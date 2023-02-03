/**********************************************************************************

EREFJHYTDC: John Hancock YTD Comp

FormatCode:     EREFJHYTDC
Project:        John Hancock YTD Comp
Client ID:      REF1001
Date/time:      2023-02-03 13:48:38.580
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
Web Filename:   REF1001_XAC7C_EEHISTORY_EREFJHYTDC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EREFJHYTDC_SavePath') IS NOT NULL DROP TABLE dbo.U_EREFJHYTDC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EREFJHYTDC'


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
WHERE FormatCode = 'EREFJHYTDC'
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
WHERE ExpFormatCode = 'EREFJHYTDC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EREFJHYTDC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EREFJHYTDC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EREFJHYTDC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EREFJHYTDC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EREFJHYTDC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EREFJHYTDC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EREFJHYTDC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EREFJHYTDC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EREFJHYTDC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EREFJHYTDC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEREFJHYTDC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREFJHYTDC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREFJHYTDC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFJHYTDC];
GO
IF OBJECT_ID('U_EREFJHYTDC_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_PTaxHist];
GO
IF OBJECT_ID('U_EREFJHYTDC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_PEarHist];
GO
IF OBJECT_ID('U_EREFJHYTDC_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_PDedHist];
GO
IF OBJECT_ID('U_EREFJHYTDC_File') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_File];
GO
IF OBJECT_ID('U_EREFJHYTDC_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_EEList];
GO
IF OBJECT_ID('U_EREFJHYTDC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_drvTbl];
GO
IF OBJECT_ID('U_EREFJHYTDC_DedList') IS NOT NULL DROP TABLE [dbo].[U_EREFJHYTDC_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EREFJHYTDC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EREFJHYTDC];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREFJHYTDC','John Hancock YTD Comp','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EREFJHYTDCZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFJHYTDCZ0','50','H','01','1',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFJHYTDCZ0','50','H','01','2',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFJHYTDCZ0','50','H','01','3',NULL,'Gross Comp',NULL,NULL,'"Gross Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFJHYTDCZ0','50','H','01','4',NULL,'Plan Comp',NULL,NULL,'"Plan Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFJHYTDCZ0','50','H','01','5',NULL,'Eligible Plan Comp',NULL,NULL,'"Eligible Plan Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFJHYTDCZ0','50','H','01','6',NULL,'Match Eligible Plan Comp',NULL,NULL,'"Match Eligible Plan Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFJHYTDCZ0','50','H','01','7',NULL,'Union Code',NULL,NULL,'"Union Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFJHYTDCZ0','50','H','01','8',NULL,'Union Name',NULL,NULL,'"Union Name"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFJHYTDCZ0','50','D','10','1',NULL,'SSN',NULL,NULL,'"dvrSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFJHYTDCZ0','50','D','10','2',NULL,'Employee Name',NULL,NULL,'"dvrEmployeeName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFJHYTDCZ0','50','D','10','3',NULL,'Gross Comp',NULL,NULL,'"dvrGrossComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFJHYTDCZ0','50','D','10','4',NULL,'Plan Comp',NULL,NULL,'"dvrPlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFJHYTDCZ0','50','D','10','5',NULL,'Eligible Plan Comp',NULL,NULL,'"drvEligiblePlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFJHYTDCZ0','50','D','10','6',NULL,'Match Eligible Plan Comp',NULL,NULL,'"dvrMatchEligiblePlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFJHYTDCZ0','50','D','10','7',NULL,'Union Code',NULL,NULL,'"drvUnionCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFJHYTDCZ0','50','D','10','8',NULL,'Union Name',NULL,NULL,'"drvUnionName"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EREFJHYTDC_20230203.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'John Hancock YTD Comp','202112319','EMPEXPORT','ONDEM_XOE',NULL,'EREFJHYTDC',NULL,NULL,NULL,'202112319','Apr 22 2022  1:51PM','Apr 22 2022  1:51PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'John Hancock YTD Comp-Sched','202112319','EMPEXPORT','SCH_EREFJH',NULL,'EREFJHYTDC',NULL,NULL,NULL,'202112319','Apr 22 2022  1:51PM','Apr 22 2022  1:51PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'John Hancock YTD Comp-Test','202212319','EMPEXPORT','TEST_XOE','Feb  3 2023 12:23PM','EREFJHYTDC',NULL,NULL,NULL,'202212319','Dec 31 2022 12:00AM','Dec 30 1899 12:00AM','202201011','6525','','','202201011',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFJHYTDC','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFJHYTDC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFJHYTDC','D10','dbo.U_EREFJHYTDC_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EREFJHYTDC
-----------

IF OBJECT_ID('U_dsi_BDM_EREFJHYTDC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EREFJHYTDC] (
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
-- Create table U_EREFJHYTDC_DedList
-----------

IF OBJECT_ID('U_EREFJHYTDC_DedList') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EREFJHYTDC_drvTbl
-----------

IF OBJECT_ID('U_EREFJHYTDC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(1) NOT NULL,
    [dvrSSN] char(11) NULL,
    [dvrEmployeeName] varchar(202) NOT NULL,
    [dvrGrossComp] nvarchar(4000) NULL,
    [dvrPlanComp] nvarchar(4000) NULL,
    [drvEligiblePlanComp] nvarchar(4000) NULL,
    [dvrMatchEligiblePlanComp] nvarchar(4000) NOT NULL,
    [drvUnionCode] char(12) NULL,
    [drvUnionName] char(15) NULL
);

-----------
-- Create table U_EREFJHYTDC_EEList
-----------

IF OBJECT_ID('U_EREFJHYTDC_EEList') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EREFJHYTDC_File
-----------

IF OBJECT_ID('U_EREFJHYTDC_File') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EREFJHYTDC_PDedHist
-----------

IF OBJECT_ID('U_EREFJHYTDC_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401K] numeric NULL,
    [PdhROTH] numeric NULL,
    [Pdh401KM] numeric NULL,
    [PdhROTH1] numeric NULL,
    [Pdh401SB] numeric NULL,
    [Pdh401KL1] numeric NULL
);

-----------
-- Create table U_EREFJHYTDC_PEarHist
-----------

IF OBJECT_ID('U_EREFJHYTDC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmt] money NULL,
    [PehCurAmtYTD] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehPlanComp] money NOT NULL,
    [PehMatchPlanComp] money NOT NULL
);

-----------
-- Create table U_EREFJHYTDC_PTaxHist
-----------

IF OBJECT_ID('U_EREFJHYTDC_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EREFJHYTDC_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthCOID] char(5) NOT NULL,
    [PthCurTaxableWages] money NULL,
    [PthFederalWithholding] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFJHYTDC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 04/22/2022
Service Request Number: TekP-2022-02-08-02

Purpose: John Hancock YTD Comp

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREFJHYTDC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREFJHYTDC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREFJHYTDC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREFJHYTDC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREFJHYTDC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFJHYTDC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFJHYTDC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFJHYTDC', 'SCH_EREFJH';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREFJHYTDC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREFJHYTDC';

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
    DELETE FROM dbo.U_EREFJHYTDC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREFJHYTDC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     ----==========================================
  --  -- Create Deduction List
  --  --==========================================
  --  DECLARE @DedList VARCHAR(MAX)
  --  SET @DedList = '401K,401K1,ROTH,ROTH1,401KM,401SB';

  --  IF OBJECT_ID('U_EREFJHYTDC_DedList','U') IS NOT NULL
  --      DROP TABLE dbo.U_EREFJHYTDC_DedList;
  --  SELECT DISTINCT
  --       DedCode = DedDedCode
  --      ,DedType = DedDedType
  --  INTO dbo.U_EREFJHYTDC_DedList
  --  FROM dbo.fn_ListToTable(@DedList)
  --  JOIN dbo.DedCode WITH (NOLOCK)
  --      ON DedDedCode = Item;

        --  --==========================================
  --  -- BDM Section
  --  --==========================================
  --  DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

  --  -- Required parameters
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

   
  --  -- Non-Required parameters
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, DP');
  --  INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','DIS, CHL, DPC, STC');
  --  -- Run BDM Module
  --  EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


  --  -- Required OE parameters
  --  IF @ExportCode LIKE '%PASSIVE'
  --  BEGIN
  --      INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
  --  END;

  --  IF @ExportCode LIKE '%ACTIVE'
  --  BEGIN
  --      INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
  --  END;


  --  -- Run BDM Module
  --  EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

   
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EREFJHYTDC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREFJHYTDC_PEarHist;


        SELECT DISTINCT
         PehEEID
      
        -- Current Payroll Amount
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt END)
        -- YTD Payroll Amount
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        -- Current Include Deferred Comp Amount
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        -- YTD Include Deferred Comp Amount
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        
        ,PehPlanComp  = Isnull(SUM(CASE WHEN (EecUnionLocal IN ('682', '688') and PehInclInDefComp = 'Y') and Left(PehPerControl, 8)  >= Convert(CHAR(8),DATEADD(s,+1,DATEADD(mm, DATEDIFF(m,0,EecDateoforiginalHire +90)+1,0)),112) THEN Pehcuramt 
                                                                    
                         ELSE CASE WHEN (EecUnionLocal NOT IN ('682', '688') and PehInclInDefComp = 'Y') and Left(PehPerControl, 8)  >= Convert(CHAR(8),EecDateoforiginalHire ,112) THEN Pehcuramt END
                            END),0.00)

        ,PehMatchPlanComp =  Isnull(SUM(Case WHEN (EecUnionLocal NOT IN ('TRU688', '688', '525U05','NON525') and Eeddedcode IN ('401KM', '401SB') and PehInclInDefComp = 'Y') AND Left(PehPerControl, 8) >= eedbenstartdate THEN PehCurAmt 
                                END),0.00)
        --,PehMatchPlanComp =  Isnull(SUM(Case WHEN (EecUnionLocal NOT IN ( 'TRU688', '688', '525U05','NON525' ) and Eeddedcode IN ('401KM', '401SB') and  PehInclInDefComp = 'Y') AND  Left(PehPerControl, 8) > = Convert(CHAR(8),EecDateoforiginalHire,112)   THEN PehCurAmt 
                                          
        --                            END),0.00)

        INTO dbo.U_EREFJHYTDC_PEarHist
        FROM dbo.PEarHist WITH (NOLOCK)                
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEid  = peheeid 
           AND EecCOID = pehCOID
        Left Join dbo.Empded WITH (NOLOCK)
            ON Eedeeid = peheeid
            and eedcoid = PehCoid
            AND Eeddedcode IN ('401KM', '401SB')
        WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
              AND PehPerControl <= @EndPerControl 
              AND PehPerControl between @StartPerControl and @EndPerControl
            -- and peheeid IN ( 'CDN9QJ0000K0')
             -- AND  peheeid IN ( 'CDNA5X00W0K0', 'CDN9Y101Z0K0','CDN9WY00U0K0')
        GROUP BY peheeid
        HAVING SUM(PehCurAmt) <> 0.00
    ;
    

     -----------------------------
    -- Working Table - PTaxHist
    -----------------------------


   --IF OBJECT_ID('U_EREFJHYTDC_PTaxHist','U') IS NOT NULL
   --     DROP TABLE dbo.U_EREFJHYTDC_PTaxHist;
   -- SELECT DISTINCT
   --      PthEEID
   --     ,PthCOID
   --     ,PthCurTaxableWages          = SUM(PthCurTaxableWages)
   --     ,PthFederalWithholding       = SUM(CASE WHEN PthTaxCode = 'USFIT' THEN PthCurDefComp + PthCurSec125 + PthCurD125 ELSE 0.00 END)
   -- INTO dbo.U_EREFJHYTDC_PTaxHist
   -- FROM dbo.PTaxHist WITH (NOLOCK)
   -- WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
   --     AND PthPerControl <= @EndPerControl
   --     --PthPerControl BETWEEN @StartPerControl AND @EndPerControl
   -- GROUP BY PthEEID, PthCOID



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREFJHYTDC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFJHYTDC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFJHYTDC_drvTbl;
    SELECT DISTINCT
         drvEEID                    = xEEID
        ,drvCoID                    = xCoID
        --,drvDepRecID                = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,dvrSSN                        = eepSSN
        ,dvrEmployeeName            = CONCAT(Eepnamelast, ',' , '' , eepnamefirst)
        ,dvrGrossComp                = FORMAT(ISNULL(PehCurAmtYTD ,'0.00'),'0.00')
        ,dvrPlanComp                = FORMAT(ISNULL(round(PehInclInDefCompYTD , 2),'0.00'), '0.00')
        ,drvEligiblePlanComp        = FORMAT(ISNULL(Round(PehPlanComp, 2),'0.00'), '0.00')
        ,dvrMatchEligiblePlanComp    = ISNULL(FORMAT(CASE WHEN EecUnionLocal NOT IN ('TRU688', '688', '525U05', 'NON525') THEN PehMatchPlanComp END, '0.00'), '0.00')
        ,drvUnionCode                = CASE WHEN EecUnionLocal <> 'N' THEN EecUnionLocal END
        ,drvUnionName                    = CASE WHEN unishortdesc <> 'No' THEN unishortdesc END
    INTO dbo.U_EREFJHYTDC_drvTbl
    FROM dbo.U_EREFJHYTDC_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp 
        ON EecEEid  = xEEID 
        AND EecCOID = xCOID 
    --JOIn dbo.U_dsi_BDM_EREFJHYTDC WITH (NOLOCK)
    --    ON BdmEEID = xEEID
    --    AND BdmCOID = xCOID 
    --LEFT JOIN dbo.U_EREFJHYTDC_PTaxHist WITH (NOLOCK)
    --    On PthEeid =  xeeid
    LEFT JOIN dbo.U_EREFJHYTDC_PEarHist WITH (NOLOCK)
        On Peheeid =  xeeid
        LEFT JOIN dbo.LabUnion 
        ON unicode = EecUnionLocal
    where  EecUnionLocal NOT In ('830','PAW22000') 
    and (EecEmplstatus <> 'T' or (EecEmplstatus = 'T' and eecDateofTermination between @Startdate and @Enddate and (PehCurAmtYTD  <> 0.00  or PehInclInDefCompYTD  <> 0.00  or PehPlanComp <> 0.00  or PehMatchPlanComp <> 0.00 )))

        
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
ALTER VIEW dbo.dsi_vwEREFJHYTDC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREFJHYTDC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREFJHYTDC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201011'
       ,expStartPerControl     = '202201011'
       ,expLastEndPerControl   = '202212319'
       ,expEndPerControl       = '202212319'
WHERE expFormatCode = 'EREFJHYTDC' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEREFJHYTDC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EREFJHYTDC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EREFJHYTDC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EREFJHYTDC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EREFJHYTDC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFJHYTDC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EREFJHYTDC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFJHYTDC', 'UseFileName', 'V', 'Y'


-- End ripout