SET NOCOUNT ON;
IF OBJECT_ID('U_EEMP403EXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEMP403EXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEMP403EXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEMP403EXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMP403EXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMP403EXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP403EXP];
GO
IF OBJECT_ID('U_EEMP403EXP_PEarHist_Prior') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_PEarHist_Prior];
GO
IF OBJECT_ID('U_EEMP403EXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_PEarHist];
GO
IF OBJECT_ID('U_EEMP403EXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_PDedHist];
GO
IF OBJECT_ID('U_EEMP403EXP_File') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_File];
GO
IF OBJECT_ID('U_EEMP403EXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_EEList];
GO
IF OBJECT_ID('U_EEMP403EXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_drvTbl];
GO
IF OBJECT_ID('U_EEMP403EXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMP403EXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMP403EXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMP403EXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMP403EXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMP403EXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMP403EXP','Empower 401k','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EEMP403EXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EEMP403EXPZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EEMP403EXPZ0','11','D','10','14',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionNumber"','3','(''UA''=''F'')','EEMP403EXPZ0','20','D','10','25',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','4','(''UA''=''F'')','EEMP403EXPZ0','35','D','10','45',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','5','(''UA''=''F'')','EEMP403EXPZ0','20','D','10','80',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','6','(''UA''=''F'')','EEMP403EXPZ0','20','D','10','100',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffic"','7','(''UA''=''F'')','EEMP403EXPZ0','15','D','10','120',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateBirthDay"','8','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','135',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','145',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EEMP403EXPZ0','35','D','10','147',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EEMP403EXPZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''F'')','EEMP403EXPZ0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','14','(''UA''=''F'')','EEMP403EXPZ0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','16','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneBusinessNumber"','17','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneBusinessExt"','18','(''UA''=''F'')','EEMP403EXPZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','19','(''UA''=''F'')','EEMP403EXPZ0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','20','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','21','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','22','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','23','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBeforeTax"','24','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','315',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRoth"','25','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','325',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatching"','26','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','335',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoan01"','27','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','345',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib5"','28','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib6"','29','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib7"','30','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib8"','31','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYtdHours"','32','(''UA''=''F'')','EEMP403EXPZ0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYtdTotalCompensation"','33','(''UA''=''F'')','EEMP403EXPZ0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCompensation"','34','(''UA''=''F'')','EEMP403EXPZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPreEntry"','35','(''UA''=''F'')','EEMP403EXPZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompEmpCode"','36','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPercentOwner"','37','(''UA''=''F'')','EEMP403EXPZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficeDetermination"','38','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateParticipation"','39','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityCode"','40','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller1"','41','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','452',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonCode"','42','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','453',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAStartDate"','43','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','454',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAEndDate"','44','(''UD101''=''F'')','EEMP403EXPZ0','10','D','10','464',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','45','(''UA''=''F'')','EEMP403EXPZ0','40','D','10','474',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','46','(''UA''=''F'')','EEMP403EXPZ0','17','D','10','514',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmountQualifier"','47','(''UA''=''F'')','EEMP403EXPZ0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','48','(''UA''=''F'')','EEMP403EXPZ0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOxley"','49','(''UA''=''F'')','EEMP403EXPZ0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFillers"','50','(''UA''=''F'')','EEMP403EXPZ0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFedExemp"','51','(''UA''=''F'')','EEMP403EXPZ0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerAssigned"','52','(''UA''=''F'')','EEMP403EXPZ0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceCode"','53','(''UA''=''F'')','EEMP403EXPZ0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP403EXP_20200518.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201909069','EMPEXPORT','SCHEDULED',NULL,'EEMP403EXP',NULL,NULL,NULL,'201909069','Sep  6 2019  1:35PM','Sep  6 2019  1:35PM','201909061',NULL,'','','201909061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP403EXP_20200518.txt',NULL,'','','',NULL,NULL,NULL,'Empower 401k','201909069','EMPEXPORT','ONDEMAND','Sep  6 2019  3:23PM','EEMP403EXP',NULL,NULL,NULL,'201909069','Sep  6 2019 12:00AM','Dec 30 1899 12:00AM','201908111','193','','','201908111',dbo.fn_GetTimedKey(),NULL,'us3mLaHEN1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP403EXP_20200518.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202004249','EMPEXPORT','TEST','Apr 24 2020  7:03PM','EEMP403EXP',NULL,NULL,NULL,'202004249','Apr 24 2020 12:00AM','Dec 30 1899 12:00AM','202004241','357','','','202004241',dbo.fn_GetTimedKey(),NULL,'us3lKiPEO1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEMP403EXP_20200518.txt' END WHERE expFormatCode = 'EEMP403EXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP403EXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP403EXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP403EXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP403EXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP403EXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EEMP403EXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEMP403EXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EEMP403EXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMP403EXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP403EXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP403EXP','D10','dbo.U_EEMP403EXP_drvTbl',NULL);
IF OBJECT_ID('U_EEMP403EXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEMP403EXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvPlanNumber] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivisionNumber] varchar(1) NOT NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMiddleName] varchar(1) NULL,
    [drvNameSuffic] varchar(1) NOT NULL,
    [drvDateBirthDay] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvPhoneBusinessExt] varchar(10) NULL,
    [drvCountryCode] char(3) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvPayDate] datetime NULL,
    [drvEmpBeforeTax] varchar(24) NULL,
    [drvEmpRoth] varchar(24) NULL,
    [drvERMatching] varchar(1) NOT NULL,
    [drvLoan01] varchar(24) NULL,
    [drvContrib5] varchar(24) NULL,
    [drvContrib6] varchar(24) NULL,
    [drvContrib7] varchar(1) NOT NULL,
    [drvContrib8] varchar(1) NOT NULL,
    [drvYtdHours] varchar(24) NULL,
    [drvYtdTotalCompensation] varchar(24) NULL,
    [drvPlanCompensation] varchar(24) NULL,
    [drvYTDPreEntry] varchar(1) NOT NULL,
    [drvCompEmpCode] varchar(1) NOT NULL,
    [drvPercentOwner] varchar(1) NOT NULL,
    [drvOfficeDetermination] varchar(1) NOT NULL,
    [drvDateParticipation] varchar(1) NOT NULL,
    [drvEligibilityCode] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvReasonCode] char(6) NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvAnnualSalary] varchar(24) NULL,
    [drvAmountQualifier] varchar(1) NOT NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvOxley] varchar(1) NOT NULL,
    [drvFillers] varchar(1) NOT NULL,
    [drvFedExemp] varchar(1) NOT NULL,
    [drvEmployerAssigned] varchar(1) NOT NULL,
    [drvComplianceCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EEMP403EXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEMP403EXP_File') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EEMP403EXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_PDedHist] (
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
IF OBJECT_ID('U_EEMP403EXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EEMP403EXP_PEarHist_Prior') IS NULL
CREATE TABLE [dbo].[U_EEMP403EXP_PEarHist_Prior] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] money NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP403EXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: People Incorporated

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/06/2020
Service Request Number: TekP-2020-01-13-001

Purpose: Empower 404B Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMP403EXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMP403EXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMP403EXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMP403EXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMP403EXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP403EXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP403EXP', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMP403EXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMP403EXP';

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
    DELETE FROM dbo.U_EEMP403EXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMP403EXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403ER,403D,403P,RTHD,RTHP,HSAI,HSAIC,HSAF,HSAFC,HSAER';

    IF OBJECT_ID('U_EEMP403EXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP403EXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMP403EXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

   IF OBJECT_ID('U_EEMP403EXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP403EXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMP403EXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EEMP403EXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP403EXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('403D' , '403P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('RTHD', 'RTHP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('403ER') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ( 'HSAI', 'HSAIC', 'HSAF' , 'HSAFC') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EEMP403EXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EEMP403EXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EEMP403EXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP403EXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN PehEarnCode IN ('HOLWK', 'OB', 'OT', 'OT2', 'OT3', 'REG', 'REG2', 'REG3') THEN pehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode IN ('HOLWK', 'OB', 'OT', 'OT2', 'OT3', 'REG', 'REG2', 'REG3') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EEMP403EXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMP403EXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMP403EXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP403EXP_drvTbl;
    SELECT DISTINCT
        --New Layout
            drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '507881-01'
        ,drvSSN = eepSSN
        ,drvDivisionNumber = ''
        ,drvEmpLastName = EepNameLast
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMiddleName = LEFT(EepNameMiddle,1)
        ,drvNameSuffic = ''
        ,drvDateBirthDay = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN ISNULL(eepMaritalStatus,'') in ('Z','') THEN 'S' ELSE eepMaritalStatus END
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvPhoneBusinessExt = EecPhoneBusinessExt
        ,drvCountryCode = EepAddressCountry
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        /*
        if eecemplstatus = T send eecdateoftermination
if eecemplstatus  = A and EecDateOfOriginalHire does not = EecDateOfLastHire send previous eecdateoftermination 
        */
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                     WHEN EecEmplStatus = 'A' and EecDateOfOriginalHire <>  EecDateOfLastHire THEN (select top 1 ehcDateOfTermination from emphcomp where ehceeid = xeeid  and ehcEmplStatus = 'T' order by ehcDateTimeCreated)
                                     END
        /*
        If EecDateOfOriginalHire does not = EecDateOfLastHire, send EecDateOfLastHire else leave blank
        */
        ,drvDateOfLastHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvPayDate = dbo.dsi_fnGetMinMaxDates('MAX',Paydate, PrgPayDate) 
        ,drvEmpBeforeTax = dbo.dsi_fnpadzero((ISNULL(PdhSource1,0)),10,2)
        ,drvEmpRoth = dbo.dsi_fnpadzero((ISNULL(PdhSource3,0)),10,2)
        ,drvERMatching = ''
        ,drvLoan01 = dbo.dsi_fnpadzero((ISNULL(PdhSource2,0)),10,2)
        ,drvContrib5 = dbo.dsi_fnpadzero((ISNULL(PdhSource6,0)),10,2) 
        ,drvContrib6 = dbo.dsi_fnpadzero((ISNULL(PdhSource7,0)),10,2)  
        ,drvContrib7 = ''
        ,drvContrib8 = ''
        ,drvYtdHours = dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0)),5,0)
        ,drvYtdTotalCompensation = dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0)),10,2)
        ,drvPlanCompensation = dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0)),10,2) --dbo.dsi_fnpadzero((ISNULL( PehInclInDefCompYTD,0)),10,2)
        ,drvYTDPreEntry = ''
        ,drvCompEmpCode = ''
        ,drvPercentOwner = ''
        ,drvOfficeDetermination = ''
        ,drvDateParticipation = ''
        ,drvEligibilityCode = 'Y'
        ,drvFiller1 = ''
        ,drvReasonCode =  CASE WHEN EecEmplStatus = 'L'then (Select top 1 EshEmplStatusReason from EmpHStat  (Nolock) where EshEmplStatus = 'L' and eshcoid = xCOID and esheeid = xEEID)  END
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' then (Select max(eshStatusStartDate)  from EmpHStat  (Nolock) where EshEmplStatus = 'L' and eshcoid = xCOID and esheeid = xEEID) END
        ,drvLOAEndDate = CASE WHEN EecEmplStatus = 'L' then (Select max(eshStatusStopDate)  from EmpHStat  (Nolock) where EshEmplStatus = 'L' and eshcoid = xCOID and esheeid = xEEID) END
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvAnnualSalary = CASE WHEN EecAnnSalary = 0 THEN dbo.dsi_fnpadzero((ISNULL((Select sum(PehCurAmtYTD) from U_EEMP403EXP_PEarHist_Prior where PehEEID = xEEID),0)),10,2) ELSE  dbo.dsi_fnpadzero((ISNULL(EecAnnSalary,0)),10,2) END
        ,drvAmountQualifier = 'A'
        ,drvTerminationReasonCode =  CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'DE'
                                                 WHEN EecTermReason IN ('202','213') THEN 'R'
                                                 ELSE 'S'
                                            END
                                      END
        ,drvOxley = ''
        ,drvFillers = ''
        ,drvFedExemp = ''
        ,drvEmployerAssigned = ''
        ,drvComplianceCode = ''
    INTO dbo.U_EEMP403EXP_drvTbl
    FROM dbo.U_EEMP403EXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    INNER JOIN dbo.U_EEMP403EXP_PEarHist WITH (NOLOCK)
            ON PehEEID = xEEID
    JOIN dbo.U_EEMP403EXP_PDedHist WITH (NOLOCK)
       on PdhEEID =  xEEID
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as Paydate
    ON Paydate.PgpPayGroup =  eecpaygroup


 Delete from U_EEMP403EXP_drvTbl where drveeid not in (select eeceeid from empcomp where EECUDFIELD22 = 'Y')
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'EVMACS401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ETEST12345_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEEMP403EXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMP403EXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMP403EXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201908301'
       ,expStartPerControl     = '201908301'
       ,expLastEndPerControl   = '201909069'
       ,expEndPerControl       = '201909069'
WHERE expFormatCode = 'EEMP403EXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMP403EXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMP403EXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort