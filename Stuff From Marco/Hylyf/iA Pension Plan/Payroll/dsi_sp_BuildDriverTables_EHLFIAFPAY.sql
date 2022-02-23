SET NOCOUNT ON;
IF OBJECT_ID('U_EHLFIAFPAY_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHLFIAFPAY_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHLFIAFPAY' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHLFIAFPAY_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHLFIAFPAY_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHLFIAFPAY') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLFIAFPAY];
GO
IF OBJECT_ID('U_EHLFIAFPAY_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_PEarHist];
GO
IF OBJECT_ID('U_EHLFIAFPAY_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_PDedHist];
GO
IF OBJECT_ID('U_EHLFIAFPAY_ItemList') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_ItemList];
GO
IF OBJECT_ID('U_EHLFIAFPAY_File') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_File];
GO
IF OBJECT_ID('U_EHLFIAFPAY_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_EEList];
GO
IF OBJECT_ID('U_EHLFIAFPAY_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_drvTbl];
GO
IF OBJECT_ID('U_EHLFIAFPAY_DedListPENSN') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_DedListPENSN];
GO
IF OBJECT_ID('U_EHLFIAFPAY_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHLFIAFPAY';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHLFIAFPAY';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHLFIAFPAY';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHLFIAFPAY';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHLFIAFPAY';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHLFIAFPAY','iA Financial Group Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EHLFIAFPAYZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employees SIN"','1','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','1',NULL,'Employee’s Social Insurance Number (SIN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution date"','2','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','2',NULL,'Contribution date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution amount"','3','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','3',NULL,'Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Contribution type"','4','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','4',NULL,'Contribution type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beginning of pay period date"','5','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','5',NULL,'Beginning of pay period date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"End of pay period date"','6','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','6',NULL,'End of pay period date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee’s last name"','7','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','7',NULL,'Employee’s last name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee’s first name"','8','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','8',NULL,'Employee’s first name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Information - Contract"','9','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','9',NULL,'Plan Information - Contract',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Information - Divison"','10','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','10',NULL,'Plan Information - Divison',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spousal contribution"','11','(''DA''=''Q,'')','EHLFIAFPAYZ0','50','H','01','11',NULL,'Spousal contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spousal contribution"','12','(''DA''=''Q'')','EHLFIAFPAYZ0','50','H','01','12',NULL,'Spousal contribution proportion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSIN"','1','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','1',NULL,'Employee’s Social Insurance Number (SIN)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributiondate"','2','(''UD101''=''Q,'')','EHLFIAFPAYZ0','50','D','10','2',NULL,'Contribution date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionamount"','3','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','3',NULL,'Contribution amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributiontype"','4','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','4',NULL,'Contribution type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeginningofpayperioddate"','5','(''UD101''=''Q,'')','EHLFIAFPAYZ0','50','D','10','5',NULL,'Beginning of pay period date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndofpayperioddate"','6','(''UD101''=''Q,'')','EHLFIAFPAYZ0','50','D','10','6',NULL,'End of pay period date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeslastname"','7','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','7',NULL,'Employee’s last name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeesfirstname"','8','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','8',NULL,'Employee’s first name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanInformation"','9','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','9',NULL,'Plan Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanInformation2"','10','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','10',NULL,'Plan Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousalcontribution"','11','(''UA''=''Q,'')','EHLFIAFPAYZ0','50','D','10','11',NULL,'Spousal contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousalcontributionpropor"','12','(''UA''=''Q'')','EHLFIAFPAYZ0','50','D','10','12',NULL,'Spousal contribution proportion',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHLFIAFPAY_20200630.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'iA Financial Group Payroll Exp','202006039','EMPEXPORT','ONDEMAND','Jun 16 2020 12:00AM','EHLFIAFPAY',NULL,NULL,NULL,'202006039','Jun  3 2020 12:00AM','Dec 30 1899 12:00AM','202006031',NULL,'','','202006031',dbo.fn_GetTimedKey(),NULL,'MLAGROSA',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHLFIAFPAY_20200630.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202006039','EMPEXPORT','SCH_IAPH','Jun 16 2020 12:00AM','EHLFIAFPAY',NULL,NULL,NULL,'202006039','Jun  3 2020 12:00AM','Dec 30 1899 12:00AM','202006031','1','','','202006031',dbo.fn_GetTimedKey(),NULL,'MLAGROSA',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHLFIAFPAY_20200630.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202006199','EMPEXPORT','TEST','Jun 29 2020  2:38PM','EHLFIAFPAY',NULL,NULL,NULL,'202006199','Jun 19 2020 12:00AM','Dec 30 1899 12:00AM','202006191','4710','','','202006191',dbo.fn_GetTimedKey(),NULL,'LKING01',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EHLFIAFPAY_20200630.txt' END WHERE expFormatCode = 'EHLFIAFPAY';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLFIAFPAY','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLFIAFPAY','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLFIAFPAY','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHLFIAFPAY','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EHLFIAFPAY' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHLFIAFPAY' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EHLFIAFPAY_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHLFIAFPAY_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHLFIAFPAY','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHLFIAFPAY','D10','dbo.U_EHLFIAFPAY_drvTbl',NULL);
IF OBJECT_ID('U_EHLFIAFPAY_DedList') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_DedListPENSN') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_DedListPENSN] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmployeeSIN] varchar(50) NULL,
    [drvContributiondate] datetime NULL,
    [drvContributionamount] varchar(12) NULL,
    [drvContributiontype] varchar(38) NULL,
    [drvBeginningofpayperioddate] datetime NULL,
    [drvEndofpayperioddate] datetime NULL,
    [drvEmployeeslastname] varchar(100) NULL,
    [drvEmployeesfirstname] varchar(100) NULL,
    [drvPlanInformation] char(10) NULL,
    [drvPlanInformation2] char(10) NULL,
    [drvSpousalcontribution] varchar(1) NOT NULL,
    [drvSpousalcontributionpropor] varchar(1) NOT NULL,
    [PrgPeriodStart] datetime NULL,
    [PrgPeriodEnd] datetime NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_EEList') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_File') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_ItemList') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_ItemList] (
    [Code] varchar(5) NOT NULL,
    [ItemDesc] varchar(35) NOT NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhRegularContrib] numeric NULL,
    [PdhAddContrib] numeric NULL,
    [pdhEmpAddContrib] numeric NULL,
    [pdhErRegContrib] numeric NULL
);
IF OBJECT_ID('U_EHLFIAFPAY_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHLFIAFPAY_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHLFIAFPAY]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: HyLife

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/03/2020
Service Request Number: SR-2016-00012345

Purpose: iA Financial Group Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHLFIAFPAY';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHLFIAFPAY';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHLFIAFPAY';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHLFIAFPAY';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHLFIAFPAY' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHLFIAFPAY', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHLFIAFPAY';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHLFIAFPAY', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHLFIAFPAY';

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
    DELETE FROM dbo.U_EHLFIAFPAY_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHLFIAFPAY_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ADPNU, ADPEN , ADPNN,PNUN2, PENSE, PNUN2, PENSN , PNUN2, PENSE, PNUN2, PENSN ,  RRSPV ';
    --SET @DedList = 'ADPNU, ADPEN , ADPNN,PNUN2, PENSU, PENRN, PENSR, PENSE, PNUN2, PENSN , PNUN2, PENSE, PNUN2, PENSN ,  RRSPV ';

    IF OBJECT_ID('U_EHLFIAFPAY_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHLFIAFPAY_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHLFIAFPAY_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHLFIAFPAY_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHLFIAFPAY_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        
        ,PdhRegularContrib    = SUM(CASE WHEN PdhDedCode IN ('PNUN2','PENSE','PENSN') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhAddContrib            = SUM(CASE WHEN PdhDedCode IN ('RRSPV') THEN PdhEECurAmt ELSE 0.00 END)    
        
        ,pdhEmpAddContrib    = SUM(CASE WHEN PdhDedCode IN ('ADPNU', 'ADPEN' , 'ADPNN') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhErRegContrib    = SUM(CASE WHEN PdhDedCode IN ('PNUN2',  'PENSE', 'PENSN') THEN PdhERCurAmt ELSE 0.00 END)        
        --,pdhErRegContrib    = SUM(CASE WHEN PdhDedCode IN ('PNUN2','PENSU', 'PENRN', 'PENSR', 'PENSE', 'PENSN') THEN PdhERCurAmt ELSE 0.00 END)        

    INTO dbo.U_EHLFIAFPAY_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHLFIAFPAY_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

        -----------------------------
    IF OBJECT_ID('U_EHLFIAFPAY_ItemList','U') IS NOT NULL
        DROP TABLE dbo.U_EHLFIAFPAY_ItemList;
     SELECT
    'EEREG' as Code
    ,'Employee''s regular contribution'  as ItemDesc
    
    INTO dbo.U_EHLFIAFPAY_ItemList 

    UNION ALL
        SELECT 
    'EEADD' as Code
    ,'Employee''s additional  contribution'  as ItemDesc
    UNION ALL
            SELECT 
    'ERREG' as Code
    ,'Employer''s regular contribution'  as ItemDesc

    UNION ALL
            SELECT 
    'EEAD2' as Code
    ,'Employee''s additional contribution'  as ItemDesc
    
    



    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHLFIAFPAY_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHLFIAFPAY_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)x  
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
    INTO dbo.U_EHLFIAFPAY_PEarHist
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
    -- DETAIL RECORD - U_EHLFIAFPAY_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHLFIAFPAY_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHLFIAFPAY_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmployeeSIN = CASE WHEN ISNULL(eepssn,'') <> '' THEN eepssn ELSE EinNationalID END
        ,drvContributiondate = dbo.dsi_fnGetMinMaxDates('MAX',PrgPayDate,Paydate)  
        ,drvContributionamount = CASE WHEN Code = 'EEREG' THEN CAST(CONVERT(DECIMAL(10,2),PdhRegularContrib) as VARCHAR(12))
                                      WHEN Code = 'EEADD' THEN CAST(CONVERT(DECIMAL(10,2),pdhEmpAddContrib) as VARCHAR(12))
                                      WHEN Code = 'ERREG' THEN CAST(CONVERT(DECIMAL(10,2),pdhErRegContrib) as VARCHAR(12))
                                        WHEN Code = 'EEAD2' THEN CAST(CONVERT(DECIMAL(10,2),PdhAddContrib) as VARCHAR(12))


                                END
        ,drvContributiontype =  CASE WHEN Code = 'EEREG' THEN 'Employee''s regular contribution'
                                      WHEN Code = 'EEADD' THEN 'Employee''s additional  contribution'
                                      WHEN Code = 'ERREG' THEN 'Employer''s regular contribution'
                                      WHEN Code = 'EEAD2' THEN 'RRSP - Employee''s regular contribution'
                                END
        ,drvBeginningofpayperioddate = PrgPeriodStart
        ,drvEndofpayperioddate = PrgPeriodEnd
        ,drvEmployeeslastname = EepNameLast
        ,drvEmployeesfirstname = EepNameFirst
        ,drvPlanInformation = EECUDFIELD01
        ,drvPlanInformation2 = EECUDFIELD13
        ,drvSpousalcontribution = ''
        ,drvSpousalcontributionpropor = ''
        ,PrgPeriodStart
        ,PrgPeriodEnd
    INTO dbo.U_EHLFIAFPAY_drvTbl
    FROM dbo.U_EHLFIAFPAY_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_EHLFIAFPAY_PEarHist WITH (NOLOCK)
        on PehEEID = xEEID
    JOIN dbo.U_EHLFIAFPAY_PDedHist  WITH (NOLOCK)
        ON Pdheeid = xeeid
    LEFT JOIN(SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayGroup
        on PayGroup.PgpPayGroup = eecPaygroup
    LEFT JOIN dbo.EmpIntl on eineeid = xeeid
    LEFT JOIN dbo.U_EHLFIAFPAY_ItemList
        on Code <> ''
    ;

    Delete from dbo.U_EHLFIAFPAY_drvTbl where drvContributionAmount  = '0.00'


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
ALTER VIEW dbo.dsi_vwEHLFIAFPAY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHLFIAFPAY_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHLFIAFPAY%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005271'
       ,expStartPerControl     = '202005271'
       ,expLastEndPerControl   = '202006039'
       ,expEndPerControl       = '202006039'
WHERE expFormatCode = 'EHLFIAFPAY';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHLFIAFPAY_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHLFIAFPAY_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort