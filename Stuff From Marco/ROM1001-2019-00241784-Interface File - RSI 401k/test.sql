SET NOCOUNT ON;
IF OBJECT_ID('U_EROMRSI401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EROMRSI401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EROMRSI401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEROMRSI401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEROMRSI401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EROMRSI401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROMRSI401];
GO
IF OBJECT_ID('U_EROMRSI401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_PEarHist];
GO
IF OBJECT_ID('U_EROMRSI401_PDedHist_2') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_PDedHist_2];
GO
IF OBJECT_ID('U_EROMRSI401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_PDedHist];
GO
IF OBJECT_ID('U_EROMRSI401_File') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_File];
GO
IF OBJECT_ID('U_EROMRSI401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_EEList];
GO
IF OBJECT_ID('U_EROMRSI401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_drvTbl];
GO
IF OBJECT_ID('U_EROMRSI401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EROMRSI401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EROMRSI401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EROMRSI401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EROMRSI401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EROMRSI401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EROMRSI401','RSI 401k File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EROMRSI401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','1','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','1',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle"','2','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','2',NULL,'Middle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','4','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','5','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','5',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','6','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','6',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','7','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','7',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','8','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','8',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','9','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','10','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','11','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','12','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','13','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Gross Compensation (all wages)"','14','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','14',NULL,'Pay Period Gross Compensation (all wages)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Employee Pre-Tax Deferral"','15','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','15',NULL,'Pay Period Employee Pre-Tax Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Employee Roth Contribution"','16','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','16',NULL,'Pay Period Employee Roth Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Safe Harbor Match"','17','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','17',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Loan Payments"','18','(''DA''=''T,'')','EROMRSI401Z0','50','H','01','18',NULL,'Pay Period Loan Payments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Hours Worked"','19','(''DA''=''T'')','EROMRSI401Z0','50','H','01','19',NULL,'Pay Period Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','1','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','1',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','2','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','2',NULL,'Middle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','5','(''UD101''=''T,'')','EROMRSI401Z0','50','D','10','5',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','6','(''UD101''=''T,'')','EROMRSI401Z0','50','D','10','6',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvdateOfTermination"','7','(''UD101''=''T,'')','EROMRSI401Z0','50','D','10','7',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','8','(''UD101''=''T,'')','EROMRSI401Z0','50','D','10','8',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','EROMRSI401Z0','50','D','10','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodGrossComp"','14','(''UNT2''=''T,'')','EROMRSI401Z0','50','D','10','14',NULL,'Pay Period Gross Compensation (all wages)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodPreTaxDef"','15','(''UNT2''=''T,'')','EROMRSI401Z0','50','D','10','15',NULL,'Pay Period Employee Pre-Tax Deferral',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodEERothCont"','16','(''UNT2''=''T,'')','EROMRSI401Z0','50','D','10','16',NULL,'Pay Period Employee Roth Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSafeHarborMatch"','17','(''UNT2''=''T,'')','EROMRSI401Z0','50','D','10','17',NULL,'Safe Harbor Match',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodLoanPayments"','18','(''UNT2''=''T,'')','EROMRSI401Z0','50','D','10','18',NULL,'Pay Period Loan Payments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodHoursWorked"','19','(''UNT2''=''T,'')','EROMRSI401Z0','50','D','10','19',NULL,'Pay Period Hours Worked',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EROMRSI401_20190725.txt',NULL,'','','',NULL,NULL,NULL,'RSI401k','201907199','EMPEXPORT','ONDEMAND','Jul 25 2019  4:51PM','EROMRSI401',NULL,NULL,NULL,'201907199','Jul 19 2019 12:00AM','Dec 30 1899 12:00AM','201907121','205','','','201907121',dbo.fn_GetTimedKey(),NULL,'US3MLAROM1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EROMRSI401_20190725.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201907229','EMPEXPORT','SCHEDULED','Jul 24 2019 12:49PM','EROMRSI401',NULL,NULL,NULL,'201907229','Jul 22 2019 12:00AM','Dec 30 1899 12:00AM','201907121','206','','','201907121',dbo.fn_GetTimedKey(),NULL,'US3MLAROM1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EROMRSI401_20190725.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201907269','EMPEXPORT','TEST','Jul 25 2019 12:42PM','EROMRSI401',NULL,NULL,NULL,'201907269','Jul 26 2019 12:00AM','Dec 30 1899 12:00AM','201907261','205','','','201907261',dbo.fn_GetTimedKey(),NULL,'us3lKiROM1001',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EROMRSI401_20190725.txt' END WHERE expFormatCode = 'EROMRSI401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROMRSI401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROMRSI401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROMRSI401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROMRSI401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROMRSI401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EROMRSI401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EROMRSI401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EROMRSI401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EROMRSI401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROMRSI401','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROMRSI401','D10','dbo.U_EROMRSI401_drvTbl',NULL);
IF OBJECT_ID('U_EROMRSI401_DedList') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EROMRSI401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvdateOfTermination] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvAddressLine1] varchar(30) NULL,
    [drvAddressLine2] varchar(30) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(9) NULL,
    [drvPayPeriodGrossComp] numeric NULL,
    [drvPayPeriodPreTaxDef] money NULL,
    [drvPayPeriodEERothCont] money NULL,
    [drvSafeHarborMatch] money NULL,
    [drvPayPeriodLoanPayments] money NULL,
    [drvPayPeriodHoursWorked] decimal NULL
);
IF OBJECT_ID('U_EROMRSI401_EEList') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EROMRSI401_File') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EROMRSI401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(6) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [PdhSource1] numeric NULL
);
IF OBJECT_ID('U_EROMRSI401_PDedHist_2') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_PDedHist_2] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL
);
IF OBJECT_ID('U_EROMRSI401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EROMRSI401_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROMRSI401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Romanoff Floor Covering, Inc.

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 07/22/2019
Service Request Number: SR-2019-00241784

Purpose: RSI401k

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EROMRSI401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EROMRSI401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EROMRSI401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EROMRSI401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EROMRSI401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROMRSI401', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EROMRSI401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EROMRSI401';

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
    DELETE FROM dbo.U_EROMRSI401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EROMRSI401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401P,401CF,4CUP,401M,401R,401RC,KLN1,KLN2,KLN3';


    IF OBJECT_ID('U_EROMRSI401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EROMRSI401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EROMRSI401_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EROMRSI401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EROMRSI401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource     = CASE WHEN PdhDedCode IN ('401F', '401P', '401CF', '4CUP') THEN 'DS'
                            WHEN PdhDedCode IN ('401R', '401RC') THEN 'ROTH'
                            WHEN PdhDedCode IN ('KLN1', 'KLN2', 'KLN3') THEN 'PLAN1' 
                            WHEN PdhDedCode IN ('401M') THEN 'SMATCH' 
                        END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EROMRSI401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PdhDedCode IN ('401F','401P','401CF','4CUP','401M','401R','401RC','KLN1', 'KLN2', 'KLN3')
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401F', '401P', '401CF', '4CUP') THEN 'DS'
                            WHEN PdhDedCode IN ('401R', '401RC') THEN 'ROTH'
                            WHEN PdhDedCode IN ('KLN1', 'KLN2', 'KLN3') THEN 'PLAN1' 
                            WHEN PdhDedCode IN ('401M') THEN 'SMATCH' 
                        END
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EROMRSI401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EROMRSI401_PEarHist;
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
    INTO dbo.U_EROMRSI401_PEarHist
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
    -- DETAIL RECORD - U_EROMRSI401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EROMRSI401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EROMRSI401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSSN = eepSSN
        ,drvDateofBirth = EepDateOfBirth
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvdateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = EecDateOfLastHire
        ,drvAddressLine1 = LEFT(EepAddressLine1,30)
        ,drvAddressLine2 = LEFT(EepAddressLine2,30)
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode,9)
        ,drvPayPeriodGrossComp = PehCurAmt
        ,drvPayPeriodPreTaxDef = DSSoure
        ,drvPayPeriodEERothCont = ROTH
        ,drvSafeHarborMatch = SMATCH
        ,drvPayPeriodLoanPayments = PLAN1
        ,drvPayPeriodHoursWorked = PehCurHrs
    INTO dbo.U_EROMRSI401_drvTbl
    FROM dbo.U_EROMRSI401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    INNER JOIN dbo.U_EROMRSI401_PEarHist WITH (NOLOCK)
            ON PehEEID = xEEID
    INNER JOIN (
        Select PdhEEID as SourceEEId
            ,DSSoure = (SUM (CASE WHEN PDHSource = 'DS' then pdheeCurAmt END))
            ,ROTH = (SUM (CASE WHEN PDHSource = 'ROTH' then pdheeCurAmt END))
            ,SMATCH = (SUM (CASE WHEN PDHSource = 'SMATCH' then pdherCurAmt END))
            ,PLAN1 = (SUM (CASE WHEN PDHSource = 'PLAN1' then PdhEECurAmt END))
     FROM U_EROMRSI401_PDedHist
    GROUP BY PdhEEID) as DedHistSource
    ON SourceEEId =  xEEID



    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'ETEST12345_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ETEST12345_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEROMRSI401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EROMRSI401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EROMRSI401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201907151'
       ,expStartPerControl     = '201907151'
       ,expLastEndPerControl   = '201907229'
       ,expEndPerControl       = '201907229'
WHERE expFormatCode = 'EROMRSI401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEROMRSI401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EROMRSI401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort