/**********************************************************************************

EBFPAYDED: Benefits First Payroll Deductions

FormatCode:     EBFPAYDED
Project:        Benefits First Payroll Deductions
Client ID:      SCO1001
Date/time:      2021-11-28 11:06:36.630
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N13
Server:         N1SUP3DB54
Database:       ULTIPRO_SGLLC
Web Filename:   SCO1001_95320_EEHISTORY_EBFPAYDED_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBFPAYDED_SavePath') IS NOT NULL DROP TABLE dbo.U_EBFPAYDED_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBFPAYDED'


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
WHERE FormatCode = 'EBFPAYDED'
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
WHERE ExpFormatCode = 'EBFPAYDED'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBFPAYDED')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBFPAYDED'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBFPAYDED'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBFPAYDED'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBFPAYDED'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBFPAYDED'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBFPAYDED'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBFPAYDED'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBFPAYDED'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBFPAYDED'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBFPAYDED_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBFPAYDED_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBFPAYDED') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBFPAYDED];
GO
IF OBJECT_ID('U_EBFPAYDED_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBFPAYDED_PDedHist];
GO
IF OBJECT_ID('U_EBFPAYDED_File') IS NOT NULL DROP TABLE [dbo].[U_EBFPAYDED_File];
GO
IF OBJECT_ID('U_EBFPAYDED_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBFPAYDED_EEList];
GO
IF OBJECT_ID('U_EBFPAYDED_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBFPAYDED_drvTbl];
GO
IF OBJECT_ID('U_EBFPAYDED_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBFPAYDED_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBFPAYDED','Benefits First Payroll Deductions','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EBFPAYDED0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBFPAYDED0Z0','50','H','01','1',NULL,'ClientID',NULL,NULL,'"ClientID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBFPAYDED0Z0','50','H','01','2',NULL,'EmpSSN',NULL,NULL,'"EmpSSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBFPAYDED0Z0','50','H','01','3',NULL,'DeductionCd',NULL,NULL,'"DeductionCd"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBFPAYDED0Z0','50','H','01','4',NULL,'DeductionAmount',NULL,NULL,'"DeductionAmount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBFPAYDED0Z0','50','H','01','5',NULL,'StartDate',NULL,NULL,'"StartDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBFPAYDED0Z0','50','H','01','6',NULL,'EndDate',NULL,NULL,'"EndDate"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBFPAYDED0Z0','50','D','10','1',NULL,'ClientID',NULL,NULL,'"drvClientID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBFPAYDED0Z0','50','D','10','2',NULL,'EmpSSN',NULL,NULL,'"drvEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBFPAYDED0Z0','50','D','10','3',NULL,'DeductionCd',NULL,NULL,'"drvDeductionCd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBFPAYDED0Z0','50','D','10','4',NULL,'DeductionAmount',NULL,NULL,'"drvDeductionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBFPAYDED0Z0','50','D','10','5',NULL,'StartDate',NULL,NULL,'"drvStartDate "','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBFPAYDED0Z0','50','D','10','6',NULL,'EndDate',NULL,NULL,'"drvEndDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBFPAYDED_20211128.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'Benefits First Payroll Ded','202111289','EMPEXPORT','ONDEM_XOE',NULL,'EBFPAYDED',NULL,NULL,NULL,'202111289','Nov 28 2021 10:22AM','Nov 28 2021 10:22AM','202111141',NULL,'','','202111141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Benefits First Payroll D-Sched','202111289','EMPEXPORT','SCH_EBFPAY',NULL,'EBFPAYDED',NULL,NULL,NULL,'202111289','Nov 28 2021 10:22AM','Nov 28 2021 10:22AM','202111141',NULL,'','','202111141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'Benefits First Payroll D-Test','202111289','EMPEXPORT','TEST_XOE',NULL,'EBFPAYDED',NULL,NULL,NULL,'202111289','Nov 28 2021 10:22AM','Nov 28 2021 10:22AM','202111141',NULL,'','','202111141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBFPAYDED','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBFPAYDED','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBFPAYDED','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBFPAYDED','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBFPAYDED','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBFPAYDED','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBFPAYDED','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBFPAYDED','D10','dbo.U_EBFPAYDED_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBFPAYDED_DedList
-----------

IF OBJECT_ID('U_EBFPAYDED_DedList') IS NULL
CREATE TABLE [dbo].[U_EBFPAYDED_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBFPAYDED_drvTbl
-----------

IF OBJECT_ID('U_EBFPAYDED_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBFPAYDED_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvClientID] varchar(3) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvDeductionCd] char(5) NOT NULL,
    [drvDeductionAmount] nvarchar(4000) NULL,
    [drvStartDate] varchar(1) NOT NULL,
    [drvEndDate] varchar(1) NOT NULL
);

-----------
-- Create table U_EBFPAYDED_EEList
-----------

IF OBJECT_ID('U_EBFPAYDED_EEList') IS NULL
CREATE TABLE [dbo].[U_EBFPAYDED_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBFPAYDED_File
-----------

IF OBJECT_ID('U_EBFPAYDED_File') IS NULL
CREATE TABLE [dbo].[U_EBFPAYDED_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EBFPAYDED_PDedHist
-----------

IF OBJECT_ID('U_EBFPAYDED_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBFPAYDED_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBFPAYDED]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Scotsman Group

Created By: Darren Collard
Business Analyst: Lea King
Create Date: 11/28/2021
Service Request Number: TekP-2021-09-29-0002

Purpose: Benefits First Payroll Deductions

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBFPAYDED';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBFPAYDED';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBFPAYDED';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBFPAYDED';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBFPAYDED' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBFPAYDED', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBFPAYDED', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBFPAYDED', 'SCH_EBFPAY';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBFPAYDED', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBFPAYDED';

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
    DELETE FROM dbo.U_EBFPAYDED_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBFPAYDED_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ADD,ADD22,BC1W,BC2W,BC3W,BC4W,BCBS1,BCBS2,BCBS3,BCBS4,DELTA,DLT2,FSADC,FSAMD,HSACF,HSACU,HSAFA,HSAIN,LEGAL,LIF22,LIFE,LTD05,SUPDP,SUPLF,SUPSP,VCADD,VCHA,VEADD,VSADD,VSP,VSP2,VYAC1,VYACI,VYCCI,VYSP';

    IF OBJECT_ID('U_EBFPAYDED_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBFPAYDED_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBFPAYDED_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EBFPAYDED_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBFPAYDED_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(PdhEECurAmt)
    INTO dbo.U_EBFPAYDED_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBFPAYDED_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBFPAYDED_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBFPAYDED_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBFPAYDED_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvClientID = '739'
        ,drvEmpSSN = eepSSN
        ,drvDeductionCd = pdhDedCode
        ,drvDeductionAmount = FORMAT(pdheecuramt,'#0.00')
        ,drvStartDate = ''
        ,drvEndDate = ''
    INTO dbo.U_EBFPAYDED_drvTbl
    FROM dbo.U_EBFPAYDED_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EBFPAYDED_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEBFPAYDED_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBFPAYDED_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBFPAYDED%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202111141'
       ,expStartPerControl     = '202111141'
       ,expLastEndPerControl   = '202111289'
       ,expEndPerControl       = '202111289'
WHERE expFormatCode = 'EBFPAYDED';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBFPAYDED_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBFPAYDED_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBFPAYDED' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBFPAYDED'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBFPAYDED'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBFPAYDED', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBFPAYDED', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBFPAYDED', 'UseFileName', 'V', 'Y'


-- End ripout