/**********************************************************************************

EIATFIDENR: Fidelity HSA Enrollment

FormatCode:     EIATFIDENR
Project:        Fidelity HSA Enrollment
Client ID:      IAT1000
Date/time:      2023-12-18 11:16:36.150
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB03
Database:       ULTIPRO_WPIATIG
Web Filename:   IAT1000_2BDI5_EEHISTORY_EIATFIDENR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIATFIDENR_SavePath') IS NOT NULL DROP TABLE dbo.U_EIATFIDENR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIATFIDENR'


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
WHERE FormatCode = 'EIATFIDENR'
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
WHERE ExpFormatCode = 'EIATFIDENR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIATFIDENR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIATFIDENR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIATFIDENR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIATFIDENR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIATFIDENR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIATFIDENR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIATFIDENR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIATFIDENR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIATFIDENR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIATFIDENR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIATFIDENR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIATFIDENR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIATFIDENR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATFIDENR];
GO
IF OBJECT_ID('U_EIATFIDENR_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_PDedHist];
GO
IF OBJECT_ID('U_EIATFIDENR_Header') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_Header];
GO
IF OBJECT_ID('U_EIATFIDENR_File') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_File];
GO
IF OBJECT_ID('U_EIATFIDENR_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_EEList];
GO
IF OBJECT_ID('U_EIATFIDENR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_drvTbl];
GO
IF OBJECT_ID('U_EIATFIDENR_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_DedList];
GO
IF OBJECT_ID('U_EIATFIDENR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_AuditFields];
GO
IF OBJECT_ID('U_EIATFIDENR_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIATFIDENR_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIATFIDENR') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIATFIDENR];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EIATFIDENR','Fidelity HSA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EIATFIDENRZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATFIDENRZ0','7','H','01','1',NULL,'Test File Indicator',NULL,NULL,'"drvTestFileIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATFIDENRZ0','73','H','01','8',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATFIDENRZ0','5','D','10','1',NULL,'HSA_PLAN_NUM',NULL,NULL,'"drvHsaPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATFIDENRZ0','4','D','10','6',NULL,'Batch_Group_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATFIDENRZ0','3','D','10','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATFIDENRZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"DrvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATFIDENRZ0','1','D','10','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIATFIDENRZ0','5','D','10','25',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIATFIDENRZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"DrvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIATFIDENRZ0','4','D','10','32',NULL,'PLAN YEAR',NULL,NULL,'"drvPlanYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIATFIDENRZ0','2','D','10','36',NULL,'COVERAGE TIER',NULL,NULL,'"drvCoverageTier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIATFIDENRZ0','5','D','10','38',NULL,'HDHP ID',NULL,NULL,'"drvHDHPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIATFIDENRZ0','8','D','10','43',NULL,'ENROLLMENT EFFECTIVE DATE',NULL,NULL,'"drvEnrollEffDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIATFIDENRZ0','1','D','10','51',NULL,'ENROLLMENT STATUS',NULL,NULL,'"drvEnrollStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIATFIDENRZ0','1','D','10','52',NULL,'CLIENT BILLING FLAG',NULL,NULL,'"drvClientBillFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIATFIDENRZ0','1','D','10','53',NULL,'SIMPLE ACKNOWLEDGEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIATFIDENRZ0','8','D','10','54',NULL,'SIMPLE ACKNOWLEDGEMENT DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIATFIDENRZ0','19','D','10','62',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIATFIDENR_20231218.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'IAT Fidelity HSA OE Active','202312129','EMPEXPORT','OEACTIVE',NULL,'EIATFIDENR',NULL,NULL,NULL,'202312129','Oct 10 2023  4:54PM','Oct 10 2023  4:54PM','202311281',NULL,'','','202311281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'IAT Fidelity HSA OE Passive','202312129','EMPEXPORT','OEPASSIVE',NULL,'EIATFIDENR',NULL,NULL,NULL,'202312129','Oct 10 2023  4:54PM','Oct 10 2023  4:54PM','202311281',NULL,'','','202311281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fidelity HSA Enrollment','202312129','EMPEXPORT','ONDEM_XOE',NULL,'EIATFIDENR',NULL,NULL,NULL,'202312129','Oct 10 2023  4:54PM','Oct 10 2023  4:54PM','202311281',NULL,'','','202311281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','FENUE,GDP4G,FEO5X',NULL,NULL,NULL,'Fidelity HSA Enroll - Fri 8am','202312129','EMPEXPORT','SCH_EIATFI',NULL,'EIATFIDENR',NULL,NULL,NULL,'202312159','Oct 10 2023  4:54PM','Oct 10 2023  4:54PM','202312081',NULL,'','','202311281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'IAT Fidelity HSA Enrollm-Test','202312129','EMPEXPORT','TEST_XOE',NULL,'EIATFIDENR',NULL,NULL,NULL,'202312129','Oct 10 2023  4:54PM','Oct 10 2023  4:54PM','202311281',NULL,'','','202311281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATFIDENR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATFIDENR','H01','dbo.U_EIATFIDENR_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATFIDENR','D10','dbo.U_EIATFIDENR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIATFIDENR
-----------

IF OBJECT_ID('U_dsi_BDM_EIATFIDENR') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIATFIDENR] (
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
-- Create table U_EIATFIDENR_Audit
-----------

IF OBJECT_ID('U_EIATFIDENR_Audit') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audTermintation] varchar(1) NOT NULL,
    [audBenefitDate] varchar(1) NOT NULL
);

-----------
-- Create table U_EIATFIDENR_AuditFields
-----------

IF OBJECT_ID('U_EIATFIDENR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIATFIDENR_DedList
-----------

IF OBJECT_ID('U_EIATFIDENR_DedList') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIATFIDENR_drvTbl
-----------

IF OBJECT_ID('U_EIATFIDENR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvHsaPlanNum] varchar(5) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvPlanYear] varchar(30) NULL,
    [drvCoverageTier] varchar(2) NULL,
    [drvHDHPID] varchar(5) NOT NULL,
    [drvEnrollEffDate] datetime NULL,
    [drvEnrollStatus] varchar(1) NULL,
    [drvClientBillFlag] varchar(1) NOT NULL
);

-----------
-- Create table U_EIATFIDENR_EEList
-----------

IF OBJECT_ID('U_EIATFIDENR_EEList') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIATFIDENR_File
-----------

IF OBJECT_ID('U_EIATFIDENR_File') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EIATFIDENR_Header
-----------

IF OBJECT_ID('U_EIATFIDENR_Header') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_Header] (
    [drvTestFileIndicator] varchar(7) NULL
);

-----------
-- Create table U_EIATFIDENR_PDedHist
-----------

IF OBJECT_ID('U_EIATFIDENR_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIATFIDENR_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATFIDENR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IAT Insurance

Created By: Spencer Kerch
Business Analyst: Kim Ephraim
Create Date: 10/10/2023
Service Request Number: TekP-2023-09-12-01

Purpose: Fidelity HSA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIATFIDENR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIATFIDENR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIATFIDENR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIATFIDENR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIATFIDENR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATFIDENR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATFIDENR', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATFIDENR', 'SCH_EIATFI';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATFIDENR', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATFIDENR', 'OEPASSIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIATFIDENR';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIATFIDENR', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@MinCovDate        DATETIME
            ,@OEMinCovDate      DATETIME;;

    -- Set FormatCode
    SELECT @FormatCode = 'EIATFIDENR';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = '01/01/2024'
        ,@OEMinCovDate      = '01/01/' + CAST(DATEPART(YEAR, DATEADD(YEAR, 1, GETDATE())) AS VARCHAR) 
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EIATFIDENR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIATFIDENR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIATFIDENR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIATFIDENR_AuditFields;
    CREATE TABLE dbo.U_EIATFIDENR_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EIATFIDENR_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EIATFIDENR_AuditFields VALUES ('EmpDed','EedBenStartDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIATFIDENR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIATFIDENR_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTermintation = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audBenefitDate = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N'END
    INTO dbo.U_EIATFIDENR_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIATFIDENR_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'  --AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '');
    AND (ISNULL(audKEY3Value, '') = 'MEDP' or ISNULL(audKEY3Value, '') = '');

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIATFIDENR_Audit ON dbo.U_EIATFIDENR_Audit (audEEID,audKey2);

    --changes only
    DELETE FROM  dbo.U_EIATFIDENR_Audit WHERE audRowNo > 1;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MEDP'; --'HSAI,HSA,HSAC,HSAF,HSAD,HSADC';

    IF OBJECT_ID('U_EIATFIDENR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIATFIDENR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIATFIDENR_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'FutureDatedStartDateDays', '30')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'FutureDatedStopDateDays', '30')
 --   INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;

    IF @ExportCode LIKE 'OE%' 
        DELETE FROM dbo.U_dsi_BDM_EIATFIDENR WHERE BdmBenStopDate IS NOT NULL

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIATFIDENR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIATFIDENR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATFIDENR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID        
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvHsaPlanNum = '0375P'
        ,drvSSN = stuff(stuff(eepSSN,6,0,'-'),4,0,'-')
        ,drvRecordID = 'HS'
        ,drvPlanYear = CASE WHEN @ExportCode in ('OEACTIVE','OEPASSIVE') and bdmDedCode IN ('MEDP') then CAST(Year(@OEMinCovDate) AS VARCHAR)
                            WHEN @ExportCode NOT in ('OEACTIVE','OEPASSIVE') and bdmDedCode IN ('MEDP') then CAST(Year(dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @MinCovDate)) AS VARCHAR) 
                                END
                                --CAST(Year(bdmBenStartDate) AS VARCHAR)
        ,drvCoverageTier = CASE WHEN bdmDedCode IN ('MEDP') and BdmBenOption in ('EED' ,'EEB')then '05'
                                WHEN bdmDedCode IN ('MEDP') and BdmBenOption not in ('EED' ,'EEB') then '13'
                             END
        ,drvHDHPID = 'HDHP1'
        ,drvEnrollEffDate = CASE WHEN @ExportCode in ('OEACTIVE','OEPASSIVE') and bdmDedCode IN ('MEDP') then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @MinCovDate)
                                 WHEN @ExportCode NOT in ('OEACTIVE','OEPASSIVE') and bdmDedCode IN ('MEDP') and ISNULL(ejhreason,'') = '100' THEN PgrPayDate
								 WHEN @ExportCode NOT in ('OEACTIVE','OEPASSIVE') and bdmDedCode IN ('MEDP') AND ISNULL(ejhreason,'') <> '100' then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @MinCovDate)
                                 WHEN @ExportCode NOT in ('OEACTIVE','OEPASSIVE') and bdmDedCode IN ('MEDP') AND ISNULL(ejhreason,'') <> '100' AND BdmBenStatusDate > @MinCovDate AND DAY(BdmBenStatusDate) <> '01' then CONCAT(MONTH(DATEADD(month,1,BdmBenStatusDate)),'01',YEAR(DATEADD(month,1,BdmBenStatusDate)))
                                 END
        ,drvEnrollStatus = CASE WHEN bdmBenStatus in ('A') AND bdmDedCode IN ('MEDP') then 'A'
                                WHEN bdmBenStatus in ('C','T','W') then 'I' 
                            END
        ,drvClientBillFlag = 'N'
                            --CASE WHEN eecEmplStatus in ('T') then 'N'
       --                           ELSE 'Y'
       --                      END
    INTO dbo.U_EIATFIDENR_drvTbl
    FROM dbo.U_EIATFIDENR_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.empcomp with (NOLOCK)
        ON eecEEID = xEEID
        AND EecEEType in ('REB','REF','REG','REH','CPB')
        --AND EecEmplStatus <> 'T'
    JOIN dbo.U_dsi_BDM_EIATFIDENR WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmrectype = 'EMP'
	JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup= EecPayGroup
    --LEFT Join dbo.U_EIATFIDENR_Audit WITH (NOLOCK) 
    --    ON audEEID = xeeid
    --    and audKey2 = xcoid
     --LEFT JOIN (
     --       SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent
     --       FROM (
     --               SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
     --               FROM dbo.EmpHDed a WITH (NOLOCK)
     --               JOIN dbo.BenChRsn WITH (NOLOCK)
     --                   ON EdhChangeReason = BchCode
     --               WHERE EdhDedCode IN (@DedList)
     --                   AND edhChangeReason IN ('100','208','210','200','106','CHGRP','LEVNT1','401') AND EdhEffDate BETWEEN @StartDate AND @EndDate
     --           ) AS X
     --       WHERE RN = 1) AS Edh
     --   ON EdhEEID = xEEID
     --   AND EdhCoID = xCOID
    --Where EecEEType in ('REB','REF','REG','REH','CPB')
    --    AND  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (EecDateofTermination  BETWEEN  @StartDate AND @EndDate or audDateTime BETWEEN  @StartDate AND @EndDate )))
    --WHERE ( BdmChangeReason IN ('100','208','210','200','106','CHGRP','LEVNT1','401') OR  AudNewHire = 'Y' OR AudNewHire = 'Y' OR AudBenefitDate = 'Y')
      
     LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('MEDP')
                        AND edhChangeReason IN ('100','208','210','200','106','CHGRP','LEVNT1','401') AND EdhEffDate BETWEEN @StartDate AND @EndDate
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID
	LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID,EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                        JOIN dbo.EmpComp WITH (NOLOCK)
                            ON EjhEEID = EecEEID
                            AND EjhJObEffDate = EecDateOfLastHire
							AND EjhJobEffDate BETWEEN @StartDate AND @EndDate
                        ) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID        
        AND EjhCOID = xCOID
     LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audTermintation = MAX(audTermintation)                
            ,audBenefitDate  = MAX(audBenefitDate)        --  
        FROM dbo.U_EIATFIDENR_Audit
        WHERE audRowNo = 1
        AND (audNewHire = 'Y'            
            OR audTermintation = 'Y'
            OR audBenefitDate  = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
         ON audEEID = xEEID
    Where  ( edhChangeReason is not null OR  AudNewHire = 'Y' OR audTermintation = 'Y' OR AudBenefitDate = 'Y')
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIATFIDENR_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EIATFIDENR_Header;
    SELECT DISTINCT
         drvTestFileIndicator = CASE WHEN @ExportCode = 'TEST_XOE' THEN 'TESTEDT' END
    INTO dbo.U_EIATFIDENR_Header
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
ALTER VIEW dbo.dsi_vwEIATFIDENR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIATFIDENR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIATFIDENR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311281'
       ,expStartPerControl     = '202311281'
       ,expLastEndPerControl   = '202312129'
       ,expEndPerControl       = '202312129'
WHERE expFormatCode = 'EIATFIDENR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIATFIDENR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIATFIDENR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIATFIDENR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIATFIDENR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIATFIDENR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATFIDENR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIATFIDENR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATFIDENR', 'UseFileName', 'V', 'Y'


-- End ripout