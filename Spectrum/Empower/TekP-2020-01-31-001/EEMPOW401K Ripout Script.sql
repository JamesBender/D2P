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
IF OBJECT_ID('U_EEMPOW401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_AuditFields];
GO
IF OBJECT_ID('U_EEMPOW401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEMPOW401K_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EEMPOW401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EEMPOW401K];
GO
IF OBJECT_ID('U__EEMPOW401K_JobHistTbl') IS NOT NULL DROP TABLE [dbo].[U__EEMPOW401K_JobHistTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMPOW401K';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMPOW401K';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMPOW401K';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMPOW401K';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMPOW401K';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMPOW401K','Empower 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EEMPOW401KZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"509383-01"','1','(''DA''=''F'')','EEMPOW401KZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLin2"','12','(''UA''=''F'')','EEMPOW401KZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','13','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','14','(''UA''=''F'')','EEMPOW401KZ0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','15','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','16','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneBusinessNumber"','17','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EEMPOW401KZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EEMPOW401KZ0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','22','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','23','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTax"','24','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','315',NULL,'Pre-tax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMatch"','25','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','325',NULL,'Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoans"','26','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','335',NULL,'Loans',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRoth"','27','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','345',NULL,'Roth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EEMPOW401KZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','32','(''UA''=''F'')','EEMPOW401KZ0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalComp"','33','(''UA''=''F'')','EEMPOW401KZ0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanComp"','34','(''UA''=''F'')','EEMPOW401KZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EEMPOW401KZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EEMPOW401KZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipationDate"','39','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','40','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoaReasonCode"','41','(''UA''=''F'')','EEMPOW401KZ0','1','D','10','452',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoaStartDate"','42','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','453',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoaEndDate"','43','(''UD101''=''F'')','EEMPOW401KZ0','10','D','10','463',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','473',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','45','(''UA''=''F'')','EEMPOW401KZ0','40','D','10','474',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','46','(''UA''=''F'')','EEMPOW401KZ0','17','D','10','515',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','47','(''DA''=''F'')','EEMPOW401KZ0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCode"','48','(''UA''=''F'')','EEMPOW401KZ0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EEMPOW401KZ0','1','D','10','553',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EEMPOW401KZ0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EEMPOW401KZ0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplAssignedId"','52','(''UA''=''F'')','EEMPOW401KZ0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceStatusCode"','53','(''UA''=''F'')','EEMPOW401KZ0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200427.txt',NULL,'','',NULL,NULL,NULL,NULL,'Empower 401k Export','202004249','EMPEXPORT','ONDEMAND',NULL,'EEMPOW401K',NULL,NULL,NULL,'202004249','Apr  1 2020 10:38AM','Apr  1 2020 10:38AM','202004241',NULL,'','','202004241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200427.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202004249','EMPEXPORT','SCHEDULED',NULL,'EEMPOW401K',NULL,NULL,NULL,'202004249','Apr  1 2020 10:38AM','Apr  1 2020 10:38AM','202004241',NULL,'','','202004241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200427.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202004249','EMPEXPORT','OEACTIVE',NULL,'EEMPOW401K',NULL,NULL,NULL,'202004249','Apr  1 2020 10:38AM','Apr  1 2020 10:38AM','202004241',NULL,'','','202004241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200427.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202004249','EMPEXPORT','OEPASSIVE',NULL,'EEMPOW401K',NULL,NULL,NULL,'202004249','Apr  1 2020 10:38AM','Apr  1 2020 10:38AM','202004241',NULL,'','','202004241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EEMPOW401K_20200427.txt',NULL,'','','ZLXEN,ZLXFP,ZLX6Z,ZLXAY,6PJW1,6PK5J,ZLXGT,ZLXBY,ZLX92,ZLXCU,ZLXDO,ZLX9U,ZLXLO,ZLXJX,ZLXHP,7RV7K',NULL,NULL,NULL,'Test Purposes Only','202004249','EMPEXPORT','TEST','Apr 24 2020 11:59AM','EEMPOW401K',NULL,NULL,NULL,'202004249','Apr 24 2020 12:00AM','Dec 30 1899 12:00AM','202004241','3318','','','202004241',dbo.fn_GetTimedKey(),NULL,'us3lKiSPE1014A',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EEMPOW401K_20200427.txt' END WHERE expFormatCode = 'EEMPOW401K';
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
IF OBJECT_ID('U__EEMPOW401K_JobHistTbl') IS NULL
CREATE TABLE [dbo].[U__EEMPOW401K_JobHistTbl] (
    [EjhEEID] char(12) NOT NULL,
    [EjhCOID] char(5) NOT NULL,
    [EjhIsTransfer] char(1) NULL,
    [EjhReason] char(6) NOT NULL
);
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
IF OBJECT_ID('U_EEMPOW401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_Audit] (
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
IF OBJECT_ID('U_EEMPOW401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
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
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivisionNumber] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLin2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvPreTax] nvarchar(4000) NULL,
    [drvMatch] nvarchar(4000) NULL,
    [drvLoans] nvarchar(4000) NULL,
    [drvRoth] nvarchar(4000) NULL,
    [drvHoursWorked] nvarchar(4000) NULL,
    [drvYTDTotalComp] nvarchar(4000) NULL,
    [drvYTDPlanComp] nvarchar(4000) NULL,
    [drvParticipationDate] datetime NULL,
    [drvLoaReasonCode] varchar(1) NULL,
    [drvLoaStartDate] datetime NULL,
    [drvLoaEndDate] datetime NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] money NULL,
    [drvTermReasonCode] varchar(1) NULL,
    [drvEmplAssignedId] char(9) NULL,
    [drvComplianceStatusCode] varchar(1) NULL
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
    [PdhPreTaxAmt] numeric NULL,
    [PdhMatchAmt] numeric NULL,
    [PdhLoansAmt] numeric NULL,
    [PdhRothAmt] numeric NULL
);
IF OBJECT_ID('U_EEMPOW401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMPOW401K_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurPlanAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [PehHourWorked] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPOW401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Spectrum Retirement Community

Created By: James Bender
Business Analyst: Lea King
Create Date: 04/01/2020
Service Request Number: TekP-2020-01-31-001

Purpose: Empower 401k Export

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
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EEMPOW401K';

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEMPOW401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_AuditFields;
    CREATE TABLE dbo.U_EEMPOW401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EEMPOW401K_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEMPOW401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPOW401K_Audit;
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
    INTO dbo.U_EEMPOW401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPOW401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audOldValue = 'L'
    AND audNewValue = 'A'
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPOW401K_Audit ON dbo.U_EEMPOW401K_Audit (audEEID,audCOID);


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEMPOW401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPOW401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EEMPOW401K_EEList 
    WHERE xEEID IN (
        SELECT DISTINCT EecEEID from EmpComp where eecEEType IN('CON','REG')
    );

    DELETE FROM dbo.U_EEMPOW401K_EEList 
    WHERE xEEID IN (
        SELECT DISTINCT EepEEID from EmpPers WHERE EepSSN IN ('999999999')
    );


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401F,401PC,401FC,ROTH2,ROTHF,RTHPC,RTHFC,4KLON,4KLN2,4KLN3,KLN,MATCH';

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
        ,PdhPreTaxAmt     = SUM(CASE WHEN PdhDedCode IN ('401K', '401F', '401PC', '401FC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhMatchAmt     = SUM(CASE WHEN PdhDedCode IN ('401K', '401F', '401PC', '401FC', 'ROTH2', 'ROTHF', 'RTHPC', 'RTHFC', 'MATCH') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLoansAmt     = SUM(CASE WHEN PdhDedCode IN ('4KLON', '4KLN2', '4KLN3', 'KLN') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothAmt     = SUM(CASE WHEN PdhDedCode IN ('ROTH2', 'ROTHF','RTHPC','RTHFC') THEN PdhEECurAmt ELSE 0.00 END)
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
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt) -- SUM(CASE WHEN PehEarnCode NOT IN ('MBSD', 'MBSOT', 'NSOT', 'SHFT3', 'WEK') THEN PehCurAmt ELSE 0.00 END)
        --,PehCurAmtYTD           =  SUM(CASE WHEN PehEarnCode NOT IN ('MBSD', 'MBSOT', 'NSOT', 'SHFT3', 'WEK') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurPlanAmtYTD       = SUM(CASE WHEN PehEarnCode IN ('BRK2','BRV','FTO','HLW','HOL','HST','JUR','MBSD','MBSOT','NSOT','OBERN','PDBRK','PTO','R','REG','SCK','SHFT3','VSB','WEK','WEKOT','AZSIK','BO1','BO2','BO3','BO4','BRKOT','BYE','COM','EPBON','FBBON','OT','PAYPT') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        -- Start here
        ,PehHourWorked = SUM(CASE WHEN PehEarnCode NOT IN ('MBSD', 'MBSOT', 'NSOT', 'SHFT3', 'WEK') THEN PehCurHrs ELSE 0.00 END)        
    INTO dbo.U_EEMPOW401K_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    DECLARE @CompanyCode VARCHAR(5);
    SELECT @CompanyCode =  CmmCompanyCode FROM dbo.CompMast WITH (NOLOCK)


    IF OBJECT_ID('U__EEMPOW401K_JobHistTbl', 'U') IS NOT NULL
        DROP TABLE dbo.U__EEMPOW401K_JobHistTbl;
    SELECT EjhEEID, EjhCOID, EjhIsTransfer, EjhReason
    INTO dbo.U__EEMPOW401K_JobHistTbl
    FROM dbo.EmpHJob WITH (NOLOCK)
    JOIN dbo.U_EEMPOW401K_EEList WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    WHERE EjhIsTransfer = 'Y'


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
        ,drvSort = '' --CONVERT(DATE, PayGroupDate) --EecPayGroup + ' ' + CAST(PayGroupDate AS VARCHAR) + ' ' + FORMAT(PrgPayDate, 'MM/dd/yyyy')
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivisionNumber = CmpCompanyCode
                /*CASE CmpCompanyCode
                                    WHEN 'SRMIL' THEN 'D1'
                                    WHEN 'SRC' THEN 'D16'
                                    WHEN 'SRCNY' THEN 'D18'
                                    WHEN 'SRCOH' THEN 'D2'
                                    WHEN 'SRMNM' THEN 'D5'
                                    WHEN 'SRCAZ' THEN 'D6'
                                    WHEN 'SRCCO' THEN 'D7'
                                    WHEN 'SRCIL' THEN 'D8'
                                    WHEN 'SRCIN' THEN 'D9'
                                    WHEN 'SRCKS' THEN 'D10'
                                    WHEN 'SRCMI' THEN 'D17'
                                    WHEN 'SRCMO' THEN 'D11'
                                    WHEN 'SRCOR' THEN 'D13'
                                    WHEN 'SRCTX' THEN 'D14'
                                END*/
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN ISNULL(eepMaritalStatus, '') <> '' THEN EepMaritalStatus ELSE '' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLin2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN PtdOldValue 
                                END        
        ,drvRehireDate = CASE WHEN (SELECT COUNT(*) FROM dbo.U__EEMPOW401K_JobHistTbl WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhIsTransfer = 'Y' AND EjhReason = '101') > 0 THEN 
                                -- Determine which is later, send that.
                                CASE WHEN EecDateOfOriginalHire > EecDateOfLastHire THEN EecDateOfOriginalHire ELSE EecDateOfLastHire END
                            WHEN  (SELECT COUNT(*) FROM dbo.U__EEMPOW401K_JobHistTbl WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhIsTransfer = 'Y' AND EjhReason <> '101') > 0 THEN null
                            ELSE 
                                CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
                                
                        END
        --CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        




        ,drvCheckDate =    CASE WHEN PrgPayDate IS NOT NULL THEN
                            CASE WHEN CONVERT(DATE, PayGroupDate) > PrgPayDate THEN CONVERT(DATE, PayGroupDate) ELSE PrgPayDate END
                            ELSE CONVERT(DATE, PayGroupDate)
                        END
        
        /*CASE WHEN PayDate IS NOT NULL THEN PayDate -- jcb
                            WHEN PayDate IS NULL THEN PayGroupDate
                            WHEN PayDate IS NOT NULL AND PayDate > PayGroupDate THEN PayDate
                            WHEN PayDate IS NOT NULL AND PayDate < PayGroupDate THEN PayGroupDate
                        END-- CASE WHEN PdhPreTaxAmt IS NOT NULL OR PdhRothAmt IS NOT NULL THEN PayDate END --PgrPayDate
                        */







        ,drvPreTax = FORMAT(PdhPreTaxAmt, '0.00')
        ,drvMatch = FORMAT(PdhMatchAmt, '0.00')
        ,drvLoans = FORMAT(PdhLoansAmt, '0.00')
        ,drvRoth = FORMAT(PdhRothAmt, '0.00')
        ,drvHoursWorked = FORMAT(PehHourWorked, '0')
        ,drvYTDTotalComp = FORMAT(PehCurAmtYTD, '0.00')
        ,drvYTDPlanComp = FORMAT(PehCurPlanAmtYTD, '0.00')
        ,drvParticipationDate = EepUDField05
        ,drvLoaReasonCode = CASE WHEN ISNULL(audDateTime, '') <> '' OR  EecEmplStatus = 'L' THEN 'L' END -- JCB
        ,drvLoaStartDate = CASE WHEN ISNULL(audDateTime, '') <> '' OR EecEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvLoaEndDate = CASE WHEN ISNULL(audDateTime, '') <> '' THEN EshStatusStopDate END
        ,drvWorkEmailAddress = CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail ELSE EepAddressEmailAlternate END
        ,drvSalaryAmount = EecAnnSalary
        ,drvTermReasonCode = CASE WHEN EecEmplStatus = 'T' THEN 'L' /*EecTermReason*/ END
        ,drvEmplAssignedId = EecEmpNo
        ,drvComplianceStatusCode =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                    END
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
    /*JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup*/
    LEFT JOIN dbo.U_EEMPOW401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EEMPOW401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    LEFT JOIN dbo.U_EEMPOW401K_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    JOIN dbo.Company WITH (NOLOCK)
        ON EecCoId = CmpCoId
    JOIN (


            SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayGroupDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   AND PgpPeriodType = 'R'
                   GROUP BY PgpPayGroup
                   
                   
                   
                   ) AS Pay_Group_Dates
        ON EecPayGroup = PgpPayGroup
    left JOIN (



            SELECT PrgEEID, PrgCOID, MAX(PrgPayDate) AS PayDate
            FROM dbo.PayReg WITH (NOLOCK)
            WHERE  PrgPerControl BETWEEN @StartPerControl AND @EndPerControl  -- JCB
                AND PrgTransactionType IN ('D', 'C')
            GROUP BY PrgEEID, PrgCOID) AS PAY_DATES





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
    WHERE EecEmplStatus <> 'T' -- JCB
            OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(DAY, -30, @EndDate))
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
    SET expLastStartPerControl = '202004241'
       ,expStartPerControl     = '202004241'
       ,expLastEndPerControl   = '202004249'
       ,expEndPerControl       = '202004249'
WHERE expFormatCode = 'EEMPOW401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPOW401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPOW401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort