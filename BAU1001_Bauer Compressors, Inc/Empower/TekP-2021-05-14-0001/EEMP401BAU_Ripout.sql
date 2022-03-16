SET NOCOUNT ON;
IF OBJECT_ID('U_EEMP401BAU_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEMP401BAU_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEMP401BAU' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEMP401BAU_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMP401BAU_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMP401BAU_BKUP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401BAU_BKUP];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMP401BAU') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401BAU];
GO
IF OBJECT_ID('U_EEMP401BAU_PDedHist_PreTaxSec125') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_PDedHist_PreTaxSec125];
GO
IF OBJECT_ID('U_EEMP401BAU_File') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_File];
GO
IF OBJECT_ID('U_EEMP401BAU_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_EEList];
GO
IF OBJECT_ID('U_EEMP401BAU_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_drvTbl];
GO
IF OBJECT_ID('U_EEMP401BAU_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_DedList];
GO
IF OBJECT_ID('U_dsi_EEMP401BAU_EarnHistW2') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401BAU_EarnHistW2];
GO
IF OBJECT_ID('U_dsi_EEMP401BAU_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401BAU_EarnHist];
GO
IF OBJECT_ID('U_dsi_EEMP401BAU_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401BAU_DedHist];
GO
IF OBJECT_ID('U_dsi_EEMP401BAU_Ded125') IS NOT NULL DROP TABLE [dbo].[U_dsi_EEMP401BAU_Ded125];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEMP401BAU';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEMP401BAU';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEMP401BAU';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEMP401BAU';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEMP401BAU';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMP401BAU','Empower 401K - Plan 372447-01','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EEMP401BAUZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEMP401BAU' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EEMP401BAUZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EEMP401BAUZ0','11','D','10','14',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''F'')','EEMP401BAUZ0','20','D','10','25',NULL,'Division number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastname"','4','(''UA''=''F'')','EEMP401BAUZ0','35','D','10','45',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''F'')','EEMP401BAUZ0','20','D','10','80',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMI"','6','(''UA''=''F'')','EEMP401BAUZ0','20','D','10','100',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','7','(''UA''=''F'')','EEMP401BAUZ0','15','D','10','120',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','8','(''UD101''=''F'')','EEMP401BAUZ0','10','D','10','135',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''F'')','EEMP401BAUZ0','1','D','10','145',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EEMP401BAUZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','11','(''UA''=''F'')','EEMP401BAUZ0','35','D','10','147',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','12','(''UA''=''F'')','EEMP401BAUZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','13','(''UA''=''F'')','EEMP401BAUZ0','20','D','10','217',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','14','(''UA''=''F'')','EEMP401BAUZ0','2','D','10','237',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''F'')','EEMP401BAUZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','16','(''UA''=''F'')','EEMP401BAUZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','17','(''UA''=''F'')','EEMP401BAUZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','18','(''UA''=''F'')','EEMP401BAUZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','19','(''UA''=''F'')','EEMP401BAUZ0','2','D','10','273',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''F'')','EEMP401BAUZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UD101''=''F'')','EEMP401BAUZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','22','(''UD101''=''F'')','EEMP401BAUZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','23','(''UD101''=''F'')','EEMP401BAUZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt1"','24','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','315',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt2"','25','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','325',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt3"','26','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','335',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt4"','27','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','345',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt5"','28','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt6"','29','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt7"','30','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConAmt8"','31','(''UNT2''=''F'')','EEMP401BAUZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','32','(''UNT0''=''F'')','EEMP401BAUZ0','5','D','10','395',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalComp"','33','(''UNT2''=''F'')','EEMP401BAUZ0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanComp"','34','(''UNT2''=''F'')','EEMP401BAUZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPreEntryComp"','35','(''UNT2''=''F'')','EEMP401BAUZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyComp"','36','(''UA''=''F'')','EEMP401BAUZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPercentOwnership"','37','(''UA''=''F'')','EEMP401BAUZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficer"','38','(''UA''=''F'')','EEMP401BAUZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipationDate"','39','(''UD101''=''F'')','EEMP401BAUZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligCode"','40','(''UA''=''F'')','EEMP401BAUZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeforeTaxContributionPer"','41','(''UA''=''F'')','EEMP401BAUZ0','3','D','10','452',NULL,'Before-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeforeTaxContributionAmt"','42','(''UA''=''F'')','EEMP401BAUZ0','8','D','10','455',NULL,'Before-Tax Contribution $',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAfterTaxContributionPer"','43','(''UA''=''F'')','EEMP401BAUZ0','3','D','10','463',NULL,'After-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAfterTaxContributionAmt"','44','(''UA''=''F'')','EEMP401BAUZ0','8','D','10','466',NULL,'After-Tax Contribution $',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','45','(''UA''=''F'')','EEMP401BAUZ0','40','D','10','474',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','46','(''UNT2''=''F'')','EEMP401BAUZ0','17','D','10','514',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmtQualifier"','47','(''UA''=''F'')','EEMP401BAUZ0','2','D','10','531',NULL,'Salary Amount Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCode"','48','(''UA''=''F'')','EEMP401BAUZ0','20','D','10','533',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSBORIndex"','49','(''UA''=''F'')','EEMP401BAUZ0','1','D','10','553',NULL,'SOX Ind',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','EEMP401BAUZ0','6','D','10','554',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFederalExempt"','51','(''UA''=''F'')','EEMP401BAUZ0','2','D','10','560',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAssignedID"','52','(''UA''=''F'')','EEMP401BAUZ0','10','D','10','562',NULL,'Employer Assigned ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComplianceStatusCode"','53','(''UA''=''F'')','EEMP401BAUZ0','6','D','10','572',NULL,'Compliance Status Code',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EEMP401BAU_20210821.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Empower 401K Export','202001311','EMPEXPORT','EEMP401BAU','Feb  5 2020  5:27PM','EEMP401BAU',NULL,NULL,NULL,'202001311','Jan 31 2020 12:00AM','Jan 31 2020 12:00AM','202001311','162','eecPayGroup','BCIBW,BCIWK','202001311',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBACOI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','QX8A8',NULL,NULL,NULL,'Empower 401K Test File','202107309','EMPEXPORT','TEST','Aug  5 2021  9:55AM','EEMP401BAU',NULL,NULL,NULL,'202107309','Jul 30 2021 12:00AM','Dec 30 1899 12:00AM','202107301','236','eecPayGroup','BCIBW,BCIWK','202107301',dbo.fn_GetTimedKey(),NULL,'us3lKiBAU1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401BAU','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401BAU','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401BAU','InitialSort','C','drvPlanNumber');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401BAU','SubSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401BAU','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401BAU','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EEMP401BAU' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EEMP401BAU' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EEMP401BAU_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEMP401BAU_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP401BAU','H01','dbo.U_EEMP401BAU_Header','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP401BAU','D10','dbo.U_EEMP401BAU_drvTbl',NULL);
IF OBJECT_ID('U_dsi_EEMP401BAU_Ded125') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401BAU_Ded125] (
    [dedEEID] char(12) NOT NULL,
    [dedCOID] char(5) NOT NULL,
    [dedAmount] money NULL
);
IF OBJECT_ID('U_dsi_EEMP401BAU_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401BAU_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [hpct] decimal NULL,
    [paydate] datetime NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);
IF OBJECT_ID('U_dsi_EEMP401BAU_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401BAU_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EEMP401BAU_EarnHistW2') IS NULL
CREATE TABLE [dbo].[U_dsi_EEMP401BAU_EarnHistW2] (
    [w2eeid] char(12) NOT NULL,
    [w2coid] char(5) NOT NULL,
    [w2date] int NULL,
    [w2eamt] money NULL
);
IF OBJECT_ID('U_EEMP401BAU_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMP401BAU_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EEMP401BAU_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMP401BAU_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvPlanNumber] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivision] varchar(2) NULL,
    [drvLastname] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMI] varchar(1) NOT NULL,
    [drvNameSuffix] varchar(1) NOT NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvCheckdate] datetime NULL,
    [drvConAmt1] money NULL,
    [drvConAmt2] money NULL,
    [drvConAmt3] money NULL,
    [drvConAmt4] money NULL,
    [drvConAmt5] varchar(1) NOT NULL,
    [drvConAmt6] varchar(1) NOT NULL,
    [drvConAmt7] varchar(1) NOT NULL,
    [drvConAmt8] varchar(1) NOT NULL,
    [drvHoursWorked] varchar(30) NULL,
    [drvYTDTotalComp] money NULL,
    [drvYTDPlanComp] money NULL,
    [drvYTDPreEntryComp] varchar(1) NOT NULL,
    [drvHighlyComp] varchar(1) NOT NULL,
    [drvPercentOwnership] varchar(1) NOT NULL,
    [drvOfficer] varchar(1) NOT NULL,
    [drvParticipationDate] varchar(1) NOT NULL,
    [drvEligCode] varchar(1) NOT NULL,
    [drvBeforeTaxContributionPer] varchar(1) NOT NULL,
    [drvBeforeTaxContributionAmt] varchar(1) NOT NULL,
    [drvAfterTaxContributionPer] varchar(1) NOT NULL,
    [drvAfterTaxContributionAmt] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvSalary] money NULL,
    [drvSalaryAmtQualifier] varchar(1) NOT NULL,
    [drvTermReasonCode] varchar(1) NOT NULL,
    [drvSBORIndex] varchar(1) NOT NULL,
    [drvFederalExempt] varchar(1) NOT NULL,
    [drvEmpAssignedID] varchar(1) NOT NULL,
    [drvComplianceStatusCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EEMP401BAU_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMP401BAU_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEMP401BAU_File') IS NULL
CREATE TABLE [dbo].[U_EEMP401BAU_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EEMP401BAU_PDedHist_PreTaxSec125') IS NULL
CREATE TABLE [dbo].[U_EEMP401BAU_PDedHist_PreTaxSec125] (
    [prEEID] char(12) NOT NULL,
    [prCOID] char(5) NOT NULL,
    [prYTDAmt] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401BAU]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bauer Compressors, Inc.

Created By: Vinny Kelly
Business Analyst: Tamie Strickland
Create Date: 3/01/2018
Service Request Number: BAU1001-2017-00168205-Interface File - Empower Pension

Purpose: Empower 401K - Plan No 372447-01

Revision History
----------------
Update By           Date        Request Num                Desc
Lynn Manning        12/3/2019    SR-2019-00248896        Update LOANS to pull based on dedtype = 'LON'; add 401CE; Include ALL employees on file; update Total Comp and Plan Comp
Keary McCutchen        07/31/2021     SR-2021-00313865        Merge EPB401BAU & EEMP401BAU
                                 TekP-2021-05-14-0001

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMP401BAU';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMP401BAU';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMP401BAU';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMP401BAU';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMP401BAU' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401BAU', 'EEMP401BAU';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401BAU', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMP401BAU', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMP401BAU';

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
    DELETE FROM dbo.U_EEMP401BAU_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMP401BAU_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    


    --delete tmp
    /*DELETE FROM dbo.U_EEMP401BAU_EEList
        WHERE xeeid+xcoid in (select eeceeid+eeccoid from empcomp where eeceetype = 'TMP')*/

    delete dbo.u_EPB401BAU_EELIST
        from dbo.u_EPB401BAU_EELIST
        join empcomp with (nolock) on xeeid = eeceeid and xcoid = eeccoid
        where EecEEType in ('TMP')


    --==================================================
    -- Cleans EELIST of employees with invalid SSNs
    --===================================================
    DELETE FROM dbo.U_EEMP401BAU_EEList
    WHERE xEEID IN (
        SELECT eepEEID FROM dbo.EmpPers
        WHERE LEFT(EepSSN,3) IN ('000','666') 
        OR LEFT(EepSSN,3) >= '900'
        OR SUBSTRING(EepSSN,4,2) = '00'
        OR RIGHT(RTRIM(EepSSN),4) = '0000' 
    );
        

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    --Added '401GP,401GR,401GC,401RG,401CG,401C - KJM 7/31/2021 
    SET @DedList = '401P,401CP,401ER,401RT,401CE,401EC,401GP,401GR,401GC,401RG,401CG,401C';

    IF OBJECT_ID('U_EEMP401BAU_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401BAU_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMP401BAU_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    INSERT INTO dbo.U_EEMP401BAU_DedList
    SELECT DISTINCT
        DedCode = DedDedCode
        ,DedType = DedDedType
    FROM dbo.DedCode WITH (NOLOCK)
    WHERE DedDedType = 'LON'
    AND DedDedCode <> 'LOAN';

    -- select * from dbo.U_EEMP401BAU_DedList


    --=====================================================
    --  Start BDM Configuration
    --======================================================

    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @DedList)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')  --  Options are AuditDate, StopDate, or ActiveOnly
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'DEF')
    
    IF @ExportCode IN ('OEPASSIVE','PASSIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')     END

    IF @ExportCode IN ('OEACTIVE','ACTIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')    END
    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -- SELECT * FROM U_Dsi_BDM_EmpDeductions WHERE EedFormatCode = 'EEMP401BAU'


    --====================================================================
    -- Now get the LOANS
    --=====================================================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    DECLARE @LoanList VARCHAR(MAX)
    SET @LoanList = (SELECT DISTINCT DedDedCode = REPLACE((    SELECT RTRIM(DedDedCode) AS [data()] 
                                                            FROM dbo.DedCode
                                                            WHERE DedDedType = 'LON' AND DedDedCode <> 'LOAN'
                                                            FOR XML PATH('')), ' ', ',') );
    --PRINT @LoanList
    
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @LoanList)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'StopDate')  --  Options are AuditDate, StopDate, or ActiveOnly
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'LOAN')
    
    IF @ExportCode IN ('OEPASSIVE','PASSIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')     END

    IF @ExportCode IN ('OEACTIVE','ACTIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')    END
    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -- SELECT * FROM U_DSI_BDM_EmpDeductions WHERE eedFormatCode = 'EEMP401BAU' AND EedValidForExport = 'Y' AND EedRunID = 'LOAN'


    --=============================================================
    -- Now get Grandfathered Plan
    --=========================================================================
    /* Removed GF Plan 7/31/2021 KJM
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    DECLARE @Grandfather VARCHAR(MAX)
    SET @Grandfather = ('401GP,401GR,401GC,401RG,401CG,401C')


    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @Grandfather)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')  --  Options are AuditDate, StopDate, or ActiveOnly
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'GF')
    
    IF @ExportCode IN ('OEPASSIVE','PASSIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')     END

    IF @ExportCode IN ('OEACTIVE','ACTIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')    END
    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -- SELECT * FROM U_DSI_BDM_EmpDeductions WHERE eedFormatCode = 'EEMP401BAU' AND EedValidForExport = 'Y' AND EedRunID = 'GF'



    --==============================================================
    -- Remove employees that belong to the Grandfathered Plan (EPB401BAU)
    --  IF Employee had one the grandfathered deduction codes and does not have a "regular" deduction 
    --   then they were grandfathered in and should be removed.
    --==========================================================================
    DELETE    dbo.U_EEMP401BAU_EEList
    FROM    dbo.U_EEMP401BAU_EEList
    LEFT JOIN dbo.U_DSI_BDM_EmpDeductions 
        ON EedEEID = xEEID AND EedCOID = xCOID AND eedFormatCode = 'EEMP401BAU' AND EedValidForExport = 'Y' AND EedRunID = 'GF'
    WHERE
        ISNULL(EedEEID,'') <> '';
    --KJM */

    --===========================
    -- Get the last pay date
    --===========================
    DECLARE @LastPayDate as datetime;
    SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
    AND prgPERCONTROL BETWEEN @StartPerControl and @EndPerControl;

    

    --==========================================
    -- Build Working Tables
    --==========================================
    if object_id('U_dsi_EEMP401BAU_DedHist') is not null
      drop table dbo.U_dsi_EEMP401BAU_DedHist

    SELECT
        xEEID heeid,
        xCOID hcoid,
        pdhdedcode hdedcode,
        PdhEECalcRateOrPct hpct,
        PdhPayDate paydate,
        SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
        SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt 

    INTO dbo.U_dsi_EEMP401BAU_DedHist
    FROM dbo.u_EEMP401BAU_EELIST WITH (NOLOCK)
    JOIN dbo.PDEDHIST WITH (NOLOCK)
        ON xeeid = PdhEEID AND xCOID = PdhCOID
    JOIN dbo.U_EEMP401BAU_DedList WITH (NOLOCK)
        ON PdhDedCode = DedCode
    WHERE
        (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)            
        AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
    GROUP BY xEEID,xCOID,PdhDedCode,PdhEECalcRateOrPct,PdhPayDate

    --select * from U_dsi_EEMP401BAU_DedHist
    --select pdhdedcode,* from PDEDHIST where pdhdedcode like '%401%' order by 1


    --=========================================================
    -- Build earning history YTD - Deferred Comp Earnings
    --==========================================================
    if object_id('U_dsi_EEMP401BAU_EarnHist') is not null
      drop table dbo.U_dsi_EEMP401BAU_EarnHist;

    SELECT
        xEEID eeeid,
        xCOID ecoid,
        SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
        SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

    INTO dbo.U_dsi_EEMP401BAU_EarnHist
    FROM dbo.u_EEMP401BAU_EELIST  WITH (NOLOCK)
    JOIN dbo.PEARHIST  WITH (NOLOCK)
        ON xeeid = pehEEID and xCOID = PehCOID
        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
        AND pehInclInDefComp = 'Y'
    GROUP BY xEEID,xCOID;

    --=================================================================
    -- Build earning history YTD W2 wages PLUS AUTOA earning per Dena Corr
    --==================================================================
    if object_id('U_dsi_EEMP401BAU_EarnHistW2') is not null
      drop table dbo.U_dsi_EEMP401BAU_EarnHistW2;
    select 
         pthEEID w2eeid
        ,pthCOID w2coid
        ,YEAR(pthPAYDATE) w2date
        ,w2eamt = sum(pthcurtaxablewages) + sum(ISNULL(pehCurAmt,0.00))
    into dbo.U_dsi_EEMP401BAU_EarnHistW2
    FROM dbo.u_EEMP401BAU_EELIST  WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON xEEID = pthEEID AND xCOID = pthCOID
    LEFT JOIN (    SELECT pehEEID, pehGenNumber, SUM(pehCurAmt) PehCurAmt
                FROM dbo.PEarHist 
                WHERE pehEarnCode = 'AUTOA'
                GROUP BY pehEEID, pehGenNumber ) AUTOA
        ON PehGenNumber = pthGennumber
    where pthtaxcode = 'USFIT' 
    and year(pthpaydate)=year(@EndDate)
    GROUP BY pthEEID,pthCOID,YEAR(pthPAYDATE);


    --==================================================================
    -- Get DEDUCTION PreTax Deferral & Section 125 YTD Amounts
    -- Created 10/25/2019 LynnM
    --==================================================================
    IF OBJECT_ID('U_EEMP401BAU_PDedHist_PreTaxSec125','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401BAU_PDedHist_PreTaxSec125;
    SELECT
         prEEID = PdhEEID
        ,prCOID = PdhCOID
        ,prYTDAmt = SUM(PdhEECurAmt)
    INTO 
        dbo.U_EEMP401BAU_PDedHist_PreTaxSec125
    FROM
        dbo.U_EEMP401BAU_EELIST WITH (NOLOCK)
    JOIN
        dbo.PDedHist WITH (NOLOCK)
            ON PdhEEID = xEEID
            AND PdhCOID = xCOID
            AND LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    JOIN
        dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = PdhDedCode
    JOIN 
        ULTIPRO_SYSTEM..DTaxCat WITH (NOLOCK)
            ON  DtcCode = DedTaxCategory
            AND dtcHasBeenReplaced = 'N' 
            AND dtcCountryCode = 'USA' 
            AND GETDATE() between dtcEffectiveDate and dtcEffectiveStopDate 
            AND (DtcDedPlanType LIKE '%125%' OR dtcIsDefComp = 'Y') 
    GROUP BY PdhEEID, PdhCOID;

    -- select * from dbo.U_EEMP401BAU_PDedHist_PreTaxSec125


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMP401BAU_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMP401BAU_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401BAU_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '372447'--7/31/2021 KJM '372447-01'
        ,drvSSN = eepSSN
        ,drvDivision = CASE WHEN m.isgr IS NULL AND EecPayPeriod = 'W' THEN 'D1' 
                            WHEN m.isgr IS NULL AND EecPayPeriod = 'B' THEN 'D2'
                            WHEN m.isgr = 'Y' AND EecPayPeriod = 'W' THEN 'D3'
                            WHEN m.isgr = 'Y' AND EecPayPeriod = 'B' THEN 'D4'
                        END
                        --7/27/21 KJM case when eecpayperiod = 'W' then 'D1' when eecpayperiod = 'B' then 'D2' end
        ,drvLastname = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMI = ''
        ,drvNameSuffix = ''
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = ''
        ,drvWorkPhoneExt = ''
        ,drvCountry = ''
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvReHireDate = case when eecDateOfOriginalHire <> eecDateOfLastHire
                      AND CoXfer.reason <> 'TRI' THEN eecDateOfLastHire END
        ,drvCheckdate = @LastPayDate
        ,drvConAmt1 = case when isnull(k.ee,'') = '' then '0.00' else k.ee end  --401K including CU
        ,drvConAmt2 = case when isnull(r.ee,'') = '' then '0.00' else r.ee end  --Roth including CU
        ,drvConAmt3 = case when isnull(l.ee,'') = '' then '0.00' else l.ee end  --Loans
        ,drvConAmt4 = case when isnull(m.er,'') = '' then '0.00' else m.er end  --ER Match
        ,drvConAmt5 = ''
        ,drvConAmt6 = ''
        ,drvConAmt7 = ''
        ,drvConAmt8 = ''
        ,drvHoursWorked = cast(ehrs as varchar)
        ,drvYTDTotalComp = ISNULL(w2eamt,0.00) + ISNULL(prYTDAmt,0.00)
        ,drvYTDPlanComp = eamt
        ,drvYTDPreEntryComp = ''
        ,drvHighlyComp = ''
        ,drvPercentOwnership = ''
        ,drvOfficer = ''
        ,drvParticipationDate = ''
        ,drvEligCode = ''
        ,drvBeforeTaxContributionPer = ''
        ,drvBeforeTaxContributionAmt = ''
        ,drvAfterTaxContributionPer = ''
        ,drvAfterTaxContributionAmt = ''
        ,drvEmail = EepAddressEMail
        ,drvSalary = EecAnnSalary
        ,drvSalaryAmtQualifier = 'A'
        ,drvTermReasonCode = ''
        ,drvSBORIndex = ''
        ,drvFederalExempt = ''
        ,drvEmpAssignedID = ''
        ,drvComplianceStatusCode = ''
    INTO dbo.U_EEMP401BAU_drvTbl
    FROM dbo.U_EEMP401BAU_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_EEMP401BAU_EarnHistW2 -- W2 gross wages
        ON xeeid = w2eeid 
        and xcoid = w2coid
    left join dbo.U_dsi_EEMP401BAU_EarnHist   -- Def Comp earnings
        ON xEEID = eEEID 
        and xCOID = eCOID   
    left join dbo.U_EEMP401BAU_PDedHist_PreTaxSec125  -- deductions: Section 125 and DEF
        ON prEEID = xEEID 
        and prCOID = xCOID
    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                where hdedcode in ('401GP','401GC','401CG','401C','401P','401CP','401CE','401EC') /* 7/31/2021 KJM ('401P','401CP','401CE','401EC')*/ group by heeid,hcoid) k on xEEID = k.hEEid and xCOID = k.hCOID

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                where hdedcode in ('401RG','401RT') group by heeid,hcoid) r on xEEID = r.hEEid and xCOID = r.hCOID --ADDED 401RG KJM 7/31/2021

    left join (select heeid, hcoid, isgr=max(case when hdedcode = '401GR' THEN 'Y' END), sum(heeamt) ee, sum(heramt) er from
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                where hdedcode in ('401GR','401ER') group by heeid,hcoid) m on xEEID = m.hEEid and xCOID = m.hCOID --ADDED 401GR KJM 7/31/2021

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                JOIN dbo.U_EEMP401BAU_DedList WITH (NOLOCK)
                    ON DedType = 'LON'
                    AND DedCode = hDedCode
                group by heeid,hcoid) l on xEEID = l.hEEid and xCOID = l.hCOID
    LEFT JOIN (select distinct ejheeid eeid, ejhcoid coid, ejhreason reason, ejhJobEffDate jdate
            from emphjob
            where ejhreason = 'TRI') as CoXfer on CoXfer.eeid = xeeid and CoXfer.coid = xcoid
    --LEFT JOIN (SELECT PlnEEID
    --        FROM dbo.U_EEMP401BAU_PlnSource
    --        WHERE PlnSource2 <> 0) GR on GR.PlnEEID = xEEID
    --WHERE ((PdhSource1+PdhSource2+PdhSource3+PdhSource4+PdhSource5+PdhSource6 <> 0) OR
    --        PehCurAmtYTD <> 0 OR PehCurHrsYTD <> 0 )    
    --;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EMPROY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_EMPROY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'EMPROY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************


sp_geteeid 'Goralski'
declare @EEID VARCHAR(12) = 'BSGMOZ01O0K0'
SELECT EedEEID, EedCOID, EedDedCode, EedBenStartDate, EedBenStopDate, * FROM EMPDED WHERE EedEEID = @EEID AND EedDedCode IN ('401GP','401GR','401GC','401RG','401CG','401P','401CP','401ER','401RT','401CE')
SELECT * FROM dbo.U_EEMP401BAU_EEList WHERE xEEID = @EEID
SELECT * FROM dbo.U_dsi_EEMP401BAU_DedHist WHERE hEEID = @EEID
SELECT * FROM dbo.U_dsi_EEMP401BAU_EarnHist WHERE eEEID = @EEID
SELECT * FROM dbo.U_dsi_EEMP401BAU_EarnHistW2 WHERE w2EEID = @EEID
SELECT * FROM dbo.U_EEMP401BAU_PDedHist_PreTaxSec125 WHERE prEEID = @EEID
SELECT * FROM dbo.U_EEMP401BAU_drvTbl WHERE drvEEID = @EEID




--Alter the View
ALTER VIEW dbo.dsi_vwEEMP401BAU_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EEMP401BAU_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMP401BAU%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201709281'
       ,expStartPerControl     = '201709281'
       ,expLastEndPerControl   = '201710059'
       ,expEndPerControl       = '201710059'
WHERE expFormatCode = 'EEMP401BAU';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401BAU]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bauer Compressors, Inc.

Created By: Vinny Kelly
Business Analyst: Tamie Strickland
Create Date: 3/01/2018
Service Request Number: BAU1001-2017-00168205-Interface File - Empower Pension

Purpose: Empower 401K - Plan No 372447-01

Revision History
----------------
Update By           Date        Request Num            Desc
Lynn Manning        12/3/2019    SR-2019-00248896    Update LOANS to pull based on dedtype = 'LON'; add 401CE; Include ALL employees on file; update Total Comp and Plan Comp


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMP401BAU';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMP401BAU';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMP401BAU';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMP401BAU';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMP401BAU' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401BAU', 'EEMP401BAU';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401BAU', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMP401BAU', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMP401BAU';

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
    DELETE FROM dbo.U_EEMP401BAU_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMP401BAU_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    


    --delete tmp
    /*DELETE FROM dbo.U_EEMP401BAU_EEList
        WHERE xeeid+xcoid in (select eeceeid+eeccoid from empcomp where eeceetype = 'TMP')*/

    delete dbo.u_EPB401BAU_EELIST
        from dbo.u_EPB401BAU_EELIST
        join empcomp with (nolock) on xeeid = eeceeid and xcoid = eeccoid
        where EecEEType in ('TMP')


    --==================================================
    -- Cleans EELIST of employees with invalid SSNs
    --===================================================
    DELETE FROM dbo.U_EEMP401BAU_EEList
    WHERE xEEID IN (
        SELECT eepEEID FROM dbo.EmpPers
        WHERE LEFT(EepSSN,3) IN ('000','666') 
        OR LEFT(EepSSN,3) >= '900'
        OR SUBSTRING(EepSSN,4,2) = '00'
        OR RIGHT(RTRIM(EepSSN),4) = '0000' 
    );
        

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401P,401CP,401ER,401RT,401CE,401EC';

    IF OBJECT_ID('U_EEMP401BAU_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401BAU_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMP401BAU_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    INSERT INTO dbo.U_EEMP401BAU_DedList
    SELECT DISTINCT
        DedCode = DedDedCode
        ,DedType = DedDedType
    FROM dbo.DedCode WITH (NOLOCK)
    WHERE DedDedType = 'LON'
    AND DedDedCode <> 'LOAN';

    -- select * from dbo.U_EEMP401BAU_DedList


    --=====================================================
    --  Start BDM Configuration
    --======================================================

    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @DedList)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')  --  Options are AuditDate, StopDate, or ActiveOnly
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'DEF')
    
    IF @ExportCode IN ('OEPASSIVE','PASSIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')     END

    IF @ExportCode IN ('OEACTIVE','ACTIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')    END
    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -- SELECT * FROM U_Dsi_BDM_EmpDeductions WHERE EedFormatCode = 'EEMP401BAU'


    --====================================================================
    -- Now get the LOANS
    --=====================================================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    DECLARE @LoanList VARCHAR(MAX)
    SET @LoanList = (SELECT DISTINCT DedDedCode = REPLACE((    SELECT RTRIM(DedDedCode) AS [data()] 
                                                            FROM dbo.DedCode
                                                            WHERE DedDedType = 'LON' AND DedDedCode <> 'LOAN'
                                                            FOR XML PATH('')), ' ', ',') );
    --PRINT @LoanList
    
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @LoanList)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'StopDate')  --  Options are AuditDate, StopDate, or ActiveOnly
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'LOAN')
    
    IF @ExportCode IN ('OEPASSIVE','PASSIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')     END

    IF @ExportCode IN ('OEACTIVE','ACTIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')    END
    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -- SELECT * FROM U_DSI_BDM_EmpDeductions WHERE eedFormatCode = 'EEMP401BAU' AND EedValidForExport = 'Y' AND EedRunID = 'LOAN'


    --=============================================================
    -- Now get Grandfathered Plan
    --=========================================================================

    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    DECLARE @Grandfather VARCHAR(MAX)
    SET @Grandfather = ('401GP,401GR,401GC,401RG,401CG,401C')


    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @Grandfather)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')  --  Options are AuditDate, StopDate, or ActiveOnly
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'GF')
    
    IF @ExportCode IN ('OEPASSIVE','PASSIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')     END

    IF @ExportCode IN ('OEACTIVE','ACTIVE')
    BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')    END
    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -- SELECT * FROM U_DSI_BDM_EmpDeductions WHERE eedFormatCode = 'EEMP401BAU' AND EedValidForExport = 'Y' AND EedRunID = 'GF'



    --==============================================================
    -- Remove employees that belong to the Grandfathered Plan (EPB401BAU)
    --  IF Employee had one the grandfathered deduction codes and does not have a "regular" deduction 
    --   then they were grandfathered in and should be removed.
    --==========================================================================
    DELETE    dbo.U_EEMP401BAU_EEList
    FROM    dbo.U_EEMP401BAU_EEList
    LEFT JOIN dbo.U_DSI_BDM_EmpDeductions 
        ON EedEEID = xEEID AND EedCOID = xCOID AND eedFormatCode = 'EEMP401BAU' AND EedValidForExport = 'Y' AND EedRunID = 'GF'
    WHERE
        ISNULL(EedEEID,'') <> '';


    --===========================
    -- Get the last pay date
    --===========================
    DECLARE @LastPayDate as datetime;
    SELECT @LastPayDate = max(prgpaydate)  FROM IPAYREGKEYS WHERE prgdocno <> 'ADJUSTMENT'
    AND prgPERCONTROL BETWEEN @StartPerControl and @EndPerControl;

    

    --==========================================
    -- Build Working Tables
    --==========================================
    if object_id('U_dsi_EEMP401BAU_DedHist') is not null
      drop table dbo.U_dsi_EEMP401BAU_DedHist

    SELECT
        xEEID heeid,
        xCOID hcoid,
        pdhdedcode hdedcode,
        PdhEECalcRateOrPct hpct,
        PdhPayDate paydate,
        SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
        SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt 

    INTO dbo.U_dsi_EEMP401BAU_DedHist
    FROM dbo.u_EEMP401BAU_EELIST WITH (NOLOCK)
    JOIN dbo.PDEDHIST WITH (NOLOCK)
        ON xeeid = PdhEEID AND xCOID = PdhCOID
    JOIN dbo.U_EEMP401BAU_DedList WITH (NOLOCK)
        ON PdhDedCode = DedCode
    WHERE
        (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)            
        AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
    GROUP BY xEEID,xCOID,PdhDedCode,PdhEECalcRateOrPct,PdhPayDate

    --select * from U_dsi_EEMP401BAU_DedHist
    --select pdhdedcode,* from PDEDHIST where pdhdedcode like '%401%' order by 1


    --=========================================================
    -- Build earning history YTD - Deferred Comp Earnings
    --==========================================================
    if object_id('U_dsi_EEMP401BAU_EarnHist') is not null
      drop table dbo.U_dsi_EEMP401BAU_EarnHist;

    SELECT
        xEEID eeeid,
        xCOID ecoid,
        SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
        SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

    INTO dbo.U_dsi_EEMP401BAU_EarnHist
    FROM dbo.u_EEMP401BAU_EELIST  WITH (NOLOCK)
    JOIN dbo.PEARHIST  WITH (NOLOCK)
        ON xeeid = pehEEID and xCOID = PehCOID
        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
        AND pehInclInDefComp = 'Y'
    GROUP BY xEEID,xCOID;

    --=================================================================
    -- Build earning history YTD W2 wages PLUS AUTOA earning per Dena Corr
    --==================================================================
    if object_id('U_dsi_EEMP401BAU_EarnHistW2') is not null
      drop table dbo.U_dsi_EEMP401BAU_EarnHistW2;
    select 
         pthEEID w2eeid
        ,pthCOID w2coid
        ,YEAR(pthPAYDATE) w2date
        ,w2eamt = sum(pthcurtaxablewages) + sum(ISNULL(pehCurAmt,0.00))
    into dbo.U_dsi_EEMP401BAU_EarnHistW2
    FROM dbo.u_EEMP401BAU_EELIST  WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON xEEID = pthEEID AND xCOID = pthCOID
    LEFT JOIN (    SELECT pehEEID, pehGenNumber, SUM(pehCurAmt) PehCurAmt
                FROM dbo.PEarHist 
                WHERE pehEarnCode = 'AUTOA'
                GROUP BY pehEEID, pehGenNumber ) AUTOA
        ON PehGenNumber = pthGennumber
    where pthtaxcode = 'USFIT' 
    and year(pthpaydate)=year(@EndDate)
    GROUP BY pthEEID,pthCOID,YEAR(pthPAYDATE);


    --==================================================================
    -- Get DEDUCTION PreTax Deferral & Section 125 YTD Amounts
    -- Created 10/25/2019 LynnM
    --==================================================================
    IF OBJECT_ID('U_EEMP401BAU_PDedHist_PreTaxSec125','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401BAU_PDedHist_PreTaxSec125;
    SELECT
         prEEID = PdhEEID
        ,prCOID = PdhCOID
        ,prYTDAmt = SUM(PdhEECurAmt)
    INTO 
        dbo.U_EEMP401BAU_PDedHist_PreTaxSec125
    FROM
        dbo.U_EEMP401BAU_EELIST WITH (NOLOCK)
    JOIN
        dbo.PDedHist WITH (NOLOCK)
            ON PdhEEID = xEEID
            AND PdhCOID = xCOID
            AND LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    JOIN
        dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = PdhDedCode
    JOIN 
        ULTIPRO_SYSTEM..DTaxCat WITH (NOLOCK)
            ON  DtcCode = DedTaxCategory
            AND dtcHasBeenReplaced = 'N' 
            AND dtcCountryCode = 'USA' 
            AND GETDATE() between dtcEffectiveDate and dtcEffectiveStopDate 
            AND (DtcDedPlanType LIKE '%125%' OR dtcIsDefComp = 'Y') 
    GROUP BY PdhEEID, PdhCOID;

    -- select * from dbo.U_EEMP401BAU_PDedHist_PreTaxSec125


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMP401BAU_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMP401BAU_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401BAU_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '372447-01'
        ,drvSSN = eepSSN
        ,drvDivision = case when eecpayperiod = 'W' then 'D1' when eecpayperiod = 'B' then 'D2' end
        ,drvLastname = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMI = ''
        ,drvNameSuffix = ''
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = ''
        ,drvWorkPhoneExt = ''
        ,drvCountry = ''
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvReHireDate = case when eecDateOfOriginalHire <> eecDateOfLastHire
                      AND CoXfer.reason <> 'TRI' THEN eecDateOfLastHire END
        ,drvCheckdate = @LastPayDate
        ,drvConAmt1 = case when isnull(k.ee,'') = '' then '0.00' else k.ee end  --401K including CU
        ,drvConAmt2 = case when isnull(r.ee,'') = '' then '0.00' else r.ee end  --Roth including CU
        ,drvConAmt3 = case when isnull(l.ee,'') = '' then '0.00' else l.ee end  --Loans
        ,drvConAmt4 = case when isnull(m.er,'') = '' then '0.00' else m.er end  --ER Match
        ,drvConAmt5 = ''
        ,drvConAmt6 = ''
        ,drvConAmt7 = ''
        ,drvConAmt8 = ''
        ,drvHoursWorked = cast(ehrs as varchar)
        ,drvYTDTotalComp = ISNULL(w2eamt,0.00) + ISNULL(prYTDAmt,0.00)
        ,drvYTDPlanComp = eamt
        ,drvYTDPreEntryComp = ''
        ,drvHighlyComp = ''
        ,drvPercentOwnership = ''
        ,drvOfficer = ''
        ,drvParticipationDate = ''
        ,drvEligCode = ''
        ,drvBeforeTaxContributionPer = ''
        ,drvBeforeTaxContributionAmt = ''
        ,drvAfterTaxContributionPer = ''
        ,drvAfterTaxContributionAmt = ''
        ,drvEmail = EepAddressEMail
        ,drvSalary = EecAnnSalary
        ,drvSalaryAmtQualifier = 'A'
        ,drvTermReasonCode = ''
        ,drvSBORIndex = ''
        ,drvFederalExempt = ''
        ,drvEmpAssignedID = ''
        ,drvComplianceStatusCode = ''
    INTO dbo.U_EEMP401BAU_drvTbl
    FROM dbo.U_EEMP401BAU_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_EEMP401BAU_EarnHistW2 -- W2 gross wages
        ON xeeid = w2eeid 
        and xcoid = w2coid
    left join dbo.U_dsi_EEMP401BAU_EarnHist   -- Def Comp earnings
        ON xEEID = eEEID 
        and xCOID = eCOID   
    left join dbo.U_EEMP401BAU_PDedHist_PreTaxSec125  -- deductions: Section 125 and DEF
        ON prEEID = xEEID 
        and prCOID = xCOID
    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                where hdedcode in ('401P','401CP','401CE','401EC') group by heeid,hcoid) k on xEEID = k.hEEid and xCOID = k.hCOID

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                where hdedcode in ('401RT') group by heeid,hcoid) r on xEEID = r.hEEid and xCOID = r.hCOID

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                where hdedcode in ('401ER') group by heeid,hcoid) m on xEEID = m.hEEid and xCOID = m.hCOID

    left join (select heeid, hcoid, sum(heeamt) ee, sum(heramt) er from 
                dbo.U_dsi_EEMP401BAU_DedHist with (nolock)
                JOIN dbo.U_EEMP401BAU_DedList WITH (NOLOCK)
                    ON DedType = 'LON'
                    AND DedCode = hDedCode
                group by heeid,hcoid) l on xEEID = l.hEEid and xCOID = l.hCOID
    LEFT JOIN (select distinct ejheeid eeid, ejhcoid coid, ejhreason reason, ejhJobEffDate jdate
            from emphjob
            where ejhreason = 'TRI') as CoXfer on CoXfer.eeid = xeeid and CoXfer.coid = xcoid
    --LEFT JOIN (SELECT PlnEEID
    --        FROM dbo.U_EEMP401BAU_PlnSource
    --        WHERE PlnSource2 <> 0) GR on GR.PlnEEID = xEEID
    --WHERE ((PdhSource1+PdhSource2+PdhSource3+PdhSource4+PdhSource5+PdhSource6 <> 0) OR
    --        PehCurAmtYTD <> 0 OR PehCurHrsYTD <> 0 )    
    --;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EMPROY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_EMPROY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'EMPROY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************


