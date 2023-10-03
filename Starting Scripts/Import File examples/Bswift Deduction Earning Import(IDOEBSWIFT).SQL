/**********************************************************************************

IDOEBSWIFT: Bswift Deduction Earning Import

FormatCode:     IDOEBSWIFT
Project:        Bswift Deduction Earning Import
Client ID:      DOE1000
Date/time:      2023-09-29 07:53:27.260
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW3WUP3DB01
Database:       ULTIPRO_WPDOE
Web Filename:   DOE1000_324F7_EEHISTORY_IDOEBSWIFT_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\EW3\EW33\DOE1000\DOE\Imports\Bswift\Archive\
ExportPath:    
ImportPath:    \\us.saas\EW3\EW33\DOE1000\DOE\Imports\Bswift\
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_IDOEBSWIFT_SavePath') IS NOT NULL DROP TABLE dbo.U_IDOEBSWIFT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'IDOEBSWIFT'


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
WHERE FormatCode = 'IDOEBSWIFT'
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
WHERE ExpFormatCode = 'IDOEBSWIFT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'IDOEBSWIFT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'IDOEBSWIFT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'IDOEBSWIFT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'IDOEBSWIFT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'IDOEBSWIFT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'IDOEBSWIFT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'IDOEBSWIFT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'IDOEBSWIFT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'IDOEBSWIFT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'IDOEBSWIFT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwIDOEBSWIFT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwIDOEBSWIFT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_IDOEBSWIFT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IDOEBSWIFT];
GO
IF OBJECT_ID('U_IDOEBSWIFT_Raw') IS NOT NULL DROP TABLE [dbo].[U_IDOEBSWIFT_Raw];
GO
IF OBJECT_ID('U_IDOEBSWIFT_Import') IS NOT NULL DROP TABLE [dbo].[U_IDOEBSWIFT_Import];
GO
IF OBJECT_ID('U_IDOEBSWIFT_File') IS NOT NULL DROP TABLE [dbo].[U_IDOEBSWIFT_File];
GO
IF OBJECT_ID('U_IDOEBSWIFT_EEList') IS NOT NULL DROP TABLE [dbo].[U_IDOEBSWIFT_EEList];
GO
IF OBJECT_ID('U_IDOEBSWIFT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_IDOEBSWIFT_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','IDOEBSWIFT','Bswift Deduction Earning Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','IDOEBSWIFTZ0','N',NULL,'C','dbo.dsi_sp_switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IDOEBSWIFTZ0','50','H','01','1',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IDOEBSWIFTZ0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IDOEBSWIFTZ0','50','H','01','3',NULL,'Deduction Plan Code',NULL,NULL,'"Deduction Plan Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IDOEBSWIFTZ0','50','H','01','4',NULL,'Deduction Start Date',NULL,NULL,'"Deduction Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IDOEBSWIFTZ0','50','H','01','5',NULL,'Deduction Stop Date',NULL,NULL,'"Deduction Stop Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IDOEBSWIFTZ0','50','H','01','6',NULL,'EE Deduction Amt ($)',NULL,NULL,'"EE Deduction Amt ($)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IDOEBSWIFTZ0','50','H','01','7',NULL,'ER Deduction Amt ($)',NULL,NULL,'"ER Deduction Amt ($)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IDOEBSWIFTZ0','50','H','01','8',NULL,'EE Deduction Percent (%)',NULL,NULL,'"EE Deduction Percent (%)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IDOEBSWIFTZ0','50','H','01','9',NULL,'ER Deduction Percent (%)',NULL,NULL,'"ER Deduction Percent (%)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IDOEBSWIFTZ0','50','H','01','10',NULL,'Import Type',NULL,NULL,'"Import Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IDOEBSWIFTZ0','50','H','01','11',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','IDOEBSWIFTZ0','50','H','01','12',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IDOEBSWIFTZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IDOEBSWIFTZ0','100','D','10','2',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IDOEBSWIFTZ0','50','D','10','3',NULL,'Deduction Plan Code',NULL,NULL,'"drvDeductionPlanCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IDOEBSWIFTZ0','50','D','10','4',NULL,'Deduction Start Date',NULL,NULL,'"drvDeductionStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IDOEBSWIFTZ0','50','D','10','5',NULL,'Deduction Stop Date',NULL,NULL,'"drvDeductionStopDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IDOEBSWIFTZ0','50','D','10','6',NULL,'EE Deduction Amt ($)',NULL,NULL,'"drvEEDeductionAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IDOEBSWIFTZ0','50','D','10','7',NULL,'ER Deduction Amt ($)',NULL,NULL,'"drvERDeductionAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IDOEBSWIFTZ0','50','D','10','8',NULL,'EE Deduction Percent (%)',NULL,NULL,'"drvEEDeductionPercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IDOEBSWIFTZ0','50','D','10','9',NULL,'ER Deduction Percent (%)',NULL,NULL,'"drvERDeductionPercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IDOEBSWIFTZ0','50','D','10','10',NULL,'Import Type',NULL,NULL,'"drvImportType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IDOEBSWIFTZ0','50','D','10','11',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','IDOEBSWIFTZ0','250','D','10','12',NULL,'Error Message',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'IDOEBSWIFT_20230929.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',NZNW3,NZNYC',NULL,NULL,NULL,'Ded/Earn ADD/CHANGES ONDEM','202306239','EMPEXPORT','ADDCHG','Jan  1 2019 12:00AM','IDOEBSWIFT',NULL,NULL,NULL,'202306239','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202306231',NULL,'','','202306231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','U5DK4,NZNYC,NZNW3',NULL,NULL,NULL,'Ded/Earn ADD/CHANGES SCHED','202306129','EMPEXPORT','SCH_ADDCHG','Jan  1 2019 12:00AM','IDOEBSWIFT',NULL,NULL,NULL,'202309299','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202309291',NULL,'','','202306121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','U5DK4,NZNYC,NZNW3',NULL,NULL,NULL,'Ded/Earn STOP SCHED','202306129','EMPEXPORT','SCH_STOPS','Jan  1 2019 12:00AM','IDOEBSWIFT',NULL,NULL,NULL,'202309299','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202309291',NULL,'','','202306121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ded/Earn STOP ONDEM','202302109','EMPEXPORT','STOPDEDS','Jan  1 2019 12:00AM','IDOEBSWIFT',NULL,NULL,NULL,'202302109','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ded/Earn ADD/CHANGES TEST','202302109','EMPEXPORT','TESTADDCHG','Jan  1 2019 12:00AM','IDOEBSWIFT',NULL,NULL,NULL,'202302109','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ded/Earn STOP TEST','202302109','EMPEXPORT','TESTSTOPS','Jan  1 2019 12:00AM','IDOEBSWIFT',NULL,NULL,NULL,'202302109','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','ArchivePath','V','\\us.saas\EW3\EW33\DOE1000\DOE\Imports\Bswift\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','ImportPath','V','\\us.saas\EW3\EW33\DOE1000\DOE\Imports\Bswift\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','TEMPLATE','V','Generic Deductions & Earnings Import - v1.0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IDOEBSWIFT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IDOEBSWIFT','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IDOEBSWIFT','D10','dbo.U_IDOEBSWIFT_drvTbl (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_IDOEBSWIFT_drvTbl
-----------

IF OBJECT_ID('U_IDOEBSWIFT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_IDOEBSWIFT_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvEmployeeNumber] varchar(50) NULL,
    [drvEmployeeName] varchar(100) NULL,
    [drvSocialSecurityNumber] varchar(50) NULL,
    [drvDeductionPlanCode] varchar(50) NULL,
    [drvDeductionStartDate] varchar(50) NULL,
    [drvDeductionStopDate] varchar(50) NULL,
    [drvEEDeductionAmt] varchar(50) NULL,
    [drvERDeductionAmt] varchar(50) NULL,
    [drvEEDeductionPercent] varchar(50) NULL,
    [drvERDeductionPercent] varchar(50) NULL,
    [drvPendingEffectiveDate] varchar(50) NULL,
    [drvAction] varchar(50) NULL,
    [drvError] varchar(250) NULL,
    [drvImported] tinyint NOT NULL DEFAULT ((0)),
    [drvEEID] varchar(12) NULL,
    [drvCOID] varchar(5) NULL,
    [drvDedCode] varchar(50) NULL,
    [drvEarnCode] varchar(50) NULL,
    [drvImportType] varchar(50) NULL,
    [drvPendingUpdateID] char(20) NULL,
    [drvInitialSort] varchar(50) NULL
);

-----------
-- Create table U_IDOEBSWIFT_EEList
-----------

IF OBJECT_ID('U_IDOEBSWIFT_EEList') IS NULL
CREATE TABLE [dbo].[U_IDOEBSWIFT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_IDOEBSWIFT_File
-----------

IF OBJECT_ID('U_IDOEBSWIFT_File') IS NULL
CREATE TABLE [dbo].[U_IDOEBSWIFT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_IDOEBSWIFT_Import
-----------

IF OBJECT_ID('U_IDOEBSWIFT_Import') IS NULL
CREATE TABLE [dbo].[U_IDOEBSWIFT_Import] (
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
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_IDOEBSWIFT_Raw
-----------

IF OBJECT_ID('U_IDOEBSWIFT_Raw') IS NULL
CREATE TABLE [dbo].[U_IDOEBSWIFT_Raw] (
    [Field1] varchar(max) NULL,
    [Field2] varchar(max) NULL,
    [Field3] varchar(max) NULL,
    [Field4] varchar(max) NULL,
    [Field5] varchar(max) NULL,
    [Field6] varchar(max) NULL,
    [Field7] varchar(max) NULL,
    [Field8] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IDOEBSWIFT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Doe Run Company

Created By: Ritin Sharma
Business Analyst: Harpreet Takhar
Create Date: 10-Feb-2023
Service Request Number: SR-2022-00374393

Purpose: Bswift Deduction Earning Import

NOTE TO SUPPORT: This is an Automated Web Import that uses the Import Tool for Validating/Posting Records

Revision History
----------------
Update By        Date        Request Num        Desc
XXX              XX/XX/20XX  SR-20XX-00000000   XXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'IDOEBSWIFT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'IDOEBSWIFT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'IDOEBSWIFT';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'IDOEBSWIFT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IDOEBSWIFT' ORDER BY RunID DESC;

Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'IDOEBSWIFT', 'STOPDEDS';   -- Process Deduction/Earning STOP
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IDOEBSWIFT', 'ADDCHG'; -- Process Deduction/Earning ADD/CHANGES
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IDOEBSWIFT', 'TESTSTOPS';   -- Test Deduction/Earning STOP
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IDOEBSWIFT', 'TESTADDCHG'; -- Test Deduction/Earning ADD/CHANGES
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IDOEBSWIFT', 'SCH_STOPS';   -- Process Deduction/Earning STOP on schedule
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IDOEBSWIFT', 'SCH_ADDCHG'; -- Process Deduction/Earning ADD/CHANGES on schedule



--For Debugging Start--
select * from U_dsi_BIM_Configuration where FormatCode ='IDOEBSWIFT'
select * from U_dsi_BIM_XML where xmlformatcode='IDOEBSWIFT'
select * from U_dsi_BIM_Processes where bimformatcode='IDOEBSWIFT'
select dbo.dsi_BIM_fn_GetValidateModeSetting()
select * from u_dsi_bim_errors where eFormatcode='IDOEBSWIFT'
select * from U_IDOEBSWIFT_Raw
select * from U_IDOEBSWIFT_Import
select * from U_IDOEBSWIFT_drvTbl
select EEDEEAMT,EEDERAMT,* from U_dsi_BIM_LodEDed where eedformatcode='IDOEBSWIFT'
select * from U_dsi_BIM_LodEEarn where eeeformatcode='IDOEBSWIFT'
exec master.dbo.xp_cmdshell 'dir <Import/ExportPath>'
exec master.dbo.xp_cmdshell '<Bulk Insert Command from bim processes>'
--For Debugging End--

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'IDOEBSWIFT', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --========================================
    -- Declare Variables
    --========================================
    DECLARE  @FormatCode VARCHAR(10)
            ,@ImportPath VARCHAR(1000)
            ,@FileName VARCHAR(1000)
            ,@ExportCode VARCHAR(12)
            ,@EnableStandardWebImport CHAR(1);

    SET @FormatCode = 'IDOEBSWIFT';
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');
    SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);

    --==================================================
    -- Set FileName
    --==================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'DeductionEarningImport_' + LTRIM(RTRIM(ExportCode)) + '_'
                        + CONVERT(CHAR(8),GETDATE(),112)                          -- YYYYMMDD
                        + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMSS
                        + '.csv'
        WHERE FormatCode = @FormatCode;
    END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_IDOEBSWIFT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_IDOEBSWIFT_drvTbl;
    CREATE TABLE dbo.U_IDOEBSWIFT_drvTbl (
         drvSurrogateKey VARCHAR(50) NULL
        ,drvEmployeeNumber VARCHAR(50) NULL
        ,drvEmployeeName VARCHAR(100) NULL
        ,drvSocialSecurityNumber VARCHAR(50) NULL
        ,drvDeductionPlanCode VARCHAR(50) NULL
        ,drvDeductionStartDate VARCHAR(50) NULL
        ,drvDeductionStopDate VARCHAR(50) NULL
        ,drvEEDeductionAmt VARCHAR(50) NULL
        ,drvERDeductionAmt VARCHAR(50) NULL
        ,drvEEDeductionPercent VARCHAR(50) NULL
        ,drvERDeductionPercent VARCHAR(50) NULL
        ,drvPendingEffectiveDate VARCHAR(50) NULL
        ,drvAction VARCHAR(50) NULL
        ,drvError VARCHAR(250) NULL
        ,drvImported TINYINT DEFAULT 0 NOT NULL
        ,drvEEID VARCHAR(12) NULL
        ,drvCOID VARCHAR(5) NULL
        ,drvDedCode VARCHAR(50) NULL
        ,drvEarnCode VARCHAR(50) NULL
        ,drvImportType VARCHAR(50) NULL
        ,drvPendingUpdateID CHAR(20) NULL
        ,drvInitialSort VARCHAR(50) NULL
    );

    --========================================
    -- Benefit Import Module (BIM) Code
    --========================================
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEDUCTION');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*Bswift_BenefitsDed*'); --File Name contains "Deductions"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','8');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','Employee#');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Non-Closed'); --Regular --PayGroup --Non-Closed --Non-Opened

      -- Archive File on the Final Step (Adds/Changes) or while testing in validate-only mode, Otherwise Copy Files
        IF (@ExportCode IN ('STOPDEDS','SCH_STOPS','TESTSTOPS','TESTADDCHG') OR dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        ----------------------------------------------------------
        -- Only Retain Records where SSN in Field# 1 is Numeric
        ----------------------------------------------------------
        DELETE FROM dbo.U_IDOEBSWIFT_Import WHERE RunID = 'DEDUCTION' AND ISNUMERIC(Field1) = 0 AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IDOEBSWIFT_drvTbl (drvError)
       SELECT 'Error Processing Delimited File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================================
    -- If Error During BIM, then Report Error and Stop Processing
    --==============================================================
    IF EXISTS (SELECT 1 FROM dbo.U_IDOEBSWIFT_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
        INSERT INTO dbo.U_IDOEBSWIFT_drvTbl (drvError,drvImported)
        SELECT Error, 2 FROM dbo.U_IDOEBSWIFT_Import WHERE ISNULL(Error,'') <> '';

        -- Stop Processing
        RETURN;
    END;

    --=====================================================================
    -- Flag Earnings in RunID based on Deduction Offset Flag in Field# 19
    --=====================================================================
    UPDATE dbo.U_IDOEBSWIFT_Import
    SET RunID = 'EARNING'
    WHERE LTRIM(RTRIM(Field2)) = 'GTL' -- Deduction OffSet = 'GTL'
    --OR EXISTS (SELECT 1 FROM dbo.EarnCode WITH (NOLOCK) WHERE ErnEarncode = Field2);


    --========================================
    -- Build Driver Table - Error Report
    --========================================
    BEGIN TRY
        IF @ExportCode IN ('STOPDEDS','TESTSTOPS','SCH_STOPS')

        BEGIN
            DELETE FROM dbo.U_IDOEBSWIFT_Import WHERE NULLIF(Field4,'') IS NULL ;
        END ;

        IF @ExportCode IN ('ADDCHG','TESTADDCHG','SCH_ADDCHG')

        BEGIN
            DELETE FROM dbo.U_IDOEBSWIFT_Import WHERE NULLIF(Field4,'') IS NOT NULL ;
        END ;

        INSERT INTO dbo.U_IDOEBSWIFT_drvTbl
        (drvSurrogateKey, drvEmployeeNumber, drvEmployeeName, drvSocialSecurityNumber ,drvDeductionPlanCode ,drvDeductionStartDate,drvDeductionStopDate
        ,drvEEDeductionAmt ,drvERDeductionAmt ,drvEEDeductionPercent ,drvERDeductionPercent ,drvPendingEffectiveDate,drvAction ,drvError,drvImported
        ,drvEEID ,drvCOID,drvDedCode,drvEarnCode ,drvImportType ,drvInitialSort)

        SELECT DISTINCT
         drvSurrogateKey           = RTRIM(EEID) + RTRIM(COID) + Field2
        ,drvEmployeeNumber           = NULLIF(Field1,'')
        ,drvEmployeeName            = RTRIM(EepNameFirst) + SPACE(1) + EepNameLast
        ,drvSocialSecurityNumber   = EepSSN
        ,drvDeductionPlanCode        = NULLIF(Field2,'')
        ,drvDeductionStartDate       = NULLIF(Field3,'')
        ,drvDeductionStopDate        = NULLIF(Field4,'')
        ,drvEEDeductionAmt            = NULLIF(Field5,'')
        ,drvERDeductionAmt            = NULLIF(Field6,'')
        ,drvEEDeductionPercent        = NULLIF(Field7,'')
        ,drvERDeductionPercent        = NULLIF(Field8,'')
        ,drvPendingEffectiveDate   = ''
        ,drvAction                    = CASE WHEN EEID IS NULL THEN 'REJECTED' -- Unable to match [Employee Number] in file
                                          WHEN EecEmplStatus = 'T' THEN 'REJECTED' -- Terminated Employee
                                          WHEN RunID = 'DEDUCTION' AND DedDedCode IS NULL THEN 'REJECTED' --[Deduction Code] Not Setup in UltiPro
                                          WHEN RunID = 'EARNING' AND ErnEarnCode IS NULL THEN 'REJECTED' --[Earning Code] Not Setup in UltiPro
                                          -- Process Add/Change/Restart or Stops for Deductions
                                          WHEN RunID = 'DEDUCTION' THEN
                                               CASE WHEN NULLIF(Field4,'') IS NOT NULL THEN
                                                        CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                                             ELSE 'REJECTED' -- No Benefit Plan for Employee to Stop
                                                        END
                                                    WHEN EedDedCode IS NOT NULL THEN
                                                        CASE WHEN COALESCE(EedStopDate,EedBenStopDate) IS NOT NULL THEN 'RESTART'
                                                             ELSE 'CHANGE'
                                                        END
                                                    ELSE 'ADD'
                                               END
                                          -- Process Add/Change/Restart/Stops for Earnings
                                          WHEN RunID = 'EARNING' THEN
                                               CASE WHEN NULLIF(Field4,'') IS NOT NULL THEN
                                                        CASE WHEN EeeEarnCode IS NOT NULL THEN 'STOP'
                                                             ELSE 'REJECTED' -- No Earning Code for Employee to Stop
                                                        END
                                                    WHEN EeeEarnCode IS NOT NULL THEN
                                                        CASE WHEN EeeStopDate IS NOT NULL THEN 'RESTART'
                                                            ELSE 'CHANGE'
                                                        END
                                                    ELSE 'ADD'
                                               END
                                          -- Reject All Others
                                          ELSE 'REJECTED'
                                              END
        ,drvError                   = CASE WHEN EEID IS NULL THEN 'Record Rejected: Unable to match [Employee Number] in file to Employee in UltiPro.'
                                          WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Terminated Employee - Do Not Process.'
                                          WHEN RunID = 'DEDUCTION' AND DedDedCode IS NULL THEN 'Record Rejected: [Deduction Code] Not Setup in UltiPro. '
                                          WHEN RunID = 'EARNING' AND ErnEarnCode IS NULL THEN 'Record Rejected: [Earning Code] Not Setup in UltiPro. '
                                          WHEN RunID = 'DEDUCTION' AND EedDedCode IS NULL AND NULLIF(Field4,'') IS NOT NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP for Employee in UltiPro.'
                                          WHEN RunID = 'EARNING' AND EeeEarnCode IS NULL AND NULLIF(Field4,'') IS NOT NULL THEN 'Record Rejected: No Earning Code to STOP for Employee in UltiPro.'
                                       END
        ,drvImported                = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                        WHEN EEID IS NULL THEN 2 -- Unable to match [Employee Number] in file
                                        WHEN EecEmplStatus = 'T' THEN 2 -- Terminated Employee
                                        WHEN RunID = 'DEDUCTION' AND DedDedCode IS NULL THEN 2 -- [Deduction Code] Not Setup in UltiPro
                                        WHEN RunID = 'EARNING' AND ErnEarnCode IS NULL THEN 2 -- [Earning Code] Not Setup in UltiPro
                                        WHEN RunID = 'DEDUCTION' AND EedDedCode IS NULL AND NULLIF(Field4,'') IS NOT NULL THEN 2 -- No Benefit Plan for Employee to Stop
                                        WHEN RunID = 'EARNING' AND EeeEarnCode IS NULL AND NULLIF(Field4,'') IS NOT NULL THEN 2-- No Benefit Plan for Employee to Stop
                                        ELSE 0
                                     END
        ,drvEEID                    = EEID
        ,drvCOID                   = COID
        ,drvDedCode                   = CASE WHEN RunID = 'DEDUCTION' THEN DedDedCode END
        ,drvEarnCode                = CASE WHEN RunID = 'EARNING' THEN ErnEarncode END
        ,drvImportType               = RunID
        ,drvInitialSort               = ISNULL(Field1,'')

        FROM dbo.U_IDOEBSWIFT_Import
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
            ON eepEEID = EEID
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCOID = COID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = Field2
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        LEFT JOIN dbo.EarnCode WITH (NOLOCK)
            ON ErnEarncode = Field2 AND NULLIF(Field2,'') = 'GTL'
        LEFT JOIN dbo.EmpEarn WITH (NOLOCK)
            ON EeeEEID = EEID
            AND EeeCoID = COID
            AND EeeEarnCode = ErnEarncode;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IDOEBSWIFT_drvTbl (drvError)
       SELECT 'Error Processing File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --=======================================================
    -- Employee has Multiple Deductions in File
    --=======================================================
    UPDATE dbo.U_IDOEBSWIFT_drvTbl
        SET drvAction = 'REJECTED'
            ,drvError = 'Record Rejected: Employee has Duplicate Deduction Codes in File.'
            ,drvImported = 2
    WHERE drvImported = 0 AND drvImportType = 'DEDUCTION'
    AND drvSurrogateKey IN (SELECT drvSurrogateKey FROM dbo.U_IDOEBSWIFT_drvTbl WHERE drvImported = 0 AND drvImportType = 'DEDUCTION' GROUP BY drvSurrogateKey HAVING COUNT(*) > 1);

    --=======================================================
    -- Employee has Multiple Earnings in File
    --=======================================================
    UPDATE dbo.U_IDOEBSWIFT_drvTbl
        SET drvAction = 'REJECTED'
            ,drvError = 'Record Rejected: Employee has Duplicate Earning Codes in File.'
            ,drvImported = 2
    WHERE drvImported = 0 AND drvImportType = 'EARNING'
    AND drvSurrogateKey IN (SELECT drvSurrogateKey FROM dbo.U_IDOEBSWIFT_drvTbl WHERE drvImported = 0 AND drvImportType = 'EARNING' GROUP BY drvSurrogateKey HAVING COUNT(*) > 1);

    --============================================
    -- Update PendingUpdateID for Valid Records
    --============================================
    UPDATE dbo.U_IDOEBSWIFT_drvTbl
    SET drvPendingUpdateID = LEFT('IDOEBSWIFT' + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --============================================================
    -- Generate XML File for Standard Web Import for Automation
    --============================================================
    BEGIN TRY
        -----------------------------------
        -- Clear BIM Tables by FormatCode
        -----------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;
        DELETE FROM dbo.U_dsi_BIM_LodEEarn WHERE EeeFormatCode = @FormatCode;
        DELETE FROM dbo.U_dsi_BIM_LodEComp WHERE EecFormatCode = @FormatCode;

        --------------------------------------------------------------
        -- Populate Lod Deduction Table (LodEDed) for Deductions
        --------------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEEAmt,EedERAmt
            ,EedBenStartDate,EedBenStatusDate,EedBenStopDate,EedStartDate,EedStopDate,EedBenStatus,EedChangeReason,EedPendingEffDate,EedPendingTransType
            ,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        SELECT DISTINCT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                            WHEN DedEECalcRule = '20' AND NULLIF(drvEEDeductionAmt,'') IS NOT NULL THEN CONVERT(MONEY,drvEEDeductionAmt)
                            ELSE  CONVERT(MONEY,0.00) END
            ,EedERAmt = CASE -- Only Populate for Employer (ER) Flat Amount Calc Rule ('20')
                            WHEN DedERCalcRule = '20' AND NULLIF(drvERDeductionAmt,'') IS NOT NULL THEN CONVERT(MONEY,drvERDeductionAmt)
                            ELSE  CONVERT(MONEY,0.00) END
            ,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
                                    WHEN drvAction IN ('ADD','RESTART','CHANGE') THEN CONVERT(DATETIME,drvDeductionStartDate)
                                    ELSE '12/30/1899'
                                END
            ,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
                                     WHEN drvDeductionStartDate IS NOT NULL AND drvAction = 'CHANGE' THEN CONVERT(DATETIME,drvDeductionStartDate)
                                     ELSE '12/30/1899'
                                END
            ,EedBenStopDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
                                   WHEN drvAction = 'STOP' THEN CONVERT(DATETIME,drvDeductionStopDate)
                                   ELSE '01/01/1900'
                              END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvDeductionStartDate)
                                 ELSE '12/30/1899'
                            END
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(DATETIME,drvDeductionStopDate)
                                ELSE '01/01/1900'
                           END
            ,EedBenStatus = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                 WHEN drvAction = 'STOP' THEN 'T'
                                 ELSE 'A'
                            END
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction = 'STOP' THEN '401'
                                    WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
                               END
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID

        FROM dbo.U_IDOEBSWIFT_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'DEDUCTION';

         --===============================================
        -- Populate Lod Employee Comp Table (LodEComp)
        --===============================================
        INSERT INTO dbo.U_dsi_BIM_LodEComp (EecFormatCode,EecEEID,EecCOID,EecEmpNo,EecCompanyCode,EecPendingEffDate,EecPendingTransType,EecPendingUpdateID,EecSessionID)
        SELECT EecFormatCode = @FormatCode
            ,EecEEID = drvEEID
            ,EecCOID = drvCOID
            ,EecEmpNo = EecEmpNo
            ,EecCompanyCode = CmpCompanyCode
            ,EecPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EecPendingTransType = 'U'
            ,EecPendingUpdateID = drvPendingUpdateID
            ,EecSessionID = @FormatCode
        FROM dbo.U_IDOEBSWIFT_drvTbl WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = drvEEID
            AND EecCOID = drvCOID
        JOIN dbo.Company WITH (NOLOCK)
            ON CmpCOID = drvCOID
        WHERE drvImported = 0
        AND drvImportType = 'EARNING';

        --------------------------------------------------------------
        -- Populate Lod Deduction Table (LodEEarn) for Earnings
        --------------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEEarn (EeeFormatCode,EeeEEID,EeeCoID,EeeEarnCode,EeeAmt,EeeStartDate,EeeStopDate,EeePendingTransType,EeePendingUpdateID)
        SELECT EeeFormatCode = @FormatCode
            ,EeeEEID = drvEEID
            ,EeeCoID = drvCoID
            ,EeeEarnCode = drvEarnCode
            ,EeeAmt = CASE WHEN drvEEDeductionAmt IS NOT NULL THEN CONVERT(DECIMAL(16,6),drvEEDeductionAmt)
                              ELSE EeeAmt
                         END
            ,EeeStartDate = CASE WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN
                                 CASE
                                      WHEN CONVERT(DATETIME,drvDeductionStartDate) < EecDateOfLastHire THEN EecDateOfLastHire
                                      ELSE CONVERT(DATETIME,drvDeductionStartDate)
                                 END
                                 ELSE EeeStartDate
                            END
            ,EeeStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(DATETIME,drvDeductionStopDate) END
            ,EeePendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EeePendingUpdateID = drvPendingUpdateID
        FROM dbo.U_IDOEBSWIFT_drvTbl WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = drvEEID
            AND EecCoID = drvCoID
        JOIN dbo.EarnCode WITH (NOLOCK)
            ON ErnEarnCode = drvEarnCode
        LEFT JOIN dbo.EmpEarn WITH (NOLOCK)
            ON EeeEEID = drvEEID
            AND EeeCoID = drvCoID
            AND EeeEarnCode = drvEarnCode
        WHERE drvImportType = 'EARNING'
            AND drvImported = 0;


        --============================================================
        -- Generate XML File for Web Import Tool
        --============================================================

        DECLARE @XMLFilePath VARCHAR(1000) = CASE
                                                   WHEN @ExportCode IN ('TESTSTOPS','TESTADDCHG') THEN dbo.Dsi_fnVariable(@FormatCode,'ArchivePath')
                                                   ELSE '' --dbo.Dsi_fnVariable(@FormatCode,'ArchivePath')
                                              END
            ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Earnings', @XMLFilePath, @XMLArchiveFilePath;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IDOEBSWIFT_drvTbl (drvError)
       SELECT 'Error Loading Records for Validation/Posting: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

        -----------------------------------------
        -- Create Deduction OffSet For Earnings
        -----------------------------------------
        BEGIN TRY
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() <> 'TRUE')

        DECLARE @RecordCount INT, @LoopCount INT, @EEID VARCHAR(12), @COID VARCHAR(5);
        SET @LoopCount = 1;

        DECLARE @DedOffSet AS TABLE (
            RowID    INT IDENTITY(1,1)
            ,EEID    VARCHAR(12)
            ,COID    VARCHAR(5)
        );

        INSERT INTO @DedOffSet (EEID, COID)
        SELECT DISTINCT drvEEID, drvCOID
        FROM dbo.U_IDOEBSWIFT_drvTbl WITH (NOLOCK)
        WHERE drvImported = 0 AND drvImportType = 'EARNING';

        SET @RecordCount = @@ROWCOUNT;

        -- Create Deduction Offset for Each Employee
        WHILE @LoopCount <= @RecordCount
        BEGIN
            -- Get EEID, COID for Each Employee
            SELECT @EEID = EEID, @COID = COID
            FROM @DedOffSet WHERE RowID = @LoopCount

            -- Create Deduction Offset
            PRINT 'Create Deduction Offset'
            PRINT '@EEID: ' + ISNULL(@EEID,'')
            PRINT '@COID: ' + ISNULL(@COID,'')
            EXEC dbo.sp_usg_AddOffSettingDeductions @EEID, @COID;

            -- Update Loop Count
            SET @LoopCount = @LoopCount + 1;
        END
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IDOEBSWIFT_drvTbl (drvError)
       SELECT 'Error Processing Earnings in UltiPro: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --=======================
    -- Report Successful
    --=======================
    UPDATE dbo.U_IDOEBSWIFT_drvTbl
        SET drvError =  CASE
                            WHEN @ExportCode IN ('TESTSTOPS','TESTADDCHG') THEN 'Test Only - Loaded Successfully in Staging'
                            ELSE 'Loaded Successfully'
                       END
            ,drvImported = 1
    WHERE drvImported = 0
    AND
        (
            (drvImportType = 'DEDUCTION' AND EXISTS (SELECT 1 FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID))
            OR
            (drvImportType = 'EARNING' AND EXISTS (SELECT 1 FROM dbo.U_dsi_BIM_LodEEarn WHERE EeeFormatCode = @FormatCode AND EeePendingUpdateID = drvPendingUpdateID))
        );

    --============================
    -- Reject Remaining Records
    --============================
    UPDATE dbo.U_IDOEBSWIFT_drvTbl
        SET drvError = CASE
                            WHEN @ExportCode IN ('TESTSTOPS','TESTADDCHG') THEN 'Test Only - Record Rejected in Staging'
                            ELSE 'Record Rejected'
                       END
            ,drvAction = 'REJECTED'
            ,drvImported = 2
    WHERE drvImported = 0;

END
/**********************************************************************************

--Create the View
CREATE VIEW dbo.dsi_vwIDOEBSWIFT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IDOEBSWIFT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = 'IDOEBSWIFT')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201901011'
       ,ExpStartPerControl     = '201901011'
       ,ExpLastEndPerControl   = '201901019'
       ,ExpEndPerControl       = '201901019'
WHERE ExpFormatCode = 'IDOEBSWIFT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwIDOEBSWIFT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IDOEBSWIFT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'IDOEBSWIFT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'IDOEBSWIFT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'IDOEBSWIFT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IDOEBSWIFT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'IDOEBSWIFT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IDOEBSWIFT', 'UseFileName', 'V', 'Y'


-- End ripout