/**********************************************************************************

IVOYAIMW: Voya Contributions WEB Import

FormatCode:     IVOYAIMW
Project:        Voya Contributions WEB Import
Client ID:      EAS1016
Date/time:      2024-02-09 15:30:18.503
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP5DB04
Database:       ULTIPRO_WPEURF
Web Filename:   EAS1016_MY9A2_EEHISTORY_IVOYAIMW_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\ew1\Public\EAS1016\Imports\Voya\Processed\
ExportPath:    
ImportPath:    \\us.saas\ew1\Public\EAS1016\Imports\Voya\
TestPath:      
XMLPath:       \\us.saas\ew1\Public\EAS1016\Imports\Voya\XML\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_IVOYAIMW_SavePath') IS NOT NULL DROP TABLE dbo.U_IVOYAIMW_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'IVOYAIMW'


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
WHERE FormatCode = 'IVOYAIMW'
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
WHERE ExpFormatCode = 'IVOYAIMW'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'IVOYAIMW')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'IVOYAIMW'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'IVOYAIMW'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'IVOYAIMW'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'IVOYAIMW'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'IVOYAIMW'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'IVOYAIMW'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'IVOYAIMW'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'IVOYAIMW'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'IVOYAIMW'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_fn_IVOYAIMW_GetMatchAction') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_IVOYAIMW_GetMatchAction];
GO
IF OBJECT_ID('dsi_vwIVOYAIMW_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwIVOYAIMW_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_IVOYAIMW') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IVOYAIMW];
GO
IF OBJECT_ID('U_IVOYAIMW_Raw') IS NOT NULL DROP TABLE [dbo].[U_IVOYAIMW_Raw];
GO
IF OBJECT_ID('U_IVOYAIMW_Import') IS NOT NULL DROP TABLE [dbo].[U_IVOYAIMW_Import];
GO
IF OBJECT_ID('U_IVOYAIMW_File') IS NOT NULL DROP TABLE [dbo].[U_IVOYAIMW_File];
GO
IF OBJECT_ID('U_IVOYAIMW_EEList') IS NOT NULL DROP TABLE [dbo].[U_IVOYAIMW_EEList];
GO
IF OBJECT_ID('U_IVOYAIMW_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_IVOYAIMW_drvTbl];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW_Raw') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_IVOYAIMW_Raw];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW_DedOffsets') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_IVOYAIMW_DedOffsets];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_IVOYAIMW];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','IVOYAIMW','Voya Contributions WEB Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6500','S','N','DW5DR4000010','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','DW5DR4000010','500','H','01','1',NULL,NULL,NULL,NULL,'"Employee #"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','DW5DR4000010','500','H','01','2',NULL,NULL,NULL,NULL,'"Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','DW5DR4000010','500','H','01','3',NULL,NULL,NULL,NULL,'"Record Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','DW5DR4000010','500','H','01','4',NULL,NULL,NULL,NULL,'"DedCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','DW5DR4000010','500','H','01','5',NULL,NULL,NULL,NULL,'"Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','DW5DR4000010','500','H','01','6',NULL,NULL,NULL,NULL,'"Stop Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','DW5DR4000010','500','H','01','7',NULL,NULL,NULL,NULL,'"Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','DW5DR4000010','500','H','01','8',NULL,NULL,NULL,NULL,'"Percent"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','DW5DR4000010','500','H','01','9',NULL,NULL,NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','DW5DR4000010','500','H','01','10',NULL,NULL,NULL,NULL,'"Notes"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','DW5DR4000010','500','D','10','1',NULL,NULL,NULL,NULL,'"DrvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','DW5DR4000010','500','D','10','2',NULL,NULL,NULL,NULL,'"DrvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','DW5DR4000010','500','D','10','3',NULL,NULL,NULL,NULL,'"DrvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','DW5DR4000010','500','D','10','4',NULL,NULL,NULL,NULL,'"DrvDedCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','DW5DR4000010','500','D','10','5',NULL,NULL,NULL,NULL,'"DrvStartDateReport"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','DW5DR4000010','500','D','10','6',NULL,NULL,NULL,NULL,'"DrvStopDateReport"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','DW5DR4000010','500','D','10','7',NULL,NULL,NULL,NULL,'"DrvEECalcRateOrPctRaw"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','DW5DR4000010','500','D','10','8',NULL,NULL,NULL,NULL,'"DrvEEAmtRaw"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','DW5DR4000010','500','D','10','9',NULL,NULL,NULL,NULL,'"DrvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','DW5DR4000010','500','D','10','10',NULL,NULL,NULL,NULL,'"DrvNotes"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'IVOYAIMW_20240209.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',T5MPL,VL4LN,6ZJUE,6ZJZT,OAK08,MZXL6,3LMN2,EPR5N,VHGEP,6ZJYR,SODK4,6ZJXC,9YSCR',NULL,NULL,NULL,'Testing','202302109','EMPEXPORT','TEST','Nov 30 2020 12:00AM','IVOYAIMW',NULL,NULL,NULL,'202302109','Nov 28 2020 12:00AM','Dec 30 1899 12:00AM','202301191','21','','','202301191',dbo.fn_GetTimedKey(),NULL,'JMARSHALL01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','GYSLY,GYSWU,DVXKB,YJQVW,GYT7N',NULL,NULL,NULL,'VOYA DefandLoan - Fri 2pm','202301199','EMPEXPORT','UPDATES','Jan 19 2023  1:55PM','IVOYAIMW',NULL,NULL,NULL,'202402099','Jan 19 2023 12:00AM','Dec 30 1899 12:00AM','202402021','38','','','202212131',dbo.fn_GetTimedKey(),NULL,'EELLIOTT01',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','ArchivePath','V','\\us.saas\ew1\Public\EAS1016\Imports\Voya\Processed\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','ExportDescription','C','Voya Import');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','ImportPath','V','\\us.saas\ew1\Public\EAS1016\Imports\Voya\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','InitialSort','C','DrvAction');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','UseFileName','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVOYAIMW','XMLPath','V','\\us.saas\ew1\Public\EAS1016\Imports\Voya\XML\');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IVOYAIMW','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IVOYAIMW','D10','dbo.U_Dsi_DrvTbl_IVOYAIMW',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_Dsi_DrvTbl_IVOYAIMW
-----------

IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_IVOYAIMW] (
    [DrvCOID] varchar(5) NULL,
    [DrvEEID] varchar(32) NULL,
    [DrvSSN] varchar(9) NULL,
    [DrvEmpNo] varchar(12) NULL,
    [DrvEmployeeName] varchar(128) NULL,
    [DrvEmplStatus] varchar(1) NULL,
    [DrvPaygroup] varchar(6) NULL,
    [DrvRecordType] varchar(32) NULL,
    [DrvVendorCode] varchar(32) NULL,
    [DrvDedCode] varchar(32) NULL,
    [DrvDedGroupCode] varchar(6) NULL,
    [DrvLoanNumber] varchar(6) NULL,
    [DrvEECalcRateOrPctRaw] varchar(32) NULL,
    [DrvEEAmtRaw] varchar(32) NULL,
    [DrvLoanAmtRaw] varchar(32) NULL,
    [DrvEECalcRateOrPct] money NULL,
    [DrvEEAmt] money NULL,
    [DrvStartDate] datetime NULL,
    [DrvStopDate] datetime NULL,
    [DrvStartDateReport] varchar(10) NULL,
    [DrvStopDateReport] varchar(10) NULL,
    [DrvEEHasDeduction] varchar(1) NULL,
    [DrvAction] varchar(16) NULL,
    [DrvMatchAction] varchar(8) NULL,
    [DrvNotes] varchar(256) NULL,
    [DrvDuplicateKey] varchar(64) NULL,
    [DrvPendingUpdateID] varchar(12) NULL
);

-----------
-- Create table U_Dsi_DrvTbl_IVOYAIMW_DedOffsets
-----------

IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW_DedOffsets') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_IVOYAIMW_DedOffsets] (
    [DrvCOID] varchar(5) NULL,
    [DrvEEID] varchar(12) NULL,
    [DrvUpdated] varchar(1) NULL
);

-----------
-- Create table U_Dsi_DrvTbl_IVOYAIMW_Raw
-----------

IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW_Raw') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_IVOYAIMW_Raw] (
    [AscFileLine] varchar(8000) NULL
);

-----------
-- Create table U_IVOYAIMW_drvTbl
-----------

IF OBJECT_ID('U_IVOYAIMW_drvTbl') IS NULL
CREATE TABLE [dbo].[U_IVOYAIMW_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvEmployeeNumber] varchar(50) NULL,
    [drvEmployeeName] varchar(50) NULL,
    [drvSSN] varchar(50) NULL,
    [drvDeductionCode] varchar(50) NULL,
    [drvBenefitStatus] varchar(50) NULL,
    [drvBenefitStatusDate] varchar(50) NULL,
    [drvBenefitStartDate] varchar(50) NULL,
    [drvBenefitStopDate] varchar(50) NULL,
    [drvDeductionStartDate] varchar(50) NULL,
    [drvDeductionStopDate] varchar(50) NULL,
    [drvContributionPercent] varchar(50) NULL,
    [drvContributionAmount] varchar(50) NULL,
    [drvEmployerPercent] varchar(50) NULL,
    [drvEmployerAmount] varchar(50) NULL,
    [drvBenefitOption] varchar(50) NULL,
    [drvBenefitAmount] varchar(50) NULL,
    [drvBenefitChangeReason] varchar(50) NULL,
    [drvLoanNumber] varchar(50) NULL,
    [drvLoanPaymentAmount] varchar(50) NULL,
    [drvLoanGoalAmount] varchar(50) NULL,
    [drvLoanType] varchar(50) NULL,
    [drvAction] varchar(50) NULL,
    [drvError] varchar(250) NULL,
    [drvImported] tinyint NOT NULL DEFAULT ((0)),
    [drvEEID] varchar(12) NULL,
    [drvCOID] varchar(5) NULL,
    [drvDedCode] varchar(50) NULL,
    [drvImportType] varchar(50) NULL,
    [drvPeriodStartDate] varchar(50) NULL,
    [drvPendingUpdateID] char(20) NULL,
    [drvInitialSort] varchar(50) NULL
);

-----------
-- Create table U_IVOYAIMW_EEList
-----------

IF OBJECT_ID('U_IVOYAIMW_EEList') IS NULL
CREATE TABLE [dbo].[U_IVOYAIMW_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_IVOYAIMW_File
-----------

IF OBJECT_ID('U_IVOYAIMW_File') IS NULL
CREATE TABLE [dbo].[U_IVOYAIMW_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_IVOYAIMW_Import
-----------

IF OBJECT_ID('U_IVOYAIMW_Import') IS NULL
CREATE TABLE [dbo].[U_IVOYAIMW_Import] (
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
    [Field8] varchar(max) NULL,
    [Field9] varchar(max) NULL,
    [Field10] varchar(max) NULL,
    [Field11] varchar(max) NULL,
    [Field12] varchar(max) NULL,
    [Field13] varchar(max) NULL,
    [Field14] varchar(max) NULL,
    [Field15] varchar(max) NULL,
    [Field16] varchar(max) NULL,
    [Field17] varchar(max) NULL,
    [Field18] varchar(max) NULL,
    [Field19] varchar(max) NULL,
    [Field20] varchar(max) NULL,
    [Field21] varchar(max) NULL,
    [Field22] varchar(max) NULL,
    [Field23] varchar(max) NULL,
    [Field24] varchar(max) NULL,
    [Field25] varchar(max) NULL,
    [Field26] varchar(max) NULL,
    [Field27] varchar(max) NULL,
    [Field28] varchar(max) NULL,
    [Field29] varchar(max) NULL,
    [Field30] varchar(max) NULL,
    [Field31] varchar(max) NULL,
    [Field32] varchar(max) NULL,
    [Field33] varchar(max) NULL,
    [Field34] varchar(max) NULL,
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_IVOYAIMW_Raw
-----------

IF OBJECT_ID('U_IVOYAIMW_Raw') IS NULL
CREATE TABLE [dbo].[U_IVOYAIMW_Raw] (
    [Field1] varchar(max) NULL,
    [Field2] varchar(max) NULL,
    [Field3] varchar(max) NULL,
    [Field4] varchar(max) NULL,
    [Field5] varchar(max) NULL,
    [Field6] varchar(max) NULL,
    [Field7] varchar(max) NULL,
    [Field8] varchar(max) NULL,
    [Field9] varchar(max) NULL,
    [Field10] varchar(max) NULL,
    [Field11] varchar(max) NULL,
    [Field12] varchar(max) NULL,
    [Field13] varchar(max) NULL,
    [Field14] varchar(max) NULL,
    [Field15] varchar(max) NULL,
    [Field16] varchar(max) NULL,
    [Field17] varchar(max) NULL,
    [Field18] varchar(max) NULL,
    [Field19] varchar(max) NULL,
    [Field20] varchar(max) NULL,
    [Field21] varchar(max) NULL,
    [Field22] varchar(max) NULL,
    [Field23] varchar(max) NULL,
    [Field24] varchar(max) NULL,
    [Field25] varchar(max) NULL,
    [Field26] varchar(max) NULL,
    [Field27] varchar(max) NULL,
    [Field28] varchar(max) NULL,
    [Field29] varchar(max) NULL,
    [Field30] varchar(max) NULL,
    [Field31] varchar(max) NULL,
    [Field32] varchar(max) NULL,
    [Field33] varchar(max) NULL,
    [Field34] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IVOYAIMW]
    @SystemID char(12)
AS
SET NOCOUNT ON;


/**********************************************************************************

Client Name: Turfmasters Brands 

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 08/31/2023
Service Request Number: TekP-2023-04-18-01 

Purpose: Voya Import

Revision History
----------------
Update By            Date            Request Num                Desc

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'IVOYAIMW';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'IVOYAIMW';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'IVOYAIMW';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'IVOYAIMW';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IVOYAIMW' ORDER BY DateTimeCompleted DESC;

SELECT * FROM dbo.U_dsi_BIM_ImportFileList
SELECT * FROM dbo.U_IVOYAIMW_Raw
SELECT * FROM dbo.U_IVOYAIMW_Import
SELECT * FROM dbo.U_Dsi_DrvTbl_IVOYAIMW
SELECT * FROM dbo.U_Dsi_DrvTbl_IVOYAIMW WHERE DrvAction = 'Error'
SELECT * FROM dbo.U_Dsi_DrvTbl_IVOYAIMW WHERE DrvAction <> 'Error'

SELECT * FROM dbo.LodEDed WHERE EedPendingUpdateID IN (SELECT DISTINCT CntPendingUpdateID FROM LODCNTRL WHERE CntSessionID = 'IVOYAIMW')
SELECT * FROM dbo.LodEComp WHERE EecPendingUpdateID IN (SELECT DISTINCT CntPendingUpdateID FROM LODCNTRL WHERE CntSessionID = 'IVOYAIMW')
SELECT * FROM dbo.LodCntrl WHERE CntSessionID = 'IVOYAIMW'
 
DELETE FROM dbo.LodEDed WHERE EedPendingUpdateID IN (SELECT DISTINCT CntPendingUpdateID FROM LODCNTRL WHERE CntSessionID = 'IVOYAIMW')
DELETE FROM dbo.LodEComp WHERE EecPendingUpdateID IN (SELECT DISTINCT CntPendingUpdateID FROM LODCNTRL WHERE CntSessionID = 'IVOYAIMW')
DELETE FROM dbo.LodCntrl WHERE CntSessionID = 'IVOYAIMW'

--EXEC dbo.dsi_sp_UpdateConfig 'IVOYAIMW', 'XMLPath', 'V',  'Y'
--EXEC dbo.dsi_sp_UpdateConfig 'IVOYAIMW', 'XMLPath', 'V',  '\\us.saas\ew1\Public\EAS1016\Imports\Voya\XML\'


---EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'IVOYAIMW', @AllObjects = 'Y', @IsWeb = 'Y'

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IVOYAIMW', 'UPDATES'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IVOYAIMW', 'TEST'

**********************************************************************************/

