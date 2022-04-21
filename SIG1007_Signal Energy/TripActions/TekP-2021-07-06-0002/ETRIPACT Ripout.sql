/**********************************************************************************

ETRIPACT: TripActions HRIS Export

FormatCode:     ETRIPACT
Project:        TripActions HRIS Export
Client ID:      USG1000
Date/time:      2022-04-20 12:09:27.500
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_ETRIPACT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETRIPACT_SavePath') IS NOT NULL DROP TABLE dbo.U_ETRIPACT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETRIPACT'


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
WHERE FormatCode = 'ETRIPACT'
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
WHERE ExpFormatCode = 'ETRIPACT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETRIPACT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETRIPACT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETRIPACT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETRIPACT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETRIPACT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETRIPACT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETRIPACT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETRIPACT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETRIPACT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETRIPACT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETRIPACT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRIPACT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRIPACT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRIPACT];
GO
IF OBJECT_ID('U_ETRIPACT_File') IS NOT NULL DROP TABLE [dbo].[U_ETRIPACT_File];
GO
IF OBJECT_ID('U_ETRIPACT_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRIPACT_EEList];
GO
IF OBJECT_ID('U_ETRIPACT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRIPACT_drvTbl];
GO
IF OBJECT_ID('U_ETRIPACT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRIPACT_AuditFields];
GO
IF OBJECT_ID('U_ETRIPACT_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRIPACT_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRIPACT','TripActions HRIS Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ETRIPACT00Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETRIPACT00Z0','50','H','01','1',NULL,'email',NULL,NULL,'"email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETRIPACT00Z0','50','H','01','2',NULL,'firstName',NULL,NULL,'"firstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETRIPACT00Z0','50','H','01','3',NULL,'lastName',NULL,NULL,'"lastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETRIPACT00Z0','50','H','01','4',NULL,'enabled',NULL,NULL,'"enabled"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETRIPACT00Z0','50','H','01','5',NULL,'employeeId',NULL,NULL,'"employeeId"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETRIPACT00Z0','50','H','01','6',NULL,'title',NULL,NULL,'"title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETRIPACT00Z0','50','H','01','7',NULL,'department',NULL,NULL,'"department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETRIPACT00Z0','50','H','01','8',NULL,'costCenter',NULL,NULL,'"costCenter"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETRIPACT00Z0','50','H','01','9',NULL,'region',NULL,NULL,'"region"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETRIPACT00Z0','50','H','01','10',NULL,'subsidiary',NULL,NULL,'"subsidiary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETRIPACT00Z0','50','H','01','11',NULL,'managerEmail',NULL,NULL,'"managerEmail"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETRIPACT00Z0','50','H','01','12',NULL,'approverEmail',NULL,NULL,'"approverEmail"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETRIPACT00Z0','50','H','01','13',NULL,'companyOffice',NULL,NULL,'"companyOffice"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETRIPACT00Z0','50','D','10','1',NULL,'email',NULL,NULL,'"drvAddressEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETRIPACT00Z0','50','D','10','2',NULL,'firstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETRIPACT00Z0','50','D','10','3',NULL,'lastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETRIPACT00Z0','50','D','10','4',NULL,'enabled',NULL,NULL,'"drvEnabled"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETRIPACT00Z0','50','D','10','5',NULL,'employeeId',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETRIPACT00Z0','50','D','10','6',NULL,'title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETRIPACT00Z0','50','D','10','7',NULL,'department',NULL,NULL,'"drvOrgLvl3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETRIPACT00Z0','50','D','10','8',NULL,'costCenter',NULL,NULL,'"drvProject"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETRIPACT00Z0','50','D','10','9',NULL,'region',NULL,NULL,'"drvOrgLvl2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETRIPACT00Z0','50','D','10','10',NULL,'subsidiary',NULL,NULL,'"drvCompanyName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETRIPACT00Z0','50','D','10','11',NULL,'managerEmail',NULL,NULL,'"drvManagerEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETRIPACT00Z0','50','D','10','12',NULL,'approverEmail',NULL,NULL,'"drvApproverEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETRIPACT00Z0','50','D','10','13',NULL,'companyOffice',NULL,NULL,'"drvOrgLvl1"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETRIPACT_20220420.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TripActions HRIS Export','202108269','EMPEXPORT','ONDEM_XOE','Aug 26 2021 12:00AM','ETRIPACT',NULL,NULL,NULL,'202108269','Aug 26 2021 12:00AM','Dec 30 1899 12:00AM','202108261',NULL,'','','202108261',dbo.fn_GetTimedKey(),NULL,'us3kMcSIG1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TripActions HRIS Export-Sched','202108269','EMPEXPORT','SCH_ETRIPA','Aug 26 2021 12:00AM','ETRIPACT',NULL,NULL,NULL,'202108269','Aug 26 2021 12:00AM','Dec 30 1899 12:00AM','202108261',NULL,'','','202108261',dbo.fn_GetTimedKey(),NULL,'us3kMcSIG1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'TripActions HRIS Export-Test','202104269','EMPEXPORT','TEST_XOE','Aug 26 2021 11:28AM','ETRIPACT',NULL,NULL,NULL,'202104269','Apr 26 2021 12:00AM','Dec 30 1899 12:00AM','202104011','439','','','202104011',dbo.fn_GetTimedKey(),NULL,'us3kMcSIG1007',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIPACT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIPACT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIPACT','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIPACT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIPACT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRIPACT','D10','dbo.U_ETRIPACT_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_ETRIPACT_Audit
-----------

IF OBJECT_ID('U_ETRIPACT_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRIPACT_Audit] (
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
-- Create table U_ETRIPACT_AuditFields
-----------

IF OBJECT_ID('U_ETRIPACT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRIPACT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ETRIPACT_drvTbl
-----------

IF OBJECT_ID('U_ETRIPACT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRIPACT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvEnabled] varchar(5) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvTitle] varchar(8000) NULL,
    [drvOrgLvl3] varchar(8000) NULL,
    [drvProject] varchar(8000) NULL,
    [drvOrgLvl2] varchar(8000) NULL,
    [drvCompanyName] varchar(8000) NULL,
    [drvManagerEmail] varchar(50) NULL,
    [drvApproverEmail] varchar(50) NULL,
    [drvOrgLvl1] varchar(8000) NULL
);

-----------
-- Create table U_ETRIPACT_EEList
-----------

IF OBJECT_ID('U_ETRIPACT_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRIPACT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETRIPACT_File
-----------

IF OBJECT_ID('U_ETRIPACT_File') IS NULL
CREATE TABLE [dbo].[U_ETRIPACT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRIPACT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Signal Energy

Created By: Keary McCutchen
Business Analyst: Lea King
Create Date: 08/26/2021
Service Request Number: SR-2021-00317581

Purpose: TripActions HRIS Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRIPACT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRIPACT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRIPACT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRIPACT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRIPACT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIPACT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIPACT', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIPACT', 'SCH_ETRIPA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRIPACT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRIPACT';

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
    DELETE FROM dbo.U_ETRIPACT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRIPACT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ETRIPACT_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIPACT_AuditFields;
    CREATE TABLE dbo.U_ETRIPACT_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ETRIPACT_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETRIPACT_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIPACT_Audit;
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
    INTO dbo.U_ETRIPACT_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ETRIPACT_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(day,-30,@StartDate) AND @EndDate
    AND audNewValue = 'T';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETRIPACT_Audit ON dbo.U_ETRIPACT_Audit (audEEID,audCOID);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETRIPACT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRIPACT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIPACT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvAddressEmail = Emp.EepAddressEMail
        ,drvNameFirst = Emp.EepNameFirst
        ,drvNameLast = Emp.EepNameLast
        ,drvEnabled = CASE WHEN EecEmplStatus = 'T' THEN 'False' ELSE 'True' END
        ,drvEmpNo = EecEmpNo
        ,drvTitle = REPLACE(JbcDesc,',',' ')
        ,drvOrgLvl3 = REPLACE(Org3.OrgDesc,',',' ')
        ,drvProject = REPLACE(EecProject,',',' ')
        ,drvOrgLvl2 = REPLACE(Org2.OrgDesc,',',' ')
        ,drvCompanyName = REPLACE(CmpCompanyName,',',' ')
        ,drvManagerEmail = Sup.EepAddressEMail
        ,drvApproverEmail = Sup.EepAddressEMail
        ,drvOrgLvl1 = REPLACE(Org1.OrgDesc,',',' ')
    INTO dbo.U_ETRIPACT_drvTbl
    FROM dbo.U_ETRIPACT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers Emp WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH  (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.OrgLevel AS Org1 WITH (NOLOCK) 
        ON Org1.OrgCode = EecOrgLvl1
        AND Org1.OrgLvl = 1
    JOIN dbo.OrgLevel AS Org2 WITH (NOLOCK) 
        ON Org2.OrgCode = EecOrgLvl2
        AND Org2.OrgLvl = 2
    JOIN dbo.OrgLevel AS Org3 WITH (NOLOCK) 
        ON Org3.OrgCode = EecOrgLvl3
        AND Org3.OrgLvl = 3
    LEFT 
    JOIN dbo.EmpPers Sup WITH (NOLOCK) -- supervisor  
        ON Sup.EepEEID = EecSupervisorID  
    LEFT
    JOIN dbo.U_ETRIPACT_Audit WITH (NOLOCK)
        ON audEEID = xEEID
    WHERE
        (EecEmplStatus IN ('A','L')
        OR (EecEmplStatus = 'T' AND audDateTime IS NOT NULL ))
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
ALTER VIEW dbo.dsi_vwETRIPACT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRIPACT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRIPACT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108191'
       ,expStartPerControl     = '202108191'
       ,expLastEndPerControl   = '202108269'
       ,expEndPerControl       = '202108269'
WHERE expFormatCode = 'ETRIPACT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRIPACT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRIPACT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETRIPACT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETRIPACT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETRIPACT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETRIPACT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETRIPACT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETRIPACT', 'UseFileName', 'V', 'Y'


-- End ripout