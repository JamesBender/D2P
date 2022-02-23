SET NOCOUNT ON;
IF OBJECT_ID('U_EMMDEMAFEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMMDEMAFEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMMDEMAFEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMMDEMAFEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMMDEMAFEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMMDEMAFEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMMDEMAFEX];
GO
IF OBJECT_ID('U_EMMDEMAFEX_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_PTaxHist];
GO
IF OBJECT_ID('U_EMMDEMAFEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_PEarHist];
GO
IF OBJECT_ID('U_EMMDEMAFEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_PDedHist];
GO
IF OBJECT_ID('U_EMMDEMAFEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_Header];
GO
IF OBJECT_ID('U_EMMDEMAFEX_HdrRecords') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_HdrRecords];
GO
IF OBJECT_ID('U_EMMDEMAFEX_File') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_File];
GO
IF OBJECT_ID('U_EMMDEMAFEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_EEList];
GO
IF OBJECT_ID('U_EMMDEMAFEX_Demo_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_Demo_Trailer];
GO
IF OBJECT_ID('U_EMMDEMAFEX_Demo_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_Demo_drvTbl];
GO
IF OBJECT_ID('U_EMMDEMAFEX_Comp_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_Comp_Trailer];
GO
IF OBJECT_ID('U_EMMDEMAFEX_Comp_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_Comp_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMMDEMAFEX';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EMMDEMAFEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMMDEMAFEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMMDEMAFEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMMDEMAFEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMMDEMAFEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMMDEMAFEX','Mass Mutual 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMMDEMAFEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','H','01','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','H','01','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMDEMAFEXZ0','30','H','01','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMDEMAFEXZ0','8','H','01','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMDEMAFEXZ0','8','H','01','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMDEMAFEXZ0','4','H','01','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMDEMAFEXZ0','2','H','01','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','H','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','H','20','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','H','20','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMDEMAFEXZ0','30','H','20','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMDEMAFEXZ0','8','H','20','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMDEMAFEXZ0','8','H','20','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMDEMAFEXZ0','4','H','20','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMDEMAFEXZ0','2','H','20','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','H','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','H','40','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','H','40','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMDEMAFEXZ0','30','H','40','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMDEMAFEXZ0','8','H','40','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMDEMAFEXZ0','8','H','40','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMDEMAFEXZ0','4','H','40','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMDEMAFEXZ0','2','H','40','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEMO"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','D','10','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','D','10','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','4','(''UA''=''F'')','EMMDEMAFEXZ0','12','D','10','15',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','5','(''UA''=''F'')','EMMDEMAFEXZ0','8','D','10','27',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsetCode"','6','(''UA''=''F'')','EMMDEMAFEXZ0','12','D','10','35',NULL,'Subset Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','7','(''UA''=''F'')','EMMDEMAFEXZ0','9','D','10','47',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','8','(''UA''=''F'')','EMMDEMAFEXZ0','4','D','10','56',NULL,'Prefix Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','9','(''UA''=''F'')','EMMDEMAFEXZ0','15','D','10','60',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','10','(''UA''=''F'')','EMMDEMAFEXZ0','10','D','10','75',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','11','(''UA''=''F'')','EMMDEMAFEXZ0','20','D','10','85',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','12','(''UA''=''F'')','EMMDEMAFEXZ0','8','D','10','105',NULL,'Suffix Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''F'')','EMMDEMAFEXZ0','35','D','10','113',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''F'')','EMMDEMAFEXZ0','35','D','10','148',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EMMDEMAFEXZ0','35','D','10','183',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','16','(''UA''=''F'')','EMMDEMAFEXZ0','35','D','10','218',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','17','(''UA''=''F'')','EMMDEMAFEXZ0','2','D','10','253',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','18','(''UA''=''F'')','EMMDEMAFEXZ0','10','D','10','255',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','19','(''UA''=''F'')','EMMDEMAFEXZ0','2','D','10','265',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','20','(''UA''=''F'')','EMMDEMAFEXZ0','12','D','10','267',NULL,'Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','EMMDEMAFEXZ0','12','D','10','279',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','22','(''UA''=''F'')','EMMDEMAFEXZ0','35','D','10','291',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','23','(''UD112''=''F'')','EMMDEMAFEXZ0','8','D','10','326',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','24','(''UD112''=''F'')','EMMDEMAFEXZ0','8','D','10','334',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','25','(''UA''=''F'')','EMMDEMAFEXZ0','1','D','10','342',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','26','(''DA''=''F'')','EMMDEMAFEXZ0','2','D','10','343',NULL,'Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','27','(''UA''=''F'')','EMMDEMAFEXZ0','1','D','10','345',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentClass"','28','(''UA''=''F'')','EMMDEMAFEXZ0','8','D','10','346',NULL,'Employment Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','29','(''UA''=''F'')','EMMDEMAFEXZ0','8','D','10','354',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusChangeDate"','30','(''UD112''=''F'')','EMMDEMAFEXZ0','8','D','10','362',NULL,'Employment Status Changed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''F'')','EMMDEMAFEXZ0','1','D','10','370',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''F'')','EMMDEMAFEXZ0','1','D','10','371',NULL,'16B Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatus"','33','(''UA''=''F'')','EMMDEMAFEXZ0','1','D','10','372',NULL,'Payroll Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','34','(''UA''=''F'')','EMMDEMAFEXZ0','2','D','10','373',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMP"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','D','45','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','D','45','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','D','45','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','4','(''UA''=''F'')','EMMDEMAFEXZ0','12','D','45','15',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''F'')','EMMDEMAFEXZ0','9','D','45','27',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','6','(''UD112''=''F'')','EMMDEMAFEXZ0','8','D','45','36',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveStartDate"','7','(''UA''=''F'')','EMMDEMAFEXZ0','8','D','45','44',NULL,'Effective Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEndDate"','8','(''UD112''=''F'')','EMMDEMAFEXZ0','8','D','45','52',NULL,'Effective Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSalary"','9','(''UNP2''=''F'')','EMMDEMAFEXZ0','12','D','45','60',NULL,'Salary for Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415Salary"','10','(''UNP2''=''F'')','EMMDEMAFEXZ0','12','D','45','72',NULL,'Salary for 415 Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPSalary"','11','(''UNP2''=''F'')','EMMDEMAFEXZ0','12','D','45','84',NULL,'Salary for ADP Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','12','(''UN0''=''F'')','EMMDEMAFEXZ0','4','D','45','96',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMTR"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','T','15','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','T','15','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','T','15','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','15','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CNTR"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','T','35','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','T','35','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','T','35','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','35','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionRecords"','5','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','35','27',NULL,'Total Contribution Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','6','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','35','39',NULL,'Total Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRecords"','7','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','35','51',NULL,'Total Loan Repayment Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmount"','8','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','35','63',NULL,'Total Loan Repayment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CPTR"','1','(''DA''=''F'')','EMMDEMAFEXZ0','4','T','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMDEMAFEXZ0','4','T','50','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMDEMAFEXZ0','6','T','50','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','50','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompRecords"','5','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','50','27',NULL,'Total Salary for Compensation Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryContribTotal"','6','(''UNP2''=''F'')','EMMDEMAFEXZ0','12','T','50','39',NULL,'Total Salary for Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415SalaryTotal"','7','(''UNP2''=''F'')','EMMDEMAFEXZ0','12','T','50','51',NULL,'Total Salary for 415 Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPSalaryTotal"','8','(''UNP2''=''F'')','EMMDEMAFEXZ0','12','T','50','63',NULL,'Total Salary for ADP Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalHours"','9','(''UN0''=''F'')','EMMDEMAFEXZ0','12','T','50','75',NULL,'Total Hours Worked',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMMDEMAFEX_20191120.txt',NULL,'','','',NULL,NULL,NULL,'Test Compensation Export','201907249','EMPEXPORT','TEST_COMP','Jul 24 2019 12:52PM','EMMDEMAFEX',NULL,NULL,NULL,'201907249','Jul 24 2019 12:00AM','Dec 30 1899 12:00AM','201907101','299','','','201907101',dbo.fn_GetTimedKey(),NULL,'',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMMDEMAFEX_20191120.txt',NULL,'','','',NULL,NULL,NULL,'Test Demographics Export','201909189','EMPEXPORT','TEST_DEMO','Sep 18 2019 11:42AM','EMMDEMAFEX',NULL,NULL,NULL,'201909189','Sep 18 2019 12:00AM','Dec 30 1899 12:00AM','201909041','323','','','201909041',dbo.fn_GetTimedKey(),NULL,'',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMMDEMAFEX_20191120.txt',NULL,'Null','N','K4AZ9,TJ5U3,VN2OZ,Z6AGR,NQMWG,Q61KR,WF8AR,KS7ZU,TJ5OR,TJ66X,Z69NN,K4B39,VHOPW,VHOLS,QWK37,TJ61X,QHOI0,Q5CD6,T2WZT',NULL,NULL,NULL,'Mass Mutual 401k Comp-Tues410p','201911129','EMPEXPORT','COMP','Nov 20 2019  3:38PM','EMMDEMAFEX',NULL,NULL,NULL,'201911129','Nov 12 2019 12:00AM','Dec 30 1899 12:00AM','201911051','190','','','201911051',dbo.fn_GetTimedKey(),NULL,'us3mLaASS1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMMDEMAFEX_20191120.txt',NULL,'Null','N','K4AZ9,TJ5U3,VN2OZ,Z6AGR,NQMWG,Q61KR,WF8AR,KS7ZU,TJ5OR,TJ66X,Z69NN,K4B39,VHOPW,VHOLS,QWK37,TJ61X,QHOI0,Q5CD6,T2WZT',NULL,NULL,NULL,'Mass Mutual 401k Demo-Tues4pm','201911129','EMPEXPORT','DEMO','Nov 20 2019  3:39PM','EMMDEMAFEX',NULL,NULL,NULL,'201911129','Nov 12 2019 12:00AM','Dec 30 1899 12:00AM','201911051','1321','','','201911051',dbo.fn_GetTimedKey(),NULL,'us3mLaASS1010',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMMDEMAFEX_20191120.txt' END WHERE expFormatCode = 'EMMDEMAFEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMDEMAFEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMDEMAFEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMDEMAFEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMDEMAFEX','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMDEMAFEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMDEMAFEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMMDEMAFEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMMDEMAFEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMMDEMAFEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMMDEMAFEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMDEMAFEX','TEST_COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMDEMAFEX','H01','dbo.U_EMMDEMAFEX_Header','drvfiletype = ''DEMO''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMDEMAFEX','H40','dbo.U_EMMDEMAFEX_Header','drvfiletype = ''COMP''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMDEMAFEX','D10','dbo.U_EMMDEMAFEX_Demo_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMDEMAFEX','D45','dbo.U_EMMDEMAFEX_Comp_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMDEMAFEX','T15','dbo.U_EMMDEMAFEX_Demo_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMDEMAFEX','T50','dbo.U_EMMDEMAFEX_Comp_Trailer',NULL);
IF OBJECT_ID('U_EMMDEMAFEX_Comp_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_Comp_drvTbl] (
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
IF OBJECT_ID('U_EMMDEMAFEX_Comp_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_Comp_Trailer] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvDetailCount] int NULL,
    [drvCompRecords] int NULL,
    [drvSalaryContribTotal] money NULL,
    [drv415SalaryTotal] money NULL,
    [drvADPSalaryTotal] money NULL,
    [drvTotalHours] decimal NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_Demo_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_Demo_drvTbl] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEIN] varchar(9) NOT NULL,
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
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvAddressEmail] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvGender] char(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvEmploymentClass] varchar(1) NOT NULL,
    [drvEmploymentStatus] varchar(8) NULL,
    [drvEmpStatusChangeDate] datetime NULL,
    [drvPayrollStatus] char(1) NULL,
    [drvPayFrequency] varchar(2) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvFileType] varchar(4) NOT NULL,
    [drvPayGroup] char(6) NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_Demo_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_Demo_Trailer] (
    [drvDetailCount] int NULL,
    [drvContractNumber] varchar(6) NOT NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_File') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_HdrRecords') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_HdrRecords] (
    [Header_Type] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_Header') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_Header] (
    [drvContractNumber] varchar(10) NULL,
    [drvFileDescription] varchar(13) NULL,
    [drvTransmissionDate] datetime NOT NULL,
    [drvActTransmissionDate] datetime NOT NULL,
    [drvActTransmissionTime] varchar(4) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [Peh415TestingComp] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL
);
IF OBJECT_ID('U_EMMDEMAFEX_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EMMDEMAFEX_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWagesYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMMDEMAFEX]

    @SystemID CHAR(12)

AS

SET NOCOUNT ON;

/**********************************************************************************

Client Name: Associated Foreign Exchange



Created By: Marco Lagrosa

Business Analyst: Lea King

Create Date: 11/20/2019 

Service Request Number: TekP-2019-10-16-0001



Purpose: To send employee information to Mass Mutual for plan administration.



Revision History

----------------

Update By            Date            Request Num                Desc        





SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMMDEMAFEX';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMMDEMAFEX';

SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMMDEMAFEX';

SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMMDEMAFEX';

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMMDEMAFEX' ORDER BY DateTimeCompleted DESC;



Execute Export

--------------

--Demographics --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMDEMAFEX', 'DEMO';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMDEMAFEX', 'TEST_DEMO';



--Compensation --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMDEMAFEX', 'COMP';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMDEMAFEX', 'TEST_COMP';




EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMMDEMAFEX', @AllObjects = 'Y', @IsWeb  = 'Y'



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



    SET @FormatCode = 'EMMDEMAFEX'

    SET @MasterContractNum = '063098'

    

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

    DELETE FROM dbo.U_EMMDEMAFEX_EEList

    WHERE xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)

    AND xEEID IN (SELECT xEEID FROM dbo.U_EMMDEMAFEX_EEList GROUP BY xEEID HAVING Count(*) > 1 );

 

    --Delete Employees with invalid SSN 999999999

    DELETE dbo.U_EMMDEMAFEX_EEList

    FROM dbo.U_EMMDEMAFEX_EEList

    INNER JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID

        AND EepSSN = '999999999';


     --Delete Employees EecEeType of TES

    DELETE from  dbo.U_EMMDEMAFEX_EEList  where xeeid in (select distinct EEcEEid  from EmpComp where EecEEType = 'TES')



    --==========================================

    -- Build Employee Data and the driver tables

    --==========================================

    -----------------------------

    -- Working Table - PDedHist

    -----------------------------

    IF OBJECT_ID('U_EMMDEMAFEX_PDedHist') IS NOT NULL

        DROP TABLE dbo.U_EMMDEMAFEX_PDedHist;


    SELECT DISTINCT

         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CP','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('401RC','401RO') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L','401L2') THEN 'PLAN1' 

                            WHEN PdhDedCode IN ('401ER') THEN 'SFMAT' 

                        END

        ,PdhEECurAmt = SUM(PdhEECurAmt)

        ,PdhERCurAmt = SUM(PdhERCurAmt)

    INTO dbo.U_EMMDEMAFEX_PDedHist

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

    IF OBJECT_ID('U_EMMDEMAFEX_PEarHist') IS NOT NULL

        DROP TABLE dbo.U_EMMDEMAFEX_PEarHist;

    SELECT DISTINCT

         PehEEID

        ,PehCurAmtYTD        = SUM(PehCurAmt)

        ,PehCurHrsYTD        = SUM(PehCurHrs)

        ,Peh415TestingComp   = SUM(CASE WHEN ErnInclInMiscEarn1 = 'Y' THEN PehCurAmt END)

        ,PehInclInDefComp    = SUM(CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt END)

        ,PehInclInDefCompHrs = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurHrs END)

    INTO dbo.U_EMMDEMAFEX_PEarHist

    FROM dbo.PEarHist WITH (NOLOCK)

    INNER JOIN dbo.EarnCode WITH (NOLOCK)

        ON PehEarnCode = ErnEarnCode

    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)

    AND PehPerControl <= @EndPerControl   

    AND ErnEarnCode in ('BEREV', 'BONUS','COMM','DT','FLOAT', 'HOL', 'JURY', 'MBON', 'OT', 'OTH', 'OTHER','REG', 'RETHR', 'RETRO', 'SICK', 'VAC', 'VOL')

    GROUP BY PehEEID;



    -----------------------------

    -- Working Table - PTaxHist

    -----------------------------

    IF OBJECT_ID('U_EMMDEMAFEX_PTaxHist') IS NOT NULL

        DROP TABLE dbo.U_EMMDEMAFEX_PTaxHist;

    SELECT DISTINCT

         PthEEID

        ,PthGrossWagesYTD    = SUM(PthCurGrossWages)       

    INTO dbo.U_EMMDEMAFEX_PTaxHist

    FROM dbo.PTaxHist WITH (NOLOCK)

    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)

    AND PthPerControl <= @EndPerControl

    AND PthTaxCode = 'USFIT'

    GROUP BY PthEEID

    HAVING SUM(PthCurGrossWages) <> 0.00;



    ---------------------------------

    -- HEADER RECORD - Multiple Headers are included in the file

    ---------------------------------

    IF OBJECT_ID('U_EMMDEMAFEX_HdrRecords') IS NOT NULL

        DROP TABLE dbo.U_EMMDEMAFEX_HdrRecords;

    SELECT 'DEMO' AS Header_Type --Demographics

    INTO dbo.U_EMMDEMAFEX_HdrRecords

  

    UNION

    

    SELECT 'CONT' --Contribution and Loans

    

    UNION

    

    SELECT 'COMP'; --Compensation



    IF OBJECT_ID('U_EMMDEMAFEX_Header') IS NOT NULL

        DROP TABLE dbo.U_EMMDEMAFEX_Header;

    SELECT DISTINCT

         drvContractNumber        = @MasterContractNum

        ,drvFileDescription     = CASE WHEN Header_Type = 'DEMO' THEN 'CCS Demo File'


                                       WHEN Header_Type = 'COMP' THEN 'CCS Comp File'

                                  END

        ,drvTransmissionDate    = GETDATE()

        ,drvActTransmissionDate = GETDATE()

        ,drvActTransmissionTime = LEFT(REPLACE(CONVERT(VARCHAR,GETDATE(),108),':',''),4)

        ,drvFileType            = Header_Type 

    INTO dbo.U_EMMDEMAFEX_Header

    FROM dbo.U_EMMDEMAFEX_HdrRecords;



    ---------------------------------

    -- DETAIL RECORD - Demographics Data

    ---------------------------------

    IF @ExportCode LIKE '%DEMO' 

    BEGIN

        IF OBJECT_ID('U_EMMDEMAFEX_Demo_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMMDEMAFEX_Demo_drvTbl;



        SELECT DISTINCT

             drvContractNumber        = '063098'

            ,drvEIN                 = '204819436'

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

            ,drvPhoneHomeNumber     = EepPhoneHomeNumber -- Blank

            ,drvAddressEmail        = ' ' -- Blank

            ,drvDateOfBirth         = EepDateOfBirth

            ,drvDateOfOriginalHire  = EecDateOfOriginalHire

            ,drvGender              = ISNULL(EepGender,'U')

            ,drvMaritalStatus       = CASE WHEN Eepmaritalstatus = 'M' THEN 'M'
                                           WHEN Eepmaritalstatus = 'S' THEN 'S'
                                           ELSE 'U'
                                      END   

            ,drvEmploymentClass     = 'Y' --CASE WHEN eecdedgroupcode in ('FT','REG','PT','PTC') THEN 'Y' ELSE 'N' END

            ,drvEmploymentStatus    = CASE WHEN EecEmplStatus = 'T' THEN

                                            CASE WHEN EecTermReason = '203' THEN 'Deceased'

                                                 WHEN EecTermReason IN ('202') THEN 'Retired'

                                                 WHEN EecTermReason NOT IN ('202','203') THEN 'Termed'

                                            END

                                            WHEN EecEmplStatus = 'L'  THEN 'Leave'
                                            ELSE 'Active'

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

        INTO dbo.U_EMMDEMAFEX_Demo_drvTbl

        FROM dbo.U_EMMDEMAFEX_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        LEFT JOIN dbo.Company WITH (NOLOCK)

            ON CmpCOID = xCOID

        ;



        --Exclude Employees whose Term Date is not in last 12 months And Doesn't have any YTD compensation or Contribution

        DELETE dbo.U_EMMDEMAFEX_Demo_drvTbl

        WHERE drvEmploymentStatus IN ('T','D','R') AND drvEmpStatusChangeDate < DATEADD(MM, - 12, @EndDate)

        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMMDEMAFEX_PEarHist WITH (NOLOCK) WHERE PehEEID = drvEEID)

        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMMDEMAFEX_PDedHist WITH (NOLOCK) WHERE PdhEEID = drvEEID);



        ---------------------------------

        -- TRAILER RECORD - Demographics Data

        ---------------------------------

        IF OBJECT_ID('U_EMMDEMAFEX_Demo_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMMDEMAFEX_Demo_Trailer;

        SELECT DISTINCT drvDetailCount     = COUNT(*)

                ,drvContractNumber        = '063098'

        INTO dbo.U_EMMDEMAFEX_Demo_Trailer

        FROM dbo.U_EMMDEMAFEX_Demo_drvTbl;



        SELECT @TotalFileRecords = drvDetailCount

        FROM dbo.U_EMMDEMAFEX_Demo_Trailer;



    END

    


    IF @ExportCode LIKE '%COMP'

    BEGIN

        ---------------------------------

        -- DETAIL RECORD - Compensation Record

        ---------------------------------

        IF OBJECT_ID('U_EMMDEMAFEX_Comp_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMMDEMAFEX_Comp_drvTbl;

        SELECT DISTINCT

             drvContractNumber        = '063098'

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

        INTO dbo.U_EMMDEMAFEX_Comp_drvTbl

        FROM dbo.U_EMMDEMAFEX_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        LEFT JOIN dbo.U_EMMDEMAFEX_PEarHist WITH (NOLOCK)

            ON PehEEID = xEEID

        LEFT JOIN dbo.U_EMMDEMAFEX_PTaxHist WITH (NOLOCK)

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

        IF OBJECT_ID('U_EMMDEMAFEX_Comp_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMMDEMAFEX_Comp_Trailer;

        SELECT DISTINCT

             drvContractNumber        = '063098'

            ,drvDetailCount         = COUNT(*)

            ,drvCompRecords         = COUNT(*)

            ,drvSalaryContribTotal  = SUM(drvContribSalary)

            ,drv415SalaryTotal      = SUM(drv415Salary)

            ,drvADPSalaryTotal      = SUM(drvADPSalary)

            ,drvTotalHours          = SUM(ROUND(drvhoursworked,0))

        INTO dbo.U_EMMDEMAFEX_Comp_Trailer

        FROM dbo.U_EMMDEMAFEX_Comp_drvTbl;

    END



    --==========================================

    -- Set FileName

    --==========================================

    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')

    BEGIN

        UPDATE dbo.U_dsi_Parameters

        SET ExportFile = '063098' + 

                         CASE WHEN @ExportCode LIKE '%DEMO%' THEN 'demo' 

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

ALTER VIEW dbo.dsi_vwEMMDEMAFEX_Export AS

    SELECT TOP 200000000 Data FROM dbo.U_EMMDEMAFEX_File WITH (NOLOCK)

    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO



--Check out AscDefF

SELECT * FROM dbo.AscDefF

WHERE AdfHeaderSystemID LIKE 'EMMDEMAFEX%'

ORDER BY AdfSetNumber, AdfFieldNumber;



--Update Dates

UPDATE dbo.AscExp

    SET ExpLastStartPerControl = '201810011'

       ,ExpStartPerControl     = '201810011'

       ,ExpLastEndPerControl   = '201810019'

       ,ExpEndPerControl       = '201810019'

WHERE ExpFormatCode = 'EMMDEMAFEX';



**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMMDEMAFEX_Export AS  
    SELECT TOP 200000000 Data FROM dbo.U_EMMDEMAFEX_File WITH (NOLOCK) 
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort 