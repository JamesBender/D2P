SET NOCOUNT ON;
IF OBJECT_ID('U_EMETLIFINT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMETLIFINT_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMETLIFINT' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMETLIFINT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETLIFINT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETLIFINT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFINT];
GO
IF OBJECT_ID('U_EMETLIFINT_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_PEarHist];
GO
IF OBJECT_ID('U_EMETLIFINT_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_PDedHist];
GO
IF OBJECT_ID('U_EMETLIFINT_File') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_File];
GO
IF OBJECT_ID('U_EMETLIFINT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_EEList];
GO
IF OBJECT_ID('U_EMETLIFINT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_drvTbl];
GO
IF OBJECT_ID('U_EMETLIFINT_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMETLIFINT') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETLIFINT];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMETLIFINT';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMETLIFINT';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMETLIFINT';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMETLIFINT';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMETLIFINT';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMETLIFINT','MetLife CI ACC Hospital Legal Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMETLIFINTZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionCode"','1','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"9225422"','2','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','3','(''UA''=''F'')','EMETLIFINTZ0','11','D','10','9',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EMETLIFINTZ0','11','D','10','20',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EMETLIFINTZ0','9','D','10','31',NULL,'Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''F'')','EMETLIFINTZ0','20','D','10','40',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','EMETLIFINTZ0','12','D','10','60',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','8','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','72',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberDOB"','9','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','73',NULL,'Member Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberMartial"','10','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','81',NULL,'Member Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberGender"','11','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','82',NULL,'Member Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','12','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','83',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','13','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','85',NULL,'Employee''s Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalIdentification"','14','(''UA''=''F'')','EMETLIFINTZ0','11','D','10','93',NULL,'Personnel Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"U"','15','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','104',NULL,'Employee Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"U"','16','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','105',NULL,'Spouse Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EMETLIFINTZ0','22','D','10','106',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','128',NULL,'Survivor Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EMETLIFINTZ0','9','D','10','129',NULL,'Survivor SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EMETLIFINTZ0','20','D','10','138',NULL,'Survivor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EMETLIFINTZ0','12','D','10','158',NULL,'Survivor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','22','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','170',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EMETLIFINTZ0','32','D','10','171',NULL,'Care of Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressStreet"','24','(''UA''=''F'')','EMETLIFINTZ0','32','D','10','203',NULL,'Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','25','(''UA''=''F'')','EMETLIFINTZ0','21','D','10','235',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','26','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','256',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','27','(''UA''=''F'')','EMETLIFINTZ0','9','D','10','258',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','267',NULL,'Coverage Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','269',NULL,'Coverage Start Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','277',NULL,'Coverage Stop Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','285',NULL,'Group Number - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','292',NULL,'Subcode - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','296',NULL,'Branch - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','300',NULL,'Plan Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','302',NULL,'Status Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','303',NULL,'Members Covered Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','304',NULL,'Cancel Reason - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','306',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','307',NULL,'Facility ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EMETLIFINTZ0','15','D','10','315',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','330',NULL,'Coverage Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','332',NULL,'Coverage Start Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','340',NULL,'Coverage Stop Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','348',NULL,'Group Number - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','355',NULL,'Subcode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','359',NULL,'Branch - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','363',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','365',NULL,'Status Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','366',NULL,'Members Covered Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','367',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','377',NULL,'Annual Benefit Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','385',NULL,'Salary Mode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','386',NULL,'Salary Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','393',NULL,'Coverage Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','395',NULL,'Coverage Start Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','403',NULL,'Coverage Stop Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','411',NULL,'Group Number - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','418',NULL,'Subcode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','422',NULL,'Branch - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','426',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','428',NULL,'Status Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','429',NULL,'Members Covered Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','430',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','440',NULL,'Annual Benefit Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','448',NULL,'Salary Mode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','449',NULL,'Salary Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','456',NULL,'Coverage Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','458',NULL,'Coverage Start Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','466',NULL,'Coverage Stop Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','474',NULL,'Group Number - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','481',NULL,'Subcode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','485',NULL,'Branch - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','489',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','491',NULL,'Status Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','492',NULL,'Members Covered Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','493',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','503',NULL,'Monthly Benefit Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','511',NULL,'Salary Mode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','512',NULL,'Salary Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','519',NULL,'Coverage Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','521',NULL,'Coverage Start Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','529',NULL,'Coverage Stop Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','537',NULL,'Group Number - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','544',NULL,'Subcode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','548',NULL,'Branch - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','552',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','554',NULL,'Status Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','555',NULL,'Members Covered Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','556',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','566',NULL,'Weekly Benefit Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','574',NULL,'Salary Mode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','575',NULL,'Salary Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','582',NULL,'Coverage Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','584',NULL,'Coverage Start Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','592',NULL,'Coverage Stop Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','600',NULL,'Group Number - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','607',NULL,'Subcode - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','611',NULL,'Branch - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','615',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','617',NULL,'Status Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','618',NULL,'Members Covered Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','619',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','629',NULL,'Annual Benefit Amount - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','637',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','645',NULL,'Coverage Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','647',NULL,'Coverage Start Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','655',NULL,'Coverage Stop Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','663',NULL,'Group Number - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','670',NULL,'Subcode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','674',NULL,'Branch - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','678',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','680',NULL,'Status Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','681',NULL,'Members Covered Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','682',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','692',NULL,'Annual Benefit Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','700',NULL,'Salary Mode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','701',NULL,'Salary Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','708',NULL,'Coverage Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','710',NULL,'Coverage Start Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','120','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','718',NULL,'Coverage Stop Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','726',NULL,'Group Number - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','733',NULL,'Subcode - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','737',NULL,'Branch - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','741',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','743',NULL,'Status Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','744',NULL,'Members Covered Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','745',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','755',NULL,'Annual Benefit Amount - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','763',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','771',NULL,'Coverage Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','773',NULL,'Coverage Start Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','781',NULL,'Coverage Stop Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','789',NULL,'Group Number - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','796',NULL,'Subcode - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','800',NULL,'Branch - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','804',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','806',NULL,'Status Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','807',NULL,'Members Covered Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','808',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','818',NULL,'Annual Benefit Amount - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','826',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','834',NULL,'Coverage Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','836',NULL,'Coverage Start Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','844',NULL,'Coverage Stop Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','852',NULL,'Group Number - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','859',NULL,'Subcode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','863',NULL,'Branch - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','867',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','869',NULL,'Status Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','870',NULL,'Members Covered Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','871',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','881',NULL,'Annual Benefit Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','889',NULL,'Salary Mode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','890',NULL,'Salary Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','897',NULL,'Coverage Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','899',NULL,'Coverage Start Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','907',NULL,'Coverage Stop Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','915',NULL,'Group Number - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','922',NULL,'Subcode - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','926',NULL,'Branch - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','930',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','932',NULL,'Status Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','933',NULL,'Members Covered Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','934',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','944',NULL,'Annual Benefit Amount - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','952',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','960',NULL,'Coverage Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','962',NULL,'Coverage Start Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','970',NULL,'Coverage Stop Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','978',NULL,'Group Number - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','985',NULL,'Subcode - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','989',NULL,'Branch - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','993',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','995',NULL,'Status Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','996',NULL,'Members Covered Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','997',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1007',NULL,'Annual Benefit Amount - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1015',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1023',NULL,'Coverage Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1025',NULL,'Coverage Start Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1033',NULL,'Coverage Stop Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1041',NULL,'Group Number - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1048',NULL,'Subcode - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1052',NULL,'Branch - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1056',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1058',NULL,'Status Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1059',NULL,'Members Covered Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1060',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1070',NULL,'Annual Benefit Amount - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1078',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1086',NULL,'Coverage Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1088',NULL,'Coverage Start Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1096',NULL,'Coverage Stop Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1104',NULL,'Group Number - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1111',NULL,'Subcode - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1115',NULL,'Branch - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1119',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1121',NULL,'Status Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1122',NULL,'Members Covered Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1123',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1133',NULL,'Annual Benefit Amount - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''F'')','EMETLIFINTZ0','12','D','10','1141',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1153',NULL,'Coverage Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1155',NULL,'Coverage Start Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1163',NULL,'Coverage Stop Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1171',NULL,'Group Number - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1178',NULL,'Subcode - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1182',NULL,'Branch - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1186',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1188',NULL,'Status Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1189',NULL,'Members Covered Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1190',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1200',NULL,'Annual Benefit Amount - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1208',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1216',NULL,'Coverage Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1218',NULL,'Coverage Start Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1226',NULL,'Coverage Stop Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1234',NULL,'Group Number - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1241',NULL,'Subcode - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1245',NULL,'Branch - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1249',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1251',NULL,'Status Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1252',NULL,'Members Covered Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1253',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1263',NULL,'Annual Benefit Amount - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1271',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1279',NULL,'Coverage Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1281',NULL,'Coverage Start Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','229','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1289',NULL,'Coverage Stop Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','230','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1297',NULL,'Group Number - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1304',NULL,'Subcode - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1308',NULL,'Branch - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1312',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1314',NULL,'Status Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1315',NULL,'Members Covered Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1316',NULL,'Cancel Reason - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''DA''=''F'')','EMETLIFINTZ0','23','D','10','1318',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusCode"','238','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1341',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSatusCodeEffeDate"','239','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1342',NULL,'Status Code Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','240','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1350',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0008604048"','241','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1360',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00001"','242','(''DA''=''F'')','EMETLIFINTZ0','5','D','10','1370',NULL,'Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000028212"','243','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1375',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"12"','244','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1385',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode18"','245','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1387',NULL,'Coverage Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate18"','246','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1389',NULL,'Coverage Start Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate18"','247','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1397',NULL,'Coverage Stop Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber18"','248','(''UA''=''F'')','EMETLIFINTZ0','7','D','10','1405',NULL,'Group Number - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode18"','249','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1412',NULL,'Subcode - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch18"','250','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1416',NULL,'Branch - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode18"','251','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1420',NULL,'Status Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoverCode18"','252','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1421',NULL,'Members Covered Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus18"','253','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1422',NULL,'Enrollment Status - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode19"','254','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1423',NULL,'Coverage Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate19"','255','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1425',NULL,'Coverage Start Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate19"','256','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1433',NULL,'Coverage Stop Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber19"','257','(''UA''=''F'')','EMETLIFINTZ0','7','D','10','1441',NULL,'Group Number - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode19"','258','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1448',NULL,'Subcode - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch19"','259','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1452',NULL,'Branch - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoverCode19"','260','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1456',NULL,'Members Covered Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus19"','261','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1457',NULL,'Enrollment Status - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount19"','262','(''UA''=''F'')','EMETLIFINTZ0','8','D','10','1458',NULL,'Benefit Amount - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancelInd19"','263','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1466',NULL,'Voluntary Cancellation Ind - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1468',NULL,'Taveover Indicator - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''DA''=''F'')','EMETLIFINTZ0','9','D','10','1469',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode20"','266','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1478',NULL,'Coverage Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate20"','267','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1480',NULL,'Coverage Start Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate20"','268','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1488',NULL,'Coverage Stop Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber20"','269','(''UA''=''F'')','EMETLIFINTZ0','7','D','10','1496',NULL,'Group Number - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode20"','270','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1503',NULL,'Subcode - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch20"','271','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1507',NULL,'Branch - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoverCode20"','272','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1511',NULL,'Members Covered Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus20"','273','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1512',NULL,'Enrollment Status - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount20"','274','(''UA''=''F'')','EMETLIFINTZ0','8','D','10','1513',NULL,'Benefit Amount - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1521',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1531',NULL,'Coverage Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1533',NULL,'Coverage Start Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1541',NULL,'Coverage Stop Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1549',NULL,'Group Number - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1556',NULL,'Subcode - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1560',NULL,'Branch - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1564',NULL,'Members Covered Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1565',NULL,'Enrollment Status - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''DA''=''F'')','EMETLIFINTZ0','3','D','10','1566',NULL,'GPC Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1569',NULL,'Paypoint',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','286','(''DA''=''F'')','EMETLIFINTZ0','3','D','10','1571',NULL,'Payroll Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','287','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1574',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','288','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1576',NULL,'Coverage Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','289','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1578',NULL,'Coverage Start Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','290','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1586',NULL,'Coverage Stop Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','291','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1594',NULL,'Group Number - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1601',NULL,'Subcode - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','293','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1605',NULL,'Branch - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','294','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1609',NULL,'Members Covered Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','295','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1610',NULL,'Enrollment Status - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','296','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1611',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode23"','297','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1613',NULL,'Coverage Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate23"','298','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1615',NULL,'Coverage Start Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate23"','299','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1623',NULL,'Coverage Stop Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber23"','300','(''UA''=''F'')','EMETLIFINTZ0','7','D','10','1631',NULL,'Group Number - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode23"','301','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1638',NULL,'Subcode - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch23"','302','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1642',NULL,'Branch - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoverCode23"','303','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1646',NULL,'Members Covered Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvenrollmentStatus23"','304','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1647',NULL,'Enrollment Status - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancelInd23"','305','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1648',NULL,'Voluntary Cancellation Ind - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','306','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1650',NULL,'Takeover Indicator - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','307','(''DA''=''F'')','EMETLIFINTZ0','9','D','10','1651',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode24"','308','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1660',NULL,'Coverage Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate24"','309','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1662',NULL,'Coverage Start Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate24"','310','(''UDMDY''=''F'')','EMETLIFINTZ0','8','D','10','1670',NULL,'Coverage Stop Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber24"','311','(''UA''=''F'')','EMETLIFINTZ0','7','D','10','1678',NULL,'Group Number - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode24"','312','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1685',NULL,'Subcode - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch24"','313','(''UA''=''F'')','EMETLIFINTZ0','4','D','10','1689',NULL,'Branch - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoverCode24"','314','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1693',NULL,'Members Covered Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus24"','315','(''UA''=''F'')','EMETLIFINTZ0','1','D','10','1694',NULL,'Enrollment Status - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancelInd24"','316','(''UA''=''F'')','EMETLIFINTZ0','2','D','10','1695',NULL,'Voluntary Cancellation Ind - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','317','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1697',NULL,'Takeover Indicator - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','318','(''DA''=''F'')','EMETLIFINTZ0','9','D','10','1698',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','319','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1707',NULL,'Coverage Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','320','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1709',NULL,'Coverage Start Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1717',NULL,'Coverage Stop Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1725',NULL,'Group Number - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','323','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1732',NULL,'Subcode - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','324','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1736',NULL,'Branch - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','325','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1740',NULL,'Members Covered Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','326','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1741',NULL,'Enrollment Status - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','327','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1742',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','328','(''DA''=''F'')','EMETLIFINTZ0','95','D','10','1752',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','329','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1847',NULL,'Coverage Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','330','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1849',NULL,'Coverage Start Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1857',NULL,'Coverage Stop Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1865',NULL,'Group Number - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','333','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1872',NULL,'Subcode - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','334','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1876',NULL,'Branch - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','335','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1880',NULL,'Status Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','336','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1881',NULL,'Members Covered Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','337','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1882',NULL,'Benefit Amount - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','338','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1890',NULL,'Takeover Indicator - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','339','(''DA''=''F'')','EMETLIFINTZ0','10','D','10','1891',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','340','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1901',NULL,'Coverage Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1903',NULL,'Coverage Start Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1911',NULL,'Coverage Stop Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','343','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1919',NULL,'Group Number - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','344','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1926',NULL,'Subcode - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','345','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1930',NULL,'Branch - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','346','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1934',NULL,'Members Covered Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','347','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1935',NULL,'Enrollment Status - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','348','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1936',NULL,'Benefit Amount - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','349','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1944',NULL,'Voluntary Cancellation Ind - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','350','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1946',NULL,'Takeover Indicator - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''DA''=''F'')','EMETLIFINTZ0','9','D','10','1947',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1956',NULL,'Coverage Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','353','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1958',NULL,'Coverage Start Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','354','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1966',NULL,'Coverage Stop Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','355','(''DA''=''F'')','EMETLIFINTZ0','7','D','10','1974',NULL,'Group Number - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','356','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1981',NULL,'Subcode - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','357','(''DA''=''F'')','EMETLIFINTZ0','4','D','10','1985',NULL,'Branch - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','358','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1989',NULL,'Members Covered Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','359','(''DA''=''F'')','EMETLIFINTZ0','1','D','10','1990',NULL,'Enrollment Status - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','360','(''DA''=''F'')','EMETLIFINTZ0','8','D','10','1991',NULL,'Benefit Amount - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''DA''=''F'')','EMETLIFINTZ0','2','D','10','1999',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFINT_20200629.txt',NULL,'','','',NULL,NULL,NULL,'MetLife CI ACC Hosp Legal Ex','202003059','EMPEXPORT','ONDEMAND','Mar  6 2020 11:33AM','EMETLIFINT',NULL,NULL,NULL,'202003059','Mar  5 2020 11:35AM','Mar  5 2020 11:35AM','202003051','492','','','202003051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFINT_20200629.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202003059','EMPEXPORT','SCHEDULED','Mar  6 2020 11:35AM','EMETLIFINT',NULL,NULL,NULL,'202003059','Mar  5 2020 11:35AM','Mar  5 2020 11:35AM','202003051','492','','','202003051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFINT_20200629.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202003059','EMPEXPORT','OEACTIVE','Mar  6 2020 11:31AM','EMETLIFINT',NULL,NULL,NULL,'202003059','Mar  5 2020 11:35AM','Mar  5 2020 11:35AM','202003051','2','','','202003051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFINT_20200629.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202003059','EMPEXPORT','OEPASSIVE','Mar  6 2020 11:32AM','EMETLIFINT',NULL,NULL,NULL,'202003059','Mar  5 2020 11:35AM','Mar  5 2020 11:35AM','202003051','492','','','202003051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFINT_20200629.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006119','EMPEXPORT','TEST','Jun 11 2020  4:46PM','EMETLIFINT',NULL,NULL,NULL,'202006119','Jun 11 2020 12:00AM','Dec 30 1899 12:00AM','202005281','379','','','202005281',dbo.fn_GetTimedKey(),NULL,'us3lKiREP1011',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMETLIFINT_20200629.txt' END WHERE expFormatCode = 'EMETLIFINT';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFINT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFINT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFINT','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFINT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFINT','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMETLIFINT' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMETLIFINT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMETLIFINT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFINT_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFINT','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFINT','D10','dbo.U_EMETLIFINT_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMETLIFINT') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETLIFINT] (
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
IF OBJECT_ID('U_EMETLIFINT_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFINT_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMETLIFINT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETLIFINT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(13) NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(13) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvMemberDOB] datetime NULL,
    [drvMemberMartial] varchar(1) NULL,
    [drvMemberGender] char(1) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvPersonalIdentification] char(9) NULL,
    [drvAddressStreet] varchar(6000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvEmployeeStatusCode] varchar(1) NOT NULL,
    [drvSatusCodeEffeDate] datetime NULL,
    [drvCoverageCode18] varchar(2) NULL,
    [drvCoverageStartDate18] datetime NULL,
    [drvCoverageStopDate18] datetime NULL,
    [drvGroupNumber18] varchar(7) NULL,
    [drvSubCode18] varchar(4) NULL,
    [drvBranch18] varchar(4) NULL,
    [drvStatusCode18] varchar(1) NULL,
    [drvMembersCoverCode18] varchar(1) NULL,
    [drvEnrollmentStatus18] varchar(1) NULL,
    [drvCoverageCode19] varchar(2) NULL,
    [drvCoverageStartDate19] datetime NULL,
    [drvCoverageStopDate19] datetime NULL,
    [drvGroupNumber19] varchar(7) NULL,
    [drvSubCode19] varchar(4) NULL,
    [drvBranch19] varchar(4) NULL,
    [drvMembersCoverCode19] varchar(1) NULL,
    [drvEnrollmentStatus19] varchar(1) NULL,
    [drvBenefitAmount19] varchar(8) NULL,
    [drvVoluntaryCancelInd19] varchar(2) NULL,
    [drvCoverageCode20] varchar(2) NULL,
    [drvCoverageStartDate20] datetime NULL,
    [drvCoverageStopDate20] datetime NULL,
    [drvGroupNumber20] varchar(7) NULL,
    [drvSubCode20] varchar(4) NULL,
    [drvBranch20] varchar(4) NULL,
    [drvMembersCoverCode20] varchar(1) NULL,
    [drvEnrollmentStatus20] varchar(1) NULL,
    [drvBenefitAmount20] varchar(8) NULL,
    [drvCoverageCode23] varchar(2) NULL,
    [drvCoverageStartDate23] datetime NULL,
    [drvCoverageStopDate23] datetime NULL,
    [drvGroupNumber23] varchar(7) NULL,
    [drvSubCode23] varchar(4) NULL,
    [drvBranch23] varchar(4) NULL,
    [drvMembersCoverCode23] varchar(1) NULL,
    [drvenrollmentStatus23] varchar(1) NULL,
    [drvVoluntaryCancelInd23] varchar(2) NULL,
    [drvCoverageCode24] varchar(2) NULL,
    [drvCoverageStartDate24] datetime NULL,
    [drvCoverageStopDate24] datetime NULL,
    [drvGroupNumber24] varchar(7) NULL,
    [drvSubCode24] varchar(4) NULL,
    [drvBranch24] varchar(4) NULL,
    [drvMembersCoverCode24] varchar(1) NULL,
    [drvEnrollmentStatus24] varchar(1) NULL,
    [drvVoluntaryCancelInd24] varchar(2) NULL
);
IF OBJECT_ID('U_EMETLIFINT_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFINT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMETLIFINT_File') IS NULL
CREATE TABLE [dbo].[U_EMETLIFINT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
IF OBJECT_ID('U_EMETLIFINT_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMETLIFINT_PDedHist] (
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
IF OBJECT_ID('U_EMETLIFINT_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMETLIFINT_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFINT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Repairify

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/05/2020
Service Request Number: TekP-2019-11-11-0003

Purpose: MetLife CI ACC Hospital Legal Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETLIFINT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETLIFINT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETLIFINT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETLIFINT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETLIFINT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFINT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFINT', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFINT', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETLIFINT';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMETLIFINT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMETLIFINT';

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
    DELETE FROM dbo.U_EMETLIFINT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETLIFINT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCH,CRIC1,CRIC3,CRIE1,CRIE3,CRIF1,CRIF3,CRIS1,CRIS3,HOSP2,LEGAL,ACCDA';
    --SET @DedList = 'ACCDA';

    IF OBJECT_ID('U_EMETLIFINT_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFINT_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETLIFINT_DedList
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
    IF OBJECT_ID('U_EMETLIFINT_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFINT_PDedHist;
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
    INTO dbo.U_EMETLIFINT_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMETLIFINT_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMETLIFINT_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFINT_PEarHist;
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
    INTO dbo.U_EMETLIFINT_PEarHist
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
    -- DETAIL RECORD - U_EMETLIFINT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETLIFINT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFINT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + ' ' + CASE WHEN BdmRecType = 'EMP' THEN '1' ELSE '2' END -- xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvTransactionCode = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        ,drvEmployeeNumber = '00' + EepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddleInit = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvMemberDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMemberMartial =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN ISNULL(EepMaritalStatus, '') NOT IN ('Z', '') THEN EepMaritalStatus ELSE 'U' END
                            END
        ,drvMemberGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvRelationshipCode =    CASE WHEN BdmRecType = 'EMP' THEN '00'
                                    ELSE
                                        CASE WHEN ConRelationShip IN ('DP', 'SPS') THEN '01'
                                            WHEN ConRelationShip IN ('CHL', 'STC', 'DPC', 'DCH') THEN '02'
                                        END
                                END                                                                            
        ,drvDateOfLastHire = CASE WHEN BdmRecType = 'EMP' THEN EecDateOfLastHire END
        ,drvPersonalIdentification = EecEmpNo
        ,drvAddressStreet = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1 + ' ' + ISNULL(EepAddressLine2, '')) 
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvEmployeeStatusCode =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('203', '202') THEN 'T'
                                        ELSE 'A'
                                    END
        ,drvSatusCodeEffeDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvCoverageCode18 = CASE WHEN LEGAL_Code IS NOT NULL THEN 'LE' END
        ,drvCoverageStartDate18 = CASE WHEN LEGAL_Code IS NOT NULL THEN LEGAL_BdmBenStartDate END
        ,drvCoverageStopDate18 = CASE WHEN LEGAL_Code IS NOT NULL THEN LEGAL_BdmBenStopDate END
        ,drvGroupNumber18 = CASE WHEN LEGAL_Code IS NOT NULL THEN '9225422' END
        ,drvSubCode18 = CASE WHEN LEGAL_Code IS NOT NULL THEN '0002' END
        ,drvBranch18 = CASE WHEN LEGAL_Code IS NOT NULL THEN '0001' END
        ,drvStatusCode18 = CASE WHEN LEGAL_Code IS NOT NULL THEN 'A' END
        ,drvMembersCoverCode18 = CASE WHEN LEGAL_Code IS NOT NULL THEN '1' END
        ,drvEnrollmentStatus18 = CASE WHEN LEGAL_Code IS NOT NULL THEN 'P' END
        ,drvCoverageCode19 =    CASE WHEN BdmRecType = 'EMP' THEN  -- JCB
                                    CASE WHEN CRIE1_Code IS NOT NULL OR CRIE3_Code IS NOT NULL 
                                            OR CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                            OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN 'GE'
                                    END
                                END
        ,drvCoverageStartDate19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN CRIE1_Code IS NOT NULL THEN CRIE1_BdmBenStartDate
                                            WHEN CRIE3_Code IS NOT NULL THEN CRIE3_BdmBenStartDate
                                            WHEN CRIC1_Code IS NOT NULL THEN CRIC1_BdmBenStartDate
                                            WHEN CRIC3_Code IS NOT NULL THEN CRIC3_BdmBenStartDate
                                            WHEN CRIF1_Code IS NOT NULL THEN CRIF1_BdmBenStartDate
                                            WHEN CRIF3_Code IS NOT NULL THEN CRIF3_BdmBenStartDate
                                            WHEN CRIS1_Code IS NOT NULL THEN CRIS1_BdmBenStartDate
                                            WHEN CRIS3_Code IS NOT NULL THEN CRIS3_BdmBenStartDate
                                        END
                                    END
        ,drvCoverageStopDate19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN CRIE1_Code IS NOT NULL THEN CRIE1_BdmBenStopDate
                                            WHEN CRIE3_Code IS NOT NULL THEN CRIE3_BdmBenStopDate
                                            WHEN CRIC1_Code IS NOT NULL THEN CRIC1_BdmBenStopDate
                                            WHEN CRIC3_Code IS NOT NULL THEN CRIC3_BdmBenStopDate
                                            WHEN CRIF1_Code IS NOT NULL THEN CRIF1_BdmBenStopDate
                                            WHEN CRIF3_Code IS NOT NULL THEN CRIF3_BdmBenStopDate
                                            WHEN CRIS1_Code IS NOT NULL THEN CRIS1_BdmBenStopDate
                                            WHEN CRIS3_Code IS NOT NULL THEN CRIS3_BdmBenStopDate
                                        END
                                    END
        ,drvGroupNumber19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN CRIE1_Code IS NOT NULL OR CRIE3_Code IS NOT NULL 
                                    OR CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                    OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                    OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '0225425'
                                END
                            END
        ,drvSubCode19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                            CASE WHEN CRIE1_Code IS NOT NULL OR CRIE3_Code IS NOT NULL 
                                OR CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '0001'
                            END
                        END
        ,drvBranch19 = CASE WHEN BdmRecType = 'EMP' THEN 
                            CASE WHEN CRIE1_Code IS NOT NULL OR CRIE3_Code IS NOT NULL 
                                OR CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '0001'
                            END
                        END
        ,drvMembersCoverCode19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN CRIE1_Code IS NOT NULL OR CRIE3_Code IS NOT NULL 
                                            OR CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                            OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '1'
                                        END
                                    END
        ,drvEnrollmentStatus19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN CRIE1_Code IS NOT NULL OR CRIE3_Code IS NOT NULL 
                                            OR CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                            OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN 'P'
                                        END
                                    END
        ,drvBenefitAmount19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN CRIE1_Code IS NOT NULL OR CRIC1_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIS1_Code IS NOT NULL THEN '00015000'
                                        WHEN CRIE3_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF3_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '00030000'
                                    END
                                END
        ,drvVoluntaryCancelInd19 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN EecEmplStatus = 'A' 
                                            AND (
                                                    (CRIE1_Code IS NOT NULL AND CRIE1_BdmBenStatus <> 'A')
                                                    OR (CRIE3_Code IS NOT NULL AND CRIE3_BdmBenStatus <> 'A')
                                                    OR (CRIC1_Code IS NOT NULL AND CRIC1_BdmBenStatus <> 'A')
                                                    OR (CRIC3_Code IS NOT NULL AND CRIC3_BdmBenStatus <> 'A') 
                                                    OR (CRIF1_Code IS NOT NULL AND CRIF1_BdmBenStatus <> 'A') 
                                                    OR (CRIF3_Code IS NOT NULL AND CRIF3_BdmBenStatus <> 'A') 
                                                    OR (CRIS1_Code IS NOT NULL AND CRIS1_BdmBenStatus <> 'A') 
                                                    OR (CRIS3_Code IS NOT NULL AND CRIS3_BdmBenStatus <> 'A')
                                                )
                                             THEN 'CE'
                                        END
                                    END
        ,drvCoverageCode20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                                    CASE WHEN CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                            OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN 'GD'
                                    END
                                --END
        ,drvCoverageStartDate20 =    --CASE WHEN BdmRecType = 'DEP' THEN -- JCB
                                        CASE WHEN CRIC1_Code IS NOT NULL THEN CRIC1_BdmBenStartDate
                                            WHEN CRIC3_Code IS NOT NULL THEN CRIC3_BdmBenStartDate
                                            WHEN CRIF1_Code IS NOT NULL THEN CRIF1_BdmBenStartDate
                                            WHEN CRIF3_Code IS NOT NULL THEN CRIF3_BdmBenStartDate
                                            WHEN CRIS1_Code IS NOT NULL THEN CRIS1_BdmBenStartDate
                                            WHEN CRIS3_Code IS NOT NULL THEN CRIS3_BdmBenStartDate
                                        END
                                    --END
        ,drvCoverageStopDate20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN CRIC1_Code IS NOT NULL THEN CRIC1_BdmBenStopDate
                                            WHEN CRIC3_Code IS NOT NULL THEN CRIC3_BdmBenStopDate
                                            WHEN CRIF1_Code IS NOT NULL THEN CRIF1_BdmBenStopDate
                                            WHEN CRIF3_Code IS NOT NULL THEN CRIF3_BdmBenStopDate
                                            WHEN CRIS1_Code IS NOT NULL THEN CRIS1_BdmBenStopDate
                                            WHEN CRIS3_Code IS NOT NULL THEN CRIS3_BdmBenStopDate
                                        END
                                    --END
        ,drvGroupNumber20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                                CASE WHEN CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                    OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                    OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '0225425'
                                END
                            --END
        ,drvSubCode20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                            CASE WHEN CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '0001'
                            END
                        --D
        ,drvBranch20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                            CASE WHEN CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '0001'
                            END
                        --END
        ,drvMembersCoverCode20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                            OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '4'
                                        END
                                    --END
        ,drvEnrollmentStatus20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN CRIC1_Code IS NOT NULL OR CRIC3_Code IS NOT NULL 
                                            OR CRIF1_Code IS NOT NULL OR CRIF3_Code IS NOT NULL 
                                            OR CRIS1_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN 'P'
                                        END
                                    --END
        ,drvBenefitAmount20 =    --CASE WHEN BdmRecType = 'DEP' THEN 
                                    CASE WHEN CRIC1_Code IS NOT NULL OR CRIF1_Code IS NOT NULL OR CRIS1_Code IS NOT NULL THEN '00007500'
                                        WHEN CRIC3_Code IS NOT NULL OR CRIF3_Code IS NOT NULL OR CRIS3_Code IS NOT NULL THEN '00015000'
                                    END
                                --END
        ,drvCoverageCode23 = CASE WHEN ACCH_Code IS NOT NULL OR ACCDA_Code IS NOT NULL THEN 'AH' END
        ,drvCoverageStartDate23 =    CASE WHEN ACCH_Code IS NOT NULL THEN ACCH_BdmBenStartDate 
                                        WHEN ACCDA_Code IS NOT NULL THEN ACCDA_BdmBenStartDate 
                                    END
        ,drvCoverageStopDate23 =    CASE WHEN ACCH_Code IS NOT NULL THEN ACCH_BdmBenStopDate 
                                        WHEN ACCDA_Code IS NOT NULL THEN ACCDA_BdmBenStopDate 
                                    END
        ,drvGroupNumber23 = CASE WHEN ACCH_Code IS NOT NULL OR ACCDA_Code IS NOT NULL THEN '0225423' END
        ,drvSubCode23 = CASE WHEN ACCH_Code IS NOT NULL OR ACCDA_Code IS NOT NULL THEN '0001' END
        ,drvBranch23 = CASE WHEN ACCH_Code IS NOT NULL OR ACCDA_Code IS NOT NULL THEN '0001' END
        ,drvMembersCoverCode23 =    CASE WHEN ACCH_Code IS NOT NULL THEN 
                                            CASE WHEN ACCH_BdmBenOption = 'EE' THEN '1'
                                                WHEN ACCH_BdmBenOption = 'EEF' THEN '4'
                                                WHEN ACCH_BdmBenOption = 'EEC' THEN '2'
                                                WHEN ACCH_BdmBenOption = 'EES' THEN '3'
                                                ELSE '1'
                                            END
                                        WHEN ACCDA_Code IS NOT NULL THEN 
                                            CASE WHEN ACCDA_BdmBenOption = 'EE' THEN '1'
                                                WHEN ACCDA_BdmBenOption = 'EEF' THEN '4'
                                                WHEN ACCDA_BdmBenOption = 'EEC' THEN '2'
                                                WHEN ACCDA_BdmBenOption = 'EES' THEN '3'
                                                ELSE '1'
                                            END
                                    END
        ,drvenrollmentStatus23 = CASE WHEN ACCH_Code IS NOT NULL OR ACCDA_Code IS NOT NULL THEN 'P' END
        ,drvVoluntaryCancelInd23 =    CASE WHEN EecEmplStatus = 'A' AND CRIE1_Code IS NOT NULL AND CRIE1_BdmBenStatus <> 'A' THEN 'CE' END
        ,drvCoverageCode24 = CASE WHEN HOSP2_Code IS NOT NULL THEN 'HH' END
        ,drvCoverageStartDate24 = CASE WHEN HOSP2_Code IS NOT NULL THEN HOSP2_BdmBenStartDate END
        ,drvCoverageStopDate24 = CASE WHEN HOSP2_Code IS NOT NULL THEN HOSP2_BdmBenStopDate END
        ,drvGroupNumber24 = CASE WHEN HOSP2_Code IS NOT NULL THEN '0225424' END
        ,drvSubCode24 = CASE WHEN HOSP2_Code IS NOT NULL THEN '0001' END
        ,drvBranch24 = CASE WHEN HOSP2_Code IS NOT NULL THEN '0001' END
        ,drvMembersCoverCode24 =    CASE WHEN HOSP2_Code IS NOT NULL THEN
                                        CASE WHEN HOSP2_BdmBenOption = 'EE' THEN '1'
                                            WHEN HOSP2_BdmBenOption = 'EEF' THEN '4'
                                            WHEN HOSP2_BdmBenOption = 'EEC' THEN '2'
                                            WHEN HOSP2_BdmBenOption = 'EES' THEN '3'
                                        END
                                    END
        ,drvEnrollmentStatus24 = CASE WHEN HOSP2_Code IS NOT NULL THEN 'P' END
        ,drvVoluntaryCancelInd24 = CASE WHEN EecEmplStatus = 'A' AND HOSP2_Code IS NOT NULL AND HOSP2_BdmBenStatus <> 'A' THEN 'CE' END
    INTO dbo.U_EMETLIFINT_drvTbl
    FROM dbo.U_EMETLIFINT_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId 
            ,MAX(CASE WHEN BdmDedCode = 'ACCH' THEN BdmDedCode END) AS ACCH_Code
            ,MAX(CASE WHEN BdmDedCode = 'ACCDA' THEN BdmDedCode END) AS ACCDA_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIC1' THEN BdmDedCode END) AS CRIC1_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIC3' THEN BdmDedCode END) AS CRIC3_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIE1' THEN BdmDedCode END) AS CRIE1_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIE3' THEN BdmDedCode END) AS CRIE3_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIF1' THEN BdmDedCode END) AS CRIF1_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIF3' THEN BdmDedCode END) AS CRIF3_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIS1' THEN BdmDedCode END) AS CRIS1_Code
            ,MAX(CASE WHEN BdmDedCode = 'CRIS3' THEN BdmDedCode END) AS CRIS3_Code
            ,MAX(CASE WHEN BdmDedCode = 'HOSP2' THEN BdmDedCode END) AS HOSP2_Code
            ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmDedCode END) AS LEGAL_Code
            ,MAX(CASE WHEN BdmDedCode = 'ACCH' THEN BdmBenStartDate END) AS ACCH_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'ACCDA' THEN BdmBenStartDate END) AS ACCDA_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIC1' THEN BdmBenStartDate END) AS CRIC1_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIC3' THEN BdmBenStartDate END) AS CRIC3_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIE1' THEN BdmBenStartDate END) AS CRIE1_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIE3' THEN BdmBenStartDate END) AS CRIE3_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIF1' THEN BdmBenStartDate END) AS CRIF1_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIF3' THEN BdmBenStartDate END) AS CRIF3_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIS1' THEN BdmBenStartDate END) AS CRIS1_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIS3' THEN BdmBenStartDate END) AS CRIS3_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'HOSP2' THEN BdmBenStartDate END) AS HOSP2_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmBenStartDate END) AS LEGAL_BdmBenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'ACCH' THEN BdmBenStopDate END) AS ACCH_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'ACCDA' THEN BdmBenStopDate END) AS ACCDA_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIC1' THEN BdmBenStopDate END) AS CRIC1_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIC3' THEN BdmBenStopDate END) AS CRIC3_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIE1' THEN BdmBenStopDate END) AS CRIE1_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIE3' THEN BdmBenStopDate END) AS CRIE3_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIF1' THEN BdmBenStopDate END) AS CRIF1_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIF3' THEN BdmBenStopDate END) AS CRIF3_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIS1' THEN BdmBenStopDate END) AS CRIS1_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'CRIS3' THEN BdmBenStopDate END) AS CRIS3_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'HOSP2' THEN BdmBenStopDate END) AS HOSP2_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmBenStopDate END) AS LEGAL_BdmBenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'ACCH' THEN BdmBenStatus END) AS ACCH_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'ACCDA' THEN BdmBenStatus END) AS ACCDA_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIC1' THEN BdmBenStatus END) AS CRIC1_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIC3' THEN BdmBenStatus END) AS CRIC3_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIE1' THEN BdmBenStatus END) AS CRIE1_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIE3' THEN BdmBenStatus END) AS CRIE3_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIF1' THEN BdmBenStatus END) AS CRIF1_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIF3' THEN BdmBenStatus END) AS CRIF3_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIS1' THEN BdmBenStatus END) AS CRIS1_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'CRIS3' THEN BdmBenStatus END) AS CRIS3_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'HOSP2' THEN BdmBenStatus END) AS HOSP2_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmBenStatus END) AS LEGAL_BdmBenStatus
            ,MAX(CASE WHEN BdmDedCode = 'ACCH' THEN BdmBenOption END) AS ACCH_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'ACCDA' THEN BdmBenOption END) AS ACCDA_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIC1' THEN BdmBenOption END) AS CRIC1_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIC3' THEN BdmBenOption END) AS CRIC3_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIE1' THEN BdmBenOption END) AS CRIE1_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIE3' THEN BdmBenOption END) AS CRIE3_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIF1' THEN BdmBenOption END) AS CRIF1_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIF3' THEN BdmBenOption END) AS CRIF3_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIS1' THEN BdmBenOption END) AS CRIS1_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'CRIS3' THEN BdmBenOption END) AS CRIS3_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'HOSP2' THEN BdmBenOption END) AS HOSP2_BdmBenOption
            ,MAX(CASE WHEN BdmDedCode = 'LEGAL' THEN BdmBenOption END) AS LEGAL_BdmBenOption
            FROM dbo.U_dsi_BDM_EMETLIFINT WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecId
        ) AS Bdm_Flattened
        ON BdmEEID = xEEID 
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
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
ALTER VIEW dbo.dsi_vwEMETLIFINT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLIFINT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETLIFINT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202002271'
       ,expStartPerControl     = '202002271'
       ,expLastEndPerControl   = '202003059'
       ,expEndPerControl       = '202003059'
WHERE expFormatCode = 'EMETLIFINT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETLIFINT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLIFINT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;