/**********************************************************************************

IVANG401LN: Vanguard 401k Deferral and Loan Import

FormatCode:     IVANG401LN
Project:        Vanguard 401k Deferral and Loan Import
Client ID:      WAS1002
Date/time:      2023-03-28 20:08:00.400
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ12
Server:         EZ1SUP2ST01
Database:       ULTIPRO_WIS
Web Filename:   WAS1002_94935_EEHISTORY_IVANG401LN_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\Ez\Public\10047\Imports_Test\Vanguard\Archive\
ExportPath:    
ImportPath:    \\us.saas\Ez\Public\10047\Imports_Test\Vanguard\
TestPath:      
XmlPath:       \\us.saas\EZ\Public\10047\Imports_Test\Vanguard\XML\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_IVANG401LN_SavePath') IS NOT NULL DROP TABLE dbo.U_IVANG401LN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'IVANG401LN'


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
WHERE FormatCode = 'IVANG401LN'
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
WHERE ExpFormatCode = 'IVANG401LN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'IVANG401LN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'IVANG401LN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'IVANG401LN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'IVANG401LN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'IVANG401LN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'IVANG401LN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'IVANG401LN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'IVANG401LN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'IVANG401LN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'IVANG401LN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_fn_IVANG401LN_GetNextOrActiveLoanCode') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_IVANG401LN_GetNextOrActiveLoanCode];
GO
IF OBJECT_ID('dsi_vwIVANG401LN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwIVANG401LN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_IVANG401LN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IVANG401LN];
GO
IF OBJECT_ID('U_IVANG401LN_Raw') IS NOT NULL DROP TABLE [dbo].[U_IVANG401LN_Raw];
GO
IF OBJECT_ID('U_IVANG401LN_PayGroup') IS NOT NULL DROP TABLE [dbo].[U_IVANG401LN_PayGroup];
GO
IF OBJECT_ID('U_IVANG401LN_Import') IS NOT NULL DROP TABLE [dbo].[U_IVANG401LN_Import];
GO
IF OBJECT_ID('U_IVANG401LN_File') IS NOT NULL DROP TABLE [dbo].[U_IVANG401LN_File];
GO
IF OBJECT_ID('U_IVANG401LN_EEList') IS NOT NULL DROP TABLE [dbo].[U_IVANG401LN_EEList];
GO
IF OBJECT_ID('U_IVANG401LN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_IVANG401LN_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N',NULL,'Y','0',NULL,NULL,'N',NULL,'N','E','013010','BENEFITIMP','SDF','IVANG401LN','Vanguard 401k Deferral and Loan Import','N','I','FORM_ASCIIIMPORTBENEFITS','N','N',dbo.fn_GetTimedKey(),'D',NULL,'S','N','IVANG401LNZ1','N',NULL,'N',NULL,'N',NULL,'N');
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','IVANG401LN','Vanguard 401k Deferral and Loan Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','IVANG401LNZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IVANG401LNZ0','50','H','01','1',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IVANG401LNZ0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IVANG401LNZ0','50','H','01','3',NULL,'Deduction Code',NULL,NULL,'"Deduction Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IVANG401LNZ0','50','H','01','4',NULL,'Contribution Percent',NULL,NULL,'"Contribution Percent"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IVANG401LNZ0','50','H','01','5',NULL,'Contribution Amount',NULL,NULL,'"Contribution Amount "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IVANG401LNZ0','50','H','01','6',NULL,'Loan Payment Amount',NULL,NULL,'"Loan Payment Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IVANG401LNZ0','50','H','01','7',NULL,'Loan Goal Amount',NULL,NULL,'"Loan Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IVANG401LNZ0','50','H','01','8',NULL,'Loan Type',NULL,NULL,'"Loan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IVANG401LNZ0','50','H','01','9',NULL,'Import Type',NULL,NULL,'"Import Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IVANG401LNZ0','50','H','01','10',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IVANG401LNZ0','50','H','01','11',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IVANG401LNZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IVANG401LNZ0','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IVANG401LNZ0','50','D','10','3',NULL,'Deduction Code',NULL,NULL,'"drvDeductionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IVANG401LNZ0','50','D','10','4',NULL,'Contribution Percent',NULL,NULL,'"drvContributionPercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IVANG401LNZ0','50','D','10','5',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IVANG401LNZ0','50','D','10','6',NULL,'Loan Payment Amount',NULL,NULL,'"drvLoanPaymentAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IVANG401LNZ0','50','D','10','7',NULL,'Loan Goal Amount',NULL,NULL,'"drvLoanGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IVANG401LNZ0','50','D','10','8',NULL,'Loan Type',NULL,NULL,'"drvLoanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IVANG401LNZ0','50','D','10','9',NULL,'Import Type',NULL,NULL,'"drvImportType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IVANG401LNZ0','50','D','10','10',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IVANG401LNZ0','250','D','10','11',NULL,'Error',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'IVANG401LN_20230328.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','BHQNN',NULL,NULL,NULL,'Vanguard Deferral Import','201806019','EMPEXPORT','DEF_IMPORT','Jun  1 2018 10:26AM','IVANG401LN',NULL,NULL,NULL,'202209099','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202209021',NULL,'','','201806011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','BHQNN',NULL,NULL,NULL,'Vanguard Loan Add/Change','201806019','EMPEXPORT','LOAN_ADDCH','Jun  1 2018 10:26AM','IVANG401LN',NULL,NULL,NULL,'202209099','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202209021',NULL,'','','201806011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','BHQNN',NULL,NULL,NULL,'Vanguard Loan Stop','201806019','EMPEXPORT','LOAN_STOP','Jun  1 2018 10:26AM','IVANG401LN',NULL,NULL,NULL,'202209099','Jun  1 2018 12:00AM','Dec 30 1899 12:00AM','202209021',NULL,'','','201806011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------

INSERT INTO [dbo].[AscImp] (impCOID,impDateAccruedThru,impDateOfRollover,impDatePendingMoved,impDesc,impEEIdentifier,impEngine,impExceptions,impFormatCode,impImportCode,impImported,impPayPeriodID,impPosted,impReset,impSessionType,impSource,impSystemID,impUser,impValid,impVerified) VALUES ('',NULL,NULL,NULL,'Vanguard 401k Deferral & Loan','E','BENEFITIMP',NULL,'IVANG401LN','IVANG401LN',NULL,NULL,'Jun  1 2018 10:36AM','Jun  1 2018 10:39AM',NULL,'VALIDATE / POST / RESET ONLY (DO NOT CLICK IMPORT)',dbo.fn_GetTimedKey(),'ULTI',NULL,'Jun  1 2018 10:36AM');

-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','ArchivePath','V','\\us.saas\Ez\Public\10047\Imports_Test\Vanguard\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','ImportPath','V','\\us.saas\Ez\Public\10047\Imports_Test\Vanguard\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','UseFileName','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IVANG401LN','XmlPath','V','\\us.saas\EZ\Public\10047\Imports_Test\Vanguard\XML\');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IVANG401LN','D10','dbo.U_IVANG401LN_drvTbl (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_IVANG401LN_drvTbl
-----------

IF OBJECT_ID('U_IVANG401LN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_IVANG401LN_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvEmployeeNumber] varchar(10) NULL,
    [drvEmployeeName] varchar(50) NULL,
    [drvSSN] varchar(11) NULL,
    [drvDeductionCode] varchar(5) NULL,
    [drvPayPeriod] varchar(1) NULL,
    [drvBenefitStatus] varchar(1) NULL,
    [drvBenefitStatusDate] varchar(10) NULL,
    [drvBenefitStartDate] varchar(10) NULL,
    [drvEEEligDate] varchar(10) NULL,
    [drvBenefitStopDate] varchar(10) NULL,
    [drvDeductionStartDate] varchar(10) NULL,
    [drvDeductionStopDate] varchar(10) NULL,
    [drvContributionPercent] varchar(16) NULL,
    [drvContributionAmount] varchar(10) NULL,
    [drvEmployerPercent] varchar(10) NULL,
    [drvEmployerAmount] varchar(10) NULL,
    [drvBenefitOption] varchar(10) NULL,
    [drvBenefitAmount] varchar(16) NULL,
    [drvBenefitChangeReason] varchar(3) NULL,
    [drvLoanNumber] varchar(20) NULL,
    [drvLoanPaymentAmount] varchar(16) NULL,
    [drvLoanGoalAmount] varchar(16) NULL,
    [drvLoanType] varchar(20) NULL,
    [drvAction] varchar(20) NULL,
    [drvError] varchar(250) NULL,
    [drvImported] int NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvImportType] varchar(20) NULL,
    [EedBenStartDate] datetime NULL,
    [EedEEEligDate] datetime NULL,
    [EecDateOfBenefitSeniority] datetime NULL,
    [drvStopDate] char(10) NULL,
    [drvPeriodStartDate] char(10) NULL,
    [drvPendingUpdateID] varchar(20) NULL,
    [drvSession] varchar(10) NULL,
    [drvInitialSort] varchar(20) NULL,
    [drvSubSort] varchar(50) NULL
);

-----------
-- Create table U_IVANG401LN_EEList
-----------

IF OBJECT_ID('U_IVANG401LN_EEList') IS NULL
CREATE TABLE [dbo].[U_IVANG401LN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_IVANG401LN_File
-----------

IF OBJECT_ID('U_IVANG401LN_File') IS NULL
CREATE TABLE [dbo].[U_IVANG401LN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_IVANG401LN_Import
-----------

IF OBJECT_ID('U_IVANG401LN_Import') IS NULL
CREATE TABLE [dbo].[U_IVANG401LN_Import] (
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
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_IVANG401LN_PayGroup
-----------

IF OBJECT_ID('U_IVANG401LN_PayGroup') IS NULL
CREATE TABLE [dbo].[U_IVANG401LN_PayGroup] (
    [pEEID] varchar(12) NULL,
    [pCOID] varchar(5) NULL,
    [pPayGroup] char(6) NULL,
    [pPerControl] char(9) NULL,
    [pPayPerStartDate] datetime NULL,
    [pPayPerEndDate] datetime NULL
);

-----------
-- Create table U_IVANG401LN_Raw
-----------

IF OBJECT_ID('U_IVANG401LN_Raw') IS NULL
CREATE TABLE [dbo].[U_IVANG401LN_Raw] (
    [Data] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IVANG401LN]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Washington Inventory Service

Created By: Pooja Gupta
Business Analyst: Josh Smith
Create Date: 05/20/2016
Service Request Number: SR-2021-00330971

Purpose: Vanguard 401k Deferral and Loan Import

Revision History
----------------
Update By           Date            Request Num         Desc
XXXXXXXXXXXX    XX/XX/XXXX        SR-2022-XXXXXX           XXXXXX

--DELETE FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IVANG401LN' AND Locked = 1;

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'IVANG401LN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'IVANG401LN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'IVANG401LN';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'IVANG401LN';
SELECT * FROM dbo.AscImp WHERE ImpFormatCode = 'IVANG401LN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IVANG401LN' ORDER BY DateTimeStamp DESC;


--EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'Testing', 'V',  'Y'
--EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'XmlPath', 'V',  '\\us.saas\N1\Public\10047\Imports\Vanguard\XML\'

--EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'Testing', 'V',  'N'
--EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'XmlPath', 'V',  NULL


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IVANG401LN', 'LOAN_STOP';   --Does Not Archive File
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IVANG401LN', 'DEF_IMPORT';  --Does Not Archive File
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IVANG401LN', 'LOAN_ADDCH';  --Archives if dbo.dsi_BIM_fn_GetValidateModeSetting() <> 'TRUE'

dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'IVANG401LN', @AllObjects = 'Y', @IsWeb = 'Y';
**********************************************************************************/
BEGIN

    /***********************
        DECLARE VARIABLES
    ************************/
    DECLARE    @SrcPath VARCHAR(200),
               @ImportPath VARCHAR(100),
               @FileName VARCHAR(100),
               @BulkIns VARCHAR(500),
               @dbName VARCHAR(25),
               @v_ServerName VARCHAR(60),
               @ExportCode VARCHAR(12),
               @FormatCode VARCHAR(10);

    SET @FormatCode = 'IVANG401LN'
    SET @v_ServerName = RTRIM(@@SERVERNAME);
    SET @dbName = RTRIM(DB_NAME());
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');
    SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);

    -- Remove FilePath from @FileName, If Exists
    IF (CHARINDEX('\',REVERSE(@FileName)) > 0)
        SET @FileName = REVERSE(LEFT(REVERSE(@FileName),CHARINDEX('\',REVERSE(@FileName))-1));
    
    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_IVANG401LN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_IVANG401LN_drvTbl;

    CREATE TABLE dbo.U_IVANG401LN_drvTbl (
    drvSurrogateKey varchar(50) NULL,
    drvEmployeeNumber varchar(10) NULL,
    drvEmployeeName varchar(50) NULL,
    drvSSN varchar(11) NULL,
    drvDeductionCode varchar(5) NULL,
    drvPayPeriod VARCHAR(1) NULL,
    drvBenefitStatus varchar(1) NULL,
    drvBenefitStatusDate varchar(10) NULL,
    drvBenefitStartDate varchar(10) NULL,
    drvEEEligDate varchar(10) NULL,
    drvBenefitStopDate varchar(10) NULL,
    drvDeductionStartDate varchar(10) NULL,
    drvDeductionStopDate varchar(10) NULL,
    drvContributionPercent varchar(16) NULL,
    drvContributionAmount varchar(10) NULL,
    drvEmployerPercent varchar(10) NULL,
    drvEmployerAmount varchar(10) NULL,
    drvBenefitOption varchar(10) NULL,
    drvBenefitAmount varchar(16) NULL,
    drvBenefitChangeReason varchar(3)  NULL,
    drvLoanNumber varchar(20) NULL,
    drvLoanPaymentAmount varchar(16) NULL,
    drvLoanGoalAmount varchar(16) NULL,
    drvLoanType varchar(20) NULL,
    drvAction varchar(20) NULL,
    drvError varchar(250) NULL,
    drvImported int NOT NULL,
    drvEEID char(12) NULL,
    drvCOID char(5) NULL,
    drvImportType varchar(20) NULL,
    EedBenStartDate datetime NULL,
    EedEEEligDate datetime NULL,
    EecDateOfBenefitSeniority datetime NULL,
    drvStopDate char(10) NULL,
    drvPeriodStartDate char(10) NULL,
    drvPendingUpdateID varchar(20) NULL,
    drvSession varchar(10) NULL,
    drvInitialSort varchar(20) NULL,
    drvSubSort varchar(50) NULL
    );

    --================================================
    -- Benefit Import Module (BIM) Code - Deferrals
    --================================================
    IF (@ExportCode = 'DEF_IMPORT') 
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEFERRAL');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*pdp9298201*');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileFormat','Fixed');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','23');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field6','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- Fixed Length File Format
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',1,1,1,'Record ID');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',2,2,6,'Plan ID');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',3,8,10,'Division ID');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',4,18,10,'Payroll Code 1');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',5,28,10,'Payroll Code 2');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',6,38,9,'Participant ID (Participant Social Security Number)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',7,47,15,'Employee Number');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',8,62,8,'Change Effective Date');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',9,70,3,'Source Type');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',10,73,5,'Contribution Percent');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',11,78,8,'Suspension End Date');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',12,86,8,'Eligibility Date');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',13,94,30,'Participant Name');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',14,124,8,'Plan Entry Date');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',15,132,2,'Suspension Reason Code: Activity (1)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',16,134,3,'Suspension Reason Code: Subactivity (1)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',17,137,2,'Suspension Reason Code: Activity (2)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',18,139,3,'Suspension Reason Code: Subactivity (2)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',19,142,2,'Suspension Reason Code: Activity (3)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',20,144,3,'Suspension Reason Code: Subactivity (3)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',21,147,1,'Participant Auto Conversion Flag');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',22,148,1,'Contribution Eligibility Status');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',23,149,32,'FILLER');
        
        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE' OR @ExportCode = 'DEF_IMPORT')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        ---------------------------------------------------------------------
        -- Only Retain Records where Field# 1 (Record ID) = '2' (Deferral)
        ---------------------------------------------------------------------
        DELETE FROM dbo.U_IVANG401LN_Import WHERE RunID = 'DEFERRAL' AND Field1 <> '2' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVANG401LN_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Deferral Delimited File (BIM): ' + ISNULL(ERROR_MESSAGE(),''), 2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --================================================
    -- Benefit Import Module (BIM) Code - Loans
    --================================================
    IF (@ExportCode IN ('LOAN_ADDCH','LOAN_STOP')) 
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        --INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'AddToPreviousRun','Y');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','LOAN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*pdp9298201*'); --File Name contains "Loan"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileFormat','Fixed');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','24'); --MAX Fields across All Layouts
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field3','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- Fixed Length File Format
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',1,1,6,'Plan ID');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',2,7,10,'Location ID');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',3,17,9,'Participant ID (Participant SSN)');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',4,26,3,'Loan Number');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',5,29,11,'Loan Payment Amount');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',6,40,11,'Loan Principal and Interest');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',7,51,7,'Interest Rate');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',8,58,6,'Loan Issue Date/start date');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',9,64,5,'Original Number of Payments');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',10,69,11,'Last Payment Amount');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',11,80,13,'Employee Number');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',12,93,1,'Payment Frequency');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',13,94,30,'Name');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',14,124,1,'UDF Text Indicator');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',15,125,11,'Loan Original Amount');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',16,136,11,'Loan Expected Interest');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',17,147,4,'Employee Payroll Code');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',18,151,11,'Client UDF Cash / Goal Amount');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',19,162,10,'Client UDF Text');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',20,172,1,'Loan Type');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',21,173,6,'Filler');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',22,179,1,'Loan issue date century indicator');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',23,180,1,'Loan Payoff Date Century Indicator');

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE' OR @ExportCode = 'LOAN_STOP' OR dbo.dsi_fnVariable('IVANG401LN', 'Testing') = 'Y')  --DLC Added Testing check
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        --------------------------------------------------------------------
        -- Only Retain Records where Field# 1 (Plan ID) = '091509' (Loan)
        --------------------------------------------------------------------
        DELETE FROM dbo.U_IVANG401LN_Import WHERE RunID = 'LOAN' AND Field1 <> '092982' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVANG401LN_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Loan Fixed File (BIM): ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================================
    -- If Error During BIM, then Report Error and Stop Processing
    --==============================================================
    IF EXISTS (SELECT 1 FROM dbo.U_IVANG401LN_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
        INSERT INTO dbo.U_IVANG401LN_drvTbl (drvError,drvImported)
        SELECT Error, 2 FROM dbo.U_IVANG401LN_Import WHERE ISNULL(Error,'') <> '';

        -- Stop Processing
        RETURN;
    END;

    /***************************************
        Build Driver Table - Error Report
    ****************************************/

    --===================================================
    -- Load Deferral (401K / Roth) Information
    -- select * from dbo.U_IVANG401LN_Import WHERE RunID = 'DEFERRAL'
    --===================================================
    IF (@ExportCode IN  ('DEF_IMPORT'))
    BEGIN TRY
        IF OBJECT_ID('U_IVANG401LN_drvTbl') IS NOT NULL
            DROP TABLE dbo.U_IVANG401LN_drvTbl;
        SELECT DISTINCT
             drvSurrogateKey = CONVERT(VARCHAR(50),RTRIM(EEID) + RTRIM(COID))
            ,drvEmployeeNumber = CONVERT(VARCHAR(10),EecEmpNo)
            ,drvEmployeeName = CONVERT(VARCHAR(50),RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast))
            ,drvSSN = CONVERT(VARCHAR(11),Field6)
            ,drvDeductionCode = CASE    WHEN Field9 = 'AAA' THEN '401P'
                                        WHEN Field9 = 'NRB' THEN '401PO'
                                        ELSE null
                                END
            ,drvPayPeriod = CONVERT(VARCHAR(1),EecPayPeriod)
            ,drvBenefitStatus = CAST('A' AS VARCHAR(1))
            ,drvBenefitStatusDate = CASE    WHEN EedDedCode IS NULL AND CONVERT(DECIMAL(10,6),Field10) > 0 THEN CONVERT(VARCHAR(10), CONVERT(DATETIME,Field8) ,101)
                                            WHEN EedDedCode IS NOT NULL AND EedBenStartDate < EecDateOfBenefitSeniority THEN CONVERT(VARCHAR(10),EecDateOfBenefitSeniority,101)
                                            ELSE '12/30/1899'
                                    END
            ,drvBenefitStartDate =  CASE    WHEN EedDedCode IS NULL AND CONVERT(DECIMAL(10,6),Field10) > 0 THEN CONVERT(VARCHAR(10), CONVERT(DATETIME,Field8) ,101)
                                            WHEN EedDedCode IS NOT NULL AND EedBenStartDate < EecDateOfBenefitSeniority THEN CONVERT(VARCHAR(10),EecDateOfBenefitSeniority,101)
                                            ELSE '12/30/1899'
                                    END
            ,drvEEEligDate=            CASE    WHEN EedDedCode IS NULL AND CONVERT(DECIMAL(10,6),Field10) > 0 THEN null
                                            WHEN EedDedCode IS NOT NULL AND EedEEEligDate < EecDateOfBenefitSeniority THEN CONVERT(VARCHAR(10),EecDateOfBenefitSeniority,101)
                                            ELSE '12/30/1899'
                                    END
            ,drvBenefitStopDate =    CONVERT(VARCHAR(10),'01/01/1900')  -- Always null.  A stopped ded will have a 0 percentage
            ,drvDeductionStartDate =CASE    WHEN EedStartDate IS NULL AND CONVERT(DECIMAL(10,6),Field10) > 0 THEN CONVERT(VARCHAR(10), PayPeriodStartDate ,101)
                                            ELSE '12/30/1899'
                                    END
            ,drvDeductionStopDate = CONVERT(VARCHAR(10),'01/01/1900')  -- Always null.  A stopped ded will have a 0 percentage
            ,drvContributionPercent=CONVERT(VARCHAR(16),  CONVERT(DECIMAL(16,6),Field10)/100)
            ,drvContributionAmount =CONVERT(VARCHAR(10),null)
            ,drvEmployerPercent =    CONVERT(VARCHAR(10),null)
            ,drvEmployerAmount =    CONVERT(VARCHAR(10),null)
            ,drvBenefitOption =        CONVERT(VARCHAR(10),NULL)
            ,drvBenefitAmount =        CONVERT(VARCHAR(16),null)
            ,drvBenefitChangeReason=CASE    WHEN EedDedCode IS NULL THEN '400' ELSE '402' END
            ,drvLoanNumber = CONVERT(VARCHAR(20),NULL)
            ,drvLoanPaymentAmount = CONVERT(VARCHAR(16),NULL)
            ,drvLoanGoalAmount = CONVERT(VARCHAR(16),null)
            ,drvLoanType = CONVERT(VARCHAR(20),NULL)
            ,drvAction = CONVERT(VARCHAR(20),
                         CASE
                            WHEN NULLIF(Field6,'') IS NULL THEN 'REJECTED'
                            WHEN EEID IS NULL THEN 'REJECTED'
                            WHEN EedDedCode IS NOT NULL AND CONVERT(INT,Field10) = 0 AND EedEECalcRateOrPct = 0 THEN 'REJECTED'
                            WHEN EecEmplStatus <> 'T' THEN
                                CASE
                                    WHEN EedDedCode IS NOT NULL AND CONVERT(INT,Field10) = 0 THEN 'STOP'
                                    WHEN EedDedCode IS NOT NULL AND CONVERT(INT,Field10) > 0 THEN 'CHANGE'
                                    ELSE 'ADD'
                                END
                            ELSE 'REJECTED'
                         END)
            ,drvError = CONVERT(VARCHAR(250),
                        CASE
                            WHEN NULLIF(Field6,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                            WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                            WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                            WHEN EedDedCode IS NOT NULL AND CONVERT(INT,Field10) = 0 AND EedEECalcRateOrPct = 0 THEN 'Record Rejected: Deduction already stopped.'
                            WHEN EedDedCode IS NULL AND CONVERT(INT,Field10) = 0 THEN 'DELETE'
                            ELSE null
                        END)
            ,drvImported = CASE    -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN EecEmplStatus = 'T' THEN 2
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvImportType = CONVERT(VARCHAR(20),RunID)
            ,EedBenStartDate
            ,EedEEEligDate
            ,EecDateOfBenefitSeniority
            ,drvStopDate = CONVERT(CHAR(10),COALESCE(EedBenStopDate,EedStopDate),101)
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvPendingUpdateID = CONVERT(VARCHAR(20),NULL)
            ,drvSession=    CAST('IVANGDEF' AS VARCHAR(10))
            ,drvInitialSort = CONVERT(VARCHAR(20), Field2)
        INTO    dbo.U_IVANG401LN_drvTbl
        FROM    dbo.U_IVANG401LN_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
                ON    EecEEID = EEID
                AND EecCoID = COID
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
                ON    eepEEID = EEID
        LEFT JOIN dbo.Company WITH (NOLOCK)
                ON    CmpCoID = COID
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
                ON    EedEEID = EEID
                AND EedCoID = COID
                AND EedDedCode = ISNULL(CASE    WHEN Field9 = 'AAA' THEN '401P'
                                                WHEN Field9 = 'NRB' THEN '401PO'
                                        END , '')
        WHERE RunID = 'DEFERRAL';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVANG401LN_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Deferral File: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    -- select * from dbo.U_IVANG401LN_DrvTbl order by drvError

    -------------
    -- Delete record when employee has never had the deduction and the amount is 0
    ------------
     DELETE    dbo.U_IVANG401LN_drvTbl
     WHERE    ISNULL(drvError,'') = 'Delete' ;

    ----------
    -- Update the Pending Update ID and SurrogateKey
    ----------
    UPDATE    dbo.U_IVANG401LN_DrvTbl
    SET
             drvPendingUpdateID = 'DEFERL' + dbo.fn_GetTimedKey() 
            ,drvSurrogateKey=      drvSurrogateKey + drvDeductionCode
    WHERE
            ISNULL(drvError,'') = '' 
            AND drvImportType = 'DEFERRAL' ;

    --===================================================
    -- Load 401K Loan Information
    -- select * from u_ivang401LN_Import WHERE RunID = 'LOAN'
    --===================================================
    IF (@ExportCode IN  ('LOAN_ADDCH','LOAN_STOP'))
    BEGIN TRY
        INSERT INTO dbo.U_IVANG401LN_drvTbl(drvSurrogateKey,drvEmployeeNumber,drvEmployeeName,drvSSN,drvDeductionCode,drvPayPeriod,drvBenefitStatus,drvBenefitStatusDate,drvBenefitStartDate,drvEEEligDate
            ,drvBenefitStopDate,drvDeductionStartDate,drvDeductionStopDate,drvContributionPercent,drvContributionAmount,drvEmployerPercent,drvEmployerAmount,drvBenefitOption
            ,drvBenefitAmount,drvBenefitChangeReason,drvLoanNumber,drvLoanPaymentAmount,drvLoanGoalAmount,drvLoanType,drvAction,drvError,drvImported,drvEEID,drvCOID
            ,drvImportType,EedBenStartDate,EedEEEligDate,EecDateOfBenefitSeniority,drvStopDate,drvPeriodStartDate,drvPendingUpdateID,drvSession, drvInitialSort)
        SELECT DISTINCT
             drvSurrogateKey =        CONVERT(VARCHAR(50),RTRIM(EEID) + RTRIM(COID))
            ,drvEmployeeNumber =    CONVERT(VARCHAR(10),EecEmpNo)
            ,drvEmployeeName =        CONVERT(VARCHAR(50),RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast))
            ,drvSSN =                CONVERT(VARCHAR(11),Field3)
            ,drvDeductionCode =       NULL 
            ,drvPayPeriod = CONVERT(VARCHAR(1),EecPayPeriod)
            ,drvBenefitStatus =        null
            ,drvBenefitStatusDate = null
            ,drvBenefitStartDate =    null
            ,drvEEEligDate =        null
            ,drvBenefitStopDate =    null
            ,drvDeductionStartDate= CASE    WHEN EedDedCode IS NULL AND CONVERT(DECIMAL(10,2),Field5)/100 > 0 AND Field20 NOT IN ('D','M','F') THEN CONVERT(VARCHAR(10), PayPeriodStartDate ,101)
                                            ELSE '12/30/1899'
                                    END
            ,drvDeductionStopDate =    CASE    WHEN Field20 IN ('D','M','F') THEN CONVERT(VARCHAR(10), DATEADD(Day, -1, PayPeriodStartDate) ,101)
                                            ELSE '01/01/1900'
                                    END
            ,drvContributionPercent=null
            ,drvContributionAmount= null
            ,drvEmployerPercent =    null
            ,drvEmployerAmount =    null
            ,drvBenefitOption =        null
            ,drvBenefitAmount =        null
            ,drvBenefitChangeReason=CASE    WHEN EedDedCode IS NULL THEN '400' ELSE '402' END
            ,drvLoanNumber =        CONVERT(VARCHAR(5), Field4)
            ,drvLoanPaymentAmount = CONVERT(DECIMAL(10,2),Field5)/100
            ,drvLoanGoalAmount =    null
            ,drvLoanType =            Field20
            ,drvAction = CONVERT(VARCHAR(20),
                         CASE
                            WHEN NULLIF(Field3,'') IS NULL THEN 'REJECTED'
                            WHEN EEID IS NULL THEN 'REJECTED'
                            WHEN EecEmplStatus <> 'T' THEN
                                CASE
                                    WHEN Field20 IN ('D','M','F') THEN 'STOP'
                                    WHEN Field20 IN ('C') AND EedDedCode IS NOT NULL THEN 'CHANGE'
                                    WHEN Field20 IN ('N') THEN 'ADD'
                                END
                            ELSE 'REJECTED'
                         END)
            ,drvError = CONVERT(VARCHAR(250),
                        CASE
                            WHEN NULLIF(Field3,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                            WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                            WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                        END)
            ,drvImported = CASE    -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN EecEmplStatus = 'T' THEN 2
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvImportType = CONVERT(VARCHAR(20),RunID)
            ,EedBenStartDate
            ,EedEEEligDate
            ,EecDateOfBenefitSeniority
            ,drvStopDate = CONVERT(CHAR(10),EedStopDate,101)
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvPendingUpdateID = null
            ,drvSession=    null
            ,drvInitialSort = CONVERT(VARCHAR(20), Field3)
        FROM dbo.U_IVANG401LN_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
            ON eepEEID = EEID
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode IN  ('401L1','401L2','401W1','401W2')
        WHERE RunID = 'LOAN';

    -- select * from U_IVANG401LN_Import where RunID = 'LOAN'

        --Remove Add/Change records from stop session
    DELETE dbo.U_IVANG401LN_drvTbl 
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction <> 'STOP' 
        AND @ExportCode IN ('LOAN_STOP');

    --Remove STOP loan records from adds/changes session
    DELETE dbo.U_IVANG401LN_drvTbl 
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'STOP' 
        AND @ExportCode IN ('LOAN_ADDCH');
        
        --Loan Recycling Code Starts
    
    DECLARE @LoanCodesPAY1 VARCHAR(MAX),
            @LoanCodesPAY2 VARCHAR(MAX)
    
    SET @LoanCodesPAY1 = '401L1,401L2' 
    SET @LoanCodesPAY2 = '401W1,401W2' 

    --======================
    --Stop Session Updates
    --======================
    --Step 1. Match Stop Records to active EE loan
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvDeductionCode = EedDedCode
    FROM dbo.U_IVANG401LN_drvTbl 
    JOIN dbo.DedCode WITH (NOLOCK)
         ON DedDedCode IN ('401L1','401L2','401W1','401W2' )
    JOIN dbo.EmpDed (NOLOCK)
        ON EedEEID = drvEEID
        AND EedCoID = drvCoID
        AND EedDedCode = DedDedCode
        AND LTRIM(RTRIM(EedEEMemberOrCaseNo)) = LTRIM(RTRIM(drvLoanNumber))
    WHERE drvAction = 'STOP' AND drvImported = 0 AND drvImportType = 'LOAN';

    --Step 2. Reject Stop records with no deduction code after previous step
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvError = 'Stop Record Rejected: Loan ID on file did not match the Member/Case Number field of any existing loan deduction code for this employee.'
        ,drvAction = 'REJECTED'
        ,drvImported = 2
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'STOP' AND drvImported = 0 AND drvImportType = 'LOAN' AND ISNULL(drvDeductionCode,'') = '';


    --======================
    --Add/Change Session Updates
    --======================
    --Step 1. Match Change Records to active EE loan
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvDeductionCode = EedDedCode
    FROM dbo.U_IVANG401LN_drvTbl 
    JOIN dbo.DedCode WITH (NOLOCK)
         ON DedDedCode IN ('401L1','401L2','401W1','401W2')
    JOIN dbo.EmpDed (NOLOCK)
        ON EedEEID = drvEEID
        AND eedCoID = drvCoID
        AND EedDedCode = DedDedCode
        AND LTRIM(RTRIM(EedEEMemberOrCaseNo)) = LTRIM(RTRIM(drvLoanNumber))
    --JOIN dbo.fn_ListToTable(@LoanCodes)
        --ON item = EedDedCode
    WHERE drvAction = 'CHANGE' AND drvImported = 0 AND drvImportType = 'LOAN';

    --Step 2. Reject Stop records with no deduction code after previous step
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvError = 'Change Record Rejected: Loan ID on file did not match the notes field of any existing loan deduction code for this employee.'
        ,drvAction = 'REJECTED'
        ,drvImported = 2
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'CHANGE' AND drvImported = 0 AND drvImportType = 'LOAN' AND ISNULL(drvDeductionCode,'') IS NULL;

     --Step 2.5. Reject remaining records with no deduction code after previous steps
    BEGIN
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvError = 'Record Rejected: Maximum Allowed Active Loans Exceeded.'
        ,drvAction = 'REJECTED'
        ,drvImported = 2
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'ADD' AND drvImported = 0 AND drvPayPeriod<>'W' AND dbo.dsi_fn_IVANG401LN_GetNextOrActiveLoanCode(drvEEID, drvCoID, @LoanCodesPAY1,'Count','')>=1
    END

    BEGIN
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvError = 'Record Rejected: Maximum Allowed Active Loans Exceeded.'
        ,drvAction = 'REJECTED'
        ,drvImported = 2
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'ADD' AND drvImported = 0 AND drvPayPeriod='W' AND dbo.dsi_fn_IVANG401LN_GetNextOrActiveLoanCode(drvEEID, drvCoID, @LoanCodesPAY2,'Count','')>=1
    END

    --Step 3. Assign next available deduction code for ADD records
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvDeductionCode = dbo.dsi_fn_IVANG401LN_GetNextOrActiveLoanCode(drvEEID, drvCoID, @LoanCodesPAY1,'Available','') --dbo.dsi_fn_GetNextAvailableLoanCode(drvEEID, drvCoID, @LoanCodes)
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'ADD' AND drvImported = 0 AND drvImportType = 'LOAN' AND drvPayPeriod<>'W';

    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvDeductionCode = dbo.dsi_fn_IVANG401LN_GetNextOrActiveLoanCode(drvEEID, drvCoID, @LoanCodesPAY2,'Available','') --dbo.dsi_fn_GetNextAvailableLoanCode(drvEEID, drvCoID, @LoanCodes)
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'ADD' AND drvImported = 0 AND drvImportType = 'LOAN' AND drvPayPeriod='W';

    --Step 4. Reject remaining records with no deduction code after previous steps
    UPDATE dbo.U_IVANG401LN_drvTbl 
    SET drvError = 'Record Rejected: No available loans to add for this employee'
        ,drvAction = 'REJECTED'
        ,drvImported = 2
    FROM dbo.U_IVANG401LN_drvTbl 
    WHERE drvAction = 'ADD' AND drvImported = 0 AND drvImportType = 'LOAN' AND ISNULL(drvDeductionCode,'') ='';


    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVANG401LN_drvTbl (drvError,drvImported)
       SELECT drvError=CONCAT('Error Processing Loan File: ', ERROR_MESSAGE(), ' in ', ERROR_PROCEDURE(), ' at line ',ERROR_LINE())
             ,drvImported=2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --===============================================
    -- Update PendingUpdateID for Valid Records
    --===============================================
    UPDATE dbo.U_IVANG401LN_drvTbl
    SET drvPendingUpdateID = LEFT(@FormatCode + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --======================================================
    -- Generate XML File for Automated Web Import
    --======================================================
    BEGIN TRY
        --------------------------------------------
        -- Populate BIM Lod Deduction Table for Web
        --------------------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;

        --=============================================
        -- Populate Lod Deduction Table (BIM_LodEDed)
        --=============================================

        ---------------------------------------------------------------------
        -- Import Records for 401K/ROTH Regular and Catch-Up Deferral File
        ---------------------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate,EedStopDate
            ,EedBenStatus,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDeductionCode
            ,EedEECalcRateOrPct = CASE
                                    WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                    WHEN drvAction IN ('ADD','CHANGE') THEN
                                        CASE
                                            WHEN DedEECalcRule = '21' THEN NULL
                                            WHEN DedEECalcRule = '20' THEN drvContributionAmount
                                            ELSE drvContributionPercent
                                        END
                              END
            ,EedBenStartDate = drvBenefitStartDate
            ,EedStartDate = drvDeductionStartDate
            ,EedBenStatusDate = drvBenefitStatusDate
            ,EedBenStopDate = drvBenefitStopDate
            ,EedStopDate = drvDeductionStopDate
            ,EedBenStatus = drvBenefitStatus
            ,EedChangeReason = drvBenefitChangeReason
            ,EedPendingTransType = CASE
                                    WHEN drvAction = 'ADD' THEN 'A'
                                    ELSE 'U'
                               END
            ,EedPendingEffDate = CONVERT(VARCHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
        FROM dbo.u_IVANG401LN_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDeductionCode
        WHERE drvImported = 0 AND drvImportType = 'DEFERRAL' AND drvAction <> 'REJECTED';

        -------------------------------------
        -- Import Records for Loan File
        -------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEEMemberOrCaseNo,EedEEAmt,EedEEGTDAmt,EedStartDate,EedStopDate,EedChangeReason
            ,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDeductionCode
            ,EedEEMemberOrCaseNo = drvLoanNumber
            ,EedEEAmt = drvLoanPaymentAmount
            ,EedEEGTDAmt = null   -- if populated in Ultipro then leave as is
            ,EedStartDate = CASE
                             WHEN drvAction = 'ADD' THEN drvDeductionStartDate
                             ELSE '12/30/1899'
                        END
            ,EedStopDate = CASE
                            WHEN drvAction = 'STOP' THEN drvDeductionStopDate
                            ELSE '01/01/1900'
                       END
            ,EedChangeReason = CASE
                                WHEN drvAction = 'ADD' THEN '400'
                                WHEN drvAction = 'STOP' THEN '401'
                                WHEN drvAction = 'CHANGE' THEN '402'
                            END
            ,EedPendingTransType = CASE
                                    WHEN drvAction = 'ADD' THEN 'A'
                                    ELSE 'U'
                               END
            ,EedPendingEffDate = CONVERT(VARCHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
        FROM dbo.u_IVANG401LN_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDeductionCode
        WHERE drvImported = 0 AND drvImportType = 'LOAN' AND drvAction <> 'REJECTED';

        ------------------------------------------------------------------------
        -- Generate XML File for Standard Web Import to Validate/Post Records
        ------------------------------------------------------------------------
        DECLARE @XMLFilePath VARCHAR(1000) = '' --IIF(dbo.dsi_fnVariable('IVANG401LN', 'Testing') = 'Y',dbo.dsi_fnVariable('IVANG401LN', 'XmlPath'),'') 
               ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable('IVANG401LN','ArchivePath');

        PRINT CONCAT('----XML FILEPATH = ',@XmlFilePath)
        
        --DLC While testing only run if in validate mode.
        IF dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE'
            EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;    

    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IVANG401LN_drvTbl (drvError,drvImported)
       SELECT 'Error Generating XML File for Web Import: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing

       RETURN;
    END CATCH;

    -----------------------------
    -- Report Successful Update
    -----------------------------
    UPDATE dbo.u_IVANG401LN_drvTbl
        SET drvError = 'Imported Successfully'
            ,drvImported = '1'
    FROM dbo.u_IVANG401LN_drvTbl
    WHERE drvImported = '0'
     AND EXISTS (SELECT 1 FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID);

    /*******************************
        Reject Remaining Records
    *******************************/
    UPDATE dbo.u_IVANG401LN_drvTbl
        SET drvError = drvError 
            ,drvAction = 'REJECTED'
            ,drvImported = '2'
    FROM dbo.u_IVANG401LN_drvTbl
    WHERE drvImported = '0';

    /***************************
        Set amounts to user friendly format
    *******************************/
    UPDATE    dbo.u_IVANG401LN_drvTbl
    SET        
             drvContributionPercent= CONVERT(VARCHAR(12), CONVERT(DECIMAL(10,2), drvContributionPercent))
            ,drvLoanPaymentAmount=     CONVERT(VARCHAR(12), CONVERT(DECIMAL(10,2), drvLoanPaymentAmount))

    FROM dbo.u_IVANG401LN_drvTbl ;

    -- select * from dbo.u_IVANG401LN_drvTbl
/*
    --==================================================
    -- SET FILENAME
    --==================================================
    UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'Vanguard401KImport_REVIEW_'
                            + CONVERT(CHAR(8),GETDATE(),112)                              -- YYMMDD
                            + REPLACE(CONVERT(VARCHAR(10),GETDATE(),108),':',SPACE(0))    -- HHMMss
                            + '.csv'
    WHERE FormatCode = @FormatCode;
*/

END

/*

--Create the View
CREATE VIEW dbo.dsi_vwIVANG401LN_Export as
    SELECT TOP 20000000 Data FROM dbo.U_IVANG401LN_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'IVANG401LN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201409011'
       ,ExpStartPerControl     = '201409011'
       ,ExpLastEndPerControl   = '201409089'
       ,ExpEndPerControl       = '201409089'
WHERE ExpFormatCode = 'IVANG401LN';

select eedeeid, eecempno, eepnamelast, eepnamefirst, eeddedcode, eedeeamt, * from empded ed join empcomp on eeceeid = eedeeid and eeccoid = eedcoid 
join emppers ep on eepeeid = eeceeid
where eeddedcode like '401L%' and eedeeamt > 0 and eedstopdate is null 
order by ep.eepnamelast, ep.eepnamefirst

sp_geteeid '34942'
DECLARE @EEID VARCHAR(12)  SET @EEID = '83Y1HB0000K0'

select * from dbo.U_IVANG401LN_Import where EEID = @EEID
select * from dbo.U_IVANG401LN_DrvTbl where drveeid = @EEID
SELECT eedeeid, eeddedcode, EedBenStatus, EedEEAmt, EedBenStartDate, EedBenStopDate, EedStartDate, EedStopDate, * 
FROM EmpDed WHERE EedEEID = @EEID AND EedDedCode IN ('401K','401KA','401KR','401L')

DELETE FROM lodcntrl WHERE cntSessionid LIKE '1LONSTOP%' OR cntSessionid LIKE '2LOANCHG%' OR cntSessionid LIKE 'IVANGDEF%'
DELETE FROM lodecomp WHERE eecSessionid LIKE '1LONSTOP%' OR eecSessionid LIKE '2LOANCHG%' OR eecSessionid LIKE 'IVANGDEF%'
DELETE FROM lodeded  WHERE eedpendingupdateid LIKE 'LONSTOP%' OR eedpendingupdateid LIKE 'LOANCHG%' OR eedpendingupdateid LIKE 'DEFERL%'

SELECT * FROM lodcntrl WHERE cntsessionid LIKE '1LONSTOP%' OR cntsessionid LIKE '2LOANCHG%' OR cntsessionid LIKE 'IVANGDEF%'
SELECT * FROM lodecomp WHERE eecsessionid LIKE '1LONSTOP%' OR eecsessionid LIKE '2LOANCHG%' OR eecsessionid LIKE 'IVANGDEF%'
SELECT EedEEID, EedDedCode, EedEECalcRateOrPct, EedEEGoalAmt, * FROM lodeded WHERE (eedpendingupdateid LIKE 'LONSTOP%' OR eedpendingupdateid LIKE 'LOANCHG%' OR eedpendingupdateid LIKE 'DEFERL%' ) 
ORDER BY lodeded.EedEEID, lodeded.EedDedCode

*/
GO
--Create the View
CREATE VIEW dbo.dsi_vwIVANG401LN_Export as
    SELECT TOP 20000000 Data FROM dbo.U_IVANG401LN_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SubSort;
GO
CREATE FUNCTION [dbo].[dsi_fn_IVANG401LN_GetNextOrActiveLoanCode] (  
@EEID      VARCHAR(12),  
@CoID      VARCHAR(6), 
@DedList   VARCHAR(MAX), 
@Action    VARCHAR(16),
@notes     VARCHAR(10)  
)  
RETURNS VARCHAR(5)  
WITH EXECUTE AS CALLER  
AS  
  
/************************************************************  
  
Created By:  Garret Donovan  
Create Date: 3/25/2021  
  
Purpose: Returns the active/next-available loan deduction code for an employee from the provided deduction codes.

**NEXT Action should only be used for clients who allow one active 401k loan per their plan definition**
  
Revision History  
----------------  
Update By         Date          CP Num         Descr  
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx  
Rebecca Lodge     11/30/2021                   Added Notes/Loan ID matching
  
SELECT EedEEID, dbo.dsi_fn_GetNextOrActiveLoanCode(EedEEID, EedCoID, '401L1,401L2,401L3,401L4,401L5','Available') FROM dbo.EmpDed (nolock)
  
************************************************************/  
  
BEGIN  
  
DECLARE @DedCode VARCHAR(5)  
DECLARE @COUNT INT
  
SET @COID      = LTRIM(RTRIM(COALESCE(@COID, '')))  
SET @EEID      = LTRIM(RTRIM(COALESCE(@EEID, ''))) 
SET @DedList   = LTRIM(RTRIM(COALESCE(@DedList, '')))   
SET @Action    = LTRIM(RTRIM(COALESCE(@Action, '')))  
SET @Notes     = LTRIM(RTRIM(COALESCE(@Notes, '')))  
  
-----------  
-- Build and update table variable  
-----------  
  
DECLARE @tvDedCodes TABLE (  
[tvDedCode]   CHAR(6), 
[tvStartDate] DATETIME,  
[tvStopDate]  DATETIME,
[tvNotes] VARCHAR(100)
)  
  
INSERT INTO @tvDedCodes (tvDedCode)
SELECT Item FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
  
UPDATE @tvDedCodes  
   SET tvStartDate = EedStartDate,  
       tvStopDate = EedStopDate,
       tvNotes = EedNotes
  FROM @tvDedCodes  
  JOIN dbo.EmpDed WITH (NOLOCK) 
    ON EedCOID = @COID 
    AND EedEEID = @EEID 
    AND EedDedCode = tvDedCode;
  
-----------  
-- Return active dedcode  
-----------  
  
IF @Action = 'Active' BEGIN  
  
   SELECT @DedCode = tvDedCode  
     FROM @tvDedCodes  
    WHERE tvStartDate IS NOT NULL  
      AND tvStopDate IS NULL  
      AND tvNotes = @Notes
  
    RETURN LTRIM(RTRIM(COALESCE(@DedCode, '')))  
  
END  

IF @Action = 'Count' BEGIN  
  
SELECT @COUNT = COUNT(EedEEID)
        FROM dbo.EmpDed WITH (NOLOCK)            
        WHERE EedDedCode in (SELECT Item FROM dbo.dsi_BDM_fn_ListToTable(@DedList)) AND EedEEID=@EEID AND EedCOID=@COID
        AND ISNULL(EedStopDate,'') = ''
        GROUP BY EedEEID
        
RETURN @COUNT                 
  
END 
  
-----------  
-- Return next available dedcode  
-----------  
  
IF @Action = 'Available' BEGIN  
  
   SELECT @DedCode = MIN(tvDedCode)  
     FROM @tvDedCodes  
    WHERE tvStartDate IS NULL  
      AND tvStopDate IS NULL  
  
    IF LTRIM(RTRIM(COALESCE(@DedCode, ''))) <> '' RETURN LTRIM(RTRIM(COALESCE(@DedCode, '')))  
  
   SELECT @DedCode = tvDedCode  
     FROM @tvDedCodes  
    WHERE tvStartDate IS NOT NULL  
      AND tvStopDate = (SELECT MIN(tvStopDate) FROM @tvDedCodes)  
  
    IF LTRIM(RTRIM(COALESCE(@DedCode, ''))) <> '' RETURN LTRIM(RTRIM(COALESCE(@DedCode, '')))  
  
END  
  
RETURN ''  
  
END;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'IVANG401LN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'IVANG401LN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'IVANG401LN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IVANG401LN', 'UseFileName', 'V', 'Y'


-- End ripout