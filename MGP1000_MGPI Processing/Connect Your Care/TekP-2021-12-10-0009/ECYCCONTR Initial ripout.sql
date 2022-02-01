/**********************************************************************************

ECYCCONTR: Connect Your Care FSA/HSA Contribution Export

FormatCode:     ECYCCONTR
Project:        Connect Your Care FSA/HSA Contribution Export
Client ID:      MGP1000
Date/time:      2022-01-25 20:57:46.080
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPMGPI
Web Filename:   MGP1000_BLF99_EEHISTORY_ECYCCONTR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECYCCONTR_SavePath') IS NOT NULL DROP TABLE dbo.U_ECYCCONTR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECYCCONTR'


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
WHERE FormatCode = 'ECYCCONTR'
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
WHERE ExpFormatCode = 'ECYCCONTR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECYCCONTR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECYCCONTR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECYCCONTR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECYCCONTR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECYCCONTR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECYCCONTR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECYCCONTR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECYCCONTR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECYCCONTR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECYCCONTR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECYCCONTR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCCONTR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCCONTR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCONTR];
GO
IF OBJECT_ID('U_ECYCCONTR_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECYCCONTR_PEarHist];
GO
IF OBJECT_ID('U_ECYCCONTR_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECYCCONTR_PDedHist];
GO
IF OBJECT_ID('U_ECYCCONTR_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCCONTR_File];
GO
IF OBJECT_ID('U_ECYCCONTR_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCCONTR_EEList];
GO
IF OBJECT_ID('U_ECYCCONTR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECYCCONTR_drvTbl];
GO
IF OBJECT_ID('U_ECYCCONTR_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECYCCONTR_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECYCCONTR','Connect Your Care FSA/HSA Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','250','S','N','ECYCCONTR0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCONTR0Z0','11','D','10','1',NULL,'Account SSN',NULL,NULL,'"drvAccountSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCONTR0Z0','20','D','10','12',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCONTR0Z0','8','D','10','32',NULL,'Pay Date',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCCONTR0Z0','30','D','10','40',NULL,'Billing Group Identifier',NULL,NULL,'"drvBillingGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECYCCONTR0Z0','20','D','10','70',NULL,'Enrollment Submitter ID',NULL,NULL,'"drvEnrollmentSubmitterID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECYCCONTR0Z0','30','D','10','90',NULL,'Employer ID',NULL,NULL,'"drvEmployerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECYCCONTR0Z0','30','D','10','120',NULL,'Employer Offering ID',NULL,NULL,'"drvEmployerOfferingID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECYCCONTR0Z0','8','D','10','150',NULL,'Contribution Amount',NULL,NULL,'"drvContrAmount"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECYCCONTR0Z0','30','D','10','158',NULL,'Contribution Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECYCCONTR0Z0','5','D','10','188',NULL,'Special Contribution Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECYCCONTR0Z0','30','D','10','193',NULL,'Partner Employee ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECYCCONTR0Z0','28','D','10','223',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECYCCONTR_20220125.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'CYC FSA/HSA Contr-OnDemand','202107011','EMPEXPORT','ONDEM_XOE','May 22 2019  9:16PM','ECYCCONTR',NULL,NULL,NULL,'202107011','May 24 2019 12:00AM','May 31 2019 12:00AM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CYC FSA/HSA Contr-Scheduled','202106039','EMPEXPORT','SCH_ECYCCO',NULL,'ECYCCONTR',NULL,NULL,NULL,'202106039','Apr 17 2019  3:44AM','Apr 17 2019  3:44AM','202106031',NULL,'','','202106031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCONTR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCONTR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCONTR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCONTR','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCONTR','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCONTR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCONTR','D10','dbo.U_ECYCCONTR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECYCCONTR_DedList
-----------

IF OBJECT_ID('U_ECYCCONTR_DedList') IS NULL
CREATE TABLE [dbo].[U_ECYCCONTR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECYCCONTR_drvTbl
-----------

IF OBJECT_ID('U_ECYCCONTR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECYCCONTR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvAccountSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvPayDate] datetime NULL,
    [drvBillingGroupID] varchar(4) NULL,
    [drvEnrollmentSubmitterID] varchar(14) NOT NULL,
    [drvEmployerID] varchar(14) NOT NULL,
    [drvEmployerOfferingID] varchar(10) NULL,
    [drvContrAmount] numeric NULL
);

-----------
-- Create table U_ECYCCONTR_EEList
-----------

IF OBJECT_ID('U_ECYCCONTR_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCCONTR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECYCCONTR_File
-----------

IF OBJECT_ID('U_ECYCCONTR_File') IS NULL
CREATE TABLE [dbo].[U_ECYCCONTR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(250) NULL
);

-----------
-- Create table U_ECYCCONTR_PDedHist
-----------

IF OBJECT_ID('U_ECYCCONTR_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECYCCONTR_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhHSAEE] numeric NULL,
    [PdhDCAPEE] numeric NULL,
    [PdhPayDate] datetime NULL
);

-----------
-- Create table U_ECYCCONTR_PEarHist
-----------

IF OBJECT_ID('U_ECYCCONTR_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECYCCONTR_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCONTR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: MGPI Processing

Created By: Carrie McDowell
Create Date: 11/20/2020

Purpose: Connect Your Care FSA/HSA Contribution Export
Revision History
----------------
Update By           Date        Request Num         Desc


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCCONTR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCCONTR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCCONTR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECYCCONTR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCCONTR' ORDER BY RunID DESC;

Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCONTR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCONTR', 'SCH_ECYCCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCCONTR';

EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'ECYCCONTR', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode      varchar(10)
            ,@ExportCode      varchar(10)
            ,@StartDate       datetime
            ,@EndDate         datetime
            ,@StartPerControl varchar(9)
            ,@EndPerControl   varchar(9);
            

    -- Set FormatCode
    SELECT @FormatCode = 'ECYCCONTR';

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
    DELETE FROM dbo.U_ECYCCONTR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCCONTR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    ---- Create Deduction List
    ----==========================================
    DECLARE @DedList varchar(MAX)
    SET @DedList = 'HSAI,HSAF,HSACI,HSACF,HSAA1,HSAA2,HSAA3,HSAA4,DCPLB,FLXAT,DPCAT,FLXLB,HSAER,HSAE2';            --MB added FLXLB 2/12/2021


    IF OBJECT_ID('U_ECYCCONTR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCONTR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType  -- select * from dbo.U_ECYCCONTR_DedList
    INTO dbo.U_ECYCCONTR_DedList -- select *
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;
   
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECYCCONTR_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCONTR_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhCOID
         --,Substring(PdhPerControl,1,8) AS PdhPayDate
         ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        -- Categorize Payroll Amounts
        ,PdhHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDCAPEE     = SUM(CASE WHEN PdhDedCode IN ('FLXLB','DCPLB','FLXAT','DPCAT') THEN PdhEECurAmt ELSE 0.00 END) 
        ,PdhPayDate    = MAX(PdhPayDate)
    INTO dbo.U_ECYCCONTR_PDedHist -- SELECT *            --SELECT * FROM dbo.U_ECYCCONTR_PDedHist where pdheeid = 'BP4KWY0000K0'
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECYCCONTR_DedList WITH (NOLOCK) -- select * from dbo.U_ECYCCONTR_EEList
       ON DedCode = PdhDedCode                    -- select distinct PdhDedCode from dbo.PDedHist            
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    --LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID,PdhCOID,PdhDedCode
    ----HAVING (SUM(PdhEECurAmt) <> 0.00
    ----    OR SUM(PdhERCurAmt) <> 0.00)
    ;
 --   JOIN dbo.U_ECYCCONTR_EEList WITH (NOLOCK) 
 --       ON PdhEEID = xEEID
 --          AND PdhCOID = xCOID
 --   WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    --GROUP BY PdhEEID, PdhDedCode
 --   HAVING (SUM(PdhEECurAmt) <> 0.00);
        
        
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECYCCONTR_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCONTR_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    INTO dbo.U_ECYCCONTR_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PehEarnCode IN ('HSAER','HSAE2')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECYCCONTR_drvTbl                        --SELECT SUM(drvContrAmount) FROM dbo.U_ECYCCONTR_drvTbl WHERE drvEmployerOfferingID LIKE 'FSA%'
    ---------------------------------                            --SELECT * FROM dbo.U_ECYCCONTR_drvTbl
    IF OBJECT_ID('U_ECYCCONTR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCCONTR_drvTbl;
    SELECT DISTINCT
        drvEEID                = xEEID
        ,drvCoID               = xCoID
        ,drvInitialSort        = eepSSN
        -- standard fields above and additional driver fields below
        ,drvAccountSSN         = eepSSN
        ,drvEmployeeID         = EecEmpNo
        ,drvPayDate            = PdhPayDate
        ,drvBillingGroupID     = CASE WHEN EecDedGroupCode IN ('ATBHR','ATNBH','ATNBS') THEN 'ATCH'
                                  WHEN EecDedGroupCode IN ('ATSLB','LBBHR','LBNBH','LBNBS') THEN 'LAWR' END
        ,drvEnrollmentSubmitterID    = 'MGPINGREDIENTS'
        ,drvEmployerID           = 'MGPINGREDIENTS'
        ,drvEmployerOfferingID = CASE WHEN PdhDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') THEN 'HSAEE' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) 
                                      WHEN PdhDedCode IN ('DCPLB','DPCAT') THEN 'DCAPEE' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) 
                                      WHEN PdhDedCode IN ('FLXLB','FLXAT') THEN 'FSAEE' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))    --MB added 2/12/2021 per feedback
                                      --WHEN PehEEID IS NOT NULL THEN 'HSAER' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))  --XXX TJJ ADDED HSAER 3/1/2021
                                     END
        ,drvContrAmount        = CASE WHEN PdhDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') THEN PdhHSAEE * 100 
                                      WHEN PdhDedCode IN ('FLXLB','DCPLB','FLXAT','DPCAT') THEN PdhDCAPEE * 100 
                                      --WHEN PehEEID IS NOT NULL THEN PehCurAmt * 100 --XXX TJJ ADDED HSAER 3/1/2021
                                 END 
    INTO dbo.U_ECYCCONTR_drvTbl -- Select * from dbo.U_ECYCCONTR_drvTbl where drveeid = 'BP4KWY0000K0'
    FROM dbo.U_ECYCCONTR_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK) --Select * from dbo.EmpComp with (nolock)
        ON EecEEID = xEEID
       AND EecCoID = xCoID 
    JOIN dbo.EmpPers WITH (NOLOCK) -- Select * from dbo.EmpPers with (nolock)
        ON eepEEID = xEEID
    JOIN dbo.U_ECYCCONTR_PDedHist WITH (NOLOCK) -- Select * from dbo.U_ECYCCONTR_PDedHist WITH (NOLOCK) where pdheeid = 'DP2Y9H000020'
        ON PdhEEID = xEEID
        AND PdhCOID = xCOID
        AND PdhDedCode NOT IN ('HSAER','HSAE2')

    
UNION
    SELECT DISTINCT
        drvEEID                = xEEID
        ,drvCoID               = xCoID
        ,drvInitialSort        = eepSSN
        -- standard fields above and additional driver fields below
        ,drvAccountSSN         = eepSSN
        ,drvEmployeeID         = EecEmpNo
        ,drvPayDate            = PdhPayDate
        ,drvBillingGroupID     = CASE WHEN EecDedGroupCode IN ('ATBHR','ATNBH','ATNBS') THEN 'ATCH'
                                  WHEN EecDedGroupCode IN ('ATSLB','LBBHR','LBNBH','LBNBS') THEN 'LAWR' END
        ,drvEnrollmentSubmitterID    = 'MGPINGREDIENTS'
        ,drvEmployerID           = 'MGPINGREDIENTS'
        ,drvEmployerOfferingID = 'HSAER' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))  
        ,drvContrAmount        = PehCurAmt * 100 --XXX TJJ ADDED HSAER 3/1/2021
                                
    --INTO dbo.U_ECYCCONTR_drvTbl -- Select * from dbo.U_ECYCCONTR_drvTbl order by drveeid
    FROM dbo.U_ECYCCONTR_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK) -- Select * from dbo.EmpComp with (nolock)
        ON EecEEID = xEEID
       AND EecCoID = xCoID 
    JOIN dbo.EmpPers WITH (NOLOCK) -- Select * from dbo.EmpPers with (nolock)
        ON eepEEID = xEEID
    JOIN dbo.U_ECYCCONTR_PDedHist WITH (NOLOCK) -- Select * from dbo.U_ECYCCONTR_PDedHist WITH (NOLOCK) where pdheeid = 'BP4KWY0000K0'
        ON PdhEEID = xEEID
        AND PdhCOID = xCOID
    LEFT JOIN dbo.U_ECYCCONTR_PEarHist WITH (NOLOCK)  --select * from U_ECYCCONTR_PEarHist where peheeid = 'DQUF87000020'
        ON PehEEID = xEEID
    WHERE PdhDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') 
    OR PehCurAmt IS NOT NULL --XXX TJJ 7/1
    

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECYCCONTR_Export AS
    SELECT TOP 200000000 Data
    FROM dbo.U_ECYCCONTR_File WITH (NOLOCK)
    ORDER BY InitialSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCCONTR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107011'
       ,expStartPerControl     = '202107011'
       ,expLastEndPerControl   = '202107011'
       ,expEndPerControl       = '202107011'
WHERE expFormatCode = 'ECYCCONTR' and expExportCode = 'ONDEM_XOE';

select len(data) FROM dbo.U_ECYCCONTR_File WITH (NOLOCK)

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECYCCONTR_Export AS
    SELECT TOP 200000000 Data
    FROM dbo.U_ECYCCONTR_File WITH (NOLOCK)
    ORDER BY InitialSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECYCCONTR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECYCCONTR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECYCCONTR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCCONTR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECYCCONTR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCCONTR', 'UseFileName', 'V', 'Y'


-- End ripout