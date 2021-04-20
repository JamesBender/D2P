SET NOCOUNT ON;
IF OBJECT_ID('U_EINFORMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINFORMEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EINFORMEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EINFORMEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEINFORMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINFORMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINFORMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINFORMEXP];
GO
IF OBJECT_ID('U_EINFORMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EINFORMEXP_File];
GO
IF OBJECT_ID('U_EINFORMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINFORMEXP_EEList];
GO
IF OBJECT_ID('U_EINFORMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EINFORMEXP_drvTbl];
GO
IF OBJECT_ID('U_EINFORMEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EINFORMEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EINFORMEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EINFORMEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EINFORMEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EINFORMEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EINFORMEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EINFORMEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EINFORMEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EINFORMEXP','InfoArmor ID Theft Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EINFORMEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EINFORMEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','1','(''UD101''=''T,'')','EINFORMEXPZ0','50','D','10','1',NULL,'Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD"','2','(''DA''=''T,'')','EINFORMEXPZ0','50','D','10','2',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"5442"','3','(''DA''=''T,'')','EINFORMEXPZ0','50','D','10','3',NULL,'ClientID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','4',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberNameFirst"','5','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','5',NULL,'MemberFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberNameMiddle"','6','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','6',NULL,'MemberMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberNameLast"','7','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','7',NULL,'MemberLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSSN"','8','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','8',NULL,'MemberSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBMonth"','9','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','9',NULL,'DOB_Month',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBDay"','10','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','10',NULL,'DOB_Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOBYear"','11','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','11',NULL,'DOB_Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','12',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','13',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','15',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','16','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','16',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAreaCode"','17','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','17',NULL,'AreaCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','18','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','18',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','19','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','19',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer payroll deduction"','20','(''DA''=''T,'')','EINFORMEXPZ0','50','D','10','20',NULL,'Deduction Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EINFORMEXPZ0','50','D','10','21',NULL,'Customer_Defined Non-Required Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','22','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','22',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimary"','23','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','23',NULL,'Primary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyID"','24','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','24',NULL,'FamilyID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUniqueID"','25','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','25',NULL,'UniqueID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','26','(''UA''=''T,'')','EINFORMEXPZ0','50','D','10','26',NULL,'Plan_Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAP"','27','(''DA''=''T'')','EINFORMEXPZ0','50','D','10','27',NULL,'ProductID',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EINFORMEXP_20210405.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202104019','EMPEXPORT','OEACTIVE',NULL,'EINFORMEXP',NULL,NULL,NULL,'202104019','Apr  1 2021 11:40AM','Apr  1 2021 11:40AM','202104011',NULL,'','','202104011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202104019','EMPEXPORT','OEPASSIVE',NULL,'EINFORMEXP',NULL,NULL,NULL,'202104019','Apr  1 2021 11:40AM','Apr  1 2021 11:40AM','202104011',NULL,'','','202104011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'InfoArmor ID Theft Export','202104019','EMPEXPORT','ONDEM_XOE',NULL,'EINFORMEXP',NULL,NULL,NULL,'202104019','Apr  1 2021 11:40AM','Apr  1 2021 11:40AM','202104011',NULL,'','','202104011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'InfoArmor ID Theft Expor-Sched','202104019','EMPEXPORT','SCH_EINFOR',NULL,'EINFORMEXP',NULL,NULL,NULL,'202104019','Apr  1 2021 11:40AM','Apr  1 2021 11:40AM','202104011',NULL,'','','202104011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'InfoArmor ID Theft Expor-Test','202104059','EMPEXPORT','TEST_XOE','Apr  5 2021  9:21AM','EINFORMEXP',NULL,NULL,NULL,'202104059','Apr  5 2021 12:00AM','Dec 30 1899 12:00AM','202103221','90','','','202103221',dbo.fn_GetTimedKey(),NULL,'us3lKiOUT1004',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFORMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFORMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFORMEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFORMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFORMEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EINFORMEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EINFORMEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EINFORMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINFORMEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFORMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFORMEXP','D10','dbo.U_EINFORMEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EINFORMEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EINFORMEXP] (
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
IF OBJECT_ID('U_EINFORMEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EINFORMEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EINFORMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EINFORMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvEmployeeID] char(9) NULL,
    [drvMemberNameFirst] varchar(100) NULL,
    [drvMemberNameMiddle] varchar(1) NULL,
    [drvMemberNameLast] varchar(100) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvDOBMonth] int NULL,
    [drvDOBDay] int NULL,
    [drvDOBYear] int NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAreaCode] varchar(3) NULL,
    [drvHomePhoneNumber] varchar(7) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvRelationship] varchar(1) NULL,
    [drvPrimary] varchar(1) NOT NULL,
    [drvFamilyID] char(11) NULL,
    [drvUniqueID] varchar(41) NULL,
    [drvPlanType] varchar(10) NOT NULL
);
IF OBJECT_ID('U_EINFORMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EINFORMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EINFORMEXP_File') IS NULL
CREATE TABLE [dbo].[U_EINFORMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINFORMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: OutBox Sys

Created By: James Bender
Business Analyst: Lea King
Create Date: 04/01/2021
Service Request Number: TekP-2020-10-28-0001

Purpose: InfoArmor ID Theft Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINFORMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINFORMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINFORMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EINFORMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINFORMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFORMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFORMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFORMEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFORMEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFORMEXP', 'SCH_EINFOR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EINFORMEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EINFORMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EINFORMEXP';

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
    DELETE FROM dbo.U_EINFORMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EINFORMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EINFORMEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'IDT';

    IF OBJECT_ID('U_EINFORMEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EINFORMEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EINFORMEXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EINFORMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EINFORMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EINFORMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' ' + CASE WHEN BdmRecType = 'EMP' THEN '1' WHEN ConRelationship IN ('SPS','DP') THEN '2' ELSE '3' END
        -- standard fields above and additional driver fields below
        ,drvEffectiveDate = BdmBenStartDate
        ,drvEmployeeID = EecEmpNo
        ,drvMemberNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMemberNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvMemberNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvDOBMonth = CASE WHEN BdmRecType = 'EMP' THEN DATEPART(MONTH,EepDateOfBirth) ELSE DATEPART(MONTH,ConDateOfBirth) END
        ,drvDOBDay = CASE WHEN BdmRecType = 'EMP' THEN DATEPART(DAY,EepDateOfBirth) ELSE DATEPART(DAY,ConDateOfBirth) END
        ,drvDOBYear = CASE WHEN BdmRecType = 'EMP' THEN DATEPART(YEAR,EepDateOfBirth) ELSE DATEPART(YEAR,ConDateOfBirth) END
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAreaCode = LEFT(EepPhoneHomeNumber, 3)
        ,drvHomePhoneNumber = RIGHT(RTRIM(EepPhoneHomeNumber), 7)
        ,drvEmailAddress = EepAddressEMail
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN 'P'
                                WHEN ConRelationship IN ('SPS','DP') THEN 'S'
                                WHEN ConRelationship IN ('CHD','CHL','DPC','STC') THEN 'D'
                            END
        ,drvPrimary = CASE WHEN BdmRecType = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvFamilyID = EepSSN
        ,drvUniqueID = CASE WHEN BdmRecType = 'EMP' THEN RTRIM(EepSSN) + '1' ELSE RTRIM(ConSSN) + CAST(RN AS VARCHAR) END
        ,drvPlanType = CASE WHEN BdmBenOption = 'E1M' THEN 'Family' ELSE 'Individual' END
    INTO dbo.U_EINFORMEXP_drvTbl
    FROM dbo.U_EINFORMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EINFORMEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    LEFT JOIN (                
                SELECT ConEEID, ConNameFirst, ConNameMiddle, ConNameLast, ConSSN, ConDateOfBirth, ConRelationship, ConSystemId, (ROW_NUMBER() OVER (PARTITION BY BdmEEID, BdmCOID ORDER BY CASE WHEN BdmRecType = 'EMP' THEN 0 WHEN ConRelationship IN ('SPS','DP') THEN 1 ELSE 2 END, ConDateOfBirth) + 1) AS RN
                FROM dbo.U_dsi_BDM_EINFORMEXP WITH (NOLOCK)
                LEFT JOIN dbo.Contacts Con WITH (NOLOCK)
                    ON ConEEID = BdmEEID
                    AND ConSystemID = BdmDepRecID
                WHERE BdmRecType = 'DEP'
                ) AS Con
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE EecEmplStatus = 'A'
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
ALTER VIEW dbo.dsi_vwEINFORMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINFORMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EINFORMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202103251'
       ,expStartPerControl     = '202103251'
       ,expLastEndPerControl   = '202104019'
       ,expEndPerControl       = '202104019'
WHERE expFormatCode = 'EINFORMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEINFORMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EINFORMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort