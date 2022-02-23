SET NOCOUNT ON;
IF OBJECT_ID('U_EANTFMLSAF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EANTFMLSAF_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EANTFMLSAF' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEANTFMLSAF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEANTFMLSAF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EANTFMLSAF_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTFMLSAF_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EANTFMLSAF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTFMLSAF];
GO
IF OBJECT_ID('U_EANTFMLSAF_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_Trailer];
GO
IF OBJECT_ID('U_EANTFMLSAF_HeaderW') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_HeaderW];
GO
IF OBJECT_ID('U_EANTFMLSAF_Header') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_Header];
GO
IF OBJECT_ID('U_EANTFMLSAF_File') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_File];
GO
IF OBJECT_ID('U_EANTFMLSAF_EEList') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_EEList];
GO
IF OBJECT_ID('U_EANTFMLSAF_drvTbl_UDDT') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_drvTbl_UDDT];
GO
IF OBJECT_ID('U_EANTFMLSAF_drvTbl_LOB') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_drvTbl_LOB];
GO
IF OBJECT_ID('U_EANTFMLSAF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_drvTbl];
GO
IF OBJECT_ID('U_EANTFMLSAF_DedList') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_DedList];
GO
IF OBJECT_ID('U_dsi_EANTFMLSAF_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EANTFMLSAF_EarnHist];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EANTFMLSAF';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EANTFMLSAF';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EANTFMLSAF';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EANTFMLSAF';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EANTFMLSAF';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EANTFMLSAF','Anthem Life Compass','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1500','S','N','EANTFMLSAFZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWHeader"','1','(''UA''=''F'')','EANTFMLSAFZ0','44','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EANTFMLSAFZ0','3','H','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo"','2','(''UA''=''F'')','EANTFMLSAFZ0','10','H','02','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupName"','3','(''UA''=''F'')','EANTFMLSAFZ0','50','H','02','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate"','4','(''UD112''=''F'')','EANTFMLSAFZ0','8','H','02','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTime"','5','(''UA''=''F'')','EANTFMLSAFZ0','6','H','02','72',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullDelta"','6','(''UA''=''F'')','EANTFMLSAFZ0','1','H','02','78',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvfiller"','7','(''SS''=''F'')','EANTFMLSAFZ0','1422','H','02','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EANTFMLSAFZ0','3','D','10','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','2','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','3','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','54',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','104',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaidenName"','5','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','154',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','6','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','204',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','7','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','212',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''F'')','EANTFMLSAFZ0','20','D','10','220',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EANTFMLSAFZ0','1','D','10','240',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','10','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','241',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo"','11','(''UA''=''F'')','EANTFMLSAFZ0','10','D','10','249',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupEffDate"','12','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','259',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','13','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','267',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupEffDate"','14','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','275',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassEffDate"','15','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','283',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillClassEffDate"','16','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','291',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERName"','17','(''UA''=''F'')','EANTFMLSAFZ0','120','D','10','299',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupNo"','18','(''UA''=''F'')','EANTFMLSAFZ0','10','D','10','419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupName"','19','(''UA''=''F'')','EANTFMLSAFZ0','100','D','10','429',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassNo"','20','(''UA''=''F'')','EANTFMLSAFZ0','5','D','10','529',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassDesc"','21','(''UA''=''F'')','EANTFMLSAFZ0','80','D','10','534',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','22','(''UA''=''F'')','EANTFMLSAFZ0','10','D','10','614',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryFreq"','23','(''UA''=''F'')','EANTFMLSAFZ0','1','D','10','624',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorks"','24','(''UA''=''F'')','EANTFMLSAFZ0','3','D','10','625',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityStatus"','25','(''UA''=''F'')','EANTFMLSAFZ0','3','D','10','628',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','26','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','10','631',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJoinGroupDate"','27','(''UD112''=''F'')','EANTFMLSAFZ0','10','D','10','639',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','28','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','649',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','29','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','699',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','30','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','749',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','31','(''UA''=''F'')','EANTFMLSAFZ0','50','D','10','799',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','32','(''UA''=''F'')','EANTFMLSAFZ0','2','D','10','849',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','33','(''UA''=''F'')','EANTFMLSAFZ0','12','D','10','851',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','34','(''UA''=''F'')','EANTFMLSAFZ0','15','D','10','863',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFaxNumber"','35','(''UA''=''F'')','EANTFMLSAFZ0','15','D','10','878',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','36','(''UA''=''F'')','EANTFMLSAFZ0','40','D','10','893',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmoker"','37','(''UA''=''F'')','EANTFMLSAFZ0','1','D','10','933',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','38','(''UA''=''F'')','EANTFMLSAFZ0','1','D','10','934',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillClass"','39','(''UA''=''F'')','EANTFMLSAFZ0','10','D','10','935',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','40','(''SS''=''F'')','EANTFMLSAFZ0','556','D','10','945',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EANTFMLSAFZ0','3','D','11','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOB"','2','(''UA''=''F'')','EANTFMLSAFZ0','20','D','11','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenStatus"','3','(''UA''=''F'')','EANTFMLSAFZ0','3','D','11','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','4','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','11','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','5','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','11','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovAmt"','6','(''UA''=''F'')','EANTFMLSAFZ0','15','D','11','43',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSelectOpt"','7','(''UA''=''F'')','EANTFMLSAFZ0','2','D','11','58',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','8','(''SS''=''F'')','EANTFMLSAFZ0','1441','D','11','60',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EANTFMLSAFZ0','3','D','12','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvType"','2','(''UA''=''F'')','EANTFMLSAFZ0','30','D','12','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvValue"','3','(''UA''=''F'')','EANTFMLSAFZ0','300','D','12','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOB"','4','(''UA''=''F'')','EANTFMLSAFZ0','20','D','12','334',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','5','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','12','354',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','6','(''SS''=''F'')','EANTFMLSAFZ0','1139','D','12','362',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EANTFMLSAFZ0','3','D','13','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConDateofBirth"','2','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','13','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConFirstName"','3','(''UA''=''F'')','EANTFMLSAFZ0','50','D','13','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConMiddleName"','4','(''UA''=''F'')','EANTFMLSAFZ0','50','D','13','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConLastName"','5','(''UA''=''F'')','EANTFMLSAFZ0','50','D','13','112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConMaidenName"','6','(''UA''=''F'')','EANTFMLSAFZ0','50','D','13','162',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConGender"','7','(''UA''=''F'')','EANTFMLSAFZ0','1','D','13','212',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConRelation"','8','(''UA''=''F'')','EANTFMLSAFZ0','2','D','13','213',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConEligDate"','9','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','13','215',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConTermDate"','10','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','13','223',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConSSN"','11','(''UA''=''F'')','EANTFMLSAFZ0','20','D','13','231',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConSmoker"','12','(''UA''=''F'')','EANTFMLSAFZ0','1','D','13','251',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConClassNum"','13','(''UA''=''F'')','EANTFMLSAFZ0','5','D','13','252',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConLOB"','14','(''UA''=''F'')','EANTFMLSAFZ0','20','D','13','257',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConEffDate"','15','(''UD112''=''F'')','EANTFMLSAFZ0','8','D','13','277',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConCovAmt"','16','(''UA''=''F'')','EANTFMLSAFZ0','15','D','13','285',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConBenSelectOpt"','17','(''UA''=''F'')','EANTFMLSAFZ0','2','D','13','300',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvfiller"','18','(''SS''=''F'')','EANTFMLSAFZ0','1199','D','13','302',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EANTFMLSAFZ0','3','T','90','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalRecords"','2','(''UA''=''F'')','EANTFMLSAFZ0','10','T','90','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','3','(''SS''=''F'')','EANTFMLSAFZ0','1487','T','90','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW13\Downloads\V10\Exports\SAFEB\EmployeeHistoryExport\OEACT_EANTFMLSAF_YYYYMMDD.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201706279','EMPEXPORT','OEACTIVE','May 21 2019 12:00AM','EANTFMLSAF',NULL,NULL,NULL,'201706279','Jun 27 2017 12:00AM','Dec 30 1899 12:00AM','201706271',NULL,'','','201706271',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW13\Downloads\V10\Exports\SAFEB\EmployeeHistoryExport\OEPAS_EANTFMLSAF_YYYYMMDD.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201706279','EMPEXPORT','OEPASSIVE','May 17 2019 12:00AM','EANTFMLSAF',NULL,NULL,NULL,'201706279','Jun 27 2017 12:00AM','Dec 30 1899 12:00AM','201706271',NULL,'','','201706271',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW13\Downloads\V10\Exports\SAFEB\EmployeeHistoryExport\EANTFMLSAF_20171026a.txt',NULL,'','','CWMD1',NULL,NULL,NULL,'Anthem Life Compass','201907231','EMPEXPORT','ONDEMAND','Jul 23 2019 12:00AM','EANTFMLSAF',NULL,NULL,NULL,'202012289','Jul 23 2019 12:00AM','Dec 30 1899 12:00AM','202012011','10944','','','201907171',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW13\Downloads\V10\Exports\SAFEB\EmployeeHistoryExport\TEST_EANTFMLSAF_20201203.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202012031','EMPEXPORT','TEST','Dec  3 2020 12:51PM','EANTFMLSAF',NULL,NULL,NULL,'202012031','Dec  3 2020 12:00AM','Dec 30 1899 12:00AM','202012031','10805','','','202012031',dbo.fn_GetTimedKey(),NULL,'us3cPeSAF1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','SubSort','C','drvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSAF','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EANTFMLSAF_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EANTFMLSAF_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSAF_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','H01','dbo.U_EANTFMLSAF_HeaderW',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','H02','dbo.U_EANTFMLSAF_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','D10','dbo.U_EANTFMLSAF_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','D11','dbo.U_EANTFMLSAF_drvTbl_LOB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','D12','dbo.U_EANTFMLSAF_drvTbl_UDDT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','D13','dbo.U_EANTFMLSAF_drvTbl_Dep','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSAF','T90','dbo.U_EANTFMLSAF_Trailer',NULL);
IF OBJECT_ID('U_dsi_EANTFMLSAF_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EANTFMLSAF_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);
IF OBJECT_ID('U_EANTFMLSAF_DedList') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EANTFMLSAF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_drvTbl] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMaidenName] varchar(1) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvGroupNo] varchar(7) NOT NULL,
    [drvGroupEffDate] datetime NULL,
    [drvSalEffDate] datetime NULL,
    [drvBillGroupEffDate] datetime NULL,
    [drvClassEffDate] varchar(1) NOT NULL,
    [drvBillClassEffDate] varchar(1) NOT NULL,
    [drvERName] varchar(14) NOT NULL,
    [drvBillGroupNo] varchar(4) NOT NULL,
    [drvBillGroupName] varchar(1) NOT NULL,
    [drvClassNo] varchar(2) NOT NULL,
    [drvClassDesc] varchar(1) NOT NULL,
    [drvSalary] varchar(10) NULL,
    [drvSalaryFreq] varchar(1) NOT NULL,
    [drvHrsWorks] varchar(31) NULL,
    [drvEligibilityStatus] varchar(3) NOT NULL,
    [drvDateofHire] datetime NULL,
    [drvJoinGroupDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvFaxNumber] varchar(1) NOT NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvSmoker] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvBillClass] varchar(4) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTFMLSAF_drvTbl_LOB') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_drvTbl_LOB] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvLOB] varchar(7) NULL,
    [drvBenStatus] varchar(3) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvCovAmt] varchar(1) NOT NULL,
    [drvBenSelectOpt] varchar(1) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTFMLSAF_drvTbl_UDDT') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_drvTbl_UDDT] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvType] varchar(18) NOT NULL,
    [drvValue] varchar(256) NULL,
    [drvLOB] varchar(1) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvFiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTFMLSAF_EEList') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EANTFMLSAF_File') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1500) NULL
);
IF OBJECT_ID('U_EANTFMLSAF_Header') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_Header] (
    [drvEEID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(3) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvGroupNo] varchar(7) NOT NULL,
    [drvGroupName] varchar(14) NOT NULL,
    [drvDate] varchar(30) NULL,
    [drvTime] varchar(8000) NULL,
    [drvFullDelta] varchar(1) NOT NULL,
    [drvfiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTFMLSAF_HeaderW') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_HeaderW] (
    [drvEEID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvWHeader] varchar(44) NULL
);
IF OBJECT_ID('U_EANTFMLSAF_Trailer') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSAF_Trailer] (
    [drvEEID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvTotalRecords] int NULL,
    [drvFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTFMLSAF]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: SAFEbuilt, LLC

Created By: Parsha Antara
Business Analyst: Jennifer Flood
Create Date: 05/16/2019
Service Request Number: SR-2019-00229158

Purpose: Anthem Life COMPASS Proprietary Standard Layout (1500 byte)


Revision History
----------------
Update By           Date           Request Num        Desc
B'Nai Jackson        04/27/2020        PR-343669          Added class codes & Updated Detail Record 200 & 210 fields
B'Nai Jackson        05/27/2020        PR-343669          Excluded Employee Type Codes of  “CON” and “BRD”
B'Nai Jackson        06/11/2020        PR-343669          Blank-out the Bill Class and Class Effective DAte field (temporary update)
Marco Lagrosa        09/22/2020        TekP-2020-09-18-0003         Remove employee under ACQ paygroup



SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANTFMLSAF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANTFMLSAF';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EANTFMLSAF', @AllObjects = 'Y'

select * from ascexp
\\us.saas\ew1\EW12\Downloads\V10\Exports\REDLC\EmployeeHistoryExport\
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
    SELECT @FormatCode = 'EANTFMLSAF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EANTFMLSAF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANTFMLSAF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     -- Remove Terminated Employees
    DELETE FROM dbo.U_EANTFMLSAF_EEList
    FROM dbo.U_EANTFMLSAF_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE (EecEmplStatus = 'T'
    AND eecdateoftermination + 7 < @EndDate)
    or eepssn like '999%'
    or eepssn like '000%'
    or eeceetype in ('tes','z','CON','BRD')--05/27/20 BJ
    ; 
    --Marco Lagrosa        09/22/2020        TekP-2020-09-18-0003         Remove employee under ACQ paygroup
    --IF @ExportCode like 'TEST%' 
    --    BEGIN
            Delete from dbo.U_EANTFMLSAF_EEList where xeeid in (Select eeceeid from vw_int_EmpComp where eecpaygroup = 'ACQ') 
    --    END

 
    --==========================================
    -- Build Driver Tables
    --==========================================

    -- Build earnings for last 12 months (for hours reporting)
    
if object_id('U_dsi_EANTFMLSAF_EarnHist') is not null
  drop table dbo.U_dsi_EANTFMLSAF_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0)) AS eamt,
    SUM(ISNULL(pehCurHrs,0)) AS ehrs

    INTO dbo.U_dsi_EANTFMLSAF_EarnHist
        from dbo.u_EANTFMLSAF_EELIST 
    JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND pehearncode in ('HOLW','OT','REG','DOT') 
        AND pehpaydate BETWEEN (@EndDate - 365) and @EndDate
    GROUP BY xEEID,xCOID--,pehearncode
    
