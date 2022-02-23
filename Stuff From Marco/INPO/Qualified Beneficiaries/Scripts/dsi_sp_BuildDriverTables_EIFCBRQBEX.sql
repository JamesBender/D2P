SET NOCOUNT ON;
IF OBJECT_ID('U_EIFCBRQBEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIFCBRQBEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIFCBRQBEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIFCBRQBEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIFCBRQBEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIFCBRQBEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIFCBRQBEX];
GO
IF OBJECT_ID('U_EIFCBRQBEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_PEarHist];
GO
IF OBJECT_ID('U_EIFCBRQBEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_PDedHist];
GO
IF OBJECT_ID('U_EIFCBRQBEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_Header];
GO
IF OBJECT_ID('U_EIFCBRQBEX_File') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_File];
GO
IF OBJECT_ID('U_EIFCBRQBEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_EEList];
GO
IF OBJECT_ID('U_EIFCBRQBEX_drvTblQBR') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_drvTblQBR];
GO
IF OBJECT_ID('U_EIFCBRQBEX_drvTblOFC') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_drvTblOFC];
GO
IF OBJECT_ID('U_EIFCBRQBEX_drvTblEmp') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_drvTblEmp];
GO
IF OBJECT_ID('U_EIFCBRQBEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EIFCBRQBEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIFCBRQBEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIFCBRQBEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIFCBRQBEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIFCBRQBEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIFCBRQBEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIFCBRQBEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EIFCBRQBEX','InfiniSource Cobra Qualifying Beneficiaries','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EIFCBRQBEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileFormat"','1','(''UA''=''F'')','EIFCBRQBEXZ0','25','H','01','1',NULL,'FileFormat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileVersion"','2','(''UA''=''F'')','EIFCBRQBEXZ0','3','H','01','26',NULL,'FileVersion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompNo"','3','(''UA''=''F'')','EIFCBRQBEXZ0','15','H','01','29',NULL,'CompanyNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserId"','4','(''UA''=''F'')','EIFCBRQBEXZ0','20','H','01','44',NULL,'UserID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPassword"','5','(''UA''=''F'')','EIFCBRQBEXZ0','20','H','01','64',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmissionDate"','6','(''UD23''=''F'')','EIFCBRQBEXZ0','10','H','01','84',NULL,'SubmissionDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResponseEmail"','7','(''UA''=''F'')','EIFCBRQBEXZ0','65','H','01','94',NULL,'ResponseEMail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResponseFax"','8','(''UA''=''F'')','EIFCBRQBEXZ0','12','H','01','159',NULL,'ResponseFAX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendNotices"','9','(''UA''=''F'')','EIFCBRQBEXZ0','5','H','01','171',NULL,'SendNotices',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvValidatedOnly"','10','(''UA''=''F'')','EIFCBRQBEXZ0','5','H','01','176',NULL,'ValidateOnly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRecordType"','1','(''UA''=''F'')','EIFCBRQBEXZ0','3','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCompanyNo"','2','(''UA''=''F'')','EIFCBRQBEXZ0','15','D','10','4',NULL,'CompanyNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmpNo"','3','(''UA''=''F'')','EIFCBRQBEXZ0','20','D','10','19',NULL,'EmployeeNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','4','(''UA''=''F'')','EIFCBRQBEXZ0','12','D','10','39',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDOB"','5','(''UD23''=''F'')','EIFCBRQBEXZ0','10','D','10','51',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','6','(''UA''=''F'')','EIFCBRQBEXZ0','25','D','10','61',NULL,'Firstname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','7','(''UA''=''F'')','EIFCBRQBEXZ0','35','D','10','86',NULL,'Lastname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','8','(''UA''=''F'')','EIFCBRQBEXZ0','1','D','10','121',NULL,'Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLanguageCode"','9','(''UA''=''F'')','EIFCBRQBEXZ0','25','D','10','122',NULL,'LanguageCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBRecordType"','1','(''UA''=''F'')','EIFCBRQBEXZ0','3','D','20','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBEventDate"','2','(''UD23''=''F'')','EIFCBRQBEXZ0','10','D','20','4',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBEventCode"','3','(''UA''=''F'')','EIFCBRQBEXZ0','50','D','20','14',NULL,'EventCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBSSN"','4','(''UA''=''F'')','EIFCBRQBEXZ0','12','D','20','64',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBDOB"','5','(''UD23''=''F'')','EIFCBRQBEXZ0','10','D','20','76',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBFirstName"','6','(''UA''=''F'')','EIFCBRQBEXZ0','25','D','20','86',NULL,'Firstname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBLastName"','7','(''UA''=''F'')','EIFCBRQBEXZ0','35','D','20','111',NULL,'Lastname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBMiddleName"','8','(''UA''=''F'')','EIFCBRQBEXZ0','1','D','20','146',NULL,'Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBRelationCode"','9','(''UA''=''F'')','EIFCBRQBEXZ0','10','D','20','147',NULL,'RelationCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBAddressLine1"','10','(''UA''=''F'')','EIFCBRQBEXZ0','55','D','20','157',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBAddressLine2"','11','(''UA''=''F'')','EIFCBRQBEXZ0','55','D','20','212',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBCity"','12','(''UA''=''F'')','EIFCBRQBEXZ0','35','D','20','267',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBState"','13','(''UA''=''F'')','EIFCBRQBEXZ0','5','D','20','302',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBZipCode"','14','(''UA''=''F'')','EIFCBRQBEXZ0','15','D','20','307',NULL,'Zipcode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBCountryCode"','15','(''UA''=''F'')','EIFCBRQBEXZ0','3','D','20','322',NULL,'CountryCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBDisabled"','16','(''UA''=''F'')','EIFCBRQBEXZ0','3','D','20','325',NULL,'Disabled',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCRecordType"','1','(''UA''=''F'')','EIFCBRQBEXZ0','3','D','30','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCPlanCode"','2','(''UA''=''F'')','EIFCBRQBEXZ0','15','D','30','4',NULL,'PlanCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCCoverageCode"','3','(''UA''=''F'')','EIFCBRQBEXZ0','15','D','30','19',NULL,'CoverageCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCOptionCode"','4','(''UA''=''F'')','EIFCBRQBEXZ0','15','D','30','34',NULL,'OptionCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCLossOfCoverage"','5','(''UD23''=''F'')','EIFCBRQBEXZ0','10','D','30','49',NULL,'LossOfCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCEventDate"','6','(''UD23''=''F'')','EIFCBRQBEXZ0','10','D','30','59',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCPremium"','7','(''UA''=''F'')','EIFCBRQBEXZ0','7','D','30','69',NULL,'Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCDayDue"','8','(''UD23''=''F'')','EIFCBRQBEXZ0','2','D','30','76',NULL,'DayDue',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCWaitingPeriodBegan"','9','(''UA''=''F'')','EIFCBRQBEXZ0','10','D','30','78',NULL,'WaitingPeriodBegan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOFCCoverageBegan"','10','(''UA''=''F'')','EIFCBRQBEXZ0','10','D','30','88',NULL,'CoverageBegan',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIFCBRQBEX_20200401.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'InfiniSource Cobra Qualifying','202001169','EMPEXPORT','ONDEMAND',NULL,'EIFCBRQBEX',NULL,NULL,NULL,'202001169','Jan 16 2020  4:04PM','Jan 16 2020  4:04PM','202001161',NULL,'','','202001161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIFCBRQBEX_20200401.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001169','EMPEXPORT','SCHEDULED',NULL,'EIFCBRQBEX',NULL,NULL,NULL,'202001169','Jan 16 2020  4:04PM','Jan 16 2020  4:04PM','202001161',NULL,'','','202001161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIFCBRQBEX_20200401.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003209','EMPEXPORT','TEST','Mar 20 2020  4:35PM','EIFCBRQBEX',NULL,NULL,NULL,'202003209','Mar 20 2020 12:00AM','Dec 30 1899 12:00AM','202001011','49','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiINS1016',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EIFCBRQBEX_20200401.txt' END WHERE expFormatCode = 'EIFCBRQBEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','Subsort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','Subsort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','Subsort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRQBEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EIFCBRQBEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIFCBRQBEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EIFCBRQBEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRQBEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRQBEX','H01','dbo.U_EIFCBRQBEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRQBEX','D10','dbo.U_EIFCBRQBEX_drvTblEmp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRQBEX','D20','dbo.U_EIFCBRQBEX_drvTblQBR',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRQBEX','D30','dbo.U_EIFCBRQBEX_drvTblOFC',NULL);
IF OBJECT_ID('U_dsi_BDM_EIFCBRQBEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIFCBRQBEX] (
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
IF OBJECT_ID('U_EIFCBRQBEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_drvTblEmp') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_drvTblEmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpRecordType] varchar(3) NOT NULL,
    [drvEmpCompanyNo] varchar(7) NOT NULL,
    [drvEmpEmpNo] char(11) NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpDOB] datetime NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpMiddleName] varchar(1) NULL,
    [drvEmpLanguageCode] varchar(7) NOT NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_drvTblOFC') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_drvTblOFC] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvSubSort2] char(5) NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvDepRecID] char(12) NULL,
    [drvOFCRecordType] varchar(3) NOT NULL,
    [drvOFCPlanCode] varchar(12) NULL,
    [drvOFCCoverageCode] varchar(13) NULL,
    [drvOFCOptionCode] varchar(15) NULL,
    [drvOFCLossOfCoverage] datetime NULL,
    [drvOFCEventDate] datetime NULL,
    [drvOFCPremium] varchar(12) NULL,
    [drvOFCDayDue] datetime NULL,
    [drvOFCWaitingPeriodBegan] varchar(1) NOT NULL,
    [drvOFCCoverageBegan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_drvTblQBR') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_drvTblQBR] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvQBRecordType] varchar(2) NOT NULL,
    [drvQBEventDate] datetime NULL,
    [drvQBEventCode] varchar(31) NOT NULL,
    [drvQBSSN] char(11) NULL,
    [drvQBDOB] datetime NULL,
    [drvQBFirstName] varchar(100) NULL,
    [drvQBLastName] varchar(100) NULL,
    [drvQBMiddleName] varchar(1) NULL,
    [drvQBRelationCode] varchar(9) NULL,
    [drvQBAddressLine1] varchar(255) NULL,
    [drvQBAddressLine2] varchar(255) NULL,
    [drvQBCity] varchar(255) NULL,
    [drvQBState] varchar(255) NULL,
    [drvQBZipCode] varchar(50) NULL,
    [drvQBCountryCode] varchar(3) NOT NULL,
    [drvQBDisabled] varchar(3) NULL,
    [drvRectype] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_File') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_Header') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_Header] (
    [drvFileFormat] varchar(6) NOT NULL,
    [drvSSN] int NOT NULL,
    [drvFileVersion] varchar(3) NOT NULL,
    [drvCompNo] varchar(7) NOT NULL,
    [drvUserId] varchar(8) NOT NULL,
    [drvPassword] varchar(8) NOT NULL,
    [drvSubmissionDate] datetime NOT NULL,
    [drvResponseEmail] varchar(17) NOT NULL,
    [drvResponseFax] varchar(1) NOT NULL,
    [drvSendNotices] varchar(4) NOT NULL,
    [drvValidatedOnly] varchar(4) NULL
);
IF OBJECT_ID('U_EIFCBRQBEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_PDedHist] (
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
IF OBJECT_ID('U_EIFCBRQBEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIFCBRQBEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIFCBRQBEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Institute Of Nuclear Power Operations 

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/16/2020
Service Request Number: SR-2019-00223916

Purpose: InfiniSource Cobra Qualifying Beneficiaries

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIFCBRQBEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIFCBRQBEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIFCBRQBEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIFCBRQBEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIFCBRQBEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIFCBRQBEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIFCBRQBEX', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIFCBRQBEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIFCBRQBEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIFCBRQBEX';

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
    DELETE FROM dbo.U_EIFCBRQBEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIFCBRQBEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,FSA,FSADC,FSAL,CDHP,OAPN,OAPN,VIS';

    IF OBJECT_ID('U_EIFCBRQBEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIFCBRQBEX_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','1');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','1');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y');
    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '208,210,200,105,201,202,203,204,205,206,207,300,303,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5') 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '208,210,200,105,201,202,203,204,205,206,207,300,303,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','2'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraPQBMulti', '1')
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EIFCBRQBEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_PDedHist;
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
    INTO dbo.U_EIFCBRQBEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIFCBRQBEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIFCBRQBEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_PEarHist;
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
    INTO dbo.U_EIFCBRQBEX_PEarHist
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
    -- DETAIL RECORD - U_EIFCBRQBEX_drvTblEmp
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRQBEX_drvTblEmp','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_drvTblEmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = '2' + eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpRecordType = 'EMP'
        ,drvEmpCompanyNo = 'CN99136'
        ,drvEmpEmpNo = eepSSN /*CASE WHEN BdmCobraReason IN ('LEVNT4','204','210','201') THEN COnSSN
                            ELSe eepSSN
                        END
                        */
        ,drvEmpSSN = /*CASE WHEN BdmCobraReason IN ('LEVNT4','204','210','201') THEN COnSSN
                            ELSe eepSSN
                        END
                    */eepSSN
        ,drvEmpDOB = eepdateofbirth/*CASE WHEN BdmCobraReason IN ('LEVNT4','204','210','201') THEN condateofbirth 
                            ELSe eepdateofbirth 
                        END
                    */
        ,drvEmpFirstName = /*CASE WHEN BdmCobraReason IN ('LEVNT4','204','210','201') THEN conNameFirst 
                            ELSe eepNameFirst 
                        END */ eepNameFirst
        ,drvEmpLastName = eepNameLast/*CASE WHEN BdmCobraReason IN ('LEVNT4','204','210','201') THEN conNameLast
                            ELSe eepNameLast
                        END */
        ,drvEmpMiddleName = LEFT(ISNULL(EepNameMiddle,''),1) /*CASE WHEN BdmCobraReason IN ('LEVNT4','204','210','201') THEN LEFT(ISNULL(ConNameMiddle,''),1)
                            ELSe LEFT(ISNULL(EepNameMiddle,''),1)
                        END*/
        ,drvEmpLanguageCode = 'English'
    INTO dbo.U_EIFCBRQBEX_drvTblEmp
    FROM dbo.U_EIFCBRQBEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EIFCBRQBEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmRecType = 'EMP'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIFCBRQBEX_drvTblQBR
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRQBEX_drvTblQBR','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_drvTblQBR;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = '2' + eepSSN
        ,drvSubSort = ISNULL(BdmDepRecID,eepssn)
        ,drvSubSort2 =  ''
        ,drvSubSort3 = '1'
        ,drvQBRecordType = 'QB'
        ,drvQBEventDate = bdmDateofCobraEvent
        ,drvQBEventCode = CASE WHEN BdmCobraReason in ('210') OR EecTermReason in ('203') THEN 'Death of the Employee'
                               WHEN BdmCobraReason in ('204','LEVNT4') THEN 'Divorce/Legal Separation'
                               WHEN BdmCobraReason in ('201') THEN 'Dependent Ceasing to be Dep'
                               WHEN BdmCobraReason in ('205') THEN 'Employee''s Medicare Entitlement'
                               WHEN BdmCobraReason in ('207') THEN 'Military Leave of Absence'
                               WHEN BdmCobraReason in ('203') THEN 'Employee''s Reduction of Hours'
                               WHEN eecEmplStatus in ('T') and eectermtype = 'V' THEN 'Termination of Employment'
                               WHEN eecEmplStatus in ('T') and eectermtype = 'I' or EecTermReason = 'INV' THEN 'Termination of Employment'
                               Else 'Termination of Employment'
                          END
        ,drvQBSSN = 
                        CASE WHEN BdmRecType = 'EMP' THEn eepSSN
                        ELSE COnSSN
                    END
        ,drvQBDOB = CASE WHEN BdmRecType = 'EMP' THEn EepDateOfBirth
                        ELSE ConDateOfBirth
                    END
        ,drvQBFirstName = CASE WHEN BdmRecType = 'EMP' THEn EepNameFirst
                        ELSE ConNameFirst
                    END 
        ,drvQBLastName = CASE WHEN BdmRecType = 'EMP' THEn EepNameLast
                        ELSE ConNameLast
                         END
                          
        ,drvQBMiddleName =  CASE WHEN BdmRecType = 'EMP' THEn LEFT(ISNULL(EepNameMiddle,''),1)
                        ELSE LEFT(ISNULL(ConNameMiddle,''),1)
                         END 
                        
        ,drvQBRelationCode = CASE WHEN BdmRecType = 'EMP' THEN 'Employee'
                                  WHEN BdmRecType = 'DEP' THEN
                                    CASE WHEN ConRelationship in ('SPS','DP') THEN 'Spouse'
                                         WHEN ConRelationship in ('CHL','DPC','DIS','STC') THEN 'Dependent'
                                    END
                            END
        ,drvQBAddressLine1 = EepAddressLine1
        ,drvQBAddressLine2 = EepAddressLine2
        ,drvQBCity = EepAddressCity
        ,drvQBState = EepAddressState
        ,drvQBZipCode = EepAddressZipCode
        ,drvQBCountryCode = 'USA'
        ,drvQBDisabled = CASE WHEN BdmRecType ='EMP' THEN
                                    CASE WHEN eepIsDisabled = 'Y' THEN 'YES'
                                        ELSe 'NO'
                                    END 
                              WHEN BdmRecType ='DEP' THEN
                                CASE WHEN conIsDisabled = 'Y' THEN 'YES'
                                        ELSe 'NO'
                                    END 

                         END
        ,drvRectype = bdmRecType
    INTO dbo.U_EIFCBRQBEX_drvTblQBR
    FROM dbo.U_EIFCBRQBEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (     select distinct bdmeeid,bdmcoid,bdmrectype,bdmdeprecid,max(bdmDateofCobraEvent) as bdmDateofCobraEvent,bdmCobraReason from  dbo.U_dsi_BDM_EIFCBRQBEX WITH (NOLOCK)  group by bdmeeid,bdmcoid,bdmrectype,bdmdeprecid,bdmCobraReason ) Consolidated
        ON consolidated.BdmEEID = xEEID 
        AND consolidated.BdmCoID = xCoID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = Consolidated.BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIFCBRQBEX_drvTblOFC
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRQBEX_drvTblOFC','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_drvTblOFC;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN =   '2' + eepSSN
        ,drvSubSort = ISNULL(BdmDepRecID,eepssn)
        ,drvSubSort2 = bdmdedcode --ISNULL(BdmDepRecID,eepssn) + '2'
        ,drvSubSort3 = '2'
        ,drvDepRecID = BdmDepRecID--BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvOFCRecordType = 'OFC'
        ,drvOFCPlanCode = CASE WHEN bdmdedcode in ('DEN','CDHP','OAP','OAPN') THEN 'CIGNA'
                               WHEN bdmdedtype in ('FSA') THEN 'INFINISOURCE'
                               WHEN bdmdedcode in ('VIS') THEN 'VSP'
                          END
        ,drvOFCCoverageCode = CASE WHEN BdmDedCode in ('DEN') THEN 'DENTAL'
                                   WHEN BdmDedCode in ('CDHP') THEN 'MEDICAL HSA'
                                   WHEN BdmDedCode in ('OAP') THEN 'MEDICAL OAP'
                                   WHEN BdmDedCode in ('OAPN') THEN 'MEDICAL OAPIN'
                                   WHEN bdmdedtype in ('FSA') THEN 'FSA'
                                   WHEN BdmDedCode in ('VIS') THEN 'VISION'
                              END
                            
        ,drvOFCOptionCode = CASE WHEN BdmCobraReason in ('201') THEN 'EE ONLY'
                                 WHEN bdmdedtype in ('FSA') THEN 'MONTHLY PREMIUM'
                                 WHEN BdmDedCode in ('DEN') THEN
                                        CASE WHEN BdmBenOption in ('EE') THEN 'EE ONLY'
                                             WHEN BdmBenOption in ('EEC') THEN 'EE+CHILD(REN)'
                                             WHEN BdmBenOption in ('EES') THEN 'EE+SPOUSE'
                                             WHEN BdmBenOption in ('EEF') THEN 'FAMILY'
                                        END    
                                WHEN BdmDedCode in ('CDHP') THEN
                                            CASE WHEN BdmBenOption in ('EE') THEN 'EE ONLY'
                                                    WHEN BdmBenOption in ('EEC') THEN 'EE+CHILD(REN)'
                                                    WHEN BdmBenOption in ('EES') THEN 'EE+SPOUSE'
                                                    WHEN BdmBenOption in ('EEF') THEN 'FAMILY'
                                            END
                                WHEN BdmDedCode in ('OAP') THEN
                                            CASE WHEN BdmBenOption in ('EE') THEN 'EE ONLY'
                                                    WHEN BdmBenOption in ('EEC') THEN 'EE+CHILD(REN)'
                                                    WHEN BdmBenOption in ('EES') THEN 'EE+SPOUSE'
                                                    WHEN BdmBenOption in ('EEF') THEN 'FAMILY'
                                            END
                                WHEN BdmDedCode in ('OAPN') THEN
                                            CASE WHEN BdmBenOption in ('EE') THEN 'EE ONLY'
                                                    WHEN BdmBenOption in ('EEC') THEN 'EE+CHILD(REN)'
                                                    WHEN BdmBenOption in ('EES') THEN 'EE+SPOUSE'
                                                    WHEN BdmBenOption in ('EEF') THEN 'FAMILY'
                                            END
                                WHEN BdmDedCode in ('VIS') THEN
                                            CASE WHEN BdmBenOption in ('EE') THEN 'EE ONLY'
                                                    WHEN BdmBenOption in ('EEC') THEN 'EE+CHILD(REN)'
                                                    WHEN BdmBenOption in ('EES') THEN 'EE+SPOUSE'
                                                    WHEN BdmBenOption in ('EEF') THEN 'FAMILY'
                                            END
                            END 
        ,drvOFCLossOfCoverage = (select top 1 bdmBenStopDate from U_dsi_BDM_EIFCBRQBEX where bdmeeid = xeeid and bdmcoid = xcoid and bdmdedcode = consolidated.bdmdedcode)
        ,drvOFCEventDate = bdmDateofCobraEvent
        ,drvOFCPremium = CASE WHEN bdmdedtype in ('FSA') THEN CAST( CONVERT( DECIMAL(10,2),(((((select top 1 bdmeeamt from U_dsi_BDM_EIFCBRQBEX where bdmeeid = xeeid and bdmcoid = xcoid and bdmdedcode = consolidated.bdmdedcode) *24 )/ 12) * (0.02))) + ((((select top 1 bdmeeamt from U_dsi_BDM_EIFCBRQBEX where bdmeeid = xeeid and bdmcoid = xcoid and bdmdedcode = consolidated.bdmdedcode) *24 )/ 12) )) as varchar(12))
                              ELSE ''
                         END
        ,drvOFCDayDue = CASE WHEN bdmdedtype in ('FSA') THEN DateAdd(day,1,(select top 1 bdmBenStopDate from U_dsi_BDM_EIFCBRQBEX where bdmeeid = xeeid and bdmcoid = xcoid and bdmdedcode = consolidated.bdmdedcode))
                         END
        ,drvOFCWaitingPeriodBegan = ''
        ,drvOFCCoverageBegan = ''
    
    INTO dbo.U_EIFCBRQBEX_drvTblOFC
    FROM dbo.U_EIFCBRQBEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (select distinct bdmeeid,bdmcoid,bdmdedcode,bdmdedtype,bdmbenoption,bdmcobrareason,bdmDateofCobraEvent,BdmDepRecID from U_dsi_BDM_EIFCBRQBEX WITH (NOLOCK)) as Consolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

            delete from U_EIFCBRQBEX_drvTblOFC where drveeid in (        select distinct drveeid from U_EIFCBRQBEX_drvTblQBR   where drvRectype = 'EMP' and drvQBEventCode in ('Death of the Employee','Dependent Ceasing to be Dep') 
) and drvdeprecid is null


        Delete from U_EIFCBRQBEX_drvTblQBR   where drvRectype = 'EMP' and drvQBEventCode in ('Death of the Employee','Dependent Ceasing to be Dep') 


    Update dbo.U_EIFCBRQBEX_drvTblEmp set drvEmpSSN = SUBSTRING(drvEmpSSN, 1, 3)+'-'+
       SUBSTRING(drvEmpSSN, 4, 2)+'-'+
       SUBSTRING(drvEmpSSN, 3, 4)


Update dbo.U_EIFCBRQBEX_drvTblQBR  set drvQBSSN = SUBSTRING(drvQBSSN, 1, 3)+'-'+
       SUBSTRING(drvQBSSN, 4, 2)+'-'+
       SUBSTRING(drvQBSSN, 3, 4)

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRQBEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRQBEX_Header;
    SELECT DISTINCT

         drvFileFormat = 'QE.TXT'
        ,drvSSN = -1
        ,drvFileVersion = '4.0'
        ,drvCompNo = 'CN99136'
        ,drvUserId = 'USupport'
        ,drvPassword = 'M624D773'
        ,drvSubmissionDate = GETDATE()
        ,drvResponseEmail = 'benefits@inpo.org'
        ,drvResponseFax = ''
        ,drvSendNotices = 'TRUE'
        ,drvValidatedOnly = CASE WHEN @ExportCode LIKE '%SCHEDULED%' THEN ''
                                 WHEN @ExportCode LIKE '%TEST' THEN 'TRUE'
                            END

    INTO dbo.U_EIFCBRQBEX_Header
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
ALTER VIEW dbo.dsi_vwEIFCBRQBEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIFCBRQBEX_File (NOLOCK)
    ORDER BY InitialSort,SubSort,SubSort2,SubSort3

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIFCBRQBEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001091'
       ,expStartPerControl     = '202001091'
       ,expLastEndPerControl   = '202001169'
       ,expEndPerControl       = '202001169'
WHERE expFormatCode = 'EIFCBRQBEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIFCBRQBEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIFCBRQBEX_File (NOLOCK)
    ORDER BY InitialSort,SubSort,SubSort2,SubSort3