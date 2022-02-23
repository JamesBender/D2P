SET NOCOUNT ON;
IF OBJECT_ID('U_EDASCIGRET_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDASCIGRET_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDASCIGRET' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDASCIGRET_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDASCIGRET_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDASCIGRET') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDASCIGRET];
GO
IF OBJECT_ID('U_EDASCIGRET_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_Trailer];
GO
IF OBJECT_ID('U_EDASCIGRET_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_PEarHist];
GO
IF OBJECT_ID('U_EDASCIGRET_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_PDedHist];
GO
IF OBJECT_ID('U_EDASCIGRET_Header') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_Header];
GO
IF OBJECT_ID('U_EDASCIGRET_File') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_File];
GO
IF OBJECT_ID('U_EDASCIGRET_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_EEList];
GO
IF OBJECT_ID('U_EDASCIGRET_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_drvTbl];
GO
IF OBJECT_ID('U_EDASCIGRET_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDASCIGRET') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDASCIGRET];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDASCIGRET';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDASCIGRET';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDASCIGRET';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDASCIGRET';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDASCIGRET';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EDASCIGRET','Cigna LTD STD FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDASCIGRETZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD"','1','(''DA''=''F'')','EDASCIGRETZ0','2','H','01','1',NULL,'File Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"021449251"','2','(''DA''=''F'')','EDASCIGRETZ0','15','H','01','3',NULL,'DUNS Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestOrPRod"','3','(''UA''=''F'')','EDASCIGRETZ0','1','H','01','18',NULL,'Production/Test Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationDate"','4','(''UD112''=''F'')','EDASCIGRETZ0','8','H','01','19',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DAS Companies, Inc."','5','(''DA''=''F'')','EDASCIGRETZ0','35','H','01','27',NULL,'Employer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2"','6','(''DA''=''F'')','EDASCIGRETZ0','1','H','01','62',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EDASCIGRETZ0','2','H','01','63',NULL,'Life & Accident File Maintenance Reason Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2"','8','(''DA''=''F'')','EDASCIGRETZ0','1','H','01','65',NULL,'Disability File Maintenance Reason Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EDASCIGRETZ0','2935','H','01','66',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepSSN"','1','(''UA''=''F'')','EDASCIGRETZ0','9','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eecEmpNo"','2','(''UA''=''F'')','EDASCIGRETZ0','11','D','10','10',NULL,'Employee Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','3','(''SS''=''F'')','EDASCIGRETZ0','10','D','10','21',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','4','(''SS''=''F'')','EDASCIGRETZ0','4','D','10','31',NULL,'Eligibility Billing Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000309498"','5','(''DA''=''F'')','EDASCIGRETZ0','9','D','10','35',NULL,'CIGNA Internal Company Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000019911"','6','(''DA''=''F'')','EDASCIGRETZ0','9','D','10','44',NULL,'Employee Group Number ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EDASCIGRETZ0','3','D','10','53',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','56',NULL,'Class Change Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EDASCIGRETZ0','10','D','10','64',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepNameLast"','10','(''UA''=''F'')','EDASCIGRETZ0','35','D','10','74',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepNameFirst"','11','(''UA''=''F'')','EDASCIGRETZ0','25','D','10','109',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepNameMiddle"','12','(''UA''=''F'')','EDASCIGRETZ0','15','D','10','134',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EDASCIGRETZ0','10','D','10','149',NULL,'Employee Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','14','(''DA''=''F'')','EDASCIGRETZ0','10','D','10','159',NULL,'Employee Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepDateOfBirth"','15','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','169',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepGender"','16','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','177',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepMaritalStatus"','17','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','178',NULL,'Employee Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EDASCIGRETZ0','4','D','10','179',NULL,'Employee’s PIN Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','183',NULL,'Employee Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','EDASCIGRETZ0','34','D','10','184',NULL,'Employee E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','218',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''F'')','EDASCIGRETZ0','34','D','10','219',NULL,'Supplemental E-mail Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','253',NULL,'E-mail 1 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''F'')','EDASCIGRETZ0','34','D','10','254',NULL,'Supplemental E-mail Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','288',NULL,'E-mail 2 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressLine1"','26','(''UA''=''F'')','EDASCIGRETZ0','35','D','10','289',NULL,'Employee Mail Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressLine2"','27','(''UA''=''F'')','EDASCIGRETZ0','35','D','10','324',NULL,'Employee Mail Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressCity"','28','(''UA''=''F'')','EDASCIGRETZ0','30','D','10','359',NULL,'Employee Mail City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressState"','29','(''UA''=''F'')','EDASCIGRETZ0','2','D','10','389',NULL,'Employee Mail State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressZipCode"','30','(''UA''=''F'')','EDASCIGRETZ0','10','D','10','391',NULL,'Employee Mail Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','31','(''UA''=''F'')','EDASCIGRETZ0','30','D','10','401',NULL,'Employee Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','32','(''UA''=''F'')','EDASCIGRETZ0','2','D','10','431',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''F'')','EDASCIGRETZ0','2','D','10','433',NULL,'Employee Residence State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''F'')','EDASCIGRETZ0','3','D','10','435',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"R"','35','(''DA''=''F'')','EDASCIGRETZ0','1','D','10','438',NULL,'Type of Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','439',NULL,'Effective Date of the Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepPhoneNumber"','37','(''UA''=''F'')','EDASCIGRETZ0','20','D','10','447',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"R"','38','(''DA''=''F'')','EDASCIGRETZ0','1','D','10','467',NULL,'Phone Usage code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''F'')','EDASCIGRETZ0','45','D','10','468',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''F'')','EDASCIGRETZ0','2','D','10','513',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','41','(''UA''=''F'')','EDASCIGRETZ0','2','D','10','515',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffectiveDate"','42','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','517',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpType"','43','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','525',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','44','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','526',NULL,'Employee Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedServiceDate  "','45','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','534',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''F'')','EDASCIGRETZ0','20','D','10','542',NULL,'Employee Work-site Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','562',NULL,'Employee Annual Salary for Life Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvModeDisability','48','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','571',NULL,'Mode For Disability Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','49','(''UNPN''=''T'')','EDASCIGRETZ0','9','D','10','572',NULL,'Employee Earnings for Disability Products',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','582',NULL,'Last Earnings Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlySalary"','51','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','590',NULL,'Salaried Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimeIndicator"','52','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','591',NULL,'Full Time Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCommBonusIndicator"','53','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','592',NULL,'Commission Bonus Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','593',NULL,'Work At Home Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptIndicator"','55','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','594',NULL,'Exempt Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklyHours"','56','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','595',NULL,'Number of Hours Worked Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateCode"','57','(''UA''=''F'')','EDASCIGRETZ0','2','D','10','600',NULL,'Tax Filing State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','602',NULL,'Occupation Classification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''F'')','EDASCIGRETZ0','65','D','10','611',NULL,'Job Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''F'')','EDASCIGRETZ0','12','D','10','676',NULL,'Company Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','688',NULL,'Organization Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''F'')','EDASCIGRETZ0','15','D','10','718',NULL,'Client Organization Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''F'')','EDASCIGRETZ0','12','D','10','733',NULL,'Client Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''F'')','EDASCIGRETZ0','10','D','10','745',NULL,'Union Local Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','755',NULL,'Union Local Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','66','(''DA''=''F'')','EDASCIGRETZ0','1','D','10','785',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','786',NULL,'Health Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','787',NULL,'Health Plan Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''F'')','EDASCIGRETZ0','6','D','10','817',NULL,'Accrued Sick Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','823',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualAnnHours"','71','(''UA''=''F'')','EDASCIGRETZ0','4','D','10','824',NULL,'Actual Annual Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStateCode"','72','(''UA''=''F'')','EDASCIGRETZ0','2','D','10','828',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''F'')','EDASCIGRETZ0','50','D','10','830',NULL,'Reserved1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''F'')','EDASCIGRETZ0','2','D','10','880',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','882',NULL,'Maintenance Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','890',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''SS''=''F'')','EDASCIGRETZ0','35','D','10','899',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''SS''=''F'')','EDASCIGRETZ0','25','D','10','934',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''SS''=''F'')','EDASCIGRETZ0','15','D','10','959',NULL,'Spouse Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''SS''=''F'')','EDASCIGRETZ0','10','D','10','974',NULL,'Spouse Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''SS''=''F'')','EDASCIGRETZ0','10','D','10','984',NULL,'Spouse Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','994',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1002',NULL,'Spouse Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1003',NULL,'Spouse Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''SS''=''F'')','EDASCIGRETZ0','20','D','10','1004',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"03"','86','(''DA''=''F'')','EDASCIGRETZ0','2','D','10','1024',NULL,'Number of products',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode01"','87','(''UA''=''F'')','EDASCIGRETZ0','4','D','10','1026',NULL,'Coverage code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1030',NULL,'Reserved 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSymbol01"','89','(''UA''=''F'')','EDASCIGRETZ0','3','D','10','1039',NULL,'Policy Symbol 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber01"','90','(''UA''=''F'')','EDASCIGRETZ0','7','D','10','1042',NULL,'Policy Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffetiveDate01"','91','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','1049',NULL,'Provision Effective Date  1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPerc01"','92','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1057',NULL,'Elected Benefits Percent 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1062',NULL,'Elected Benefits Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrib01"','94','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1071',NULL,'Employee Contribution Percent 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','1076',NULL,'Election Effective Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd01"','96','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','1084',NULL,'Post Tax Indicator 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1085',NULL,'Benefit Description 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1115',NULL,'Reserved Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode02"','99','(''UA''=''F'')','EDASCIGRETZ0','4','D','10','1145',NULL,'Coverage code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1149',NULL,'Reserved 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSymbol02"','101','(''UA''=''F'')','EDASCIGRETZ0','3','D','10','1158',NULL,'Policy Symbol 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber02"','102','(''UA''=''F'')','EDASCIGRETZ0','7','D','10','1161',NULL,'Policy Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffetiveDate02"','103','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','1168',NULL,'Provision Effective Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPerc02"','104','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1176',NULL,'Elected Benefits Percent 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1181',NULL,'Elected Benefits Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrib02"','106','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1190',NULL,'Employee Contribution Percent  2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','1195',NULL,'Election Effective Date  2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd02"','108','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','1203',NULL,'Post Tax Indicator  2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1204',NULL,'Benefit Description 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1234',NULL,'Reserved Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode03"','111','(''UA''=''F'')','EDASCIGRETZ0','4','D','10','1264',NULL,'Coverage code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1268',NULL,'Reserved 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSymbol03"','113','(''UA''=''F'')','EDASCIGRETZ0','3','D','10','1277',NULL,'Policy Symbol 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber03"','114','(''UA''=''F'')','EDASCIGRETZ0','7','D','10','1280',NULL,'Policy Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate03"','115','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','1287',NULL,'Provision Effective Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPerc03"','116','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1295',NULL,'Elected Benefits Percent 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1300',NULL,'Elected Benefits Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrib03"','118','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1309',NULL,'Employee Contribution Percent 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','1314',NULL,'Election Effective Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd03"','120','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','1322',NULL,'Post Tax Indicator 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1323',NULL,'Benefit Description 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1353',NULL,'Reserved Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode04"','123','(''UA''=''F'')','EDASCIGRETZ0','4','D','10','1383',NULL,'Coverage code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1387',NULL,'Reserved Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSymbol04"','125','(''UA''=''F'')','EDASCIGRETZ0','3','D','10','1396',NULL,'Policy Symbol 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber04"','126','(''UA''=''F'')','EDASCIGRETZ0','7','D','10','1399',NULL,'Policy Number 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffetiveDate04"','127','(''UD112''=''F'')','EDASCIGRETZ0','8','D','10','1406',NULL,'Provision Effective Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPerc04"','128','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1414',NULL,'Elected Benefits Percent 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1419',NULL,'Elected Benefits Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrib04"','130','(''UA''=''F'')','EDASCIGRETZ0','5','D','10','1428',NULL,'Employee Contribution Percent 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''SS''=''F'')','EDASCIGRETZ0','8','D','10','1433',NULL,'Election Effective Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd04"','132','(''UA''=''F'')','EDASCIGRETZ0','1','D','10','1441',NULL,'Post Tax Indicator 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1442',NULL,'Benefit Description 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''SS''=''F'')','EDASCIGRETZ0','30','D','10','1472',NULL,'Reserved Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''SS''=''F'')','EDASCIGRETZ0','2','D','10','1502',NULL,'Number of Products',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''SS''=''F'')','EDASCIGRETZ0','3','D','10','1504',NULL,'Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''SS''=''F'')','EDASCIGRETZ0','3','D','10','1507',NULL,'Policy Symbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''SS''=''F'')','EDASCIGRETZ0','6','D','10','1510',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1516',NULL,'Assignment Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1517',NULL,'Employee Previous Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''SS''=''F'')','EDASCIGRETZ0','4','D','10','1526',NULL,'Employee Previous Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1530',NULL,'Spouse Previous Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1539',NULL,'Child Previous Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1548',NULL,'Employee Issued Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''SS''=''F'')','EDASCIGRETZ0','4','D','10','1557',NULL,'Employee Issued Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1561',NULL,'Spouse Issued Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1570',NULL,'Child Issued Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1579',NULL,'Employee Applied Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''SS''=''F'')','EDASCIGRETZ0','4','D','10','1588',NULL,'Employee Applied Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1592',NULL,'Spouse Applied Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1601',NULL,'Child Applied Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1610',NULL,'Employee Pending Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''SS''=''F'')','EDASCIGRETZ0','4','D','10','1619',NULL,'Employee Pending Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1623',NULL,'Spouse Pending Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1632',NULL,'Child Pending Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1641',NULL,'Employee Monthly Cash Accumulation Fund Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''SS''=''F'')','EDASCIGRETZ0','9','D','10','1650',NULL,'Spouse Monthly Cash Accumulation Fund Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1659',NULL,'Employee AIO Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1660',NULL,'Employee ADD/ADB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1661',NULL,'Spouse  ADD/ADB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1662',NULL,'Employee APB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1663',NULL,'Spouse APB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''SS''=''F'')','EDASCIGRETZ0','1','D','10','1664',NULL,'PAI plan option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''SS''=''F'')','EDASCIGRETZ0','20','D','10','1665',NULL,'Reserved6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''SS''=''F'')','EDASCIGRETZ0','1167','D','10','1685',NULL,'Reserved7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepAddresEmail"','166','(''UA''=''F'')','EDASCIGRETZ0','50','D','10','2851',NULL,'Extended Employee E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''SS''=''F'')','EDASCIGRETZ0','50','D','10','2901',NULL,'Extended Supplemental E-mail Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''SS''=''F'')','EDASCIGRETZ0','50','D','10','2951',NULL,'Extended Supplemental E-mail Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TR"','1','(''DA''=''F'')','EDASCIGRETZ0','2','T','90','1',NULL,'File Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"021449251"','2','(''DA''=''F'')','EDASCIGRETZ0','15','T','90','3',NULL,'DUNS Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EDASCIGRETZ0','1','T','90','18',NULL,'Reserved8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfRecords"','4','(''UA''=''F'')','EDASCIGRETZ0','9','T','90','19',NULL,'Number of Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EDASCIGRETZ0','2973','T','90','28',NULL,'Reserved9',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDASCIGRET_20200212.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','201908239','EMPEXPORT','OEACTIVE','Aug 30 2019 12:02PM','EDASCIGRET',NULL,NULL,NULL,'201908239','Aug 23 2019 12:46PM','Aug 23 2019 12:46PM','201908231','7','','','201908231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDASCIGRET_20200212.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201908239','EMPEXPORT','OEPASSIVE','Aug 23 2019  4:17PM','EDASCIGRET',NULL,NULL,NULL,'201908239','Aug 23 2019 12:46PM','Aug 23 2019 12:46PM','201908231','1317','','','201908231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDASCIGRET_20200212.txt',NULL,'','',',FPORD,XO23H',NULL,NULL,NULL,'Cigna LTD STD - Wed 7:10am','201910119','EMPEXPORT','SCHEDULED','Oct 18 2019 12:00AM','EDASCIGRET',NULL,NULL,NULL,'202002129','Oct 11 2019 12:00AM','Dec 30 1899 12:00AM','202002051','1252','','','201910041',dbo.fn_GetTimedKey(),NULL,'us3mLaDAS1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDASCIGRET_20200212.txt',NULL,'','',NULL,NULL,NULL,NULL,'Cigna Dis FMLA Ondemand','201908239','EMPEXPORT','ONDEMAND','Dec 27 2019 12:00AM','EDASCIGRET',NULL,NULL,NULL,'201908239','Aug 23 2019 12:00AM','Dec 30 1899 12:00AM','201908231',NULL,'','','201908231',dbo.fn_GetTimedKey(),NULL,'us3lKiDAS1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDASCIGRET_20200212.txt',NULL,'','','FPORD,XO23H',NULL,NULL,NULL,'Test Purposes Only','202002129','EMPEXPORT','TEST','Feb 12 2020 11:25AM','EDASCIGRET',NULL,NULL,NULL,'202002129','Feb 12 2020 12:00AM','Dec 30 1899 12:00AM','202002051','583','','','202002051',dbo.fn_GetTimedKey(),NULL,'us3mLaDAS1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EDASCIGRET_20200212.txt' END WHERE expFormatCode = 'EDASCIGRET';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDASCIGRET','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDASCIGRET','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDASCIGRET','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDASCIGRET','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDASCIGRET','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EDASCIGRET' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDASCIGRET' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EDASCIGRET_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDASCIGRET_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDASCIGRET','H01','dbo.U_EDASCIGRET_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDASCIGRET','D10','dbo.U_EDASCIGRET_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDASCIGRET','T90','dbo.U_EDASCIGRET_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDASCIGRET') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDASCIGRET] (
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
IF OBJECT_ID('U_EDASCIGRET_DedList') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDASCIGRET_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [eepSSN] char(11) NULL,
    [eecEmpNo] char(9) NULL,
    [eepNameFirst] varchar(100) NULL,
    [eepNameLast] varchar(100) NULL,
    [eepNameMiddle] varchar(1) NULL,
    [EepDateOfBirth] datetime NULL,
    [eepGender] char(1) NULL,
    [EepMaritalStatus] varchar(1) NULL,
    [EepAddressLine1] varchar(6000) NULL,
    [EepAddressLine2] varchar(6000) NULL,
    [EepAddressCity] varchar(6000) NULL,
    [EepAddressState] varchar(255) NULL,
    [EepAddressZipCode] varchar(50) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [eepPhoneNumber] varchar(50) NOT NULL,
    [drvStatusCode] varchar(2) NOT NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvEmpType] varchar(1) NOT NULL,
    [drvDateofHire] datetime NULL,
    [drvAdjustedServiceDate] datetime NULL,
    [drvModeDisability] varchar(1) NOT NULL,
    [drvAnnSalary] decimal NULL,
    [drvHourlySalary] varchar(1) NOT NULL,
    [drvFullTimeIndicator] varchar(1) NOT NULL,
    [drvCommBonusIndicator] varchar(1) NOT NULL,
    [drvExemptIndicator] varchar(1) NOT NULL,
    [drvWeeklyHours] varchar(12) NULL,
    [drvStateCode] varchar(255) NULL,
    [drvActualAnnHours] varchar(24) NULL,
    [drvWorkStateCode] varchar(255) NULL,
    [drvCoverageCode01] varchar(4) NOT NULL,
    [drvSymbol01] varchar(4) NOT NULL,
    [drvPolicyNumber01] varchar(7) NOT NULL,
    [drvEffetiveDate01] int NULL,
    [drvBenefitPerc01] varchar(1) NOT NULL,
    [drvEmpContrib01] varchar(1) NOT NULL,
    [drvPostTaxInd01] varchar(1) NOT NULL,
    [drvCoverageCode02] varchar(3) NOT NULL,
    [drvSymbol02] varchar(2) NOT NULL,
    [drvPolicyNumber02] varchar(7) NOT NULL,
    [drvEffetiveDate02] datetime NULL,
    [drvBenefitPerc02] varchar(5) NOT NULL,
    [drvEmpContrib02] varchar(5) NOT NULL,
    [drvPostTaxInd02] varchar(1) NOT NULL,
    [drvCoverageCode03] varchar(3) NOT NULL,
    [drvSymbol03] varchar(2) NOT NULL,
    [drvPolicyNumber03] varchar(7) NOT NULL,
    [drvEffectiveDate03] datetime NULL,
    [drvBenefitPerc03] varchar(5) NOT NULL,
    [drvEmpContrib03] varchar(5) NOT NULL,
    [drvPostTaxInd03] varchar(1) NOT NULL,
    [drvCoverageCode04] varchar(1) NOT NULL,
    [drvSymbol04] varchar(1) NOT NULL,
    [drvPolicyNumber04] varchar(1) NOT NULL,
    [drvEffetiveDate04] varchar(1) NOT NULL,
    [drvBenefitPerc04] varchar(1) NOT NULL,
    [drvEmpContrib04] varchar(1) NOT NULL,
    [drvPostTaxInd04] varchar(1) NOT NULL,
    [eepAddresEmail] varchar(50) NULL
);
IF OBJECT_ID('U_EDASCIGRET_EEList') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDASCIGRET_File') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
IF OBJECT_ID('U_EDASCIGRET_Header') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_Header] (
    [drvTestOrPRod] varchar(1) NOT NULL,
    [drvCreationDate] varchar(8) NULL
);
IF OBJECT_ID('U_EDASCIGRET_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_PDedHist] (
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
IF OBJECT_ID('U_EDASCIGRET_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [PrgHoursWorkPerWeek] decimal NULL
);
IF OBJECT_ID('U_EDASCIGRET_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDASCIGRET_Trailer] (
    [drvNumberOfRecords] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDASCIGRET]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: DAS Companies

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/17/2019
Service Request Number: SR-2019-00247691

Purpose: Cigna LTD STD FMLA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDASCIGRET';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDASCIGRET';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDASCIGRET';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDASCIGRET';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDASCIGRET' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDASCIGRET', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDASCIGRET', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDASCIGRET', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDASCIGRET', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDASCIGRET';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDASCIGRET', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@RunDate           VARCHAR(8)
            ,@FileMinCovDate    DATETIME
            ,@Last52WeekPerControl as VARCHAR(10);

    -- Set FormatCode
    SELECT @FormatCode = 'EDASCIGRET';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('11/01/2019' AS date) 
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

        SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDASCIGRET_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDASCIGRET_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Delete Employees with invalid SSN 555555554
    DELETE dbo.U_EDASCIGRET_EEList
    FROM dbo.U_EDASCIGRET_EEList
    INNER JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID
        AND EepSSN = '555555554';

    --Delete Employees with eeceetype =  TES
    DELETE FROM dbo.U_EDASCIGRET_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT distinct eeceeid FROM empcomp where eeceetype = 'TES');

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD';

    IF OBJECT_ID('U_EDASCIGRET_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDASCIGRET_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDASCIGRET_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

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


            -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EDASCIGRET_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDASCIGRET_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN  PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl THEN PehCurHrs ELSE 0.0 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        ,PrgHoursWorkPerWeek = MAX(CASE WHEN PgrPayFrequency = 'B' THEN PgrSchedHrs / 2 ELSE PgrSchedHrs END )
    INTO dbo.U_EDASCIGRET_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH (NOLOCK)
        on PrgPayGroup = PgrPayGroup
    WHERE  PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDASCIGRET_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDASCIGRET_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDASCIGRET_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,eepSSN = eepSSN
        ,eecEmpNo = EecEmpNo
        ,eepNameFirst = EepNameFirst
        ,eepNameLast = EepNameLast
        ,eepNameMiddle = LEFT(ISNULL(EepNameMiddle,''),1)
        ,EepDateOfBirth = EepDateOfBirth
        ,eepGender = EepGender
        ,EepMaritalStatus = CASE WHEN (EepMaritalStatus IS NULL or EepMaritalStatus = '') or EepMaritalStatus IN('K','Z') THEN 'K'
                WHEN EepMaritalStatus = 'S' THEN 'I'
                    ELSE EepMaritalStatus 
                END
        ,EepAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,EepAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,EepAddressCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,EepAddressState = EepAddressState
        --Zip code - update to include the dash for the ones that have all 9 digits.
        ,EepAddressZipCode = CASE WHEN len(eepAddressZipCode) > 5 
                                            THEN substring(eepAddressZipCode,1,5) + '-' + substring(eepAddressZipCode,6,4) 
                                            ELSE eepAddressZipCode 
                                            END
        ,drvCountry = 'US'
        ,drvCountryCode = 'US'
        ,eepPhoneNumber = ISNULL(EepPhoneHomeNumber,'')
        ,drvStatusCode = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'DI'
                                                 WHEN EecTermReason IN ('202','213') THEN 'RT'
                                                 ELSE 'TE'
                                            END
                                WHEN EecEmplStatus = 'A' THEN 'AC'
                                WHEN EecEmplStatus = 'L' THEN 'L1'
                                ELSE 'AC'
                        END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN 
                                    CASE WHEN EecTermReason = '203' THEN    EepDateDeceased
                                                 ELSE EecDateOfTermination
                                            END 
                                    WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                    --WHEN EecEmplStatus IN ('A','S') AND EecEmplStatusStartDate >= EecDateOfLastHire THEN EecEmplStatusStartDate
                                    --WHEN EecEmplStatus IN ('A','S') AND EecDateOfOriginalHire <> EecDateOfLastHire AND (EecHireSource = 'REHIRE' OR EecJobChangeReason = '101') THEN EecDateOfLastHire
                                    ELSE NULL
                                    END
        ,drvEmpType = 'P'
        ,drvDateofHire = EecDateOfLastHire
        ,drvAdjustedServiceDate = EecDateOfOriginalHire
        --Mode For Disability Earnings - if EecSalaryOrHourly = H, send H, else send A
        ,drvModeDisability = CASE WHEN EecSalaryOrHourly = 'H' THEN 'H' ELSE 'A' END
        --Employee Earnings for Disability Products - if EecSalaryOrHourly = H, send EecHourlyPayRate, else send EecAnnSalary
        ,drvAnnSalary = CASE WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate ELSE EecAnnSalary END 
        ,drvHourlySalary = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvFullTimeIndicator = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Y' ELSE 'N' END
        ,drvCommBonusIndicator = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvExemptIndicator = CASE WHEN (Select Top 1 EjhFLSACategory from EmpHJob (nolock)  where ejheeid = xEEID order by AuditKey desc) = 'E' THEN 'Y' ELSE 'N' END
        ,drvWeeklyHours =  CAST(PrgHoursWorkPerWeek as varchar(12))
        ,drvStateCode = EepAddressState
        ,drvActualAnnHours = dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0)),4,0) 
        ,drvWorkStateCode = EepAddressState
        ,drvCoverageCode01 = 'FMLA'
        ,drvSymbol01 = 'FMLA'
        ,drvPolicyNumber01 = '0752004' --CASE WHEN STDER IN('STDER') THEN '0752480' ELSE '' END
        ,drvEffetiveDate01 = NULL
        ,drvBenefitPerc01 = ''
        ,drvEmpContrib01 = ''
        ,drvPostTaxInd01 = ''
        ,drvCoverageCode02 = CASE WHEN STDER IN('STD') THEN 'STD' ELSE '' END
        ,drvSymbol02 = CASE WHEN STDER IN('STD') THEN 'LK' ELSE '' END
        ,drvPolicyNumber02 = CASE WHEN STDER IN('STD') THEN '0752004' ELSE '' END
        ,drvEffetiveDate02 = CASE WHEN STDER IN('STD') THEN dbo.dsi_fnGetMinMaxDates('MIN',STDER_BenefitDate, @FileMinCovDate) ELSE NULL END
        ,drvBenefitPerc02 = CASE WHEN STDER IN('STD') THEN '06667' ELSE  '' END
        ,drvEmpContrib02 = CASE WHEN STDER IN('STD') THEN '00000' ELSE  '' END
        ,drvPostTaxInd02 = CASE WHEN STDER IN('STD') THEN 'N' ELSE  '' END
        ,drvCoverageCode03 = CASE WHEN LTDER IN('LTD') THEN 'LTD' ELSE '' END
        ,drvSymbol03 = CASE WHEN LTDER IN('LTD') THEN 'LK' ELSE '' END
        ,drvPolicyNumber03 = CASE WHEN LTDER IN('LTD') THEN '0965017' ELSE '' END
        ,drvEffectiveDate03 = CASE WHEN LTDER IN('LTD') THEN dbo.dsi_fnGetMinMaxDates('MIN',LTDER_BenefitDate, @FileMinCovDate) ELSE NULL END
        ,drvBenefitPerc03 = CASE WHEN LTDER IN('LTD') THEN '06000' ELSE  '' END
        ,drvEmpContrib03 = CASE WHEN LTDER IN('LTD') THEN '00000' ELSE  '' END
        ,drvPostTaxInd03 = CASE WHEN LTDER IN('LTD') THEN 'N' ELSE  '' END
        ,drvCoverageCode04 = ''
        ,drvSymbol04 = ''
        ,drvPolicyNumber04 = ''
        ,drvEffetiveDate04 = ''
        ,drvBenefitPerc04 = ''
        ,drvEmpContrib04 = ''
        ,drvPostTaxInd04 = ''
        ,eepAddresEmail =  eepAddressEMail
    INTO dbo.U_EDASCIGRET_drvTbl
    FROM dbo.U_EDASCIGRET_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  bdmEEID,bdmcoid
            ,LTDER = MAX((CASE WHEN BDMDedCode = 'LTD' then BDMDedCode END))
            ,STDER = MAX((CASE WHEN BDMDedCode = 'STD' then BDMDedCode END))
            ,LTDER_BenefitDate = MIN((CASE WHEN BDMDedCode = 'LTD' then  BdmBenStatusDate END))
            ,STDER_BenefitDate = MIN((CASE WHEN BDMDedCode = 'STD' then  BdmBenStatusDate END))
            from U_dsi_bdm_EDASCIGRET  group by bdmEEID,bdmcoid) as BdmConsolidated
    ON BdmConsolidated.BdmEEID = xEEID
    AND BdmConsolidated.BdmCOID = xCOID
    JOIN EmpHJob
    ON ejheeid = xEEID 
    AND ejhcoid = xCoID
    LEFT JOIN dbo.U_EDASCIGRET_PEarHist WITH (NOLOCK)
    on PehEEID =  XEEID
    ;

    --Include employee that only have YTD earnings
    DELETE FROM dbo.U_EDASCIGRET_drvTbl WHERE drvEEID NOT IN (
            SELECT DISTINCT
                 PehEEID
            FROM dbo.PayReg WITH (NOLOCK)
            JOIN dbo.PEarHist WITH (NOLOCK)
                ON PehGenNumber = PrgGenNumber
            WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
            AND PehPerControl <= @EndPerControl
            GROUP BY PehEEID
            HAVING SUM(PehCurAmt) <> 0.00
    );


    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDASCIGRET_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDASCIGRET_Header;
    SELECT DISTINCT
         drvTestOrPRod = CASE  WHEN @ExportCode LIKE '%SCHEDULED' or ISNULL(@ExportCode,'') = '' THEN 'P' ELSE 'T' END
        ,drvCreationDate = @RunDate
    INTO dbo.U_EDASCIGRET_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDASCIGRET_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDASCIGRET_Trailer;
    SELECT DISTINCT
         drvNumberOfRecords = (select count(*) from U_EDASCIGRET_drvTbl (nolock))
    INTO dbo.U_EDASCIGRET_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')    
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'EDASCIGRET_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ETEST12345_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEDASCIGRET_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDASCIGRET_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDASCIGRET%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201908161'
       ,expStartPerControl     = '201908161'
       ,expLastEndPerControl   = '201908239'
       ,expEndPerControl       = '201908239'
WHERE expFormatCode = 'EDASCIGRET';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDASCIGRET_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDASCIGRET_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort