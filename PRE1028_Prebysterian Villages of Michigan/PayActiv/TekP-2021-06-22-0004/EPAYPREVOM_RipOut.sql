/**********************************************************************************

EPAYPREVOM: PayActiv Demographic Export

FormatCode:     EPAYPREVOM
Project:        PayActiv Demographic Export
Client ID:      PRE1028
Date/time:      2022-02-21 20:28:45.277
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP6DB01
Database:       ULTIPRO_WPPVM
Web Filename:   PRE1028_IGY57_EEHISTORY_EPAYPREVOM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPAYPREVOM_SavePath') IS NOT NULL DROP TABLE dbo.U_EPAYPREVOM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPAYPREVOM'


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
WHERE FormatCode = 'EPAYPREVOM'
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
WHERE ExpFormatCode = 'EPAYPREVOM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPAYPREVOM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPAYPREVOM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPAYPREVOM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPAYPREVOM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPAYPREVOM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPAYPREVOM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPAYPREVOM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPAYPREVOM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPAYPREVOM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPAYPREVOM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPAYPREVOM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPAYPREVOM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPAYPREVOM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYPREVOM];
GO
IF OBJECT_ID('U_EPAYPREVOM_File') IS NOT NULL DROP TABLE [dbo].[U_EPAYPREVOM_File];
GO
IF OBJECT_ID('U_EPAYPREVOM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPAYPREVOM_EEList];
GO
IF OBJECT_ID('U_EPAYPREVOM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPAYPREVOM_drvTbl];
GO
IF OBJECT_ID('U_EPAYPREVOM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPAYPREVOM_AuditFields];
GO
IF OBJECT_ID('U_EPAYPREVOM_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPAYPREVOM_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPAYPREVOM','PayActiv Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EPAYPREVOMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPAYPREVOMZ0','50','H','01','1',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPAYPREVOMZ0','50','H','01','2',NULL,'Legal First Name',NULL,NULL,'"Legal First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPAYPREVOMZ0','50','H','01','3',NULL,'Legal Last Name',NULL,NULL,'"Legal Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPAYPREVOMZ0','50','H','01','4',NULL,'Employment Type (Hourly/Salaried)',NULL,NULL,'"Employment Type (Hourly/Salaried)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPAYPREVOMZ0','50','H','01','5',NULL,'Income Rate (Hourly wage)',NULL,NULL,'"Income Rate (Hourly wage)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPAYPREVOMZ0','50','H','01','6',NULL,'Phone Number',NULL,NULL,'"Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPAYPREVOMZ0','50','H','01','7',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPAYPREVOMZ0','50','H','01','8',NULL,'Location ID (If applicable)',NULL,NULL,'"Location ID (If applicable)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPAYPREVOMZ0','50','H','01','9',NULL,'Pay Group',NULL,NULL,'"Pay Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPAYPREVOMZ0','50','H','01','10',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPAYPREVOMZ0','50','H','01','11',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPAYPREVOMZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPAYPREVOMZ0','50','D','10','2',NULL,'Legal First Name',NULL,NULL,'"drvFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPAYPREVOMZ0','50','D','10','3',NULL,'Legal Last Name',NULL,NULL,'"drvLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPAYPREVOMZ0','50','D','10','4',NULL,'Employment Type (Hourly/Salaried)',NULL,NULL,'"drvEmpType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPAYPREVOMZ0','50','D','10','5',NULL,'Income Rate (Hourly wage)',NULL,NULL,'"drvIncomeRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPAYPREVOMZ0','50','D','10','6',NULL,'Phone Number',NULL,NULL,'"drvPhNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPAYPREVOMZ0','50','D','10','7',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPAYPREVOMZ0','50','D','10','8',NULL,'Location ID (If applicable)',NULL,NULL,'"drvLocId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPAYPREVOMZ0','50','D','10','9',NULL,'Pay Group',NULL,NULL,'"drvPayGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPAYPREVOMZ0','50','D','10','10',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPAYPREVOMZ0','50','D','10','11',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPAYPREVOM_20220221.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PayActiv Demographic Export','202112169','EMPEXPORT','ONDEM_XOE',NULL,'EPAYPREVOM',NULL,NULL,NULL,'202112169','Dec 16 2021 12:32PM','Dec 16 2021 12:32PM','202112161',NULL,'','','202112161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PayActiv Demographic Exp-Sched','202112169','EMPEXPORT','SCH_EPAYPR',NULL,'EPAYPREVOM',NULL,NULL,NULL,'202112169','Dec 16 2021 12:32PM','Dec 16 2021 12:32PM','202112161',NULL,'','','202112161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'PayActiv Demographic Exp-Test','202201191','EMPEXPORT','TEST_XOE','Jan 19 2022  5:43PM','EPAYPREVOM',NULL,NULL,NULL,'202201191','Jan 19 2022 12:00AM','Dec 30 1899 12:00AM','202201051','268','eecLocation','2','202201051',dbo.fn_GetTimedKey(),NULL,'us3cPePRE1028',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYPREVOM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYPREVOM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYPREVOM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYPREVOM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPAYPREVOM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAYPREVOM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPAYPREVOM','D10','dbo.U_EPAYPREVOM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPAYPREVOM_Audit
-----------

IF OBJECT_ID('U_EPAYPREVOM_Audit') IS NULL
CREATE TABLE [dbo].[U_EPAYPREVOM_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EPAYPREVOM_AuditFields
-----------

IF OBJECT_ID('U_EPAYPREVOM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPAYPREVOM_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EPAYPREVOM_drvTbl
-----------

IF OBJECT_ID('U_EPAYPREVOM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPAYPREVOM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpId] varchar(9) NULL,
    [drvFName] varchar(100) NULL,
    [drvLName] varchar(100) NULL,
    [drvEmpType] varchar(6) NOT NULL,
    [drvIncomeRate] varchar(30) NULL,
    [drvPhNum] varchar(13) NULL,
    [drvEmail] varchar(50) NULL,
    [drvLocId] varchar(25) NULL,
    [drvPayGroup] char(6) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvDOB] varchar(30) NULL
);

-----------
-- Create table U_EPAYPREVOM_EEList
-----------

IF OBJECT_ID('U_EPAYPREVOM_EEList') IS NULL
CREATE TABLE [dbo].[U_EPAYPREVOM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPAYPREVOM_File
-----------

IF OBJECT_ID('U_EPAYPREVOM_File') IS NULL
CREATE TABLE [dbo].[U_EPAYPREVOM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPAYPREVOM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Presbyterian Villages of Michigan 

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 12/16/2021
Service Request Number: TekP-2021-06-22-0004

Purpose: PayActiv Demographic Export

Revision History
----------------
01/06/2022 by AP:
    - Updated employee id field logic.
    - Cleaned up phone number logic.

02/21/2022 by AP:
	- Added Mobile Phone to phone number field.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPAYPREVOM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPAYPREVOM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPAYPREVOM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPAYPREVOM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPAYPREVOM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYPREVOM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYPREVOM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPAYPREVOM', 'SCH_EPAYPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPAYPREVOM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPAYPREVOM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPAYPREVOM';

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
    DELETE FROM dbo.U_EPAYPREVOM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPAYPREVOM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- --==========================================
    -- -- Create Deduction List
    -- --==========================================
    -- DECLARE @DedList VARCHAR(MAX)
    -- SET @DedList = 'DED1,DED2';

    -- IF OBJECT_ID('U_EPAYPREVOM_DedList','U') IS NOT NULL
    --     DROP TABLE dbo.U_EPAYPREVOM_DedList;
    -- SELECT DISTINCT
    --      DedCode = DedDedCode
    --     ,DedType = DedDedType
    -- INTO dbo.U_EPAYPREVOM_DedList
    -- FROM dbo.fn_ListToTable(@DedList)
    -- JOIN dbo.DedCode WITH (NOLOCK)
    --     ON DedDedCode = Item;


    -- --==========================================
    -- -- BDM Section
    -- --==========================================
    -- DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- -- Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- -- Non-Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- -- Run BDM Module
    -- EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    -- IF OBJECT_ID('U_EPAYPREVOM_PDedHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EPAYPREVOM_PDedHist;
    -- SELECT DISTINCT
    --      PdhEEID
    --     -- Current Payroll Amounts
    --     ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --     -- YTD Payroll Amounts
    --     ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --     ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --     -- Categorize Payroll Amounts
    --     ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --     ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    -- INTO dbo.U_EPAYPREVOM_PDedHist
    -- FROM dbo.PDedHist WITH (NOLOCK)
    -- JOIN dbo.U_EPAYPREVOM_DedList WITH (NOLOCK)
    --     ON DedCode = PdhDedCode
    -- WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PdhPerControl <= @EndPerControl
    -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    -- GROUP BY PdhEEID
    -- HAVING (SUM(PdhEECurAmt) <> 0.00
    --     OR SUM(PdhERCurAmt) <> 0.00
    -- );


    -- -----------------------------
    -- -- Working Table - PEarHist
    -- -----------------------------
    -- IF OBJECT_ID('U_EPAYPREVOM_PEarHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EPAYPREVOM_PEarHist;
    -- SELECT DISTINCT
    --      PehEEID
    --     ,PrgPayDate             = MAX(PrgPayDate)
    --     -- Current Payroll Amount/Hours
    --     ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --     ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --     -- YTD Payroll Amount/Hours
    --     ,PehCurAmtYTD           = SUM(PehCurAmt)
    --     ,PehCurHrsYTD           = SUM(PehCurHrs)
    --     -- Current Include Deferred Comp Amount/Hours
    --     ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --     ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --     -- YTD Include Deferred Comp Amount/Hours
    --     ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --     ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    -- INTO dbo.U_EPAYPREVOM_PEarHist
    -- FROM dbo.vw_int_PayReg WITH (NOLOCK)
    -- JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --     ON PehGenNumber = PrgGenNumber
    -- WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PehPerControl <= @EndPerControl
    -- GROUP BY PehEEID
    -- HAVING SUM(PehCurAmt) <> 0.00;

    --Code for "terminations sent one time only". One time means sent one time during the per control range.

--Audit Table
    IF OBJECT_ID('U_EPAYPREVOM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYPREVOM_AuditFields;
    CREATE TABLE dbo.U_EPAYPREVOM_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EPAYPREVOM_AuditFields VALUES ('Empcomp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EPAYPREVOM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYPREVOM_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EPAYPREVOM_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EPAYPREVOM_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EPAYPREVOM_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPAYPREVOM_Audit ON dbo.U_EPAYPREVOM_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPAYPREVOM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPAYPREVOM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPAYPREVOM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpId = RIGHT('000000000' + LTRIM(RTRIM(EecEmpNo)), 9)
        ,drvFName = EepNameFirst
        ,drvLName = EepNameLast
        ,drvEmpType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salary' ELSE 'Hourly' END
        ,drvIncomeRate = CAST(CASE WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary ELSE CAST(EecHourlyPayRate AS DECIMAL(10,2)) END AS VARCHAR)
        ,drvPhNum = CASE WHEN M.EfoPhoneNumber IS NOT NULL THEN 
						'(' + SUBSTRING(M.EfoPhoneNumber, 1, 3) + ')' + 
                    SUBSTRING(M.EfoPhoneNumber, 4, 3) + '-' + 
                    SUBSTRING(M.EfoPhoneNumber, 7, 4)
					
					ELSE '(' + SUBSTRING(EepPhoneHomeNumber, 1, 3) + ')' + 
                    SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                    SUBSTRING(EepPhoneHomeNumber, 7, 4)
				END
        ,drvEmail = EepAddressEMail
        ,drvLocId = LocDesc
        ,drvPayGroup = EecPayGroup
        ,drvWorkState = LocAddressState
        ,drvDOB = CONVERT(VARCHAR, EepDateOfBirth, 101)
    INTO dbo.U_EPAYPREVOM_drvTbl
    FROM dbo.U_EPAYPREVOM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        AND EXISTS(select 1 from dbo.U_EPAYPREVOM_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	OUTER APPLY (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL' AND EfoEEID = xEEID) M
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPAYPREVOM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPAYPREVOM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPAYPREVOM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112091'
       ,expStartPerControl     = '202112091'
       ,expLastEndPerControl   = '202112169'
       ,expEndPerControl       = '202112169'
WHERE expFormatCode = 'EPAYPREVOM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPAYPREVOM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPAYPREVOM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPAYPREVOM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPAYPREVOM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPAYPREVOM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPAYPREVOM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPAYPREVOM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPAYPREVOM', 'UseFileName', 'V', 'Y'


-- End ripout