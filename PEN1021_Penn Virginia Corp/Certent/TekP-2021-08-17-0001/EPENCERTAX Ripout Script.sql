/**********************************************************************************

EPENCERTAX: Penn Virginia Certent Tax File

FormatCode:     EPENCERTAX
Project:        Penn Virginia Certent Tax File
Client ID:      PEN1021
Date/time:      2022-04-11 08:33:58.270
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPPNV
Web Filename:   PEN1021_PIS66_EEHISTORY_EPENCERTAX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPENCERTAX_SavePath') IS NOT NULL DROP TABLE dbo.U_EPENCERTAX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPENCERTAX'


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
WHERE FormatCode = 'EPENCERTAX'
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
WHERE ExpFormatCode = 'EPENCERTAX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPENCERTAX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPENCERTAX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPENCERTAX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPENCERTAX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPENCERTAX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPENCERTAX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPENCERTAX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPENCERTAX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPENCERTAX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPENCERTAX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPENCERTAX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPENCERTAX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPENCERTAX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPENCERTAX];
GO
IF OBJECT_ID('U_EPENCERTAX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPENCERTAX_PEarHist];
GO
IF OBJECT_ID('U_EPENCERTAX_Header') IS NOT NULL DROP TABLE [dbo].[U_EPENCERTAX_Header];
GO
IF OBJECT_ID('U_EPENCERTAX_File') IS NOT NULL DROP TABLE [dbo].[U_EPENCERTAX_File];
GO
IF OBJECT_ID('U_EPENCERTAX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPENCERTAX_EEList];
GO
IF OBJECT_ID('U_EPENCERTAX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPENCERTAX_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPENCERTAX','Penn Virginia Certent Tax File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EPENCERTAXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPENCERTAXZ0','50','H','01','1',NULL,'Equityholder Code / Participant ID',NULL,NULL,'"hrvEquityCode_PartID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPENCERTAXZ0','50','H','01','2',NULL,'Tax Year',NULL,NULL,'"hrvTaxYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPENCERTAXZ0','50','H','01','3',NULL,'YTD Total Compensation',NULL,NULL,'"hrvYTDTotalCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPENCERTAXZ0','50','H','01','4',NULL,'YTD Taxable Supplemental ',NULL,NULL,'"hrvYTDTaxableSupplemental"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPENCERTAXZ0','50','H','01','5',NULL,'YTD Social Security ',NULL,NULL,'"hrvYTDSocialSecurity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPENCERTAXZ0','50','H','01','6',NULL,'YTD Medicare ',NULL,NULL,'"hrvYTDMedicare"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPENCERTAXZ0','50','H','01','7',NULL,'YTD SDI ',NULL,NULL,'"hrvYTDSDI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPENCERTAXZ0','50','H','01','8',NULL,'YTD SUI ',NULL,NULL,'"hrvYTDSUI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPENCERTAXZ0','50','H','01','9',NULL,'YTD FLI ',NULL,NULL,'"hrvYTDFLI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPENCERTAXZ0','50','H','01','10',NULL,'YTD WF ',NULL,NULL,'"hrvYTDWF "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPENCERTAXZ0','50','H','01','11',NULL,'State Code',NULL,NULL,'"hrvStateCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPENCERTAXZ0','50','H','01','12',NULL,'Company Code',NULL,NULL,'"hrvCompanyCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPENCERTAXZ0','50','D','10','1',NULL,'Equityholder Code / Participant ID',NULL,NULL,'"drvEquityCode_PartID "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPENCERTAXZ0','50','D','10','2',NULL,'Tax Year',NULL,NULL,'"drvTaxYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPENCERTAXZ0','50','D','10','3',NULL,'YTD Total Compensation',NULL,NULL,'"drvYTDTotalCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPENCERTAXZ0','50','D','10','4',NULL,'YTD Taxable Supplemental ',NULL,NULL,'"drvYTDTaxableSupplemental "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPENCERTAXZ0','50','D','10','5',NULL,'YTD Social Security ',NULL,NULL,'"drvYTDSocialSecurity "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPENCERTAXZ0','50','D','10','6',NULL,'YTD Medicare ',NULL,NULL,'"drvYTDMedicare "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPENCERTAXZ0','50','D','10','7',NULL,'YTD SDI ',NULL,NULL,'"drvYTDSDI "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPENCERTAXZ0','50','D','10','8',NULL,'YTD SUI ',NULL,NULL,'"drvYTDSUI "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPENCERTAXZ0','50','D','10','9',NULL,'YTD FLI ',NULL,NULL,'"drvYTDFLI "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPENCERTAXZ0','50','D','10','10',NULL,'YTD WF ',NULL,NULL,'"drvYTDWF "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPENCERTAXZ0','50','D','10','11',NULL,'State Code',NULL,NULL,'"drvStateCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPENCERTAXZ0','50','D','10','12',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''T|'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPENCERTAX_20220411.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Penn Virginia Certent Tax File','202109289','EMPEXPORT','ONDEM_XOE',NULL,'EPENCERTAX',NULL,NULL,NULL,'202109289','Sep 28 2021  3:44PM','Sep 28 2021  3:44PM','202109281',NULL,'','','202109281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Penn Virginia Certent Ta-Sched','202109289','EMPEXPORT','SCH_EPENCE',NULL,'EPENCERTAX',NULL,NULL,NULL,'202109289','Sep 28 2021  3:44PM','Sep 28 2021  3:44PM','202109281',NULL,'','','202109281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Penn Virginia Certent Ta-Test','202203311','EMPEXPORT','TEST_XOE','Mar 30 2022  3:42PM','EPENCERTAX',NULL,NULL,NULL,'202203311','Mar 31 2022 12:00AM','Apr  3 2022 12:00AM','202203311','50','','','202203311',dbo.fn_GetTimedKey(),NULL,'us3rVaPEN1021',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPENCERTAX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPENCERTAX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPENCERTAX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPENCERTAX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPENCERTAX','H01','dbo.U_EPENCERTAX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPENCERTAX','D10','dbo.U_EPENCERTAX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPENCERTAX_drvTbl
-----------

IF OBJECT_ID('U_EPENCERTAX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPENCERTAX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEquityCode_PartID] char(9) NULL,
    [drvTaxYear] int NULL,
    [drvYTDTotalCompensation] nvarchar(4000) NULL,
    [drvYTDTaxableSupplemental] varchar(10) NULL,
    [drvYTDSocialSecurity] varchar(10) NULL,
    [drvYTDMedicare] varchar(10) NULL,
    [drvYTDSDI] varchar(1) NOT NULL,
    [drvYTDSUI] varchar(10) NULL,
    [drvYTDFLI] varchar(1) NOT NULL,
    [drvYTDWF] varchar(1) NOT NULL,
    [drvStateCode] varchar(255) NULL,
    [drvCompanyCode] varchar(3) NULL
);

-----------
-- Create table U_EPENCERTAX_EEList
-----------

IF OBJECT_ID('U_EPENCERTAX_EEList') IS NULL
CREATE TABLE [dbo].[U_EPENCERTAX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPENCERTAX_File
-----------

IF OBJECT_ID('U_EPENCERTAX_File') IS NULL
CREATE TABLE [dbo].[U_EPENCERTAX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EPENCERTAX_Header
-----------

IF OBJECT_ID('U_EPENCERTAX_Header') IS NULL
CREATE TABLE [dbo].[U_EPENCERTAX_Header] (
    [hrvEquityCode_PartID] varchar(34) NOT NULL,
    [hrvTaxYear] varchar(8) NOT NULL,
    [hrvYTDTotalCompensation] varchar(22) NOT NULL,
    [hrvYTDTaxableSupplemental] varchar(37) NOT NULL,
    [hrvYTDSocialSecurity] varchar(19) NOT NULL,
    [hrvYTDMedicare] varchar(12) NOT NULL,
    [hrvYTDSDI] varchar(7) NOT NULL,
    [hrvYTDSUI] varchar(7) NOT NULL,
    [hrvYTDFLI] varchar(7) NOT NULL,
    [hrvYTDWF] varchar(6) NOT NULL,
    [hrvStateCode] varchar(10) NOT NULL,
    [hrvCompanyCode] varchar(12) NOT NULL
);

-----------
-- Create table U_EPENCERTAX_PEarHist
-----------

IF OBJECT_ID('U_EPENCERTAX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPENCERTAX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PthCurTaxAmtYTD] money NULL,
    [PthMedicareYTD] numeric NULL,
    [PehCurAmtYTDSupp] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPENCERTAX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Penn Virginia Corporation

Created By: Luis Lugo
Business Analyst: Richard Vars
Create Date: 09/28/2021
Service Request Number: TekP-2021-08-17-0001

Purpose: Penn Virginia Certent Tax File

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPENCERTAX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPENCERTAX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPENCERTAX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPENCERTAX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPENCERTAX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPENCERTAX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPENCERTAX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPENCERTAX', 'SCH_EPENCE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPENCERTAX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPENCERTAX';

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
    DELETE FROM dbo.U_EPENCERTAX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPENCERTAX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EPENCERTAX_EEList WHERE xEEID NOT IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecUDField22 = 'Y'
    )


     ---- Include terms within the last 90 days of the effective date.
  --  DELETE El
  --  FROM dbo.U_EPENCERTAX_EEList El
  --  INNER JOIN dbo.vw_int_EmpComp
  --      ON xEEID = EecEEID
  --      AND xCoID = EecCoID
  --      --AND EecEmplStatus = 'T'
  --      AND EecDateOfTermination < DATEADD(DAY, -90, CONVERT(DATE, @EndDate))


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPENCERTAX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPENCERTAX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PthCurTaxAmtYTD        = SUM(PthCurTaxAmt)
        ,PthMedicareYTD        = SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxAmt ELSE 0.00 END)
        --,PehStateSUIYTD         = sum(CASE WHEN PthTaxCode like '%SUI%' THEN PthCurTaxAmt ELSE 0.00 END)
        --,PehCurAmtYTDSupp       = sum(CASE WHEN pehEarncode IN ('BONS1','BONS2','RELO','RELO2','RSTK','SEV','BONS3') THEN PehCurAmt ELSE 0.00 END) 
        ,PehCurAmtYTDSupp  = SUM(PthCurSuppTaxableWages) 
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPENCERTAX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PehGenNumber = PthGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND pehEarncode in ('BEREV','FLOAT','GTL','HOL','HOLW','JURY','PTO','REG','RETRO','STD','SICK')

    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID,PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPENCERTAX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPENCERTAX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPENCERTAX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEquityCode_PartID = EecEmpNo
        ,drvTaxYear = Year(GetDate())
        ,drvYTDTotalCompensation = FORMAT(PehCurAmtYTD, '#0.00') -- CONVERT(VARCHAR(10), CONVERT(MONEY, PehCurAmtYTD))
        ,drvYTDTaxableSupplemental = CONVERT(VARCHAR(10), CONVERT(MONEY, PehCurAmtYTDSupp))
        --,drvCompensation   = ''
        ,drvYTDSocialSecurity  = CONVERT(VARCHAR(10), CONVERT(MONEY, YtdSocialSecurity))
        ,drvYTDMedicare  = CONVERT(VARCHAR(10), CONVERT(MONEY, PthMedicareYTD))
        ,drvYTDSDI  = '' -- Leave Blank
        ,drvYTDSUI  =  CONVERT(VARCHAR(10), CONVERT(MONEY, PehStateSUIYTD))
        ,drvYTDFLI  = '' -- Leave Blank
        ,drvYTDWF  = '' -- Leave Blank
        ,drvStateCode = LocAddressState
        ,drvCompanyCode = CASE WHEN CmpCoID = 'Q9F09' THEN '100'
                               WHEN CmpCoID = 'Q9FEY' THEN '314'
                               END

    INTO dbo.U_EPENCERTAX_drvTbl
    FROM dbo.U_EPENCERTAX_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Empcomp WITH (NOLOCK)
        ON eeceeid = xEEID and EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
            ON LocCode = eecLocation
    LEFT JOIN dbo.U_EPENCERTAX_PEarHist
        ON PehEEID = xEEID
        AND PehCOID = xCOID
    /*JOIN (SELECT pehEEID,PehCOID, SUM(PehCurAmt) AS PehCurAmtYTD   --SUM(PehCurAmtYTDSupp) AS PehCurAmtYTDSupp--,SUM(PehStateSUIYTD) AS PehStateSUIYTD
               FROM dbo.PEarHist WITH (NOLOCK)
               WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
               AND PehPerControl <= @EndPerControl
               AND PehPayDate > '1/1/2020'
                --AND PthTaxCode = 'USSOCEE'
               GROUP BY pehEEID,PehCoID) AS PEH           
               ON PEH.pehEEID = xEEID
               AND PEH.PehCOID = xCOID*/

     /*JOIN (SELECT pehEEID,PehCOID, SUM(CASE WHEN pehEarncode IN ('BONS1','BONS2','RELO','RELO2','RSTK','SEV','BONS3') THEN PehCurAmt ELSE 0.00 END) AS PehCurAmtYTDSUPP  
               FROM dbo.PEarHist WITH (NOLOCK)
               WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
               AND PehPerControl <= @EndPerControl
               AND PehPayDate > '1/1/2021'
                --AND PthTaxCode = 'USSOCEE'
               GROUP BY pehEEID,PehCoID) AS PEHSUPP       
               ON PEHSUPP.PehEEID = xEEID
               AND PEHSUPP.PehCoID = xCOID*/

    JOIN (SELECT PthEEID, PthCOID,SUM(PthCurTaxAmt) AS  PehStateSUIYTD                     
          FROM dbo.PTaxHist A WITH (NOLOCK)
          WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
                AND PthPerControl <= @EndPerControl
                AND PthPayDate > '1/1/2020'
                AND PthTaxCode like '%SUI%'
          GROUP BY PthEEID, PthCOID) AS PTHSUIYTD
          ON PTHSUIYTD.PthEEID = xEEID
         AND PTHSUIYTD.PthCoID = xCOID

    JOIN (SELECT PthEEID, PthCOID,SUM(PthCurTaxAmt) AS YtdSocialSecurity                     
          FROM dbo.PTaxHist A WITH (NOLOCK)
          WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
                AND PthPerControl <= @EndPerControl
                AND PthPayDate > '1/1/2020'
                AND PthTaxCode = 'USSOCEE'
          GROUP BY PthEEID, PthCOID) AS PTH
          ON PTH.PthEEID = xEEID
         AND PTH.PthCoID = xCOID
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPENCERTAX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPENCERTAX_Header;
    SELECT DISTINCT
          hrvEquityCode_PartID = 'Equityholder Code / Participant ID'
         ,hrvTaxYear = 'Tax Year'
         ,hrvYTDTotalCompensation = 'YTD Total Compensation'
         ,hrvYTDTaxableSupplemental = 'YTD Taxable Supplemental Compensation'
         ,hrvYTDSocialSecurity = 'YTD Social Security'
         ,hrvYTDMedicare = 'YTD Medicare'
         ,hrvYTDSDI = 'YTD SDI'
         ,hrvYTDSUI = 'YTD SUI' 
         ,hrvYTDFLI = 'YTD FLI'
         ,hrvYTDWF = 'YTD WF'
         ,hrvStateCode = 'State Code'
         ,hrvCompanyCode = 'Company Code'
    INTO dbo.U_EPENCERTAX_Header
    ;



    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ClientName_Tax_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPENCERTAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPENCERTAX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPENCERTAX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109211'
       ,expStartPerControl     = '202109211'
       ,expLastEndPerControl   = '202109289'
       ,expEndPerControl       = '202109289'
WHERE expFormatCode = 'EPENCERTAX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPENCERTAX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPENCERTAX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPENCERTAX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPENCERTAX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPENCERTAX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPENCERTAX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPENCERTAX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPENCERTAX', 'UseFileName', 'V', 'Y'


-- End ripout