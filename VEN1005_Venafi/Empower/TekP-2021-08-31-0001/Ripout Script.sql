SET NOCOUNT ON;
IF OBJECT_ID('U_EMPWRVE2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMPWRVE2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMPWRVE2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMPWRVE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMPWRVE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMPWRVE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMPWRVE2];
GO
IF OBJECT_ID('U_EMPWRVE2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_PEarHist];
GO
IF OBJECT_ID('U_EMPWRVE2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_PDedHist];
GO
IF OBJECT_ID('U_EMPWRVE2_File') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_File];
GO
IF OBJECT_ID('U_EMPWRVE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_EEList];
GO
IF OBJECT_ID('U_EMPWRVE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMPWRVE2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMPWRVE2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMPWRVE2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMPWRVE2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMPWRVE2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMPWRVE2','Empower 401K Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','577','S','N','EMPWRVE2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMPWRVE2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EMPWRVE2Z0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','2','(''UA''=''F'')','EMPWRVE2Z0','11','D','10','14',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionnumber"','3','(''UA''=''F'')','EMPWRVE2Z0','20','D','10','25',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''F'')','EMPWRVE2Z0','35','D','10','45',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''F'')','EMPWRVE2Z0','20','D','10','80',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','6','(''UA''=''F'')','EMPWRVE2Z0','20','D','10','100',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','7','(''UA''=''F'')','EMPWRVE2Z0','15','D','10','120',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','8','(''UD101''=''F'')','EMPWRVE2Z0','10','D','10','135',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EMPWRVE2Z0','1','D','10','145',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EMPWRVE2Z0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EMPWRVE2Z0','35','D','10','147',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EMPWRVE2Z0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''F'')','EMPWRVE2Z0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','14','(''UA''=''F'')','EMPWRVE2Z0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''F'')','EMPWRVE2Z0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','16','(''UA''=''F'')','EMPWRVE2Z0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneNumber"','17','(''UA''=''F'')','EMPWRVE2Z0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','18','(''UA''=''F'')','EMPWRVE2Z0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','19','(''UA''=''F'')','EMPWRVE2Z0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''F'')','EMPWRVE2Z0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD101''=''F'')','EMPWRVE2Z0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReHireDate"','22','(''UD101''=''F'')','EMPWRVE2Z0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckdate"','23','(''UD101''=''F'')','EMPWRVE2Z0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount1"','24','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','315',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount2"','25','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','325',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount3"','26','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','335',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount4"','27','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','345',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount5"','28','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount6"','29','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount7"','30','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount8"','31','(''UN02''=''F'')','EMPWRVE2Z0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','32','(''UN00''=''F'')','EMPWRVE2Z0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalCompensation"','33','(''UN02''=''F'')','EMPWRVE2Z0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanCompensation"','34','(''UN02''=''F'')','EMPWRVE2Z0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPreEntryCompensation"','35','(''UN02''=''F'')','EMPWRVE2Z0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyCompEmployeeCode"','36','(''UA''=''F'')','EMPWRVE2Z0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPercentofOwnership"','37','(''UN02''=''F'')','EMPWRVE2Z0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficerDetermination"','38','(''UA''=''F'')','EMPWRVE2Z0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipationDate"','39','(''UD101''=''F'')','EMPWRVE2Z0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityCode"','40','(''UA''=''F'')','EMPWRVE2Z0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeforeTaxContributionPer"','41','(''UN00''=''F'')','EMPWRVE2Z0','3','D','10','452',NULL,'Before-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeforeTaxContributionAmt"','42','(''UN02''=''F'')','EMPWRVE2Z0','8','D','10','455',NULL,'Before-Tax Contribution $',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAfterTaxContributionPer"','43','(''UN00''=''F'')','EMPWRVE2Z0','3','D','10','463',NULL,'After-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAfterTaxContributionAmt"','44','(''UN02''=''F'')','EMPWRVE2Z0','8','D','10','466',NULL,'After-Tax Contribution $',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','45','(''UA''=''F'')','EMPWRVE2Z0','40','D','10','474',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','46','(''UA''=''F'')','EMPWRVE2Z0','17','D','10','514',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmountQualifier"','47','(''UA''=''F'')','EMPWRVE2Z0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','48','(''UA''=''F'')','EMPWRVE2Z0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSarbanesOxleyReportingInd"','49','(''UA''=''F'')','EMPWRVE2Z0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','EMPWRVE2Z0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFederalExemptions"','51','(''UA''=''F'')','EMPWRVE2Z0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerAssignedID"','52','(''UA''=''F'')','EMPWRVE2Z0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceStatusCode"','53','(''UA''=''F'')','EMPWRVE2Z0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMPWRVE2_20211011.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'American Funds 401K Export','201807139','EMPEXPORT','ONDEMAND','Jul 12 2018 11:49AM','EMPWRVE2',NULL,NULL,NULL,'201807139','Jul 13 2018 12:00AM','Dec 30 1899 12:00AM','201807131','708','','','201807131',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPTSC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'American Funds 401K Export','201807139','EMPEXPORT','SCHEDULED','Jul 12 2018 11:49AM','EMPWRVE2',NULL,NULL,NULL,'201807139','Jul 13 2018 12:00AM','Dec 30 1899 12:00AM','201807131','708','','','201807131',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPTSC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003131','EMPEXPORT','TEST','Mar 11 2020  2:44PM','EMPWRVE2',NULL,NULL,NULL,'202003131','Mar 13 2020 12:00AM','Mar 15 2020 12:00AM','202003131','259','','','202003131',dbo.fn_GetTimedKey(),NULL,'ULTI_WPVENA',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMPWRVE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMPWRVE2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMPWRVE2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMPWRVE2','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMPWRVE2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMPWRVE2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMPWRVE2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMPWRVE2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMPWRVE2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMPWRVE2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMPWRVE2','D10','dbo.U_EMPWRVE2_drvTbl',NULL);
IF OBJECT_ID('U_EMPWRVE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMPWRVE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvPlanNumber] varchar(9) NOT NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvDivisionnumber] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(51) NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(50) NULL,
    [drvCountryCode] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvCheckdate] datetime NULL,
    [drvContributionAmount1] numeric NULL,
    [drvContributionAmount2] numeric NULL,
    [drvContributionAmount3] numeric NULL,
    [drvContributionAmount4] numeric NULL,
    [drvContributionAmount5] numeric NULL,
    [drvContributionAmount6] numeric NULL,
    [drvContributionAmount7] numeric NULL,
    [drvContributionAmount8] numeric NULL,
    [drvHoursWorked] decimal NULL,
    [drvYTDTotalCompensation] money NULL,
    [drvYTDPlanCompensation] money NULL,
    [drvYTDPreEntryCompensation] int NULL,
    [drvHighlyCompEmployeeCode] char(1) NULL,
    [drvPercentofOwnership] int NULL,
    [drvOfficerDetermination] char(1) NULL,
    [drvParticipationDate] datetime NULL,
    [drvEligibilityCode] varchar(1) NOT NULL,
    [drvBeforeTaxContributionPer] int NULL,
    [drvBeforeTaxContributionAmt] int NULL,
    [drvAfterTaxContributionPer] int NULL,
    [drvAfterTaxContributionAmt] int NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] money NULL,
    [drvSalaryAmountQualifier] varchar(1) NOT NULL,
    [drvTerminationReasonCode] varchar(1) NOT NULL,
    [drvSarbanesOxleyReportingInd] varchar(1) NOT NULL,
    [drvFederalExemptions] varchar(1) NOT NULL,
    [drvEmployerAssignedID] char(9) NULL,
    [drvComplianceStatusCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(4) NULL,
    [drvSubSort] varchar(12) NULL
);
IF OBJECT_ID('U_EMPWRVE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EMPWRVE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMPWRVE2_File') IS NULL
CREATE TABLE [dbo].[U_EMPWRVE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(577) NULL
);
IF OBJECT_ID('U_EMPWRVE2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMPWRVE2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhContributionAmount1] numeric NULL,
    [PdhContributionAmount2] numeric NULL,
    [PdhContributionAmount3] numeric NULL,
    [PdhContributionAmount4] numeric NULL,
    [PdhContributionAmount5] numeric NULL,
    [PdhContributionAmount6] numeric NULL,
    [PdhContributionAmount7] numeric NULL,
    [PdhContributionAmount8] numeric NULL
);
IF OBJECT_ID('U_EMPWRVE2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMPWRVE2_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMPWRVE2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Venafi

Created By: Karol Violan
Create Date: 12/3/2019
Service Request Number: SR-2019-00259376


Purpose: Empower Payroll 401K Export PDI/Payroll Bridge

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMPWRVE2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMPWRVE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMPWRVE2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMPWRVE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMPWRVE2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMPWRVE2', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMPWRVE2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMPWRVE2', 'TEST';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMPWRVE2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMPWRVE2';

    -- Declare dates FROM Parameter file
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
    --DELETE FROM dbo.U_EMPWRVE2_EEList  
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)  
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EMPWRVE2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);  

    DELETE E
    FROM dbo.U_EMPWRVE2_EEList E
    JOIN EmpComp WITH (NOLOCK) 
        ON xeeid = eecEEID 
        AND xcoid = eeccoid
    WHERE (EecEEType NOT IN ('REG', 'INT') OR EecFullTimeOrPartTime = 'P')  ;

    
   
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMPWRVE2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMPWRVE2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl = LEFT(PdhPerControl,8)
        -- Current Payroll Amounts
        ,PdhEECurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- Categorize Payroll Amounts
        --pre-tax
        ,PdhContributionAmount1 = SUM(CASE WHEN PdhDedCode IN ('401F','401P') THEN PdhEECurAmt ELSE 0.00 END) --pos 315
        --MATCH
        ,PdhContributionAmount2 = SUM(CASE WHEN PdhDedCode IN ('401ER') THEN PdhERCurAmt ELSE 0.00 END) --pos325
        --loans
        ,PdhContributionAmount3 = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') THEN PdhEECurAmt ELSE 0.00 END)  --pos 335      
        --Roth
        ,PdhContributionAmount4 = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP') THEN PdhEECurAmt ELSE 0.00 END) --pos 345
        ,PdhContributionAmount5 = SUM(CASE WHEN PdhDedCode IN ('401AF','401AP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhContributionAmount6 = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhContributionAmount7 = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhContributionAmount8 = SUM(CASE WHEN PdhDedCode IN ('') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EMPWRVE2_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND pdhDedCode IN ('401F', '401P','401ER','ROTHF','ROTHP','401L', '401L2', '401AF','401AP')
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --)
    
    ;

    -----------------------------
    -- Working Table - PEarHist SELECT * FROM dbo.U_EMPWRVE2_PEarHist WITH (NOLOCK);
                                --SELECT DISTINCT PehEarnCode FROM dbo.PEarHist WITH (NOLOCK) WHERE PehInclInDefCompHrs = 'N' ORDER BY PehEarnCode;
    -----------------------------
    IF OBJECT_ID('U_EMPWRVE2_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMPWRVE2_PEarHist;
    SELECT DISTINCT
         PehEEID
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN ISNULL(PehCurAmt, 0.00) END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN ISNULL(PehCurHrs,0.00) END)
    INTO dbo.U_EMPWRVE2_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID


    
    DECLARE @LastPayDate as datetime;
    SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
    AND prgPERCONTROL BETWEEN @StartPerControl and @EndPerControl;

    --==========================================
    -- Build Driver Tables SELECT * FROM dbo.U_EMPWRVE2_drvTbl WITH (NOLOCK);
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMPWRVE2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMPWRVE2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMPWRVE2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '501231-01' 
        ,drvEmployeeSSN = LEFT(eepSSN, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6, 4)
        ,drvDivisionnumber = ''
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'Z' THEN '' ELSE eepMaritalStatus END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-') ELSE EepAddressZipCode END
        ,drvHomePhoneNumber = EepPhoneHomeNumber
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = EecPhoneBusinessNumber
        ,drvCountryCode = ''    --EepAddressCountry --Remove if all employees live in the USA
        ,drvHireDate = EecDateofOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateofTermination END
                        --CASE 
      --                  WHEN EecEmplStatus = 'T' AND isNull(EecTermReason,'') <> 'TRO' THEN EecDateOfTermination
      --                  WHEN EecDateofOriginalHire <> EecDateofLastHire  AND isNull(EecTermReason,'') <> 'TRO'  
      --                  THEN ((SELECT MAX(EshStatusStartDate) FROM dbo.EmpHStat WITH(NOLOCK) JOIN dbo.EmpComp ON EshEEID = EecEEID WHERE EshEEID = xEEID AND EshEmplStatus = 'T' AND EshStatusStartDate <= EecDateofLastHire))
      --                  END
        ,drvReHireDate = CASE WHEN eecDateOfOriginalHire <> eecDateOfLastHire THEN eecDateOfLastHire END
        ,drvCheckdate = @LastPayDate
        ,drvContributionAmount1 = PdhContributionAmount1 --EE Cont 315 Catch up Included
        ,drvContributionAmount2 = PdhContributionAmount2 --ER Cont 325 MATCH
        ,drvContributionAmount3 = PdhContributionAmount3 --Loan 335 
        ,drvContributionAmount4 = PdhContributionAmount4 --Roth 345 
        ,drvContributionAmount5 = PdhContributionAmount5 
        ,drvContributionAmount6 = PdhContributionAmount6 
        ,drvContributionAmount7 = PdhContributionAmount7
        ,drvContributionAmount8 = PdhContributionAmount8
        ,drvHoursWorked = PehCurHrsYTD
        ,drvYTDTotalCompensation = PehCurAmtYTD
        ,drvYTDPlanCompensation = PehInclInDefCompYTD
        ,drvYTDPreEntryCompensation = NULL
        ,drvHighlyCompEmployeeCode = EecIsHighlyComp
        ,drvPercentofOwnership = NULL
        ,drvOfficerDetermination = EecSUIIsOfficer
        ,drvParticipationDate = EecDateofOriginalHire
        ,drvEligibilityCode = ''
        ,drvBeforeTaxContributionPer = NULL
        ,drvBeforeTaxContributionAmt = NULL
        ,drvAfterTaxContributionPer = NULL
        ,drvAfterTaxContributionAmt = NULL
        ,drvEmailAddress = EepAddressEMail
        ,drvSalaryAmount = EecAnnSalary
        ,drvSalaryAmountQualifier = 'A' --A=Annual, M= Monthly, S= Semi-Monthly, B= Bi-Weekly, H= hourly, W= Week 
        ,drvTerminationReasonCode = ''
                                    /*CASE WHEN EecEmplStatus = 'T' 
                                        THEN CASE 
                                        WHEN EecTermReason = '203' THEN 'DI'
                                        WHEN EecTermReason IN ('200','208') THEN 'LA'
                                        WHEN EecTermReason = '202' THEN 'R'
                                        ELSE 'S'
                                        END
                                        END    */
        ,drvSarbanesOxleyReportingInd = ''
        ,drvFederalExemptions = ''
        ,drvEmployerAssignedID = EecEmpNo
        ,drvComplianceStatusCode = ''
        ,drvInitialSort = RIGHT(CONVERT(VARCHAR(12),EecDateOfOriginalHire,101),4)
        ,drvSubSort = CONVERT(VARCHAR(12),EecDateOfOriginalHire,101)
    INTO dbo.U_EMPWRVE2_drvTbl
    FROM dbo.U_EMPWRVE2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        AND EepAddressCountry = 'USA'
    JOIN dbo.U_EMPWRVE2_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EMPWRVE2_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    --LEFT JOIN  (select distinct ejheeid eeid, ejhcoid coid, ejhreason reason, ejhJobEffDate jdate    
    --        FROM emphjob
    --        WHERE ejhreason = 'TRI') as CoXfer on CoXfer.eeid = xeeid and CoXfer.coid = xcoid

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'EMPWRVE2_' + CONVERT(VARCHAR(8),GETDATE(),112) + 'HHMMSS.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMPWRVE2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EMPWRVE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMPWRVE2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201707101'
       ,expStartPerControl     = '201707101'
       ,expLastEndPerControl   = '201707179'
       ,expEndPerControl       = '201707179'
WHERE expFormatCode = 'EMPWRVE2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMPWRVE2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMPWRVE2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort