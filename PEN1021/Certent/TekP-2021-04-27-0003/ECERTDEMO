SET NOCOUNT ON;
IF OBJECT_ID('U_ECERTDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECERTDEMO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECERTDEMO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECERTDEMO' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECERTDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECERTDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECERTDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECERTDEMO];
GO
IF OBJECT_ID('U_ECERTDEMO_Header') IS NOT NULL DROP TABLE [dbo].[U_ECERTDEMO_Header];
GO
IF OBJECT_ID('U_ECERTDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_ECERTDEMO_File];
GO
IF OBJECT_ID('U_ECERTDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECERTDEMO_EEList];
GO
IF OBJECT_ID('U_ECERTDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECERTDEMO_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECERTDEMO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECERTDEMO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECERTDEMO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECERTDEMO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECERTDEMO';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECERTDEMO','Certent Demo File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECERTDEMO0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECERTDEMO' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvParticipantID "','1','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','1',NULL,'Equityholder Code / Participant ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvSSN_TaxID"','2','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','2',NULL,'SSN/Tax ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvFirstName "','3','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvMiddleName"','4','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','4',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvLastName "','5','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvHomeAddLine1"','6','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','6',NULL,'Homene 1  Address Li',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvHomeAddLine2"','7','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','7',NULL,'Home Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvHomeAddLine3"','8','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','8',NULL,'Home Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvHomeDistrictorRegion"','9','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','9',NULL,'Home District or Region',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvHomeCity"','10','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','10',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrStateorProvince"','11','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','11',NULL,'Current State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrPostalCode"','12','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','12',NULL,'Current Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrCountry"','13','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','13',NULL,'Current Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkAddressLine1"','14','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','14',NULL,'Work Address Line1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkAddressLine2"','15','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','15',NULL,'Work Address Line2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkAddressLine3"','16','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','16',NULL,'Work Address Line3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkDistrictorRegion"','17','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','17',NULL,'Work District or Region',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkCity"','18','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','18',NULL,'Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkStateorProvince"','19','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','19',NULL,'Work State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkPostalCode"','20','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','20',NULL,'Work Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvWorkCountry"','21','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','21',NULL,'Work Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentPhone"','22','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','22',NULL,'Current Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentEmailAddress"','23','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','23',NULL,'Current Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvDateRelationshipStarted"','24','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','24',NULL,'Date Relationship Started',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvTerminationDate"','25','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','25',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvTerminationType"','26','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','26',NULL,'Termination Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrBlackoutInsider"','27','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','27',NULL,'Currently a Blackout Insider',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentlyOfficer"','28','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','28',NULL,'Currently an Officer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentlyDirector"','29','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','29',NULL,'Currently a Director',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrNamedExecutive"','30','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','30',NULL,'Currently a Named Executive',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrmore10Shareholder"','31','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','31',NULL,'Currently more Than 10% Shareholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvSection16Insider"','32','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','32',NULL,'Section 16 Insider',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCitizenshipCountry"','33','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','33',NULL,'Citizenship Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentJobTitle"','34','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','34',NULL,'Current Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentDepartment"','35','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','35',NULL,'Current Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentSection"','36','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','36',NULL,'Current Section',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvCurrentBranch"','37','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','37',NULL,'Current Branch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvSubsidiaryCode"','38','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','38',NULL,'Subsidiary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvExperienceGroup  "','39','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','39',NULL,'Experience Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvDateofBirth"','40','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','40',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvAsofDate"','41','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','41',NULL,'As of Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvAnnualSalary"','42','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','42',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvRetEligibilityDate"','43','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','43',NULL,'Retirement Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrvBasisofPayakaRateType"','44','(''UA''=''T,'')','ECERTDEMO0Z0','50','H','01','44',NULL,'Basis of Pay aka Rate Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantID "','1','(''UA''=''T,'')','ECERTDEMO0Z0','50','D','10','1',NULL,'Equityholder Code / Participant ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN_TaxID"','2','(''UA''=''T,'')','ECERTDEMO0Z0','50','D','10','2',NULL,'SSN/Tax ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName "','3','(''UA''=''T,'')','ECERTDEMO0Z0','50','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','4','(''UA''=''T,'')','ECERTDEMO0Z0','50','D','10','4',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName "','5','(''UA''=''T,'')','ECERTDEMO0Z0','50','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddLine1"','6','(''UA''=''T,'')','ECERTDEMO0Z0','50','D','10','6',NULL,'Homene 1  Address Li',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddLine2"','7','(''UA''=''T,'')','ECERTDEMO0Z0','51','D','10','7',NULL,'Home Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddLine2"','8','(''UA''=''T,'')','ECERTDEMO0Z0','52','D','10','8',NULL,'Home Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeDistrictorRegion"','9','(''UA''=''T,'')','ECERTDEMO0Z0','53','D','10','9',NULL,'Home District or Region',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCity"','10','(''UA''=''T,'')','ECERTDEMO0Z0','54','D','10','10',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrStateorProvince"','11','(''UA''=''T,'')','ECERTDEMO0Z0','55','D','10','11',NULL,'Current State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrPostalCode"','12','(''UA''=''T,'')','ECERTDEMO0Z0','56','D','10','12',NULL,'Current Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrCountry"','13','(''UA''=''T,'')','ECERTDEMO0Z0','57','D','10','13',NULL,'Current Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine1"','14','(''UA''=''T,'')','ECERTDEMO0Z0','58','D','10','14',NULL,'Work Address Line1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine2"','15','(''UA''=''T,'')','ECERTDEMO0Z0','59','D','10','15',NULL,'Work Address Line2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine3"','16','(''UA''=''T,'')','ECERTDEMO0Z0','60','D','10','16',NULL,'Work Address Line3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkDistrictorRegion"','17','(''UA''=''T,'')','ECERTDEMO0Z0','61','D','10','17',NULL,'Work District or Region',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','18','(''UA''=''T,'')','ECERTDEMO0Z0','62','D','10','18',NULL,'Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStateorProvince"','19','(''UA''=''T,'')','ECERTDEMO0Z0','63','D','10','19',NULL,'Work State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPostalCode"','20','(''UA''=''T,'')','ECERTDEMO0Z0','64','D','10','20',NULL,'Work Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCountry"','21','(''UA''=''T,'')','ECERTDEMO0Z0','65','D','10','21',NULL,'Work Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentPhone"','22','(''UA''=''T,'')','ECERTDEMO0Z0','66','D','10','22',NULL,'Current Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentEmailAddress"','23','(''UA''=''T,'')','ECERTDEMO0Z0','67','D','10','23',NULL,'Current Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateRelationshipStarted"','24','(''UD112''=''T,'')','ECERTDEMO0Z0','68','D','10','24',NULL,'Date Relationship Started',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','25','(''UD112''=''T,'')','ECERTDEMO0Z0','69','D','10','25',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationType"','26','(''UA''=''T,'')','ECERTDEMO0Z0','70','D','10','26',NULL,'Termination Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrBlackoutInsider"','27','(''UA''=''T,'')','ECERTDEMO0Z0','71','D','10','27',NULL,'Currently a Blackout Insider',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentlyOfficer"','28','(''UA''=''T,'')','ECERTDEMO0Z0','72','D','10','28',NULL,'Currently an Officer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentlyDirector"','29','(''UA''=''T,'')','ECERTDEMO0Z0','73','D','10','29',NULL,'Currently a Director',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrNamedExecutive"','30','(''UA''=''T,'')','ECERTDEMO0Z0','74','D','10','30',NULL,'Currently a Named Executive',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrmore10Shareholder"','31','(''UA''=''T,'')','ECERTDEMO0Z0','75','D','10','31',NULL,'Currently more Than 10% Shareholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSection16Insider"','32','(''UA''=''T,'')','ECERTDEMO0Z0','76','D','10','32',NULL,'Section 16 Insider',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCitizenshipCountry"','33','(''UA''=''T,'')','ECERTDEMO0Z0','77','D','10','33',NULL,'Citizenship Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentJobTitle"','34','(''UA''=''T,'')','ECERTDEMO0Z0','78','D','10','34',NULL,'Current Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDepartment"','35','(''UA''=''T,'')','ECERTDEMO0Z0','79','D','10','35',NULL,'Current Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentSection"','36','(''UA''=''T,'')','ECERTDEMO0Z0','80','D','10','36',NULL,'Current Section',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentBranch"','37','(''UA''=''T,'')','ECERTDEMO0Z0','81','D','10','37',NULL,'Current Branch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsidiaryCode"','38','(''UA''=''T,'')','ECERTDEMO0Z0','82','D','10','38',NULL,'Subsidiary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExperienceGroup  "','39','(''UA''=''T,'')','ECERTDEMO0Z0','83','D','10','39',NULL,'Experience Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','40','(''UD112''=''T,'')','ECERTDEMO0Z0','84','D','10','40',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAsofDate"','41','(''UD112''=''T,'')','ECERTDEMO0Z0','85','D','10','41',NULL,'As of Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','42','(''UA''=''T,'')','ECERTDEMO0Z0','86','D','10','42',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetEligibilityDate"','43','(''UD112''=''T,'')','ECERTDEMO0Z0','87','D','10','43',NULL,'Retirement Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasisofPayakaRateType"','44','(''UA''=''T,'')','ECERTDEMO0Z0','88','D','10','44',NULL,'Basis of Pay aka Rate Type',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECERTDEMO_20210808.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Certent Demo File','202108089','EMPEXPORT','ONDEMAND',NULL,'ECERTDEMO',NULL,NULL,NULL,'202108089','Aug  8 2021  1:17PM','Aug  8 2021  1:17PM','202108081',NULL,'','','202108081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202108089','EMPEXPORT','SCHEDULED',NULL,'ECERTDEMO',NULL,NULL,NULL,'202108089','Aug  8 2021  1:17PM','Aug  8 2021  1:17PM','202108081',NULL,'','','202108081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202108089','EMPEXPORT','TEST',NULL,'ECERTDEMO',NULL,NULL,NULL,'202108089','Aug  8 2021  1:17PM','Aug  8 2021  1:17PM','202108081',NULL,'','','202108081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTDEMO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTDEMO','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERTDEMO','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECERTDEMO' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECERTDEMO' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECERTDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECERTDEMO_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECERTDEMO','H01','dbo.U_ECERTDEMO_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECERTDEMO','D10','dbo.U_ECERTDEMO_drvTbl',NULL);
IF OBJECT_ID('U_ECERTDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECERTDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvParticipantID] char(9) NULL,
    [drvSSN_TaxID] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvHomeAddLine1] varchar(255) NULL,
    [drvHomeAddLine2] varchar(255) NULL,
    [drvHomeAddLine3] varchar(1) NOT NULL,
    [drvHomeDistrictorRegion] varchar(1) NOT NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvCurrStateorProvince] varchar(255) NULL,
    [drvCurrPostalCode] varchar(50) NULL,
    [drvCurrCountry] char(3) NULL,
    [drvWorkAddressLine1] varchar(1) NOT NULL,
    [drvWorkAddressLine2] varchar(1) NOT NULL,
    [drvWorkAddressLine3] varchar(1) NOT NULL,
    [drvWorkDistrictorRegion] varchar(1) NOT NULL,
    [drvWorkCity] varchar(255) NULL,
    [drvWorkStateorProvince] varchar(255) NULL,
    [drvWorkPostalCode] varchar(50) NULL,
    [drvWorkCountry] char(3) NULL,
    [drvCurrentPhone] varchar(1) NOT NULL,
    [drvCurrentEmailAddress] varchar(50) NULL,
    [drvDateRelationshipStarted] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTerminationType] char(6) NULL,
    [drvCurrBlackoutInsider] varchar(1) NOT NULL,
    [drvCurrentlyOfficer] varchar(150) NULL,
    [drvCurrentlyDirector] varchar(1) NOT NULL,
    [drvCurrNamedExecutive] varchar(1) NOT NULL,
    [drvCurrmore10Shareholder] varchar(1) NOT NULL,
    [drvSection16Insider] varchar(1) NOT NULL,
    [drvCitizenshipCountry] varchar(1) NOT NULL,
    [drvCurrentJobTitle] varchar(1) NOT NULL,
    [drvCurrentDepartment] varchar(1) NOT NULL,
    [drvCurrentSection] varchar(1) NOT NULL,
    [drvCurrentBranch] varchar(1) NOT NULL,
    [drvSubsidiaryCode] varchar(1) NOT NULL,
    [drvExperienceGroup] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvAsofDate] datetime NOT NULL,
    [drvAnnualSalary] varchar(1) NOT NULL,
    [drvRetEligibilityDate] varchar(1) NOT NULL,
    [drvBasisofPayakaRateType] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECERTDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_ECERTDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECERTDEMO_File') IS NULL
