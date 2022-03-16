SET NOCOUNT ON;
IF OBJECT_ID('U_ETSQBNPMEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETSQBNPMEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETSQBNPMEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETSQBNPMEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETSQBNPMEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETSQBNPMEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETSQBNPMEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETSQBNPMEX];
GO
IF OBJECT_ID('U_ETSQBNPMEX_File') IS NOT NULL DROP TABLE [dbo].[U_ETSQBNPMEX_File];
GO
IF OBJECT_ID('U_ETSQBNPMEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETSQBNPMEX_EEList];
GO
IF OBJECT_ID('U_ETSQBNPMEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETSQBNPMEX_drvTbl];
GO
IF OBJECT_ID('U_ETSQBNPMEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETSQBNPMEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETSQBNPMEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETSQBNPMEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETSQBNPMEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETSQBNPMEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETSQBNPMEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETSQBNPMEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETSQBNPMEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETSQBNPMEX','Tax Saver NPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ETSQBNPMEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETSQBNPMEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpID"','2','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','2',NULL,'EmpID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','3','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','3',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First"','4','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','4',NULL,'First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last"','5','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','5',NULL,'Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1"','6','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','6',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2"','7','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','7',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','8','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','8',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StateOrProvince"','9','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','9',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PostalCode"','10','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','10',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','11','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','11',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','12','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','12',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WaivedCovg"','13','(''DA''=''T,'')','ETSQBNPMEXZ0','50','H','01','13',NULL,'WaivedCovg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','14','(''DA''=''T'')','ETSQBNPMEXZ0','50','H','01','14',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpID"','2','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','2',NULL,'EmpID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T,'')','ETSQBNPMEXZ0','50','D','10','3',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','4',NULL,'First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','5',NULL,'Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','6','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','6',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','7','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','7',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','8','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','8',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','9','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','9',NULL,'StateOrProvince',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','10','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','10',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','ETSQBNPMEXZ0','50','D','10','11',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T,'')','ETSQBNPMEXZ0','50','D','10','12',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','13','(''DA''=''T,'')','ETSQBNPMEXZ0','50','D','10','13',NULL,'WaivedCovg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','14','(''UD110''=''T'')','ETSQBNPMEXZ0','50','D','10','14',NULL,'Hire Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETSQBNPMEX_20210223.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202102179','EMPEXPORT','OEACTIVE','Feb 23 2021 12:23PM','ETSQBNPMEX',NULL,NULL,NULL,'202102179','Feb 17 2021  3:38PM','Feb 17 2021  3:38PM','202101011','26','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102179','EMPEXPORT','OEPASSIVE',NULL,'ETSQBNPMEX',NULL,NULL,NULL,'202102179','Feb 17 2021  3:38PM','Feb 17 2021  3:38PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tax Saver NPM Export','202102179','EMPEXPORT','ONDEM_XOE',NULL,'ETSQBNPMEX',NULL,NULL,NULL,'202102179','Feb 17 2021  3:38PM','Feb 17 2021  3:38PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tax Saver Cobra NPM Expo-Sched','202102179','EMPEXPORT','SCH_ETSQBN',NULL,'ETSQBNPMEX',NULL,NULL,NULL,'202102179','Feb 17 2021  3:38PM','Feb 17 2021  3:38PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Tax Saver Cobra NPM Expo-Test','202102179','EMPEXPORT','TEST_XOE',NULL,'ETSQBNPMEX',NULL,NULL,NULL,'202102179','Feb 17 2021  3:38PM','Feb 17 2021  3:38PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSQBNPMEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSQBNPMEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSQBNPMEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSQBNPMEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETSQBNPMEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETSQBNPMEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETSQBNPMEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETSQBNPMEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETSQBNPMEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETSQBNPMEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETSQBNPMEX','D10','dbo.U_ETSQBNPMEX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETSQBNPMEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETSQBNPMEX] (
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
IF OBJECT_ID('U_ETSQBNPMEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ETSQBNPMEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETSQBNPMEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETSQBNPMEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpID] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvHireDate] datetime NULL
);
IF OBJECT_ID('U_ETSQBNPMEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ETSQBNPMEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETSQBNPMEX_File') IS NULL
CREATE TABLE [dbo].[U_ETSQBNPMEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETSQBNPMEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Alkami

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/17/2021
Service Request Number: TekP-2020-12-04-0004

Purpose: Tax Saver NPM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETSQBNPMEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETSQBNPMEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETSQBNPMEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETSQBNPMEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETSQBNPMEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSQBNPMEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSQBNPMEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSQBNPMEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSQBNPMEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETSQBNPMEX', 'SCH_ETSQBN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETSQBNPMEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETSQBNPMEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETSQBNPMEX';

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
    DELETE FROM dbo.U_ETSQBNPMEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETSQBNPMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '';

    IF OBJECT_ID('U_ETSQBNPMEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETSQBNPMEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETSQBNPMEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList); -- ?
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

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
    -- DETAIL RECORD - U_ETSQBNPMEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETSQBNPMEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETSQBNPMEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmpID = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvGender = EepGender
        ,drvHireDate = EecDateOfLastHire
    INTO dbo.U_ETSQBNPMEX_drvTbl
    FROM dbo.U_ETSQBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETSQBNPMEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
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
ALTER VIEW dbo.dsi_vwETSQBNPMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETSQBNPMEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETSQBNPMEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102101'
       ,expStartPerControl     = '202102101'
       ,expLastEndPerControl   = '202102179'
       ,expEndPerControl       = '202102179'
WHERE expFormatCode = 'ETSQBNPMEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETSQBNPMEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETSQBNPMEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort