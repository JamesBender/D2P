/**********************************************************************************

EQPSABPYEX: Assoc Bank FSA and HSA Payroll Export

FormatCode:     EQPSABPYEX
Project:        Assoc Bank FSA and HSA Payroll Export
Client ID:      QPS1000
Date/time:      2022-12-02 11:36:17.927
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB03
Database:       ULTIPRO_WPQPS
Web Filename:   QPS1000_6TRXF_EEHISTORY_EQPSABPYEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQPSABPYEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EQPSABPYEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQPSABPYEX'


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
WHERE FormatCode = 'EQPSABPYEX'
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
WHERE ExpFormatCode = 'EQPSABPYEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQPSABPYEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQPSABPYEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQPSABPYEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQPSABPYEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQPSABPYEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQPSABPYEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQPSABPYEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQPSABPYEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQPSABPYEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQPSABPYEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQPSABPYEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQPSABPYEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQPSABPYEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQPSABPYEX];
GO
IF OBJECT_ID('U_EQPSABPYEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_Trailer];
GO
IF OBJECT_ID('U_EQPSABPYEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_PEarHist];
GO
IF OBJECT_ID('U_EQPSABPYEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_PDedHist];
GO
IF OBJECT_ID('U_EQPSABPYEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_Header];
GO
IF OBJECT_ID('U_EQPSABPYEX_File') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_File];
GO
IF OBJECT_ID('U_EQPSABPYEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_EEList];
GO
IF OBJECT_ID('U_EQPSABPYEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_drvTbl];
GO
IF OBJECT_ID('U_EQPSABPYEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_DedList];
GO
IF OBJECT_ID('U_EQPSABPYEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_AuditFields];
GO
IF OBJECT_ID('U_EQPSABPYEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EQPSABPYEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EQPSABPYEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQPSABPYEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQPSABPYEX','Assoc Bank FSA and HSA Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EQPSABPYEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABPYEXZ0','2','H','01','1',NULL,'Record Type ',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABPYEXZ0','3','H','01','2',NULL,'Admin Code ',NULL,NULL,'"ABK"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABPYEXZ0','6','H','01','3',NULL,'Employer Code ',NULL,NULL,'"Q5P7S2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABPYEXZ0','1','H','01','4',NULL,'Synchronize Flag ',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABPYEXZ0','8','H','01','5',NULL,'Created Date ',NULL,NULL,'"drvCreatedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABPYEXZ0','6','H','01','6',NULL,'Created Time ',NULL,NULL,'"drvCreatedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABPYEXZ0','6','H','01','7',NULL,'File Version ',NULL,NULL,'"3.4"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABPYEXZ0','2','D','10','1',NULL,'Record Type ',NULL,NULL,'"CT "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABPYEXZ0','50','D','10','2',NULL,'Participant File Import ID ',NULL,NULL,'"drvPartFileID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABPYEXZ0','50','D','10','3',NULL,'Planame ',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABPYEXZ0','8','D','10','4',NULL,'Contribution Date ',NULL,NULL,'"drvContribDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABPYEXZ0','30','D','10','5',NULL,'Contribution Description ',NULL,NULL,'"drvContribDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABPYEXZ0','9','D','10','6',NULL,'Contribution Amount ',NULL,NULL,'"drvContribAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABPYEXZ0','6','D','10','7',NULL,'Amount Type ',NULL,NULL,'"Actual"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQPSABPYEXZ0','7','D','10','8',NULL,'Tax Year ',NULL,NULL,'"Current"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABPYEXZ0','2','T','90','1',NULL,'Record Type ',NULL,NULL,'"FF "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABPYEXZ0','20','T','90','2',NULL,'Record Count ',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABPYEXZ0','3','T','90','3',NULL,'Admin Code ',NULL,NULL,'"DBI "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABPYEXZ0','6','T','90','4',NULL,'Employer Code ',NULL,NULL,'"Q5P7S2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABPYEXZ0','8','T','90','5',NULL,'Created Date ',NULL,NULL,'"drvCreatedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABPYEXZ0','6','T','90','6',NULL,'Created Time ',NULL,NULL,'"drvCreatedTime"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQPSABPYEX_20221202.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assoc Bank FSA and HSA Payroll','202212029','EMPEXPORT','ONDEM_XOE',NULL,'EQPSABPYEX',NULL,NULL,NULL,'202212029','Dec  2 2022 10:32AM','Dec  2 2022 10:32AM','202211151',NULL,'','','202211151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assoc Bank FSA and HSA P-Sched','202212029','EMPEXPORT','SCH_EQPSAB',NULL,'EQPSABPYEX',NULL,NULL,NULL,'202212029','Dec  2 2022 10:32AM','Dec  2 2022 10:32AM','202211151',NULL,'','','202211151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Assoc Bank FSA and HSA P-Test','202212029','EMPEXPORT','TEST_XOE',NULL,'EQPSABPYEX',NULL,NULL,NULL,'202212029','Dec  2 2022 10:32AM','Dec  2 2022 10:32AM','202211151',NULL,'','','202211151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABPYEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABPYEX','H01','dbo.U_EQPSABPYEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABPYEX','D10','dbo.U_EQPSABPYEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABPYEX','T90','dbo.U_EQPSABPYEX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQPSABPYEX
-----------

IF OBJECT_ID('U_dsi_BDM_EQPSABPYEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQPSABPYEX] (
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
-- Create table U_EQPSABPYEX_Audit
-----------

IF OBJECT_ID('U_EQPSABPYEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_Audit] (
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
-- Create table U_EQPSABPYEX_AuditFields
-----------

IF OBJECT_ID('U_EQPSABPYEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EQPSABPYEX_DedList
-----------

IF OBJECT_ID('U_EQPSABPYEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQPSABPYEX_drvTbl
-----------

IF OBJECT_ID('U_EQPSABPYEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvPartFileID] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvContribDate] varchar(8000) NULL,
    [drvContribDesc] varchar(21) NOT NULL,
    [drvContribAmt] nvarchar(4000) NULL
);

-----------
-- Create table U_EQPSABPYEX_EEList
-----------

IF OBJECT_ID('U_EQPSABPYEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQPSABPYEX_File
-----------

IF OBJECT_ID('U_EQPSABPYEX_File') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EQPSABPYEX_Header
-----------

IF OBJECT_ID('U_EQPSABPYEX_Header') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_Header] (
    [drvCreatedDate] varchar(8) NULL,
    [drvCreatedTime] varchar(6) NULL
);

-----------
-- Create table U_EQPSABPYEX_PDedHist
-----------

IF OBJECT_ID('U_EQPSABPYEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL
);

-----------
-- Create table U_EQPSABPYEX_PEarHist
-----------

IF OBJECT_ID('U_EQPSABPYEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_PEarHist] (
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
-- Create table U_EQPSABPYEX_Trailer
-----------

IF OBJECT_ID('U_EQPSABPYEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EQPSABPYEX_Trailer] (
    [drvRecordCount] int NULL,
    [drvCreatedDate] varchar(8) NULL,
    [drvCreatedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQPSABPYEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: QPS Employment

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 12/02/2022
Service Request Number: TekP-2022-10-25-03 

Purpose: Assoc Bank FSA and HSA Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQPSABPYEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQPSABPYEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQPSABPYEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQPSABPYEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQPSABPYEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABPYEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABPYEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABPYEX', 'SCH_EQPSAB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQPSABPYEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQPSABPYEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(6);

    -- Set FormatCode
    SELECT @FormatCode = 'EQPSABPYEX';

    -- Declare dates from Parameter file
     SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = REPLACE(CONVERT (CHAR(10),GETDATE(), 101),'/','')
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(10), GETDATE(), 108),':',SPACE(0))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EQPSABPYEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQPSABPYEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EQPSABPYEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_AuditFields;
    CREATE TABLE dbo.U_EQPSABPYEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EQPSABPYEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EQPSABPYEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_Audit;
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
    INTO dbo.U_EQPSABPYEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EQPSABPYEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EQPSABPYEX_Audit ON dbo.U_EQPSABPYEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EQPSABPYEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EQPSABPYEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAD,HEFSA,HSACF,HSACI,HSAF,HSAI,HSAIC,LFSA,HSAER';

    IF OBJECT_ID('U_EQPSABPYEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQPSABPYEX_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EQPSABPYEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhDedCode IN ('FSA', 'HEFSA', 'FSAD', 'LFSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC') 
                AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('FSA', 'HEFSA', 'FSAD', 'LFSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC') THEN PdhEECurAmt ELSE 0.00 END)
      --  ,PdhHSAER     = SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN 0.01 ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EQPSABPYEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EQPSABPYEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    AND PdhDedCode IN ('FSA', 'HEFSA', 'FSAD', 'LFSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC', 'HSAER')
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EQPSABPYEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EQPSABPYEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABPYEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EQPSABPYEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvPartFileID = eepssn
        ,drvPlanName = CASE WHEN Bdmdedcode  IN ('FSA', 'HEFSA') THEN 'Medical FSA'
                            WHEN Bdmdedcode  = 'FSAD' THEN 'Dependent Care FSA'
                            WHEN Bdmdedcode  = 'LFSA' THEN 'Limited FSA'
                            WHEN Bdmdedcode  IN ( 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC') THEN 'Health Savings Account'
                        END
        ,drvContribDate = REPLACE(CONVERT (CHAR(10),PrgPayDate , 101),'/','') 
        ,drvContribDesc = CASE WHEN Bdmdedcode IN ('HSAER')  THEN 'Employer Contribution' else 'Payroll Deduction' END
         ,drvContribAmt = CASE WHEN Bdmdedcode IN ('FSA', 'HEFSA', 'FSAD', 'LFSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAI') and Format(PdhEECurAmt, '0.00')> '0.00' THEN Format(PdhEECurAmt, '0.00') END
    INTO dbo.U_EQPSABPYEX_drvTbl
    FROM dbo.U_EQPSABPYEX_EEList WITH (NOLOCK)
   JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQPSABPYEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     LEFT JOIN dbo.U_EQPSABPYEX_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    LEFT JOIN dbo.U_EQPSABPYEX_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    LEFT JOIN dbo.U_EQPSABPYEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
     Where eecEEtype <> 'TES'
        And  EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audDateTime BETWEEN @StartDate AND @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EQPSABPYEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_Header;
    SELECT DISTINCT
         drvCreatedDate = @RunDate
        ,drvCreatedTime = @RunTime
    INTO dbo.U_EQPSABPYEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EQPSABPYEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABPYEX_Trailer;
    SELECT DISTINCT
         drvRecordCount = (Select Count(*) FROM dbo.U_EQPSABPYEX_drvTbl)
        ,drvCreatedDate = @RunDate
        ,drvCreatedTime = @RunTime
    INTO dbo.U_EQPSABPYEX_Trailer
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
ALTER VIEW dbo.dsi_vwEQPSABPYEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQPSABPYEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EQPSABPYEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202211151'
       ,expStartPerControl     = '202211151'
       ,expLastEndPerControl   = '202212029'
       ,expEndPerControl       = '202212029'
WHERE expFormatCode = 'EQPSABPYEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEQPSABPYEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EQPSABPYEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQPSABPYEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQPSABPYEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQPSABPYEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQPSABPYEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQPSABPYEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQPSABPYEX', 'UseFileName', 'V', 'Y'


-- End ripout