BEGIN

-----------
-- Declare Variables
-----------

DECLARE @FormatCode              VARCHAR(10)
DECLARE @ImportPath              VARCHAR(1000)
DECLARE @FileName                VARCHAR(1000)
DECLARE @ExportCode              VARCHAR(12)
DECLARE @LeaveDateInPlace        DATETIME
DECLARE @SetDateToNull           DATETIME
DECLARE @COID                    CHAR(5)
DECLARE @EEID                    CHAR(12)

SET @LeaveDateInPlace = '12/30/1899'
SET @SetDateToNull    = '1/1/1900'

SET @FormatCode = 'IVOYAIMW';
SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

--Set directory and filename where import file is located

SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode, 'ImportPath');
SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);


-----------
-- Set FileName
-----------

IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N') BEGIN
    UPDATE dbo.U_dsi_Parameters
    SET ExportFile = 'Voya_Import_'
                    + CONVERT(CHAR(8), GETDATE(), 112)                          -- YYYYMMDD
                    + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', SPACE(0)) -- HHMMSS
                    + '.csv'
    WHERE FormatCode = @FormatCode;
END;

  
-----------
-- Create Driver Table
-----------

IF OBJECT_ID('U_Dsi_DrvTbl_IVOYAIMW') IS NOT NULL DROP TABLE dbo.U_Dsi_DrvTbl_IVOYAIMW
IF OBJECT_ID('U_IVOYAIMW_Import')     IS NOT NULL DROP TABLE dbo.U_IVOYAIMW_Import

