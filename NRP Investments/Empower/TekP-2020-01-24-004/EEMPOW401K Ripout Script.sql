SET NOCOUNT ON;
IF OBJECT_ID('U_EEMPOW401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEMPOW401K_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEMPOW401K' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEMPOW401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPOW401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPOW401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPOW401K];
GO
IF OBJECT_ID('U_EEMPOW401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_PEarHist];
GO
IF OBJECT_ID('U_EEMPOW401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_PDedHist];
GO
IF OBJECT_ID('U_EEMPOW401K_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_File];
GO
IF OBJECT_ID('U_EEMPOW401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_EEList];
GO
IF OBJECT_ID('U_EEMPOW401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_drvTbl];
GO
IF OBJECT_ID('U_EEMPOW401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EEMPOW401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EEMPOW401K];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMPOW401K';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMPOW401K';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMPOW401K';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMPOW401K';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMPOW401K';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMPOW401K','Fifth Third Empower Retire 401k','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EEMPOW401KZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"853191-01"','1','(''DA''=''F'')','EEMPOW401KZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EEMPOW401KZ0','11','D','10','14',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionNumber"','3','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','25',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''F'')','EEMPOW401KZ0','35','D','10','45',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','80',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','100',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''F'')','EEMPOW401KZ0','15','D','10','120',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','135',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EEMPOW401KZ0','1','D','10','145',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EEMPOW401KZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EEMPOW401KZ0','35','D','10','147',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EEMPOW401KZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','13','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','14','(''UA''=''F'')','EEMPOW401KZ0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','15','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','16','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWorkNumber"','17','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EEMPOW401KZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EEMPOW401KZ0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','22','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','23','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTax"','24','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','315',NULL,'Pre-Tax (including catch-up)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborMatch"','25','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','325',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoans"','26','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','335',NULL,'Loans',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth"','27','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','345',NULL,'Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','32','(''UA''=''F'')','EEMPOW401KZ0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYtdTotalCompensation"','33','(''UA''=''F'')','EEMPOW401KZ0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYtdPlanCompensation"','34','(''UA''=''F'')','EEMPOW401KZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EEMPOW401KZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EEMPOW401KZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','452',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','453',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','454',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','464',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','45','(''UA''=''F'')','EEMPOW401KZ0','40','D','10','474',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','46','(''UA''=''F'')','EEMPOW401KZ0','17','D','10','514',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','47','(''DA''=''F'')','EEMPOW401KZ0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCode"','48','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EEMPOW401KZ0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EEMPOW401KZ0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAssignedId"','52','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EEMPOW401KZ0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200722.txt',NULL,'','','',NULL,NULL,NULL,'Fifth Third Empower 401k','202005299','EMPEXPORT','ONDEMAND','Jun  1 2020  6:23AM','EEMPOW401K',NULL,NULL,NULL,'202005299','May 29 2020 11:09AM','May 29 2020 11:09AM','202005291','259','','','202005291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200722.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202005299','EMPEXPORT','OEACTIVE','Jun  1 2020  6:23AM','EEMPOW401K',NULL,NULL,NULL,'202005299','May 29 2020 11:09AM','May 29 2020 11:09AM','202005291','0','','','202005291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200722.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202005299','EMPEXPORT','OEPASSIVE','Jun  1 2020  6:23AM','EEMPOW401K',NULL,NULL,NULL,'202005299','May 29 2020 11:09AM','May 29 2020 11:09AM','202005291','259','','','202005291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200722.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202005299','EMPEXPORT','SCHEDU_EMP','Jun 19 2020 11:53AM','EEMPOW401K',NULL,NULL,NULL,'202005299','May 22 2020 12:00AM','Dec 30 1899 12:00AM','202005291','370','eecPayGroup','BIWEEK','202005291',dbo.fn_GetTimedKey(),NULL,'us3jBeNRP1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200722.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006059','EMPEXPORT','TEST_EMP','Jun 25 2020  4:45PM','EEMPOW401K',NULL,NULL,NULL,'202006059','Jun  5 2020 12:00AM','Dec 30 1899 12:00AM','202006051','369','eecPayGroup','BIWEEK','202006051',dbo.fn_GetTimedKey(),NULL,'us3lKiNRP1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEMPOW401K_20200722.txt' END WHERE expFormatCode = 'EEMPOW401K';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPOW401K','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EEMPOW401K' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEMPOW401K' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EEMPOW401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPOW401K','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPOW401K','D10','dbo.U_EEMPOW401K_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EEMPOW401K') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EEMPOW401K] (
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
IF OBJECT_ID('U_EEMPOW401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEMPOW401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivisionNumber] varchar(2) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneWorkNumber] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvPreTax] nvarchar(10) NULL,
    [drvSafeHarborMatch] nvarchar(10) NULL,
    [drvLoans] nvarchar(10) NULL,
    [drvRoth] nvarchar(10) NULL,
    [drvHoursWorked] varchar(5) NULL,
    [drvYtdTotalCompensation] nvarchar(11) NULL,
    [drvYtdPlanCompensation] nvarchar(11) NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] nvarchar(17) NULL,
    [drvTermReasonCode] varchar(2) NULL,
    [drvEmpAssignedId] char(9) NULL
);
IF OBJECT_ID('U_EEMPOW401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEMPOW401K_File') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EEMPOW401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPreTax] numeric NULL,
    [PdhSafeHarborMatch] numeric NULL,
    [PdhLoans] numeric NULL,
    [PdhRoth] numeric NULL
);
IF OBJECT_ID('U_EEMPOW401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPOW401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NRP Invest

Created By: James Bender
Business Analyst: Lea King
Create Date: 05/29/2020
Service Request Number: TekP-2020-01-24-004

Purpose: Fifth Third Empower Retire 401k

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPOW401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPOW401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPOW401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMPOW401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPOW401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPOW401K', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEMPOW401K';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMPOW401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FirstDayOfYear    DATETIME
            ,@LastDayOfYear        DATETIME
            ,@FirstPerControlOfYear    VARCHAR(9)
            ,@LastPerControlOfYear    VARCHAR(9)
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EEMPOW401K';

    SELECT @FirstDayOfYear = CAST('1/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR(4)) AS DATETIME)
    SELECT @LastDayOfYear = CAST('12/31/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR(4)) AS DATETIME)
    SELECT @FirstPerControlOfYear = CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '01011';
    SELECT @LastPerControlOfYear = CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '12319';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --SELECT ExpSelectByList FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND ExpExportCode = @ExportCode


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    --Add eeid and coid in eelist from  U_EEMPOW401K_PEarHist table --JAMES PLEASE TAKE A LOOK
    --START : JAMES PLEASE TAKE A LOOK
    INSERT INTO U_EEMPOW401K_EEList
    Select dbo.dsi_BDM_fn_GetCurrentCOID(PehEEID) as COID,PehEEID as eeid from U_EEMPOW401K_PEarHist where peheeid not in ( Select xeeid from dbo.U_EEMPOW401K_EEList)
    --END : JAMES PLEASE TAKE A LOOK

    DELETE FROM dbo.U_EEMPOW401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPOW401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EEMPOW401K_EEList Where xEEID IN (
        SELECT DISTINCT EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecEEType NOT IN ('REG'))

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KC,401KF,LOAN1,LOAN2,MATCH,401KP,ROTHC,ROTHF,ROTHP';

    IF OBJECT_ID('U_EEMPOW401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMPOW401K_DedList
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
    IF OBJECT_ID('U_EEMPOW401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPreTax     = SUM(CASE WHEN PdhDedCode IN ('401KC','401KF','401KP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSafeHarborMatch     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLoans     = SUM(CASE WHEN PdhDedCode IN ('LOAN1', 'LOAN2') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhRoth     = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP', 'ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        /*,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EEMPOW401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EEMPOW401K_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EEMPOW401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEArnCode NOT IN ('CAR','COMM','COMMD','EXPNS','GTL','GPYMT','HOUSE','JURY','SEV') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEArnCode NOT IN ('CAR','COMM','COMMD','EXPNS','GTL','GPYMT','HOUSE','JURY','SEV') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN PehEarnCode NOT IN ('CAR','COMM','COMMD','EXPNS','GTL','GPYMT','HOUSE','JURY','SEV') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode NOT IN ('CAR','COMM','COMMD','EXPNS','GTL','GPYMT','HOUSE','JURY','SEV') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EEMPOW401K_PEarHist
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
    -- DETAIL RECORD - U_EEMPOW401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMPOW401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = PgpPayGroup -- LEFT(CAST(PehCurHrsYTD AS VARCHAR), LEN(CAST(PehCurHrsYTD AS VARCHAR)) - 7)
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivisionNumber = CASE WHEN PrgPayGroup = 'SEMI' THEN 'D1' ELSE 'D2' END
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN ISNULL(eepMaritalStatus, '') = ''  OR EepMaritalStatus = 'Z' THEN 'S' ELSE eepMaritalStatus END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneWorkNumber = EecPhoneBusinessNumber
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                                    WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN PtdOldValue --EshStatusStopDate-- PreviousTermDate
                                END
        ,drvRehireDate =    CASE WHEN EecEmplStatus = 'A' AND EecDateOfLastHire <> EecDateOfOriginalHire THEN  EecDateOfLastHire 
                                WHEN EecEmplStatus = 'T' THEN null --''
                                ELSE null --''
                            END
        ,drvCheckDate = CASE WHEN PrgPayDate IS NOT NULL THEN
                            CASE WHEN CONVERT(DATE, PayGroupDate) > PrgPayDate THEN CONVERT(DATE, PayGroupDate) ELSE PrgPayDate END
                            ELSE CONVERT(DATE, PayGroupDate)
                        END
        ,drvPreTax = RIGHT(SPACE(10) + FORMAT(PdhPreTax, '#0.00'), 10)
        ,drvSafeHarborMatch = RIGHT(SPACE(10) + FORMAT(PdhSafeHarborMatch, '#0.00'), 10)
        ,drvLoans = RIGHT(SPACE(10) + FORMAT(PdhLoans, '#0.00'), 10)
        ,drvRoth = RIGHT(SPACE(10) + FORMAT(PdhRoth, '#0.00'), 10)
        ,drvHoursWorked = RIGHT(SPACE(5) + LEFT(CAST(PehCurHrsYTD AS VARCHAR), LEN(CAST(PehCurHrsYTD AS VARCHAR)) - 7), 5)
        ,drvYtdTotalCompensation = RIGHT(SPACE(11) + FORMAT(PehCurAmtYTD, '#0.00'), 11)
        ,drvYtdPlanCompensation = RIGHT(SPACE(11) + FORMAT(PehCurAmtYTD, '#0.00'), 11)
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvSalaryAmount = RIGHT(SPACE(17) + FORMAT(EecAnnSalary, '#0.00'), 17)
        ,drvTermReasonCode =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DE' 
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN 'S'  
                                END
        ,drvEmpAssignedId = EecEmpNo
    INTO dbo.U_EEMPOW401K_drvTbl
    FROM dbo.U_EEMPOW401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    /*LEFT JOIN dbo.U_dsi_BDM_EEMPOW401K WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID*/
    JOIN dbo.U_EEMPOW401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EEMPOW401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN (
            SELECT PrgEEID, PrgCOID, PrgPerControl, PrgPayGroup
            FROM dbo.PayReg WITH (NOLOCK)
            WHERE PrgPerControl BETWEEN @FirstPerControlOfYear AND @LastPerControlOfYear -- @StartPerControl AND @EndPerControl
        ) AS Peg_Reg
        ON PrgEEID = xEEID
        AND PrgCOID = xCOID 
    LEFT JOIN (
                SELECT audEEID AS PtdEEID, audKey2 as PtdCOID, audOldValue AS PtdOldValue
                FROM (
                    SELECT   audEEID = audKey1Value 
                            ,audKey2 = audKey2Value
                            ,audKey3 = audKey3Value
                            ,audTableName
                            ,audFieldName
                            ,audAction
                            ,audDateTime
                            ,audOldValue
                            ,audNewValue
                            ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    
                        FROM dbo.vw_AuditData WITH (NOLOCK)
                        WHERE 
                        audTableName = 'EmpComp'
                        AND audFieldName = 'EecDateOfTermination'
                        AND AudKey1Value IN (SELECT DISTINCT xEEID FROM dbo.U_EEMPOW401K_EEList WITH (NOLOCK))) AS T 
                where audRowNo = 1) AS Prev_Term
        ON PtdEEID = xEEID
        AND PtdCOID = xCOID
    JOIN (
            SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayGroupDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   AND PgpPeriodType = 'R'
                   GROUP BY PgpPayGroup
                   ) AS Pay_Group_Dates
        --ON EecPayGroup = PgpPayGroup
        ON PrgPayGroup = PgpPayGroup
    Where (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN   @FirstDayOfYear    AND @LastDayOfYear       ))
    AND ( ISNULL((SELECT REPLACE(ExpSelectByList, ' ', '') FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND ExpExportCode = @ExportCode), '') = ''
    OR
            PrgPayGroup IN (SELECT * fROM dbo.SplitStrings_CTE((SELECT ExpSelectByList FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND ExpExportCode = @ExportCode), ','))
            )
    /*AND ( (SELECT ExpSelectByList FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND ExpExportCode = @ExportCode) IS NOT NULL AND
            PrgPayGroup IN (SELECT * fROM dbo.SplitStrings_CTE((SELECT ExpSelectByList FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND ExpExportCode = @ExportCode), ','))
            )*/
        
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
ALTER VIEW dbo.dsi_vwEEMPOW401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPOW401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPOW401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005291'
       ,expStartPerControl     = '202005291'
       ,expLastEndPerControl   = '202005299'
       ,expEndPerControl       = '202005299'
WHERE expFormatCode = 'EEMPOW401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPOW401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPOW401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort