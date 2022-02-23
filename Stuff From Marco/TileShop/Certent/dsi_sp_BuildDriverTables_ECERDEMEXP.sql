SET NOCOUNT ON;
IF OBJECT_ID('U_ECERDEMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECERDEMEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECERDEMEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECERDEMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECERDEMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECERDEMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECERDEMEXP];
GO
IF OBJECT_ID('U_ECERDEMEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_PEarHist];
GO
IF OBJECT_ID('U_ECERDEMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_File];
GO
IF OBJECT_ID('U_ECERDEMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_EEList];
GO
IF OBJECT_ID('U_ECERDEMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_drvTbl];
GO
IF OBJECT_ID('U_ECERDEMEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_AuditFields];
GO
IF OBJECT_ID('U_ECERDEMEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECERDEMEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECERDEMEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECERDEMEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECERDEMEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECERDEMEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECERDEMEXP','Certent Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECERDEMEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Equityholder Code"','1','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','1',NULL,'Equityholder Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tax ID"','2','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','2',NULL,'Tax ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','3','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','4','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','4',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Address Line 1"','6','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','6',NULL,'Current Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Address Line 2"','7','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','7',NULL,'Current Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Address Line 3"','8','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','8',NULL,'Current Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current City"','9','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','9',NULL,'Current City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current State or Province"','10','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','10',NULL,'Current State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Postal Code"','11','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','11',NULL,'Current Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Country"','12','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','12',NULL,'Current Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Email Address"','13','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','13',NULL,'Current Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date Relationship Started"','14','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','14',NULL,'Date Relationship Started',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','15','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','15',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Type"','16','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','16',NULL,'Termination Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Job Title"','17','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','17',NULL,'Current Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Department"','18','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','18',NULL,'Current Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','19','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','19',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"As of Date"','20','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','20',NULL,'As of Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','21','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','21',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tax Year"','22','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','22',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Total Compensation "','23','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','23',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Taxable Supplemental Compensation"','24','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','24',NULL,'YTD Taxable Supplemental Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Social Security"','25','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','25',NULL,'YTD Social Security',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD SDI/SUI"','26','(''DA''=''T,'')','ECERDEMEXPZ0','50','H','01','26',NULL,'YTD SDI/SUI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Code"','27','(''DA''=''T'')','ECERDEMEXPZ0','50','H','01','27',NULL,'State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEquityholderCode"','1','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','1',NULL,'Equityholder Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxID"','2','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','2',NULL,'Tax ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','3','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','4','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','4',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','5','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentAddressLine1"','6','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','6',NULL,'Current Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentAddressLine2"','7','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','7',NULL,'Current Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentAddressLine3"','8','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','8',NULL,'Current Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentCity"','9','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','9',NULL,'Current City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentStateorProvince"','10','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','10',NULL,'Current State or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentPostalCode"','11','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','11',NULL,'Current Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentCountry"','12','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','12',NULL,'Current Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentEmailAddress"','13','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','13',NULL,'Current Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateRelationshipStarted"','14','(''UD101''=''T,'')','ECERDEMEXPZ0','50','D','10','14',NULL,'Date Relationship Started',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','15','(''UD101''=''T,'')','ECERDEMEXPZ0','50','D','10','15',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationType"','16','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','16',NULL,'Termination Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentJobTitle"','17','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','17',NULL,'Current Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDepartment"','18','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','18',NULL,'Current Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','19','(''UD101''=''T,'')','ECERDEMEXPZ0','50','D','10','19',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAsofDate"','20','(''UD101''=''T,'')','ECERDEMEXPZ0','50','D','10','20',NULL,'As of Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','21','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','21',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','22','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','22',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalCompensation"','23','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','23',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTaxableSuppCompensation"','24','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','24',NULL,'YTD Taxable Supplemental Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSocialSecurity"','25','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','25',NULL,'YTD Social Security',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSDISUI"','26','(''UA''=''T,'')','ECERDEMEXPZ0','50','D','10','26',NULL,'YTD SDI/SUI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateCode"','27','(''UA''=''T'')','ECERDEMEXPZ0','50','D','10','27',NULL,'State Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECERDEMEXP_20200916.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Certent Demo Export','202005119','EMPEXPORT','ONDEMAND',NULL,'ECERDEMEXP',NULL,NULL,NULL,'202005119','May 11 2020  5:09PM','May 11 2020  5:09PM','202005111',NULL,'','','202005111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECERDEMEXP_20200916.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202005119','EMPEXPORT','SCH_CERDXP',NULL,'ECERDEMEXP',NULL,NULL,NULL,'202005119','May 11 2020  5:09PM','May 11 2020  5:09PM','202005111',NULL,'','','202005111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECERDEMEXP_20200916.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008311','EMPEXPORT','TEST','Aug 31 2020  5:26PM','ECERDEMEXP',NULL,NULL,NULL,'202008311','Aug 31 2020 12:00AM','Dec 30 1899 12:00AM','202008171','191','','','202008171',dbo.fn_GetTimedKey(),NULL,'us3cPeTIL1001',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECERDEMEXP_20200916.txt' END WHERE expFormatCode = 'ECERDEMEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERDEMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERDEMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERDEMEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERDEMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECERDEMEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECERDEMEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECERDEMEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECERDEMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECERDEMEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECERDEMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECERDEMEXP','D10','dbo.U_ECERDEMEXP_drvTbl',NULL);
IF OBJECT_ID('U_ECERDEMEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECERDEMEXP_Audit] (
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
IF OBJECT_ID('U_ECERDEMEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECERDEMEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ECERDEMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECERDEMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvEquityholderCode] char(9) NULL,
    [drvTaxID] nvarchar(258) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvCurrentAddressLine1] nvarchar(258) NULL,
    [drvCurrentAddressLine2] nvarchar(258) NULL,
    [drvCurrentAddressLine3] varchar(1) NOT NULL,
    [drvCurrentCity] nvarchar(258) NULL,
    [drvCurrentStateorProvince] varchar(255) NULL,
    [drvCurrentPostalCode] varchar(50) NULL,
    [drvCurrentCountry] varchar(3) NOT NULL,
    [drvCurrentEmailAddress] varchar(50) NULL,
    [drvDateRelationshipStarted] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTerminationType] varchar(9) NULL,
    [drvCurrentJobTitle] varchar(25) NOT NULL,
    [drvCurrentDepartment] char(6) NULL,
    [drvDateofBirth] datetime NULL,
    [drvAsofDate] datetime NULL,
    [drvAnnualSalary] varchar(1) NOT NULL,
    [drvTaxYear] varchar(4) NULL,
    [drvYTDTotalCompensation] varchar(12) NULL,
    [drvYTDTaxableSuppCompensation] varchar(12) NULL,
    [drvYTDSocialSecurity] varchar(12) NULL,
    [drvYTDSDISUI] varchar(1) NOT NULL,
    [drvStateCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECERDEMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECERDEMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECERDEMEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECERDEMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECERDEMEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECERDEMEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] numeric NULL,
    [PehInclInDefCompNonSupYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECERDEMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Tile Shop

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 05/11/2020
Service Request Number: TekP-2020-02-17-0010

Purpose: Certent Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECERDEMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECERDEMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECERDEMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECERDEMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECERDEMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERDEMEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECERDEMEXP', 'TEST';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECERDEMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECERDEMEXP';

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
    DELETE FROM dbo.U_ECERDEMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECERDEMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    

    IF OBJECT_ID('U_ECERDEMEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECERDEMEXP_AuditFields;
    CREATE TABLE dbo.U_ECERDEMEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ECERDEMEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ECERDEMEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECERDEMEXP_Audit;
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
    INTO dbo.U_ECERDEMEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECERDEMEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECERDEMEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate - 90 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECERDEMEXP_Audit ON dbo.U_ECERDEMEXP_Audit (audKey1Value, audKey2Value);


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECERDEMEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECERDEMEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PayDate             = MAX(PrgPayDate)
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
        ,PehInclInDefCompYTD    = SUM(CASE WHEN pehEarnCode in( 'BRL' ,'RSTK', 'RSTKE','STKNQ','STNQ' ,'STQ'  ,'STQE')  THEN PehCurAmt ELSE  0.00 END)
        ,PehInclInDefCompNonSupYTD    = SUM(CASE WHEN PehEarnCode NOT IN ('BOOT', 'EXPRM', 'HSARF', 'HSARI') THEN PehCurAmt END)

        
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)

    INTO dbo.U_ECERDEMEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

        -----------------------------
    -- Working Table - PTaxHist
    -----------------------------
    IF OBJECT_ID('U_ECERDEMEXPPTaxHist') IS NOT NULL
        DROP TABLE dbo.U_ECERDEMEXPPTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PthGrossWagesYTD    = SUM(PthCurTaxableWages)   
    INTO dbo.U_ECERDEMEXPPTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    AND PthTaxCode = 'USSOCEE'
    GROUP BY PthEEID
    HAVING SUM(PthCurGrossWages) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECERDEMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECERDEMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECERDEMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvEquityholderCode = eecEmpNo
        ,drvTaxID = QuoteName(eepSSN,'"')
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = ''
        ,drvLastName = EepNameLast
        ,drvCurrentAddressLine1 = QuoteName(EepAddressLine1,'"')
        ,drvCurrentAddressLine2 = QuoteName(EepAddressLine2,'"')
        ,drvCurrentAddressLine3 = ''
        ,drvCurrentCity = QuoteName(EepAddressCity,'"') 
        ,drvCurrentStateorProvince = EepAddressState
        ,drvCurrentPostalCode = EepAddressZipCode
        ,drvCurrentCountry = 'USA'
        ,drvCurrentEmailAddress = EepAddressEMail
        ,drvDateRelationshipStarted = Eecdateoflasthire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationType = CASE WHEN EecEmplStatus = 'T' THEN 'Voluntary' END
        ,drvCurrentJobTitle = JbcDesc 
        ,drvCurrentDepartment = eecOrglvl1
        ,drvDateofBirth = EepDateOfBirth
        ,drvAsofDate = dbo.dsi_fnGetMinMaxDates('MAX',PayGrp.PrgPayDate, PayDate)
        ,drvAnnualSalary = ''
        ,drvTaxYear = CAST(YEAR(dbo.dsi_fnGetMinMaxDates('MAX',PayGrp.PrgPayDate, PayDate)) as varchar(4))
        ,drvYTDTotalCompensation =  CAST(PehInclInDefCompNonSupYTD as varchar(12))  
        ,drvYTDTaxableSuppCompensation = CAST(PehInclInDefCompYTD as varchar(12))
        ,drvYTDSocialSecurity = CAST(PthGrossWagesYTD as varchar(12))
        ,drvYTDSDISUI = ''
        ,drvStateCode = ''
    INTO dbo.U_ECERDEMEXP_drvTbl
    FROM dbo.U_ECERDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ECERDEMEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (select * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL) where Employment_StockAwarded = '1')
        as StockAwarded
        ON StockAwarded.eeceeid = xeeid
        AND StockAwarded.eeccoid = xcoid
    LEFT JOIN dbo.U_ECERDEMEXP_PEarHist as A 
        ON PehEEID =  xeeid
    LEFT JOIN dbo.U_ECERDEMEXPPTaxHist WITH (NOLOCK)
        on PTHEEID = xeeid
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PrgPayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) PayGrp
    ON PayGrp.PgpPayGroup =  eecPaygroup
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
ALTER VIEW dbo.dsi_vwECERDEMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECERDEMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECERDEMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005041'
       ,expStartPerControl     = '202005041'
       ,expLastEndPerControl   = '202005119'
       ,expEndPerControl       = '202005119'
WHERE expFormatCode = 'ECERDEMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECERDEMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECERDEMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort