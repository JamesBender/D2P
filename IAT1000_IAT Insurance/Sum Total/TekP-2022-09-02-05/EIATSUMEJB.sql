/**********************************************************************************

EIATSUMEJB: Sum Total Employee Job

FormatCode:     EIATSUMEJB
Project:        Sum Total Employee Job
Client ID:      IAT1000
Date/time:      2022-09-19 09:11:48.333
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB03
Database:       ULTIPRO_WPIATIG
Web Filename:   IAT1000_2BDI5_EEHISTORY_EIATSUMEJB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIATSUMEJB_SavePath') IS NOT NULL DROP TABLE dbo.U_EIATSUMEJB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIATSUMEJB'


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
WHERE FormatCode = 'EIATSUMEJB'
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
WHERE ExpFormatCode = 'EIATSUMEJB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIATSUMEJB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIATSUMEJB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIATSUMEJB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIATSUMEJB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIATSUMEJB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIATSUMEJB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIATSUMEJB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIATSUMEJB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIATSUMEJB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIATSUMEJB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIATSUMEJB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIATSUMEJB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIATSUMEJB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATSUMEJB];
GO
IF OBJECT_ID('U_EIATSUMEJB_File') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEJB_File];
GO
IF OBJECT_ID('U_EIATSUMEJB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEJB_EEList];
GO
IF OBJECT_ID('U_EIATSUMEJB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEJB_drvTbl];
GO
IF OBJECT_ID('U_EIATSUMEJB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEJB_AuditFields];
GO
IF OBJECT_ID('U_EIATSUMEJB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEJB_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIATSUMEJB','Sum Total Employee Job','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EIATSUMEJBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATSUMEJBZ0','50','H','01','1',NULL,'EMP_NO',NULL,NULL,'"EMP_NO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATSUMEJBZ0','50','H','01','2',NULL,'LAST_NAME',NULL,NULL,'"LAST_NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATSUMEJBZ0','50','H','01','3',NULL,'JOIN_DATE',NULL,NULL,'"JOIN_DATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATSUMEJBZ0','50','H','01','4',NULL,'PRIMARY',NULL,NULL,'"PRIMARY"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATSUMEJBZ0','50','D','10','1',NULL,'EMP_NO',NULL,NULL,'"drvEMP_NO"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATSUMEJBZ0','50','D','10','2',NULL,'JOB_CODE',NULL,NULL,'"drvJOB_CODE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATSUMEJBZ0','50','D','10','3',NULL,'JOIN_DATE',NULL,NULL,'"drvJOIN_DATE"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATSUMEJBZ0','50','D','10','4',NULL,'PRIMARY',NULL,NULL,'"1"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIATSUMEJB_20220919.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202209159','EMPEXPORT','OEACTIVE',NULL,'EIATSUMEJB',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202209159','EMPEXPORT','OEPASSIVE',NULL,'EIATSUMEJB',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sum Total Employee Job','202209159','EMPEXPORT','ONDEM_XOE',NULL,'EIATSUMEJB',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sum Total Employee Job-Sched','202209159','EMPEXPORT','SCH_EIATSU',NULL,'EIATSUMEJB',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Sum Total Employee Job-Test','202209159','EMPEXPORT','TEST_XOE',NULL,'EIATSUMEJB',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEJB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEJB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEJB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEJB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEJB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEJB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATSUMEJB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATSUMEJB','D10','dbo.U_EIATSUMEJB_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EIATSUMEJB_Audit
-----------

IF OBJECT_ID('U_EIATSUMEJB_Audit') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEJB_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
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
-- Create table U_EIATSUMEJB_AuditFields
-----------

IF OBJECT_ID('U_EIATSUMEJB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEJB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIATSUMEJB_drvTbl
-----------

IF OBJECT_ID('U_EIATSUMEJB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEJB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvEMP_NO] char(9) NULL,
    [drvJOB_CODE] char(8) NULL,
    [drvJOIN_DATE] datetime NULL
);

-----------
-- Create table U_EIATSUMEJB_EEList
-----------

IF OBJECT_ID('U_EIATSUMEJB_EEList') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEJB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIATSUMEJB_File
-----------

IF OBJECT_ID('U_EIATSUMEJB_File') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEJB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATSUMEJB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IAT Insurance Inc

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 09/15/2022
Service Request Number: TekP-2022-09-02-05

Purpose: Sum Total Employee Job

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIATSUMEJB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIATSUMEJB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIATSUMEJB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIATSUMEJB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIATSUMEJB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEJB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEJB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEJB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEJB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEJB', 'SCH_EIATSU';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIATSUMEJB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIATSUMEJB';

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
    DELETE FROM dbo.U_EIATSUMEJB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIATSUMEJB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIATSUMEJB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIATSUMEJB_AuditFields;
    CREATE TABLE dbo.U_EIATSUMEJB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EIATSUMEJB_AuditFields VALUES ('Empcomp','eecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIATSUMEJB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIATSUMEJB_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EIATSUMEJB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIATSUMEJB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIATSUMEJB_Audit ON dbo.U_EIATSUMEJB_Audit (audEEID,audKey2);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIATSUMEJB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIATSUMEJB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATSUMEJB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEMP_NO =EecEmpNo
        ,drvJOB_CODE = EecJobCode
        ,drvJOIN_DATE = EecDateInJob
    INTO dbo.U_EIATSUMEJB_drvTbl
    FROM dbo.U_EIATSUMEJB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        where EecOrgLvl2 not in ('DRG', 'IATF', 'IATKF', 'IATNY', 'IATRWF', 'IATS')
        AND eepnamelast <>'TEST'
    ;
    --MAX(EecDateInJob)
------Exclude ORGCODE: DRG, IATF, IATKF, IATNY, IATRWF, IATS; eepnamelast = 'TEST',


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEIATSUMEJB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIATSUMEJB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIATSUMEJB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209081'
       ,expStartPerControl     = '202209081'
       ,expLastEndPerControl   = '202209159'
       ,expEndPerControl       = '202209159'
WHERE expFormatCode = 'EIATSUMEJB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIATSUMEJB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIATSUMEJB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIATSUMEJB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIATSUMEJB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIATSUMEJB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATSUMEJB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIATSUMEJB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATSUMEJB', 'UseFileName', 'V', 'Y'


-- End ripout