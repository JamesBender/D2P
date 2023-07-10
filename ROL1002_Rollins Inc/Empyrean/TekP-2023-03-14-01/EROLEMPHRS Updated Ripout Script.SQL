/**********************************************************************************

EROLEMPHRS: Empyrean Payroll Hours

FormatCode:     EROLEMPHRS
Project:        Empyrean Payroll Hours
Client ID:      ROL1002
Date/time:      2023-04-24 07:48:34.983
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
Web Filename:   ROL1002_C9MXB_EEHISTORY_EROLEMPHRS_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EROLEMPHRS_SavePath') IS NOT NULL DROP TABLE dbo.U_EROLEMPHRS_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EROLEMPHRS'


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
WHERE FormatCode = 'EROLEMPHRS'
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
WHERE ExpFormatCode = 'EROLEMPHRS'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EROLEMPHRS')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EROLEMPHRS'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EROLEMPHRS'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EROLEMPHRS'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EROLEMPHRS'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EROLEMPHRS'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EROLEMPHRS'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EROLEMPHRS'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EROLEMPHRS'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EROLEMPHRS'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEROLEMPHRS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEROLEMPHRS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EROLEMPHRS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLEMPHRS];
GO
IF OBJECT_ID('U_EROLEMPHRS_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EROLEMPHRS_PEarHist];
GO
IF OBJECT_ID('U_EROLEMPHRS_File') IS NOT NULL DROP TABLE [dbo].[U_EROLEMPHRS_File];
GO
IF OBJECT_ID('U_EROLEMPHRS_EEList') IS NOT NULL DROP TABLE [dbo].[U_EROLEMPHRS_EEList];
GO
IF OBJECT_ID('U_EROLEMPHRS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EROLEMPHRS_drvTbl];
GO
IF OBJECT_ID('U_EROLEMPHRS_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EROLEMPHRS_AuditFields];
GO
IF OBJECT_ID('U_EROLEMPHRS_Audit') IS NOT NULL DROP TABLE [dbo].[U_EROLEMPHRS_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EROLEMPHRS','Empyrean Payroll Hours','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EROLEMPHRSZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLEMPHRSZ0','50','H','01','1',NULL,'ClientID',NULL,NULL,'"ClientID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLEMPHRSZ0','50','H','01','2',NULL,'SourceSystemCode',NULL,NULL,'"SourceSystemCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLEMPHRSZ0','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLEMPHRSZ0','50','H','01','4',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLEMPHRSZ0','50','H','01','5',NULL,'HoursDate',NULL,NULL,'"HoursDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLEMPHRSZ0','50','H','01','6',NULL,'HoursAmount',NULL,NULL,'"HoursAmount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLEMPHRSZ0','50','H','01','7',NULL,'HoursCode',NULL,NULL,'"HoursCode"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLEMPHRSZ0','50','D','10','1',NULL,'ClientID',NULL,NULL,'"SH_Roll001"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLEMPHRSZ0','50','D','10','2',NULL,'SourceSystemCode',NULL,NULL,'"drvSourceSystemCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLEMPHRSZ0','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLEMPHRSZ0','50','D','10','4',NULL,'EmployeeID',NULL,NULL,'"drvEmpID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLEMPHRSZ0','50','D','10','5',NULL,'HoursDate',NULL,NULL,'"drvHoursDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLEMPHRSZ0','50','D','10','6',NULL,'HoursAmount',NULL,NULL,'"drvHoursAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLEMPHRSZ0','50','D','10','7',NULL,'HoursCode',NULL,NULL,'"drvHoursCode"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EROLEMPHRS_20230424.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Payroll Hours','202304149','EMPEXPORT','ONDEM_XOE',NULL,'EROLEMPHRS',NULL,NULL,NULL,'202304149','Apr  5 2023  8:05AM','Apr  5 2023  8:05AM','202304081',NULL,'','','202304081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Payroll Hours-Sched','202304149','EMPEXPORT','SCH_EROLEM',NULL,'EROLEMPHRS',NULL,NULL,NULL,'202304149','Apr  5 2023  8:05AM','Apr  5 2023  8:05AM','202304081',NULL,'','','202304081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Empyrean Payroll Hours-Test','202304149','EMPEXPORT','TEST_XOE',NULL,'EROLEMPHRS',NULL,NULL,NULL,'202304149','Apr  5 2023  8:05AM','Apr  5 2023  8:05AM','202304081',NULL,'','','202304081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMPHRS','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLEMPHRS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLEMPHRS','D10','dbo.U_EROLEMPHRS_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EROLEMPHRS_Audit
-----------

IF OBJECT_ID('U_EROLEMPHRS_Audit') IS NULL
CREATE TABLE [dbo].[U_EROLEMPHRS_Audit] (
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
-- Create table U_EROLEMPHRS_AuditFields
-----------

IF OBJECT_ID('U_EROLEMPHRS_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EROLEMPHRS_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EROLEMPHRS_drvTbl
-----------

IF OBJECT_ID('U_EROLEMPHRS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EROLEMPHRS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] datetime NULL,
    [drvSubSort] char(11) NULL,
    [drvSourceSystemCode] varchar(11) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpID] char(9) NULL,
    [drvHoursDate] datetime NULL,
    [drvHoursAmount] nvarchar(4000) NULL,
    [drvHoursCode] varchar(5) NULL
);

-----------
-- Create table U_EROLEMPHRS_EEList
-----------

IF OBJECT_ID('U_EROLEMPHRS_EEList') IS NULL
CREATE TABLE [dbo].[U_EROLEMPHRS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EROLEMPHRS_File
-----------

IF OBJECT_ID('U_EROLEMPHRS_File') IS NULL
CREATE TABLE [dbo].[U_EROLEMPHRS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EROLEMPHRS_PEarHist
-----------

IF OBJECT_ID('U_EROLEMPHRS_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EROLEMPHRS_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] char(5) NOT NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLEMPHRS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 04/01/2023
Service Request Number: TekP-2023-03-14-01

Purpose: Empyrean Payroll Hours

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        04/24/2023       TekP-2023-03-14-01 Added code to pull PehExclInTotalHours = 'N' and changed code for SourceSystemCode
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EROLEMPHRS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EROLEMPHRS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EROLEMPHRS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EROLEMPHRS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EROLEMPHRS' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303291'
       ,expStartPerControl     = '202303291'
       ,expLastEndPerControl   = '202304059'
       ,expEndPerControl       = '202304059'
WHERE expFormatCode = 'EROLEMPHRS';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMPHRS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMPHRS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMPHRS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMPHRS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMPHRS', 'SCH_EROLEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EROLEMPHRS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EROLEMPHRS';

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
    DELETE FROM dbo.U_EROLEMPHRS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EROLEMPHRS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EROLEMPHRS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMPHRS_AuditFields;
    CREATE TABLE dbo.U_EROLEMPHRS_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EROLEMPHRS_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EROLEMPHRS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMPHRS_Audit;
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
    INTO dbo.U_EROLEMPHRS_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EROLEMPHRS_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EROLEMPHRS_Audit ON dbo.U_EROLEMPHRS_Audit (audEEID,audKey2);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EROLEMPHRS_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMPHRS_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehEarnCode
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
    INTO dbo.U_EROLEMPHRS_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON prgEEID = pehEEID 
        AND prgGenNumber = pehGenNumber
    WHERE PehPerControl Between @StartPerControl
    AND  @EndPerControl 
    AND PehExclInTotalHours = 'N' --MW added
    GROUP BY PehEEID,PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EROLEMPHRS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EROLEMPHRS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMPHRS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = PrgPayDate
        ,drvSubSort = eepssn
        -- standard fields above and additional driver fields below
        ,drvSourceSystemCode = CASE WHEN ISNULL(PehCurHrs,0.00) < 0.00 then 'Correction1' ELSE 'RollinsUKG' END--CASE WHEN RTRIM(PehEarnCode) < 0 then 'Correction1' else 'RollinsUKG' END--MW Changed
        ,drvSSN = eepssn
        ,drvEmpID = EecEmpno
        ,drvHoursDate = PrgPayDate
        ,drvHoursAmount = CASE WHEN PehCurHrs <> 0 THEN FORMAT(PehCurHrs, '###.##') ELSE '00.00' END 
        ,drvHoursCode = RTRIM(PehEarnCode)
    INTO dbo.U_EROLEMPHRS_drvTbl
    FROM dbo.U_EROLEMPHRS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND EecEEType <> 'TES'
                and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_EROLEMPHRS_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_EROLEMPHRS_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        On EepEEID = xEEID
    --WHERE ISNULL(PehCurHrs,0.00) <> 0.00 -- MW added
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'ROL_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_ROL_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'ROL_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEROLEMPHRS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EROLEMPHRS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EROLEMPHRS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304081'
       ,expStartPerControl     = '202304081'
       ,expLastEndPerControl   = '202304149'
       ,expEndPerControl       = '202304149'
WHERE expFormatCode = 'EROLEMPHRS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEROLEMPHRS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EROLEMPHRS_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EROLEMPHRS' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EROLEMPHRS'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EROLEMPHRS'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLEMPHRS', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EROLEMPHRS', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLEMPHRS', 'UseFileName', 'V', 'Y'


-- End ripout