CREATE TABLE dbo.U_Dsi_DrvTbl_IVOYAIMW(

DrvCOID                VARCHAR(5),
DrvEEID                VARCHAR(32),
DrvSSN                 VARCHAR(9),
DrvEmpNo               VARCHAR(12),
DrvEmployeeName        VARCHAR(128),
DrvEmplStatus          VARCHAR(1),
DrvPaygroup            VARCHAR(6),
DrvRecordType          VARCHAR(32),
DrvVendorCode          VARCHAR(32),
DrvDedCode             VARCHAR(32),
DrvDedGroupCode        VARCHAR(6),
DrvLoanNumber          VARCHAR(6),
DrvEECalcRateOrPctRaw  VARCHAR(32),
DrvEEAmtRaw            VARCHAR(32),
DrvLoanAmtRaw          VARCHAR(32),
DrvEECalcRateOrPct     MONEY NULL,
DrvEEAmt               MONEY NULL,
DrvStartDate           DATETIME NULL,
DrvStopDate            DATETIME NULL,
DrvStartDateReport     VARCHAR(10),
DrvStopDateReport      VARCHAR(10),
DrvEEHasDeduction      VARCHAR(1),
DrvAction              VARCHAR(16),
DrvMatchAction         VARCHAR(8),
DrvNotes               VARCHAR(256),
DrvDuplicateKey        VARCHAR(64),
DrvPendingUpdateID     VARCHAR(12)
)

