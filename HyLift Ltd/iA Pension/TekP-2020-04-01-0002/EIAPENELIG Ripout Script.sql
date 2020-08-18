SET NOCOUNT ON;
IF OBJECT_ID('U_EIAPENELIG_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIAPENELIG_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIAPENELIG' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIAPENELIG_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIAPENELIG_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIAPENELIG') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIAPENELIG];
GO
IF OBJECT_ID('U_EIAPENELIG_File') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_File];
GO
IF OBJECT_ID('U_EIAPENELIG_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_EEList];
GO
IF OBJECT_ID('U_EIAPENELIG_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_drvTbl];
GO
IF OBJECT_ID('U_EIAPENELIG_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_AuditFields];
GO
IF OBJECT_ID('U_EIAPENELIG_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIAPENELIG';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIAPENELIG';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIAPENELIG';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIAPENELIG';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIAPENELIG';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIAPENELIG','iA Pension Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EIAPENELIGZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','1','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','1',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','2','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','2',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','3','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','4','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','4',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of birth"','5','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','5',NULL,'Date of birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','6','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','6',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Communication language"','7','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','7',NULL,'Communication language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire date"','8','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','8',NULL,'Hire date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Province of employment"','9','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','9',NULL,'Province of employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment status change"','10','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','10',NULL,'Employment status change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of the employment status change"','11','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','11',NULL,'Date of the employment status change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','12','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','12',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','13','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','13',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','23','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','23',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Postal Code"','24','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','24',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Province"','25','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','25',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','26','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','26',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Personal Email"','27','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','27',NULL,'Personal Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Email"','28','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','28',NULL,'Business Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Personal Phone Number"','29','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','29',NULL,'Personal Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Personal Extension Number"','30','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','30',NULL,'Personal Extension Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Phone Number"','31','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','31',NULL,'Business Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Extension Number"','32','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','32',NULL,'Business Extension Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Insurance Number (SIN)"','33','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','33',NULL,'Social Insurance Number (SIN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligibility Date"','34','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','34',NULL,'Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type of participation"','35','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','35',NULL,'Type of participation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee is full time or part time"','39','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','39',NULL,'Employee is full time or part time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Permanent or temporary employment"','40','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','40',NULL,'Permanent or temporary employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Information - Contract"','46','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','46',NULL,'Plan Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Information - Division"','47','(''DA''=''T,'')','EIAPENELIGZ0','50','H','01','47',NULL,'Plan Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Grievance Period"','48','(''DA''=''T'')','EIAPENELIGZ0','50','H','01','48',NULL,'Grievance Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','1','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','1',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','2','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','2',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','3','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','4','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','4',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','5','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','5',NULL,'Date of birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','6','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','6',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"English"','7','(''DA''=''T,'')','EIAPENELIGZ0','50','D','10','7',NULL,'Communication language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','8','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','8',NULL,'Hire date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProviceOfEmployment"','9','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','9',NULL,'Province of employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatusChange"','10','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','10',NULL,'Employment status change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastStatChange"','11','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','11',NULL,'Date of the employment status change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','12',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','13',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','23','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','23',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','24','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','24',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressProv"','25','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','25',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','26','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','26',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T,'')','EIAPENELIGZ0','50','D','10','27',NULL,'Personal Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','28','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','28',NULL,'Business Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalPhoneNum"','29','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','29',NULL,'Personal Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','EIAPENELIGZ0','50','D','10','30',NULL,'Personal Extension Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EIAPENELIGZ0','50','D','10','31',NULL,'Business Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','EIAPENELIGZ0','50','D','10','32',NULL,'Business Extension Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"srvSINumber"','33','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','33',NULL,'Social Insurance Number (SIN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligabilityDate"','34','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','34',NULL,'Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','35','(''DA''=''T,'')','EIAPENELIGZ0','50','D','10','35',NULL,'Type of participation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplFullOrPartTime"','39','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','39',NULL,'Employee is full time or part time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPermOrTemEmpl"','40','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','40',NULL,'Permanent or temporary employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanInformation1"','46','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','46',NULL,'Plan Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanInformation2"','47','(''UA''=''T,'')','EIAPENELIGZ0','50','D','10','47',NULL,'Plan Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrievancePeriod"','48','(''UA''=''T'')','EIAPENELIGZ0','50','D','10','48',NULL,'Grievance Period',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIAPENELIG_20200817.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'iA Pension Eligibility Export','202008179','EMPEXPORT','ONDEMAND',NULL,'EIAPENELIG',NULL,NULL,NULL,'202008179','Jun  1 2020 10:05AM','Jun  1 2020 10:05AM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIAPENELIG_20200817.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202008179','EMPEXPORT','SCHEDULED',NULL,'EIAPENELIG',NULL,NULL,NULL,'202008179','Jun  1 2020 10:05AM','Jun  1 2020 10:05AM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIAPENELIG_20200817.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202008189','EMPEXPORT','TEST','Aug 17 2020 12:10PM','EIAPENELIG',NULL,NULL,NULL,'202008189','Aug 18 2020 12:00AM','Dec 30 1899 12:00AM','202008011','2653','','','202008011',dbo.fn_GetTimedKey(),NULL,'LKING01',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EIAPENELIG_20200817.txt' END WHERE expFormatCode = 'EIAPENELIG';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIAPENELIG','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIAPENELIG','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIAPENELIG','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIAPENELIG','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIAPENELIG','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EIAPENELIG' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIAPENELIG' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EIAPENELIG_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIAPENELIG_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIAPENELIG','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIAPENELIG','D10','dbo.U_EIAPENELIG_drvTbl',NULL);
IF OBJECT_ID('U_EIAPENELIG_Audit') IS NULL
CREATE TABLE [dbo].[U_EIAPENELIG_Audit] (
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
IF OBJECT_ID('U_EIAPENELIG_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIAPENELIG_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EIAPENELIG_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIAPENELIG_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameMiddle] varchar(3) NOT NULL,
    [drvNameFirst] varchar(102) NULL,
    [drvEmployeeNumber] varchar(8000) NULL,
    [drvDateOfBirth] nvarchar(4000) NULL,
    [drvGender] varchar(3) NOT NULL,
    [drvDateOfHire] nvarchar(4000) NULL,
    [drvProviceOfEmployment] varchar(257) NULL,
    [drvEmplStatusChange] varchar(22) NOT NULL,
    [drvDateOfLastStatChange] nvarchar(4000) NOT NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NOT NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressZipCode] varchar(52) NULL,
    [drvAddressProv] varchar(257) NULL,
    [drvAddressCountry] varchar(5) NULL,
    [drvAddressEmail] varchar(52) NOT NULL,
    [drvPersonalPhoneNum] varchar(8000) NOT NULL,
    [srvSINumber] varchar(8000) NULL,
    [drvEligabilityDate] nvarchar(4000) NULL,
    [drvEmplFullOrPartTime] varchar(3) NULL,
    [drvPermOrTemEmpl] varchar(11) NOT NULL,
    [drvPlanInformation1] varchar(8000) NOT NULL,
    [drvPlanInformation2] varchar(8000) NOT NULL,
    [drvGrievancePeriod] varchar(8000) NOT NULL
);
IF OBJECT_ID('U_EIAPENELIG_EEList') IS NULL
CREATE TABLE [dbo].[U_EIAPENELIG_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIAPENELIG_File') IS NULL
CREATE TABLE [dbo].[U_EIAPENELIG_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIAPENELIG]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: HyLife Ltd.

Created By: James Bender
Business Analyst: Lea King
Create Date: 06/01/2020
Service Request Number: TekP-2020-04-01-0002

Purpose: iA Pension Eligibility Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIAPENELIG';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIAPENELIG';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIAPENELIG';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIAPENELIG';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIAPENELIG' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIAPENELIG', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIAPENELIG', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIAPENELIG';

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
    DELETE FROM dbo.U_EIAPENELIG_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIAPENELIG_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EIAPENELIG_EEList where xEEID IN (
        SELECT DISTINCT EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN('TES')
    );

    DELETE FROM dbo.U_EIAPENELIG_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp  WITH (NOLOCK) WHERE EecDateOfBenefitSeniority IS NULL
    );

    DELETE FROM dbo.U_EIAPENELIG_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecDateOfBenefitSeniority = '1/1/2070'
    );

    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EIAPENELIG_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIAPENELIG_AuditFields;
    CREATE TABLE dbo.U_EIAPENELIG_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EIAPENELIG_AuditFields VALUES ('EmpComp','EecEmplStatus');   
    
    -- Create audit table
    IF OBJECT_ID('U_EIAPENELIG_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIAPENELIG_Audit;
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
    INTO dbo.U_EIAPENELIG_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EIAPENELIG_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EIAPENELIG_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN DATEADD(DAY, -21, @StartDate) AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIAPENELIG_Audit ON dbo.U_EIAPENELIG_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIAPENELIG_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIAPENELIG_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIAPENELIG_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --'Status: ' + ISNULL(EecEmplStatus, 'none') + '  audit date: ' + ISNULL(CAST(AudTermDate AS VARCHAR), 'none')
        -- standard fields above and additional driver fields below
        ,drvNameLast = '"' + REPlACE(EepNameLast, ' ', '') + '"'
        ,drvNameMiddle = '"' + ISNULL(LEFT(EepNameMiddle,1), '') + '"'
        ,drvNameFirst = '"' + EepNameFirst + '"'
        ,drvEmployeeNumber = '"' + REPLACE(EecEmpNo, ' ', '') + '"'
        ,drvDateOfBirth = '"' + FORMAT(EepDateOfBirth, 'MM/dd/yyyy') + '"'
        ,drvGender = '"' + ISNULL(EepGender, '') + '"'
        ,drvDateOfHire = '"' + FORMAT(EecDateOfLastHire, 'MM/dd/yyyy') + '"'
        ,drvProviceOfEmployment = '"' + LocAddressState + '"'
        ,drvEmplStatusChange =    '"' + CASE WHEN EecEmplStatus = 'L' THEN 'Leave of absence'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'Death'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'Retirement'
                                    WHEN EecEmplStatus = 'A' AND EshEmplStatus = 'L' THEN 'Return at work'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN 'Standard termination'
                                    ELSE ''
                                END + '"'
        ,drvDateOfLastStatChange =    '"' + ISNULL(FORMAT(CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                        WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN EecEmplStatus = 'A' AND EshEmplStatus = 'L' THEN EshStatusStopDate
                                    END, 'MM/dd/yyyy'), '') + '"'
        ,drvAddressLine1 = '"' + REPLACE(EepAddressLine1, ',', '') + '"'
        ,drvAddressLine2 = '"' + ISNULL(REPLACE(RTRIM(EepAddressLine2), ',', ''), '') + '"'
        ,drvAddressCity = '"' + REPLACE(EepAddressCity, ' ', '') + '"'
        ,drvAddressZipCode = '"' + EepAddressZipCode + '"'
        ,drvAddressProv = '"' + EepAddressState + '"'
        ,drvAddressCountry = '"' + EepAddressCountry + '"'
        ,drvAddressEmail = '"' + ISNULL(CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail ELSE EepAddressEmailAlternate END, '') + '"'
        ,drvPersonalPhoneNum = '"' + ISNULL(REPLACE(EepPhoneHomeNumber, ' ', ''), '') + '"'
        ,srvSINumber = '"' + CASE WHEN ISNULL(EinNationalId, '') = '' THEN REPLACE(EepSSN, ' ','') ELSE EinNationalId END + '"'
        ,drvEligabilityDate = '"' + FORMAT(EecDateOfBenefitSeniority, 'MM/dd/yyyy') + '"'
        ,drvEmplFullOrPartTime = '"' + EecFullTimeOrPartTime + '"'
        ,drvPermOrTemEmpl = '"' + CASE WHEN EecEEType = 'REG' THEN 'Permanent' ELSE 'Temporary' END + '"'
        ,drvPlanInformation1 = '"' + ISNULL(REPLACE(EecUDField01, ' ', ''), '') + '"'
        ,drvPlanInformation2 = '"' + ISNULL(REPLACE(EecUDField13, ' ', ''), '') + '"'
        ,drvGrievancePeriod = '"' + ISNULL(REPLACE(EecUDField22, ' ', ''), '') + '"'
    INTO dbo.U_EIAPENELIG_drvTbl
    FROM dbo.U_EIAPENELIG_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.EmpIntl WITH (NOLOCK)
        ON xEEID = EinEEID
    JOIN (
            SELECT  EshEEID, EshCOID, EshEmplStatus, EshStatusStopDate
            FROM (
                SELECT EshEEID, EshCOID, EshEmplStatus, EshDateTimeChanged, EshStatusStopDate, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshDateTimeChanged DESC) AS rn
                FROM dbo.EmpHStat WITH (NOLOCK)) AS Hist
            WHERE rn = 1) As Hist_Latest
    ON EshEEID = xEEID
    AND EshCOID = xCOID
    LEFT JOIN (
                    SELECT audKey1Value AS AudEEID, audKey2Value AS AudCOID, audDateTime AS AudTermDate
                    FROM dbo.U_EIAPENELIG_Audit WITH (NOLOCK) 
                    WHERE audTableName = 'EmpComp' 
                    AND audFieldName = 'EecEmplStatus'
                    AND AudOldValue = 'A' 
                    AND AudNewValue = 'T'
        ) AS AudTermDate
        ON AudEEID = xEEID
        AND AudCOID = xCOID
    WHERE EecDateOfBenefitSeniority <> '1/1/2070'
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudTermDate > DATEADD(DAY, -21, @EndDate)))
    --    AND TRY_CAST(EecUDFIELD01 AS INT) IS NOT NULL
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
ALTER VIEW dbo.dsi_vwEIAPENELIG_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIAPENELIG_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIAPENELIG%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008011'
       ,expStartPerControl     = '202008011'
       ,expLastEndPerControl   = '202008179'
       ,expEndPerControl       = '202008179'
WHERE expFormatCode = 'EIAPENELIG';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIAPENELIG_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIAPENELIG_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort