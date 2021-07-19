SET NOCOUNT ON;
IF OBJECT_ID('U_EEMPWR401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEMPWR401K_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEMPWR401K' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEMPWR401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPWR401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPWR401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPWR401K];
GO
IF OBJECT_ID('U_EEMPWR401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_PEarHist];
GO
IF OBJECT_ID('U_EEMPWR401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_PDedHist];
GO
IF OBJECT_ID('U_EEMPWR401K_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_File];
GO
IF OBJECT_ID('U_EEMPWR401K_EmpHJob') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_EmpHJob];
GO
IF OBJECT_ID('U_EEMPWR401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_EEList];
GO
IF OBJECT_ID('U_EEMPWR401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_drvTbl];
GO
IF OBJECT_ID('U_EEMPWR401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_DedList];
GO
IF OBJECT_ID('U_EEMPWR401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_AuditFields];
GO
IF OBJECT_ID('U_EEMPWR401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMPWR401K';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMPWR401K';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMPWR401K';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMPWR401K';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMPWR401K';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMPWR401K','Empower 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','708','S','N','EEMPWR401KZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEMPWR401K' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"455269-01"','1','(''DA''=''F'')','EEMPWR401KZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','2','(''UA''=''F'')','EEMPWR401KZ0','11','D','10','0',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionnumber"','3','(''UA''=''F'')','EEMPWR401KZ0','20','D','10','0',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''F'')','EEMPWR401KZ0','35','D','10','0',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''F'')','EEMPWR401KZ0','20','D','10','0',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','6','(''UA''=''F'')','EEMPWR401KZ0','20','D','10','0',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','7','(''UA''=''F'')','EEMPWR401KZ0','15','D','10','0',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','8','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EEMPWR401KZ0','35','D','10','0',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EEMPWR401KZ0','35','D','10','0',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''F'')','EEMPWR401KZ0','20','D','10','0',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','14','(''UA''=''F'')','EEMPWR401KZ0','2','D','10','0',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','16','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneNumber"','17','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','18','(''UA''=''F'')','EEMPWR401KZ0','4','D','10','0',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','19','(''UA''=''F'')','EEMPWR401KZ0','2','D','10','0',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReHireDate"','22','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckdate"','23','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount1"','24','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount2"','25','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount3"','26','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount4"','27','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount5"','28','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount6"','29','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount7"','30','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount8"','31','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHoursWorked"','32','(''UA''=''F'')','EEMPWR401KZ0','5','D','10','0',NULL,'YTD Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalCompensation"','33','(''UA''=''F'')','EEMPWR401KZ0','11','D','10','0',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanCompensation"','34','(''UA''=''F'')','EEMPWR401KZ0','11','D','10','0',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPreEntryCompensation"','35','(''UA''=''F'')','EEMPWR401KZ0','11','D','10','0',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyCompEmployeeCode"','36','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPercentofOwnership"','37','(''UA''=''F'')','EEMPWR401KZ0','6','D','10','0',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficerDetermination"','38','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipationDate"','39','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Participation Date (ACQUISITION DATE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityCode"','40','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvP1P2Splits"','41','(''UA''=''F'')','EEMPWR401KZ0','2','D','10','0',NULL,'P1/P2 Splits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAReasonCode"','42','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'LOA Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAStartDate"','43','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'LOA Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAEndDate"','44','(''UD101''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','45','(''UA''=''F'')','EEMPWR401KZ0','80','D','10','0',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','46','(''UA''=''F'')','EEMPWR401KZ0','17','D','10','0',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmountQualifier"','47','(''UA''=''F'')','EEMPWR401KZ0','2','D','10','0',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','48','(''UA''=''F'')','EEMPWR401KZ0','20','D','10','0',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSarbanesOxleyReporting"','49','(''UA''=''F'')','EEMPWR401KZ0','1','D','10','0',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','EEMPWR401KZ0','6','D','10','0',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFederalExemptions"','51','(''UA''=''F'')','EEMPWR401KZ0','2','D','10','0',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerAssignedID"','52','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceStatusCode"','53','(''UA''=''F'')','EEMPWR401KZ0','6','D','10','0',NULL,'Compliance Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalEmailAddress"','54','(''UA''=''F'')','EEMPWR401KZ0','80','D','10','0',NULL,'Personal Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhone"','55','(''UA''=''F'')','EEMPWR401KZ0','10','D','10','0',NULL,'Mobile Phone',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EEMPWR401K_20210709.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',RW4WR,S92VK,S92SH,S92PR,90P54,S92N5,K2WNB',NULL,NULL,NULL,'Empower 401K Export Send','202002069','EMPEXPORT','EEMPKOE',NULL,'EEMPWR401K',NULL,NULL,NULL,'202002069',NULL,NULL,'202002061',NULL,NULL,'','202002061',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',RW4WR,S92VK,S92SH,S92PR,90P54,S92N5,K2WNB',NULL,NULL,NULL,'Empower 401K Export','201909279','EMPEXPORT','ONDEMAND',NULL,'EEMPWR401K',NULL,NULL,NULL,'201909279','Nov 27 2019 11:24AM','Nov 27 2019 11:24AM','201909271',NULL,'','','201909271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911279','EMPEXPORT','SCHEDULED',NULL,'EEMPWR401K',NULL,NULL,NULL,'201911279','Nov 27 2019 11:24AM','Nov 27 2019 11:24AM','201911271',NULL,'','','201911271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202107092','EMPEXPORT','TEST',NULL,'EEMPWR401K',NULL,NULL,NULL,'202107092','Nov 27 2019 11:24AM','Nov 27 2019 11:24AM','202107092',NULL,'','','202107092',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EEMPWR401K' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EEMPWR401K' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EEMPWR401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPWR401K','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPWR401K','D10','dbo.U_EEMPWR401K_drvTbl',NULL);
IF OBJECT_ID('U_EEMPWR401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EEMPWR401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EEMPWR401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEMPWR401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvDivisionnumber] char(5) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvCheckdate] varchar(10) NULL,
    [drvContributionAmount1] varchar(10) NULL,
    [drvContributionAmount2] varchar(10) NULL,
    [drvContributionAmount3] varchar(10) NULL,
    [drvContributionAmount4] varchar(10) NULL,
    [drvContributionAmount5] varchar(10) NULL,
    [drvContributionAmount6] varchar(10) NULL,
    [drvContributionAmount7] varchar(1) NOT NULL,
    [drvContributionAmount8] varchar(1) NOT NULL,
    [drvYTDHoursWorked] varchar(5) NULL,
    [drvYTDTotalCompensation] varchar(11) NULL,
    [drvYTDPlanCompensation] varchar(11) NULL,
    [drvYTDPreEntryCompensation] varchar(11) NULL,
    [drvHighlyCompEmployeeCode] char(1) NULL,
    [drvPercentofOwnership] varchar(1) NOT NULL,
    [drvOfficerDetermination] char(1) NULL,
    [drvParticipationDate] datetime NULL,
    [drvEligibilityCode] varchar(1) NOT NULL,
    [drvP1P2Splits] varchar(2) NOT NULL,
    [drvLOAReasonCode] varchar(1) NOT NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] varchar(17) NULL,
    [drvSalaryAmountQualifier] varchar(1) NOT NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvSarbanesOxleyReporting] varchar(1) NOT NULL,
    [drvFederalExemptions] varchar(1) NOT NULL,
    [drvEmployerAssignedID] char(9) NULL,
    [drvComplianceStatusCode] varchar(1) NOT NULL,
    [drvPersonalEmailAddress] varchar(50) NULL,
    [drvMobilePhone] varchar(50) NULL
);
IF OBJECT_ID('U_EEMPWR401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEMPWR401K_EmpHJob') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_EmpHJob] (
    [EjhEEID] char(12) NOT NULL,
    [EjhCOID] char(5) NOT NULL,
    [EjhHireReHireDate] datetime NULL
);
IF OBJECT_ID('U_EEMPWR401K_File') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(708) NULL
);
IF OBJECT_ID('U_EEMPWR401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_PDedHist] (
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
    [PdhSource6] numeric NULL
);
IF OBJECT_ID('U_EEMPWR401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPWR401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Gray Television

Created By: Sean Farrell
Business Analyst: Karen Formicone
Create Date: 11/27/2019
Service Request Number: SR-2019-00244787

Purpose: Empower 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
Nicci Blady            10/20/2020        NoSR-PartnerDirect    Update to send amounts > 0.00, add new ded codes, update contribution buckets
Keary McCutchen        07/09/2021        Rehire dates (field 22 Re-Hire Date on Empower spec)
                                    Acquisition dates (field 39 Participation Date on Empower spec)
                                    P1/P2 splits (field 41 Filler on Empower spec)
                                    Employees reporting on multiple files when transferring companies/stations


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPWR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl, ExpDesc, * FROM dbo.AscExp WHERE expFormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPWR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'EEMPKOE';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMPWR401K', @AllObjects = 'Y', @IsWeb = 'Y';

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
    SELECT @FormatCode = 'EEMPWR401K';

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
    -- Max PayDate
    --==========================================

    DECLARE @CheckDate VARCHAR(10);

    SELECT

    @CheckDate = CONVERT(VARCHAR,MAX(PrgPayDate),101)
    FROM dbo.PayReg WITH (NOLOCK)
    WHERE LEFT(PrgPerControl,4) = LEFT(@EndPerControl,4)
    AND PrgPerControl <= @EndPerControl;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEMPWR401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPWR401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- PdhDedCode  = K401K, K4CU, KLN1, KLN2 and EedBenStatus is Cancelled drop from file.
    DELETE EE
    FROM dbo.U_EEMPWR401K_EEList EE
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
       AND EedCOID = XCOID
       AND EedDedCode IN ('K401K', 'K4CU', 'KLN1', 'KLN2')
       AND EedBenStatus = 'C'
    ;
    
    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEMPWR401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_AuditFields;
    CREATE TABLE dbo.U_EEMPWR401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EEMPWR401K_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEMPWR401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EEMPWR401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPWR401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(d,-14,@EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPWR401K_Audit ON dbo.U_EEMPWR401K_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EEMPWR401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EEMPWR401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'K401K,K2CU,KLN1,KLN2,K4CU,KERM,KRTHK,KAFTX';            --10/20/2020 Added KERM (Combined ER Match),KRTHK (Roth regular),KAFTX (Roth After Tax) ded codes - NB

    IF OBJECT_ID('U_EEMPWR401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMPWR401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - EmpHJob
    -----------------------------
    IF OBJECT_ID('U_EEMPWR401K_EmpHJob','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_EmpHJob;
    SELECT DISTINCT
          EjhEEID
         ,EjhCOID
         ,EjhHireReHireDate = MAX(EjhJobEffDate)
    INTO dbo.U_EEMPWR401K_EmpHJob
    FROM dbo.EmpHJob WITH (NOLOCK)

    WHERE EjhJobEffDate BETWEEN @StartDate AND @EndDate
     AND EjhReason IN ('100','101','J111','J117') --Only New Hires and ReHires
    GROUP BY EjhEEID,EjhCoID
    ;
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EEMPWR401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('K401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('K4CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('K401K','KERM') THEN PdhERCurAmt ELSE 0.00 END)            --10/20/2020 Added KERM (Combined ER Match) ded code - NB
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('KLN1','KLN2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('KRTHK') THEN PdhEECurAmt ELSE 0.00 END)                    --10/20/2020 Added KRTHK (Roth regular) ded code - NB
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('KAFTX') THEN PdhEECurAmt ELSE 0.00 END)                    --10/20/2020 Added KAFTX (Roth After Tax) ded code - NB
    INTO dbo.U_EEMPWR401K_PDedHist
    FROM dbo.U_EEMPWR401K_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
       AND PdhCoID = xCOID
    JOIN dbo.U_EEMPWR401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl    -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) > 0.00            --11/18/2020 Updated per client request - NB
        OR SUM(PdhERCurAmt) > 0.00)
    ;


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EEMPWR401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
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
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EEMPWR401K_PEarHist
    FROM dbo.U_EEMPWR401K_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
       AND PrgCoID = xCOID
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
    -- DETAIL RECORD - U_EEMPWR401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMPWR401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvEmployeeSSN = eepSSN
        ,drvDivisionnumber = CmpCompanyCode
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE eepMaritalStatus WHEN 'M' THEN 'M' WHEN 'D' THEN 'D' WHEN 'W' THEN 'W' ELSE 'S' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhoneNumber = EepPhoneHomeNumber
        ,drvWorkPhoneNumber = EmpComp.EecPhoneBusinessNumber
        ,drvWorkPhoneExt = ''
        ,drvCountryCode = 'US'
        ,drvHireDate = EmpComp.EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EmpComp.EecEmplStatus = 'T' THEN EmpComp.EecDateOfTermination
                                   WHEN EmpComp.EecEMplStatus = 'A' AND EmpComp.EecDateOfLastHire <> EmpComp.EecdateOfOriginalHire AND Exists (SELECT Top 1 * FROM dbo.EmpHStat WITH (NOLOCK) WHERE EshEEID = xEEID AND EshCOID = xCOID AND ESHEmplStatus = 'T' ORDER BY EshStatusStartDate DESC)
                                    THEN (SELECT DATEADD(d,-1,MAX(EshStatusStartDate)) FROM dbo.EmpHStat WITH (NOLOCK) WHERE EshEEID = xEEID AND EshCOID = xCOID AND ESHEmplStatus = 'T')
                                    ELSE NULL
                              END
        ,drvReHireDate = CASE WHEN  EmpComp.EecDateOfLastHire = Employment_AcquisitionDate THEN NULL 
                              WHEN  EmpComp.EecDateOfLastHire != Employment_AcquisitionDate THEN EmpComp.EecDateOfTermination
                              WHEN  EjhHireReHireDate IS NOT NULL THEN EmpComp.EecDateOfLastHire
                          END
--CASE WHEN EmpComp.EecDateOFLastHire <> EmpComp.EecDateofOriginalHire THEN EmpComp.EecdateOfLastHire ELSE NULL END
        ,drvCheckdate = @CheckDate
        ,drvContributionAmount1 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource1)),'0.00'),10)
        ,drvContributionAmount2 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource2)),'0.00'),10)
        ,drvContributionAmount3 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource3)),'0.00'),10)
        ,drvContributionAmount4 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource4)),'0.00'),10)
        ,drvContributionAmount5 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource5)),'0.00'),10)        --''--'0.00'        --10/20/2020 Added KRTHK (Roth regular) contributions - NB
        ,drvContributionAmount6 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource6)),'0.00'),10)        --''--'0.00'        --10/20/2020 Added KAFTX (Roth After Tax) contributions - NB
        ,drvContributionAmount7 = ''--'''0.00'
        ,drvContributionAmount8 = ''--'0.00'
        ,drvYTDHoursWorked = RIGHT(SPACE(5) + CONVERT(VARCHAR,CONVERT(NUMERIC(10),PehCurHrsYTD)),5)
        ,drvYTDTotalCompensation = RIGHT(SPACE(11) + CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PehInclInDefCompYTD)),11)
        ,drvYTDPlanCompensation = RIGHT(SPACE(11) + CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PehInclInDefCompYTD)),11)
        ,drvYTDPreEntryCompensation = CASE WHEN dbo.dsi_fnlib_TrueWeeklyandMonthlyDATEDIFF('Monthly',EmpComp.EecDateOfOriginalhire,@EndDate) < 6 THEN RIGHT(SPACE(11) + CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PehInclInDefCompYTD)),11) ELSE '' END
        ,drvHighlyCompEmployeeCode = EmpComp.EecUDFIELD22
        ,drvPercentofOwnership = ''
        ,drvOfficerDetermination = EmpComp.EecUDFIELD21
        ,drvParticipationDate = CASE WHEN Employment_AcquisitionDate IS NULL THEN EmpComp.EecDateOfOriginalHire ELSE Employment_AcquisitionDate END
        ,drvEligibilityCode = 'Y'
        ,drvP1P2Splits = CASE WHEN EecPayGroup = 'ATLST2' THEN 'P2' ELSE 'P1' END
        ,drvLOAReasonCode = CASE WHEN EmpComp.EecEmplStatus = 'L' AND EmpComp.EecLeaveReason = '300' THEN 'M' ELSE '' END
        ,drvLOAStartDate = CASE WHEN EmpComp.EecEmplStatus = 'L' AND EmpComp.EecLeaveReason = '300' THEN EmpComp.EecEmplStatusStartDate ELSE NULL END
        ,drvLOAEndDate = CASE WHEN EmpComp.EecLeaveReason = '300' AND audOLdValue = 'L' AND audNewValue <> 'L' THEN audDateTime ELSE NULL END
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvSalaryAmount = RIGHT(SPACE(17) + CASE EmpComp.EecSalaryOrHourly WHEN 'H' THEN CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),EmpComp.EecHourlyPayRate)) ELSE CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),EmpComp.EecPeriodPayRate)) END,17)
        ,drvSalaryAmountQualifier = CASE EmpComp.EecSalaryOrHourly WHEN 'H' THEN 'H' ELSE 'B' END
        ,drvTerminationReasonCode = CASE WHEN EmpComp.EecEmplStatus = 'T' THEN 
                                                CASE EmpComp.EecTermReason 
                                                        WHEN '203' THEN 'DE'
                                                        WHEN '300' THEN 'LA'
                                                        WHEN '202' THEN 'R'
                                                        ELSE 'S'
                                                END
                                   END
        ,drvSarbanesOxleyReporting = ''
        ,drvFederalExemptions = ''
        ,drvEmployerAssignedID = EmpComp.EecEmpno
        ,drvComplianceStatusCode = ''
        ,drvPersonalEmailAddress = EepAddressEMailAlternate
        ,drvMobilePhone = EfoPhoneNumber
    INTO dbo.U_EEMPWR401K_drvTbl
    FROM dbo.U_EEMPWR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp EmpComp WITH (NOLOCK)
        ON EmpComp.EecEEID = xEEID 
        AND EmpComp.EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EEMPWR401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EEMPWR401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EEMPWR401K_Audit WITH (NOLOCK)
        ON audEEID = xEEID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
        AND EfoIsPrivate = 'N'
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    LEFT JOIN  fn_MP_CustomFields_EmpComp_export (null, null, null, null) PltfrmCfg
        ON PltfrmCfg.EecEEID = xEEID
       AND PltfrmCfg.EecCoID = xCOID
    LEFT JOIN dbo.U_EEMPWR401K_EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
       AND EjhCOID = XCOID
    WHERE (EmpComp.EecEmplStatus IN ('A','L')
    OR (EmpComp.EecEMplStatus = 'T' AND (DATEDIFF(d,@EndDate,EmpComp.EecDateOfTermination) BETWEEN 0 AND 30 
                OR PehCurAmt > 0.00)))
                /* (PdhSource1 > 0.00
                OR PdhSource2 > 0.00
                OR PdhSource3 > 0.00
                OR PdhSource4 > 0.00)))*/
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

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPWR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl, ExpDesc, * FROM dbo.AscExp WHERE expFormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPWR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'EEMPKOE';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMPWR401K', @AllObjects = 'Y', @IsWeb = 'Y';

--Alter the View
ALTER VIEW dbo.dsi_vwEEMPWR401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPWR401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPWR401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

SELECT * FROM dbo.AscDefh
WHERE ADHFORMATCODE =  'EEMPWR401K'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107092'
       ,expStartPerControl     = '202107092'
       ,expLastEndPerControl   = '202107092'
       ,expEndPerControl       = '202107092'
WHERE expFormatCode = 'EEMPWR401K'
AND expExportCode = 'TEST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPWR401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPWR401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort