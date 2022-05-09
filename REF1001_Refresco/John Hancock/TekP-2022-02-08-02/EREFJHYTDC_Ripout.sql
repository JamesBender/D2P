/**********************************************************************************

EREFJHYTDC: John Hancock YTD Comp

FormatCode:     EREFJHYTDC
Project:        John Hancock YTD Comp
Client ID:      USG1000
Date/time:      2022-04-28 14:12:59.100
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EREFJHYTDC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EREFJHYTDC_SavePath') IS NOT NULL DROP TABLE dbo.U_EREFJHYTDC_SavePath


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EREFJHYTDC'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EREFJHYTDC'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EREFJHYTDC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EREFJHYTDC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EREFJHYTDC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EREFJHYTDC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EREFJHYTDC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EREFJHYTDC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EREFJHYTDC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EREFJHYTDC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EREFJHYTDC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EREFJHYTDC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EREFJHYTDC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEREFJHYTDC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREFJHYTDC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREFJHYTDC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFJHYTDC];
GO
IF OBJECT_ID('U_EREFJHYTDC_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_PTaxHist];
GO
IF OBJECT_ID('U_EREFJHYTDC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_PEarHist];
GO
IF OBJECT_ID('U_EREFJHYTDC_File') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_File];
GO
IF OBJECT_ID('U_EREFJHYTDC_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_EEList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREFJHYTDC','John Hancock YTD Comp','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EREFJHYTDCZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFJHYTDCZ0','50','H','01','1',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFJHYTDCZ0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFJHYTDCZ0','50','H','01','3',NULL,'Gross Comp',NULL,NULL,'"Gross Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFJHYTDCZ0','50','H','01','4',NULL,'Plan Comp',NULL,NULL,'"Plan Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFJHYTDCZ0','50','H','01','5',NULL,'Eligible Plan Comp',NULL,NULL,'"Eligible Plan Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFJHYTDCZ0','50','H','01','6',NULL,'Match Eligible Plan Comp',NULL,NULL,'"Match Eligible Plan Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFJHYTDCZ0','50','H','01','7',NULL,'Union Code',NULL,NULL,'"Union Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFJHYTDCZ0','50','H','01','8',NULL,'Union Name',NULL,NULL,'"Union Name"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFJHYTDCZ0','50','D','10','1',NULL,'SSN',NULL,NULL,'"dvrSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFJHYTDCZ0','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"dvrEmployeeName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFJHYTDCZ0','50','D','10','3',NULL,'Gross Comp',NULL,NULL,'"dvrGrossComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFJHYTDCZ0','50','D','10','4',NULL,'Plan Comp',NULL,NULL,'"dvrPlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFJHYTDCZ0','50','D','10','5',NULL,'Eligible Plan Comp',NULL,NULL,'"drvEligiblePlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFJHYTDCZ0','50','D','10','6',NULL,'Match Eligible Plan Comp',NULL,NULL,'"dvrMatchEligiblePlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFJHYTDCZ0','50','D','10','7',NULL,'Union Code',NULL,NULL,'"drvUnionCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFJHYTDCZ0','50','D','10','8',NULL,'Union Name',NULL,NULL,'"drvUnionName"','(''UA''=''Q,'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'EREFJHYTDC_20220428.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'John Hancock YTD Comp','202204229','EMPEXPORT','ONDEM_XOE',NULL,'EREFJHYTDC',NULL,NULL,NULL,'202204229','Apr 22 2022  1:51PM','Apr 22 2022  1:51PM','202204221',NULL,'','','202204221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'John Hancock YTD Comp-Sched','202204229','EMPEXPORT','SCH_EREFJH',NULL,'EREFJHYTDC',NULL,NULL,NULL,'202204229','Apr 22 2022  1:51PM','Apr 22 2022  1:51PM','202204221',NULL,'','','202204221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'John Hancock YTD Comp-Test','202204229','EMPEXPORT','TEST_XOE',NULL,'EREFJHYTDC',NULL,NULL,NULL,'202204229','Apr 22 2022  1:51PM','Apr 22 2022  1:51PM','202204221',NULL,'','','202204221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFJHYTDC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFJHYTDC','D10','dbo.U_EREFJHYTDC_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_EREFJHYTDC_EEList
-----------

IF OBJECT_ID('U_EREFJHYTDC_EEList') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EREFJHYTDC_File
-----------

IF OBJECT_ID('U_EREFJHYTDC_File') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EREFJHYTDC_PEarHist
-----------

IF OBJECT_ID('U_EREFJHYTDC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmtYTD] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompYTD] money NULL
);

-----------
-- Create table U_EREFJHYTDC_PTaxHist
-----------

IF OBJECT_ID('U_EREFJHYTDC_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthCOID] char(5) NOT NULL,
    [PthCurTaxableWages] money NULL,
    [PthSSNWages] numeric NULL,
    [PthMedicareWages] numeric NULL,
    [PthStateWithholding] numeric NULL,
    [PthFederalWithholding] numeric NULL,
    [PthSSNWithholding] numeric NULL,
    [PthMedicareWithholding] numeric NULL,
    [PthOterholding] numeric NULL,
    [PthStateIncomeTax] numeric NULL,
    [PthLocalIncomeTax] numeric NULL,
    [PthStateWagesTipsEtc] numeric NULL,
    [PthLocalWagesTipsEtc] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFJHYTDC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 04/22/2022
Service Request Number: TekP-2022-02-08-02

Purpose: John Hancock YTD Comp

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREFJHYTDC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREFJHYTDC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREFJHYTDC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREFJHYTDC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREFJHYTDC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFJHYTDC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFJHYTDC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFJHYTDC', 'SCH_EREFJH';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREFJHYTDC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREFJHYTDC';

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
    DELETE FROM dbo.U_EREFJHYTDC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREFJHYTDC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EREFJHYTDC_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EREFJHYTDC_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EREFJHYTDC_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;

    ----==========================================
    ---- Build Working Tables
    ----==========================================

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_EREFJHYTDC_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EREFJHYTDC_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EREFJHYTDC_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EREFJHYTDC_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EREFJHYTDC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREFJHYTDC_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EREFJHYTDC_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

     -----------------------------
    -- Working Table - PTaxHist
    -----------------------------


   IF OBJECT_ID('U_EREFJHYTDC_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREFJHYTDC_PTaxHist;
    SELECT DISTINCT
        PthEEID
        ,PthCOID
        ,PthCurTaxableWages                     = SUM(PthCurTaxableWages)
        --,PthSSNWages                            = SUM(CASE WHEN PthTaxCode IN ('USSOCEE') THEN PthCurTaxableWages ELSE 0.00 END)
        --,PthMedicareWages                       = SUM(CASE WHEN PthTaxCode IN ('USMEDEE') THEN PthCurTaxableWages ELSE 0.00 END)

        --,PthStateWithholding                    = SUM(CASE WHEN RTRIM(PthTaxCode) LIKE '%SIT' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthFederalWithholding                  = SUM(CASE WHEN PthTaxCode = 'USFIT' THEN PthCurDefComp + PthCurSec125 + PthCurD125 ELSE 0.00 END)
        --,PthSSNWithholding                      = SUM(CASE WHEN PthTaxCode = 'USSOCEE' THEN PthCurTaxAmt ELSE 0.00 END)
        --,PthMedicareWithholding                 = SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxAmt ELSE 0.00 END)
        --,PthOterholding                         = SUM(CASE WHEN PthTaxCode NOT IN ('USMEDEE','USSOCEE','USFIT') AND PthTaxCode NOT LIKE '%LIT' AND PthTaxCode NOT LIKE '%SIT' THEN PthCurTaxAmt ELSE 0.00 END)
        --,PthStateIncomeTax                      = SUM(CASE WHEN PthTaxCode LIKE '%SIT' THEN PthCurTaxAmt ELSE 0.00 END)
        --,PthLocalIncomeTax                      = SUM(CASE WHEN PthTaxCode LIKE '%LIT' THEN PthCurTaxAmt ELSE 0.00 END)


        --,PthStateWagesTipsEtc                   = SUM(CASE WHEN PthTaxCode LIKE '%SIT' THEN PthCurTaxableWages ELSE 0.00 END)
        --,PthLocalWagesTipsEtc                   = SUM(CASE WHEN PthTaxCode LIKE '%LIT' THEN PthCurTaxableWages ELSE 0.00 END)

    INTO dbo.U_EREFJHYTDC_PTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    WHERE --LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
        --AND PthPerControl <= @EndPerControl
        PthPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PthEEID, PthCOID



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREFJHYTDC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFJHYTDC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFJHYTDC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,dvrSSN = eepSSN
        ,dvrEmployeeName = ''
        ,dvrGrossComp = ''
        ,dvrPlanComp = ''
        ,drvEligiblePlanComp = ''
        ,dvrMatchEligiblePlanComp = ''
        ,drvUnionCode = EecUnionLocal
        ,drvUnionName = EecUnionLocal
    INTO dbo.U_EREFJHYTDC_drvTbl
    FROM dbo.U_EREFJHYTDC_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp 
        ON EecEEid  = xEEID 
        AND EecCOID = xCOID 
    LEFT JOIN dbo.U_EREFJHYTDC_PTaxHist WITH (NOLOCK)
        On PthEeid =  xeeid
        where eecCOID <> 'RCI'
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
ALTER VIEW dbo.dsi_vwEREFJHYTDC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREFJHYTDC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREFJHYTDC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204151'
       ,expStartPerControl     = '202204151'
       ,expLastEndPerControl   = '202204229'
       ,expEndPerControl       = '202204229'
WHERE expFormatCode = 'EREFJHYTDC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEREFJHYTDC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EREFJHYTDC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EREFJHYTDC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EREFJHYTDC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EREFJHYTDC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFJHYTDC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EREFJHYTDC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFJHYTDC', 'UseFileName', 'V', 'Y'


-- End ripout