SET NOCOUNT ON;
IF OBJECT_ID('U_ECOMPSFMLA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECOMPSFMLA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECOMPSFMLA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECOMPSFMLA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOMPSFMLA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOMPSFMLA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOMPSFMLA];
GO
IF OBJECT_ID('U_ECOMPSFMLA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_PEarHist];
GO
IF OBJECT_ID('U_ECOMPSFMLA_File') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_File];
GO
IF OBJECT_ID('U_ECOMPSFMLA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_EEList];
GO
IF OBJECT_ID('U_ECOMPSFMLA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_drvTbl];
GO
IF OBJECT_ID('U_ECOMPSFMLA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_AuditFields];
GO
IF OBJECT_ID('U_ECOMPSFMLA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECOMPSFMLA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECOMPSFMLA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECOMPSFMLA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECOMPSFMLA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECOMPSFMLA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOMPSFMLA','ComPsych FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','ECOMPSFMLAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number"','1','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','1',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Name"','2','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','2',NULL,'Account Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','3','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Social Security Number"','4','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','4',NULL,'Employee Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','6','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','6',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','7','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 1"','8','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','8',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 2"','9','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','9',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home City"','10','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','10',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home State / Province"','11','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','11',NULL,'Home State / Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Zip / Postal Code"','12','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','12',NULL,'Home Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Country"','13','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','13',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone Number"','14','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','14',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','15','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','16','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','16',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Language"','17','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','17',NULL,'Primary Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Address ID"','18','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','18',NULL,'Work Address ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Address 1"','19','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','19',NULL,'Work Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Address 2"','20','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','20',NULL,'Work Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work City"','21','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','21',NULL,'Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State / Province"','22','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','22',NULL,'Work State / Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Zip / Postal Code"','23','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','23',NULL,'Work Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Country"','24','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','24',NULL,'Work Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Number"','25','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','25',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Extension"','26','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','26',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Unit"','27','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','27',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization"','28','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','28',NULL,'Organization',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 1"','29','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','29',NULL,'Employee Group 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 2"','30','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','30',NULL,'Employee Group 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 3"','31','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','31',NULL,'Employee Group 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 4"','32','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','32',NULL,'Employee Group 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 5"','33','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','33',NULL,'Employee Group 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 6"','34','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','34',NULL,'Employee Group 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 7"','35','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','35',NULL,'Employee Group 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Group 8"','36','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','36',NULL,'Employee Group 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full Time / Part-Time Status"','37','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','37',NULL,'Full Time / Part-Time Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','38','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','38',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adjusted Employment Date"','39','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','39',NULL,'Adjusted Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Anniversary Date"','40','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','40',NULL,'Anniversary Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','41','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','41',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked Previous 12 Months"','42','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','42',NULL,'Hours Worked Previous 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee"','43','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','43',NULL,'Key Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','44','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','44',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work E-mail Address"','45','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','45',NULL,'Work E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Hours per Week"','46','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','46',NULL,'Scheduled Hours per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Number of days per Week"','47','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','47',NULL,'Scheduled Number of days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Letter Recipient E-mail Addresses"','48','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','48',NULL,'Additional Letter Recipient E-mail Addresses',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employed at this Account"','49','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','49',NULL,'Spouse Employed at this Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Employee Number"','50','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','50',NULL,'Spouse Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 1IDS"','51','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','51',NULL,'Employer Contact 1IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Weekly STD Earnings"','52','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','52',NULL,'Weekly STD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Eligibility Date"','53','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','53',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eligibility Date"','54','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','54',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 2 IDS"','55','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','55',NULL,'Employer Contact 2 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 3 IDS"','56','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','56',NULL,'Employer Contact 3 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 4 IDS"','57','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','57',NULL,'Employer Contact 4 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 5 IDS"','58','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','58',NULL,'Employer Contact 5 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 6 IDS"','59','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','59',NULL,'Employer Contact 6 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 7 IDS"','60','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','60',NULL,'Employer Contact 7 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 8 IDS"','61','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','61',NULL,'Employer Contact 8 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 9 IDS"','62','(''DA''=''T,'')','ECOMPSFMLAZ0','50','H','01','62',NULL,'Employer Contact 9 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Contact 10 IDS"','63','(''DA''=''T'')','ECOMPSFMLAZ0','50','H','01','63',NULL,'Employer Contact 10 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"158646"','1','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','1',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Community Credit Union"','2','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','2',NULL,'Account Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNo"','3','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','4',NULL,'Employee Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','8',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','9',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','10','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','10',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','11','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','11',NULL,'Home State / Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressPostalCode"','12','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','12',NULL,'Home Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','13','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','13',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','14','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','14',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','16','(''UD101''=''T,'')','ECOMPSFMLAZ0','50','D','10','16',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','17',NULL,'Primary Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressID"','18','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','18',NULL,'Work Address ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddress1"','19','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','19',NULL,'Work Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddress2"','20','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','20',NULL,'Work Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','21','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','21',NULL,'Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','22','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','22',NULL,'Work State / Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPostalCode"','23','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','23',NULL,'Work Zip / Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','24','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','24',NULL,'Work Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','25',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','26',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','27',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganization"','28','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','28',NULL,'Organization',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGroup1"','29','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','29',NULL,'Employee Group 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','30',NULL,'Employee Group 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','31',NULL,'Employee Group 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','32',NULL,'Employee Group 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','33',NULL,'Employee Group 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','34',NULL,'Employee Group 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','35',NULL,'Employee Group 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','36',NULL,'Employee Group 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimePartTimeStatus"','37','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','37',NULL,'Full Time / Part-Time Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','38','(''UD101''=''T,'')','ECOMPSFMLAZ0','50','D','10','38',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedEmplDate"','39','(''UD101''=''T,'')','ECOMPSFMLAZ0','50','D','10','39',NULL,'Adjusted Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','40',NULL,'Anniversary Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','41','(''UD101''=''T,'')','ECOMPSFMLAZ0','50','D','10','41',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedPast12Mo"','42','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','42',NULL,'Hours Worked Previous 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','43',NULL,'Key Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','44','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','44',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','45',NULL,'Work E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSchedHoursPerWeek"','46','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','46',NULL,'Scheduled Hours per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSchedDaysPerWeek"','47','(''UA''=''T,'')','ECOMPSFMLAZ0','50','D','10','47',NULL,'Scheduled Number of days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','48',NULL,'Additional Letter Recipient E-mail Addresses',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','49',NULL,'Spouse Employed at this Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','50',NULL,'Spouse Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','51',NULL,'Employer Contact 1IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','52',NULL,'Weekly STD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','53',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','54',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','55',NULL,'Employer Contact 2 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','56',NULL,'Employer Contact 3 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','57',NULL,'Employer Contact 4 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','58',NULL,'Employer Contact 5 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','59',NULL,'Employer Contact 6 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','60',NULL,'Employer Contact 7 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','61',NULL,'Employer Contact 8 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T,'')','ECOMPSFMLAZ0','50','D','10','62',NULL,'Employer Contact 9 IDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T'')','ECOMPSFMLAZ0','50','D','10','63',NULL,'Employer Contact 10 IDS',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECOMPSFMLA_20200824.txt',NULL,'','','',NULL,NULL,NULL,'ComPsych FMLA Export','202003169','EMPEXPORT','ONDEMAND','Mar 18 2020  1:58PM','ECOMPSFMLA',NULL,NULL,NULL,'202003169','Mar 16 2020  1:04PM','Mar 16 2020  1:04PM','202002161','373','','','202002161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECOMPSFMLA_20200824.txt',NULL,'','',',IAGFG',NULL,NULL,NULL,'ComPsych FMLA - Thurs 4 pm','202003169','EMPEXPORT','SCHEDULED','Mar 18 2020  2:02PM','ECOMPSFMLA',NULL,NULL,NULL,'202008209','Mar 16 2020  1:04PM','Mar 16 2020  1:04PM','202008131','373','','','202002161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECOMPSFMLA_20200824.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008211','EMPEXPORT','TEST','Aug 21 2020  7:41PM','ECOMPSFMLA',NULL,NULL,NULL,'202008211','Aug 21 2020 12:00AM','Aug 15 2020 12:00AM','202008071','366','','','202008071',dbo.fn_GetTimedKey(),NULL,'us3cPeFIR1030',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECOMPSFMLA_20200824.txt' END WHERE expFormatCode = 'ECOMPSFMLA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPSFMLA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPSFMLA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPSFMLA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPSFMLA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOMPSFMLA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECOMPSFMLA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECOMPSFMLA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECOMPSFMLA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOMPSFMLA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOMPSFMLA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOMPSFMLA','D10','dbo.U_ECOMPSFMLA_drvTbl',NULL);
IF OBJECT_ID('U_ECOMPSFMLA_Audit') IS NULL
CREATE TABLE [dbo].[U_ECOMPSFMLA_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ECOMPSFMLA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECOMPSFMLA_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ECOMPSFMLA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECOMPSFMLA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNo] char(9) NULL,
    [drvSSN] nvarchar(258) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressPostalCode] varchar(5) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvWorkAddressID] char(6) NULL,
    [drvWorkAddress1] varchar(6000) NULL,
    [drvWorkAddress2] varchar(6000) NULL,
    [drvWorkCity] varchar(255) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkPostalCode] varchar(5) NULL,
    [drvOrganization] varchar(25) NULL,
    [drvEmployeeGroup1] varchar(8) NULL,
    [drvFullTimePartTimeStatus] char(1) NULL,
    [drvHireDate] datetime NULL,
    [drvAdjustedEmplDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvHoursWorkedPast12Mo] nvarchar(4000) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvSchedHoursPerWeek] varchar(5) NOT NULL,
    [drvSchedDaysPerWeek] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOMPSFMLA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOMPSFMLA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECOMPSFMLA_File') IS NULL
CREATE TABLE [dbo].[U_ECOMPSFMLA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_ECOMPSFMLA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECOMPSFMLA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurHrs] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOMPSFMLA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: First Community Credit Union

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/16/2020
Service Request Number: TekP-2020-02-10-0011

Purpose: ComPsych FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOMPSFMLA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOMPSFMLA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOMPSFMLA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOMPSFMLA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOMPSFMLA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOMPSFMLA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOMPSFMLA', 'TEST';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECOMPSFMLA', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@EndYtdDate        DATE
            ,@StartYtdDate        DATE
            ,@StartYtdPerControl VARCHAR(9)
            ,@EndYtdPerControl    VARCHAR(9)
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'ECOMPSFMLA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @EndYtdDate = LEFT(@EndPerControl, 8);
    SELECT @StartYtdDate = DATEADD(Year, -1, @EndYtdDate);
    SELECT @EndYtdPerControl = FORMAT(@EndYtdDate, 'yyyyMMdd') + '1', @StartYtdPerControl = FORMAT(@StartYtdDate, 'yyyyMMdd') + '9'
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECOMPSFMLA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECOMPSFMLA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECOMPSFMLA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.empcomp WITH (NOLOCK) WHERE EecEEType IN('CON')
    );




    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_ECOMPSFMLA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECOMPSFMLA_AuditFields;
    CREATE TABLE dbo.U_ECOMPSFMLA_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ECOMPSFMLA_AuditFields VALUES ('empcomp','eecemplstatus');    
    -- Create audit table
    IF OBJECT_ID('U_ECOMPSFMLA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECOMPSFMLA_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_ECOMPSFMLA_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECOMPSFMLA_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECOMPSFMLA_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECOMPSFMLA_Audit ON dbo.U_ECOMPSFMLA_Audit (audKey1Value, audKey2Value);








    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECOMPSFMLA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECOMPSFMLA_PEarHist;
    SELECT DISTINCT
         PehEEID
         ,PehCurHrs = SUM(PehCurHrs)
    INTO dbo.U_ECOMPSFMLA_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE CAST(LEFT(PehPerControl, 8) AS DATE) BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
    --PehPerControl BETWEEN @StartYtdPerControl AND @EndYtdPerControl
        AND PehEarnCode IN ('REG', 'SATOT', 'OT', 'SATRE')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECOMPSFMLA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECOMPSFMLA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECOMPSFMLA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNo = EecEmpNo
        ,drvSSN = quotename(SUBSTRING(eepssn, 1, 3)+'-'+
       SUBSTRING(eepssn, 4, 2)+'-'+
       SUBSTRING(eepssn, 3, 4),'"')
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 =dbo.dsi_fnRemoveChars('.,/-', EepAddressLine2)
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressPostalCode = LEFT(ISNULL(EepAddressZipCode,''),5)  
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvWorkAddressID = EecLocation
        ,drvWorkAddress1 = dbo.dsi_fnRemoveChars('.,/-',LocAddressline1)
        ,drvWorkAddress2 = dbo.dsi_fnRemoveChars('.,/-',LocAddressline2)
        ,drvWorkCity = LocAddresscity
        ,drvWorkState = LocAddressState
        ,drvWorkPostalCode = LEFT(ISNULL(LocAddressZipCode,''),5) 
        ,drvOrganization = OrgDesc
        ,drvEmployeeGroup1 =    CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salaried'
                                    WHEN EecSalaryOrHourly = 'H' THEN 'Hourly'
                                END
        ,drvFullTimePartTimeStatus = eecFullTimeOrPartTime
        ,drvHireDate = EecDateOfOriginalHire
        ,drvAdjustedEmplDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvHoursWorkedPast12Mo = FORMAT(PehCurHrs, '#0.00')
        ,drvJobTitle = JbcDesc
        ,drvSchedHoursPerWeek = CASE WHEN EecFullTimeOrPartTime = 'P' THEN '29.00' ELSE '40.00' END
        ,drvSchedDaysPerWeek = CASE WHEN EecFullTimeOrPartTime = 'P' THEN '4' ELSE '5' END
    INTO dbo.U_ECOMPSFMLA_drvTbl
    FROM dbo.U_ECOMPSFMLA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID

    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN OrgLevel WITH (NOLOCK)
        ON EecOrgLvl1 = OrgCode
    LEFT JOIN dbo.Location With (NOLOCK)
        on LocCode = EecLocation
    LEFT JOIN dbo.U_ECOMPSFMLA_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_ECOMPSFMLA_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate)) 
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
ALTER VIEW dbo.dsi_vwECOMPSFMLA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECOMPSFMLA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOMPSFMLA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202002161'
       ,expStartPerControl     = '202002161'
       ,expLastEndPerControl   = '202003169'
       ,expEndPerControl       = '202003169'
WHERE expFormatCode = 'ECOMPSFMLA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOMPSFMLA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECOMPSFMLA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort