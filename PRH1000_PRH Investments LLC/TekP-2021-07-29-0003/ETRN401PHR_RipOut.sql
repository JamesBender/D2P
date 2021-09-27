SET NOCOUNT ON;
IF OBJECT_ID('U_ETRN401PHR_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRN401PHR_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRN401PHR' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRN401PHR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRN401PHR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRN401PHR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRN401PHR];
GO
IF OBJECT_ID('U_ETRN401PHR_PHist') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_PHist];
GO
IF OBJECT_ID('U_ETRN401PHR_PEarHistYTD') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_PEarHistYTD];
GO
IF OBJECT_ID('U_ETRN401PHR_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_PDedHist];
GO
IF OBJECT_ID('U_ETRN401PHR_File') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_File];
GO
IF OBJECT_ID('U_ETRN401PHR_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_EEList];
GO
IF OBJECT_ID('U_ETRN401PHR_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_DedList];
GO
IF OBJECT_ID('U_dsi_ETRN401PHR_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ETRN401PHR_hdrTbl];
GO
IF OBJECT_ID('U_dsi_ETRN401PHR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ETRN401PHR_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRN401PHR';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRN401PHR';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRN401PHR';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRN401PHR';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRN401PHR';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ETRN401PHR','Transamerica 401k Payroll','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','579','S','N','BVPCME0000K0','N','Oct  6 2017  2:39PM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRN401PHR' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','1','(''DA''=''F'')','BVPCME0000K0','2','H','01','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVendorName"','2','(''UA''=''F'')','BVPCME0000K0','30','H','01','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreateDate"','3','(''UA''=''F'')','BVPCME0000K0','14','H','01','33',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractID"','4','(''UA''=''F'')','BVPCME0000K0','9','H','01','47',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubID"','5','(''UA''=''F'')','BVPCME0000K0','5','H','01','56',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsMEP"','6','(''UA''=''F'')','BVPCME0000K0','1','H','01','61',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyName"','7','(''UA''=''F'')','BVPCME0000K0','40','H','01','62',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','8','(''UA''=''F'')','BVPCME0000K0','8','H','01','102',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPayrollAmt"','9','(''UN02''=''F'')','BVPCME0000K0','13','H','01','110',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositAmt"','10','(''UN02''=''F'')','BVPCME0000K0','13','H','01','123',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositMethod"','11','(''UA''=''F'')','BVPCME0000K0','1','H','01','136',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvACHNumber"','12','(''UA''=''F'')','BVPCME0000K0','26','H','01','137',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMode"','13','(''UA''=''F'')','BVPCME0000K0','8','H','01','163',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','1','(''DA''=''F'')','BVPCME0000K0','2','D','10','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','2','(''UA''=''F'')','BVPCME0000K0','5','D','10','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCompanyNumber"','3','(''UA''=''F'')','BVPCME0000K0','5','D','10','8',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupCode"','4','(''UA''=''F'')','BVPCME0000K0','5','D','10','13',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''F'')','BVPCME0000K0','9','D','10','18',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','6','(''UA''=''F'')','BVPCME0000K0','5','D','10','27',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','BVPCME0000K0','15','D','10','32',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Filler"','8','(''SS''=''F'')','BVPCME0000K0','5','D','10','47',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','9','(''UA''=''F'')','BVPCME0000K0','1','D','10','52',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','10','(''UA''=''F'')','BVPCME0000K0','20','D','10','53',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','11','(''UA''=''F'')','BVPCME0000K0','4','D','10','73',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPreTaxAmt"','12','(''UN02''=''F'')','BVPCME0000K0','11','D','10','77',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPreTaxCatchUpAmt"','13','(''UN02''=''F'')','BVPCME0000K0','11','D','10','88',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERothAmt"','14','(''UN02''=''F'')','BVPCME0000K0','11','D','10','99',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERothCatchUpAmt"','15','(''UN02''=''F'')','BVPCME0000K0','11','D','10','110',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPostTaxAmt"','16','(''UN02''=''F'')','BVPCME0000K0','11','D','10','121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEMandPostTaxAmt"','17','(''UN02''=''F'')','BVPCME0000K0','11','D','10','132',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMatchAmt"','18','(''UN02''=''F'')','BVPCME0000K0','11','D','10','143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERNotMatchAmt"','19','(''UN02''=''F'')','BVPCME0000K0','11','D','10','154',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERSafeHarborMatchAmt"','20','(''UN02''=''F'')','BVPCME0000K0','11','D','10','165',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERSafeHarborNonMatchAmt"','21','(''UN02''=''F'')','BVPCME0000K0','11','D','10','176',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERMoneyPurchase"','22','(''UN02''=''F'')','BVPCME0000K0','11','D','10','187',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERFullyVestedMoneyPurchase"','23','(''UN02''=''F'')','BVPCME0000K0','11','D','10','198',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERPrevailingWage"','24','(''UN02''=''F'')','BVPCME0000K0','11','D','10','209',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQMAC"','25','(''UN02''=''F'')','BVPCME0000K0','11','D','10','220',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQNEC"','26','(''UN02''=''F'')','BVPCME0000K0','11','D','10','231',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepayAmt"','27','(''UN02''=''F'')','BVPCME0000K0','11','D','10','242',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompensationYTDAmt"','28','(''UN02''=''F'')','BVPCME0000K0','11','D','10','253',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludedCompensationYTDAmt"','29','(''UN02''=''F'')','BVPCME0000K0','11','D','10','264',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkedYTD"','30','(''UA''=''F'')','BVPCME0000K0','4','D','10','275',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsUSAddress"','31','(''UA''=''F'')','BVPCME0000K0','1','D','10','279',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','32','(''UA''=''F'')','BVPCME0000K0','33','D','10','280',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','33','(''UA''=''F'')','BVPCME0000K0','33','D','10','313',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','34','(''UA''=''F'')','BVPCME0000K0','25','D','10','346',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','35','(''UA''=''F'')','BVPCME0000K0','2','D','10','371',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','36','(''UA''=''F'')','BVPCME0000K0','5','D','10','373',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIntlAddressCityProvince"','37','(''UA''=''F'')','BVPCME0000K0','25','D','10','378',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIntlAddressZipCode"','38','(''UA''=''F'')','BVPCME0000K0','10','D','10','403',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIntlCountry"','39','(''UA''=''F'')','BVPCME0000K0','20','D','10','413',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','40','(''UA''=''F'')','BVPCME0000K0','8','D','10','433',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','41','(''UA''=''F'')','BVPCME0000K0','8','D','10','441',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofTermination"','42','(''UA''=''F'')','BVPCME0000K0','8','D','10','449',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofRehire"','43','(''UA''=''F'')','BVPCME0000K0','8','D','10','457',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERQACANonElective"','44','(''UN02''=''F'')','BVPCME0000K0','11','D','10','465',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERQACAMatch"','45','(''UN02''=''F'')','BVPCME0000K0','11','D','10','476',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERALTMatch"','46','(''UN02''=''F'')','BVPCME0000K0','11','D','10','487',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERALTProfitSharing"','47','(''UN02''=''F'')','BVPCME0000K0','11','D','10','498',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERALTMoneyPurchase"','48','(''UN02''=''F'')','BVPCME0000K0','11','D','10','509',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','49','(''UA''=''F'')','BVPCME0000K0','59','D','10','520',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"99"','1','(''DA''=''F'')','BVPCME0000K0','2','T','90','1',NULL,NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETRN401PHR_20210927.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','0K2KR',NULL,NULL,NULL,'Transamerica 401k Payroll','201808159','EMPEXPORT','ETRN401PHR','Aug 16 2018  7:27PM','ETRN401PHR',NULL,NULL,NULL,'201808159','Aug 15 2018 12:00AM','Dec 30 1899 12:00AM','201808151','5','','','201808151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPRHI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','Z15X9',NULL,NULL,NULL,'TEST','201808029','EMPEXPORT','TEST','Aug 14 2018  3:43PM','ETRN401PHR',NULL,NULL,NULL,'201808029','Aug  2 2018 12:00AM','Dec 30 1899 12:00AM','201808021','444','','','201808021',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPRHI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','ExportDescription','C','Transamerica 401k Payroll');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','FileType','C','txt');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','MaxFileLength','C','568');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','SystemID','V','BVPCMG0010K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRN401PHR','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETRN401PHR' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETRN401PHR' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETRN401PHR_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRN401PHR_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRN401PHR','H01','dbo.U_dsi_ETRN401PHR_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRN401PHR','D10','dbo.U_dsi_ETRN401PHR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRN401PHR','T90','NONE',NULL);
IF OBJECT_ID('U_dsi_ETRN401PHR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ETRN401PHR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvLocation] varchar(6000) NULL,
    [drvSubCompanyNumber] varchar(1) NOT NULL,
    [drvGroupCode] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNamePrefix] varchar(1) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(1) NOT NULL,
    [drvEEPreTaxAmt] varchar(30) NULL,
    [drvEEPreTaxCatchUpAmt] varchar(30) NULL,
    [drvEERothAmt] varchar(30) NULL,
    [drvEERothCatchUpAmt] varchar(30) NULL,
    [drvEEPostTaxAmt] varchar(1) NOT NULL,
    [drvEEMandPostTaxAmt] varchar(1) NOT NULL,
    [drvERMatchAmt] varchar(30) NULL,
    [drvERNotMatchAmt] varchar(1) NOT NULL,
    [drvERSafeHarborMatchAmt] varchar(1) NOT NULL,
    [drvERSafeHarborNonMatchAmt] varchar(1) NOT NULL,
    [drvERMoneyPurchase] varchar(1) NOT NULL,
    [drvERFullyVestedMoneyPurchase] varchar(1) NOT NULL,
    [drvERPrevailingWage] varchar(1) NOT NULL,
    [drvQMAC] varchar(1) NOT NULL,
    [drvQNEC] varchar(1) NOT NULL,
    [drvLoanRepayAmt] varchar(30) NULL,
    [drvCompensationYTDAmt] varchar(30) NULL,
    [drvExcludedCompensationYTDAmt] varchar(30) NULL,
    [drvHrsWorkedYTD] varchar(30) NULL,
    [drvIsUSAddress] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvIntlAddressCityProvince] varchar(1) NOT NULL,
    [drvIntlAddressZipCode] varchar(1) NOT NULL,
    [drvIntlCountry] varchar(1) NOT NULL,
    [drvDateofBirth] char(8) NULL,
    [drvDateofHire] char(8) NULL,
    [drvDateofTermination] char(8) NULL,
    [drvDateofRehire] char(8) NULL,
    [drvERQACANonElective] varchar(1) NOT NULL,
    [drvERQACAMatch] varchar(1) NOT NULL,
    [drvERALTMatch] varchar(1) NOT NULL,
    [drvERALTProfitSharing] varchar(1) NOT NULL,
    [drvERALTMoneyPurchase] varchar(1) NOT NULL,
	drvEmailAddress varchar(100) NULL
);
IF OBJECT_ID('U_dsi_ETRN401PHR_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ETRN401PHR_hdrTbl] (
    [drvVendorName] varchar(17) NOT NULL,
    [drvFileCreateDate] varchar(6000) NULL,
    [drvContractID] varchar(6) NOT NULL,
    [drvSubID] varchar(5) NOT NULL,
    [drvIsMEP] varchar(1) NOT NULL,
    [drvCompanyName] varchar(20) NOT NULL,
    [drvPayrollEndDate] char(8) NULL,
    [drvTotalPayrollAmt] numeric NULL,
    [drvDepositAmt] varchar(30) NULL,
    [drvDepositMethod] varchar(1) NOT NULL,
    [drvACHNumber] varchar(1) NOT NULL,
    [drvMode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ETRN401PHR_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRN401PHR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRN401PHR_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRN401PHR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRN401PHR_File') IS NULL
CREATE TABLE [dbo].[U_ETRN401PHR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(520) NULL
);
IF OBJECT_ID('U_ETRN401PHR_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRN401PHR_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEECurAmt401K] numeric NULL,
    [PdhEECurAmtROTH] numeric NULL,
    [PdhEECurAmtMatch] numeric NULL,
    [PdhEECurAmt401KCatchUp] numeric NULL,
    [PdhEECurAmtROTHCatchUp] numeric NULL,
    [PdhEECurAmtSAFEH] numeric NULL,
    [PdhEECurAmtLoanTot] numeric NULL
);
IF OBJECT_ID('U_ETRN401PHR_PEarHistYTD') IS NULL
CREATE TABLE [dbo].[U_ETRN401PHR_PEarHistYTD] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] numeric NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehCurHrsYTD] numeric NULL,
    [PehInclInDefComp] numeric NULL,
    [PehInclInDefCompHrs] numeric NULL
);
IF OBJECT_ID('U_ETRN401PHR_PHist') IS NULL
CREATE TABLE [dbo].[U_ETRN401PHR_PHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRN401PHR]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: PRH Investments, LLC 
Vendor Name: Transamerica 401k Payroll - Fixed Width Format
Created By: Vraj Parikh
Business Analyst: Justin Holy
Create Date: 1/28/2018
Service Request Number: PRH1000-2017-00167780 (rebuild)

Purpose: TransAmerica Payroll

Changes:
MM/DD/YYYY    NAME HERE     SF 09999999              Comments Here

_dsi_usp_ExportRipout @FormatCode = 'ETRN401PHR', @AllObjects = 'Y', @IsWeb = 'Y'

select * from dbo.U_dsi_Configuration where FormatCode = 'ETRN401PHR' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ETRN401PHR'
select * from dbo.U_dsi_Parameters where FormatCode = 'ETRN401PHR'

select * from AscDefH where AdhFormatCode = 'ETRN401PHR'
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl, *
FROM dbo.AscExp WHERE expformatcode = 'ETRN401PHR';
select * from ascdeff JOIN AscDefH on adhSystemiD = AdfHeaderSystemID WHERE AdhFormatCode = 'ETRN401PHR' order by adfrectype, AdfSetNumber, AdfFieldNumber 

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRN401PHR' ORDER BY RunID DESC;

DSI_SP_TESTSWITCHBOX_V2 'ETRN401PHR', 'ETRN401PHR'
DSI_SP_TESTSWITCHBOX_V2 'ETRN401PHR', 'TEST'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ETRN401PHR' AND CfgName = 'TESTING'

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
    SELECT @FormatCode = 'ETRN401PHR';

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

    --remove test employees - 7/18/18
    DELETE FROM dbo.U_ETRN401PHR_EEList
    where xeeid in ('BAYPTL0000K0','BAPMAL0010K0','BAYPI30000K0','BIJ6280040K0','BIJ6IH0020K0','BAYOT60000K0','BVJFT40000K0')

    --no future hires (see further below)

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    -- SELECT * FROM dbo.U_ETRN401PHR_EEList
    DELETE FROM dbo.U_ETRN401PHR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRN401PHR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401L,401M,401P,ROTCF,ROTHF,ROTHP,RTHCP';

    IF OBJECT_ID('U_ETRN401PHR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRN401PHR_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETRN401PHR_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt = CAST(SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhERCurAmt = CAST(SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEECurAmt401K = CAST(SUM(CASE WHEN PdhDedCode IN ('401P','401F') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtROTH = CAST(SUM(CASE WHEN PdhDedCode IN ('ROTHF','ROTHP') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtMatch = CAST(SUM(CASE WHEN PdhDedCode IN ('401M') THEN PdhERCurAmt ELSE 0.00 END)   AS NUMERIC(12,2))      
        ,PdhEECurAmt401KCatchUp = CAST(SUM(CASE WHEN PdhDedCode IN ('401CP','401CF') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtROTHCatchUp = CAST(SUM(CASE WHEN PdhDedCode IN ('ROTCF','RTHCP') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtSAFEH = CAST(SUM(CASE WHEN PdhDedCode IN ('') THEN PdhEECurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PdhEECurAmtLoanTot = CAST(SUM(CASE WHEN PdhDedCode IN ('401L') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) AS NUMERIC(12,2))
    INTO dbo.U_ETRN401PHR_PDedHist
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_ETRN401PHR_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    WHERE  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETRN401PHR_PHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_PHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate          = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
    INTO dbo.U_ETRN401PHR_PHist
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl between @StartPerControl and @EndPerControl         --7/13/18 = @StartPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETRN401PHR_PEarHistYTD','U') IS NOT NULL
        DROP TABLE dbo.U_ETRN401PHR_PEarHistYTD;
    SELECT DISTINCT
         PehEEID
        --,PrgPayDate          = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END) AS NUMERIC(12,2))
        ,PehCurHrs           = CAST(SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END) AS NUMERIC(12,2))
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD        = CAST(SUM(PehCurAmt) AS NUMERIC(12,2))
        ,PehCurHrsYTD        = CAST(SUM(PehCurHrs) AS NUMERIC(12,2))
        -- Include Deferred Comp Amount/Hours
        ,PehInclInDefComp    = CAST(SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END) AS NUMERIC(12,2))
        ,PehInclInDefCompHrs = CAST(SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END) AS NUMERIC(12,2))
    INTO dbo.U_ETRN401PHR_PEarHistYTD
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    
     --==========================================
    -- Remove Terminated Employees greater than 1 year
    --==========================================

    DELETE dbo.U_ETRN401PHR_EEList
    FROM dbo.U_ETRN401PHR_EEList
    JOIN EmpComp t WITH (NOLOCK) ON xeeid = eeceeid
        and xcoid = eeccoid                                                        --7/2/18 
    WHERE DATEDIFF(DAY,t.EecDateOfTermination,@EndDate) > 365 ;

    --no future hire dates 4/16/18
    DELETE dbo.U_ETRN401PHR_EEList
    FROM dbo.U_ETRN401PHR_EEList
    JOIN EmpComp on eeceeid = xeeid and eeccoid = xcoid
    JOIN (SELECT PrgPayDate
        FROM dbo.U_ETRN401PHR_PHist
        GROUP BY PrgPayDate) e ON 1=1
    where eecdateoflasthire > e.PrgPayDate;

    ----no future term dates 4/20/18
    DELETE dbo.U_ETRN401PHR_EEList
    FROM dbo.U_ETRN401PHR_EEList
    JOIN EmpComp on eeceeid = xeeid and eeccoid = xcoid
    JOIN (SELECT PrgPayDate
        FROM dbo.U_ETRN401PHR_PHist
        GROUP BY PrgPayDate) e ON 1=1
    where eecdateoftermination > e.PrgPayDate;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_dsi_ETRN401PHR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_dsi_ETRN401PHR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_dsi_ETRN401PHR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvLocation = dbo.dsi_fnRemoveChars('.,/',cmpcompanycode) --cmpcompanyname
        ,drvSubCompanyNumber = ''
        ,drvGroupCode = ''
        ,drvSSN = eepSSN
        ,drvNamePrefix = ''
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddleInit = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = ''
        ,drvEEPreTaxAmt = CAST(PdhEECurAmt401K AS VARCHAR)
        ,drvEEPreTaxCatchUpAmt = CAST(PdhEECurAmt401KCatchUp AS VARCHAR)
        ,drvEERothAmt = CAST(PdhEECurAmtROTH AS VARCHAR)
        ,drvEERothCatchUpAmt = CAST(PdhEECurAmtROTHCatchUp AS VARCHAR)
        ,drvEEPostTaxAmt = ''
        ,drvEEMandPostTaxAmt = ''
        ,drvERMatchAmt = CAST(PdhEECurAmtMatch AS VARCHAR)
        ,drvERNotMatchAmt = ''
        ,drvERSafeHarborMatchAmt = ''
        ,drvERSafeHarborNonMatchAmt = ''
        ,drvERMoneyPurchase = ''
        ,drvERFullyVestedMoneyPurchase = ''
        ,drvERPrevailingWage = ''
        ,drvQMAC = ''
        ,drvQNEC = ''
        ,drvLoanRepayAmt = CAST(PdhEECurAmtLoanTot AS VARCHAR)
        ,drvCompensationYTDAmt = CAST(PehCurAmtYTD AS VARCHAR)
        ,drvExcludedCompensationYTDAmt = CAST(PehInclInDefComp AS VARCHAR)
        ,drvHrsWorkedYTD = CAST(dbo.dsi_fnRemoveChars('.',dbo.dsi_fnPadZero(isnull(PehCurHrsYTD,0.00),4,0)) AS VARCHAR)--CAST(PehCurHrsYTD AS VARCHAR)
        ,drvIsUSAddress = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvIntlAddressCityProvince = ''
        ,drvIntlAddressZipCode = ''
        ,drvIntlCountry = ''
        ,drvDateofBirth = CONVERT(CHAR(8),EepDateOfBirth,112)
        ,drvDateofHire = CONVERT(CHAR(8),EecDateofOriginalHire,112)
        ,drvDateofTermination = case when eecemplstatus = 'T' and EecDateOfTermination < @EndDate then CONVERT(CHAR(8),EecDateOfTermination,112) end    --4/16/18
        ,drvDateofRehire = CASE WHEN  EecDateofOriginalHire <> EecDateOfLastHire THEN CONVERT(CHAR(8),EecDateOfLastHire,112) END
        ,drvERQACANonElective = ''
        ,drvERQACAMatch = ''
        ,drvERALTMatch = ''
        ,drvERALTProfitSharing = ''
        ,drvERALTMoneyPurchase = ''
		,drvEmailAddress = EepAddressEmail

    INTO dbo.U_dsi_ETRN401PHR_drvTbl
    FROM dbo.U_ETRN401PHR_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ETRN401PHR_PEarHistYTD WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ETRN401PHR_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID 
    LEFT JOIN COMPANY WITH (NOLOCK)
        ON EmpComp.EecCoid = CmpCoid
    ;

    ---------------------------------
    -- HEADER RECORD - U_dsi_ETRN401PHR_hdrTbl
    ---------------------------------
    IF OBJECT_ID('U_dsi_ETRN401PHR_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_dsi_ETRN401PHR_hdrTbl;
    SELECT DISTINCT
        drvVendorName = 'UltimatePRHInvest' --'TransAmerica'
        ,drvFileCreateDate = dbo.dsi_fnRemoveChars('-:.',REPLACE(CONVERT(VARCHAR(20),GETDATE(),121),' ',''))
        ,drvContractID = '512960'
        ,drvSubID = '00000'
        ,drvIsMEP = '0'
        ,drvCompanyName = 'PRH Investments, LLC'
        ,drvPayrollEndDate = CONVERT(CHAR(8),e.PayDate,112)
        ,drvTotalPayrollAmt = --CAST(d.amt AS VARCHAR)--e.amt

        (SELECT sum(CAST(drvEEPreTaxAmt AS NUMERIC (12,2))) + 
        sum(CAST(drvEEPreTaxCatchUpAmt AS NUMERIC (12,2))) +
        sum(CAST(drvEERothAmt AS NUMERIC (12,2)))+
        sum(CAST(drvEERothCatchUpAmt AS NUMERIC (12,2)))+
        sum(CAST(drvERMatchAmt AS NUMERIC (12,2)))+
        sum(CAST(drvLoanRepayAmt AS NUMERIC (12,2)))

        FROM dbo.U_dsi_ETRN401PHR_drvTbl )
        ,drvDepositAmt = CAST(d.amt AS VARCHAR)
        ,drvDepositMethod = '0'
        ,drvACHNumber = ''
        ,drvMode = ''--CASE WHEN @ExportCode IN ('TEST') THEN 'VALIDATE' ELSE '' END

    INTO dbo.U_dsi_ETRN401PHR_hdrTbl
    FROM (SELECT CAST(ISNULL(SUM(PdhEECurAmt401K),0) + ISNULL(SUM(PdhEECurAmtMatch),0) + ISNULL(SUM(PdhEECurAmt401KCatchUp),0) +  ISNULL(SUM(PdhEECurAmtROTH),0) +  ISNULL(SUM(PdhEECurAmtROTHCatchUp),0)+ ISNULL(SUM(PdhEECurAmtLoanTot),0)  AS NUMERIC(12,2))amt 
        FROM dbo.U_ETRN401PHR_PDedHist) d
   LEFT JOIN (SELECT MAX(PrgPayDate) paydate, SUM(PehCurAmt) amt
        FROM dbo.U_ETRN401PHR_PHist
        /*GROUP BY PrgPayDate */) e ON 1=1;
    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwETRN401PHR_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ETRN401PHR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRN401PHR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201705031'
       ,expStartPerControl     = '201705031'
       ,expLastEndPerControl   = '201705109'
       ,expEndPerControl       = '201705109'
WHERE expFormatCode = 'ETRN401PHR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRN401PHR_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ETRN401PHR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;