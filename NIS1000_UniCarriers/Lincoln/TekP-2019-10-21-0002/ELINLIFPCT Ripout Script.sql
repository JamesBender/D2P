SET NOCOUNT ON;
IF OBJECT_ID('U_ELINLIFPCT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINLIFPCT_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINLIFPCT' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINLIFPCT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINLIFPCT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINLIFPCT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINLIFPCT];
GO
IF OBJECT_ID('U_ELINLIFPCT_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_PEarHist];
GO
IF OBJECT_ID('U_ELINLIFPCT_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_PDedHist];
GO
IF OBJECT_ID('U_ELINLIFPCT_Header') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_Header];
GO
IF OBJECT_ID('U_ELINLIFPCT_File') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_File];
GO
IF OBJECT_ID('U_ELINLIFPCT_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_EEList];
GO
IF OBJECT_ID('U_ELINLIFPCT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_drvTbl];
GO
IF OBJECT_ID('U_ELINLIFPCT_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_DedList];
GO
IF OBJECT_ID('U_ELINLIFPCT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_AuditFields];
GO
IF OBJECT_ID('U_ELINLIFPCT_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELINLIFPCT') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELINLIFPCT];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINLIFPCT';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINLIFPCT';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINLIFPCT';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINLIFPCT';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINLIFPCT';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINLIFPCT','Lincoln Life Port & Convert Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ELINLIFPCTZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"H"','1','(''DA''=''T|'')','ELINLIFPCTZ0','50','H','01','1',NULL,'Header Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"09-LF0171"','2','(''DA''=''T|'')','ELINLIFPCTZ0','50','H','01','2',NULL,'Customer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','3','(''UA''=''T|'')','ELINLIFPCTZ0','50','H','01','3',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','4','(''UD112''=''T'')','ELINLIFPCTZ0','50','H','01','4',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"09LF0171"','1','(''DA''=''T|'')','ELINLIFPCTZ0','50','D','10','1',NULL,'CustomerID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','2','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','2',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateOfBirth"','3','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','3',NULL,'Employee Birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGender"','4','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','4',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','5','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','5',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','6','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine1"','7','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','7',NULL,'Employee Mailing Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine2"','8','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','8',NULL,'Employee Mailing Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressCity"','9','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','9',NULL,'Employee Mailing City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressState"','10','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','10',NULL,'Employee Mailing State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressZipCode"','11','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','11',NULL,'Employee Mailing Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsuredFirstName"','12','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','12',NULL,'Insured First name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsuredLastName"','13','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','13',NULL,'Insured Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsuredGender"','14','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','14',NULL,'Insured Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsuredDateOfBirth"','15','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','15',NULL,'Insured Birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrpCovStartDate"','16','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','16',NULL,'Group Coverage Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTermDate"','17','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','17',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovTermDate"','18','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','18',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovTermReason"','19','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','19',NULL,'Coverage Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverType"','20','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','20',NULL,'Coverage Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverAmt"','21','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','21',NULL,'Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalEmail"','22','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','22',NULL,'Personal Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','23','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','23',NULL,'Emp ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPhone"','24','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','24',NULL,'Employee Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','25','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','25',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateEmpLastActivity"','26','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','26',NULL,'Date Employee Last Actively at Work',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplClass"','27','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','27',NULL,'Employee’s Class - LTD Plan Maximum Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpOnLeave"','28','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','28',NULL,'Is Employee on Leave of Absence?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLeaveStartDate"','29','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','29',NULL,'Leave of Absence Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRetired"','30','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','30',NULL,'Employee Retired?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRetiredDate"','31','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','31',NULL,'Date of Retirement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTitleAtTerm"','32','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','32',NULL,'Employee’s Occupation at time of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMonthEarnAtTerm"','33','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','33',NULL,'Employee’s Basic Monthly Earnings at time of Termi',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsYearLTDCovered"','34','(''UA''=''T|'')','ELINLIFPCTZ0','50','D','10','34',NULL,'12 consecutive months covered for LTD?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateOfHire"','35','(''UD112''=''T|'')','ELINLIFPCTZ0','50','D','10','35',NULL,'Employee Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMisc"','36','(''UA''=''T'')','ELINLIFPCTZ0','50','D','10','36',NULL,'Miscellaneous Fields',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINLIFPCT_20200211.txt',NULL,'','','',NULL,NULL,NULL,'Lincoln Life Port & Convert Ex','202001159','EMPEXPORT','ONDEMAND','Dec 10 2019 12:12PM','ELINLIFPCT',NULL,NULL,NULL,'202001159','Dec 10 2019  8:29AM','Dec 10 2019  8:29AM','201901011','131','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINLIFPCT_20200211.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202001159','EMPEXPORT','SCHEDULED','Dec 10 2019 12:13PM','ELINLIFPCT',NULL,NULL,NULL,'202001159','Dec 10 2019  8:29AM','Dec 10 2019  8:29AM','201901011','131','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINLIFPCT_20200211.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001159','EMPEXPORT','OEACTIVE','Dec 10 2019 12:11PM','ELINLIFPCT',NULL,NULL,NULL,'202001159','Dec 10 2019  8:29AM','Dec 10 2019  8:29AM','201901011','123','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINLIFPCT_20200211.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001159','EMPEXPORT','OEPASSIVE','Dec 10 2019 12:12PM','ELINLIFPCT',NULL,NULL,NULL,'202001159','Dec 10 2019  8:29AM','Dec 10 2019  8:29AM','201901011','123','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINLIFPCT_20200211.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202002069','EMPEXPORT','TEST','Feb  6 2020  9:50AM','ELINLIFPCT',NULL,NULL,NULL,'202002069','Feb  6 2020 12:00AM','Dec 30 1899 12:00AM','201910011','5','','','201910011',dbo.fn_GetTimedKey(),NULL,'us3lKiNIS1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELINLIFPCT_20200211.txt' END WHERE expFormatCode = 'ELINLIFPCT';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINLIFPCT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINLIFPCT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINLIFPCT','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINLIFPCT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINLIFPCT','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELINLIFPCT' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINLIFPCT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELINLIFPCT_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINLIFPCT_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINLIFPCT','H01','dbo.U_ELINLIFPCT_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINLIFPCT','D10','dbo.U_ELINLIFPCT_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ELINLIFPCT') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELINLIFPCT] (
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
IF OBJECT_ID('U_ELINLIFPCT_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELINLIFPCT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ELINLIFPCT_DedList') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELINLIFPCT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpDateOfBirth] datetime NULL,
    [drvEmpGender] char(1) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpAddressLine1] varchar(255) NULL,
    [drvEmpAddressLine2] varchar(255) NULL,
    [drvEmpAddressCity] varchar(255) NULL,
    [drvEmpAddressState] varchar(255) NULL,
    [drvEmpAddressZipCode] varchar(50) NULL,
    [drvInsuredFirstName] varchar(100) NULL,
    [drvInsuredLastName] varchar(100) NULL,
    [drvInsuredGender] varchar(1) NOT NULL,
    [drvInsuredDateOfBirth] datetime NULL,
    [drvGrpCovStartDate] varchar(1) NOT NULL,
    [drvEmpTermDate] datetime NULL,
    [drvCovTermDate] datetime NULL,
    [drvCovTermReason] varchar(1) NULL,
    [drvCoverType] varchar(2) NULL,
    [drvCoverAmt] nvarchar(4000) NULL,
    [drvPersonalEmail] varchar(50) NULL,
    [drvEmpId] varchar(1) NOT NULL,
    [drvEmpPhone] varchar(1) NOT NULL,
    [drvClass] varchar(1) NOT NULL,
    [drvDateEmpLastActivity] datetime NULL,
    [drvEmplClass] varchar(1) NOT NULL,
    [drvEmpOnLeave] varchar(1) NOT NULL,
    [drvEmpLeaveStartDate] varchar(1) NOT NULL,
    [drvEmpRetired] varchar(1) NOT NULL,
    [drvEmpRetiredDate] varchar(1) NOT NULL,
    [drvEmpTitleAtTerm] varchar(1) NOT NULL,
    [drvEmpMonthEarnAtTerm] varchar(1) NOT NULL,
    [drvIsYearLTDCovered] varchar(1) NOT NULL,
    [drvEmpDateOfHire] varchar(1) NOT NULL,
    [drvMisc] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELINLIFPCT_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINLIFPCT_File') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ELINLIFPCT_Header') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_Header] (
    [drvRecordCount] nvarchar(4000) NULL,
    [drvFileDate] nvarchar(4000) NULL
);
IF OBJECT_ID('U_ELINLIFPCT_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [pdh300Amt] numeric NULL,
    [pdhGLifeAmt] numeric NULL,
    [pdh310Amt] numeric NULL,
    [pdh321_322Amt] numeric NULL
);
IF OBJECT_ID('U_ELINLIFPCT_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELINLIFPCT_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINLIFPCT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UniCarriers

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/10/2019
Service Request Number: TekP-2019-10-10-0002

Purpose: Lincoln Life Port & Convert Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINLIFPCT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINLIFPCT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINLIFPCT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINLIFPCT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINLIFPCT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINLIFPCT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINLIFPCT', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINLIFPCT', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELINLIFPCT';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINLIFPCT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELINLIFPCT';

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
    DELETE FROM dbo.U_ELINLIFPCT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINLIFPCT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    /*DELETE FROM dbo.U_ELINLIFPCT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT DISTINCT EdhEEID 
                    FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhEffDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, edhDedCode ORDER BY EdhEffDate DESC) AS rn 
                        FROM EmpHDed
                        WHERE EdhDedCode IN ('300','310','321','322','GLIFE')) AS T WHERE rn = 1 AND EdhChangeReason = 'OE');*/


    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ELINLIFPCT_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_AuditFields;
    CREATE TABLE dbo.U_ELINLIFPCT_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_ELINLIFPCT_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELINLIFPCT_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
    INTO dbo.U_ELINLIFPCT_Audit
    FROM dbo.U_ELINLIFPCT_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ELINLIFPCT_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_ELINLIFPCT_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_ELINLIFPCT_DedList))
    );
    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ELINLIFPCT_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELINLIFPCT_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '300,310,321,322,GLIFE';

    IF OBJECT_ID('U_ELINLIFPCT_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINLIFPCT_DedList
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
    IF OBJECT_ID('U_ELINLIFPCT_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,pdh300Amt     = SUM(CASE WHEN PdhDedCode IN ('300') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhGLifeAmt     = SUM(CASE WHEN PdhDedCode IN ('GLIFE') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdh310Amt     = SUM(CASE WHEN PdhDedCode IN ('310') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdh321_322Amt     = SUM(CASE WHEN PdhDedCode IN ('321', '322') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ELINLIFPCT_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELINLIFPCT_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELINLIFPCT_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_PEarHist;
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
    INTO dbo.U_ELINLIFPCT_PEarHist
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
    -- DETAIL RECORD - U_ELINLIFPCT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINLIFPCT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpSSN = eepSSN
        ,drvEmpDateOfBirth = EepDateOfBirth
        ,drvEmpGender = EepGender
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpLastName = EepNameLast
        ,drvEmpAddressLine1 = EepAddressLine1
        ,drvEmpAddressLine2 = EepAddressLine2
        ,drvEmpAddressCity = EepAddressCity
        ,drvEmpAddressState = EepAddressState
        ,drvEmpAddressZipCode = EepAddressZipCode
        ,drvInsuredFirstName =    CASE WHEN bdmDedCode IN ('300', 'GLIFE') AND ISNULL(BdmBenStopDate, '') <> '' THEN EepNameFirst                                
                                    WHEN BdmDedCode IN ('310') AND ISNULL(BdmBenStopDate, '') <> '' THEN ConNameFirst
                                    WHEN BdmDedCode IN ('321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN ''
                                END
        ,drvInsuredLastName =    CASE WHEN bdmDedCode IN ('300', 'GLIFE') AND ISNULL(BdmBenStopDate, '') <> '' THEN EepNameLast
                                    WHEN BdmDedCode IN ('310') AND ISNULL(BdmBenStopDate, '') <> '' THEN ConNameLast 
                                    WHEN BdmDedCode IN ('321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN ''
                                END
        ,drvInsuredGender = '' 
        ,drvInsuredDateOfBirth =    CASE WHEN BdmDedCode IN ('300', 'GLIFE') AND ISNULL(BdmBenStopDate, '') <> '' THEN EepDateOfBirth 
                                        WHEN BdmDedCode IN  ('310') AND ISNULL(BdmBenStopDate, '') <> '' THEN ConDateOfBirth
                                        WHEN BdmDedCode in ('321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN null
                                    END
        ,drvGrpCovStartDate = ''
        ,drvEmpTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvCovTermDate =    CASE WHEN BdmDedCode IN ('300', 'GLIFE') AND ISNULL(BdmBenStopDate, '') <> '' THEN BdmBenStopDate 
                                WHEN BdmDedCode IN  ('310', '321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN BdmBenStopDate
                                WHEN BdmDedCode in ('321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN ''
                            END
                            --203, 202 
                            --210, 208, 302, LEVNT3, 204, LEVNT4, 202, 203, CHGRP
        ,drvCovTermReason =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203') THEN '3' -- JCB
                                WHEN EecEmplStatus <> 'T' AND EdhChangeReason IN ('210') THEN '3'
                                WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202') THEN '7'   
                                WHEN EecEmplStatus <> 'T' AND EdhChangeReason IN ('208') THEN '7'                             
                                WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('203', '202') THEN '1'
                                WHEN EecEmplStatus = 'L' AND ISNULL(bdmBenStopDate, '') <> '' THEN '9'
                                WHEN BdmDedCode IN ('310', '321', '322') AND BdmBenStatus IN ('T', 'C') AND EdhChangeReason IN ('201', '302', 'LEVNT3') THEN '4'
                                WHEN BdmDedCode IN ('310', '321', '322') AND BdmBenStatus IN ('T', 'C') AND EdhChangeReason IN ('204', 'LEVNT4') THEN '5'
                                WHEN EecEmplStatus <> 'T' AND EdhChangeReason IN ('202', '203', 'CHGRP') THEN '8'
                            END
        ,drvCoverType =    CASE WHEN BdmDedCode = '300' AND ISNULL(BdmBenStopDate, '') <> '' THEN 'OL'
                            WHEN BdmDedCode = 'GLIFE' AND ISNULL(BdmBenStopDate, '') <> '' THEN 'BL'
                            WHEN BdmDedCode = '310' AND ISNULL(BdmBenStopDate, '') <> '' THEN 'SL'
                            WHEN BdmDedCode IN ('321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN 'DL'                        
                        END
        
        ,drvCoverAmt =    CASE WHEN ISNULL(BdmBenStopDate, '') <> '' THEN FORMAT(
                            CASE WHEN (select EedBenAmt from dbo.U_dsi_BDM_EmpDeductions where EedEEID= xEEID and EedDedCode = BdmDedCode) = 0 
                                THEN (select TOP 1 PdhDedCalcBasisAmt from PDedHist where PdhEEID = xEEID and pdhDedCode = BdmDedCode)
                                ELSE (select EedBenAmt from dbo.U_dsi_BDM_EmpDeductions where EedEEID= xEEID and EedDedCode = BdmDedCode) END
                            , '##.00')
                        END
        ,drvPersonalEmail = EepAddressEMail
        ,drvEmpId = ''
        ,drvEmpPhone = ''
        ,drvClass = ''
        ,drvDateEmpLastActivity =    CASE WHEN EecEmplStatus = 'T' THEN EecDateLastWorked ELSE
                                        CASE WHEN BdmDedCode = '300' AND ISNULL(BdmBenStopDate, '') <> '' THEN BdmBenStopDate
                                            WHEN BdmDedCode = 'GLIFE' AND ISNULL(BdmBenStopDate, '') <> '' THEN BdmBenStopDate
                                            WHEN BdmDedCode = '310' AND ISNULL(BdmBenStopDate, '') <> '' THEN BdmBenStopDate
                                            WHEN BdmDedCode IN ('321', '322') AND ISNULL(BdmBenStopDate, '') <> '' THEN BdmBenStopDate
                                        END
                                    END
        ,drvEmplClass = ''
        ,drvEmpOnLeave = ''
        ,drvEmpLeaveStartDate = ''
        ,drvEmpRetired = ''
        ,drvEmpRetiredDate = ''
        ,drvEmpTitleAtTerm = ''
        ,drvEmpMonthEarnAtTerm = ''
        ,drvIsYearLTDCovered = ''
        ,drvEmpDateOfHire = ''
        ,drvMisc = ''
    INTO dbo.U_ELINLIFPCT_drvTbl
    FROM dbo.U_ELINLIFPCT_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELINLIFPCT WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConRelationship = 'SPS'
        AND ConDateOfBirth IS NOT Null
    --JOIN dbo.U_ELINLIFPCT_PDedHist WITH (NOLOCK)
    --    ON PdhEEID = xEEID
    JOIN (    -- filter out anyone who's most recent change reason was open enrollment (OE)
            Select distinct EdhEEID, EdhCoID, EdhDedCode, EdhChangeReason from (
                Select EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhEffDate, ROW_NUMBER() Over(partition by EdhEEID, EdhCOID, edhDedCode order by EdhEffDate desc) as rn 
                from EmpHDed
                Where EdhDedCode IN ('300','310','321','322','GLIFE') and (EdhChangeReason <> 'OE' OR EdhChangeReason IS NULL) 
                AND EdhChangeReason IN ('210', '208', '302', 'LEVNT3', '204', 'LEVNT4', '202', '203', 'CHGRP', '201') -- JCB
            ) as T
            Where rn = 1 
            ) Non_OE_Reason
        ON EdhEEID = xEEID
        and EdhCoID = xCOID
        AND BdmDedCode = EdhDedCode
    WHERE BdmBenStatus NOT IN ('A')
        AND (EecEmplStatus = 'A' OR (EecEmplStatus = 'T' AND EecTERmReason IN ('202', '203')))
        --EecEmplStatus = 'T' AND EecTermReason
    ;

    /* Stuff from Marco about benefit amounts 

    select * from dbo.U_dsi_BDM_EmpDeductions where EedEEID= 'A2Q1NJ0010K0' and EedDedCode = '300'

select PdhDedCalcBasisAmt from PDedHist where PdhEEID = 'A2Q1NJ0010K0' and pdhDedCode ='300'
 

 */

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELINLIFPCT_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ELINLIFPCT_Header;
    SELECT DISTINCT
         drvRecordCount = FORMAT((SELECT COUNT(*) FROM dbo.U_ELINLIFPCT_drvTbl), '0000000')
        ,drvFileDate = FORMAT(GETDATE(), 'yyyyMMdd')
    INTO dbo.U_ELINLIFPCT_Header
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
ALTER VIEW dbo.dsi_vwELINLIFPCT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELINLIFPCT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINLIFPCT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901011'
       ,expStartPerControl     = '201901011'
       ,expLastEndPerControl   = '202001159'
       ,expEndPerControl       = '202001159'
WHERE expFormatCode = 'ELINLIFPCT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINLIFPCT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINLIFPCT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort