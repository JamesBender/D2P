/**********************************************************************************

ITRPTOSDEF: T. Rowe Price Deferral Import

FormatCode:     ITRPTOSDEF
Project:        T. Rowe Price Deferral Import
Client ID:      TOS1003
Date/time:      2023-12-15 16:04:14.260
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP2DB03
Database:       ULTIPRO_WPTOAM
Web Filename:   TOS1003_NW9UY_EEHISTORY_ITRPTOSDEF_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\Us.saas\ew4\Public\TOS1003\Imports\TRowePrice\Archive\
ExportPath:    
ImportPath:    \\Us.saas\ew4\Public\TOS1003\Imports\TRowePrice\
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ITRPTOSDEF_SavePath') IS NOT NULL DROP TABLE dbo.U_ITRPTOSDEF_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ITRPTOSDEF'


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
WHERE FormatCode = 'ITRPTOSDEF'
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
WHERE ExpFormatCode = 'ITRPTOSDEF'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ITRPTOSDEF')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ITRPTOSDEF'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ITRPTOSDEF'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ITRPTOSDEF'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ITRPTOSDEF'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ITRPTOSDEF'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ITRPTOSDEF'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ITRPTOSDEF'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ITRPTOSDEF'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ITRPTOSDEF'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwITRPTOSDEF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwITRPTOSDEF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ITRPTOSDEF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ITRPTOSDEF];
GO
IF OBJECT_ID('U_ITRPTOSDEF_Raw') IS NOT NULL DROP TABLE [dbo].[U_ITRPTOSDEF_Raw];
GO
IF OBJECT_ID('U_ITRPTOSDEF_Import') IS NOT NULL DROP TABLE [dbo].[U_ITRPTOSDEF_Import];
GO
IF OBJECT_ID('U_ITRPTOSDEF_File') IS NOT NULL DROP TABLE [dbo].[U_ITRPTOSDEF_File];
GO
IF OBJECT_ID('U_ITRPTOSDEF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ITRPTOSDEF_EEList];
GO
IF OBJECT_ID('U_ITRPTOSDEF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ITRPTOSDEF_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ITRPTOSDEF',' T. Rowe Price Deferral Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','KELGVW3GX5MA','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','KELGVW3GX5MA','50','H','01','1',NULL,'Employee#',NULL,NULL,'"Employee#"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','KELGVW3GX5MA','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','KELGVW3GX5MA','50','H','01','3',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"Social Security Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','KELGVW3GX5MA','50','H','01','4',NULL,'DEFERRAL PERCENT',NULL,NULL,'"Deferral Percent"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','KELGVW3GX5MA','50','H','01','5',NULL,'DEFERRAL AMOUNT',NULL,NULL,'"Deferral Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','KELGVW3GX5MA','50','H','01','6',NULL,'LOAN ID',NULL,NULL,'"Loan ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','KELGVW3GX5MA','50','H','01','7',NULL,'LOAN STATUS',NULL,NULL,'"Loan Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','KELGVW3GX5MA','50','H','01','8',NULL,'LOAN REPAYMENT AMOUNT',NULL,NULL,'"Loan Repayment Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','KELGVW3GX5MA','50','H','01','9',NULL,'UltiPro DedCode',NULL,NULL,'"UltiPro DedCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','KELGVW3GX5MA','50','H','01','10',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','KELGVW3GX5MA','50','H','01','11',NULL,'Error',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','KELGVW3GX5MA','50','D','10','1',NULL,'Employee#',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','KELGVW3GX5MA','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','KELGVW3GX5MA','50','D','10','3',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','KELGVW3GX5MA','50','D','10','4',NULL,'DEFERRAL PERCENT',NULL,NULL,'"drvDeferralPercent"','(''UNT4''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','KELGVW3GX5MA','50','D','10','5',NULL,'DEFERRAL AMOUNT',NULL,NULL,'"drvDeferralAmt"','(''UNT4''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','KELGVW3GX5MA','50','D','10','6',NULL,'LOAN ID',NULL,NULL,'"drvLOANID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','KELGVW3GX5MA','50','D','10','7',NULL,'LOAN STATUS',NULL,NULL,'"drvSTATUS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','KELGVW3GX5MA','50','D','10','8',NULL,'LOAN REPAYMENT AMOUNT',NULL,NULL,'"drvREPAYMENTAMOUNT"','(''UNT4''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','KELGVW3GX5MA','50','D','10','9',NULL,'UltiPro DedCode',NULL,NULL,'"drvDedCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','KELGVW3GX5MA','50','D','10','10',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','KELGVW3GX5MA','250','D','10','11',NULL,'Error',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ITRPTOSDEF_20231215.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'TRoweDeferImport-OnDemand','202012299','EMPEXPORT','DEFERRAL',NULL,'ITRPTOSDEF',NULL,NULL,NULL,'202012299',NULL,'Dec 30 1899 12:00AM','202012291',NULL,'','','202012291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','YWS0C,IHG16,WCR7A,IHG2Y,Q7OPC,IHG4E,IHFYK,IHG95',NULL,NULL,NULL,'TRoweDeferImport-Sched','202012299','EMPEXPORT','SCH_DEFER',NULL,'ITRPTOSDEF',NULL,NULL,NULL,'202312119',NULL,'Dec 30 1899 12:00AM','202312041',NULL,'','','202012291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','ArchivePath','V','\\Us.saas\ew4\Public\TOS1003\Imports\TRowePrice\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','ImportPath','V','\\Us.saas\ew4\Public\TOS1003\Imports\TRowePrice\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPTOSDEF','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ITRPTOSDEF','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ITRPTOSDEF','D10','dbo.U_ITRPTOSDEF_drvTbl (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ITRPTOSDEF_drvTbl
-----------

IF OBJECT_ID('U_ITRPTOSDEF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ITRPTOSDEF_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvEmployeeName] varchar(100) NULL,
    [drvCompanyCode] varchar(50) NULL,
    [drvEmployeeNumber] varchar(50) NULL,
    [drvSocialSecurityNumber] varchar(50) NULL,
    [drvDeductionPlanCode] varchar(50) NULL,
    [drvBenefitStatus] varchar(50) NULL,
    [drvBenefitStatusDate] varchar(50) NULL,
    [drvBenefitStartDate] varchar(50) NULL,
    [drvBenefitStopDate] varchar(50) NULL,
    [drvDeductionStartDate] varchar(50) NULL,
    [drvDeductionStopDate] varchar(50) NULL,
    [drvCoverageLevelCode] varchar(50) NULL,
    [drvBenefitAmountRateorPercentage] money NULL,
    [drvRepaymentAmount] money NULL,
    [drvCoverageAmount] money NULL,
    [drvAnnualGoalAmount] money NULL,
    [drvROTHINDICATOR] varchar(50) NULL,
    [drvDeferralAmt] money NULL,
    [drvDeferralPercent] money NULL,
    [drvEEDeductionAmt] money NULL,
    [drvEEDeductionPercent] money NULL,
    [drvERDeductionAmt] money NULL,
    [drvERDeductionPercent] money NULL,
    [drvDeductionisOffset] varchar(50) NULL,
    [drvMemberorCaseNumber] varchar(50) NULL,
    [drvDoNotUse] varchar(50) NULL,
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
    [drvInitialSort] varchar(50) NULL,
    [drvSubSort] varchar(50) NULL,
    [drvPeriodStartDate] date NULL,
    [drvLoanID] varchar(50) NULL,
    [drvStatus] varchar(50) NULL
);

-----------
-- Create table U_ITRPTOSDEF_EEList
-----------

IF OBJECT_ID('U_ITRPTOSDEF_EEList') IS NULL
CREATE TABLE [dbo].[U_ITRPTOSDEF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ITRPTOSDEF_File
-----------

IF OBJECT_ID('U_ITRPTOSDEF_File') IS NULL
CREATE TABLE [dbo].[U_ITRPTOSDEF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ITRPTOSDEF_Import
-----------

IF OBJECT_ID('U_ITRPTOSDEF_Import') IS NULL
CREATE TABLE [dbo].[U_ITRPTOSDEF_Import] (
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
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_ITRPTOSDEF_Raw
-----------

IF OBJECT_ID('U_ITRPTOSDEF_Raw') IS NULL
CREATE TABLE [dbo].[U_ITRPTOSDEF_Raw] (
    [Data] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE   PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ITRPTOSDEF]  
    @SystemID char(12)  
AS  
SET NOCOUNT ON;  
/**********************************************************************************  
Client Name: Toshiba America, Inc.  
  
Created By: Shairil Narang  
Business Analyst: Jackie Finn
Create Date: 02/03/2022  
Service Request Number: SR-2022-00365099 
  
Purpose:  T. Rowe Price Deferral Import    ** WEB **  
  
NOTE TO SUPPORT: This interface is setup for Automated Web Imports via UltiPro Web Import Tool  
  
Revision History  
----------------  
Update By           Date            Request Num         Desc  
Jackie Finn        04/28/2023      SR-2022-00365099     File Name update
  
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ITRPTOSDEF';  
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ITRPTOSDEF';  
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ITRPTOSDEF';  
SELECT expformatcode, expexportcode, rtrim(expDesc), expascfilename, expstartpercontrol, expendpercontrol,* FROM dbo.AscExp WHERE ExpFormatCode = 'ITRPTOSDEF';  
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ITRPTOSDEF' ORDER BY RunID DESC;  
  
SELECT * FROM dbo.U_dsi_BIM_Processes WHERE bimFormatCode = 'ITRPTOSDEF' ORDER BY bimDateTimeStamp;  
SELECT * from dbo.U_DSI_InterfaceProcesses where formatcode = 'ITRPTOSDEF' order by datetimestamp;  
SELECT * from dbo.U_dsi_BIM_Errors where eFormatCode = 'ITRPTOSDEF';  
  
  
--Update Drive Mappings in U_DSI_Configuration  
---------------------------------------------------  
SELECT * FROM U_DSI_Configuration WHERE cfgname like '%path%' order by 4  
  
--PROD--  
update U_DSI_Configuration set cfgvalue = '\\us.saas\EW4\Public\NEP1001\Imports\TRowe\Archive\' where formatcode = 'ITRPTOSDEF' and cfgname = 'ArchivePath';  
update U_DSI_Configuration set cfgvalue = '\\us.saas\EW4\Public\NEP1001\Imports\TRowe\' where formatcode = 'ITRPTOSDEF' and cfgname = 'ImportPath';  
  
--Update Testing flag in U_DSI_Configuration for Production  
---------------------------------------------------  
UPDATE dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ITRPTOSDEF' AND cfgname = 'Testing';  
  
Execute Export  
--------------  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPTOSDEF', 'DEFERRAL';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPTOSDEF', 'SCH_DEFER';  
  
EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ITRPTOSDEF', @AllObjects = 'Y', @IsWeb = 'Y';  
  
SELECT * FROM dbo.U_dsi_BIM_Errors  
Testing
---------------
select * from U_dsi_InterfaceProcesses where FormatCode=''

select dbo.dsi_BIM_fn_GetStandardWebPath();   
select * from U_dsi_BIM_Configuration
select * from U_dsi_BIM_XML where xmlformatcode='ITRPTOSDEF'
select * from U_dsi_BIM_Processes where bimformatcode='ITRPTOSDEF'
select * from u_dsi_bim_errors
select * from U_ITRPTOSDEF_Raw
select * from U_ITRPTOSDEF_Import
select * from U_ITRPTOSDEF_drvTbl
select * from U_dsi_BIM_LodEDed where eedformatcode='ITRPTOSDEF'
exec master.dbo.xp_cmdshell 'dir \\us.saas\e2\Public\LIF1019\Imports\YourCause\'
  
**********************************************************************************/  
BEGIN  
  
    --========================================  
    -- Declare Variables  
    --========================================  
    DECLARE  @FormatCode VARCHAR(10)  
            ,@ImportPath VARCHAR(1000)  
            ,@ExportCode VARCHAR(12);  
  
    SET @FormatCode = 'ITRPTOSDEF';  
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);  
  
    --Set directory and filename where import file is located  
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');  
  
    --==================================================  
    -- Set FileName  
    --==================================================  
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')  
    BEGIN  
        UPDATE dbo.U_dsi_Parameters  
        SET ExportFile = 'DeferralLoanImport_' + LTRIM(RTRIM(ExportCode)) + '_'  
                        + CONVERT(CHAR(8),GETDATE(),112)                          -- YYYYMMDD  
                        + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMSS  
                        + '.csv'  
        WHERE FormatCode = @FormatCode;  
    END;  
  
     --==================================================  
    -- Create Driver Table for Error Report  
    --==================================================  
    IF OBJECT_ID('U_ITRPTOSDEF_drvTbl','U') IS NOT NULL  
        DROP TABLE dbo.U_ITRPTOSDEF_drvTbl;  
    CREATE TABLE dbo.U_ITRPTOSDEF_drvTbl (  
         drvSurrogateKey VARCHAR(50) NULL  
        ,drvEmployeeName VARCHAR(100) NULL  
        ,drvCompanyCode VARCHAR(50) NULL  
        ,drvEmployeeNumber VARCHAR(50) NULL  
        ,drvSocialSecurityNumber VARCHAR(50) NULL  
        ,drvDeductionPlanCode VARCHAR(50) NULL  
        ,drvBenefitStatus VARCHAR(50) NULL  
        ,drvBenefitStatusDate VARCHAR(50) NULL  
        ,drvBenefitStartDate VARCHAR(50) NULL  
        ,drvBenefitStopDate VARCHAR(50) NULL  
        ,drvDeductionStartDate VARCHAR(50) NULL  
        ,drvDeductionStopDate VARCHAR(50) NULL  
        ,drvCoverageLevelCode VARCHAR(50) NULL  
        ,drvBenefitAmountRateorPercentage MONEY NULL  
        ,drvRepaymentAmount MONEY NULL  
        ,drvCoverageAmount MONEY NULL  
        ,drvAnnualGoalAmount MONEY NULL  
        ,drvROTHINDICATOR VARCHAR(50) NULL  
        ,drvDeferralAmt MONEY NULL  
        ,drvDeferralPercent MONEY NULL  
        ,drvEEDeductionAmt MONEY NULL  
        ,drvEEDeductionPercent MONEY NULL  
        ,drvERDeductionAmt MONEY NULL  
        ,drvERDeductionPercent MONEY NULL  
        ,drvDeductionisOffset VARCHAR(50) NULL  
        ,drvMemberorCaseNumber VARCHAR(50) NULL  
        ,drvDoNotUse VARCHAR(50) NULL  
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
        ,drvSubSort VARCHAR(50) NULL  
        ,drvPeriodStartDate DATE NULL  
        ,drvLoanID VARCHAR(50) NULL  
        ,drvStatus VARCHAR(50) NULL  
    );  
  
    /*  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_Raw  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_Import  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_drvTbl  
    */  
  
    --========================================  
    -- Benefit Import Module (Load File)  
    --========================================  
    IF (@ExportCode = 'DEFERRAL' OR @ExportCode = 'SCH_DEFER')  
    BEGIN TRY  
  
        -----------------------------------------------------------------------------------------  
        -- T.ROWE PRICE DEFERRAL FEEDBACK INFORMATION (BEFORE-TAX / AFTER-TAX / ROTH)  
        -----------------------------------------------------------------------------------------  
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;  
  
        --INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'AddToPreviousRun','Y');  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEFERRAL');  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','XS*'); --File Name contains "XS"   -TEST file TS*  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileFormat','Fixed');  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','20');  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field4','SSN');  
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Non-Closed'); --Regular --PayGroup --Non-Closed --Non-Opened  
  
  
        -- Fixed Length File Format  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',1,1,6,'Record Identification');  
       INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',2,7,1,'RECORD TYPE');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',3,8,6,'PLAN');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',4,14,9,'SSN');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',5,23,1,'SOURCE');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',6,24,2,'SEQUENCE #');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',7,26,4,'LOCATION');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',8,30,30,'Filler');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',9,60,13,'EMPLOYEE IDENTIFICATION');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',10,73,2,'STATUS');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',11,75,1,'FILLER');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',12,76,8,'ELIGIBILITY DATE');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',13,84,1,'DEFERRAL TYPE');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',14,85,15,'DEFERRAL AMOUNT');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',15,100,8,'DATE');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',16,108,4,'TIME');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',17,112,1,'FIRST DEFERRAL');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',18,113,13,'LOCATION EXTENSION');  
        INSERT INTO dbo.U_dsi_BIM_Configuration(FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',19,126,25,'FILLER');  
  
        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files  
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')  
        BEGIN  
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');  
        END  
        ELSE  
        BEGIN  
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');  
        END;  
  
  
        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;  
  
        ----------------------------------------------------------  
        -- Only Retain Records where SSN in Field# 4 is Numeric  
        ----------------------------------------------------------  
        DELETE FROM dbo.U_ITRPTOSDEF_Import WHERE RunID LIKE 'DEFERRAL%' AND ISNUMERIC(REPLACE(Field4,'-','')) = 0 AND ISNULL(Error,'') = '';  
  
    END TRY  
    BEGIN CATCH  
       -- Report SQL Error in Error Report File  
       INSERT INTO dbo.U_ITRPTOSDEF_drvTbl (drvError)  
       SELECT 'Error Processing Fixed Deferral File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');  
  
       -- Stop Processing  
       RETURN;  
    END CATCH;  
  
    /*  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_Raw  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_Import  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_drvTbl  
    */  
  
    --==============================================================  
    -- If Error During BIM, then Report Error and Stop Processing  
    --==============================================================  
    IF EXISTS (SELECT 1 FROM dbo.U_ITRPTOSDEF_Import WHERE ISNULL(Error,'') <> '')  
    BEGIN  
        INSERT INTO dbo.U_ITRPTOSDEF_drvTbl (drvError,drvImported)  
        SELECT Error, 2 FROM dbo.U_ITRPTOSDEF_Import WHERE ISNULL(Error,'') <> '';  
  
        -- Stop Processing  
        RETURN;  
    END;  
  
    --==================================================  
    -- Build Driver Table - Deferral  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_Raw  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_Import  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_drvTbl  
    --==================================================  
    IF (@ExportCode = 'DEFERRAL' OR @ExportCode = 'SCH_DEFER')  
    BEGIN TRY  
    --====================================================  
    -- (401K)  
    --====================================================  
    INSERT INTO dbo.U_ITRPTOSDEF_drvTbl (drvSurrogateKey,drvEmployeeNumber,drvEmployeeName,drvSOCIALSECURITYNUMBER,drvDeferralAmt,drvDEFERRALPERCENT,drvROTHINDICATOR  
            ,drvAction,drvError,drvImported,drvEEID,drvCOID,drvImportType,drvDedCode,drvPeriodStartDate,drvInitialSort,drvSubSort)  
    SELECT DISTINCT  
             drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)  
            ,drvEmployeeNumber = RTRIM(EecEmpNo)  
            ,drvEmployeeName = RTRIM(EepNameFirst) + SPACE(1) + EepNameLast  
            ,drvSOCIALSECURITYNUMBER = Field4  
            ,drvDeferralAmt = NULL  
            ,drvDEFERRALPERCENT =  CONVERT(MONEY,CONVERT(NUMERIC(11,4),Field14)) /10000  
            ,drvROTHINDICATOR = NULL  
            ,drvAction = CASE WHEN NULLIF(Field4,SPACE(1)) IS NULL THEN 'REJECTED' --[Social Security Number] Is Missing in File  
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match [Social Security Number] in File with Employee in UltiPro  
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee  
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.  
                              -- Process Stops  
                              WHEN CONVERT(MONEY,ABS(Field14)) = 0.00 THEN  
                                CASE WHEN EedDedCode IS NOT NULL THEN 'CHANGE'  
                                     ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP  
                                END  
                              ELSE -- Process Add/Changes  
                                CASE WHEN EedDedCode IS NOT NULL THEN  
                                        CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'  
                                             ELSE 'CHANGE'  
                                        END  
                                     ELSE 'ADD'  
                                END  
                         END  
            ,drvError = CASE WHEN NULLIF(Field4,SPACE(1)) IS NULL THEN 'Record Rejected: [Social Security Number] Is Missing in File.'  
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match [Social Security Number] in File with Employee in UltiPro.'  
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Terminated Employee - Do Not Process.'  
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'  
                             WHEN EedDedCode IS NULL AND CONVERT(MONEY,ABS(Field14)) = 0.00 THEN 'Record Rejected: No Deduction/Benefit Plan to ZERO OUT for Employee.'  
                        END  
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected  
                                WHEN NULLIF(Field4,SPACE(1)) IS NULL THEN 2 --[Social Security Number] Is Missing in File  
                                WHEN EEID IS NULL THEN 2 --Unable to Match [Social Security Number] in File with Employee in UltiPro  
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee  
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.  
                                WHEN EedDedCode IS NULL AND CONVERT(MONEY,ABS(Field14)) = 0.00 THEN 2 --No Deduction/Benefit Plan to STOP  
                                ELSE 0  
                           END  
            ,drvEEID = EEID  
            ,drvCOID = COID  
            ,drvImportType = 'DEFERRAL'  
            ,drvDedCode = DedDedCode  
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)  
            ,drvInitialSort = '1'        --CONVERT(VARCHAR(50), Field4)  
            ,drvSubSort = 'PERCENT'  
        FROM dbo.U_ITRPTOSDEF_Import  
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)  
            ON EecEEID = EEID  
            AND EecCoID = COID  
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)  
            ON eepEEID = EEID  
        LEFT JOIN dbo.Company WITH (NOLOCK)  
            ON CmpCoID = COID  
        LEFT JOIN dbo.DedCode WITH (NOLOCK)  
            ON DedDedCode = CASE Field5 
                                    WHEN 'A' THEN '401CP'
                                    WHEN 'S' THEN '401CR'  
                                END
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)  
            ON EedEEID = EEID  
            AND EedCoID = COID  
            AND EedDedCode = DedDedCode  
        WHERE RunID = 'DEFERRAL'  
         
        ;  
  
    END TRY  
    BEGIN CATCH  
       -- Report SQL Error in Error Report File  
       INSERT INTO dbo.U_ITRPTOSDEF_drvTbl (drvError)  
       SELECT 'Error Loading Deferral File into Driver Table: ' + ISNULL(ERROR_MESSAGE(),'');  
  
       -- Stop Processing  
       RETURN;  
    END CATCH;  
  
    --==============================================  
    -- Update PendingUpdateID for Valid Records  
    --==============================================  
    UPDATE dbo.U_ITRPTOSDEF_drvTbl  
    SET drvPendingUpdateID = LEFT('ITRPTOSDEF' + dbo.fn_GetTimedKey(),20)  
    WHERE drvImported = 0;  
  
    --SELECT drvAction, * FROM dbo.U_ITRPTOSDEF_drvTbl  
    --SELECT * FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = 'ITRPTOSDEF';  
  
    --============================================================  
    -- Generate XML File for Standard Web Import for Automation  
    --============================================================  
    BEGIN TRY  
        --===========================================  
        -- Populate BIM Lod Deduction Table for Web  
        --===========================================  
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;  
  
        --============================================================  
        -- Populate Lod Deduction Table (BIM LodEDed) - Deferrals  
        --============================================================  
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedEEAmt,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate  
            ,EedStopDate,EedChangeReason,EedBenStatus,EedPendingEffDate,EedPendingTransType,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID) --EedEECalcRule  
        SELECT EedFormatCode = @FormatCode  
            ,EedEEID = drvEEID  
            ,EedCOID = drvCOID  
            ,EedDedCode = drvDedCode  
            ,EedEECalcRateOrPct = CASE WHEN DedEECalcRule <> '20' THEN -- Deduction Calc Rule is NOT '20' (Flat Amount)  
                                            CASE WHEN drvSubSort = 'PERCENT' THEN drvDeferralPercent  
                                            END  
                                  END  
            ,EedEEAmt = CASE WHEN DedEECalcRule = '20' THEN -- Deduction Calc Rule is '20' (Flat Amount)  
                                  CASE WHEN drvSubSort = 'AMOUNT' THEN drvDeferralAmt  
                                  END  
                        END  
            ,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900' -- Set to NULL for Deduction Only Plans  
                                    WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvPeriodStartDate)  
                                    ELSE '12/30/1899'  
                               END  
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvPeriodStartDate)  
                                 ELSE '12/30/1899'  
                            END  
            ,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900' -- Set to NULL for Deduction Only Plans  
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(DATETIME,drvPeriodStartDate)  
                                     WHEN drvAction = 'STOP' THEN DATEADD(DAY,-1,CONVERT(DATETIME,drvPeriodStartDate))  
                                     ELSE '12/30/1899'  
                                END  
            ,EedBenStopDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900' -- Set to NULL for Deduction Only Plans  
                                   WHEN drvAction = 'STOP' THEN NULL --DATEADD(DAY,-1,CONVERT(DATETIME,drvPeriodStartDate))  
                                   ELSE '01/01/1900'  
                              END  
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN NULL    --DATEADD(DAY,-1,CONVERT(DATETIME,drvPeriodStartDate))  
                                ELSE '01/01/1900'  
                           END  
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'  
                                    WHEN drvAction = 'STOP' THEN '401'  
                                    WHEN drvAction IN ('CHANGE','RESTART') THEN '402'  
                               END  
            ,EedBenStatus = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL -- Set to NULL for Deduction Only Plans  
                                 ELSE 'A'  
                            END  
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)  
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'  
                                        ELSE 'U'  
                                   END  
            ,EedInclInAddlChk = DedInclInAddlChk  
            ,EedInclInManlChk = DedInclInManlChk  
            ,EedPendingUpdateID = drvPendingUpdateID  
            --,EedEECalcRule = DedEECalcRule    -- This may need to be set if existing records don't match Deduction/Benefit Plan Calc Rule (i.e., changing from Option Rate Schedule to Flat Amount)  
        FROM dbo.U_ITRPTOSDEF_drvTbl WITH (NOLOCK)  
        JOIN dbo.DedCode WITH (NOLOCK)  
            ON DedDedCode = drvDedCode  
        WHERE drvImported = 0 AND drvImportType = 'DEFERRAL' ;  
  
        --======================================================================  
        -- Generate XML File for Standard Web Import to Validate/Post Records  
        --======================================================================  
        DECLARE @XMLFilePath VARCHAR(1000) = ''--dbo.Dsi_fnVariable(@FormatCode,'ArchivePath') --Send Blank ('') to generate file to Standard Web 'ImportPath' folder to process via UltiPro Web Import Tool  
               ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');  
  
        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;  
    END TRY  
    BEGIN CATCH  
       -- Report SQL Error in Error Report File  
       INSERT INTO dbo.U_ITRPTOSDEF_drvTbl (drvError)  
       SELECT 'Error Generating XML File for Standard Web Import: ' + ISNULL(ERROR_MESSAGE(),'');  
  
       -- Stop Processing  
       RETURN;  
    END CATCH;  
  
  
    --=======================  
    -- Report Successful  
    --=======================  
    UPDATE dbo.U_ITRPTOSDEF_drvTbl  
        SET drvError = 'Loaded Successfully-Check Import Tool Results for Validation and Posting'  -- Updated 5/23/2022 CR  
           ,drvImported = 1  
    WHERE drvImported = 0  
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID);  
  
    -- SELECT * FROM dbo.U_ITRPTOSDEF_drvTbl WITH (NOLOCK)  
  
    --============================  
    -- Reject Remaining Records  
    --============================  
    UPDATE dbo.U_ITRPTOSDEF_drvTbl  
        SET drvError = 'Record Rejected'  
            ,drvAction = 'REJECTED'  
            ,drvImported = 2  
    WHERE drvImported = 0;  
  
