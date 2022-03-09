/**********************************************************************************

ESUNLIFE: Sunlife XML Export

FormatCode:     ESUNLIFE
Project:        Sunlife XML Export
Client ID:      REF1001
Date/time:      2022-03-03 06:02:27.853
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
ExportPath:    \\us.saas\E0\data_exchange\REF1001\Exports\
TestPath:      \\us.saas\e4\Public\REF1001\Exports\Sunlife\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESUNLIFE_SavePath') IS NOT NULL DROP TABLE dbo.U_ESUNLIFE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESUNLIFE'


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
WHERE FormatCode = 'ESUNLIFE'
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
WHERE ExpFormatCode = 'ESUNLIFE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESUNLIFE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESUNLIFE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESUNLIFE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESUNLIFE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESUNLIFE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESUNLIFE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESUNLIFE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESUNLIFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESUNLIFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESUNLIFE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESUNLIFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNLIFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNLIFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLIFE];
GO
IF OBJECT_ID('U_ESUNLIFE_Salary') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Salary];
GO
IF OBJECT_ID('U_ESUNLIFE_PolNum') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_PolNum];
GO
IF OBJECT_ID('U_ESUNLIFE_Person') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Person];
GO
IF OBJECT_ID('U_ESUNLIFE_OverRideDate') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_OverRideDate];
GO
IF OBJECT_ID('U_ESUNLIFE_NewEmp') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_NewEmp];
GO
IF OBJECT_ID('U_ESUNLIFE_NewDedStart') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_NewDedStart];
GO
IF OBJECT_ID('U_ESUNLIFE_NewDedDt') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_NewDedDt];
GO
IF OBJECT_ID('U_ESUNLIFE_NewDedDate') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_NewDedDate];
GO
IF OBJECT_ID('U_ESUNLIFE_New') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_New];
GO
IF OBJECT_ID('U_ESUNLIFE_MTrailer') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_MTrailer];
GO
IF OBJECT_ID('U_ESUNLIFE_MemberClose') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_MemberClose];
GO
IF OBJECT_ID('U_ESUNLIFE_Member') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Member];
GO
IF OBJECT_ID('U_ESUNLIFE_LTrailer') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_LTrailer];
GO
IF OBJECT_ID('U_ESUNLIFE_Load') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Load];
GO
IF OBJECT_ID('U_ESUNLIFE_Header') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Header];
GO
IF OBJECT_ID('U_ESUNLIFE_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_File];
GO
IF OBJECT_ID('U_ESUNLIFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_EEList];
GO
IF OBJECT_ID('U_ESUNLIFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_drvTbl];
GO
IF OBJECT_ID('U_ESUNLIFE_Dep') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Dep];
GO
IF OBJECT_ID('U_ESUNLIFE_Ded') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Ded];
GO
IF OBJECT_ID('U_ESUNLIFE_Benefit') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Benefit];
GO
IF OBJECT_ID('U_ESUNLIFE_BenEffDt') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_BenEffDt];
GO
IF OBJECT_ID('U_ESUNLIFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_AuditFields];
GO
IF OBJECT_ID('U_ESUNLIFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Audit];
GO
IF OBJECT_ID('U_ESUNLIFE_Address') IS NOT NULL DROP TABLE [dbo].[U_ESUNLIFE_Address];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESUNLIFE','Sunlife XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ESUNLIFE00Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','50','H','01','1',NULL,'Header',NULL,NULL,'"drvHeader"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','H','02','1',NULL,'Loader',NULL,NULL,'"drvLoader"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','D','10','1',NULL,'Member',NULL,NULL,'"drvMemberOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','D','30','1',NULL,'Person',NULL,NULL,'"drvPersonOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','D','40','1',NULL,'Salary',NULL,NULL,'"drvSalOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','D','50','1',NULL,'Address',NULL,NULL,'"drvAddOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','D','60','1',NULL,'Person Link',NULL,NULL,'"drvDepOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','8000','D','70','1',NULL,'Benefits',NULL,NULL,'"drvBeneOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLIFE00Z0','50','D','80','1',NULL,'Member End',NULL,NULL,'"drvMemberClose"','(''UA''=''T'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201906179','EMPEXPORT','OEACTIVE','Jun 17 2019 12:00AM','ESUNLIFE',NULL,NULL,NULL,'201906179','Jun 17 2019 12:00AM','Dec 30 1899 12:00AM','201906171',NULL,'','','201906171',dbo.fn_GetTimedKey(),NULL,'SMACKIN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201904159','EMPEXPORT','OEPASSIVE',NULL,'ESUNLIFE',NULL,NULL,NULL,'201904159','Apr 15 2019  5:15PM','Apr 15 2019  5:15PM','201904151',NULL,'','','201904151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife XML Export','202011031','EMPEXPORT','ONDEMAND','Nov  5 2020 12:00AM','ESUNLIFE',NULL,NULL,NULL,'202011031','Nov  3 2020 12:00AM','Dec 30 1899 12:00AM','202010281',NULL,'','','202010281',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202203019','EMPEXPORT','SCHEDULED','Mar  2 2022 11:01AM','ESUNLIFE',NULL,NULL,NULL,'202203019','Apr 15 2019  5:15PM','Apr 15 2019  5:15PM','202202231',NULL,'','','202202231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\e4sup3db01\UltiProData\TCI\Export_Test\EOPTUMHSAC_20210317.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202012151','EMPEXPORT','TEST','Dec 20 2020 12:00AM','ESUNLIFE',NULL,NULL,NULL,'202012151','Dec 15 2020 12:00AM','Dec 30 1899 12:00AM','202012091','4250','','','202012091',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','ExportPath','V','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','TestPath','V','\\us.saas\e4\Public\REF1001\Exports\Sunlife\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','UDESPath','C','\\us.saas\E0\data_exchange\REF1001\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLIFE','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','H01','dbo.U_ESUNLIFE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','H02','dbo.U_ESUNLIFE_Load',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D10','dbo.U_ESUNLIFE_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D30','dbo.U_ESUNLIFE_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D40','dbo.U_ESUNLIFE_Salary',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D50','dbo.U_ESUNLIFE_Address',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D60','dbo.U_ESUNLIFE_Dep',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D70','dbo.U_ESUNLIFE_Benefit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLIFE','D80','dbo.U_ESUNLIFE_MemberClose',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESUNLIFE_Address
-----------

IF OBJECT_ID('U_ESUNLIFE_Address') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Address] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvAddOpen] varchar(8000) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_Audit
-----------

IF OBJECT_ID('U_ESUNLIFE_Audit') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Audit] (
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
-- Create table U_ESUNLIFE_AuditFields
-----------

IF OBJECT_ID('U_ESUNLIFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESUNLIFE_BenEffDt
-----------

IF OBJECT_ID('U_ESUNLIFE_BenEffDt') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_BenEffDt] (
    [BenEEID] varchar(255) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_Benefit
-----------

IF OBJECT_ID('U_ESUNLIFE_Benefit') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Benefit] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvBeneOpen] varchar(156) NOT NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_Ded
-----------

IF OBJECT_ID('U_ESUNLIFE_Ded') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Ded] (
    [EEID] char(12) NOT NULL,
    [COID] char(5) NOT NULL,
    [DCRSP] numeric NULL,
    [DCMEM] numeric NULL,
    [DCES1] numeric NULL,
    [DCESP] numeric NULL,
    [DCER] numeric NULL
);

-----------
-- Create table U_ESUNLIFE_Dep
-----------

IF OBJECT_ID('U_ESUNLIFE_Dep') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Dep] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepOpen] nvarchar(4000) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] char(12) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_drvTbl
-----------

IF OBJECT_ID('U_ESUNLIFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_drvTbl] (
    [drvNationalID] varchar(50) NOT NULL,
    [drvEinNationalID] varchar(50) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(512) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] varchar(3) NULL,
    [drvCompanycode] varchar(3) NULL,
    [drvUserField1] varchar(1) NOT NULL,
    [drvEECurAmt] numeric NULL,
    [drvERCurAmt] numeric NULL,
    [drvMatch] numeric NULL,
    [drvMatch3] numeric NULL,
    [drvERAmt] numeric NULL,
    [drvSITWorkInStateCode] varchar(3) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvAdjustestedHireDate] varchar(1) NOT NULL,
    [drvBenStartDate] datetime NULL,
    [drvLanguageCode] varchar(1) NOT NULL,
    [drvEmplStatus] char(1) NULL,
    [drvDateDeceased] datetime NULL,
    [drvGender] char(1) NULL,
    [drvWorkInStateCode] varchar(3) NOT NULL,
    [drvHireDate] varchar(1) NOT NULL,
    [drvEecLanguageCode] varchar(1) NOT NULL,
    [drvEepDateofBirth] datetime NULL,
    [drvEedBenStartDate] datetime NULL,
    [drvaddressemail] varchar(50) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL
);

-----------
-- Create table U_ESUNLIFE_EEList
-----------

IF OBJECT_ID('U_ESUNLIFE_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESUNLIFE_File
-----------

IF OBJECT_ID('U_ESUNLIFE_File') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ESUNLIFE_Header
-----------

IF OBJECT_ID('U_ESUNLIFE_Header') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Header] (
    [drvHeader] varchar(43) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_Load
-----------

IF OBJECT_ID('U_ESUNLIFE_Load') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Load] (
    [drvLoader] varchar(82) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_LTrailer
-----------

IF OBJECT_ID('U_ESUNLIFE_LTrailer') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_LTrailer] (
    [drvLoader] varchar(9) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_Member
-----------

IF OBJECT_ID('U_ESUNLIFE_Member') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Member] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvMemberOpen] varchar(274) NOT NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_MemberClose
-----------

IF OBJECT_ID('U_ESUNLIFE_MemberClose') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_MemberClose] (
    [drvMemberClose] varchar(9) NOT NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(12) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_MTrailer
-----------

IF OBJECT_ID('U_ESUNLIFE_MTrailer') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_MTrailer] (
    [drvMember] varchar(9) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_New
-----------

IF OBJECT_ID('U_ESUNLIFE_New') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_New] (
    [NewEEID] varchar(255) NOT NULL,
    [NewDed] nvarchar(2000) NULL,
    [NewMem] datetime NULL
);

-----------
-- Create table U_ESUNLIFE_NewDedDate
-----------

IF OBJECT_ID('U_ESUNLIFE_NewDedDate') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_NewDedDate] (
    [NewDedEEID] varchar(255) NOT NULL,
    [NewDedDt] datetime NULL
);

-----------
-- Create table U_ESUNLIFE_NewDedDt
-----------

IF OBJECT_ID('U_ESUNLIFE_NewDedDt') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_NewDedDt] (
    [NewDedEEID] varchar(255) NOT NULL,
    [NewDedCode] varchar(255) NOT NULL,
    [NewDedDt] nvarchar(2000) NULL
);

-----------
-- Create table U_ESUNLIFE_NewDedStart
-----------

IF OBJECT_ID('U_ESUNLIFE_NewDedStart') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_NewDedStart] (
    [NewStartEEID] varchar(255) NOT NULL,
    [NewStartDt] nvarchar(2000) NULL
);

-----------
-- Create table U_ESUNLIFE_NewEmp
-----------

IF OBJECT_ID('U_ESUNLIFE_NewEmp') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_NewEmp] (
    [NewEmp] char(12) NULL,
    [NewEmpDt] datetime NULL
);

-----------
-- Create table U_ESUNLIFE_OverRideDate
-----------

IF OBJECT_ID('U_ESUNLIFE_OverRideDate') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_OverRideDate] (
    [EhcEEID] char(12) NOT NULL,
    [EhcCOID] char(5) NOT NULL,
    [OverrideDate] datetime NULL
);

-----------
-- Create table U_ESUNLIFE_Person
-----------

IF OBJECT_ID('U_ESUNLIFE_Person') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Person] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvPersonOpen] varchar(8000) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_PolNum
-----------

IF OBJECT_ID('U_ESUNLIFE_PolNum') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_PolNum] (
    [PEEID] char(12) NOT NULL,
    [PCOID] char(5) NOT NULL,
    [PolNum] varchar(6) NOT NULL
);

-----------
-- Create table U_ESUNLIFE_Salary
-----------

IF OBJECT_ID('U_ESUNLIFE_Salary') IS NULL
CREATE TABLE [dbo].[U_ESUNLIFE_Salary] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSalOpen] varchar(78) NOT NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLIFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco Beverage

Created By: Cyndi Diaz
Business Analyst: Emily Gaddy
Create Date: 04/15/2019
Service Request Number: SR-2018-00210462

Purpose: Sunlife XML Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNLIFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNLIFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNLIFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUNLIFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNLIFE' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLIFE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLIFE', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLIFE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLIFE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLIFE', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNLIFE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUNLIFE', @AllObjects = 'Y'
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
    SELECT @FormatCode = 'ESUNLIFE';

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
    DELETE FROM dbo.U_ESUNLIFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNLIFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESUNLIFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_AuditFields;
    CREATE TABLE dbo.U_ESUNLIFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    insert into dbo.U_ESUNLIFE_AuditFields values ('empcomp','eecemplstatus');
    insert into dbo.U_ESUNLIFE_AuditFields values ('empcomp','EecDedGroupCode');
    insert into dbo.U_ESUNLIFE_AuditFields values ('empcomp','EecAnnSalary');
    insert into dbo.U_ESUNLIFE_AuditFields values ('empcomp','EecDateOfOriginalHire');
    insert into dbo.U_ESUNLIFE_AuditFields values ('empded','EedBenStopDate');
    insert into dbo.U_ESUNLIFE_AuditFields values ('empded','EedDedCode');
    insert into dbo.U_ESUNLIFE_AuditFields values ('empded','EedBenOption');
    insert into dbo.U_ESUNLIFE_AuditFields values ('emppers','EepAddressLine1');
    insert into dbo.U_ESUNLIFE_AuditFields values ('emppers','EepAddressLine2');
    insert into dbo.U_ESUNLIFE_AuditFields values ('emppers','EepAddressCity');
    insert into dbo.U_ESUNLIFE_AuditFields values ('emppers','EepAddressState');
    insert into dbo.U_ESUNLIFE_AuditFields values ('emppers','EepAddressZipCode');
    insert into dbo.U_ESUNLIFE_AuditFields values ('contacts','ConNameFirst');
    insert into dbo.U_ESUNLIFE_AuditFields values ('depbplan','DbnDedCode');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESUNLIFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Audit;
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
    INTO dbo.U_ESUNLIFE_Audit                --select * from U_ESUNLIFE_Audit where audfieldname = 'eeddedcode' and audnewvalue = 'CDENT'
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESUNLIFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(AudNewValue, '') <> '';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESUNLIFE_Audit ON dbo.U_ESUNLIFE_Audit (audEEID,audKey2);

     Delete from dbo.U_ESUNLIFE_EEList
     where exists (Select 1 from dbo.EmpComp where EecEEID = xEEID and EecCoID = xCOID and EecEmplStatus IN ('T','R')) 
     AND Not exists (Select 1 from dbo.U_ESUNLIFE_Audit where audeeid = xeeid and audKey2 =xcoid and audfieldname = 'eecemplstatus' and isnull(audnewvalue, '') IN ('T','R'));

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','CCDEN,CPDEN,CDENT,CSDEN,CVDEN,CDENQ,CHLHQ,CHLTH,CCHLH,CPHLH,CHLHQ,CHLTH,CSHLH,CVHLH,CCLIF,CPLIF,CSLIF,CVLIF,CLIFE,CLTD,CCLTD,CPLTD,CSLTD,CVLTD,CELTD,CCDLI,CPDLI,CSDLI,CVDLI,CDLIF');
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

    --mark waived deductions as valid for export and exists in audit - U_ESUNLIFE_Audit
    UPDATE dbo.U_DSI_BDM_EmpDeductions SET EedValidForExport = 'Y' 
    FROM dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)
    JOIN dbo.U_ESUNLIFE_Audit WITH (NOLOCK)
        ON AudEEID = EedEEID
        AND AudKey2 = EedCOID
        AND AudKey3 = EedDedCode
        AND AudTableName = 'EmpDed'
        WHERE EedFormatCode = 'ESUNLIFE' AND EedDedRowStatus = 'Deduction start date = end date'

    --mark termed deduction as not valid for export when an active deduction in the same ded type exists
    UPDATE T SET T.EedValidForExport = 'N'
    FROM dbo.U_DSI_BDM_EmpDeductions T WITH (NOLOCK)
    WHERE T.EedBenStopdate IS NOT NULL
    AND T.EedFormatCode = 'ESUNLIFE' AND T.EedValidForExport = 'Y'
    AND EXISTS(SELECT * FROM dbo.U_DSI_BDM_EmpDeductions A WITH (NOLOCK)
    WHERE A.EedEEID = T.EedEEID AND A.EedBenStopdate IS NULL AND A.DedDedType = T.DedDedType
    AND A.EedFormatCode = 'ESUNLIFE' AND A.EedValidForExport = 'Y')

    --Identify employees whom have stopped all of their deds

    If object_id('EmpsWithAllStops') is not null
      Drop table dbo.EmpsWithAllStops

    --Select employees whom lack at least one active benefit deduction
    Select distinct xEEID EEID,xCOID COID


    INTO dbo.EmpsWithAllStops

    From dbo.u_ESUNLIFE_EELIST
    Left Join
    (Select Eedeeid EEID,Eedcoid COID,count(*) as Total 
    From U_dsi_bdm_EmpDeductions 
    Where (EedBenStopDate is null or EedBenStopDate > @EndDate)
    and eedformatcode = @FormatCode and eedvalidforexport = 'Y'
    Group by Eedeeid,Eedcoid
    ) as IsOneActive on xEEID = IsOneActive.EEID and xCOID = IsOneActive.COID
    Where isnull(Total,0)=0


    --Identify dependents whom have stopped all of their deds

    If object_id('DepsWithAllStops') is not null
      Drop table dbo.DepsWithAllStops
    Select distinct ConSystemID


    INTO dbo.DepsWithAllStops                --select * from DepsWithAllStops where CONSYSTEMID IN ('CE80GB1AT0K0','CE80GB1AU0K0')

    From dbo.Contacts WITH (NOLOCK)
    Left Join
    (Select DbnDepRecID DepID,count(*) as Total 
    From U_dsi_bdm_DepDeductions 
    Where (DbnBenStopDate is null or DbnBenStopDate > @EndDate)
    and Dbnformatcode = 'ESUNLIFE' and Dbnvalidforexport = 'Y'
    Group by DbnDepRecID
    ) as IsOneActive on ConSystemID = IsOneActive.DepID
    Where isnull(Total,0)=0


    --get override date
    IF OBJECT_ID('U_ESUNLIFE_OverRideDate') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_OverRideDate;
    SELECT EhcEEID,EhcCOID,MAX(OverrideDate) OverrideDate
    INTO dbo.U_ESUNLIFE_OverRideDate                --SELECT * FROM U_ESUNLIFE_OverRideDate
    FROM dbo.EmpHComp WITH (NOLOCK)
    JOIN dbo.DedGroupChangeDateOverride WITH (NOLOCK)
        ON SystemID = EhcSystemID
    GROUP BY EhcEEID,EhcCOID

    --determine if this is the first time the employee has been sent on the file
    IF OBJECT_ID('U_ESUNLIFE_NewEmp','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_NewEmp;
    SELECT xEEID NewEmp,dbo.dsi_fnGetMinMaxDates ('MAX',MAX(NE.AudDateTime),MAX(ND.AudDateTime)) NewEmpDt
    INTO dbo.U_ESUNLIFE_NewEmp                        --select * from U_ESUNLIFE_NewEmp WHERE NEWEEID = 'D7YIFY000020'
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    LEFT JOIN dbo.VW_AuditData NE WITH (NOLOCK)
        ON xEEID = NE.AudKey1Value
        AND NE.AudFieldname = 'EecEmplStatus' 
        AND NE.AudTableName = 'EmpComp' 
        AND NE.AudOldValue IS NULL 
        AND ISNULL(NE.AudNewValue, '') = 'A' 
        AND NE.AudDateTime BETWEEN @StartDate AND @EndDate
    LEFT JOIN dbo.VW_AuditData ND WITH (NOLOCK)
        ON xEEID = ND.AudKey1Value
        AND ND.AudFieldname = 'EedDedCode' 
        AND ND.AudTableName = 'EmpDed' 
        AND CONVERT(VARCHAR(10),ND.AudDateTime, 101) BETWEEN @StartDate AND @EndDate
        AND ND.AudNewValue IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')
    GROUP BY xEEID
    ;

    --determine if a new deduction code is added by deduction
    IF OBJECT_ID('U_ESUNLIFE_New','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_New;
    SELECT AudKey1Value NewEEID,AudNewValue NewDed,MAX(AudDateTime) NewMem
    INTO dbo.U_ESUNLIFE_New                        --select * from U_ESUNLIFE_New WHERE NEWEEID = 'D7YIFY000020'
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.VW_AuditData WITH (NOLOCK)
        ON xEEID = AudKey1Value
    WHERE AudFieldname = 'EedDedCode' AND AudTableName = 'EmpDed' 
    AND AudDateTime BETWEEN @StartDate AND @EndDate
    AND AudNewValue IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')
    GROUP BY AudKey1Value,AudNewValue
    ;

    --determine if a deduction code got new dates - this is how they process rehires
    IF OBJECT_ID('U_ESUNLIFE_NewDedDt','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_NewDedDt;
    SELECT DISTINCT M.AudKey1Value NewDedEEID, M.AudKey3Value NewDedCode, MAX(M.AudNewValue) NewDedDt
    INTO dbo.U_ESUNLIFE_NewDedDt                        --select * from U_ESUNLIFE_NewDedDt WHERE NewDedEEID = 'CDWDMR0160K0'
    FROM dbo.VW_AuditData M WITH (NOLOCK)
    WHERE M.AudFieldname = 'EedStartDate' AND M.AudTableName = 'EmpDed' AND AudDateTime BETWEEN @StartDate AND @EndDate
    AND M.AudKey3Value IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')
    AND M.AudDatetime = (SELECT MAX(AudDatetime) FROM dbo.VW_AuditData WITH (NOLOCK) WHERE AudFieldName = 'EedStartDate' AND AudTableName = 'EmpDed' and AudKey1Value = M.AudKey1Value
                AND AudKey3Value = M.AudKey3Value AND AudDateTime BETWEEN @StartDate AND @EndDate)
    GROUP BY M.AudKey1Value,M.AudNewValue,M.AudKey3Value
    ;

    --get max ded date when benefits are restarted
    IF OBJECT_ID('U_ESUNLIFE_NewDedStart','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_NewDedStart;
    SELECT DISTINCT AudKey1Value NewStartEEID, MAX(AudNewValue) NewStartDt
    INTO dbo.U_ESUNLIFE_NewDedStart                        --select * from U_ESUNLIFE_NewDedDt WHERE NewDedEEID = 'CDWDMR0160K0'
    FROM dbo.VW_AuditData WITH (NOLOCK)
    WHERE AudFieldname = 'EedStartDate' AND AudTableName = 'EmpDed' AND AudDateTime BETWEEN @StartDate AND @EndDate 
    AND AudKey3Value IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')
    GROUP BY AudKey1Value
    ;
/*
    --get policy number
    IF OBJECT_ID('U_ESUNLIFE_PolNum','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_PolNum;
    SELECT EedEEID PEEID,EedCOID PCOID
    ,PolNum = '102716'
    INTO dbo.U_ESUNLIFE_PolNum                                    --SELECT * FROM U_ESUNLIFE_PolNum WHERE PEEID = 'CDWDLB00J0K0'
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)                    --SP_GETEEID '603066'
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT * FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
    GROUP BY EedEEID,EedCOID;
    ;
*/

    --only send benefit effective and lock in dates once when deduction is first added
    IF OBJECT_ID('U_ESUNLIFE_BenEffDt','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_BenEffDt;
    SELECT AudKey1Value BenEEID
    INTO dbo.U_ESUNLIFE_BenEffDt                        --select * from U_ESUNLIFE_BenEffDt
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.VW_AuditData WITH (NOLOCK)
        ON xEEID = AudKey1Value
    WHERE AudFieldname = 'EedDedCode' AND AudTableName = 'EmpDed' AND AudOldValue IS NULL AND AudNewValue IS NOT NULL AND AudDateTime BETWEEN @StartDate AND @EndDate 
    AND AudNewValue IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF')
    GROUP BY AudKey1Value
    ;

    ---------------------------------
    -- DETAIL RECORD - U_ESUNLIFE_Member
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Member','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Member;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvMemberOpen = '<Member ' + 
        'PolicyNum="' + '102716' + '" ' +
        'LocationNum="' + ISNULL(CASE WHEN EepAddressState <> 'QC' AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'001'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'001'                                                                                                                                                                                    
                        WHEN    EecEmpNo = '000208681'AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'001'                                                                                                                                                                                    
                        WHEN    EecLocation = 'VIS' AND EecDedGroupCode IN ('CONTR','NONE') THEN'001'                                                                                                                                                                                    
                        WHEN    EecLocation = 'VIS' AND EecDedGroupCode IN ('VISC','NONE') THEN'002'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PCSAL','NONE') THEN'003'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PCSAL','NONE') THEN'003'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('CONPC','NONE') THEN'003'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PTCL','NONE') THEN'004'                                                                                                                                                                                    
                        WHEN    EepAddressState <> 'QC' AND EecLocation = 'CAL' AND EecDedGroupCode IN ('SAL','NONE') THEN'005'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'CAL' AND EecDedGroupCode IN ('SAL','NONE') THEN'005'                                                                                                                                                                                    
                        WHEN    EecLocation = 'CAL' AND EecDedGroupCode IN ('CONTR','NONE') THEN'005'                                                                                                                                                                                    
                        WHEN    EecLocation = 'CAL' AND EecDedGroupCode IN ('CALG','NONE') THEN'006'
                        WHEN    EecLocation = 'SUR' AND EecDedGroupCode IN ('SURR','NONE') THEN '008'                                                                                                                                                                                        
                        WHEN    EepAddressState <> 'QC'AND EecLocation = 'SUR' THEN '007'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'SUR' AND EecDedGroupCode IN ('SALS','NONE') THEN '007'                                                                                                                                                                                    
                        WHEN    EecLocation = 'SUR' AND EecDedGroupCode IN ('CONTR','NONE') THEN '007'                                                                                                                                                                                                                                                                                                                                                                    
                    END, '') + '" ' + 
        'ClassNum="' + ISNULL(CASE WHEN EepAddressState <> 'QC' AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'1'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'2'                                                                                                                                                                                    
                        WHEN    EecEmpNo = '000208681'AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'4'                                                                                                                                                                                    
                        WHEN    EecLocation = 'VIS' AND EecDedGroupCode IN ('CONTR','NONE') THEN'3'                                                                                                                                                                                    
                        WHEN    EecLocation = 'VIS' AND EecDedGroupCode IN ('VISC','NONE') THEN'5'
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PCSAL','NONE') THEN'18'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PCSAL','NONE') AND EecSalaryOrHourly = 'H' THEN '2'                                                                                                                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('CONPC','NONE') THEN'3'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PTCL','NONE') THEN'6'                                                                                                                                                                                    
                        WHEN    EepAddressState <> 'QC' AND EecLocation = 'CAL' AND EecDedGroupCode IN ('SAL','NONE') THEN'1'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'CAL' AND EecDedGroupCode IN ('SAL','NONE') THEN'2'                                                                                                                                                                                    
                        WHEN    EecLocation = 'CAL' AND EecDedGroupCode IN ('CONTR','NONE') THEN'3'                                                                                                                                                                                    
                        WHEN    EecLocation = 'CAL' AND EecDedGroupCode IN ('CALG','NONE') THEN'7'
                        WHEN    EecLocation = 'SUR' AND EecDedGroupCode IN ('SURR','NONE') THEN'8'                                                                                                                                                                                    
                        WHEN    EepAddressState <> 'QC'AND EecLocation = 'SUR' THEN'1'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'SUR' AND EecDedGroupCode IN ('SALS','NONE') THEN'2'                                                                                                                                                                                    
                        WHEN    EecLocation = 'SUR' AND EecDedGroupCode IN ('CONTR','NONE') THEN'3'                                                                                                                                                                                                                                                                                                                                                                    
                    END, '') + '" ' + 
        'PlanNum="' + ISNULL(CASE WHEN EepAddressState <> 'QC' AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'1'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'2'                                                                                                                                                                                    
                        WHEN    EecEmpNo = '000208681'AND EecLocation = 'VIS' AND EecDedGroupCode IN ('SAL','NONE') THEN'4'                                                                                                                                                                                    
                        WHEN    EecLocation = 'VIS' AND EecDedGroupCode IN ('CONTR','NONE') THEN'3'                                                                                                                                                                                    
                        WHEN    EecLocation = 'VIS' AND EecDedGroupCode IN ('VISC','NONE') THEN'5'    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PCSAL','NONE') THEN'18'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PCSAL','NONE') AND EecSalaryOrHourly = 'H' THEN '2'                                                                                                                                                                                
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('CONPC','NONE') THEN'3'                                                                                                                                                                                    
                        WHEN    EecLocation = 'PTC' AND EecDedGroupCode IN ('PTCL','NONE') THEN'6'                                                                                                                                                                                    
                        WHEN    EepAddressState <> 'QC' AND EecLocation = 'CAL' AND EecDedGroupCode IN ('SAL','NONE') THEN'1'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'CAL' AND EecDedGroupCode IN ('SAL','NONE') THEN'2'                                                                                                                                                                                    
                        WHEN    EecLocation = 'CAL' AND EecDedGroupCode IN ('CONTR','NONE') THEN'3'                                                                                                                                                                                    
                        WHEN    EecLocation = 'CAL' AND EecDedGroupCode IN ('CALG','NONE') THEN'7'
                        WHEN    EecLocation = 'SUR' AND EecDedGroupCode IN ('SURR','NONE') THEN'8'                                                                                                                                                                                    
                        WHEN    EepAddressState <> 'QC'AND EecLocation = 'SUR' THEN'1'                                                                                                                                                                                    
                        WHEN    EepAddressState = 'QC' AND EecLocation = 'SUR' AND EecDedGroupCode IN ('SALS','NONE') THEN'2'                                                                                                                                                                                    
                        WHEN    EecLocation = 'SUR' AND EecDedGroupCode IN ('CONTR','NONE') THEN'3'                                                                                                                                                                                                                                                                                                                                                                        
                    END, '') + '" ' + 
        'CertificateNum="' + ISNULL(CONVERT(VARCHAR(20),CAST(EecEmpNo AS INT)), '') + '" ' +
        '' +
        ISNULL(CASE WHEN NewEmpDt BETWEEN @StartDate AND @EndDate THEN 'EmploymentDt="' +  LEFT(CONVERT(VARCHAR(8),EecDateOfOriginalHire, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfOriginalHire, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfOriginalHire, 112), 7, 2) END
        + '" ' , '') + '' +
        'WorkResidenceCd="' + ISNULL(CASE WHEN SubString(EecStateSui,1,2) = 'NL' then '1'
                            WHEN SubString(EecStateSui,1,2) = 'PE' then '2'
                            WHEN SubString(EecStateSui,1,2) = 'NB' then '3'
                            WHEN SubString(EecStateSui,1,2) = 'NS' then '4'
                            WHEN SubString(EecStateSui,1,2) = 'ON' then '5'
                            WHEN SubString(EecStateSui,1,2) = 'QC' then '6'
                            WHEN SubString(EecStateSui,1,2) = 'MB' then '7'
                            WHEN SubString(EecStateSui,1,2) = 'SK' then '8'
                            WHEN SubString(EecStateSui,1,2) = 'AB' then '9'
                            WHEN SubString(EecStateSui,1,2) = 'BC' then '10'
                            WHEN SubString(EecStateSui,1,2) = 'NT' then '11'
                            WHEN SubString(EecStateSui,1,2) = 'YT' then '12'
                            WHEN SubString(EecStateSui,1,2) = 'NU' then '13'
                        END, '') + '" ' +
        'StatusCd="' + CASE WHEN (EecEmplStatus IN ('T','R') OR ISNULL(EEID, '') <> '') THEN '3' Else '1' END + '" ' +
        ISNULL(CASE WHEN EecEmplStatus = 'T' THEN 'TermDt="' + LEFT(CONVERT(VARCHAR(8),EecDateOfTermination  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfTermination  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfTermination  , 112), 7, 2)
                                    WHEN EecEmplStatus = 'R' THEN 'TermDt="' + LEFT(CONVERT(VARCHAR(8),EshStatusStartDate    , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EshStatusStartDate    , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EshStatusStartDate    , 112), 7, 2)  --Released/Laid Off
                                    WHEN ISNULL(EEID, '') <> '' then 'TermDt="' + LEFT(CONVERT(VARCHAR(8),MAX(EedBenStopDate)  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(EedBenStopDate)  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(EedBenStopDate)  , 112), 7, 2)
                            END + '" ', '') +
        ISNULL(CASE WHEN EecEmplStatus IN ('T','R') AND (EecTermReason = '203' OR EdhChangeReason = '210') THEN 'TermReasonCd="' + '6' + '" '
                    WHEN (EecEmplStatus IN ('T','R') OR (EecDedGroupCode = 'NONE')) THEN 'TermReasonCd="' + '2' + '" ' END, '') +
        'UpdateFlag="' + ISNULL(CASE WHEN NewEmpDt BETWEEN @StartDate AND @EndDate THEN 'False' ELSE 'True' END, '') + '" ' +
        'ApplyDate="' + ISNULL(CASE WHEN EXISTS(SELECT * FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudEEID = xEEID AND AudFieldName = 'EecEmplStatus' AND AudOldValue IS NULL AND AudNewValue = 'A' AND AudEEID = xEEID) THEN 
                                    LEFT(CONVERT(VARCHAR(8),EecDateOfLastHire, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfLastHire, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfLastHire, 112), 7, 2)  --Add
                                        WHEN EecEmplStatus = 'T' THEN LEFT(CONVERT(VARCHAR(8),EecDateOfTermination   , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfTermination   , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfTermination   , 112), 7, 2)  --Term
                                        WHEN EecEmplStatus = 'R' THEN LEFT(CONVERT(VARCHAR(8),EshStatusStartDate    , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EshStatusStartDate    , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EshStatusStartDate    , 112), 7, 2)  --Released/Laid Off
                                        WHEN EXISTS(SELECT * FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudEEID = xEEID AND AudFieldName = 'EecEmplStatus' AND ISNULL(AudOldValue, '') IN ('T','R') AND ISNULL(AudNewValue, '') = 'A') THEN 
                                                LEFT(CONVERT(VARCHAR(8),EecDateOfLastHire, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfLastHire, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EecDateOfLastHire, 112), 7, 2)  --ReHire
                                        WHEN EXISTS(SELECT * FROM dbo.U_ESUNLIFE_NewDedStart WITH (NOLOCK) WHERE NewStartEEID = xEEID) THEN (SELECT LEFT(CONVERT(VARCHAR(8),MAX(EedBenStartDate)  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(EedBenStartDate)  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(EedBenStartDate)  , 112), 7, 2) FROM dbo.EmpDed WHERE EedEEID = xEEID) --restart deds
                                        WHEN NewMem BETWEEN @StartDate AND @EndDate THEN 
                                                (SELECT LEFT(CONVERT(VARCHAR(8),MAX(EedBenStartDate), 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(EedBenStartDate), 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(EedBenStartDate), 112), 7, 2) FROM dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK) WHERE EedEEID = xEEID AND EedFormatCode = 'ESUNLIFE' AND EedValidForExport = 'Y')
                                        WHEN EXISTS(SELECT * FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudEEID = xEEID AND AudFieldName = 'EedBenOption' AND ISNULL(AudOldValue, '') <> ISNULL(AudNewValue, '') AND AudOldValue IS NOT NULL) THEN  --Tier Change
                                                (SELECT CASE WHEN MAX(DbnBenStopDate) IS NOT NULL THEN LEFT(CONVERT(VARCHAR(8),MAX(DbnBenStopDate), 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(DbnBenStopDate), 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(DbnBenStopDate), 112), 7, 2) 
                                                             ELSE LEFT(CONVERT(VARCHAR(8),MAX(DbnBenStartDate), 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(DbnBenStartDate), 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),MAX(DbnBenStartDate), 112), 7, 2)END
                                                            FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) JOIN dbo.Contacts WITH (NOLOCK) ON ConEEID = AudEEID JOIN dbo.DepBPlan WITH (NOLOCK) ON DbnDepRecID = ConSystemID AND AudKey3 = DbnDedCode 
                                                            WHERE AudEEID = xEEID AND AudFieldName = 'EedBenOption' AND ISNULL(AudOldValue, '') <> ISNULL(AudNewValue, ''))
                                        WHEN ISNULL(OverrideDate, '') <> '' THEN LEFT(CONVERT(VARCHAR(8),OverrideDate, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),OverrideDate, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),OverrideDate, 112), 7, 2) --Coverage Changes
                                        WHEN AudFieldName = 'EecDedGroupCode' AND ISNULL(AudNewValue, '') IN ('CONPC','CALG','SURR','VISC','PTCL','SAL','CONTR','RNUN','SALS','PCSAL') THEN 
                                                LEFT(CONVERT(VARCHAR(8),AudDateTime  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),AudDateTime  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),AudDateTime  , 112), 7, 2)  --Deduction Group Changes
                                        WHEN EjhIsRateChange = 'Y' THEN LEFT(CONVERT(VARCHAR(8),EjhJobEffDate   , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EjhJobEffDate   , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EjhJobEffDate   , 112), 7, 2)  --Salary Changes
                                        ELSE LEFT(CONVERT(VARCHAR(8),GETDATE(), 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),GETDATE(), 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),GETDATE(), 112), 7, 2)
                                END, '') + '" ' +
        'TransferFlg="' + 'Implicit' + '"' +  --ISNULL(CASE WHEN AudEEID IS NOT NULL THEN 'True' Else 'False'  END, '') + '" ' +
        --'ReinstatementFlg="' + ISNULL(CASE WHEN AudEEID IS NOT NULL THEN 
                                                    --CASE WHEN ((AudFieldName = 'EecDedGroupCode')
                                                        --OR (AudFieldName = 'EecEmplStatus' AND AudOldValue IN ('T','R') AND AudNewValue = 'A')
                                                        --OR (AudFieldName = 'EedBenStopDate' AND AudOldValue IS NOT NULL AND AudNewValue IS NULL)) THEN 'True' Else 'False'
                                                    --END
                                                 --ELSE 'False'
                                                 --END, '') + '"' +
        '>'
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
    INTO dbo.U_ESUNLIFE_Member            --SELECT DRVEEID,COUNT(*) FROM U_ESUNLIFE_Member GROUP BY DRVEEID HAVING COUNT(*) > 1
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (EecEmplStatus NOT IN ('T','R') OR (EecEmplStatus IN ('T','R') AND ISNULL(EecTermReason, '') NOT IN ('TRI','TRO')
                AND EXISTS(SELECT * FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudFieldName = 'EecEmplStatus' AND ISNULL(AudNewValue, '') IN ('T','R'))))            --SELECT * FROM U_ESUNLIFE_AuditFields
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT DEDLONGDESC FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
    --JOIN dbo.U_ESUNLIFE_PolNum WITH (NOLOCK)
        --ON PEEID = xEEID
        --AND PCOID = xCOID
    LEFT JOIN dbo.EmpsWithAllStops WITH (NOLOCK)
        ON EEID = xEEID
        AND COID = xCOID
    LEFT JOIN dbo.BenChRsn WITH (NOLOCK)
        ON BchCode = EecTermReason
    LEFT JOIN dbo.U_ESUNLIFE_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName = 'EecDedGroupCode'
        AND AudDateTime = (SELECT MAX(AudDateTime) FROM dbo.U_ESUNLIFE_Audit WITH (NOLOCK) WHERE AudEEID = xEEID AND AudFieldName = 'EecDedGroupCode')
    LEFT JOIN dbo.U_ESUNLIFE_OverRideDate WITH (NOLOCK)
        ON EhcEEID = xEEID
        AND EhcCOID = xCOID
    LEFT JOIN dbo.U_ESUNLIFE_New WITH (NOLOCK)
        ON NewEEID = xEEID
        AND NewDed = EedDedCode
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID)
    LEFT JOIN dbo.EmpHDed WITH (NOLOCK)
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDateTimeCreated = (SELECT MAX(EdhDateTimeCreated) FROM dbo.EmpHDed WITH (NOLOCK) WHERE EdhEEID = xEEID AND EdhCOID = xCOID)
    LEFT JOIN dbo.EMPHSTAT WITH (NOLOCK)
        ON EshEEID = xEEID
        AND EshIsCurrent = 'Y' 
        AND EshEmplStatus = 'R'
    LEFT JOIN dbo.U_ESUNLIFE_NewEmp WITH (NOLOCK)
        ON NewEmp = xEEID
    WHERE EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                    AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND EecEmpNo <> '208681'
    GROUP BY xEEID,xCOID,EecLocation,EecEmpNo,EecDateOfOriginalHire,EecStateSui,EecEmplStatus,EecSalaryOrHourly,EecTermReason,EdhChangeReason,EecDateOfTermination,EshStatusStartDate,EEID,BchCode,EepAddressState,DedLongDesc,EecDedGroupCode,EecDateOfLastHire,OverrideDate,AudFieldName,AudOldValue,AudNewValue,AudDateTime,NewMem,EjhIsRateChange,EjhJobEffDate,AudEEID,EedDedCode,NewEmpDt
    ;
    
    ---------------------------------
    -- MEMBER CLOSE RECORD
    ---------------------------------
    IF OBJECT_ID('dbo.U_ESUNLIFE_MemberClose','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_MemberClose;            --SELECT * FROM U_ESUNLIFE_MemberClose
    SELECT DISTINCT
         drvMemberClose = '</Member>'
        ,drvInitialSort = drvInitialSort
        ,drvSubSort = 'ZZZZZZZZZZZZ'
    INTO dbo.U_ESUNLIFE_MemberClose
    FROM dbo.U_ESUNLIFE_Member WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESUNLIFE_Person
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Person','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Person;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPersonOpen = '<Person ' + 
        'FirstNm="' + REPLACE(REPLACE(ISNULL(EepNameFirst, ''), ')', ''), '(', '') + '" ' + 
        'MiddleInitialNm="' + LEFT(ISNULL(EepNameMiddle, ''),1) + '" ' + 
        'LastNm="' + ISNULL(EepNameLast, '') + '" ' + 
        'BirthDt="' + ISNULL(LEFT(CONVERT(VARCHAR(8),EepDateOfBirth  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EepDateOfBirth  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EepDateOfBirth  , 112), 7, 2), '') + '" ' + 
        'ResidenceCd="' + CASE WHEN EepAddressState = 'NL' then '1'
                                WHEN EepAddressState = 'PE' then '2'
                                WHEN EepAddressState = 'NB' then '3'
                                WHEN EepAddressState = 'NS' then '4'
                                WHEN EepAddressState = 'ON' then '5'
                                WHEN EepAddressState = 'QC' then '6'
                                WHEN EepAddressState = 'MB' then '7'
                                WHEN EepAddressState = 'SK' then '8'
                                WHEN EepAddressState = 'AB' then '9'
                                WHEN EepAddressState = 'BC' then '10'
                                WHEN EepAddressState = 'NT' then '11'
                                WHEN EepAddressState = 'YT' then '12'
                                WHEN EepAddressState = 'NU' then '13'
                            END
            + '" ' + 
        'GenderCd="' + ISNULL(CASE WHEN EepGender = 'M' then '1'
                            WHEN EepGender = 'F' then '2'
                        END, '')
            + '" ' + 
        'SmokerFlg="' + ISNULL(CASE WHEN EepIsSmoker = 'Y' then 'True' Else 'False' END, '') + '" ' + 
        'DepTypeCd="' +  ISNULL(CASE WHEN EXISTS(SELECT * FROM dbo.Contacts WITH (NOLOCK) JOIN dbo.DepBPlan WITH (NOLOCK) ON ConSystemId = DbnDepRecID AND ConEEID = xEEID
                                    AND DbnBenStartDate <= GETDATE() AND DbnBenStopDate IS NULL
                                    AND DbnDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
                                THEN '3' ELSE '2' END, '') + '" ' +    
        'LanguageCd="' + ISNULL(CASE WHEN EecLanguageCode = 'FR' Then '2' Else '1' END, '') + '"' + 
        '/>'
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
    INTO dbo.U_ESUNLIFE_Person
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND EecEmplStatus NOT IN ('T','R')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT DEDLONGDESC FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
    WHERE EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                    AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND EecEmpNo <> '208681'
    GROUP BY xEEID,xCOID,EepNameFirst,EepNameMiddle,EepNameLast,EepDateofBirth,EepAddressState,EepGender,EepIsSmoker,EecLanguageCode,EecEmpNo
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESUNLIFE_Salary
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Salary','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Salary;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvSalOpen = '<Salary ' + 
        'SalaryDescCd="' + '1' + '" ' + 
        'SalaryBasisCd="' + '1' + '" ' + 
        'SalaryAmt= "' + ISNULL(CONVERT(VARCHAR(20),EecAnnSalary), '') + '"' + 
        '/>'
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
    INTO dbo.U_ESUNLIFE_Salary                    --select * from U_ESUNLIFE_Salary
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND EecEmplStatus NOT IN ('T','R')
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT DEDLONGDESC FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
    WHERE EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                    AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND EecEmpNo <> '208681'
    ;

    ---------------------------------
    -- DETAIL RECORD - U_ESUNLIFE_Address
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Address','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Address;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvAddOpen = '<Address ' + 
        'AddressTypeCd="' + '1' + '" ' + 
        'AddressNm="' + ISNULL(REPLACE(REPLACE(EepNameFirst, ')', ''), '(', '') + ' ' + EepNameLast + ' ' + ISNULL(EepNameSuffix, ''), '') + '" ' + 
        'StreetAddressNm="' + ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1, CHAR(0233),'e'), CHAR(0220), 'U'), CHAR(0226), 'a'), CHAR(0224), 'a'), CHAR(0225), 'a'), CHAR(0231), 'c'), CHAR(0199), 'C'), CHAR(0234), 'e'), CHAR(0235), 'e'), CHAR(0232), 'e'), CHAR(0201), 'E'), CHAR(0239), 'i'), CHAR(0238), 'i'), CHAR(0244), 'o'), CHAR(0246), 'o'), CHAR(0251), 'u'), CHAR(0249), 'u'), CHAR(0228), 'u'), CHAR(0134), 'a'), ',', '')
        , '')+ '" ' + 
        'SuiteNm="' + ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine2, CHAR(0233),'e'), CHAR(0220), 'U'), CHAR(0226), 'a'), CHAR(0224), 'a'), CHAR(0225), 'a'), CHAR(0231), 'c'), CHAR(0199), 'C'), CHAR(0234), 'e'), CHAR(0235), 'e'), CHAR(0232), 'e'), CHAR(0201), 'E'), CHAR(0239), 'i'), CHAR(0238), 'i'), CHAR(0244), 'o'), CHAR(0246), 'o'), CHAR(0251), 'u'), CHAR(0249), 'u'), CHAR(0228), 'u'), CHAR(0134), 'a'), ',', '')
        , '') + '" ' + 
        'CityNm="' + ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressCity, CHAR(0233),'e'), CHAR(0220), 'U'), CHAR(0226), 'a'), CHAR(0224), 'a'), CHAR(0225), 'a'), CHAR(0231), 'c'), CHAR(0199), 'C'), CHAR(0234), 'e'), CHAR(0235), 'e'), CHAR(0232), 'e'), CHAR(0201), 'E'), CHAR(0239), 'i'), CHAR(0238), 'i'), CHAR(0244), 'o'), CHAR(0246), 'o'), CHAR(0251), 'u'), CHAR(0249), 'u'), CHAR(0228), 'u'), CHAR(0134), 'a'), ',', '')
         , '') + '" ' + 
        'StateOrProvCd="' + ISNULL(CASE WHEN EepAddressState = 'NL' then '1'
                                WHEN EepAddressState = 'PE' then '2'
                                WHEN EepAddressState = 'NB' then '3'
                                WHEN EepAddressState = 'NS' then '4'
                                WHEN EepAddressState = 'ON' then '5'
                                WHEN EepAddressState = 'QC' then '6'
                                WHEN EepAddressState = 'MB' then '7'
                                WHEN EepAddressState = 'SK' then '8'
                                WHEN EepAddressState = 'AB' then '9'
                                WHEN EepAddressState = 'BC' then '10'
                                WHEN EepAddressState = 'NT' then '11'
                                WHEN EepAddressState = 'YT' then '12'
                                WHEN EepAddressState = 'NU' then '13'
                            END, '') + '" ' + 
        'PostalNum="' + LEFT(ISNULL(EepAddressZipCode, ''), 3) + ' '+ RIGHT(RTRIM(ISNULL(EepAddressZipCode, '')), 3) + '" ' + 
        'CountryCd="' + ISNULL(CASE WHEN EepAddressCountry = 'CAN' then '1' 
                            WHEN EepAddressCountry = 'USA' then '2' 
                        END, '') + '" ' + 
        --'EffectiveDt="' + ISNULL(LEFT(CONVERT(VARCHAR(8),AudDateTime  , 112), 4) + '/' + SUBSTRING(CONVERT(VARCHAR(8),AudDateTime  , 112), 5, 2) + '/' + SUBSTRING(CONVERT(VARCHAR(8),AudDateTime  , 112), 7, 2), '') + '" ' + 
        ISNULL(CASE WHEN ISNULL(EepAddressEMail, '') <> '' AND ISNULL(RTRIM(LTRIM(EepAddressEMailAlternate)), '') <> '' THEN 
                                        'EmailAddressNm= "' + ISNULL(CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN RTRIM(LTRIM(EepAddressEMail)) 
                                          WHEN ISNULL(RTRIM(LTRIM(EepAddressEMailAlternate)), '') <> '' THEN RTRIM(LTRIM(EepAddressEMailAlternate)) END, '') END + '"', '') + 
        '/>'
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
    INTO dbo.U_ESUNLIFE_Address
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND EecEmplStatus NOT IN ('T','R')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)                --SELECT DEDLONGDESC FROM U_DSI_BDM_EmpDeductions
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_ESUNLIFE_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressCity','EepAddressState','EepAddressZipCode')
    WHERE EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                    AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND EecEmpNo <> '208681'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESUNLIFE_Dep
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Dep','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Dep;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvDepOpen = '<PersonLink ' + 
        'PersonLinkTypeCd="' + ISNULL(CASE WHEN ConRelationship = 'SPS' Then '2'
                              WHEN ConRelationship <> 'SPS' Then '3'
                         END, '') + '" ' + 
        'FirstNm="' + REPLACE(REPLACE(ISNULL(ConNameFirst, ''), ')', ''), '(', '') + '" ' + 
        'LastNm="' + ISNULL(ConNameLast, '') + '" ' + 
        'BirthDt="' + ISNULL(LEFT(CONVERT(VARCHAR(8),ConDateOfBirth  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),ConDateOfBirth  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),ConDateOfBirth  , 112), 7, 2), '') + '" ' + 
        'GenderCd="' + ISNULL(CASE WHEN ConGender = 'M' then '1'
                            WHEN ConGender = 'F' then '2'
                    END, '') + '" ' + 
        'SmokerFlg="' + ISNULL(CASE WHEN ConIsSmoker = 'Y' then 'True'
                            WHEN ConIsSmoker = 'N' then 'False'
                     END, '') + '" ' + 
        'InSchoolFlg="' + ISNULL(CASE WHEN ConIsStudent = 'Y' Then 'True' Else 'False' END, '') + '" ' + 
        'EffectiveDt="' + CASE WHEN ISNULL(DbnBenStartDate, '') <> '' then LEFT(CONVERT(VARCHAR(8),DbnBenStartDate   , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),DbnBenStartDate   , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),DbnBenStartDate   , 112), 7, 2)
                            ELSE ISNULL(LEFT(CONVERT(VARCHAR(8),EedBenStartDate   , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStartDate   , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStartDate   , 112), 7, 2), '')
                        END + '" ' + 
        ISNULL(CASE WHEN EXISTS(SELECT * FROM dbo.DepsWithAllStops WHERE ConSystemID = DbnDepRecID) THEN
                             'TermDt="' + ISNULL(LEFT(CONVERT(VARCHAR(8),DbnBenStopDate  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),DbnBenStopDate  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),DbnBenStopDate  , 112), 7, 2), '') END + '" ', '') + 
                    --WHEN ISNULL(EedBenStopDate, '') <> '' THEN 'TermDt="' + ISNULL(LEFT(CONVERT(VARCHAR(8),EedBenStopDate  , 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStopDate  , 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStopDate  , 112), 7, 2), '') END + '" ', '') + 
        'TermReasonCd="' + ISNULL(CASE WHEN ISNULL(DbnBenStopDate, '') <> '' OR ISNULL(EedBenStopDate, '') <> '' then 
                                CASE WHEN EdhChangeReason= '300' then '6' Else '2' END
                              ELSE '1' 
                         END, '') + '" ' + 
        'StatusCd="' + ISNULL(CASE WHEN DbnBenStatus IN ('T','R') then '3' Else '1' END, '') + CASE WHEN ISNULL(AudOldValue, '') <> ISNULL(AudNewValue, '') AND AudOldValue IS NOT NULL THEN '" ' ELSE '"' END + 
        ISNULL(CASE WHEN ISNULL(AudOldValue, '') <> ISNULL(AudNewValue, '') AND AudOldValue IS NOT NULL THEN 'OldFirstNm="' + ISNULL(AudOldValue, '') + '"' END, '') + 
        '/>'
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ConSystemID
    INTO dbo.U_ESUNLIFE_Dep                --select * from U_ESUNLIFE_Dep
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND EecEmplStatus NOT IN ('T','R')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConRelationship IN ('SPS','CHL','STC','CHD','LEG')
    AND ConIsDependent = 'Y'
    JOIN dbo.U_DSI_BDM_DepDeductions WITH (NOLOCK)
        ON DbnDepRecID = ConSystemID
        AND DbnFormatCode = 'ESUNLIFE'
        AND DbnValidForExport = 'Y'
    AND DbnBenStartDate = (SELECT MAX(DbnBenStartDate) FROM dbo.U_DSI_BDM_DepDeductions WITH (NOLOCK) WHERE DbnDepRecID = ConSystemID AND DbnFormatCode = 'ESUNLIFE' AND DbnValidForExport = 'Y')
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
        AND EedDedCode = DbnDedCode
    LEFT JOIN dbo.EmpHDed WITH (NOLOCK)
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDateTimeCreated = (SELECT MAX(EdhDateTimeCreated) FROM dbo.EmpHDed WITH (NOLOCK) WHERE EdhEEID = xEEID AND EdhCOID = xCOID)
    LEFT JOIN dbo.U_ESUNLIFE_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName = 'ConNameFirst'
        AND AudNewValue = ConNameFirst
    WHERE EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                    AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND EecEmpNo <> '208681'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESUNLIFE_Benefit
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Benefit','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Benefit;                --SELECT * FROM U_ESUNLIFE_Benefit
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvBeneOpen = '<Benefits ' + 
        'BenefitType="' + ISNULL(CASE WHEN EedDedCode = 'CLIFE' AND EepAddressState <> 'QC'THEN '101'
                                                WHEN EedDedCode = 'CDLIF' AND EepAddressState <> 'QC'THEN '103'
                                                WHEN EedDedCode = 'CLTD' AND EepAddressState <> 'QC'THEN '411'
                                                WHEN EedDedCode = 'CDENT' AND EepAddressState <> 'QC'THEN '502'
                                                WHEN EedDedCode = 'CHLHQ' AND EepAddressState <> 'QC'THEN '512'
                                                WHEN EedDedCode = 'CLIFE' AND EepAddressState = 'QC'THEN '101'
                                                WHEN EedDedCode = 'CDLIF' AND EepAddressState = 'QC'THEN '103'
                                                WHEN EedDedCode = 'CLTD' AND EepAddressState = 'QC'THEN '411'
                                                WHEN EedDedCode = 'CDENQ' AND EepAddressState = 'QC'THEN '502'
                                                WHEN EedDedCode = 'CHLHQ' AND EepAddressState = 'QC'THEN '512'
                                                WHEN EedDedCode = 'CHLTH' AND EepAddressState = 'QC'THEN '512'
                                                WHEN EedDedCode = 'CLIFE' THEN '101'
                                                WHEN EedDedCode = 'CDLIF' THEN '103'
                                                WHEN EedDedCode = 'CLTD' THEN '411'
                                                WHEN EedDedCode = 'CDENT' THEN '502'
                                                WHEN EedDedCode = 'CHLHQ' THEN '512'
                                                WHEN EedDedCode = 'CHLTH' THEN '512'
                                                WHEN EedDedCode = 'CDENT' THEN '502'
                                                WHEN EedDedCode = 'CHLHQ' THEN '512'
                                                WHEN EedDedCode = 'CLIFE' THEN '101'
                                                WHEN EedDedCode = 'CDLIF' THEN '103'
                                                WHEN EedDedCode = 'CELTD' THEN '411'
                                                WHEN EedDedCode = 'CDENT' THEN '502'
                                                WHEN EedDedCode = 'CHLHQ' THEN '512'
                                                WHEN EedDedCode = 'CVLIF' THEN '101'
                                                WHEN EedDedCode = 'CVDLI' THEN '103'
                                                WHEN EedDedCode = 'CVLTD' THEN '411'
                                                WHEN EedDedCode = 'CVDEN' THEN '502'
                                                WHEN EedDedCode = 'CVHLH' THEN '512'
                                                WHEN EedDedCode = 'CPLIF' THEN '101'
                                                WHEN EedDedCode = 'CPDLI' THEN '103'
                                                WHEN EedDedCode = 'CPLTD' THEN '411'
                                                WHEN EedDedCode = 'CPDEN' THEN '502'
                                                WHEN EedDedCode = 'CPHLH' THEN '512'
                                                WHEN EedDedCode = 'CCLIF' THEN '101'
                                                WHEN EedDedCode = 'CCDLI' THEN '103'
                                                WHEN EedDedCode = 'CCLTD' THEN '411'
                                                WHEN EedDedCode = 'CCDEN' THEN '502'
                                                WHEN EedDedCode = 'CCHLH' THEN '512'
                                                WHEN EedDedCode = 'CSLIF' THEN '101'
                                                WHEN EedDedCode = 'CSDLI' THEN '103'
                                                WHEN EedDedCode = 'CSLTD' THEN '411'
                                                WHEN EedDedCode = 'CSDEN' THEN '502'
                                                WHEN EedDedCode = 'CSHLH' THEN '512'
                                            END, '') + '" ' + 
        'FlexCodeNm="' + 'A'  + '" ' + 
        ISNULL(CASE WHEN EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CCHLH','CPHLH','CHLTH','CSHLH','CVHLH','CDLIF','CVDLI','CPDLI','CCDLI','CSDLI') THEN 'DepTypeCd="' + 
                                    CASE WHEN EedDedCode IN ('CDLIF','CVDLI','CPDLI','CCDLI','CSDLI') THEN '3' 
                                        WHEN ISNULL(EedBenOption, '') = 'SINGLE' THEN '2' 
                                        WHEN ISNULL(EedBenOption, '') = 'FAMILY' THEN '3'
                                    END
                        END + '" ', '') + 
        ISNULL(CASE WHEN (NewDedDt BETWEEN @StartDate AND @EndDate AND NewDed = EedDedCode OR BenEEID IS NOT NULL) THEN 'EffectiveDt="' +  LEFT(CONVERT(VARCHAR(8),EedBenStartDate, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStartDate, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStartDate, 112), 7, 2) END + '" ', '') + 
        ISNULL(CASE WHEN (NewDedDt BETWEEN @StartDate AND @EndDate AND NewDed = EedDedCode OR BenEEID IS NOT NULL) THEN 'LockInDt="' +  LEFT(CONVERT(VARCHAR(8),EedBenStartDate, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStartDate, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStartDate, 112), 7, 2) END + '" ', '') + 
        'StatusCd="' + ISNULL(CASE WHEN EedBenStopDate IS NOT NULL then '3'
                                            WHEN EedBenStopDate IS NULL then '1'
                                    END, '') + '" ' + 
        ISNULL(CASE WHEN EedBenStatus IN ('T','R') THEN 'TermReasonCd="' + '2' + '" ' END, '') + 
        ISNULL(CASE WHEN ISNULL(EedBenStopDate, '') <> '' THEN 'TermDt= "' + ISNULL(LEFT(CONVERT(VARCHAR(8),EedBenStopDate, 112), 4) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStopDate, 112), 5, 2) + '-' + SUBSTRING(CONVERT(VARCHAR(8),EedBenStopDate, 112), 7, 2), '') + '"' END, '')  + 
        '/>'
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
    INTO dbo.U_ESUNLIFE_Benefit                    --select * from U_ESUNLIFE_Benefit
    FROM dbo.U_ESUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND EecEmplStatus NOT IN ('T','R')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_DSI_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedFormatCode = 'ESUNLIFE'
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_ESUNLIFE_BenEffDt WITH (NOLOCK)
        ON BenEEID = xEEID
    LEFT JOIN dbo.U_ESUNLIFE_New WITH (NOLOCK)
        ON NewEEID = xEEID
        AND NewDed = EedDedCode
    LEFT JOIN dbo.U_ESUNLIFE_NewDedDt WITH (NOLOCK)
        ON NewDedEEID = xEEID
        AND EedDedCode = NewDedCode
    WHERE EXISTS(SELECT * FROM dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStartDate <= @EndDate AND EedStopDate IS NULL
                    AND EedDedCode IN ('CCDEN','CPDEN','CDENT','CSDEN','CVDEN','CDENQ','CHLHQ','CHLTH','CCHLH','CPHLH','CHLHQ','CHLTH','CSHLH','CVHLH','CCLIF','CPLIF','CSLIF','CVLIF','CLIFE','CLTD','CCLTD','CPLTD','CSLTD','CVLTD','CELTD','CCDLI','CPDLI','CSDLI','CVDLI','CDLIF'))
    AND EecEmpNo <> '208681'
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Header;
    SELECT DISTINCT
         drvHeader = '<?xml version=”1.0” encoding=”ISO-8859-1”?>'
    INTO dbo.U_ESUNLIFE_Header
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESUNLIFE_Load','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_Load;
    SELECT DISTINCT
        drvLoader = '<Loader PolicyNum="102716" ClientName="Refresco Canada Inc." ReportLanguageCd="1">'
    INTO dbo.U_ESUNLIFE_Load                    --select * from U_ESUNLIFE_Load    PolicyNum="Refresco Canada Inc." 
    ;
    
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    INSERT INTO dbo.U_ESUNLIFE_File (RecordSet,InitialSort,SubSort,SubSort2,SubSort3,Data) VALUES ('T99','9999999','9999999','9999999','9999999','</Loader>');
 /*   
    IF OBJECT_ID('U_ESUNLIFE_LTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLIFE_LTrailer;
    SELECT DISTINCT
         drvLoader = '</Loader>'
    INTO dbo.U_ESUNLIFE_LTrailer
    ;
*/
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'T102716' + CONVERT(VARCHAR(8),GETDATE(),112) + LEFT(REPLACE(CONVERT(VARCHAR(20),GETDATE(), 114), ':', ''), 6) +  '.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESUNLIFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUNLIFE_File (NOLOCK)
    ORDER BY CASE WHEN RecordSet = 'H01' THEN 1
                  ELSE 2 END, InitialSort, RIGHT(RecordSet,2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUNLIFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201904081'
       ,expStartPerControl     = '201904081'
       ,expLastEndPerControl   = '201904159'
       ,expEndPerControl       = '201904159'
WHERE expFormatCode = 'ESUNLIFE';



    --------JOB NAME: Sunlife XML Export (ESUNLIFE) - Weekly, Wednesday, 11:01AM ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Sunlife XML Export (ESUNLIFE) - Weekly, Wednesday, 11:01AM ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (ESUNLIFE)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-7,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''ESUNLIFE''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (ESUNLIFE)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''ESUNLIFE'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly, Wednesday, 11:01AM ET',
            @enabled=1, 
            @freq_type=8, 
            @freq_interval=8,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20190415,
            @active_end_date=99991231,
            @active_start_time=110100,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUNLIFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUNLIFE_File (NOLOCK)
    ORDER BY CASE WHEN RecordSet = 'H01' THEN 1
                  ELSE 2 END, InitialSort, RIGHT(RecordSet,2);

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESUNLIFE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESUNLIFE'
   AND rpoParmType = 'expSystemID'


-- End ripout