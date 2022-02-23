SET NOCOUNT ON;
IF OBJECT_ID('U_ENUCCOMFML_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ENUCCOMFML_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ENUCCOMFML' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwENUCCOMFML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENUCCOMFML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENUCCOMFML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENUCCOMFML];
GO
IF OBJECT_ID('U_ENUCCOMFML_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_PEarHist];
GO
IF OBJECT_ID('U_ENUCCOMFML_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_PDedHist];
GO
IF OBJECT_ID('U_ENUCCOMFML_File') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_File];
GO
IF OBJECT_ID('U_ENUCCOMFML_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_EEList];
GO
IF OBJECT_ID('U_ENUCCOMFML_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_drvTbl];
GO
IF OBJECT_ID('U_ENUCCOMFML_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ENUCCOMFML') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENUCCOMFML];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENUCCOMFML';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENUCCOMFML';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENUCCOMFML';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENUCCOMFML';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENUCCOMFML';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENUCCOMFML','Compsych FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','ENUCCOMFMLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ENUCCOMFML' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number "','1','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','1',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Name"','2','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','2',NULL,'Account Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID # "','3','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','3',NULL,'Employee ID #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN#"','4','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','4',NULL,'Employee SSN#',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','6','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','6',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','7','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address Line #1"','8','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','8',NULL,'Home Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address Line #2"','9','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','9',NULL,'Home Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home City"','10','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','10',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home State / Providence"','11','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','11',NULL,'Home State / Providence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Zip / Postal Code"','12','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','12',NULL,'Home Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Country"','13','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','13',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home (or Primary) Phone #"','14','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','14',NULL,'Home (or Primary) Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','15','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','16','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','16',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Language"','17','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','17',NULL,'Primary Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Address ID"','18','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','18',NULL,'Work Address ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Address Line #1"','19','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','19',NULL,'Work Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Address Line #2"','20','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','20',NULL,'Work Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work City"','21','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','21',NULL,'Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State / Providence"','22','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','22',NULL,'Work State / Providence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Zip"','23','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','23',NULL,'Work Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Country"','24','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','24',NULL,'Work Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone #"','25','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','25',NULL,'Work Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Extension"','26','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','26',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Unit"','27','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','27',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization"','28','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','28',NULL,'Organization',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #1 "','29','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','29',NULL,'Employee Group #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #2"','30','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','30',NULL,'Employee Group #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #3"','31','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','31',NULL,'Employee Group #3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #4 "','32','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','32',NULL,'Employee Group #4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #5 "','33','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','33',NULL,'Employee Group #5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #6 "','34','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','34',NULL,'Employee Group #6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #7"','35','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','35',NULL,'Employee Group #7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group #8"','36','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','36',NULL,'Employee Group #8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full Time / Part Time Status"','37','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','37',NULL,'Full Time / Part Time Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','38','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','38',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adjusted Employment Date"','39','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','39',NULL,'Adjusted Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Anniversary Date"','40','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','40',NULL,'Anniversary Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','41','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','41',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked in the Previous 12 Months"','42','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','42',NULL,'Hours Worked in the Previous 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee"','43','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','43',NULL,'Key Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','44','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','44',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work E-mail Address"','45','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','45',NULL,'Work E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Hours per Week"','46','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','46',NULL,'Scheduled Hours per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled # of Days per Week"','47','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','47',NULL,'Scheduled # of Days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Letter Recipient E-mail"','48','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','48',NULL,'Additional Letter Recipient E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employed "','49','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','49',NULL,'Spouse Employed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employee ID"','50','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','50',NULL,'Spouse Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 1 IDS"','51','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','51',NULL,'Employer Contact 1 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Earnings"','52','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','52',NULL,'STD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Eligibility Date"','53','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','53',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eligibility Date"','54','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','54',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 2 IDS"','55','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','55',NULL,'Employer Contact 2 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 3 IDS"','56','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','56',NULL,'Employer Contact 3 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 4 IDS"','57','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','57',NULL,'Employer Contact 4 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 5 IDS"','58','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','58',NULL,'Employer Contact 5 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 6 IDS"','59','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','59',NULL,'Employer Contact 6 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 7 IDS"','60','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','60',NULL,'Employer Contact 7 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 8 IDS"','61','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','61',NULL,'Employer Contact 8 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 9 IDS"','62','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','62',NULL,'Employer Contact 9 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 10 IDS"','63','(''DA''=''T,'')','ENUCCOMFMLZ0','50','H','01','63',NULL,'Employer Contact 10 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','1','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','1',NULL,'drvAccountNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountName"','2','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','2',NULL,'drvAccountName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','3',NULL,'drvEmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','4','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','4',NULL,'drvEmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','5',NULL,'drvFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','6',NULL,'drvMiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','7',NULL,'drvLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddressLine1"','8','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','8',NULL,'drvHomeAddressLine1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddressLine2"','9','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','9',NULL,'drvHomeAddressLine2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCity"','10','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','10',NULL,'drvHomeCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeStateProvidence"','11','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','11',NULL,'drvHomeStateProvidence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeZipPostalCode"','12','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','12',NULL,'drvHomeZipPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCountry"','13','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','13',NULL,'drvHomeCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','14','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','14',NULL,'drvHomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','15',NULL,'drvGender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','16','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','16',NULL,'drvDateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryLanguage"','17','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','17',NULL,'drvPrimaryLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressID"','18','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','18',NULL,'drvWorkAddressID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine1"','19','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','19',NULL,'drvWorkAddressLine',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine2"','20','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','20',NULL,'drvWorkAddressLine',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','21','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','21',NULL,'drvWorkCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStateProvidence"','22','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','22',NULL,'drvWorkStateProvidence',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkZip"','23','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','23',NULL,'drvWorkZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCountry"','24','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','24',NULL,'drvWorkCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','25','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','25',NULL,'drvWorkPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExtension"','26','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','26',NULL,'drvWorkPhoneExtension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessUnit"','27','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','27',NULL,'drvBusinessUnit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganization"','28','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','28',NULL,'drvOrganization',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup1"','29','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','29',NULL,'drvEmployeeGroup1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup2 "','30','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','30',NULL,'drvEmployeeGroup2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup3 "','31','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','31',NULL,'drvEmployeeGroup3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup4 "','32','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','32',NULL,'drvEmployeeGroup4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup5 "','33','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','33',NULL,'drvEmployeeGroup5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup6 "','34','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','34',NULL,'drvEmployeeGroup6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup7 "','35','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','35',NULL,'drvEmployeeGroup7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup8 "','36','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','36',NULL,'drvEmployeeGroup8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimePartTimeStatus"','37','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','37',NULL,'drvFullTimePartTimeStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','38','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','38',NULL,'drvHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedEmploymentDate"','39','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','39',NULL,'drvAdjustedEmploymentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnniversaryDate"','40','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','40',NULL,'drvAnniversaryDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','41','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','41',NULL,'drvTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedinthePrevMonths"','42','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','42',NULL,'drvHoursWorkedinthePrevMonths',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployee"','43','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','43',NULL,'drvKeyEmployee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','44','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','44',NULL,'drvJobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','45','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','45',NULL,'drvWorkEmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHoursperWeek"','46','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','46',NULL,'drvScheduledHoursperWeek',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledofDaysperWeek"','47','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','47',NULL,'drvScheduledofDaysperWeek',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLetterRecipientEmail"','48','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','48',NULL,'drvAdditionalLetterRecipientEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmployed"','49','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','49',NULL,'drvSpouseEmployed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmployeeID"','50','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','50',NULL,'drvSpouseEmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContactIDS"','51','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','51',NULL,'drvEmployerContactIDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEarnings"','52','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','52',NULL,'drvSTDEarnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEligibilityDate"','53','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','53',NULL,'drvSTDEligibilityDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEligibilityDate"','54','(''UD101''=''T,'')','ENUCCOMFMLZ0','50','D','10','54',NULL,'drvLTDEligibilityDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact2IDS"','55','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','55',NULL,'drvEmployerContact2IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact3IDS"','56','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','56',NULL,'drvEmployerContact3IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact4IDS"','57','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','57',NULL,'drvEmployerContact4IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact5IDS"','58','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','58',NULL,'drvEmployerContact5IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact6IDS"','59','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','59',NULL,'drvEmployerContact6IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact7IDS"','60','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','60',NULL,'drvEmployerContact7IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact8IDS"','61','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','61',NULL,'drvEmployerContact8IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact9IDS"','62','(''UA''=''T,'')','ENUCCOMFMLZ0','50','D','10','62',NULL,'drvEmployerContact9IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerContact10IDS"','63','(''UA''=''T'')','ENUCCOMFMLZ0','50','D','10','63',NULL,'drvEmployerContact10IDS',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ENUCCOMFML_20210628.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202106239','EMPEXPORT','OEACTIVE',NULL,'ENUCCOMFML',NULL,NULL,NULL,'202106239','Jun 23 2021  5:59PM','Jun 23 2021  5:59PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202106239','EMPEXPORT','OEPASSIVE',NULL,'ENUCCOMFML',NULL,NULL,NULL,'202106239','Jun 23 2021  5:59PM','Jun 23 2021  5:59PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Compsych FMLA Export','202106239','EMPEXPORT','ONDEM_XOE',NULL,'ENUCCOMFML',NULL,NULL,NULL,'202106239','Jun 23 2021  5:59PM','Jun 23 2021  5:59PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Compsych FMLA Export-Sched','202106239','EMPEXPORT','SCH_ENUCCO',NULL,'ENUCCOMFML',NULL,NULL,NULL,'202106239','Jun 23 2021  5:59PM','Jun 23 2021  5:59PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Compsych FMLA Export-Test','202106259','EMPEXPORT','TEST_XOE','Jun 25 2021  8:52AM','ENUCCOMFML',NULL,NULL,NULL,'202106259','Jun 25 2021 12:00AM','Dec 30 1899 12:00AM','202106111','3170','','','202106111',dbo.fn_GetTimedKey(),NULL,'us3lKiNUC1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUCCOMFML','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ENUCCOMFML' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ENUCCOMFML' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ENUCCOMFML_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENUCCOMFML_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENUCCOMFML','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENUCCOMFML','D10','dbo.U_ENUCCOMFML_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ENUCCOMFML') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENUCCOMFML] (
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
IF OBJECT_ID('U_ENUCCOMFML_DedList') IS NULL
CREATE TABLE [dbo].[U_ENUCCOMFML_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ENUCCOMFML_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENUCCOMFML_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvAccountNumber] varchar(6) NOT NULL,
    [drvAccountName] varchar(5) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeSSN] nvarchar(258) NULL,
    [drvFirstName] nvarchar(258) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] nvarchar(258) NULL,
    [drvHomeAddressLine1] nvarchar(258) NULL,
    [drvHomeAddressLine2] nvarchar(258) NULL,
    [drvHomeCity] nvarchar(258) NULL,
    [drvHomeStateProvidence] varchar(255) NULL,
    [drvHomeZipPostalCode] varchar(50) NULL,
    [drvHomeCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvPrimaryLanguage] varchar(1) NOT NULL,
    [drvWorkAddressID] varchar(1) NOT NULL,
    [drvWorkAddressLine1] varchar(1) NOT NULL,
    [drvWorkAddressLine2] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvWorkStateProvidence] varchar(255) NULL,
    [drvWorkZip] varchar(1) NOT NULL,
    [drvWorkCountry] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExtension] varchar(1) NOT NULL,
    [drvBusinessUnit] varchar(10) NULL,
    [drvOrganization] varchar(10) NULL,
    [drvEmployeeGroup1] varchar(10) NULL,
    [drvEmployeeGroup2] varchar(10) NULL,
    [drvEmployeeGroup3] varchar(1) NOT NULL,
    [drvEmployeeGroup4] varchar(1) NOT NULL,
    [drvEmployeeGroup5] varchar(1) NOT NULL,
    [drvEmployeeGroup6] varchar(1) NOT NULL,
    [drvEmployeeGroup7] varchar(1) NOT NULL,
    [drvEmployeeGroup8] varchar(1) NOT NULL,
    [drvFullTimePartTimeStatus] char(1) NULL,
    [drvHireDate] datetime NULL,
    [drvAdjustedEmploymentDate] datetime NULL,
    [drvAnniversaryDate] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvHoursWorkedinthePrevMonths] varchar(30) NULL,
    [drvKeyEmployee] varchar(1) NOT NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvScheduledHoursperWeek] varchar(30) NULL,
    [drvScheduledofDaysperWeek] varchar(1) NOT NULL,
    [drvAdditionalLetterRecipientEmail] varchar(1) NOT NULL,
    [drvSpouseEmployed] varchar(1) NOT NULL,
    [drvSpouseEmployeeID] varchar(1) NOT NULL,
    [drvEmployerContactIDS] varchar(256) NULL,
    [drvSTDEarnings] varchar(30) NULL,
    [drvSTDEligibilityDate] datetime NULL,
    [drvLTDEligibilityDate] datetime NULL,
    [drvEmployerContact2IDS] varchar(1) NOT NULL,
    [drvEmployerContact3IDS] varchar(1) NOT NULL,
    [drvEmployerContact4IDS] varchar(1) NOT NULL,
    [drvEmployerContact5IDS] varchar(1) NOT NULL,
    [drvEmployerContact6IDS] varchar(1) NOT NULL,
    [drvEmployerContact7IDS] varchar(1) NOT NULL,
    [drvEmployerContact8IDS] varchar(1) NOT NULL,
    [drvEmployerContact9IDS] varchar(1) NOT NULL,
    [drvEmployerContact10IDS] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ENUCCOMFML_EEList') IS NULL
