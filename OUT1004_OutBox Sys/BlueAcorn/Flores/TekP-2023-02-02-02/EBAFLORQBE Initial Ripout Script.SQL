/**********************************************************************************

EBAFLORQBE: Flores COBRA QB Insured Export

FormatCode:     EBAFLORQBE
Project:        Flores COBRA QB Insured Export
Client ID:      OUT1004
Date/time:      2023-04-03 07:42:38.440
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPOUTB
Web Filename:   OUT1004_VA7H4_EEHISTORY_EBAFLORQBE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBAFLORQBE_SavePath') IS NOT NULL DROP TABLE dbo.U_EBAFLORQBE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBAFLORQBE'


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
WHERE FormatCode = 'EBAFLORQBE'
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
WHERE ExpFormatCode = 'EBAFLORQBE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBAFLORQBE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBAFLORQBE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBAFLORQBE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBAFLORQBE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBAFLORQBE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBAFLORQBE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBAFLORQBE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBAFLORQBE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBAFLORQBE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBAFLORQBE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBAFLORQBE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBAFLORQBE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBAFLORQBE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAFLORQBE];
GO
IF OBJECT_ID('U_EBAFLORQBE_File') IS NOT NULL DROP TABLE [dbo].[U_EBAFLORQBE_File];
GO
IF OBJECT_ID('U_EBAFLORQBE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBAFLORQBE_EEList];
GO
IF OBJECT_ID('U_EBAFLORQBE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAFLORQBE_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_EBAFLORQBE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBAFLORQBE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBAFLORQBE','Flores COBRA QB Insured Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EBAFLORQBEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAFLORQBEZ0','9','D','10','1',NULL,'Employee ID Number',NULL,NULL,'"drvEmpliyeeIDNumber"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAFLORQBEZ0','25','D','10','2',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAFLORQBEZ0','15','D','10','3',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAFLORQBEZ0','30','D','10','4',NULL,'Street Address Line 1',NULL,NULL,'"drvStreetAddressLine1"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAFLORQBEZ0','30','D','10','5',NULL,'Street Address Line 2',NULL,NULL,'"drvStreetAddressLine2"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAFLORQBEZ0','20','D','10','6',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAFLORQBEZ0','2','D','10','7',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAFLORQBEZ0','10','D','10','8',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAFLORQBEZ0','13','D','10','9',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAFLORQBEZ0','50','D','10','10',NULL,'Email address',NULL,NULL,'"drvEmailaddress"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAFLORQBEZ0','10','D','10','11',NULL,'Birth date',NULL,NULL,'"drvBirthdate"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAFLORQBEZ0','2','D','10','12',NULL,'State of employment',NULL,NULL,'"drvStateofEmployment"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAFLORQBEZ0','2','D','10','13',NULL,'Type of Event',NULL,NULL,'"drvTypeofEvent"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAFLORQBEZ0','10','D','10','14',NULL,'Date of Event',NULL,NULL,'"drvDateofEvent"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAFLORQBEZ0','10','D','10','15',NULL,'Date Premiums Paid Through',NULL,NULL,'"drvDatePremiumPaidThrough"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAFLORQBEZ0','10','D','10','16',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAFLORQBEZ0','1','D','10','17',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBAFLORQBE_20230403.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Flores COBRA QB Insured Export','202303159','EMPEXPORT','ONDEM_XOE',NULL,'EBAFLORQBE',NULL,NULL,NULL,'202303159','Mar 15 2023 11:07AM','Mar 15 2023 11:07AM','202303151',NULL,'','','202303151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores COBRA QB Insured -Sched','202303159','EMPEXPORT','SCH_EBAFLO',NULL,'EBAFLORQBE',NULL,NULL,NULL,'202303159','Mar 15 2023 11:07AM','Mar 15 2023 11:07AM','202303151',NULL,'','','202303151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',2IIJU',NULL,NULL,NULL,'Flores COBRA QB Insured -Test','202303319','EMPEXPORT','TEST_XOE','Mar 31 2023  2:35PM','EBAFLORQBE',NULL,NULL,NULL,'202303319','Mar 31 2023 12:00AM','Dec 30 1899 12:00AM','202303151','8','','','202303151',dbo.fn_GetTimedKey(),NULL,'us3kEpOUT1004',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAFLORQBE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAFLORQBE','D10','dbo.U_EBAFLORQBE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBAFLORQBE
-----------

IF OBJECT_ID('U_dsi_BDM_EBAFLORQBE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBAFLORQBE] (
    [BdmRecType] varchar(3) NOT NULL,
    [BdmCOID] char(5) NULL,
    [BdmEEID] char(12) NOT NULL,
    [BdmDepRecID] char(12) NULL,
    [BdmSystemID] char(12) NULL,
    [BdmRunID] varchar(32) NULL,
    [BdmDedRowStatus] varchar(256) NULL,
    [BdmRelationship] char(3) NULL,
    [BdmDateOfBirth] datetime NULL,
    [BdmDedCode] char(5) NULL,
    [BdmDedType] varchar(32) NULL,
    [BdmBenOption] char(6) NULL,
    [BdmBenStatus] char(1) NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStatusDate] datetime NULL,
    [BdmBenOptionDate] datetime NULL,
    [BdmChangeReason] char(6) NULL,
    [BdmStartDate] datetime NULL,
    [BdmStopDate] datetime NULL,
    [BdmIsCobraCovered] char(1) NULL,
    [BdmCobraReason] char(6) NULL,
    [BdmDateOfCOBRAEvent] datetime NULL,
    [BdmIsPQB] char(1) NULL,
    [BdmIsChildOldest] char(1) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [BdmUSGField2] varchar(256) NULL,
    [BdmUSGDate1] datetime NULL,
    [BdmUSGDate2] datetime NULL,
    [BdmTVStartDate] datetime NULL,
    [BdmSessionID] varchar(32) NULL,
    [BdmEEAmt] money NULL,
    [BdmEECalcRateOrPct] decimal NULL,
    [BdmEEGoalAmt] money NULL,
    [BdmEEMemberOrCaseNo] char(40) NULL,
    [BdmERAmt] money NULL,
    [BdmNumSpouses] int NULL,
    [BdmNumChildren] int NULL,
    [BdmNumDomPartners] int NULL,
    [BdmNumDPChildren] int NULL
);

-----------
-- Create table U_EBAFLORQBE_drvTbl
-----------

IF OBJECT_ID('U_EBAFLORQBE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAFLORQBE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpliyeeIDNumber] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvStreetAddressLine1] varchar(255) NULL,
    [drvStreetAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailaddress] varchar(50) NULL,
    [drvBirthdate] varchar(30) NULL,
    [drvStateofEmployment] varchar(1) NOT NULL,
    [drvTypeofEvent] varchar(2) NULL,
    [drvDateofEvent] varchar(30) NULL,
    [drvDatePremiumPaidThrough] varchar(1) NOT NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvGender] char(1) NULL
);

-----------
-- Create table U_EBAFLORQBE_EEList
-----------

IF OBJECT_ID('U_EBAFLORQBE_EEList') IS NULL
CREATE TABLE [dbo].[U_EBAFLORQBE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBAFLORQBE_File
-----------

IF OBJECT_ID('U_EBAFLORQBE_File') IS NULL
CREATE TABLE [dbo].[U_EBAFLORQBE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAFLORQBE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Blue Acorn

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 03/15/2023
Service Request Number: TekP-2023-02-02-02

Purpose: Flores COBRA QB Insured Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBAFLORQBE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBAFLORQBE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBAFLORQBE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBAFLORQBE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBAFLORQBE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAFLORQBE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAFLORQBE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAFLORQBE', 'SCH_EBAFLO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBAFLORQBE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBAFLORQBE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBAFLORQBE';

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
    DELETE FROM dbo.U_EBAFLORQBE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBAFLORQBE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4,203'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

     -- 203 death insert employee
    INSERT INTO [dbo].[U_dsi_BDM_EBAFLORQBE]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmBenStatus]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,DbnBenStatus
    ,'QB'
    ,'Data inserted for 203 term reason'
    ,DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'203'
    ,'203'
    ,DbnBenStartDate
    ,DbnBenStopDate
    ,    CASE WHEN DbnRelationship IN ('SPS','DP') THEN 'Y' 
        WHEN DbnRelationship NOT IN ('SPS','DP') AND (SELECT COUNT(*) FROM dbo.U_dsi_BDM_DepDeductions SPS WITH (NOLOCK) WHERE SPS.DbnEEID = DbnEEID AND SPS.DbnFormatCode = 'EBAFLORQBE' AND SPS.DbnRelationship IN ('SPS','DP')) = 0 THEN 'Y' 
        ELSE 'N' 
        END
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH(NOLOCK)
    ON DbnEEID = EecEEID
    AND DbnCOID = EecCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EecEEID = EepEEID
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = @FormatCode
    AND EecTermReason = '203'
   

    INSERT INTO [dbo].[U_dsi_BDM_EBAFLORQBE]
    ([BdmRecType]
    ,[BdmCOID]
    ,[BdmEEID]
    ,[BdmDepRecID]
    ,[BdmSystemID]
    ,[BdmRunID]
    ,[BdmDedRowStatus]
    ,[BdmRelationship]
    ,[BdmDateOfBirth]
    ,[BdmDedCode]
    ,[BdmBenOption]
    ,[BdmBenStatus]
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmDateOFCobraEvent]
    ,[BdmChangeReason]
    ,[BdmCobraReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    )
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 204 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,DbnDedCode --EdhDedCode
    ,DbnBenOption
    ,DbnBenStatus
    ,dbnBenStartDate
    ,dbnBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'204'
    ,'204'
    ,EdhStartDate
    ,EdhStopDate
    ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions
    ON dbneeid = edheeid
    AND dbnformatcode = @FormatCode
    WHERE edhChangeReason in ('204')
    AND DbnBenStatus <> 'A'
    --AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
    --AND dbnValidForExport = 'N'
    --AND dbnRelationship <> 'Z'



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBAFLORQBE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAFLORQBE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAFLORQBE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpliyeeIDNumber = EepSSN
        ,drvLastName = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConNameLast ELSE EepNameLast END
        ,drvFirstName = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConNameFirst ELSE EepNameFirst END
        ,drvStreetAddressLine1 = EepAddressLine1
        ,drvStreetAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmailaddress = EepAddressEMail
        ,drvBirthdate = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then CONVERT(VARCHAR, ConDateOfBirth, 101) ELSE CONVERT(VARCHAR, EepDateOfBirth, 101) END
        ,drvStateofEmployment = ''
        ,drvTypeofEvent = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4') THEN '4'
                                WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '3'
                                WHEN BdmChangeReason = '205' THEN '6'
                                WHEN BdmChangeReason IN ('201', 'LEVNT3') THEN '5'
                                WHEN EecEmplStatus = 'T' AND EecTermType = 'V' THEN '1'
                                WHEN BdmChangeReason IN ('202', '203') THEN '2'
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' AND EecTermType = 'I' THEN '10' END
        ,drvDateofEvent = (SELECT MAX(ISNULL(CONVERT(VARCHAR, BdmBenStopDate, 101), ''))
                            FROM dbo.U_dsi_BDM_EBAFLORQBE WITH (NOLOCK)
                            WHERE BdmEEID = xEEID
                            AND BdmCOID = xCOID) 
        ,drvDatePremiumPaidThrough = ''
        ,drvLocation = ''
        ,drvGender = CASE WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') OR EecTermReason = '203' then ConGender else EepGender END
    INTO dbo.U_EBAFLORQBE_drvTbl
    FROM dbo.U_EBAFLORQBE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAFLORQBE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecId
    WHERE BdmRunID = 'QB'
    AND BdmIsPQB = 'Y'
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
ALTER VIEW dbo.dsi_vwEBAFLORQBE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAFLORQBE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBAFLORQBE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303081'
       ,expStartPerControl     = '202303081'
       ,expLastEndPerControl   = '202303159'
       ,expEndPerControl       = '202303159'
WHERE expFormatCode = 'EBAFLORQBE';


UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303151'
       ,expStartPerControl     = '202303151'
       ,expLastEndPerControl   = '202303319'
       ,expEndPerControl       = '202303319'
WHERE expFormatCode = 'EBAFLORQBE' and expexportcode = 'TEST_XOE ;
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBAFLORQBE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBAFLORQBE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBAFLORQBE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBAFLORQBE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBAFLORQBE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAFLORQBE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBAFLORQBE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAFLORQBE', 'UseFileName', 'V', 'Y'


-- End ripout