/**********************************************************************************

ECULSAPXML: SAP General Journal Entry XML

FormatCode:     ECULSAPXML
Project:        SAP General Journal Entry XML
Client ID:      CUL1000
Date/time:      2023-11-21 15:13:22.233
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N24
Server:         N2SUP4ST05
Database:       ULTIPRO_CULLIGAN
Web Filename:   CUL1000_03870_EEHISTORY_ECULSAPXML_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

NOTE:          MultFile is set to Y, meaning Switchbox doesn't directly write the file.
               The file(s) are probably created by an AfterCollect.


**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECULSAPXML_SavePath') IS NOT NULL DROP TABLE dbo.U_ECULSAPXML_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECULSAPXML'


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
WHERE FormatCode = 'ECULSAPXML'
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
WHERE ExpFormatCode = 'ECULSAPXML'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECULSAPXML')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECULSAPXML'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECULSAPXML'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECULSAPXML'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECULSAPXML'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECULSAPXML'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECULSAPXML'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECULSAPXML'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECULSAPXML'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECULSAPXML'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECULSAPXML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECULSAPXML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECULSAPXML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECULSAPXML];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_ECULSAPXML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_ECULSAPXML];
GO
IF OBJECT_ID('U_ECULSAPXML_XML') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_XML];
GO
IF OBJECT_ID('U_ECULSAPXML_WorkingTbl') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_WorkingTbl];
GO
IF OBJECT_ID('U_ECULSAPXML_PaymentId') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_PaymentId];
GO
IF OBJECT_ID('U_ECULSAPXML_File') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_File];
GO
IF OBJECT_ID('U_ECULSAPXML_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_EEList];
GO
IF OBJECT_ID('U_ECULSAPXML_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_DrvTbl];
GO
IF OBJECT_ID('U_ECULSAPXML_DDAmount') IS NOT NULL DROP TABLE [dbo].[U_ECULSAPXML_DDAmount];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ECULSAPXML','SAP General Journal Entry XML','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','500','S','N','ECULSAPXMLZ0','N',NULL,'C','dbo.dsi_sp_SwitchBox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------


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
/*08*/ DECLARE @FileName varchar(1000) = 'ECULSAPXML_20231121.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAP GL XML Export','202311179','EMPEXPORT','ONDEM_XOE',NULL,'ECULSAPXML',NULL,NULL,NULL,'202311179','Nov 20 2023  9:37AM','Nov 20 2023  9:37AM','202311171',NULL,'','','202311171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAP GL XML Export-Sched','202311179','EMPEXPORT','SCH_ECULSA',NULL,'ECULSAPXML',NULL,NULL,NULL,'202311179','Nov 20 2023  9:37AM','Nov 20 2023  9:37AM','202311171',NULL,'','','202311171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'SAP GL XML Export-Test','202311179','EMPEXPORT','TEST_XOE',NULL,'ECULSAPXML',NULL,NULL,NULL,'202311179','Nov 20 2023  9:37AM','Nov 20 2023  9:37AM','202311171',NULL,'','','202311171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','OverrideCount','V','728');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','PmtInfId','V','53');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECULSAPXML','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------


-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECULSAPXML_DDAmount
-----------

IF OBJECT_ID('U_ECULSAPXML_DDAmount') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_DDAmount] (
    [PrgEEID] char(12) NOT NULL,
    [PrhAcct] varchar(22) NULL,
    [PrhEEInstitutionNo] char(3) NULL,
    [PrhEEBankRoute] char(9) NULL,
    [PrgDDAmt] decimal NULL,
    [PrgPayDate] datetime NULL,
    [PrhPayGroup] char(6) NOT NULL
);

-----------
-- Create table U_ECULSAPXML_DrvTbl
-----------

IF OBJECT_ID('U_ECULSAPXML_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_DrvTbl] (
    [drvEmpNo] varchar(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvDivision] varchar(25) NULL,
    [drvWorkPhoneBusinessCountry] varchar(1) NULL,
    [drvWorkPhoneBusinessNumber] varchar(50) NULL,
    [drvWorkPhoneBusinessExt] varchar(10) NULL,
    [drvCELPhoneCountryPrefix] varchar(10) NULL,
    [drvCELPhoneNumber] varchar(50) NULL,
    [drvCELPhoneExtension] varchar(10) NULL,
    [drvPhoneHomeCountry] varchar(1) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvAddressEmailAlternate] varchar(50) NULL,
    [drvEEID] varchar(12) NULL,
    [drvCOID] varchar(5) NULL
);

-----------
-- Create table U_ECULSAPXML_EEList
-----------

IF OBJECT_ID('U_ECULSAPXML_EEList') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECULSAPXML_File
-----------

IF OBJECT_ID('U_ECULSAPXML_File') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(500) NULL
);

-----------
-- Create table U_ECULSAPXML_PaymentId
-----------

IF OBJECT_ID('U_ECULSAPXML_PaymentId') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_PaymentId] (
    [IDPayDate] datetime NULL,
    [PaymentIDCounter] bigint NULL,
    [PaymentID] int NULL
);

-----------
-- Create table U_ECULSAPXML_WorkingTbl
-----------

IF OBJECT_ID('U_ECULSAPXML_WorkingTbl') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_WorkingTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(31) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvGLAccount] varchar(8) NOT NULL,
    [drvItemText] varchar(39) NULL,
    [drvDebit] decimal NULL,
    [drvCredit] numeric NULL,
    [drvValueDate] datetime NULL,
    [drvAssignmentNumber] varchar(24) NULL
);

-----------
-- Create table U_ECULSAPXML_XML
-----------

