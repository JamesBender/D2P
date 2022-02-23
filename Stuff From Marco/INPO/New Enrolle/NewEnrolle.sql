SET NOCOUNT ON;
IF OBJECT_ID('U_EIFCBRNEEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIFCBRNEEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIFCBRNEEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIFCBRNEEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIFCBRNEEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIFCBRNEEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIFCBRNEEX];
GO
IF OBJECT_ID('U_EIFCBRNEEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_PEarHist];
GO
IF OBJECT_ID('U_EIFCBRNEEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_PDedHist];
GO
IF OBJECT_ID('U_EIFCBRNEEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_Header];
GO
IF OBJECT_ID('U_EIFCBRNEEX_File') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_File];
GO
IF OBJECT_ID('U_EIFCBRNEEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_EEList];
GO
IF OBJECT_ID('U_EIFCBRNEEX_drvTblenr') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_drvTblenr];
GO
IF OBJECT_ID('U_EIFCBRNEEX_drvTblEmp') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_drvTblEmp];
GO
IF OBJECT_ID('U_EIFCBRNEEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EIFCBRNEEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIFCBRNEEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIFCBRNEEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIFCBRNEEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIFCBRNEEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIFCBRNEEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIFCBRNEEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EIFCBRNEEX','InfiniSource Cobra Newly Eligible Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EIFCBRNEEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileFormat"','1','(''UA''=''F'')','EIFCBRNEEXZ0','25','H','01','1',NULL,'FileFormat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileVersion"','2','(''UA''=''F'')','EIFCBRNEEXZ0','3','H','01','26',NULL,'FileVersion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompNo"','3','(''UA''=''F'')','EIFCBRNEEXZ0','15','H','01','29',NULL,'CompanyNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserId"','4','(''UA''=''F'')','EIFCBRNEEXZ0','20','H','01','44',NULL,'UserID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPassword"','5','(''UA''=''F'')','EIFCBRNEEXZ0','20','H','01','64',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmissionDate"','6','(''UD23''=''F'')','EIFCBRNEEXZ0','10','H','01','84',NULL,'SubmissionDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResponseEmail"','7','(''UA''=''F'')','EIFCBRNEEXZ0','65','H','01','94',NULL,'ResponseEMail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResponseFax"','8','(''UA''=''F'')','EIFCBRNEEXZ0','12','H','01','159',NULL,'ResponseFAX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendNotices"','9','(''UA''=''F'')','EIFCBRNEEXZ0','5','H','01','171',NULL,'SendNotices',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvValidatedOnly"','10','(''UA''=''F'')','EIFCBRNEEXZ0','5','H','01','176',NULL,'ValidateOnly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRecordType"','1','(''UA''=''F'')','EIFCBRNEEXZ0','3','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCompanyNo"','2','(''UA''=''F'')','EIFCBRNEEXZ0','15','D','10','4',NULL,'CompanyNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmpNo"','3','(''UA''=''F'')','EIFCBRNEEXZ0','20','D','10','19',NULL,'EmployeeNo',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','4','(''UA''=''F'')','EIFCBRNEEXZ0','12','D','10','39',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDOB"','5','(''UD23''=''F'')','EIFCBRNEEXZ0','10','D','10','51',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','6','(''UA''=''F'')','EIFCBRNEEXZ0','25','D','10','61',NULL,'Firstname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','7','(''UA''=''F'')','EIFCBRNEEXZ0','35','D','10','86',NULL,'Lastname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','8','(''UA''=''F'')','EIFCBRNEEXZ0','1','D','10','121',NULL,'Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLanguageCode"','9','(''UA''=''F'')','EIFCBRNEEXZ0','25','D','10','122',NULL,'LanguageCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrRecordType"','1','(''UA''=''F'')','EIFCBRNEEXZ0','3','D','20','1',NULL,'RecordType ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrSSN"','2','(''UA''=''F'')','EIFCBRNEEXZ0','12','D','20','4',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrDob"','3','(''UD23''=''F'')','EIFCBRNEEXZ0','10','D','20','16',NULL,'DOB ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrFirstName"','4','(''UA''=''F'')','EIFCBRNEEXZ0','25','D','20','26',NULL,'Firstname ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrLastname"','5','(''UA''=''F'')','EIFCBRNEEXZ0','35','D','20','51',NULL,'Lastname ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrMiddlename"','6','(''UA''=''F'')','EIFCBRNEEXZ0','1','D','20','86',NULL,'Initial ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrRelationCode"','7','(''UA''=''F'')','EIFCBRNEEXZ0','10','D','20','87',NULL,'RelationCode ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrAddressLine1"','8','(''UA''=''F'')','EIFCBRNEEXZ0','55','D','20','97',NULL,'Address1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrAddressLine2"','9','(''UA''=''F'')','EIFCBRNEEXZ0','55','D','20','152',NULL,'Address2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrCity"','10','(''UA''=''F'')','EIFCBRNEEXZ0','35','D','20','207',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrState"','11','(''UA''=''F'')','EIFCBRNEEXZ0','5','D','20','242',NULL,'State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrZipCode"','12','(''UA''=''F'')','EIFCBRNEEXZ0','15','D','20','247',NULL,'Zipcode ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrCountryCode"','13','(''UA''=''F'')','EIFCBRNEEXZ0','3','D','20','262',NULL,'CountryCode ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrInsuranceEffectiveDate"','14','(''UD23''=''F'')','EIFCBRNEEXZ0','10','D','20','265',NULL,'InsuranceEffective ',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIFCBRNEEX_20200123.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'InfiniSource New Enrollee','202001169','EMPEXPORT','ONDEMAND',NULL,'EIFCBRNEEX',NULL,NULL,NULL,'202001169','Jan 16 2020  4:04PM','Jan 16 2020  4:04PM','202001161',NULL,'','','202001161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIFCBRNEEX_20200123.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202001169','EMPEXPORT','SCHEDULED','Jan 20 2020  3:50PM','EIFCBRNEEX',NULL,NULL,NULL,'202001169','Jan 16 2020 12:00AM','Dec 30 1899 12:00AM','201909161','165','','','201909161',dbo.fn_GetTimedKey(),NULL,'us3mLaINS1016',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIFCBRNEEX_20200123.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001319','EMPEXPORT','TEST','Jan 23 2020 12:14PM','EIFCBRNEEX',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','40','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3mLaINS1016',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EIFCBRNEEX_20200123.txt' END WHERE expFormatCode = 'EIFCBRNEEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRNEEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRNEEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRNEEX','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRNEEX','Subsort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRNEEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIFCBRNEEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EIFCBRNEEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIFCBRNEEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EIFCBRNEEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIFCBRNEEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRNEEX','H01','dbo.U_EIFCBRNEEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRNEEX','D10','dbo.U_EIFCBRNEEX_drvTblEmp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIFCBRNEEX','D20','dbo.U_EIFCBRNEEX_drvTblenr',NULL);
IF OBJECT_ID('U_dsi_BDM_EIFCBRNEEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIFCBRNEEX] (
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
IF OBJECT_ID('U_EIFCBRNEEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EIFCBRNEEX_drvTblEmp') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_drvTblEmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
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
IF OBJECT_ID('U_EIFCBRNEEX_drvTblenr') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_drvTblenr] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEnrRecordType] varchar(3) NOT NULL,
    [drvEnrSSN] char(11) NULL,
    [drvEnrDob] datetime NULL,
    [drvEnrFirstName] varchar(100) NULL,
    [drvEnrLastname] varchar(100) NULL,
    [drvEnrMiddlename] varchar(1) NULL,
    [drvEnrRelationCode] varchar(9) NULL,
    [drvEnrAddressLine1] varchar(255) NULL,
    [drvEnrAddressLine2] varchar(255) NULL,
    [drvEnrCity] varchar(255) NULL,
    [drvEnrState] varchar(255) NULL,
    [drvEnrZipCode] varchar(50) NULL,
    [drvEnrCountryCode] varchar(3) NOT NULL,
    [drvEnrInsuranceEffectiveDate] datetime NULL
);
IF OBJECT_ID('U_EIFCBRNEEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIFCBRNEEX_File') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EIFCBRNEEX_Header') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_Header] (
    [drvFileFormat] varchar(6) NOT NULL,
    [drvSSN] int NOT NULL,
    [drvFileVersion] varchar(3) NOT NULL,
    [drvCompNo] varchar(7) NOT NULL,
    [drvUserId] varchar(1) NOT NULL,
    [drvPassword] varchar(1) NOT NULL,
    [drvSubmissionDate] datetime NOT NULL,
    [drvResponseEmail] varchar(17) NOT NULL,
    [drvResponseFax] varchar(1) NOT NULL,
    [drvSendNotices] varchar(4) NOT NULL,
    [drvValidatedOnly] varchar(4) NULL
);
IF OBJECT_ID('U_EIFCBRNEEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_PDedHist] (
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
IF OBJECT_ID('U_EIFCBRNEEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIFCBRNEEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIFCBRNEEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Institute Of Nuclear Power Operations 

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/20/2020
Service Request Number: TekP-2019-12-05-001

Purpose: InfiniSource Cobra Newly Eligible Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIFCBRNEEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIFCBRNEEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIFCBRNEEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIFCBRNEEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIFCBRNEEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIFCBRNEEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIFCBRNEEX', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIFCBRNEEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIFCBRNEEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIFCBRNEEX';

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
    DELETE FROM dbo.U_EIFCBRNEEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIFCBRNEEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,FSA,FSADC,FSAL,CDHP,OAPN,OAPN,VIS';

    IF OBJECT_ID('U_EIFCBRNEEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRNEEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIFCBRNEEX_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'NPM')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeIncludeEmps','Y'); -- Include employees when dependent is eligible    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y')
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    /*
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'NPMDep')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeIncludeEmps','Y'); -- Include employees when dependent is eligible    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TableType', 'DEP')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    */
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EIFCBRNEEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRNEEX_PDedHist;
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
    INTO dbo.U_EIFCBRNEEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIFCBRNEEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIFCBRNEEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRNEEX_PEarHist;
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
    INTO dbo.U_EIFCBRNEEX_PEarHist
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
    -- DETAIL RECORD - U_EIFCBRNEEX_drvTblEmp
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRNEEX_drvTblEmp','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRNEEX_drvTblEmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = '2' + eepSSN
        ,drvSubSort = '2'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpRecordType = 'EMP'
        ,drvEmpCompanyNo = 'CN99136'
        ,drvEmpEmpNo = eepSSN
        ,drvEmpSSN =  eepSSN
        ,drvEmpDOB =  eepdateofbirth 
        ,drvEmpFirstName = eepNameFirst 
        ,drvEmpLastName = eepNameLast
        ,drvEmpMiddleName =  LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvEmpLanguageCode = 'English'
    INTO dbo.U_EIFCBRNEEX_drvTblEmp
    FROM dbo.U_EIFCBRNEEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EIFCBRNEEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EIFCBRNEEX_drvTblenr
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRNEEX_drvTblenr','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRNEEX_drvTblenr;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = '2' + eepSSN
        ,drvSubSort = '3'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEnrRecordType = 'ENR'
        ,drvEnrSSN = CASE WHEN BdmRecType = 'EMP' THEn eepSSN
                        ELSE COnSSN
                    END
        ,drvEnrDob = CASE WHEN BdmRecType = 'EMP' THEn EepDateOfBirth
                        ELSE ConDateOfBirth
                    END
        ,drvEnrFirstName = CASE WHEN BdmRecType = 'EMP' THEn EepNameFirst
                        ELSE ConNameFirst
                    END 
        ,drvEnrLastname = CASE WHEN BdmRecType = 'EMP' THEn EepNameLast
                        ELSE ConNameLast
                    END 
        ,drvEnrMiddlename = CASE WHEN BdmRecType = 'EMP' THEn LEFT(ISNULL(EepNameMiddle,''),1)
                        ELSE LEFT(ISNULL(ConNameMiddle,''),1)
                         END  
        ,drvEnrRelationCode = CASE WHEN BdmRecType = 'EMP' THEN 'Employee'
                                  WHEN BdmRecType = 'DEP' THEN
                                    CASE WHEN ConRelationship in ('SPS','DP') THEN 'Spouse'
                                         WHEN ConRelationship in ('CHL','DPC','DIS','STC') THEN 'Dependent'
                                    END
                            END
        ,drvEnrAddressLine1 = EepAddressLine1
        ,drvEnrAddressLine2 = EepAddressLine2
        ,drvEnrCity = EepAddressCity
        ,drvEnrState = EepAddressState
        ,drvEnrZipCode = EepAddressZipCode
        ,drvEnrCountryCode = 'USA'
        ,drvEnrInsuranceEffectiveDate = BdmBenStartDate
    INTO dbo.U_EIFCBRNEEX_drvTblenr
    FROM dbo.U_EIFCBRNEEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN ( Select BdmRecType,BdmCoid,BdmEEID,BdmDepREcId,BdmRelationShip,Max(BdmBenStartDate) as BdmBenStartDate from U_dsi_BDM_EIFCBRNEEX 
 group by BdmRecType,BdmCoid,BdmEEID,BdmDepREcId,BdmRelationShip) as Consolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
    AND ConSystemID = BdmDepRecID;


    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIFCBRNEEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EIFCBRNEEX_Header;
    SELECT DISTINCT

         drvFileFormat = 'NE.TXT'
        ,drvSSN = -1
        ,drvFileVersion = '4.0'
        ,drvCompNo = 'CN99136'
        ,drvUserId = ''
        ,drvPassword = ''
        ,drvSubmissionDate = GETDATE()
        ,drvResponseEmail = 'benefits@inpo.org'
        ,drvResponseFax = ''
        ,drvSendNotices = 'TRUE'
        ,drvValidatedOnly = CASE WHEN @ExportCode LIKE '%SCHEDULED%' THEN ''
                                 WHEN @ExportCode LIKE '%TEST' THEN 'TRUE'
                            END

    INTO dbo.U_EIFCBRNEEX_Header
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
ALTER VIEW dbo.dsi_vwEIFCBRNEEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIFCBRNEEX_File (NOLOCK)
    ORDER BY InitialSort

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIFCBRNEEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001091'
       ,expStartPerControl     = '202001091'
       ,expLastEndPerControl   = '202001169'
       ,expEndPerControl       = '202001169'
WHERE expFormatCode = 'EIFCBRNEEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIFCBRNEEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIFCBRNEEX_File (NOLOCK)
    ORDER BY InitialSort,Subsort