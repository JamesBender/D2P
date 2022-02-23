SET NOCOUNT ON;
IF OBJECT_ID('U_ETRNWES401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRNWES401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRNWES401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRNWES401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRNWES401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRNWES401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRNWES401];
GO
IF OBJECT_ID('U_ETRNWES401_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_Trailer];
GO
IF OBJECT_ID('U_ETRNWES401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_PEarHist];
GO
IF OBJECT_ID('U_ETRNWES401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_PDedHist];
GO
IF OBJECT_ID('U_ETRNWES401_Header') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_Header];
GO
IF OBJECT_ID('U_ETRNWES401_File') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_File];
GO
IF OBJECT_ID('U_ETRNWES401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_EEList];
GO
IF OBJECT_ID('U_ETRNWES401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_drvTbl];
GO
IF OBJECT_ID('U_ETRNWES401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_DedList];
GO
IF OBJECT_ID('U_ETRNWES401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_AuditFields];
GO
IF OBJECT_ID('U_ETRNWES401_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETRNWES401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRNWES401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRNWES401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRNWES401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRNWES401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRNWES401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRNWES401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRNWES401','TransAmerica 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ETRNWES401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRNWES401' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRecordType"','1','(''UA''=''F'')','ETRNWES401Z0','2','H','01','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRVendorName"','2','(''UA''=''F'')','ETRNWES401Z0','30','H','01','2',NULL,'VendorName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRFileCreateDt"','3','(''UD112''=''F'')','ETRNWES401Z0','14','H','01','3',NULL,'FileCreateDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRContractId"','4','(''UA''=''F'')','ETRNWES401Z0','9','H','01','4',NULL,'ContractId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRSubId"','5','(''UA''=''F'')','ETRNWES401Z0','5','H','01','5',NULL,'SubId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRIsMEP"','6','(''UA''=''F'')','ETRNWES401Z0','1','H','01','6',NULL,'IsMEP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRCompanyName"','7','(''UA''=''F'')','ETRNWES401Z0','40','H','01','7',NULL,'CompanyName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRPayrollEndDate"','8','(''UD112''=''F'')','ETRNWES401Z0','8','H','01','8',NULL,'PayrollEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRTotalPayrollAmount"','9','(''UA''=''F'')','ETRNWES401Z0','13','H','01','9',NULL,'TotalPayrollAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRDepositAmount"','10','(''UA''=''F'')','ETRNWES401Z0','13','H','01','10',NULL,'DepositAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRDepositMethod"','11','(''UA''=''F'')','ETRNWES401Z0','1','H','01','11',NULL,'DepositMethod',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRACHNumber"','12','(''UA''=''F'')','ETRNWES401Z0','26','H','01','12',NULL,'ACHNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRMode"','13','(''UA''=''F'')','ETRNWES401Z0','8','H','01','13',NULL,'Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRecordType"','1','(''UA''=''F'')','ETRNWES401Z0','2','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLocation"','2','(''UA''=''F'')','ETRNWES401Z0','5','D','10','2',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSubCompanyNumber"','3','(''UA''=''F'')','ETRNWES401Z0','5','D','10','3',NULL,'SubCompanyNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartGroupCode"','4','(''UA''=''F'')','ETRNWES401Z0','5','D','10','4',NULL,'GroupCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','5','(''UA''=''F'')','ETRNWES401Z0','9','D','10','5',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTitle"','6','(''UA''=''F'')','ETRNWES401Z0','5','D','10','6',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFirstName"','7','(''UA''=''F'')','ETRNWES401Z0','15','D','10','7',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFillers"','8','(''UA''=''F'')','ETRNWES401Z0','5','D','10','8',NULL,'Fillers',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMiddleInitial"','9','(''UA''=''F'')','ETRNWES401Z0','1','D','10','9',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLastName"','10','(''UA''=''F'')','ETRNWES401Z0','20','D','10','10',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSuffix"','11','(''UA''=''F'')','ETRNWES401Z0','4','D','10','11',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEEPreTax"','12','(''UA''=''F'')','ETRNWES401Z0','11','D','10','12',NULL,'EEPreTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEEPreTaxCatchup"','13','(''UA''=''F'')','ETRNWES401Z0','11','D','10','13',NULL,'EEPreTaxCatch-up',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEERoth"','14','(''UA''=''F'')','ETRNWES401Z0','11','D','10','14',NULL,'EERoth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEERothCatchup"','15','(''UA''=''F'')','ETRNWES401Z0','11','D','10','15',NULL,'EERothCatch-up',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEEPostTax"','16','(''UA''=''F'')','ETRNWES401Z0','11','D','10','16',NULL,'EEPostTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEEMandatoryAfterTax"','17','(''UA''=''F'')','ETRNWES401Z0','11','D','10','17',NULL,'EEMandatoryAfterTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERMatch"','18','(''UA''=''F'')','ETRNWES401Z0','11','D','10','18',NULL,'ERMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERNonMatch"','19','(''UA''=''F'')','ETRNWES401Z0','11','D','10','19',NULL,'ERNonMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERSafeHarborMatch"','20','(''UA''=''F'')','ETRNWES401Z0','11','D','10','20',NULL,'ERSafeHarborMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERSafeHarborNonMatch"','21','(''UA''=''F'')','ETRNWES401Z0','11','D','10','21',NULL,'ERSafeHarborNonMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERMoneyPurchase"','22','(''UA''=''F'')','ETRNWES401Z0','11','D','10','22',NULL,'ERMoneyPurchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERFullyVestedMoney"','23','(''UA''=''F'')','ETRNWES401Z0','11','D','10','23',NULL,'ERFullyVestedMoneyPurchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERPrevailingWage"','24','(''UA''=''F'')','ETRNWES401Z0','11','D','10','24',NULL,'ERPrevailingWage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartQMAC"','25','(''UA''=''F'')','ETRNWES401Z0','11','D','10','25',NULL,'QMAC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartQNEC"','26','(''UA''=''F'')','ETRNWES401Z0','11','D','10','26',NULL,'QNEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLoanRepayments"','27','(''UA''=''F'')','ETRNWES401Z0','11','D','10','27',NULL,'LoanRepayments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCompensationYTD"','28','(''UA''=''F'')','ETRNWES401Z0','11','D','10','28',NULL,'CompensationYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartExcludedCompYTD"','29','(''UA''=''F'')','ETRNWES401Z0','11','D','10','29',NULL,'ExcludedCompensationYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoursWorkedYTD"','30','(''UA''=''F'')','ETRNWES401Z0','4','D','10','30',NULL,'HoursWorkedYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIsUSAddress"','31','(''UA''=''F'')','ETRNWES401Z0','1','D','10','31',NULL,'IsUSAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddress1"','32','(''UA''=''F'')','ETRNWES401Z0','33','D','10','32',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddress2"','33','(''UA''=''F'')','ETRNWES401Z0','33','D','10','33',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCity"','34','(''UA''=''F'')','ETRNWES401Z0','25','D','10','34',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartState"','35','(''UA''=''F'')','ETRNWES401Z0','2','D','10','35',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartZipCode"','36','(''UA''=''F'')','ETRNWES401Z0','5','D','10','36',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartINTLCityProvice"','37','(''UA''=''F'')','ETRNWES401Z0','25','D','10','37',NULL,'INTLCityProvice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartINTLZipPostalCode"','38','(''UA''=''F'')','ETRNWES401Z0','10','D','10','38',NULL,'INTLZipPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartINTLCountry"','39','(''UA''=''F'')','ETRNWES401Z0','20','D','10','39',NULL,'INTLCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDateOfBirth"','40','(''UD112''=''F'')','ETRNWES401Z0','8','D','10','40',NULL,'DateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDateOfHire"','41','(''UD112''=''F'')','ETRNWES401Z0','8','D','10','41',NULL,'DateOfHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDateOfTerm"','42','(''UD112''=''F'')','ETRNWES401Z0','8','D','10','42',NULL,'DateOfTerm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRehireDate"','43','(''UD112''=''F'')','ETRNWES401Z0','8','D','10','43',NULL,'RehireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERQACANonElective"','44','(''UA''=''F'')','ETRNWES401Z0','11','D','10','44',NULL,'ERQACANon-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERQACAMatch"','45','(''UA''=''F'')','ETRNWES401Z0','11','D','10','45',NULL,'ERQACAMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERALTMatch"','46','(''UA''=''F'')','ETRNWES401Z0','11','D','10','46',NULL,'ERALTMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERALTProfitSharing"','47','(''UA''=''F'')','ETRNWES401Z0','11','D','10','47',NULL,'ERALTProfitSharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartERALTMoneyPurchase"','48','(''UA''=''F'')','ETRNWES401Z0','11','D','10','48',NULL,'ERALTMoneyPurchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmail"','49','(''UA''=''F'')','ETRNWES401Z0','60','D','10','49',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrRecordType"','1','(''UA''=''F'')','ETRNWES401Z0','2','T','90','1',NULL,'RecordType',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETRNWES401_20210326.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TransAmerica 401k Export','202006019','EMPEXPORT','ONDEMAND',NULL,'ETRNWES401',NULL,NULL,NULL,'202006019','Jun  1 2020  2:58PM','Jun  1 2020  2:58PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202006019','EMPEXPORT','SCH_TRNW4',NULL,'ETRNWES401',NULL,NULL,NULL,'202006019','Jun  1 2020  2:58PM','Jun  1 2020  2:58PM','202005221',NULL,'','','202005221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006059','EMPEXPORT','TEST','Jul  9 2020  7:26PM','ETRNWES401',NULL,NULL,NULL,'202006059','Jun  5 2020 12:00AM','Dec 30 1899 12:00AM','202006051','273','eecPayGroup','SM','202006051',dbo.fn_GetTimedKey(),NULL,'us3cPeWES1026A',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRNWES401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRNWES401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRNWES401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRNWES401','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETRNWES401' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETRNWES401' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETRNWES401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRNWES401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRNWES401','H01','dbo.U_ETRNWES401_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRNWES401','D10','dbo.U_ETRNWES401_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRNWES401','T90','dbo.U_ETRNWES401_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ETRNWES401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRNWES401] (
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
IF OBJECT_ID('U_ETRNWES401_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_Audit] (
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
IF OBJECT_ID('U_ETRNWES401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ETRNWES401_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRNWES401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPartRecordType] varchar(2) NOT NULL,
    [drvPartLocation] char(6) NULL,
    [drvPartSubCompanyNumber] varchar(1) NOT NULL,
    [drvPartGroupCode] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartTitle] varchar(30) NULL,
    [drvPartFirstName] varchar(100) NULL,
    [drvPartFillers] varchar(1) NOT NULL,
    [drvPartMiddleInitial] varchar(1) NULL,
    [drvPartLastName] varchar(100) NULL,
    [drvPartSuffix] varchar(30) NULL,
    [drvPartEEPreTax] varchar(11) NULL,
    [drvPartEEPreTaxRaw] numeric NULL,
    [drvPartEEPreTaxCatchup] varchar(1) NOT NULL,
    [drvPartEERoth] varchar(11) NULL,
    [drvPartEERothRaw] numeric NULL,
    [drvPartEERothCatchup] varchar(1) NOT NULL,
    [drvPartEEPostTax] varchar(1) NOT NULL,
    [drvPartEEMandatoryAfterTax] varchar(1) NOT NULL,
    [drvPartERMatch] varchar(11) NULL,
    [drvPartERMatchRaw] numeric NULL,
    [drvPartERNonMatch] varchar(1) NOT NULL,
    [drvPartERSafeHarborMatch] varchar(1) NOT NULL,
    [drvPartERSafeHarborNonMatch] varchar(1) NOT NULL,
    [drvPartERMoneyPurchase] varchar(1) NOT NULL,
    [drvPartERFullyVestedMoney] varchar(1) NOT NULL,
    [drvPartERPrevailingWage] varchar(1) NOT NULL,
    [drvPartQMAC] varchar(1) NOT NULL,
    [drvPartQNEC] varchar(1) NOT NULL,
    [drvPartLoanRepayments] varchar(11) NULL,
    [drvPartLoanRepaymentsRaw] numeric NULL,
    [drvPartCompensationYTD] varchar(11) NULL,
    [drvPartExcludedCompYTD] varchar(11) NULL,
    [drvPartHoursWorkedYTD] varchar(11) NULL,
    [drvPartIsUSAddress] varchar(1) NOT NULL,
    [drvPartAddress1] varchar(255) NULL,
    [drvPartAddress2] varchar(255) NULL,
    [drvPartCity] varchar(255) NULL,
    [drvPartState] varchar(255) NULL,
    [drvPartZipCode] varchar(50) NULL,
    [drvPartINTLCityProvice] varchar(1) NOT NULL,
    [drvPartINTLZipPostalCode] varchar(1) NOT NULL,
    [drvPartINTLCountry] varchar(1) NOT NULL,
    [drvPartDateOfBirth] datetime NULL,
    [drvPartDateOfHire] datetime NULL,
    [drvPartDateOfTerm] datetime NULL,
    [drvPartRehireDate] datetime NULL,
    [drvPartERQACANonElective] varchar(1) NOT NULL,
    [drvPartERQACAMatch] varchar(1) NOT NULL,
    [drvPartERALTMatch] varchar(1) NOT NULL,
    [drvPartERALTProfitSharing] varchar(1) NOT NULL,
    [drvPartERALTMoneyPurchase] varchar(1) NOT NULL,
    [drvPartEmail] varchar(50) NULL,
    [drvPayDate] datetime NULL
);
IF OBJECT_ID('U_ETRNWES401_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRNWES401_File') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ETRNWES401_Header') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_Header] (
    [drvHRRecordType] varchar(2) NOT NULL,
    [drvHRVendorName] varchar(17) NOT NULL,
    [drvHRFileCreateDt] nvarchar(4000) NULL,
    [drvHRContractId] varchar(6) NOT NULL,
    [drvHRSubId] varchar(5) NOT NULL,
    [drvHRIsMEP] varchar(1) NOT NULL,
    [drvHRCompanyName] varchar(14) NOT NULL,
    [drvHRPayrollEndDate] datetime NULL,
    [drvHRTotalPayrollAmount] varchar(13) NULL,
    [drvHRDepositAmount] varchar(13) NULL,
    [drvHRDepositMethod] varchar(1) NOT NULL,
    [drvHRACHNumber] varchar(1) NOT NULL,
    [drvHRMode] varchar(9) NULL
);
IF OBJECT_ID('U_ETRNWES401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401K] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhCatchUp] numeric NULL,
    [pdhMatch] numeric NULL,
    [PdhLoan] numeric NULL
);
IF OBJECT_ID('U_ETRNWES401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompYTDEx] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_ETRNWES401_Trailer') IS NULL
CREATE TABLE [dbo].[U_ETRNWES401_Trailer] (
    [drvTrRecordType] varchar(2) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRNWES401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: West Air Gases

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 06/01/2020
Service Request Number: TekP-2020-03-06-0001

Purpose: TransAmerica 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRNWES401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRNWES401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRNWES401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRNWES401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRNWES401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRNWES401', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRNWES401', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRNWES401', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRNWES401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRNWES401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRNWES401';

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
    DELETE FROM dbo.U_ETRNWES401_EEList
    WHERE xEEID IN (Select eeceeid from dbo.EmpComp where EecEEType in ('INT', 'TES', 'CON','Z'));

       DELETE FROM dbo.U_ETRNWES401_EEList
    WHERE xEEID IN (select eepeeid from emppers where eepssn = '999999999');

    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F, 401P, RTHCF, RTHCP, ROTHF, ROTHP ,401CF, 401CP,MATCH, 401L, 401L2';

    IF OBJECT_ID('U_ETRNWES401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRNWES401_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================


    IF OBJECT_ID('U_ETRNWES401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_AuditFields;
    CREATE TABLE dbo.U_ETRNWES401_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ETRNWES401_AuditFields VALUES ('empcomp','eecemplstatus');   
    INSERT INTO dbo.U_ETRNWES401_AuditFields VALUES ('empcomp','eecdateoftermination');    
 
    
    -- Create audit table
    IF OBJECT_ID('U_ETRNWES401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_Audit;
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
    INTO dbo.U_ETRNWES401_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ETRNWES401_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ETRNWES401_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -366 AND @EndDate + 7;

         
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETRNWES401_Audit ON dbo.U_ETRNWES401_Audit (audKey1Value, audKey2Value);
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETRNWES401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401K     = SUM(CASE WHEN PdhDedCode IN ('401F', '401P','401F','401P', '401CF', '401CP') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth     = SUM(CASE WHEN PdhDedCode IN ('RTHCF', 'RTHCP', 'ROTHF', 'ROTHP') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhCatchUp     = SUM(CASE WHEN PdhDedCode IN ('401CF', '401CP') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)        
        ,pdhMatch     = SUM(CASE WHEN PdhDedCode IN ('MATCH') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLoan     = SUM(CASE WHEN PdhDedCode IN ('401L', '401L2') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ETRNWES401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRNWES401_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETRNWES401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl and PehEarnCode not in ('BENEF', 'CELAL', 'EDUCA', 'EXP', 'FUNPD', 'GTL', 'HOLSV', 'HSERF', 'HSERI', 'INSPA', 'SEV') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y'  THEN PehCurAmt END)
        ,PehInclInDefCompYTDEx    = SUM(CASE WHEN PehInclInDefComp = 'N' and  PehEarnCode not in ('BENEF', 'CELAL', 'EDUCA', 'EXP', 'FUNPD', 'GTL', 'HOLSV', 'HSERF', 'HSERI', 'INSPA', 'SEV') THEN PehCurAmt END)

        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ETRNWES401_PEarHist
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
    -- DETAIL RECORD - U_ETRNWES401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRNWES401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPartRecordType = '02'
        ,drvPartLocation = EecLocation
        ,drvPartSubCompanyNumber = ''
        ,drvPartGroupCode = ''
        ,drvPartSSN = eepSSN
        ,drvPartTitle = EepNamePrefix
        ,drvPartFirstName = EepNameFirst
        ,drvPartFillers = ''
        ,drvPartMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvPartLastName = EepNameLast
        ,drvPartSuffix = CASE WHEN Isnull(eepnamesuffix,'') IN ('','Z') THEN  '' ELSE eepnamesuffix END
        ,drvPartEEPreTax = CAST(CONVERT(DECIMAL(9,2),Pdh401K) as varchar(11))
        ,drvPartEEPreTaxRaw = Pdh401K
        ,drvPartEEPreTaxCatchup = ''
        ,drvPartEERoth = CAST(CONVERT(DECIMAL(9,2),PdhRoth) as varchar(11)) 
        ,drvPartEERothRaw = PdhRoth
        ,drvPartEERothCatchup = ''
        ,drvPartEEPostTax = ''
        ,drvPartEEMandatoryAfterTax = ''
        ,drvPartERMatch = CAST(CONVERT(DECIMAL(9,2),pdhMatch) as varchar(11)) 
        ,drvPartERMatchRaw = pdhMatch
        ,drvPartERNonMatch = ''
        ,drvPartERSafeHarborMatch = ''
        ,drvPartERSafeHarborNonMatch = ''
        ,drvPartERMoneyPurchase = ''
        ,drvPartERFullyVestedMoney = ''
        ,drvPartERPrevailingWage = ''
        ,drvPartQMAC = ''
        ,drvPartQNEC = ''
        ,drvPartLoanRepayments = CAST(CONVERT(DECIMAL(9,2),pdhLoan) as varchar(11)) 
        ,drvPartLoanRepaymentsRaw = pdhLoan
        ,drvPartCompensationYTD = CAST(CONVERT(DECIMAL(9,2),PehInclInDefCompYTD) as varchar(11))  
        ,drvPartExcludedCompYTD = CAST(CONVERT(DECIMAL(9,2),PehInclInDefCompYTDEx) as varchar(11))  
        ,drvPartHoursWorkedYTD = CAST(CONVERT(DECIMAL(11,0),PehCurHrsYTD) as varchar(11) )
        ,drvPartIsUSAddress = '1'
        ,drvPartAddress1 = EepAddressLine1
        ,drvPartAddress2 = EepAddressLine2
        ,drvPartCity = EepAddressCity
        ,drvPartState = EepAddressState
        ,drvPartZipCode = EepAddressZipCode
        ,drvPartINTLCityProvice = ''
        ,drvPartINTLZipPostalCode = ''
        ,drvPartINTLCountry = ''
        ,drvPartDateOfBirth = EepDateOfBirth
        ,drvPartDateOfHire = eecdateoforiginalhire 
        ,drvPartDateOfTerm = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN eecdateoftermination ELSE (select top 1 audnewValue from dbo.U_ETRNWES401_Audit where audkey1value = xeeid and audFieldName = 'EecDateOfTermination') END
        /* if eecdateoftermination after eecdateoflasthire space fill else If EecDateOfOriginalHire does not = EecDateOfLastHire send EecDateOfLastHire*/
        ,drvPartRehireDate = CASE WHEN eecdateoftermination > eecdateoflasthire THEN NULL 
                                    ELSE 
                                    CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
                             END
        ,drvPartERQACANonElective = ''
        ,drvPartERQACAMatch = ''
        ,drvPartERALTMatch = ''
        ,drvPartERALTProfitSharing = ''
        ,drvPartERALTMoneyPurchase = ''
        ,drvPartEmail = eepAddressEMailAlternate
        ,drvPayDate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate, Paydate)  
    INTO dbo.U_ETRNWES401_drvTbl
    FROM dbo.U_ETRNWES401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        
    and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ETRNWES401_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ETRNWES401_PEarHist WITH (NOLOCK)
        ON PehEEID =  xEEID
    LEFT JOIN dbo.U_ETRNWES401_PDedHist WITH (NOLOCK)
        ON PdhEEID  = XEEID
    LEFT JOIN (SELECT PgpPayGroup as Paygroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   --AND PgpPeriodType = 'R'
                   GROUP BY PgpPayGroup) PayGrp
        On PayGrp.Paygroup = eecpaygroup
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ETRNWES401_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_Header;
    SELECT DISTINCT
         drvHRRecordType = '01'
        ,drvHRVendorName = 'Ultimate Software'
        ,drvHRFileCreateDt = format(getdate(),'yyyyMMddHHmmss')
        ,drvHRContractId = '810558'
        ,drvHRSubId = '00000'
        ,drvHRIsMEP = '0'
        ,drvHRCompanyName = 'West Air Gases'
        ,drvHRPayrollEndDate = (Select top 1 drvPayDate from dbo.U_ETRNWES401_drvTbl)
        ,drvHRTotalPayrollAmount = CAST( CONVERT(DECIMAL(11,2),(Select sum(drvPartLoanRepaymentsRaw + drvPartERMatchRaw + drvPartEERothRaw + drvPartEEPreTaxRaw ) from dbo.U_ETRNWES401_drvTbl)) as varchar(13))
        ,drvHRDepositAmount = CAST( CONVERT(DECIMAL(11,2),(Select sum(drvPartLoanRepaymentsRaw + drvPartERMatchRaw + drvPartEERothRaw + drvPartEEPreTaxRaw ) from dbo.U_ETRNWES401_drvTbl)) as varchar(13))
        ,drvHRDepositMethod =''
        ,drvHRACHNumber = ''
        ,drvHRMode =  CASE WHEN @ExportCode like 'TEST%' THEN 'Validated' END
    INTO dbo.U_ETRNWES401_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ETRNWES401_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ETRNWES401_Trailer;
    SELECT DISTINCT
         drvTrRecordType = '99'
    INTO dbo.U_ETRNWES401_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwETRNWES401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRNWES401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRNWES401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005251'
       ,expStartPerControl     = '202005251'
       ,expLastEndPerControl   = '202006019'
       ,expEndPerControl       = '202006019'
WHERE expFormatCode = 'ETRNWES401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRNWES401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRNWES401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort