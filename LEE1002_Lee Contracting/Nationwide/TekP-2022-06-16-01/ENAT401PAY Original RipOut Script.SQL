/**********************************************************************************

ENAT401PAY: NationWide 401k Conribution File

FormatCode:     ENAT401PAY
Project:        NationWide 401k Conribution File
Client ID:      LEE1002
Date/time:      2022-08-01 07:16:40.130
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPLEEC
Web Filename:   LEE1002_MV3A4_EEHISTORY_ENAT401PAY_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENAT401PAY_SavePath') IS NOT NULL DROP TABLE dbo.U_ENAT401PAY_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENAT401PAY'


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
WHERE FormatCode = 'ENAT401PAY'
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
WHERE ExpFormatCode = 'ENAT401PAY'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENAT401PAY')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENAT401PAY'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENAT401PAY'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENAT401PAY'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENAT401PAY'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENAT401PAY'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENAT401PAY'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENAT401PAY'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENAT401PAY'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENAT401PAY'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENAT401PAY_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENAT401PAY_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENAT401PAY') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAT401PAY];
GO
IF OBJECT_ID('U_ENAT401PAY_File') IS NOT NULL DROP TABLE [dbo].[U_ENAT401PAY_File];
GO
IF OBJECT_ID('U_ENAT401PAY_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENAT401PAY_EEList];
GO
IF OBJECT_ID('U_dsi_ENAT401PAY_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401PAY_trlTbl];
GO
IF OBJECT_ID('U_dsi_ENAT401PAY_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401PAY_hdrTbl];
GO
IF OBJECT_ID('U_dsi_ENAT401PAY_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401PAY_drvTbl];
GO
IF OBJECT_ID('U_dsi_ENAT401PAY_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401PAY_DedHist];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ENAT401PAY','NationWide 401k Conribution File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENAT401PAYZ0','N','Jul 28 2016  5:29PM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENAT401PAYZ0','25','H','01','1',NULL,'Transaction Identifier',NULL,NULL,'"drvTransID1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENAT401PAYZ0','25','H','01','2',NULL,'Line of Business',NULL,NULL,'"drvLineOfBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENAT401PAYZ0','25','H','01','3',NULL,'System Identifier',NULL,NULL,'"drvSysID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENAT401PAYZ0','25','H','01','4',NULL,'Filler',NULL,NULL,'"drvFiller"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENAT401PAYZ0','25','D','02','1',NULL,'Transaction Identifier',NULL,NULL,'"drvTransID2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENAT401PAYZ0','25','D','02','2',NULL,'Line of Business',NULL,NULL,'"drvLineOfBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENAT401PAYZ0','25','D','02','3',NULL,'Nationwide Case No',NULL,NULL,'"drvCaseNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENAT401PAYZ0','25','D','02','4',NULL,'Payroll End Date',NULL,NULL,'"drvPayrollEndDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENAT401PAYZ0','25','D','02','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENAT401PAYZ0','25','D','02','6',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENAT401PAYZ0','25','D','02','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENAT401PAYZ0','25','D','02','8',NULL,'Source Number',NULL,NULL,'"drvSourceNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENAT401PAYZ0','25','D','02','9',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENAT401PAYZ0','25','D','02','10',NULL,'Fund Symbol',NULL,NULL,'"drvFundSym"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENAT401PAYZ0','25','D','02','11',NULL,'Contribution Amount',NULL,NULL,'"drvConAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENAT401PAYZ0','25','D','02','12',NULL,'Loan Number',NULL,NULL,'"drvLoanNum"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENAT401PAYZ0','25','T','03','1',NULL,'Transaction Identifier',NULL,NULL,'"drvTransID3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENAT401PAYZ0','25','T','03','2',NULL,'Line of Business',NULL,NULL,'"drvLineOfBusiness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENAT401PAYZ0','25','T','03','3',NULL,'System Identifier',NULL,NULL,'"drvSysID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENAT401PAYZ0','25','T','03','4',NULL,'Transaction Count',NULL,NULL,'"drvTransCount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENAT401PAYZ0','25','T','03','5',NULL,'Filler',NULL,NULL,'"drvFiller"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENAT401PAY_20220801.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active OE file','201607291','EMPEXPORT','ACTIVEOE','Apr 16 2018 12:00AM','ENAT401PAY',NULL,NULL,NULL,'201607291','Jul 29 2016 12:00AM','Dec 30 1899 12:00AM','201607291',NULL,'','','201607291',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLEEC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','KZ21X',NULL,NULL,NULL,'NationWide Conribution File','201806019','EMPEXPORT','ENAT401PAY','Jun 13 2018  2:22PM','ENAT401PAY',NULL,NULL,NULL,'201806019','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','201806011','279','','','201806011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLEEC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive OE file','201607289','EMPEXPORT','PASSIVEOE','Apr 16 2018 12:00AM','ENAT401PAY',NULL,NULL,NULL,'201607289','Jul 28 2016 12:00AM','Dec 30 1899 12:00AM','201604291',NULL,'','','201604291',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLEEC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'NationWide Contribution - Test','201806081','EMPEXPORT','TEST','Jun 11 2018  1:52PM','ENAT401PAY',NULL,NULL,NULL,'201806081','Jun  8 2018 12:00AM','Jun  3 2018 12:00AM','201806081','285','','','201806081',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLEEC',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','ExportDescription','C','NationWide 401k Contribution');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','FileType','C','csv');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','MaxFileLength','C','313');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','SystemID','V','190F20A30DB6');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401PAY','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAT401PAY','H01','dbo.U_dsi_ENAT401PAY_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAT401PAY','D02','dbo.U_dsi_ENAT401PAY_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAT401PAY','T03','dbo.U_dsi_ENAT401PAY_trlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_ENAT401PAY_DedHist
-----------

IF OBJECT_ID('U_dsi_ENAT401PAY_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401PAY_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);

-----------
-- Create table U_dsi_ENAT401PAY_drvTbl
-----------

IF OBJECT_ID('U_dsi_ENAT401PAY_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401PAY_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransID2] varchar(4) NOT NULL,
    [drvLineOfBusiness] varchar(1) NOT NULL,
    [drvCaseNo] varchar(9) NOT NULL,
    [drvPayrollEndDate] varchar(8) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(6000) NULL,
    [drvNameFirst] varchar(6000) NULL,
    [drvSourceNo] varchar(2) NOT NULL,
    [drvTransCode] varchar(2) NOT NULL,
    [drvFundSym] varchar(1) NOT NULL,
    [drvConAmt] money NULL,
    [drvLoanNum] varchar(1) NOT NULL
);

-----------
-- Create table U_dsi_ENAT401PAY_hdrTbl
-----------

IF OBJECT_ID('U_dsi_ENAT401PAY_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401PAY_hdrTbl] (
    [drvTransID1] varchar(4) NOT NULL,
    [drvLineOfBusiness] varchar(1) NOT NULL,
    [drvSysID] varchar(10) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);

-----------
-- Create table U_dsi_ENAT401PAY_trlTbl
-----------

IF OBJECT_ID('U_dsi_ENAT401PAY_trlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401PAY_trlTbl] (
    [drvTransID3] varchar(4) NOT NULL,
    [drvLineOfBusiness] varchar(1) NOT NULL,
    [drvSysID] varchar(10) NOT NULL,
    [drvTransCount] int NULL,
    [drvFiller] money NULL
);

-----------
-- Create table U_ENAT401PAY_EEList
-----------

IF OBJECT_ID('U_ENAT401PAY_EEList') IS NULL
CREATE TABLE [dbo].[U_ENAT401PAY_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENAT401PAY_File
-----------

IF OBJECT_ID('U_ENAT401PAY_File') IS NULL
CREATE TABLE [dbo].[U_ENAT401PAY_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAT401PAY]  @systemid varchar(12) = '' AS Begin  /********************************************************************** Client Name: Lee Contracting, Inc. Vendor: Nationwide 401k Contribution File Created By: Garret Donovan Business Analyst: Justin Holy Create Date: 4/16/2018 Service Request Number: LEE1002-2018-00190100-Interface File  Changes: MM/DD/YYYY    NAME HERE     SF 09999999              Comments Here  _dsi_usp_ExportRipout 'ENAT401PAY','Y'   select * from dbo.U_dsi_Configuration where FormatCode = 'ENAT401PAY' ORDER BY LEN(CfgName) DESC select * from dbo.U_dsi_SQLClauses where FormatCode = 'ENAT401PAY' select * from dbo.U_dsi_Parameters where FormatCode = 'ENAT401PAY'  select * from AscDefH where AdhFormatCode = 'ENAT401PAY' select * from AscExp where expFormatCode = 'ENAT401PAY' select * from ascdeff where AdfHeaderSystemID = 'ENAT401PAYZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber   DSI_SP_TESTSWITCHBOX_V2 'ENAT401PAY', 'ENAT401PAY' DSI_SP_TESTSWITCHBOX_V2 'ENAT401PAY', 'TEST' DSI_SP_TESTSWITCHBOX_V2 'ENAT401PAY', 'ACTIVEOE' DSI_SP_TESTSWITCHBOX_V2 'ENAT401PAY', 'PASSIVEOE'  To turn off/on TESTEDT header record:  Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ENAT401PAY' AND CfgName = 'TESTING'  **************************/  -- Collect the @Start and @End Percontrol/PayDates upfront      /***************************     COLLECT DATE PARAMETERS     ****************************/     DECLARE         @StartDate DATETIME,         @EndDate DATETIME,         @StartPerControl Char(9),         @EndPerControl Char(9),         @FormatCode Char(10),         @ExportCode Char(10),         @ExportFile char(200)      --    Declare @Systemid char(12)     --    set @Systemid = '6DWPQL0000K0'      SELECT         @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),         @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),         @StartPerControl = startpercontrol,         @EndPerControl  = endpercontrol,         @FormatCode = rtrim(formatcode),         @ExportCode = Exportcode,         @Exportfile = ExportFile      FROM dbo.U_Dsi_Parameters     WHERE formatcode = 'ENAT401PAY'  -- dedcodes  declare @DedList varchar(200) select @DedList = 'x'    --no longer used  -- change variables below as needed declare @daysstopped int declare @useaudit char(1) declare @includeoe char(1)  declare @showalldeds char(1) declare @allcomp char(1) declare @onerecperemp char(1) declare @showstoppedoe  char(1) declare @oetype char(1) set @daysstopped = 14    -- set number of days if looking for only showing deds stopped within certain days set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe  -- clean up EELIST if needed  -- clean up list if not using all companies  if @allcomp = 'N' begin             delete dbo.u_ENAT401PAY_EELIST             from dbo.u_ENAT401PAY_EELIST             join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid             where t.eecemplstatus = 'T'             and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid                 and a.eecemplstatus <> 'T')  end  --401K - 401K Percentage --401CU - 401K Catch up Percentage --401ER - 401K ER Match --401L - 401K Loan  --PEN - Pension --SAFE - Safe Harbor  --BDM -- replace E401GWOE with the OE session if applicable  DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode  INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','401CP,401K,401KR') IF @ExportCode <> 'E401OE' BEGIN     INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)    --@EndDate - @daysstopped)     INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate) END IF @ExportCode = 'E401OE' BEGIN     INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)     INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate) END  INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')  IF @ExportCode = 'E401OE' BEGIN    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active') END  EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode  -- Step20 Clean up eelist if needed to only include employees with deductions             --delete dbo.u_ENAT401PAY_eelist             --from dbo.u_ENAT401PAY_eelist a             --where not exists(select 1 from U_dsi_bdm_EmpDeductions             --                where a.xeeid = eedeeid             --                and a.xcoid = eedcoid             --                and eedformatcode = @formatcode             --                and eedvalidforexport = 'Y')  -- Clean up eelist if only one record per employee if @onerecperemp = 'Y' begin             delete dbo.u_ENAT401PAY_EELIST             from dbo.u_ENAT401PAY_EELIST             join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid             where t.eecemplstatus = 'T'             and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid                 and a.eecemplstatus <> 'T')              delete dbo.u_ENAT401PAY_eelist             from dbo.u_ENAT401PAY_eelist a             join emppers with (nolock) on xeeid = eepeeid             where eephomecoid <> xcoid             and exists(select 1 from dbo.u_ENAT401PAY_eelist b where a.xeeid = b.xeeid             having count(*) > 1) end  --Clean up Terms from Deductions and EEList         --delete dbo.u_ENAT401PAY_eelist         --    from dbo.u_ENAT401PAY_eelist left join empcomp on xeeid = eeceeid and xcoid = eeccoid         --where eecDateofTermination is not null         --    and YEAR(eecDateOfTermination) <> YEAR(getdate())  -- not needed - 2/13/13 drn --        delete dbo.u_ENAT401PAY_eelist --            from dbo.u_ENAT401PAY_eelist --            left join empcomp on xeeid = eeceeid and xcoid = eeccoid --        where eecDateofTermination is not null --            and @daysstopped + eecDateofTermination < @enddate  -- Build deduction history  if object_id('U_dsi_ENAT401PAY_DedHist') is not null   drop table dbo.U_dsi_ENAT401PAY_DedHist  SELECT     xEEID heeid,     xCOID hcoid,     pdhdedcode hdedcode,     SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,     cast (0.00 as money) AS heramt     INTO dbo.U_dsi_ENAT401PAY_DedHist         from dbo.u_ENAT401PAY_EELIST     JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID         AND (PDHEECURAMT <> 0)         AND PDHDEDCODE IN ('401CP','401K','401KR')         AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl     GROUP BY xEEID,xCOID,PdhDedCode  ----ER Amts --insert into U_dsi_ENAT401PAY_DedHist --    SELECT --    xEEID heeid, --    xCOID hcoid, --    pdhdedcode hdedcode, --    cast(0 as money) AS heeamt, --    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt --        from dbo.u_ENAT401PAY_EELIST --    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID --        AND (PDHErCURAMT <> 0) --        AND PDHDEDCODE IN ('401CP','401P') --        AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl --    GROUP BY xEEID,xCOID,PdhDedCode  --select distinct heeid,hcoid from U_dsi_ENAT401PAY_DedHist - 31 --select * from dbo.u_ENAT401PAY_EELIST  -- Populate Source for Employees  if object_id('U_dsi_ENAT401PAY_drvTbl') is not null   drop table dbo.U_dsi_ENAT401PAY_drvTbl  -- EE Detail    select distinct     drvEEID            = xEEID     ,drvcoid        = xcoid     ,drvdepid        = cast(null as varchar)     ,drvrectype        = 'E' -- standard fields above and additional driver fields below     ,drvTransID2 = 'CTRB'     ,drvLineOfBusiness = '1'     ,drvCaseNo = '442-80187'     ,drvPayrollEndDate = CONVERT(VARCHAR(8),paydt,112)     ,drvSSN = eepSSN     ,drvNameLast = dbo.dsi_fnRemoveChars('.,/-',eepnamelast)     ,drvNameFirst = dbo.dsi_fnRemoveChars('.,/-',eepnamefirst)     ,drvSourceNo = CASE                                                 WHEN hdedcode IN ('401K') and ee <> 0 THEN '2'                         WHEN hdedcode IN ('401K') and er <> 0 THEN '3'                         WHEN hdedcode IN ('401CP') and ee <> 0 THEN '10'                         WHEN hdedcode IN ('401CP') and er <> 0 THEN '3'                         WHEN hdedcode IN ('401KR') THEN '21'                         ELSE ''                     END     ,drvTransCode = '11'     ,drvFundSym = ''     ,drvConAmt = CASE                      WHEN er <> 0 THEN er ELSE ee                    END     ,drvLoanNum = ''     --select * from dbo.U_dsi_ENAT401PAY_drvTbl   into dbo.U_dsi_ENAT401PAY_drvTbl   from dbo.u_ENAT401PAY_eelist with (nolock)     join empPers with (nolock) on xEEID = eepEEID     join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID     join company with (nolock) on eeccoid = cmpcoid     LEFT JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode                 AND EedValidForExport = 'Y'                 AND EedCOID = xCOID AND EedEEID = xEEID      left join (SELECT MAX(PgpPayDate) paydt--, MAX(PGPPERIODSTARTDATE) pdstdt,MAX(PGPPERIODENDDATE) pdenddt             FROM PgPayPer WHERE PgpPayDate <= @EndDate) per on 1=1      left join (select heeid eeid, hcoid coid, heeamt ee, heramt er,hdedcode         from U_dsi_ENAT401PAY_DedHist where hdedcode in ('401CP','401K','401KR')         --group by heeid, hcoid,hdedcode         ) K on K.eeid = xeeid and K.coid = xcoid     WHERE EE <> 0 OR ER <> 0  -- Create Headers     if object_id('U_dsi_ENAT401PAY_hdrTbl') is not null       drop table dbo.U_dsi_ENAT401PAY_hdrTbl        SELECT               drvTransID1 = 'HDR1'             ,drvLineOfBusiness = '1'             ,drvSysID = 'V-03.00.00'             ,drvFiller = '0'             INTO             dbo.U_dsi_ENAT401PAY_hdrTbl  -- Create Trailers if object_id('U_dsi_ENAT401PAY_trlTbl') is not null   drop table dbo.U_dsi_ENAT401PAY_trlTbl      SELECT         drvTransID3 = 'TRL1'         ,drvLineOfBusiness = '1'         ,drvSysID = 'V-03.00.00'         ,drvTransCount = C.reccnt +2         ,drvFiller = a.ConTot     INTO dbo.U_dsi_ENAT401PAY_trlTbl     FROM (SELECT COUNT(*) RecCnt FROM dbo.U_dsi_ENAT401PAY_drvTbl)C --dbo.U_dsi_ENAT401PAY_drvTbl         JOIN (SELECT SUM(ISNULL(drvConAmt,'0')) ConTot FROM dbo.U_dsi_ENAT401PAY_drvTbl) A ON 1=1  -- Set FileName if (dbo.dsi_fnVariable('ENAT401PAY','UseFileName') = 'N')   update dbo.U_dsi_Parameters     set ExportFile =  'PIINC_401K_' + convert(char(8),getdate(),112) + '.csv'     where FormatCode = 'ENAT401PAY'  -- Remember to alter view for correct sorting /*  ALTER  View dbo.dsi_vwENAT401PAY_Export as         select top 2000000 Data from dbo.U_ENAT401PAY_File with (nolock)          order by case when substring(Recordset,1,1) = 'D' then 1 else 2 end,             initialsort, subsort, substring(Recordset,2,2) */  --Used for testing --dbo.dsi_sp_TestSwitchbox_v2 'ENAT401PAY','ENAT401PAY' --dbo.dsi_sp_TestSwitchbox_v2 'ENAT401PAY','TEST'  END 
GO
Create View dbo.dsi_vwENAT401PAY_Export as                             select top 200000000 Data from dbo.U_ENAT401PAY_File with (nolock)                             order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENAT401PAY' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENAT401PAY'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENAT401PAY'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENAT401PAY', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENAT401PAY', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENAT401PAY', 'UseFileName', 'V', 'Y'


-- End ripout