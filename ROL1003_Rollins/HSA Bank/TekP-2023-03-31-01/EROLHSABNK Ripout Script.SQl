/**********************************************************************************

EROLHSABNK: HSA Bank HSA Contributions

FormatCode:     EROLHSABNK
Project:        HSA Bank HSA Contributions
Client ID:      ROL1002
Date/time:      2023-04-28 11:14:14.557
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
Web Filename:   ROL1002_C9MXB_EEHISTORY_EROLHSABNK_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EROLHSABNK_SavePath') IS NOT NULL DROP TABLE dbo.U_EROLHSABNK_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EROLHSABNK'


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
WHERE FormatCode = 'EROLHSABNK'
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
WHERE ExpFormatCode = 'EROLHSABNK'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EROLHSABNK')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EROLHSABNK'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EROLHSABNK'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EROLHSABNK'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EROLHSABNK'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EROLHSABNK'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EROLHSABNK'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EROLHSABNK'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EROLHSABNK'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EROLHSABNK'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEROLHSABNK_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEROLHSABNK_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EROLHSABNK') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLHSABNK];
GO
IF OBJECT_ID('U_EROLHSABNK_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EROLHSABNK_PDedHist];
GO
IF OBJECT_ID('U_EROLHSABNK_Header') IS NOT NULL DROP TABLE [dbo].[U_EROLHSABNK_Header];
GO
IF OBJECT_ID('U_EROLHSABNK_File') IS NOT NULL DROP TABLE [dbo].[U_EROLHSABNK_File];
GO
IF OBJECT_ID('U_EROLHSABNK_EEList') IS NOT NULL DROP TABLE [dbo].[U_EROLHSABNK_EEList];
GO
IF OBJECT_ID('U_EROLHSABNK_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EROLHSABNK_drvTbl];
GO
IF OBJECT_ID('U_EROLHSABNK_DedList') IS NOT NULL DROP TABLE [dbo].[U_EROLHSABNK_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EROLHSABNK','HSA Bank HSA Contributions','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EROLHSABNKZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLHSABNKZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"HR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLHSABNKZ0','50','H','01','2',NULL,'Client Batch Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLHSABNKZ0','50','H','01','3',NULL,'Client Identifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLHSABNKZ0','50','H','01','4',NULL,'Primary Contact Email Address',NULL,NULL,'"rollinsbenefits@rollins.com"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLHSABNKZ0','50','H','01','5',NULL,'Notifications Email Address',NULL,NULL,'"rollinsbenefits@rollins.com"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLHSABNKZ0','50','H','01','6',NULL,'Date',NULL,NULL,'"drvRunDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLHSABNKZ0','50','H','01','7',NULL,'Number of Transactions',NULL,NULL,'"drvNumofTransactions"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EROLHSABNKZ0','50','H','01','8',NULL,'Total Transaction Amount',NULL,NULL,'"drvTotalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EROLHSABNKZ0','50','H','01','9',NULL,'File Version',NULL,NULL,'"2.0"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLHSABNKZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"TR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLHSABNKZ0','50','D','10','2',NULL,'Employer Identifier Type',NULL,NULL,'"FID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLHSABNKZ0','50','D','10','3',NULL,'Employer Identifier',NULL,NULL,'"510068479"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLHSABNKZ0','50','D','10','4',NULL,'Clearing Account',NULL,NULL,'"200208"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLHSABNKZ0','50','D','10','5',NULL,'Transaction Date',NULL,NULL,'"drvTransactionDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLHSABNKZ0','50','D','10','6',NULL,'Amount Type',NULL,NULL,'"Actual"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLHSABNKZ0','50','D','10','7',NULL,'Plan Year Name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EROLHSABNKZ0','50','D','10','8',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EROLHSABNKZ0','50','D','10','9',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EROLHSABNKZ0','50','D','10','10',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EROLHSABNKZ0','50','D','10','11',NULL,'Employee Account identifier Type',NULL,NULL,'"S"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EROLHSABNKZ0','50','D','10','12',NULL,'Employee Account Identifier Value',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EROLHSABNKZ0','50','D','10','13',NULL,'Transaction Amount',NULL,NULL,'"drvTransactionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EROLHSABNKZ0','50','D','10','14',NULL,'Product Type',NULL,NULL,'"drvProductType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EROLHSABNKZ0','50','D','10','15',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EROLHSABNKZ0','50','D','10','16',NULL,'Consumer Notes',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EROLHSABNKZ0','50','D','10','17',NULL,'Tax Year',NULL,NULL,'"drvTaxYear"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EROLHSABNKZ0','50','D','10','18',NULL,'Trace Identifier',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EROLHSABNK_20230428.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'HSA Bank HSA Contributions','202304289','EMPEXPORT','ONDEM_XOE',NULL,'EROLHSABNK',NULL,NULL,NULL,'202304289','Apr 28 2023  7:06AM','Apr 28 2023  7:06AM','202304281',NULL,'','','202304281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HSA Bank HSA Contributio-Sched','202304289','EMPEXPORT','SCH_EROLHS',NULL,'EROLHSABNK',NULL,NULL,NULL,'202304289','Apr 28 2023  7:06AM','Apr 28 2023  7:06AM','202304281',NULL,'','','202304281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'HSA Bank HSA Contributio-Test','202304289','EMPEXPORT','TEST_XOE',NULL,'EROLHSABNK',NULL,NULL,NULL,'202304289','Apr 28 2023  7:06AM','Apr 28 2023  7:06AM','202304281',NULL,'','','202304281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLHSABNK','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLHSABNK','H01','dbo.U_EROLHSABNK_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLHSABNK','D10','dbo.U_EROLHSABNK_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EROLHSABNK_DedList
-----------

IF OBJECT_ID('U_EROLHSABNK_DedList') IS NULL
CREATE TABLE [dbo].[U_EROLHSABNK_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EROLHSABNK_drvTbl
-----------

IF OBJECT_ID('U_EROLHSABNK_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EROLHSABNK_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransactionDate] varchar(10) NULL,
    [drvPlanName] varchar(29) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvTransactionAmount] nvarchar(4000) NULL,
    [drvProductType] varchar(3) NULL,
    [drvTransactionType] varchar(3) NOT NULL,
    [drvTaxYear] int NULL
);

-----------
-- Create table U_EROLHSABNK_EEList
-----------

IF OBJECT_ID('U_EROLHSABNK_EEList') IS NULL
CREATE TABLE [dbo].[U_EROLHSABNK_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EROLHSABNK_File
-----------

IF OBJECT_ID('U_EROLHSABNK_File') IS NULL
CREATE TABLE [dbo].[U_EROLHSABNK_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EROLHSABNK_Header
-----------

IF OBJECT_ID('U_EROLHSABNK_Header') IS NULL
CREATE TABLE [dbo].[U_EROLHSABNK_Header] (
    [drvRunDate] varchar(10) NULL,
    [drvNumofTransactions] int NULL,
    [drvTotalAmount] nvarchar(4000) NULL
);

-----------
-- Create table U_EROLHSABNK_PDedHist
-----------

IF OBJECT_ID('U_EROLHSABNK_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EROLHSABNK_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhPayDate] varchar(10) NULL,
    [PdhCOM] numeric NULL,
    [PdhFSADP] numeric NULL,
    [PdhFSAMD] numeric NULL,
    [PdhHSA] money NULL,
    [PdhHSAER] money NULL,
    [PdhCURAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLHSABNK]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 04/28/2023
Service Request Number: TekP-2023-03-31-01 

Purpose: HSA Bank HSA Contributions

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EROLHSABNK';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EROLHSABNK';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EROLHSABNK';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EROLHSABNK';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EROLHSABNK' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLHSABNK', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLHSABNK', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLHSABNK', 'SCH_EROLHS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EROLHSABNK', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(10);

    -- Set FormatCode
    SELECT @FormatCode = 'EROLHSABNK';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate        = CONVERT(VARCHAR(10),GETDATE(),126)
      
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    ----==========================================
    ---- Clean EE List 
    ---- Caution: Careful of cleaning EE List if including paycheck data
    ----==========================================

    ---- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    --DELETE FROM dbo.U_EROLHSABNK_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EROLHSABNK_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    ----==========================================
    ---- Audit Section
    ----==========================================
    ---- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EROLHSABNK_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EROLHSABNK_AuditFields;
    --CREATE TABLE dbo.U_EROLHSABNK_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EROLHSABNK_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EROLHSABNK_Audit;
    --SELECT 
    --     audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --INTO dbo.U_EROLHSABNK_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    --JOIN dbo.U_EROLHSABNK_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE';

    -- Create Index
    --CREATE CLUSTERED INDEX CDX_U_EROLHSABNK_Audit ON dbo.U_EROLHSABNK_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EROLHSABNK_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EROLHSABNK_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA,HSAER,FSAMD,FSADP,COM';

    IF OBJECT_ID('U_EROLHSABNK_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EROLHSABNK_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EROLHSABNK_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EROLHSABNK_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EROLHSABNK_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhDedCode
        ,PdhPayDate = CONVERT(VARCHAR(10),MAX(PdhPayDate),126)
        ---- Current Payroll Amounts
        --,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ---- YTD Payroll Amounts
        --,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        --,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhCOM       = SUM(CASE WHEN PdhDedCode IN ('COM') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSADP     = SUM(CASE WHEN PdhDedCode IN ('FSADP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSAMD     = SUM(CASE WHEN PdhDedCode IN ('FSAMD') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhHSA       = SUM(CASE WHEN PdhDedCode IN ('HSA') and PdhEECurAmt > 0 THEN PdhEECurAmt  END)
        ,PdhHSAER     = SUM(CASE WHEN PdhDedCode IN ('HSAER') and ISNULL(PdhERCurAmt, 0.00) > 0.00 THEN PdhERCurAmt ELSE 
                            CASE WHEN PdhDedCode IN ('HSAER') and ISNULL(PdhEECurAmt, 0.00) > 0.00  THEN  PdhEECurAmt END END)
        ,PdhCURAmt    = SUM(CASE WHEN PdhDedCode IN ('COM','FSADP','FSAMD','HSA') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
      
    INTO dbo.U_EROLHSABNK_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EROLHSABNK_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID,PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );
    

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EROLHSABNK_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EROLHSABNK_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EROLHSABNK_drvTbl;
    SELECT DISTINCT
         drvEEID = Pdheeid
        ,drvCoID = PdhCoid
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransactionDate = CONVERT(VARCHAR(10),PdhPayDate,126)
        ,drvPlanName =  CASE WHEN  PdhDedcode = 'COM' and ISNULL(PdhCOM, 0) <> 0  THEN 'Commuter Benefit Mass Transit'
                             WHEN  PdhDedcode = 'FSADP' and ISNULL(PdhFSADP, 0) <> 0  THEN  'Dependent Care'
                             WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD, 0) <> 0  THEN 'Medical FSA'
                             WHEN  PdhDedcode = 'HSA' and ISNULL(PdhHSA, 0) > 0   THEN 'Health Savings Account'
                             WHEn  PdhDedcode = 'HSAER' and ISNULL(PdhHSAER, 0) > 0 THEN 'Health Savings Account'
                            END

        ,drvLastName = REPLACE(EepNameLast,',','')
        ,drvFirstName = REPLACE(EepNameFirst,',','')
        ,drvSSN = eepSSN
    
        ,drvTransactionAmount = CASE WHEN PdhDedcode = 'COM' and ISNULL(PdhCOM, 0.00) > 0.00  THEN FORMAT(PdhCOM, '0.00')
                                     WHEN  PdhDedcode = 'COM' and ISNULL(PdhCOM, 0.00) < 0.00  THEN '-'+ FORMAT(PdhCOM, '0.00')
                                     WHEN  PdhDedcode = 'FSADP' and ISNULL(PdhFSADP ,0.00) > 0.00  THEN  FORMAT(PdhFSADP, '0.00')
                                     WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD,  0.00) < 0.00  THEN '-' + FORMAT(PdhFSAMD,'0.00')  
                                     WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD,  0.00) > 0.00  THEN FORMAT(PdhFSAMD, '0.00')  
                                     WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD,  0.00) < 0.00  THEN '-' + FORMAT(PdhFSAMD, '0.00') 
                                     WHEN  PdhDedcode = 'HSA' and ISNULL(PdhHSA,   0.00) > 0.00 THEN FORMAT(PdhHSA, '0.00')
                                     WHEN  PdhDedcode = 'HSAER' and ISNULL(PdhHSAER, 0.00) > 0.00 THEN FORMAT(PdhHSAER,'0.00')
                                    END
        ,drvProductType =  CASE WHEN ( ISNULL(PdhCOM,  0.00) <> 0.00 or ISNULL(PdhFSADP,  0.00) <> 0.00 or ISNULL(PdhFSAMD,  0.00) <> 0.00 ) THEN 'FSA'
                                WHEN (PdhDedcode = 'HSAER' or PdhDedcode = 'HSA') and ISNULL(PdhHSA, 0.00) > 0.00 or ISNULL(PdhHSAER, 0.00) > 0.00 THEN 'HSA'
                            END
        ,drvTransactionType = CASE WHEN PdhDedcode = 'HSAER' THEN 'ERC' Else ' PD' END
        ,drvTaxYear = Year(CONVERT(VARCHAR(10),GETDATE(),126))
    INTO dbo.U_EROLHSABNK_drvTbl
    FROM dbo.U_EROLHSABNK_PDedHist  WITH (NOLOCK)       ---dbo.U_EROLHSABNK_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
        where  CASE WHEN PdhDedcode = 'COM' and ISNULL(PdhCOM, 0.00) > 0.00  THEN FORMAT(PdhCOM, '0.00')
                                     WHEN  PdhDedcode = 'COM' and ISNULL(PdhCOM, 0.00) < 0.00  THEN '-'+ FORMAT(PdhCOM, '0.00')
                                     WHEN  PdhDedcode = 'FSADP' and ISNULL(PdhFSADP ,0.00) > 0.00  THEN  FORMAT(PdhFSADP, '0.00')
                                     WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD,  0.00) < 0.00  THEN '-' + FORMAT(PdhFSAMD,'0.00')  
                                     WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD,  0.00) > 0.00  THEN FORMAT(PdhFSAMD, '0.00')  
                                     WHEN  PdhDedcode = 'FSAMD' and ISNULL(PdhFSAMD,  0.00) < 0.00  THEN '-' + FORMAT(PdhFSAMD, '0.00') 
                                     WHEN  PdhDedcode = 'HSA' and ISNULL(PdhHSA,   0.00) > 0.00 THEN FORMAT(PdhHSA, '0.00')
                                     WHEN  PdhDedcode = 'HSAER' and ISNULL(PdhHSAER, 0.00) > 0.00 THEN FORMAT(PdhHSAER,'0.00')
                                    END IS not null
    
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EROLHSABNK_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EROLHSABNK_Header;
    SELECT DISTINCT
         drvRunDate = @RunDate
        ,drvNumofTransactions = (Select Count(*) from dbo.U_EROLHSABNK_drvTbl)
        ,drvTotalAmount = ( Select Format(sum( convert(decimal(10, 2), drvtransactionamount )), '0.00') from dbo.U_EROLHSABNK_drvTbl)
    INTO dbo.U_EROLHSABNK_Header
   
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
ALTER VIEW dbo.dsi_vwEROLHSABNK_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EROLHSABNK_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EROLHSABNK%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304281'
       ,expStartPerControl     = '20230421'
       ,expLastEndPerControl   = '202304289'
       ,expEndPerControl       = '202304289'
WHERE expFormatCode = 'EROLHSABNK';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEROLHSABNK_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EROLHSABNK_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EROLHSABNK' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EROLHSABNK'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EROLHSABNK'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLHSABNK', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EROLHSABNK', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLHSABNK', 'UseFileName', 'V', 'Y'


-- End ripout