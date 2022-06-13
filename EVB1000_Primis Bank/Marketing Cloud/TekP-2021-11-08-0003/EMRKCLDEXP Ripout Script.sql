/**********************************************************************************

EMRKCLDEXP: Marketing Cloud Changes Export

FormatCode:     EMRKCLDEXP
Project:        Marketing Cloud Changes Export
Client ID:      EVB1000
Date/time:      2022-06-02 10:02:37.610
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPEVB
Web Filename:   EVB1000_64DCB_EEHISTORY_EMRKCLDEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMRKCLDEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EMRKCLDEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMRKCLDEXP'


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
WHERE FormatCode = 'EMRKCLDEXP'
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
WHERE ExpFormatCode = 'EMRKCLDEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMRKCLDEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMRKCLDEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMRKCLDEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMRKCLDEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMRKCLDEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMRKCLDEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMRKCLDEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMRKCLDEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMRKCLDEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMRKCLDEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMRKCLDEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMRKCLDEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMRKCLDEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMRKCLDEXP];
GO
IF OBJECT_ID('U_EMRKCLDEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMRKCLDEXP_File];
GO
IF OBJECT_ID('U_EMRKCLDEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMRKCLDEXP_EEList];
GO
IF OBJECT_ID('U_EMRKCLDEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMRKCLDEXP_drvTbl];
GO
IF OBJECT_ID('U_EMRKCLDEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMRKCLDEXP_AuditFields];
GO
IF OBJECT_ID('U_EMRKCLDEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMRKCLDEXP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMRKCLDEXP','Marketing Cloud Changes Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EMRKCLDEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMRKCLDEXPZ0','50','H','01','1',NULL,'First_Name',NULL,NULL,'"First_Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMRKCLDEXPZ0','50','H','01','2',NULL,'Last_Name',NULL,NULL,'"Last_Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMRKCLDEXPZ0','50','H','01','3',NULL,'Preferred_First_Name',NULL,NULL,'"Preferred_First_Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMRKCLDEXPZ0','50','H','01','4',NULL,'EmailAddress',NULL,NULL,'"EmailAddress"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMRKCLDEXPZ0','50','H','01','5',NULL,'Date_of_Birth',NULL,NULL,'"Date_of_Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMRKCLDEXPZ0','50','H','01','6',NULL,'Seniority_Date',NULL,NULL,'"Seniority_Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMRKCLDEXPZ0','50','H','01','7',NULL,'Last_HireDate',NULL,NULL,'"Last_HireDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMRKCLDEXPZ0','50','H','01','8',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMRKCLDEXPZ0','50','H','01','9',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMRKCLDEXPZ0','50','H','01','10',NULL,'Cost_Center',NULL,NULL,'"Cost_Center"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMRKCLDEXPZ0','50','H','01','11',NULL,'Department_Number',NULL,NULL,'"Department_Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMRKCLDEXPZ0','50','H','01','12',NULL,'Department_Description',NULL,NULL,'"Department_Description"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMRKCLDEXPZ0','50','D','10','1',NULL,'First_Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMRKCLDEXPZ0','50','D','10','2',NULL,'Last_Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMRKCLDEXPZ0','50','D','10','3',NULL,'Preferred_First_Name',NULL,NULL,'"drvNameFirstPreffered"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMRKCLDEXPZ0','50','D','10','4',NULL,'EmailAddress',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMRKCLDEXPZ0','50','D','10','5',NULL,'Date_of_Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMRKCLDEXPZ0','50','D','10','6',NULL,'Seniority_Date',NULL,NULL,'"drvSeniorityDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMRKCLDEXPZ0','50','D','10','7',NULL,'Last_HireDate',NULL,NULL,'"drvLastHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMRKCLDEXPZ0','50','D','10','8',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMRKCLDEXPZ0','50','D','10','9',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMRKCLDEXPZ0','50','D','10','10',NULL,'Cost_Center',NULL,NULL,'"drvCostCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMRKCLDEXPZ0','50','D','10','11',NULL,'Department_Number',NULL,NULL,'"drvDepartmentNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMRKCLDEXPZ0','50','D','10','12',NULL,'Department_Description',NULL,NULL,'"drvDepartmentDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMRKCLDEXPZ0','50','D','10','13',NULL,'TerminatedDate',NULL,NULL,'"drvTerminatedDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMRKCLDEXP_20220602.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Marketing Cloud Export','202203189','EMPEXPORT','ONDEM_XOE',NULL,'EMRKCLDEXP',NULL,NULL,NULL,'202203189','Mar 18 2022 10:28AM','Mar 18 2022 10:28AM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',U3A0I,T91B2,U3A44',NULL,NULL,NULL,'Marketing Cloud - Daily 5am','202203189','EMPEXPORT','SCH_EMRKCL',NULL,'EMRKCLDEXP',NULL,NULL,NULL,'202206029','Mar 18 2022 10:28AM','Mar 18 2022 10:28AM','202206011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Marketing Cloud Export-Test','202204059','EMPEXPORT','TEST_XOE','Apr  5 2022 12:00AM','EMRKCLDEXP',NULL,NULL,NULL,'202204059','Apr  5 2022 12:00AM','Dec 30 1899 12:00AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'us3lKiEVB1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMRKCLDEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMRKCLDEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMRKCLDEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMRKCLDEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMRKCLDEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMRKCLDEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMRKCLDEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMRKCLDEXP','D10','dbo.U_EMRKCLDEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EMRKCLDEXP_Audit
-----------

IF OBJECT_ID('U_EMRKCLDEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EMRKCLDEXP_Audit] (
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
-- Create table U_EMRKCLDEXP_AuditFields
-----------

IF OBJECT_ID('U_EMRKCLDEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMRKCLDEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMRKCLDEXP_drvTbl
-----------

IF OBJECT_ID('U_EMRKCLDEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMRKCLDEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirstPreffered] varchar(100) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSeniorityDate] datetime NULL,
    [drvLastHireDate] datetime NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvCostCenter] varchar(10) NULL,
    [drvDepartmentNumber] char(10) NULL,
    [drvDepartmentDescription] varchar(25) NULL,
    [drvTerminatedDate] datetime NULL
);

-----------
-- Create table U_EMRKCLDEXP_EEList
-----------

IF OBJECT_ID('U_EMRKCLDEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMRKCLDEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMRKCLDEXP_File
-----------

IF OBJECT_ID('U_EMRKCLDEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMRKCLDEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMRKCLDEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Primis Bank

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 03/18/2022
Service Request Number: TekP-2021-11-08-0003

Purpose: Marketing Cloud Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMRKCLDEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMRKCLDEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMRKCLDEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMRKCLDEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMRKCLDEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMRKCLDEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMRKCLDEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMRKCLDEXP', 'SCH_EMRKCL';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMRKCLDEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMRKCLDEXP';

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
    DELETE FROM dbo.U_EMRKCLDEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMRKCLDEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMRKCLDEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMRKCLDEXP_AuditFields;
    CREATE TABLE dbo.U_EMRKCLDEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    -- Audit Fields
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepNameFirst');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepNameLast');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepNamePreferred');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepAddressEmail');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepDateOfBirth');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpComp', 'EecDateOfSeniority');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpComp', 'EedDateOfLastHire');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepAddressCity');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpPers', 'EepAddressSate');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpComp', 'EecOrgLvl1');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpComp', 'EecOrgLvl3');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpComp', 'EecEmplStatus');
    INSERT INTO dbo.U_EMRKCLDEXP_AuditFields VALUES ('EmpComp', 'EecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMRKCLDEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMRKCLDEXP_Audit;
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
        --,audDedCodeChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedDedCode' AND ISNULL(audNewValue , '') <> '' THEN 'Y' ELSE 'N' END
        --,audStatChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenStatus' AND ISNULL(audNewValue, '') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EMRKCLDEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMRKCLDEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMRKCLDEXP_Audit ON dbo.U_EMRKCLDEXP_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EMRKCLDEXP_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMRKCLDEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMRKCLDEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMRKCLDEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMRKCLDEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameFirstPreffered = EepNamePreferred
        ,drvEmailAddress = EepAddressEMail
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSeniorityDate = EecDateOfSeniority
        ,drvLastHireDate = EecDateOfLastHire
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvCostCenter = EecOrglvl3 --EedGLExpAcct
        ,drvDepartmentNumber = EjhOrgLvl1
        ,drvDepartmentDescription = OrgDesc,
        drvTerminatedDate = EecDateOfTermination
    INTO dbo.U_EMRKCLDEXP_drvTbl
    FROM dbo.U_EMRKCLDEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT EjhEEID, EjhCOID, EjhOrgLvl1, OrgDesc
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhOrgLvl1, OrgDesc, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM EmpHJob WITH (NOLOCK)
                    JOIN dbo.vw_int_OrgLevel WITH (NOLOCK)
                        ON EjhOrgLvl1 = OrgCode) AS Ejh
            WHERE RN = 1) AS Org
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN (
                SELECT EedEEID, EedCOID, MAX(EedGLExpAcct) EedGLExpAcct
                FROM dbo.EmpDed WITH(NOLOCK)
                GROUP BY EedEEID, EedCOID) Eed 
        ON EedEEID = xEEID 
        AND EedCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEMRKCLDEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMRKCLDEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMRKCLDEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202203189'
       ,expEndPerControl       = '202203189'
WHERE expFormatCode = 'EMRKCLDEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMRKCLDEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMRKCLDEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMRKCLDEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMRKCLDEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMRKCLDEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMRKCLDEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMRKCLDEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMRKCLDEXP', 'UseFileName', 'V', 'Y'


-- End ripout