IF OBJECT_ID('U_ECULSAPXML_XML') IS NULL
CREATE TABLE [dbo].[U_ECULSAPXML_XML] (
    [XMLOUT] xml(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_ECULSAPXML]
AS
/**********************************************************************************
Client Name: Culligan International

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 11/18/2023
Service Request Number: TekP-2023-02-28-01

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/15        SR-2015-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'ECULSAPXML';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'TEST_XOE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECULSAPXML', @AllObjects = 'Y', @IsWeb='Y';
**********************************************************************************/
BEGIN

    -- Declare variables
    DECLARE @FormatCode        VARCHAR(10)
            ,@sCmd            VARCHAR(1000)
            ,@ExportPath    VARCHAR(500)
            ,@FileName        VARCHAR(1000)
            ,@sXML            VARCHAR(100);

    -- Set variables
    SET @FormatCode = 'ECULSAPXML';
    SET @ExportPath = ''--dbo.dsi_fnVariable(@FormatCode,'ExportPath');
    SET @FileName = (SELECT StepValue FROM dbo.U_dsi_InterfaceProcesses where FormatCode = 'ECULSAPXML' AND StepID = 0);
    SET @sXML = '' --'<?xml version=""1.0"" encoding=""UTF-8""?>';

    --=====================================
    -- Generate XML File via Custom BCP
    --=====================================
    SELECT @sCmd = 'BCP "SELECT ''' + @sXML + ''' + CONVERT(VARCHAR(MAX),XMLOUT) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_ECULSAPXML_XML WITH (NOLOCK) " QueryOut "' + @ExportPath + @FileName +'"' +
                  ' -S"' + rtrim(@@SERVERNAME) + '" -T -c -t';

    PRINT 'Custom BCP: '+ @sCmd;
    
    IF (SELECT COUNT(*) FROM dbo.U_ECULSAPXML_WorkingTbl WITH (NOLOCK)) > 0 --If no amounts, don't make a file
    EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECULSAPXML]
    @systemid CHAR(12)
AS
/**********************************************************************************
Client: Culligan International

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 11/18/2023
Service Request Number: TekP-2023-02-28-01

Purpose: SAP General Journal Entry XML Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECULSAPXML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECULSAPXML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECULSAPXML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECULSAPXML', 'SCH_ECULSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECULSAPXML', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
        DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9)
            ,@FileName           VARCHAR(100)
			,@ValueDate          Varchar(50)

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ECULSAPXML';

    -- Set @FileName
    SET @FileName = (SELECT StepValue FROM dbo.U_dsi_InterfaceProcesses where FormatCode = 'ECULSAPXML' AND StepID = 0);

    --==========================================
    -- Working Tables
    --==========================================

    ---Working Table
       IF OBJECT_ID('U_ECULSAPXML_WorkingTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_WorkingTbl;

     SELECT * INTO dbo.U_ECULSAPXML_WorkingTbl
      FROM ( 
      SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''   
        ,drvInitialSort = cast(ck.ckhrecid as varchar) + '1'
        ,drvSubSort = '1' 
        ,drvGLAccount =  '21501001'                                        
        ,drvItemText = CASE WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
                                WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
                                WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
                                WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
                                WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
                                WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
                                WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
                                WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
                                WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
                                WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
                                WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
                                WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
                                WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
                                WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
                                WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
                                WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
                                WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
                                WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
                                WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
                                WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
                                WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
                                WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
                                WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
                                END        
        ,drvDebit = CAST(SUM(vDebitAmt)AS DECIMAL(18,2))
        ,drvCredit = 0.00 --SUM(vCreditAmt)
        ,drvValueDate =  MAX(VPaydate)
        ,drvAssignmentNumber = ''      
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
        ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   JOIN dbo.ChkHead ck WITH (NOLOCK)
        ON ckhgennumber = vGenNumber
   --   Where Convert(VARCHAR, VPaydate, 120) Between Convert(VARCHAR, @Startdate, 120) and Convert(VARCHAR, @Enddate, 120)
        AND CASE WHEN vPayGroup = 'PGN' THEN 'Paragon Payroll Checks'
                                WHEN vPayGroup = 'CWGB' THEN 'CWG Payroll Checks'
                                WHEN vPayGroup = 'BCC' THEN 'Culligan BCC Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'Culligan BLT Payroll Checks'
                                WHEN vPayGroup = 'EXWT' THEN 'EXWT Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = '3003C' THEN '3003C Culligan Canada Payroll Checks'
                                WHEN vPayGroup = 'ACC' THEN 'ACC-Culligan Corporate Payroll Checks'
                                WHEN vPayGroup = 'APEC' THEN 'APEC Biweekly Payroll Checks'
                                WHEN vPayGroup = 'BCI' THEN 'BCI-Culligan Intl Payroll Checks'
                                WHEN vPayGroup = 'BCL' THEN 'BCL Franchise Commercial Payroll Checks'
                                WHEN vPayGroup = 'BCR' THEN 'BCR Retail Payroll Checks'
                                WHEN vPayGroup = 'BCS' THEN 'BCS-Culligan Sales Comp Payroll Checks'
                                WHEN vPayGroup = 'BIH' THEN 'BIH Intl Headquarters Payroll Checks'
                                WHEN vPayGroup = 'BIS1' THEN 'BIS-Industrial Sales Payroll Checks'
                                WHEN vPayGroup = 'BLT' THEN 'BLT-Layton Plant Payroll Checks'
                                WHEN vPayGroup = 'BRF' THEN 'BRF Corporate Transition Payroll Checks'
                                WHEN vPayGroup = 'CWC' THEN 'CWC Payroll Checks'
                                WHEN vPayGroup = 'CWG' THEN 'CWG Weekly Payroll Checks'
                                WHEN vPayGroup = 'FOAM' THEN 'FOAM Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'GTW' THEN 'GTW Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'HYDRO' THEN 'HYDRO Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'LTD' THEN ' Cull Ltd Payroll Checks'
                                WHEN vPayGroup = 'NAR' THEN 'NAR-National Acct Rest Payroll Checks'
                                WHEN vPayGroup = 'OMNI' THEN 'Omnipute Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'QCAN' THEN 'Quench Canada Payroll Checks'
                                WHEN vPayGroup = 'QNYS' THEN ' Quench NYS Weekly Payroll Checks'
                                WHEN vPayGroup = 'QPRC' THEN 'Quench Puerto Rico Payroll Checks'
                                WHEN vPayGroup = 'QUSA' THEN 'Quench USA Payroll Checks'
                                WHEN vPayGroup = 'RAYNE' THEN 'Rayne Payroll Checks'
                                WHEN vPayGroup = 'RDL' THEN 'RDL-Water Analysis Lab Payroll Checks'
                                WHEN vPayGroup = 'WATERB' THEN 'WaterCo Bi-Weekly Payroll Checks'
                                WHEN vPayGroup = 'WATERC' THEN 'Waterco Payroll Checks'
                                WHEN vPayGroup = 'ZERO' THEN 'Zero Payroll Checks'
                                WHEN vPayGroup = 'ZIP' THEN 'ZIP - US Payroll Checks'
                                END  is not null
    GROUP BY   vPayGroup, ck.ckhrecid
    Having CAST(SUM(vDebitAmt)AS DECIMAL(18,2)) <> 0.00 
    
    
    Union

      SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort =  cast(ck.ckhrecid as varchar) + '2'
        ,drvSubSort = '2'
        ,drvGLAccount =   '11015050'                               
        ,drvItemText =  '11015050'                              
        ,drvDebit =  0.00 --SUM(vDebitAmt)
        ,drvCredit = CAst(SUM(vCreditAmt) AS DECIMAL(18,2))
        ,drvValueDate =  MAX(VPaydate)
        ,drvAssignmentNumber =  dbo.dsi_fnPadZeroS(ck.ckhrecid,13,0 )
     FROM dbo.vw_dsi_TmpAlloc WITH (NOLOCK)
    LEFT JOIN dbo.GLBAccts WITH (NOLOCK)
        ON GlbBaseSegment = substring(vGLAcctNumber,11,8)
   JOIN dbo.ChkHead ck WITH (NOLOCK)
        ON ckhgennumber = vGenNumber
       -- Where Convert(VARCHAR, VPaydate, 120) Between Convert(VARCHAR, @Startdate, 120) and Convert(VARCHAR, @Enddate, 120)
    GROUP BY ck.ckhrecid
    
    having CAst(SUM(vCreditAmt) AS DECIMAL(18,2)) <> 0.00 ) w
     
        
     SET @ValueDate = (Select Convert(VARCHAR (10),MAX(drvValueDate), 126)  FROM  dbo.U_ECULSAPXML_WorkingTbl) 

     --==========================================
    -- Build XML / Load For Custom BCP
    --==========================================

    -- Create Table for BCP Export
    IF OBJECT_ID('U_ECULSAPXML_XML') IS NOT NULL
        DROP TABLE dbo.U_ECULSAPXML_XML
    CREATE TABLE dbo.U_ECULSAPXML_XML (
        XMLOUT XML
    );

    ------------------
    -- Build XML For Header Data
    ------------------
    DECLARE @HdrXML XML, @JournalXML XML,@XMLOUT VARCHAR(MAX)

  SELECT @HdrXML =
     
        (SELECT 
        CreationDateTime =  Convert(VARCHAR, GETDATE(),112) +'T' + convert(VARCHAR(8), GETDATE(), 14) + 'Z'
        
        FOR XML PATH ('MessageHeader')
        , TYPE )     
    

    --SELECT @HdrXML

    ------------------
    -- Build XML For Journal Data
    ------------------
    SELECT @JournalXML =
          
        (SELECT
          
            (SELECT 
                CreationDateTime =  Convert(VARCHAR, GETDATE(),112) +'T' + convert(VARCHAR(8), GETDATE(), 14) + 'Z'
        
            FOR XML PATH ('MessageHeader')
            , TYPE )     
        ,
            (SELECT 
                OriginalReferenceDocumentType = 'BKPFF'
               ,OriginalReferenceDocument = 'TEST'
               ,OriginalReferenceDocumentLogicalSystem = '0LELAAS'
               ,BusinessTransactionType = 'RFBU'
               ,AccountingDocumentType = 'SI'
               ,DocumentHeaderText= 'Test DocumentHeaderText'
               ,CreatedByUser ='TEST'
               ,CompanyCode = 'US01'
               ,DocumentDate= @ValueDate
               ,PostinDate = @ValueDate
               ,DocumentReferenceID = '1508'
               ,(SELECT
                    CompanyCode = 'US01'
                   ,GLAccount= drvGLAccount
                   ,(SELECT  "@currencyCode"='USD' 
                             , CASE WHEN drvGLAccount <>'11015050' and  FORMAT(drvDebit, '#.##' )  <> '0.00' THEN FORMAT(drvDebit, '#.##') 
									WHEN drvGLAccount ='11015050' and FORMAT(drvCredit, '#.##' )  <> '0.00' THEN FORMAT(drvCredit, '#.##') 
								END
                                FOR XML PATH ('AmountInTransactionCurrency')
                            ,TYPE)
                    ,(SELECT  "@currencyCode"='USD' 
                             , CASE WHEN drvGLAccount <>'11015050' and  FORMAT(drvDebit, '#.##' )  <> '0.00' THEN FORMAT(drvDebit, '#.##') 
									WHEN drvGLAccount ='11015050' and FORMAT(drvCredit, '#.##' )  <> '0.00' THEN FORMAT(drvCredit, '#.##')
									END 
                                FOR XML PATH ('AmountInCompanyCodeCurrency')
                            ,TYPE)
                    ,DocumentItemText = CASE WHEN drvGLAccount <>'11015050' and FORMAT(drvDebit, '#.##' )  <> '0.00' THEN drvItemText
											 WHEN drvGLAccount ='11015050' and FORMAT(drvCredit, '#.##' )  <> '0.00' THEN drvItemText 
										 END
                    ,AssignmentReference =  CASE WHEN drvGLAccount <>'11015050' and FORMAT(drvDebit, '#.##' )  <> '0.00' THEN drvAssignmentNumber
												 WHEN drvGLAccount ='11015050' and FORMAT(drvCredit, '#.##' )  <> '0.00' THEN drvAssignmentNumber 
											 END 
                    ,(SELECT 
                     ProfitCenter= 'C8010'
                    FOR XML PATH ('AccountAssignment')
                    ,TYPE)
                 FROM dbo.U_ECULSAPXML_WorkingTbl
                             
             
                 
                 FOR XML PATH ('Item')
                 ,TYPE)
             
            FOR XML PATH ('JournalEntry')
            ,TYPE)
        FOR XML PATH  ('JournalEntryCreateRequest')
        ,TYPE)
        ;
   
   SELECT @XMLOUT = (SELECT @HdrXML, @JournalXML FOR XML RAW)
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'<Row>','')); 
    SET @XMLOUT = (SELECT REPLACE(@XMLOUT,'</Row>',''));


--SELECT  @XMLOUT

    SET @XMLOUT = CONCAT('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sfin="http://sap.com/xi/SAPSCORE/SFIN">'
                        , '<soapenv:Header/>'
                        , '<soapenv:Body>'
                        ,'<sfin:JournalEntryBulkCreateRequest>'
                        ,@XMLOUT
                        ,'</sfin:JournalEntryBulkCreateRequest>'
                        ,'</soapenv:Body>'
                        ,'</soapenv:Envelope>'
                        )

   --SELECT @XMLOUT    
   
    -- Load Into Custom Table for BCP Export
    INSERT INTO dbo.U_ECULSAPXML_XML (XMLOUT)
    VALUES (@XMLOUT)

    --=====================================================
    -- Update Record Count
    --=====================================================
    UPDATE dbo.U_dsi_Configuration
        SET CfgValue = ISNULL((SELECT COUNT(*) FROM dbo.U_ECULSAPXML_WorkingTbl WITH (NOLOCK)),'0')
    WHERE FormatCode = 'ECULSAPXML' AND CfgName = 'OverrideCount';

    --=====================================================
    -- Set FileName: writing_request_MMDDYYYYHHMMSS.xml
    --=====================================================
    IF (dbo.dsi_fnVariable('ECULSAPXML','UseFileName') = 'N')
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = @FileName
        WHERE FormatCode = 'ECULSAPXML';

END
/*

-- View XML File from XML Table
SELECT * FROM dbo.U_ECULSAPXML_XML (NOLOCK)

*/
GO
CREATE VIEW dbo.dsi_vwECULSAPXML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECULSAPXML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECULSAPXML' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECULSAPXML'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECULSAPXML'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPXML', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPXML', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECULSAPXML', 'UseFileName', 'V', 'Y'


-- End ripout