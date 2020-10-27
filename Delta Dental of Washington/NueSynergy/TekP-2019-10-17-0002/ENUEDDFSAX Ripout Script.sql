SET NOCOUNT ON;
IF OBJECT_ID('U_ENUEDDFSAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ENUEDDFSAX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ENUEDDFSAX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwENUEDDFSAX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENUEDDFSAX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENUEDDFSAX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENUEDDFSAX];
GO
IF OBJECT_ID('U_ENUEDDFSAX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_PEarHist];
GO
IF OBJECT_ID('U_ENUEDDFSAX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_PDedHist];
GO
IF OBJECT_ID('U_ENUEDDFSAX_File') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_File];
GO
IF OBJECT_ID('U_ENUEDDFSAX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_EEList];
GO
IF OBJECT_ID('U_ENUEDDFSAX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_drvTbl];
GO
IF OBJECT_ID('U_ENUEDDFSAX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ENUEDDFSAX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENUEDDFSAX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENUEDDFSAX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENUEDDFSAX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENUEDDFSAX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENUEDDFSAX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENUEDDFSAX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CSV','ENUEDDFSAX','NueSynergy FSA Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ENUEDDFSAXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ENUEDDFSAX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Record ID"','1','(''DA''=''T,'')','ENUEDDFSAXZ0','9','H','01','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TPA ID"','2','(''DA''=''T,'')','ENUEDDFSAXZ0','8','H','01','2',NULL,'TPA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer ID"','3','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','3',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Type Code"','4','(''DA''=''T,'')','ENUEDDFSAXZ0','17','H','01','4',NULL,'Account Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan ID"','5','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','5',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Start Date"','6','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','6',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan End Date"','7','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','7',NULL,'Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','8','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','8',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Deposit Type"','9','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','9',NULL,'Deposit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Deposit Amount"','10','(''DA''=''T,'')','ENUEDDFSAXZ0','23','H','01','10',NULL,'Employee Deposit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Deposit Amount"','11','(''DA''=''T,'')','ENUEDDFSAXZ0','23','H','01','11',NULL,'Employer Deposit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Display to cardholder"','12','(''DA''=''T,'')','ENUEDDFSAXZ0','21','H','01','12',NULL,'Display to cardholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Display date"','13','(''DA''=''T,'')','ENUEDDFSAXZ0','15','H','01','13',NULL,'Display date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','14','(''DA''=''T'')','ENUEDDFSAXZ0','15','H','01','14',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordId"','1','(''UA''=''T,'')','ENUEDDFSAXZ0','15','D','10','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTPAID"','2','(''UA''=''T,'')','ENUEDDFSAXZ0','15','D','10','2',NULL,'TPA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerId"','3','(''UA''=''T,'')','ENUEDDFSAXZ0','10','D','10','3',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountTypeCode"','4','(''UA''=''T,'')','ENUEDDFSAXZ0','20','D','10','4',NULL,'Account Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId"','5','(''UA''=''T,'')','ENUEDDFSAXZ0','15','D','10','5',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanStartDate"','6','(''UD101''=''T,'')','ENUEDDFSAXZ0','30','D','10','6',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEndDate"','7','(''UD101''=''T,'')','ENUEDDFSAXZ0','30','D','10','7',NULL,'Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','8','(''UA''=''T,'')','ENUEDDFSAXZ0','30','D','10','8',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepositType"','9','(''UA''=''T,'')','ENUEDDFSAXZ0','18','D','10','9',NULL,'Deposit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDepositAmount"','10','(''UA''=''T,'')','ENUEDDFSAXZ0','12','D','10','10',NULL,'Employee Deposit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERDepositAmt"','11','(''UA''=''T,'')','ENUEDDFSAXZ0','9','D','10','11',NULL,'Employer Deposit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCardHolder"','12','(''UD112''=''T,'')','ENUEDDFSAXZ0','8','D','10','12',NULL,'Display to cardholder',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisplayDate"','13','(''UD101''=''T,'')','ENUEDDFSAXZ0','10','D','10','13',NULL,'Display date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','14','(''UD101''=''T'')','ENUEDDFSAXZ0','10','D','10','14',NULL,'Effective Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ENUEDDFSAX_20201022.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202008319','EMPEXPORT','OEACTIVE',NULL,'ENUEDDFSAX',NULL,NULL,NULL,'202008319','Nov 27 2019 12:21PM','Nov 27 2019 12:21PM','201911201',NULL,'','','201911201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202008319','EMPEXPORT','OEPASSIVE',NULL,'ENUEDDFSAX',NULL,NULL,NULL,'202008319','Nov 27 2019 12:21PM','Nov 27 2019 12:21PM','201911201',NULL,'','','201911201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NueSynergy FSA Payroll Export','202008319','EMPEXPORT','ONDEMAND',NULL,'ENUEDDFSAX',NULL,NULL,NULL,'202008319','Nov 27 2019 12:21PM','Nov 27 2019 12:21PM','201911201',NULL,'','','201911201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202008319','EMPEXPORT','SCHEDULED',NULL,'ENUEDDFSAX',NULL,NULL,NULL,'202008319','Nov 27 2019 12:21PM','Nov 27 2019 12:21PM','201911201',NULL,'','','201911201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202010239','EMPEXPORT','TEST','Oct 22 2020  7:11PM','ENUEDDFSAX',NULL,NULL,NULL,'202010239','Oct 23 2020 12:00AM','Dec 30 1899 12:00AM','202010231','107','eecPayGroup','BIWKH,BIWKW,BWWDS,DEF','202010231',dbo.fn_GetTimedKey(),NULL,'us3cPeWAS1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUEDDFSAX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUEDDFSAX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUEDDFSAX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUEDDFSAX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENUEDDFSAX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ENUEDDFSAX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ENUEDDFSAX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ENUEDDFSAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENUEDDFSAX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENUEDDFSAX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENUEDDFSAX','D10','dbo.U_ENUEDDFSAX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ENUEDDFSAX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENUEDDFSAX] (
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
IF OBJECT_ID('U_ENUEDDFSAX_DedList') IS NULL
CREATE TABLE [dbo].[U_ENUEDDFSAX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ENUEDDFSAX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENUEDDFSAX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvRecordId] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvEmployerId] varchar(10) NOT NULL,
    [drvAccountTypeCode] varchar(3) NULL,
    [drvPlanId] varchar(15) NULL,
    [drvPlanStartDate] datetime NULL,
    [drvPlanEndDate] datetime NULL,
    [drvEmpId] char(11) NULL,
    [drvDepositType] varchar(1) NOT NULL,
    [drvEmployeeDepositAmount] varchar(12) NULL,
    [drvERDepositAmt] varchar(1) NOT NULL,
    [drvCardHolder] varchar(1) NOT NULL,
    [drvDisplayDate] datetime NULL,
    [drvEffectiveDate] datetime NULL
);
IF OBJECT_ID('U_ENUEDDFSAX_EEList') IS NULL
CREATE TABLE [dbo].[U_ENUEDDFSAX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENUEDDFSAX_File') IS NULL
CREATE TABLE [dbo].[U_ENUEDDFSAX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ENUEDDFSAX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENUEDDFSAX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [DCAAmount] numeric NULL,
    [FSAAmount] numeric NULL
);
IF OBJECT_ID('U_ENUEDDFSAX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENUEDDFSAX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENUEDDFSAX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Delta Dental of Washingotn

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/27/2019
Service Request Number: TekP-2019-10-17-0002

Purpose: NueSynergy FSA Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENUEDDFSAX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENUEDDFSAX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENUEDDFSAX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENUEDDFSAX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENUEDDFSAX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUEDDFSAX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUEDDFSAX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUEDDFSAX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENUEDDFSAX', 'TEST';
EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENUEDDFSAX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ENUEDDFSAX', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FedTaxIdNo        VARCHAR(10);

    -- Set FormatCode
    SELECT @FormatCode = 'ENUEDDFSAX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT TOP 1 @FedTaxIdNo = LEFT(CmmFedTaxId, 2) + '-' + RIGHT(CmmFedTaxId, 7) FROM dbo.CompMast WITH (NOLOCK);
    
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENUEDDFSAX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENUEDDFSAX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     DELETE from  dbo.U_ENUEDDFSAX_EEList  where xeeid in (select distinct EEcEEid  from EmpComp where EecEEType = 'TES')


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA4,FSADC,FSAHC,FSAI,FSAL,FSAMD,FSANM,FSANO,FSAO,FSAU,FSAMD';

    



    IF OBJECT_ID('U_ENUEDDFSAX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENUEDDFSAX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENUEDDFSAX_DedList
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
    IF OBJECT_ID('U_ENUEDDFSAX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENUEDDFSAX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,DCAAmount     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,FSAAmount     = SUM(CASE WHEN PdhDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU','FSAMD') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ENUEDDFSAX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENUEDDFSAX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ENUEDDFSAX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENUEDDFSAX_PEarHist;
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
    INTO dbo.U_ENUEDDFSAX_PEarHist
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
    -- DETAIL RECORD - U_ENUEDDFSAX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENUEDDFSAX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENUEDDFSAX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepssn
        ,drvRecordId = 'IH'
        ,drvTPAID = 'T00445'
        ,drvEmployerId = 'NUEDELTAWA' --@FedTaxIdNo -- '597-84-5612'
        ,drvAccountTypeCode =    CASE WHEN ISNULL(bdmDedCode, '') <> '' THEN
                                    CASE WHEN bdmDedCode  in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU', 'FSAMD') THEN  'FSA'
                                        WHEN bdmDedCode  in ('FSADC') THEN 'DCA'
                                    END 
                                ELSE
                                    CASE WHEN pdhDedCode  in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN  'FSA'
                                        WHEN pdhDedCode  in ('FSADC') THEN 'DCA'
                                    END  
                                END
        ,drvPlanId =    CASE WHEN ISNULL(bdmDedCode, '') <> '' THEN
                            CASE WHEN bdmDedCode  in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU','FSAMD') THEN  concat('FSA',YEAR(GETDATE()))
                                WHEN bdmDedCode  in ('FSADC') THEN  concat('DCA',YEAR(GETDATE()))
                            END
                        ELSE
                            CASE WHEN pdhDedCode  in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN  concat('FSA',YEAR(GETDATE()))
                                WHEN pdhDedCode  in ('FSADC') THEN  concat('DCS',YEAR(GETDATE()))
                            END
                        END
        ,drvPlanStartDate =    CASE WHEN ISNULL(bdmDedCode, '') <> '' THEN bdmBenStartDate
                            ELSE (select TOP 1 EdhBenSTartDate FROM EmpHDed WHERE EdhEEID = xEEID AND EdhBenStatus <> 'A' and EDhDedCode = pdhDedCode)                                
                            END
        ,drvPlanEndDate =    CASE WHEN ISNULL(bdmDedCode, '') <> '' THEN bdmBenStopDate
                            ELSE (select TOP 1 EdhBenStopDate FROM EmpHDed WHERE EdhEEID = xEEID AND EdhBenStatus <> 'A' and EDhDedCode = pdhDedCode)                                
                            END
        /*CASE WHEN ISNULL(bdmDedCode, '') <> '' THEN
                                CASE WHEN bdmDedCode  in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN  bdmBenStopDate
                                    WHEN bdmDedCode  in ('FSADC') THEN bdmBenStopDate
                                END
                            ELSE
                                CASE WHEN pdhDedCode  in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN  bdmBenStopDate
                                    WHEN pdhDedCode  in ('FSADC') THEN bdmBenStopDate
                                END
                            END*/
        ,drvEmpId = eepssn
        ,drvDepositType = '1'
        ,drvEmployeeDepositAmount =    CASE WHEN ISNULL(bdmDedCode, '') <> '' THEN
                                        CASE WHEN BdmDedCode = 'FSADC' THEN CAST(CONVERT(DECIMAL(10,2),DCAAmount) as varchar(12))
                                            WHEN BdmDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU', 'FSAMD') THEN CAST(CONVERT(DECIMAL(10,2),FSAAmount) as varchar(12))
                                        END
                                    ELSE
                                        CASE WHEN pdhDedCode = 'FSADC' THEN CAST(CONVERT(DECIMAL(10,2),DCAAmount) as varchar(12))
                                            WHEN pdhDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU', 'FSAMD') THEN CAST(CONVERT(DECIMAL(10,2),FSAAmount) as varchar(12))
                                        END
                                    END
        ,drvERDepositAmt = ''
        ,drvCardHolder = '1'
        ,drvDisplayDate = prgpaydate
        ,drvEffectiveDate = prgpaydate
    INTO dbo.U_ENUEDDFSAX_drvTbl
    FROM dbo.U_ENUEDDFSAX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        On EEPEEID = XEEID
    LEFT JOIN dbo.U_dsi_BDM_ENUEDDFSAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRecType = 'EMP'
    JOIN dbo.U_ENUEDDFSAX_PEarHist WITH (NOLOCK)
        ON PEHEEID = XEEID
    JOIN dbo.U_ENUEDDFSAX_PDedHist WITH (NOLOCK)
      ON PDHEEID = XEEID
    JOIN dbo.pDedHist a WITH (NOLOCK)
        ON a.pdhEEID = xEEID 
        AND PdhDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU', 'FSADC','FSAMD') 
        AND pdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    --JOIN dbo.pDedHist WITH (NOLOCK)
     --WHERE bdmRecType = 'EMP'
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
ALTER VIEW dbo.dsi_vwENUEDDFSAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENUEDDFSAX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENUEDDFSAX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911201'
       ,expStartPerControl     = '201911201'
       ,expLastEndPerControl   = '201911279'
       ,expEndPerControl       = '201911279'
WHERE expFormatCode = 'ENUEDDFSAX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENUEDDFSAX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENUEDDFSAX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort