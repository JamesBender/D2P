SET NOCOUNT ON;
IF OBJECT_ID('U_EEFXPAYROL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEFXPAYROL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEFXPAYROL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEFXPAYROL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEEFXPAYROL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEFXPAYROL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEFXPAYROL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEFXPAYROL];
GO
IF OBJECT_ID('U_EEFXPAYROL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEFXPAYROL_PEarHist];
GO
IF OBJECT_ID('U_EEFXPAYROL_File') IS NOT NULL DROP TABLE [dbo].[U_EEFXPAYROL_File];
GO
IF OBJECT_ID('U_EEFXPAYROL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEFXPAYROL_EEList];
GO
IF OBJECT_ID('U_EEFXPAYROL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEFXPAYROL_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEFXPAYROL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEFXPAYROL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEFXPAYROL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEFXPAYROL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEFXPAYROL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEFXPAYROL','Health EFX Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EEFXPAYROLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EEFXPAYROL' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','1','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Service Hours"','2','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','2',NULL,'Pay Period Service Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD Earnings"','3','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','3',NULL,'YTD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Gross Earnings"','4','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','4',NULL,'Pay Period Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Start Date"','5','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','5',NULL,'Pay Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period End Date"','6','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','6',NULL,'Pay Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"W2 Box 1 Earnings"','7','(''DA''=''T|'')','EEFXPAYROLZ0','50','H','01','7',NULL,'W2 Box 1 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Control Date"','8','(''DA''=''T'')','EEFXPAYROLZ0','50','H','01','8',NULL,'Period Control Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T|'')','EEFXPAYROLZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodServiceHours"','2','(''UA''=''T|'')','EEFXPAYROLZ0','50','D','10','2',NULL,'Pay Period Service Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDEarnings"','3','(''UA''=''T|'')','EEFXPAYROLZ0','50','D','10','3',NULL,'YTD Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodGrossEarnings"','4','(''UA''=''T|'')','EEFXPAYROLZ0','50','D','10','4',NULL,'Pay Period Gross Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodStartDate"','5','(''UD112''=''T|'')','EEFXPAYROLZ0','50','D','10','5',NULL,'Pay Period Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodEndDate"','6','(''UD112''=''T|'')','EEFXPAYROLZ0','50','D','10','6',NULL,'Pay Period End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvW2Box1Earnings"','7','(''UA''=''T|'')','EEFXPAYROLZ0','50','D','10','7',NULL,'W2 Box 1 Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodControlDate"','8','(''UA''=''T'')','EEFXPAYROLZ0','50','D','10','8',NULL,'Period Control Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EEFXPAYROL_20210430.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','Y23F4,1KHF6,1KHLK,1KHQV,FB4R0',NULL,NULL,NULL,'Health EFX Payroll Export','201901319','EMPEXPORT','ONDEMAND','Sep 11 2020  4:20PM','EEFXPAYROL',NULL,NULL,NULL,'201901319','Aug 31 2020 12:00AM','Dec 30 1899 12:00AM','201901011','951','','','201901011',dbo.fn_GetTimedKey(),NULL,'us3jBeMAX1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','Y23F4,1KHF6,1KHLK,1KHQV,FB4R0',NULL,NULL,NULL,'HealthEFX Payroll -6th of mnth','201901319','EMPEXPORT','SCHEDULED','May  5 2020  4:08AM','EEFXPAYROL',NULL,NULL,NULL,'202103319','May  1 2020 11:43AM','May  1 2020 11:43AM','202103011','917','','','201901011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','Y23F4,1KHF6,1KHLK,1KHQV,FB4R0',NULL,NULL,NULL,'Test Purposes Only','202010319','EMPEXPORT','TEST','Apr  2 2021  9:51AM','EEFXPAYROL',NULL,NULL,NULL,'202010319','Oct 31 2020 12:00AM','Dec 30 1899 12:00AM','202010011','958','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3lKiMAX1005',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXPAYROL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXPAYROL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXPAYROL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXPAYROL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEFXPAYROL','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EEFXPAYROL' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EEFXPAYROL' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EEFXPAYROL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEFXPAYROL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEFXPAYROL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEFXPAYROL','D10','dbo.U_EEFXPAYROL_drvTbl',NULL);
IF OBJECT_ID('U_EEFXPAYROL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEFXPAYROL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayPeriodServiceHours] nvarchar(4000) NULL,
    [drvYTDEarnings] nvarchar(4000) NULL,
    [drvPayPeriodGrossEarnings] nvarchar(4000) NULL,
    [drvPayPeriodStartDate] datetime NULL,
    [drvPayPeriodEndDate] datetime NULL,
    [drvW2Box1Earnings] nvarchar(4000) NULL,
    [drvPeriodControlDate] char(9) NULL
);
IF OBJECT_ID('U_EEFXPAYROL_EEList') IS NULL
CREATE TABLE [dbo].[U_EEFXPAYROL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EEFXPAYROL_File') IS NULL
CREATE TABLE [dbo].[U_EEFXPAYROL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EEFXPAYROL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEFXPAYROL_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtAll] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEFXPAYROL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Maxor National Pharm

Created By: James Bender
Business Analyst: Lea King
Create Date: 05/01/2020
Service Request Number: TekP-2020-03-26-0001

Purpose: Health EFX Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEFXPAYROL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEFXPAYROL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEFXPAYROL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEFXPAYROL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEFXPAYROL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEFXPAYROL', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEFXPAYROL', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEFXPAYROL';

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
    DELETE FROM dbo.U_EEFXPAYROL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEFXPAYROL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EEFXPAYROL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEFXPAYROL_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtAll              = SUM(CASE WHEN PehPerControl >= FORMAT(DATEPART(YEAR, GETDATE()), '####') + '01011' THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode NOT IN ('D075', 'D100', 'D150', 'D200', 'D225', 'D300')  THEN PehCurHrs ELSE 0.00 END)
        
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnExclInTotalHours = 'N' AND ErnEarnCode NOT IN ('PTOPO','SPTOP')  THEN PehCurHrs ELSE 0.00 END)
        
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EEFXPAYROL_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON PehEarnCode = ErnEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEFXPAYROL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEFXPAYROL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEFXPAYROL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPayPeriodServiceHours = FORMAT(PehCurHrs, '#0.00')
        ,drvYTDEarnings = FORMAT(PehCurAmtAll, '#0.00')
        ,drvPayPeriodGrossEarnings = FORMAT(PehCurAmt, '#0.00')
        ,drvPayPeriodStartDate = PayPeriodStart --pgrPeriodStartDate
        ,drvPayPeriodEndDate = PayPeriodEnd --pgrPeriodEndDate
        ,drvW2Box1Earnings = FORMAT(W2Box1Earnings, '#0.00')
        ,drvPeriodControlDate = PgpPeriodControl -- pgrPeriodControl
    INTO dbo.U_EEFXPAYROL_drvTbl
    FROM dbo.U_EEFXPAYROL_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EEFXPAYROL_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
--    JOIN dbo.PayGroup WITH (NOLOCK)
        --ON PgrPayGroup = EecPayGroup
    JOIN (
            SELECT PthEEID, /*PthCOID,*/ SUM(PthCurTaxableWages) AS W2Box1Earnings
            FROM dbo.PTaxHist WITH (NOLOCK)
            WHERE PthPerControl BETWEEN @StartPerControl AND @EndPerControl
                AND PthTaxCode = 'USFIT'
            GROUP BY PthEEID/*, PthCOID*/) AS W2Earnings
        ON PthEEID = xEEID
    JOIN (
            SELECT PgpPayGroup, MIN(PgpPeriodStartDate) AS PayPeriodStart, MAX(PgpPeriodEndDAte) AS PayPeriodEnd, MAX(PgpPeriodControl) AS PgpPeriodControl
            FROM PgPayPer 
            where PgpPayDate BETWEEN @StartDate and @EndDate
            GROUP BY PgpPayGroup
            ) AS PayPeriods
        ON PgpPayGroup = EecPayGroup
    /*LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
        AND PthCOID = xCOID
        AND PthPerControl BETWEEN @StartPerControl AND @EndPerControl
        AND PthTaxCode = 'USFIT'*/
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
ALTER VIEW dbo.dsi_vwEEFXPAYROL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEFXPAYROL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEFXPAYROL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007011'
       ,expStartPerControl     = '202005011'
       ,expLastEndPerControl   = '202007319'
       ,expEndPerControl       = '20200319'
WHERE expFormatCode = 'EEFXPAYROL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEFXPAYROL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEFXPAYROL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort