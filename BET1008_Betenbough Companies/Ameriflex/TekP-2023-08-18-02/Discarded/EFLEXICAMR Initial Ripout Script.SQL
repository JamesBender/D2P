/**********************************************************************************

EFLEXICAMR: Ameriflex HSA IC V2

FormatCode:     EFLEXICAMR
Project:        Ameriflex HSA IC V2
Client ID:      BET1008
Date/time:      2023-09-25 15:26:08.033
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP7DB03
Database:       ULTIPRO_WPBETB
Web Filename:   BET1008_SC6HO_EEHISTORY_EFLEXICAMR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFLEXICAMR_SavePath') IS NOT NULL DROP TABLE dbo.U_EFLEXICAMR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFLEXICAMR'


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
WHERE FormatCode = 'EFLEXICAMR'
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
WHERE ExpFormatCode = 'EFLEXICAMR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFLEXICAMR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFLEXICAMR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFLEXICAMR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFLEXICAMR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFLEXICAMR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFLEXICAMR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFLEXICAMR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFLEXICAMR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFLEXICAMR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFLEXICAMR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFLEXICAMR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFLEXICAMR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFLEXICAMR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLEXICAMR];
GO
IF OBJECT_ID('U_EFLEXICAMR_File') IS NOT NULL DROP TABLE [dbo].[U_EFLEXICAMR_File];
GO
IF OBJECT_ID('U_EFLEXICAMR_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFLEXICAMR_EEList];
GO
IF OBJECT_ID('U_EFLEXICAMR_D10') IS NOT NULL DROP TABLE [dbo].[U_EFLEXICAMR_D10];
GO
IF OBJECT_ID('U_EFLEXICAMR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFLEXICAMR_AuditFields];
GO
IF OBJECT_ID('U_EFLEXICAMR_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFLEXICAMR_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFLEXICAMR','Ameriflex HSA IC V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','153','S','N','EYYJ0O000RY0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EYYJ0O000RY0','2','D','10','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EYYJ0O000RY0','6','D','10','3',NULL,'TPA ID',NULL,NULL,'"drvTPAID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EYYJ0O000RY0','9','D','10','9',NULL,'Group Code',NULL,NULL,'"drvGroupCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EYYJ0O000RY0','10','D','10','18',NULL,'Plan ID',NULL,NULL,'"drvPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EYYJ0O000RY0','9','D','10','28',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EYYJ0O000RY0','3','D','10','37',NULL,'Account Type',NULL,NULL,'"drvAccountType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EYYJ0O000RY0','8','D','10','40',NULL,'Plan Year Start date',NULL,NULL,'"drvPlanYearStartdate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EYYJ0O000RY0','8','D','10','48',NULL,'Plan Year End date',NULL,NULL,'"drvPlanYearEnddate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EYYJ0O000RY0','1','D','10','56',NULL,'Account Status',NULL,NULL,'"drvAccountStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EYYJ0O000RY0','18','D','10','57',NULL,'Original Prefund / Annual Election/Goal Amount',NULL,NULL,'"drvAnnualElectionGoalAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EYYJ0O000RY0','18','D','10','75',NULL,'Enrollee Deposit Amount',NULL,NULL,'"drvEnrolleeDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EYYJ0O000RY0','18','D','10','93',NULL,'Employer Deposit Amount',NULL,NULL,'"drvEmployerDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EYYJ0O000RY0','8','D','10','111',NULL,'Benefit Start Date',NULL,NULL,'"drvBenefitStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EYYJ0O000RY0','8','D','10','119',NULL,'Benefit End Date',NULL,NULL,'"drvBenefitEndDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EYYJ0O000RY0','8','D','10','127',NULL,'Auto-Deposit Start Date/Election change effective',NULL,NULL,'"drvElectionchangeeffdate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EYYJ0O000RY0','18','D','10','135',NULL,'Calendar ID',NULL,NULL,'"drvCalendarID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EYYJ0O000RY0','1','D','10','153',NULL,'Auto Add All Dependents',NULL,NULL,'"drvAutoAddAllDependents"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFLEXICAMR_20230925.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202308169','EMPEXPORT','OEACTIVE','Aug 16 2017 12:00AM','EFLEXICAMR',NULL,NULL,NULL,'202308169','Aug 16 2017 12:00AM','Dec 30 1899 12:00AM','202308091',NULL,NULL,NULL,'202308091',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202308169','EMPEXPORT','OEPASSIVE','Aug 16 2017 12:00AM','EFLEXICAMR',NULL,NULL,NULL,'202308169','Aug 16 2017 12:00AM','Dec 30 1899 12:00AM','202308091',NULL,NULL,NULL,'202308091',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ameriflex HSA IC V2 Export','202308169','EMPEXPORT','ONDEM_XOE','Aug 16 2017 12:00AM','EFLEXICAMR',NULL,NULL,NULL,'202308169','Aug 16 2017 12:00AM','Dec 30 1899 12:00AM','202308091',NULL,NULL,NULL,'202308091',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEDFT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'FSA IC Export','202308169','EMPEXPORT','SCH_EFLEXI',NULL,'EFLEXICAMR',NULL,NULL,NULL,'202308169',NULL,NULL,'202308091',NULL,NULL,NULL,'202308091',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202308169','EMPEXPORT','TEST_XOE','Mar 10 2022  1:33PM','EFLEXICAMR',NULL,NULL,NULL,'202308169','Mar 10 2022 12:00AM','Dec 30 1899 12:00AM','202308091','16',NULL,NULL,'202308091',dbo.fn_GetTimedKey(),NULL,'ULTI_WPBETB',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLEXICAMR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLEXICAMR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLEXICAMR','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLEXICAMR','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLEXICAMR','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLEXICAMR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLEXICAMR','D10','dbo.U_EFLEXICAMR_D10',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EFLEXICAMR_Audit
-----------

IF OBJECT_ID('U_EFLEXICAMR_Audit') IS NULL
CREATE TABLE [dbo].[U_EFLEXICAMR_Audit] (
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
-- Create table U_EFLEXICAMR_AuditFields
-----------

IF OBJECT_ID('U_EFLEXICAMR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFLEXICAMR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EFLEXICAMR_D10
-----------

IF OBJECT_ID('U_EFLEXICAMR_D10') IS NULL
CREATE TABLE [dbo].[U_EFLEXICAMR_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvGroupCode] varchar(9) NOT NULL,
    [drvPlanID] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvAccountType] varchar(3) NULL,
    [drvPlanYearStartdate] varchar(30) NULL,
    [drvPlanYearEnddate] varchar(30) NULL,
    [drvAccountStatus] varchar(1) NOT NULL,
    [drvAnnualElectionGoalAmount] money NULL,
    [drvEnrolleeDepositAmount] money NULL,
    [drvEmployerDepositAmount] varchar(18) NOT NULL,
    [drvBenefitStartDate] datetime NULL,
    [drvBenefitEndDate] varchar(30) NULL,
    [drvElectionchangeeffdate] varchar(1) NOT NULL,
    [drvCalendarID] varchar(1) NOT NULL,
    [drvAutoAddAllDependents] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLEXICAMR_EEList
-----------

IF OBJECT_ID('U_EFLEXICAMR_EEList') IS NULL
CREATE TABLE [dbo].[U_EFLEXICAMR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFLEXICAMR_File
-----------

IF OBJECT_ID('U_EFLEXICAMR_File') IS NULL
CREATE TABLE [dbo].[U_EFLEXICAMR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(153) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLEXICAMR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Betenbough

Created By: Gaspare Simeti
Business Analyst: Gaspare Simeti
Create Date: 2/1/22
Service Request Number: 00289016

Purpose: Ameriflex HSA IC V2

Revision History'
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX
DAgyei              02/25/2019     PR-294905          Added Transit and Parking benefits
Marie Waters        09/08/2023       TekP-2023-08-18-02 Updated formatcode, dedcode fields and session names

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFLEXICAMR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFLEXICAMR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFLEXICAMR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFLEXICAMR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFLEXICAMR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLEXICAMR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLEXICAMR', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLEXICAMR', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLEXICAMR', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMERFLXI2', 'SCH_EFLEXI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFLEXICAMR';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFLEXICAMR', @AllObjects = 'Y', @IsWeb = 'Y'
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
            -- ,@PlanYearStart datetime
            -- ,@PlanEndDate datetime;

    -- Set FormatCode
    SELECT @FormatCode = 'EFLEXICAMR';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        -- ,@PlanYearStart = LEFT(@EndPerControl,4)+'0101'
        -- ,@PlanEndDate = LEFT(@EndPerControl,4)+'1231'

    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFLEXICAMR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFLEXICAMR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','HSA');--FSAMD, FSADC, FSALT
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFLEXICAMR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFLEXICAMR_AuditFields;
    CREATE TABLE dbo.U_EFLEXICAMR_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EFLEXICAMR_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFLEXICAMR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFLEXICAMR_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audTableName, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EFLEXICAMR_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EFLEXICAMR_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';



    --==========================================
    -- Non Standard Plan Year Date
    --==========================================    
    --DECLARE @FSAPlanYearStart VARCHAR(10);
    --DECLARE @FSAPlanYearEnd   VARCHAR(10);
    DECLARE @HSAPlanYearStart VARCHAR(10);
    DECLARE @HSAPlanYearEnd   VARCHAR(10);
    
    --SET @FSAPlanYearStart = CAST(DATEPART(YYYY,@EndDate) as VARCHAR)+'001' /*CASE     WHEN DATEPART(MM,@EndDate) < 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,-1,@EndDate)))) + '0701'
    --                            WHEN DATEPART(MM,@EndDate) >= 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,0,@EndDate)))) + '0701'
    --                            END;*/
                                
    --SET @FSAPlanYearEnd   = CAST(DATEPART(YYYY,@EndDate) as VARCHAR)+'1231'/*CASE     WHEN DATEPART(MM,@EndDate) < 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,0,@EndDate)))) + '0630'
    --                            WHEN DATEPART(MM,@EndDate) >= 7 THEN LTRIM(STR(DATEPART(YY,DATEADD(YY,1,@EndDate)))) + '0630'
    --                            END; */   
                                            
    SET @HSAPlanYearStart = '20230401';
                                
    SET @HSAPlanYearEnd   = '20991231';
    
   -- PRINT 'FSA Plan Year Start:  ' + @FSAPlanYearStart;
   -- PRINT 'FSA Plan Year End:  ' + @FSAPlanYearEnd;    
    PRINT 'HSA Plan Year Start:  ' + @HSAPlanYearStart;
    PRINT 'HSA Plan Year End:  ' + @HSAPlanYearEnd;    
    
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFLEXICAMR_D10
    ---------------------------------
    IF OBJECT_ID('U_EFLEXICAMR_D10','U') IS NOT NULL
        DROP TABLE dbo.U_EFLEXICAMR_D10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvRecordID = 'IC'
        ,drvTPAID = 'AMF001'
        ,drvGroupCode = 'AMFBETENB'
        ,drvPlanID = 'BETENB'
        ,drvSSN = EepSSN
        ,drvAccountType = CASE -- WHEN EedDedCode = 'FSAMD' THEN 'FSA' --MW removed
                               -- WHEN EedDedCode = 'FSADC' THEN 'DCA' --MW removed
                               -- WHEN EedDedCode = 'FSALT' THEN 'LPF' --MW removed
                                WHEN EedDedCode = 'HSA' THEN 'ABH' --MW added 9/8/23
                                --WHEN EedDedCode LIKE 'HS%' THEN 'ABH' --Was AB2. 11/3/20
                                END
        ,drvPlanYearStartdate = CASE WHEN EedDedCode = 'HSA' THEN CONVERT(varchar,@HSAPlanYearStart,112) END  -- ELSE CONVERT(varchar,@FSAPlanYearStart,112) END
        ,drvPlanYearEnddate = CASE WHEN EedDedCode = 'HSA' THEN CONVERT(varchar,@HSAPlanYearEnd,112) END --  ELSE CONVERT(varchar,@FSAPlanYearEnd,112) END
        ,drvAccountStatus = CASE
                                 WHEN EedBenStatus ='T' THEN 'T'
                                 ELSE 'A'
                                 END 
        ,drvAnnualElectionGoalAmount = CASE WHEN EedDedCode = 'HSA' THEN EedEEGoalAmt END
        ,drvEnrolleeDepositAmount = CASE WHEN EedDedCode = 'HSA' THEN EedEEAmt END
        ,drvEmployerDepositAmount = '000000000000000.00' --EedERAmt
        ,drvBenefitStartDate = CASE WHEN  EedDedCode = 'HSA' THEN eedbenstartdate 
                                    --WHEN EedDedCode LIKE 'HS%' AND EedBenStartDate > @HSAPlanYearStart THEN CONVERT(varchar,EedBenStartDate,112)
                                    --WHEN EedDedCode LIKE 'HS%' AND EedBenStartDate <= @HSAPlanYearStart THEN CONVERT(varchar,@HSAPlanYearStart,112)
                                    --WHEN EedDedCode NOT LIKE 'HS%' AND EedBenStartDate > @FSAPlanYearStart THEN CONVERT(varchar,EedBenStartDate,112)
                                    --WHEN EedDedCode NOT LIKE 'HS%' AND EedBenStartDate <= @FSAPlanYearStart THEN CONVERT(varchar,@FSAPlanYearStart,112)
                                    END
        ,drvBenefitEndDate = CASE
                                 When EedBenStatus = 'T' THEN CONVERT(varchar,EedBenStopDate,112)
                                 ELSE  ''
                                 END 
        ,drvElectionchangeeffdate = ''
        ,drvCalendarID = ''
        ,drvAutoAddAllDependents = '' 
                                        --CASE WHEN EedDedCode LIKE 'HS%' THEN 'N' --Logic added 11/10/20
          --                                  ELSE ''
          --                                  END
    INTO dbo.U_EFLEXICAMR_D10
    FROM dbo.U_EFLEXICAMR_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp with (nolock)
        ON xeeid = eeceeid 
        and xcoid = eeccoid
    JOIN dbo.EmpPers with (nolock)
        ON  Eepeeid = xEEID
    JOIN Company
        ON cmpcoid = xcoid
    JOIN  dbo.U_dsi_bdm_EmpDeductions with (nolock)
        on xeeid = eedeeid 
        and xcoid = eedcoid
        and eedformatcode = @formatcode 
        and eedvalidforexport = 'Y'
        and EedDedCode = 'HSA'  
  /*  WHERE (eecemplstatus <> 'T' OR (eecemplstatus= 'T' 
               and  exists (select top 1 1 from dbo.U_EFLEXICAMR_Audit as aud with (nolock)
                    where audeeid = xeeid and audtablename ='empcomp' and audfieldname = 'eecemplstatus' and isnull(audoldvalue,' ') <> audnewvalue  and audnewvalue ='T'))) ;
*/
    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = 'EDFT_EFLEXICAMR_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.TXT'
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFLEXICAMR_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EFLEXICAMR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFLEXICAMR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201708091'
       ,expStartPerControl     = '201708091'
       ,expLastEndPerControl   = '201708169'
       ,expEndPerControl       = '201708169'
WHERE expFormatCode = 'EFLEXICAMR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFLEXICAMR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFLEXICAMR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFLEXICAMR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFLEXICAMR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFLEXICAMR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLEXICAMR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFLEXICAMR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLEXICAMR', 'UseFileName', 'V', 'Y'


-- End ripout