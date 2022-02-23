SET NOCOUNT ON;
IF OBJECT_ID('U_ETAXSVRFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETAXSVRFSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETAXSVRFSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETAXSVRFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETAXSVRFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETAXSVRFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSVRFSA];
GO
IF OBJECT_ID('U_ETAXSVRFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_PEarHist];
GO
IF OBJECT_ID('U_ETAXSVRFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_PDedHist];
GO
IF OBJECT_ID('U_ETAXSVRFSA_File') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_File];
GO
IF OBJECT_ID('U_ETAXSVRFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_EEList];
GO
IF OBJECT_ID('U_ETAXSVRFSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_drvTbl];
GO
IF OBJECT_ID('U_ETAXSVRFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETAXSVRFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETAXSVRFSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETAXSVRFSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETAXSVRFSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETAXSVRFSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETAXSVRFSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETAXSVRFSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETAXSVRFSA','TaxSaver Combined FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ETAXSVRFSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETAXSVRFSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','1','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','1',NULL,'Employee Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','2','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','2',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','3','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','3',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMI"','4','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','4',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrFsaDed"','5','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','5',NULL,'Current deduction for Health FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrFsaYtd"','6','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','6',NULL,'Current Year to Date for Health FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGoalFsaAmt"','7','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','7',NULL,'Annual Goal amount for Health FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSABenEligDate"','8','(''UD101''=''T,'')','ETAXSVRFSAZ0','50','D','10','8',NULL,'Benefit Eligibility Date (mm/dd/yy)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSABenTermDate"','9','(''UD101''=''T,'')','ETAXSVRFSAZ0','50','D','10','9',NULL,'Benefit Termination Date (mm/dd/yy)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDayCareFSADed"','10','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','10',NULL,'Current deduction for Day Care FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrYtdDayCareAmt"','11','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','11',NULL,'Current Year to Date for Day Care FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnDayCareGoalAmt"','12','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','12',NULL,'Annual Goal for Day Care FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepBenEligDate"','13','(''UD101''=''T,'')','ETAXSVRFSAZ0','50','D','10','13',NULL,'Benefit Eligibility Date (mm/dd/yy)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepBenTermDate"','14','(''UD101''=''T,'')','ETAXSVRFSAZ0','50','D','10','14',NULL,'Benefit Termination Date (mm/dd/yy)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','15','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','15',NULL,'Employee Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','16',NULL,'Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','18',NULL,'State abbreviation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','19','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','19',NULL,'Zip code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepOrLoc"','20','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','20',NULL,'Department or Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpChecAcct"','21','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','21',NULL,'Employee Checking Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAbaNum"','22','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','22',NULL,'Employee ABA Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckingOrSavings"','23','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','24',NULL,'"22" or "32" to indicate whether account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDebitCard"','24','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','24',NULL,'Y or N (only necessary if you give your participan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlan"','25','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','25',NULL,'Health Plan elected (please talk w/ Taxsaver Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmailAddr"','26','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','26',NULL,'Employee email address (work or home)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPayCycle"','27','(''UA''=''T,'')','ETAXSVRFSAZ0','50','D','10','27',NULL,'Pay Cycle (W,B,S,M)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLimitedFSA"','28','(''UA''=''T'')','ETAXSVRFSAZ0','50','D','10','28',NULL,'Limited FSA Flag',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETAXSVRFSA_20210204.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','201912319','EMPEXPORT','OEACTIVE','Jan 21 2021  1:59PM','ETAXSVRFSA',NULL,NULL,NULL,'201912319','Dec  3 2019  8:56AM','Dec  3 2019  8:56AM','201912011','0','','','201912011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201912319','EMPEXPORT','OEPASSIVE','Dec  5 2019  5:59AM','ETAXSVRFSA',NULL,NULL,NULL,'201912319','Dec  3 2019  8:56AM','Dec  3 2019  8:56AM','201912011','120','','','201912011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TaxSaver FSA Export','201912319','EMPEXPORT','ONDEMAND','Dec  5 2019  5:35AM','ETAXSVRFSA',NULL,NULL,NULL,'201912319','Dec  3 2019  8:56AM','Dec  3 2019  8:56AM','201912011','120','','','201912011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201912319','EMPEXPORT','SCH_TXSVR','Dec  5 2019  5:36AM','ETAXSVRFSA',NULL,NULL,NULL,'201912319','Dec  3 2019  8:56AM','Dec  3 2019  8:56AM','201912011','120','','','201912011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202101159','EMPEXPORT','TEST','Feb  3 2021  4:50PM','ETAXSVRFSA',NULL,NULL,NULL,'202101159','Jan 15 2021 12:00AM','Dec 30 1899 12:00AM','202101081','55','','BIWEEK,SEMIMO','202101081',dbo.fn_GetTimedKey(),NULL,'us3lKiALK1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRFSA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRFSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETAXSVRFSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETAXSVRFSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETAXSVRFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRFSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSVRFSA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSVRFSA','D10','dbo.U_ETAXSVRFSA_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETAXSVRFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETAXSVRFSA] (
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
IF OBJECT_ID('U_ETAXSVRFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETAXSVRFSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRFSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMI] varchar(1) NULL,
    [drvCurrFsaDed] nvarchar(4000) NULL,
    [drvCurrFsaYtd] varchar(256) NULL,
    [drvGoalFsaAmt] nvarchar(4000) NULL,
    [drvFSABenEligDate] datetime NULL,
    [drvFSABenTermDate] datetime NULL,
    [drvDayCareFSADed] nvarchar(4000) NULL,
    [drvCurrYtdDayCareAmt] varchar(256) NULL,
    [drvAnnDayCareGoalAmt] nvarchar(4000) NULL,
    [drvDepBenEligDate] datetime NULL,
    [drvDepBenTermDate] datetime NULL,
    [drvAddressLine1] nvarchar(258) NULL,
    [drvAddressLine2] nvarchar(258) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvDepOrLoc] varchar(1) NOT NULL,
    [drvEmpChecAcct] varchar(1) NOT NULL,
    [drvEmpAbaNum] varchar(1) NOT NULL,
    [drvCheckingOrSavings] varchar(1) NOT NULL,
    [drvDebitCard] varchar(1) NOT NULL,
    [drvHealthPlan] varchar(1) NOT NULL,
    [drvEmpEmailAddr] varchar(50) NULL,
    [drvEmpPayCycle] char(1) NULL,
    [drvLimitedFSA] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ETAXSVRFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETAXSVRFSA_File') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ETAXSVRFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [FsaAmount] numeric NULL,
    [DepcaAmount] numeric NULL
);
IF OBJECT_ID('U_ETAXSVRFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRFSA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSVRFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Alkami Technology

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/20/2021
Service Request Number: TekP-2020-12-04-0003

Purpose: TaxSaver FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETAXSVRFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETAXSVRFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETAXSVRFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETAXSVRFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETAXSVRFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSVRFSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSVRFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSVRFSA', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETAXSVRFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETAXSVRFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETAXSVRFSA';

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
    DELETE FROM dbo.U_ETAXSVRFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETAXSVRFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ETAXSVRFSA_EEList where xEEID IN (SELECT EecEEID from EmpComp where EecEEType = 'TES')
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSADC,FSA,HDHP,PPO';

    IF OBJECT_ID('U_ETAXSVRFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETAXSVRFSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate -30);
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

    UPDATE dbo.U_dsi_bdm_ETAXSVRFSA
        SET BdmUSGField2 = eedeeytdamt 
    FROM dbo.U_dsi_bdm_ETAXSVRFSA 
    JOIN dbo.EmpDed B WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' and eeddedcode in ('FSA','FSADC')
    
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETAXSVRFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,FsaAmount     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,DepcaAmount     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)

    INTO dbo.U_ETAXSVRFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETAXSVRFSA_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETAXSVRFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRFSA_PEarHist;
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
    INTO dbo.U_ETAXSVRFSA_PEarHist
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
    -- DETAIL RECORD - U_ETAXSVRFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETAXSVRFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpSSN = eepSSN
        ,drvEmpLastName = EepNameLast
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMI = CASE WHEN ISNULL(EepNameMiddle, '') <> '' THEN LEFT(EepNameMiddle, 1) END

        ,drvCurrFsaDed = CASE WHEN ISNULL(FsaCode, '') <> '' THEN FORMAT(FsaAmount, '##.00') END
        ,drvCurrFsaYtd = CASE WHEN ISNULL(FsaCode, '') <> '' THEN FsaGtdAmt END 
        ,drvGoalFsaAmt = CASE WHEN ISNULL(FsaCode, '') <> '' THEN FORMAT(FsaGoalAmt, '##.00') END
        ,drvFSABenEligDate = CASE WHEN ISNULL(FsaCode, '') <> '' THEN FsaStartDate END
        ,drvFSABenTermDate = CASE WHEN ISNULL(FsaCode, '') <> '' THEN FsaStopDate END
        ,drvDayCareFSADed = CASE WHEN ISNULL(DepcaCode, '') <> '' THEN FORMAT(DepcaAmount, '##.00') END 
        ,drvCurrYtdDayCareAmt = CASE WHEN ISNULL(DepcaCode, '') <> '' THEN DepcaGtdAmt END  
        ,drvAnnDayCareGoalAmt = CASE WHEN ISNULL(DepcaCode, '') <> '' THEN FORMAT(DepcaGoalAmt, '##.00') END 
        ,drvDepBenEligDate =  CASE WHEN ISNULL(DepcaCode, '') <> '' THEN DepcaStartDate END 
        ,drvDepBenTermDate = CASE WHEN ISNULL(DepcaCode, '') <> '' THEN DepcaStopDate END 
        ,drvAddressLine1 = Quotename(EepAddressLine1,'"')
        ,drvAddressLine2 = Quotename(EepAddressLine2,'"')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvDepOrLoc = ''--(select top 1 LocDesc from Location where LocCode  = eecLocation)
        ,drvEmpChecAcct = ''
        ,drvEmpAbaNum = ''
        ,drvCheckingOrSavings = ''
        ,drvDebitCard = 'Y'
        --if eeddedcode = HDHP or PPO and eedbenstatus = A  send Y else send N
        ,drvHealthPlan =  CASE WHEN HDHPORPPO is not null and HDHPORPPO_BenStatus ='A' THEN 'Y' ELSE 'N' END
        ,drvEmpEmailAddr = EepAddressEMail
        ,drvEmpPayCycle = eecpayperiod
        ,drvLimitedFSA = 'N'
    INTO dbo.U_ETAXSVRFSA_drvTbl
    FROM dbo.U_ETAXSVRFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  bdmEEID,bdmcoid
            ,FsaCode = MAX((CASE WHEN BDMDedCode = 'FSA' then BDMDedCode END))
            ,FsaAmt = SUM(CASE WHEN BDMDedCode = 'FSA' THEN BdmEEAmt ELSE 0 END)
            ,FsaGtdAmt = MAX(CASE WHEN BDMDedCode = 'FSA' THEN BdmUSgField2 END)
            ,FsaGoalAmt = SUM(CASE WHEN BDMDedCode = 'FSA' THEN BdmEEGoalAmt ELSE 0 END)
            ,FsaStartDate = MAX((CASE WHEN BDMDedCode = 'FSA' then  BdmBenStartDate END))
            ,FsaStopDate = MAX((CASE WHEN BDMDedCode = 'FSA' then  BdmBenStopDate END))
            ,DepcaCode = MAX((CASE WHEN BDMDedCode = 'FSADC' then BDMDedCode END))
            ,DepcaAmt = SUM(CASE WHEN BDMDedCode = 'FSADC' THEN BdmEEAmt ELSE 0 END)
            ,DepcaGtdAmt = MAX(CASE WHEN BDMDedCode = 'FSADC' THEN BdmUSgField2 END)
            ,DepcaGoalAmt = SUM(CASE WHEN BDMDedCode = 'FSADC' THEN BdmEEGoalAmt ELSE 0 END)
            ,DepcaStartDate = MAX((CASE WHEN BDMDedCode = 'FSADC' then  BdmBenStartDate END))
            ,DepcaStopDate = MAX((CASE WHEN BDMDedCode = 'FSADC' then  BdmBenStopDate END)) 
            ,HDHPORPPO = MAX((CASE WHEN BDMDedCode IN('HDHP','PPO') then BDMDedCode END))
             ,HDHPORPPO_BenStatus = MAX((CASE WHEN BDMDedCode IN('HDHP','PPO') then Bdmbenstatus END))
               
            from dbo.U_dsi_BDM_ETAXSVRFSA a WITH (NOLOCK) group by bdmEEID, bdmcoid) as BdmConsolidated
            ON bdmEEID = xEEID
            AND BdmCOID = xCOID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_ETAXSVRFSA_PDedHist
        ON pdhEEID = xEEID
    WHERE --EecEEType NOT IN  ('TES')
        --AND 
        EecEmplStatus NOT IN  ('T')
        AND (FsaCode IS NOT NULL 
                OR DepcaCode IS NOT NULL
                --OR MedPCode IS NOT NULL
                --OR MedHCode IS NOT NULL
                )
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
ALTER VIEW dbo.dsi_vwETAXSVRFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETAXSVRFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETAXSVRFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912011'
       ,expStartPerControl     = '201912011'
       ,expLastEndPerControl   = '201912319'
       ,expEndPerControl       = '201912319'
WHERE expFormatCode = 'ETAXSVRFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETAXSVRFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETAXSVRFSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort