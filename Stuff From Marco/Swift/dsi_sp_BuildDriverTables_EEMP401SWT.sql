SET NOCOUNT ON;
IF OBJECT_ID('U_EEMP401SW2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEMP401SW2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEMP401SW2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEMP401SW2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMP401SW2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMP401SW2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401SW2];
GO
IF OBJECT_ID('U_EEMP401SW2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_PEarHist];
GO
IF OBJECT_ID('U_EEMP401SW2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_PDedHist];
GO
IF OBJECT_ID('U_EEMP401SW2_File') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_File];
GO
IF OBJECT_ID('U_EEMP401SW2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_EEList];
GO
IF OBJECT_ID('U_EEMP401SW2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_drvTbl];
GO
IF OBJECT_ID('U_EEMP401SW2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_DedList];
GO
IF OBJECT_ID('U_dsi_EEMP401SW2_EarnHistW2') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401SW2_EarnHistW2];
GO
IF OBJECT_ID('U_dsi_EEMP401SW2_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401SW2_EarnHist];
GO
IF OBJECT_ID('U_dsi_EEMP401SW2_DefCompHistW2') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401SW2_DefCompHistW2];
GO
IF OBJECT_ID('U_dsi_EEMP401SW2_DefCompHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401SW2_DefCompHist];
GO
IF OBJECT_ID('U_dsi_EEMP401SW2_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401SW2_DedHist];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMP401SW2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMP401SW2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMP401SW2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMP401SW2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMP401SW2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMP401SW2','Empower 401K V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','577','S','N','EEMP401SW2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EEMP401SW2Z0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EEMP401SW2Z0','11','D','10','14',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''F'')','EEMP401SW2Z0','20','D','10','25',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastname"','4','(''UA''=''F'')','EEMP401SW2Z0','35','D','10','45',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''F'')','EEMP401SW2Z0','20','D','10','80',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMI"','6','(''UA''=''F'')','EEMP401SW2Z0','20','D','10','100',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','7','(''UA''=''F'')','EEMP401SW2Z0','15','D','10','120',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','8','(''UD101''=''F'')','EEMP401SW2Z0','10','D','10','135',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EEMP401SW2Z0','1','D','10','145',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EEMP401SW2Z0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EEMP401SW2Z0','35','D','10','147',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EEMP401SW2Z0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''F'')','EEMP401SW2Z0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','14','(''UA''=''F'')','EEMP401SW2Z0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','16','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','17','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','18','(''UA''=''F'')','EEMP401SW2Z0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','19','(''UA''=''F'')','EEMP401SW2Z0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''F'')','EEMP401SW2Z0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD101''=''F'')','EEMP401SW2Z0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','22','(''UD101''=''F'')','EEMP401SW2Z0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','23','(''UD101''=''F'')','EEMP401SW2Z0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBeforeTax"','24','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','315',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMatch"','25','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','325',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoan"','26','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','335',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth"','27','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','345',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt5"','28','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt6"','29','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt7"','30','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt8"','31','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','32','(''UA''=''F'')','EEMP401SW2Z0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalComp"','33','(''UA''=''F'')','EEMP401SW2Z0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanComp"','34','(''UA''=''F'')','EEMP401SW2Z0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPreEntryComp"','35','(''UA''=''F'')','EEMP401SW2Z0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyComp"','36','(''UA''=''F'')','EEMP401SW2Z0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPercentOwnership"','37','(''UA''=''F'')','EEMP401SW2Z0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficer"','38','(''UA''=''F'')','EEMP401SW2Z0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipationDate"','39','(''UD101''=''F'')','EEMP401SW2Z0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligCode"','40','(''UA''=''F'')','EEMP401SW2Z0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAReasonCode"','41','(''UA''=''F'')','EEMP401SW2Z0','2','D','10','452',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAStartDate"','42','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','454',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAEndDate"','43','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','464',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','44','(''UA''=''F'')','EEMP401SW2Z0','40','D','10','474',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','45','(''UA''=''F'')','EEMP401SW2Z0','17','D','10','514',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmtQualifier"','46','(''UA''=''F'')','EEMP401SW2Z0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCode"','47','(''UA''=''F'')','EEMP401SW2Z0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSBORIndex"','48','(''UA''=''F'')','EEMP401SW2Z0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''F'')','EEMP401SW2Z0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFederalExempt"','50','(''UA''=''F'')','EEMP401SW2Z0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAssignedID"','51','(''UA''=''F'')','EEMP401SW2Z0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceStatusCode"','52','(''UA''=''F'')','EEMP401SW2Z0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP401SW2_20200727.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201901049','EMPEXPORT','OEACTIVE','Mar 21 2018 12:00AM','EEMP401SW2',NULL,NULL,NULL,'201901049','May 17 2017 12:00AM','Dec 30 1899 12:00AM','201901041',NULL,'','','201901041',dbo.fn_GetTimedKey(),NULL,'ULTI_WPCOLCH',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP401SW2_20200727.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201901049','EMPEXPORT','OEPASSIVE','Mar 21 2018 12:00AM','EEMP401SW2',NULL,NULL,NULL,'201901049','May 17 2017 12:00AM','Dec 30 1899 12:00AM','201901041',NULL,'','','201901041',dbo.fn_GetTimedKey(),NULL,'ULTI_WPCOLCH',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP401SW2_20200727.txt',NULL,'','','',NULL,NULL,NULL,'Empower 401K DEZE','201902019','EMPEXPORT','ONDEMAND','Feb 12 2019  1:44PM','EEMP401SW2',NULL,NULL,NULL,'201902019','Feb  1 2019 12:00AM','Dec 30 1899 12:00AM','201902011','734','','','201902011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSWITC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMP401SW2_20200727.txt',NULL,'','',',EKPGM,D7EF0',NULL,NULL,NULL,'Test Purposes Only','202007171','EMPEXPORT','TEST','Jul 17 2020  2:49PM','EEMP401SW2',NULL,NULL,NULL,'202007171','Jul 17 2020 12:00AM','Jul 11 2020 12:00AM','202007171','843','','','202007171',dbo.fn_GetTimedKey(),NULL,'us3rVaSWI1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEMP401SW2_20200727.txt' END WHERE expFormatCode = 'EEMP401SW2';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401SW2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401SW2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401SW2','InitialSort','C','drvHireDate');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401SW2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401SW2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401SW2','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EEMP401SW2' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEMP401SW2' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EEMP401SW2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMP401SW2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP401SW2','D10','dbo.U_EEMP401SW2_drvTbl',NULL);
IF OBJECT_ID('U_dsi_EEMP401SW2_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401SW2_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [hpct] decimal NULL,
    [paydate] datetime NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);