CREATE TABLE [dbo].[U_ENUCCOMFML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENUCCOMFML_File') IS NULL
CREATE TABLE [dbo].[U_ENUCCOMFML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_ENUCCOMFML_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENUCCOMFML_PDedHist] (
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
IF OBJECT_ID('U_ENUCCOMFML_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENUCCOMFML_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENUCCOMFML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NuCO2 Supply

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/23/2021
Service Request Number: TekP-2021-04-23-0001

Purpose: Compsych FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENUCCOMFML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENUCCOMFML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENUCCOMFML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENUCCOMFML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENUCCOMFML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUCCOMFML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUCCOMFML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUCCOMFML', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUCCOMFML', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUCCOMFML', 'SCH_ENUCCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENUCCOMFML';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ENUCCOMFML', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'ENUCCOMFML';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


        SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENUCCOMFML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENUCCOMFML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     DELETE FROM dbo.U_ENUCCOMFML_EEList
    WHERE  xEEID IN (Select eepeeid from dbo.EmpPers where eepssn in ('111111112'  ,'123456789'  ,'222222223'  ,'333333339'  ,'444444441'  ,'999999998','222222221'))


     DELETE FROM dbo.U_ENUCCOMFML_EEList
    WHERE  xEEID IN (Select eeceeid from dbo.EmpComp where eeceetype = 'Z' or eecemplstatus ='T')




    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD,LTD2,LTD5';

    IF OBJECT_ID('U_ENUCCOMFML_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENUCCOMFML_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENUCCOMFML_DedList
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
    /*
    IF OBJECT_ID('U_ENUCCOMFML_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENUCCOMFML_PDedHist;
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
    INTO dbo.U_ENUCCOMFML_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENUCCOMFML_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    */

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ENUCCOMFML_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENUCCOMFML_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN LEFT(PehPerControl,4) = LEFT(@EndPerControl,4) - 1  and PehEarnCode IN 
('CODT' ,'COLB' ,'COOT' ,'DBLTM','DTLB' ,'OT'   ,'ADJUS','AWARD','BEREV','BONCO','BONUS','BULLD','CACVD','CAEPS','CAMBP','CAPHE','CARAL','COCVD','COMM','CONSP','COVID','DRRCS','ERDON','HPDNW','JURY','LDCOM','MEDPR','MISC','NDBON','NYCVD','NYCVV','PITCV','PKEXE','PKNE' ,'REFER','REG'  ,'RETRO','RNCOM','RTCOM','SALLD','SCKPO','SEV','SEVER','SICK' ,'SIGN' ,'SPCOM','STLMT','SUSP','TUITX','TVLHR','TVLPY','TXRLO','VACPO','XACLD') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl and PehEarnCode IN 
('CODT' ,'COLB' ,'COOT' ,'DBLTM','DTLB' ,'OT'   ,'ADJUS','AWARD','BEREV','BONCO','BONUS','BULLD','CACVD','CAEPS','CAMBP','CAPHE','CARAL','COCVD','COMM','CONSP','COVID','DRRCS','ERDON','HPDNW','JURY','LDCOM','MEDPR','MISC','NDBON','NYCVD','NYCVV','PITCV','PKEXE','PKNE' ,'REFER','REG'  ,'RETRO','RNCOM','RTCOM','SALLD','SCKPO','SEV','SEVER','SICK' ,'SIGN' ,'SPCOM','STLMT','SUSP','TUITX','TVLHR','TVLPY','TXRLO','VACPO','XACLD') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ENUCCOMFML_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENUCCOMFML_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENUCCOMFML_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENUCCOMFML_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvAccountNumber = '159329'
        ,drvAccountName = 'NuCO2'
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeSSN = QuoteName(eepSSN,'"')
        ,drvFirstName = QuoteName(EepNameFirst,'"')
        ,drvMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvLastName = QuoteName(EepNameLast,'"')
        ,drvHomeAddressLine1 = Quotename(EepAddressLine1,'"')
        ,drvHomeAddressLine2 = Quotename(EepAddressLine2,'"')
        ,drvHomeCity = QuoteName(EepAddressCity,'"')
        ,drvHomeStateProvidence = EepAddressState
        ,drvHomeZipPostalCode = EepAddressZipCode
        ,drvHomeCountry = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvPrimaryLanguage = ''
        ,drvWorkAddressID = ''
        ,drvWorkAddressLine1 = ''
        ,drvWorkAddressLine2 = ''
        ,drvWorkCity = '' 
        --eecorglvl1 = CORP send EecSITWorkInStateCode else send 
        --LocAddressState in eeclocation  send eecaddressstate
        ,drvWorkStateProvidence =  CASE WHEN  eecorglvl1 = 'CORP' THEN EecSITWorkInStateCode  ELSE (Select top 1 LocAddressState from dbo.Location WITH (NOLOCK) where LocCode = eecLocation) END
        ,drvWorkZip = ''
        ,drvWorkCountry = ''
        ,drvWorkPhone = ''
        ,drvWorkPhoneExtension = ''
        ,drvBusinessUnit = eecorglvl1
        ,drvOrganization = eecorglvl2
        ,drvEmployeeGroup1 = eecorglvl3
        ,drvEmployeeGroup2 = eecorglvl4
        ,drvEmployeeGroup3 = ''
        ,drvEmployeeGroup4 = ''
        ,drvEmployeeGroup5 = ''
        ,drvEmployeeGroup6 = ''
        ,drvEmployeeGroup7 = ''
        ,drvEmployeeGroup8 = ''
        ,drvFullTimePartTimeStatus = EecFullTimeOrPartTime
        ,drvHireDate = eecdateoforiginalhire
        --If EecDateOfOriginalHire does not = EecDateOfLastHire, send EecDateOfLastHire else leave blank
        ,drvAdjustedEmploymentDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvAnniversaryDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        --sum (PehCurHrs) for PehEarnCodes where erntaxcategory = WAGES or OVTI 
        --for per controls in last 12 months - this should be a rolling 12 months

        ,drvHoursWorkedinthePrevMonths = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) as varchar)
        ,drvKeyEmployee = ''
        ,drvJobTitle = JbcDesc
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvScheduledHoursperWeek = CAST ( CONVERT(decimal(10,2),(EecScheduledWorkHrs / 2)) as varchar)
        ,drvScheduledofDaysperWeek = CASE WHEN  EecFullTimeOrPartTime = 'F' THEN  '5' else  '3' END
        ,drvAdditionalLetterRecipientEmail = ''
        ,drvSpouseEmployed = ''
        ,drvSpouseEmployeeID = ''
        ,drvEmployerContactIDS = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'EmpNo')   
        ,drvSTDEarnings =CAST( CONVERT(DECIMAL(10,2),CASE WHEN PehCurAmt > eecAnnSalary then PehCurAmt else eecAnnSalary END) as varchar)--(Select top 1  YedTaxableWages from dbo.YREEDet WITH (NOLOCK) where yedeeid = xeeid and YedTaxYear = YEAR(@StartDAte) -1 )
        ,drvSTDEligibilityDate = CASE WHEN STD = 'STD' THEN STD_startDate END
        ,drvLTDEligibilityDate = CASE WHEN LTD = 'LTD' THEN LTD_startDate END
        ,drvEmployerContact2IDS = ''
        ,drvEmployerContact3IDS = ''
        ,drvEmployerContact4IDS = ''
        ,drvEmployerContact5IDS = ''
        ,drvEmployerContact6IDS = ''
        ,drvEmployerContact7IDS = ''
        ,drvEmployerContact8IDS = ''
        ,drvEmployerContact9IDS = ''
        ,drvEmployerContact10IDS = ''
    INTO dbo.U_ENUCCOMFML_drvTbl
    FROM dbo.U_ENUCCOMFML_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (Select  A.bdmEEID,A.bdmcoid
            ,STD = MAX((CASE WHEN BDMDedCode = 'STD' then 'STD' END))
            ,LTD = MAX((CASE WHEN BDMDedCode in ('LTD','LTD2','LTD5') then 'LTD' END))

         
           
            ,STD_startDate = MAX((CASE WHEN BDMDedCode = 'STD' then bdmbenstartdate END))
            ,LTD_startDate = MAX((CASE WHEN BDMDedCode  in ('LTD','LTD2','LTD5') then bdmbenstartdate END))
        

            from dbo.U_dsi_BDM_ENUCCOMFML A
            
            group by A.bdmEEID,A.bdmcoid) as ConsolidatedBDM
        on Bdmeeid =  xEEID
        and bdmcoid = xCoID
    LEFT JOIN dbo.U_ENUCCOMFML_PEarHist WITH (NOLOCK)
        ON peheeid  = xeeid
    WHERE EecEEType  <> 'HRO'
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
ALTER VIEW dbo.dsi_vwENUCCOMFML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENUCCOMFML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENUCCOMFML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106161'
       ,expStartPerControl     = '202106161'
       ,expLastEndPerControl   = '202106239'
       ,expEndPerControl       = '202106239'
WHERE expFormatCode = 'ENUCCOMFML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENUCCOMFML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENUCCOMFML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2, SubSort3