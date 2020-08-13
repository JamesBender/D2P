SET NOCOUNT ON;
IF OBJECT_ID('U_EIGOEFSAEL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIGOEFSAEL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIGOEFSAEL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIGOEFSAEL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIGOEFSAEL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIGOEFSAEL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIGOEFSAEL];
GO
IF OBJECT_ID('U_EIGOEFSAEL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_PEarHist];
GO
IF OBJECT_ID('U_EIGOEFSAEL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_PDedHist];
GO
IF OBJECT_ID('U_EIGOEFSAEL_File') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_File];
GO
IF OBJECT_ID('U_EIGOEFSAEL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_EEList];
GO
IF OBJECT_ID('U_EIGOEFSAEL_drvTbl_IC') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_drvTbl_IC];
GO
IF OBJECT_ID('U_EIGOEFSAEL_drvTbl_IB') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_drvTbl_IB];
GO
IF OBJECT_ID('U_EIGOEFSAEL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_DedList];
GO
IF OBJECT_ID('U_EIGOEFSAEL_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_AuditFields];
GO
IF OBJECT_ID('U_EIGOEFSAEL_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIGOEFSAEL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIGOEFSAEL];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIGOEFSAEL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIGOEFSAEL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIGOEFSAEL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIGOEFSAEL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIGOEFSAEL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIGOEFSAEL','Igoe FSA Eligibility','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EIGOEFSAELZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IB"','1','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IGOTAETEC"','2','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','10','2',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','4','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','4',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','5',NULL,'Social Security',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','8',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSatus"','14','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','14',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminatedDate"','15','(''UD101''=''T,'')','EIGOEFSAELZ0','50','D','10','15',NULL,'Terminated Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','16','(''UD101''=''T,'')','EIGOEFSAELZ0','50','D','10','16',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','17','(''UD101''=''T,'')','EIGOEFSAELZ0','50','D','10','17',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','18','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','18',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','19','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','10','19',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','10','20',NULL,'Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T'')','EIGOEFSAELZ0','50','D','10','21',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IC"','1','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IGOTAETEC"','2','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','20','2',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','4','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','4',NULL,'Event Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','5','(''UD101''=''T,'')','EIGOEFSAELZ0','50','D','20','5',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId"','6','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','6',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountType"','7','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','7',NULL,'Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','20','8',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePerPayAmt"','9','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','9',NULL,'Employee Per Pay Period Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerPerPayAmt"','10','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','10',NULL,'Employer Per Pay Period Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanStartDate"','11','(''UD101''=''T,'')','EIGOEFSAELZ0','50','D','20','11',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','20','12',NULL,'Blank Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','EIGOEFSAELZ0','50','D','20','13',NULL,'Payroll Mode ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','14','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','14',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drPlanDropDate"','15','(''UD101''=''T,'')','EIGOEFSAELZ0','50','D','20','15',NULL,'Plan Drop Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAnnualElect"','16','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','16',NULL,'Employee Annual Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerAnnualElect"','17','(''UA''=''T,'')','EIGOEFSAELZ0','50','D','20','17',NULL,'Employer Annual Election',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIGOEFSAEL_20200617.txt',NULL,'','','',NULL,NULL,NULL,'Igoe FSA Eligibility','202005189','EMPEXPORT','ONDEMAND','May 26 2020 12:28PM','EIGOEFSAEL',NULL,NULL,NULL,'202005189','May 18 2020 11:08AM','May 18 2020 11:08AM','202001011','408','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIGOEFSAEL_20200617.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202005189','EMPEXPORT','SCHEDULED','May 26 2020 12:29PM','EIGOEFSAEL',NULL,NULL,NULL,'202005189','May 18 2020 11:08AM','May 18 2020 11:08AM','202001011','408','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIGOEFSAEL_20200617.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202005189','EMPEXPORT','OEACTIVE','May 26 2020 12:27PM','EIGOEFSAEL',NULL,NULL,NULL,'202005189','May 18 2020 11:08AM','May 18 2020 11:08AM','202001011','408','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIGOEFSAEL_20200617.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202005189','EMPEXPORT','OEPASSIVE','May 26 2020 12:27PM','EIGOEFSAEL',NULL,NULL,NULL,'202005189','May 18 2020 11:08AM','May 18 2020 11:08AM','202001011','408','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIGOEFSAEL_20200617.txt',NULL,'','','X1BG1,X1BTF',NULL,NULL,NULL,'Test Purposes Only','202006041','EMPEXPORT','TEST','Jun 17 2020  1:44PM','EIGOEFSAEL',NULL,NULL,NULL,'202006041','Jun  4 2020 12:00AM','Dec 30 1899 12:00AM','202005211','378','','','202005211',dbo.fn_GetTimedKey(),NULL,'us3cPeTRI1021',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EIGOEFSAEL_20200617.txt' END WHERE expFormatCode = 'EIGOEFSAEL';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIGOEFSAEL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIGOEFSAEL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIGOEFSAEL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIGOEFSAEL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIGOEFSAEL','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EIGOEFSAEL' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIGOEFSAEL' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EIGOEFSAEL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIGOEFSAEL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIGOEFSAEL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIGOEFSAEL','D10','dbo.U_EIGOEFSAEL_drvTbl_IB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIGOEFSAEL','D20','dbo.U_EIGOEFSAEL_drvTbl_IC',NULL);
IF OBJECT_ID('U_dsi_BDM_EIGOEFSAEL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIGOEFSAEL] (
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
IF OBJECT_ID('U_EIGOEFSAEL_Audit') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_Audit] (
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
IF OBJECT_ID('U_EIGOEFSAEL_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EIGOEFSAEL_DedList') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EIGOEFSAEL_drvTbl_IB') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_drvTbl_IB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeID] char(11) NULL,
    [drvEventType] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSatus] char(1) NULL,
    [drvTerminatedDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL
);
IF OBJECT_ID('U_EIGOEFSAEL_drvTbl_IC') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_drvTbl_IC] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeID] char(11) NULL,
    [drvEventType] varchar(9) NOT NULL,
    [drvEffectiveDate] datetime NULL,
    [drvPlanId] varchar(3) NULL,
    [drvAccountType] varchar(3) NULL,
    [drvEmployeePerPayAmt] money NULL,
    [drvEmployerPerPayAmt] money NULL,
    [drvPlanStartDate] datetime NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drPlanDropDate] datetime NULL,
    [drvEmployeeAnnualElect] money NULL,
    [drvEmployerAnnualElect] varchar(6) NULL
);
IF OBJECT_ID('U_EIGOEFSAEL_EEList') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIGOEFSAEL_File') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EIGOEFSAEL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_PDedHist] (
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
IF OBJECT_ID('U_EIGOEFSAEL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIGOEFSAEL_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIGOEFSAEL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Tae Tech

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 05/18/2020
Service Request Number: TekP-2020-04-29-0001

Purpose: Igoe FSA Eligibility

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIGOEFSAEL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIGOEFSAEL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIGOEFSAEL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIGOEFSAEL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIGOEFSAEL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIGOEFSAEL', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIGOEFSAEL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIGOEFSAEL', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIGOEFSAEL';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIGOEFSAEL', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EIGOEFSAEL';
    SELECT @FileMinCovDate = '4/1/2020'

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
    DELETE FROM dbo.U_EIGOEFSAEL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIGOEFSAEL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);




    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EIGOEFSAEL_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_AuditFields;
    CREATE TABLE dbo.U_EIGOEFSAEL_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empcomp','eecEmplStatus');   


    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameLast');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameFirst');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameMiddle');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameAddressLine1');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameAddressLine2');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameAddressCity');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameAddressState');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepNameAddressZipCode'); 
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepDateOfBirth'); 
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepAddressEmail'); 
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('empPers','eepEepPhoneHomeNumber');   



    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('EmpHDed','EdhEEAmt');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('EmpHDed','EdhEEGoalAmt');   
    INSERT INTO dbo.U_EIGOEFSAEL_AuditFields VALUES ('EmpHDed','EdhBenStartDate');   



    -- Create audit table
    IF OBJECT_ID('U_EIGOEFSAEL_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_Audit;
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
    INTO dbo.U_EIGOEFSAEL_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EIGOEFSAEL_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EIGOEFSAEL_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIGOEFSAEL_Audit ON dbo.U_EIGOEFSAEL_Audit (audKey1Value, audKey2Value);












    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,DEP';

    IF OBJECT_ID('U_EIGOEFSAEL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIGOEFSAEL_DedList
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
    IF OBJECT_ID('U_EIGOEFSAEL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EIGOEFSAEL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIGOEFSAEL_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIGOEFSAEL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_PEarHist;
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
    INTO dbo.U_EIGOEFSAEL_PEarHist
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
    -- DETAIL RECORD - U_EIGOEFSAEL_drvTbl_IB
    ---------------------------------
    IF OBJECT_ID('U_EIGOEFSAEL_drvTbl_IB','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_drvTbl_IB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' A'
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EepSSN
        ,drvEventType =    CASE WHEN statNewValue = 'T' THEN 'TERM'
                            WHEN statNewValue = 'L' THEN 'LOA'
                            WHEN Bdm_Start_EEID IS NOT NULL AND BdmBenStopDate IS NULL THEN 'NEW' -- AND start is in range for file AND not have a stop date is NOT in range of file AND start > stop IF they have one, else re-enroll
                            WHEN statNewValue = 'A' AND statOldValue = 'L' AND Bdm_Start_EEID IS NOT NULL THEN 'RE-ENROLL'
                            WHEN DemoEEID IS NOT NULL THEN 'DEMOG'
                            --WHEN Bdm_Start_EEID IS NOT NULL AND BdmBenStopDate IS NULL THEN 'NEW' -- AND start is in range for file AND not have a stop date is NOT in range of file AND start > stop IF they have one, else re-enroll
                            WHEN Bdm_Chg_EEID IS NOT NULL THEN 'COVERAGE'
                            ELSE ''
                        END
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvSatus = EecEmplStatus
        ,drvTerminatedDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvHireDate = EecDateOfLastHire
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressEmail = EepAddressEMail
        ,drvPhoneNumber = EepPhoneHomeNumber
    INTO dbo.U_EIGOEFSAEL_drvTbl_IB
    FROM dbo.U_EIGOEFSAEL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EIGOEFSAEL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT DISTINCT audKey1Value AS DemoEEID
                FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                WHERE audTableName = 'EmpPers') AS Demo_Update
        ON DemoEEID = xEEID
    LEFT JOIN (SELECT statEEID, statCOID, statOldValue, statNewValue, statChgDate
                FROM (
                        SELECT audKey1Value AS statEEID
                            ,audKey2Value AS statCOID
                            ,audOldValue AS statOldValue
                            ,audNewValue AS statNewValue
                            ,audDateTime AS statChgDate
                            ,ROW_NUMBER() OVER(PARTITION BY audKey1Value, audKey2Value, audOldValue, audNewValue ORDER BY audDateTime DESC) AS RN
                            FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                            WHERE audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus') AS Stat_Raw
                WHERE RN = 1) AS EmpSatusChg    
        ON statEEID = xEEID
        AND statCOID = xCOID
    LEFT JOIN (
                SELECT DISTINCT audKey1Value AS Bdm_Chg_EEID, audKey2Value AS Bdm_Chg_COID
                FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                    WHERE audTableName = 'EmpHDed' AND audFieldName IN ('EdhEEAmt','EdhEEGoalAmt')) AS Bdm_Chg
        ON Bdm_Chg_EEID = xEEID
        AND Bdm_Chg_COID = xCOID

    LEFT JOIN (
                SELECT DISTINCT audKey1Value AS Bdm_Start_EEID, audKey2Value AS Bdm_Start_COID
                FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                    WHERE audTableName = 'EmpHDed' AND audFieldName IN ('EdhBenStartDate')) AS Bdm_Start
        ON Bdm_Start_EEID = xEEID
        AND Bdm_Start_COID = xCOID
        --,'EdBenStartDate'
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EIGOEFSAEL_drvTbl_IC
    ---------------------------------
    IF OBJECT_ID('U_EIGOEFSAEL_drvTbl_IC','U') IS NOT NULL
        DROP TABLE dbo.U_EIGOEFSAEL_drvTbl_IC;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' B'
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EepSSN
        ,drvEventType =    CASE WHEN statNewValue = 'T' THEN 'TERM'
                            WHEN statNewValue = 'L' THEN 'LOA'
                            WHEN Bdm_Start_EEID IS NOT NULL AND BdmBenStopDate IS NULL THEN 'NEW' -- AND start is in range for file AND not have a stop date is NOT in range of file AND start > stop IF they have one, else re-enroll
                            WHEN statNewValue = 'A' AND statOldValue = 'L' AND Bdm_Start_EEID IS NOT NULL THEN 'RE-ENROLL'
                            WHEN DemoEEID IS NOT NULL THEN 'DEMOG'
                            --WHEN Bdm_Start_EEID IS NOT NULL AND BdmBenStopDate IS NULL THEN 'NEW' -- AND start is in range for file AND not have a stop date is NOT in range of file AND start > stop IF they have one, else re-enroll
                            WHEN Bdm_Chg_EEID IS NOT NULL THEN 'COVERAGE'
                            ELSE ''
                        END
        ,drvEffectiveDate =    
                                CASE WHEN statNewValue = 'T' THEN  dbo.dsi_fnGetMinMaxDates('MAX',EecDateOfTermination, @FileMinCovDate)
                                    WHEN statNewValue IN ('L', 'A')  THEN dbo.dsi_fnGetMinMaxDates('MAX',EecEmplStatusStartDate, @FileMinCovDate)
                                    
                                    --WHEN EecEmplStatus IN ('L', 'A') THEN 'C' -- THEN EecEmplStatusStartDate
                                    WHEN EecEmplStatus IN ('L')  THEN EecEmplStatusStartDate
                                    
                                    --WHEN Bdm_Chg_EEID IS NOT NULL THEN  dbo.dsi_fnGetMinMaxDates('MAX',GETDATE(), @FileMinCovDate)
                                    WHEN Bdm_Chg_EEID IS NOT NULL THEN  dbo.dsi_fnGetMinMaxDates('MAX',Bdm_Chg_DateTime, @FileMinCovDate)
                                    WHEN BdmBenStartDate IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
                                    WHEN BdmBenStopDate IS NOT NULL THEN  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStopDate, @FileMinCovDate)
                                END 
        ,drvPlanId =    CASE WHEN BdmDedCode IN ('FSA') THEN 'MED'
                            WHEN BdmDedCode IN ('DEP') THEN 'DCA'
                        END
        ,drvAccountType =    CASE WHEN BdmDedCode IN ('FSA') THEN 'FSA'
                                WHEN BdmDedCode IN ('DEP') THEN 'DCA'
                            END
        ,drvEmployeePerPayAmt = BdmEEAmt
        ,drvEmployerPerPayAmt = EedERLstAmt
        ,drvPlanStartDate = CAST('4/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) AS DATETIME)
        ,drvStatus = CASE WHEN ISNULL(BdmBenStopDate, '') <>  '' THEN 'T' ELSE 'A' END
        ,drPlanDropDate = BdmBenStopDate
        ,drvEmployeeAnnualElect = BdmEEGoalAmt
        ,drvEmployerAnnualElect = CASE WHEN BdmDedCode = 'FSA' THEN '500.00' END
    INTO dbo.U_EIGOEFSAEL_drvTbl_IC
    FROM dbo.U_EIGOEFSAEL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EIGOEFSAEL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT DISTINCT audKey1Value AS DemoEEID
                FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                WHERE audTableName = 'EmpPers') AS Demo_Update
        ON DemoEEID = xEEID
    LEFT JOIN (
                SELECT EedEEID, EedCoID, EedDedCode, EedERLstAmt 
                FROM dbo.EmpDed WITH (NOLOCK) 
                WHERE EedDedCode IN ('FSA', 'DEP') AND EedBenStatus = 'A'
            ) AS Amounts
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedDedCode = BdmDedCode
    LEFT JOIN (SELECT statEEID, statCOID, statOldValue, statNewValue, statChgDate
                FROM (
                        SELECT audKey1Value AS statEEID
                            ,audKey2Value AS statCOID
                            ,audOldValue AS statOldValue
                            ,audNewValue AS statNewValue
                            ,audDateTime AS statChgDate
                            ,ROW_NUMBER() OVER(PARTITION BY audKey1Value, audKey2Value, audOldValue, audNewValue ORDER BY audDateTime DESC) AS RN
                            FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                            WHERE audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus') AS Stat_Raw
                WHERE RN = 1) AS EmpSatusChg    
        ON statEEID = xEEID
        AND statCOID = xCOID
    LEFT JOIN (
                SELECT   DISTINCT audKey1Value AS Bdm_Chg_EEID, audKey2Value AS Bdm_Chg_COID, audDateTime AS Bdm_Chg_DateTime
FROM (
SELECT *
                FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                    WHERE audTableName = 'EmpHDed' AND audFieldName IN ('EdhEEAmt','EdhEEGoalAmt') AND AudKey3Value = 'FSA') AS T
                    Where AudRowNo = 1) AS Bdm_Chg
        ON Bdm_Chg_EEID = xEEID
        AND Bdm_Chg_COID = xCOID

    LEFT JOIN (
                SELECT DISTINCT audKey1Value AS Bdm_Start_EEID, audKey2Value AS Bdm_Start_COID
                FROM dbo.U_EIGOEFSAEL_Audit WITH (NOLOCK)
                    WHERE audTableName = 'EmpHDed' AND audFieldName IN ('EdhBenStartDate')) AS Bdm_Start
        ON Bdm_Start_EEID = xEEID
        AND Bdm_Start_COID = xCOID
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
ALTER VIEW dbo.dsi_vwEIGOEFSAEL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIGOEFSAEL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIGOEFSAEL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202005189'
       ,expEndPerControl       = '202005189'
WHERE expFormatCode = 'EIGOEFSAEL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIGOEFSAEL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIGOEFSAEL_File (NOLOCK)
    ORDER BY InitialSort, SubSort;