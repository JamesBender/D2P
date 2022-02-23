SET NOCOUNT ON;
IF OBJECT_ID('U_EBCVAN401X_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBCVAN401X_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBCVAN401X' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBCVAN401X_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBCVAN401X_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBCVAN401X') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBCVAN401X];
GO
IF OBJECT_ID('U_EBCVAN401X_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_PEarHist];
GO
IF OBJECT_ID('U_EBCVAN401X_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_PDedHist];
GO
IF OBJECT_ID('U_EBCVAN401X_Header') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_Header];
GO
IF OBJECT_ID('U_EBCVAN401X_File') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_File];
GO
IF OBJECT_ID('U_EBCVAN401X_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_EEList];
GO
IF OBJECT_ID('U_EBCVAN401X_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvTrailer];
GO
IF OBJECT_ID('U_EBCVAN401X_drvPartTbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvPartTbl];
GO
IF OBJECT_ID('U_EBCVAN401X_drvLoanTbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvLoanTbl];
GO
IF OBJECT_ID('U_EBCVAN401X_drvEmailTbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvEmailTbl];
GO
IF OBJECT_ID('U_EBCVAN401X_drvContBTbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvContBTbl];
GO
IF OBJECT_ID('U_EBCVAN401X_drvContATbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvContATbl];
GO
IF OBJECT_ID('U_EBCVAN401X_drvContATbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvContATbl];
GO
IF OBJECT_ID('U_EBCVAN401X_drvCompTbl') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_drvCompTbl];
GO
IF OBJECT_ID('U_EBCVAN401X_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_DedList];
GO
IF OBJECT_ID('U_EBCVAN401X_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_AuditFields];
GO
IF OBJECT_ID('U_EBCVAN401X_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBCVAN401X';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBCVAN401X';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBCVAN401X';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBCVAN401X';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBCVAN401X';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EBCVAN401X','Vanguard 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1100','S','N','EBCVAN401XZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderZeroes"','1','(''UA''=''F'')','EBCVAN401XZ0','11','H','01','1',NULL,'Header Zeroes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderIndicator"','2','(''UA''=''F'')','EBCVAN401XZ0','3','H','01','12',NULL,'Header Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderFormat"','3','(''UA''=''F'')','EBCVAN401XZ0','8','H','01','15',NULL,'Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderPlanNumber"','4','(''UA''=''F'')','EBCVAN401XZ0','6','H','01','23',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderDate"','5','(''UD112''=''F'')','EBCVAN401XZ0','8','H','01','29',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderTime"','6','(''UDHMS''=''F'')','EBCVAN401XZ0','6','H','01','37',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderPlanSequence"','7','(''UA''=''F'')','EBCVAN401XZ0','8','H','01','43',NULL,'Plan # and sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderFiller"','8','(''UA''=''F'')','EBCVAN401XZ0','30','H','01','51',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPlanId"','1','(''UA''=''F'')','EBCVAN401XZ0','6','D','10','1',NULL,'Plan Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','2','(''UA''=''F'')','EBCVAN401XZ0','9','D','10','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRecordType"','3','(''UA''=''F'')','EBCVAN401XZ0','3','D','10','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller1"','4','(''UA''=''F'')','EBCVAN401XZ0','22','D','10','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartName"','5','(''UA''=''F'')','EBCVAN401XZ0','30','D','10','41',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartStatus"','6','(''UA''=''F'')','EBCVAN401XZ0','2','D','10','71',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine1"','7','(''UA''=''F'')','EBCVAN401XZ0','30','D','10','73',NULL,'Address Line One',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine2"','8','(''UA''=''F'')','EBCVAN401XZ0','30','D','10','103',NULL,'Address Line Two',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCity"','9','(''UA''=''F'')','EBCVAN401XZ0','18','D','10','133',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartState"','10','(''UA''=''F'')','EBCVAN401XZ0','3','D','10','151',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartZipCode"','11','(''UA''=''F'')','EBCVAN401XZ0','9','D','10','154',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartForeignFlag"','12','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','163',NULL,'Foreign Address Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpNumber"','13','(''UA''=''F'')','EBCVAN401XZ0','13','D','10','164',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLocationCode4"','14','(''UA''=''F'')','EBCVAN401XZ0','4','D','10','177',NULL,'Location Code(4)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLocationCode10"','15','(''UA''=''F'')','EBCVAN401XZ0','10','D','10','181',NULL,'Location Code(10)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartBirthDate"','16','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','191',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmploymentDate"','17','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','199',NULL,'Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPlanEligDate"','18','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','207',NULL,'Plan Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEntryDate"','19','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','215',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartVestingDate"','20','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','223',NULL,'Alternate Vesting Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller2"','21','(''UA''=''F'')','EBCVAN401XZ0','8','D','10','231',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTerminationDate"','22','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','239',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTerminationReason"','23','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','247',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSendKitInd"','24','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','248',NULL,'Send Kit Indicator (652)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRehireDate"','25','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','249',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartVestingOverPercent"','26','(''UA''=''F'')','EBCVAN401XZ0','4','D','10','257',NULL,'Vesting Override Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartVestingOverPercentInd"','27','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','261',NULL,'Vesting Override Percent Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreForLoanAmort"','28','(''UA''=''F'')','EBCVAN401XZ0','2','D','10','262',NULL,'Payroll Freq. For Loan Amortization',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller3"','29','(''UA''=''F'')','EBCVAN401XZ0','34','D','10','264',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrolCodeOne"','30','(''UA''=''F'')','EBCVAN401XZ0','10','D','10','298',NULL,'Payroll Code One',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrolCodeTwo"','31','(''UA''=''F'')','EBCVAN401XZ0','10','D','10','308',NULL,'Payroll Code Two',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHighlyCompensatedFlag"','32','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','318',NULL,'Highly Compensated Flag (HCE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEffectiveDate"','33','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','319',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller4"','34','(''UA''=''F'')','EBCVAN401XZ0','24','D','10','327',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller5"','35','(''UA''=''F'')','EBCVAN401XZ0','8','D','10','351',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartChangeType"','36','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','359',NULL,'Change Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller6"','37','(''UA''=''F'')','EBCVAN401XZ0','180','D','10','360',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMaritalStatus"','38','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','540',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartGender"','39','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','541',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller7"','40','(''UA''=''F'')','EBCVAN401XZ0','27','D','10','542',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLOAType"','41','(''UA''=''F'')','EBCVAN401XZ0','1','D','10','569',NULL,'LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLOABeginDate"','42','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','570',NULL,'LOA Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLOAEndDate"','43','(''UD112''=''F'')','EBCVAN401XZ0','8','D','10','578',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFiller8"','44','(''UA''=''F'')','EBCVAN401XZ0','314','D','10','586',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContPlanId"','1','(''UA''=''F'')','EBCVAN401XZ0','6','D','20','1',NULL,'Plan Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContSSN"','2','(''UA''=''F'')','EBCVAN401XZ0','9','D','20','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContRecordType"','3','(''UA''=''F'')','EBCVAN401XZ0','3','D','20','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContFiller1"','4','(''UA''=''F'')','EBCVAN401XZ0','22','D','20','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContPayrollEndDate"','5','(''UD112''=''F'')','EBCVAN401XZ0','8','D','20','41',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContPRSOverPayrollEndDate"','6','(''UD112''=''F'')','EBCVAN401XZ0','8','D','20','49',NULL,'PRS Override Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContFund1"','7','(''UA''=''F'')','EBCVAN401XZ0','10','D','20','57',NULL,'Contribution Fund 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContSource1"','8','(''UA''=''F'')','EBCVAN401XZ0','4','D','20','67',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContAmt1"','9','(''UA''=''F'')','EBCVAN401XZ0','10','D','20','71',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContFiller2"','10','(''UA''=''F'')','EBCVAN401XZ0','10','D','20','81',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContSource2"','11','(''UA''=''F'')','EBCVAN401XZ0','4','D','20','91',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContAmt2"','12','(''UA''=''F'')','EBCVAN401XZ0','10','D','20','95',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContFiller3"','13','(''UA''=''F'')','EBCVAN401XZ0','695','D','20','105',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCPlanId"','1','(''UA''=''F'')','EBCVAN401XZ0','6','D','30','1',NULL,'Plan Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCSSN"','2','(''UA''=''F'')','EBCVAN401XZ0','9','D','30','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCRecordType"','3','(''UA''=''F'')','EBCVAN401XZ0','3','D','30','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCFiller1"','4','(''UA''=''F'')','EBCVAN401XZ0','22','D','30','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCSource1"','5','(''UA''=''F'')','EBCVAN401XZ0','4','D','30','41',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCTotalAmt1"','6','(''UA''=''F'')','EBCVAN401XZ0','10','D','30','45',NULL,'Contribution Total Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCSource2"','7','(''UA''=''F'')','EBCVAN401XZ0','4','D','30','55',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCTotalAmt2"','8','(''UA''=''F'')','EBCVAN401XZ0','10','D','30','59',NULL,'Contribution Total Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCFiller2"','9','(''UA''=''F'')','EBCVAN401XZ0','459','D','30','69',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCPretaxLimitOver"','10','(''UA''=''F'')','EBCVAN401XZ0','1','D','30','528',NULL,'Pretax Limit Override',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContCFiller3"','11','(''UA''=''F'')','EBCVAN401XZ0','109','D','30','529',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPlanId"','1','(''UA''=''F'')','EBCVAN401XZ0','6','D','40','1',NULL,'Plan Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanSSN"','2','(''UA''=''F'')','EBCVAN401XZ0','9','D','40','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRecordType"','3','(''UA''=''F'')','EBCVAN401XZ0','3','D','40','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanFiller1"','4','(''UA''=''F'')','EBCVAN401XZ0','22','D','40','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber1"','5','(''UA''=''F'')','EBCVAN401XZ0','3','D','40','41',NULL,'Loan Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayrollEndDate1"','6','(''UD112''=''F'')','EBCVAN401XZ0','8','D','40','44',NULL,'Payroll End Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentAmt1"','7','(''UA''=''F'')','EBCVAN401XZ0','10','D','40','52',NULL,'Payment Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber2"','8','(''UA''=''F'')','EBCVAN401XZ0','3','D','40','62',NULL,'Loan Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayrollEndDate2"','9','(''UD112''=''F'')','EBCVAN401XZ0','8','D','40','65',NULL,'Loan Number 2 Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentAmt2"','10','(''UA''=''F'')','EBCVAN401XZ0','10','D','40','73',NULL,'Loan Number 2 payment amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanFiller2"','11','(''UA''=''F'')','EBCVAN401XZ0','209','D','40','83',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanFiller3"','12','(''UA''=''F'')','EBCVAN401XZ0','268','D','40','292',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompPlanId"','1','(''UA''=''F'')','EBCVAN401XZ0','6','D','50','1',NULL,'Plan Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompSSN"','2','(''UA''=''F'')','EBCVAN401XZ0','9','D','50','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompRecordType"','3','(''UA''=''F'')','EBCVAN401XZ0','3','D','50','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompFiller1"','4','(''UA''=''F'')','EBCVAN401XZ0','22','D','50','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompSourceCode1"','5','(''UA''=''F'')','EBCVAN401XZ0','4','D','50','41',NULL,'Source Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompProcessCode"','6','(''UA''=''F'')','EBCVAN401XZ0','4','D','50','45',NULL,'Process Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompFrequency"','7','(''UA''=''F'')','EBCVAN401XZ0','2','D','50','49',NULL,'Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompCompensationCode"','8','(''UA''=''F'')','EBCVAN401XZ0','2','D','50','51',NULL,'Compensation Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompPayrollStartDate"','9','(''UD112''=''F'')','EBCVAN401XZ0','8','D','50','53',NULL,'Payroll Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompPayrollEndDate"','10','(''UD112''=''F'')','EBCVAN401XZ0','8','D','50','61',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompCompensationAmt"','11','(''UA''=''F'')','EBCVAN401XZ0','14','D','50','69',NULL,'Compensation Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompBlank"','12','(''UA''=''F'')','EBCVAN401XZ0','17','D','50','83',NULL,'Blank',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompFiller2"','13','(''UA''=''F'')','EBCVAN401XZ0','101','D','50','100',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPlanId"','1','(''UA''=''F'')','EBCVAN401XZ0','6','D','60','1',NULL,'Plan Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMSSN"','2','(''UA''=''F'')','EBCVAN401XZ0','9','D','60','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMRecordType"','3','(''UA''=''F'')','EBCVAN401XZ0','3','D','60','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMFiller1"','4','(''UA''=''F'')','EBCVAN401XZ0','22','D','60','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMEmailAddress"','5','(''UA''=''F'')','EBCVAN401XZ0','140','D','60','41',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMTrailerNine"','1','(''UA''=''F'')','EBCVAN401XZ0','11','T','90','1',NULL,'Trailer Nines',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMTrailerInd"','2','(''UA''=''F'')','EBCVAN401XZ0','4','T','90','12',NULL,'Trailer Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPlanNumber"','3','(''UA''=''F'')','EBCVAN401XZ0','6','T','90','16',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMDate"','4','(''UD112''=''F'')','EBCVAN401XZ0','8','T','90','22',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMTime"','5','(''UDHMS''=''F'')','EBCVAN401XZ0','6','T','90','30',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMRecordCount"','6','(''UA''=''F'')','EBCVAN401XZ0','10','T','90','36',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMFiller2"','7','(''UA''=''F'')','EBCVAN401XZ0','35','T','90','46',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EBCVAN401X_20200309.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Vanguard 401k Export','202001249','EMPEXPORT','ONDEMAND',NULL,'EBCVAN401X',NULL,NULL,NULL,'202001249','Jan 24 2020 11:28AM','Jan 24 2020 11:28AM','202001241',NULL,'','','202001241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EBCVAN401X_20200309.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001249','EMPEXPORT','BCX_SCHED',NULL,'EBCVAN401X',NULL,NULL,NULL,'202001249','Jan 24 2020 11:28AM','Jan 24 2020 11:28AM','202001241',NULL,'','','202001241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EBCVAN401X_20200309.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001319','EMPEXPORT','TEST','Feb 26 2020 12:24PM','EBCVAN401X',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001311','919','','','202001311',dbo.fn_GetTimedKey(),NULL,'us3lKiBUC1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EBCVAN401X_20200309.txt' END WHERE expFormatCode = 'EBCVAN401X';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCVAN401X','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCVAN401X','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCVAN401X','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCVAN401X','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCVAN401X','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCVAN401X','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EBCVAN401X' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBCVAN401X' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EBCVAN401X_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBCVAN401X_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','H01','dbo.U_EBCVAN401X_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','D10','dbo.U_EBCVAN401X_drvPartTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','D20','dbo.U_EBCVAN401X_drvContATbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','D30','dbo.U_EBCVAN401X_drvContBTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','D40','dbo.U_EBCVAN401X_drvLoanTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','D50','dbo.U_EBCVAN401X_drvCompTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','D60','dbo.U_EBCVAN401X_drvEmailTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCVAN401X','T90','dbo.U_EBCVAN401X_drvTrailer',NULL);
IF OBJECT_ID('U_EBCVAN401X_Audit') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_Audit] (
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
IF OBJECT_ID('U_EBCVAN401X_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EBCVAN401X_DedList') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvCompTbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvCompTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCompPlanId] varchar(6) NOT NULL,
    [drvCompSSN] char(11) NULL,
    [drvCompRecordType] varchar(1) NOT NULL,
    [drvCompFiller1] varchar(1) NOT NULL,
    [drvCompSourceCode1] varchar(2) NOT NULL,
    [drvCompProcessCode] varchar(4) NOT NULL,
    [drvCompFrequency] varchar(2) NOT NULL,
    [drvCompCompensationCode] varchar(2) NOT NULL,
    [drvCompPayrollStartDate] datetime NULL,
    [drvCompPayrollEndDate] datetime NULL,
    [drvCompCompensationAmt] varchar(31) NULL,
    [drvCompBlank] varchar(1) NOT NULL,
    [drvCompFiller2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvContATbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvContATbl] (
    [drvEEID] char(12) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvContPlanId] varchar(6) NOT NULL,
    [drvContPlanId] varchar(6) NOT NULL,
    [drvContSSN] char(11) NULL,
    [drvContSSN] char(11) NULL,
    [drvContRecordType] varchar(1) NOT NULL,
    [drvContRecordType] varchar(1) NOT NULL,
    [drvContFiller1] varchar(1) NOT NULL,
    [drvContFiller1] varchar(1) NOT NULL,
    [drvContPayrollEndDate] datetime NULL,
    [drvContPayrollEndDate] datetime NULL,
    [drvContPRSOverPayrollEndDate] datetime NULL,
    [drvContPRSOverPayrollEndDate] datetime NULL,
    [drvContFund1] varchar(1) NOT NULL,
    [drvContFund1] varchar(1) NOT NULL,
    [drvContSource1] varchar(3) NULL,
    [drvContSource1] varchar(3) NULL,
    [drvContAmt1] varchar(31) NULL,
    [drvContAmt1] varchar(31) NULL,
    [drvContAmt1Raw] numeric NULL,
    [drvContAmt1Raw] numeric NULL,
    [drvContFiller2] varchar(1) NOT NULL,
    [drvContFiller2] varchar(1) NOT NULL,
    [drvContSource2] varchar(3) NULL,
    [drvContSource2] varchar(3) NULL,
    [drvContAmt2] varchar(31) NULL,
    [drvContAmt2] varchar(31) NULL,
    [drvContAmt2Raw] numeric NULL,
    [drvContAmt2Raw] numeric NULL,
    [drvContFiller3] varchar(1) NOT NULL,
    [drvContFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvContATbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvContATbl] (
    [drvEEID] char(12) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvContPlanId] varchar(6) NOT NULL,
    [drvContPlanId] varchar(6) NOT NULL,
    [drvContSSN] char(11) NULL,
    [drvContSSN] char(11) NULL,
    [drvContRecordType] varchar(1) NOT NULL,
    [drvContRecordType] varchar(1) NOT NULL,
    [drvContFiller1] varchar(1) NOT NULL,
    [drvContFiller1] varchar(1) NOT NULL,
    [drvContPayrollEndDate] datetime NULL,
    [drvContPayrollEndDate] datetime NULL,
    [drvContPRSOverPayrollEndDate] datetime NULL,
    [drvContPRSOverPayrollEndDate] datetime NULL,
    [drvContFund1] varchar(1) NOT NULL,
    [drvContFund1] varchar(1) NOT NULL,
    [drvContSource1] varchar(3) NULL,
    [drvContSource1] varchar(3) NULL,
    [drvContAmt1] varchar(31) NULL,
    [drvContAmt1] varchar(31) NULL,
    [drvContAmt1Raw] numeric NULL,
    [drvContAmt1Raw] numeric NULL,
    [drvContFiller2] varchar(1) NOT NULL,
    [drvContFiller2] varchar(1) NOT NULL,
    [drvContSource2] varchar(3) NULL,
    [drvContSource2] varchar(3) NULL,
    [drvContAmt2] varchar(31) NULL,
    [drvContAmt2] varchar(31) NULL,
    [drvContAmt2Raw] numeric NULL,
    [drvContAmt2Raw] numeric NULL,
    [drvContFiller3] varchar(1) NOT NULL,
    [drvContFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvContBTbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvContBTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvContCPlanId] varchar(6) NOT NULL,
    [drvContCSSN] varchar(1) NOT NULL,
    [drvContCRecordType] varchar(1) NOT NULL,
    [drvContCFiller1] varchar(1) NOT NULL,
    [drvContCSource1] varchar(3) NOT NULL,
    [drvContCTotalAmt1] varchar(31) NULL,
    [drvContCSource2] varchar(3) NOT NULL,
    [drvContCTotalAmt2] varchar(31) NULL,
    [drvContCFiller2] varchar(1) NOT NULL,
    [drvContCPretaxLimitOver] varchar(1) NOT NULL,
    [drvContCFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvEmailTbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvEmailTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEMPlanId] varchar(6) NOT NULL,
    [drvEMSSN] char(11) NULL,
    [drvEMRecordType] varchar(1) NOT NULL,
    [drvEMFiller1] varchar(1) NOT NULL,
    [drvEMEmailAddress] varchar(50) NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvLoanTbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvLoanTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvLoanPlanId] varchar(6) NOT NULL,
    [drvLoanSSN] char(11) NULL,
    [drvLoanRecordType] varchar(1) NOT NULL,
    [drvLoanFiller1] varchar(1) NOT NULL,
    [drvLoanNumber1] varchar(1) NOT NULL,
    [drvLoanPayrollEndDate1] datetime NULL,
    [drvLoanPaymentAmt1] varchar(31) NULL,
    [drvLoanPaymentAmt1Raw] numeric NULL,
    [drvLoanNumber2] varchar(1) NOT NULL,
    [drvLoanPayrollEndDate2] datetime NULL,
    [drvLoanPaymentAmt2] varchar(31) NULL,
    [drvLoanPaymentAmt2Raw] numeric NULL,
    [drvLoanFiller2] varchar(1) NOT NULL,
    [drvLoanFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvPartTbl') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvPartTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPartPlanId] varchar(6) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartRecordType] varchar(1) NULL,
    [drvPartFiller1] varchar(1) NOT NULL,
    [drvPartName] varchar(234) NULL,
    [drvPartStatus] varchar(1) NOT NULL,
    [drvPartAddressLine1] varchar(255) NULL,
    [drvPartAddressLine2] varchar(255) NULL,
    [drvPartCity] varchar(255) NULL,
    [drvPartState] varchar(255) NULL,
    [drvPartZipCode] varchar(50) NULL,
    [drvPartForeignFlag] varchar(1) NOT NULL,
    [drvPartEmpNumber] char(9) NULL,
    [drvPartLocationCode4] varchar(1) NOT NULL,
    [drvPartLocationCode10] varchar(1) NOT NULL,
    [drvPartBirthDate] datetime NULL,
    [drvPartEmploymentDate] datetime NULL,
    [drvPartPlanEligDate] varchar(1) NOT NULL,
    [drvPartEntryDate] varchar(1) NOT NULL,
    [drvPartVestingDate] datetime NULL,
    [drvPartFiller2] varchar(1) NOT NULL,
    [drvPartTerminationDate] datetime NULL,
    [drvPartTerminationReason] varchar(1) NULL,
    [drvPartSendKitInd] varchar(1) NULL,
    [drvPartRehireDate] datetime NULL,
    [drvPartVestingOverPercent] varchar(1) NOT NULL,
    [drvPartVestingOverPercentInd] varchar(1) NOT NULL,
    [drvPartPayrollFreForLoanAmort] varchar(1) NOT NULL,
    [drvPartFiller3] varchar(1) NOT NULL,
    [drvPartPayrolCodeOne] varchar(10) NOT NULL,
    [drvPartPayrolCodeTwo] varchar(1) NOT NULL,
    [drvPartHighlyCompensatedFlag] varchar(1) NOT NULL,
    [drvPartEffectiveDate] datetime NULL,
    [drvPartFiller4] varchar(1) NOT NULL,
    [drvPartFiller5] varchar(1) NOT NULL,
    [drvPartChangeType] varchar(1) NOT NULL,
    [drvPartFiller6] varchar(1) NOT NULL,
    [drvPartMaritalStatus] varchar(1) NOT NULL,
    [drvPartGender] char(1) NULL,
    [drvPartFiller7] varchar(1) NOT NULL,
    [drvPartLOAType] varchar(1) NULL,
    [drvPartLOABeginDate] datetime NULL,
    [drvPartLOAEndDate] datetime NULL,
    [drvPartFiller8] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_drvTrailer] (
    [drvEMTrailerNine] varchar(11) NOT NULL,
    [drvEMTrailerInd] varchar(4) NOT NULL,
    [drvEMPlanNumber] varchar(6) NOT NULL,
    [drvEMDate] datetime NOT NULL,
    [drvEMTime] datetime NOT NULL,
    [drvEMRecordCount] varchar(30) NULL,
    [drvEMFiller2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_EEList') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBCVAN401X_File') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1100) NULL
);
IF OBJECT_ID('U_EBCVAN401X_Header') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_Header] (
    [drvHeaderZeroes] varchar(11) NOT NULL,
    [drvHeaderIndicator] varchar(3) NOT NULL,
    [drvHeaderFormat] varchar(8) NOT NULL,
    [drvHeaderPlanNumber] varchar(6) NOT NULL,
    [drvHeaderDate] datetime NOT NULL,
    [drvHeaderTime] datetime NOT NULL,
    [drvHeaderPlanSequence] varchar(1) NOT NULL,
    [drvHeaderFiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBCVAN401X_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_PDedHist] (
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
IF OBJECT_ID('U_EBCVAN401X_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBCVAN401X_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBCVAN401X]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Buckley LLP

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/24/2020
Service Request Number: TekP-2019-10-21-0003

Purpose: Vanguard 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBCVAN401X';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBCVAN401X';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBCVAN401X';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBCVAN401X';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBCVAN401X' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCVAN401X', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCVAN401X', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBCVAN401X', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================U_EBCVAN401X_drvContATbl
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EBCVAN401X';

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
    DELETE FROM dbo.U_EBCVAN401X_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBCVAN401X_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

       DELETE FROM dbo.U_EBCVAN401X_EEList
    WHERE xEEID IN (select eeceeid from empcomp where eecdedgroupCode = 'PB' or EecEEType IN ('TMP', 'PB', 'SUM' , 'INT'));

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '4K,4KE,4KEP,4KP,ROTH,ROTHE,ROTHP,RTHEP,4KL1,4KL2';

    IF OBJECT_ID('U_EBCVAN401X_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBCVAN401X_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EBCVAN401X_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('4K', '4KE', '4KEP' ,'4KP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH', 'ROTHE', 'ROTHP', 'RTHEP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('4KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('4KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EBCVAN401X_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBCVAN401X_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EBCVAN401X_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_PEarHist;
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
    INTO dbo.U_EBCVAN401X_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --Audit Table
    IF OBJECT_ID('U_EBCVAN401X_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_AuditFields;
    CREATE TABLE dbo.U_EBCVAN401X_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EBCVAN401X_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EBCVAN401X_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_Audit;
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
    INTO dbo.U_EBCVAN401X_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EBCVAN401X_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EBCVAN401X_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBCVAN401X_Audit ON dbo.U_EBCVAN401X_Audit (audKey1Value, audKey2Value);



    
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBCVAN401X_drvPartTbl
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvPartTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvPartTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartPlanId = '094612'
        ,drvPartSSN = eepSSN
        ,drvPartRecordType = CASE WHEN EecDedGroupCode <> 'PB' and EecEEType <> 'TMP' THEN 'A' END
        ,drvPartFiller1 =  ''
        ,drvPartName = eepNameLast + (CASE WHEN Isnull(eepNameSuffix,'') <> '' THEN eepNameSuffix + ' ,' else ', ' END)  + eepnamefirst + ' ' + LEFT(Isnull(eepnamemiddle,''),1)
        ,drvPartStatus = ''
        ,drvPartAddressLine1 = EepAddressLine1
        ,drvPartAddressLine2 = EepAddressLine2
        ,drvPartCity = EepAddressCity
        ,drvPartState = EepAddressState
        ,drvPartZipCode = EepAddressZipCode
        ,drvPartForeignFlag = ''
        ,drvPartEmpNumber = eecempno
        ,drvPartLocationCode4 = ''
        ,drvPartLocationCode10 = ''
        ,drvPartBirthDate = EepDateOfBirth
        ,drvPartEmploymentDate = Eecdateoforiginalhire
        ,drvPartPlanEligDate = ''
        ,drvPartEntryDate = ''
        ,drvPartVestingDate = Eecdateoforiginalhire
        ,drvPartFiller2 = ''
        ,drvPartTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPartTerminationReason = CASE WHEN EecEmplStatus = 'T' THEN 
                                            CASE WHEN eecTermReason IN ('203') THEN '6'
                                                 WHEN eecTermReason IN ('202') THEN '4'
                                                 WHEN eecTermReason IN ('208') THEN '5' 
                                                 ELSE '0'
                                            END
                                    END
        ,drvPartSendKitInd = CASE WHEN EecEmplStatus = 'T' THEN 
                                            CASE WHEN eecTermReason IN ('203') THEN '1'
                                                 WHEN eecTermReason NOT IN ('203') THEN '2'
                                            END
                                    END
        ,drvPartRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire  END
        ,drvPartVestingOverPercent = ''
        ,drvPartVestingOverPercentInd = ''
        ,drvPartPayrollFreForLoanAmort = CASE WHEN EecPayPeriod = 'M' THEN '4' ELSE '5' END
        ,drvPartFiller3 = ''
        ,drvPartPayrolCodeOne = CASE WHEN EecDedGroupCode  = 'PART' THEN 'Partner' ELSE 'NonPartner' END
        ,drvPartPayrolCodeTwo = ''
        ,drvPartHighlyCompensatedFlag = ''
        ,drvPartEffectiveDate = eecdateoflasthire
        ,drvPartFiller4 = ''
        ,drvPartFiller5 = ''
        ,drvPartChangeType = '1'
        ,drvPartFiller6 = ''
        ,drvPartMaritalStatus = ''
        ,drvPartGender = EepGender
        ,drvPartFiller7 = ''
        ,drvPartLOAType = CASE WHEN EecEmplStatus = 'L' THEN
                                CASE WHEN (Select Top 1 EshEmplStatusReason  from EmpHStat  where eshCOID = xCOID and eshEEID = XEEID order by EshDateTimeCreated desc) = '300' THEN 'M'
                                     WHEN (Select Top 1 EshEmplStatusReason  from EmpHStat  where eshCOID = xCOID and eshEEID = XEEID order by EshDateTimeCreated desc) <> '300' THEN 'O' 
                                END
                          END
        ,drvPartLOABeginDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate  END
        ,drvPartLOAEndDate = CASE WHEN EecEmplStatus = 'L' THEN (Select Top 1 EshStatusStopDate  from EmpHStat  where eshCOID = xCOID and eshEEID = XEEID order by EshDateTimeCreated desc)   END
        ,drvPartFiller8 = ''
    INTO dbo.U_EBCVAN401X_drvPartTbl
    FROM dbo.U_EBCVAN401X_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
           /*and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EBCVAN401X_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))*/
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EBCVAN401X_PEarHist WITH (NOLOCK)
        on Peheeid = xeeid
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBCVAN401X_drvContATbl
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvContATbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvContATbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvContPlanId = '094612'
        ,drvContSSN = eepSSN
        ,drvContRecordType = 'B'
        ,drvContFiller1 = ''
        ,drvContPayrollEndDate = @EndDate
        ,drvContPRSOverPayrollEndDate = @EndDate
        ,drvContFund1 = ''
        ,drvContSource1 = CASE WHEN PdhSource1 is not null THEN 'AAA' END 
        ,drvContAmt1 =  CASE WHEN PdhSource1 is not null THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhSource1*100,9,0))  + '+'  END 
        ,drvContAmt1Raw =  CASE WHEN PdhSource1 is not null THEN PdhSource1  END 
        ,drvContFiller2 = ''
        ,drvContSource2 =  CASE WHEN PdhSource2 is not null THEN 'NRB' END 
        ,drvContAmt2 =  CASE WHEN PdhSource2 is not null THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhSource2*100,9,0)) + '+' END 
        ,drvContAmt2Raw =  CASE WHEN PdhSource2 is not null THEN PdhSource2 END 
        ,drvContFiller3 = ''
    INTO U_EBCVAN401X_drvContATbl
    FROM dbo.U_EBCVAN401X_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
       /* AND EecCoID = xCoID
           and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EBCVAN401X_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T'))) */
     JOIN dbo.U_EBCVAN401X_PDedHist WITH (NOLOCK)
        on Pdheeid = XEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBCVAN401X_drvContBTbl
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvContBTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvContBTbl;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvContCPlanId = '094612'
        ,drvContCSSN = ''
        ,drvContCRecordType = 'C'
        ,drvContCFiller1 = ''
        ,drvContCSource1 = 'AAA'
        ,drvContCTotalAmt1 =  (Select CONVERT(VARCHAR,dbo.dsi_fnPadZero(sum(drvContAmt1Raw)*100,9,0))  from U_EBCVAN401X_drvContATbl) + '+'
        ,drvContCSource2 = 'NRB'
        ,drvContCTotalAmt2 = (Select CONVERT(VARCHAR,dbo.dsi_fnPadZero(sum(drvContAmt2Raw)*100,9,0))  from U_EBCVAN401X_drvContATbl) + '+'
        ,drvContCFiller2 = ''
        ,drvContCPretaxLimitOver = '1'
        ,drvContCFiller3 = ''
    INTO dbo.U_EBCVAN401X_drvContBTbl

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBCVAN401X_drvLoanTbl
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvLoanTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvLoanTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvLoanPlanId = '094612'
        ,drvLoanSSN = eepSSN
        ,drvLoanRecordType = 'D'
        ,drvLoanFiller1 = ''
        ,drvLoanNumber1 = ''
        ,drvLoanPayrollEndDate1 = @EndDate
        ,drvLoanPaymentAmt1 = CASE WHEN PdhSource6 is not null THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhSource6*100,9,0))  + '+' END 
        ,drvLoanPaymentAmt1Raw =PdhSource6
        ,drvLoanNumber2 = ''
        ,drvLoanPayrollEndDate2 = @EndDate
        ,drvLoanPaymentAmt2 = CASE WHEN PdhSource7 is not null THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhSource7*100,9,0))  + '+' END 
        ,drvLoanPaymentAmt2Raw =PdhSource7
        ,drvLoanFiller2 = ''
        ,drvLoanFiller3 = ''
    INTO dbo.U_EBCVAN401X_drvLoanTbl
    FROM dbo.U_EBCVAN401X_EEList WITH (NOLOCK)
   JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_EBCVAN401X_PDedHist WITH (NOLOCK)
        on Pdheeid = XEEID and ( Isnull(PdhSource6,0) > 0 or isnull(PdhSource7,0) > 0)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBCVAN401X_drvCompTbl
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvCompTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvCompTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCompPlanId = '094612'
        ,drvCompSSN = eepSSN
        ,drvCompRecordType = 'K'
        ,drvCompFiller1 = ''
        ,drvCompSourceCode1 = 'AA'
        ,drvCompProcessCode = 'VMAP'
        ,drvCompFrequency = '01'
        ,drvCompCompensationCode = 'LP'
        ,drvCompPayrollStartDate =  CAST( ('01/01/' + CAST( Year(GetDate()) as varchar(4))) as datetime)
        ,drvCompPayrollEndDate =  CAST( ('12/31/' + CAST( Year(GetDate()) as varchar(4))) as datetime)
        ,drvCompCompensationAmt =  CONVERT(VARCHAR,dbo.dsi_fnPadZero(eecAnnSalary*100,12,0))  + '+'
        ,drvCompBlank = ''
        ,drvCompFiller2 = ''
    INTO dbo.U_EBCVAN401X_drvCompTbl
    FROM dbo.U_EBCVAN401X_EEList WITH (NOLOCK)
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        JOIN dbo.U_EBCVAN401X_PEarHist WITH (NOLOCK)
        on Peheeid = xeeid
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBCVAN401X_drvEmailTbl
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvEmailTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvEmailTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEMPlanId = '094612'
        ,drvEMSSN = eepSSN
        ,drvEMRecordType = 'X'
        ,drvEMFiller1 = ''
        ,drvEMEmailAddress = EepAddressEMail
    INTO dbo.U_EBCVAN401X_drvEmailTbl
    FROM dbo.U_EBCVAN401X_EEList WITH (NOLOCK)
 JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            JOIN dbo.U_EBCVAN401X_PEarHist WITH (NOLOCK)
        on Peheeid = xeeid
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_Header;
    SELECT DISTINCT
         drvHeaderZeroes = '00000000000'
        ,drvHeaderIndicator = 'HDR'
        ,drvHeaderFormat = 'SFF     '
        ,drvHeaderPlanNumber = '094612'
        ,drvHeaderDate = GETDATE()
        ,drvHeaderTime = GETDATE()
        ,drvHeaderPlanSequence = ''
        ,drvHeaderFiller = ''
    INTO dbo.U_EBCVAN401X_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBCVAN401X_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EBCVAN401X_drvTrailer;
    SELECT DISTINCT
         drvEMTrailerNine = '99999999999'
        ,drvEMTrailerInd = 'TRLR'
        ,drvEMPlanNumber = '094612'
        ,drvEMDate = GETDATE()
        ,drvEMTime = GETDATE()
        ,drvEMRecordCount =  CONVERT(VARCHAR,dbo.dsi_fnPadZero((Select (
                            (Select count(*) from U_EBCVAN401X_drvEmailTbl) +
                            (Select count(*) from U_EBCVAN401X_drvCompTbl) +
                            (Select count(*) from U_EBCVAN401X_drvLoanTbl) +
                            (Select count(*) from U_EBCVAN401X_drvContBTbl) +
                            (Select count(*) from U_EBCVAN401X_drvContATbl) + 
                            (Select count(*) from U_EBCVAN401X_drvPartTbl) )),9,0))
                ,drvEMFiller2 = ''
    INTO dbo.U_EBCVAN401X_drvTrailer
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
ALTER VIEW dbo.dsi_vwEBCVAN401X_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBCVAN401X_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBCVAN401X%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001171'
       ,expStartPerControl     = '202001171'
       ,expLastEndPerControl   = '202001249'
       ,expEndPerControl       = '202001249'
WHERE expFormatCode = 'EBCVAN401X';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBCVAN401X_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBCVAN401X_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort