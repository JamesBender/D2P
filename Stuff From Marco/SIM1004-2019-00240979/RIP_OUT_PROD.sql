SET NOCOUNT ON;
IF OBJECT_ID('U_EMMSIM1004_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMMSIM1004_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMMSIM1004' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMMSIM1004_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMMSIM1004_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMMSIM1004') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMMSIM1004];
GO
IF OBJECT_ID('U_EMMSIM1004_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_PTaxHist];
GO
IF OBJECT_ID('U_EMMSIM1004_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_PEarHist];
GO
IF OBJECT_ID('U_EMMSIM1004_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_PDedHist];
GO
IF OBJECT_ID('U_EMMSIM1004_Header') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Header];
GO
IF OBJECT_ID('U_EMMSIM1004_HdrRecords') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_HdrRecords];
GO
IF OBJECT_ID('U_EMMSIM1004_File') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_File];
GO
IF OBJECT_ID('U_EMMSIM1004_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_EEList];
GO
IF OBJECT_ID('U_EMMSIM1004_Demo_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Demo_Trailer];
GO
IF OBJECT_ID('U_EMMSIM1004_Demo_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Demo_drvTbl];
GO
IF OBJECT_ID('U_EMMSIM1004_Cont_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Cont_Trailer];
GO
IF OBJECT_ID('U_EMMSIM1004_Cont_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Cont_drvTbl];
GO
IF OBJECT_ID('U_EMMSIM1004_Comp_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Comp_Trailer];
GO
IF OBJECT_ID('U_EMMSIM1004_Comp_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_Comp_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMMSIM1004';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EMMSIM1004';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMMSIM1004';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMMSIM1004';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMMSIM1004';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMMSIM1004';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMMSIM1004','Mass Mutual 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMMSIM1004Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMSIM1004Z0','4','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','H','01','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','H','01','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMSIM1004Z0','30','H','01','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMSIM1004Z0','8','H','01','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMSIM1004Z0','8','H','01','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMSIM1004Z0','4','H','01','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMSIM1004Z0','2','H','01','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMSIM1004Z0','4','H','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','H','20','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','H','20','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMSIM1004Z0','30','H','20','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMSIM1004Z0','8','H','20','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMSIM1004Z0','8','H','20','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMSIM1004Z0','4','H','20','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMSIM1004Z0','2','H','20','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMSIM1004Z0','4','H','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','H','40','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','H','40','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMSIM1004Z0','30','H','40','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMSIM1004Z0','8','H','40','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMSIM1004Z0','8','H','40','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMSIM1004Z0','4','H','40','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMSIM1004Z0','2','H','40','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEMO"','1','(''DA''=''F'')','EMMSIM1004Z0','4','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','D','10','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','D','10','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','4','(''UA''=''F'')','EMMSIM1004Z0','12','D','10','15',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','5','(''UA''=''F'')','EMMSIM1004Z0','8','D','10','27',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsetCode"','6','(''UA''=''F'')','EMMSIM1004Z0','12','D','10','35',NULL,'Subset Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','7','(''UA''=''F'')','EMMSIM1004Z0','9','D','10','47',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','8','(''UA''=''F'')','EMMSIM1004Z0','4','D','10','56',NULL,'Prefix Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','9','(''UA''=''F'')','EMMSIM1004Z0','15','D','10','60',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','10','(''UA''=''F'')','EMMSIM1004Z0','10','D','10','75',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','11','(''UA''=''F'')','EMMSIM1004Z0','20','D','10','85',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','12','(''UA''=''F'')','EMMSIM1004Z0','8','D','10','105',NULL,'Suffix Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''F'')','EMMSIM1004Z0','35','D','10','113',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''F'')','EMMSIM1004Z0','35','D','10','148',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EMMSIM1004Z0','35','D','10','183',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','16','(''UA''=''F'')','EMMSIM1004Z0','35','D','10','218',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','17','(''UA''=''F'')','EMMSIM1004Z0','2','D','10','253',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','18','(''UA''=''F'')','EMMSIM1004Z0','10','D','10','255',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','19','(''UA''=''F'')','EMMSIM1004Z0','2','D','10','265',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','20','(''UA''=''F'')','EMMSIM1004Z0','12','D','10','267',NULL,'Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','EMMSIM1004Z0','12','D','10','279',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','22','(''UA''=''F'')','EMMSIM1004Z0','35','D','10','291',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','23','(''UD112''=''F'')','EMMSIM1004Z0','8','D','10','326',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','24','(''UD112''=''F'')','EMMSIM1004Z0','8','D','10','334',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','25','(''UA''=''F'')','EMMSIM1004Z0','1','D','10','342',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','26','(''DA''=''F'')','EMMSIM1004Z0','2','D','10','343',NULL,'Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','27','(''UA''=''F'')','EMMSIM1004Z0','1','D','10','345',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentClass"','28','(''UA''=''F'')','EMMSIM1004Z0','8','D','10','346',NULL,'Employment Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','29','(''UA''=''F'')','EMMSIM1004Z0','8','D','10','354',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusChangeDate"','30','(''UD112''=''F'')','EMMSIM1004Z0','8','D','10','362',NULL,'Employment Status Changed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''F'')','EMMSIM1004Z0','1','D','10','370',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''F'')','EMMSIM1004Z0','1','D','10','371',NULL,'16B Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatus"','33','(''UA''=''F'')','EMMSIM1004Z0','1','D','10','372',NULL,'Payroll Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','34','(''UA''=''F'')','EMMSIM1004Z0','2','D','10','373',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONT"','1','(''DA''=''F'')','EMMSIM1004Z0','4','D','25','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','D','25','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','D','25','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN1"','4','(''DA''=''F'')','EMMSIM1004Z0','8','D','25','15',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','5','(''UA''=''F'')','EMMSIM1004Z0','12','D','25','23',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EMMSIM1004Z0','9','D','25','35',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','7','(''UD112''=''F'')','EMMSIM1004Z0','8','D','25','44',NULL,'Payroll Date (Effective Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodStart"','8','(''UD112''=''F'')','EMMSIM1004Z0','8','D','25','52',NULL,'Payroll Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEnd"','9','(''UD112''=''F'')','EMMSIM1004Z0','8','D','25','60',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSource"','10','(''UA''=''F'')','EMMSIM1004Z0','5','D','25','68',NULL,'Contribution Source Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','11','(''UA''=''F'')','EMMSIM1004Z0','12','D','25','73',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LNRP"','1','(''DA''=''F'')','EMMSIM1004Z0','4','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','D','30','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','D','30','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN1"','4','(''DA''=''F'')','EMMSIM1004Z0','8','D','30','15',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','5','(''UA''=''F'')','EMMSIM1004Z0','12','D','30','23',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EMMSIM1004Z0','9','D','30','35',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','7','(''UD112''=''F'')','EMMSIM1004Z0','8','D','30','44',NULL,'Payroll Date (Effective Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEnd"','8','(''UD112''=''F'')','EMMSIM1004Z0','8','D','30','52',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','9','(''UA''=''F'')','EMMSIM1004Z0','12','D','30','60',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMP"','1','(''DA''=''F'')','EMMSIM1004Z0','4','D','45','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','D','45','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','D','45','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','4','(''UA''=''F'')','EMMSIM1004Z0','12','D','45','15',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''F'')','EMMSIM1004Z0','9','D','45','27',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','6','(''UD112''=''F'')','EMMSIM1004Z0','8','D','45','36',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveStartDate"','7','(''UA''=''F'')','EMMSIM1004Z0','8','D','45','44',NULL,'Effective Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEndDate"','8','(''UD112''=''F'')','EMMSIM1004Z0','8','D','45','52',NULL,'Effective Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSalary"','9','(''UNP2''=''F'')','EMMSIM1004Z0','12','D','45','60',NULL,'Salary for Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415Salary"','10','(''UNP2''=''F'')','EMMSIM1004Z0','12','D','45','72',NULL,'Salary for 415 Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPSalary"','11','(''UNP2''=''F'')','EMMSIM1004Z0','12','D','45','84',NULL,'Salary for ADP Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','12','(''UN0''=''F'')','EMMSIM1004Z0','4','D','45','96',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMTR"','1','(''DA''=''F'')','EMMSIM1004Z0','4','T','15','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','T','15','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','T','15','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMSIM1004Z0','12','T','15','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CNTR"','1','(''DA''=''F'')','EMMSIM1004Z0','4','T','35','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','T','35','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','T','35','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMSIM1004Z0','12','T','35','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionRecords"','5','(''UN0''=''F'')','EMMSIM1004Z0','12','T','35','27',NULL,'Total Contribution Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','6','(''UN0''=''F'')','EMMSIM1004Z0','12','T','35','39',NULL,'Total Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRecords"','7','(''UN0''=''F'')','EMMSIM1004Z0','12','T','35','51',NULL,'Total Loan Repayment Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmount"','8','(''UN0''=''F'')','EMMSIM1004Z0','12','T','35','63',NULL,'Total Loan Repayment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CPTR"','1','(''DA''=''F'')','EMMSIM1004Z0','4','T','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMSIM1004Z0','4','T','50','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMSIM1004Z0','6','T','50','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMSIM1004Z0','12','T','50','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompRecords"','5','(''UN0''=''F'')','EMMSIM1004Z0','12','T','50','27',NULL,'Total Salary for Compensation Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryContribTotal"','6','(''UNP2''=''F'')','EMMSIM1004Z0','12','T','50','39',NULL,'Total Salary for Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415SalaryTotal"','7','(''UNP2''=''F'')','EMMSIM1004Z0','12','T','50','51',NULL,'Total Salary for 415 Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPSalaryTotal"','8','(''UNP2''=''F'')','EMMSIM1004Z0','12','T','50','63',NULL,'Total Salary for ADP Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalHours"','9','(''UN0''=''F'')','EMMSIM1004Z0','12','T','50','75',NULL,'Total Hours Worked',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\SIMV\EmployeeHistoryExport\EMMSIM1004_CONTRIB_0712.txt',NULL,'','','',NULL,NULL,NULL,'Contribution Loan Export','201907111','EMPEXPORT','CONTRIB','Jul 15 2019  3:31PM','EMMSIM1004',NULL,NULL,NULL,'201907111','Jul 11 2019 12:00AM','Jun 30 2019 12:00AM','201907111','518','','','201907111',dbo.fn_GetTimedKey(),NULL,'us3mLaSIM1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\SIMV\EmployeeHistoryExport\EMMSIM1004_DEMO_0711.txt',NULL,'','','',NULL,NULL,NULL,'Demographics Export','201907101','EMPEXPORT','DEMO','Jul 12 2019  3:37PM','EMMSIM1004',NULL,NULL,NULL,'201907101','Jul 10 2019 12:00AM','Dec 30 1899 12:00AM','201906011','331','','','201906011',dbo.fn_GetTimedKey(),NULL,'us3mLaSIM1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\SIMV\EmployeeHistoryExport\EMMSIM1004_COMP_0712.txt',NULL,'','','',NULL,NULL,NULL,'Compensation Export','201907101','EMPEXPORT','COMP','Jul 12 2019  4:11PM','EMMSIM1004',NULL,NULL,NULL,'201907101','Jul 10 2019 12:00AM','Dec 30 1899 12:00AM','201903011','297','','','201903011',dbo.fn_GetTimedKey(),NULL,'us3mLaSIM1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\SIMV\EmployeeHistoryExport\EMMSIM1004_TESTCOMP_071519.txt',NULL,'','','',NULL,NULL,NULL,'Test Compensation Export','201907159','EMPEXPORT','TEST_COMP','Jul 15 2019  8:57AM','EMMSIM1004',NULL,NULL,NULL,'201907159','Jul 15 2019 12:00AM','Dec 30 1899 12:00AM','201907081','299','','','201907081',dbo.fn_GetTimedKey(),NULL,'us3lKiSIM1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\SIMV\EmployeeHistoryExport\EMMSIM1004_TESTCONT_071519.txt',NULL,'','','',NULL,NULL,NULL,'Test Contribution Loans Export','201907119','EMPEXPORT','TEST_CONT','Jul 15 2019  8:57AM','EMMSIM1004',NULL,NULL,NULL,'201907119','Jul 11 2019 12:00AM','Dec 30 1899 12:00AM','201907111','518','','','201907111',dbo.fn_GetTimedKey(),NULL,'us3lKiSIM1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\SIMV\EmployeeHistoryExport\EMMSIM1004_TESTDEMO_071519.txt',NULL,'','','',NULL,NULL,NULL,'Test Demographics Export','201907151','EMPEXPORT','TEST_DEMO','Jul 15 2019  8:57AM','EMMSIM1004',NULL,NULL,NULL,'201907151','Jul 15 2019 12:00AM','Dec 30 1899 12:00AM','201907081','330','','','201907081',dbo.fn_GetTimedKey(),NULL,'us3lKiSIM1004',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMSIM1004','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMSIM1004','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMSIM1004','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMSIM1004','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMSIM1004','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMSIM1004','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' WHERE FormatCode = 'EMMSIM1004' AND CfgName = 'ExportPath' AND CfgValue IS NULL;
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EMMSIM1004_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EMMSIM1004_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMMSIM1004_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','CONTRIB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','CONTRIB','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','CONTRIB','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','CONTRIB','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','CONTRIB','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','CONTRIB','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_CONT','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_CONT','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_CONT','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_CONT','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_CONT','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_CONT','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMSIM1004','TEST_COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','H01','dbo.U_EMMSIM1004_Header','drvfiletype = ''DEMO''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','H20','dbo.U_EMMSIM1004_Header','drvfiletype = ''CONT''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','H40','dbo.U_EMMSIM1004_Header','drvfiletype = ''COMP''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','D10','dbo.U_EMMSIM1004_Demo_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','D25','dbo.U_EMMSIM1004_Cont_drvTbl','drvContributionSource <> ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','D30','dbo.U_EMMSIM1004_Cont_drvTbl','drvContributionSource = ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','D45','dbo.U_EMMSIM1004_Comp_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','T15','dbo.U_EMMSIM1004_Demo_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','T35','dbo.U_EMMSIM1004_Cont_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMSIM1004','T50','dbo.U_EMMSIM1004_Comp_Trailer',NULL);
IF OBJECT_ID('U_EMMSIM1004_Comp_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Comp_drvTbl] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEIN] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvPayDate] varchar(8) NULL,
    [drvEffectiveStartDate] varchar(8) NULL,
    [drvPeriodEndDate] datetime NULL,
    [drvContribSalary] money NULL,
    [drv415Salary] money NULL,
    [drvADPSalary] money NULL,
    [drvHoursWorked] decimal NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMSIM1004_Comp_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Comp_Trailer] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvDetailCount] int NULL,
    [drvCompRecords] int NULL,
    [drvSalaryContribTotal] money NULL,
    [drv415SalaryTotal] money NULL,
    [drvADPSalaryTotal] money NULL,
    [drvTotalHours] decimal NULL
);
IF OBJECT_ID('U_EMMSIM1004_Cont_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Cont_drvTbl] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEIN] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvPayrollDate] varchar(8) NULL,
    [drvPeriodStart] datetime NULL,
    [drvPeriodEnd] datetime NULL,
    [drvContributionSource] varchar(5) NULL,
    [drvContributionAmount] varchar(31) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMSIM1004_Cont_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Cont_Trailer] (
    [drvDetailCount] int NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvContributionRecords] int NULL,
    [drvContributionAmount] bigint NULL,
    [drvLoanRecords] int NULL,
    [drvLoanAmount] bigint NULL
);
IF OBJECT_ID('U_EMMSIM1004_Demo_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Demo_drvTbl] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEIN] char(9) NULL,
    [drvLocation] varchar(8) NOT NULL,
    [drvSubSetCode] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNamePrefix] varchar(30) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressEmail] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvEmploymentClass] varchar(1) NOT NULL,
    [drvEmploymentStatus] varchar(1) NULL,
    [drvEmpStatusChangeDate] datetime NULL,
    [drvPayrollStatus] char(1) NULL,
    [drvPayFrequency] varchar(2) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvFileType] varchar(4) NOT NULL,
    [drvPayGroup] char(6) NULL
);
IF OBJECT_ID('U_EMMSIM1004_Demo_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Demo_Trailer] (
    [drvDetailCount] int NULL,
    [drvContractNumber] varchar(6) NOT NULL
);
IF OBJECT_ID('U_EMMSIM1004_EEList') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMMSIM1004_File') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EMMSIM1004_HdrRecords') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_HdrRecords] (
    [Header_Type] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMSIM1004_Header') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_Header] (
    [drvContractNumber] varchar(10) NULL,
    [drvFileDescription] varchar(24) NULL,
    [drvTransmissionDate] datetime NOT NULL,
    [drvActTransmissionDate] datetime NOT NULL,
    [drvActTransmissionTime] varchar(4) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMSIM1004_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EMMSIM1004_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [Peh415TestingComp] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL
);
IF OBJECT_ID('U_EMMSIM1004_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EMMSIM1004_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWagesYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMMSIM1004]

    @SystemID CHAR(12)

AS

SET NOCOUNT ON;

/**********************************************************************************

Client Name: SimVentions, Inc.



Created By: Marco Lagrosa

Business Analyst: Lea King

Create Date: 07/10/2019 

Service Request Number: SR-2019-00240979



Purpose: To send employee information to Mass Mutual for plan administration.



Revision History

----------------

Update By            Date            Request Num                Desc        





SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMMSIM1004';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMMSIM1004';

SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMMSIM1004';

SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMMSIM1004';

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMMSIM1004' ORDER BY DateTimeCompleted DESC;



Execute Export

--------------

--Demographics --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMSIM1004', 'DEMO';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMSIM1004', 'TEST_DEMO';



--Compensation --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMSIM1004', 'COMP';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMSIM1004', 'TEST_COMP';



--Contributions and Loans --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMSIM1004', 'CONTRIB';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMSIM1004', 'TEST_CONT';



EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMMSIM1004', @AllObjects = 'Y'



**********************************************************************************/

BEGIN



    --==========================================

    -- Declare variables

    --==========================================

    DECLARE @FormatCode VARCHAR(10)

        ,@ExportCode VARCHAR(10)

        ,@StartDate DATETIME

        ,@EndDate DATETIME

        ,@StartPerControl VARCHAR(9)

        ,@EndPerControl VARCHAR(9)

        ,@MasterContractNum VARCHAR(10)

        ,@TotalFileRecords INT;



    SET @Formatcode = 'EMMSIM1004'

    SET @MasterContractNum = '083308'

    

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

    DELETE FROM dbo.U_EMMSIM1004_EEList

    WHERE xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)

    AND xEEID IN (SELECT xEEID FROM dbo.U_EMMSIM1004_EEList GROUP BY xEEID HAVING Count(*) > 1 );

 

    --Delete Employees with invalid SSN 999999999

    DELETE dbo.U_EMMSIM1004_EEList

    FROM dbo.U_EMMSIM1004_EEList

    INNER JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID

        AND EepSSN = '999999999';



    --==========================================

    -- Build Employee Data and the driver tables

    --==========================================

    -----------------------------

    -- Working Table - PDedHist

    -----------------------------

    IF OBJECT_ID('U_EMMSIM1004_PDedHist') IS NOT NULL

        DROP TABLE dbo.U_EMMSIM1004_PDedHist;


    SELECT DISTINCT

         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CP','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('401RC','401RO') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L','401L2') THEN 'PLAN1' 

                            WHEN PdhDedCode IN ('401ER') THEN 'SFMAT' 

                        END

        ,PdhEECurAmt = SUM(PdhEECurAmt)

        ,PdhERCurAmt = SUM(PdhERCurAmt)

    INTO dbo.U_EMMSIM1004_PDedHist

    FROM dbo.PDedHist WITH (NOLOCK)

    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('401CP','401ER','401P','401RC','401RO','401L','401L2')

    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401CP','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('401RC','401RO') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L','401L2') THEN 'PLAN1' 

                            WHEN PdhDedCode IN ('401ER') THEN 'SFMAT' 

                        END

    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);



    ------------------------------------

    -- Working Table - PEarHist (YTD)

    ------------------------------------

    IF OBJECT_ID('U_EMMSIM1004_PEarHist') IS NOT NULL

        DROP TABLE dbo.U_EMMSIM1004_PEarHist;

    SELECT DISTINCT

         PehEEID

        ,PehCurAmtYTD        = SUM(PehCurAmt)

        ,PehCurHrsYTD        = SUM(PehCurHrs)

        ,Peh415TestingComp   = SUM(CASE WHEN ErnInclInMiscEarn1 = 'Y' THEN PehCurAmt END)

        ,PehInclInDefComp    = SUM(CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt END)

        ,PehInclInDefCompHrs = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurHrs END)

    INTO dbo.U_EMMSIM1004_PEarHist

    FROM dbo.PEarHist WITH (NOLOCK)

    INNER JOIN dbo.EarnCode WITH (NOLOCK)

        ON PehEarnCode = ErnEarnCode

    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)

    AND PehPerControl <= @EndPerControl   

    AND ErnEarnCode in ('B','BRV','ET','GF','HC','HOL','JUR','LTD','MI','OT','RB','REG','STD')
    GROUP BY PehEEID;



    -----------------------------

    -- Working Table - PTaxHist

    -----------------------------

    IF OBJECT_ID('U_EMMSIM1004_PTaxHist') IS NOT NULL

        DROP TABLE dbo.U_EMMSIM1004_PTaxHist;

    SELECT DISTINCT

         PthEEID

        ,PthGrossWagesYTD    = SUM(PthCurGrossWages)       

    INTO dbo.U_EMMSIM1004_PTaxHist

    FROM dbo.PTaxHist WITH (NOLOCK)

    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)

    AND PthPerControl <= @EndPerControl

    AND PthTaxCode = 'USFIT'

    GROUP BY PthEEID

    HAVING SUM(PthCurGrossWages) <> 0.00;



    ---------------------------------

    -- HEADER RECORD - Multiple Headers are included in the file

    ---------------------------------

    IF OBJECT_ID('U_EMMSIM1004_HdrRecords') IS NOT NULL

        DROP TABLE dbo.U_EMMSIM1004_HdrRecords;

    SELECT 'DEMO' AS Header_Type --Demographics

    INTO dbo.U_EMMSIM1004_HdrRecords

  

    UNION

    

    SELECT 'CONT' --Contribution and Loans

    

    UNION

    

    SELECT 'COMP'; --Compensation



    IF OBJECT_ID('U_EMMSIM1004_Header') IS NOT NULL

        DROP TABLE dbo.U_EMMSIM1004_Header;

    SELECT DISTINCT

         drvContractNumber        = @MasterContractNum

        ,drvFileDescription     = CASE WHEN Header_Type = 'DEMO' THEN 'SimVentions Demo File'

                                       WHEN Header_Type = 'CONT' THEN 'SimVentions Contrib File'

                                       WHEN Header_Type = 'COMP' THEN 'SimVentions Comp File'

                                  END

        ,drvTransmissionDate    = GETDATE()

        ,drvActTransmissionDate = GETDATE()

        ,drvActTransmissionTime = LEFT(REPLACE(CONVERT(VARCHAR,GETDATE(),108),':',''),4)

        ,drvFileType            = Header_Type 

    INTO dbo.U_EMMSIM1004_Header

    FROM dbo.U_EMMSIM1004_HdrRecords;



    ---------------------------------

    -- DETAIL RECORD - Demographics Data

    ---------------------------------

    IF @ExportCode LIKE '%DEMO' 

    BEGIN

        IF OBJECT_ID('U_EMMSIM1004_Demo_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMMSIM1004_Demo_drvTbl;



        SELECT DISTINCT

             drvContractNumber        = '083308'

            ,drvEIN                 = CmpFedTaxID

            ,drvLocation            = '        '

            ,drvSubSetCode          = '1'

            ,drvSSN                 = EepSSN

            ,drvNameFirst           = EepNameFirst

            ,drvNamePrefix          = NULLIF(EepNamePrefix,'Z')

            ,drvNameMiddle          = LEFT(EepNameMiddle,1)

            ,drvNameLast            = EepNameLast

            ,drvNameSuffix          = NULLIF(EepNameSuffix,'Z')

            ,drvAddressLine1        = EepAddressLine1

            ,drvAddressLine2        = EepAddressLine2

            ,drvCity                = EepAddressCity

            ,drvState               = EepAddressState

            ,drvZipCode             = EepAddressZipCode

            ,drvCountry                = 'US'

            ,drvPhoneHomeNumber     = ' ' -- Blank

            ,drvAddressEmail        = ' ' -- Blank

            ,drvDateOfBirth         = EepDateOfBirth

            ,drvDateOfOriginalHire  = EecDateOfOriginalHire

            ,drvGender              = EepGender

            ,drvMaritalStatus       = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END

            ,drvEmploymentClass     = CASE WHEN eecdedgroupcode in ('FT','REG','PT','PTC') THEN 'Y' ELSE 'N' END

            ,drvEmploymentStatus    = CASE WHEN EecEmplStatus = 'T' THEN

                                            CASE WHEN EecTermReason = '203' THEN 'D'

                                                 WHEN EecTermReason IN ('202','213') THEN 'R'

                                                 ELSE 'T'

                                            END

                                            ELSE EecEmplStatus

                                      END

            ,drvEmpStatusChangeDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 

                                           WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate

                                           WHEN EecEmplStatus IN ('A','S') AND EecEmplStatusStartDate >= EecDateOfLastHire THEN EecEmplStatusStartDate

                                           WHEN EecEmplStatus IN ('A','S') AND EecDateOfOriginalHire <> EecDateOfLastHire AND (EecHireSource = 'REHIRE' OR EecJobChangeReason = '101') THEN EecDateOfLastHire

                                           ELSE EecDateOfLastHire

                                       END

            ,drvPayrollStatus        = EecFullTimeOrPartTime

            ,drvPayFrequency        = CASE WHEN EecPayPeriod = 'B' THEN '26'

                                           WHEN EecPayPeriod = 'W' THEN '52'

                                           WHEN EecPayPeriod = 'S' THEN '24'

                                           WHEN EecPayPeriod = 'M' THEN '12'

                                      END



            ,drvEEID = xEEID

            ,drvCoID = xCoID

            ,drvInitialSort = eepSSN

            ,drvFileType = 'DEMO'

            ,drvPayGroup = EecPayGroup

        INTO dbo.U_EMMSIM1004_Demo_drvTbl

        FROM dbo.U_EMMSIM1004_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        LEFT JOIN dbo.Company WITH (NOLOCK)

            ON CmpCOID = xCOID

        ;



        --Exclude Employees whose Term Date is not in last 12 months And Doesn't have any YTD compensation or Contribution

        DELETE dbo.U_EMMSIM1004_Demo_drvTbl

        WHERE drvEmploymentStatus IN ('T','D','R') AND drvEmpStatusChangeDate < DATEADD(MM, - 12, @EndDate)

        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMMSIM1004_PEarHist WITH (NOLOCK) WHERE PehEEID = drvEEID)

        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMMSIM1004_PDedHist WITH (NOLOCK) WHERE PdhEEID = drvEEID);



        ---------------------------------

        -- TRAILER RECORD - Demographics Data

        ---------------------------------

        IF OBJECT_ID('U_EMMSIM1004_Demo_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMMSIM1004_Demo_Trailer;

        SELECT DISTINCT drvDetailCount     = COUNT(*)

                ,drvContractNumber        = '083308'

        INTO dbo.U_EMMSIM1004_Demo_Trailer

        FROM dbo.U_EMMSIM1004_Demo_drvTbl;



        SELECT @TotalFileRecords = drvDetailCount

        FROM dbo.U_EMMSIM1004_Demo_Trailer;



    END

    

    IF @ExportCode LIKE '%CONT%' 

    BEGIN

        ---------------------------------

        -- DETAIL RECORD - Contributions and Loans

        ---------------------------------

        IF OBJECT_ID('U_EMMSIM1004_Cont_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMMSIM1004_Cont_drvTbl;

        SELECT DISTINCT

             drvContractNumber        = '083308'

            ,drvEIN                 = CmpFedTaxID

            ,drvSSN                 = EepSSN             

            ,drvPayrollDate         = PrgPayDate

            ,drvPeriodStart         = PrgPeriodStart

            ,drvPeriodEnd           = PrgPeriodEnd

            ,drvContributionSource  = PdhSource

            -- Remove the 

            ,drvContributionAmount  = CASE WHEN pdhSource = 'SFMAT' THEN
            
                                        CASE WHEN PdhERCurAmt >= 0 THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhERCurAmt*100,12,0)) 

                                           ELSE '-'+CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhERCurAmt*-1*100,11,0)) 

                                       END
                                     ELSE 
                                         CASE WHEN PdhEECurAmt >= 0 THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*100,12,0)) 

                                           ELSE '-'+CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*-1*100,11,0)) 

                                       END
                                     END 

            ,drvEEID = xEEID

            ,drvCoID = xCOID

            ,drvInitialSort = EepSSN

            ,drvFileType = 'CONT'

        INTO dbo.U_EMMSIM1004_Cont_drvTbl

        FROM dbo.U_EMMSIM1004_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        INNER JOIN dbo.U_EMMSIM1004_PDedHist WITH (NOLOCK)

            ON PdhEEID = xEEID 

        LEFT JOIN dbo.Company WITH (NOLOCK)

            ON CmpCOID = xCOID

        LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PrgPayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 

                   FROM dbo.PgPayPer WITH (NOLOCK)

                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 

                   AND PgpPeriodType = 'R'

                   GROUP BY PgpPayGroup

        ) Prg

            ON EecPayGroup = PgpPayGroup

        ;

        ---------------------------------

        -- TRAILER RECORD - Contributions and Loans

        ---------------------------------

        IF OBJECT_ID('U_EMMSIM1004_Cont_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMMSIM1004_Cont_Trailer;

        SELECT DISTINCT

             drvDetailCount         = COUNT(*)

            ,drvContractNumber        = '083308'

            ,drvContributionRecords = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN 1 ELSE 0 END)

            ,drvContributionAmount  = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)

            ,drvLoanRecords         = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN 1 ELSE 0 END)

            ,drvLoanAmount          = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)

        INTO dbo.U_EMMSIM1004_Cont_Trailer

        FROM dbo.U_EMMSIM1004_Cont_drvTbl;



        SELECT @TotalFileRecords = @TotalFileRecords + drvDetailCount

        FROM dbo.U_EMMSIM1004_Cont_Trailer;

    END



    IF @ExportCode LIKE '%COMP'

    BEGIN

        ---------------------------------

        -- DETAIL RECORD - Compensation Record

        ---------------------------------

        IF OBJECT_ID('U_EMMSIM1004_Comp_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMMSIM1004_Comp_drvTbl;

        SELECT DISTINCT

             drvContractNumber        = '083308'

            ,drvEIN                 = CmpFedTaxID

            ,drvSSN                 = EepSSN

            ,drvPayDate             = PayDate

            ,drvEffectiveStartDate  = LEFT(@EndPerControl,4)+'0101'

            ,drvPeriodEndDate       = PrgPeriodEnd

            ,drvContribSalary       = PehInclInDefComp

            ,drv415Salary           = PthGrossWagesYTD

            ,drvADPSalary           = PehInclInDefComp

            ,drvHoursWorked         = PehInclInDefCompHrs

            ,drvEEID = xEEID

            ,drvCoID = xCOID

            ,drvInitialSort = EepSSN

            ,drvFileType = 'COMP'

        INTO dbo.U_EMMSIM1004_Comp_drvTbl

        FROM dbo.U_EMMSIM1004_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        LEFT JOIN dbo.U_EMMSIM1004_PEarHist WITH (NOLOCK)

            ON PehEEID = xEEID

        LEFT JOIN dbo.U_EMMSIM1004_PTaxHist WITH (NOLOCK)

            ON PthEEID = xEEID

        LEFT JOIN dbo.Company WITH (NOLOCK)

            ON CmpCOID = xCOID

        LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 

                   FROM dbo.PgPayPer WITH (NOLOCK)

                   WHERE PgpPeriodControl <= @EndPerControl 

                   AND PgpPeriodType = 'R'

                GROUP BY PgpPayGroup

        ) Prg

            ON EecPayGroup = PgpPayGroup 

        WHERE PehEEID IS NOT NULL

        AND (PehInclInDefComp <> 0 OR PthGrossWagesYTD <> 0 OR PehInclInDefCompHrs <> 0);



        ---------------------------------

        -- TRAILER RECORD - Compensation Record

        ---------------------------------

        IF OBJECT_ID('U_EMMSIM1004_Comp_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMMSIM1004_Comp_Trailer;

        SELECT DISTINCT

             drvContractNumber        = '083308'

            ,drvDetailCount         = COUNT(*)

            ,drvCompRecords         = COUNT(*)

            ,drvSalaryContribTotal  = SUM(drvContribSalary)

            ,drv415SalaryTotal      = SUM(drv415Salary)

            ,drvADPSalaryTotal      = SUM(drvADPSalary)

            ,drvTotalHours          = SUM(ROUND(drvhoursworked,0))

        INTO dbo.U_EMMSIM1004_Comp_Trailer

        FROM dbo.U_EMMSIM1004_Comp_drvTbl;

    END



    --==========================================

    -- Set FileName

    --==========================================

    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')

    BEGIN

        UPDATE dbo.U_dsi_Parameters

        SET ExportFile = '083308' + 

                         CASE WHEN @ExportCode LIKE '%DEMO%' THEN 'demo' 

                              WHEN @ExportCode LIKE '%CONT%' THEN 'cont' 

                              WHEN @ExportCode LIKE '%COMP%' THEN 'comp'  

                         END +

                         CASE WHEN @ExportCode LIKE 'TEST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'test_' ELSE '_' END + 

                         CONVERT(VARCHAR,GetDate(),112) +

                         '.asc'

        WHERE FormatCode = @FormatCode;

    END;



END;

/**********************************************************************************



--Alter the View

ALTER VIEW dbo.dsi_vwEMMSIM1004_Export AS

    SELECT TOP 200000000 Data FROM dbo.U_EMMSIM1004_File WITH (NOLOCK)

    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO



--Check out AscDefF

SELECT * FROM dbo.AscDefF

WHERE AdfHeaderSystemID LIKE 'EMMSIM1004%'

ORDER BY AdfSetNumber, AdfFieldNumber;



--Update Dates

UPDATE dbo.AscExp

    SET ExpLastStartPerControl = '201810011'

       ,ExpStartPerControl     = '201810011'

       ,ExpLastEndPerControl   = '201810019'

       ,ExpEndPerControl       = '201810019'

WHERE ExpFormatCode = 'EMMSIM1004';



**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMMSIM1004_Export AS  
    SELECT TOP 200000000 Data FROM dbo.U_EMMSIM1004_File WITH (NOLOCK) 
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort 