SET NOCOUNT ON;
IF OBJECT_ID('U_ETAXSVRHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETAXSVRHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETAXSVRHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETAXSVRHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETAXSVRHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETAXSVRHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSVRHSA];
GO
IF OBJECT_ID('U_ETAXSVRHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_PEarHist];
GO
IF OBJECT_ID('U_ETAXSVRHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_PDedHist];
GO
IF OBJECT_ID('U_ETAXSVRHSA_File') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_File];
GO
IF OBJECT_ID('U_ETAXSVRHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_EEList];
GO
IF OBJECT_ID('U_ETAXSVRHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_drvTbl];
GO
IF OBJECT_ID('U_ETAXSVRHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETAXSVRHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETAXSVRHSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETAXSVRHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETAXSVRHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETAXSVRHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETAXSVRHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETAXSVRHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETAXSVRHSA','TaxSaver HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ETAXSVRHSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','1','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','1',NULL,'Employee Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','2','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','2',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','3','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','3',NULL,'Employee First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMI"','4','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','4',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHsaEEContPerPeriod"','5','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','5',NULL,'HSA EE Contribution per pay period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHsaEEYtdAccum"','6','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','6',NULL,'HSA EE YTD Accumulator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHsaERContPerPeriod"','7','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','7',NULL,'HSA ER Contribution per pay period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHsaERYtdAccum"','8','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','8',NULL,'HSA ER YTD Accumulator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSABenEligDate"','9','(''UD101''=''T,'')','ETAXSVRHSAZ0','50','D','10','9',NULL,'HSA Benefit Eligibility Date (mm/dd/yy)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSABenTermDate"','10','(''UD101''=''T,'')','ETAXSVRHSAZ0','50','D','10','10',NULL,'HSA  Benefit Term Date (mm/dd/yy)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','11','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','11',NULL,'Participants phone number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateOfBirth"','12','(''UD101''=''T,'')','ETAXSVRHSAZ0','50','D','10','12',NULL,'Participants DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','13',NULL,'Employee Street Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','14',NULL,'Employee Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','16',NULL,'State abbreviation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','17','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','17',NULL,'Zip code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepOrLoc"','18','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','18',NULL,'Department or Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDebitCard"','19','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','19',NULL,'Y or N (only necessary if you give your participan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmailAddr"','20','(''UA''=''T,'')','ETAXSVRHSAZ0','50','D','10','20',NULL,'Employee email address (work or home)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPayCycle"','21','(''UA''=''T'')','ETAXSVRHSAZ0','50','D','10','21',NULL,'Pay Cycle (W,B,S,M)',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETAXSVRHSA_20200316.txt',NULL,'','','',NULL,NULL,NULL,'TaxSaver HSA Export','202001219','EMPEXPORT','ONDEMAND','Dec  5 2019  8:36AM','ETAXSVRHSA',NULL,NULL,NULL,'202001219','Dec  5 2019  5:56AM','Dec  5 2019  5:56AM','202001212','32','','','202001212',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETAXSVRHSA_20200316.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202001219','EMPEXPORT','SCHEDULED','Dec  5 2019  8:36AM','ETAXSVRHSA',NULL,NULL,NULL,'202001219','Dec  5 2019  5:56AM','Dec  5 2019  5:56AM','202001212','32','','','202001212',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETAXSVRHSA_20200316.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001219','EMPEXPORT','OEACTIVE','Dec  5 2019  8:36AM','ETAXSVRHSA',NULL,NULL,NULL,'202001219','Dec  5 2019  5:56AM','Dec  5 2019  5:56AM','202001212','0','','','202001212',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETAXSVRHSA_20200316.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001219','EMPEXPORT','OEPASSIVE','Dec  5 2019  8:36AM','ETAXSVRHSA',NULL,NULL,NULL,'202001219','Dec  5 2019  5:56AM','Dec  5 2019  5:56AM','202001212','32','','','202001212',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETAXSVRHSA_20200316.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001219','EMPEXPORT','TEST','Jan  2 2020  1:03PM','ETAXSVRHSA',NULL,NULL,NULL,'202001219','Jan  3 2020 12:00AM','Dec 30 1899 12:00AM','202001212','28','eecPayGroup','KEY','202001212',dbo.fn_GetTimedKey(),NULL,'us3lKiTRU1009',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ETAXSVRHSA_20200316.txt' END WHERE expFormatCode = 'ETAXSVRHSA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRHSA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRHSA','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSVRHSA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ETAXSVRHSA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETAXSVRHSA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ETAXSVRHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETAXSVRHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSVRHSA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSVRHSA','D10','dbo.U_ETAXSVRHSA_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETAXSVRHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETAXSVRHSA] (
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
IF OBJECT_ID('U_ETAXSVRHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETAXSVRHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMI] varchar(1) NULL,
    [drvHsaEEContPerPeriod] nvarchar(4000) NULL,
    [drvHsaEEYtdAccum] nvarchar(4000) NULL,
    [drvHsaERContPerPeriod] varchar(1) NOT NULL,
    [drvHsaERYtdAccum] varchar(1) NOT NULL,
    [drvHSABenEligDate] datetime NULL,
    [drvHSABenTermDate] datetime NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmpDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvDepOrLoc] varchar(25) NULL,
    [drvDebitCard] varchar(1) NOT NULL,
    [drvEmpEmailAddr] varchar(50) NULL,
    [drvEmpPayCycle] varchar(1) NULL
);
IF OBJECT_ID('U_ETAXSVRHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETAXSVRHSA_File') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ETAXSVRHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhHsaCurAmt] numeric NULL,
    [PdhHsaYtdAmt] numeric NULL
);
IF OBJECT_ID('U_ETAXSVRHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETAXSVRHSA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSVRHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Truman Arnold Company

Created By: Marco Lagrosa/James Bender
Business Analyst: Lea King
Create Date: 12/05/2019
Service Request Number: TekP-2019-10-25-0003

Purpose: TaxSaver HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETAXSVRHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETAXSVRHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETAXSVRHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETAXSVRHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETAXSVRHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSVRHSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSVRHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSVRHSA', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETAXSVRHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETAXSVRHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETAXSVRHSA';

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
    DELETE FROM dbo.U_ETAXSVRHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETAXSVRHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA,HSAFA,HSAC';

    IF OBJECT_ID('U_ETAXSVRHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETAXSVRHSA_DedList
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
    IF OBJECT_ID('U_ETAXSVRHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --,PdhHsaCurAmt     = SUM(CASE WHEN PdhDedCode IN ('HSA', 'HSAFA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHsaCurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode IN ('HSA', 'HSAFA', 'HSAC') THEN PdhEECurAmt ELSE 0.00 END)     
        ,PdhHsaYtdAmt = SUM(CASE WHEN LEFT(PdhPerControl, 4) BETWEEN LEFT(@StartPerControl, 4) AND LEFT(@EndPerControl, 4) AND PdhDedCode IN ('HSA', 'HSAFA', 'HSAC') THEN PdhEECurAmt ELSE 0.00 END)
        /*,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_ETAXSVRHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETAXSVRHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETAXSVRHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRHSA_PEarHist;
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
    INTO dbo.U_ETAXSVRHSA_PEarHist
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
    -- DETAIL RECORD - U_ETAXSVRHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETAXSVRHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSVRHSA_drvTbl;
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
        ,drvHsaEEContPerPeriod = CASE WHEN BdmDedCode in ('HSA', 'HSAFA', 'HSAC') THEN FORMAT(PdhHsaCurAmt, '#0.00') END
        ,drvHsaEEYtdAccum = CASE WHEN BdmDedCode in ('HSA', 'HSAFA', 'HSAC') THEN FORMAT(PdhHsaYtdAmt, '#0.00') END
        ,drvHsaERContPerPeriod = ''
        ,drvHsaERYtdAccum = ''
        ,drvHSABenEligDate = CASE WHEN BdmDedCode in ('HSA', 'HSAFA', 'HSAC') THEN BdmBenStartDate END
        ,drvHSABenTermDate = CASE WHEN BdmDedCode in ('HSA', 'HSAFA', 'HSAC') THEN BdmBenStopDate END
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmpDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvDepOrLoc = LocDesc
        ,drvDebitCard = 'Y'
        ,drvEmpEmailAddr = CASE WHEN ISNULL(EepAddressEMailAlternate, '') <> '' THEN EepAddressEMailAlternate ELSE EepAddressEmail END
        ,drvEmpPayCycle = CASE WHEN PgrPayFrequency = 'B' THEN 'B' END
    INTO dbo.U_ETAXSVRHSA_drvTbl
    FROM dbo.U_ETAXSVRHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETAXSVRHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ETAXSVRHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    WHERE EecEmplStatus NOT IN ('T')
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
ALTER VIEW dbo.dsi_vwETAXSVRHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETAXSVRHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETAXSVRHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912011'
       ,expStartPerControl     = '201912101'
       ,expLastEndPerControl   = '201912319'
       ,expEndPerControl       = '201912319'
WHERE expFormatCode = 'ETAXSVRHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETAXSVRHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETAXSVRHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort