SET NOCOUNT ON;
IF OBJECT_ID('U_ECYCFSAHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECYCFSAHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECYCFSAHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECYCFSAHSA_G10_BKP_2021_PROD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCFSAHSA_G10_BKP_2021_PROD_Export];
GO
IF OBJECT_ID('dsi_vwECYCFSAHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCFSAHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCFSAHSA_G10_BKP_2021_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCFSAHSA_G10_BKP_2021_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCFSAHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCFSAHSA];
GO
IF OBJECT_ID('U_ECYCFSAHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_PEarHist];
GO
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_File];
GO
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList];
GO
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl];
GO
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList];
GO
IF OBJECT_ID('U_ECYCFSAHSA_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_File];
GO
IF OBJECT_ID('U_ECYCFSAHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_EEList];
GO
IF OBJECT_ID('U_ECYCFSAHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_drvTbl];
GO
IF OBJECT_ID('U_ECYCFSAHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECYCFSAHSA_G10_BKP_2021_PROD') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECYCFSAHSA_G10_BKP_2021_PROD];
GO
IF OBJECT_ID('U_dsi_BDM_ECYCFSAHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECYCFSAHSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECYCFSAHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECYCFSAHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECYCFSAHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECYCFSAHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECYCFSAHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECYCFSAHSA','ConnectYourCare Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','300','S','N','ECYCFSAHSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECYCFSAHSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''F'')','ECYCFSAHSAZ0','11','D','10','1',NULL,'Account SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','2','(''UA''=''F'')','ECYCFSAHSAZ0','30','D','10','12',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','ECYCFSAHSAZ0','30','D','10','42',NULL,'Partner Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','ECYCFSAHSAZ0','30','D','10','72',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionType"','5','(''UA''=''F'')','ECYCFSAHSAZ0','2','D','10','102',NULL,'Transaction Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionEffDate"','6','(''UA''=''F'')','ECYCFSAHSAZ0','8','D','10','104',NULL,'Transaction Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','ECYCFSAHSAZ0','8','D','10','112',NULL,'Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARATHONHEALTH"','8','(''DA''=''F'')','ECYCFSAHSAZ0','20','D','10','120',NULL,'Enrollment Submitter ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARATHONHEALTH"','9','(''DA''=''F'')','ECYCFSAHSAZ0','30','D','10','140',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerOfferingID"','10','(''UA''=''F'')','ECYCFSAHSAZ0','30','D','10','170',NULL,'Employer Offering ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','ECYCFSAHSAZ0','10','D','10','200',NULL,'Option ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','ECYCFSAHSAZ0','10','D','10','210',NULL,'Tier Coverage Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPolicyAmt"','13','(''UA''=''F'')','ECYCFSAHSAZ0','10','D','10','220',NULL,'Total Policy Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','ECYCFSAHSAZ0','8','D','10','230',NULL,'HSA Disclosure Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','ECYCFSAHSAZ0','8','D','10','238',NULL,'HSA Disclosure Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','ECYCFSAHSAZ0','30','D','10','246',NULL,'Partner Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','ECYCFSAHSAZ0','20','D','10','276',NULL,'HSA Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','ECYCFSAHSAZ0','5','D','10','296',NULL,'Filler',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECYCFSAHSA_20210813.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'UEQ5H,UEQBA,UEQ7C,UEQ8J,UEQ9V,UEQGB,UEQDT,UEQF7,UEQCJ,JOA2K,CVUC0',NULL,NULL,NULL,'Active Open Enrollment Export','202012319','EMPEXPORT','OEACTIVE',NULL,'ECYCFSAHSA',NULL,NULL,NULL,'202012319',NULL,NULL,'202010011',NULL,NULL,'','202010011',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202012319','EMPEXPORT','OEPASSIVE',NULL,'ECYCFSAHSA',NULL,NULL,NULL,'202012319','Nov 30 2020  6:30PM','Nov 30 2020  6:30PM','202010011',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','UEQ5H,UEQ7C,UEQ8J,UEQ9V,UEQGB,UEQDT,UEQF7,UEQCJ,JOA2K,CVUC0',NULL,NULL,NULL,'CYC Enrollment - On Demand','202012319','EMPEXPORT','ONDEM_XOE',NULL,'ECYCFSAHSA',NULL,NULL,NULL,'202012319','Nov 30 2020  6:30PM','Nov 30 2020  6:30PM','202010011',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','UEQ5H,UEQBA,UEQ7C,UEQ8J,UEQ9V,UEQGB,UEQDT,UEQF7,UEQCJ,JOA2K,CVUC0',NULL,NULL,NULL,'ConnectYourCare Enroll. Wed@9a','202012319','EMPEXPORT','SCH_ECYCFS',NULL,'ECYCFSAHSA',NULL,NULL,NULL,'202108119','Nov 30 2020  6:30PM','Nov 30 2020  6:30PM','202108041',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',',UEQ5H,UEQBA,UEQ7C,UEQ8J,UEQ9V,UEQGB,UEQDT,UEQF7,UEQCJ,JOA2K,CVUC0',NULL,NULL,NULL,'Testing Purposes Only','202103311','EMPEXPORT','TEST_XOE','Aug  6 2021  1:00PM','ECYCFSAHSA',NULL,NULL,NULL,'202103311','Mar 31 2021 12:00AM','Dec 30 1899 12:00AM','202103011','842','','','202103011',dbo.fn_GetTimedKey(),NULL,'us3kMcMAR1025',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAHSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAHSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECYCFSAHSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECYCFSAHSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECYCFSAHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCFSAHSA','D10','dbo.U_ECYCFSAHSA_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECYCFSAHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECYCFSAHSA] (
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
IF OBJECT_ID('U_dsi_BDM_ECYCFSAHSA_G10_BKP_2021_PROD') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECYCFSAHSA_G10_BKP_2021_PROD] (
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
IF OBJECT_ID('U_ECYCFSAHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvTransactionType] varchar(1) NOT NULL,
    [drvTransactionEffDate] varchar(30) NULL,
    [drvEmployerOfferingID] varchar(10) NULL,
    [drvTotalPolicyAmt] int NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_File') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(300) NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvTransactionType] varchar(1) NOT NULL,
    [drvTransactionEffDate] varchar(30) NULL,
    [drvEmployerOfferingID] varchar(10) NULL,
    [drvTotalPolicyAmt] varchar(30) NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_File') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_G10_BKP_2021_PROD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(300) NULL
);
IF OBJECT_ID('U_ECYCFSAHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAHSA_PEarHist] (
    [PrgEEID] char(12) NOT NULL,
    [PrgDedCode] char(5) NULL,
    [PrgPayDate] datetime NULL,
    [PrgPayPerRemainInYr] smallint NULL,
    [PrgBenStartDate] datetime NULL,
    [PrgRowNo] bigint NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCFSAHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Marathon Health, LLC

Created By: Juanita Fouss
Business Analyst: Lauren Brown-Underwood
Create Date: 11/30/2020
Service Request Number: SR-2020-00297460

Purpose: ConnectYourCare Enrollment Export

Revision History
----------------
Update By           Date            Request Num            Desc
Juanita Fouss        12/22/2020        SR-2020-00297460    Round 1 Testing
Juanita Fouss        12/29/2020        SR-2020-00297460    Round 2 Testing - TotalPolicyAmt to EEAmt * 26, Changed Transaction Type Field
Juanita Fouss        01/06/2021        SR-2020-00297460    ROund 3 TEsting - TotalPolicyAmt to default to 0, not space filled.
Keary McCutchen         07/27/2021           SR-2021-00320531       Update Total Policy Amt
                                       TekP-2021-06-28-0001    

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCFSAHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCFSAHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCFSAHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECYCFSAHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCFSAHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCFSAHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECYCFSAHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Year                VARCHAR(4);
    -- Set FormatCode
    SELECT @FormatCode = 'ECYCFSAHSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '01/01/2021'
        ,@Year              = LEFT(StartPerControl,4)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECYCFSAHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCFSAHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD, FSADC, HSA2, HSA1';

    IF OBJECT_ID('U_ECYCFSAHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECYCFSAHSA_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','20');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','30');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedType', 'FSA')

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

    -----------------------------
    -- Added 7/27/2021 KJM
    -- Working Table - PEarHist
    ----------------------------- 
    IF OBJECT_ID('U_ECYCFSAHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAHSA_PEarHist;
    SELECT DISTINCT
         PrgEEID
        ,PrgDedCode = BdmDedCode
        ,PrgPayDate 
        ,PrgPayPerRemainInYr 
        ,PrgBenStartDate = BdmBenStartDate
        ,PrgRowNo = ROW_NUMBER() OVER (PARTITION BY PrgEEID, BdmDedCode ORDER BY PrgPayDate ASC)
    INTO dbo.U_ECYCFSAHSA_PEarHist
    FROM dbo.U_ECYCFSAHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECYCFSAHSA
        on BdmEEID = xEEID
       AND BdmBenStartDate < PrgPayDate
    ;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECYCFSAHSA_PEarHist ON dbo.U_ECYCFSAHSA_PEarHist (PrgEEID, PrgDedCode,PrgRowNo);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECYCFSAHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECYCFSAHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = EepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = EepSSN
        ,drvEmpNo = EecEmpNo
        ,drvTransactionType = CASE WHEN BdmBenStopDate IS NOT NULL THEN 'L' ELSE 'N' END
        ,drvTransactionEffDate = CASE WHEN BdmBenStatus = 'A' THEN CONVERT(VARCHAR,BdmBenStartDate,112)
                                      WHEN BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR,(BdmBenStopDate + 1),112)
                                      END
        ,drvEmployerOfferingID = CASE WHEN BdmDedCode = 'FSADC' THEN 'DCAPEE' + @Year
                                      WHEN BdmDedCode = 'FSAMD' THEN 'FSAEE' + @Year
                                      WHEN BdmDedCode IN ('HSA2','HSA2C','HSA1C','HSA1') THEN 'HSAEE' + @Year
                                END
        ,drvTotalPolicyAmt = CASE WHEN BdmDedCode IN ('FSADC','FSAMD') AND ISNULL(PrgPayPerRemainInYr,0) <> 0 THEN REPLACE(PrgPayPerRemainInYr * BdmEEAmt,'.','') -- Updated 7/27/21 KJM CASE WHEN BdmDedCode IN ('FSADC','FSAMD') THEN CONVERT(VARCHAR,CONVERT(DECIMAL(18,0),(BdmEEAmt * 26 * 100))) ELSE '0' END
                                  WHEN BdmDedCode IN ('FSADC','FSAMD') AND ISNULL(PrgPayPerRemainInYr,0) = 0 THEN REPLACE(ppeRemainingPayPeriods * BdmEEAmt,'.','') -- Updated 7/27/21 KJM CASE WHEN BdmDedCode IN ('FSADC','FSAMD') THEN CONVERT(VARCHAR,CONVERT(DECIMAL(18,0),(BdmEEAmt * 26 * 100))) ELSE '0' END
                                  ELSE
                                  0
                                  END
    INTO dbo.U_ECYCFSAHSA_drvTbl
    FROM dbo.U_ECYCFSAHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECYCFSAHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT
    JOIN dbo.U_ECYCFSAHSA_PEarHist WITH (NOLOCK)
        ON PrgEEID = xEEID
       AND PrgDedCode = BdmDedCode
       AND PrgRowNo = 1
    JOIN (SELECT ppePayGroup, ppePayDateYear = YEAR(ppePayDate), ppeRemainingPayPeriods = COUNT(DISTINCT ppePayDate)  
            FROM dbo.ppErnSch WITH (NOLOCK) 
           WHERE ppeEarnCode = 'REG'
           GROUP BY ppePayGroup, YEAR(ppePayDate)
         ) ppe
        ON ppePayGroup = EecPayGroup
       AND ppePayDateYear = YEAR(PrgPayDate)
    ;

    INSERT INTO dbo.U_ECYCFSAHSA_drvTbl
    SELECT DISTINCT
        drvEEID
        ,drvCoID
        ,drvInitialSort 
        ,drvSubSort 
        -- standard fields above and additional driver fields below
        ,drvSSN 
        ,drvEmpNo 
        ,drvTransactionType 
        ,drvTransactionEffDate 
        ,drvEmployerOfferingID = 'HSAER' + @Year
        ,drvTotalPolicyAmt 
    FROM dbo.U_ECYCFSAHSA_drvTbl
    WHERE drvEmployerOfferingID LIKE 'HSAEE%'

    --UPDATE MAX Total Policy Amt so it doesnt' exceed 10,500.00
    UPDATE dbo.U_ECYCFSAHSA_drvTbl
    SET drvTotalPolicyAmt = 1050000 
    WHERE drvTotalPolicyAmt > 1050000;
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
ALTER VIEW dbo.dsi_vwECYCFSAHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECYCFSAHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCFSAHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010011'
       ,expStartPerControl     = '202010011'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'ECYCFSAHSA';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCFSAHSA_G10_BKP_2021_PROD]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Marathon Health, LLC

Created By: Juanita Fouss
Business Analyst: Lauren Brown-Underwood
Create Date: 11/30/2020
Service Request Number: SR-2020-00297460

Purpose: ConnectYourCare Enrollment Export

Revision History
----------------
Update By           Date            Request Num            Desc
Juanita Fouss        12/22/2020        SR-2020-00297460    Round 1 Testing
Juanita Fouss        12/29/2020        SR-2020-00297460    Round 2 Testing - TotalPolicyAmt to EEAmt * 26, Changed Transaction Type Field
Juanita Fouss        01/06/2021        SR-2020-00297460    ROund 3 TEsting - TotalPolicyAmt to default to 0, not space filled.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA_G10_BKP_2021_PROD', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA_G10_BKP_2021_PROD', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA_G10_BKP_2021_PROD', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA_G10_BKP_2021_PROD', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAHSA_G10_BKP_2021_PROD', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCFSAHSA_G10_BKP_2021_PROD';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Year                VARCHAR(4);
    -- Set FormatCode
    SELECT @FormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '01/01/2021'
        ,@Year              = LEFT(StartPerControl,4)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD, FSADC, HSA2, HSA1';

    IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','20');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','30');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedType', 'FSA')

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
    -- DETAIL RECORD - U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = EepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = EepSSN
        ,drvEmpNo = EecEmpNo
        ,drvTransactionType = CASE WHEN BdmBenStopDate IS NOT NULL THEN 'L' ELSE 'N' END
        ,drvTransactionEffDate = CASE WHEN BdmBenStatus = 'A' THEN CONVERT(VARCHAR,BdmBenStartDate,112)
                                      WHEN BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR,(BdmBenStopDate + 1),112)
                                      END
        ,drvEmployerOfferingID = CASE WHEN BdmDedCode = 'FSADC' THEN 'DCAPEE' + @Year
                                      WHEN BdmDedCode = 'FSAMD' THEN 'FSAEE' + @Year
                                      WHEN BdmDedCode IN ('HSA2','HSA2C','HSA1C','HSA1') THEN 'HSAEE' + @Year
                                END
        ,drvTotalPolicyAmt = CASE WHEN BdmDedCode IN ('FSADC','FSAMD') THEN CONVERT(VARCHAR,CONVERT(DECIMAL(18,0),(BdmEEAmt * 26 * 100))) ELSE '0' END
    INTO dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl
    FROM dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECYCFSAHSA_G10_BKP_2021_PROD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;


    INSERT INTO dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl
    SELECT DISTINCT
        drvEEID
        ,drvCoID
        ,drvInitialSort 
        ,drvSubSort 
        -- standard fields above and additional driver fields below
        ,drvSSN 
        ,drvEmpNo 
        ,drvTransactionType 
        ,drvTransactionEffDate 
        ,drvEmployerOfferingID = 'HSAER' + @Year
        ,drvTotalPolicyAmt 
    FROM dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_drvTbl
    WHERE drvEmployerOfferingID LIKE 'HSAEE%'


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
ALTER VIEW dbo.dsi_vwECYCFSAHSA_G10_BKP_2021_PROD_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCFSAHSA_G10_BKP_2021_PROD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010011'
       ,expStartPerControl     = '202010011'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'ECYCFSAHSA_G10_BKP_2021_PROD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECYCFSAHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECYCFSAHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort
GO
CREATE VIEW dbo.dsi_vwECYCFSAHSA_G10_BKP_2021_PROD_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECYCFSAHSA_G10_BKP_2021_PROD_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort