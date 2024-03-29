SET NOCOUNT ON;
IF OBJECT_ID('U_EBSTEMP401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBSTEMP401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBSTEMP401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBSTEMP401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBSTEMP401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBSTEMP401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBSTEMP401];
GO
IF OBJECT_ID('U_EBSTEMP401_PEarHist_Prior') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_PEarHist_Prior];
GO
IF OBJECT_ID('U_EBSTEMP401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_PEarHist];
GO
IF OBJECT_ID('U_EBSTEMP401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_PDedHist];
GO
IF OBJECT_ID('U_EBSTEMP401_File') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_File];
GO
IF OBJECT_ID('U_EBSTEMP401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_EEList];
GO
IF OBJECT_ID('U_EBSTEMP401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_drvTbl];
GO
IF OBJECT_ID('U_EBSTEMP401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_DedList];
GO
IF OBJECT_ID('U_EBSTEMP401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_AuditFields];
GO
IF OBJECT_ID('U_EBSTEMP401_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBSTEMP401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBSTEMP401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBSTEMP401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBSTEMP401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBSTEMP401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EBSTEMP401','Empower 401k','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EBSTEMP401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EBSTEMP401Z0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EBSTEMP401Z0','11','D','10','14',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionNumber"','3','(''UA''=''F'')','EBSTEMP401Z0','20','D','10','25',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','4','(''UA''=''F'')','EBSTEMP401Z0','35','D','10','45',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','5','(''UA''=''F'')','EBSTEMP401Z0','20','D','10','80',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','6','(''UA''=''F'')','EBSTEMP401Z0','20','D','10','100',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffic"','7','(''UA''=''F'')','EBSTEMP401Z0','15','D','10','120',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateBirthDay"','8','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','135',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','145',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EBSTEMP401Z0','35','D','10','147',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EBSTEMP401Z0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''F'')','EBSTEMP401Z0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','14','(''UA''=''F'')','EBSTEMP401Z0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','16','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneBusinessNumber"','17','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneBusinessExt"','18','(''UA''=''F'')','EBSTEMP401Z0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','19','(''UA''=''F'')','EBSTEMP401Z0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','20','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','21','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','22','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','23','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBeforeTax"','24','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','315',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRoth"','25','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','325',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoan01"','26','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','335',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatching"','27','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','345',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib5"','28','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib6"','29','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib7"','30','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContrib8"','31','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYtdHours"','32','(''UA''=''F'')','EBSTEMP401Z0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYtdTotalCompensation"','33','(''UA''=''F'')','EBSTEMP401Z0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCompensation"','34','(''UA''=''F'')','EBSTEMP401Z0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPreEntry"','35','(''UA''=''F'')','EBSTEMP401Z0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompEmpCode"','36','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPercentOwner"','37','(''UA''=''F'')','EBSTEMP401Z0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficeDetermination"','38','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateParticipation"','39','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityCode"','40','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonCode"','41','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','452',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAStartDate"','42','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','453',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAEndDate"','43','(''UD101''=''F'')','EBSTEMP401Z0','10','D','10','463',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EBSTEMP401Z0','1','D','10','473',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','45','(''UA''=''F'')','EBSTEMP401Z0','40','D','10','474',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','46','(''UA''=''F'')','EBSTEMP401Z0','17','D','10','514',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmountQualifier"','47','(''UA''=''F'')','EBSTEMP401Z0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','48','(''UA''=''F'')','EBSTEMP401Z0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOxley"','49','(''UA''=''F'')','EBSTEMP401Z0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFillers"','50','(''UA''=''F'')','EBSTEMP401Z0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFedExemp"','51','(''UA''=''F'')','EBSTEMP401Z0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerAssigned"','52','(''UA''=''F'')','EBSTEMP401Z0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceCode"','53','(''UA''=''F'')','EBSTEMP401Z0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EBSTEMP401_20200317.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202003179','EMPEXPORT','SCHEDULED','Jan 13 2020 12:37PM','EBSTEMP401',NULL,NULL,NULL,'202003179','Sep  6 2019  1:35PM','Sep  6 2019  1:35PM','202001011','496','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EBSTEMP401_20200317.txt',NULL,'','','',NULL,NULL,NULL,'Empower 401k','202003179','EMPEXPORT','ONDEMAND','Jan 13 2020 12:29PM','EBSTEMP401',NULL,NULL,NULL,'202003179','Sep  6 2019 12:00AM','Dec 30 1899 12:00AM','202001011','496','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3mLaHEN1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EBSTEMP401_20200317.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003179','EMPEXPORT','TEST','Mar  6 2020 11:07AM','EBSTEMP401',NULL,NULL,NULL,'202003179','Feb 27 2020 12:00AM','Dec 30 1899 12:00AM','202001011','547','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiBES1003',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EBSTEMP401_20200317.txt' END WHERE expFormatCode = 'EBSTEMP401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSTEMP401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSTEMP401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSTEMP401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSTEMP401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSTEMP401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EBSTEMP401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBSTEMP401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EBSTEMP401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBSTEMP401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBSTEMP401','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBSTEMP401','D10','dbo.U_EBSTEMP401_drvTbl',NULL);
IF OBJECT_ID('U_EBSTEMP401_Audit') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EBSTEMP401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBSTEMP401_DedList') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBSTEMP401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] datetime NULL,
    [drvPlanNumber] varchar(10) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivisionNumber] varchar(1) NOT NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMiddleName] varchar(1) NULL,
    [drvNameSuffic] varchar(1) NOT NULL,
    [drvDateBirthDay] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvPhoneBusinessExt] varchar(10) NULL,
    [drvCountryCode] varchar(1) NOT NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvPayDate] datetime NULL,
    [drvEmpBeforeTax] varchar(24) NULL,
    [drvEmpRoth] varchar(24) NULL,
    [drvERMatching] varchar(1) NOT NULL,
    [drvLoan01] varchar(24) NULL,
    [drvContrib5] varchar(1) NOT NULL,
    [drvContrib6] varchar(1) NOT NULL,
    [drvContrib7] varchar(1) NOT NULL,
    [drvContrib8] varchar(1) NOT NULL,
    [drvYtdHours] varchar(24) NULL,
    [drvYtdTotalCompensation] varchar(24) NULL,
    [drvPlanCompensation] varchar(24) NULL,
    [drvYTDPreEntry] varchar(24) NULL,
    [drvCompEmpCode] varchar(1) NOT NULL,
    [drvPercentOwner] varchar(1) NOT NULL,
    [drvOfficeDetermination] varchar(1) NOT NULL,
    [drvDateParticipation] varchar(1) NOT NULL,
    [drvEligibilityCode] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvReasonCode] varchar(1) NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvAnnualSalary] varchar(24) NULL,
    [drvAmountQualifier] varchar(1) NOT NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvOxley] varchar(1) NOT NULL,
    [drvFillers] varchar(1) NOT NULL,
    [drvFedExemp] varchar(1) NOT NULL,
    [drvEmployerAssigned] char(9) NULL,
    [drvComplianceCode] varchar(1) NULL
);
IF OBJECT_ID('U_EBSTEMP401_EEList') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBSTEMP401_File') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EBSTEMP401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EBSTEMP401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_PEarHist] (
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
IF OBJECT_ID('U_EBSTEMP401_PEarHist_Prior') IS NULL
CREATE TABLE [dbo].[U_EBSTEMP401_PEarHist_Prior] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBSTEMP401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Henriksen Butler Design Group, LLC 

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 09/06/2019
Service Request Number: SR-2019-00242797

Purpose: Empower 401k

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBSTEMP401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBSTEMP401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBSTEMP401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBSTEMP401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBSTEMP401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBSTEMP401', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBSTEMP401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBSTEMP401';

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
    DELETE FROM dbo.U_EBSTEMP401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBSTEMP401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



--==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBSTEMP401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_AuditFields;
    CREATE TABLE dbo.U_EBSTEMP401_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EBSTEMP401_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBSTEMP401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EBSTEMP401_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBSTEMP401_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audOldValue = 'L'
    AND audNewValue = 'A'
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBSTEMP401_Audit ON dbo.U_EBSTEMP401_Audit (audEEID,audCOID);











    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401C,401F,410CF,401CP,410ER,401L,401L2,401L3,401L4,401L5';

    IF OBJECT_ID('U_EBSTEMP401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBSTEMP401_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EBSTEMP401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CF', '401CP', '401F', '401P') THEN 'DS'
                            WHEN PdhDedCode IN ('401ER') THEN 'ROTH'
                            WHEN PdhDedCode IN ('401L', '401L2', '401L3', '401L4' , '401L5') THEN 'PLAN1' 
                        END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
    INTO dbo.U_EBSTEMP401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PdhDedCode IN ('401CF', '401CP', '401F', '401P','401ER','401L', '401L2', '401L3', '401L4' , '401L5')
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401CF', '401CP', '401F', '401P')  THEN 'DS'
                            WHEN PdhDedCode IN ('401ER')THEN 'ROTH'
                            WHEN PdhDedCode IN ('401L', '401L2', '401L3', '401L4' , '401L5')THEN 'PLAN1' 
                        END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBSTEMP401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate) -- ? - JCB
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode NOT IN ('SDREG', 'SDOT', 'SDDT') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EBSTEMP401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --Prior Year

        IF OBJECT_ID('U_EBSTEMP401_PEarHist_Prior','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_PEarHist_Prior;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(PehCurAmt)
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
    INTO dbo.U_EBSTEMP401_PEarHist_Prior
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4)  = LEFT(@EndPerControl,4) - 1
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBSTEMP401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBSTEMP401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBSTEMP401_drvTbl;
    SELECT DISTINCT
        --New Layout
            drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmplStatusStartDate
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '1260715-01'
        ,drvSSN = eepSSN
        ,drvDivisionNumber = ''
        ,drvEmpLastName = EepNameLast
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMiddleName = LEFT(EepNameMiddle,1)
        ,drvNameSuffic = ''
        ,drvDateBirthDay = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvPhoneBusinessExt = EecPhoneBusinessExt
        ,drvCountryCode = '' --EepAddressCountry
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateOfLastHire = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN EecDateOfLastHire END
        ,drvPayDate = PrgPayDate
        ,drvEmpBeforeTax = dbo.dsi_fnpadzero((ISNULL(DSSoure,0)),10,2)
        ,drvEmpRoth = dbo.dsi_fnpadzero((ISNULL(ROTH,0)),10,2)
        ,drvERMatching = '' -- in spec? - JCB
        ,drvLoan01 = dbo.dsi_fnpadzero((ISNULL(PLAN1,0)),10,2)
        ,drvContrib5 = ''
        ,drvContrib6 = ''
        ,drvContrib7 = ''
        ,drvContrib8 = ''
        ,drvYtdHours = dbo.dsi_fnpadzero((ISNULL(PehCurHrsYTD,0)),5,0)
        ,drvYtdTotalCompensation = dbo.dsi_fnpadzero((ISNULL(PehCurAmtYTD,0)),10,2)
        ,drvPlanCompensation = dbo.dsi_fnpadzero((ISNULL( PehInclInDefCompYTD,0)),10,2)
        ,drvYTDPreEntry = dbo.dsi_fnpadzero((ISNULL( PehInclInDefCompYTD,0)),10,2) -- per spec line 35, this should be the same as the previous two lines - JCB
        ,drvCompEmpCode = ''
        ,drvPercentOwner = ''
        ,drvOfficeDetermination = ''
        ,drvDateParticipation = ''
        ,drvEligibilityCode = 'Y' -- the spec has a case here, want to make sure that this is being handled upstream. - JCB
        ,drvFiller1 = ''
        ,drvReasonCode = CASE WHEN ISNULL(audDateTime, '') <> '' OR EecEmplStatus = 'L' THEN 'L' END -- CASE WHEN EecEmplStatus = 'L' THEN 'L' END  --JCB
        ,drvLOAStartDate = CASE WHEN ISNULL(audDateTime, '') <> '' OR EecEmplStatus = 'L' THEN EshStatusStartDate END --CASE WHEN EecEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvLOAEndDate = CASE WHEN ISNULL(audDateTime, '') <> '' THEN EshStatusStopDate END --audDateTime -- CASE WHEN EecEmplStatus = 'L' THEN EshStatusStopDate END
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvAnnualSalary = CASE WHEN EecAnnSalary = 0 THEN dbo.dsi_fnpadzero((ISNULL((Select sum(PehCurAmtYTD) from U_EBSTEMP401_PEarHist_Prior where PehEEID = xEEID),0)),10,2) ELSE  dbo.dsi_fnpadzero((ISNULL(EecAnnSalary,0)),10,2) END
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
        ,drvEmployerAssigned = EecEmpNo -- ''
        ,drvComplianceCode =    CASE WHEN EecEmplStatus = 'T' THEN
                                    CASE WHEN EecTermREason = '203' THEN 'D'
                                        WHEN EecTermReason = '202' THEN 'R'
                                        WHEN EecTermReason = 'L' THEN 'I'
                                    END
                                END
        --''
    INTO dbo.U_EBSTEMP401_drvTbl
    FROM dbo.U_EBSTEMP401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    INNER JOIN dbo.U_EBSTEMP401_PEarHist WITH (NOLOCK)
            ON PehEEID = xEEID
    LEFT JOIN (
                Select PdhEEID as SourceEEId
                    ,DSSoure = (SUM (CASE WHEN PdhSource = 'DS' then pdheeCurAmt END))
                    ,ROTH = (SUM (CASE WHEN PdhSource = 'ROTH' then pdherCurAmt END))
                    ,SMATCH = (SUM (CASE WHEN PdhSource = 'SMATCH' then pdherCurAmt END))
                    ,PLAN1 = (SUM (CASE WHEN PdhSource = 'PLAN1' then PdhEECurAmt END))
             FROM U_EBSTEMP401_PDedHist
            GROUP BY PdhEEID) as DedHistSource
            ON SourceEEId =  xEEID
    LEFT JOIN dbo.U_EBSTEMP401_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    ;

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
ALTER VIEW dbo.dsi_vwEBSTEMP401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBSTEMP401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBSTEMP401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202003179'
       ,expEndPerControl       = '202003179'
WHERE expFormatCode = 'EBSTEMP401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBSTEMP401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBSTEMP401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort