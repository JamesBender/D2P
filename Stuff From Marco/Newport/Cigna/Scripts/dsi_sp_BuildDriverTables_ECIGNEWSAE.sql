SET NOCOUNT ON;
IF OBJECT_ID('U_ECIGNEWSAE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIGNEWSAE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIGNEWSAE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIGNEWSAE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGNEWSAE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGNEWSAE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNEWSAE];
GO
IF OBJECT_ID('U_ECIGNEWSAE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_PEarHist];
GO
IF OBJECT_ID('U_ECIGNEWSAE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_PDedHist];
GO
IF OBJECT_ID('U_ECIGNEWSAE_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_File];
GO
IF OBJECT_ID('U_ECIGNEWSAE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_EEList];
GO
IF OBJECT_ID('U_ECIGNEWSAE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_drvTbl];
GO
IF OBJECT_ID('U_ECIGNEWSAE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGNEWSAE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGNEWSAE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIGNEWSAE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIGNEWSAE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIGNEWSAE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIGNEWSAE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIGNEWSAE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIGNEWSAE','Cigna Critical Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECIGNEWSAEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIGNEWSAE' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Legal Company Name"','1','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','1',NULL,'Legal Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client ID"','2','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','2',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE First Name"','3','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','3',NULL,'EE First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Last Name"','4','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','4',NULL,'EE Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Street Address"','5','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','5',NULL,'EE Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE City"','6','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','6',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE State"','7','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','7',NULL,'EE State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Zip Code"','8','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','8',NULL,'EE Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE SSN"','9','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','9',NULL,'EE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Gender"','10','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','10',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DOB"','11','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','11',NULL,'EE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Smoker Status"','12','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','12',NULL,'EE Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Date of Hire"','13','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','13',NULL,'EE Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status"','14','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','14',NULL,'EE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Status Date"','15','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','15',NULL,'EE Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE LOA Type"','16','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','16',NULL,'EE LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Product Class"','17','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','17',NULL,'Cigna Product Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna Billing Account"','18','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','18',NULL,'Cigna Billing Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Elected"','19','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','19',NULL,'Benefit Elected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Election Date"','20','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','20',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Effective Date"','21','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','21',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QLE/Revised Eligibility Date"','22','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Type"','23','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','23',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI/CI/HC Coverage Tier"','24','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE CI Approved Coverage Amount"','25','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP CI Approved Coverage Amount"','26','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Coverage Effective Date"','27','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','27',NULL,'SP Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH CI Approved Coverage Amount"','28','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Coverage Effective Date"','29','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','29',NULL,'CH Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP First Name"','30','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','30',NULL,'SP First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Last Name"','31','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','31',NULL,'SP Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP SSN"','32','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','32',NULL,'SP SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Gender"','33','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','33',NULL,'SP Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DOB"','34','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','34',NULL,'SP DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Smoker Status"','35','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','35',NULL,'SP Smoker Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency"','36','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','36',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Deduction  Amt"','37','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','37',NULL,'Payroll Deduction  Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Premium Paid to Date"','38','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','38',NULL,'Premium Paid to Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI termination Status Code"','39','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','39',NULL,'AI termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AI Termination Status Effective Date"','40','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','40',NULL,'AI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Code"','41','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','41',NULL,'CI Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Termination Status Effective Date"','42','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','42',NULL,'CI Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Code"','43','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','43',NULL,'HC Termination Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HC Termination Status Effective Date"','44','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','44',NULL,'HC Termination Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover Indicator"','45','(''DA''=''T,'')','ECIGNEWSAEZ0','50','H','01','45',NULL,'Takeover Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"File Type"','46','(''DA''=''T'')','ECIGNEWSAEZ0','50','H','01','46',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLegalCompanyName"','1','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','1',NULL,'drvLegalCompanyName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientID"','2','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','2',NULL,'drvClientID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEFirstName"','3','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','3',NULL,'drvEEFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELastName"','4','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','4',NULL,'drvEELastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStreetAddress"','5','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','5',NULL,'drvEEStreetAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECity"','6','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','6',NULL,'drvEECity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEState"','7','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','7',NULL,'drvEEState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEZipCode"','8','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','8',NULL,'drvEEZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESSN"','9','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','9',NULL,'drvEESSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEGender"','10','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','10',NULL,'drvEEGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDOB"','11','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','11',NULL,'drvEEDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESmokerStatus"','12','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','12',NULL,'drvEESmokerStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateofHire"','13','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','13',NULL,'drvEEDateofHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatus"','14','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','14',NULL,'drvEEStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatusDate"','15','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','15',NULL,'drvEEStatusDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELOAType"','16','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','16',NULL,'drvEELOAType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCignaProductClass"','17','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','17',NULL,'drvCignaProductClass',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCignaBillingAccount"','18','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','18',NULL,'drvCignaBillingAccount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitElected"','19','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','19',NULL,'drvBenefitElected',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageElectionDate"','20','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','20',NULL,'drvCoverageElectionDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDate"','21','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','21',NULL,'drvCoverageEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQLERevisedEligibilityDate"','22','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','22',NULL,'drvQLERevisedEligibilityDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','23','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','23',NULL,'drvPlanType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAICIHCCoverageTier"','24','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','24',NULL,'drvAICIHCCoverageTier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECIApprovedCoverageAmount"','25','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','25',NULL,'drvEECIApprovedCoverageAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCIApprovedCoverageAmount"','26','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','26',NULL,'drvSPCIApprovedCoverageAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCoverageEffectiveDate"','27','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','27',NULL,'drvSPCoverageEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCIApprovedCoverageAmount"','28','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','28',NULL,'drvCHCIApprovedCoverageAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCoverageEffectiveDate"','29','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','29',NULL,'drvCHCoverageEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPFirstName"','30','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','30',NULL,'drvSPFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPLastName"','31','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','31',NULL,'drvSPLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPSSN"','32','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','32',NULL,'drvSPSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPGender"','33','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','33',NULL,'drvSPGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPDOB"','34','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','34',NULL,'drvSPDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPSmokerStatus"','35','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','35',NULL,'drvSPSmokerStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','36','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','36',NULL,'drvPayrollFrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDeductionAmt"','37','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','37',NULL,'drvPayrollDeductionAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumPaidtoDate"','38','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','38',NULL,'drvPremiumPaidtoDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAIterminationStatusCode"','39','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','39',NULL,'drvAIterminationStatusCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAITerminationStatusEffDate"','40','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','40',NULL,'drvAITerminationStatusEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITerminationStatusCode"','41','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','41',NULL,'drvCITerminationStatusCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITerminationStatusEffDate"','42','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','42',NULL,'drvCITerminationStatusEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCTerminationStatusCode"','43','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','43',NULL,'drvHCTerminationStatusCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCTerminationStatusEffDate"','44','(''UD101''=''T,'')','ECIGNEWSAEZ0','50','D','10','44',NULL,'drvHCTerminationStatusEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeoverIndicator"','45','(''UA''=''T,'')','ECIGNEWSAEZ0','50','D','10','45',NULL,'drvTakeoverIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','46','(''UA''=''T'')','ECIGNEWSAEZ0','50','D','10','46',NULL,'drvFileType',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECIGNEWSAE_20211012.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202108199','EMPEXPORT','OEACTIVE',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202108199','EMPEXPORT','OEPASSIVE',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Newport Cigna SA Export','202108199','EMPEXPORT','ONDEMAND',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202108199','EMPEXPORT','SCH_CICSX',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','U5P4Y,CXNNJ',NULL,NULL,NULL,'Test Purposes Only','202110061','EMPEXPORT','TEST','Oct  6 2021  2:33PM','ECIGNEWSAE',NULL,NULL,NULL,'202110061','Oct  6 2021 12:00AM','Dec 30 1899 12:00AM','202109291','108','','','202109291',dbo.fn_GetTimedKey(),NULL,'us3cPeNEW1020',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECIGNEWSAE' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECIGNEWSAE' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECIGNEWSAE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNEWSAE','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNEWSAE','D10','dbo.U_ECIGNEWSAE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECIGNEWSAE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGNEWSAE] (
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
IF OBJECT_ID('U_ECIGNEWSAE_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIGNEWSAE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvLegalCompanyName] varchar(13) NOT NULL,
    [drvClientID] varchar(6) NOT NULL,
    [drvEEFirstName] varchar(100) NULL,
    [drvEELastName] varchar(100) NULL,
    [drvEEStreetAddress] varchar(6000) NULL,
    [drvEECity] varchar(255) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEZipCode] varchar(5) NULL,
    [drvEESSN] char(11) NULL,
    [drvEEGender] char(1) NULL,
    [drvEEDOB] datetime NULL,
    [drvEESmokerStatus] varchar(1) NULL,
    [drvEEDateofHire] datetime NULL,
    [drvEEStatus] varchar(1) NOT NULL,
    [drvEEStatusDate] datetime NULL,
    [drvEELOAType] varchar(1) NULL,
    [drvCignaProductClass] varchar(3) NOT NULL,
    [drvCignaBillingAccount] varchar(3) NOT NULL,
    [drvBenefitElected] varchar(3) NULL,
    [drvCoverageElectionDate] varchar(1) NOT NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvQLERevisedEligibilityDate] varchar(1) NOT NULL,
    [drvPlanType] varchar(8) NULL,
    [drvAICIHCCoverageTier] varchar(10) NULL,
    [drvEECIApprovedCoverageAmount] varchar(5) NULL,
    [drvSPCIApprovedCoverageAmount] varchar(30) NULL,
    [drvSPCoverageEffectiveDate] datetime NULL,
    [drvCHCIApprovedCoverageAmount] varchar(30) NULL,
    [drvCHCoverageEffectiveDate] datetime NULL,
    [drvSPFirstName] varchar(100) NULL,
    [drvSPLastName] varchar(100) NULL,
    [drvSPSSN] char(11) NULL,
    [drvSPGender] char(1) NULL,
    [drvSPDOB] datetime NULL,
    [drvSPSmokerStatus] varchar(1) NULL,
    [drvPayrollFrequency] varchar(2) NOT NULL,
    [drvPayrollDeductionAmt] varchar(30) NULL,
    [drvPremiumPaidtoDate] varchar(1) NOT NULL,
    [drvAIterminationStatusCode] varchar(1) NULL,
    [drvAITerminationStatusEffDate] datetime NULL,
    [drvCITerminationStatusCode] varchar(1) NULL,
    [drvCITerminationStatusEffDate] datetime NULL,
    [drvHCTerminationStatusCode] varchar(1) NULL,
    [drvHCTerminationStatusEffDate] datetime NULL,
    [drvTakeoverIndicator] varchar(1) NOT NULL,
    [drvFileType] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECIGNEWSAE_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIGNEWSAE_File') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ECIGNEWSAE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_PDedHist] (
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
IF OBJECT_ID('U_ECIGNEWSAE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNEWSAE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Newport Group, Inc.

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 08/19/2021
Service Request Number: SR-2016-00012345

Purpose: Newport Cigna SA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGNEWSAE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGNEWSAE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGNEWSAE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGNEWSAE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGNEWSAE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGNEWSAE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGNEWSAE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGNEWSAE';

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
    DELETE FROM dbo.U_ECIGNEWSAE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGNEWSAE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HOSPI, AI, CIC25, CIE05, CIE10, CIE15, CIE20, CIS05, CIS10';

    IF OBJECT_ID('U_ECIGNEWSAE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGNEWSAE_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DependentBenefitAgeGradedRate','CIS05,CIS10,CIC25');

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


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECIGNEWSAE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_PDedHist;
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
    INTO dbo.U_ECIGNEWSAE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIGNEWSAE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECIGNEWSAE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl and PehEarnCode in ('PTO','SICK') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECIGNEWSAE_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIGNEWSAE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGNEWSAE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvLegalCompanyName = 'Newport Group'
        ,drvClientID = '301241'
        ,drvEEFirstName = EepNameFirst
        ,drvEELastName = EepNameLast
        ,drvEEStreetAddress = dbo.dsi_fnRemoveChars(',',Isnull(eepaddressline1,'') + ISNULL(eepaddressline2,''))
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEZipCode = LEFT(EepAddressZipCode,5)
        ,drvEESSN = eepSSN
        ,drvEEGender = EepGender
        ,drvEEDOB = EepDateOfBirth
        ,drvEESmokerStatus = eepIsSmoker
        ,drvEEDateofHire = eecDateofLastHire
        ,drvEEStatus = CASE WHEN EecEmplStatus = 'T' and eecTermReason <> '203' THEN 'T'
                            WHEN EecEmplStatus = 'L' THEN 'L'
                            WHEN EecEmplStatus = 'T' and eecTermReason  = '203' THEN 'D'
                            ELSE 'A'
                       END
        ,drvEEStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateLastWorked
                            WHEN EecEmplStatus = 'L' THEN Dateadd(day,-1,EecEmplStatusStartDate)
                            
                       END
        ,drvEELOAType = CASE WHEN EecEmplStatus = 'L' THEN 
                                CASE WHEN PehCurHrs > 0 THEN 'P' ELSE 'U' END
                            END
        ,drvCignaProductClass = '001'
        ,drvCignaBillingAccount = '001'
        ,drvBenefitElected = PLAN_Code
        ,drvCoverageElectionDate = ''
        ,drvCoverageEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',bdmConsolidated.StartDate, CAST('1/1/2021' as datetime) )
        ,drvQLERevisedEligibilityDate = ''
        ,drvPlanType = CASE WHEN PLAN_Code = 'VHC' THEN 'HC960956'
                            WHEN PLAN_Code = 'VAI' THEN 'AI961746'
                            WHEN PLAN_Code IN ('VCI') THEN 'CI961662'
                            END
        ,drvAICIHCCoverageTier = CASE WHEN PLAN_Code in ('VHC','VAI') THEN        
                                            CASE WHEN BenOptions = 'EE' THEN 'EE'
                                                 WHEN BenOptions IN ('EES','EEDP') THEN 'EE Plus SP'    
                                                 WHEN BenOptions IN ('EEC') THEN 'EE Plus CH'
                                                 WHEN BenOptions IN ('EEF','EEDPF') THEN 'Family'
                                            END
                                        WHEN PLAN_Code = 'VCI'  THEN
                                                CASE WHEN SPS is null and CHD is not null then 'EE Plus CH'
                                                     WHEN CHD is not null and SPS is not null then 'Family'
                                                     WHEN SPS is not null and CHD is null then 'EE Plus SP'
                                                    ELSE 'EE'
                                                END
                                 END
        ,drvEECIApprovedCoverageAmount = Amount
        ,drvSPCIApprovedCoverageAmount = CASE WHEN SPS is not null then CAST(SPS_AMT as varchar) END
        ,drvSPCoverageEffectiveDate = CASE 
                                                WHEN PLAN_Code in ('VHC','VAI') and  BenOptions IN ('EES','EEDP','EEF','EEDPF') THEN  dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                                WHEN SPS is not null then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                           
                                           END
        ,drvCHCIApprovedCoverageAmount = CASE WHEN CHD is not null then Cast( CONVERT(DECIMAL(10,0),(Cast (Amount as money) * 0.25)) as varchar) END
        ,drvCHCoverageEffectiveDate = CASE 
                                            WHEN PLAN_Code in ('VHC','VAI') and BenOptions IN ('EEC','EEF','EEDPF') THEN dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                            WHEN CHD is not null then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                           
                                             END
        ,drvSPFirstName = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConNameFirst from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPLastName = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConNameLast from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPSSN = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConSSN from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPGender = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConGender from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPDOB = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConDateOfBirth from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPSmokerStatus = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConIsSmoker from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvPayrollFrequency = '26'
        ,drvPayrollDeductionAmt = CASE WHEN PLAN_Code = 'VAI' THEN CAST(BenefitAmounts.VAI as varchar) 
                                        WHEN PLAN_Code = 'VHC' THEN CAST(BenefitAmounts.VHC as varchar)
                                        WHEN PLAN_Code = 'VCI' THEN CAST(BenefitAmounts.VCI + ISNULL(BenefitAmounts.VCI_Dep,0) as varchar)
                                         END
        ,drvPremiumPaidtoDate = ''
        ,drvAIterminationStatusCode = CASE WHEN PLAN_Code = 'VAI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN 'T' END
        ,drvAITerminationStatusEffDate = CASE WHEN PLAN_Code = 'VAI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN StopDate END
        ,drvCITerminationStatusCode = CASE WHEN PLAN_Code = 'VCI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN 'T' END
        ,drvCITerminationStatusEffDate = CASE WHEN PLAN_Code = 'VCI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN StopDate END
        ,drvHCTerminationStatusCode = CASE WHEN PLAN_Code = 'VHC' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN 'T' END
        ,drvHCTerminationStatusEffDate = CASE WHEN PLAN_Code = 'VHC' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN StopDate END
        ,drvTakeoverIndicator = ''
        ,drvFileType = 'F'
    INTO dbo.U_ECIGNEWSAE_drvTbl
    FROM dbo.U_ECIGNEWSAE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    LEFT JOIN dbo.U_ECIGNEWSAE_PEarHist  WITH (NOLOCK)
        on PehEEID =  xeeid
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select bdmeeid,bdmcoid,
    BenOptions= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN BdmBenOption
                                  WHEN bdmDedCode = 'AI' THEN BdmBenOption
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN BdmBenOption
                             END 
                             ),
    CASE WHEN bdmDedCode='HOSPI' THEN 'VHC'
                                  WHEN bdmDedCode = 'AI' THEN 'VAI'
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN 'VCI'
                             END AS PLAN_Code,
            StartDate= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN bdmbenstartdate
                                  WHEN bdmDedCode = 'AI' THEN bdmbenstartdate
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN bdmbenstartdate
                             END 
                             ),
            StopDate= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN bdmbenstopdate
                                  WHEN bdmDedCode = 'AI' THEN bdmbenstopdate
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN bdmbenstopdate
                             END 
                             ),
            SPS = MAX(CASE WHEN bdmdedcode in ('CIS05','CIS10') THEN '1' END ) ,
            SPS_AMT = MAX(CASE  WHEN BdmDedCode = 'CIS05' THEN '5000'
                    WHEN BdmDedCode = 'CIS10' THEN '10000'
                 END ) ,
            CHD = MAX(CASE WHEN bdmdedcode in ('CIC25') THEN '1' END ) ,

            BenefitAmount =  MAX(    CASE 
                                  WHEN bdmDedCode = 'AI' THEN bdmeeamt 
                                  WHEN bdmdedcode = 'HOSPI' THEN bdmeeamt
                                  END
                             ),
            Amount = MAX(CASE WHEN bdmDedCode = 'CIE05' THEN '5000'
                            WHEN bdmDedCode = 'CIE10' THEN '10000'
                            WHEN bdmDedCode = 'CIE15' THEN '15000'
                            WHEN bdmDedCode = 'CIE20' THEN '20000'
                            WHEN BdmDedCode = 'CIS05' THEN '5000'
                            WHEN BdmDedCode = 'CIS10' THEN '10000'
                            END),
            BenStatus= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN BdmBenStatus
                                  WHEN bdmDedCode = 'AI' THEN BdmBenStatus
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN BdmBenStatus
                             END 
                             )
 from dbo.U_dsi_BDM_ECIGNEWSAE 

 group by bdmeeid,bdmcoid,CASE WHEN bdmDedCode='HOSPI' THEN 'VHC'
                                  WHEN bdmDedCode = 'AI' THEN 'VAI'
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN 'VCI'
                             END) as bdmConsolidated
        ON bdmConsolidated.BdmCOID =  xCOID
        and bdmConsolidated.BdmEEID =  xeeid
LEFT JOIN (Select bcacoid, bcaeeid,VCI = MAX(CASE WHEN  bcadedcode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10') THEN BcaEEAmt END ) ,
       VAI = MAX(CASE WHEN  bcadedcode IN('AI') THEN BcaEEAmt END ) ,
       VHC = MAX(CASE WHEN  bcadedcode IN('HOSPI') THEN BcaEEAmt END ),
           VCI_Dep = MAX(CASE WHEN  bcadedcode IN('CIC25', 'CIS05', 'CIS10') THEN EedEeLstAmt END )
 
from U_dsi_bdm_BenCalculationAmounts JOIN 
dbo.EmpDed on bcaeeid = eedeeid and bcacoid =  eedcoid
and bcadedcode = eeddedcode
where bcaformatcode = 'ECIGNEWSAE' 
group by bcacoid, bcaeeid) AS BenefitAmounts
    on BenefitAmounts.bcaeeid =  xeeid
    and BenefitAmounts.bcacoid =xcoid

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
ALTER VIEW dbo.dsi_vwECIGNEWSAE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGNEWSAE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGNEWSAE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108121'
       ,expStartPerControl     = '202108121'
       ,expLastEndPerControl   = '202108199'
       ,expEndPerControl       = '202108199'
WHERE expFormatCode = 'ECIGNEWSAE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGNEWSAE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGNEWSAE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2