/**********************************************************************************

EWEXMULTXP: WEX FSA/DepCare/HAS/Commute/Park Export

FormatCode:     EWEXMULTXP
Project:        WEX FSA/DepCare/HAS/Commute/Park Export
Client ID:      FAY1001
Date/time:      2022-05-24 13:21:36.843
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB02
Database:       ULTIPRO_WPFAY
Web Filename:   FAY1001_7R9P0_EEHISTORY_EWEXMULTXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWEXMULTXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EWEXMULTXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWEXMULTXP'


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
WHERE FormatCode = 'EWEXMULTXP'
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
WHERE ExpFormatCode = 'EWEXMULTXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWEXMULTXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWEXMULTXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWEXMULTXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWEXMULTXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWEXMULTXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWEXMULTXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWEXMULTXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWEXMULTXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWEXMULTXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWEXMULTXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWEXMULTXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWEXMULTXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWEXMULTXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXMULTXP];
GO
IF OBJECT_ID('U_EWEXMULTXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_Trailer];
GO
IF OBJECT_ID('U_EWEXMULTXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_PEarHist];
GO
IF OBJECT_ID('U_EWEXMULTXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_PDedHist];
GO
IF OBJECT_ID('U_EWEXMULTXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_Header];
GO
IF OBJECT_ID('U_EWEXMULTXP_File') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_File];
GO
IF OBJECT_ID('U_EWEXMULTXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_EEList];
GO
IF OBJECT_ID('U_EWEXMULTXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_drvTbl];
GO
IF OBJECT_ID('U_EWEXMULTXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWEXMULTXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EWEXMULTXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWEXMULTXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWEXMULTXP','WEX FSA/DepCare/HAS/Commute/Park Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EWEXMULTXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXMULTXPZ0','50','H','01','1',NULL,'Record Type ',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXMULTXPZ0','50','H','01','2',NULL,'Administrator Code ',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXMULTXPZ0','50','H','01','3',NULL,'Employer Code ',NULL,NULL,'"43221"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXMULTXPZ0','50','H','01','4',NULL,'Synchronize Flag ',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXMULTXPZ0','50','H','01','5',NULL,'Submitted Date ',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXMULTXPZ0','50','H','01','6',NULL,'Submitted Time ',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXMULTXPZ0','50','H','01','7',NULL,'File Version ',NULL,NULL,'"3.5"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXMULTXPZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL,'"CT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXMULTXPZ0','50','D','10','2',NULL,'Participant File Import Id ',NULL,NULL,'"drvParticipantFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXMULTXPZ0','50','D','10','3',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXMULTXPZ0','50','D','10','4',NULL,'Contribution Date ',NULL,NULL,'"drvContributionDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXMULTXPZ0','50','D','10','5',NULL,'Contribution Description ',NULL,NULL,'"Payroll Deduction"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXMULTXPZ0','50','D','10','6',NULL,'Contribution Amount ',NULL,NULL,'"drvContributionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXMULTXPZ0','50','D','10','7',NULL,'Amount Type ',NULL,NULL,'"Actual"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXMULTXPZ0','50','T','90','1',NULL,'Record Type ',NULL,NULL,'"FF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXMULTXPZ0','50','T','90','2',NULL,'Record Count ',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXMULTXPZ0','50','T','90','3',NULL,'Administrator Code ',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXMULTXPZ0','50','T','90','4',NULL,'Employer Code ',NULL,NULL,'"43221"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXMULTXPZ0','50','T','90','5',NULL,'Submitted Date ',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXMULTXPZ0','50','T','90','6',NULL,'Submitted Time ',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWEXMULTXP_20220524.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202203299','EMPEXPORT','OEACTIVE','Mar 29 2022 10:14AM','EWEXMULTXP',NULL,NULL,NULL,'202203299','Mar 29 2022  8:37AM','Mar 29 2022  8:37AM','202203251','2','','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202203299','EMPEXPORT','OEPASSIVE','Mar 29 2022 10:14AM','EWEXMULTXP',NULL,NULL,NULL,'202203299','Mar 29 2022  8:37AM','Mar 29 2022  8:37AM','202203251','195','','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OEZ4Z,9YH8C,WLTLO',NULL,NULL,NULL,'WEX FSA/DepCre/HAS/Com/Par Exp','202205209','EMPEXPORT','ONDEM_XOE','May 23 2022  2:39PM','EWEXMULTXP',NULL,NULL,NULL,'202205209','May 20 2022 12:00AM','Dec 30 1899 12:00AM','202205181','349','eecPayGroup','SALARY,NEHRLY,PTNRS,TCETX','202205181',dbo.fn_GetTimedKey(),NULL,'us3cBeFAY1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'WEX FSA/DepCre/HAS/Com/P-Sched','202203299','EMPEXPORT','SCH_EWEXMU','Mar 29 2022 10:15AM','EWEXMULTXP',NULL,NULL,NULL,'202203299','Mar 29 2022  8:37AM','Mar 29 2022  8:37AM','202203251','195','','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OEZ4Z,9YH8C,WLTLO',NULL,NULL,NULL,'WEX FSA/DepCre/HAS/Com/P-Test','202205061','EMPEXPORT','TEST_XOE','May 23 2022  2:56PM','EWEXMULTXP',NULL,NULL,NULL,'202205061','May  6 2022 12:00AM','May  1 2022 12:00AM','202205061','349','','SALARY,GLOB,HRONLY,TCEBWK,NEHRLY,PTNRS,TCETX,TICGMH,TICGMP,TICGMS','202205061',dbo.fn_GetTimedKey(),NULL,'us3cBeFAY1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXMULTXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXMULTXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXMULTXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXMULTXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXMULTXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXMULTXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXMULTXP','H01','dbo.U_EWEXMULTXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXMULTXP','D10','dbo.U_EWEXMULTXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXMULTXP','T90','dbo.U_EWEXMULTXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EWEXMULTXP
-----------

IF OBJECT_ID('U_dsi_BDM_EWEXMULTXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWEXMULTXP] (
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
-- Create table U_EWEXMULTXP_DedList
-----------

IF OBJECT_ID('U_EWEXMULTXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EWEXMULTXP_drvTbl
-----------

IF OBJECT_ID('U_EWEXMULTXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvParticipantFileImportId] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionAmount] nvarchar(4000) NULL
);

-----------
-- Create table U_EWEXMULTXP_EEList
-----------

IF OBJECT_ID('U_EWEXMULTXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWEXMULTXP_File
-----------

IF OBJECT_ID('U_EWEXMULTXP_File') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EWEXMULTXP_Header
-----------

IF OBJECT_ID('U_EWEXMULTXP_Header') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_Header] (
    [drvSubmittedDate] date NULL,
    [drvSubmittedTime] varchar(6) NULL
);

-----------
-- Create table U_EWEXMULTXP_PDedHist
-----------

IF OBJECT_ID('U_EWEXMULTXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhMedicalFSAAmt] numeric NULL,
    [PdhDepCareFSAAmt] numeric NULL,
    [PdhLimitedMedicalFSAAmt] numeric NULL,
    [PdhMassTransitFSA] numeric NULL,
    [PdhParkingAmt] numeric NULL,
    [PdhHSAAmt] numeric NULL
);

-----------
-- Create table U_EWEXMULTXP_PEarHist
-----------

IF OBJECT_ID('U_EWEXMULTXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurHrsPast12Mo] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EWEXMULTXP_Trailer
-----------

IF OBJECT_ID('U_EWEXMULTXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EWEXMULTXP_Trailer] (
    [drvRecordCount] int NULL,
    [drvSubmittedDate] date NULL,
    [drvSubmittedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXMULTXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Fay Financial

Created By: James Bender
Business Analyst: Curlin Beck
Create Date: 03/29/2022
Service Request Number: TekP-2021-12-10-0004

Purpose: WEX FSA/DepCare/HAS/Commute/Park Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWEXMULTXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWEXMULTXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWEXMULTXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWEXMULTXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWEXMULTXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXMULTXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXMULTXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXMULTXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXMULTXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXMULTXP', 'SCH_EWEXMU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWEXMULTXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWEXMULTXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWEXMULTXP';

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
    DELETE FROM dbo.U_EWEXMULTXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWEXMULTXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA, FSADC, FSAI, FSAI2, FSAMD,HSA,HSACF,HSACI,HSAI,HSAF,TRAM1,TRAM2,TSAM2,TSAMT,TSAP2,TSAPK';

    IF OBJECT_ID('U_EWEXMULTXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXMULTXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWEXMULTXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EWEXMULTXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXMULTXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhMedicalFSAAmt            = SUM(CASE WHEN PdhDedCode IN ('FSAMD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDepCareFSAAmt            = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLimitedMedicalFSAAmt    = SUM(CASE WHEN PdhDedCode IN ('FSAI','FSAI2') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhMassTransitFSA            = SUM(CASE WHEN PdhDedCode IN ('TRAM1','TRAM2','TSAM2','TSAMT') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhParkingAmt                = SUM(CASE WHEN PdhDedCode IN ('TSAP2','TSAPK') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSAAmt                    = SUM(CASE WHEN PdhDedCode IN ('HSA','HSACI','HSACF','HSAI','HSAF') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EWEXMULTXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EWEXMULTXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EWEXMULTXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXMULTXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsPast12Mo           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EWEXMULTXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd') + '1' AND @EndPerControl
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWEXMULTXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXMULTXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXMULTXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportId = EepSSN
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('FSAMD') THEN 'Medical FSA'
                        WHEN BdmDedCode IN ('FSADC') THEN 'Dependent Care FSA'
                        WHEN BdmDedCode IN ('FSAI','FSAI2') THEN 'Limited Medical FSA'
                        WHEN BdmDedCode IN ('TRAM1','TRAM2','TSAM2','TSAMT') THEN 'Mass Transit'
                        WHEN BdmDedCode IN ('TSAP2','TSAPK') THEN 'Parking'
                        WHEN BdmDedCode IN ('HSA','HSACI','HSACF','HSAI','HSAF') THEN 'Health Savings Account'
                        END
        ,drvContributionDate = PrgPayDate -- PgrPayDate
        ,drvContributionAmount = FORMAT(
                                    CASE WHEN BdmDedCode IN ('FSAMD') THEN PdhMedicalFSAAmt
                                    WHEN BdmDedCode IN ('FSADC') THEN PdhDepCareFSAAmt
                                    WHEN BdmDedCode IN ('FSAI','FSAI2') THEN PdhLimitedMedicalFSAAmt
                                    WHEN BdmDedCode IN ('TRAM1','TRAM2','TSAM2','TSAMT') THEN PdhMassTransitFSA
                                    WHEN BdmDedCode IN ('TSAP2','TSAPK') THEN PdhParkingAmt
                                    WHEN BdmDedCode IN ('HSA','HSACI','HSACF','HSAI','HSAF') THEN PdhHSAAmt
                                    END, '#0.00')
    INTO dbo.U_EWEXMULTXP_drvTbl
    FROM dbo.U_EWEXMULTXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EWEXMULTXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --JOIN dbo.PayGroup WITH (NOLOCK)
    --    ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_EWEXMULTXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.U_EWEXMULTXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;

    UPDATE dbo.U_EWEXMULTXP_drvTbl 
    SET drvContributionAmount = NULL
    WHERE CAST(drvContributionAmount AS FLOAT) <= 0;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------

    DECLARE @CurrentDate DATE, @CurrentTime VARCHAR(6);

    SELECT @CurrentDate = GETDATE();
    SELECT @CurrentTime = FORMAT(GETDATE(), 'HHmmss')

    IF OBJECT_ID('U_EWEXMULTXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXMULTXP_Header;
    SELECT DISTINCT
         drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EWEXMULTXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWEXMULTXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXMULTXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EWEXMULTXP_drvTbl)
        ,drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EWEXMULTXP_Trailer
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
ALTER VIEW dbo.dsi_vwEWEXMULTXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWEXMULTXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EWEXMULTXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202203251'
       ,expStartPerControl     = '202203251'
       ,expLastEndPerControl   = '202203299'
       ,expEndPerControl       = '202203299'
WHERE expFormatCode = 'EWEXMULTXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWEXMULTXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EWEXMULTXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWEXMULTXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWEXMULTXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWEXMULTXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWEXMULTXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWEXMULTXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWEXMULTXP', 'UseFileName', 'V', 'Y'


-- End ripout