-----------
-- Run Benefit Import Module
-----------

BEGIN TRY

    DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'RunID', 'DEDUCTION');
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'FilePath', @ImportPath);
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1, ParmValue2) VALUES (@FormatCode, 'FileFormat', 'Delimited', ',');
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'FieldCount', '34');
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1, ParmValue2) VALUES (@FormatCode, 'KeyEEID', 'Field2', 'SSN');
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'PayrollType', 'PayGroup'); --Regular --PayGroup --Non-Closed --Non-Opened
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'FileName', '81J206_*')
    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'MultipleFiles', 'Y'); -- Sweep Folder and Import Files

    -- If we're in Validate Mode OR this is a stops run, copy the files; otherwise archive them

    IF dbo.dsi_fnVariable(@FormatCode, 'Testing') = 'Y' OR @ExportCode = 'TEST' or dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE'
    
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'CopyFiles', 'Y');
   ELSE 
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode, ParmName, ParmValue1) VALUES (@FormatCode, 'ArchiveFiles', 'Y');
    ;

    EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;


END TRY
BEGIN CATCH

    -- Report BIM Error in the driver table

   INSERT INTO dbo.U_Dsi_DrvTbl_IVOYAIMW (DrvNotes)
   SELECT 'Error Processing Fixed File (BIM): ' + ISNULL(ERROR_MESSAGE(), '');

   RETURN;

END CATCH;


-----------
-- If error during BIM, then report error and stop processing
-----------

IF EXISTS (SELECT 1 FROM dbo.U_IVOYAIMW_Import WHERE ISNULL(Error, '') <> '') BEGIN

    INSERT INTO dbo.U_Dsi_DrvTbl_IVOYAIMW (DrvNotes)
    SELECT Error FROM dbo.U_IVOYAIMW_Import WHERE ISNULL(Error, '') <> '';
    RETURN;

END;


-----------
-- Build driver table
-----------

INSERT INTO dbo.U_Dsi_DrvTbl_IVOYAIMW
SELECT DISTINCT

DrvCOID                = COID,
DrvEEID                = EEID,
DrvSSN                 = Field2,
DrvEmpNo               = EmployeeNo,
DrvEmployeeName        = EmployeeName,
DrvEmplStatus          = '', -- updated below
DrvPaygroup            = '', -- updated below
DrvRecordType          = CASE
                            WHEN Field10 = 'Pre-Tax Defrl%' THEN 'Deferral %'
                            WHEN Field10 = 'Pre-Tax'        THEN 'Deferral Amt'
                            WHEN Field10 = 'ROTH %'         THEN 'Deferral %'
                            WHEN Field10 = 'ROTH $'         THEN 'Deferral Amt'
                            WHEN Field13 <> ''              THEN 'Loan'
                            ELSE ''
                         END,
DrvVendorCode          = Field10,
DrvDedCode             = CASE
                            WHEN Field10 = 'Pre-Tax Defrl%' THEN 'TM401'
                            WHEN Field10 = 'Pre-Tax'        THEN 'TM40F'              
                            WHEN Field10 = 'ROTH %'         THEN 'TMRTH'
                            WHEN Field10 = 'ROTH $'         THEN 'TMRTF'
                            ELSE ''
                         END,
DrvDedGroupCode        = '', -- updated below
DrvLoanNumber          = Field13,
DrvEECalcRateOrPctRaw  = Field11,
DrvEEAmtRaw            = Field12,
DrvLoanAmtRaw          = Field19,
DrvEECalcRateOrPct     = 0,
DrvEEAmt               = 0,
DrvStartDate           = PayPeriodStartDate,
DrvStopDate            = PayPeriodEndDate,
DrvStartDateReport     = '',
DrvStopDateReport      = '',
DrvEEHasDeduction      = 'N',
DrvAction              = '',
DrvMatchAction         = '',
DrvNotes               = '',
DrvDuplicateKey        = '',
DrvPendingUpdateID     = dbo.fn_GetTimedKey()

FROM dbo.U_IVOYAIMW_Import WITH (NOLOCK)
WHERE ISNUMERIC(Field2) = 1


Union 

SELECT DISTINCT

DrvCOID                = COID,
DrvEEID                = EEID,
DrvSSN                 = Field2,
DrvEmpNo               = EmployeeNo,
DrvEmployeeName        = EmployeeName,
DrvEmplStatus          = '', -- updated below
DrvPaygroup            = '', -- updated below
DrvRecordType          = CASE
                            --WHEN Field10 = 'Pre-Tax Defrl%' THEN 'Deferral %'
                           -- WHEN Field10 = 'Pre-Tax'        THEN 'Deferral Amt'
                           -- WHEN Field10 = 'ROTH %'         THEN 'Deferral %'
                            --WHEN Field10 = 'ROTH $'         THEN 'Deferral Amt'
                            --WHEN Field13 <> ''              THEN 'Loan'
                            WHEN field31 = '01' THEN 'Match'
                            ELSE ''
                         END,
DrvVendorCode          = CASE WHEN field31 = '01' THEN 'Match' END,--Field10,
DrvDedCode             = CASE
                            --WHEN Field10 = 'Pre-Tax Defrl%' THEN 'TM401'
                           -- WHEN Field10 = 'Pre-Tax'        THEN 'TM40F'              
                           -- WHEN Field10 = 'ROTH %'         THEN 'TMRTH'
                           -- WHEN Field10 = 'ROTH $'         THEN 'TMRTF'
                            WHEN field31 = '01' THEN 'TM4KM'
                            ELSE ''
                         END,
DrvDedGroupCode        = '', -- updated below
DrvLoanNumber          = Field13,
DrvEECalcRateOrPctRaw  = Field11,
DrvEEAmtRaw            = Field12,
DrvLoanAmtRaw          = Field19,
DrvEECalcRateOrPct     = 0,
DrvEEAmt               = 0,
DrvStartDate           = PayPeriodStartDate,
DrvStopDate            = PayPeriodEndDate,
DrvStartDateReport     = '',
DrvStopDateReport      = '',
DrvEEHasDeduction      = 'N',
DrvAction              = '',
DrvMatchAction         = '',
DrvNotes               = '',
DrvDuplicateKey        = '',
DrvPendingUpdateID     = dbo.fn_GetTimedKey()

FROM dbo.U_IVOYAIMW_Import WITH (NOLOCK)
WHERE  field31 = '01'



-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TESTING

--DELETE FROM dbo.U_Dsi_DrvTbl_IVOYAIMW WHERE DrvEEID <> 'B6RDFU0000K0'


-----------
-- Update employee fields
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvEmplStatus    = EecEmplStatus,
       DrvPaygroup      = EecPaygroup,
       DrvDedGroupCode  = EecDedGroupCode

  FROM dbo.U_Dsi_DrvTbl_IVOYAIMW
  JOIN dbo.EmpComp WITH (NOLOCK) ON EecCoID = DrvCOID AND EecEEID = DrvEEID;