CREATE TABLE [dbo].[U_ECERTDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ECERTDEMO_Header') IS NULL
CREATE TABLE [dbo].[U_ECERTDEMO_Header] (
    [hrvParticipantID] varchar(32) NOT NULL,
    [hrvSSN_TaxID] varchar(10) NOT NULL,
    [hrvFirstName] varchar(10) NOT NULL,
    [hrvMiddleName] varchar(11) NOT NULL,
    [hrvLastName] varchar(9) NOT NULL,
    [hrvHomeAddLine1] varchar(19) NOT NULL,
    [hrvHomeAddLine2] varchar(19) NOT NULL,
    [hrvHomeAddLine3] varchar(19) NOT NULL,
    [hrvHomeDistrictorRegion] varchar(23) NOT NULL,
    [hrvHomeCity] varchar(9) NOT NULL,
    [hrvCurrStateorProvince] varchar(25) NOT NULL,
    [hrvCurrPostalCode] varchar(19) NOT NULL,
    [hrvCurrCountry] varchar(15) NOT NULL,
    [hrvWorkAddressLine1] varchar(18) NOT NULL,
    [hrvWorkAddressLine2] varchar(18) NOT NULL,
    [hrvWorkAddressLine3] varchar(18) NOT NULL,
    [hrvWorkDistrictorRegion] varchar(23) NOT NULL,
    [hrvWorkCity] varchar(9) NOT NULL,
    [hrvWorkStateorProvince] varchar(22) NOT NULL,
    [hrvWorkPostalCode] varchar(16) NOT NULL,
    [hrvWorkCountry] varchar(12) NOT NULL,
    [hrvCurrentPhone] varchar(13) NOT NULL,
    [hrvCurrentEmailAddress] varchar(21) NOT NULL,
    [hrvDateRelationshipStarted] varchar(25) NOT NULL,
    [hrvTerminationDate] varchar(16) NOT NULL,
    [hrvTerminationType] varchar(16) NOT NULL,
    [hrvCurrBlackoutInsider] varchar(28) NOT NULL,
    [hrvCurrentlyOfficer] varchar(19) NOT NULL,
    [hrvCurrentlyDirector] varchar(20) NOT NULL,
    [hrvCurrNamedExecutive] varchar(27) NOT NULL,
    [hrvCurrmore10Shareholder] varchar(35) NOT NULL,
    [hrvSection16Insider] varchar(18) NOT NULL,
    [hrvCitizenshipCountry] varchar(19) NOT NULL,
    [hrvCurrentJobTitle] varchar(17) NOT NULL,
    [hrvCurrentDepartment] varchar(18) NOT NULL,
    [hrvCurrentSection] varchar(15) NOT NULL,
    [hrvCurrentBranch] varchar(14) NOT NULL,
    [hrvSubsidiaryCode] varchar(15) NOT NULL,
    [hrvExperienceGroup] varchar(16) NOT NULL,
    [hrvDateofBirth] varchar(13) NOT NULL,
    [hrvAsofDate] varchar(10) NOT NULL,
    [hrvAnnualSalary] varchar(13) NOT NULL,
    [hrvRetEligibilityDate] varchar(27) NOT NULL,
    [hrvBasisofPayakaRateType] varchar(26) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECERTDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Penn Virgina Corp

Created By: Luis Lugo
Business Analyst: Richard Vars
Create Date: 08/08/2021
Service Request Number: TekP-2021-04-27-0003

Purpose: Certent Demo File

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECERTDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECERTDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECERTDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECERTDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECERTDEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERTDEMO', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERTDEMO', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERTDEMO', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECERTDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECERTDEMO';

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
    DELETE FROM dbo.U_ECERTDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECERTDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECERTDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECERTDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECERTDEMO_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvParticipantID = EecEmpNo
        ,drvSSN_TaxID = EepSsn
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = '' -- leave blank
        ,drvLastName = EepNameLast
        ,drvHomeAddLine1 = EepAddressLine1
        ,drvHomeAddLine2 = EepAddressLine2
        ,drvHomeAddLine3 = '' -- leave blank
        ,drvHomeDistrictorRegion = '' -- leave blank
        ,drvHomeCity = EepAddressCity
        ,drvCurrStateorProvince = EepAddressState
        ,drvCurrPostalCode = EepAddressZipCode
        ,drvCurrCountry = EepAddressCountry
        ,drvWorkAddressLine1 = '' -- leave blank
        ,drvWorkAddressLine2 = '' -- leave blank
        ,drvWorkAddressLine3 = '' -- leave blank
        ,drvWorkDistrictorRegion = '' -- leave blank
        ,drvWorkCity = LocAddresscity
        ,drvWorkStateorProvince = LocAddressState
        ,drvWorkPostalCode = LocAddresszipcode
        ,drvWorkCountry = EepAddressCountry
        ,drvCurrentPhone = '' -- leave blank
        ,drvCurrentEmailAddress = EepAddressEMail
        ,drvDateRelationshipStarted = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationType = CASE WHEN EecEmplStatus = 'T' THEN eectermreason END
        ,drvCurrBlackoutInsider = '' -- leave blank
        ,drvCurrentlyOfficer = EecJobTitle
        ,drvCurrentlyDirector = '' -- leave blank
        ,drvCurrNamedExecutive = '' -- leave blank
        ,drvCurrmore10Shareholder = '' -- leave blank
        ,drvSection16Insider = '' -- leave blank
        ,drvCitizenshipCountry = '' -- leave blank
        ,drvCurrentJobTitle = '' -- leave blank
        ,drvCurrentDepartment = '' -- leave blank
        ,drvCurrentSection = '' -- leave blank
        ,drvCurrentBranch = '' -- leave blank
        ,drvSubsidiaryCode = '' -- leave blank
        ,drvExperienceGroup = '' -- leave blank
        ,drvDateofBirth = EepDateOfBirth
        ,drvAsofDate = getdate()
        ,drvAnnualSalary = '' -- leave blank
        ,drvRetEligibilityDate = '' -- leave blank
        ,drvBasisofPayakaRateType = '' -- leave blank
    INTO dbo.U_ECERTDEMO_drvTbl
    FROM dbo.U_ECERTDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.location WITH (NOLOCK)
        ON loccode = eeclocation
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECERTDEMO_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECERTDEMO_Header;
    SELECT DISTINCT
         hrvParticipantID = 'Equityholder Code/Participant ID'
        ,hrvSSN_TaxID = 'SSN/Tax ID'
        ,hrvFirstName = 'First Name'--EepNameFirst
        ,hrvMiddleName = 'Middle Name'--LEFT(EepNameMiddle,1)
        ,hrvLastName = 'Last Name'--EepNameLast
        ,hrvHomeAddLine1 = 'Home Address Line 1'--EepAddressLine1
        ,hrvHomeAddLine2 = 'Home Address Line 2'--EepAddressLine2
        ,hrvHomeAddLine3 = 'Home Address Line 3'--EepAddressLine2
        ,hrvHomeDistrictorRegion = 'Home District or Region'
        ,hrvHomeCity = 'Home City'--EepAddressCity
        ,hrvCurrStateorProvince ='Current State or Province'-- EepAddressState
        ,hrvCurrPostalCode = 'Current Postal Code'--EepAddressZipCode
        ,hrvCurrCountry = 'Current Country'--EepAddressCountry
        ,hrvWorkAddressLine1 ='Work Address Line1'-- EepAddressLine1
        ,hrvWorkAddressLine2 = 'Work Address Line2'--EepAddressLine2
        ,hrvWorkAddressLine3 = 'Work Address Line3'
        ,hrvWorkDistrictorRegion = 'Work District or Region'
        ,hrvWorkCity = 'Work City'--EepAddressCity
        ,hrvWorkStateorProvince ='Work State or Province'-- EepAddressState
        ,hrvWorkPostalCode = 'Work Postal Code'--EepAddressZipCode
        ,hrvWorkCountry = 'Work Country'--EepAddressCountry
        ,hrvCurrentPhone = 'Current Phone'
        ,hrvCurrentEmailAddress ='Current Email Address'-- EepAddressEMail
        ,hrvDateRelationshipStarted = 'Date Relationship Started'
        ,hrvTerminationDate = 'Termination Date'--CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,hrvTerminationType = 'Termination Type'
        ,hrvCurrBlackoutInsider = 'Currently a Blackout Insider'
        ,hrvCurrentlyOfficer = 'Currently an Office'
        ,hrvCurrentlyDirector = 'Currently a Director'
        ,hrvCurrNamedExecutive = 'Currently a Named Executive'
        ,hrvCurrmore10Shareholder = 'Currently more Than 10% Shareholder'
        ,hrvSection16Insider = 'Section 16 Insider'
        ,hrvCitizenshipCountry = 'Citizenship Country'--EepAddressCountry
        ,hrvCurrentJobTitle = 'Current Job Title'
        ,hrvCurrentDepartment = 'Current Department'
        ,hrvCurrentSection = 'Current Section'
        ,hrvCurrentBranch = 'Current Branch'
        ,hrvSubsidiaryCode = 'Subsidiary Code'
        ,hrvExperienceGroup = 'Experience Group'
        ,hrvDateofBirth = 'Date of Birth'--EepDateOfBirth
        ,hrvAsofDate = 'As of Date'
        ,hrvAnnualSalary = 'Annual Salary'
        ,hrvRetEligibilityDate = 'Retirement Eligibility Date'
        ,hrvBasisofPayakaRateType = 'Basis of Pay aka Rate Type'
    INTO dbo.U_ECERTDEMO_Header
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ClientName_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + ''
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_ClientName_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + ''
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_ClientName_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + ''
                                  ELSE 'ClientName_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + ''
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECERTDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECERTDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECERTDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108011'
       ,expStartPerControl     = '202108011'
       ,expLastEndPerControl   = '202108089'
       ,expEndPerControl       = '202108089'
WHERE expFormatCode = 'ECERTDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECERTDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECERTDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
