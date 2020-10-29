SET NOCOUNT ON;
IF OBJECT_ID('U_ECIGFMLAEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIGFMLAEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIGFMLAEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIGFMLAEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGFMLAEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGFMLAEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGFMLAEX];
GO
IF OBJECT_ID('U_ECIGFMLAEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_Trailer];
GO
IF OBJECT_ID('U_ECIGFMLAEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_PEarHist];
GO
IF OBJECT_ID('U_ECIGFMLAEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_PDedHist];
GO
IF OBJECT_ID('U_ECIGFMLAEX_Header') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_Header];
GO
IF OBJECT_ID('U_ECIGFMLAEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_File];
GO
IF OBJECT_ID('U_ECIGFMLAEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_EEList];
GO
IF OBJECT_ID('U_ECIGFMLAEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_drvTbl];
GO
IF OBJECT_ID('U_ECIGFMLAEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGFMLAEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGFMLAEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIGFMLAEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIGFMLAEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIGFMLAEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIGFMLAEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIGFMLAEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECIGFMLAEX','Cigna FMLA Disability Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECIGFMLAEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIGFMLAEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD"','1','(''DA''=''F'')','ECIGFMLAEXZ0','2','H','01','1',NULL,'File Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P01817507"','2','(''DA''=''F'')','ECIGFMLAEXZ0','15','H','01','3',NULL,'DUNS Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTestIndicator"','3','(''UA''=''F'')','ECIGFMLAEXZ0','1','H','01','18',NULL,'Production/Test Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','4','(''UD112''=''F'')','ECIGFMLAEXZ0','8','H','01','19',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BERRY APPLEMAN LEIDEN"','5','(''DA''=''F'')','ECIGFMLAEXZ0','35','H','01','27',NULL,'Employer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2"','6','(''DA''=''F'')','ECIGFMLAEXZ0','1','H','01','62',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''F'')','ECIGFMLAEXZ0','2','H','01','63',NULL,'Life & Accident File Maintenance Reason Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2"','8','(''DA''=''F'')','ECIGFMLAEXZ0','1','H','01','65',NULL,'Disability File Maintenance Reason Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','ECIGFMLAEXZ0','2935','H','01','66',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''F'')','ECIGFMLAEXZ0','9','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','2','(''UA''=''F'')','ECIGFMLAEXZ0','11','D','10','10',NULL,'Employee Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','ECIGFMLAEXZ0','10','D','10','21',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','31',NULL,'Eligibility Billing Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000454392"','5','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','35',NULL,'CIGNA Internal Company Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000025132"','6','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','44',NULL,'Employee Group Number ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''F'')','ECIGFMLAEXZ0','3','D','10','53',NULL,'Employee Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','56',NULL,'Class Change Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','ECIGFMLAEXZ0','10','D','10','64',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','10','(''UA''=''F'')','ECIGFMLAEXZ0','35','D','10','74',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','11','(''UA''=''F'')','ECIGFMLAEXZ0','25','D','10','109',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','12','(''UA''=''F'')','ECIGFMLAEXZ0','15','D','10','134',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','ECIGFMLAEXZ0','10','D','10','149',NULL,'Employee Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','14','(''UA''=''F'')','ECIGFMLAEXZ0','10','D','10','159',NULL,'Employee Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','15','(''UD112''=''F'')','ECIGFMLAEXZ0','8','D','10','169',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','177',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','17','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','178',NULL,'Employee Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','179',NULL,'Employee’s PIN Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','183',NULL,'Employee Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','ECIGFMLAEXZ0','34','D','10','184',NULL,'Employee E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','218',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','ECIGFMLAEXZ0','34','D','10','219',NULL,'Supplemental E-mail Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','253',NULL,'E-mail 1 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','ECIGFMLAEXZ0','34','D','10','254',NULL,'Supplemental E-mail Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','288',NULL,'E-mail 2 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','26','(''UA''=''F'')','ECIGFMLAEXZ0','35','D','10','289',NULL,'Employee Mail Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','27','(''UA''=''F'')','ECIGFMLAEXZ0','35','D','10','324',NULL,'Employee Mail Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','28','(''UA''=''F'')','ECIGFMLAEXZ0','30','D','10','359',NULL,'Employee Mail City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSate"','29','(''UA''=''F'')','ECIGFMLAEXZ0','2','D','10','389',NULL,'Employee Mail State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','30','(''UA''=''F'')','ECIGFMLAEXZ0','10','D','10','391',NULL,'Employee Mail Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','31','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','401',NULL,'Employee Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"US"','32','(''DA''=''F'')','ECIGFMLAEXZ0','2','D','10','431',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','ECIGFMLAEXZ0','2','D','10','433',NULL,'Employee Residence State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','ECIGFMLAEXZ0','3','D','10','435',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"R"','35','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','438',NULL,'Type of Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','439',NULL,'Effective Date of the Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','37','(''UA''=''F'')','ECIGFMLAEXZ0','20','D','10','447',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','467',NULL,'Phone Usage code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','ECIGFMLAEXZ0','45','D','10','468',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','ECIGFMLAEXZ0','2','D','10','513',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusCode"','41','(''UA''=''F'')','ECIGFMLAEXZ0','2','D','10','515',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusEffDate"','42','(''UD112''=''F'')','ECIGFMLAEXZ0','8','D','10','517',NULL,'Employee Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','43','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','525',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDateOfHire"','44','(''UD112''=''F'')','ECIGFMLAEXZ0','8','D','10','526',NULL,'Employee Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','534',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','ECIGFMLAEXZ0','20','D','10','542',NULL,'Employee Work-site Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','562',NULL,'Employee Annual Salary for Life Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','48','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','571',NULL,'Mode For Disability Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningForDisabilitiy"','49','(''UA''=''F'')','ECIGFMLAEXZ0','9','D','10','572',NULL,'Employee Earnings for Disability Products',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','581',NULL,'Last Earnings Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalariedIndicator"','51','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','589',NULL,'Salaried Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimeIndicator"','52','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','590',NULL,'Full Time Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','591',NULL,'Commission Bonus Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','592',NULL,'Work At Home Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptIndicator"','55','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','593',NULL,'Exempt Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedPerWeek"','56','(''UA''=''F'')','ECIGFMLAEXZ0','5','D','10','594',NULL,'Number of Hours Worked Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxFilingStateCode"','57','(''UA''=''F'')','ECIGFMLAEXZ0','2','D','10','599',NULL,'Tax Filing State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','601',NULL,'Occupation Classification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','ECIGFMLAEXZ0','65','D','10','610',NULL,'Job Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','ECIGFMLAEXZ0','12','D','10','675',NULL,'Company Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganizationName"','61','(''UA''=''F'')','ECIGFMLAEXZ0','30','D','10','687',NULL,'Organization Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientOrganizationCode"','62','(''UA''=''F'')','ECIGFMLAEXZ0','15','D','10','717',NULL,'Client Organization Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientLocationCode"','63','(''UA''=''F'')','ECIGFMLAEXZ0','12','D','10','732',NULL,'Client Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','ECIGFMLAEXZ0','10','D','10','744',NULL,'Union Local Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','754',NULL,'Union Local Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','784',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','785',NULL,'Health Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','786',NULL,'Health Plan Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','ECIGFMLAEXZ0','6','D','10','816',NULL,'Accrued Sick Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeIndicator"','70','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','822',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualAnnualHours"','71','(''UA''=''F'')','ECIGFMLAEXZ0','4','D','10','823',NULL,'Actual Annual Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','72','(''UA''=''F'')','ECIGFMLAEXZ0','2','D','10','827',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','ECIGFMLAEXZ0','50','D','10','829',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','ECIGFMLAEXZ0','2','D','10','879',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','881',NULL,'Maintenance Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','889',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','ECIGFMLAEXZ0','35','D','10','898',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','ECIGFMLAEXZ0','25','D','10','933',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''F'')','ECIGFMLAEXZ0','15','D','10','958',NULL,'Spouse Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','ECIGFMLAEXZ0','10','D','10','973',NULL,'Spouse Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','ECIGFMLAEXZ0','10','D','10','983',NULL,'Spouse Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','993',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1001',NULL,'Spouse Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1002',NULL,'Spouse Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','ECIGFMLAEXZ0','20','D','10','1003',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"03"','86','(''DA''=''F'')','ECIGFMLAEXZ0','2','D','10','1023',NULL,'Number of products',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA"','87','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','1025',NULL,'Coverage code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1029',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA"','89','(''DA''=''F'')','ECIGFMLAEXZ0','3','D','10','1038',NULL,'Policy Symbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0963474"','90','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','1041',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','1048',NULL,'Provision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''F'')','ECIGFMLAEXZ0','5','D','10','1056',NULL,'Elected Benefits Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1061',NULL,'Elected Benefits Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''F'')','ECIGFMLAEXZ0','5','D','10','1070',NULL,'Employee Contribution Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','1075',NULL,'Election Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1083',NULL,'Post Tax Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1084',NULL,'50/75 Rule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''F'')','ECIGFMLAEXZ0','59','D','10','1085',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCodeLoop2"','99','(''UA''=''F'')','ECIGFMLAEXZ0','4','D','10','1144',NULL,'Coverage code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1148',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol2"','101','(''UA''=''F'')','ECIGFMLAEXZ0','3','D','10','1157',NULL,'Policy Symbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber2"','102','(''UA''=''F'')','ECIGFMLAEXZ0','7','D','10','1160',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvisionEffDateLoop2"','103','(''UD112''=''F'')','ECIGFMLAEXZ0','8','D','10','1167',NULL,'Provision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectedBenefitPct2"','104','(''UA''=''F'')','ECIGFMLAEXZ0','5','D','10','1175',NULL,'Elected Benefits Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1180',NULL,'Elected Benefits Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContribPct2"','106','(''UA''=''F'')','ECIGFMLAEXZ0','5','D','10','1189',NULL,'Employee Contribution Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','1194',NULL,'Election Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxIndicator2"','108','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','1202',NULL,'Post Tax Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitDescription2"','109','(''UA''=''F'')','ECIGFMLAEXZ0','30','D','10','1203',NULL,'Benefit Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','1233',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCodeLoop3"','111','(''UA''=''F'')','ECIGFMLAEXZ0','4','D','10','1263',NULL,'Coverage code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1267',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol3"','113','(''UA''=''F'')','ECIGFMLAEXZ0','3','D','10','1276',NULL,'Policy Symbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPoicyNumber3"','114','(''UA''=''F'')','ECIGFMLAEXZ0','7','D','10','1279',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvisionEffDateLoop3"','115','(''UD112''=''F'')','ECIGFMLAEXZ0','8','D','10','1286',NULL,'Provision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectedBenefitPct3"','116','(''UA''=''F'')','ECIGFMLAEXZ0','5','D','10','1294',NULL,'Elected Benefits Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1299',NULL,'Elected Benefits Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeContribAmt3"','118','(''UA''=''F'')','ECIGFMLAEXZ0','5','D','10','1308',NULL,'Employee Contribution Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','1313',NULL,'Election Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxIndicatorLoop3"','120','(''UA''=''F'')','ECIGFMLAEXZ0','1','D','10','1321',NULL,'Post Tax Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitDescriptionLoop3"','121','(''UA''=''F'')','ECIGFMLAEXZ0','30','D','10','1322',NULL,'Benefit Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','1352',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','1382',NULL,'Coverage code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1386',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''F'')','ECIGFMLAEXZ0','3','D','10','1395',NULL,'Policy Symbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','1398',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','1405',NULL,'Provision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''F'')','ECIGFMLAEXZ0','5','D','10','1413',NULL,'Elected Benefits Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1418',NULL,'Elected Benefits Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''F'')','ECIGFMLAEXZ0','5','D','10','1427',NULL,'Employee Contribution Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''F'')','ECIGFMLAEXZ0','8','D','10','1432',NULL,'Election Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1440',NULL,'Post Tax Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','1441',NULL,'Benefit Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''F'')','ECIGFMLAEXZ0','30','D','10','1471',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''F'')','ECIGFMLAEXZ0','2','D','10','1501',NULL,'Number of Products',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''F'')','ECIGFMLAEXZ0','3','D','10','1503',NULL,'Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''F'')','ECIGFMLAEXZ0','3','D','10','1506',NULL,'Policy Symbol',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''F'')','ECIGFMLAEXZ0','6','D','10','1509',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1515',NULL,'Assignment Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1516',NULL,'Employee Previous Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','1525',NULL,'Employee Previous Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1529',NULL,'Spouse Previous Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1538',NULL,'Child Previous Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1547',NULL,'Employee Issued Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','1556',NULL,'Employee Issued Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1560',NULL,'Spouse Issued Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1569',NULL,'Child Issued Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1578',NULL,'Employee Applied Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','1587',NULL,'Employee Applied Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1591',NULL,'Spouse Applied Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1600',NULL,'Child Applied Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1609',NULL,'Employee Pending Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''F'')','ECIGFMLAEXZ0','4','D','10','1618',NULL,'Employee Pending Salary Multiple',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1622',NULL,'Spouse Pending Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1631',NULL,'Child Pending Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1640',NULL,'Employee Monthly Cash Accumulation Fund Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''F'')','ECIGFMLAEXZ0','9','D','10','1649',NULL,'Spouse Monthly Cash Accumulation Fund Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1658',NULL,'Employee AIO Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1659',NULL,'Employee ADD/ADB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1660',NULL,'Spouse ADD/ADB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1661',NULL,'Employee APB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1662',NULL,'Spouse APB Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''F'')','ECIGFMLAEXZ0','1','D','10','1663',NULL,'PAI plan option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''F'')','ECIGFMLAEXZ0','925','D','10','1664',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2589',NULL,'H&W Deduction # 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2596',NULL,'H&W Deduction # 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2603',NULL,'H&W Deduction # 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2610',NULL,'H&W Deduction # 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2617',NULL,'H&W Deduction # 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2624',NULL,'H&W Deduction # 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2631',NULL,'H&W Deduction # 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2638',NULL,'H&W Deduction # 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2645',NULL,'H&W Deduction # 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2652',NULL,'H&W Deduction # 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2659',NULL,'H&W Deduction # 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''F'')','ECIGFMLAEXZ0','7','D','10','2666',NULL,'H&W Deduction # 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''F'')','ECIGFMLAEXZ0','178','D','10','2673',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtendedEmpEmail"','178','(''UA''=''F'')','ECIGFMLAEXZ0','50','D','10','2851',NULL,'Extended Employee E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''F'')','ECIGFMLAEXZ0','50','D','10','2901',NULL,'Extended Supplemental E-mail Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''F'')','ECIGFMLAEXZ0','50','D','10','2951',NULL,'Extended Supplemental E-mail Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TR"','1','(''DA''=''F'')','ECIGFMLAEXZ0','2','T','90','1',NULL,'File Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P01817507"','2','(''DA''=''F'')','ECIGFMLAEXZ0','15','T','90','3',NULL,'DUNS Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','ECIGFMLAEXZ0','1','T','90','18',NULL,'Reserved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfRecords"','4','(''UA''=''F'')','ECIGFMLAEXZ0','9','T','90','19',NULL,'Number of Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','ECIGFMLAEXZ0','2973','T','90','28',NULL,'Reserved',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECIGFMLAEX_20201029.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202010299','EMPEXPORT','OEACTIVE','Oct 29 2020  6:09PM','ECIGFMLAEX',NULL,NULL,NULL,'202010299','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202010291','2','','','202010291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202010299','EMPEXPORT','OEPASSIVE','Oct 29 2020  6:09PM','ECIGFMLAEX',NULL,NULL,NULL,'202010299','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202010291','1290','','','202010291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Cigna FMLA Disability Export','202010299','EMPEXPORT','ONDEM_XOE','Oct 29 2020  6:09PM','ECIGFMLAEX',NULL,NULL,NULL,'202010299','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202010291','1290','','','202010291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Cigna FMLA Disability Ex-Sched','202010299','EMPEXPORT','SCH_ECIGFM','Oct 29 2020  6:09PM','ECIGFMLAEX',NULL,NULL,NULL,'202010299','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202010291','1290','','','202010291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Cigna FMLA Disability Ex-Test','202010299','EMPEXPORT','TEST_XOE','Oct 29 2020  6:10PM','ECIGFMLAEX',NULL,NULL,NULL,'202010299','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202010291','1290','','','202010291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGFMLAEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGFMLAEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGFMLAEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGFMLAEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGFMLAEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECIGFMLAEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECIGFMLAEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECIGFMLAEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGFMLAEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGFMLAEX','H01','dbo.U_ECIGFMLAEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGFMLAEX','D10','dbo.U_ECIGFMLAEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGFMLAEX','T90','dbo.U_ECIGFMLAEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ECIGFMLAEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGFMLAEX] (
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
IF OBJECT_ID('U_ECIGFMLAEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIGFMLAEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressSate] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmploymentStatusCode] varchar(2) NOT NULL,
    [drvEmployeeStatusEffDate] datetime NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvEmployeeDateOfHire] datetime NULL,
    [drvEarningForDisabilitiy] nvarchar(4000) NULL,
    [drvSalariedIndicator] varchar(1) NOT NULL,
    [drvFullTimeIndicator] varchar(1) NOT NULL,
    [drvExemptIndicator] varchar(1) NOT NULL,
    [drvHoursWorkedPerWeek] nvarchar(4000) NULL,
    [drvTaxFilingStateCode] varchar(255) NULL,
    [drvOrganizationName] varchar(25) NULL,
    [drvClientOrganizationCode] varchar(6) NULL,
    [drvClientLocationCode] char(6) NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvActualAnnualHours] nvarchar(4000) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvCoverageCodeLoop2] varchar(3) NULL,
    [drvPolicySymbol2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(7) NULL,
    [drvProvisionEffDateLoop2] datetime NULL,
    [drvElectedBenefitPct2] varchar(5) NULL,
    [drvEmpContribPct2] varchar(5) NULL,
    [drvPostTaxIndicator2] varchar(1) NULL,
    [drvBenefitDescription2] varchar(7) NULL,
    [drvCoverageCodeLoop3] varchar(3) NULL,
    [drvPolicySymbol3] varchar(2) NULL,
    [drvPoicyNumber3] varchar(7) NULL,
    [drvProvisionEffDateLoop3] datetime NULL,
    [drvElectedBenefitPct3] varchar(5) NULL,
    [drvEmployeeContribAmt3] varchar(5) NULL,
    [drvPostTaxIndicatorLoop3] varchar(1) NULL,
    [drvBenefitDescriptionLoop3] varchar(7) NULL,
    [drvExtendedEmpEmail] varchar(50) NULL
);
IF OBJECT_ID('U_ECIGFMLAEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIGFMLAEX_File') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
IF OBJECT_ID('U_ECIGFMLAEX_Header') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_Header] (
    [drvProdTestIndicator] varchar(1) NOT NULL,
    [drvFileCreationDate] datetime NOT NULL
);
IF OBJECT_ID('U_ECIGFMLAEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_PDedHist] (
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
IF OBJECT_ID('U_ECIGFMLAEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_PEarHist] (
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
IF OBJECT_ID('U_ECIGFMLAEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECIGFMLAEX_Trailer] (
    [drvNumberOfRecords] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGFMLAEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Berry Appleman

Created By: James Bender
Business Analyst: Lea King
Create Date: 10/29/2020
Service Request Number: TekP-2020-10-07-0001

Purpose: Cigna FMLA Disability Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGFMLAEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGFMLAEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGFMLAEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGFMLAEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGFMLAEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGFMLAEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGFMLAEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGFMLAEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGFMLAEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGFMLAEX', 'SCH_ECIGFM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGFMLAEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGFMLAEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGFMLAEX';

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
    DELETE FROM dbo.U_ECIGFMLAEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGFMLAEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECIGFMLAEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )
    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD1,LTD2,LTD3,STDS';

    IF OBJECT_ID('U_ECIGFMLAEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGFMLAEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGFMLAEX_DedList
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
    IF OBJECT_ID('U_ECIGFMLAEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGFMLAEX_PDedHist;
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
    INTO dbo.U_ECIGFMLAEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIGFMLAEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECIGFMLAEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGFMLAEX_PEarHist;
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
    INTO dbo.U_ECIGFMLAEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND 
    PehPerControl <= @EndPerControl
    AND PehPerControl > FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd') + '1'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIGFMLAEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGFMLAEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGFMLAEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = CASE WHEN ISNULL(EepGender, '') <> '' THEN EepGender ELSE 'F' END
        ,drvMaritalStatus =    CASE WHEN EepMaritalStatus IN ('D','M','W') THEN EepMaritalStatus
                                WHEN EepMaritalStatus = 'S' THEN 'I'
                                ELSE 'K'
                            END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressSate = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneNumber = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber ELSE EfoPhoneNumber END
        ,drvEmploymentStatusCode =    CASE WHEN EecEmplStatus = 'L' THEN 'L1'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RT'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DI'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') THEN 'TE'
                                        ELSE 'AC'
                                    END
        ,drvEmployeeStatusEffDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                    END
        ,drvEmployeeType = CASE WHEN EecEEType = 'REG' THEN 'P' ELSE 'T' END
        ,drvEmployeeDateOfHire = EecDateOfLastHire
        ,drvEarningForDisabilitiy = FORMAT(EecAnnSalary*100, '000000000')
        ,drvSalariedIndicator = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvFullTimeIndicator = CASE WHEN EecFullTimeOrPartTime = 'FT' THEN 'Y' ELSE 'N' END
        ,drvExemptIndicator = CASE WHEN EjhFLSACategory = 'E' THEN 'Y' ELSE 'N' END
        ,drvHoursWorkedPerWeek = CASE WHEN EecEmpNo IN ('000001','111802','111687','010196','009970','111783','111516') THEN '04000' ELSE FORMAT(EjhWeeklyHours*100, '00000') END
        ,drvTaxFilingStateCode = EepAddressState
        ,drvOrganizationName = OrgDesc1
        ,drvClientOrganizationCode = EecOrgLvl1
        ,drvClientLocationCode = EecLocation
        ,drvKeyEmployeeIndicator = CASE WHEN JbcJobFamily = '7' THEN 'Y' ELSE 'N' END
        ,drvActualAnnualHours =    CASE WHEN EecEmpNo IN ('000001','111802','111687','010196','009970','111783','111516') THEN '04000' 
                                    ELSE FORMAT(CAST(CASE WHEN PehCurHrsYTD % 1 >= .45 THEN PehCurHrsYTD+ 1 ELSE PehCurHrsYTD END AS INT), '0000')
                                    --FORMAT(PehCurHrsYTD*100, '00000') 
                                END
        ,drvWorkState = LocAddressState
        ,drvCoverageCodeLoop2 = CASE WHEN STDS_DedCode IS NOT NULL THEN 'STD' END

        ,drvPolicySymbol2 = CASE WHEN STDS_DedCode IS NOT NULL THEN 'LK' END
        ,drvPolicyNumber2 = CASE WHEN STDS_DedCode IS NOT NULL THEN '0963474' END

        ,drvProvisionEffDateLoop2 = CASE WHEN STDS_DedCode IS NOT NULL THEN Min_STDS END

        ,drvElectedBenefitPct2 = CASE WHEN STDS_DedCode IS NOT NULL THEN '06000' END
        ,drvEmpContribPct2 = CASE WHEN STDS_DedCode IS NOT NULL THEN '00000' END
        ,drvPostTaxIndicator2 = CASE WHEN STDS_DedCode IS NOT NULL THEN 'N' END
        ,drvBenefitDescription2 = CASE WHEN STDS_DedCode IS NOT NULL THEN 'Class 1' END

        ,drvCoverageCodeLoop3 = CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL OR LTD3_DedCode IS NOT NULL THEN 'LTD' END

        ,drvPolicySymbol3 =  CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL OR LTD3_DedCode IS NOT NULL THEN 'LK' END
        ,drvPoicyNumber3 =  CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL OR LTD3_DedCode IS NOT NULL THEN '0966374' END


        ,drvProvisionEffDateLoop3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN Min_LTD1
                                        WHEN LTD2_DedCode IS NOT NULL THEN Min_LTD2
                                        WHEN LTD3_DedCode IS NOT NULL THEN Min_LTD3
                                    END
        ,drvElectedBenefitPct3 = CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL OR LTD3_DedCode IS NOT NULL THEN '06000' END
        ,drvEmployeeContribAmt3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN '10000'
                                        WHEN LTD2_DedCode IS NOT NULL THEN '00000'
                                        WHEN LTD3_DedCode IS NOT NULL THEN '00000'
                                    END
        ,drvPostTaxIndicatorLoop3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN 'Y'
                                        WHEN LTD2_DedCode IS NOT NULL THEN 'N'
                                        WHEN LTD3_DedCode IS NOT NULL THEN 'N'
                                    END
        ,drvBenefitDescriptionLoop3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN 'Class 1'
                                            WHEN LTD2_DedCode IS NOT NULL THEN 'Class 2'
                                            WHEN LTD3_DedCode IS NOT NULL THEN 'Class 3'
                                        END
        ,drvExtendedEmpEmail = EepAddressEMail
    INTO dbo.U_ECIGFMLAEX_drvTbl
    FROM dbo.U_ECIGFMLAEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
--    JOIN dbo.U_dsi_BDM_ECIGFMLAEX WITH (NOLOCK)
--        ON BdmEEID = xEEID 
--        AND BdmCoID = xCoID
    JOIN (
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode = 'STDS' THEN BdmDedCode END) AS STDS_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN BdmDedCode END) AS LTD1_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD2' THEN BdmDedCode END) AS LTD2_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD3' THEN BdmDedCode END) AS LTD3_DedCode
            FROM dbo.U_dsi_BDM_ECIGFMLAEX WITH (NOLOCK)
            GROUP By BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID
    JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
    /*JOIN (
            SELECT EjhEEID, EjhCOID, EjhJobCode, DATEDIFF(MONTH, MIN(EjhJobEffDate), GETDATE()) AS EjhMonthsInJobCode, MAX(EjhFLSACategory) AS EjhFLSACategory
            FROM dbo.EmpHJob WITH (NOLOCK)
            GROUP BY EjhEEID, EjhCOID, EjhJobCode ) AS JobMonths*/
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode1, OrgDesc AS OrgDesc1, OrgManagerId AS OrgManagerId1
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 1
            ) AS Org1
        ON OrgCode1 = EecOrgLvl1
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_ECIGFMLAEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN (
            SELECT EdhEEID, EdhCOID
                ,MIN(CASE WHEN EdhDedCode = 'LTD1' THEN  EdhBenStartDate END ) AS Min_LTD1
                ,MIN(CASE WHEN EdhDedCode = 'LTD2' THEN  EdhBenStartDate END ) AS Min_LTD2
                ,MIN(CASE WHEN EdhDedCode = 'LTD3' THEN  EdhBenStartDate END ) AS Min_LTD3
                ,MIN(CASE WHEN EdhDedCode = 'STDS' THEN  EdhBenStartDate END ) AS Min_STDS
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('LTD1','LTD2','LTD3','STDS')
            GROUP BY EdhEEID, EdhCOID) AS Edh
    ON EdhEEID = xEEID
    AND EdhCOID = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate and @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECIGFMLAEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGFMLAEX_Header;
    SELECT DISTINCT
         drvProdTestIndicator = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvFileCreationDate = GETDATE()
    INTO dbo.U_ECIGFMLAEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECIGFMLAEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGFMLAEX_Trailer;
    SELECT DISTINCT
         drvNumberOfRecords = FORMAT((SELECT COUNT(*) FROM dbo.U_ECIGFMLAEX_drvTbl WITH (NOLOCK)), '000000000')
    INTO dbo.U_ECIGFMLAEX_Trailer
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
ALTER VIEW dbo.dsi_vwECIGFMLAEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGFMLAEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGFMLAEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010221'
       ,expStartPerControl     = '202010221'
       ,expLastEndPerControl   = '202010299'
       ,expEndPerControl       = '202010299'
WHERE expFormatCode = 'ECIGFMLAEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGFMLAEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGFMLAEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort