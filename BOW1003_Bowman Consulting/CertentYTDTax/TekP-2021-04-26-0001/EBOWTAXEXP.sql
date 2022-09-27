/**********************************************************************************

EBOWTAXEXP: Bowman Certent Tax File

FormatCode:     EBOWTAXEXP
Project:        Bowman Certent Tax File
Client ID:      BOW1003
Date/time:      2022-09-20 11:29:31.560
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP2DB01
Database:       ULTIPRO_WPBOWMN
Web Filename:   BOW1003_941BF_EEHISTORY_EBOWTAXEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBOWTAXEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EBOWTAXEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBOWTAXEXP'


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
WHERE FormatCode = 'EBOWTAXEXP'
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
WHERE ExpFormatCode = 'EBOWTAXEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBOWTAXEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBOWTAXEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBOWTAXEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBOWTAXEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBOWTAXEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBOWTAXEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBOWTAXEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBOWTAXEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBOWTAXEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBOWTAXEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBOWTAXEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBOWTAXEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBOWTAXEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBOWTAXEXP];
GO
IF OBJECT_ID('U_EBOWTAXEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_PEarHist];
GO
IF OBJECT_ID('U_EBOWTAXEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_PDedHist];
GO
IF OBJECT_ID('U_EBOWTAXEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_Header];
GO
IF OBJECT_ID('U_EBOWTAXEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_File];
GO
IF OBJECT_ID('U_EBOWTAXEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_EEList];
GO
IF OBJECT_ID('U_EBOWTAXEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_drvTbl];
GO
IF OBJECT_ID('U_EBOWTAXEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_DedList];
GO
IF OBJECT_ID('U_EBOWTAXEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_AuditFields];
GO
IF OBJECT_ID('U_EBOWTAXEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBOWTAXEXP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBOWTAXEXP','Bowman Certent Tax File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EBOWTAXEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOWTAXEXPZ0','50','H','01','1',NULL,'Equityholder Code / Participant ID',NULL,NULL,'"hrvEqholderCd_PartID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOWTAXEXPZ0','50','H','01','2',NULL,'Tax Year',NULL,NULL,'"hrvTaxYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOWTAXEXPZ0','50','H','01','3',NULL,'YTD Total Compensation',NULL,NULL,'"hrvYTDTotalComp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOWTAXEXPZ0','50','H','01','4',NULL,'YTD Taxable Supplemental Compensation',NULL,NULL,'"hrvYTDTaxableSupComp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOWTAXEXPZ0','50','H','01','5',NULL,'YTD Social Security',NULL,NULL,'"hrvYTDSocialSecurity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOWTAXEXPZ0','50','H','01','6',NULL,'YTD SDI',NULL,NULL,'"hrvYTDSDI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOWTAXEXPZ0','50','H','01','7',NULL,'Company Code',NULL,NULL,'"hrvCompanyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOWTAXEXPZ0','50','H','01','8',NULL,'State',NULL,NULL,'"hrvState"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOWTAXEXPZ0','50','D','10','1',NULL,'Equityholder Code / Participant ID',NULL,NULL,'"drvEqholderCd_PartID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOWTAXEXPZ0','50','D','10','2',NULL,'Tax Year',NULL,NULL,'"drvTaxYear"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOWTAXEXPZ0','50','D','10','3',NULL,'YTD Total Compensation',NULL,NULL,'"drvYTDTotalComp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOWTAXEXPZ0','50','D','10','4',NULL,'YTD Taxable Supplemental Compensation',NULL,NULL,'"drvYTDTaxableSupComp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOWTAXEXPZ0','50','D','10','5',NULL,'YTD Social Security',NULL,NULL,'"drvYTDSocialSecurity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOWTAXEXPZ0','50','D','10','6',NULL,'YTD SDI',NULL,NULL,'"drvYTDSDI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOWTAXEXPZ0','50','D','10','7',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOWTAXEXPZ0','50','D','10','8',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBOWTAXEXP_20220920.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Bowman Certent Tax File','202108319','EMPEXPORT','ONDEMAND',NULL,'EBOWTAXEXP',NULL,NULL,NULL,'202108319','Aug  6 2021 12:34PM','Aug  6 2021 12:34PM','202108011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202108319','EMPEXPORT','SCHEDULED',NULL,'EBOWTAXEXP',NULL,NULL,NULL,'202108319','Aug  6 2021 12:34PM','Aug  6 2021 12:34PM','202108011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202209099','EMPEXPORT','TEST','Sep 12 2022 12:00AM','EBOWTAXEXP',NULL,NULL,NULL,'202209099','Sep  9 2022 12:00AM','Dec 30 1899 12:00AM','202209091','352','','','202209091',dbo.fn_GetTimedKey(),NULL,'us3jReBOW1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWTAXEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWTAXEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWTAXEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWTAXEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWTAXEXP','UDESPath','C','\\us.saas\EW4\EW42\Downloads\V10\Exports\BOWMN\EmployeeHistoryExport\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWTAXEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOWTAXEXP','H01','dbo.U_EBOWTAXEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOWTAXEXP','D10','dbo.U_EBOWTAXEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBOWTAXEXP_Audit
-----------

IF OBJECT_ID('U_EBOWTAXEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EBOWTAXEXP_AuditFields
-----------

IF OBJECT_ID('U_EBOWTAXEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBOWTAXEXP_DedList
-----------

IF OBJECT_ID('U_EBOWTAXEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBOWTAXEXP_drvTbl
-----------

IF OBJECT_ID('U_EBOWTAXEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEqholderCd_PartID] char(9) NULL,
    [drvTaxYear] int NULL,
    [drvYTDTotalComp] varchar(10) NULL,
    [drvYTDTaxableSupComp] varchar(10) NULL,
    [drvYTDSocialSecurity] varchar(10) NULL,
    [drvYTDSDI] varchar(10) NULL,
    [drvCompanyCode] varchar(5) NOT NULL,
    [drvState] varchar(255) NULL
);

-----------
-- Create table U_EBOWTAXEXP_EEList
-----------

IF OBJECT_ID('U_EBOWTAXEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBOWTAXEXP_File
-----------

IF OBJECT_ID('U_EBOWTAXEXP_File') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EBOWTAXEXP_Header
-----------

IF OBJECT_ID('U_EBOWTAXEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_Header] (
    [hrvEqholderCd_PartID] varchar(34) NOT NULL,
    [hrvTaxYear] varchar(8) NOT NULL,
    [hrvYTDTotalComp] varchar(22) NOT NULL,
    [hrvYTDTaxableSupComp] varchar(37) NOT NULL,
    [hrvYTDSocialSecurity] varchar(19) NOT NULL,
    [hrvYTDSDI] varchar(7) NOT NULL,
    [hrvCompanyCode] varchar(12) NOT NULL,
    [hrvState] varchar(5) NOT NULL
);

-----------
-- Create table U_EBOWTAXEXP_PDedHist
-----------

IF OBJECT_ID('U_EBOWTAXEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL
);

-----------
-- Create table U_EBOWTAXEXP_PEarHist
-----------

IF OBJECT_ID('U_EBOWTAXEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBOWTAXEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PthCurTaxAmt] numeric NULL,
    [PthCurTaxAmtYTD] numeric NULL,
    [PehCurAmtYTDSupp] numeric NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBOWTAXEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bowman

Created By: Luis Lugo
Business Analyst: Richard Vars
Create Date: 08/06/2021
Service Request Number: TekP-2021-04-26-0001

Purpose: Bowman Certent Tax File

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBOWTAXEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBOWTAXEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBOWTAXEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBOWTAXEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBOWTAXEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOWTAXEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOWTAXEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOWTAXEXP', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBOWTAXEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBOWTAXEXP';

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
    DELETE FROM dbo.U_EBOWTAXEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBOWTAXEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     -- Include terms within the last 90 days of the effective date.
    DELETE El
    FROM dbo.U_EBOWDEMEXP_EEList El
    INNER JOIN dbo.vw_int_EmpComp
        ON xEEID = EecEEID
        AND xCoID = EecCoID
        --AND EecEmplStatus = 'T'
        AND EecDateOfTermination < DATEADD(DAY, -90, CONVERT(DATE, @EndDate))


         --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EBOWDEMEXP_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EBOWDEMEXP_AuditFields;
    --CREATE TABLE dbo.U_EBOWDEMEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    --INSERT INTO dbo.U_EBOWDEMEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EBOWDEMEXP_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EBOWDEMEXP_Audit;
    --SELECT 
    --    audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --INTO dbo.U_EBOWDEMEXP_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    --JOIN dbo.U_EBOWDEMEXP_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE';


     -- Create Index
    --CREATE CLUSTERED INDEX CDX_U_EBOWDEMEXP_Audit ON dbo.U_EBOWDEMEXP_Audit (audEEID,audKey2);



    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBOWDEMEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBOWDEMEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ,PthCurTaxAmt            = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PthCurTaxAmt ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PthCurTaxAmtYTD        = sum(CASE WHEN PthTaxCode = 'USSOCEE' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PehStateSUIYTD         = sum(CASE WHEN PthTaxCode like '%SUI%' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PehCurAmtYTDSupp       = sum(CASE WHEN pehEarncode IN ('BOANN','BOFDW','BOMYS','BON2','BONUS','BOSPM','BOSPQ','BOSTB','BOTEC','COMM','CUSBO','DELIQ','EQLN',
                                                                'PEER','QUART','REFER','RELO','SEV','SIGN','SPOT','STAYB') THEN PehCurAmt ELSE 0.00 END) 
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        ,PehYTDTaxableSupplementalCompensation = SUM(PthCurSuppTaxableWages)
    INTO dbo.U_EBOWDEMEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber and PthTaxCode = 'USSOCEE'
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND pehEarncode in ('ADBVC','ADLTI','AATAX','AATNW','SFBON','BONUS','BONSG','BON2','BONSP','BONNS','BONOT','BON3','BON4',
                                                     'BON1','BONVC','CASHA','DT','GTL','INDLV','JURY','LTIBN','MISC','RELOU','RELUM','OT100','OTSAL','OTHPA',
                                                     'OPAYN','OT','PTO','PDTX','PDTXM','LTINC','PTOAC','PTOBK','PTOPO','REFRL','REG2','REG','RETRO','SALRY',
                                                     'SEV','STDP','SG','STKOP','TAXPR','VOLWK','WKDHR','BONIP')
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBOWTAXEXP_drvTbl
    ---------------------------------
    ---------------------------------
    IF OBJECT_ID('U_EBOWTAXEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBOWTAXEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEqholderCd_PartID = EecEmpNo 
        ,drvTaxYear = Year(GetDate())
        ,drvYTDTotalComp =  CONVERT(VARCHAR(10), CONVERT(MONEY, PehCurAmtYTD))
        ,drvYTDTaxableSupComp = CONVERT(VARCHAR(10), CONVERT(MONEY, PehYTDTaxableSupplementalCompensation)) --PehCurAmtYTDSupp))
        ,drvYTDSocialSecurity = CONVERT(VARCHAR(10), CONVERT(MONEY, YtdSocialSecurity))
        ,drvYTDSDI = CONVERT(VARCHAR(10), CONVERT(MONEY, PehStateSUIYTD))
        ,drvCompanyCode = CASE WHEN cmpcompanycode = 'BCG' THEN 'BCG'
                               WHEN cmpcompanycode = 'BRCLC' THEN 'BRCLC'
                               WHEN cmpcompanycode = 'NCPC2' THEN 'NCPC2'
                               ELSE '' END
        ,drvState = eepaddressstate

    INTO dbo.U_EBOWTAXEXP_drvTbl
    FROM dbo.U_EBOWTAXEXP_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.Empcomp WITH (NOLOCK)
        ON eeceeid = xEEID and EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
            ON LocCode = eecLocation
    JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
    JOIN dbo.U_EBOWDEMEXP_PEarHist WITH (NOLOCK)
        ON xEEID = PehEEID
    /*JOIN (SELECT pehEEID,PehCOID, SUM(PehCurAmt) AS PehCurAmtYTD   --SUM(PehCurAmtYTDSupp) AS PehCurAmtYTDSupp--,SUM(PehStateSUIYTD) AS PehStateSUIYTD
               FROM dbo.PEarHist WITH (NOLOCK)
               WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
               AND PehPerControl <= @EndPerControl
               AND PehPayDate > '1/1/2021'
                --AND PthTaxCode = 'USSOCEE'
               GROUP BY pehEEID,PehCoID) AS PEH           
               ON pehEEID = xEEID
               AND PehCOID = xCOID*/

     JOIN (SELECT pehEEID,PehCOID, SUM(CASE WHEN pehEarncode IN ('BOANN','BOFDW','BOMYS','BON2','BONUS','BOSPM','BOSPQ','BOSTB','BOTEC','COMM','CUSBO','DELIQ','EQLN','PEER','QUART','REFER','RELO','SEV','SIGN','SPOT','STAYB') THEN PehCurAmt ELSE 0.00 END) AS PehCurAmtYTDSUPP  
               FROM dbo.PEarHist WITH (NOLOCK)
               WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
               AND PehPerControl <= @EndPerControl
               AND PehPayDate > '1/1/2021'
                --AND PthTaxCode = 'USSOCEE'
               GROUP BY pehEEID,PehCoID) AS PEHSUPP       
               ON pehsupp.PehEEID = xEEID
               AND pehsupp.PehCoID = xCOID

    /*JOIN (SELECT PthEEID, PthCOID,SUM(PthCurTaxAmt) AS  PehStateSUIYTD                     
          FROM dbo.PTaxHist A WITH (NOLOCK)
          WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
                AND PthPerControl <= @EndPerControl
                AND PthPayDate > '1/1/2021'
                AND PthTaxCode like '%SUI%'
          GROUP BY PthEEID, PthCOID) AS PTHSUIYTD
          ON PTHSUIYTD.PthEEID = xEEID
         AND PTHSUIYTD.PthCoID = xCOID*/
                          

    JOIN (SELECT PthEEID, PthCOID,SUM(PthCurTaxAmt) AS YtdSocialSecurity                     
          FROM dbo.PTaxHist A WITH (NOLOCK)
          WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
                AND PthPerControl <= @EndPerControl
                AND PthPayDate > '1/1/2021'
                AND PthTaxCode = 'USSOCEE'
          GROUP BY PthEEID, PthCOID) AS PTH
          ON PTH.PthEEID = xEEID
         AND PTH.PthCoID = xCOID

         Where (EepUDField01 = 'YES' OR EepUDField02 = 'YES')  -- ELIGIBILITY DETERMINATION
        ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBOWTAXEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBOWTAXEXP_Header;
    SELECT DISTINCT
         hrvEqholderCd_PartID = 'Equityholder Code / Participant ID'
        ,hrvTaxYear = 'Tax Year'
        ,hrvYTDTotalComp = 'YTD Total Compensation'
        ,hrvYTDTaxableSupComp = 'YTD Taxable Supplemental Compensation'
        ,hrvYTDSocialSecurity = 'YTD Social Security'
        ,hrvYTDSDI = 'YTD SDI'
        ,hrvCompanyCode = 'Company Code' --CmpCompanyCode
        ,hrvState = 'State'
    INTO dbo.U_EBOWTAXEXP_Header
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Bowman_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Bowman_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Bowman_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'Bowman_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEBOWTAXEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBOWTAXEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBOWTAXEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108011'
       ,expStartPerControl     = '202108011'
       ,expLastEndPerControl   = '202108319'
       ,expEndPerControl       = '202108319'
WHERE expFormatCode = 'EBOWTAXEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBOWTAXEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBOWTAXEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBOWTAXEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBOWTAXEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBOWTAXEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBOWTAXEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBOWTAXEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBOWTAXEXP', 'UseFileName', 'V', 'Y'


-- End ripout