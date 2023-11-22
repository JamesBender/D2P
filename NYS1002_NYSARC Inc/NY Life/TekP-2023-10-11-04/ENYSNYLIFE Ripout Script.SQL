/**********************************************************************************

ENYSNYLIFE: NY Life FMLA Export

FormatCode:     ENYSNYLIFE
Project:        NY Life FMLA Export
Client ID:      NYS1002
Date/time:      2023-11-14 09:30:28.547
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB04
Database:       ULTIPRO_NYAR
Web Filename:   NYS1002_JHH1U_EEHISTORY_ENYSNYLIFE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENYSNYLIFE_SavePath') IS NOT NULL DROP TABLE dbo.U_ENYSNYLIFE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENYSNYLIFE'


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
WHERE FormatCode = 'ENYSNYLIFE'
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
WHERE ExpFormatCode = 'ENYSNYLIFE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENYSNYLIFE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENYSNYLIFE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENYSNYLIFE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENYSNYLIFE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENYSNYLIFE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENYSNYLIFE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENYSNYLIFE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENYSNYLIFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENYSNYLIFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENYSNYLIFE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENYSNYLIFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENYSNYLIFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENYSNYLIFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENYSNYLIFE];
GO
IF OBJECT_ID('U_ENYSNYLIFE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENYSNYLIFE_PEarHist];
GO
IF OBJECT_ID('U_ENYSNYLIFE_File') IS NOT NULL DROP TABLE [dbo].[U_ENYSNYLIFE_File];
GO
IF OBJECT_ID('U_ENYSNYLIFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENYSNYLIFE_EEList];
GO
IF OBJECT_ID('U_ENYSNYLIFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENYSNYLIFE_drvTbl];
GO
IF OBJECT_ID('U_ENYSNYLIFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENYSNYLIFE_AuditFields];
GO
IF OBJECT_ID('U_ENYSNYLIFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENYSNYLIFE_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENYSNYLIFE','NY Life FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENYSNYLIFEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENYSNYLIFEZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENYSNYLIFEZ0','50','H','01','2',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENYSNYLIFEZ0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENYSNYLIFEZ0','50','H','01','4',NULL,'Status AC or TE',NULL,NULL,'"Status AC or TE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENYSNYLIFEZ0','50','H','01','5',NULL,'Actual Annual Hours',NULL,NULL,'"Actual Annual Hours"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENYSNYLIFEZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENYSNYLIFEZ0','50','D','10','2',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENYSNYLIFEZ0','50','D','10','3',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENYSNYLIFEZ0','50','D','10','4',NULL,'Status AC or TE',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENYSNYLIFEZ0','50','D','10','5',NULL,'Actual Annual Hours',NULL,NULL,'"drvActualAnnHours"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENYSNYLIFE_20231114.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NY Life FMLA Export','202311149','EMPEXPORT','ONDEM_XOE',NULL,'ENYSNYLIFE',NULL,NULL,NULL,'202311149','Nov 14 2023  8:37AM','Nov 14 2023  8:37AM','202310071',NULL,'','','202310071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NY Life FMLA Export-Sched','202311149','EMPEXPORT','SCH_ENYSNY',NULL,'ENYSNYLIFE',NULL,NULL,NULL,'202311149','Nov 14 2023  8:37AM','Nov 14 2023  8:37AM','202310071',NULL,'','','202310071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'NY Life FMLA Export-Test','202311149','EMPEXPORT','TEST_XOE',NULL,'ENYSNYLIFE',NULL,NULL,NULL,'202311149','Nov 14 2023  8:37AM','Nov 14 2023  8:37AM','202310071',NULL,'','','202310071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYSNYLIFE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENYSNYLIFE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENYSNYLIFE','D10','dbo.U_ENYSNYLIFE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ENYSNYLIFE_Audit
-----------

IF OBJECT_ID('U_ENYSNYLIFE_Audit') IS NULL
CREATE TABLE [dbo].[U_ENYSNYLIFE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_ENYSNYLIFE_AuditFields
-----------

IF OBJECT_ID('U_ENYSNYLIFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENYSNYLIFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ENYSNYLIFE_drvTbl
-----------

IF OBJECT_ID('U_ENYSNYLIFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENYSNYLIFE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvStatus] varchar(2) NOT NULL,
    [drvActualAnnHours] varchar(24) NULL
);

-----------
-- Create table U_ENYSNYLIFE_EEList
-----------

IF OBJECT_ID('U_ENYSNYLIFE_EEList') IS NULL
CREATE TABLE [dbo].[U_ENYSNYLIFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENYSNYLIFE_File
-----------

IF OBJECT_ID('U_ENYSNYLIFE_File') IS NULL
CREATE TABLE [dbo].[U_ENYSNYLIFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ENYSNYLIFE_PEarHist
-----------

IF OBJECT_ID('U_ENYSNYLIFE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENYSNYLIFE_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmt12Mos] money NULL,
    [PehCurHrs12Mos] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENYSNYLIFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NYSARC, Inc. d/b/a AHRC

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 11/14/2023
Service Request Number: TekP-2023-10-11-04

Purpose: NY Life FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENYSNYLIFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENYSNYLIFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENYSNYLIFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENYSNYLIFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENYSNYLIFE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYSNYLIFE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYSNYLIFE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYSNYLIFE', 'SCH_ENYSNY';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENYSNYLIFE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENYSNYLIFE';

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
    DELETE FROM dbo.U_ENYSNYLIFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENYSNYLIFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ENYSNYLIFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ENYSNYLIFE_AuditFields;
    CREATE TABLE dbo.U_ENYSNYLIFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_ENYSNYLIFE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ENYSNYLIFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ENYSNYLIFE_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ENYSNYLIFE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ENYSNYLIFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN Dateadd(d, -7,@StartDate)  AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ENYSNYLIFE_Audit ON dbo.U_ENYSNYLIFE_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ENYSNYLIFE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ENYSNYLIFE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ENYSNYLIFE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENYSNYLIFE_PEarHist;
    SELECT DISTINCT
         PehEEID
        --,PrgPayDate             = MAX(PrgPayDate)
        ---- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmt12Mos          = SUM(PehCurAmt)
        ,PehCurHrs12Mos          = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ENYSNYLIFE_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
   JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    --WHERE  PehPerControl <= @EndPerControl
    WHERE PrgPayDate BETWEEN DATEADD(YY,-1,@StartDate) AND @EndDate
    and PehInclInDefComp = 'Y'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENYSNYLIFE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENYSNYLIFE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENYSNYLIFE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvLastName =  dbo.dsi_fnRemoveChars('.,/-',REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'))
        ,drvFirstName = dbo.dsi_fnRemoveChars('.,/-',REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameFirst, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'))
        ,drvStatus = CASE WHEN EecEmplStatus ='T' THEN 'TE' ELSE 'AC' END
        ,drvActualAnnHours = dbo.dsi_fnPadZero(REPLACE(CONVERT(MONEY,PehCurHrs12Mos),'.00',''),4,0)
    INTO dbo.U_ENYSNYLIFE_drvTbl
    FROM dbo.U_ENYSNYLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_ENYSNYLIFE_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
       WHERE EecEEType <>  'TES'
    AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_ENYSNYLIFE_Audit where audEEID = xEEID AND audCoId = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
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
ALTER VIEW dbo.dsi_vwENYSNYLIFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENYSNYLIFE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ENYSNYLIFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202310071'
       ,expStartPerControl     = '202310071'
       ,expLastEndPerControl   = '202311149'
       ,expEndPerControl       = '202311149'
WHERE expFormatCode = 'ENYSNYLIFE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENYSNYLIFE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENYSNYLIFE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENYSNYLIFE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENYSNYLIFE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENYSNYLIFE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENYSNYLIFE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENYSNYLIFE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENYSNYLIFE', 'UseFileName', 'V', 'Y'


-- End ripout