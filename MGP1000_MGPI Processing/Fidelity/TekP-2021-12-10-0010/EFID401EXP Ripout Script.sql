/**********************************************************************************

EFID401EXP: Fidelity 401k Contribution Export

FormatCode:     EFID401EXP
Project:        Fidelity 401k Contribution Export
Client ID:      MGP1000
Date/time:      2022-05-09 10:35:16.377
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPMGPI
Web Filename:   MGP1000_BLF99_EEHISTORY_EFID401EXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFID401EXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EFID401EXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFID401EXP'


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
WHERE FormatCode = 'EFID401EXP'
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
WHERE ExpFormatCode = 'EFID401EXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFID401EXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFID401EXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFID401EXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFID401EXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFID401EXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFID401EXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFID401EXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFID401EXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFID401EXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFID401EXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFID401EXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFID401EXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFID401EXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFID401EXP];
GO
IF OBJECT_ID('U_EFID401EXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFID401EXP_PDedHist];
GO
IF OBJECT_ID('U_EFID401EXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EFID401EXP_Header];
GO
IF OBJECT_ID('U_EFID401EXP_File') IS NOT NULL DROP TABLE [dbo].[U_EFID401EXP_File];
GO
IF OBJECT_ID('U_EFID401EXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFID401EXP_EEList];
GO
IF OBJECT_ID('U_EFID401EXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFID401EXP_drvTbl];
GO
IF OBJECT_ID('U_EFID401EXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFID401EXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFID401EXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFID401EXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFID401EXP','Fidelity 401k Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','80','S','N','EFID401EXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFID401EXPZ0','7','H','01','1',NULL,'Test File Identifier',NULL,NULL,'"drvTestFileIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFID401EXPZ0','73','H','01','8',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFID401EXPZ0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFID401EXPZ0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFID401EXPZ0','3','D','10','10',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFID401EXPZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFID401EXPZ0','1','D','10','24',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFID401EXPZ0','5','D','10','25',NULL,'RESERVED',NULL,NULL,'"00000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFID401EXPZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"19"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFID401EXPZ0','4','D','10','32',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFID401EXPZ0','3','D','10','36',NULL,'TRANSACTION CODE',NULL,NULL,'"220"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFID401EXPZ0','2','D','10','39',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFID401EXPZ0','2','D','10','41',NULL,'SOURCE',NULL,NULL,'"drvSource"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFID401EXPZ0','2','D','10','43',NULL,'ITEM NUMBER',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFID401EXPZ0','1','D','10','45',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFID401EXPZ0','13','D','10','46',NULL,'AMOUNT – see previous tab of code needed for last',NULL,NULL,'"drvAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFID401EXPZ0','4','D','10','59',NULL,'RESERVED (space-fill)',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFID401EXPZ0','4','D','10','63',NULL,'FISCAL YEAR (Current year)',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFID401EXPZ0','1','D','10','67',NULL,'CORRECTION METHOD',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFID401EXPZ0','8','D','10','68',NULL,'POSTING DATE (HSA)',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFID401EXPZ0','5','D','10','76',NULL,'RESERVED',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFID401EXP_20220509.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202204089','EMPEXPORT','OEACTIVE',NULL,'EFID401EXP',NULL,NULL,NULL,'202204089','Apr  8 2022 10:50AM','Apr  8 2022 10:50AM','202204011',NULL,'','','202204011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202204089','EMPEXPORT','OEPASSIVE',NULL,'EFID401EXP',NULL,NULL,NULL,'202204089','Apr  8 2022 10:50AM','Apr  8 2022 10:50AM','202204011',NULL,'','','202204011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fidelity 401k Contribution Exp','202204089','EMPEXPORT','ONDEM_XOE',NULL,'EFID401EXP',NULL,NULL,NULL,'202204089','Apr  8 2022 10:50AM','Apr  8 2022 10:50AM','202204011',NULL,'','','202204011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fidelity 401k Contributi-Sched','202204089','EMPEXPORT','SCH_EFID40',NULL,'EFID401EXP',NULL,NULL,NULL,'202204089','Apr  8 2022 10:50AM','Apr  8 2022 10:50AM','202204011',NULL,'','','202204011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Fidelity 401k Contributi-Test','202204229','EMPEXPORT','TEST_XOE','May  2 2022  8:45PM','EFID401EXP',NULL,NULL,NULL,'202204229','Apr 22 2022 12:00AM','Dec 30 1899 12:00AM','202204221','69','eecPayGroup','LXUNI','202204221',dbo.fn_GetTimedKey(),NULL,'us3cPeMGP1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401EXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401EXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401EXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401EXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401EXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFID401EXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFID401EXP','H01','dbo.U_EFID401EXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFID401EXP','D10','dbo.U_EFID401EXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFID401EXP
-----------

IF OBJECT_ID('U_dsi_BDM_EFID401EXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFID401EXP] (
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
-- Create table U_EFID401EXP_DedList
-----------

IF OBJECT_ID('U_EFID401EXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EFID401EXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFID401EXP_drvTbl
-----------

IF OBJECT_ID('U_EFID401EXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFID401EXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvPlanNumber] varchar(5) NOT NULL,
    [drvSSN] varchar(11) NULL,
    [drvSource] varchar(2) NOT NULL,
    [drvAmount] varchar(13) NULL
);

-----------
-- Create table U_EFID401EXP_EEList
-----------

IF OBJECT_ID('U_EFID401EXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EFID401EXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFID401EXP_File
-----------

IF OBJECT_ID('U_EFID401EXP_File') IS NULL
CREATE TABLE [dbo].[U_EFID401EXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);

-----------
-- Create table U_EFID401EXP_Header
-----------

IF OBJECT_ID('U_EFID401EXP_Header') IS NULL
CREATE TABLE [dbo].[U_EFID401EXP_Header] (
    [drvTestFileIdentifier] varchar(7) NOT NULL
);

-----------
-- Create table U_EFID401EXP_PDedHist
-----------

IF OBJECT_ID('U_EFID401EXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFID401EXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhC_ROTH_X] money NULL,
    [PdhMX] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFID401EXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MGPI Processing Inc.

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 04/08/2022
Service Request Number: TekP-2021-12-10-0010

Purpose: Fidelity 401k Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFID401EXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFID401EXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFID401EXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFID401EXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFID401EXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401EXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401EXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401EXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401EXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFID401EXP', 'SCH_EFID40';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFID401EXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFID401EXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFID401EXP';

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
    DELETE FROM dbo.U_EFID401EXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFID401EXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CX,ROTHX,401MX';
    
    IF OBJECT_ID('U_EFID401EXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401EXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFID401EXP_DedList
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
    IF OBJECT_ID('U_EFID401EXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401EXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhC_ROTH_X     = SUM(CASE WHEN PdhDedCode IN ('401CX','ROTHX') THEN PdhEECurAmt*100 ELSE 0 END)
        ,PdhMX     = SUM(CASE WHEN PdhDedCode IN ('401MX') THEN PdhERCurAmt*100 ELSE 0 END)
    INTO dbo.U_EFID401EXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFID401EXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFID401EXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFID401EXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401EXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '51457'
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(REPLACE(eepSSN, ' ', ''), 5), 2) + '-' + RIGHT(REPLACE(eepSSN, ' ', ''),4) 
        ,drvSource =    CASE WHEN BdmDedCode = '401CX' THEN '01'
                        WHEN BdmDedCode = 'ROTHX' THEN '02'
                        WHEN BdmDedCode = '401MX' THEN '03'
                        ELSE '99'
                        END
        ,drvAmount = RIGHT('00000000000000000000000' + 
                        CASE WHEN BdmDedCode IN ('401CX','ROTHX') THEN 
                            LEFT(PdhC_ROTH_X, LEN(FORMAT(PdhC_ROTH_X, '#0'))-1) + CASE WHEN PdhC_ROTH_X > 0 THEN                                
                                                                                        CASE RIGHT(FORMAT(PdhC_ROTH_X, '#0'), 1) 
                                                                                            WHEN '1' THEN 'A'
                                                                                            WHEN '2' THEN 'B'
                                                                                            WHEN '3' THEN 'C'
                                                                                            WHEN '4' THEN 'D'
                                                                                            WHEN '5' THEN 'E'
                                                                                            WHEN '6' THEN 'F'
                                                                                            WHEN '7' THEN 'G'
                                                                                            WHEN '8' THEN 'H'
                                                                                            WHEN '9' THEN 'I'
                                                                                            WHEN '0' THEN '{'
                                                                                        END
                                                                                    ELSE
                                                                                        CASE RIGHT(FORMAT(PdhC_ROTH_X, '#0'), 1) 
                                                                                            WHEN '1' THEN 'J'
                                                                                            WHEN '2' THEN 'K'
                                                                                            WHEN '3' THEN 'L'
                                                                                            WHEN '4' THEN 'M'
                                                                                            WHEN '5' THEN 'N'
                                                                                            WHEN '6' THEN 'O'
                                                                                            WHEN '7' THEN 'P'
                                                                                            WHEN '8' THEN 'Q'
                                                                                            WHEN '9' THEN 'R'
                                                                                            WHEN '0' THEN '{'
                                                                                        END
                                                                                    END
                        WHEN BdmDedCode IN ('401MX') THEN --FORMAT(PdhMX, '#.00')
                            LEFT(PdhMX, LEN(FORMAT(PdhMX, '#0'))-1) + CASE WHEN PdhMX > 0 THEN                                
                                                                                        CASE RIGHT(FORMAT(PdhMX, '#0'), 1) 
                                                                                            WHEN '1' THEN 'A'
                                                                                            WHEN '2' THEN 'B'
                                                                                            WHEN '3' THEN 'C'
                                                                                            WHEN '4' THEN 'D'
                                                                                            WHEN '5' THEN 'E'
                                                                                            WHEN '6' THEN 'F'
                                                                                            WHEN '7' THEN 'G'
                                                                                            WHEN '8' THEN 'H'
                                                                                            WHEN '9' THEN 'I'
                                                                                            WHEN '0' THEN '{'
                                                                                        END
                                                                                    ELSE
                                                                                        CASE RIGHT(FORMAT(PdhMX, '#0'), 1) 
                                                                                            WHEN '1' THEN 'J'
                                                                                            WHEN '2' THEN 'K'
                                                                                            WHEN '3' THEN 'L'
                                                                                            WHEN '4' THEN 'M'
                                                                                            WHEN '5' THEN 'N'
                                                                                            WHEN '6' THEN 'O'
                                                                                            WHEN '7' THEN 'P'
                                                                                            WHEN '8' THEN 'Q'
                                                                                            WHEN '9' THEN 'R'
                                                                                            WHEN '0' THEN '{'
                                                                                        END
                                                                                    END
                        END, 13)
    INTO dbo.U_EFID401EXP_drvTbl
    FROM dbo.U_EFID401EXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFID401EXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EFID401EXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EFID401EXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EFID401EXP_Header;
    SELECT DISTINCT
         drvTestFileIdentifier = 'TESTEDT'
    INTO dbo.U_EFID401EXP_Header
    ;

    IF @EXPORTCODE NOT LIKE '%TEST%' 
    BEGIN
        DELETE dbo.U_EFID401EXP_Header
    END;

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
ALTER VIEW dbo.dsi_vwEFID401EXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFID401EXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFID401EXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204011'
       ,expStartPerControl     = '202204011'
       ,expLastEndPerControl   = '202204089'
       ,expEndPerControl       = '202204089'
WHERE expFormatCode = 'EFID401EXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFID401EXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFID401EXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFID401EXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFID401EXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFID401EXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFID401EXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFID401EXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFID401EXP', 'UseFileName', 'V', 'Y'


-- End ripout