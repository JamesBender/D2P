/**********************************************************************************

EINTACUSOC: USOC Intaact File

FormatCode:     EINTACUSOC
Project:        USOC Intaact File
Client ID:      USO1001
Date/time:      2023-12-26 10:51:49.080
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUSOC
Web Filename:   USO1001_839B6_EEHISTORY_EINTACUSOC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EINTACUSOC_SavePath') IS NOT NULL DROP TABLE dbo.U_EINTACUSOC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EINTACUSOC'


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
WHERE FormatCode = 'EINTACUSOC'
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
WHERE ExpFormatCode = 'EINTACUSOC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EINTACUSOC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EINTACUSOC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EINTACUSOC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EINTACUSOC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EINTACUSOC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EINTACUSOC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EINTACUSOC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EINTACUSOC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EINTACUSOC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EINTACUSOC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEINTACUSOC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINTACUSOC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINTACUSOC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINTACUSOC];
GO
IF OBJECT_ID('U_EINTACUSOC_File') IS NOT NULL DROP TABLE [dbo].[U_EINTACUSOC_File];
GO
IF OBJECT_ID('U_EINTACUSOC_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINTACUSOC_EEList];
GO
IF OBJECT_ID('U_EINTACUSOC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EINTACUSOC_drvTbl];
GO
IF OBJECT_ID('U_EINTACUSOC_DedList') IS NOT NULL DROP TABLE [dbo].[U_EINTACUSOC_DedList];
GO
IF OBJECT_ID('U_EINTACUSOC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EINTACUSOC_AuditFields];
GO
IF OBJECT_ID('U_EINTACUSOC_Audit') IS NOT NULL DROP TABLE [dbo].[U_EINTACUSOC_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EINTACUSOC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EINTACUSOC];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EINTACUSOC','USOC Intaact File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EINTACUSOCZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINTACUSOCZ0','50','H','01','1',NULL,'EMPLOYEE_ID',NULL,NULL,'"EMPLOYEE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINTACUSOCZ0','50','H','01','2',NULL,'EMPLOYEE_TYPE',NULL,NULL,'"EMPLOYEE_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINTACUSOCZ0','50','H','01','3',NULL,'START_DATE',NULL,NULL,'"START_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINTACUSOCZ0','50','H','01','4',NULL,'ACTIVE',NULL,NULL,'"ACTIVE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINTACUSOCZ0','50','H','01','5',NULL,'DEPT_ID',NULL,NULL,'"DEPT_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINTACUSOCZ0','50','H','01','6',NULL,'CONTACT_NAME',NULL,NULL,'"CONTACT_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINTACUSOCZ0','50','H','01','7',NULL,'FIRST_NAME',NULL,NULL,'"FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINTACUSOCZ0','50','H','01','8',NULL,'LAST_NAME',NULL,NULL,'"LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINTACUSOCZ0','50','H','01','9',NULL,'PRINT_AS',NULL,NULL,'"PRINT_AS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINTACUSOCZ0','50','H','01','101',NULL,'EMAIL1',NULL,NULL,'"EMAIL1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINTACUSOCZ0','50','H','01','11',NULL,'PREFERRED_NAME',NULL,NULL,'"PREFERRED_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINTACUSOCZ0','50','H','01','12',NULL,'END_DATE',NULL,NULL,'"END_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINTACUSOCZ0','50','D','10','1',NULL,'EMPLOYEE_ID',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINTACUSOCZ0','50','D','10','2',NULL,'EMPLOYEE_TYPE',NULL,NULL,'"drvEmpType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINTACUSOCZ0','50','D','10','3',NULL,'START_DATE',NULL,NULL,'"drvStartDate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINTACUSOCZ0','50','D','10','4',NULL,'ACTIVE',NULL,NULL,'"drvActive"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINTACUSOCZ0','50','D','10','5',NULL,'DEPT_ID',NULL,NULL,'"drvDeptId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINTACUSOCZ0','50','D','10','6',NULL,'CONTACT_NAME',NULL,NULL,'"drvContactName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINTACUSOCZ0','50','D','10','7',NULL,'FIRST_NAME',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINTACUSOCZ0','50','D','10','8',NULL,'LAST_NAME',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINTACUSOCZ0','50','D','10','9',NULL,'PRINT_AS',NULL,NULL,'"drvPrintName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINTACUSOCZ0','50','D','10','10',NULL,'EMAIL1',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINTACUSOCZ0','50','D','10','11',NULL,'PREFERRED_NAME',NULL,NULL,'"drvPrefferedName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINTACUSOCZ0','50','D','10','12',NULL,'END_DATE',NULL,NULL,'"drvEndDate"','(''UDMDY''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EINTACUSOC_20231226.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'6IYSR,V5C45',NULL,NULL,NULL,'USOC Intaact File On-Demand','202312129','EMPEXPORT','ONDEM_XOE',NULL,'EINTACUSOC',NULL,NULL,NULL,'202312129','Dec 12 2023  3:21PM','Dec 12 2023  3:21PM','202312121',NULL,'','','202312121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',6IYSR,V5C45',NULL,NULL,NULL,'USOC Intaact File-Sched','202312129','EMPEXPORT','SCH_EINTAC',NULL,'EINTACUSOC',NULL,NULL,NULL,'202312129','Dec 12 2023  3:21PM','Dec 12 2023  3:21PM','202312121',NULL,'','','202312121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',6IYSR,V5C45',NULL,NULL,NULL,'USOC Intaact File-Test','202312189','EMPEXPORT','TEST_XOE',NULL,'EINTACUSOC',NULL,NULL,NULL,'202312189','Dec 12 2023  3:21PM','Dec 12 2023  3:21PM','202311181',NULL,'','','202311181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINTACUSOC','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINTACUSOC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINTACUSOC','D10','dbo.U_EINTACUSOC_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EINTACUSOC
-----------

IF OBJECT_ID('U_dsi_BDM_EINTACUSOC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EINTACUSOC] (
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
-- Create table U_EINTACUSOC_Audit
-----------

IF OBJECT_ID('U_EINTACUSOC_Audit') IS NULL
CREATE TABLE [dbo].[U_EINTACUSOC_Audit] (
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
    [audEmpNo] varchar(1) NOT NULL,
    [audEmpType] varchar(1) NOT NULL,
    [audStartDate] varchar(1) NOT NULL,
    [audActive] varchar(1) NOT NULL,
    [audDeptId] varchar(1) NOT NULL,
    [audFirstName] varchar(1) NOT NULL,
    [audLastName] varchar(1) NOT NULL,
    [audEmail] varchar(1) NOT NULL,
    [audAltEmail] varchar(1) NOT NULL,
    [audPreferredName] varchar(1) NOT NULL,
    [audTermination] varchar(1) NOT NULL,
    [audLastHire] varchar(1) NOT NULL
);

-----------
-- Create table U_EINTACUSOC_AuditFields
-----------

IF OBJECT_ID('U_EINTACUSOC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EINTACUSOC_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EINTACUSOC_DedList
-----------

IF OBJECT_ID('U_EINTACUSOC_DedList') IS NULL
CREATE TABLE [dbo].[U_EINTACUSOC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EINTACUSOC_drvTbl
-----------

IF OBJECT_ID('U_EINTACUSOC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EINTACUSOC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvEmpType] varchar(45) NULL,
    [drvStartDate] datetime NULL,
    [drvActive] varchar(1) NOT NULL,
    [drvDeptId] varchar(10) NULL,
    [drvContactName] varchar(201) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvPrintName] varchar(201) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPrefferedName] varchar(100) NULL,
    [drvEndDate] datetime NULL
);

-----------
-- Create table U_EINTACUSOC_EEList
-----------

IF OBJECT_ID('U_EINTACUSOC_EEList') IS NULL
CREATE TABLE [dbo].[U_EINTACUSOC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EINTACUSOC_File
-----------

IF OBJECT_ID('U_EINTACUSOC_File') IS NULL
CREATE TABLE [dbo].[U_EINTACUSOC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINTACUSOC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: USOC

Created By: Spencer Kerch
Business Analyst: Dawn Ross
Create Date: 12/12/2023
Service Request Number: TekP-2023-10-25-03

Purpose: USOC Intaact File

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        12/15/2023     TekP-2023-10-25-03 Updated New Hire field (ELSE 'N') 
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINTACUSOC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINTACUSOC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINTACUSOC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EINTACUSOC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINTACUSOC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINTACUSOC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINTACUSOC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINTACUSOC', 'SCH_EINTAC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EINTACUSOC';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EINTACUSOC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EINTACUSOC';

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
    DELETE FROM dbo.U_EINTACUSOC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EINTACUSOC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EINTACUSOC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EINTACUSOC_AuditFields;
    CREATE TABLE dbo.U_EINTACUSOC_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','EecEEType');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','EecOrgLvl4');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpPers','eepAddressEmail');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpPers','eepAddressEmailAlternate');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpPers','EepNamePreferred');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','eecDateofTermination');
    INSERT INTO dbo.U_EINTACUSOC_AuditFields VALUES ('EmpComp','eecDateOfLastHire');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EINTACUSOC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EINTACUSOC_Audit;
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
        ,audEmpNo = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecEmpNo' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audEmpType = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecEEType' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audStartDate = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecDateOfLastHire' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audActive = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audDeptId = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecOrgLvl4' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audFirstName = CASE WHEN audTableName = 'EmpPers' and audFieldName = 'EepNameFirst' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audLastName =  CASE WHEN audTableName = 'EmpPers' and audFieldName = 'EepNameLast' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audEmail = CASE WHEN audTableName = 'EmpPers' and audFieldName = 'EepAddressEmail' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audAltEmail =  CASE WHEN audTableName = 'EmpPers' and audFieldName = 'EepAddressEmailAlternate' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audPreferredName = CASE WHEN audTableName = 'EmpPers' and audFieldName = 'EepNamePreferred' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audTermination = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecDateOfTermination' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
        ,audLastHire = CASE WHEN audTableName = 'EmpComp' and audFieldName = 'EecDateOfLastHire' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
    INTO dbo.U_EINTACUSOC_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EINTACUSOC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EINTACUSOC_Audit ON dbo.U_EINTACUSOC_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EINTACUSOC_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EINTACUSOC_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EINTACUSOC_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EINTACUSOC_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EINTACUSOC_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EINTACUSOC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EINTACUSOC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EINTACUSOC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvEmpType = CodDesc --emptyp codtable
        ,drvStartDate = EecDateOfLastHire
        ,drvActive = CASE WHEN EecEmplStatus= 'T' THEN 'F' ELSE 'T' END
        ,drvDeptId = eecOrgLvl4 --eecOrgLvl4
        ,drvContactName = EepNameFirst + ' ' + EepNameLast 
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvPrintName = EepNameFirst + ' ' + EepNameLast 
        ,drvEmail = CASE WHEN EepAddressEMail IS NULL THEN EepAddressEmailAlternate ELSE EepAddressEMail END
        ,drvPrefferedName = eepNamePreferred
        ,drvEndDate = eecDateOfTermination
       -- ,drvNewHire = CASE When EecDateOfLastHire BETWEEN @StartDate AND @EndDate then 'Y' ELSE 'N' END -- MW added ELSE 'N' 12/15/23
    INTO dbo.U_EINTACUSOC_drvTbl
    FROM dbo.U_EINTACUSOC_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EINTACUSOC WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN dbo.Codes WITH (NOLOCK)
        ON CodCode = EecEEType
        AND CodTable = 'EMPTYPE'
    JOIN dbo.U_EINTACUSOC_Audit WITH (NOLOCK)
        ON xEEID = audEEID
        AND xCOID = audKey2
        WHERE (audEmpNo = 'Y' OR audEmpType = 'Y' OR audStartdate = 'Y' OR audActive = 'Y' OR audDeptId = 'Y' OR audFirstName = 'Y' OR audLastName = 'Y' OR audEmail = 'Y'
            OR (EepAddressEMail IS NULL AND audAltEmail = 'Y') OR audPreferredName = 'Y' OR audTermination = 'Y' OR audLastHire = 'Y') 
            AND AudDateTime BETWEEN @StartDate AND @EndDate
            
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
ALTER VIEW dbo.dsi_vwEINTACUSOC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINTACUSOC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EINTACUSOC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202312051'
       ,expStartPerControl     = '202312051'
       ,expLastEndPerControl   = '202312129'
       ,expEndPerControl       = '202312129'
WHERE expFormatCode = 'EINTACUSOC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEINTACUSOC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EINTACUSOC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EINTACUSOC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EINTACUSOC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EINTACUSOC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EINTACUSOC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EINTACUSOC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EINTACUSOC', 'UseFileName', 'V', 'Y'


-- End ripout