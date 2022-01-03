/**********************************************************************************

ESWKDEMEXP: Shareworks Demo Export

FormatCode:     ESWKDEMEXP
Project:        Shareworks Demo Export
Client ID:      REM1008
Date/time:      2021-12-29 14:47:05.907
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB04
Database:       ULTIPRO_WPREMY
Web Filename:   REM1008_SZRG6_EEHISTORY_ESWKDEMEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESWKDEMEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ESWKDEMEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESWKDEMEXP'


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
WHERE FormatCode = 'ESWKDEMEXP'
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
WHERE ExpFormatCode = 'ESWKDEMEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESWKDEMEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESWKDEMEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESWKDEMEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESWKDEMEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESWKDEMEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESWKDEMEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESWKDEMEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESWKDEMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESWKDEMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESWKDEMEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESWKDEMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESWKDEMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESWKDEMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESWKDEMEXP];
GO
IF OBJECT_ID('U_ESWKDEMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_File];
GO
IF OBJECT_ID('U_ESWKDEMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_EEList];
GO
IF OBJECT_ID('U_ESWKDEMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_drvTbl];
GO
IF OBJECT_ID('U_ESWKDEMEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_AuditFields];
GO
IF OBJECT_ID('U_ESWKDEMEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESWKDEMEXP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESWKDEMEXP','Shareworks Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ESWKDEMEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESWKDEMEXPZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESWKDEMEXPZ0','50','D','10','2',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESWKDEMEXPZ0','50','D','10','3',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESWKDEMEXPZ0','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESWKDEMEXPZ0','50','D','10','5',NULL,'Is A Corporate Entity?',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESWKDEMEXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESWKDEMEXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL,'"drvInternationalSIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESWKDEMEXPZ0','50','D','10','6',NULL,'SSN',NULL,NULL,'"drvCandaSIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESWKDEMEXPZ0','50','D','10','9',NULL,'Date of Hire',NULL,NULL,'"drvDateOfHire"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESWKDEMEXPZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL,'"DrvDateOfBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESWKDEMEXPZ0','50','D','10','11',NULL,'Company Email',NULL,NULL,'"drvCompanyEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESWKDEMEXPZ0','250','D','10','12',NULL,'Home Address || Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESWKDEMEXPZ0','250','D','10','13',NULL,'Home Address || Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESWKDEMEXPZ0','50','D','10','14',NULL,'Home Address || City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESWKDEMEXPZ0','50','D','10','15',NULL,'Home Address || State/Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESWKDEMEXPZ0','50','D','10','16',NULL,'Home Address || Country',NULL,NULL,'"drvAddressCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESWKDEMEXPZ0','50','D','10','17',NULL,'Home Address || ZIP/Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESWKDEMEXPZ0','50','D','10','18',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESWKDEMEXPZ0','50','D','10','19',NULL,'Entity/Rep Office',NULL,NULL,'"drvEntityRepOffice"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESWKDEMEXPZ0','50','D','10','20',NULL,'Stock Options and Awards Employee Status',NULL,NULL,'"drvStockOptionStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESWKDEMEXPZ0','50','D','10','21',NULL,'Stock Options and Awards Employee Status (Effectiv',NULL,NULL,'"drvStockOptionDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESWKDEMEXPZ0','50','D','10','22',NULL,'Termination Reason/Type',NULL,NULL,'""','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESWKDEMEXP_20211229.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',BRS79,BRS1T,BRS0G,BRS2T,JMRX2,BRS6F,BRRHI,BRS8H,BRRJ7,BRS4J,BRRXL,BRS5F,D06AO,BRRZD,BTAS9,BPP00',NULL,NULL,NULL,'Shareworks Demo Export - AdHoc','202106289','EMPEXPORT','ONDEM_XOE','Aug 10 2021 11:32AM','ESWKDEMEXP',NULL,NULL,NULL,'202106289','Jun 28 2021  5:47AM','Jun 28 2021  5:47AM','202106281','1752','','','202106281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','VKSUT,BRS79,BRS1T,BRS0G,BRS2T,JMRX2,BRS6F,VKSRD,BRRHI,BRS8H,BRRJ7,BRS4J,BRRXL,BRS5F,D06AO,BRRZD,BTAS9,BPP00',NULL,NULL,NULL,'Shareworks Demo Export-Sched','202109139','EMPEXPORT','SCH_ESWKDE',NULL,'ESWKDEMEXP',NULL,NULL,NULL,'202112299','Jun 28 2021  5:47AM','Jun 28 2021  5:47AM','202112281',NULL,'','','202109131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Shareworks Demo Export-Test','202109221','EMPEXPORT','TEST_XOE','Sep 22 2021  8:45AM','ESWKDEMEXP',NULL,NULL,NULL,'202109221','Sep 22 2021 12:00AM','Dec 30 1899 12:00AM','202109221','1809','','','202109221',dbo.fn_GetTimedKey(),NULL,'us3cPeREM1008',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESWKDEMEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESWKDEMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESWKDEMEXP','D10','dbo.U_ESWKDEMEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESWKDEMEXP_Audit
-----------

IF OBJECT_ID('U_ESWKDEMEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL
);

-----------
-- Create table U_ESWKDEMEXP_AuditFields
-----------

IF OBJECT_ID('U_ESWKDEMEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESWKDEMEXP_drvTbl
-----------

IF OBJECT_ID('U_ESWKDEMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(9) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameMiddle] varchar(8000) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvInternationalSIN] varchar(50) NULL,
    [drvCandaSIN] varchar(50) NULL,
    [drvDateOfHire] varchar(8000) NULL,
    [DrvDateOfBirth] varchar(8000) NULL,
    [drvCompanyEmail] varchar(50) NULL,
    [drvAddressLine1] varchar(81) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressCountry] varchar(45) NULL,
    [drvAddressZipCode] varchar(52) NULL,
    [drvDepartment] varchar(10) NULL,
    [drvEntityRepOffice] varchar(10) NULL,
    [drvStockOptionStatus] varchar(16) NULL,
    [drvStockOptionDate] varchar(8000) NULL
);

-----------
-- Create table U_ESWKDEMEXP_EEList
-----------

IF OBJECT_ID('U_ESWKDEMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESWKDEMEXP_File
-----------

IF OBJECT_ID('U_ESWKDEMEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESWKDEMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESWKDEMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Remitly

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 06/28/2021
Service Request Number: TekP-2020-11-18-0001

Purpose: Shareworks Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESWKDEMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESWKDEMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESWKDEMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESWKDEMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESWKDEMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWKDEMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWKDEMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESWKDEMEXP', 'SCH_ESWKDE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESWKDEMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESWKDEMEXP';

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
    DELETE FROM dbo.U_ESWKDEMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESWKDEMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESWKDEMEXP_EEList WHERE xEEID NOT IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('REG','Z')--('STU','SUM','TES','TMP','CON')
    );

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESWKDEMEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESWKDEMEXP_AuditFields;
    CREATE TABLE dbo.U_ESWKDEMEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESWKDEMEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESWKDEMEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESWKDEMEXP_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESWKDEMEXP_Audit
    FROM dbo.U_ESWKDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESWKDEMEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -90, @EndDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND LTRIM(RTRIM(audNewValue)) = 'T'
    --AND ISNULL(audNewValue,'') <> '';
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESWKDEMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESWKDEMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESWKDEMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = SUBSTRING(EecEmpNo, PATINDEX('%[^0]%', EecEmpNo+'.'), LEN(EecEmpNo)) -- EecEmpNo
        ,drvNameFirst = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameFirst, 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvNameMiddle = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameMiddle, 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvNameLast = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast, 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvSSN = eepSSN
        ,drvInternationalSIN = CASE WHEN EepAddressCountry <> 'CAN' THEN EinNationalId END
        ,drvCandaSIN = CASE WHEN EepAddressCountry = 'CAN' THEN EinNationalId END
        ,drvDateOfHire = REPLACE(CONVERT(CHAR(11), /*EecDateOfOriginalHire*/ EecDateOfLastHire, 106), ' ', '-')
        ,DrvDateOfBirth = REPLACE(CONVERT(CHAR(11), EepDateOfBirth, 106), ' ', '-')
        ,drvCompanyEmail = EepAddressEMail
        ,drvAddressLine1 = LEFT(REPLACE(LEFT('"' + REPLACE(REPLACE(REPLACE(EepAddressLine1, '"', ''), '”', ''), '“', ''), 127), 'ñ', 'n'), 80) + '"'
        --,drvAddressLine2 = '"' + CASE WHEN LEN(EepAddressLine1) > 80  THEN SUBSTRING(REPLACE(LEFT(REPLACE(REPLACE(REPLACE(EepAddressLine1, '"', ''), '”', ''), '“', ''), 127) + '"', 'ñ', 'n'), 80, (LEN(EepAddressLine1) - 80) + 1) + ' ' ELSE '' END 
        ,drvAddressLine2 = '"' + CASE WHEN LEN(EepAddressLine1) > 80  THEN SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1, '"', ''), '”', ''), '“', ''), 'ñ', 'n'), 80, (LEN(EepAddressLine1) - 80) + 1) + ' ' ELSE '' END 
                 + CASE WHEN EepAddressLine2 IS NOT NULL THEN REPLACE(REPLACE(RTRIM(EepAddressLine2), '"', ''), 'ñ', 'n') ELSE '' END + '"'
        ,drvAddressCity = '"' + RTRIM(REPLACE(ISNULL(EepAddressCity, ''), 'ñ', 'n')) + '"'
        ,drvAddressState = EepAddressState
        ,drvAddressCountry = CodDesc --EepAddressCountry
        ,drvAddressZipCode = CASE WHEN ISNULL(EepAddressZipCode, '') <> '' THEN '"' + RTRIM(EepAddressZipCode) + '"' ELSE 'N/A' END
        ,drvDepartment = EecOrgLvl1
        ,drvEntityRepOffice = EecOrgLvl2 --'"' + REPLACE(OrgDesc2, ',','') + '"' -- '"' + CmpCompanyName + '"'
        ,drvStockOptionStatus = CASE WHEN EecEmplStatus = 'A' THEN 'Active'                                    
                                    WHEN EecEmplStatus = 'L' THEN 'Leave of Absence'
                                    --WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN 'Rehire'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'Retired'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'Death'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '215' THEN 'Disability'
                                    WHEN EecEmplStatus = 'T' THEN 'Termination'
                                END
        ,drvStockOptionDate = REPLACE(CONVERT(CHAR(11), 
                                                        CASE WHEN EecEmplStatus = 'T' AND EjhReason <> 'TRO' THEN EecDateOfTermination 
                                                            WHEN EecEmplStatus = 'T' AND EjhReason = 'TRO' THEN EecDateOfLastHire 
                                                            WHEN EecEmplStatus <> 'T' THEN EecDateOfLastHire  END, 106), ' ', '-')
    INTO dbo.U_ESWKDEMEXP_drvTbl
    FROM dbo.U_ESWKDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON xCOID = CmpCOID
    LEFT JOIN dbo.Codes WITH (NOLOCK)
        ON CodTable = 'COUNTRY'
        AND EepAddressCountry = CodCode
    LEFT JOIN (
            SELECT DISTINCT OrgCode AS OrgCode2, OrgDesc AS OrgDesc2, OrgManagerId AS OrgManagerId2
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 2
            ) AS Org2
        ON OrgCode2 = EecOrgLvl2
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCoID    = xCOID
    LEFT JOIN dbo.U_ESWKDEMEXP_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
    LEFT JOIN dbo.EmpIntl
        ON EinEEID = xEEID
    WHERE --EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN AudDateTime AND @EndDate)
        (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL)) -- AND EecDateOfTermination BETWEEN AudDateTime AND @EndDate))
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
ALTER VIEW dbo.dsi_vwESWKDEMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESWKDEMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESWKDEMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106211'
       ,expStartPerControl     = '202106211'
       ,expLastEndPerControl   = '202106289'
       ,expEndPerControl       = '202106289'
WHERE expFormatCode = 'ESWKDEMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESWKDEMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESWKDEMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESWKDEMEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESWKDEMEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESWKDEMEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESWKDEMEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESWKDEMEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESWKDEMEXP', 'UseFileName', 'V', 'Y'


-- End ripout