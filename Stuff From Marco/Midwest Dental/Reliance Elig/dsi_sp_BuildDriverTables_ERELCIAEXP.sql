SET NOCOUNT ON;
IF OBJECT_ID('U_ERELCIAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ERELCIAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ERELCIAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwERELCIAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERELCIAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERELCIAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELCIAEXP];
GO
IF OBJECT_ID('U_ERELCIAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_PEarHist];
GO
IF OBJECT_ID('U_ERELCIAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_PDedHist];
GO
IF OBJECT_ID('U_ERELCIAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_File];
GO
IF OBJECT_ID('U_ERELCIAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_EEList];
GO
IF OBJECT_ID('U_ERELCIAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_drvTbl];
GO
IF OBJECT_ID('U_ERELCIAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ERELCIAEXP_Consolidated') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ERELCIAEXP_Consolidated];
GO
IF OBJECT_ID('U_dsi_BDM_ERELCIAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ERELCIAEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ERELCIAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ERELCIAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ERELCIAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ERELCIAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ERELCIAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERELCIAEXP','Reliance CI ACC Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ERELCIAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Selected Benefit "','1','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','1',NULL,'Selected Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Begin Date "','2','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','2',NULL,'Coverage Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage End Date "','3','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','3',NULL,'Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Tier Elected "','4','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','4',NULL,'Coverage Tier Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name "','5','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','5',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name "','6','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','6',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender Code "','7','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','7',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth "','8','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship "','9','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','9',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN "','10','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','10',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent SSN"','11','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','11',NULL,'Dependent SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name "','12','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','12',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name "','13','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','13',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address #1 "','14','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','14',NULL,'Address #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address #2    "','15','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','15',NULL,'Address #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','16','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','16',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State "','17','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','17',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code "','18','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','18',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Area Code "','19','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','19',NULL,'Area Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Telephone Number "','20','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','20',NULL,'Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code "','21','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','21',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Code_Reason_Term "','22','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','22',NULL,'Code_Reason_Term',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Date of Hire "','23','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','23',NULL,'Employee Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Email "','24','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','24',NULL,'Employee Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Occupation "','25','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','25',NULL,'Employee Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Amount "','26','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','26',NULL,'Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Type EE or ER"','27','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','27',NULL,'Pay Type EE or ER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution Taxability"','28','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','28',NULL,'Contribution Taxability',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Mode "','29','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','29',NULL,'Pay Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Identifier"','30','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','30',NULL,'Plan Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Premium Deduction "','31','(''DA''=''T|'')','ERELCIAEXPZ0','50','H','01','31',NULL,'Payroll Premium Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Open Field"','32','(''DA''=''T'')','ERELCIAEXPZ0','50','H','01','32',NULL,'Open Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSelectedBenefit"','1','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','1',NULL,'Selected Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageBeginDate"','2','(''UD101''=''T|'')','ERELCIAEXPZ0','50','D','10','2',NULL,'Coverage Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEndDate"','3','(''UD101''=''T|'')','ERELCIAEXPZ0','50','D','10','3',NULL,'Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTierElected"','4','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','4',NULL,'Coverage Tier Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','5','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','5',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','6','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','6',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCode"','7','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','7',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','8','(''UD101''=''T|'')','ERELCIAEXPZ0','50','D','10','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','9','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','9',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','10','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','10',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSSN"','11','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','11',NULL,'Dependent SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentLastName"','12','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','12',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentFirstName"','13','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','13',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','14','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','14',NULL,'Address #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','15','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','15',NULL,'Address #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','16','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','16',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','17','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','17',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','18','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','18',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAreaCode"','19','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','19',NULL,'Area Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTelephoneNumber"','20','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','20',NULL,'Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','21','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','21',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCodeReasonTerm"','22','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','22',NULL,'Code_Reason_Term',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDateofHire"','23','(''UD101''=''T|'')','ERELCIAEXPZ0','50','D','10','23',NULL,'Employee Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmail"','24','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','24',NULL,'Employee Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeOccupation"','25','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','25',NULL,'Employee Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount"','26','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','26',NULL,'Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayTypeEEorER"','27','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','27',NULL,'Pay Type EE or ER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionTaxability"','28','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','28',NULL,'Contribution Taxability',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayMode"','29','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','29',NULL,'Pay Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIdentifier"','30','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','30',NULL,'Plan Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollPremiumDeduction"','31','(''UA''=''T|'')','ERELCIAEXPZ0','50','D','10','31',NULL,'Payroll Premium Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOpenField"','32','(''UA''=''T'')','ERELCIAEXPZ0','50','D','10','32',NULL,'Open Field',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELCIAEXP_20200611.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance CI ACC Export','202005279','EMPEXPORT','ONDEMAND',NULL,'ERELCIAEXP',NULL,NULL,NULL,'202005279','May 27 2020  1:33PM','May 27 2020  1:33PM','202005271',NULL,'','','202005271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELCIAEXP_20200611.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202005279','EMPEXPORT','SCH_RLCI',NULL,'ERELCIAEXP',NULL,NULL,NULL,'202005279','May 27 2020  1:33PM','May 27 2020  1:33PM','202005271',NULL,'','','202005271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELCIAEXP_20200611.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202005279','EMPEXPORT','OEACTIVE',NULL,'ERELCIAEXP',NULL,NULL,NULL,'202005279','May 27 2020  1:33PM','May 27 2020  1:33PM','202005271',NULL,'','','202005271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELCIAEXP_20200611.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202005279','EMPEXPORT','OEPASSIVE',NULL,'ERELCIAEXP',NULL,NULL,NULL,'202005279','May 27 2020  1:33PM','May 27 2020  1:33PM','202005271',NULL,'','','202005271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELCIAEXP_20200611.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006081','EMPEXPORT','TEST','Jun  8 2020  5:16PM','ERELCIAEXP',NULL,NULL,NULL,'202006081','Jun  8 2020 12:00AM','Dec 30 1899 12:00AM','202005251','1484','','','202005251',dbo.fn_GetTimedKey(),NULL,'us3cPeMID1018',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ERELCIAEXP_20200611.txt' END WHERE expFormatCode = 'ERELCIAEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELCIAEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ERELCIAEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ERELCIAEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ERELCIAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELCIAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELCIAEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELCIAEXP','D10','dbo.U_ERELCIAEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ERELCIAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ERELCIAEXP] (
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
IF OBJECT_ID('U_dsi_BDM_ERELCIAEXP_Consolidated') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ERELCIAEXP_Consolidated] (
    [Bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmdeprecid] char(12) NULL,
    [Child] varchar(5) NULL,
    [Spouse] varchar(6) NULL,
    [Empl] varchar(3) NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmUSGField1] varchar(256) NULL,
    [BdmEEAmt] money NULL,
    [BcaEEBenAmt] money NULL,
    [BcaEEBenAmt_CIC10] money NULL,
    [BcaEEBenAmt_CIS05] money NULL,
    [BcaEEBenAmt_CIS10] money NULL,
    [BcaEEBenAmt_CRC05] money NULL,
    [BcaEEBenAmt_CRE10] money NULL,
    [BcaEEBenAmt_CRE20] money NULL,
    [BcaEEBenAmt_CRITC] money NULL,
    [BcaEEBenAmt_CRITL] money NULL,
    [BcaEEBenAmt_CRITS] money NULL,
    [BcaEEAmt_CIC10] money NULL,
    [BcaEEAmt_CIS05] money NULL,
    [BcaEEAmt_CIS10] money NULL,
    [BcaEEAmt_CRC05] money NULL,
    [BcaEEAmt_CRE10] money NULL,
    [BcaEEAmt_CRE20] money NULL,
    [BcaEEAmt_CRITC] money NULL,
    [BcaEEAmt_CRITL] money NULL,
    [BcaEEAmt_CRITS] money NULL,
    [BcaEEAmt] money NULL,
    [bdmbenoption] char(6) NULL,
    [SelectedBenefit] varchar(3) NULL
);
IF OBJECT_ID('U_ERELCIAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ERELCIAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ERELCIAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERELCIAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] char(12) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSelectedBenefit] varchar(3) NULL,
    [drvCoverageBeginDate] datetime NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvCoverageTierElected] varchar(11) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvGenderCode] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvRelationship] varchar(6) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvDependentSSN] varchar(11) NULL,
    [drvDependentLastName] varchar(100) NULL,
    [drvDependentFirstName] varchar(100) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvAreaCode] varchar(3) NULL,
    [drvTelephoneNumber] varchar(7) NULL,
    [drvLocationCode] varchar(6) NULL,
    [drvCodeReasonTerm] varchar(1) NOT NULL,
    [drvEmployeeDateofHire] datetime NULL,
    [drvEmployeeEmail] varchar(50) NULL,
    [drvEmployeeOccupation] varchar(6000) NULL,
    [drvBenefitAmount] varchar(12) NULL,
    [drvPayTypeEEorER] varchar(13) NOT NULL,
    [drvContributionTaxability] varchar(11) NOT NULL,
    [drvPayMode] varchar(12) NULL,
    [drvPlanIdentifier] varchar(1) NULL,
    [drvPayrollPremiumDeduction] varchar(12) NULL,
    [drvOpenField] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ERELCIAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ERELCIAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ERELCIAEXP_File') IS NULL
