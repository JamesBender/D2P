SET NOCOUNT ON;
IF OBJECT_ID('U_EMASMUTUAL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMASMUTUAL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMASMUTUAL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMASMUTUAL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMASMUTUAL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMASMUTUAL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMASMUTUAL];
GO
IF OBJECT_ID('U_EMASMUTUAL_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_PTaxHist];
GO
IF OBJECT_ID('U_EMASMUTUAL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_PEarHist];
GO
IF OBJECT_ID('U_EMASMUTUAL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_PDedHist];
GO
IF OBJECT_ID('U_EMASMUTUAL_Header') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Header];
GO
IF OBJECT_ID('U_EMASMUTUAL_HdrRecords') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_HdrRecords];
GO
IF OBJECT_ID('U_EMASMUTUAL_File') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_File];
GO
IF OBJECT_ID('U_EMASMUTUAL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_EEList];
GO
IF OBJECT_ID('U_EMASMUTUAL_Demo_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Demo_Trailer];
GO
IF OBJECT_ID('U_EMASMUTUAL_Demo_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Demo_drvTbl];
GO
IF OBJECT_ID('U_EMASMUTUAL_Cont_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Cont_Trailer];
GO
IF OBJECT_ID('U_EMASMUTUAL_Cont_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Cont_drvTbl];
GO
IF OBJECT_ID('U_EMASMUTUAL_Comp_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Comp_Trailer];
GO
IF OBJECT_ID('U_EMASMUTUAL_Comp_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_Comp_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMASMUTUAL';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EMASMUTUAL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMASMUTUAL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMASMUTUAL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMASMUTUAL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMASMUTUAL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMASMUTUAL','Mass Mutual 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMASMUTUALZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMASMUTUALZ0','4','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','H','01','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','H','01','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMASMUTUALZ0','30','H','01','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMASMUTUALZ0','8','H','01','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMASMUTUALZ0','8','H','01','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMASMUTUALZ0','4','H','01','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMASMUTUALZ0','2','H','01','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMASMUTUALZ0','4','H','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','H','20','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','H','20','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMASMUTUALZ0','30','H','20','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMASMUTUALZ0','8','H','20','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMASMUTUALZ0','8','H','20','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMASMUTUALZ0','4','H','20','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMASMUTUALZ0','2','H','20','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMASMUTUALZ0','4','H','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','H','40','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','H','40','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMASMUTUALZ0','30','H','40','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMASMUTUALZ0','8','H','40','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMASMUTUALZ0','8','H','40','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMASMUTUALZ0','4','H','40','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMASMUTUALZ0','2','H','40','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEMO"','1','(''DA''=''F'')','EMASMUTUALZ0','4','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','D','10','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','D','10','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','4','(''UA''=''F'')','EMASMUTUALZ0','12','D','10','15',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','5','(''UA''=''F'')','EMASMUTUALZ0','8','D','10','27',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsetCode"','6','(''UA''=''F'')','EMASMUTUALZ0','12','D','10','35',NULL,'Subset Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','7','(''UA''=''F'')','EMASMUTUALZ0','9','D','10','47',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','8','(''UA''=''F'')','EMASMUTUALZ0','4','D','10','56',NULL,'Prefix Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','9','(''UA''=''F'')','EMASMUTUALZ0','15','D','10','60',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','10','(''UA''=''F'')','EMASMUTUALZ0','10','D','10','75',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','11','(''UA''=''F'')','EMASMUTUALZ0','20','D','10','85',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','12','(''UA''=''F'')','EMASMUTUALZ0','8','D','10','105',NULL,'Suffix Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''F'')','EMASMUTUALZ0','35','D','10','113',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''F'')','EMASMUTUALZ0','35','D','10','148',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EMASMUTUALZ0','35','D','10','183',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','16','(''UA''=''F'')','EMASMUTUALZ0','35','D','10','218',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','17','(''UA''=''F'')','EMASMUTUALZ0','2','D','10','253',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','18','(''UA''=''F'')','EMASMUTUALZ0','10','D','10','255',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','19','(''UA''=''F'')','EMASMUTUALZ0','2','D','10','265',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','20','(''UA''=''F'')','EMASMUTUALZ0','12','D','10','267',NULL,'Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','EMASMUTUALZ0','12','D','10','279',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','22','(''UA''=''F'')','EMASMUTUALZ0','35','D','10','291',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','23','(''UD112''=''F'')','EMASMUTUALZ0','8','D','10','326',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','24','(''UD112''=''F'')','EMASMUTUALZ0','8','D','10','334',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','25','(''UA''=''F'')','EMASMUTUALZ0','1','D','10','342',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','26','(''DA''=''F'')','EMASMUTUALZ0','2','D','10','343',NULL,'Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','27','(''UA''=''F'')','EMASMUTUALZ0','1','D','10','345',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentClass"','28','(''UA''=''F'')','EMASMUTUALZ0','8','D','10','346',NULL,'Employment Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','29','(''UA''=''F'')','EMASMUTUALZ0','8','D','10','354',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusChangeDate"','30','(''UD112''=''F'')','EMASMUTUALZ0','8','D','10','362',NULL,'Employment Status Changed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''F'')','EMASMUTUALZ0','1','D','10','370',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''F'')','EMASMUTUALZ0','1','D','10','371',NULL,'16B Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatus"','33','(''UA''=''F'')','EMASMUTUALZ0','1','D','10','372',NULL,'Payroll Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','34','(''UA''=''F'')','EMASMUTUALZ0','2','D','10','373',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONT"','1','(''DA''=''F'')','EMASMUTUALZ0','4','D','25','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','D','25','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','D','25','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN1"','4','(''DA''=''F'')','EMASMUTUALZ0','8','D','25','15',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','5','(''UA''=''F'')','EMASMUTUALZ0','12','D','25','23',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EMASMUTUALZ0','9','D','25','35',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','7','(''UD112''=''F'')','EMASMUTUALZ0','8','D','25','44',NULL,'Payroll Date (Effective Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodStart"','8','(''UD112''=''F'')','EMASMUTUALZ0','8','D','25','52',NULL,'Payroll Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEnd"','9','(''UD112''=''F'')','EMASMUTUALZ0','8','D','25','60',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSource"','10','(''UA''=''F'')','EMASMUTUALZ0','5','D','25','68',NULL,'Contribution Source Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','11','(''UA''=''F'')','EMASMUTUALZ0','12','D','25','73',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LNRP"','1','(''DA''=''F'')','EMASMUTUALZ0','4','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','D','30','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','D','30','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN1"','4','(''DA''=''F'')','EMASMUTUALZ0','8','D','30','15',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','5','(''UA''=''F'')','EMASMUTUALZ0','12','D','30','23',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EMASMUTUALZ0','9','D','30','35',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','7','(''UD112''=''F'')','EMASMUTUALZ0','8','D','30','44',NULL,'Payroll Date (Effective Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEnd"','8','(''UD112''=''F'')','EMASMUTUALZ0','8','D','30','52',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','9','(''UA''=''F'')','EMASMUTUALZ0','12','D','30','60',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMP"','1','(''DA''=''F'')','EMASMUTUALZ0','4','D','45','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','D','45','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','D','45','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','4','(''UA''=''F'')','EMASMUTUALZ0','12','D','45','15',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''F'')','EMASMUTUALZ0','9','D','45','27',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','6','(''UD112''=''F'')','EMASMUTUALZ0','8','D','45','36',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveStartDate"','7','(''UA''=''F'')','EMASMUTUALZ0','8','D','45','44',NULL,'Effective Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEndDate"','8','(''UD112''=''F'')','EMASMUTUALZ0','8','D','45','52',NULL,'Effective Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSalary"','9','(''UNP2''=''F'')','EMASMUTUALZ0','12','D','45','60',NULL,'Salary for Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415Salary"','10','(''UNP2''=''F'')','EMASMUTUALZ0','12','D','45','72',NULL,'Salary for 415 Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPSalary"','11','(''UNP2''=''F'')','EMASMUTUALZ0','12','D','45','84',NULL,'Salary for ADP Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','12','(''UN0''=''F'')','EMASMUTUALZ0','4','D','45','96',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMTR"','1','(''DA''=''F'')','EMASMUTUALZ0','4','T','15','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','T','15','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','T','15','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMASMUTUALZ0','12','T','15','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CNTR"','1','(''DA''=''F'')','EMASMUTUALZ0','4','T','35','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','T','35','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','T','35','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMASMUTUALZ0','12','T','35','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionRecords"','5','(''UN0''=''F'')','EMASMUTUALZ0','12','T','35','27',NULL,'Total Contribution Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','6','(''UN0''=''F'')','EMASMUTUALZ0','12','T','35','39',NULL,'Total Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRecords"','7','(''UN0''=''F'')','EMASMUTUALZ0','12','T','35','51',NULL,'Total Loan Repayment Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmount"','8','(''UN0''=''F'')','EMASMUTUALZ0','12','T','35','63',NULL,'Total Loan Repayment Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CPTR"','1','(''DA''=''F'')','EMASMUTUALZ0','4','T','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMASMUTUALZ0','4','T','50','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMASMUTUALZ0','6','T','50','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMASMUTUALZ0','12','T','50','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompRecords"','5','(''UN0''=''F'')','EMASMUTUALZ0','12','T','50','27',NULL,'Total Salary for Compensation Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryContribTotal"','6','(''UNP2''=''F'')','EMASMUTUALZ0','12','T','50','39',NULL,'Total Salary for Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv415SalaryTotal"','7','(''UNP2''=''F'')','EMASMUTUALZ0','12','T','50','51',NULL,'Total Salary for 415 Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADPSalaryTotal"','8','(''UNP2''=''F'')','EMASMUTUALZ0','12','T','50','63',NULL,'Total Salary for ADP Testing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalHours"','9','(''UN0''=''F'')','EMASMUTUALZ0','12','T','50','75',NULL,'Total Hours Worked',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Compensation Export','201912311','EMPEXPORT','COMP','Dec 31 2019  1:19PM','EMASMUTUAL',NULL,NULL,NULL,'201912311','Sep 28 2018 12:00AM','Sep 22 2018 12:00AM','201912311','195','','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Contribution Loan Export','201912311','EMPEXPORT','CONTRIB','Dec 31 2019  1:19PM','EMASMUTUAL',NULL,NULL,NULL,'201912311','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','201912311','2','','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Demographics Export','201912311','EMPEXPORT','DEMO','Dec 31 2019  1:19PM','EMASMUTUAL',NULL,NULL,NULL,'201912311','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','201912311','1340','','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Test Demographics Export','202001099','EMPEXPORT','TEST_DEMO','Jan  8 2020  1:04PM','EMASMUTUAL',NULL,NULL,NULL,'202001099','Jan  9 2020 12:00AM','Dec 30 1899 12:00AM','202001091','1345','','','202001091',dbo.fn_GetTimedKey(),NULL,'us3lKiASS1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Test Contribution Loans Export','202001099','EMPEXPORT','TEST_CONT','Jan 10 2020  1:36PM','EMASMUTUAL',NULL,NULL,NULL,'202001099','Jan  9 2020 12:00AM','Dec 30 1899 12:00AM','202001091','121','','','202001091',dbo.fn_GetTimedKey(),NULL,'us3lKiASS1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Test Compensation Export','202001099','EMPEXPORT','TEST_COMP','Jan  8 2020  1:08PM','EMASMUTUAL',NULL,NULL,NULL,'202001099','Jan  9 2020 12:00AM','Dec 30 1899 12:00AM','202001091','169','','','202001091',dbo.fn_GetTimedKey(),NULL,'us3lKiASS1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','',NULL,NULL,NULL,'COMBINED Files','202001231','EMPEXPORT','COMBINED','Feb  7 2020  6:02PM','EMASMUTUAL',NULL,NULL,NULL,'202001231','Jan 23 2020 12:00AM','Jan 17 2020 12:00AM','202001231','995','','','202001231',dbo.fn_GetTimedKey(),NULL,'us3mLaASS1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMASMUTUAL_20200210.txt',NULL,'','','Q5CD6',NULL,NULL,NULL,'TEST COMBINED','202001231','EMPEXPORT','TEST_COMBI','Feb  7 2020  6:07PM','EMASMUTUAL',NULL,NULL,NULL,'202001231','Jan 23 2020 12:00AM','Jan 17 2020 12:00AM','202001231','995','eecPayGroup','USBWK','202001231',dbo.fn_GetTimedKey(),NULL,'us3lKiASS1010',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMASMUTUAL_20200210.txt' END WHERE expFormatCode = 'EMASMUTUAL';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMASMUTUAL','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMASMUTUAL' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMASMUTUAL' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMASMUTUAL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMASMUTUAL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_DEMO','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','CONTRIB','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_CONT','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','H','20','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','D','25','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','TEST_COMP','T','35','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMASMUTUAL','DEMO','D','30','Y','F');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','H01','dbo.U_EMASMUTUAL_Header','drvfiletype = ''DEMO''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','H20','dbo.U_EMASMUTUAL_Header','drvfiletype = ''CONT''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','H40','dbo.U_EMASMUTUAL_Header','drvfiletype = ''COMP''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D10','dbo.U_EMASMUTUAL_Demo_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D25','dbo.U_EMASMUTUAL_Cont_drvTbl','drvContributionSource <> ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D30','dbo.U_EMASMUTUAL_Cont_drvTbl','drvContributionSource = ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','D45','dbo.U_EMASMUTUAL_Comp_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','T15','dbo.U_EMASMUTUAL_Demo_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','T35','dbo.U_EMASMUTUAL_Cont_Trailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMASMUTUAL','T50','dbo.U_EMASMUTUAL_Comp_Trailer',NULL);
IF OBJECT_ID('U_EMASMUTUAL_Comp_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Comp_drvTbl] (
    [drvContractNumber] varchar(10) NULL,
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
IF OBJECT_ID('U_EMASMUTUAL_Comp_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Comp_Trailer] (
    [drvContractNumber] varchar(10) NULL,
    [drvDetailCount] int NULL,
    [drvCompRecords] int NULL,
    [drvSalaryContribTotal] money NULL,
    [drv415SalaryTotal] money NULL,
    [drvADPSalaryTotal] money NULL,
    [drvTotalHours] decimal NULL
);
IF OBJECT_ID('U_EMASMUTUAL_Cont_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Cont_drvTbl] (
    [drvContractNumber] varchar(10) NULL,
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
IF OBJECT_ID('U_EMASMUTUAL_Cont_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Cont_Trailer] (
    [drvDetailCount] int NULL,
    [drvContractNumber] varchar(10) NULL,
    [drvContributionRecords] int NULL,
    [drvContributionAmount] bigint NULL,
    [drvLoanRecords] int NULL,
    [drvLoanAmount] bigint NULL
);
IF OBJECT_ID('U_EMASMUTUAL_Demo_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Demo_drvTbl] (
    [drvContractNumber] varchar(10) NULL,
    [drvEIN] char(9) NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvSubSetCode] int NOT NULL,
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
    [drvAddressEmail] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvGender] char(1) NULL,
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
IF OBJECT_ID('U_EMASMUTUAL_Demo_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Demo_Trailer] (
    [drvDetailCount] int NULL,
    [drvContractNumber] varchar(10) NULL
);
IF OBJECT_ID('U_EMASMUTUAL_EEList') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMASMUTUAL_File') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EMASMUTUAL_HdrRecords') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_HdrRecords] (
    [Header_Type] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMASMUTUAL_Header') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_Header] (
    [drvContractNumber] varchar(10) NULL,
    [drvFileDescription] varchar(16) NULL,
    [drvTransmissionDate] datetime NOT NULL,
    [drvActTransmissionDate] datetime NOT NULL,
    [drvActTransmissionTime] varchar(4) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMASMUTUAL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EMASMUTUAL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [Peh415TestingComp] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL
);
IF OBJECT_ID('U_EMASMUTUAL_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EMASMUTUAL_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWagesYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMASMUTUAL]

    @SystemID CHAR(12)

AS

SET NOCOUNT ON;

/**********************************************************************************

Client Name: Associated Foreign Exchange



Created By: Marco Lagrosa

Business Analyst: Lea King

Create Date: 12/31/2019 

Service Request Number: TekP-2019-10-16-0001



Purpose: To send employee information to Mass Mutual for plan administration.



Revision History

----------------

Update By            Date            Request Num                Desc        





SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMASMUTUAL';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMASMUTUAL';

SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMASMUTUAL';

SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMASMUTUAL';

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMASMUTUAL' ORDER BY DateTimeCompleted DESC;



Execute Export

--------------

--Demographics --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'DEMO';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'TEST_DEMO';



--Compensation --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'COMP';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'TEST_COMP';



--Contributions and Loans --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'CONTRIB';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'TEST_CONT';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMASMUTUAL', 'COMBINED';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMASMUTUAL', @AllObjects = 'Y', @IsWeb  = 'Y'



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



    SET @Formatcode = 'EMASMUTUAL'

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

    DELETE FROM dbo.U_EMASMUTUAL_EEList

    WHERE xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)

    AND xEEID IN (SELECT xEEID FROM dbo.U_EMASMUTUAL_EEList GROUP BY xEEID HAVING Count(*) > 1 );

 

    --Delete Employees with invalid SSN 999999999

    DELETE dbo.U_EMASMUTUAL_EEList

    FROM dbo.U_EMASMUTUAL_EEList

    INNER JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID

        AND EepSSN = '999999999';
    

    Delete from dbo.U_EMASMUTUAL_EEList where xeeid in (

    select eeceeid from empcomp where EecDedGroupCode = 'NONE' and EecFullTimeOrPartTime = 'PT')


    --==========================================

    -- Build Employee Data and the driver tables

    --==========================================

    -----------------------------

    -- Working Table - PDedHist

    -----------------------------

    IF OBJECT_ID('U_EMASMUTUAL_PDedHist') IS NOT NULL

        DROP TABLE dbo.U_EMASMUTUAL_PDedHist;



    SELECT DISTINCT

         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CF','401CP','401F','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('ROTHF','ROTHP') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L1','401L2') THEN 'PLAN1' 

                        END

        ,PdhEECurAmt = SUM(PdhEECurAmt)

        ,PdhERCurAmt = SUM(PdhERCurAmt)

    INTO dbo.U_EMASMUTUAL_PDedHist

    FROM dbo.PDedHist WITH (NOLOCK)

    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('401CF','401CP','401F','401P','ROTHF','ROTHP','401L1','401L2')

    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401CF','401CP','401F','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('ROTHF','ROTHP') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L1','401L2') THEN 'PLAN1' 

                        END

    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);



    ------------------------------------

    -- Working Table - PEarHist (YTD)

    ------------------------------------

    IF OBJECT_ID('U_EMASMUTUAL_PEarHist') IS NOT NULL

        DROP TABLE dbo.U_EMASMUTUAL_PEarHist;

    SELECT DISTINCT

         PehEEID

        ,PehCurAmtYTD        = SUM(PehCurAmt)

        ,PehCurHrsYTD        = SUM(PehCurHrs)

        ,Peh415TestingComp   = SUM(CASE WHEN ErnInclInMiscEarn1 = 'Y' THEN PehCurAmt END)

        ,PehInclInDefComp    = SUM(CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt END)

        ,PehInclInDefCompHrs = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurHrs END)

    INTO dbo.U_EMASMUTUAL_PEarHist

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

    IF OBJECT_ID('U_EMASMUTUAL_PTaxHist') IS NOT NULL

        DROP TABLE dbo.U_EMASMUTUAL_PTaxHist;

    SELECT DISTINCT

         PthEEID

        ,PthGrossWagesYTD    = SUM(PthCurGrossWages)       

    INTO dbo.U_EMASMUTUAL_PTaxHist

    FROM dbo.PTaxHist WITH (NOLOCK)

    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)

    AND PthPerControl <= @EndPerControl

    AND PthTaxCode = 'USFIT'

    GROUP BY PthEEID

    HAVING SUM(PthCurGrossWages) <> 0.00;



    ---------------------------------

    -- HEADER RECORD - Multiple Headers are included in the file

    ---------------------------------

    IF OBJECT_ID('U_EMASMUTUAL_HdrRecords') IS NOT NULL

        DROP TABLE dbo.U_EMASMUTUAL_HdrRecords;

    SELECT 'DEMO' AS Header_Type --Demographics

    INTO dbo.U_EMASMUTUAL_HdrRecords

  

    UNION

    

    SELECT 'CONT' --Contribution and Loans

    

    UNION

    

    SELECT 'COMP'; --Compensation



    IF OBJECT_ID('U_EMASMUTUAL_Header') IS NOT NULL

        DROP TABLE dbo.U_EMASMUTUAL_Header;

    SELECT DISTINCT

         drvContractNumber        = @MasterContractNum

        ,drvFileDescription     = CASE WHEN Header_Type = 'DEMO' THEN 'CCS Demo File'

                                       WHEN Header_Type = 'CONT' THEN 'CCS Contrib File'

                                       WHEN Header_Type = 'COMP' THEN 'CCS Comp File'

                                  END

        ,drvTransmissionDate    = GETDATE()

        ,drvActTransmissionDate = GETDATE()

        ,drvActTransmissionTime = LEFT(REPLACE(CONVERT(VARCHAR,GETDATE(),108),':',''),4)

        ,drvFileType            = Header_Type 

    INTO dbo.U_EMASMUTUAL_Header

    FROM dbo.U_EMASMUTUAL_HdrRecords;



    ---------------------------------

    -- DETAIL RECORD - Demographics Data

    ---------------------------------

    IF @ExportCode LIKE '%DEMO'  or @ExportCode LIKE '%COMBINED'

    BEGIN

        IF OBJECT_ID('U_EMASMUTUAL_Demo_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMASMUTUAL_Demo_drvTbl;



        SELECT DISTINCT

             drvContractNumber        = @MasterContractNum

            ,drvEIN                 = CmpFedTaxID

            ,drvLocation            = ''

            ,drvSubSetCode          = 1

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

            ,drvPhoneHomeNumber     = EepPhoneHomeNumber

            ,drvAddressEmail        = EepAddressEMail

            ,drvDateOfBirth         = EepDateOfBirth

            ,drvDateOfOriginalHire  = EecDateOfOriginalHire

            ,drvGender              = EepGender

            ,drvMaritalStatus       = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END

            ,drvEmploymentClass     = 'Y'

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

        INTO dbo.U_EMASMUTUAL_Demo_drvTbl

        FROM dbo.U_EMASMUTUAL_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        LEFT JOIN dbo.Company WITH (NOLOCK)

            ON CmpCOID = xCOID

        ;



        --Exclude Employees whose Term Date is not in last 12 months And Doesn't have any YTD compensation or Contribution

        DELETE dbo.U_EMASMUTUAL_Demo_drvTbl

        WHERE drvEmploymentStatus IN ('Termed','Deceased','Retired') AND drvEmpStatusChangeDate < DATEADD(MM, - 12, @EndDate)

        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMASMUTUAL_PEarHist WITH (NOLOCK) WHERE PehEEID = drvEEID)

        AND NOT EXISTS (SELECT 1 FROM dbo.U_EMASMUTUAL_PDedHist WITH (NOLOCK) WHERE PdhEEID = drvEEID);



        Delete from U_EMASMUTUAL_Demo_drvTbl where drveeid not in (
            select eeceeid from empcomp where EecPayGroup = 'USBWK' and EecDedGroupCode <> 'NONE' and EecFullTimeOrPartTime <> 'PT'
        )

        ---------------------------------

        -- TRAILER RECORD - Demographics Data

        ---------------------------------

        IF OBJECT_ID('U_EMASMUTUAL_Demo_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMASMUTUAL_Demo_Trailer;

        SELECT DISTINCT drvDetailCount     = COUNT(*)

                ,drvContractNumber        = @MasterContractNum

        INTO dbo.U_EMASMUTUAL_Demo_Trailer

        FROM dbo.U_EMASMUTUAL_Demo_drvTbl;



        SELECT @TotalFileRecords = drvDetailCount

        FROM dbo.U_EMASMUTUAL_Demo_Trailer;



    END

    

    IF @ExportCode LIKE '%CONT%'  or @ExportCode LIKE '%COMBINED'

    BEGIN

        ---------------------------------

        -- DETAIL RECORD - Contributions and Loans

        ---------------------------------

        IF OBJECT_ID('U_EMASMUTUAL_Cont_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMASMUTUAL_Cont_drvTbl;

        SELECT DISTINCT

             drvContractNumber        = @MasterContractNum

            ,drvEIN                 = CmpFedTaxID

            ,drvSSN                 = EepSSN             

            ,drvPayrollDate         = PrgPayDate

            ,drvPeriodStart         = PrgPeriodStart

            ,drvPeriodEnd           = PrgPeriodEnd

            ,drvContributionSource  = PdhSource

            ,drvContributionAmount  = CASE WHEN PdhEECurAmt > 0 THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*100,12,0)) 

                                           ELSE '-'+CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*-1*100,11,0)) 

                                      END

            ,drvEEID = xEEID

            ,drvCoID = xCOID

            ,drvInitialSort = EepSSN

            ,drvFileType = 'CONT'

        INTO dbo.U_EMASMUTUAL_Cont_drvTbl

        FROM dbo.U_EMASMUTUAL_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        INNER JOIN dbo.U_EMASMUTUAL_PDedHist WITH (NOLOCK)

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

        IF OBJECT_ID('U_EMASMUTUAL_Cont_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMASMUTUAL_Cont_Trailer;

        SELECT DISTINCT

             drvDetailCount         = COUNT(*)

            ,drvContractNumber        = @MasterContractNum

            ,drvContributionRecords = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN 1 ELSE 0 END)

            ,drvContributionAmount  = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)

            ,drvLoanRecords         = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN 1 ELSE 0 END)

            ,drvLoanAmount          = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)

        INTO dbo.U_EMASMUTUAL_Cont_Trailer

        FROM dbo.U_EMASMUTUAL_Cont_drvTbl;



        SELECT @TotalFileRecords = @TotalFileRecords + drvDetailCount

        FROM dbo.U_EMASMUTUAL_Cont_Trailer;

    END



    IF @ExportCode LIKE '%COMP'  or @ExportCode LIKE '%COMBINED'

    BEGIN

        ---------------------------------

        -- DETAIL RECORD - Compensation Record

        ---------------------------------

        IF OBJECT_ID('U_EMASMUTUAL_Comp_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMASMUTUAL_Comp_drvTbl;

        SELECT DISTINCT

             drvContractNumber        = @MasterContractNum

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

        INTO dbo.U_EMASMUTUAL_Comp_drvTbl

        FROM dbo.U_EMASMUTUAL_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        LEFT JOIN dbo.U_EMASMUTUAL_PEarHist WITH (NOLOCK)

            ON PehEEID = xEEID

        LEFT JOIN dbo.U_EMASMUTUAL_PTaxHist WITH (NOLOCK)

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

        Delete from U_EMASMUTUAL_Comp_drvTbl where drveeid not in (
            select eeceeid from empcomp where EecPayGroup = 'USBWK' and EecDedGroupCode <> 'NONE' and EecFullTimeOrPartTime <> 'PT'
        )

        ---------------------------------

        -- TRAILER RECORD - Compensation Record

        ---------------------------------

        IF OBJECT_ID('U_EMASMUTUAL_Comp_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMASMUTUAL_Comp_Trailer;

        SELECT DISTINCT

             drvContractNumber        = @MasterContractNum

            ,drvDetailCount         = COUNT(*)

            ,drvCompRecords         = COUNT(*)

            ,drvSalaryContribTotal  = SUM(drvContribSalary)

            ,drv415SalaryTotal      = SUM(drv415Salary)

            ,drvADPSalaryTotal      = SUM(drvADPSalary)

            ,drvTotalHours          = SUM(ROUND(drvhoursworked,0))

        INTO dbo.U_EMASMUTUAL_Comp_Trailer

        FROM dbo.U_EMASMUTUAL_Comp_drvTbl;

    END



    --==========================================

    -- Set FileName

    --==========================================

    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')

    BEGIN

        UPDATE dbo.U_dsi_Parameters

        SET ExportFile = @MasterContractNum + 

                         CASE WHEN @ExportCode LIKE '%DEMO%' THEN 'demo' 

                              WHEN @ExportCode LIKE '%CONT%' THEN 'cont' 

                              WHEN @ExportCode LIKE '%COMP%' THEN 'comp'

                              WHEN @ExportCode LIKE '%COMBINED%' THEN 'combined'   

                         END +

                         CASE WHEN @ExportCode LIKE 'TEST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'test_' ELSE '_' END + 

                         CONVERT(VARCHAR,GetDate(),112) +

                         '.asc'

        WHERE FormatCode = @FormatCode;

    END;



END;

/**********************************************************************************



--Alter the View

ALTER VIEW dbo.dsi_vwEMASMUTUAL_Export AS

    SELECT TOP 200000000 Data FROM dbo.U_EMASMUTUAL_File WITH (NOLOCK)

    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO



--Check out AscDefF

SELECT * FROM dbo.AscDefF

WHERE AdfHeaderSystemID LIKE 'EMASMUTUAL%'

ORDER BY AdfSetNumber, AdfFieldNumber;



--Update Dates

UPDATE dbo.AscExp

    SET ExpLastStartPerControl = '201810011'

       ,ExpStartPerControl     = '201810011'

       ,ExpLastEndPerControl   = '201810019'

       ,ExpEndPerControl       = '201810019'

WHERE ExpFormatCode = 'EMASMUTUAL';



**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMASMUTUAL_Export AS  
    SELECT TOP 200000000 Data FROM dbo.U_EMASMUTUAL_File WITH (NOLOCK) 
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort 