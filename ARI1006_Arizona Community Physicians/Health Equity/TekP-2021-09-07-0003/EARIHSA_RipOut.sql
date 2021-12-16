/**********************************************************************************

EARIHSA: Health Equity FSA HSA Contribution

FormatCode:     EARIHSA
Project:        Health Equity FSA HSA Contribution
Client ID:      ARI1006
Date/time:      2021-12-16 13:22:14.907
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP2DB03
Database:       ULTIPRO_WPARIC
Web Filename:   ARI1006_CL2YX_EEHISTORY_EARIHSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EARIHSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EARIHSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EARIHSA'


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
WHERE FormatCode = 'EARIHSA'
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
WHERE ExpFormatCode = 'EARIHSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EARIHSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EARIHSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EARIHSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EARIHSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EARIHSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EARIHSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EARIHSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EARIHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EARIHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EARIHSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEARIHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEARIHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EARIHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARIHSA];
GO
IF OBJECT_ID('U_EARIHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_PEarHist];
GO
IF OBJECT_ID('U_EARIHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_PDedHist];
GO
IF OBJECT_ID('U_EARIHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_File];
GO
IF OBJECT_ID('U_EARIHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_EEList];
GO
IF OBJECT_ID('U_EARIHSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_drvTbl];
GO
IF OBJECT_ID('U_EARIHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_DedList];
GO
IF OBJECT_ID('U_EARIHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_AuditFields];
GO
IF OBJECT_ID('U_EARIHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EARIHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EARIHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EARIHSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EARIHSA','Health Equity FSA HSA Contribution','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EARIHSA000Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARIHSA000Z0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"FND"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARIHSA000Z0','50','D','10','2',NULL,'Group ID',NULL,NULL,'"drvGroupID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARIHSA000Z0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvEmpID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARIHSA000Z0','50','D','10','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARIHSA000Z0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARIHSA000Z0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARIHSA000Z0','50','D','10','7',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARIHSA000Z0','50','D','10','8',NULL,'Pre-Tax Payroll Deduction',NULL,NULL,'"drvPTPayDed"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARIHSA000Z0','50','D','10','9',NULL,'Post-Tax Payroll Deduction',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARIHSA000Z0','50','D','10','10',NULL,'Other Post-Tax Participant Contribution',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARIHSA000Z0','50','D','10','11',NULL,'Pre-Tax Program Sponsor Contribution (Applies towa',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARIHSA000Z0','50','D','10','12',NULL,'Post-Tax Program Sponsor Contribution (Applies tow',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARIHSA000Z0','50','D','10','13',NULL,'Pre-Tax Program Sponsor Contribution (Additional B',NULL,NULL,'"drvPTProgSponCont"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARIHSA000Z0','50','D','10','14',NULL,'Post-Tax Program Sponsor Contribution (Additional',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARIHSA000Z0','50','D','10','15',NULL,'Funding Date',NULL,NULL,'"drvFundDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARIHSA000Z0','50','D','10','16',NULL,'Pre-Tax Program Sponsor Interest',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARIHSA000Z0','50','D','10','17',NULL,'Post-Tax Program Sponsor Interest',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARIHSA000Z0','50','D','10','18',NULL,'Balance Transfer From Account',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARIHSA000Z0','50','D','10','19',NULL,'Balance Transfer Percentage',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARIHSA000Z0','50','D','10','20',NULL,'Balance Transfer Max Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARIHSA000Z0','50','D','10','21',NULL,'Custom Contribution Description',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EARIHSA_20211216.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity FSAHSA Con-Act OE','202112029','EMPEXPORT','OEACTIVE','Dec  6 2021 12:00AM','EARIHSA',NULL,NULL,NULL,'202112029','Dec  2 2021 12:00AM','Dec 30 1899 12:00AM','202112021',NULL,'',NULL,'202112021',dbo.fn_GetTimedKey(),NULL,'us3cPeARI1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity FSAHSA Con-PassOE','202112029','EMPEXPORT','OEPASSIVE','Dec  6 2021 12:00AM','EARIHSA',NULL,NULL,NULL,'202112029','Dec  2 2021 12:00AM','Dec 30 1899 12:00AM','202112021',NULL,'',NULL,'202112021',dbo.fn_GetTimedKey(),NULL,'us3cPeARI1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity FSAHSA Cont OnDem','202112029','EMPEXPORT','ONDEM_XOE','Dec  6 2021 12:00AM','EARIHSA',NULL,NULL,NULL,'202112029','Dec  2 2021 12:00AM','Dec 30 1899 12:00AM','202112021',NULL,'',NULL,'202112021',dbo.fn_GetTimedKey(),NULL,'us3cPeARI1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity FSAHSA Cont-Sched','202112029','EMPEXPORT','SCH_EARIHS','Dec  6 2021 12:00AM','EARIHSA',NULL,NULL,NULL,'202112029','Dec  2 2021 12:00AM','Dec 30 1899 12:00AM','202112021',NULL,'',NULL,'202112021',dbo.fn_GetTimedKey(),NULL,'us3cPeARI1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'HealthEquity FSA HSA Cont-Test','202111269','EMPEXPORT','TEST_XOE','Dec  7 2021  5:33PM','EARIHSA',NULL,NULL,NULL,'202111269','Nov 26 2021 12:00AM','Dec 30 1899 12:00AM','202111261','241','eecPayGroup','EMPL','202111261',dbo.fn_GetTimedKey(),NULL,'us3cPeARI1006',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARIHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARIHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARIHSA','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARIHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARIHSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARIHSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARIHSA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARIHSA','D10','dbo.U_EARIHSA_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EARIHSA
-----------

IF OBJECT_ID('U_dsi_BDM_EARIHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EARIHSA] (
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
-- Create table U_EARIHSA_Audit
-----------

IF OBJECT_ID('U_EARIHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_Audit] (
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
-- Create table U_EARIHSA_AuditFields
-----------

IF OBJECT_ID('U_EARIHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EARIHSA_DedList
-----------

IF OBJECT_ID('U_EARIHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EARIHSA_drvTbl
-----------

IF OBJECT_ID('U_EARIHSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvGroupID] varchar(5) NOT NULL,
    [drvEmpID] char(9) NULL,
    [drvUniqueID] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvPlanCode] nvarchar(4000) NULL,
    [drvPTPayDed] numeric NULL,
    [drvPTProgSponCont] numeric NULL,
    [drvFundDate] datetime NULL
);

-----------
-- Create table U_EARIHSA_EEList
-----------

IF OBJECT_ID('U_EARIHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EARIHSA_File
-----------

IF OBJECT_ID('U_EARIHSA_File') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EARIHSA_PDedHist
-----------

IF OBJECT_ID('U_EARIHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
	PdhDedCode varchar(10) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL
);

-----------
-- Create table U_EARIHSA_PEarHist
-----------

IF OBJECT_ID('U_EARIHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EARIHSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARIHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Arizona Community Physicians

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 12/02/2021
Service Request Number: SR-2020-00288701

Purpose: HealthEquity HSA

Revision History
----------------
12/16/2021 by AP:
	- Cleaned up code outputting 2 HSA lines.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EARIHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EARIHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EARIHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EARIHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EARIHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARIHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARIHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARIHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARIHSA', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EARIHSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EARIHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EARIHSA';

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
    DELETE FROM dbo.U_EARIHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EARIHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
     --Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EARIHSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EARIHSA_AuditFields;
    CREATE TABLE dbo.U_EARIHSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EARIHSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EARIHSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EARIHSA_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EARIHSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EARIHSA_Audit;
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
    INTO dbo.U_EARIHSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EARIHSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -15, @EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EARIHSA_Audit ON dbo.U_EARIHSA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EARIHSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EARIHSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA, FSADC, FSALP, HSACF, HSACI, HSAF, HSAI, HSAER';

    IF OBJECT_ID('U_EARIHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EARIHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EARIHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','FSA, FSADC, FSALP, HSACF, HSACI, HSAF, HSAI, HSAER');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================
      -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EARIHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EARIHSA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        --,PehQTRCurAmt           = SUM(CASE WHEN PehPerControl between CONVERT(VARCHAR, DATEADD(D,-90,@EndDate), 112) + '1' and @EndPerControl THEN PehCurAmt ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        --,PehInclInDefCompHrs12Mth = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND  PehPerControl between CONVERT(VARCHAR, DATEADD(D,-365,@EndDate), 112) + '1' and @EndPerControl THEN PehCurHrs ELSE 0.00 END)
    INTO dbo.U_EARIHSA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --SUM(CASE WHEN PehPerControl between CONVERT(VARCHAR, DATEADD(D,-90,@EndDate), 112) + '1' and @EndPerControl THEN PehCurAmt ELSE 0.00 END)
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EARIHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EARIHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
		,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('FSA','FSALP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI','FSADC','FSA','FSALP') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EARIHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EARIHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EARIHSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EARIHSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EARIHSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvGroupID = '60341'
        ,drvEmpID = EecEmpno
        ,drvUniqueID = EepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvPlanCode =    CASE 
                            WHEN BdmDedCode in ('HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAER') THEN 'HSA' 
                            WHEN BdmDedCode in ('FSA', 'FSALP') THEN 'HCFSA' +FORMAT(CASE WHEN DATEPART(YEAR, GETDATE()) < 2022 THEN 2022 ELSE DATEPART(YEAR, GETDATE()) END, '0000') 
                            WHEN BdmDedCode in ('FSADC') THEN 'DCFSA' +FORMAT(CASE WHEN DATEPART(YEAR, GETDATE()) < 2022 THEN 2022 ELSE DATEPART(YEAR, GETDATE()) END, '0000') 
                        END
        ,drvPTPayDed = CASE WHEN pdh1.PdhDedCode in ('FSA','FSALP') THEN pdh1.PdhSource1
                            WHEN pdh3.PdhDedCode IN ('FSADC') THEN pdh3.PdhSource3        
                            WHEN pdh4.PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI') THEN pdh4.PdhSource4
                            ELSE '0.00'
                        END        
        ,drvPTProgSponCont = CASE WHEN pdh2.PdhDedCode = 'HSAER' and pdh2.PdhSource2 > 0 THEN pdh2.PdhSource2
									ELSE '0.00'
                                --WHEN pdh2.PdhDedCode <> 'HSAER' THEN '0.00'
                            END
        ,drvFundDate = CASE WHEN BdmDedCode in ('FSA', 'FSADC', 'FSALP', 'HSACF', 'HSACI', 'HSAF', 'HSAI','HSAER') THEN DATEADD(D,-2,PrgPayDate) END
    INTO dbo.U_EARIHSA_drvTbl
    FROM dbo.U_EARIHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND eecEEType <> 'TES'
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_EARIHSA_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_dsi_BDM_EARIHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EARIHSA_PDedHist pdh WITH (NOLOCK)
        ON pdh.PdhEEID = xEEID
	LEFT JOIN (SELECT PdhEEID, PdhDedCode, SUM(PdhSource1) PdhSource1
				FROM dbo.U_EARIHSA_PDedHist WITH(NOLOCK)
				WHERE PdhDedCode IN ('FSA', 'FSALP')
				GROUP BY PdhEEID, PdhDedCode) pdh1 ON pdh1.PdhEEID = pdh.PdhEEID
	LEFT JOIN (SELECT PdhEEID, PdhDedCode, SUM(PdhSource3) PdhSource3
				FROM dbo.U_EARIHSA_PDedHist WITH(NOLOCK)
				WHERE PdhDedCode IN ('FSADC')
				GROUP BY PdhEEID, PdhDedCode) pdh3 ON pdh3.PdhEEID = pdh.PdhEEID
	LEFT JOIN (SELECT PdhEEID, PdhDedCode, SUM(PdhSource4) PdhSource4
				FROM dbo.U_EARIHSA_PDedHist WITH(NOLOCK)
				WHERE PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI')
				GROUP BY PdhEEID, PdhDedCode) pdh4 ON pdh4.PdhEEID = pdh.PdhEEID
	LEFT JOIN (SELECT PdhEEID, PdhDedCode, SUM(CASE WHEN PdhSource2 > 0 THEN PdhSource2 END) AS PdhSource2
				FROM dbo.U_EARIHSA_PDedHist WITH(NOLOCK)
				WHERE PdhDedCode IN ('HSAER')
				GROUP BY PdhEEID, PdhDedCode) pdh2 ON pdh2.PdhEEID = pdh.PdhEEID
    LEFT JOIN dbo.U_EARIHSA_PEarHist
        on PehEEID =  xeeid
    ;
--    1 ENR Record for FSA benefits, 1 ENR Record for Dep Care FSA and 1 ENR Record for HSA benefits
--if eeddedcode HSACF, HSACI, HSAF, HSAI send HSA
--If eeddedcode is FSA , FSALP send HCFSA2022 
--         this value must change on 1/1 of every year
--if eeddedcode FSADC send DCFSA2022
--         this value must change on 1/1 of every year
--Important Note for the FSA Plan Codes
--The current Plan Year is  01/01/2022 - 12/31/2022
--Each year starting on 1/1 the Plan Codes for FSA benefits must reflect the current plan year
--For example 
--on 1/1/2023 the plan codes being sent on the file will need to be HCFSA2023 and DCFSA2023
--on 1/1/2024 the plan codes being sent on the file will need to be HCFSA2024 and DCFSA2024

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_PSF_60341_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_FND.UPD'
                                  ELSE 'PSF_60341_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_FND.UPD'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEARIHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EARIHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EARIHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110011'
       ,expStartPerControl     = '202110011'
       ,expLastEndPerControl   = '202112029'
       ,expEndPerControl       = '202112029'
WHERE expFormatCode = 'EARIHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEARIHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EARIHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EARIHSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EARIHSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EARIHSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARIHSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EARIHSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARIHSA', 'UseFileName', 'V', 'Y'


-- End ripout