-----------
-- Set the loan deduction code
-----------

-- Employees can only have 1 active loan

WITH CTE AS (
 
   SELECT 
   EedCoID,
   EedEEID,
   EedDedCode = MIN(EedDedCode) 
   FROM dbo.EmpDed
   WHERE EedDedCode IN ('TM4L1', 'TM4L2')
     AND EedStopDate IS NULL
   GROUP BY EedCoID, EedEEID)
UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvDedCode = EedDedCode
  FROM CTE
 WHERE DrvRecordType = 'LOAN'
   AND DrvCOID = EedCoID
   AND DrvEEID = EedEEID


-- If no active loan found, just set it to TM4L1

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvDedCode = 'TM4L1'
 WHERE DrvRecordType = 'LOAN'
   AND DrvDedCode = ''


-----------
-- Check for errors
-----------

-- Invalid employee number

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Invalid SSN. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND COALESCE(DrvEEID, '') = ''


-- Employee is terminated

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Employee is terminated. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND DrvEmplStatus = 'T';


-- Unable to determine record type

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Unable to determine record type. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND DrvRecordType = ''


-- Unable to determine deduction code

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Unable to determine deduction code. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND DrvDedCode = ''


-- No amount/invalid amount for deferral

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'No amount/invalid amount for deferral. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND (DrvEEAmtRaw = '' OR (DrvEEAmtRaw <> '' AND ISNUMERIC(DrvEEAmtRaw) = 0))
   AND DrvRecordType = 'Deferral Amt'


-- No percent/invalid percent for deferral

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'No percent/invalid percent for deferral. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND (DrvEECalcRateOrPctRaw = '' OR (DrvEECalcRateOrPctRaw <> '' AND ISNUMERIC(DrvEECalcRateOrPctRaw) = 0))
   AND DrvRecordType = 'Deferral %'


-- No amount/invalid amount for loan

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'No amount for loan. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND (DrvLoanAmtRaw = '' OR (DrvLoanAmtRaw <> '' AND ISNUMERIC(DrvLoanAmtRaw) = 0))
   AND DrvRecordType = 'LOAN'


-----------
-- Set amounts
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvEECalcRateOrPct = CONVERT(MONEY, DrvEECalcRateOrPctRaw) / 100,
       DrvEEAmt = IIF(DrvRecordType = 'Loan', CONVERT(MONEY, DrvLoanAmtRaw), CONVERT(MONEY, DrvEEAmtRaw))
 WHERE DrvAction <> 'Error'


-----------
-- Deduction doesn't exist in the employee's DedGroupCode
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Deduction doesn''t exist in the employee''s DedGroupCode. Record skipped.'
  FROM dbo.U_Dsi_DrvTbl_IVOYAIMW
  LEFT JOIN dbo.BenProg WITH (NOLOCK) ON CbpBenGroupCode = DrvDedGroupCode AND CbpDedCode = DrvDedCode
 WHERE DrvAction <> 'Error'
   AND CbpDedCode IS NULL


-----------
-- Determine whether the employee has the deduction
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvEEHasDeduction = IIF(COALESCE(EedStopDate, EedBenStopDate) IS NOT NULL, 'T', 'A')
  FROM dbo.U_Dsi_DrvTbl_IVOYAIMW
  JOIN dbo.EmpDed WITH (NOLOCK) ON EedCOID = DrvCOID AND EedEEID = DrvEEID AND EedDedCode = DrvDedCode
 WHERE DrvAction <> 'Error'


-----------
-- Stopping a non-existent or termed deduction
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Stopping a non-existent or termed deduction. Record skipped.'
 WHERE DrvAction <> 'Error'
   AND DrvEEHasDeduction <> 'A'
   AND (DrvEEAmt = 0 AND DrvEECalcRateOrPct = 0)


-----------
-- Update surrogate key and check for duplicates
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvDuplicateKey = DrvCOID + '-' + DrvEEID + '-' + DrvDedCode
 WHERE DrvAction <> 'Error'

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Error',
       DrvNotes = 'Record Error: employee has duplicate deduction codes in file.'
WHERE DrvAction <> 'Error'
  AND DrvDuplicateKey IN (SELECT DrvDuplicateKey FROM dbo.U_Dsi_DrvTbl_IVOYAIMW GROUP BY DrvDuplicateKey HAVING COUNT(1) > 1);


-----------
-- Update the import actions
-----------

-- Adds

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Add'
 WHERE DrvAction <> 'Error'
   AND DrvEEHasDeduction = 'N'


-- Updates

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Change'
 WHERE DrvAction <> 'Error'
   AND DrvEEHasDeduction = 'A'
   AND (DrvEEAmt > 0 OR DrvEECalcRateOrPct > 0)


-- Restarts

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Restart'
 WHERE DrvAction <> 'Error'
   AND DrvEEHasDeduction = 'T'
   AND (DrvEEAmt > 0 OR DrvEECalcRateOrPct > 0)

-- Stops

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvAction = 'Stop'
 WHERE DrvAction <> 'Error'
   AND DrvEEHasDeduction = 'A'
   AND (DrvEEAmt = 0 AND DrvEECalcRateOrPct = 0)


