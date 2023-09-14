/**********************************************************************************

IPRINC401K: Principal 401k Deferral and Loan Import

FormatCode:     IPRINC401K
Project:        Principal 401k Deferral and Loan Import
Client ID:      SAT1001
Date/time:      2023-06-20 10:36:30.693
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    nwp
Server:         nw1wup8db01
Database:       ULTIPRO_WPSATI
Web Filename:   SAT1001_Y2IT0_EEHISTORY_IPRINC401K_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\nw1\Public\SAT1001\Import\Principal\Archive\
ExportPath:    
ImportPath:    \\us.saas\nw1\Public\SAT1001\Import\Principal\
XmlPath:       

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_IPRINC401K_SavePath') IS NOT NULL DROP TABLE dbo.U_IPRINC401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'IPRINC401K'


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
WHERE FormatCode = 'IPRINC401K'
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
WHERE ExpFormatCode = 'IPRINC401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'IPRINC401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'IPRINC401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'IPRINC401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'IPRINC401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'IPRINC401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'IPRINC401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'IPRINC401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'IPRINC401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'IPRINC401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'IPRINC401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwIPRINC401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwIPRINC401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_IPRINC401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IPRINC401K];
GO
IF OBJECT_ID('U_IPRINC401K_Raw') IS NOT NULL DROP TABLE [dbo].[U_IPRINC401K_Raw];
GO
IF OBJECT_ID('U_IPRINC401K_Import') IS NOT NULL DROP TABLE [dbo].[U_IPRINC401K_Import];
GO
IF OBJECT_ID('U_IPRINC401K_File') IS NOT NULL DROP TABLE [dbo].[U_IPRINC401K_File];
GO
IF OBJECT_ID('U_IPRINC401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_IPRINC401K_EEList];
GO
IF OBJECT_ID('U_IPRINC401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_IPRINC401K_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','IPRINC401K','Principal 401k Deferral and Loan Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','IPRINC401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IPRINC401KZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IPRINC401KZ0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IPRINC401KZ0','50','H','01','3',NULL,'Contribution Code',NULL,NULL,'"Contribution Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IPRINC401KZ0','50','H','01','4',NULL,'Deduction Code',NULL,NULL,'"Deduction Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IPRINC401KZ0','50','H','01','5',NULL,'Deferral Percent Amount',NULL,NULL,'"Deferral Percent Amount "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IPRINC401KZ0','50','H','01','6',NULL,'Deferral Dollar Amount',NULL,NULL,'"Deferral Dollar Amount "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IPRINC401KZ0','50','H','01','7',NULL,'Loan Payment Amount',NULL,NULL,'"Loan Payment Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IPRINC401KZ0','50','H','01','8',NULL,'Loan Payback Amount',NULL,NULL,'"Loan Payback Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IPRINC401KZ0','50','H','01','9',NULL,'Loan ID',NULL,NULL,'"Loan ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IPRINC401KZ0','50','H','01','10',NULL,'Import Type',NULL,NULL,'"Import Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IPRINC401KZ0','50','H','01','11',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','IPRINC401KZ0','50','H','01','12',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','IPRINC401KZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','IPRINC401KZ0','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','IPRINC401KZ0','50','D','10','3',NULL,'Contribution Code',NULL,NULL,'"drvContributionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','IPRINC401KZ0','50','D','10','4',NULL,'Deduction Code',NULL,NULL,'"drvDedCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','IPRINC401KZ0','50','D','10','5',NULL,'Deferral Percent Amount',NULL,NULL,'"drvDeferralPercentAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','IPRINC401KZ0','50','D','10','6',NULL,'Deferral Dollar Amount',NULL,NULL,'"drvDeferralDollarAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','IPRINC401KZ0','50','D','10','7',NULL,'Loan Payment Amount',NULL,NULL,'"drvPaymentAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','IPRINC401KZ0','50','D','10','8',NULL,'Loan Payback Amount',NULL,NULL,'"drvPaybackAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','IPRINC401KZ0','50','D','10','9',NULL,'Loan ID',NULL,NULL,'"drvLoanID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','IPRINC401KZ0','50','D','10','10',NULL,'Import Type',NULL,NULL,'"drvImportType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','IPRINC401KZ0','50','D','10','11',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','IPRINC401KZ0','250','D','10','12',NULL,'Error',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'IPRINC401K_20230620.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','AU2AW,AU18G,AU27K',NULL,NULL,NULL,'Import Deferral File Only','202303229','EMPEXPORT','DEFERRAL',NULL,'IPRINC401K',NULL,NULL,NULL,'202303229',NULL,'Dec 30 1899 12:00AM','202303221',NULL,'','','202303221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','AU2AW,AU18G,AU27K',NULL,NULL,NULL,'Import Loan File Only','202303229','EMPEXPORT','LOAN',NULL,'IPRINC401K',NULL,NULL,NULL,'202303229',NULL,'Dec 30 1899 12:00AM','202303221',NULL,'','','202303221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','ArchivePath','V','\\us.saas\nw1\Public\SAT1001\Import\Principal\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','ImportPath','V','\\us.saas\nw1\Public\SAT1001\Import\Principal\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','UseFileName','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('IPRINC401K','XmlPath','V','');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('IPRINC401K','D10','dbo.U_IPRINC401K_drvTbl WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_IPRINC401K_drvTbl
-----------

IF OBJECT_ID('U_IPRINC401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_IPRINC401K_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvRecordType] varchar(50) NULL,
    [drvPrefix] varchar(50) NULL,
    [drvContractNumber] varchar(50) NULL,
    [drvEmployeeName] varchar(100) NULL,
    [drvEmployeeIDNo] varchar(50) NULL,
    [drvEmployeeSSN] varchar(50) NULL,
    [drvPayrollSite] varchar(50) NULL,
    [drvDeferralDate] varchar(50) NULL,
    [drvEventTypeCode] varchar(50) NULL,
    [drvContributionCode] varchar(50) NULL,
    [drvTypeofPayCode] varchar(50) NULL,
    [drvDeferralPercentAmt] varchar(50) NULL,
    [drvDeferralDollarAmt] varchar(50) NULL,
    [drvPlanEntryDate] varchar(50) NULL,
    [drvLocationPayrollSite] varchar(50) NULL,
    [drvPaybackAmount] varchar(50) NULL,
    [drvPaymentAmount] varchar(50) NULL,
    [drvFirstPaymentdate] varchar(50) NULL,
    [drvLoanID] varchar(50) NULL,
    [drvEmployerAssignID] varchar(50) NULL,
    [drvFiller] varchar(50) NULL,
    [drvAction] varchar(50) NULL,
    [drvError] varchar(250) NULL,
    [drvImported] tinyint NOT NULL DEFAULT ((0)),
    [drvEEID] varchar(12) NULL,
    [drvCOID] varchar(5) NULL,
    [drvDedCode] varchar(50) NULL,
    [drvImportType] varchar(50) NULL,
    [drvPeriodStartDate] varchar(50) NULL,
    [drvPendingUpdateID] char(20) NULL,
    [drvInitialSort] varchar(50) NULL,
    [drvSubSort] varchar(50) NULL
);

-----------
-- Create table U_IPRINC401K_EEList
-----------

IF OBJECT_ID('U_IPRINC401K_EEList') IS NULL
CREATE TABLE [dbo].[U_IPRINC401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_IPRINC401K_File
-----------

IF OBJECT_ID('U_IPRINC401K_File') IS NULL
CREATE TABLE [dbo].[U_IPRINC401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_IPRINC401K_Import
-----------

IF OBJECT_ID('U_IPRINC401K_Import') IS NULL
CREATE TABLE [dbo].[U_IPRINC401K_Import] (
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
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_IPRINC401K_Raw
-----------

IF OBJECT_ID('U_IPRINC401K_Raw') IS NULL
CREATE TABLE [dbo].[U_IPRINC401K_Raw] (
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
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_IPRINC401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Satellite Industries Inc

Created By: Tushar Pathak
Business Analyst: Becca Horton
Create Date: 02/21/2023
Service Request Number: SR-2022-00389454

Purpose: Principal 401k and Loan Import

NOTE TO SUPPORT: This interface is setup for Automated Web Imports utilizing UltiPro Web Import Tool

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'IPRINC401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'IPRINC401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'IPRINC401K';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'IPRINC401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'IPRINC401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IPRINC401K', 'DEFERRAL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'IPRINC401K', 'LOAN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'IPRINC401K', @AllObjects = 'Y', @IsWeb = 'Y';
**********************************************************************************/
BEGIN

    --========================================
    -- Declare Variables
    --========================================
    DECLARE  @FormatCode VARCHAR(10)
            ,@ImportPath VARCHAR(1000)
            ,@ExportCode VARCHAR(12);

    SET @FormatCode = 'IPRINC401K';
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');

    --==================================================
    -- Set FileName
    --==================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'Principal 401k and Loan Import_' + LTRIM(RTRIM(@ExportCode)) + '_'
                        + CONVERT(CHAR(8),GETDATE(),112) + '.'                    -- YYMMDD
                        + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMss
                        + '.csv'
        WHERE FormatCode = @FormatCode;
    END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_IPRINC401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_IPRINC401K_drvTbl;
    CREATE TABLE dbo.U_IPRINC401K_drvTbl (
        drvSurrogateKey VARCHAR(50) NULL
        ,drvRecordType VARCHAR(50) NULL
        ,drvPrefix VARCHAR(50) NULL
        ,drvContractNumber VARCHAR(50) NULL
        ,drvEmployeeName VARCHAR(100) NULL
        ,drvEmployeeIDNo VARCHAR(50) NULL
        ,drvEmployeeSSN VARCHAR(50) NULL
        ,drvPayrollSite VARCHAR(50) NULL
        ,drvDeferralDate VARCHAR(50) NULL
        ,drvEventTypeCode VARCHAR(50) NULL
        ,drvContributionCode VARCHAR(50) NULL
        ,drvTypeofPayCode VARCHAR(50) NULL
        ,drvDeferralPercentAmt VARCHAR(50) NULL
        ,drvDeferralDollarAmt VARCHAR(50) NULL
        ,drvPlanEntryDate VARCHAR(50) NULL
        ,drvLocationPayrollSite VARCHAR(50) NULL
        ,drvPaybackAmount VARCHAR(50) NULL
        ,drvPaymentAmount VARCHAR(50) NULL
        ,drvFirstPaymentdate VARCHAR(50) NULL
        ,drvLoanID VARCHAR(50) NULL
        ,drvEmployerAssignID VARCHAR(50) NULL
        ,drvFiller VARCHAR(50) NULL
        ,drvAction VARCHAR(50) NULL
        ,drvError VARCHAR(250) NULL
        ,drvImported TINYINT DEFAULT 0 NOT NULL
        ,drvEEID VARCHAR(12) NULL
        ,drvCOID VARCHAR(5) NULL
        ,drvDedCode VARCHAR(50) NULL
        ,drvImportType VARCHAR(50) NULL
        ,drvPeriodStartDate VARCHAR(50) NULL
        ,drvPendingUpdateID CHAR(20) NULL
        ,drvInitialSort VARCHAR(50) NULL
        ,drvSubSort VARCHAR(50) NULL
    );

    --===================================
    -- BIM CODE - DEFERRAL RECORDS
    --===================================
    IF (@ExportCode = 'DEFERRAL')
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEFERRAL');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*DFRL*'); --File Name contains "DFRL"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','16'); --MAX Fields Across All Layouts
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field6','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

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

        ------------------------------------------------------------------------------
        -- Only Retain Deferral Records where Record ID = '010' (Deferral) in Field# 1
        ------------------------------------------------------------------------------
        DELETE FROM dbo.U_IPRINC401K_Import WHERE RunID = 'DEFERRAL' AND LTRIM(RTRIM(Field1)) <> '010' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Delimited Deferral File (BIM): ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --===================================
    -- BIM CODE - LOAN RECORDS
    --===================================
    IF (@ExportCode = 'LOAN')
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','LOAN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*LOAN*'); --File Name contains "LOAN"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','16'); --MAX Fields Across All Layouts
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field6','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

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

        ------------------------------------------------------------------------------
        -- Only Retain Loan Records where Record ID = '030' (Loan) in Field# 1
        ------------------------------------------------------------------------------
        DELETE FROM dbo.U_IPRINC401K_Import WHERE RunID = 'LOAN' AND LTRIM(RTRIM(Field1)) <> '030' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Delimited Loan File (BIM): ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================================
    -- If Error During BIM, then Report Error and Stop Processing
    --==============================================================
    IF EXISTS (SELECT 1 FROM dbo.U_IPRINC401K_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
        INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
        SELECT Error, 2 FROM dbo.U_IPRINC401K_Import WHERE ISNULL(Error,'') <> '';

        -- Stop Processing
        RETURN;
    END;

    --==================================================
    -- Build Driver Table - Deferrals
    --==================================================
    IF (@ExportCode = 'DEFERRAL')
    BEGIN TRY
        ----------------------------------------------
        -- Load Deferral Percent Amount Records
        ----------------------------------------------
        INSERT INTO dbo.U_IPRINC401K_drvTbl(drvSurrogateKey,drvRecordType,drvPrefix,drvContractNumber,drvEmployeeName,drvEmployeeIDNo,drvEmployeeSSN,drvPayrollSite
            ,drvDeferralDate,drvEventTypeCode,drvContributionCode,drvTypeofPayCode,drvDeferralPercentAmt,drvPlanEntryDate,drvEmployerAssignID,drvFiller
            ,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort,drvSubSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvRecordType = NULLIF(Field1,'')
            ,drvPrefix = NULLIF(Field2,'')
            ,drvContractNumber = NULLIF(Field3,'')
            ,drvEmployeeName = NULLIF(Field4,'')
            ,drvEmployeeIDNo = NULLIF(Field5,'')
            ,drvEmployeeSSN = NULLIF(Field6,'')
            ,drvPayrollSite = NULLIF(Field7,'')
            ,drvDeferralDate = NULLIF(Field8,'')
            ,drvEventTypeCode = NULLIF(Field9,'')
            ,drvContributionCode = NULLIF(Field10,'')
            ,drvTypeofPayCode = NULLIF(Field11,'')
            ,drvDeferralPercentAmt = CONVERT(DECIMAL(10,4),CONVERT(MONEY,Field12))
            ,drvPlanEntryDate = NULLIF(Field14,'')
            ,drvEmployerAssignID = NULLIF(Field15,'')
            ,drvFiller = NULLIF(Field16,'')
            ,drvAction = CASE WHEN NULLIF(Field6,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT Setup in UltiPro.
                              -- Process Stops
                              WHEN CONVERT(MONEY,Field12) = 0.00 THEN
                                CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                     ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
                                END
                              -- Process Add/Changes
                              WHEN EedDedCode IS NOT NULL THEN
                                CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                     ELSE 'CHANGE'
                                END
                              ELSE 'ADD'
                         END
            ,drvError = CASE WHEN NULLIF(Field6,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT Setup in UltiPro.'
                             WHEN CONVERT(MONEY,Field12) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN NULLIF(Field6,'') IS NULL THEN 2 --Missing [SSN] Value in File.
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT Setup in UltiPro.
                                WHEN CONVERT(MONEY,Field12) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = DedDedCode
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvInitialSort = Field6
            ,drvSubSort = 'PERCENT'
        FROM dbo.U_IPRINC401K_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = CASE WHEN ISNULL(Field10,'') = '0001' THEN '401P' --Pre-Tax Deferral %
                                 WHEN ISNULL(Field10,'') = '0021' THEN 'ROTHP' --Roth %
                            END
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'DEFERRAL'
        AND ISNULL(Field12,'') <> '';

        ----------------------------------------------
        -- Load Deferral Dollar Amount Records
        ----------------------------------------------
        INSERT INTO dbo.U_IPRINC401K_drvTbl(drvSurrogateKey,drvRecordType,drvPrefix,drvContractNumber,drvEmployeeName,drvEmployeeIDNo,drvEmployeeSSN,drvPayrollSite
            ,drvDeferralDate,drvEventTypeCode,drvContributionCode,drvTypeofPayCode,drvDeferralDollarAmt,drvPlanEntryDate,drvEmployerAssignID,drvFiller
            ,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort,drvSubSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvRecordType = NULLIF(Field1,'')
            ,drvPrefix = NULLIF(Field2,'')
            ,drvContractNumber = NULLIF(Field3,'')
            ,drvEmployeeName = NULLIF(Field4,'')
            ,drvEmployeeIDNo = NULLIF(Field5,'')
            ,drvEmployeeSSN = NULLIF(Field6,'')
            ,drvPayrollSite = NULLIF(Field7,'')
            ,drvDeferralDate = NULLIF(Field8,'00000000')
            ,drvEventTypeCode = NULLIF(Field9,'')
            ,drvContributionCode = NULLIF(Field10,'00000000')
            ,drvTypeofPayCode = NULLIF(Field11,'')
            ,drvDeferralDollarAmt = CONVERT(MONEY,Field13)
            ,drvPlanEntryDate = NULLIF(Field14,'')
            ,drvEmployerAssignID = NULLIF(Field15,'')
            ,drvFiller = NULLIF(Field16,'')
            ,drvAction = CASE WHEN NULLIF(Field6,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT Setup in UltiPro.
                              -- Process Stops
                              WHEN CONVERT(MONEY,Field13) = 0.00 THEN
                                CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                     ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
                                END
                              -- Process Add/Changes
                              WHEN EedDedCode IS NOT NULL THEN
                                CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                     ELSE 'CHANGE'
                                END
                              ELSE 'ADD'
                         END
            ,drvError = CASE WHEN NULLIF(Field6,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT Setup in UltiPro.'
                             WHEN CONVERT(MONEY,Field13) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN NULLIF(Field6,'') IS NULL THEN 2 --Missing [SSN] Value in File.
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT Setup in UltiPro.
                                WHEN CONVERT(MONEY,Field13) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = DedDedCode
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvInitialSort = Field6
            ,drvSubSort = 'AMOUNT'
        FROM dbo.U_IPRINC401K_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = CASE WHEN ISNULL(Field10,'') = '0001' THEN '401F' --Pre-Tax Deferral %
                                 WHEN ISNULL(Field10,'') = '0017' THEN '401CF' --Catch-up Deferral %
                                 WHEN ISNULL(Field10,'') = '0021' THEN 'ROTHF' --Roth %
                                 WHEN ISNULL(Field10,'') = '0041' THEN 'ROTCF' --Roth Catch-Up %
                            END
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'DEFERRAL'
        AND ISNULL(Field13,'') <> '';
        
        /*--====================================================
        -- Custom Code for Adding MATCH Plan
        --    *** NOTE: Remove the Code is Not Needed *** 
        --====================================================
        INSERT INTO dbo.U_IPRINC401K_drvTbl(drvSurrogateKey,drvEmployeeName,drvEmployeeSSN,drvContributionCode,drvDeferralPercentAmt,drvDeferralDollarAmt
            ,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort,drvSubSort)
        SELECT DISTINCT        
             drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvEmployeeName
            ,drvEmployeeSSN
            ,drvContributionCode = ''
            ,drvDeferralPercentAmt = CONVERT(MONEY,0.00)
            ,drvDeferralDollarAmt = CONVERT(MONEY,0.00)
            ,drvAction = 'ADD'
            ,drvError
            ,drvImported
            ,drvEEID
            ,drvCOID
            ,drvDedCode
            ,drvImportType
            ,drvPeriodStartDate
            ,drvInitialSort
            ,drvSubSort = 'MATCH'
        FROM dbo.U_IPRINC401K_drvTbl
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = '@MATCHDedCode'
        WHERE drvImportType = 'DEFERRAL'
        AND drvImported = 0
        AND NOT EXISTS (SELECT 1 FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = drvEEID AND EedCoID = drvCOID AND EedDedCode = DedDedCode);
        */
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Deferral File: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --==================================================
    -- Build Driver Table - Loans
    --==================================================
    IF (@ExportCode = 'LOAN')
    BEGIN TRY
        INSERT INTO dbo.U_IPRINC401K_drvTbl (drvSurrogateKey,drvRecordType,drvPrefix,drvContractNumber,drvEmployeeName,drvEmployeeIDNo,drvEmployeeSSN
            ,drvLocationPayrollSite,drvPaybackAmount,drvPaymentAmount,drvFirstPaymentdate,drvLoanID,drvEmployerAssignID,drvFiller,drvAction,drvError
            ,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort,drvSubSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvRecordType = NULLIF(Field1,'')
            ,drvPrefix = NULLIF(Field2,'')
            ,drvContractNumber = NULLIF(Field3,'')
            ,drvEmployeeName = NULLIF(Field4,'')
            ,drvEmployeeIDNo = NULLIF(Field5,'')
            ,drvEmployeeSSN = NULLIF(Field6,'')
            ,drvLocationPayrollSite = NULLIF(Field7,'')
            ,drvPaybackAmount = CONVERT(MONEY,Field8)
            ,drvPaymentAmount = CONVERT(MONEY,Field9)
            ,drvFirstPaymentdate = NULLIF(IIF(ISDATE(Field10)=1,Field10,STUFF(STUFF(Field10,3,0,'/'),6,0,'/')),'00/00/0000')
            ,drvLoanID = NULLIF(Field11,'')
            ,drvEmployerAssignID = NULLIF(Field12,'')
            ,drvFiller = NULLIF(Field13,'')
            ,drvAction = CASE WHEN NULLIF(Field1,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
                              WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
                              ELSE
                                CASE WHEN CONVERT(MONEY,Field9) = 0.00 THEN
                                        CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                             ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
                                        END
                                     WHEN EedDedCode IS NOT NULL THEN
                                        CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                             ELSE 'CHANGE'
                                        END
                                     ELSE 'ADD'
                                END
                         END
            ,drvError = CASE WHEN NULLIF(Field1,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
                             WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
                             WHEN CONVERT(MONEY,Field9) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN NULLIF(Field1,'') IS NULL THEN 2 --Missing [SSN] Value in File.
                                WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN CONVERT(MONEY,Field9) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = DedDedCode
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
            ,drvInitialSort = Field6
            ,drvSubSort = 'AMOUNT'
        FROM dbo.U_IPRINC401K_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = '401L'
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON EedEEID = EEID
            AND EedCoID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'LOAN';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
       SELECT 'Error Processing Loan File: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --=============================================
    -- Update PendingUpdateID for Valid Records
    --=============================================
    UPDATE dbo.U_IPRINC401K_drvTbl
    SET drvPendingUpdateID = LEFT(@FormatCode + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --============================================================
    -- Generate XML File for Standard Web Import for Automation
    --============================================================
    BEGIN TRY
        --========================================================
        -- Populate BIM Lod Deduction Table for Web
        --========================================================
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;

        --========================================================
        -- Populate Lod Deduction Table (BIM LodEDed) for Deferrals
        --========================================================
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedEEAmt,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate
            ,EedStopDate,EedBenStatus,EedBenOption,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID) --EedEECalcRule
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
            ,EedEECalcRateOrPct = CASE -- Only Populate for Employee (EE) Non-Flat Amount Calc Rule ('20')
                                       WHEN DedEECalcRule <> '20' AND drvSubSort IN ('PERCENT','MATCH') THEN
                                           CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                                WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvDeferralPercentAmt) * 100
                                            END
                                  END
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                             WHEN DedEECalcRule = '20' AND drvSubSort IN ('AMOUNT','MATCH') THEN
                                CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvDeferralDollarAmt)
                                END
                        END
            ,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                    WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvPeriodStartDate)
                                    ELSE '12/30/1899'
                               END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvPeriodStartDate)
                                 ELSE '12/30/1899'
                            END
            ,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(DATETIME,drvPeriodStartDate)
                                     WHEN drvAction IN ('STOP') THEN DATEADD(DAY,-1,CONVERT(DATETIME,drvPeriodStartDate))
                                     ELSE '12/30/1899'
                                END
            ,EedBenStopDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                   ELSE '01/01/1900'
                              END
            ,EedStopDate = '01/01/1900'
            ,EedBenStatus = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                 ELSE 'A' --Always Active
                            END
            ,EedBenOption = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN NULL
                                 WHEN EXISTS (SELECT 1 FROM dbo.EmpDed WHERE EedEEID = DrvEEID AND EedCOID = DrvCOID AND EedDedCode = drvDedCode AND ISNULL(EedBenOption,'') = 'Z') THEN '' -- Set 'Z' (None) to Blank
                            END
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction = 'STOP' THEN '401'
                                    ELSE '402'
                               END
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
            --,EedEECalcRule = DedEECalcRule    -- This may need to be set if existing records don't match Deduction/Benefit Plan Calc Rule (i.e., changing from % to Flat Amount)
        FROM dbo.U_IPRINC401K_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'DEFERRAL';

        --========================================================
        -- Populate Lod Deduction Table (BIM LodEDed) for Loans
        --========================================================
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedNotes,EedEEAmt,EedEEGTDAmt,EedStartDate,EedStopDate --,EedEEGoalAmt
            ,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
            ,EedNotes = drvLoanID
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                             WHEN DedEECalcRule = '20' AND drvSubSort = 'AMOUNT' THEN
                                CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvPaymentAmount)
                                END
                        END
            -- Best Practice is NOT to load Goal Amounts to avoid Premature Stopping of Deductions
            --,EedEEGoalAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
            --                    WHEN DedEEGoalRule <> 'Z' THEN CONVERT(MONEY,drvPaybackAmount)
            --                END
            ,EedEEGTDAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
                                WHEN DedEEGoalRule <> 'Z' THEN
                                    CASE WHEN drvAction = 'RESTART' THEN CONVERT(MONEY,0.00) END
                           END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(DATETIME,drvFirstPaymentdate)
                                 ELSE '12/30/1899'
                            END
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN DATEADD(DAY,-1,CONVERT(DATETIME,drvPeriodStartDate))
                                ELSE '01/01/1900'
                           END
            ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction = 'STOP' THEN '401'
                                    --WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
                                    ELSE '402'
                               END
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
            ,EedInclInAddlChk = DedInclInAddlChk
            ,EedInclInManlChk = DedInclInManlChk
            ,EedPendingUpdateID = drvPendingUpdateID
        FROM dbo.U_IPRINC401K_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'LOAN';

        --======================================================================
        -- Generate XML File for Standard Web Import to Validate/Post Records
        --======================================================================
        DECLARE @XMLFilePath VARCHAR(1000) = IIF(dbo.dsi_fnVariable(@FormatCode, 'Testing') = 'Y',dbo.dsi_fnVariable(@FormatCode, 'XmlPath'),'')
               ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

  --      PRINT CONCAT('----XML FILEPATH = ',@XmlFilePath)
        
        --IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', '', @XMLArchiveFilePath;
        --ELSE
        --    EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;

        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_IPRINC401K_drvTbl (drvError,drvImported)
       SELECT 'Error Generating XML File for Standard Web Import: ' + ISNULL(ERROR_MESSAGE(),''),2;

       -- Stop Processing
       RETURN;
    END CATCH;

    --===========================
    -- Report Successful
    --===========================
    UPDATE dbo.u_IPRINC401K_drvTbl
    SET drvError = 'Loaded Successfully'
       ,drvImported = 1
    WHERE drvImported = 0
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID);

    --===========================
    -- Reject Remaining Records
    --===========================
    UPDATE dbo.u_IPRINC401K_drvTbl
    SET drvError = 'Record Rejected'
       ,drvAction = 'REJECTED'
       ,drvImported = 2
    WHERE drvImported = 0;

END
/**********************************************************************************

--Create the View
CREATE VIEW dbo.dsi_vwIPRINC401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IPRINC401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'IPRINC401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201906011'
       ,ExpStartPerControl     = '201906011'
       ,ExpLastEndPerControl   = '201906019'
       ,ExpEndPerControl       = '201906019'
WHERE ExpFormatCode = 'IPRINC401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwIPRINC401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_IPRINC401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'IPRINC401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'IPRINC401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'IPRINC401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IPRINC401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'IPRINC401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'IPRINC401K', 'UseFileName', 'V', 'Y'


-- End ripout