CREATE TABLE [dbo].[U_ERELCIAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ERELCIAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ERELCIAEXP_PDedHist] (
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
IF OBJECT_ID('U_ERELCIAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ERELCIAEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELCIAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mid West Dental

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 05/27/2020
Service Request Number: SR-2016-00012345

Purpose: Reliance CI ACC Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERELCIAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERELCIAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERELCIAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERELCIAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERELCIAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELCIAEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELCIAEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELCIAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELCIAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELCIAEXP', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERELCIAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ERELCIAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERELCIAEXP';

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
    /*DELETE FROM dbo.U_ERELCIAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERELCIAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    */

    DELETE FROM dbo.U_ERELFMLAMD_EEList where  xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID) and xeeid in (select EecEEID from EmpComp where eecpaygroup in('CONTH','CONTR') or EecEEType = 'TES' )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CIC10, CIS05, CIS10, CRC05, CRE10, CRE20, CRITC, CRITL, CRITS, ACCDT';

    IF OBJECT_ID('U_ERELCIAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ERELCIAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ERELCIAEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate - 60);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, CHD, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DependentBenefitAgeGradedRate','CIC10, CIS05, CIS10, CRC05, CRE10, CRE20, CRITC, CRITL, CRITS');
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
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

   EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ERELCIAEXP D
    JOIN dbo.U_dsi_bdm_ERELCIAEXP E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ERELCIAEXP
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ERELCIAEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ERELCIAEXP
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ERELCIAEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ERELCIAEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ERELCIAEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ERELCIAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELCIAEXP_PDedHist;
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
    INTO dbo.U_ERELCIAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ERELCIAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ERELCIAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELCIAEXP_PEarHist;
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
    INTO dbo.U_ERELCIAEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


        IF OBJECT_ID('U_dsi_BDM_ERELCIAEXP_Consolidated','U') IS NOT NULL
        DROP TABLE dbo.U_dsi_BDM_ERELCIAEXP_Consolidated;
    Select Bdmeeid,bdmcoid,bdmrectype,bdmdeprecid, Max(CASE WHEN BdmDedcode in ('CIC10', 'CRC05', 'CRITC') THEN 'Child' END ) as Child ,
            Max(CASE WHEN BdmDedcode in ('CIS05', 'CIS10', 'CRITS') THEN 'Spouse' END ) as Spouse,
            Max(CASE WHEN BdmDedcode in ('CRE10', 'CRE20', 'CRITL') THEN 'Emp' END ) as Empl,
            Max(BdmBenStopDate) as BdmBenStopDate,
            Max(BdmBenStartDate) as BdmBenStartDate,
            MAX(BdmUSGField1) as BdmUSGField1,
            MAX(BdmEEAmt) as BdmEEAmt,
            MAX(BcaEEBenAmt) as BcaEEBenAmt,
            MAX(CASE WHEN bdmdedcode =  'CIC10' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CIC10,
            MAX(CASE WHEN bdmdedcode = 'CIS05' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CIS05,
            MAX(CASE WHEN bdmdedcode = 'CIS10' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CIS10,

            MAX(CASE WHEN bdmdedcode =  'CRC05' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CRC05,
            MAX(CASE WHEN bdmdedcode = 'CRE10' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CRE10,
            MAX(CASE WHEN bdmdedcode = 'CRE20' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CRE20,

            MAX(CASE WHEN bdmdedcode =  'CRITC' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CRITC,
            MAX(CASE WHEN bdmdedcode = 'CRITL' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CRITL,
            MAX(CASE WHEN bdmdedcode = 'CRITS' THEN BcaEEBenAmt END ) as BcaEEBenAmt_CRITS,
            
            MAX(CASE WHEN bdmdedcode =  'CIC10' THEN BcaEEAmt END ) as BcaEEAmt_CIC10,
            MAX(CASE WHEN bdmdedcode = 'CIS05' THEN BcaEEAmt END ) as BcaEEAmt_CIS05,
            MAX(CASE WHEN bdmdedcode = 'CIS10' THEN BcaEEAmt END ) as BcaEEAmt_CIS10,

            MAX(CASE WHEN bdmdedcode =  'CRC05' THEN BcaEEAmt END ) as BcaEEAmt_CRC05,
            MAX(CASE WHEN bdmdedcode = 'CRE10' THEN BcaEEAmt END ) as BcaEEAmt_CRE10,
            MAX(CASE WHEN bdmdedcode = 'CRE20' THEN BcaEEAmt END ) as BcaEEAmt_CRE20,

            MAX(CASE WHEN bdmdedcode =  'CRITC' THEN BcaEEAmt END ) as BcaEEAmt_CRITC,
            MAX(CASE WHEN bdmdedcode = 'CRITL' THEN BcaEEAmt END ) as BcaEEAmt_CRITL,
            MAX(CASE WHEN bdmdedcode = 'CRITS' THEN BcaEEAmt END ) as BcaEEAmt_CRITS,
            MAX(BcaEEAmt / 2 ) as BcaEEAmt,
            bdmbenoption,
            CASE WHEN BdmDedcode in ( 'CIC10', 'CIS05', 'CIS10', 'CRC05', 'CRE10', 'CRE20', 'CRITC', 'CRITL', 'CRITS') THEN  'VCI'
                                               WHEN BdmDedcode in ('ACCDT') THEN 'VAI' 
                                          END as SelectedBenefit 
            INTO dbo.U_dsi_BDM_ERELCIAEXP_Consolidated                               
            from U_dsi_BDM_ERELCIAEXP WITH (NOLOCK)
                                          JOIN dbo.u_dsi_bdm_BenCalculationAmounts 
                                          ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
                                         AND bdmdedcode = bcadedcode AND  bcaFormatCode = 'ERELCIAEXP'
                                          group by Bdmeeid,bdmcoid,bdmrectype,bdmdeprecid,bdmbenstartdate,bdmbenoption,CASE WHEN BdmDedcode in ( 'CIC10', 'CIS05', 'CIS10', 'CRC05', 'CRE10', 'CRE20', 'CRITC', 'CRITL', 'CRITS') THEN  'VCI'
                                               WHEN BdmDedcode in ('ACCDT') THEN 'VAI'
                                          END


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ERELCIAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERELCIAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERELCIAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmDepRecId
        ,drvInitialSort = eepSSN
        ,drvSubSort = bdmDepRecId
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSelectedBenefit = SelectedBenefit
        ,drvCoverageBeginDate = BdmBenStartDate
        ,drvCoverageEndDate = BdmBenStopDate
        ,drvCoverageTierElected = CASE WHEN Empl is not null THEN  'EE ONLY'    
                                       WHEN Child is not null THEN 'EE + CHILD'
                                       WHEN Spouse is not null THEN 'EE + SPOUSE'
                                       WHEN SelectedBenefit in ('VAI' ) and BdmBenOption in ('EE') THEN 'EE + ONLY'
                                       WHEN SelectedBenefit in ('VAI' ) and BdmBenOption in ('EEC') THEN 'EE + CHILD'
                                       WHEN SelectedBenefit in ('VAI' ) and BdmBenOption in ('EEF') THEN 'EE + FAMILY'
                                       WHEN SelectedBenefit in ('VAI' ) and BdmBenOption in ('EES') THEN 'EE + SPOUSE'
                                  END
        ,drvEmployeeLastName = UPPER(EepNameLast)
        ,drvEmployeeFirstName = UPPER(EepNameFirst)
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN eepGender ELSE ConGender END
        ,drvDateofBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END 
        ,drvRelationship = CASE WHEN BdmRecType = 'EMP' THEN 'SELF' ELSE 
                                    CASE WHEN ConRelationShip in ('SPS') THEN 'SPOUSE'
                                         WHEN ConRelationShip in ('CHD', 'CHL', 'STC') THEN 'CHILD'
                                    END
                            END 
        ,drvEmployeeSSN = eepSSN
        ,drvDependentSSN = CASE WHEN LEFT(ConSSN,3) IN ('999','998') THEN '' ELSE ConSSN  END
        ,drvDependentLastName = UPPER(ConNameLast)
        ,drvDependentFirstName = UPPER(ConNameFirst)
        ,drvAddress1 = UPPER(EepAddressLine1)
        ,drvAddress2 = UPPER(EepAddressLine2)
        ,drvCity = UPPER(EepAddressCity)
        ,drvState = UPPER(EepAddressState)
        ,drvZipCode = EepAddressZipCode
        ,drvAreaCode = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepPhoneHomeNumber,3) ELSE LEFT(ConPhoneHomeNumber,3) END
        ,drvTelephoneNumber = CASE WHEN BdmRecType = 'EMP' THEN RIGHT(EepPhoneHomeNumber,7) ELSE RIGHT(ConPhoneHomeNumber,7 ) END
        ,drvLocationCode = UPPER(eeclocation)
        ,drvCodeReasonTerm = ''
        ,drvEmployeeDateofHire = eecdateoforiginalhire
        ,drvEmployeeEmail = UPPER(eepaddressemail)
        ,drvEmployeeOccupation = UPPER(dbo.dsi_fnRemoveChars('.,/-',JbcDesc))
        ,drvBenefitAmount =  CASE WHEN SelectedBenefit in ('VCI' ) THEN 
                                CAST((CASE    WHEN Empl is not null THEN      
                                                CASE WHEN BcaEEBenAmt_CRE10 is not null THEN BcaEEBenAmt_CRE10 
                                                     WHEN BcaEEBenAmt_CRE20 is not null THEN BcaEEBenAmt_CRE20 
                                                    WHEN BcaEEBenAmt_CRITL is not null THEN BcaEEBenAmt_CRITL 
                                                END
    
                                        WHEN Child is not null THEN 
                                                CASE WHEN BcaEEBenAmt_CIC10 is not null THEN BcaEEBenAmt_CIC10 
                                                     WHEN BcaEEBenAmt_CRC05 is not null THEN BcaEEBenAmt_CRC05 
                                                    WHEN BcaEEBenAmt_CRITC is not null THEN BcaEEBenAmt_CRITC 
                                                END
                                
                                       WHEN Spouse is not null THEN 
                                       CASE WHEN BcaEEBenAmt_CIS05 is not null THEN BcaEEBenAmt_CIS05 
                                                     WHEN BcaEEBenAmt_CIS10 is not null THEN BcaEEBenAmt_CIS10 
                                                    WHEN BcaEEBenAmt_CRITS is not null THEN BcaEEBenAmt_CRITS 
                                                END
                
                                END) as varchar(12))
                             END
        ,drvPayTypeEEorER = 'EMPLOYEE PAID'
        ,drvContributionTaxability = 'EE POST TAX'
        ,drvPayMode = UPPER(CASE WHEN EecPayPeriod = 'W' THEN 'Weekly'
                           WHEN EecPayPeriod = 'B' THEN 'Bi-weekly'
                           WHEN EecPayPeriod = 'S' THEN 'Semi Monthly'
                           WHEN EecPayPeriod = 'M' THEN 'Monthly'
                      END)
        ,drvPlanIdentifier = CASE WHEN SelectedBenefit in ('VAI' ) THEN 'C' END
        ,drvPayrollPremiumDeduction = CASE WHEN EecEmplStatus <> 'L' THEN CAST(BcaEEAmt as varchar(12)) END
        ,drvOpenField = ''
    INTO dbo.U_ERELCIAEXP_drvTbl
    FROM dbo.U_ERELCIAEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_BDM_ERELCIAEXP_Consolidated WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode =  eecJobCode;

    --Added logic to insert spouse for VCI
    INSERT INTO dbo.U_ERELCIAEXP_drvTbl
SELECT DISTINCT
         drvEEID 
        ,drvCoID 
        ,drvDepRecID = (Select top 1 ConSystemID from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP'))
        ,drvInitialSort 
        ,drvSubSort  = (Select top 1 ConSystemID from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP'))
        ,drvSubSort2 
        -- standard fields above and additional driver fields below
        ,drvSelectedBenefit 
        ,drvCoverageBeginDate 
        ,drvCoverageEndDate 
        ,drvCoverageTierElected  = 'EE + SPOUSE'
        ,drvEmployeeLastName  
        ,drvEmployeeFirstName 
        ,drvGenderCode  = UPPER((Select top 1 ConGender from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP')))
        ,drvDateofBirth =  (Select top 1 ConDateOfBirth from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP'))
        ,drvRelationship = 'SPOUSE' 
        ,drvEmployeeSSN 
        ,drvDependentSSN  =  UPPER((Select top 1 ConSSN from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP')))
        ,drvDependentLastName  =  UPPER((Select top 1 ConNameLast from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP')))
        ,drvDependentFirstName  =  UPPER((Select top 1 ConNameFirst from Contacts where coneeid = drveeid and Conrelationship in ('SPS','DP')))
        ,drvAddress1 
        ,drvAddress2 
        ,drvCity
        ,drvState
        ,drvZipCode 
        ,drvAreaCode 
        ,drvTelephoneNumber 
        ,drvLocationCode 
        ,drvCodeReasonTerm
        ,drvEmployeeDateofHire 
        ,drvEmployeeEmail 
        ,drvEmployeeOccupation
        ,drvBenefitAmount  = CASE WHEN SelectedBenefit in ('VCI' ) THEN 
                                CAST((CASE    
                                
                                       WHEN Spouse is not null THEN 
                                       CASE WHEN BcaEEBenAmt_CIS05 is not null THEN BcaEEBenAmt_CIS05 
                                                     WHEN BcaEEBenAmt_CIS10 is not null THEN BcaEEBenAmt_CIS10 
                                                    WHEN BcaEEBenAmt_CRITS is not null THEN BcaEEBenAmt_CRITS 
                                                END
                
                                END) as varchar(12))
                             END
        ,drvPayTypeEEorER 
        ,drvContributionTaxability 
        ,drvPayMode 
        ,drvPlanIdentifier
        ,drvPayrollPremiumDeduction 
        ,drvOpenField  
        from dbo.U_ERELCIAEXP_drvTbl JOIN dbo.U_dsi_BDM_ERELCIAEXP_Consolidated
            on Bdmeeid = drveeid and bdmcoid = drvcoid
 where   drvSelectedBenefit = 'VCI' and drvDepRecId is null and spouse is not null and selectedbenefit= 'VCI'


 Update U_ERELCIAEXP_drvTbl set drvDependentSSN = '' where LEFT(drvDependentSSN,4) in ('9999','9998')

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwERELCIAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ERELCIAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ERELCIAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005201'
       ,expStartPerControl     = '202005201'
       ,expLastEndPerControl   = '202005279'
       ,expEndPerControl       = '202005279'
WHERE expFormatCode = 'ERELCIAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERELCIAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERELCIAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2