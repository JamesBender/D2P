/**********************************************************************************

ESARWDGLDC: Workday GL Payroll Debit Credit

FormatCode:     ESARWDGLDC
Project:        Workday GL Payroll Debit Credit
Client ID:      SAR1005
Date/time:      2023-04-03 13:30:13.753
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E22
Server:         E2SUP2DB03
Database:       ULTIPRO_SARH
Web Filename:   SAR1005_F769B_EEHISTORY_ESARWDGLDC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESARWDGLDC_SavePath') IS NOT NULL DROP TABLE dbo.U_ESARWDGLDC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESARWDGLDC'


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
WHERE FormatCode = 'ESARWDGLDC'
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
WHERE ExpFormatCode = 'ESARWDGLDC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESARWDGLDC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESARWDGLDC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESARWDGLDC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESARWDGLDC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESARWDGLDC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESARWDGLDC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESARWDGLDC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESARWDGLDC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESARWDGLDC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESARWDGLDC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESARWDGLDC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESARWDGLDC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESARWDGLDC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESARWDGLDC];
GO
IF OBJECT_ID('U_ESARWDGLDC_Header_Batch') IS NOT NULL DROP TABLE [dbo].[U_ESARWDGLDC_Header_Batch];
GO
IF OBJECT_ID('U_ESARWDGLDC_Header') IS NOT NULL DROP TABLE [dbo].[U_ESARWDGLDC_Header];
GO
IF OBJECT_ID('U_ESARWDGLDC_File') IS NOT NULL DROP TABLE [dbo].[U_ESARWDGLDC_File];
GO
IF OBJECT_ID('U_ESARWDGLDC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESARWDGLDC_EEList];
GO
IF OBJECT_ID('U_ESARWDGLDC_drvTbl_Line') IS NOT NULL DROP TABLE [dbo].[U_ESARWDGLDC_drvTbl_Line];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESARWDGLDC','Workday GL Payroll Debit Credit','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ESARWDGLDCZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESARWDGLDCZ0','2','H','01','1',NULL,'RecType',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESARWDGLDCZ0','8','H','01','2',NULL,'PayDate',NULL,NULL,'"drvPaydate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESARWDGLDCZ0','2','H','01','3',NULL,'GL',NULL,NULL,'"GL"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESARWDGLDCZ0','1','H','01','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESARWDGLDCZ0','20','H','01','5',NULL,'TRANSACTION PAYROLL',NULL,NULL,'"TRANSACTION PAYROLL"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESARWDGLDCZ0','2','H','01','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESARWDGLDCZ0','2','H','02','1',NULL,'RecType',NULL,NULL,'"05"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESARWDGLDCZ0','12','H','02','2',NULL,'BATCHMMDDYY',NULL,NULL,'"drvBatchMMDDYY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESARWDGLDCZ0','1','H','02','3',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESARWDGLDCZ0','7','H','02','4',NULL,'REGULAR',NULL,NULL,'"REGULAR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESARWDGLDCZ0','1','H','02','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESARWDGLDCZ0','2','H','02','6',NULL,'PR',NULL,NULL,'"PR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESARWDGLDCZ0','7','H','02','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESARWDGLDCZ0','5','H','02','8',NULL,'HOURS',NULL,NULL,'"HOURS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESARWDGLDCZ0','1','H','02','9',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESARWDGLDCZ0','8','H','02','10',NULL,'Paydate',NULL,NULL,'"drvPaydate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESARWDGLDCZ0','8','H','02','11',NULL,'GLEOM',NULL,NULL,'"drvGLEOM"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESARWDGLDCZ0','7','H','02','12',NULL,'PAYROLL',NULL,NULL,'"PAYROLL"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESARWDGLDCZ0','2','H','02','13',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESARWDGLDCZ0','2','D','10','1',NULL,'"10"',NULL,NULL,'"10"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESARWDGLDCZ0','11','D','10','2',NULL,'GLAcctNum',NULL,NULL,'"drvGLAcctNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESARWDGLDCZ0','13','D','10','3',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESARWDGLDCZ0','13','D','10','4',NULL,'DebitAmount',NULL,NULL,'"drvDebitAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESARWDGLDCZ0','13','D','10','5',NULL,'CreditAmount',NULL,NULL,'"drvCreditAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESARWDGLDCZ0','7','D','10','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESARWDGLDCZ0','2','T','90','1',NULL,'Trailer',NULL,NULL,'"99"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESARWDGLDCZ0','2','T','90','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESARWDGLDC_20230403.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Workday GL Payroll Debit Credi','202303319','EMPEXPORT','ONDEM_XOE',NULL,'ESARWDGLDC',NULL,NULL,NULL,'202303319','Mar 31 2023  2:41PM','Mar 31 2023  2:41PM','202303011',NULL,'','','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Workday GL Payroll Debit-Sched','202303319','EMPEXPORT','SCH_ESARWD',NULL,'ESARWDGLDC',NULL,NULL,NULL,'202303319','Mar 31 2023  2:41PM','Mar 31 2023  2:41PM','202303011',NULL,'','','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Workday GL Payroll Debit-Test','202303309','EMPEXPORT','TEST_XOE','Apr  3 2023 12:00AM','ESARWDGLDC',NULL,NULL,NULL,'202303309','Mar 30 2023 12:00AM','Dec 30 1899 12:00AM','202303301',NULL,'','','202303301',dbo.fn_GetTimedKey(),NULL,'us3mWaSAR1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARWDGLDC','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESARWDGLDC','H01','dbo.U_ESARWDGLDC_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESARWDGLDC','H02','dbo.U_ESARWDGLDC_Header_Batch',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESARWDGLDC','D10','dbo.U_ESARWDGLDC_drvTbl_Line',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESARWDGLDC','T90','None',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESARWDGLDC_drvTbl_Line
-----------

IF OBJECT_ID('U_ESARWDGLDC_drvTbl_Line') IS NULL
CREATE TABLE [dbo].[U_ESARWDGLDC_drvTbl_Line] (
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvGLAcctNum] varchar(11) NULL,
    [drvDebitAmount] nvarchar(4000) NULL,
    [drvCreditAmount] nvarchar(4000) NULL
);

-----------
-- Create table U_ESARWDGLDC_EEList
-----------

IF OBJECT_ID('U_ESARWDGLDC_EEList') IS NULL
CREATE TABLE [dbo].[U_ESARWDGLDC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESARWDGLDC_File
-----------

IF OBJECT_ID('U_ESARWDGLDC_File') IS NULL
CREATE TABLE [dbo].[U_ESARWDGLDC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ESARWDGLDC_Header
-----------

IF OBJECT_ID('U_ESARWDGLDC_Header') IS NULL
CREATE TABLE [dbo].[U_ESARWDGLDC_Header] (
    [drvPaydate] varchar(8) NULL
);

-----------
-- Create table U_ESARWDGLDC_Header_Batch
-----------

IF OBJECT_ID('U_ESARWDGLDC_Header_Batch') IS NULL
CREATE TABLE [dbo].[U_ESARWDGLDC_Header_Batch] (
    [drvBatchMMDDYY] varchar(13) NOT NULL,
    [drvPaydate] varchar(8) NULL,
    [drvGLEOM] varchar(8) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESARWDGLDC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Saratoga Hospital

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 03/31/2023
Service Request Number: TekP-2022-09-19-01

Purpose: Workday GL Payroll Debit Credit

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESARWDGLDC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESARWDGLDC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESARWDGLDC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESARWDGLDC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESARWDGLDC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESARWDGLDC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESARWDGLDC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESARWDGLDC', 'SCH_ESARWD';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESARWDGLDC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESARWDGLDC';

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
    DELETE FROM dbo.U_ESARWDGLDC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESARWDGLDC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESARWDGLDC_drvTbl_Line
    ---------------------------------
    IF OBJECT_ID('U_ESARWDGLDC_drvTbl_Line','U') IS NOT NULL
        DROP TABLE dbo.U_ESARWDGLDC_drvTbl_Line;
   SELECT DISTINCT
       --  drvEEID = xEEID
       --  ,drvCoID = xCoID
       -- drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         drvInitialSort = LEFT(vGLAcctNumber,11)
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvGLAcctNum = LEFT(vGLAcctNumber,11)
        ,drvDebitAmount = Format(SUM(vDebitAmt) * 100, '0')
        ,drvCreditAmount = Format(SUM(vCreditAmt) * 100,'0')
    INTO dbo.U_ESARWDGLDC_drvTbl_Line
    FROM dbo.U_ESARWDGLDC_EEList WITH (NOLOCK)
    JOIN dbo.vw_Dsi_Tmpalloc With (Nolock) 
    ON vEEID = XEEID 
    and vCOID =XCOID
    Where VPercontrol Between @StartPerControl and @EndPerControl
    Group by LEFT(vGLAcctNumber,11)
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESARWDGLDC_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESARWDGLDC_Header;
    SELECT DISTINCT
         drvPaydate = Convert(Varchar(8) ,MAX(vPaydate), 112)
    INTO dbo.U_ESARWDGLDC_Header
    FROM dbo.vw_Dsi_Tmpalloc With (Nolock)
    Where VPercontrol Between @StartPerControl and @EndPerControl
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESARWDGLDC_Header_Batch','U') IS NOT NULL
        DROP TABLE dbo.U_ESARWDGLDC_Header_Batch;
  SELECT DISTINCT
         drvBatchMMDDYY = Concat('BATCH',Convert(Varchar(8) ,MAX(vPeriodEndDate), 112))
        ,drvPaydate = Convert(Varchar(8) ,MAX(vPaydate), 112)
        ,drvGLEOM = CONVERT(VARCHAR(8),DATEADD(D,-1,DATEADD(MM,DATEDIFF(M,0,vPeriodEndDate)+1,0)),112)
    INTO dbo.U_ESARWDGLDC_Header_Batch
    FROM dbo.vw_Dsi_Tmpalloc With (Nolock)
    Where VPercontrol Between @StartPerControl and @EndPerControl
    Group by vPeriodEndDate
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
ALTER VIEW dbo.dsi_vwESARWDGLDC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESARWDGLDC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESARWDGLDC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303011'
       ,expStartPerControl     = '202303011'
       ,expLastEndPerControl   = '202303319'
       ,expEndPerControl       = '202303319'
WHERE expFormatCode = 'ESARWDGLDC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESARWDGLDC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESARWDGLDC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESARWDGLDC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESARWDGLDC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESARWDGLDC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESARWDGLDC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESARWDGLDC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESARWDGLDC', 'UseFileName', 'V', 'Y'


-- End ripout