-- Update report dates
-----------

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvStartDateReport = CONVERT(VARCHAR(10), DrvStartDate, 101),
       DrvStopDateReport = IIF(DrvAction = 'Stop', CONVERT(VARCHAR(10), DrvStopDate, 101), '')
 WHERE DrvAction <> 'Error'



 --============================================================
    -- Generate XML File for Standard Web Import for Automation
 --============================================================

    BEGIN TRY
        --------------------------------------------
        -- Populate BIM Lod Deduction Table for Web
        --------------------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;

        --=============================================
        -- Populate Lod Deduction Table (BIM_LodEDed)
        --=============================================

   INSERT INTO dbo.U_dsi_BIM_LodEDed ( EedFormatCode,EedBenOption    ,EedBenStartDate,EedBenStatus,EedBenStatusDate,EedBenStopDate,EedChangeReason,EedCOID,EedDedCode,EedEEAmt,EedEECalcRateOrPct ,EedEECalcRule,EedEEID,EedInclInAddlChk,EedInclInManlChk    
        ,EedPendingEffDate,EedPendingTransType,EedPendingUpdateID,EedStartDate,EedStopDate) 

 SELECT  
     EedFormatCode    = @FormatCode  
    ,EedBenOption    = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                          WHEN EXISTS (SELECT 1 FROM dbo.EmpDed WHERE EedEEID = DrvEEID AND EedCOID = DrvCOID AND EedDedCode = drvDedCode AND ISNULL(EedBenOption,'') = 'Z') THEN '' -- Set 'Z' (None) to Blank
                        END
    ,EedBenStartDate    = CASE WHEN DrvAction IN ('Add', 'Restart') THEN DrvStartDate 
                               ELSE EedStartDate
                             END
    ,EedBenStatus    = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                           ELSE 'A' --Always Active
                          END
    ,EedBenStatusDate    = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                              WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(DATETIME,drvStartDate)
                              WHEN drvAction IN ('STOP') THEN DATEADD(DAY,-1,CONVERT(DATETIME,drvStartDate))
                           ELSE '12/30/1899'
                         END
    ,EedBenStopDate    = CASE WHEN DrvAction = 'Stop' THEN DrvStopDate ELSE @SetDateToNull END    
    ,EedChangeReason    = CASE
                              WHEN DrvAction = 'Add'     THEN '400'
                              WHEN DrvAction = 'Change'  THEN '402'
                              WHEN DrvAction = 'Restart' THEN '402'
                              WHEN DrvAction = 'Stop'    THEN '401'
                           END
    ,EedCOID = drvCOID
    ,EedDedCode    = drvDedCode    
    ,EedEEAmt    = CASE WHEN DrvAction = 'Stop'    THEN CONVERT(MONEY, 0.00)
                              WHEN DedEECalcRule <> '20' THEN CONVERT(MONEY, 0.00)
                              ELSE convert(Money,DrvEEAmt)
                           END
    ,EedEECalcRateOrPct = CASE WHEN DrvAction = 'Stop' THEN CONVERT(MONEY, 0.00)
                              ELSE convert(Money,DrvEECalcRateOrPctRaw) --DrvEECalcRateOrPct
                           END    
    ,EedEECalcRule    = DedEECalcRule    
    ,EedEEID =     drvEEID
    ,EedInclInAddlChk    = DedInclInAddlChk
    ,EedInclInManlChk    =DedInclInManlChk
    ,EedPendingEffDate = CONVERT(DATE, GETDATE())    
    ,EedPendingTransType =    IIF( DrvAction = 'Restart', 'C', LEFT(DrvAction, 1))
    ,EedPendingUpdateID    =drvPendingUpdateID
    ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvStartDate)
                         ELSE '12/30/1899'
                      END        
    ,EedStopDate = CASE WHEN DrvAction = 'Stop' THEN DrvStopDate ELSE @SetDateToNull END
    FROM dbo.U_Dsi_DrvTbl_IVOYAIMW
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecCOID = DrvCOID AND EecEEID = DrvEEID
    JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = DrvDedCode
    LEFT JOIN dbo.EmpDed WITH (NOLOCK) ON EedCOID = DrvCOID AND EedEEID = DrvEEID AND EedDedCode = DrvDedCode
    WHERE DrvAction IN ('Add', 'Change', 'Stop', 'Restart')
    ;

--    Update dbo.U_dsi_Configuration 

--SET CfgValue = 'N'

