/**********************************************************************************

EFDAGSUPEX: Agility Supervisor/Manager Export

FormatCode:     EFDAGSUPEX
Project:        Agility Supervisor/Manager Export
Client ID:      FOR1019
Date/time:      2022-11-29 15:54:08.347
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP2DB01
Database:       ULTIPRO_WPFDIH
Web Filename:   FOR1019_48SGR_EEHISTORY_EFDAGSUPEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFDAGSUPEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EFDAGSUPEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFDAGSUPEX'


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
WHERE FormatCode = 'EFDAGSUPEX'
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
WHERE ExpFormatCode = 'EFDAGSUPEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFDAGSUPEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFDAGSUPEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFDAGSUPEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFDAGSUPEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFDAGSUPEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFDAGSUPEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFDAGSUPEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFDAGSUPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFDAGSUPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFDAGSUPEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFDAGSUPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFDAGSUPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFDAGSUPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFDAGSUPEX];
GO
IF OBJECT_ID('U_EFDAGSUPEX_File') IS NOT NULL DROP TABLE [dbo].[U_EFDAGSUPEX_File];
GO
IF OBJECT_ID('U_EFDAGSUPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFDAGSUPEX_EEList];
GO
IF OBJECT_ID('U_EFDAGSUPEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFDAGSUPEX_drvTbl];
GO
IF OBJECT_ID('U_EFDAGSUPEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFDAGSUPEX_AuditFields];
GO
IF OBJECT_ID('U_EFDAGSUPEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFDAGSUPEX_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFDAGSUPEX','Agility Supervisor/Manager Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EFDAGSUPEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDAGSUPEXZ0','3','D','10','1',NULL,'Record ID',NULL,NULL,'"ZSM"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDAGSUPEXZ0','2','D','10','4',NULL,'Not Used',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDAGSUPEXZ0','1','D','10','6',NULL,'Format',NULL,NULL,'"C"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDAGSUPEXZ0','10','D','10','7',NULL,'Identification Code',NULL,NULL,'"drvIdentificationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDAGSUPEXZ0','20','D','10','17',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDAGSUPEXZ0','20','D','10','37',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDAGSUPEXZ0','20','D','10','57',NULL,'Middle Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDAGSUPEXZ0','4','D','10','77',NULL,'Suffix',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDAGSUPEXZ0','10','D','10','81',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDAGSUPEXZ0','1','D','10','91',NULL,'Code Type',NULL,NULL,'"drvCodeType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDAGSUPEXZ0','12','D','10','92',NULL,'Telephone',NULL,NULL,'"drvTelephone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDAGSUPEXZ0','6','D','10','104',NULL,'Extension',NULL,NULL,'"drvExtension"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDAGSUPEXZ0','12','D','10','110',NULL,'Fax',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDAGSUPEXZ0','50','D','10','122',NULL,'E-Mail',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDAGSUPEXZ0','255','D','10','172',NULL,'Windows Username',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFDAGSUPEX_20221129.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agility Supervisor/Manager Exp','202211299','EMPEXPORT','ONDEM_XOE',NULL,'EFDAGSUPEX',NULL,NULL,NULL,'202211299','Nov 29 2022 11:20AM','Nov 29 2022 11:20AM','202211291',NULL,'','','202211291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agility Supervisor/Manag-Sched','202211299','EMPEXPORT','SCH_EFDAGS',NULL,'EFDAGSUPEX',NULL,NULL,NULL,'202211299','Nov 29 2022 11:20AM','Nov 29 2022 11:20AM','202211291',NULL,'','','202211291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Agility Supervisor/Manag-Test','202211299','EMPEXPORT','TEST_XOE',NULL,'EFDAGSUPEX',NULL,NULL,NULL,'202211299','Nov 29 2022 11:20AM','Nov 29 2022 11:20AM','202211291',NULL,'','','202211291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDAGSUPEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDAGSUPEX','D10','dbo.U_EFDAGSUPEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EFDAGSUPEX_Audit
-----------

IF OBJECT_ID('U_EFDAGSUPEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EFDAGSUPEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audTerm] varchar(1) NOT NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EFDAGSUPEX_AuditFields
-----------

IF OBJECT_ID('U_EFDAGSUPEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFDAGSUPEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EFDAGSUPEX_drvTbl
-----------

IF OBJECT_ID('U_EFDAGSUPEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFDAGSUPEX_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvIdentificationCode] char(8) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvCompanyCode] char(5) NULL,
    [drvCodeType] varchar(1) NOT NULL,
    [drvTelephone] varchar(50) NULL,
    [drvExtension] varchar(10) NULL,
    [drvEmail] varchar(50) NULL
);

-----------
-- Create table U_EFDAGSUPEX_EEList
-----------

IF OBJECT_ID('U_EFDAGSUPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EFDAGSUPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFDAGSUPEX_File
-----------

IF OBJECT_ID('U_EFDAGSUPEX_File') IS NULL
CREATE TABLE [dbo].[U_EFDAGSUPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFDAGSUPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Fort Defiance 

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 11/29/2022
Service Request Number: TekP-2022-08-11-04

Purpose: Agility Supervisor/Manager Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFDAGSUPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFDAGSUPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFDAGSUPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFDAGSUPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFDAGSUPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFDAGSUPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFDAGSUPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFDAGSUPEX', 'SCH_EFDAGS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFDAGSUPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFDAGSUPEX';

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
    DELETE FROM dbo.U_EFDAGSUPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFDAGSUPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFDAGSUPEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFDAGSUPEX_AuditFields;
    CREATE TABLE dbo.U_EFDAGSUPEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_EFDAGSUPEX_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFDAGSUPEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFDAGSUPEX_Audit;
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
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EFDAGSUPEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EFDAGSUPEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EFDAGSUPEX_Audit ON dbo.U_EFDAGSUPEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EFDAGSUPEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFDAGSUPEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFDAGSUPEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFDAGSUPEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFDAGSUPEX_drvTbl;
    SELECT DISTINCT
           drvEEID = ''
        ,drvCoID = ''
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvIdentificationCode = SUP_JobDesc  -- CASE WHEn dbo.dsi_fnlib_IsSupervisor(xEEID) = 'Y' THEN SupJobDesc END
        ,drvNameLast =  SUP_LNAME
        ,drvNameFirst =  SUP_FNAME
        ,drvCompanyCode = CmpCompanyCode
        ,drvCodeType = 'S' -- CASE WHEn dbo.dsi_fnlib_IsSupervisor(xEEID) = 'Y' THEN  'S'  END
        ,drvTelephone = PH.SUP_Phone
        ,drvExtension = PH.SUP_PhExt
        ,drvEmail = SUP_EMAIL
    INTO dbo.U_EFDAGSUPEX_drvTbl
    FROM dbo.U_EFDAGSUPEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp S WITH (NOLOCK)
        ON S.EecEEID = xEEID 
        AND S.EecCoID = xCoID
    JOIN dbo.EmpPers  WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN ( SELECT EepEEID AS SUP_EEID, EepNameLast AS SUP_LNAME, EepNameFirst AS SUP_FNAME, EepAddressEmail AS SUP_EMAIL   
                FROM dbo.EmpPers WITH (NOLOCK)
        ) AS SUP
            ON EecSupervisorID = SUP_EEID
    JOIN (Select eeceeid AS SUP_PHEEID ,EecPhoneBusinessNumber AS SUP_Phone, EecPhoneBusinessExt AS SUP_PhExt , EecJobCode AS SUP_JobDesc 
                FROM dbo.EmpComp WITH (NOLOCK)
        ) AS PH 
        ON  PH.SUP_PHEEID = SUP_EEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = PH.SUP_JobDesc 
    JOIN dbo.Company WITH (NOLOCK)
            ON CmpCoID = xCoID
    LEFT JOIN dbo.U_EFDAGSUPEX_Audit WITH (NOLOCK)
        ON audEEID = xEEID
    Where S.EecEEType = 'REG'
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audTerm = 'Y' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN @StartDate AND @EndDate))
        

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
ALTER VIEW dbo.dsi_vwEFDAGSUPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFDAGSUPEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFDAGSUPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202211221'
       ,expStartPerControl     = '202211221'
       ,expLastEndPerControl   = '202211299'
       ,expEndPerControl       = '202211299'
WHERE expFormatCode = 'EFDAGSUPEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFDAGSUPEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFDAGSUPEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFDAGSUPEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFDAGSUPEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFDAGSUPEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFDAGSUPEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFDAGSUPEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFDAGSUPEX', 'UseFileName', 'V', 'Y'


-- End ripout