/**********************************************************************************

EIATCONFID: IAT Fidelity HSA Contributions

FormatCode:     EIATCONFID
Project:        IAT Fidelity HSA Contributions
Client ID:      IAT1000
Date/time:      2023-10-27 14:16:51.660
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB03
Database:       ULTIPRO_WPIATIG
Web Filename:   IAT1000_2BDI5_EEHISTORY_EIATCONFID_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIATCONFID_SavePath') IS NOT NULL DROP TABLE dbo.U_EIATCONFID_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIATCONFID'


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
WHERE FormatCode = 'EIATCONFID'
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
WHERE ExpFormatCode = 'EIATCONFID'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIATCONFID')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIATCONFID'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIATCONFID'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIATCONFID'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIATCONFID'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIATCONFID'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIATCONFID'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIATCONFID'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIATCONFID'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIATCONFID'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIATCONFID_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIATCONFID_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIATCONFID') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATCONFID];
GO
IF OBJECT_ID('U_EIATCONFID_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_PEarHist];
GO
IF OBJECT_ID('U_EIATCONFID_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_PDedHist];
GO
IF OBJECT_ID('U_EIATCONFID_File') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_File];
GO
IF OBJECT_ID('U_EIATCONFID_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_EEList];
GO
IF OBJECT_ID('U_EIATCONFID_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_drvTbl];
GO
IF OBJECT_ID('U_EIATCONFID_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_DedList];
GO
IF OBJECT_ID('U_EIATCONFID_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_AuditFields];
GO
IF OBJECT_ID('U_EIATCONFID_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIATCONFID_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIATCONFID') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIATCONFID];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EIATCONFID','IAT Fidelity HSA Contributions','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EIATCONFIDZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATCONFIDZ0','7','H','01','1',NULL,'TestFile',NULL,NULL,'"TESTEDT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATCONFIDZ0','73','H','01','8',NULL,'SpaceFill',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATCONFIDZ0','5','D','10','1',NULL,'PlanNum',NULL,NULL,'"drvPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATCONFIDZ0','4','D','10','6',NULL,'BatchGroupID',NULL,NULL,'"drvbatchGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATCONFIDZ0','3','D','10','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATCONFIDZ0','11','D','10','13',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATCONFIDZ0','1','D','10','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIATCONFIDZ0','5','D','10','25',NULL,'Reserved',NULL,NULL,'"drvReserved"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIATCONFIDZ0','2','D','10','30',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIATCONFIDZ0','4','D','10','32',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIATCONFIDZ0','3','D','10','36',NULL,'Transaction Code',NULL,NULL,'"drvtranCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIATCONFIDZ0','2','D','10','39',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIATCONFIDZ0','2','D','10','41',NULL,'SOURCE',NULL,NULL,'"drvSource"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIATCONFIDZ0','2','D','10','43',NULL,'ITEM NUMBER',NULL,NULL,'"drvItemNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIATCONFIDZ0','1','D','10','45',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIATCONFIDZ0','13','D','10','46',NULL,'AMOUNT',NULL,NULL,'"drvAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIATCONFIDZ0','4','D','10','59',NULL,'RESERVED (space-fill)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIATCONFIDZ0','4','D','10','63',NULL,'TAX YEAR',NULL,NULL,'"drvTaxYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIATCONFIDZ0','1','D','10','67',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIATCONFIDZ0','8','D','10','68',NULL,'CHECK DATE (HSA)',NULL,NULL,'"drvCheckDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIATCONFIDZ0','5','D','10','76',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIATCONFID_20231027.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IAT Fidelity HSA Contributions','202310139','EMPEXPORT','ONDEM_XOE',NULL,'EIATCONFID',NULL,NULL,NULL,'202310139','Oct 11 2023 12:10PM','Oct 11 2023 12:10PM','202309041',NULL,'','','202309041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IAT Fidelity HSA Contrib-Sched','202310139','EMPEXPORT','SCH_EIATCO',NULL,'EIATCONFID',NULL,NULL,NULL,'202310139','Oct 11 2023 12:10PM','Oct 11 2023 12:10PM','202309041',NULL,'','','202309041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'IAT Fidelity HSA Contrib-Test','202310199','EMPEXPORT','TEST_XOE',NULL,'EIATCONFID',NULL,NULL,NULL,'202310199','Oct 11 2023 12:10PM','Oct 11 2023 12:10PM','202310131',NULL,'','','202310131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATCONFID','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATCONFID','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATCONFID','D10','dbo.U_EIATCONFID_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIATCONFID
-----------

IF OBJECT_ID('U_dsi_BDM_EIATCONFID') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIATCONFID] (
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
-- Create table U_EIATCONFID_Audit
-----------

IF OBJECT_ID('U_EIATCONFID_Audit') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_Audit] (
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
-- Create table U_EIATCONFID_AuditFields
-----------

IF OBJECT_ID('U_EIATCONFID_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIATCONFID_DedList
-----------

IF OBJECT_ID('U_EIATCONFID_DedList') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIATCONFID_drvTbl
-----------

IF OBJECT_ID('U_EIATCONFID_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanNum] varchar(5) NOT NULL,
    [drvbatchGroupID] varchar(1) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvReserved] varchar(5) NOT NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvtranCode] varchar(3) NOT NULL,
    [drvSource] varchar(2) NULL,
    [drvItemNum] varchar(2) NOT NULL,
    [drvAmt] varchar(24) NULL,
    [drvTaxYear] int NULL,
    [drvCheckDate] varchar(30) NULL
);

-----------
-- Create table U_EIATCONFID_EEList
-----------

IF OBJECT_ID('U_EIATCONFID_EEList') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIATCONFID_File
-----------

IF OBJECT_ID('U_EIATCONFID_File') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EIATCONFID_PDedHist
-----------

IF OBJECT_ID('U_EIATCONFID_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [pdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhHSA] numeric NULL
);

-----------
-- Create table U_EIATCONFID_PEarHist
-----------

IF OBJECT_ID('U_EIATCONFID_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIATCONFID_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATCONFID]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IAT Insurance

Created By: Spencer Kerch
Business Analyst: Kim Ephraim
Create Date: 10/11/2023
Service Request Number: TekP-2023-09-19-02
Purpose: Fidelity HSA Contributions

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIATCONFID';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIATCONFID';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIATCONFID';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIATCONFID';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIATCONFID' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202310131'
       ,expStartPerControl     = '202310131'
       ,expLastEndPerControl   = '202310139'
       ,expEndPerControl       = '202310139'
WHERE expFormatCode = 'EIATCONFID' and expexportcode = 'TEST_XOE';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATCONFID', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATCONFID', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATCONFID', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATCONFID', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATCONFID', 'SCH_EIATCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIATCONFID';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIATCONFID', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIATCONFID';

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
    DELETE FROM dbo.U_EIATCONFID_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIATCONFID_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIATCONFID_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIATCONFID_AuditFields;
    CREATE TABLE dbo.U_EIATCONFID_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_EIATCONFID_AuditFields VALUES ('Empcomp','eecEmplStatus');
    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIATCONFID_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIATCONFID_Audit;
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
    INTO dbo.U_EIATCONFID_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIATCONFID_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIATCONFID_Audit ON dbo.U_EIATCONFID_Audit (audEEID,audKey2);

 --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSAI,HSA,HSAC,HSAF,HSAD,HSADC'; --ERHSA

    IF OBJECT_ID('U_EIATCONFID_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIATCONFID_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIATCONFID_DedList
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

    ---- Required OE parameters
    --IF @ExportCode LIKE '%PASSIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    --END;

    --IF @ExportCode LIKE '%ACTIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    --END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EIATCONFID_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIATCONFID_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,pdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhHSA     = SUM(CASE WHEN PdhDedCode IN ('HSAI','HSA','HSAC','HSAF','HSAD','HSADC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhERHSA     = SUM(CASE WHEN PdhDedCode IN ('ERHSA') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EIATCONFID_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIATCONFID_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EIATCONFID_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIATCONFID_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehEarnCode
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode IN ('ERHSA') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode IN ('ERHSA') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl AND PehEarnCode IN ('ERHSA') THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl AND PehEarnCode IN ('ERHSA') THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehEarnCode IN ('ERHSA') THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehEarnCode IN ('ERHSA') THEN PehCurHrs END)
    INTO dbo.U_EIATCONFID_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl >= @StartPerControl
	---LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    --AND PehEarnCode IN ('ERHSA')
    GROUP BY PehEEID, pehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIATCONFID_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIATCONFID_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATCONFID_drvTbl;


     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanNum = '0375P'
        ,drvbatchGroupID = ''
        ,drvSSN = stuff(stuff(eepSSN,6,0,'-'),4,0,'-')
        ,drvReserved = '00000'
        ,drvRecordID = '19'
        ,drvtranCode = '220'
        ,drvSource = CASE  WHEN BdmDedcode IN  ('HSAI','HSA','HSAC','HSAF','HSAD','HSADC') THEN  '01' 
                           WHEN PehEarnCode = 'ERHSA' THEN '03' END
        ,drvItemNum = '01'
        ,drvAmt =  dbo.dsi_fnPadZero( REPLACE(CASE  WHEN PehEarnCode = 'ERHSA' THEN CAST(PehCurAmt as varchar) 
                                                    WHEN BdmDedcode IN  ('HSAI','HSA','HSAC','HSAF','HSAD','HSADC') THEN CAST(PdhHSA as varchar)                                                 
                                         END,'.',''), 13, 0)
        ,drvTaxYear = year(prgpaydate)
        ,drvCheckDate = cast(format(PrgPayDate,'yyyyMMdd') as varchar)
    INTO dbo.U_EIATCONFID_drvTbl
    FROM dbo.U_EIATCONFID_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON eecEEID = xEEID
        and eecCOID = xCOID
    JOIN dbo.U_EIATCONFID_PDedHist WITH (NOLOCK)
        ON pdhEEID = XEEID
    LEFT JOIN dbo.U_EIATCONFID_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
     JOIN dbo.U_dsi_BDM_EIATCONFID WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EIATFIDENR_Audit with (nolock)
        ON audEEID = xeeid
        and audKey2 = xcoid
    Where EecEEType in ('REB','REF','REG','REH','CPB')
   AND  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (EecDateofTermination  BETWEEN  @StartDate AND @EndDate or audDateTime BETWEEN  @StartDate AND @EndDate )))
                and CASE WHEN PehEarnCode = 'ERHSA' then CAST(PehCurAmt as varchar) 
                         WHEN BdmDedcode IN  ('HSAI','HSA','HSAC','HSAF','HSAD','HSADC') THEN CAST(PdhHSA as varchar)                    
                         END IS not null



  --  SELECT DISTINCT
  --        drvEEID = xEEID
  --      ,drvCoID = xCoID
  --      ,drvInitialSort = eepSSN
  --      ,drvSubSort = ''
  --      -- standard fields above and additional driver fields below
  --      ,drvPlanNum = '0375P'
  --      ,drvbatchGroupID = ''
  --      ,drvSSN = stuff(stuff(eepSSN,6,0,'-'),4,0,'-')
  --      ,drvReserved = '00000'
  --      ,drvRecordID = '19'
  --      ,drvtranCode = '220'
  --      ,drvSource =  '01'
                    
  --      ,drvItemNum = '01'
  --      ,drvAmt =   dbo.dsi_fnPadZero( REPLACE(PdhSource1,'.',''), 13, 0)
                    
  --      ,drvTaxYear = year(prgpaydate)
  --      ,drvCheckDate = cast(format(PrgPayDate,'yyyyMMdd') as varchar)
  --  INTO dbo.U_EIATCONFID_drvTbl
  --  FROM dbo.U_EIATCONFID_EEList WITH (NOLOCK)
  --  JOIN dbo.EmpPers WITH (NOLOCK)
  --      ON EepEEID = xEEID
  -- Join dbo.EmpComp with(nolock)
  --      ON eecEEID = xEEID
        --and eecCOID = xCOID
  --  JOIN dbo.U_EIATCONFID_PDedHist with (nolock)
  --      ON pdhEEID = XEEID
  --  LEFT Join dbo.U_EIATCONFID_PEarHist with(nolock)
  --      ON pehEEID = xEEID
     --JOIN dbo.U_dsi_BDM_EIATCONFID WITH (NOLOCK)
  --      ON BdmEEID = xEEID 
  --      AND BdmCoID = xCoID

  --  left Join dbo.U_EIATFIDENR_Audit with (nolock)
  --      ON audEEID = xeeid
  --      and audKey2 = xcoid
  --  Where EecEEType in ('REB','REF','REG','REH','CPB')
  --      AND  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateofTermination  BETWEEN  @StartDate AND @EndDate))

        --Union

        --SELECT DISTINCT
  --        drvEEID = xEEID
  --      ,drvCoID = xCoID
  --      ,drvInitialSort = eepSSN
  --      ,drvSubSort = ''
  --      -- standard fields above and additional driver fields below
  --      ,drvPlanNum = '0375P'
  --      ,drvbatchGroupID = ''
  --      ,drvSSN = stuff(stuff(eepSSN,6,0,'-'),4,0,'-')
  --      ,drvReserved = '00000'
  --      ,drvRecordID = '19'
  --      ,drvtranCode = '220'
  --      ,drvSource = '03' 
                     
  --      ,drvItemNum = '01'
  --      ,drvAmt =  CASE  WHEN PehEarnCode = 'ERHSA' then dbo.dsi_fnPadZero( REPLACE(PehCurAmt ,'.',''), 13, 0)
  --                   end
  --      ,drvTaxYear = year(prgpaydate)
  --      ,drvCheckDate = cast(format(PrgPayDate,'yyyyMMdd') as varchar)
  -- -- INTO dbo.U_EIATCONFID_drvTbl
  --  FROM dbo.U_EIATCONFID_EEList WITH (NOLOCK)
  --  JOIN dbo.EmpPers WITH (NOLOCK)
  --      ON EepEEID = xEEID
  -- Join dbo.EmpComp with(nolock)
  --      ON eecEEID = xEEID
        --and eecCOID = xCOID
  --  --JOIN dbo.U_EIATCONFID_PDedHist with (nolock)
  --  --    ON pdhEEID = XEEID
  --  Join dbo.U_EIATCONFID_PEarHist with(nolock)
  --      ON pehEEID = xEEID
     --JOIN dbo.U_dsi_BDM_EIATCONFID WITH (NOLOCK)
  --      ON BdmEEID = xEEID 
  --      AND BdmCoID = xCoID

  --  left Join dbo.U_EIATFIDENR_Audit with (nolock)
  --      ON audEEID = xeeid
  --      and audKey2 = xcoid
  --  Where EecEEType in ('REB','REF','REG','REH','CPB')
  --      AND  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateofTermination  BETWEEN  @StartDate AND @EndDate))
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
ALTER VIEW dbo.dsi_vwEIATCONFID_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIATCONFID_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIATCONFID%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202310131'
       ,expStartPerControl     = '202310131'
       ,expLastEndPerControl   = '202310199'
       ,expEndPerControl       = '202310199'
WHERE expFormatCode = 'EIATCONFID' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIATCONFID_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIATCONFID_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIATCONFID' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIATCONFID'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIATCONFID'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATCONFID', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIATCONFID', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATCONFID', 'UseFileName', 'V', 'Y'


-- End ripout