END  
/******************************************************************  
  
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ITRPTOSDEF';  
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ITRPTOSDEF';  
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ITRPTOSDEF';  
SELECT expformatcode, expexportcode, expascfilename, expstartpercontrol, expendpercontrol,* FROM dbo.AscExp WHERE ExpFormatCode = 'ITRPTOSDEF';  
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ITRPTOSDEF' ORDER BY RunID DESC;  
  
SELECT * FROM dbo.U_dsi_BIM_Processes WHERE bimFormatCode = 'ITRPTOSDEF' ORDER BY bimDateTimeStamp;  
SELECT * from dbo.U_DSI_InterfaceProcesses where formatcode = 'ITRPTOSDEF' order by datetimestamp;  
SELECT * from dbo.U_dsi_BIM_Errors where eFormatCode = 'ITRPTOSDEF';  
  
  
--Update Drive Mappings in U_DSI_Configuration  
---------------------------------------------------  
SELECT * FROM U_DSI_Configuration WHERE cfgname like '%path%' order by 4  
  
--TEST--  
update U_DSI_Configuration set cfgvalue = '\\us.saas\EZ\Public\NEP1001\Imports_Test\TRowe\Archive\' where formatcode = 'ITRPTOSDEF' and cfgname = 'ArchivePath';  
update U_DSI_Configuration set cfgvalue = '\\us.saas\EZ\Public\NEP1001\Imports_Test\TRowe\' where formatcode = 'ITRPTOSDEF' and cfgname = 'ImportPath';  
  
--PROD--  
update U_DSI_Configuration set cfgvalue = '\\us.saas\EW4\EW45\Downloads\V10\Imports\TRowe\Archive\' where formatcode = 'ITRPTOSDEF' and cfgname = 'ArchivePath';  
update U_DSI_Configuration set cfgvalue = '\\us.saas\EW4\EW45\Downloads\V10\Imports\TRowe\' where formatcode = 'ITRPTOSDEF' and cfgname = 'ImportPath';  
  
--Update Testing flag in U_DSI_Configuration for Production  
---------------------------------------------------  
UPDATE dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ITRPTOSDEF' AND cfgname = 'Testing';  
  
Execute Export  
--------------  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPTOSDEF', 'DEFERRAL';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPTOSDEF', 'LOANS';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPTOSDEF', 'SCH_DEFER';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPTOSDEF', 'SCH_LOANS';  
  
EXEC dbo._dsi_usp_ExportRipOut_v6 @FormatCode = 'ITRPTOSDEF', @AllObjects = 'Y', @IsWeb = 'Y';  
  
--Create the View  
CREATE VIEW dbo.dsi_vwITRPTOSDEF_Export AS  
    SELECT TOP 20000000 Data FROM dbo.U_ITRPTOSDEF_File (NOLOCK)  
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;  
  
--Check out AscDefF  
SELECT * FROM dbo.AscDefF  
WHERE AdfHeaderSystemID LIKE 'ITRPTOSDEF%'  
ORDER BY AdfSetNumber, AdfFieldNumber;  
  
--Update Dates  
UPDATE dbo.AscExp  
    SET ExpLastStartPerControl = '202012291'  
       ,ExpStartPerControl     = '202012291'  
       ,ExpLastEndPerControl   = '202012299'  
       ,ExpEndPerControl       = '202012299'  
WHERE ExpFormatCode = 'ITRPTOSDEF';  
  
******************************************************************/  
GO
CREATE VIEW dbo.dsi_vwITRPTOSDEF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ITRPTOSDEF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ITRPTOSDEF' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ITRPTOSDEF'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ITRPTOSDEF'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ITRPTOSDEF', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ITRPTOSDEF', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ITRPTOSDEF', 'UseFileName', 'V', 'Y'


-- End ripout