--Where FormatCode = 'IVOYAIMW' and cfgname = 'Testing';

        ------------------------------------------------------------------------
        -- Generate XML File for Standard Web Import to Validate/Post Records
        ------------------------------------------------------------------------
        DECLARE @XMLFilePath VARCHAR(1000) = IIF(dbo.dsi_fnVariable('IVOYAIMW', 'Testing') = 'Y',dbo.dsi_fnVariable('IVOYAIMW', 'XmlPath'),'') 
               ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable('IVOYAIMW','ArchivePath');

     --PRINT CONCAT('----XML FILEPATH = ',@XmlFilePath)
        
        --DLC While testing only run if in validate mode.
   -- IF dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE' -- testing
        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', '', @XMLArchiveFilePath;    
    --ELSE 
    --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;   -- testing
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVOYAIMW_drvTbl (drvError,drvImported)
       SELECT 'Error Generating XML File for Web Import: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing

       RETURN;
    END CATCH;
     
    --    --============================================================
    --    -- Generate XML File for Web Import Tool
    --    --============================================================
    --    DECLARE @XMLFilePath VARCHAR(1000) = '' --dbo.Dsi_fnVariable(@FormatCode,'XMLPath')
    --        ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

    --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    --END TRY
    --BEGIN CATCH
    --   -- Report SQL Error in Error Report File
    --   INSERT INTO dbo.U_IVOYAIMW_drvTbl (drvError)
    --   SELECT 'Error Loading Records for Validation/Posting: ' + ISNULL(ERROR_MESSAGE(),'');

    --   -- Stop Processing
    --   RETURN;
    --END CATCH;

    --==========================
    -- Report Successful Update
    --==========================

UPDATE dbo.U_Dsi_DrvTbl_IVOYAIMW
   SET DrvNotes = 'Loaded Successfully'
 WHERE DrvAction IN ('Add', 'Change', 'Restart', 'Stop')
   AND (EXISTS (SELECT * FROM dbo.U_dsi_BIM_LodEDed WHERE EedPendingUpdateID = DrvPendingUpdateID)
        OR EXISTS (SELECT * FROM dbo.U_dsi_BIM_LodEEarn WHERE EeePendingUpdateID = DrvPendingUpdateID))

END
GO
CREATE  View [dbo].[dsi_vwIVOYAIMW_Export] as
        select top 2000000 REPLACE(left(data,(len(data))), 'Jan  1 1900 12:00AM', '') as data from dbo.U_IVOYAIMW_File with (nolock)
        where Recordset IN ('H01', 'D10')
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort
GO
CREATE FUNCTION [dbo].[dsi_fn_IVOYAIMW_GetMatchAction] (
@COID            VARCHAR(6),
@EEID            VARCHAR(12),
@PendingUpdateID VARCHAR(12)
)
RETURNS VARCHAR(8)
WITH EXECUTE AS CALLER
AS

/************************************************************

Created By:  John Transier
Create Date: 04/17/2020

Purpose: Returns the action for a 401K Match record

Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx

************************************************************/

BEGIN

DECLARE @MatchStatus  VARCHAR(1)
DECLARE @Cnt1         INT
DECLARE @Cnt2         INT

SET @EEID            = LTRIM(RTRIM(COALESCE(@EEID, '')))
SET @PendingUpdateID = LTRIM(RTRIM(COALESCE(@PendingUpdateID, '')))


-----------
-- They can have multiple stops, adds, etc; we only want a match action on one
-----------

IF @PendingUpdateID <> (SELECT MIN(DrvPendingUpdateID) 
                          FROM dbo.U_Dsi_DrvTbl_IVOYAIMW WITH (NOLOCK) 
                         WHERE DrvEEID = @EEID 
                           AND DrvAction IN ('Add', 'Change', 'Restart', 'Stop')
                           AND DrvRecordType LIKE 'Deferral%') RETURN ''


-----------
-- Get the current match status
-----------

SELECT @MatchStatus = IIF(EedStopDate IS NOT NULL, 'T', 'A')
  FROM dbo.EmpDed
 WHERE EedCOID = @COID 
   AND EedEEID = @EEID 
   AND EedDedCode = '401KM'

SET @MatchStatus = ISNULL(@MatchStatus, 'N')


-----------
-- Adds or restarts
-----------

-- If they have ANY non-stop actions it can't be a stop

SELECT @Cnt1 = COUNT(1) 
  FROM dbo.U_Dsi_DrvTbl_IVOYAIMW WITH (NOLOCK) 
 WHERE DrvEEID = @EEID 
   AND DrvAction IN ('Add', 'Change', 'Restart')
   AND DrvRecordType LIKE 'Deferral%'


IF @Cnt1 > 0 BEGIN
    
   IF @MatchStatus = 'N' RETURN 'Add'
   IF @MatchStatus = 'T' RETURN 'Restart'
   
   RETURN ''
     
END


-----------
-- Return STOP only if they're stopping everything
-----------

SELECT @Cnt1 = COUNT(1) 
  FROM dbo.U_Dsi_DrvTbl_IVOYAIMW WITH (NOLOCK) 
 WHERE DrvEEID = @EEID 
   AND DrvAction IN ('Stop')
   AND DrvRecordType LIKE 'Deferral%'
   
SELECT @Cnt2 = COUNT(1) 
  FROM dbo.EmpDed WITH (NOLOCK) 
 WHERE EedCOID = @COID 
   AND EedEEID = @EEID 
   AND EedDedCode IN ('401K', '401KC', '401R')
   AND EedStopDate IS NULL
   
IF @Cnt1 > 0 AND @Cnt1 = @Cnt2 BEGIN
    
     IF @MatchStatus = 'A' RETURN 'Stop'
     
END


RETURN ''

END

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'IVOYAIMW' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'IVOYAIMW'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'IVOYAIMW'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IVOYAIMW', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'IVOYAIMW', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IVOYAIMW', 'UseFileName', 'V', 'Y'


-- End ripout