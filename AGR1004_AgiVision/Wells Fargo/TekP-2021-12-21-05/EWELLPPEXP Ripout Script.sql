/**********************************************************************************

EWELLPPEXP: Wells Fargo Positive Pay Export

FormatCode:     EWELLPPEXP
Project:        Wells Fargo Positive Pay Export
Client ID:      AGR1004
Date/time:      2022-05-18 13:09:53.740
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB03
Database:       ULTIPRO_WPAGFM
Web Filename:   AGR1004_WO01I_EEHISTORY_EWELLPPEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWELLPPEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EWELLPPEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWELLPPEXP'


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
WHERE FormatCode = 'EWELLPPEXP'
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
WHERE ExpFormatCode = 'EWELLPPEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWELLPPEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWELLPPEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWELLPPEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWELLPPEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWELLPPEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWELLPPEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWELLPPEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWELLPPEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWELLPPEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWELLPPEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWELLPPEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWELLPPEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWELLPPEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWELLPPEXP];
GO
IF OBJECT_ID('U_EWELLPPEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EWELLPPEXP_Trailer];
GO
IF OBJECT_ID('U_EWELLPPEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EWELLPPEXP_Header];
GO
IF OBJECT_ID('U_EWELLPPEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EWELLPPEXP_File];
GO
IF OBJECT_ID('U_EWELLPPEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWELLPPEXP_EEList];
GO
IF OBJECT_ID('U_EWELLPPEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWELLPPEXP_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EWELLPPEXP','Wells Fargo Positive Pay Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','85','S','N','EWELLPPEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWELLPPEXPZ0','3','H','01','1',NULL,NULL,NULL,NULL,'"drvHRecID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWELLPPEXPZ0','5','H','01','4',NULL,NULL,NULL,NULL,'"drvHBankID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWELLPPEXPZ0','15','H','01','9',NULL,NULL,NULL,NULL,'"drvHAcctNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWELLPPEXPZ0','1','H','01','24',NULL,NULL,NULL,NULL,'"drvFileStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWELLPPEXPZ0','61','H','01','25',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWELLPPEXPZ0','10','D','10','1',NULL,NULL,NULL,NULL,'"drvCheckNo"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWELLPPEXPZ0','6','D','10','11',NULL,NULL,NULL,NULL,'"drvIssueDate"','(''UDMDZ''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWELLPPEXPZ0','15','D','10','17',NULL,NULL,NULL,NULL,'"drvAccountNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWELLPPEXPZ0','3','D','10','32',NULL,NULL,NULL,NULL,'"drvTranCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWELLPPEXPZ0','10','D','10','35',NULL,NULL,NULL,NULL,'"drvAmount"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWELLPPEXPZ0','40','D','10','45',NULL,NULL,NULL,NULL,'"drvPayee"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWELLPPEXPZ0','1','D','10','85',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWELLPPEXPZ0','1','T','90','1',NULL,NULL,NULL,NULL,'"drvAmpersand"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWELLPPEXPZ0','14','T','90','2',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWELLPPEXPZ0','7','T','90','16',NULL,NULL,NULL,NULL,'"drvDetailCount"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWELLPPEXPZ0','3','T','90','23',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWELLPPEXPZ0','13','T','90','26',NULL,NULL,NULL,NULL,'"drvTotalAmount"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWELLPPEXPZ0','47','T','90','39',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWELLPPEXP_20220518.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Wells Fargo Positive Pay','202205119','EMPEXPORT','ONDEM_XOE',NULL,'EWELLPPEXP',NULL,NULL,NULL,'202205119','May  9 2017  8:49AM','May  9 2017  8:49AM','202204101',NULL,'','','202204011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Wells Fargo Positive Pay','202205119','EMPEXPORT','SCHEDULED',NULL,'EWELLPPEXP',NULL,NULL,NULL,'202205119','May  9 2017  8:49AM','May  9 2017  8:49AM','202204101',NULL,'','','202204011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202204279','EMPEXPORT','TEST_XOE','May 17 2022 12:00AM','EWELLPPEXP',NULL,NULL,NULL,'202204279','Apr 27 2022 12:00AM','Dec 30 1899 12:00AM','202204271',NULL,'eecPayGroup','JGDBW','202204271',dbo.fn_GetTimedKey(),NULL,'us3cPeAGR1004',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','InitialSort','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','SubSort','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWELLPPEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWELLPPEXP','H01','dbo.U_EWELLPPEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWELLPPEXP','D10','dbo.U_EWELLPPEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWELLPPEXP','T90','dbo.U_EWELLPPEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EWELLPPEXP_drvTbl
-----------

IF OBJECT_ID('U_EWELLPPEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWELLPPEXP_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvGenNumber] char(12) NOT NULL,
    [drvInitialSort] char(10) NOT NULL,
    [drvCheckNo] char(10) NOT NULL,
    [drvIssueDate] varchar(8000) NULL,
    [drvAccountNo] varchar(15) NULL,
    [drvTranCode] varchar(3) NOT NULL,
    [drvAmount] numeric NULL,
    [drvPayee] varchar(50) NULL
);

-----------
-- Create table U_EWELLPPEXP_EEList
-----------

IF OBJECT_ID('U_EWELLPPEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EWELLPPEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWELLPPEXP_File
-----------

IF OBJECT_ID('U_EWELLPPEXP_File') IS NULL
CREATE TABLE [dbo].[U_EWELLPPEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EWELLPPEXP_Header
-----------

IF OBJECT_ID('U_EWELLPPEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EWELLPPEXP_Header] (
    [drveeid] varchar(1) NOT NULL,
    [drvHRecID] varchar(3) NOT NULL,
    [drvHBankID] varchar(5) NOT NULL,
    [drvHAcctNo] varchar(15) NULL,
    [drvFileStatus] varchar(1) NOT NULL
);

-----------
-- Create table U_EWELLPPEXP_Trailer
-----------

IF OBJECT_ID('U_EWELLPPEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EWELLPPEXP_Trailer] (
    [drvAmpersand] varchar(1) NOT NULL,
    [drvDetailCount] int NULL,
    [drvTotalAmount] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWELLPPEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: AgriVision Farm Management

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 5/11/2022
Service Request Number: TekP-2021-12-21-05

Purpose: Wells Fargo Postive Pay Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWELLPPEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWELLPPEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWELLPPEXP';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EWELLPPEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWELLPPEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWELLPPEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWELLPPEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWELLPPEXP', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWELLPPEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWELLPPEXP';

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
    -- Build Driver Tables
    --==========================================

    /***** Positive Pay Best Practice **************************************************************************************************************
        Best Practice is to pull checks issued from history (PayReg).
        
        When to use M_Batch?
            - If the customer is always NOT going to post manual checks, and those checks will not post with the regular payroll.
            - The customer must produce the positive pay file between the PRINT and POST steps in the payroll process, which is very limiting.
            - If a customer forgets and post the payroll, then you cannot re-create the Positive Pay File.

        NOTE: You should only pull from PayReg or M_Batch, but not both..  
    ***********************************************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EWELLPPEXP_drvTbl', 'U') IS NOT NULL
        DROP TABLE dbo.U_EWELLPPEXP_drvTbl;
    -- Pay Reg Data
    SELECT DISTINCT
         drvEEID = PrgEEID
        ,drvCoID = PrgCoID
        ,drvGenNumber = PrgGenNumber
        ,drvInitialSort = ISNULL(PrgDocNo, 0)
        -- standard fields above and additional driver fields below 
        ,drvCheckNo = ISNULL(PrgDocNo, 0)
        ,drvIssueDate = REPLACE(CONVERT(VARCHAR(10), PrgPayDate, 10), '-', '')
        ,drvAccountNo = RIGHT('000000000000000' + BnkBankAcctNo, 15)
        ,drvTranCode = CASE WHEN PrgIsVoidingRecord = 'Y' THEN '370'
                            ELSE '320'
                       END
        ,drvAmount = CASE WHEN PrgIsVoidingRecord <> 'Y' THEN ABS(PrgCheckAmt * 100) ELSE 0.00 END
        ,drvPayee = UPPER(ckhEEfullname)
    INTO dbo.U_EWELLPPEXP_drvTbl
    FROM dbo.U_EWELLPPEXP_EEList
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
        AND PrgCoID = xCOID
    JOIN dbo.Bank WITH (NOLOCK)
        ON PrgCoBankID = BnkCoBankID
    LEFT JOIN dbo.ChkHead WITH (NOLOCK)
        ON ckhEEID = xEEID
        AND CONVERT(VARCHAR(10),LTRIM(RTRIM(PrgDocNo))) = CONVERT(VARCHAR(10),LTRIM(RTRIM(ckhCheckNo)))
        AND PrgGenNumber = ckhGenNumber
    WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PrgCheckAddMode IN ('R','M','A','D','B','J')
    AND PrgPrinted = 'Y'
    AND PrgTransactionType IN ('C')
    AND (PrgPostOnly = 'N'
        OR PrgIsVoidingRecord = 'Y'
    )
    AND BnkCoBankId IN ('DJE','DJEI','DJF','HT','JGD','NPDF','NPDI','NPO','NPDC','NSF','DJFI','HTI','JGDI','NPOI','NSFI','PDCI','PDFI','PDII')
    ;

    ---- Batch Data
    --SELECT DISTINCT
    --        drvEEID = MbtEEID
    --    ,drvCoID = MbtCoID
    --    ,drvGenNumber = MbtGenNumber
    --    ,drvInitialSort = ISNULL(MbtDocNo, 0)
    --    -- standard fields above and additional driver fields below 
    --    ,drvCheckNo = ISNULL(MbtDocNo, 0)
    --    ,drvIssueDate = REPLACE(CONVERT(VARCHAR(10), MbtPayDate, 10), '-', '')
    --    ,drvAccountNo = dbo.fn_padzero(BnkBankAcctNo, 15, 0)
    --    ,drvTranCode = CASE WHEN MbtIsVoidingRecord = 'Y' OR MbtCheckAmt = 0 THEN '370'
    --                        ELSE '320'
    --                    END
    --    ,drvAmount = ABS(MbtCheckAmt) * 100
    --    ,drvPayee = ckhEEfullname
    --INTO dbo.U_EWELLPPEXP_drvTbl
    --FROM dbo.U_EWELLPPEXP_EEList
    --JOIN dbo.M_Batch WITH (NOLOCK)
    --    ON MbtEEID = xEEID
    --    AND MbtCOID = xCOID
    --JOIN dbo.Bank WITH (NOLOCK)
    --    ON MbtCoBankID = BnkCoBankID
    --LEFT JOIN dbo.ChkHead WITH (NOLOCK)
    --    ON ckhEEID = xEEID
    --    AND CONVERT(VARCHAR(10),LTRIM(RTRIM(MbtDocNo))) = CONVERT(VARCHAR(10),LTRIM(RTRIM(ckhCheckNo)))
    --    AND MbtGenNumber = ckhGenNumber
    --WHERE MbtCheckAddMode IN ('R','M','A','D','B','J')
    --AND MbtPrinted = 'Y'
    --AND MbtTransactionType IN ('C')
    --AND (MbtPostOnly = 'N' OR MbtIsVoidingRecord = 'Y')
    --AND mbtpercontrol BETWEEN @StartPerControl AND @EndPerControl

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWELLPPEXP_Header', 'U') IS NOT NULL
        DROP TABLE dbo.U_EWELLPPEXP_Header;
    SELECT DISTINCT drveeid = ''
        ,drvHRecID = '*03'
        ,drvHBankID = '00182'
        ,drvHAcctNo = RIGHT('000000000000000' + drvAccountNo,15)
        ,drvFileStatus = '0'
    INTO dbo.U_EWELLPPEXP_Header
    FROM (
        SELECT DISTINCT drvAccountNo
        FROM dbo.U_EWELLPPEXP_drvTbl
    ) hdr;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWELLPPEXP_Trailer', 'U') IS NOT NULL
        DROP TABLE dbo.U_EWELLPPEXP_Trailer;
    SELECT DISTINCT 
         drvAmpersand = '&'
        ,drvDetailCount = (SELECT COUNT(*) FROM dbo.U_EWELLPPEXP_drvTbl) -- Total Record Count
        ,drvTotalAmount = ISNULL((SELECT SUM(drvAmount) FROM dbo.U_EWELLPPEXP_drvTbl WHERE drvTranCode = '320'), 0) -- Total Dollars
                        - ISNULL((SELECT SUM(drvAmount) FROM dbo.U_EWELLPPEXP_drvTbl WHERE drvTranCode = '370'), 0) -- Total Void Dollars
    INTO dbo.U_EWELLPPEXP_Trailer;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_WF_AGFM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_WF_AGFM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'WF_AGFM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEWELLPPEXP_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EWELLPPEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWELLPPEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204101'
       ,expStartPerControl     = '202204011'
       ,expLastEndPerControl   = '202205119'
       ,expEndPerControl       = '202205119'
WHERE expFormatCode = 'EWELLPPEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWELLPPEXP_Export AS
    SELECT TOP 200000000 DATA FROM dbo.U_EWELLPPEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2),InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWELLPPEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWELLPPEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWELLPPEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWELLPPEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWELLPPEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWELLPPEXP', 'UseFileName', 'V', 'Y'


-- End ripout