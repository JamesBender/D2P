SET NOCOUNT ON;
IF OBJECT_ID('U_EUMRFSAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUMRFSAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUMRFSAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUMRFSAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUMRFSAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUMRFSAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUMRFSAEXP];
GO
IF OBJECT_ID('U_EUMRFSAEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_Trailer];
GO
IF OBJECT_ID('U_EUMRFSAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_PEarHist];
GO
IF OBJECT_ID('U_EUMRFSAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_PDedHist];
GO
IF OBJECT_ID('U_EUMRFSAEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_Header];
GO
IF OBJECT_ID('U_EUMRFSAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_File];
GO
IF OBJECT_ID('U_EUMRFSAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_EEList];
GO
IF OBJECT_ID('U_EUMRFSAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_drvTbl];
GO
IF OBJECT_ID('U_EUMRFSAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUMRFSAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUMRFSAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUMRFSAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUMRFSAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUMRFSAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUMRFSAEXP','UMR FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EUMRFSAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHdRecordType"','1','(''UA''=''F'')','EUMRFSAEXPZ0','1','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDClientNumber"','2','(''UA''=''F'')','EUMRFSAEXPZ0','4','H','01','2',NULL,'Client Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDClientName"','3','(''UA''=''F'')','EUMRFSAEXPZ0','30','H','01','3',NULL,'Client Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDFiller1"','4','(''UA''=''F'')','EUMRFSAEXPZ0','30','H','01','4',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDProdType"','5','(''UA''=''F'')','EUMRFSAEXPZ0','10','H','01','5',NULL,'Product Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDProcessType"','6','(''UA''=''F'')','EUMRFSAEXPZ0','20','H','01','6',NULL,'Process Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDFileCreationDate"','7','(''UD112''=''F'')','EUMRFSAEXPZ0','8','H','01','7',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDFiller2"','8','(''UA''=''F'')','EUMRFSAEXPZ0','397','H','01','8',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''F'')','EUMRFSAEXPZ0','9','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','2','(''UA''=''F'')','EUMRFSAEXPZ0','20','D','10','2',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','3','(''UA''=''F'')','EUMRFSAEXPZ0','14','D','10','3',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','4','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','4',NULL,'Payroll Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHCContrib"','5','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','5',NULL,'Employer Health Care Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEHCContrib"','6','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','6',NULL,'Employee Health Care Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERDepCareContrib"','7','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','7',NULL,'Employer Dependent Care Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDepCareContrib"','8','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','8',NULL,'Employee Dependent Care Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPFSAIndicator"','9','(''UA''=''F'')','EUMRFSAEXPZ0','3','D','10','9',NULL,'Limited Purpose FSA Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrouLocationCode"','10','(''UA''=''F'')','EUMRFSAEXPZ0','4','D','10','10',NULL,'Group Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreq"','11','(''UA''=''F'')','EUMRFSAEXPZ0','1','D','10','11',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller1"','12','(''UA''=''F'')','EUMRFSAEXPZ0','2','D','10','12',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller2"','13','(''UA''=''F'')','EUMRFSAEXPZ0','6','D','10','13',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''F'')','EUMRFSAEXPZ0','30','D','10','14',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','15','(''UA''=''F'')','EUMRFSAEXPZ0','25','D','10','15',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','16','(''UA''=''F'')','EUMRFSAEXPZ0','20','D','10','16',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','17','(''UA''=''F'')','EUMRFSAEXPZ0','2','D','10','17',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','18','(''UA''=''F'')','EUMRFSAEXPZ0','9','D','10','18',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEEffectiveDateHC"','19','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','19',NULL,'Employee Coverage Effective Date – Health Care',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETermDateHC"','20','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','20',NULL,'Employee Coverage Termination Date – Health Care',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEYTDElectAmt"','21','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','21',NULL,'Employee Annual Health Care Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReimEffectiveDate"','22','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','22',NULL,'Automatic Reimbursement/Debit Card Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReimDebitCardInd"','23','(''UA''=''F'')','EUMRFSAEXPZ0','1','D','10','23',NULL,'Automatic Reimbursement/Debit Card Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEEffectiveDateDepCare"','24','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','24',NULL,'Employee Coverage Effective Date – Dep Care',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETermDateDepCare"','25','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','25',NULL,'Employee Coverage Termination Date – Dep Care',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEYTDCareElecAmt"','26','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','26',NULL,'Employee Annual Dependent Care Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBankRoutingNumber"','27','(''UA''=''F'')','EUMRFSAEXPZ0','15','D','10','27',NULL,'Bank Routing Transit Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller3"','28','(''UA''=''F'')','EUMRFSAEXPZ0','15','D','10','28',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypeBankAccount"','29','(''UA''=''F'')','EUMRFSAEXPZ0','1','D','10','29',NULL,'Type of Bank Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','30','(''UA''=''F'')','EUMRFSAEXPZ0','10','D','10','30',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAcctNumber"','31','(''UA''=''F'')','EUMRFSAEXPZ0','17','D','10','31',NULL,'Employee Bank Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller4"','32','(''UA''=''F'')','EUMRFSAEXPZ0','32','D','10','32',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERHCContribAmt"','33','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','33',NULL,'Employer Annual Health Care Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEYTDRHCContribAmt"','34','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','34',NULL,'Employer Annual Dependent Care Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEParkingContrib"','35','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','35',NULL,'Employee Parking Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEParkingEffectiveDate"','36','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','36',NULL,'Employee Coverage Effective Date – Parking',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEParkingTermDate"','37','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','37',NULL,'Employee Coverage Termination Date – Parking',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETransContrib"','38','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','38',NULL,'Employee Transit Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETransEffDate"','39','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','39',NULL,'Employee Coverage Effective Date – Transit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETransTermDate"','40','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','40',NULL,'Employee Coverage Termination Date – Transit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERParkingContrib"','41','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','41',NULL,'Employer Parking Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERTransitContrib"','42','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','42',NULL,'Employer Transit Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller5"','43','(''UA''=''F'')','EUMRFSAEXPZ0','9','D','10','43',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller6"','44','(''UA''=''F'')','EUMRFSAEXPZ0','3','D','10','44',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','45','(''UA''=''F'')','EUMRFSAEXPZ0','30','D','10','45',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','46','(''UD112''=''F'')','EUMRFSAEXPZ0','8','D','10','46',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','47','(''UA''=''F'')','EUMRFSAEXPZ0','1','D','10','47',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','48','(''UA''=''F'')','EUMRFSAEXPZ0','1','D','10','48',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','49','(''UA''=''F'')','EUMRFSAEXPZ0','10','D','10','49',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','50','(''UA''=''F'')','EUMRFSAEXPZ0','1','D','10','50',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDETFiller7"','51','(''UA''=''F'')','EUMRFSAEXPZ0','9','D','10','51',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEParkingMonthlyElecAmt"','52','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','52',NULL,'Employee Parking Monthly Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETransitMonthlyElecAmt"','53','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','53',NULL,'Employee Transit Monthly Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERParkingMonthlyElecAmt"','54','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','54',NULL,'Employer Parking Monthly Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERTransitMonthlyElecAmt"','55','(''UA''=''F'')','EUMRFSAEXPZ0','7','D','10','55',NULL,'Employer Transit Monthly Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailRecordType"','1','(''UA''=''F'')','EUMRFSAEXPZ0','1','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''F'')','EUMRFSAEXPZ0','7','T','90','2',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotERHCCOntrib"','3','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','3',NULL,'Total Employer Health Contributions for this pay c',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotEEHCCOntrib"','4','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','4',NULL,'Total Employee Health Contributions for this pay c',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotERDepCOntrib"','5','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','5',NULL,'Total Employer Dependent Care Contributions for th',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotEEDepCOntrib"','6','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','6',NULL,'Total Employee Dependent Care Contributions for th',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEYTDHCA"','7','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','7',NULL,'Total Employee Health Care Annual Amounts',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEYTDDep"','8','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','8',NULL,'Total Employee Dependent Care Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERYTDHCA"','9','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','9',NULL,'Total Employer Health Care Annual Amounts',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERYTDDep"','10','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','10',NULL,'Total Employer Dependent Care Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETotParkingContrib"','11','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','11',NULL,'Total Employee Parking Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETotTransitContrib"','12','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','12',NULL,'Total Employee Transit Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERTotParkingContrib"','13','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','13',NULL,'Total Employer Parking Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERTotTransitContrib"','14','(''UA''=''F'')','EUMRFSAEXPZ0','11','T','90','14',NULL,'Total Employer Transit Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerFiller"','15','(''UA''=''F'')','EUMRFSAEXPZ0','360','T','90','15',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUMRFSAEXP_20191118.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UMR FSA Export','201911189','EMPEXPORT','ONDEMAND',NULL,'EUMRFSAEXP',NULL,NULL,NULL,'201911189','Nov 18 2019  3:10PM','Nov 18 2019  3:10PM','201911181',NULL,'','','201911181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUMRFSAEXP_20191118.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911189','EMPEXPORT','SCHEDULED',NULL,'EUMRFSAEXP',NULL,NULL,NULL,'201911189','Nov 18 2019  3:10PM','Nov 18 2019  3:10PM','201911181',NULL,'','','201911181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUMRFSAEXP_20191118.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201911141','EMPEXPORT','TEST','Nov 18 2019  6:34PM','EUMRFSAEXP',NULL,NULL,NULL,'201911141','Nov 14 2019 12:00AM','Nov  8 2019 12:00AM','201911141','63','','','201911141',dbo.fn_GetTimedKey(),NULL,'us3mLaTRI1018',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUMRFSAEXP_20191118.txt' END WHERE expFormatCode = 'EUMRFSAEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUMRFSAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUMRFSAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUMRFSAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUMRFSAEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUMRFSAEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUMRFSAEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUMRFSAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUMRFSAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUMRFSAEXP','H01','dbo.U_EUMRFSAEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUMRFSAEXP','D10','dbo.U_EUMRFSAEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUMRFSAEXP','T90','dbo.U_EUMRFSAEXP_Trailer',NULL);
IF OBJECT_ID('U_EUMRFSAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUMRFSAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvPayrollDate] datetime NULL,
    [drvEmpHCContrib] varchar(1) NOT NULL,
    [drvEEHCContrib] varchar(12) NULL,
    [drvEEHCContribRaw] numeric NULL,
    [drvERDepCareContrib] varchar(1) NOT NULL,
    [drvEEDepCareContrib] varchar(12) NULL,
    [drvEEDepCareContribRaw] numeric NULL,
    [drvLPFSAIndicator] varchar(3) NULL,
    [drvGrouLocationCode] varchar(3) NOT NULL,
    [drvPayrollFreq] varchar(1) NOT NULL,
    [drvDETFiller1] varchar(1) NOT NULL,
    [drvDETFiller2] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvEEEffectiveDateHC] datetime NULL,
    [drvEETermDateHC] datetime NULL,
    [drvEEYTDElectAmt] varchar(12) NULL,
    [drvEEYTDElectAmtRaw] money NULL,
    [drvReimEffectiveDate] varchar(1) NOT NULL,
    [drvReimDebitCardInd] varchar(1) NOT NULL,
    [drvEEEffectiveDateDepCare] datetime NULL,
    [drvEETermDateDepCare] datetime NULL,
    [drvEEYTDCareElecAmt] varchar(12) NULL,
    [drvEEYTDCareElecAmtRaw] money NULL,
    [drvBankRoutingNumber] varchar(1) NOT NULL,
    [drvDETFiller3] varchar(1) NOT NULL,
    [drvTypeBankAccount] varchar(1) NOT NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvEmpAcctNumber] varchar(1) NOT NULL,
    [drvDETFiller4] varchar(1) NOT NULL,
    [drvEERHCContribAmt] varchar(1) NOT NULL,
    [drvEEYTDRHCContribAmt] varchar(1) NOT NULL,
    [drvEEParkingContrib] varchar(1) NOT NULL,
    [drvEEParkingEffectiveDate] varchar(1) NOT NULL,
    [drvEEParkingTermDate] varchar(1) NOT NULL,
    [drvEETransContrib] varchar(1) NOT NULL,
    [drvEETransEffDate] varchar(1) NOT NULL,
    [drvEETransTermDate] varchar(1) NOT NULL,
    [drvERParkingContrib] varchar(1) NOT NULL,
    [drvERTransitContrib] varchar(1) NOT NULL,
    [drvDETFiller5] varchar(1) NOT NULL,
    [drvDETFiller6] varchar(1) NOT NULL,
    [drvEmployeeId] char(9) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvGender] char(1) NULL,
    [drvPhoneNumber] varchar(1) NOT NULL,
    [drvMiddleInitial] varchar(1) NOT NULL,
    [drvDETFiller7] varchar(1) NOT NULL,
    [drvEEParkingMonthlyElecAmt] varchar(1) NOT NULL,
    [drvEETransitMonthlyElecAmt] varchar(1) NOT NULL,
    [drvERParkingMonthlyElecAmt] varchar(1) NOT NULL,
    [drvERTransitMonthlyElecAmt] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUMRFSAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUMRFSAEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EUMRFSAEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_Header] (
    [drvHdRecordType] varchar(1) NOT NULL,
    [drvHDClientNumber] varchar(4) NOT NULL,
    [drvHDClientName] varchar(32) NOT NULL,
    [drvHDFiller1] varchar(1) NOT NULL,
    [drvHDProdType] varchar(4) NOT NULL,
    [drvHDProcessType] varchar(6) NOT NULL,
    [drvHDFileCreationDate] datetime NOT NULL,
    [drvHDFiller2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUMRFSAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [HealthCareEE] numeric NULL,
    [EEDepCareContrib] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EUMRFSAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_PEarHist] (
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
IF OBJECT_ID('U_EUMRFSAEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EUMRFSAEXP_Trailer] (
    [drvTrailRecordType] varchar(1) NOT NULL,
    [drvRecordCount] varchar(8) NULL,
    [drvTotERHCCOntrib] varchar(4) NOT NULL,
    [drvTotEEHCCOntrib] varchar(12) NULL,
    [drvTotERDepCOntrib] varchar(4) NOT NULL,
    [drvTotEEDepCOntrib] varchar(12) NULL,
    [drvEEYTDHCA] varchar(12) NULL,
    [drvEEYTDDep] varchar(12) NULL,
    [drvERYTDHCA] varchar(4) NOT NULL,
    [drvERYTDDep] varchar(4) NOT NULL,
    [drvEETotParkingContrib] varchar(4) NOT NULL,
    [drvEETotTransitContrib] varchar(4) NOT NULL,
    [drvERTotParkingContrib] varchar(4) NOT NULL,
    [drvERTotTransitContrib] varchar(4) NOT NULL,
    [drvTrailerFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUMRFSAEXP] 
 
    @SystemID char(12) 
 
AS 
 
SET NOCOUNT ON; 
 
/********************************************************************************** 
 
Client Name: Trinity River Authority of Texas 
 
 
 
Created By: Marco Lagrosa 
 
Business Analyst: Lea King 
 
Create Date: 11/18/2019 
 
Service Request Number: SR-2019-00223916 
 
 
 
Purpose: UMR FSA Export 
 
 
 
Revision History 
 
---------------- 
 
Update By           Date           Request Num        Desc 
 
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX 
 
 
 
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUMRFSAEXP'; 
 
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUMRFSAEXP'; 
 
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUMRFSAEXP'; 
 
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUMRFSAEXP'; 
 
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUMRFSAEXP' ORDER BY RunID DESC; 
 
 
 
Execute Export 
 
-------------- 
 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUMRFSAEXP', 'ONDEMAND'; 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUMRFSAEXP', 'TEST'; 
 
 
 
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUMRFSAEXP'; 

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUMRFSAEXP', @AllObjects = 'Y', @IsWeb = 'Y' 
 
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
 
    SELECT @FormatCode = 'EUMRFSAEXP'; 
 
 
 
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
 
    DELETE FROM dbo.U_EUMRFSAEXP_EEList 
 
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID) 
 
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUMRFSAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1); 
 
 
 
    --========================================== 
 
    -- Create Deduction List 
 
    --========================================== 
 
    DECLARE @DedList VARCHAR(MAX) 
 
    SET @DedList = 'FSAM,FSAML,FSAD'; 
 
 
 
    IF OBJECT_ID('U_EUMRFSAEXP_DedList','U') IS NOT NULL 
 
        DROP TABLE dbo.U_EUMRFSAEXP_DedList; 
 
    SELECT DISTINCT 
 
         DedCode = DedDedCode 
 
        ,DedType = DedDedType 
 
    INTO dbo.U_EUMRFSAEXP_DedList 
 
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
 
    -- Run BDM Module 
 
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode; 
 
 
 
    --========================================== 
 
    -- Build Working Tables 
 
    --========================================== 
 
 
 
    ----------------------------- 
 
    -- Working Table - PDedHist 
 
    ----------------------------- 
 
    IF OBJECT_ID('U_EUMRFSAEXP_PDedHist','U') IS NOT NULL 
 
        DROP TABLE dbo.U_EUMRFSAEXP_PDedHist; 
 
    SELECT DISTINCT 
 
         PdhEEID 
 
        -- Current Payroll Amounts 
 
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END) 
 
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END) 
 
        -- YTD Payroll Amounts 
 
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt) 
 
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt) 
 
        -- Categorize Payroll Amounts 
 
        ,HealthCareEE     = SUM(CASE WHEN PdhDedCode IN ('FSAM','FSAML') THEN PdhEECurAmt ELSE 0.00 END) 
 
        ,EEDepCareContrib     = SUM(CASE WHEN PdhDedCode IN ('FSAD') THEN PdhEECurAmt ELSE 0.00 END) 
 
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)         
 
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END) 
 
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END) 
 
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
 
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
 
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
 
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
 
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
 
    INTO dbo.U_EUMRFSAEXP_PDedHist 
 
    FROM dbo.PDedHist WITH (NOLOCK) 
 
    JOIN dbo.U_EUMRFSAEXP_DedList WITH (NOLOCK) 
 
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
 
    IF OBJECT_ID('U_EUMRFSAEXP_PEarHist','U') IS NOT NULL 
 
        DROP TABLE dbo.U_EUMRFSAEXP_PEarHist; 
 
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
 
    INTO dbo.U_EUMRFSAEXP_PEarHist 
 
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
 
    -- DETAIL RECORD - U_EUMRFSAEXP_drvTbl 
 
    --------------------------------- 
 
    IF OBJECT_ID('U_EUMRFSAEXP_drvTbl','U') IS NOT NULL 
 
        DROP TABLE dbo.U_EUMRFSAEXP_drvTbl; 
 
    SELECT DISTINCT 
 
         drvEEID = xEEID 
 
        ,drvCoID = xCoID 
 
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA 
 
        -- standard fields above and additional driver fields below 
 
        ,drvSSN = eepSSN 
 
        ,drvLastName = EepNameLast 
 
        ,drvFirstName = EepNameFirst 
 
        ,drvPayrollDate = PrgPayDate 
 
        ,drvEmpHCContrib =  '' 
 
        ,drvEEHCContrib = CAST(CONVERT(DECIMAL(10,2),HealthCareEE) as Varchar(12)) 
        ,drvEEHCContribRaw = HealthCareEE 
 
        ,drvERDepCareContrib = '' 
 
        ,drvEEDepCareContrib = CAST(CONVERT(DECIMAL(10,2),EEDepCareContrib) as Varchar(12)) 
        ,drvEEDepCareContribRaw = EEDepCareContrib 
 
        ,drvLPFSAIndicator = CASE WHEN FSAML_DedCode IS NOT NULL THEN 'LTD' END 
 
        ,drvGrouLocationCode = '001' 
 
        ,drvPayrollFreq = 'B' 
 
        ,drvDETFiller1 = '' 
 
        ,drvDETFiller2 = '' 
 
        ,drvAddressLine1 = EepAddressLine1 
 
        ,drvAddressLine2 = EepAddressLine2 
 
        ,drvCity = EepAddressCity 
 
        ,drvState = EepAddressState 
 
        ,drvZipCode = EepAddressZipCode 
 
        ,drvEEEffectiveDateHC = CASE WHEN FSAMLFSAM_DedCode IS NOT NULL THEN FSAMLFSAM_BenStartdate END 

        ,drvEETermDateHC = CASE WHEN FSAMLFSAM_DedCode IS NOT NULL THEN ISNULL(FSAMLFSAM_BenStopdate, CAST(CONCAT(YEAR(GETDATE()), '1130') as datetime))  END --AddLogic to add Nov 30 each year of BenStopDate is null 
 
        ,drvEEYTDElectAmt = CASE WHEN FSAMLFSAM_DedCode IS NOT NULL THEN  CAST(CONVERT(DECIMAL(10,2),FSAMLFSAM_GoalAmt) as Varchar(12)) END 
 
        ,drvEEYTDElectAmtRaw = CASE WHEN FSAMLFSAM_DedCode IS NOT NULL THEN FSAMLFSAM_GoalAmt END 
 
        ,drvReimEffectiveDate = '' 
 
        ,drvReimDebitCardInd = '' 
 
        ,drvEEEffectiveDateDepCare = CASE WHEN FSAD_DedCode IS NOT NULL THEN FSAD_BenStartdate END 
        ,drvEETermDateDepCare = CASE WHEN FSAD_DedCode IS NOT NULL THEN ISNULL(FSAD_BenStopdate,CAST(CONCAT(YEAR(GETDATE()), '1130') as datetime)) END 
        ,drvEEYTDCareElecAmt = CASE WHEN FSAD_DedCode IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2),FSAD_GoalAmt) as Varchar(12))  END 
        ,drvEEYTDCareElecAmtRaw = CASE WHEN FSAD_DedCode IS NOT NULL THEN FSAD_GoalAmt END 
 
        ,drvBankRoutingNumber = '' 
 
        ,drvDETFiller3 = '' 
 
        ,drvTypeBankAccount = '' 
 
        ,drvCountry = '' 
 
        ,drvEmpAcctNumber = '' 
 
        ,drvDETFiller4 = '' 
 
        ,drvEERHCContribAmt = '' 
 
        ,drvEEYTDRHCContribAmt = '' 
 
        ,drvEEParkingContrib = '' 
 
        ,drvEEParkingEffectiveDate = '' 
 
        ,drvEEParkingTermDate = '' 
 
        ,drvEETransContrib = '' 
 
        ,drvEETransEffDate = '' 
 
        ,drvEETransTermDate = '' 
 
        ,drvERParkingContrib = '' 
 
        ,drvERTransitContrib = '' 
 
        ,drvDETFiller5 = '' 
 
        ,drvDETFiller6 = '' 
 
        ,drvEmployeeId = EecEmpNo 
 
        ,drvDateOfBirth = EepDateOfBirth 
 
        ,drvMaritalStatus = eepMaritalStatus 
 
        ,drvGender = EepGender 
 
        ,drvPhoneNumber = '' 
 
        ,drvMiddleInitial = '' 
 
        ,drvDETFiller7 = '' 
 
        ,drvEEParkingMonthlyElecAmt = '' 
 
        ,drvEETransitMonthlyElecAmt = '' 
 
        ,drvERParkingMonthlyElecAmt = '' 
 
        ,drvERTransitMonthlyElecAmt = '' 
 
    INTO dbo.U_EUMRFSAEXP_drvTbl 
 
    FROM dbo.U_EUMRFSAEXP_EEList WITH (NOLOCK) 
 
    JOIN dbo.EmpComp WITH (NOLOCK) 
 
        ON EecEEID = xEEID  
 
        AND EecCoID = xCoID 
 
    JOIN dbo.EmpPers WITH (NOLOCK) 
 
        ON EepEEID = xEEID 
 
    JOIN ( 
 
        Select  eedEEID,eedcoid 
 
            ,FSAML_DedCode = MAX((CASE WHEN eedDedCode = 'FSAML' then eedDedCode END)) 
 
            ,FSAML_BenStartdate = MAX((CASE WHEN eedDedCode = 'FSAML' then eedBenStartDate END)) 
 
            ,FSAML_GoalAmt = SUM((CASE WHEN eedDedCode = 'FSAML' then eedEEGoalAMt END)) 
 
            ,FSAML_DedAmt = SUM((CASE WHEN eedDedCode = 'FSAML' then CAST(eedUSGField1 as Money) END)) 
 
            ,FSAML_BenStopDate = MAX((CASE WHEN eedDedCode = 'FSAML' then eedBenStopDate END)) 
 
            ,FSAMLFSAM_DedCode = MAX((CASE WHEN eedDedCode IN ('FSAML','FSAM') then 'FSAMLFSAM' END)) 
 
            ,FSAMLFSAM_BenStartdate = MAX((CASE WHEN eedDedCode IN ('FSAML','FSAM')then eedBenStartDate END)) 
 
            ,FSAMLFSAM_GoalAmt = SUM((CASE WHEN eedDedCode IN ('FSAML','FSAM')then eedEEGoalAMt END)) 
 
            ,FSAMLFSAM_DedAmt = SUM((CASE WHEN eedDedCode IN ('FSAML','FSAM') then CAST(eedUSGField1 as Money) END)) 
 
            ,FSAMLFSAM_BenStopDate = MAX((CASE WHEN eedDedCode IN ('FSAML','FSAM') then eedBenStopDate END)) 
 
            ,FSAD_DedCode = MAX((CASE WHEN eedDedCode IN ('FSAD') then eedDedCode END)) 
 
            ,FSAD_BenStartdate = MAX((CASE WHEN eedDedCode IN ('FSAD') then eedBenStartDate END)) 
 
            ,FSAD_GoalAmt = SUM((CASE WHEN eedDedCode IN ('FSAD') then eedEEGoalAMt END)) 
 
            ,FSAD_DedAmt = SUM((CASE WHEN eedDedCode IN ('FSAD') then CAST(eedUSGField1 as Money)  END)) 
 
            ,FSAD_BenStopDate = MAX((CASE WHEN eedDedCode IN ('FSAD') then eedBenStopDate END)) 
            from dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK) 
            WHERE EedFormatCode = @FormatCode  
            AND EedValidForExport = 'Y'  group by eedEEID,eedcoid) as Consolidated 
            ON eedEEID  = XEEID 
            AND eedCOID = XCOID 
        JOIN dbo.U_EUMRFSAEXP_PEarHist (NOLOCK)
            on PehEeid = Xeeid
        JOIN dbo.U_EUMRFSAEXP_PDedHist (NOLOCK)
            on pdheeid = Xeeid

    ; 
 
    --------------------------------- 
 
    -- HEADER RECORD 
 
    --------------------------------- 
 
    IF OBJECT_ID('U_EUMRFSAEXP_Header','U') IS NOT NULL 
 
        DROP TABLE dbo.U_EUMRFSAEXP_Header; 
 
    SELECT DISTINCT 
 
         drvHdRecordType = 'H' 
 
        ,drvHDClientNumber = '7670' 
 
        ,drvHDClientName = 'Trinity River Authority of Texas' 
 
        ,drvHDFiller1 = '' 
 
        ,drvHDProdType = 'FLEX' 
 
        ,drvHDProcessType = 'UPDATE' 
 
        ,drvHDFileCreationDate = GETDATE() 
 
        ,drvHDFiller2 = '' 
 
    INTO dbo.U_EUMRFSAEXP_Header 
 
    ; 
 
    --------------------------------- 
 
    -- TRAILER RECORD 
 
    --------------------------------- 
 
    IF OBJECT_ID('U_EUMRFSAEXP_Trailer','U') IS NOT NULL 
 
        DROP TABLE dbo.U_EUMRFSAEXP_Trailer; 
 
    SELECT DISTINCT 
 
         drvTrailRecordType = 'T' 
 
        ,drvRecordCount = CAST( (Select count(*) from dbo.U_EUMRFSAEXP_drvTbl (NOLOCK) )  as varchar(8)) 
 
        ,drvTotERHCCOntrib = '0.00' 
 
        ,drvTotEEHCCOntrib =  CAST(CONVERT(DECIMAL(10,2), (Select Sum(drvEEHCContribRaw) from dbo.U_EUMRFSAEXP_drvTbl (NOLOCK) )) as Varchar(12)) 
 
        ,drvTotERDepCOntrib = '0.00' 
 
        ,drvTotEEDepCOntrib = CAST(CONVERT(DECIMAL(10,2), (Select Sum(drvEEDepCareContribRaw) from dbo.U_EUMRFSAEXP_drvTbl (NOLOCK) )) as Varchar(12)) 
 
        ,drvEEYTDHCA =  CAST(CONVERT(DECIMAL(10,2), (Select Sum(drvEEYTDElectAmtRaw) from dbo.U_EUMRFSAEXP_drvTbl (NOLOCK) )) as Varchar(12))  
 
        ,drvEEYTDDep =CAST(CONVERT(DECIMAL(10,2), (Select Sum(drvEEYTDCareElecAmtRaw) from dbo.U_EUMRFSAEXP_drvTbl (NOLOCK) )) as Varchar(12))     
 
        ,drvERYTDHCA = '0.00' 
 
        ,drvERYTDDep = '0.00' 
 
        ,drvEETotParkingContrib = '0.00' 
 
        ,drvEETotTransitContrib = '0.00' 
 
        ,drvERTotParkingContrib = '0.00' 
 
        ,drvERTotTransitContrib = '0.00' 
 
        ,drvTrailerFiller = '' 
 
    INTO dbo.U_EUMRFSAEXP_Trailer 
 
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
 
ALTER VIEW dbo.dsi_vwEUMRFSAEXP_Export AS 
 
    SELECT TOP 20000000 Data FROM dbo.U_EUMRFSAEXP_File (NOLOCK) 
 
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort; 
 
 
 
--Check out AscDefF 
 
SELECT * FROM dbo.AscDefF 
 
WHERE AdfHeaderSystemID LIKE 'EUMRFSAEXP%' 
 
ORDER BY AdfSetNumber, AdfFieldNumber; 
 
 
 
--Update Dates 
 
UPDATE dbo.AscExp 
 
    SET expLastStartPerControl = '201911111' 
 
       ,expStartPerControl     = '201911111' 
 
       ,expLastEndPerControl   = '201911189' 
 
       ,expEndPerControl       = '201911189' 
 
WHERE expFormatCode = 'EUMRFSAEXP'; 
 
 
 
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUMRFSAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUMRFSAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort