/**********************************************************************************

EAKNEWEPXP: California New Employee Export

FormatCode:     EAKNEWEPXP
Project:        California New Employee Export
Client ID:      AMY1001
Date/time:      2023-01-20 12:44:19.330
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N31
Server:         N3SUP1DB02
Database:       ULTIPRO_AMYK
Web Filename:   AMY1001_FABAA_EEHISTORY_EAKNEWEPXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAKNEWEPXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EAKNEWEPXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAKNEWEPXP'


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
WHERE FormatCode = 'EAKNEWEPXP'
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
WHERE ExpFormatCode = 'EAKNEWEPXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAKNEWEPXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAKNEWEPXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAKNEWEPXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAKNEWEPXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAKNEWEPXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAKNEWEPXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAKNEWEPXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAKNEWEPXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAKNEWEPXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAKNEWEPXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAKNEWEPXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAKNEWEPXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAKNEWEPXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAKNEWEPXP];
GO
IF OBJECT_ID('U_EAKNEWEPXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_Trailer];
GO
IF OBJECT_ID('U_EAKNEWEPXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_Header];
GO
IF OBJECT_ID('U_EAKNEWEPXP_File') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_File];
GO
IF OBJECT_ID('U_EAKNEWEPXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_EEList];
GO
IF OBJECT_ID('U_EAKNEWEPXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_drvTbl];
GO
IF OBJECT_ID('U_EAKNEWEPXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_AuditFields];
GO
IF OBJECT_ID('U_EAKNEWEPXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAKNEWEPXP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAKNEWEPXP','California New Employee Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EAKNEWEPXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAKNEWEPXPZ0','2','H','01','1',NULL,'Record Identifier',NULL,NULL,'"E4"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAKNEWEPXPZ0','9','H','01','2',NULL,'Federal Employer Identification Number (FEIN)',NULL,NULL,'"drvFEIN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAKNEWEPXPZ0','16','H','01','3',NULL,'State Employer Account Number',NULL,NULL,'"drvStateEmployerAcctNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAKNEWEPXPZ0','1','H','01','4',NULL,'Branch Code',NULL,NULL,'"drvBranchCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAKNEWEPXPZ0','30','H','01','5',NULL,'Employer Name',NULL,NULL,'"drvEmployerName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAKNEWEPXPZ0','40','H','01','6',NULL,'Street Address',NULL,NULL,'"drvStreetAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAKNEWEPXPZ0','25','H','01','7',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAKNEWEPXPZ0','2','H','01','8',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAKNEWEPXPZ0','5','H','01','9',NULL,'ZIP Code/Foreign Postal Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAKNEWEPXPZ0','4','H','01','10',NULL,'ZIP Code Extension',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAKNEWEPXPZ0','33','H','01','11',NULL,'Blank',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAKNEWEPXPZ0','2','D','10','1',NULL,'Record Identifier',NULL,NULL,'"W4"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAKNEWEPXPZ0','9','D','10','2',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAKNEWEPXPZ0','16','D','10','3',NULL,'Employee First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAKNEWEPXPZ0','1','D','10','4',NULL,'Employee Middle Initial',NULL,NULL,'"drvNameMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAKNEWEPXPZ0','30','D','10','5',NULL,'Employee Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAKNEWEPXPZ0','40','D','10','6',NULL,'Street Address',NULL,NULL,'"drvStreetAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAKNEWEPXPZ0','25','D','10','7',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAKNEWEPXPZ0','2','D','10','8',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAKNEWEPXPZ0','5','D','10','9',NULL,'ZIP Code/ Foreign Postal Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAKNEWEPXPZ0','4','D','10','10',NULL,'ZIP Code Extension',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAKNEWEPXPZ0','8','D','10','11',NULL,'Employee Start-of-Work Date',NULL,NULL,'"drvEmpStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAKNEWEPXPZ0','33','D','10','12',NULL,'Blank',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAKNEWEPXPZ0','2','T','90','1',NULL,'Record Identifier',NULL,NULL,'"T4"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAKNEWEPXPZ0','11','T','90','2',NULL,'Number of Employees Reported',NULL,NULL,'"drvNumberOfEmployeesReported"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAKNEWEPXPZ0','162','T','90','3',NULL,'Blank',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAKNEWEPXP_20230120.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'California New Employee Export','202301039','EMPEXPORT','ONDEM_XOE',NULL,'EAKNEWEPXP',NULL,NULL,NULL,'202301039','Jan  3 2023 12:00PM','Jan  3 2023 12:00PM','202301031',NULL,'','','202301031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'California New Employee -Sched','202301039','EMPEXPORT','SCH_EAKNEW',NULL,'EAKNEWEPXP',NULL,NULL,NULL,'202301039','Jan  3 2023 12:00PM','Jan  3 2023 12:00PM','202301031',NULL,'','','202301031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','RXHL3,RXHFX',NULL,NULL,NULL,'California New Employee -Test','202301069','EMPEXPORT','TEST_XOE','Jan 20 2023 12:00AM','EAKNEWEPXP',NULL,NULL,NULL,'202301069','Jan  6 2023 12:00AM','Dec 30 1899 12:00AM','202212301',NULL,'',NULL,'202212301',dbo.fn_GetTimedKey(),NULL,'us3mWaAMY1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAKNEWEPXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAKNEWEPXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAKNEWEPXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAKNEWEPXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAKNEWEPXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAKNEWEPXP','H01','dbo.U_EAKNEWEPXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAKNEWEPXP','D10','dbo.U_EAKNEWEPXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAKNEWEPXP','T90','dbo.U_EAKNEWEPXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EAKNEWEPXP_Audit
-----------

IF OBJECT_ID('U_EAKNEWEPXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_Audit] (
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
-- Create table U_EAKNEWEPXP_AuditFields
-----------

IF OBJECT_ID('U_EAKNEWEPXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAKNEWEPXP_drvTbl
-----------

IF OBJECT_ID('U_EAKNEWEPXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInitial] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvStreetAddress] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvEmpStartDate] char(8) NULL
);

-----------
-- Create table U_EAKNEWEPXP_EEList
-----------

IF OBJECT_ID('U_EAKNEWEPXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAKNEWEPXP_File
-----------

IF OBJECT_ID('U_EAKNEWEPXP_File') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EAKNEWEPXP_Header
-----------

IF OBJECT_ID('U_EAKNEWEPXP_Header') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_Header] (
    [drvFEIN] varchar(9) NULL,
    [drvStateEmployerAcctNumber] varchar(8) NULL,
    [drvBranchCode] varchar(1) NOT NULL,
    [drvEmployerName] varchar(40) NULL,
    [drvStreetAddress] varchar(30) NULL,
    [drvCity] varchar(30) NULL,
    [drvState] varchar(2) NULL,
    [drvZipCode] varchar(5) NULL
);

-----------
-- Create table U_EAKNEWEPXP_Trailer
-----------

IF OBJECT_ID('U_EAKNEWEPXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EAKNEWEPXP_Trailer] (
    [drvNumberOfEmployeesReported] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAKNEWEPXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Amy's Kitchen

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/03/2023
Service Request Number: TekP-2022-11-15-01

Purpose: California New Employee Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAKNEWEPXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAKNEWEPXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAKNEWEPXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAKNEWEPXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAKNEWEPXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAKNEWEPXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAKNEWEPXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAKNEWEPXP', 'SCH_EAKNEW';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAKNEWEPXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAKNEWEPXP';

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
    DELETE FROM dbo.U_EAKNEWEPXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAKNEWEPXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAKNEWEPXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAKNEWEPXP_AuditFields;
    CREATE TABLE dbo.U_EAKNEWEPXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

      INSERT INTO dbo.U_EAKNEWEPXP_AuditFields VALUES ('EmpComp','EecDateofTermination');
      INSERT INTO dbo.U_EAKNEWEPXP_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAKNEWEPXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAKNEWEPXP_Audit;
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
    INTO dbo.U_EAKNEWEPXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAKNEWEPXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(d, -20 ,@StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EAKNEWEPXP_Audit ON dbo.U_EAKNEWEPXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EAKNEWEPXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EAKNEWEPXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAKNEWEPXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAKNEWEPXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAKNEWEPXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameFirst = UPPER(EepNameFirst)
        ,drvNameMiddleInitial = UPPER(LEFT(EepNameMiddle,1))
        ,drvNameLast = UPPER(EepNameLast)
        ,drvStreetAddress = EepAddressLine1
        ,drvCity = UPPER(EepAddressCity)
        ,drvState = UPPER(EepAddressState)
        ,drvZipCode = UPPER(Left(EepAddressZipCode,5))
        ,drvEmpStartDate =  Convert(CHAR(8),CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire ELSE EecDateOfOriginalHire  END , 112)
    INTO dbo.U_EAKNEWEPXP_drvTbl
    FROM dbo.U_EAKNEWEPXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     Left Join dbo.U_EAKNEWEPXP_Audit
        ON audeeid = xeeid
        and audKey2 = xcoid
     WHERE audNewHire = 'Y' --- (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime BETWEEN  @StartDate  AND @EndDate  ))
         AND EecEEType <> 'TES'
         AND xCoID IN  ('RXHL3', 'RXHFX')
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EAKNEWEPXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EAKNEWEPXP_Header;
    SELECT DISTINCT
         drvFEIN = CASE WHEN  cmpcoid = 'RXHL3' THEN '465460581' 
                        WHEn  cmpcoid = 'RXHFX' THEN '680154899'
                        END
        ,drvStateEmployerAcctNumber = CASE WHEN cmpcoid = 'RXHFX' THEN '35254895' --  1/6/2023 MW Removed dashes
                                           WHEN cmpcoid = 'RXHL3' THEN '04590428' --  1/6/2023 MW Removed dashes
                                         END
        ,drvBranchCode = ''
        ,drvEmployerName = UPPER(CmpCompanyName)
        ,drvStreetAddress = UPPER(cmpAddressLine1)
        ,drvCity = UPPER(cmpAddressCity)
        ,drvState = UPPER(cmpAddressState)
        ,drvZipCode = UPPER(Left(cmpAddressZipCode,5))
    INTO dbo.U_EAKNEWEPXP_Header
    FROM dbo.U_EAKNEWEPXP_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EAKNEWEPXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EAKNEWEPXP_Trailer;
    SELECT DISTINCT
         drvNumberOfEmployeesReported = (Select COUNT(DISTINCT drvSSN) FROM dbo.U_EAKNEWEPXP_drvTbl WITH (NOLOCK))
    INTO dbo.U_EAKNEWEPXP_Trailer
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
ALTER VIEW dbo.dsi_vwEAKNEWEPXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAKNEWEPXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAKNEWEPXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202212271'
       ,expStartPerControl     = '202212271'
       ,expLastEndPerControl   = '202301039'
       ,expEndPerControl       = '202301039'
WHERE expFormatCode = 'EAKNEWEPXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAKNEWEPXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAKNEWEPXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAKNEWEPXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAKNEWEPXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAKNEWEPXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAKNEWEPXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAKNEWEPXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAKNEWEPXP', 'UseFileName', 'V', 'Y'


-- End ripout