sp_geteeid 'Goralski'
declare @EEID VARCHAR(12) = 'BSGMOZ01O0K0'
SELECT EedEEID, EedCOID, EedDedCode, EedBenStartDate, EedBenStopDate, * FROM EMPDED WHERE EedEEID = @EEID AND EedDedCode IN ('401GP','401GR','401GC','401RG','401CG','401P','401CP','401ER','401RT','401CE')
SELECT * FROM dbo.U_EEMP401BAU_EEList WHERE xEEID = @EEID
SELECT * FROM dbo.U_dsi_EEMP401BAU_DedHist WHERE hEEID = @EEID
SELECT * FROM dbo.U_dsi_EEMP401BAU_EarnHist WHERE eEEID = @EEID
SELECT * FROM dbo.U_dsi_EEMP401BAU_EarnHistW2 WHERE w2EEID = @EEID
SELECT * FROM dbo.U_EEMP401BAU_PDedHist_PreTaxSec125 WHERE prEEID = @EEID
SELECT * FROM dbo.U_EEMP401BAU_drvTbl WHERE drvEEID = @EEID




--Alter the View
ALTER VIEW dbo.dsi_vwEEMP401BAU_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EEMP401BAU_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMP401BAU%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201709281'
       ,expStartPerControl     = '201709281'
       ,expLastEndPerControl   = '201710059'
       ,expEndPerControl       = '201710059'
WHERE expFormatCode = 'EEMP401BAU';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMP401BAU_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EEMP401BAU_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;