IF OBJECT_ID('U_dsi_EEMP401SW2_DefCompHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401SW2_DefCompHist] (
    [dceeid] char(12) NULL,
    [dccoid] char(5) NULL,
    [dcamt] money NULL,
    [dchrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EEMP401SW2_DefCompHistW2') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401SW2_DefCompHistW2] (
    [dceeid] char(12) NULL,
    [dccoid] char(5) NULL,
    [dcamt] money NULL,
    [dchrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EEMP401SW2_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401SW2_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EEMP401SW2_EarnHistW2') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401SW2_EarnHistW2] (
    [w2eeid] char(12) NOT NULL,
    [w2coid] char(5) NOT NULL,
    [w2date] int NULL,
    [w2eamt] money NULL
);
IF OBJECT_ID('U_EEMP401SW2_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMP401SW2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEMP401SW2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMP401SW2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvPlanNumber] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvLastname] varchar(6000) NULL,
    [drvFirstname] varchar(6000) NULL,
    [drvMI] varchar(1) NOT NULL,
    [drvNameSuffix] varchar(1) NOT NULL,
    [drvBirthDate] varchar(10) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvHireDate] varchar(10) NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvRehireDate] varchar(30) NULL,
    [drvCheckDate] varchar(10) NULL,
    [drvEmpBeforeTax] money NULL,
    [drvEmpMatch] money NULL,
    [drvLoan] money NULL,
    [drvRoth] money NULL,
    [drvConAmt5] varchar(1) NOT NULL,
    [drvConAmt6] varchar(1) NOT NULL,
    [drvConAmt7] varchar(1) NOT NULL,
    [drvConAmt8] varchar(1) NOT NULL,
    [drvHoursWorked] varchar(5) NULL,
    [drvYTDTotalComp] money NULL,
    [drvYTDPlanComp] money NULL,
    [drvYTDPreEntryComp] varchar(1) NOT NULL,
    [drvHighlyComp] varchar(1) NOT NULL,
    [drvPercentOwnership] varchar(1) NOT NULL,
    [drvOfficer] varchar(1) NOT NULL,
    [drvParticipationDate] varchar(10) NULL,
    [drvEligCode] varchar(1) NOT NULL,
    [drvLOAReasonCode] varchar(1) NOT NULL,
    [drvLOAStartDate] varchar(1) NOT NULL,
    [drvLOAEndDate] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvSalary] varchar(17) NULL,
    [drvSalaryAmtQualifier] varchar(1) NOT NULL,
    [drvTermReasonCode] varchar(1) NOT NULL,
    [drvSBORIndex] varchar(1) NOT NULL,
    [drvFederalExempt] varchar(1) NOT NULL,
    [drvEmpAssignedID] varchar(1) NOT NULL,
    [drvComplianceStatusCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EEMP401SW2_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMP401SW2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEMP401SW2_File') IS NULL
CREATE TABLE [dbo].[U_EEMP401SW2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(577) NULL
);
IF OBJECT_ID('U_EEMP401SW2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMP401SW2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL
);
IF OBJECT_ID('U_EEMP401SW2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMP401SW2_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401SW2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Switch Ltd

Created By: Parsha Antara
Business Analyst: Kevin McCloskey
Create Date: 01/14/2019
Service Request Number: SR-2018-00212015

Purpose: Empower 401K File

Revision History
----------------
Update By           Date            Request Num            Desc
Sean Hawkins        05/23/2019        SR-2019-00236213    Updated to add ROTHE, removed RTHBC as not valid code
                                                        Updated to exclude contractors 


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMP401SW2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMP401SW2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMP401SW2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMP401SW2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMP401SW2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401SW2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401SW2', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401SW2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401SW2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401SW2', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEMP401SW2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMP401SW2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMP401SW2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    --remove contractors - company EKPGM coid - SR-2019-00236213
    --select cmpcompanycode, cmpcompanyname, cmpcoid from company where cmpcoid = 'EKPGM'
     DELETE FROM dbo.U_EEMP401SW2_EEList
     WHERE xCoID = 'EKPGM'
    

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEMP401SW2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMP401SW2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Build deduction history

if object_id('U_dsi_EEMP401SW2_DedHist') is not null
  drop table dbo.U_dsi_EEMP401SW2_DedHist

SELECT
    xEEID heeid,
    xCOID hcoid,
    pdhdedcode hdedcode,
    PdhEECalcRateOrPct hpct,
    PdhPayDate paydate,
    SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt

    INTO dbo.U_dsi_EEMP401SW2_DedHist
        from dbo.u_EEMP401SW2_EELIST
    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
        AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
        AND PDHDEDCODE IN ('401K','401KC','M401K','ROTH','ROTHC','401L','401L2','401KB','401BC','ROTHB','ROTHE') --added ROTHE, removed RTHBC
        AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
    GROUP BY xEEID,xCOID,PdhDedCode,PdhEECalcRateOrPct,PdhPayDate
    

    -- YTD earning history

    if object_id('U_dsi_EEMP401SW2_EarnHist') is not null
      drop table dbo.U_dsi_EEMP401SW2_EarnHist

    SELECT
        xEEID eeeid,
        xCOID ecoid,
    --    pehearncode eearncode,
        SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
        SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

        INTO dbo.U_dsi_EEMP401SW2_EarnHist
            from dbo.u_EEMP401SW2_EELIST
        JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
        --WHERE pehEarnCode in ('BONUM','BONUS','CIL','DT','DTM','GI','JURY','JURYM','LQA','ML','MR','OS1','OS1M','OT','OTI','OTII','OTM','PF','PN','REG','REGM','RETRO','SARS','SICK','SICKM','TW','TWM')
        GROUP BY xEEID,xCOID

-- Build earning history YTD W2 wages

--if object_id('U_dsi_EEMP401SW2_EarnHistW2') is not null
--  drop table dbo.U_dsi_EEMP401SW2_EarnHistW2

--    select
--        PRGEEID w2eeid
--        ,PRGCOID w2coid
--        ,YEAR(PRGPAYDATE) w2date
--        ,sum(pthcurtaxablewages) w2eamt
--    into dbo.U_dsi_EEMP401SW2_EarnHistW2
--    from iptaxhist
--    join ipayregkeys on prggennumber = pthgennumber
--    where pthtaxcode = 'USFIT' and year(prgpaydate)=year(@EndDate)
--    GROUP BY PRGEEID,PRGCOID,YEAR(PRGPAYDATE)

    -- YTD Plan compensation   
    if object_id('U_dsi_EEMP401SW2_DefCompHist') is not null  
      drop table dbo.U_dsi_EEMP401SW2_DefCompHist  

    SELECT  
     xEEID dceeid,  
     xCOID dccoid,  
     SUM(ISNULL(pehCurAmt,0.00)) AS dcamt,  
     SUM(ISNULL(pehCurHrs,0.00)) AS dchrs  

     INTO dbo.U_dsi_EEMP401SW2_DefCompHist  
      from dbo.u_EEMP401SW2_EELIST   
     JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID  
      AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)  
      AND PehEarnCode IN ('ADJUS', 'BCOM', 'BEV', 'BONUS', 'CBCOM', 'CBON', 'COLA', 'CSCOM', 'DT', 'FMLA', 'FLOAT', 'HBO', 'HOL', 'HOLOT', 'HPB', 'JURY', 'LON', 'MAT', 'MIL', 'NS3E', 'NS3HW', 'NS3OT', 'NS3RG', 'OT', 'OTC', 'PAB', 'PLN', 'PLOT', 'PTO', 'PTOPT', 'REFB', 'REG', 'REIMB', 'RETOT', 'RETRO', 'S3HW',  'S3LN', 'S3LOT', 'S3OT', 'S3REG', 'S3SAL', 'SCOM', 'SICK', 'TWOP', 'TWP', 'VAC')
     GROUP BY xEEID,xCOID 

--Get the last pay date
declare @LastPayDate as datetime
SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
AND prgPERCONTROL BETWEEN @StartPerControl and @EndPerControl




    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMP401SW2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMP401SW2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401SW2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
   --     ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvPlanNumber = '504815-01'
        ,drvSSN = eepssn
        ,drvDivision = ''
        ,drvLastname = Dbo.dsi_fnRemoveChars(',',rtrim(eepnamelast))
        ,drvFirstname = Dbo.dsi_fnRemoveChars(',',rtrim(eepnamefirst))
        ,drvMI = ''
        ,drvNameSuffix = ''
        ,drvBirthDate = CONVERT(varchar(10), eepDateOfBirth, 101)
        ,drvGender = eepGender
        ,drvMaritalStatus = eepmaritalstatus
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars(',',eepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars(',',eepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars(',',eepAddressCity)
        ,drvState = eepAddressState
        ,drvZipCode = case when len(eepAddressZipCode) > 5 then substring(eepAddressZipCode,1,5) + '-' + substring(eepAddressZipCode,6,4) else eepAddressZipCode end
        ,drvHomePhone = eepPhoneHomeNumber 
        ,drvWorkPhone = ''
        ,drvWorkPhoneExt = ''
        ,drvCountry = ''
        ,drvHireDate = CONVERT(varchar(10), eecDateOfOriginalHire, 101)--
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(varchar(10), eecDateOfTermination, 101) 
                              ELSE '' 
                              END
        ,drvRehireDate = case when eecDateOfOriginalHire <> eecDateOfLastHire then CONVERT(varchar(10), eecDateOfLastHire, 101) else cast('' as varchar) end
        ,drvCheckDate = CONVERT(varchar(10), @LastPayDate, 101)
        ,drvEmpBeforeTax = case when BTK1.ee is null or BTK1.ee = '' then '' else BTK1.ee end
        ,drvEmpMatch = case when ErMatch.er is null or ErMatch.er = '' then '' else ErMatch.er end
        ,drvLoan = Loan.ee 
        ,drvRoth = Roth.ee 
        ,drvConAmt5 = ''
        ,drvConAmt6 = ''
        ,drvConAmt7 = ''
        ,drvConAmt8 = ''
        ,drvHoursWorked = RIGHT(SPACE(5) + CAST(convert(numeric(5,0),ehrs) as varchar),5)  --convert(char(5),convert(numeric(5,0),ehrs)) --RIGHT('00000' + cast(ehrs as money),5)
        ,drvYTDTotalComp = eamt 
        ,drvYTDPlanComp = dcamt 
        ,drvYTDPreEntryComp = ''
        ,drvHighlyComp = ''
        ,drvPercentOwnership = ''
        ,drvOfficer = ''
        ,drvParticipationDate = CONVERT(varchar(10),DATEADD(mm, 2, eecdateoforiginalhire), 101)--updated from 6 months
        ,drvEligCode = 'Y'
        ,drvLOAReasonCode = ''
        ,drvLOAStartDate = ''
        ,drvLOAEndDate = ''
        ,drvEmail = eepAddressEmail
        ,drvSalary = RIGHT(SPACE(17) + cast(convert(numeric(15,2),EecAnnSalary) as varchar),17)   --convert(char(20),convert(numeric(12,2),EecAnnSalary))
        ,drvSalaryAmtQualifier = 'A'
        ,drvTermReasonCode = '' --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvSBORIndex = ''
        ,drvFederalExempt = ''
        ,drvEmpAssignedID = ''
        ,drvComplianceStatusCode = ''
    --    ,drvSSN = ''
    INTO dbo.U_EEMP401SW2_drvTbl
    FROM dbo.U_EEMP401SW2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    join dbo.U_dsi_EEMP401SW2_EarnHist on xEEID = eEEID and xCOID = eCOID
    left join dbo.U_dsi_EEMP401SW2_DefCompHist on xeeid = dceeid and xcoid = dccoid

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from
                dbo.U_dsi_EEMP401SW2_DedHist with (nolock)
                where hdedcode in ('401K','401KC','401KB','401BC') group by heeid,hcoid) BTK1 on xEEID = BTK1.hEEid and xCOID = BTK1.hCOID
                  
    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from
                dbo.U_dsi_EEMP401SW2_DedHist with (nolock)
                where hdedcode in ('M401K') group by heeid,hcoid) ErMatch on xEEID = ErMatch.hEEid and xCOID = ErMatch.hCOID

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from
                dbo.U_dsi_EEMP401SW2_DedHist with (nolock)
                where hdedcode in ('401L','401L2')  group by heeid,hcoid ) Loan on xEEID = Loan.hEEid and xCOID = Loan.hCOID

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from
                dbo.U_dsi_EEMP401SW2_DedHist with (nolock)
                where hdedcode in ('ROTHE','ROTHB','ROTH','ROTHC') group by heeid,hcoid) Roth on xEEID = Roth.hEEid and xCOID = Roth.hCOID   --removed 'RTHBC', 
    --Where (EecEmplStatus <> 'T') OR (EecEmplStatus = 'T' AND DATEDIFF(dd,eecdateoftermination,@EndDate) <= '365')

    

    ;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EEMP401SW2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_EEMP401SW2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'EEMP401SW2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEEMP401SW2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EEMP401SW2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMP401SW2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901041'
       ,expStartPerControl     = '201901041'
       ,expLastEndPerControl   = '201901049'
       ,expEndPerControl       = '201901049'
WHERE expFormatCode = 'EEMP401SW2';

**********************************************************************************/
GO
Create View dbo.dsi_vwEEMP401SW2_Export as
                            select top 200000000 Data from dbo.U_EEMP401SW2_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort