SET NOCOUNT ON;
IF OBJECT_ID('U_EIOGEFSAEL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIOGEFSAEL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIOGEFSAEL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIOGEFSAEL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIOGEFSAEL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIOGEFSAEL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIOGEFSAEL];
GO
IF OBJECT_ID('U_EIOGEFSAEL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_PEarHist];
GO
IF OBJECT_ID('U_EIOGEFSAEL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_PDedHist];
GO
IF OBJECT_ID('U_EIOGEFSAEL_File') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_File];
GO
IF OBJECT_ID('U_EIOGEFSAEL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_EEList];
GO
IF OBJECT_ID('U_EIOGEFSAEL_drvTbl_IC') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_drvTbl_IC];
GO
IF OBJECT_ID('U_EIOGEFSAEL_drvTbl_IB') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_drvTbl_IB];
GO
IF OBJECT_ID('U_EIOGEFSAEL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EIOGEFSAEL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIOGEFSAEL];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIOGEFSAEL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIOGEFSAEL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIOGEFSAEL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIOGEFSAEL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIOGEFSAEL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIOGEFSAEL','Igoe FSA Eligability Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EIOGEFSAELZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IB"','1','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','10','1',NULL,'Record Identifier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IGOTENDERG"','2','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','10','2',NULL,'Employer ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','3','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','3',NULL,'Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','4','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','10','4',NULL,'Event Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','5','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','5',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','6',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','7',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','8','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','8',NULL,'MI ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','9',NULL,'Address 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','10',NULL,'Address 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','11',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','12',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','13','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','13',NULL,'Zip ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','14','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','14',NULL,'Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','15','(''UD101''=''T,'')','EIOGEFSAELZ0','50','D','10','15',NULL,'Terminated Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','16','(''UD101''=''T,'')','EIOGEFSAELZ0','50','D','10','16',NULL,'Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','17','(''UD101''=''T,'')','EIOGEFSAELZ0','50','D','10','17',NULL,'Birth Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','18','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','10','18',NULL,'Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','10','19',NULL,'Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','10','20',NULL,'Cell Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','21','(''UA''=''T'')','EIOGEFSAELZ0','50','D','10','21',NULL,'Division ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IC"','1','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','20','1',NULL,'Record Identifier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IGOTENDERG"','2','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','20','2',NULL,'Employer ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','3','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','3',NULL,'Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','20','4',NULL,'Event Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','5','(''UD101''=''T,'')','EIOGEFSAELZ0','50','D','20','5',NULL,'Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId"','6','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','6',NULL,'Plan ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountType"','7','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','7',NULL,'Account Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','20','8',NULL,'Blank Field ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplPerPayPerAmt"','9','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','9',NULL,'Employee Per Pay Period Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmprPerPayPerAmt"','10','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','10',NULL,'Employer Per Pay Period Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanStartDate"','11','(''UD101''=''T,'')','EIOGEFSAELZ0','50','D','20','11',NULL,'Plan Start Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EIOGEFSAELZ0','50','D','20','12',NULL,'Blank Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollModeId"','13','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','13',NULL,'Payroll Mode ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','14','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','14',NULL,'Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanDropDate"','15','(''UD101''=''T,'')','EIOGEFSAELZ0','50','D','20','15',NULL,'Plan Drop Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplAnnElection"','16','(''UA''=''T,'')','EIOGEFSAELZ0','50','D','20','16',NULL,'Employee Annual Election ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T'')','EIOGEFSAELZ0','50','D','20','17',NULL,'Employer Annual Election ',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIOGEFSAEL_20200311.txt',NULL,'','','',NULL,NULL,NULL,'Igoe FSA Eligability Export','202001319','EMPEXPORT','ONDEMAND','Jan 13 2020 11:48AM','EIOGEFSAEL',NULL,NULL,NULL,'202001319','Jan  7 2020  5:07AM','Jan  7 2020  5:07AM','202001011','144','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIOGEFSAEL_20200311.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202001319','EMPEXPORT','SCHEDULED','Jan 13 2020 11:48AM','EIOGEFSAEL',NULL,NULL,NULL,'202001319','Jan  7 2020  5:07AM','Jan  7 2020  5:07AM','202001011','144','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIOGEFSAEL_20200311.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001319','EMPEXPORT','OEACTIVE','Jan 13 2020 11:47AM','EIOGEFSAEL',NULL,NULL,NULL,'202001319','Jan  7 2020  5:07AM','Jan  7 2020  5:07AM','202001011','135','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIOGEFSAEL_20200311.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001319','EMPEXPORT','OEPASSIVE','Jan 13 2020 11:48AM','EIOGEFSAEL',NULL,NULL,NULL,'202001319','Jan  7 2020  5:07AM','Jan  7 2020  5:07AM','202001011','137','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIOGEFSAEL_20200311.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003029','EMPEXPORT','TEST','Mar  2 2020  9:13AM','EIOGEFSAEL',NULL,NULL,NULL,'202003029','Mar  2 2020 12:00AM','Dec 30 1899 12:00AM','202002171','147','','','202002171',dbo.fn_GetTimedKey(),NULL,'US3LKITEN1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EIOGEFSAEL_20200311.txt' END WHERE expFormatCode = 'EIOGEFSAEL';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIOGEFSAEL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIOGEFSAEL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIOGEFSAEL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIOGEFSAEL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIOGEFSAEL','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EIOGEFSAEL' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIOGEFSAEL' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EIOGEFSAEL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIOGEFSAEL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIOGEFSAEL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIOGEFSAEL','D10','dbo.U_EIOGEFSAEL_drvTbl_IB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIOGEFSAEL','D20','dbo.U_EIOGEFSAEL_drvTbl_IC',NULL);
IF OBJECT_ID('U_dsi_BDM_EIOGEFSAEL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIOGEFSAEL] (
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
IF OBJECT_ID('U_EIOGEFSAEL_DedList') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EIOGEFSAEL_drvTbl_IB') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_drvTbl_IB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpId] char(11) NULL,
    [drvSsn] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvEmplStatus] char(1) NULL,
    [drvTermDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvDivision] varchar(25) NULL
);
IF OBJECT_ID('U_EIOGEFSAEL_drvTbl_IC') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_drvTbl_IC] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(209) NULL,
    [drvEmpId] char(11) NULL,
    [drvEffDate] datetime NULL,
    [drvPlanId] varchar(3) NULL,
    [drvAccountType] varchar(3) NULL,
    [drvEmplPerPayPerAmt] money NULL,
    [drvEmprPerPayPerAmt] nvarchar(4000) NULL,
    [drvPlanStartDate] datetime NULL,
    [drvPayrollModeId] varchar(11) NOT NULL,
    [drvStatus] char(1) NULL,
    [drvPlanDropDate] datetime NULL,
    [drvEmplAnnElection] money NULL
);
IF OBJECT_ID('U_EIOGEFSAEL_EEList') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIOGEFSAEL_File') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EIOGEFSAEL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSADCAmount] numeric NULL,
    [PdhHSATMAmount] numeric NULL,
    [PdhHSAT2Amount] numeric NULL,
    [PdhHSATCAmount] numeric NULL,
    [PdhHSTCAmount] numeric NULL,
    [PdhHSAFAAmount] numeric NULL,
    [PdhHSAF2Amount] numeric NULL,
    [PdhHSAFCAmount] numeric NULL,
    [PdhHSFCAmount] numeric NULL,
    [PdhLPFSAAmount] numeric NULL,
    [PdhFSAAmount] numeric NULL,
    [PdhPARKAmount] numeric NULL,
    [PdhCMMTRAmount] numeric NULL
);
IF OBJECT_ID('U_EIOGEFSAEL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIOGEFSAEL_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIOGEFSAEL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Tender Greens

Created By: James Bender
Business Analyst: Lea King
Create Date: 01/07/2020
Service Request Number: TekP-2019-11-20-0004

Purpose: Igoe FSA Eligability Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIOGEFSAEL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIOGEFSAEL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIOGEFSAEL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIOGEFSAEL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIOGEFSAEL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIOGEFSAEL', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIOGEFSAEL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIOGEFSAEL', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIOGEFSAEL';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIOGEFSAEL', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EIOGEFSAEL';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('1/1/2020' AS DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EIOGEFSAEL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIOGEFSAEL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FASDC,HSATM,HSAT2,HSATC,HSTC,HSAFA,HSAF2,HSAFC,HSFC,LPFSA,FSA,PARK,CMMTR,FSADC';

    IF OBJECT_ID('U_EIOGEFSAEL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIOGEFSAEL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIOGEFSAEL_DedList
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
    IF OBJECT_ID('U_EIOGEFSAEL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIOGEFSAEL_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFSADCAmount = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSATMAmount = SUM(CASE WHEN PdhDedCode IN ('HSATM') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSAT2Amount = SUM(CASE WHEN PdhDedCode IN ('HSAT2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSATCAmount = SUM(CASE WHEN PdhDedCode IN ('HSATC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSTCAmount = SUM(CASE WHEN PdhDedCode IN ('HSTC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSAFAAmount = SUM(CASE WHEN PdhDedCode IN ('HSAFA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSAF2Amount = SUM(CASE WHEN PdhDedCode IN ('HSAF2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSAFCAmount = SUM(CASE WHEN PdhDedCode IN ('HSAFC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSFCAmount = SUM(CASE WHEN PdhDedCode IN ('HSFC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLPFSAAmount = SUM(CASE WHEN PdhDedCode IN ('LPFSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSAAmount = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhPARKAmount = SUM(CASE WHEN PdhDedCode IN ('PARK') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhCMMTRAmount = SUM(CASE WHEN PdhDedCode IN ('CMMTR') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EIOGEFSAEL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIOGEFSAEL_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIOGEFSAEL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIOGEFSAEL_PEarHist;
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
    INTO dbo.U_EIOGEFSAEL_PEarHist
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
    -- DETAIL RECORD - U_EIOGEFSAEL_drvTbl_IB
    ---------------------------------
    IF OBJECT_ID('U_EIOGEFSAEL_drvTbl_IB','U') IS NOT NULL
        DROP TABLE dbo.U_EIOGEFSAEL_drvTbl_IB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpId = eepSSN
        ,drvSsn = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddleInit = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvEmplStatus = EecEmplStatus
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvHireDate = EecDateOfLastHire
        ,drvDateOfBirth = EepDateOfBirth
        ,drvEmailAddress = eepAddressEmail
        ,drvDivision = LocDesc
    INTO dbo.U_EIOGEFSAEL_drvTbl_IB
    FROM dbo.U_EIOGEFSAEL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EIOGEFSAEL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIOGEFSAEL_drvTbl_IC
    ---------------------------------
    IF OBJECT_ID('U_EIOGEFSAEL_drvTbl_IC','U') IS NOT NULL
        DROP TABLE dbo.U_EIOGEFSAEL_drvTbl_IC;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepNameLast + ', ' + EepNameFirst + ', ' + BdmDedCode
         -- standard fields above and additional driver fields below
        ,drvEmpId = EepSsn
        ,drvEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvPlanId =    CASE WHEN BdmDedCode = 'FSADC' THEN 'DCA'
                            WHEN BdmDedCode in ('HSATM', 'HSAT2', 'HSATC', 'HSTC', 'HSAFA', 'HSAF2', 'HSAFC', 'HSFC') THEN 'HSA'
                            WHEN BdmDedCode = 'LPFSA' THEN 'LPF'
                            WHEN BdmDedCode = 'FSA' THEN 'MED'
                            WHEN BdmDedCode = 'PARK' THEN 'PKG'
                            WHEN BdmDedCode = 'CMMTR' THEN 'TRN'
                        END
        ,drvAccountType =    CASE WHEN BdmDedCode = 'FSADC' THEN 'DCA'
                                WHEN BdmDedCode IN ('HSATM', 'HSAT2', 'HSATC', 'HSTC', 'HSAFA', 'HSAF2', 'HSAFC', 'HSFC') THEN 'ABH'
                                WHEN BdmDedCode = 'LPFSA' THEN 'LPF'
                                WHEN BdmDedCode = 'FSA' THEN 'FSA'
                                WHEN BdmDedCode = 'PARK' THEN 'PKG'
                                WHEN BdmDedCode = 'CMMTR' THEN 'TRN'
                            END
        ,drvEmplPerPayPerAmt = BdmEEAmt
                                /*CASE BdmDedCode
                                    WHEN 'FSADC' THEN FORMAT(PdhFSADCAmount, '#.00')
                                    WHEN 'HSATM' THEN FORMAT(PdhHSATMAmount, '#.00')
                                    WHEN 'HSAT2' THEN FORMAT(PdhHSAT2Amount, '#.00')
                                    WHEN 'HSATC' THEN FORMAT(PdhHSATCAmount, '#.00')
                                    WHEN 'HSTC' THEN FORMAT(PdhHSTCAmount, '#.00')
                                    WHEN 'HSAFA' THEN FORMAT(PdhHSAFAAmount, '#.00')
                                    WHEN 'HSAF2' THEN FORMAT(PdhHSAF2Amount, '#.00')
                                    WHEN 'HSAFC' THEN FORMAT(PdhHSAFCAmount, '#.00')
                                    WHEN 'HSFC' THEN FORMAT(PdhHSFCAmount, '#.00')
                                    WHEN 'LPFSA' THEN FORMAT(PdhLPFSAAmount, '#.00')
                                    WHEN 'FSA' THEN FORMAT(PdhFSAAmount, '#.00')
                                    WHEN 'PARK' THEN FORMAT(PdhPARKAmount, '#.00')
                                    WHEN 'CMMTR' THEN FORMAT(PdhCMMTRAmount, '#.00') 
                                END*/
        ,drvEmprPerPayPerAmt = FORMAT(pdhERCurAmt, '#.00')
        ,drvPlanStartDate = BdmBenStartDate
        ,drvPayrollModeId =    CASE WHEN EecPayGroup = 'WKLY1' THEN 'IGOTENDER02' ELSE 'IGOTENDER01' END
                            /*CASE WHEN BdmDedCode IN ('PARK', 'CMMTR') THEN 'M01' 
                            ELSE
                                CASE WHEN EecPayGroup = 'WKLY1'  THEN 'IGOTENDER02'
                                    ELSE 'IGOTENDER01'
                                END
                            END*/
        ,drvStatus = EecEmplStatus
        ,drvPlanDropDate = BdmBenStopDate 
        ,drvEmplAnnElection =    CASE WHEN BdmDedCode IN ('PARK', 'CMMTR') THEN BdmEEAmt
                                     --FORMAT((SELECT SUM(PdhEECurAmt) FROM dbo.PDedHist WITH (NOLOCK) WHERE pdhEEID = xEEID AND LEFT(PdhPerControl, 4) = LEFT(@EndPerControl, 4) AND PdhPerControl <= @EndPerControl AND PdhDedCode = BdmDedCode), '#.00')
                                    /*CASE BdmDedCode
                                        WHEN 'PARK' THEN FORMAT(PdhPARKAmount, '#.00')
                                        WHEN 'CMMTR' THEN FORMAT(PdhCMMTRAmount, '#.00')
                                    END*/
                                ELSE FORMAT(BdmEEGoalAmt, '#.00')
                                END
    INTO dbo.U_EIOGEFSAEL_drvTbl_IC
    FROM dbo.U_EIOGEFSAEL_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EIOGEFSAEL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_EIOGEFSAEL_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEIOGEFSAEL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIOGEFSAEL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIOGEFSAEL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202001319'
       ,expEndPerControl       = '202001319'
WHERE expFormatCode = 'EIOGEFSAEL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIOGEFSAEL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIOGEFSAEL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort