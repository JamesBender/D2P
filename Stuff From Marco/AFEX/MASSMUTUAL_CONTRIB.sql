SET NOCOUNT ON;
IF OBJECT_ID('U_EMMCONAFEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMMCONAFEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMMCONAFEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMMCONAFEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMMCONAFEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMMCONAFEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMMCONAFEX];
GO
IF OBJECT_ID('U_EMMCONAFEX_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_PTaxHist];
GO
IF OBJECT_ID('U_EMMCONAFEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_PEarHist];
GO
IF OBJECT_ID('U_EMMCONAFEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_PDedHist];
GO
IF OBJECT_ID('U_EMMCONAFEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_Header];
GO
IF OBJECT_ID('U_EMMCONAFEX_HdrRecords') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_HdrRecords];
GO
IF OBJECT_ID('U_EMMCONAFEX_File') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_File];
GO
IF OBJECT_ID('U_EMMCONAFEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_EEList];
GO
IF OBJECT_ID('U_EMMCONAFEX_Cont_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_Cont_Trailer];
GO
IF OBJECT_ID('U_EMMCONAFEX_Cont_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_Cont_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMMCONAFEX';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EMMCONAFEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMMCONAFEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMMCONAFEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMMCONAFEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMMCONAFEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMMCONAFEX','Mass Mutual Contrib Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMMCONAFEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''F'')','EMMCONAFEXZ0','4','H','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMCONAFEXZ0','4','H','20','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMCONAFEXZ0','6','H','20','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDescription"','4','(''UA''=''F'')','EMMCONAFEXZ0','30','H','20','15',NULL,'File Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionDate"','5','(''UD112''=''F'')','EMMCONAFEXZ0','8','H','20','45',NULL,'Scheduled Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionDate"','6','(''UD112''=''F'')','EMMCONAFEXZ0','8','H','20','53',NULL,'Actual Transmission Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActTransmissionTime"','7','(''UA''=''F'')','EMMCONAFEXZ0','4','H','20','61',NULL,'Actual Transmission Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','8','(''DA''=''F'')','EMMCONAFEXZ0','2','H','20','65',NULL,'Actual Transmission Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONT"','1','(''DA''=''F'')','EMMCONAFEXZ0','4','D','25','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMCONAFEXZ0','4','D','25','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMCONAFEXZ0','6','D','25','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN1"','4','(''DA''=''F'')','EMMCONAFEXZ0','8','D','25','15',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','5','(''UA''=''F'')','EMMCONAFEXZ0','12','D','25','23',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EMMCONAFEXZ0','9','D','25','35',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','7','(''UD112''=''F'')','EMMCONAFEXZ0','8','D','25','44',NULL,'Payroll Date (Effective Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodStart"','8','(''UD112''=''F'')','EMMCONAFEXZ0','8','D','25','52',NULL,'Payroll Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEnd"','9','(''UD112''=''F'')','EMMCONAFEXZ0','8','D','25','60',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSource"','10','(''UA''=''F'')','EMMCONAFEXZ0','5','D','25','68',NULL,'Contribution Source Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','11','(''UA''=''F'')','EMMCONAFEXZ0','12','D','25','73',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LNRP"','1','(''DA''=''F'')','EMMCONAFEXZ0','4','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMCONAFEXZ0','4','D','30','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMCONAFEXZ0','6','D','30','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN1"','4','(''DA''=''F'')','EMMCONAFEXZ0','8','D','30','15',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','5','(''UA''=''F'')','EMMCONAFEXZ0','12','D','30','23',NULL,'Subsidiary EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EMMCONAFEXZ0','9','D','30','35',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','7','(''UD112''=''F'')','EMMCONAFEXZ0','8','D','30','44',NULL,'Payroll Date (Effective Date)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodEnd"','8','(''UD112''=''F'')','EMMCONAFEXZ0','8','D','30','52',NULL,'Payroll Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','9','(''UA''=''F'')','EMMCONAFEXZ0','12','D','30','60',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CNTR"','1','(''DA''=''F'')','EMMCONAFEXZ0','4','T','35','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''F'')','EMMCONAFEXZ0','4','T','35','5',NULL,'Record Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContractNumber"','3','(''UA''=''F'')','EMMCONAFEXZ0','6','T','35','9',NULL,'Master Contract Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailCount"','4','(''UN0''=''F'')','EMMCONAFEXZ0','12','T','35','15',NULL,'Total File Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionRecords"','5','(''UN0''=''F'')','EMMCONAFEXZ0','12','T','35','27',NULL,'Total Contribution Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount"','6','(''UN0''=''F'')','EMMCONAFEXZ0','12','T','35','39',NULL,'Total Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRecords"','7','(''UN0''=''F'')','EMMCONAFEXZ0','12','T','35','51',NULL,'Total Loan Repayment Records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmount"','8','(''UN0''=''F'')','EMMCONAFEXZ0','12','T','35','63',NULL,'Total Loan Repayment Amount',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMMCONAFEX_20191231.txt',NULL,'','','',NULL,NULL,NULL,'Contribution Loan Export','201910171','EMPEXPORT','CONTRIB','Nov 20 2019  4:42PM','EMMCONAFEX',NULL,NULL,NULL,'201910171','Oct 17 2019 12:00AM','Oct  6 2019 12:00AM','201910171','114','','','201910171',dbo.fn_GetTimedKey(),NULL,'',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMMCONAFEX_20191231.txt',NULL,'','','',NULL,NULL,NULL,'Test Contribution Loans Export','201911141','EMPEXPORT','TEST_CONT','Nov 20 2019  4:52PM','EMMCONAFEX',NULL,NULL,NULL,'201911141','Nov 14 2019 12:00AM','Nov  8 2019 12:00AM','201906071','132','','','201906071',dbo.fn_GetTimedKey(),NULL,'us3mLaASS1010',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMMCONAFEX_20191231.txt' END WHERE expFormatCode = 'EMMCONAFEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMCONAFEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMCONAFEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMCONAFEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMCONAFEX','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMCONAFEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMMCONAFEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMMCONAFEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMMCONAFEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMMCONAFEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMMCONAFEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','CONTRIB','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','CONTRIB','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','CONTRIB','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','CONTRIB','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','CONTRIB','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','CONTRIB','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','TEST_CONT','H','01','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','TEST_CONT','D','10','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','TEST_CONT','T','15','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','TEST_CONT','H','40','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','TEST_CONT','D','45','Y','F');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EMMCONAFEX','TEST_CONT','T','50','Y','F');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMCONAFEX','H20','dbo.U_EMMCONAFEX_Header','drvfiletype = ''CONT''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMCONAFEX','D25','dbo.U_EMMCONAFEX_Cont_drvTbl','drvContributionSource <> ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMCONAFEX','D30','dbo.U_EMMCONAFEX_Cont_drvTbl','drvContributionSource = ''PLAN1''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMMCONAFEX','T35','dbo.U_EMMCONAFEX_Cont_Trailer',NULL);
IF OBJECT_ID('U_EMMCONAFEX_Cont_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_Cont_drvTbl] (
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEIN] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayrollDate] varchar(8) NULL,
    [drvPeriodStart] datetime NULL,
    [drvPeriodEnd] datetime NULL,
    [drvContributionSource] varchar(5) NULL,
    [drvContributionAmount] varchar(31) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMCONAFEX_Cont_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_Cont_Trailer] (
    [drvDetailCount] int NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvContributionRecords] int NULL,
    [drvContributionAmount] bigint NULL,
    [drvLoanRecords] int NULL,
    [drvLoanAmount] bigint NULL
);
IF OBJECT_ID('U_EMMCONAFEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMMCONAFEX_File') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EMMCONAFEX_HdrRecords') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_HdrRecords] (
    [Header_Type] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMCONAFEX_Header') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_Header] (
    [drvContractNumber] varchar(10) NULL,
    [drvFileDescription] varchar(16) NULL,
    [drvTransmissionDate] datetime NOT NULL,
    [drvActTransmissionDate] datetime NOT NULL,
    [drvActTransmissionTime] varchar(4) NULL,
    [drvFileType] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EMMCONAFEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EMMCONAFEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [Peh415TestingComp] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL
);
IF OBJECT_ID('U_EMMCONAFEX_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EMMCONAFEX_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossWagesYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMMCONAFEX]

    @SystemID CHAR(12)

AS

SET NOCOUNT ON;

/**********************************************************************************

Client Name: Associated Foreign Exchange



Created By: Marco Lagrosa

Business Analyst: Lea King

Create Date: 11/18/2019

Service Request Number: TekP-2019-10-16-0001



Purpose: To send employee information to Mass Mutual for plan administration.



Revision History

----------------

Update By            Date            Request Num                Desc        





SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMMCONAFEX';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMMCONAFEX';

SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMMCONAFEX';

SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMMCONAFEX';

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMMCONAFEX' ORDER BY DateTimeCompleted DESC;

--Contributions and Loans --

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMCONAFEX', 'CONTRIB';

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMMCONAFEX', 'TEST_CONT';



EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMMCONAFEX', @AllObjects = 'Y', @IsWeb  = 'Y'



**********************************************************************************/

BEGIN



    --==========================================

    -- Declare variables

    --==========================================

    DECLARE @FORMATCODE VARCHAR(10)

        ,@ExportCode VARCHAR(10)

        ,@StartDate DATETIME

        ,@EndDate DATETIME

        ,@StartPerControl VARCHAR(9)

        ,@EndPerControl VARCHAR(9)

        ,@MasterContractNum VARCHAR(10)

        ,@TotalFileRecords INT;



    SET @FORMATCODE = 'EMMCONAFEX'

    SET @MasterContractNum = '063098'

    

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

    DELETE FROM dbo.U_EMMCONAFEX_EEList

    WHERE xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)

    AND xEEID IN (SELECT xEEID FROM dbo.U_EMMCONAFEX_EEList GROUP BY xEEID HAVING Count(*) > 1 );

 

    --Delete Employees with invalid SSN 999999999

    DELETE dbo.U_EMMCONAFEX_EEList

    FROM dbo.U_EMMCONAFEX_EEList

    INNER JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID

        AND EepSSN = '999999999';


     --Delete Employees EecEeType of TES

    DELETE from  dbo.U_EMMCONAFEX_EEList  where xeeid in (select distinct EEcEEid  from EmpComp where EecEEType = 'TES')



    --==========================================

    -- Build Employee Data and the driver tables

    --==========================================

    -----------------------------

    -- Working Table - PDedHist

    -----------------------------

    IF OBJECT_ID('U_EMMCONAFEX_PDedHist') IS NOT NULL

        DROP TABLE dbo.U_EMMCONAFEX_PDedHist;


    SELECT DISTINCT

         PdhEEID

        ,PdhSource     = CASE WHEN PdhDedCode IN ('401CF','401CP','401F','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('ROTHF','ROTHP') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L','401L2') THEN 'PLAN1' 

                            --WHEN PdhDedCode IN ('401ER') THEN 'SFMAT' 

                        END

        ,PdhEECurAmt = SUM(PdhEECurAmt)

        ,PdhERCurAmt = SUM(PdhERCurAmt)

    INTO dbo.U_EMMCONAFEX_PDedHist

    FROM dbo.PDedHist WITH (NOLOCK)

    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl

    AND PdhDedCode IN ('401CF','401CP','401F','401P','ROTHF','ROTHP','401L','401L2')

    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401CF','401CP','401F','401P') THEN 'DS'

                            WHEN PdhDedCode IN ('ROTHF','ROTHP') THEN 'ROTH'

                            WHEN PdhDedCode IN ('401L','401L2') THEN 'PLAN1' 

                            --WHEN PdhDedCode IN ('401ER') THEN 'SFMAT' 

                        END

    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);



    ------------------------------------

    -- Working Table - PEarHist (YTD)

    ------------------------------------

    IF OBJECT_ID('U_EMMCONAFEX_PEarHist') IS NOT NULL

        DROP TABLE dbo.U_EMMCONAFEX_PEarHist;

    SELECT DISTINCT

         PehEEID

        ,PehCurAmtYTD        = SUM(PehCurAmt)

        ,PehCurHrsYTD        = SUM(PehCurHrs)

        ,Peh415TestingComp   = SUM(CASE WHEN ErnInclInMiscEarn1 = 'Y' THEN PehCurAmt END)

        ,PehInclInDefComp    = SUM(CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt END)

        ,PehInclInDefCompHrs = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurHrs END)

    INTO dbo.U_EMMCONAFEX_PEarHist

    FROM dbo.PEarHist WITH (NOLOCK)

    INNER JOIN dbo.EarnCode WITH (NOLOCK)

        ON PehEarnCode = ErnEarnCode

    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)

    AND PehPerControl <= @EndPerControl   

    AND ErnEarnCode in ('B','BRV','ET','GF','HC','HOL','JUR','LTD','MI','OT','RB','REG','STD')
    GROUP BY PehEEID;



    -----------------------------

    -- Working Table - PTaxHist

    -----------------------------

    IF OBJECT_ID('U_EMMCONAFEX_PTaxHist') IS NOT NULL

        DROP TABLE dbo.U_EMMCONAFEX_PTaxHist;

    SELECT DISTINCT

         PthEEID

        ,PthGrossWagesYTD    = SUM(PthCurGrossWages)       

    INTO dbo.U_EMMCONAFEX_PTaxHist

    FROM dbo.PTaxHist WITH (NOLOCK)

    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)

    AND PthPerControl <= @EndPerControl

    AND PthTaxCode = 'USFIT'

    GROUP BY PthEEID

    HAVING SUM(PthCurGrossWages) <> 0.00;



    ---------------------------------

    -- HEADER RECORD - Multiple Headers are included in the file

    ---------------------------------

    IF OBJECT_ID('U_EMMCONAFEX_HdrRecords') IS NOT NULL

        DROP TABLE dbo.U_EMMCONAFEX_HdrRecords;
       
       SELECT 'CONT' AS Header_Type --Demographics

    INTO dbo.U_EMMCONAFEX_HdrRecords





    IF OBJECT_ID('U_EMMCONAFEX_Header') IS NOT NULL

        DROP TABLE dbo.U_EMMCONAFEX_Header;

    SELECT DISTINCT

         drvContractNumber        = @MasterContractNum

        ,drvFileDescription     = CASE
                                       WHEN Header_Type = 'CONT' THEN 'CCS Contrib File'
                                  END

        ,drvTransmissionDate    = GETDATE()

        ,drvActTransmissionDate = GETDATE()

        ,drvActTransmissionTime = LEFT(REPLACE(CONVERT(VARCHAR,GETDATE(),108),':',''),4)

        ,drvFileType            = Header_Type 

    INTO dbo.U_EMMCONAFEX_Header

    FROM dbo.U_EMMCONAFEX_HdrRecords;


    IF @ExportCode LIKE '%CONT%' 

    BEGIN

        ---------------------------------

        -- DETAIL RECORD - Contributions and Loans

        ---------------------------------

        IF OBJECT_ID('U_EMMCONAFEX_Cont_drvTbl') IS NOT NULL

            DROP TABLE dbo.U_EMMCONAFEX_Cont_drvTbl;

        SELECT DISTINCT

             drvContractNumber        = '063098'

            ,drvEIN                 = '204819436'

            ,drvSSN                 = EepSSN             

            ,drvPayrollDate         = PrgPayDate

            ,drvPeriodStart         = PrgPeriodStart

            ,drvPeriodEnd           = PrgPeriodEnd

            ,drvContributionSource  = PdhSource

            -- Remove the 

            ,drvContributionAmount  = CASE WHEN pdhSource = 'SFMAT' THEN
            
                                        CASE WHEN PdhERCurAmt >= 0 THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhERCurAmt*100,12,0)) 

                                           ELSE '-'+CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhERCurAmt*-1*100,11,0)) 

                                       END
                                     ELSE 
                                         CASE WHEN PdhEECurAmt >= 0 THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*100,12,0)) 

                                           ELSE '-'+CONVERT(VARCHAR,dbo.dsi_fnPadZero(PdhEECurAmt*-1*100,11,0)) 

                                       END
                                     END 

            ,drvEEID = xEEID

            ,drvCoID = xCOID

            ,drvInitialSort = EepSSN

            ,drvFileType = 'CONT'

        INTO dbo.U_EMMCONAFEX_Cont_drvTbl

        FROM dbo.U_EMMCONAFEX_EEList WITH (NOLOCK)

        INNER JOIN dbo.EmpComp WITH (NOLOCK)

            ON EecEEID = xEEID 

            AND EecCoID = xCoID

        INNER JOIN dbo.EmpPers WITH (NOLOCK)

            ON EepEEID = xEEID

        INNER JOIN dbo.U_EMMCONAFEX_PDedHist WITH (NOLOCK)

            ON PdhEEID = xEEID 

        LEFT JOIN dbo.Company WITH (NOLOCK)

            ON CmpCOID = xCOID

        LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PrgPayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 

                   FROM dbo.PgPayPer WITH (NOLOCK)

                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 

                   AND PgpPeriodType = 'R'

                   GROUP BY PgpPayGroup

        ) Prg

            ON EecPayGroup = PgpPayGroup

        ;

        ---------------------------------

        -- TRAILER RECORD - Contributions and Loans

        ---------------------------------

        IF OBJECT_ID('U_EMMCONAFEX_Cont_Trailer') IS NOT NULL

            DROP TABLE dbo.U_EMMCONAFEX_Cont_Trailer;

        SELECT DISTINCT

             drvDetailCount         = COUNT(*)

            ,drvContractNumber        = '063098'

            ,drvContributionRecords = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN 1 ELSE 0 END)

            ,drvContributionAmount  = SUM(CASE WHEN drvContributionSource <> 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)

            ,drvLoanRecords         = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN 1 ELSE 0 END)

            ,drvLoanAmount          = SUM(CASE WHEN drvContributionSource = 'PLAN1' THEN CAST(drvContributionAmount AS BIGINT) ELSE 0 END)

        INTO dbo.U_EMMCONAFEX_Cont_Trailer

        FROM dbo.U_EMMCONAFEX_Cont_drvTbl;



        SELECT @TotalFileRecords = @TotalFileRecords + drvDetailCount

        FROM dbo.U_EMMCONAFEX_Cont_Trailer;

    END
    --==========================================

    -- Set FileName

    --==========================================

    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N')

    BEGIN

        UPDATE dbo.U_dsi_Parameters

        SET ExportFile = '063098' + 

                         CASE
                              WHEN @ExportCode LIKE '%CONT%' THEN 'cont'
                         END +

                         CASE WHEN @ExportCode LIKE 'TEST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'test_' ELSE '_' END + 

                         CONVERT(VARCHAR,GetDate(),112) +

                         '.asc'

        WHERE FormatCode = @FormatCode;

    END;



END;

/**********************************************************************************



--Alter the View

ALTER VIEW dbo.dsi_vwEMMCONAFEX_Export AS

    SELECT TOP 200000000 Data FROM dbo.U_EMMCONAFEX_File WITH (NOLOCK)

    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO



--Check out AscDefF

SELECT * FROM dbo.AscDefF

WHERE AdfHeaderSystemID LIKE 'EMMCONAFEX%'

ORDER BY AdfSetNumber, AdfFieldNumber;



--Update Dates

UPDATE dbo.AscExp

    SET ExpLastStartPerControl = '201810011'

       ,ExpStartPerControl     = '201810011'

       ,ExpLastEndPerControl   = '201810019'

       ,ExpEndPerControl       = '201810019'

WHERE ExpFormatCode = 'EMMCONAFEX';



**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMMCONAFEX_Export AS  
    SELECT TOP 200000000 Data FROM dbo.U_EMMCONAFEX_File WITH (NOLOCK) 
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort 