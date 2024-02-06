/**********************************************************************************

ECYCFSAENR: Connect Your Care FSA HSA Enrollment Export

FormatCode:     ECYCFSAENR
Project:        Connect Your Care FSA HSA Enrollment Export
Client ID:      MGP1000
Date/time:      2024-02-05 13:28:49.160
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPMGPI
Web Filename:   MGP1000_BLF99_EEHISTORY_ECYCFSAENR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECYCFSAENR_SavePath') IS NOT NULL DROP TABLE dbo.U_ECYCFSAENR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECYCFSAENR'


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
WHERE FormatCode = 'ECYCFSAENR'
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
WHERE ExpFormatCode = 'ECYCFSAENR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECYCFSAENR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECYCFSAENR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECYCFSAENR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECYCFSAENR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECYCFSAENR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECYCFSAENR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECYCFSAENR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECYCFSAENR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECYCFSAENR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECYCFSAENR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECYCFSAENR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCFSAENR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCFSAENR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCFSAENR];
GO
IF OBJECT_ID('U_ECYCFSAENR_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAENR_PEarHist];
GO
IF OBJECT_ID('U_ECYCFSAENR_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAENR_PDedHist];
GO
IF OBJECT_ID('U_ECYCFSAENR_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAENR_File];
GO
IF OBJECT_ID('U_ECYCFSAENR_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAENR_EEList];
GO
IF OBJECT_ID('U_ECYCFSAENR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAENR_drvTbl];
GO
IF OBJECT_ID('U_ECYCFSAENR_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECYCFSAENR_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECYCFSAENR','Connect Your Care FSA HSA Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','300','S','N','ECYCFSAENRZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCFSAENRZ0','11','D','10','1',NULL,'Account SSN',NULL,NULL,'"drvAccountSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCFSAENRZ0','30','D','10','12',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCFSAENRZ0','30','D','10','42',NULL,'Special Use',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCFSAENRZ0','30','D','10','72',NULL,'Policy Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECYCFSAENRZ0','2','D','10','102',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECYCFSAENRZ0','8','D','10','104',NULL,'Transaction Effective Date',NULL,NULL,'"drvTransactionEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECYCFSAENRZ0','8','D','10','112',NULL,'Policy Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECYCFSAENRZ0','20','D','10','120',NULL,'Enrollment Submitter ID',NULL,NULL,'"MGPINGREDIENTS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECYCFSAENRZ0','30','D','10','140',NULL,'Employer ID',NULL,NULL,'"MGPINGREDIENTS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECYCFSAENRZ0','30','D','10','170',NULL,'Employer Offering ID',NULL,NULL,'"drvEmployerOfferingID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECYCFSAENRZ0','10','D','10','200',NULL,'Option ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECYCFSAENRZ0','10','D','10','210',NULL,'Tier Coverage Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECYCFSAENRZ0','10','D','10','220',NULL,'Total Policy Amount',NULL,NULL,'"drvTotalPolicyAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECYCFSAENRZ0','8','D','10','230',NULL,'HSA Disclosure Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECYCFSAENRZ0','8','D','10','238',NULL,'HSA Disclosure Time',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECYCFSAENRZ0','30','D','10','246',NULL,'Partner Employee ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECYCFSAENRZ0','20','D','10','276',NULL,'HSA Account Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECYCFSAENRZ0','5','D','10','296',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECYCFSAENR_20240205.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',WA3OC,M0UP1,M0U4Y',NULL,NULL,NULL,'CYC FSA HSA Active Open Enroll','202212069','EMPEXPORT','ACTIVEXOE',NULL,'ECYCFSAENR',NULL,NULL,NULL,'202212069',NULL,NULL,'202212061',NULL,NULL,'','202212061',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',WA3OC,M0UP1,M0U4Y,Y5019',NULL,NULL,NULL,'CYC FSA HSA Enrollment-OnDem','202402059','EMPEXPORT','ONDEM_XOE','Jan  3 2022  4:32PM','ECYCFSAENR',NULL,NULL,NULL,'202402059','Jan  3 2022 12:00AM','Dec 30 1899 12:00AM','202402051','379','','','202402051',dbo.fn_GetTimedKey(),NULL,'us3cPeMGP1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',WA3OC,M0UP1,M0U4Y,Y5019',NULL,NULL,NULL,'CYC FSA HSA Enrollment-Sched','202105079','EMPEXPORT','SCH_ECYCFS',NULL,'ECYCFSAENR',NULL,NULL,NULL,'202402029','Dec  1 2020 10:01AM','Dec  1 2020 10:01AM','202401261',NULL,'','','202104301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAENR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAENR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAENR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAENR','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAENR','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCFSAENR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCFSAENR','D10','dbo.U_ECYCFSAENR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECYCFSAENR_DedList
-----------

IF OBJECT_ID('U_ECYCFSAENR_DedList') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAENR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECYCFSAENR_drvTbl
-----------

IF OBJECT_ID('U_ECYCFSAENR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAENR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(5) NOT NULL,
    [drvAccountSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvTransactionType] varchar(1) NOT NULL,
    [drvTransactionEffDate] datetime NULL,
    [drvEmployerOfferingID] varchar(10) NULL,
    [drvTotalPolicyAmount] varchar(24) NULL
);

-----------
-- Create table U_ECYCFSAENR_EEList
-----------

IF OBJECT_ID('U_ECYCFSAENR_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAENR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECYCFSAENR_File
-----------

IF OBJECT_ID('U_ECYCFSAENR_File') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAENR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(300) NULL
);

-----------
-- Create table U_ECYCFSAENR_PDedHist
-----------

IF OBJECT_ID('U_ECYCFSAENR_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAENR_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhHSAEE] numeric NULL,
    [PdhDCAPEE] numeric NULL,
    [PdhPayDate] datetime NULL
);

-----------
-- Create table U_ECYCFSAENR_PEarHist
-----------

IF OBJECT_ID('U_ECYCFSAENR_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECYCFSAENR_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCFSAENR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MGPI Processing

Created By: Carrie McDowell
Business Analyst: Van Amundson
Create Date: 12/01/2020
Service Request Number: N/A Partner Direct

Purpose: Connect Your Care FSA HSA Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        02/02/2024       TekP-2023-10-24-03  Added coding for OE on EmployerOfferingID to Prod file
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCFSAENR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCFSAENR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCFSAENR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECYCFSAENR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCFSAENR' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;


--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
update dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ECYCFSAENR' AND cfgname = 'Testing';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAENR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAENR', 'SCH_ECYCFS';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCFSAENR', 'ACTIVEXOE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECYCFSAENR', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ECYCFSAENR';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = CASE WHEN @ExportCode = 'ACTIVEXOE ' THEN CONCAT(YEAR(GetDate())+ 1,'0101') ELSE CONCAT(YEAR(GetDate()),'0101') END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECYCFSAENR_EEList --select * from  dbo.U_ECYCFSAENR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCFSAENR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSAI,HSACI,HSAA1,HSAA3,HSAF,HSACF,HSAA2,HSAA4,FLXLB,DCPLB,FLXAT,DPCAT';

    IF OBJECT_ID('U_ECYCFSAENR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAENR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECYCFSAENR_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


--============================================================
-- BDM BCA
--============================================================
--Quick Start

--Paste the following code into your stored procedure:
DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @DedList);
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate);
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate);
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable_v2 @FormatCode;


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

--select * from dbo.U_dsi_BDM_EmpDeductions with (nolock) where eedformatcode = 'ECYCFSAENR' and eedvalidforexport = 'Y'
    --==========================================
    -- Build Working Tables
    --==========================================

 --   -----------------------------
 --   -- Working Table - PDedHist
 --   -----------------------------
 --     IF OBJECT_ID('U_ECYCFSAENR_PDedHist','U') IS NOT NULL
 --       DROP TABLE dbo.U_ECYCFSAENR_PDedHist;
 --   SELECT DISTINCT
 --        PdhEEID
 --        --,Substring(PdhPerControl,1,8) AS PdhPayDate
 --        ,PdhDedCode
 --       -- Current Payroll Amounts
 --       ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
 --       -- YTD Payroll Amounts
 --       ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
 --       -- Categorize Payroll Amounts
 --       ,PdhHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') THEN PdhEECurAmt ELSE 0.00 END)
 --       ,PdhDCAPEE     = SUM(CASE WHEN PdhDedCode IN ('FLXLB','DCPLB','FLXAT','DPCAT') THEN PdhEECurAmt ELSE 0.00 END) 
    --    ,PdhPayDate    = MAX(PdhPayDate)
    --INTO dbo.U_ECYCFSAENR_PDedHist -- SELECT *            --SELECT pdhdedcode, count(pdheeid) FROM dbo.U_ECYCFSAENR_PDedHist group by pdhdedcode
 --   FROM dbo.PDedHist WITH (NOLOCK)
 --   JOIN dbo.U_ECYCFSAENR_DedList WITH (NOLOCK) -- select * from dbo.U_ECYCFSAENR_EEList
 --      ON DedCode = PdhDedCode                    -- select distinct PdhDedCode from dbo.PDedHist            
    --WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
 --   --LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
 --   --AND PdhPerControl <= @EndPerControl
 --   GROUP BY PdhEEID,PdhDedCode;
    

    -------------------------------
 --   -- Working Table - PEarHist
 --   -----------------------------
    IF OBJECT_ID('U_ECYCFSAENR_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAENR_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    INTO dbo.U_ECYCFSAENR_PEarHist --SELECT * FROM U_ECYCFSAENR_PEarHist
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
    -- DETAIL RECORD - U_ECYCFSAENR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECYCFSAENR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECYCFSAENR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = EedDedCode
        -- standard fields above and additional driver fields below
        ,drvAccountSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvTransactionType = CASE WHEN EedBenStopDate IS NOT NULL THEN 'L' ELSE 'N' END   --XXXXXXXXX NEED TO CONFIRM WHAT EQUALS A NEW OR CHANGED RECORD
                    --CASE WHEN EdhChangeReason IS NOT NULL THEN 'N'
        --                           WHEN EecEmplStatus = 'T'  THEN 'L'
        --                        END
        ,drvTransactionEffDate = CASE WHEN EedBenStopDate IS NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, EedBenStartDate) --EedBenStartDate --XXX TJJ 6/4
                                      WHEN EedBenStopDate IS NOT NULL THEN EedBenStopDate --XXX TJJ 6/4
                                END
        ,drvEmployerOfferingID = CASE WHEN EedDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') THEN 'HSAEE' + CASE WHEN @ExportCode LIKE 'ACTIVE%'  THEN CONVERT(varchar(4),DATEPART(YEAR,GETDATE())+1) ELSE CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) END -- MW updated 12/1/2023 from CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))
                                      WHEN EedDedCode IN ('DCPLB','DPCAT') THEN 'DCAPEE' + CASE WHEN @ExportCode LIKE 'ACTIVE%'  THEN CONVERT(varchar(4),DATEPART(YEAR,GETDATE())+1) ELSE CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) END -- MW updated 12/1/2023 from CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))
                                      WHEN EedDedCode IN ('FLXLB','FLXAT') THEN 'FSAEE' + CASE WHEN @ExportCode LIKE 'ACTIVE%'  THEN CONVERT(varchar(4),DATEPART(YEAR,GETDATE())+1) ELSE CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) END -- MW updated 12/1/2023 from CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))    --MB added 2/12/2021 per feedback
                                      --WHEN PehEEID IS NOT NULL THEN 'HSAER' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))  --XXX TJJ ADDED HSAER 3/1/2021
                                     END    
        
                                    --CASE WHEN EedDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4') THEN 'HSAEE' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) 
                              --           WHEN EedDedCode IN ('DCPLB','DPCAT') THEN 'DCAPEE' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) 
                              --           WHEN EedDedCode IN ('FLXLB','FLXAT') THEN 'FSAEE' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))    --MB added 2/12/2021 per feedback
                                          --WHEN PehEEID IS NOT NULL THEN 'HSAER' + CONVERT(varchar(4),DATEPART(YEAR,GETDATE()))  --XXX TJJ ADDED HSAER 3/1/2021
                              --     END
        ,drvTotalPolicyAmount = (dbo.dsi_fnPadZero(EedEEGoalAmt*100,10,0)) --CASE WHEN EedDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4','FLXLB','CDPLB','FLXAT','DCPAT') THEN (dbo.dsi_fnPadZero(EedEEGoalAmt*100,10,0)) 
                                    --END
    INTO dbo.U_ECYCFSAENR_drvTbl  --select * from dbo.U_ECYCFSAENR_drvTbl order by drveeid
    FROM dbo.U_ECYCFSAENR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ECYCFSAENR'
        AND EedValidForExport = 'Y'
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.U_ECYCFSAENR_PDedHist WITH (NOLOCK)
    --    ON PdhEEID = xEEID
UNION 

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = 'HSAER'
        -- standard fields above and additional driver fields below
        ,drvAccountSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvTransactionType = CASE WHEN EedBenStopDate IS NOT NULL THEN 'L' ELSE 'N' END   --XXXXXXXXX NEED TO CONFIRM WHAT EQUALS A NEW OR CHANGED RECORD
                    --CASE WHEN EdhChangeReason IS NOT NULL THEN 'N'
        --                           WHEN EecEmplStatus = 'T'  THEN 'L'
        --                        END
        ,drvTransactionEffDate = CASE WHEN EedBenStopDate IS NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, EedBenStartDate)--EedBenStartDate --XXX TJJ 6/4
                                      WHEN EedBenStopDate IS NOT NULL THEN EedBenStopDate --XXX TJJ 6/4
                                END
        ,drvEmployerOfferingID = 'HSAER' + CASE WHEN @ExportCode LIKE 'ACTIVE%'  THEN CONVERT(varchar(4),DATEPART(YEAR,GETDATE())+1) ELSE CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) END -- CONVERT(varchar(4),DATEPART(YEAR,GETDATE())) 
        ,drvTotalPolicyAmount = ISNULL((dbo.dsi_fnPadZero(EeeYTDAmt*100,10,0)),'0000000000')
    --INTO dbo.U_ECYCFSAENR_drvTbl  --select * from dbo.U_ECYCFSAENR_drvTbl where drveeid = 'BP4KOC0280K0'
    FROM dbo.U_ECYCFSAENR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ECYCFSAENR'
        AND EedDedCode IN ('HSAI','HSACI','HSAA1','HSAA3','HSAF','HSACF','HSAA2','HSAA4')
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpEarn WITH (NOLOCK)
        ON EeeEEID = xEEID
        AND EeeCOID = xCOID
        AND EeeEarnCode IN ('HSAER','HSAE2')
    ;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'test_cn_*_' + CONVERT(VARCHAR(8),GETDATE(),112) + 'hhmiss.txt'
    --                              ELSE 'cn_*_' + CONVERT(VARCHAR(8),GETDATE(),112) + 'hhmiss.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECYCFSAENR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECYCFSAENR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCFSAENR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202105281'
       ,expStartPerControl     = '202105281'
       ,expLastEndPerControl   = '202106049'
       ,expEndPerControl       = '202106049'
WHERE expFormatCode = 'ECYCFSAENR' AND expExportCode = 'ONDEM_XOE';



    --------JOB NAME: Connect Your Care FSA HSA Enrollment Export (ECYCFSAENR) - Weekly, Wednesday, 5:30am ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Connect Your Care FSA HSA Enrollment Export (ECYCFSAENR) - Weekly, Wednesday, 5:30am ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (ECYCFSAENR)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-7,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''ECYCFSAENR''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (ECYCFSAENR)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''ECYCFSAENR'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly, Wednesday, 5:30am ET',
            @enabled=1, 
            @freq_type=8, 
            @freq_interval=8,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20201201,
            @active_end_date=99991231,
            @active_start_time=053000,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECYCFSAENR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECYCFSAENR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECYCFSAENR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECYCFSAENR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECYCFSAENR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCFSAENR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECYCFSAENR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCFSAENR', 'UseFileName', 'V', 'Y'


-- End ripout