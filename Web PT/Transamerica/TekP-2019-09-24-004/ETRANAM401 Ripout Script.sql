SET NOCOUNT ON;
IF OBJECT_ID('U_ETRANAM401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRANAM401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRANAM401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRANAM401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRANAM401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRANAM401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRANAM401];
GO
IF OBJECT_ID('U_ETRANAM401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_PEarHist];
GO
IF OBJECT_ID('U_ETRANAM401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_PDedHist];
GO
IF OBJECT_ID('U_ETRANAM401_Header') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_Header];
GO
IF OBJECT_ID('U_ETRANAM401_File') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_File];
GO
IF OBJECT_ID('U_ETRANAM401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_EEList];
GO
IF OBJECT_ID('U_ETRANAM401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_drvTbl];
GO
IF OBJECT_ID('U_ETRANAM401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_DedList];
GO
IF OBJECT_ID('U_ETRANAM401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_AuditFields];
GO
IF OBJECT_ID('U_ETRANAM401_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETRANAM401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRANAM401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRANAM401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRANAM401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRANAM401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRANAM401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRANAM401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ETRANAM401','TransAmerica 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ETRANAM401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','1','(''DA''=''F'')','ETRANAM401Z0','2','H','01','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Ultimate"','2','(''DA''=''F'')','ETRANAM401Z0','30','H','01','3',NULL,'VendorName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDate"','3','(''UD112''=''F'')','ETRANAM401Z0','14','H','01','33',NULL,'FileCreateDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"513520"','4','(''DA''=''F'')','ETRANAM401Z0','9','H','01','47',NULL,'ContractId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','5','(''DA''=''F'')','ETRANAM401Z0','5','H','01','56',NULL,'SubId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','6','(''DA''=''F'')','ETRANAM401Z0','1','H','01','61',NULL,'IsMEP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WebPT"','7','(''DA''=''F'')','ETRANAM401Z0','40','H','01','62',NULL,'CompanyName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','8','(''UD112''=''F'')','ETRANAM401Z0','8','H','01','102',NULL,'PayrollEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPayrollAmount"','9','(''UA''=''F'')','ETRANAM401Z0','13','H','01','110',NULL,'TotalPayrollAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositAmount"','10','(''UA''=''F'')','ETRANAM401Z0','13','H','01','123',NULL,'DepositAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','ETRANAM401Z0','1','H','01','136',NULL,'DepositMethod',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','ETRANAM401Z0','26','H','01','137',NULL,'ACHNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','ETRANAM401Z0','8','H','01','163',NULL,'Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','1','(''DA''=''F'')','ETRANAM401Z0','2','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','2','(''UA''=''F'')','ETRANAM401Z0','5','D','10','3',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','ETRANAM401Z0','5','D','10','8',NULL,'SubCompanyNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','ETRANAM401Z0','5','D','10','13',NULL,'GroupCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''F'')','ETRANAM401Z0','9','D','10','18',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','ETRANAM401Z0','5','D','10','27',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','ETRANAM401Z0','15','D','10','32',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','ETRANAM401Z0','5','D','10','47',NULL,'Fillers',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','9','(''UA''=''F'')','ETRANAM401Z0','1','D','10','52',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','10','(''UA''=''F'')','ETRANAM401Z0','20','D','10','53',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','11','(''UA''=''F'')','ETRANAM401Z0','4','D','10','73',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPreTax"','12','(''UA''=''F'')','ETRANAM401Z0','11','D','10','77',NULL,'EEPreTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''F'')','ETRANAM401Z0','11','D','10','88',NULL,'EEPreTaxCatch-up',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERoth"','14','(''UA''=''F'')','ETRANAM401Z0','11','D','10','99',NULL,'EERoth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','15','(''DA''=''F'')','ETRANAM401Z0','11','D','10','110',NULL,'EERothCatch-up',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','16','(''DA''=''F'')','ETRANAM401Z0','11','D','10','121',NULL,'EEPostTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','ETRANAM401Z0','11','D','10','132',NULL,'EEMandatoryAfterTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatch"','18','(''UA''=''F'')','ETRANAM401Z0','11','D','10','143',NULL,'ERMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','ETRANAM401Z0','11','D','10','154',NULL,'ERNonMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','ETRANAM401Z0','11','D','10','165',NULL,'ERSafeHarborMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','ETRANAM401Z0','11','D','10','176',NULL,'ERSafeHarborNonMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','ETRANAM401Z0','11','D','10','187',NULL,'ERMoneyPurchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','ETRANAM401Z0','11','D','10','198',NULL,'ERFullyVestedMoneyPurchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','ETRANAM401Z0','11','D','10','209',NULL,'ERPrevailingWage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','ETRANAM401Z0','11','D','10','220',NULL,'QMAC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''F'')','ETRANAM401Z0','11','D','10','231',NULL,'QNEC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepayments"','27','(''UA''=''F'')','ETRANAM401Z0','11','D','10','242',NULL,'LoanRepayments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompensationYTD"','28','(''UA''=''F'')','ETRANAM401Z0','11','D','10','253',NULL,'CompensationYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExclCompensationYTD"','29','(''UA''=''F'')','ETRANAM401Z0','11','D','10','264',NULL,'ExcludedCompensationYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedYTD"','30','(''UA''=''F'')','ETRANAM401Z0','4','D','10','275',NULL,'HoursWorkedYTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','31','(''DA''=''F'')','ETRANAM401Z0','1','D','10','279',NULL,'IsUSAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','32','(''UA''=''F'')','ETRANAM401Z0','33','D','10','280',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','33','(''UA''=''F'')','ETRANAM401Z0','33','D','10','313',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','34','(''UA''=''F'')','ETRANAM401Z0','20','D','10','346',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','ETRANAM401Z0','5','D','10','366',NULL,'space fill',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','36','(''UA''=''F'')','ETRANAM401Z0','2','D','10','371',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressPostalCode"','37','(''UA''=''F'')','ETRANAM401Z0','5','D','10','373',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','ETRANAM401Z0','25','D','10','378',NULL,'INTLCityProvice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','ETRANAM401Z0','10','D','10','403',NULL,'INTLZipPostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','ETRANAM401Z0','20','D','10','413',NULL,'INTLCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','41','(''UD112''=''F'')','ETRANAM401Z0','8','D','10','433',NULL,'DateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','42','(''UD112''=''F'')','ETRANAM401Z0','8','D','10','441',NULL,'DateOfHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','43','(''UD112''=''F'')','ETRANAM401Z0','8','D','10','449',NULL,'DateOfTerm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','44','(''UD112''=''F'')','ETRANAM401Z0','8','D','10','457',NULL,'RehireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','ETRANAM401Z0','11','D','10','465',NULL,'ERQACANon-Elective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','ETRANAM401Z0','11','D','10','476',NULL,'ERQACAMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','ETRANAM401Z0','11','D','10','487',NULL,'ERALTMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','ETRANAM401Z0','11','D','10','498',NULL,'ERALTProfitSharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','ETRANAM401Z0','11','D','10','509',NULL,'ERALTMoneyPurchase',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"99"','1','(''DA''=''F'')','ETRANAM401Z0','2','T','90','1',NULL,'RecordType',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRANAM401_20200625.txt',NULL,'','','',NULL,NULL,NULL,'TransAmerica 401K Export','202006229','EMPEXPORT','ONDEMAND','Feb 12 2020  9:06AM','ETRANAM401',NULL,NULL,NULL,'202006229','Feb 11 2020 11:49AM','Feb 11 2020 11:49AM','202006221','451','','','202006221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRANAM401_20200625.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202006229','EMPEXPORT','SCHEDULED','Feb 12 2020  9:06AM','ETRANAM401',NULL,NULL,NULL,'202006229','Feb 11 2020 11:49AM','Feb 11 2020 11:49AM','202006221','451','','','202006221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRANAM401_20200625.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202006229','EMPEXPORT','OEACTIVE','Feb 12 2020  9:05AM','ETRANAM401',NULL,NULL,NULL,'202006229','Feb 11 2020 11:49AM','Feb 11 2020 11:49AM','202006221','442','','','202006221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRANAM401_20200625.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202006229','EMPEXPORT','OEPASSIVE','Feb 12 2020  9:05AM','ETRANAM401',NULL,NULL,NULL,'202006229','Feb 11 2020 11:49AM','Feb 11 2020 11:49AM','202006221','449','','','202006221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRANAM401_20200625.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006229','EMPEXPORT','TEST','Jun 24 2020 12:30PM','ETRANAM401',NULL,NULL,NULL,'202006229','Jun 22 2020 12:00AM','Dec 30 1899 12:00AM','202006221','554','','','202006221',dbo.fn_GetTimedKey(),NULL,'us3lKiWEB1004',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ETRANAM401_20200625.txt' END WHERE expFormatCode = 'ETRANAM401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRANAM401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRANAM401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRANAM401','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRANAM401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRANAM401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ETRANAM401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRANAM401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ETRANAM401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRANAM401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRANAM401','H01','dbo.U_ETRANAM401_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRANAM401','D10','dbo.U_ETRANAM401_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRANAM401','T90','None',NULL);
IF OBJECT_ID('U_dsi_BDM_ETRANAM401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRANAM401] (
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
IF OBJECT_ID('U_ETRANAM401_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ETRANAM401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ETRANAM401_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRANAM401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvLocation] char(6) NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvEEPreTax] nvarchar(11) NULL,
    [drvEERoth] nvarchar(11) NULL,
    [drvERMatch] nvarchar(11) NULL,
    [drvLoanRepayments] nvarchar(11) NULL,
    [drvCompensationYTD] nvarchar(11) NULL,
    [drvExclCompensationYTD] nvarchar(11) NULL,
    [drvHoursWorkedYTD] nvarchar(4000) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressPostalCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvRehireDate] datetime NULL
);
IF OBJECT_ID('U_ETRANAM401_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRANAM401_File') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_ETRANAM401_Header') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_Header] (
    [drvFileCreationDate] datetime NOT NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvTotalPayrollAmount] nvarchar(4000) NULL,
    [drvDepositAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_ETRANAM401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEEPreTax] numeric NULL,
    [PdhEERoth] numeric NULL,
    [PdhEEMatch] numeric NULL,
    [PdhLoanRepayments] numeric NULL
);
IF OBJECT_ID('U_ETRANAM401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRANAM401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehCurExcludeAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRANAM401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Web PT

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/11/2020
Service Request Number: TekP-2019-09-24-004

Purpose: TransAmerica 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRANAM401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRANAM401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRANAM401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRANAM401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRANAM401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRANAM401', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRANAM401', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRANAM401', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRANAM401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRANAM401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRANAM401';

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
    DELETE FROM dbo.U_ETRANAM401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRANAM401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401P,401ER,401L,401L2,401L3,ROTCP,ROTCF,ROTHF,ROTHP';

    IF OBJECT_ID('U_ETRANAM401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRANAM401_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;




    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ETRANAM401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_AuditFields;
    CREATE TABLE dbo.U_ETRANAM401_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ETRANAM401_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ETRANAM401_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_ETRANAM401_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ETRANAM401_AuditFields VALUES ('EmpComp','EecEecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETRANAM401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ETRANAM401_Audit
    FROM dbo.U_ETRANAM401_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ETRANAM401_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(YEAR, -1, @StartDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_ETRANAM401_Audit WHERE audRowNo > 1;







    --==========================================
    -- BDM Section
    --==========================================`
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

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
    IF OBJECT_ID('U_ETRANAM401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --,PdhEERothP = SUM(CASE WHEN PdhDedCode IN ('ROTCP','ROTHP') AND PdhEECurAmt > 0 THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEPreTax = SUM(CASE WHEN PdhDedCode IN ('401CF', '401CP', '401F', '401P') AND PdhEECurAmt > 0 THEN PdhEECurAmt ELSE 0.00 END) -- JCB
        ,PdhEERoth = SUM(CASE WHEN PdhDedCode IN ('ROTCP','ROTCF','ROTHF','ROTHP') AND PdhEECurAmt > 0 THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEMatch = SUM(CASE WHEN PdhDedCode IN ('401ER') AND PdhERCurAmt > 0 THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLoanRepayments = SUM(CASE WHEN PdhDedCode IN ('401L', '401L2', '401L3') AND PdhEECurAmt > 0 THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ETRANAM401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRANAM401_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETRANAM401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN ErnInclInDefComp = 'Y' OR ErnInclInDefCompHrs = 'Y' OR ErnInclInDefCompWageLimit = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurExcludeAmtYTD    = SUM(CASE WHEN ErnInclInDefComp = 'N' AND ErnInclInDefCompHrs = 'N' AND ErnInclInDefCompWageLimit = 'N' THEN PehCurAmt ELSE 0.00 END)
        --,PehCurExcludeAmtYTD    = SUM(CASE WHEN ErnInclInDefComp = 'N' OR ErnInclInDefCompHrs = 'N' OR ErnInclInDefCompWageLimit = 'N' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode NOT IN ('PRMO', 'PRMR') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ETRANAM401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON PehEarnCode = ErnEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    --AND PehEarnCode IN ('BEREV','BONUS','BONDC','OTC','COMM','CMTR','DT','FLOAT','HOL','JURY','MPL','MPP','OTH','OT','PTO','REBON','REG','RETRO','SICK','VAC','VOLUN','WLR','PRMO','PRMR', 'GTL')
    --AND (ErnInclInDefComp = 'Y' OR ErnInclInDefCompHrs = 'Y' OR ErnInclInDefCompWageLimit = 'Y')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETRANAM401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRANAM401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvLocation = EecLocation
        ,drvSSN = eepSSN
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddleInit = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = CASE WHEN EepNameSuffix <> 'Z' THEN EepNameSuffix END 
        ,drvEEPreTax = RIGHT('00000000' + FORMAT(PdhEEPreTax, '#0.00'), 11)
        ,drvEERoth = RIGHT('00000000' + FORMAT(PdhEERoth, '#0.00'), 11)
        ,drvERMatch = RIGHT('00000000' + FORMAT(PdhEEMatch, '#0.00'), 11)
        ,drvLoanRepayments = RIGHT('00000000' + FORMAT(PdhLoanRepayments, '#0.00'), 11)
        ,drvCompensationYTD = RIGHT('00000000' + FORMAT(PehCurAmtYTD, '#0.00'), 11)  ----------------------------- 
        ,drvExclCompensationYTD = RIGHT('00000000' + FORMAT(PehCurExcludeAmtYTD, '#0.00'), 11)
        ,drvHoursWorkedYTD = FORMAT(ROUND(PehCurHrsYTD, 0), '0000') 
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressPostalCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvDateOfTermination =    CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN  audNewValue ELSE EecDateOfTermination END
        ,drvRehireDate =    CASE WHEN EecDateOfTermination > EecDateOfLastHire THEN '' ELSE 
                                CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
                            END 
    INTO dbo.U_ETRANAM401_drvTbl
    FROM dbo.U_ETRANAM401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETRANAM401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ETRANAM401_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_ETRANAM401_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ETRANAM401_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audFieldName = 'EecDateOfTermination'
    WHERE EecEmplStatus <> 'T'
        OR (
                EecEmplStatus = 'T' and EecDateOfTermination > DATEADD(DAY, -365, GETDATE())
            )
    /*(
                eecemplstatus <> 'T' 
                OR (
                        (eecemplstatus= 'T' 
                        AND eectermreason <>'TRO' 
                        AND EXISTS (
                                    select 1 
                                    from dbo.U_ETRANAM401_Audit WITH (NOLOCK)
                                    where  audEEID = xEEID 
                                    AND audCOID = xcoid 
                                    and audfieldname = 'EecDateOFTermination' 
                                    ))
                         OR
                        (
                            EecEmplStatus = 'T'
                            AND (ISNULL(BdmBenStopDate, '') = '' OR BdmBenStopDate <= @EndDate)
                    
                        )
                    )
            )*/
    ;

    DECLARE @HeaderTotal AS DECIMAL(10,2);

    SELECT @HeaderTotal = SUM(PdhEEPreTax) + SUM(PdhEERoth) + SUM(PdhEEMatch) + SUM(PdhLoanRepayments)
    FROM dbo.U_ETRANAM401_PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRANAM401_drvTbl WITH (NOLOCK)
        ON PdhEEID = drvEEID;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ETRANAM401_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ETRANAM401_Header;
    SELECT DISTINCT
         drvFileCreationDate = GETDATE()
        ,drvPayrollEndDate = (SELECT MAX(PrgPayDate) as PrgPayDate FROM dbo.PayReg WITH (NOLOCK) WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl) -- PdhLoanRepayments
        ,drvTotalPayrollAmount = FORMAT(@HeaderTotal, '0000000000.00')
        --RIGHT('0000000000' + FORMAT((SELECT SUM(PdhEEPreTax) + SUM(PdhEERoth) + SUM(PdhEEMatch) FROM dbo.U_ETRANAM401_PDedHist WITH (NOLOCK)), '#0.00'), 13)
        ,drvDepositAmount = FORMAT(@HeaderTotal, '0000000000.00')
        --RIGHT('0000000000' + FORMAT((SELECT SUM(PdhEEPreTax) + SUM(PdhEERoth) + SUM(PdhEEMatch) FROM dbo.U_ETRANAM401_PDedHist WITH (NOLOCK)), '#0.00'), 13)
    INTO dbo.U_ETRANAM401_Header
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
ALTER VIEW dbo.dsi_vwETRANAM401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRANAM401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRANAM401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006221'
       ,expStartPerControl     = '202006221'
       ,expLastEndPerControl   = '202006229'
       ,expEndPerControl       = '202006229'
WHERE expFormatCode = 'ETRANAM401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRANAM401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRANAM401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort  