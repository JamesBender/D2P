/**********************************************************************************

EDRABOAPOS: Bank of America Positive Pay

FormatCode:     EDRABOAPOS
Project:        Bank of America Positive Pay
Client ID:      DRA1001
Date/time:      2023-01-31 11:22:36.507
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E44
Server:         E4SUP4DB02
Database:       ULTIPRO_DRAGA
Web Filename:   DRA1001_AC65C_EEHISTORY_EDRABOAPOS_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDRABOAPOS_SavePath') IS NOT NULL DROP TABLE dbo.U_EDRABOAPOS_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDRABOAPOS'


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
WHERE FormatCode = 'EDRABOAPOS'
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
WHERE ExpFormatCode = 'EDRABOAPOS'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDRABOAPOS')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDRABOAPOS'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDRABOAPOS'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDRABOAPOS'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDRABOAPOS'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDRABOAPOS'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDRABOAPOS'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDRABOAPOS'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDRABOAPOS'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDRABOAPOS'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDRABOAPOS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDRABOAPOS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDRABOAPOS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDRABOAPOS];
GO
IF OBJECT_ID('U_EDRABOAPOS_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_Trailer];
GO
IF OBJECT_ID('U_EDRABOAPOS_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_PEarHist];
GO
IF OBJECT_ID('U_EDRABOAPOS_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_PDedHist];
GO
IF OBJECT_ID('U_EDRABOAPOS_Header') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_Header];
GO
IF OBJECT_ID('U_EDRABOAPOS_File') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_File];
GO
IF OBJECT_ID('U_EDRABOAPOS_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_EEList];
GO
IF OBJECT_ID('U_EDRABOAPOS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_drvTbl];
GO
IF OBJECT_ID('U_EDRABOAPOS_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_DedList];
GO
IF OBJECT_ID('U_EDRABOAPOS_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_AuditFields];
GO
IF OBJECT_ID('U_EDRABOAPOS_Audit') IS NOT NULL DROP TABLE [dbo].[U_EDRABOAPOS_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDRABOAPOS','Bank of America Positive Pay','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EDRABOAPOSZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDRABOAPOSZ0','12','H','01','1',NULL,'Account Number',NULL,NULL,'"drvAccountNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDRABOAPOSZ0','1','H','01','2',NULL,'Header Record Indicator',NULL,NULL,'"drvHeaderRecorIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDRABOAPOSZ0','22','H','01','3',NULL,'Filler',NULL,NULL,'""','(''ss''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDRABOAPOSZ0','8','H','01','4',NULL,'Date',NULL,NULL,'"drvDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDRABOAPOSZ0','273','H','01','5',NULL,'Filler',NULL,NULL,'""','(''ss''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDRABOAPOSZ0','12','D','10','1',NULL,'Account Number',NULL,NULL,'"drvAccountNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDRABOAPOSZ0','1','D','10','2',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDRABOAPOSZ0','10','D','10','3',NULL,'Check / Serial Number',NULL,NULL,'"drvCheckSerialNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDRABOAPOSZ0','12','D','10','4',NULL,'Amount',NULL,NULL,'"drvAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDRABOAPOSZ0','8','D','10','5',NULL,'Date',NULL,NULL,'"drvDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDRABOAPOSZ0','3','D','10','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDRABOAPOSZ0','256','D','10','7',NULL,'Payee Name or Additional Data',NULL,NULL,'"drvPayeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDRABOAPOSZ0','16','D','10','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDRABOAPOSZ0','12','T','90','1',NULL,'Account Number',NULL,NULL,'"drvAccountNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDRABOAPOSZ0','1','T','90','2',NULL,'Trailer Record Indicator',NULL,NULL,'"drvTrailerRecordIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDRABOAPOSZ0','10','T','90','3',NULL,'Item Count Total',NULL,NULL,'"drvItemCountTotal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDRABOAPOSZ0','12','T','90','4',NULL,'Dollar Amount Total',NULL,NULL,'"drvDollarAmountTotal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDRABOAPOSZ0','3','T','90','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDRABOAPOS_20230131.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Bank of America Positive Pay','202301319','EMPEXPORT','ONDEM_XOE',NULL,'EDRABOAPOS',NULL,NULL,NULL,'202301319','Jan 31 2023  8:51AM','Jan 31 2023  8:51AM','202301311',NULL,'','','202301311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Bank of America Positive-Sched','202301319','EMPEXPORT','SCH_EDRABO',NULL,'EDRABOAPOS',NULL,NULL,NULL,'202301319','Jan 31 2023  8:51AM','Jan 31 2023  8:51AM','202301311',NULL,'','','202301311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Bank of America Positive-Test','202301319','EMPEXPORT','TEST_XOE','Jan 31 2023 12:00AM','EDRABOAPOS',NULL,NULL,NULL,'202301319','Jan 31 2023 12:00AM','Dec 30 1899 12:00AM','202301311',NULL,'','','202301311',dbo.fn_GetTimedKey(),NULL,'us3mWaDRA1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDRABOAPOS','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDRABOAPOS','H01','dbo.U_EDRABOAPOS_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDRABOAPOS','D10','dbo.U_EDRABOAPOS_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDRABOAPOS','T90','dbo.U_EDRABOAPOS_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EDRABOAPOS_Audit
-----------

IF OBJECT_ID('U_EDRABOAPOS_Audit') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
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
-- Create table U_EDRABOAPOS_AuditFields
-----------

IF OBJECT_ID('U_EDRABOAPOS_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EDRABOAPOS_DedList
-----------

IF OBJECT_ID('U_EDRABOAPOS_DedList') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EDRABOAPOS_drvTbl
-----------

IF OBJECT_ID('U_EDRABOAPOS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(12) NOT NULL,
    [drvsubsort] char(10) NOT NULL,
    [drvAccountNumber] varchar(12) NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvCheckSerialNumber] varchar(10) NULL,
    [drvAmount] nvarchar(12) NULL,
    [drvDate] varchar(8000) NULL,
    [drvPayeeName] varchar(50) NULL
);

-----------
-- Create table U_EDRABOAPOS_EEList
-----------

IF OBJECT_ID('U_EDRABOAPOS_EEList') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDRABOAPOS_File
-----------

IF OBJECT_ID('U_EDRABOAPOS_File') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EDRABOAPOS_Header
-----------

IF OBJECT_ID('U_EDRABOAPOS_Header') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_Header] (
    [drvAccountNumber] varchar(12) NULL,
    [drvHeaderRecorIndicator] varchar(1) NOT NULL,
    [drvDate] varchar(8000) NULL
);

-----------
-- Create table U_EDRABOAPOS_PDedHist
-----------

IF OBJECT_ID('U_EDRABOAPOS_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EDRABOAPOS_PEarHist
-----------

IF OBJECT_ID('U_EDRABOAPOS_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EDRABOAPOS_Trailer
-----------

IF OBJECT_ID('U_EDRABOAPOS_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDRABOAPOS_Trailer] (
    [drvAccountNumber] varchar(12) NULL,
    [drvTrailerRecordIndicator] varchar(1) NOT NULL,
    [drvItemCountTotal] nvarchar(10) NULL,
    [drvDollarAmountTotal] nvarchar(12) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDRABOAPOS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Dragados USA, Inc

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/31/2023
Service Request Number: TekP-2022-10-19-01

Purpose: Bank of America Positive Pay

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDRABOAPOS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDRABOAPOS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDRABOAPOS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDRABOAPOS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDRABOAPOS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRABOAPOS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRABOAPOS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDRABOAPOS', 'SCH_EDRABO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDRABOAPOS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDRABOAPOS';

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
    DELETE FROM dbo.U_EDRABOAPOS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDRABOAPOS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


 --   --==========================================
 --   -- Audit Section
 --   --==========================================
 --   -- Get data from audit fields table. Add fields here if auditing
 --   IF OBJECT_ID('U_EDRABOAPOS_AuditFields','U') IS NOT NULL
 --       DROP TABLE dbo.U_EDRABOAPOS_AuditFields;
 --   CREATE TABLE dbo.U_EDRABOAPOS_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    
    --INSERT INTO dbo.U_EDRABOAPOS_AuditFields VALUES ('Empcomp','eecEmplStatus');

 --   -- Create audit table based on fields defined above
 --   IF OBJECT_ID('U_EDRABOAPOS_Audit','U') IS NOT NULL
 --       DROP TABLE dbo.U_EDRABOAPOS_Audit;
 --   SELECT 
 --       audEEID  = audKey1Value
 --       ,audKey2 = audKey2Value
 --       ,audKey3 = audKey3Value
 --       ,audTableName
 --       ,audFieldName
 --       ,audAction
 --       ,audDateTime
 --       ,audOldValue
 --       ,audNewValue
 --       ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
 --   INTO dbo.U_EDRABOAPOS_Audit
 --   FROM dbo.vw_AuditData WITH (NOLOCK) 
 --   JOIN dbo.U_EDRABOAPOS_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
 --   WHERE audDateTime BETWEEN @StartDate AND @EndDate
 --   AND audAction <> 'DELETE';

 --   -- Create Index
 --   CREATE CLUSTERED INDEX CDX_U_EDRABOAPOS_Audit ON dbo.U_EDRABOAPOS_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EDRABOAPOS_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EDRABOAPOS_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EDRABOAPOS_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EDRABOAPOS_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EDRABOAPOS_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_EDRABOAPOS_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EDRABOAPOS_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EDRABOAPOS_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EDRABOAPOS_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    --IF OBJECT_ID('U_EDRABOAPOS_PEarHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EDRABOAPOS_PEarHist;
    --SELECT DISTINCT
    --     PehEEID
    --    ,PrgPayDate             = MAX(PrgPayDate)
    --    -- Current Payroll Amount/Hours
    --    ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --    ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --    -- YTD Payroll Amount/Hours
    --    ,PehCurAmtYTD           = SUM(PehCurAmt)
    --    ,PehCurHrsYTD           = SUM(PehCurHrs)
    --    -- Current Include Deferred Comp Amount/Hours
    --    ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --    ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --    -- YTD Include Deferred Comp Amount/Hours
    --    ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --    ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    --INTO dbo.U_EDRABOAPOS_PEarHist
    --FROM dbo.vw_int_PayReg WITH (NOLOCK)
    --JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --    ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDRABOAPOS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDRABOAPOS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDRABOAPOS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = PrgGenNumber
        ,drvsubsort = ISNULL(PrgDocNo, 0)
        -- standard fields above and additional driver fields below
        ,drvAccountNumber = RIGHT('000000000000' +BnkBankAcctNo, 12)
        ,drvRecordType = CASE WHEN prgIsVoidingRecord = 'Y' then 'V' else 'O' END
        ,drvCheckSerialNumber = RIGHT('0000000000'+Ltrim(Rtrim(PrgDocNo)), 10)
        ,drvAmount =  RIGHT('000000000000'+FORMAT(CASE WHEN PrgIsVoidingRecord <> 'Y' THEN ABS(PrgCheckAmt * 100) ELSE 0 END ,'0'), 12)
        ,drvDate = REPLACE(CONVERT(VARCHAR(10), PrgPayDate, 101), '/', '')
        ,drvPayeeName = UPPER(ckhEEfullname)
    INTO dbo.U_EDRABOAPOS_drvTbl
    FROM dbo.U_EDRABOAPOS_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
        AND PrgCoID = xCOID
    JOIN dbo.Bank WITH (NOLOCK)
        ON PrgCoBankID = BnkCoBankID
    LEFT JOIN dbo.ChkHead WITH (NOLOCK)
        ON ckhEEID = xEEID
        AND CONVERT(VARCHAR(10),LTRIM(RTRIM(PrgDocNo))) = CONVERT(VARCHAR(10),LTRIM(RTRIM(ckhCheckNo)))
        AND PrgGenNumber = ckhGenNumber
    WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PrgCheckAddMode IN ('R','M','A','D','B','J')
    AND PrgPrinted = 'Y'
    AND PrgTransactionType IN ('C')
    AND (PrgPostOnly = 'N'
        OR PrgIsVoidingRecord = 'Y'
            )
    AND BnkCoBankId IN ('DBOA', 'JWBO', 'BOA1', 'BOA2', 'BOA4')
    and PrgCheckAmt > 0
    ;



    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDRABOAPOS_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDRABOAPOS_Header;
    SELECT DISTINCT
         drvAccountNumber = drvAccountNumber
        ,drvHeaderRecorIndicator = 'H'
        ,drvDate = drvDate
    INTO dbo.U_EDRABOAPOS_Header
     FROM (
        SELECT DISTINCT drvAccountNumber, drvDate
        FROM dbo.U_EDRABOAPOS_drvTbl
    ) hdr;
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDRABOAPOS_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDRABOAPOS_Trailer;
    SELECT DISTINCT
         drvAccountNumber = drvAccountNumber
        ,drvTrailerRecordIndicator = 'T'
        ,drvItemCountTotal =  RIGHT('0000000000'+(SELECT FORMaT(COUNT(*),'0') FROM dbo.U_EDRABOAPOS_drvTbl),10) -- Total Record Count
        ,drvDollarAmountTotal = RIGHT('000000000000'+(SELECT FORMAT(SUM(cast(drvAmount as money)),'0') FROM dbo.U_EDRABOAPOS_drvTbl), 12)
    INTO dbo.U_EDRABOAPOS_Trailer
    FROM (
        SELECT DISTINCT drvAccountNumber
        FROM dbo.U_EDRABOAPOS_drvTbl
    ) Tlr;
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
ALTER VIEW dbo.dsi_vwEDRABOAPOS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDRABOAPOS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EDRABOAPOS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301241'
       ,expStartPerControl     = '202301241'
       ,expLastEndPerControl   = '202301319'
       ,expEndPerControl       = '202301319'
WHERE expFormatCode = 'EDRABOAPOS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDRABOAPOS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDRABOAPOS_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDRABOAPOS' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDRABOAPOS'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDRABOAPOS'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDRABOAPOS', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDRABOAPOS', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDRABOAPOS', 'UseFileName', 'V', 'Y'


-- End ripout