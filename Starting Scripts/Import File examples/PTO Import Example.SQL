/**********************************************************************************

IUTAPTO: UTA PTO Import

FormatCode:     IUTAPTO
Project:        UTA PTO Import
Client ID:      ALA5000
Date/time:      2023-09-13 11:45:14.597
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    TZ12
Server:         TZ1SUP2DB02
Database:       ULTIPRO_ALAG
Web Filename:   ALA5000_OBWQ9_EEHISTORY_IUTAPTO_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\ca.saas\tz\Public\ALA5000\Imports_Test\UTAPTO\Archive\
ExportPath:    
ImportPath:    \\ca.saas\tz\Public\ALA5000\Imports_Test\UTAPTO\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_IUTAPTO_SavePath') IS NOT NULL DROP TABLE dbo.U_IUTAPTO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'IUTAPTO'


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
WHERE FormatCode = 'IUTAPTO'
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
WHERE ExpFormatCode = 'IUTAPTO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'IUTAPTO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'IUTAPTO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'IUTAPTO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'IUTAPTO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'IUTAPTO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'IUTAPTO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'IUTAPTO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'IUTAPTO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'IUTAPTO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'IUTAPTO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwIUTAPTO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwIUTAPTO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_IUTAPTO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IUTAPTO];
GO
IF OBJECT_ID('U_IUTAPTO_Raw') IS NOT NULL DROP TABLE [dbo].[U_IUTAPTO_Raw];
GO
IF OBJECT_ID('U_IUTAPTO_Import') IS NOT NULL DROP TABLE [dbo].[U_IUTAPTO_Import];
GO
IF OBJECT_ID('U_IUTAPTO_File') IS NOT NULL DROP TABLE [dbo].[U_IUTAPTO_File];
GO
IF OBJECT_ID('U_IUTAPTO_EEList') IS NOT NULL DROP TABLE [dbo].[U_IUTAPTO_EEList];
GO
IF OBJECT_ID('U_IUTAPTO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_IUTAPTO_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','IUTAPTO','UTA PTO Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','IUTAPTO000Z0','N',NULL,'C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IUTAPTO000Z0','50','H','01','1',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IUTAPTO000Z0','50','H','01','2',NULL,'Balance Name',NULL,NULL,'"Balance Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IUTAPTO000Z0','50','H','01','3',NULL,'Accrual Code',NULL,NULL,'"Accrual Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IUTAPTO000Z0','50','H','01','4',NULL,'Accrual Option',NULL,NULL,'"Accrual Option"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IUTAPTO000Z0','50','H','01','5',NULL,'Allowed Balance',NULL,NULL,'"Allowed Balance"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IUTAPTO000Z0','50','H','01','7',NULL,'Date Accrued Through',NULL,NULL,'"Date Accrued Through"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IUTAPTO000Z0','50','H','01','8',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IUTAPTO000Z0','50','H','01','9',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IUTAPTO000Z0','50','D','10','1',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IUTAPTO000Z0','50','D','10','2',NULL,'Company Code',NULL,NULL,'"drvBalanceName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IUTAPTO000Z0','50','D','10','3',NULL,'Accrual Code',NULL,NULL,'"drvAccrualCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IUTAPTO000Z0','50','D','10','4',NULL,'Accrual Option',NULL,NULL,'"drvAccrualOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IUTAPTO000Z0','50','D','10','5',NULL,'Allowed Balance',NULL,NULL,'"drvAllowedBalance"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IUTAPTO000Z0','50','D','10','7',NULL,'Date Accrued Through',NULL,NULL,'"drvDateAccruedThrough"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IUTAPTO000Z0','50','D','10','8',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IUTAPTO000Z0','250','D','10','9',NULL,'Error Message',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'IUTAPTO_20230913.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',NMZYE',NULL,NULL,NULL,'IG UTA PTO Import','202011039','EMPEXPORT','IGIMPORT','Jun  1 2018  5:02PM','IUTAPTO',NULL,NULL,NULL,'202102089','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202102011',NULL,'','','202011031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IG Automated Scheduled Session','202011039','EMPEXPORT','IGSCH_IUTA','Jun  1 2018 12:00AM','IUTAPTO',NULL,NULL,NULL,'202011039','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202011031',NULL,'','','202011031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'IG Report Only (Do Not Update)','202011039','EMPEXPORT','IGTEST','Jun  1 2018 12:00AM','IUTAPTO',NULL,NULL,NULL,'202011039','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202011031',NULL,'','','202011031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',NN00X',NULL,NULL,NULL,'YD UTA PTO Import','202011039','EMPEXPORT','YDIMPORT','Jun  1 2018  5:02PM','IUTAPTO',NULL,NULL,NULL,'202011039','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202011031',NULL,'','','202011031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YD Automated Scheduled Session','202011039','EMPEXPORT','YDSCH_UTA','Jun  1 2018 12:00AM','IUTAPTO',NULL,NULL,NULL,'202011039','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202011031',NULL,'','','202011031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'YD Report Only (Do Not Update)','202011039','EMPEXPORT','YDTEST','Jun  1 2018 12:00AM','IUTAPTO',NULL,NULL,NULL,'202011039','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202011031',NULL,'','','202011031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','ArchivePath','V','\\ca.saas\tz\Public\ALA5000\Imports_Test\UTAPTO\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','ImportPath','V','\\ca.saas\tz\Public\ALA5000\Imports_Test\UTAPTO\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IUTAPTO','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IUTAPTO','D10','U_IUTAPTO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_IUTAPTO_drvTbl
-----------

IF OBJECT_ID('U_IUTAPTO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_IUTAPTO_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvEmployeeNumber] varchar(50) NULL,
    [drvBalanceName] varchar(50) NULL,
    [drvAccrualCode] varchar(50) NULL,
    [drvAccrualOption] varchar(50) NULL,
    [drvAllowedBalance] varchar(50) NULL,
    [drvDateAccruedThrough] varchar(50) NULL,
    [drvAction] varchar(50) NULL,
    [drvError] varchar(250) NULL,
    [drvImported] tinyint NOT NULL DEFAULT ((0)),
    [drvEEID] varchar(12) NULL,
    [drvCOID] varchar(5) NULL,
    [drvInitialSort] varchar(50) NULL
);

-----------
-- Create table U_IUTAPTO_EEList
-----------

IF OBJECT_ID('U_IUTAPTO_EEList') IS NULL
CREATE TABLE [dbo].[U_IUTAPTO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_IUTAPTO_File
-----------

IF OBJECT_ID('U_IUTAPTO_File') IS NULL
CREATE TABLE [dbo].[U_IUTAPTO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_IUTAPTO_Import
-----------

IF OBJECT_ID('U_IUTAPTO_Import') IS NULL
CREATE TABLE [dbo].[U_IUTAPTO_Import] (
    [RowNo] int NOT NULL,
    [FileName] varchar(max) NULL,
    [EEID] char(12) NULL,
    [COID] char(5) NULL,
    [RunID] varchar(50) NULL,
    [Error] varchar(250) NULL,
    [PayPeriodStartDate] datetime NULL,
    [PayPeriodEndDate] datetime NULL,
    [PriorPayPeriodStartDate] datetime NULL,
    [PriorPayPeriodEndDate] datetime NULL,
    [NextPayPeriodStartDate] datetime NULL,
    [NextPayPeriodEndDate] datetime NULL,
    [CompanyCode] varchar(100) NULL,
    [EmployeeNo] varchar(10) NULL,
    [EmployeeName] varchar(250) NULL,
    [Field1] varchar(max) NULL,
    [Field2] varchar(max) NULL,
    [Field3] varchar(max) NULL,
    [Field4] varchar(max) NULL,
    [Field5] varchar(max) NULL,
    [Field6] varchar(max) NULL,
    [Field7] varchar(max) NULL,
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_IUTAPTO_Raw
-----------

IF OBJECT_ID('U_IUTAPTO_Raw') IS NULL
CREATE TABLE [dbo].[U_IUTAPTO_Raw] (
    [Field1] varchar(max) NULL,
    [Field2] varchar(max) NULL,
    [Field3] varchar(max) NULL,
    [Field4] varchar(max) NULL,
    [Field5] varchar(max) NULL,
    [Field6] varchar(max) NULL,
    [Field7] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IUTAPTO]
     @SystemID  VARCHAR(15) = NULL
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Alamos Gold Inc

Created By: Rebecca Lodge
Business Analyst: Gail Yates
Create Date: 11/03/2020
Service Request Number: SR-2020-00265841

Purpose: UTA PTO Import

Revision History
----------------
Update By        Date            Request Num        Desc
XXX              XX/XX/20XX      SR-20XX-00000000   XXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'IUTAPTO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'IUTAPTO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'IUTAPTO';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'IUTAPTO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IUTAPTO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IUTAPTO', 'IMPORT';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IUTAPTO', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IUTAPTO', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v6 @FormatCode = 'IUTAPTO', @AllObjects = 'Y', @isweb='Y'
**********************************************************************************/
BEGIN

    --==================================================
    -- Declare Variables
    --==================================================
    DECLARE    @srcPath VARCHAR(200),
               @ImportPath VARCHAR(100),
               @FileName VARCHAR(100),
               @ExportCode VARCHAR(12),
               @FormatCode VARCHAR(10);

    SET @FormatCode = 'IUTAPTO';
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = 'IUTAPTO');

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');
    SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);

    --==================================================
    -- Set FileName
    --==================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'AccrualImport_REVIEW_'
                        + CONVERT(CHAR(8),GETDATE(),112)                               -- YYYYMMDD
                        + REPLACE(CONVERT(VARCHAR(10),GETDATE(),108),':',SPACE(0))     -- HHMMSS
                        + '.csv'
         WHERE FormatCode = @FormatCode;
     END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_IUTAPTO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_IUTAPTO_drvTbl;
    CREATE TABLE dbo.U_IUTAPTO_drvTbl (
        drvSurrogateKey VARCHAR(50) NULL
        ,drvEmployeeNumber VARCHAR(50) NULL
        ,drvBalanceName VARCHAR(50) NULL
        ,drvAccrualCode VARCHAR(50) NULL
        ,drvAccrualOption VARCHAR(50) NULL
        ,drvAllowedBalance VARCHAR(50) NULL
        ,drvDateAccruedThrough VARCHAR(50) NULL
        ,drvAction VARCHAR(50) NULL
        ,drvError VARCHAR(250) NULL
        ,drvImported TINYINT DEFAULT 0 NOT NULL -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
        ,drvEEID VARCHAR(12) NULL
        ,drvCOID VARCHAR(5) NULL
        ,drvInitialSort VARCHAR(50) NULL
    );

    --==================================================
    -- Benefit Import Module (Load File)
    --==================================================
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','7');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','Employee#');

        IF @ExportCode LIKE 'IG%'
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*IG_Balance*');
        ELSE
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*YD_Balance*');

        IF @ExportCode LIKE '%TEST%'
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        ELSE 
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        -- Retain Only Records where Employee# is populated in Field 1
        DELETE FROM dbo.U_IUTAPTO_Import WHERE NULLIF(Field1,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IUTAPTO_drvTbl (drvError)
       SELECT 'Error Parsing Delimited File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================
    -- Report Error Parsing File - Stop Processing
    --==============================================
    IF EXISTS (SELECT 1 FROM dbo.U_IUTAPTO_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
       -- Report Error in Error Report File
       INSERT INTO dbo.U_IUTAPTO_drvTbl (drvError)
       SELECT DISTINCT Error FROM dbo.U_IUTAPTO_Import WHERE ISNULL(Error,'') <> '';

       -- Stop Processing
       RETURN;
    END;

    --==================================================
    -- Build Driver Table - Error Report
    --==================================================
    BEGIN TRY
        INSERT INTO dbo.U_IUTAPTO_drvTbl(drvSurrogateKey,drvEmployeeNumber,drvBalanceName,drvAccrualCode,drvAccrualOption,drvAllowedBalance,drvDateAccruedThrough
            ,drvAction,drvError,drvImported,drvEEID,drvCOID,drvInitialSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + ISNULL(AccAccrCode,'')
            ,drvEmployeeNumber = NULLIF(Field1,'')
            ,drvBalanceName = NULLIF(Field2,'')
            ,drvAccrualCode = AccAccrCode
            ,drvAccrualOption = AccAccrOption
            ,drvAllowedBalance = NULLIF(Field3,'')
            ,drvDateAccruedThrough = PayPeriodEndDate
            ,drvAction = CASE WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [Employee Number] Value in File                             
                              WHEN AccAccrCode IS NULL THEN 'REJECTED' --[Accrual Code] / [Accrual Option Code] Combination Not Setup in UltiPro
                              WHEN ISNULL(EacAccrOption,'') <> '' THEN 'CHANGE'
                              ELSE 'ADD'
                         END
            ,drvError = CASE WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [Employee Number] Value in File.'
                             WHEN AccAccrCode IS NULL THEN 'Record Rejected: [Accrual Code] / [Accrual Option Code] Combination Not Setup in UltiPro. '
                             WHEN ISNULL(EacAccrOption,'') <> '' THEN 'CHANGE'
                             ELSE 'ADD'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [Employee Number] Value in File
                                WHEN AccAccrCode IS NULL THEN 2 --[Accrual Code] / [Accrual Option Code] Combination Not Setup in UltiPro
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvInitialSort = ISNULL(CONVERT(VARCHAR(50), Field1),'')
        FROM dbo.U_IUTAPTO_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
            ON eepEEID = EEID
        LEFT JOIN dbo.AccrOpts WITH (NOLOCK)
            ON AccAccrCode = CASE 
                                WHEN Field2 = 'YD-FLOATING DAYS'      THEN 'FLOATD'
                                WHEN Field2 = 'YD-VACATION AVAILABLE' THEN 'VACAT'
                                WHEN Field2 = 'IG-FLOATING HOURS'     THEN 'FLOATH'
                                WHEN Field2 = 'IG-VACATION HOURS'     THEN 'VACAT'
                                ELSE ''
                             END
            AND AccAccrOption = CASE 
                                   WHEN Field2 = 'YD-FLOATING DAYS'      THEN 'FLOATD'
                                   WHEN Field2 = 'YD-VACATION AVAILABLE' THEN 'VACAT'
                                   WHEN Field2 = 'IG-FLOATING HOURS'     THEN 'FLOATH'
                                   WHEN Field2 = 'IG-VACATION HOURS'     THEN 'VACAT'
                                   ELSE ''
                                END
        LEFT JOIN dbo.EmpAccr WITH (NOLOCK)
            ON EacEEID = EEID
            AND EacCoID = COID
            AND EacAccrCode = AccAccrCode
            AND EacAccrOption = AccAccrOption;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IUTAPTO_drvTbl (drvError)
       SELECT 'Error Processing File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==================================================
    -- Import Accrual Records
    --==================================================
    IF (@ExportCode NOT LIKE '%TEST%')
    BEGIN TRY
        MERGE dbo.EmpAccr TargetTable
        USING dbo.U_IUTAPTO_drvTbl SourceTable
            ON SourceTable.drvEEID = TargetTable.EacEEID
            AND SourceTable.drvCOID = TargetTable.EacCoID
            AND SourceTable.drvAccrualCode = TargetTable.EacAccrCode
            AND SourceTable.drvAccrualOption = TargetTable.EacAccrOption
        -- If Records Match Between Source/Target Tables based on JOIN criteria, then UPDATE Target Table
        WHEN MATCHED AND SourceTable.drvImported = 0 THEN
            UPDATE
                SET TargetTable.EacAccrallowedCurBal = CONVERT(NUMERIC(16,6),CONVERT(MONEY,SourceTable.drvAllowedBalance))
                    ,TargetTable.EacDateAccruedThru = CONVERT(DATETIME,SourceTable.drvDateAccruedThrough)
        -- If Records Match Between Source/Target Tables based on JOIN criteria, then INSERT into Target Table
        WHEN NOT MATCHED BY TARGET AND SourceTable.drvImported = 0 THEN
            INSERT (EacEEID,EacCoID,EacAccrCode,EacAccrOption,EacAccrAllowedCurBal,EacDateAccruedThru,EacSystemID)
            VALUES (SourceTable.drvEEID
                ,SourceTable.drvCOID
                ,SourceTable.drvAccrualCode
                ,SourceTable.drvAccrualOption
                ,CONVERT(NUMERIC(16,6),CONVERT(MONEY,SourceTable.drvAllowedBalance))
                ,CONVERT(DATETIME,SourceTable.drvDateAccruedThrough)
                ,dbo.fn_GetTimedKey()
            );
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IUTAPTO_drvTbl (drvError)
       SELECT 'Error Loading Records in UltiPro: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --=====================
    -- Report Successful
    --=====================
    UPDATE dbo.U_IUTAPTO_drvTbl
        SET drvError = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'Report Only - Do Not Update'
                            ELSE 'Imported Successfully'
                       END
            ,drvImported = 1
    WHERE drvImported = 0
    AND ((@ExportCode LIKE '%TEST%')
        OR (@ExportCode NOT LIKE '%TEST%' AND EXISTS (SELECT 1 FROM dbo.EmpAccr WHERE EacEEID = DrvEEID AND EacCOID = DrvCOID AND EacAccrCode = drvAccrualCode AND EacAccrOption = drvAccrualOption))
    );

    --===========================
    -- Reject Remaining Records
    --===========================
    UPDATE dbo.U_IUTAPTO_drvTbl
        SET drvError = 'Record Rejected'
            ,drvAction = 'REJECTED'
            ,drvImported = 2
    WHERE drvImported = 0;

END
/***************************************************************************
--Create the View
CREATE VIEW dbo.dsi_vwIUTAPTO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IUTAPTO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = 'IUTAPTO')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201801011'
       ,ExpStartPerControl     = '201801011'
       ,ExpLastEndPerControl   = '201801019'
       ,ExpEndPerControl       = '201801019'
WHERE ExpFormatCode = 'IUTAPTO';
***************************************************************************/
GO
CREATE VIEW dbo.dsi_vwIUTAPTO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IUTAPTO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'IUTAPTO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'IUTAPTO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'IUTAPTO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IUTAPTO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'IUTAPTO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IUTAPTO', 'UseFileName', 'V', 'Y'


-- End ripout