---------------------------------
    -- HEADER W RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_HeaderW','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_HeaderW;
    SELECT DISTINCT
    drvEEID = ''
    ,drvInitialSort = '1'
    ,drvSubSort2 = ''
        ,drvWHeader = CASE WHEN @ExportCode like 'TEST%' THEN CAST('_W-SOF_:fmlprop:ca45063z:FML Proprietary:T::' AS VARCHAR(44))
                      ELSE     CAST('_W-SOF_:fmlprop:ca45063z:FML Proprietary:P::' AS VARCHAR(44)) END   
    INTO dbo.U_EANTFMLSAF_HeaderW
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_Header;
    SELECT DISTINCT
    drvEEID = ''
    ,drvInitialSort = '1.5'
    ,drvSubSort2 = ''
        ,drvRecordType = '100'
        ,drvGroupNo = 'W41345F'
        ,drvGroupName = 'SAFEbuilt, LLC'
        ,drvDate = CONVERT(VARCHAR, GETDATE(),112)
        ,drvTime = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','')
        ,drvFullDelta = '1'
        ,drvfiller = ''
    INTO dbo.U_EANTFMLSAF_Header
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSAF_drvTbl
    --Detail Member Record - 200
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_drvTbl;
    SELECT DISTINCT
        drvInitialSort = '2'
        , drvSubSort2 = '2'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '200'
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvMaidenName = ''
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvGroupNo = 'W41345F'
        ,drvGroupEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvSalEffDate = CASE
                            WHEN ISNULL(RateDate,'') <> '' AND RateDate > '20190801' THEN RateDate--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
                            WHEN ISNULL(RateDate,'') <> '' AND RateDate <= '20190801' THEN '20190801'
                            WHEN EecDateofLastHire > '20190701' THEN EecDateofLastHire--05/06/20 BJ - Replace EecDateofOriginalHire
                        ELSE '20190801' END
        ,drvBillGroupEffDate =CASE
                            WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
                        ELSE '20190801' END
        ,drvClassEffDate =    '' --06/11/20 BJ
                            --CASE
       --                     WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
       --                 ELSE '20190801' END
        ,drvBillClassEffDate ='' --06/11/20 BJ    
        --CASE
  --                          WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
  --                      ELSE '20190801' END
        ,drvERName = 'SAFEbuilt, LLC'
        ,drvBillGroupNo = '0000'--CASE WHEN EecDedGroupCode = 'CGA' THEN '0001' ELSE '0000' END--04/27/20 BJ REMOVED
        ,drvBillGroupName = ''
        ,drvClassNo = CASE  WHEN EecFulltimeorParttime = 'F' THEN '01'
                            WHEN EecFulltimeorParttime = 'P' THEN '02'
                    ELSE '' END
        ,drvClassDesc = ''
        ,drvSalary = RIGHT('0000000000' + CONVERT(VARCHAR,CAST((EecAnnSalary*100) as INT)),10)
        ,drvSalaryFreq = '7'
        ,drvHrsWorks = CASE
                            WHEN EecPayPeriod = 'B' THEN CAST(CAST((EecScheduledWorkHrs*26)/52 AS INT) AS VARCHAR)+ ' '
                            WHEN EecPayPeriod = 'M' THEN CAST(CAST((EecScheduledWorkHrs*12)/52 AS INT) AS VARCHAR)+ ' '
                            WHEN EecPayPeriod = 'S' THEN CAST(CAST((EecScheduledWorkHrs*24)/52 AS INT) AS VARCHAR)+ ' '
                        END
        ,drvEligibilityStatus = CASE
                                    WHEN EecEmplStatus = 'T' THEN '337'
                                ELSE '336' END
        ,drvDateofHire = eecDateofLastHire
        ,drvJoinGroupDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvFaxNumber = ''
        ,drvAddressEmail = EepAddressEMail
        ,drvSmoker = '' --EepIsSmoker
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('M','S') THEN eepMaritalStatus ELSE '' END
        ,drvBillClass = CASE
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ACCTN'         THEN 'S005'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ADMIN'         THEN 'S006'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ATLNT'         THEN 'S007'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BAYVL'         THEN 'S008'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BUILDC'        THEN 'F001'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BUSDV'         THEN 'S009'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CASTL'         THEN 'S010'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CEI'           THEN 'F002'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CENTE'         THEN 'S013'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CECHI'         THEN 'S012'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CENTRAL WI'    THEN 'S067'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CGA MARKETING' THEN 'F108'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OPCOO'         THEN 'S051'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CLVND'         THEN 'S014'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CODIR'         THEN 'S016'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CODOP'         THEN 'S017'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'COAST'         THEN 'S015'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CODECO'        THEN 'F003'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'COLUM'         THEN 'S018'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'COMPAN'        THEN 'F004'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CONSTR'        THEN 'F005'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CRNST'         THEN 'S019'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CWIDE'         THEN 'S011'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DATA'          THEN 'F006'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DECAT'         THEN 'S020'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DENVE'         THEN 'S021'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DETRT'         THEN 'S022'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'EAGLE'         THEN 'S023'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ENGINE'        THEN 'F007'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ESGIL'         THEN 'S024'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ESOP'          THEN 'F008'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'EXECUT'        THEN 'F009'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FIRES'         THEN 'S025'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FLBOM'         THEN 'F100'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MTFMS'         THEN 'F103'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FTLOFF'        THEN 'F010'
                           WHEN vw_int_EmpComp.EecOrgLvl3 in ('FTLTRA','FTLTRF')        THEN 'F011'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GADIR'         THEN 'S026'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GADOP'         THEN 'S027'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GLNVW'         THEN 'S028'
                           WHEN vw_int_EmpComp.EecOrgLvl3 in ('GOVSVS','GOVERN')        THEN 'F012'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GRBAY'         THEN 'S029'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GULFC'         THEN 'F013'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HAMTK'         THEN 'S030'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HRPRW'         THEN 'S031'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HRTFD'         THEN 'S032'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HLNDB'         THEN 'F101'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000HR'         THEN 'S001'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ILDIR'         THEN 'S034'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ILBOM'         THEN 'S033'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'INDOOR'        THEN 'F014'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000IT'         THEN 'S002'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'INKF'          THEN 'F015'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'JOHNS'         THEN 'S035'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'KINGC'         THEN 'S036'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'KUTZM'         THEN 'S037'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'LANDSC'        THEN 'F016'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MADSN'         THEN 'S039'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MADHT'         THEN 'S038'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MALRD'         THEN 'S040'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MENOM'         THEN 'S041'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MERIT'         THEN 'S042'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MIBOM'         THEN 'S043'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MIDIR'         THEN 'S044'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MIDOP'         THEN 'S045'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MILTN'         THEN 'S046'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MTINC'         THEN 'F104'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MTCPP'         THEN 'F102'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MUSKN'         THEN 'S047'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOCOR'         THEN 'S048'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOFLO'         THEN 'F105'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOSHR'         THEN 'S050'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NORTH'         THEN 'S049'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OKCHB'         THEN 'F106'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ONSITE'        THEN 'F017'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ORANG'         THEN 'F107'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PARKS'         THEN 'F019'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PHNIX'         THEN 'S052'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PLANNI'        THEN 'F020'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '00PMO'         THEN 'S003'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ROSWL'         THEN 'S053'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ROYAL'         THEN 'S054'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '00SGA'         THEN 'S004'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SCBOM'         THEN 'S055'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOFTWA'        THEN 'F021'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SRNTO'         THEN 'S067'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOCHI'         THEN 'S056'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOUTH'         THEN 'S057'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'STATE'         THEN 'S058'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SURVEY'        THEN 'F022'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'TRAIN'         THEN 'S059'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'TROYM'         THEN 'S060'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WAKSH'         THEN 'S061'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WESTOS'        THEN 'F023'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WIBOM'         THEN 'S062'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WIDOP'         THEN 'S063'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WINDS'         THEN 'S064'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WINST'         THEN 'S065'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WIXOM'         THEN 'S066'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WPBENG'         THEN 'F026'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WPBOFF'        THEN 'F024'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WPBSUR'        THEN 'F025'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OPSMTN'        THEN 'F018'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDSPC'        THEN 'S068'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '07M'        THEN 'F108'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CTLWI'        THEN 'S069'
                           --04/20/20 BJ:
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OPSMTN'        THEN 'F018'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '07M'        THEN 'F108'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'STHGA'        THEN 'S057'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDSPC'        THEN 'S068'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CTLWI'        THEN 'S069'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FIN05'        THEN 'FN05'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HR05'        THEN 'HR05'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ACMGT'        THEN 'ACMT'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SALOP'        THEN 'SAOP'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MKTNG'        THEN 'MKTG'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDS01'        THEN 'BDS1'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDS03'        THEN 'BDS3'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '00COO'        THEN '00CO'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PPS01'        THEN 'PPS1'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000DC'        THEN '00DC'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MACON'        THEN 'M001'
                           --WHEN vw_int_EmpComp.EecOrgLvl3 = 'ACQ'        THEN 'ACQ1'--04/27/20 BJ REMOVED
                           
                           ELSE '0000'
                        END
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_drvTbl
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (SELECT ejhEEID, ejhCOID, MAX(EjhJobEffDate) as RateDate
                    FROM vw_int_EmpHJob
                    WHERE EjhIsRateChange = 'Y'
                    GROUP BY ejhEEID, ejhCOID) EJH
        ON EJH.ejhEEID = xEEID
        AND EJH.ejhCOID = xCOID
        
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSAF_drvTbl_LOB
    --Detail Member Line of Business Record - 210
    ---------------------------------

    --FML Segment
    IF OBJECT_ID('U_EANTFMLSAF_drvTbl_LOB','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_drvTbl_LOB;
    SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = CAST('FML' as varchar(7))
        --CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'FML' ELSE 'STD-Sal' END
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
                    --CASE
                    --        WHEN EecFulltimeorParttime = 'F' THEN '01'
     --                       WHEN EecFulltimeorParttime = 'P' THEN '03'
     --               ELSE '' END
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_drvTbl_LOB
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
        
   
    ;

    --STD Segment
    INSERT INTO dbo.U_EANTFMLSAF_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = 'STD-Sal'
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecFullTimeOrPartTime = 'F'--06/09/20 BJ
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
   
        --AND Cast(EecScheduledWorkHrs/2 as money) >= '30'
    ;

    --04/27/20 BJ Added:
      --PFLSM/PFLSF Segment (NY MAnadated Paid Family Leave - Male or Female)
    INSERT INTO dbo.U_EANTFMLSAF_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = case when eepgender = 'M' then 'PFLSM' when eepgender = 'F' then 'PFLSF' end
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecWCState = 'NY'
        AND EecOrgLvl3 <> 'ACQ'
    LEFT JOIN dbo.EmpPers with (NOLOCK) on EepEEID = EecEEID 

    --04/27/20 BJ Added:
      --DBLSM/DBLSF Segment (NY MAnadated STD - Male or Female)
    INSERT INTO dbo.U_EANTFMLSAF_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = case when eepgender = 'M' then 'DBLSM' when eepgender = 'F' then 'DBLSF' end
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecWCState = 'NY'--04/27/20 BJ
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
    LEFT JOIN dbo.EmpPers with (NOLOCK) on EepEEID = EecEEID ----04/27/20 BJ


    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSAF_drvTbl_UDDT
    --Detail UDDT/CDR Record - 999
    ---------------------------------
    
    IF OBJECT_ID('U_EANTFMLSAF_drvTbl_UDDT','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_drvTbl_UDDT;
    SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_PRM_CNT_EMAIL' --Supervisor Email
        ,drvValue = CAST(eepAddressEmail AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate --what date should be used as effective date
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_drvTbl_UDDT
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EE WITH (NOLOCK)
        ON drvEEID = EE.eecEEID and drvCOID = EE.eecCOID
    LEFT JOIN dbo.vw_int_EmpComp SUP WITH (NOLOCK)
        ON EE.EecSupervisorID = SUP.EecEEID
    LEFT JOIN dbo.EmpPers WITH (NOLOCK)
        ON SUP.EecEEID = eepeeid


    UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = DR.drvEEID
        ,drvCoID = DR.drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_HR_CNT_EMAIL' --HR Contact Email
        ,drvValue = dbo.dsi_fnlib_GetSupervisorField_v2('', drvEEID, 'AddressEMail')
        --CAST('hr.forms@safeb.net' AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = DR.drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl DR WITH (NOLOCK)

        UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_FT' --Fulltime or Parttime
        ,drvValue = CAST(CASE
                        WHEN EecFullTimeorPartTime = 'F' THEN '1'
                    ELSE '0' END AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp 
        ON eecEEID = drvEEID AND EecCOID = drvCOID

            UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_WRK_ST' --Work State
        ,drvValue = CAST(eecWCState  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp 
        ON eecEEID = drvEEID AND EecCOID = drvCOID

            UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_YR_HRS' --Hrs Last 12 Mo
        ,drvValue = CAST(CAST(ehrs as INT) AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.U_dsi_EANTFMLSAF_EarnHist
        ON eeeid = drvEEID and ecoid = drvCOID

                UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_ORG_CD' --Bill Group Number
        ,drvValue = drvBillGroupNo
        --CAST('0000'  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)

                UNION

        SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_EMP_TYP' --Emp Type System Code
        ,drvValue = CAST('SUPR'   AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN vw_int_EmpComp
        ON drvEEID = eecEEID and drvCOID = eecCOID

                UNION

        SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_ORG_TYP' --Org Type System Code
        ,drvValue = CAST('WORK'  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)

    ;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_Trailer;
    SELECT DISTINCT
         drvEEID = ''
         ,drvInitialSort = '3'
         ,drvSubSort2 = ''
        ,drvRecordType = '300'
        ,drvTotalRecords = (SELECT COUNT(*) FROM dbo.U_EANTFMLSAF_drvTbl) + (SELECT COUNT(*) FROM dbo.U_EANTFMLSAF_drvTbl_LOB) + /*(SELECT COUNT(*) FROM dbo.U_EANTFMLSAF_drvTbl_Dep) +*/ 2
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EANTFMLSAF_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EANTFMLSAF_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EANTFMLSAF_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEANTFMLSAF_Export AS
    SELECT TOP 20000000 
    CASE WHEN RecordSet = 'H01' THEN SUBSTRING(Data,1,44)
        WHEN RecordSet <> 'H01' THEN Data
        END as Data
    
    FROM dbo.U_EANTFMLSAF_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, SubSort2;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EANTFMLSAF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201706201'
       ,expStartPerControl     = '201706201'
       ,expLastEndPerControl   = '201706279'
       ,expEndPerControl       = '201706279'
WHERE expFormatCode = 'EANTFMLSAF';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTFMLSAF]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: SAFEbuilt, LLC

Created By: Parsha Antara
Business Analyst: Jennifer Flood
Create Date: 05/16/2019
Service Request Number: SR-2019-00229158

Purpose: Anthem Life COMPASS Proprietary Standard Layout (1500 byte)


Revision History
----------------
Update By           Date           Request Num        Desc
B'Nai Jackson        04/27/2020        PR-343669          Added class codes & Updated Detail Record 200 & 210 fields
B'Nai Jackson        05/27/2020        PR-343669          Excluded Employee Type Codes of  “CON” and “BRD”
B'Nai Jackson        06/11/2020        PR-343669          Blank-out the Bill Class and Class Effective DAte field (temporary update)
Marco Lagrosa        09/22/2020        TekP-2020-09-18-0003         Remove employee under ACQ paygroup



SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EANTFMLSAF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANTFMLSAF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSAF', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANTFMLSAF';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EANTFMLSAF', @AllObjects = 'Y'

select * from ascexp
\\us.saas\ew1\EW12\Downloads\V10\Exports\REDLC\EmployeeHistoryExport\
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
    SELECT @FormatCode = 'EANTFMLSAF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EANTFMLSAF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANTFMLSAF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     -- Remove Terminated Employees
    DELETE FROM dbo.U_EANTFMLSAF_EEList
    FROM dbo.U_EANTFMLSAF_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE (EecEmplStatus = 'T'
    AND eecdateoftermination + 7 < @EndDate)
    or eepssn like '999%'
    or eepssn like '000%'
    or eeceetype in ('tes','z','CON','BRD')--05/27/20 BJ
    ; 
    --Marco Lagrosa        09/22/2020        TekP-2020-09-18-0003         Remove employee under ACQ paygroup
    --IF @ExportCode like 'TEST%' 
    --    BEGIN
            Delete from dbo.U_EANTFMLSAF_EEList where xeeid in (Select eeceeid from empcomp where eecpaygroup = 'ACQ') 
    --    END

 
    --==========================================
    -- Build Driver Tables
    --==========================================

    -- Build earnings for last 12 months (for hours reporting)
    
if object_id('U_dsi_EANTFMLSAF_EarnHist') is not null
  drop table dbo.U_dsi_EANTFMLSAF_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0)) AS eamt,
    SUM(ISNULL(pehCurHrs,0)) AS ehrs

    INTO dbo.U_dsi_EANTFMLSAF_EarnHist
        from dbo.u_EANTFMLSAF_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND pehearncode in ('HOLW','OT','REG','DOT') 
        AND pehpaydate BETWEEN (@EndDate - 365) and @EndDate
    GROUP BY xEEID,xCOID--,pehearncode
    
---------------------------------
    -- HEADER W RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_HeaderW','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_HeaderW;
    SELECT DISTINCT
    drvEEID = ''
    ,drvInitialSort = '1'
    ,drvSubSort2 = ''
        ,drvWHeader = CASE WHEN @ExportCode like 'TEST%' THEN CAST('_W-SOF_:fmlprop:ca45063z:FML Proprietary:T::' AS VARCHAR(44))
                      ELSE     CAST('_W-SOF_:fmlprop:ca45063z:FML Proprietary:P::' AS VARCHAR(44)) END   
    INTO dbo.U_EANTFMLSAF_HeaderW
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_Header;
    SELECT DISTINCT
    drvEEID = ''
    ,drvInitialSort = '1.5'
    ,drvSubSort2 = ''
        ,drvRecordType = '100'
        ,drvGroupNo = 'W41345F'
        ,drvGroupName = 'SAFEbuilt, LLC'
        ,drvDate = CONVERT(VARCHAR, GETDATE(),112)
        ,drvTime = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','')
        ,drvFullDelta = '1'
        ,drvfiller = ''
    INTO dbo.U_EANTFMLSAF_Header
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSAF_drvTbl
    --Detail Member Record - 200
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_drvTbl;
    SELECT DISTINCT
        drvInitialSort = '2'
        , drvSubSort2 = '2'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '200'
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvMaidenName = ''
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvGroupNo = 'W41345F'
        ,drvGroupEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvSalEffDate = CASE
                            WHEN ISNULL(RateDate,'') <> '' AND RateDate > '20190801' THEN RateDate--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
                            WHEN ISNULL(RateDate,'') <> '' AND RateDate <= '20190801' THEN '20190801'
                            WHEN EecDateofLastHire > '20190701' THEN EecDateofLastHire--05/06/20 BJ - Replace EecDateofOriginalHire
                        ELSE '20190801' END
        ,drvBillGroupEffDate =CASE
                            WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
                        ELSE '20190801' END
        ,drvClassEffDate =    '' --06/11/20 BJ
                            --CASE
       --                     WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
       --                 ELSE '20190801' END
        ,drvBillClassEffDate ='' --06/11/20 BJ    
        --CASE
  --                          WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
  --                      ELSE '20190801' END
        ,drvERName = 'SAFEbuilt, LLC'
        ,drvBillGroupNo = '0000'--CASE WHEN EecDedGroupCode = 'CGA' THEN '0001' ELSE '0000' END--04/27/20 BJ REMOVED
        ,drvBillGroupName = ''
        ,drvClassNo = CASE  WHEN EecFulltimeorParttime = 'F' THEN '01'
                            WHEN EecFulltimeorParttime = 'P' THEN '02'
                    ELSE '' END
        ,drvClassDesc = ''
        ,drvSalary = RIGHT('0000000000' + CONVERT(VARCHAR,CAST((EecAnnSalary*100) as INT)),10)
        ,drvSalaryFreq = '7'
        ,drvHrsWorks = CASE
                            WHEN EecPayPeriod = 'B' THEN CAST(CAST((EecScheduledWorkHrs*26)/52 AS INT) AS VARCHAR)+ ' '
                            WHEN EecPayPeriod = 'M' THEN CAST(CAST((EecScheduledWorkHrs*12)/52 AS INT) AS VARCHAR)+ ' '
                            WHEN EecPayPeriod = 'S' THEN CAST(CAST((EecScheduledWorkHrs*24)/52 AS INT) AS VARCHAR)+ ' '
                        END
        ,drvEligibilityStatus = CASE
                                    WHEN EecEmplStatus = 'T' THEN '337'
                                ELSE '336' END
        ,drvDateofHire = eecDateofLastHire
        ,drvJoinGroupDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvFaxNumber = ''
        ,drvAddressEmail = EepAddressEMail
        ,drvSmoker = '' --EepIsSmoker
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('M','S') THEN eepMaritalStatus ELSE '' END
        ,drvBillClass = CASE
                           WHEN EmpComp.EecOrgLvl3 = 'ACCTN'         THEN 'S005'
                           WHEN EmpComp.EecOrgLvl3 = 'ADMIN'         THEN 'S006'
                           WHEN EmpComp.EecOrgLvl3 = 'ATLNT'         THEN 'S007'
                           WHEN EmpComp.EecOrgLvl3 = 'BAYVL'         THEN 'S008'
                           WHEN EmpComp.EecOrgLvl3 = 'BUILDC'        THEN 'F001'
                           WHEN EmpComp.EecOrgLvl3 = 'BUSDV'         THEN 'S009'
                           WHEN EmpComp.EecOrgLvl3 = 'CASTL'         THEN 'S010'
                           WHEN EmpComp.EecOrgLvl3 = 'CEI'           THEN 'F002'
                           WHEN EmpComp.EecOrgLvl3 = 'CENTE'         THEN 'S013'
                           WHEN EmpComp.EecOrgLvl3 = 'CECHI'         THEN 'S012'
                           WHEN EmpComp.EecOrgLvl3 = 'CENTRAL WI'    THEN 'S067'
                           WHEN EmpComp.EecOrgLvl3 = 'CGA MARKETING' THEN 'F108'
                           WHEN EmpComp.EecOrgLvl3 = 'OPCOO'         THEN 'S051'
                           WHEN EmpComp.EecOrgLvl3 = 'CLVND'         THEN 'S014'
                           WHEN EmpComp.EecOrgLvl3 = 'CODIR'         THEN 'S016'
                           WHEN EmpComp.EecOrgLvl3 = 'CODOP'         THEN 'S017'
                           WHEN EmpComp.EecOrgLvl3 = 'COAST'         THEN 'S015'
                           WHEN EmpComp.EecOrgLvl3 = 'CODECO'        THEN 'F003'
                           WHEN EmpComp.EecOrgLvl3 = 'COLUM'         THEN 'S018'
                           WHEN EmpComp.EecOrgLvl3 = 'COMPAN'        THEN 'F004'
                           WHEN EmpComp.EecOrgLvl3 = 'CONSTR'        THEN 'F005'
                           WHEN EmpComp.EecOrgLvl3 = 'CRNST'         THEN 'S019'
                           WHEN EmpComp.EecOrgLvl3 = 'CWIDE'         THEN 'S011'
                           WHEN EmpComp.EecOrgLvl3 = 'DATA'          THEN 'F006'
                           WHEN EmpComp.EecOrgLvl3 = 'DECAT'         THEN 'S020'
                           WHEN EmpComp.EecOrgLvl3 = 'DENVE'         THEN 'S021'
                           WHEN EmpComp.EecOrgLvl3 = 'DETRT'         THEN 'S022'
                           WHEN EmpComp.EecOrgLvl3 = 'EAGLE'         THEN 'S023'
                           WHEN EmpComp.EecOrgLvl3 = 'ENGINE'        THEN 'F007'
                           WHEN EmpComp.EecOrgLvl3 = 'ESGIL'         THEN 'S024'
                           WHEN EmpComp.EecOrgLvl3 = 'ESOP'          THEN 'F008'
                           WHEN EmpComp.EecOrgLvl3 = 'EXECUT'        THEN 'F009'
                           WHEN EmpComp.EecOrgLvl3 = 'FIRES'         THEN 'S025'
                           WHEN EmpComp.EecOrgLvl3 = 'FLBOM'         THEN 'F100'
                           WHEN EmpComp.EecOrgLvl3 = 'MTFMS'         THEN 'F103'
                           WHEN EmpComp.EecOrgLvl3 = 'FTLOFF'        THEN 'F010'
                           WHEN EmpComp.EecOrgLvl3 in ('FTLTRA','FTLTRF')        THEN 'F011'
                           WHEN EmpComp.EecOrgLvl3 = 'GADIR'         THEN 'S026'
                           WHEN EmpComp.EecOrgLvl3 = 'GADOP'         THEN 'S027'
                           WHEN EmpComp.EecOrgLvl3 = 'GLNVW'         THEN 'S028'
                           WHEN EmpComp.EecOrgLvl3 in ('GOVSVS','GOVERN')        THEN 'F012'
                           WHEN EmpComp.EecOrgLvl3 = 'GRBAY'         THEN 'S029'
                           WHEN EmpComp.EecOrgLvl3 = 'GULFC'         THEN 'F013'
                           WHEN EmpComp.EecOrgLvl3 = 'HAMTK'         THEN 'S030'
                           WHEN EmpComp.EecOrgLvl3 = 'HRPRW'         THEN 'S031'
                           WHEN EmpComp.EecOrgLvl3 = 'HRTFD'         THEN 'S032'
                           WHEN EmpComp.EecOrgLvl3 = 'HLNDB'         THEN 'F101'
                           WHEN EmpComp.EecOrgLvl3 = '000HR'         THEN 'S001'
                           WHEN EmpComp.EecOrgLvl3 = 'ILDIR'         THEN 'S034'
                           WHEN EmpComp.EecOrgLvl3 = 'ILBOM'         THEN 'S033'
                           WHEN EmpComp.EecOrgLvl3 = 'INDOOR'        THEN 'F014'
                           WHEN EmpComp.EecOrgLvl3 = '000IT'         THEN 'S002'
                           WHEN EmpComp.EecOrgLvl3 = 'INKF'          THEN 'F015'
                           WHEN EmpComp.EecOrgLvl3 = 'JOHNS'         THEN 'S035'
                           WHEN EmpComp.EecOrgLvl3 = 'KINGC'         THEN 'S036'
                           WHEN EmpComp.EecOrgLvl3 = 'KUTZM'         THEN 'S037'
                           WHEN EmpComp.EecOrgLvl3 = 'LANDSC'        THEN 'F016'
                           WHEN EmpComp.EecOrgLvl3 = 'MADSN'         THEN 'S039'
                           WHEN EmpComp.EecOrgLvl3 = 'MADHT'         THEN 'S038'
                           WHEN EmpComp.EecOrgLvl3 = 'MALRD'         THEN 'S040'
                           WHEN EmpComp.EecOrgLvl3 = 'MENOM'         THEN 'S041'
                           WHEN EmpComp.EecOrgLvl3 = 'MERIT'         THEN 'S042'
                           WHEN EmpComp.EecOrgLvl3 = 'MIBOM'         THEN 'S043'
                           WHEN EmpComp.EecOrgLvl3 = 'MIDIR'         THEN 'S044'
                           WHEN EmpComp.EecOrgLvl3 = 'MIDOP'         THEN 'S045'
                           WHEN EmpComp.EecOrgLvl3 = 'MILTN'         THEN 'S046'
                           WHEN EmpComp.EecOrgLvl3 = 'MTINC'         THEN 'F104'
                           WHEN EmpComp.EecOrgLvl3 = 'MTCPP'         THEN 'F102'
                           WHEN EmpComp.EecOrgLvl3 = 'MUSKN'         THEN 'S047'
                           WHEN EmpComp.EecOrgLvl3 = 'NOCOR'         THEN 'S048'
                           WHEN EmpComp.EecOrgLvl3 = 'NOFLO'         THEN 'F105'
                           WHEN EmpComp.EecOrgLvl3 = 'NOSHR'         THEN 'S050'
                           WHEN EmpComp.EecOrgLvl3 = 'NORTH'         THEN 'S049'
                           WHEN EmpComp.EecOrgLvl3 = 'OKCHB'         THEN 'F106'
                           WHEN EmpComp.EecOrgLvl3 = 'ONSITE'        THEN 'F017'
                           WHEN EmpComp.EecOrgLvl3 = 'ORANG'         THEN 'F107'
                           WHEN EmpComp.EecOrgLvl3 = 'PARKS'         THEN 'F019'
                           WHEN EmpComp.EecOrgLvl3 = 'PHNIX'         THEN 'S052'
                           WHEN EmpComp.EecOrgLvl3 = 'PLANNI'        THEN 'F020'
                           WHEN EmpComp.EecOrgLvl3 = '00PMO'         THEN 'S003'
                           WHEN EmpComp.EecOrgLvl3 = 'ROSWL'         THEN 'S053'
                           WHEN EmpComp.EecOrgLvl3 = 'ROYAL'         THEN 'S054'
                           WHEN EmpComp.EecOrgLvl3 = '00SGA'         THEN 'S004'
                           WHEN EmpComp.EecOrgLvl3 = 'SCBOM'         THEN 'S055'
                           WHEN EmpComp.EecOrgLvl3 = 'SOFTWA'        THEN 'F021'
                           WHEN EmpComp.EecOrgLvl3 = 'SRNTO'         THEN 'S067'
                           WHEN EmpComp.EecOrgLvl3 = 'SOCHI'         THEN 'S056'
                           WHEN EmpComp.EecOrgLvl3 = 'SOUTH'         THEN 'S057'
                           WHEN EmpComp.EecOrgLvl3 = 'STATE'         THEN 'S058'
                           WHEN EmpComp.EecOrgLvl3 = 'SURVEY'        THEN 'F022'
                           WHEN EmpComp.EecOrgLvl3 = 'TRAIN'         THEN 'S059'
                           WHEN EmpComp.EecOrgLvl3 = 'TROYM'         THEN 'S060'
                           WHEN EmpComp.EecOrgLvl3 = 'WAKSH'         THEN 'S061'
                           WHEN EmpComp.EecOrgLvl3 = 'WESTOS'        THEN 'F023'
                           WHEN EmpComp.EecOrgLvl3 = 'WIBOM'         THEN 'S062'
                           WHEN EmpComp.EecOrgLvl3 = 'WIDOP'         THEN 'S063'
                           WHEN EmpComp.EecOrgLvl3 = 'WINDS'         THEN 'S064'
                           WHEN EmpComp.EecOrgLvl3 = 'WINST'         THEN 'S065'
                           WHEN EmpComp.EecOrgLvl3 = 'WIXOM'         THEN 'S066'
                           WHEN EmpComp.EecOrgLvl3 = 'WPBENG'         THEN 'F026'
                           WHEN EmpComp.EecOrgLvl3 = 'WPBOFF'        THEN 'F024'
                           WHEN EmpComp.EecOrgLvl3 = 'WPBSUR'        THEN 'F025'
                           WHEN EmpComp.EecOrgLvl3 = 'OPSMTN'        THEN 'F018'
                           WHEN EmpComp.EecOrgLvl3 = 'BDSPC'        THEN 'S068'
                           WHEN EmpComp.EecOrgLvl3 = '07M'        THEN 'F108'
                           WHEN EmpComp.EecOrgLvl3 = 'CTLWI'        THEN 'S069'
                           --04/20/20 BJ:
                           WHEN EmpComp.EecOrgLvl3 = 'OPSMTN'        THEN 'F018'
                           WHEN EmpComp.EecOrgLvl3 = '07M'        THEN 'F108'
                           WHEN EmpComp.EecOrgLvl3 = 'STHGA'        THEN 'S057'
                           WHEN EmpComp.EecOrgLvl3 = 'BDSPC'        THEN 'S068'
                           WHEN EmpComp.EecOrgLvl3 = 'CTLWI'        THEN 'S069'
                           WHEN EmpComp.EecOrgLvl3 = 'FIN05'        THEN 'FN05'
                           WHEN EmpComp.EecOrgLvl3 = 'HR05'        THEN 'HR05'
                           WHEN EmpComp.EecOrgLvl3 = 'ACMGT'        THEN 'ACMT'
                           WHEN EmpComp.EecOrgLvl3 = 'SALOP'        THEN 'SAOP'
                           WHEN EmpComp.EecOrgLvl3 = 'MKTNG'        THEN 'MKTG'
                           WHEN EmpComp.EecOrgLvl3 = 'BDS01'        THEN 'BDS1'
                           WHEN EmpComp.EecOrgLvl3 = 'BDS03'        THEN 'BDS3'
                           WHEN EmpComp.EecOrgLvl3 = '00COO'        THEN '00CO'
                           WHEN EmpComp.EecOrgLvl3 = 'PPS01'        THEN 'PPS1'
                           WHEN EmpComp.EecOrgLvl3 = '000DC'        THEN '00DC'
                           WHEN EmpComp.EecOrgLvl3 = 'MACON'        THEN 'M001'
                           --WHEN EmpComp.EecOrgLvl3 = 'ACQ'        THEN 'ACQ1'--04/27/20 BJ REMOVED
                           
                           ELSE '0000'
                        END
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_drvTbl
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (SELECT ejhEEID, ejhCOID, MAX(EjhJobEffDate) as RateDate
                    FROM EmpHJob
                    WHERE EjhIsRateChange = 'Y'
                    GROUP BY ejhEEID, ejhCOID) EJH
        ON EJH.ejhEEID = xEEID
        AND EJH.ejhCOID = xCOID
        
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSAF_drvTbl_LOB
    --Detail Member Line of Business Record - 210
    ---------------------------------

    --FML Segment
    IF OBJECT_ID('U_EANTFMLSAF_drvTbl_LOB','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_drvTbl_LOB;
    SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = CAST('FML' as varchar(7))
        --CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'FML' ELSE 'STD-Sal' END
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
                    --CASE
                    --        WHEN EecFulltimeorParttime = 'F' THEN '01'
     --                       WHEN EecFulltimeorParttime = 'P' THEN '03'
     --               ELSE '' END
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_drvTbl_LOB
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
        
   
    ;

    --STD Segment
    INSERT INTO dbo.U_EANTFMLSAF_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = 'STD-Sal'
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecFullTimeOrPartTime = 'F'--06/09/20 BJ
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
   
        --AND Cast(EecScheduledWorkHrs/2 as money) >= '30'
    ;

    --04/27/20 BJ Added:
      --PFLSM/PFLSF Segment (NY MAnadated Paid Family Leave - Male or Female)
    INSERT INTO dbo.U_EANTFMLSAF_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = case when eepgender = 'M' then 'PFLSM' when eepgender = 'F' then 'PFLSF' end
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecWCState = 'NY'
        AND EecOrgLvl3 <> 'ACQ'
    LEFT JOIN dbo.EmpPers with (NOLOCK) on EepEEID = EecEEID 

    --04/27/20 BJ Added:
      --DBLSM/DBLSF Segment (NY MAnadated STD - Male or Female)
    INSERT INTO dbo.U_EANTFMLSAF_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = case when eepgender = 'M' then 'DBLSM' when eepgender = 'F' then 'DBLSF' end
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecWCState = 'NY'--04/27/20 BJ
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
    LEFT JOIN dbo.EmpPers with (NOLOCK) on EepEEID = EecEEID ----04/27/20 BJ


    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSAF_drvTbl_UDDT
    --Detail UDDT/CDR Record - 999
    ---------------------------------
    
    IF OBJECT_ID('U_EANTFMLSAF_drvTbl_UDDT','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_drvTbl_UDDT;
    SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_PRM_CNT_EMAIL' --Supervisor Email
        ,drvValue = CAST(eepAddressEmail AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate --what date should be used as effective date
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_drvTbl_UDDT
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.EmpComp EE WITH (NOLOCK)
        ON drvEEID = EE.eecEEID and drvCOID = EE.eecCOID
    LEFT JOIN dbo.EmpComp SUP WITH (NOLOCK)
        ON EE.EecSupervisorID = SUP.EecEEID
    LEFT JOIN dbo.EmpPers WITH (NOLOCK)
        ON SUP.EecEEID = eepeeid


    UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = DR.drvEEID
        ,drvCoID = DR.drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_HR_CNT_EMAIL' --HR Contact Email
        ,drvValue = dbo.dsi_fnlib_GetSupervisorField_v2('', drvEEID, 'AddressEMail')
        --CAST('hr.forms@safeb.net' AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = DR.drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl DR WITH (NOLOCK)

        UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_FT' --Fulltime or Parttime
        ,drvValue = CAST(CASE
                        WHEN EecFullTimeorPartTime = 'F' THEN '1'
                    ELSE '0' END AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.EmpComp 
        ON eecEEID = drvEEID AND EecCOID = drvCOID

            UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_WRK_ST' --Work State
        ,drvValue = CAST(eecWCState  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.EmpComp 
        ON eecEEID = drvEEID AND EecCOID = drvCOID

            UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_YR_HRS' --Hrs Last 12 Mo
        ,drvValue = CAST(CAST(ehrs as INT) AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN dbo.U_dsi_EANTFMLSAF_EarnHist
        ON eeeid = drvEEID and ecoid = drvCOID

                UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_ORG_CD' --Bill Group Number
        ,drvValue = drvBillGroupNo
        --CAST('0000'  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)

                UNION

        SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_EMP_TYP' --Emp Type System Code
        ,drvValue = CAST('SUPR'   AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)
    JOIN EmpComp
        ON drvEEID = eecEEID and drvCOID = eecCOID

                UNION

        SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_ORG_TYP' --Org Type System Code
        ,drvValue = CAST('WORK'  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSAF_drvTbl WITH (NOLOCK)

    ;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSAF_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSAF_Trailer;
    SELECT DISTINCT
         drvEEID = ''
         ,drvInitialSort = '3'
         ,drvSubSort2 = ''
        ,drvRecordType = '300'
        ,drvTotalRecords = (SELECT COUNT(*) FROM dbo.U_EANTFMLSAF_drvTbl) + (SELECT COUNT(*) FROM dbo.U_EANTFMLSAF_drvTbl_LOB) + /*(SELECT COUNT(*) FROM dbo.U_EANTFMLSAF_drvTbl_Dep) +*/ 2
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSAF_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EANTFMLSAF_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EANTFMLSAF_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EANTFMLSAF_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEANTFMLSAF_Export AS
    SELECT TOP 20000000 
    CASE WHEN RecordSet = 'H01' THEN SUBSTRING(Data,1,44)
        WHEN RecordSet <> 'H01' THEN Data
        END as Data
    
    FROM dbo.U_EANTFMLSAF_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, SubSort2;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EANTFMLSAF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201706201'
       ,expStartPerControl     = '201706201'
       ,expLastEndPerControl   = '201706279'
       ,expEndPerControl       = '201706279'
WHERE expFormatCode = 'EANTFMLSAF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEANTFMLSAF_Export AS
    SELECT TOP 20000000 
    CASE WHEN RecordSet = 'H01' THEN SUBSTRING(Data,1,44)
        WHEN RecordSet <> 'H01' THEN Data
        END as Data
    FROM dbo.U_EANTFMLSAF_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, SubSort2;