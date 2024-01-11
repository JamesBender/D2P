/**********************************************************************************

ITRPLONIMP: TRowe Price Loan Import

FormatCode:     ITRPLONIMP
Project:        TRowe Price Loan Import
Client ID:      TOS1003
Date/time:      2023-12-15 16:04:54.213
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP2DB03
Database:       ULTIPRO_WPTOAM
Web Filename:   TOS1003_NW9UY_EEHISTORY_ITRPLONIMP_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\EW4\Public\TOS1003\Imports\TRowePrice\Archive\
ExportPath:    
ImportPath:    \\us.saas\EW4\Public\TOS1003\Imports\TRowePrice\
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ITRPLONIMP_SavePath') IS NOT NULL DROP TABLE dbo.U_ITRPLONIMP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ITRPLONIMP'


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
WHERE FormatCode = 'ITRPLONIMP'
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
WHERE ExpFormatCode = 'ITRPLONIMP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ITRPLONIMP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ITRPLONIMP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ITRPLONIMP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ITRPLONIMP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ITRPLONIMP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ITRPLONIMP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ITRPLONIMP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ITRPLONIMP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ITRPLONIMP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ITRPLONIMP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwITRPLONIMP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwITRPLONIMP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ITRPLONIMP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ITRPLONIMP];
GO
IF OBJECT_ID('U_ITRPLONIMP_Raw') IS NOT NULL DROP TABLE [dbo].[U_ITRPLONIMP_Raw];
GO
IF OBJECT_ID('U_ITRPLONIMP_Import') IS NOT NULL DROP TABLE [dbo].[U_ITRPLONIMP_Import];
GO
IF OBJECT_ID('U_ITRPLONIMP_File') IS NOT NULL DROP TABLE [dbo].[U_ITRPLONIMP_File];
GO
IF OBJECT_ID('U_ITRPLONIMP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ITRPLONIMP_EEList];
GO
IF OBJECT_ID('U_ITRPLONIMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ITRPLONIMP_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ITRPLONIMP','TRowe Price Loan Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ITRPLONIMPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ITRPLONIMPZ0','50','H','01','1',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ITRPLONIMPZ0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ITRPLONIMPZ0','50','H','01','3',NULL,'Deduction Code',NULL,NULL,'"Deduction Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ITRPLONIMPZ0','50','H','01','4',NULL,'Contribution Percent',NULL,NULL,'"Contribution Percent"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ITRPLONIMPZ0','50','H','01','5',NULL,'Contribution Amount',NULL,NULL,'"Contribution Amount "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ITRPLONIMPZ0','50','H','01','6',NULL,'Loan Payment Amount',NULL,NULL,'"Loan Payment Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ITRPLONIMPZ0','50','H','01','7',NULL,'Loan Goal Amount',NULL,NULL,'"Loan Goal Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ITRPLONIMPZ0','50','H','01','8',NULL,'Loan Type',NULL,NULL,'"Loan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ITRPLONIMPZ0','50','H','01','9',NULL,'Import Type',NULL,NULL,'"Import Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ITRPLONIMPZ0','50','H','01','10',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ITRPLONIMPZ0','50','H','01','11',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ITRPLONIMPZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ITRPLONIMPZ0','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ITRPLONIMPZ0','50','D','10','3',NULL,'Deduction Code',NULL,NULL,'"drvDeductionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ITRPLONIMPZ0','50','D','10','4',NULL,'Contribution Percent',NULL,NULL,'"drvContributionPercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ITRPLONIMPZ0','50','D','10','5',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ITRPLONIMPZ0','50','D','10','6',NULL,'Loan Payment Amount',NULL,NULL,'"drvLoanPaymentAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ITRPLONIMPZ0','50','D','10','7',NULL,'Loan Goal Amount',NULL,NULL,'"drvLoanGoalAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ITRPLONIMPZ0','50','D','10','8',NULL,'Loan Type',NULL,NULL,'"drvLoanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ITRPLONIMPZ0','50','D','10','9',NULL,'Import Type',NULL,NULL,'"drvImportType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ITRPLONIMPZ0','50','D','10','10',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ITRPLONIMPZ0','250','D','10','11',NULL,'Error',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ITRPLONIMP_20231215.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'401k Loan File Import','202302189','EMPEXPORT','LOAN','Jan  1 2019 12:00AM','ITRPLONIMP',NULL,NULL,NULL,'202302189','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202302181',NULL,'','','202302181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','YWS0C,IHG16,WCR7A,IHG2Y,Q7OPC,IHG4E,IHFYK,IHG95',NULL,NULL,NULL,'401k Loan File Import - SCHED','202302189','EMPEXPORT','SCH_LOAN','Jan  1 2019 12:00AM','ITRPLONIMP',NULL,NULL,NULL,'202312119','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM','202312041',NULL,'','','202302181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------

INSERT INTO [dbo].[AscImp] (impCOID,impDateAccruedThru,impDateOfRollover,impDatePendingMoved,impDesc,impEEIdentifier,impEngine,impExceptions,impFormatCode,impImportCode,impImported,impPayPeriodID,impPosted,impReset,impSessionType,impSource,impSystemID,impUser,impValid,impVerified) VALUES ('',NULL,NULL,NULL,'TRowe Price Loan Import','E','BENEFITIMP',NULL,'ITRPLONIMP','ITRPLONIMP',NULL,NULL,NULL,'Jan  1 2019  9:22AM',NULL,'VALIDATE / POST / RESET ONLY (DO NOT CLICK IMPORT)',dbo.fn_GetTimedKey(),'ULTI',NULL,'Jan  1 2019  9:23AM');

-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','ArchivePath','V','\\us.saas\EW4\Public\TOS1003\Imports\TRowePrice\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','ImportPath','V','\\us.saas\EW4\Public\TOS1003\Imports\TRowePrice\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ITRPLONIMP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ITRPLONIMP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ITRPLONIMP','D10','dbo.U_ITRPLONIMP_drvTbl WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ITRPLONIMP_drvTbl
-----------

IF OBJECT_ID('U_ITRPLONIMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ITRPLONIMP_drvTbl] (
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
    [drvPendingUpdateID] varchar(20) NULL,
    [drvInitialSort] varchar(50) NULL
);

-----------
-- Create table U_ITRPLONIMP_EEList
-----------

IF OBJECT_ID('U_ITRPLONIMP_EEList') IS NULL
CREATE TABLE [dbo].[U_ITRPLONIMP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ITRPLONIMP_File
-----------

IF OBJECT_ID('U_ITRPLONIMP_File') IS NULL
CREATE TABLE [dbo].[U_ITRPLONIMP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ITRPLONIMP_Import
-----------

IF OBJECT_ID('U_ITRPLONIMP_Import') IS NULL
CREATE TABLE [dbo].[U_ITRPLONIMP_Import] (
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
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_ITRPLONIMP_Raw
-----------

IF OBJECT_ID('U_ITRPLONIMP_Raw') IS NULL
CREATE TABLE [dbo].[U_ITRPLONIMP_Raw] (
    [Data] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ITRPLONIMP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Toshiba America, Inc.

Created By: Vivek Phaniraj
Business Analyst: Jackie Finn
Create Date: 02/15/2023
Service Request Number: SR-2022-00390419

Purpose: TRowe Price Loan Import

NOTE TO SUPPORT: This is an Automated Web Import that uses the Import Tool for Validating/Posting Records

Revision History
----------------
Update By           Date            Request Num         Desc
Jackie Finn        04/28/2023      SR-2023-00403263     File Name update

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ITRPLONIMP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ITRPLONIMP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ITRPLONIMP';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'ITRPLONIMP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ITRPLONIMP' ORDER BY RunID DESC;

Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'ITRPLONIMP', 'LOAN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ITRPLONIMP', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==================================================
    -- Declare Variables
    --==================================================
    DECLARE  @FormatCode VARCHAR(10)
            ,@ImportPath VARCHAR(1000)
            ,@FileName VARCHAR(1000)
            ,@ExportCode VARCHAR(12)
            ,@EnableStandardWebImport CHAR(1);

    SET @FormatCode = 'ITRPLONIMP'
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
        SET ExportFile = 'DeferralLoanImport_' + LTRIM(RTRIM(@ExportCode)) + '_'
                            + CONVERT(CHAR(8),GETDATE(),112)                          -- YYMMDD
                            + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMss
                            + '.csv'
        WHERE FormatCode = @FormatCode;
    END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_ITRPLONIMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ITRPLONIMP_drvTbl;
    CREATE TABLE dbo.U_ITRPLONIMP_drvTbl (
        drvSurrogateKey VARCHAR(50) NULL
        ,drvEmployeeNumber VARCHAR(50) NULL
        ,drvEmployeeName VARCHAR(50) NULL
        ,drvSSN VARCHAR(50) NULL
        ,drvDeductionCode VARCHAR(50) NULL
        ,drvBenefitStatus VARCHAR(50) NULL
        ,drvBenefitStatusDate VARCHAR(50) NULL
        ,drvBenefitStartDate VARCHAR(50) NULL
        ,drvBenefitStopDate VARCHAR(50) NULL
        ,drvDeductionStartDate VARCHAR(50) NULL
        ,drvDeductionStopDate VARCHAR(50) NULL
        ,drvContributionPercent VARCHAR(50) NULL
        ,drvContributionAmount VARCHAR(50) NULL
        ,drvEmployerPercent VARCHAR(50) NULL
        ,drvEmployerAmount VARCHAR(50) NULL
        ,drvBenefitOption VARCHAR(50) NULL
        ,drvBenefitAmount VARCHAR(50) NULL
        ,drvBenefitChangeReason VARCHAR(50) NULL
        ,drvLoanNumber VARCHAR(50) NULL
        ,drvLoanPaymentAmount VARCHAR(50) NULL
        ,drvLoanGoalAmount VARCHAR(50) NULL
        ,drvLoanType VARCHAR(50) NULL
        ,drvAction VARCHAR(50) NULL
        ,drvError VARCHAR(250) NULL
        ,drvImported TINYINT DEFAULT 0 NOT NULL
        ,drvEEID VARCHAR(12) NULL
        ,drvCOID VARCHAR(5) NULL
        ,drvDedCode VARCHAR(50) NULL
        ,drvImportType VARCHAR(50) NULL
        ,drvPeriodStartDate VARCHAR(50) NULL
        ,drvPendingUpdateID VARCHAR(20) NULL
        ,drvInitialSort VARCHAR(50) NULL
    );


    --==================================================
    -- Benefit Import Module (BIM) - Loan Records
    --==================================================
    IF 1=1 -- LynnM 5/25/2023  -- (@ExportCode = 'LOAN')
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','LOAN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','XL*'); --File Name contains "Loan"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileFormat','Fixed');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','13');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field3','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','PayGroup'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- Fixed Length File Format
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',1,1,6,'FIELD1');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',2,7,3,'FIELD2');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',3,10,9,'FIELD3');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',4,19,11,'FIELD4');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',5,30,15,'FIELD5');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',6,45,8,'FIELD6');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',7,53,11,'FIELD7');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',8,64,11,'FIELD8');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',9,75,11,'FIELD9');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',10,86,1,'FIELD10');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',11,87,8,'FIELD11');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',12,95,4,'FIELD12');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',13,99,2,'FIELD13');

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')    -- select dbo.dsi_BIM_fn_GetValidateModeSetting()
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        ------------------------------------------------------------------------------
        -- Only Retain Loan Records where Record ID = '3' (Loan) in Field# 1
        ------------------------------------------------------------------------------
       -- DELETE FROM dbo.U_ITRPLONIMP_Import WHERE RunID = 'LOAN' AND LTRIM(RTRIM(Field1)) <> '3' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_ITRPLONIMP_drvTbl (drvError)
       SELECT 'Error Processing Fixed Loan File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================================
    -- If Error During BIM, then Report Error and Stop Processing
    --==============================================================
    IF EXISTS (SELECT 1 FROM dbo.U_ITRPLONIMP_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
        INSERT INTO dbo.U_ITRPLONIMP_drvTbl (drvError,drvImported)
        SELECT Error, 2 FROM dbo.U_ITRPLONIMP_Import WHERE ISNULL(Error,'') <> '';

        -- Stop Processing
        RETURN;
    END;


    --==================================================
    -- Build Driver Table - Loans
    --==================================================
    BEGIN TRY
        INSERT INTO dbo.U_ITRPLONIMP_drvTbl(drvSurrogateKey,drvEmployeeNumber,drvEmployeeName,drvSSN,drvDeductionCode,drvDeductionStartDate,drvDeductionStopDate
            ,drvLoanNumber,drvLoanPaymentAmount,drvLoanGoalAmount,drvLoanType,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvEmployeeNumber = EecEmpNo
            ,drvEmployeeName = RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast)
            ,drvSSN = NULLIF(Field3,'')
            ,drvDeductionCode = ''--NULLIF(Field2,'')
            ,drvDeductionStartDate = ''--NULLIF(Field7,'')
            ,drvDeductionStopDate = ''--NULLIF(Field8,'')
            ,drvLoanNumber = ''--NULLIF(Field16,'')
            ,drvLoanPaymentAmount = FORMAT(TRY_CAST(Field9 AS DECIMAL(11,2))* 0.01,'0.00')
            ,drvLoanGoalAmount = ''--NULLIF(Field18,'')
            ,drvLoanType = ''--CONVERT(VARCHAR(50),Field19)
            ,drvAction = CASE WHEN NULLIF(Field3,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                              ELSE
                                CASE WHEN NULLIF(Field2,'') IN ('386','387') THEN 'STOP'
                                     WHEN CONVERT(MONEY,Field9) = 0.00 THEN
                                        CASE WHEN EedDedCode IS NOT NULL AND NULLIF(Field2,'') IN ('383') THEN 'CHANGE'
                                             ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
                                        END
                                     WHEN EedDedCode IS NOT NULL THEN
                                        CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                             ELSE 'CHANGE'
                                        END
                                     ELSE 'ADD'
                                END
                         END
            ,drvError = CASE WHEN NULLIF(Field3,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                             WHEN CONVERT(MONEY,Field9) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP for Employee in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN NULLIF(Field3,'') IS NULL THEN 2 --Missing [SSN] Value in File.
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                                WHEN CONVERT(MONEY,Field9) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = DedDedCode
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(CHAR(10),NextPayPeriodStartDate,101)
            ,drvInitialSort = Field1
        FROM dbo.U_ITRPLONIMP_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.EmpPers WITH (NOLOCK)
            ON eepEEID = EEID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = '401L'
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'LOAN';



        --=====================================================
        -- Reject Stops/Changes where Deduction Code is NULL
        --=====================================================
        UPDATE dbo.U_ITRPLONIMP_drvTbl
        SET drvError = 'Record Rejected: No Active Deduction Code to STOP/CHANGE in UltiPro.'
            ,drvAction = 'REJECTED'
            ,DrvImported = 2
        WHERE drvImported = 0 AND drvAction IN ('STOP','CHANGE') AND drvDedCode IS NULL;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_ITRPLONIMP_drvTbl (drvError)
       SELECT 'Error Processing Loan File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --------------------------------------
    -- Update SurrogateKey With DedCode
    --------------------------------------
    UPDATE dbo.U_ITRPLONIMP_drvTbl SET drvSurrogateKey  = drvSurrogateKey + drvDedCode;

    --==================================================
    -- Update PendingUpdateID for Valid Records
    --==================================================
    UPDATE dbo.U_ITRPLONIMP_drvTbl
    SET drvPendingUpdateID = LEFT(@FormatCode + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --============================================================
    -- Generate XML File for Standard Web Import for Automation
    --============================================================
    BEGIN TRY
        -----------------------------------
        -- Clear BIM Tables by FormatCode
        -----------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;


        ---------------------------------------------------------
        -- Populate Lod Deduction Table (LodEDed) for Loan File
        ---------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEEMemberOrCaseNo,EedEEAmt,EedEEGoalAmt,EedEEGTDAmt,EedStartDate,EedStopDate
            ,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
            ,EedEEMemberOrCaseNo = drvLoanNumber
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                             WHEN DedEECalcRule = '20' THEN
                                CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvLoanPaymentAmount
                                END
                        END
            ,EedEEGoalAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
                                WHEN DedEEGoalRule <> 'Z' THEN CONVERT(MONEY,drvLoanGoalAmount)
                           END
            ,EedEEGTDAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
                                WHEN DedEEGoalRule <> 'Z' THEN
                                    CASE WHEN drvAction = 'RESTART' THEN CONVERT(MONEY,0.00) END
                           END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvPeriodStartDate
                                 ELSE '12/30/1899'
                            END
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(VARCHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
                                ELSE '01/01/1900'
                           END
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction = 'STOP' THEN '401'
                                    WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
                               END
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
        FROM dbo.U_ITRPLONIMP_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'LOAN';

        --============================================================
        -- Generate XML File for Web Import Tool
        --============================================================
        DECLARE @XMLFilePath VARCHAR(1000) = '' --dbo.Dsi_fnVariable(@FormatCode,'XMLPath')
            ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_ITRPLONIMP_drvTbl (drvError)
       SELECT 'Error Loading Records for Validation/Posting: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==========================
    -- Report Successful Update
    --==========================
    UPDATE dbo.U_ITRPLONIMP_drvTbl
        SET drvError = 'Loaded Successfully'
            ,drvImported = 1
    WHERE drvImported = 0
    AND EXISTS (SELECT * FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID);

    --===========================
    -- Reject Remaining Records
    --===========================
    UPDATE dbo.u_ITRPLONIMP_drvTbl
        SET drvError = 'Record Rejected'
            ,drvAction = 'REJECTED'
            ,drvImported = 2
    WHERE drvImported = 0;

END
/**********************************************************************************

--Create the View
CREATE VIEW dbo.dsi_vwITRPLONIMP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ITRPLONIMP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ITRPLONIMP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201901011'
       ,ExpStartPerControl     = '201901011'
       ,ExpLastEndPerControl   = '201901019'
       ,ExpEndPerControl       = '201901019'
WHERE ExpFormatCode = 'ITRPLONIMP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwITRPLONIMP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ITRPLONIMP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ITRPLONIMP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ITRPLONIMP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ITRPLONIMP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ITRPLONIMP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ITRPLONIMP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ITRPLONIMP', 'UseFileName', 'V', 'Y'


-- End ripout