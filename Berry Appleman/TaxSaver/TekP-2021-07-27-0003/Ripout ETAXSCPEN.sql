/**********************************************************************************

ETAXSCPEN: TaxSaver Commuter and Parking Enrollment

FormatCode:     ETAXSCPEN
Project:        TaxSaver Commuter and Parking Enrollment
Client ID:      BER1011
Date/time:      2021-11-09 19:12:51.780
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB03
Database:       ULTIPRO_WPBERRY
Web Filename:   BER1011_DB933_EEHISTORY_ETAXSCPEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETAXSCPEN_SavePath') IS NOT NULL DROP TABLE dbo.U_ETAXSCPEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETAXSCPEN'


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
WHERE FormatCode = 'ETAXSCPEN'
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
WHERE ExpFormatCode = 'ETAXSCPEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETAXSCPEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETAXSCPEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETAXSCPEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETAXSCPEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETAXSCPEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETAXSCPEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETAXSCPEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETAXSCPEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETAXSCPEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETAXSCPEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETAXSCPEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETAXSCPEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETAXSCPEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSCPEN];
GO
IF OBJECT_ID('U_ETAXSCPEN_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETAXSCPEN_PDedHist];
GO
IF OBJECT_ID('U_ETAXSCPEN_File') IS NOT NULL DROP TABLE [dbo].[U_ETAXSCPEN_File];
GO
IF OBJECT_ID('U_ETAXSCPEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSCPEN_EEList];
GO
IF OBJECT_ID('U_ETAXSCPEN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETAXSCPEN_drvTbl];
GO
IF OBJECT_ID('U_ETAXSCPEN_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSCPEN_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETAXSCPEN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETAXSCPEN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETAXSCPEN','TaxSaver Commuter and Parking Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ETAXSCPEN0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETAXSCPEN0Z0','50','D','10','1',NULL,'Employee Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETAXSCPEN0Z0','50','D','10','2',NULL,'Employee Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETAXSCPEN0Z0','50','D','10','3',NULL,'Employee First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETAXSCPEN0Z0','50','D','10','4',NULL,'Employee Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETAXSCPEN0Z0','50','D','10','5',NULL,'Current deduction for Parking',NULL,NULL,'"drvDedParking"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETAXSCPEN0Z0','50','D','10','6',NULL,'Current Year to Date for Parking',NULL,NULL,'"drvYTDParking"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETAXSCPEN0Z0','50','D','10','7',NULL,'Park Benefit Eligibility Date (mm/dd/yy)',NULL,NULL,'"drvParkStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETAXSCPEN0Z0','50','D','10','8',NULL,'Park Benefit Termination Date (mm/dd/yy)',NULL,NULL,'"drvParkEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETAXSCPEN0Z0','50','D','10','9',NULL,'Current deduction for Transit',NULL,NULL,'"drvDedTransit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETAXSCPEN0Z0','50','D','10','10',NULL,'Current Year to Date for Transit',NULL,NULL,'"drvYTDTransit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETAXSCPEN0Z0','50','D','10','11',NULL,'Transit Benefit Eligibility Date (mm/dd/yy)',NULL,NULL,'"drvTransitStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETAXSCPEN0Z0','50','D','10','12',NULL,'Transit Benefit Termination Date (mm/dd/yy)',NULL,NULL,'"drvTransitEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETAXSCPEN0Z0','128','D','10','13',NULL,'Employee Street Address (1 and 2)',NULL,NULL,'"drvAddrStreet"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETAXSCPEN0Z0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETAXSCPEN0Z0','50','D','10','15',NULL,'State abbreviation',NULL,NULL,'"drvAddrState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETAXSCPEN0Z0','50','D','10','16',NULL,'Zip code',NULL,NULL,'"drvAddrZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETAXSCPEN0Z0','128','D','10','17',NULL,'Department or Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETAXSCPEN0Z0','50','D','10','18',NULL,'Employee Checking Account Number',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETAXSCPEN0Z0','50','D','10','19',NULL,'Employee ABA Number',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETAXSCPEN0Z0','50','D','10','20',NULL,'“22” or “32” to indicate whether account is a chec',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETAXSCPEN0Z0','128','D','10','21',NULL,'Employee email address (work or home)',NULL,NULL,'"drvEmpEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETAXSCPEN0Z0','50','D','10','22',NULL,'Pay Cycle (W,B,S,M)',NULL,NULL,'"drvPayCycle"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETAXSCPEN_20211109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202111049','EMPEXPORT','OEACTIVE',NULL,'ETAXSCPEN',NULL,NULL,NULL,'202111049','Nov  4 2021 12:15PM','Nov  4 2021 12:15PM','202111041',NULL,'','','202111041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202111049','EMPEXPORT','OEPASSIVE',NULL,'ETAXSCPEN',NULL,NULL,NULL,'202111049','Nov  4 2021 12:15PM','Nov  4 2021 12:15PM','202111041',NULL,'','','202111041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSaver Com & Park Enrollment','202111049','EMPEXPORT','ONDEM_XOE',NULL,'ETAXSCPEN',NULL,NULL,NULL,'202111049','Nov  4 2021 12:15PM','Nov  4 2021 12:15PM','202111041',NULL,'','','202111041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSaver Com & Park Enro-Sched','202111049','EMPEXPORT','SCH_ETAXSC',NULL,'ETAXSCPEN',NULL,NULL,NULL,'202111049','Nov  4 2021 12:15PM','Nov  4 2021 12:15PM','202111041',NULL,'','','202111041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG',NULL,NULL,NULL,'TaxSaver Com & Park Enro-Test','202111049','EMPEXPORT','TEST_XOE','Nov  6 2021  2:34PM','ETAXSCPEN',NULL,NULL,NULL,'202111049','Nov  4 2021 12:00AM','Dec 30 1899 12:00AM','202110301','63','','','202110301',dbo.fn_GetTimedKey(),NULL,'us3dCoBER1011',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSCPEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSCPEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSCPEN','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSCPEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSCPEN','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSCPEN','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSCPEN','D10','dbo.U_ETAXSCPEN_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ETAXSCPEN
-----------

IF OBJECT_ID('U_dsi_BDM_ETAXSCPEN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETAXSCPEN] (
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
-- Create table U_ETAXSCPEN_DedList
-----------

IF OBJECT_ID('U_ETAXSCPEN_DedList') IS NULL
CREATE TABLE [dbo].[U_ETAXSCPEN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ETAXSCPEN_drvTbl
-----------

IF OBJECT_ID('U_ETAXSCPEN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETAXSCPEN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSSN] varchar(13) NOT NULL,
    [drvLastName] varchar(102) NOT NULL,
    [drvFirstName] varchar(102) NOT NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvDedParking] nvarchar(4000) NULL,
    [drvYTDParking] nvarchar(4000) NULL,
    [drvParkStartDate] datetime NULL,
    [drvParkEndDate] datetime NULL,
    [drvDedTransit] nvarchar(4000) NULL,
    [drvYTDTransit] nvarchar(4000) NULL,
    [drvTransitStartDate] datetime NULL,
    [drvTransitEndDate] datetime NULL,
    [drvAddrStreet] varchar(513) NOT NULL,
    [drvCity] varchar(257) NOT NULL,
    [drvAddrState] varchar(255) NULL,
    [drvAddrZip] varchar(50) NULL,
    [drvLocation] varchar(27) NOT NULL,
    [drvEmpEmail] varchar(52) NOT NULL,
    [drvPayCycle] char(1) NULL
);

-----------
-- Create table U_ETAXSCPEN_EEList
-----------

IF OBJECT_ID('U_ETAXSCPEN_EEList') IS NULL
CREATE TABLE [dbo].[U_ETAXSCPEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETAXSCPEN_File
-----------

IF OBJECT_ID('U_ETAXSCPEN_File') IS NULL
CREATE TABLE [dbo].[U_ETAXSCPEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ETAXSCPEN_PDedHist
-----------

IF OBJECT_ID('U_ETAXSCPEN_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETAXSCPEN_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurPARK] numeric NULL,
    [PdhERCurCOMCK] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEEYTDPARK] numeric NULL,
    [PdhEEYTDCOMCK] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSCPEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Berry Appleman

Created By: Darren Collard
Business Analyst: Lea King
Create Date: 11/04/2021
Service Request Number: TekP-2021-07-27-0003

Purpose: TaxSaver Commuter and Parking Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETAXSCPEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETAXSCPEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETAXSCPEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETAXSCPEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETAXSCPEN' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSCPEN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSCPEN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSCPEN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSCPEN', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSCPEN', 'SCH_ETAXSC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETAXSCPEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ETAXSCPEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETAXSCPEN';

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
    DELETE FROM dbo.U_ETAXSCPEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETAXSCPEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'PARK,COMCK';

    IF OBJECT_ID('U_ETAXSCPEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSCPEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETAXSCPEN_DedList
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
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETAXSCPEN_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSCPEN_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt      = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt      = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- Categorize Payroll Amounts
        ,PdhEECurPARK     = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode = 'PARK' THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurCOMCK    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND PdhDedCode = 'COMCK' THEN PdhEECurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD   = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD   = SUM(PdhERCurAmt)
        -- Categorize YTD Payroll Amounts
        ,PdhEEYTDPARK     = SUM(CASE WHEN PdhDedCode = 'PARK' THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEYTDCOMCK    = SUM(CASE WHEN PdhDedCode = 'COMCK' THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ETAXSCPEN_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETAXSCPEN_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETAXSCPEN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETAXSCPEN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSCPEN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvSSN               = CONCAT('"',RTRIM(EepSSN),'"')
        ,drvLastName          = CONCAT('"',EepNameLast,'"')
        ,drvFirstName         = CONCAT('"',EepNameFirst,'"')
        ,drvMiddleInitial     = LEFT(EepNameMiddle,1)
        ,drvDedParking        = FORMAT(BDMPARK.BdmEEAmt, '#0.00')
        ,drvYTDParking        = FORMAT((SELECT SUM(EedEEYTDAmt) FROM EmpDed WHERE EedEEID=xEEID AND EedDedCode = 'PARK'), '#0.00')
        ,drvParkStartDate     = BDMPARK.BdmBenStartDate
        ,drvParkEndDate       = BDMPARK.BdmBenStopDate
        ,drvDedTransit        = FORMAT(BDMCOMCK.BdmEEAmt, '#0.00')
        ,drvYTDTransit        = FORMAT((SELECT SUM(EedEEYTDAmt) FROM EmpDed WHERE EedEEID=xEEID AND EedDedCode = 'COMCK'), '#0.00')
        ,drvTransitStartDate  = BDMCOMCK.BdmBenStartDate
        ,drvTransitEndDate    = BDMCOMCK.BdmBenStopDate
        ,drvAddrStreet        = CONCAT('"',EepAddressLine1, RTRIM(' '+EepAddressLine2),'"')
        ,drvCity              = CONCAT('"',EepAddressCity,'"')
        ,drvAddrState         = EepAddressState
        ,drvAddrZip           = EepAddressZipCode
        ,drvLocation          = CONCAT('"',ISNULL(LocDesc,''),'"')
        ,drvEmpEmail          = CONCAT('"',RTRIM(COALESCE(NULLIF(eepAddressEMailAlternate,''),eepAddressEMail)),'"') --use work email if personal email is missing
        ,drvPayCycle          = PgrPayFrequency
    INTO dbo.U_ETAXSCPEN_drvTbl
    FROM dbo.U_ETAXSCPEN_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Paygroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    LEFT OUTER JOIN dbo.U_ETAXSCPEN_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    LEFT OUTER JOIN dbo.U_dsi_BDM_ETAXSCPEN AS BDMPARK WITH (NOLOCK)
        ON BDMPARK.BdmEEID = xEEID AND BDMPARK.BdmCoID = xCoID AND BDMPARK.BdmDedCode = 'PARK'
    LEFT OUTER JOIN dbo.U_dsi_BDM_ETAXSCPEN AS BDMCOMCK WITH (NOLOCK)
        ON BDMCOMCK.BdmEEID = xEEID AND BDMCOMCK.BdmCoID = xCoID AND BDMCOMCK.BdmDedCode = 'COMCK'
    WHERE (BDMPARK.BdmEEID IS NOT NULL OR BDMCOMCK.BdmEEID IS NOT NULL)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_APP_Commuter_Ded_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_APP_Commuter_Ded_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'APP_Commuter_Ded_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwETAXSCPEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETAXSCPEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETAXSCPEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110281'
       ,expStartPerControl     = '202110281'
       ,expLastEndPerControl   = '202111049'
       ,expEndPerControl       = '202111049'
WHERE expFormatCode = 'ETAXSCPEN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETAXSCPEN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETAXSCPEN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETAXSCPEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETAXSCPEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETAXSCPEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETAXSCPEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETAXSCPEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETAXSCPEN', 'UseFileName', 'V', 'Y'


-- End ripout