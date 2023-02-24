/**********************************************************************************

EIEWCMSDM: Morgan Stanley Employee Demographic

FormatCode:     EIEWCMSDM
Project:        Morgan Stanley Employee Demographic
Client ID:      IEW1000
Date/time:      2023-02-21 13:56:19.287
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB02
Database:       ULTIPRO_WPIEWC
Web Filename:   IEW1000_BLC3P_EEHISTORY_EIEWCMSDM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIEWCMSDM_SavePath') IS NOT NULL DROP TABLE dbo.U_EIEWCMSDM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIEWCMSDM'


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
WHERE FormatCode = 'EIEWCMSDM'
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
WHERE ExpFormatCode = 'EIEWCMSDM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIEWCMSDM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIEWCMSDM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIEWCMSDM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIEWCMSDM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIEWCMSDM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIEWCMSDM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIEWCMSDM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIEWCMSDM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIEWCMSDM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIEWCMSDM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIEWCMSDM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIEWCMSDM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIEWCMSDM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIEWCMSDM];
GO
IF OBJECT_ID('U_EIEWCMSDM_File') IS NOT NULL DROP TABLE [dbo].[U_EIEWCMSDM_File];
GO
IF OBJECT_ID('U_EIEWCMSDM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIEWCMSDM_EEList];
GO
IF OBJECT_ID('U_EIEWCMSDM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIEWCMSDM_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIEWCMSDM','Morgan Stanley Employee Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EIEWCMSDM0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIEWCMSDM0Z0','50','D','10','1',NULL,'EMPLOYEE ID NUMBER',NULL,NULL,'"drvEmployeeId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIEWCMSDM0Z0','50','D','10','2',NULL,'FIRST NAME',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIEWCMSDM0Z0','50','D','10','3',NULL,'MIDDLE NAME',NULL,NULL,'"drvMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIEWCMSDM0Z0','50','D','10','4',NULL,'LAST NAME',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIEWCMSDM0Z0','50','D','10','5',NULL,'SUFFIX',NULL,NULL,'"drvSuffix"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIEWCMSDM0Z0','50','D','10','6',NULL,'BIRTH DT',NULL,NULL,'"drvBirthDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIEWCMSDM0Z0','50','D','10','7',NULL,'COMPANY EMAIL',NULL,NULL,'"drvCompanyEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIEWCMSDM0Z0','50','D','10','8',NULL,'HOME ADDRESS LEGAL 1',NULL,NULL,'"drvHomeAddressLegal1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIEWCMSDM0Z0','50','D','10','9',NULL,'HOME ADDRESS LEGAL 2',NULL,NULL,'"drvHomeAddressLegal2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIEWCMSDM0Z0','50','D','10','10',NULL,'HOME ADDRESS LEGAL 3',NULL,NULL,'"drvHomeAddressLegal3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIEWCMSDM0Z0','50','D','10','11',NULL,'HOME CITY',NULL,NULL,'"drvHomeCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIEWCMSDM0Z0','50','D','10','12',NULL,'HOME STATE CD',NULL,NULL,'"drvHomeStateCd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIEWCMSDM0Z0','50','D','10','13',NULL,'HOME ZIPCODE',NULL,NULL,'"drvHomeZipcode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIEWCMSDM0Z0','50','D','10','14',NULL,'HOME COUNTRY LEGAL',NULL,NULL,'"drvHomeCountryLegal"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIEWCMSDM0Z0','50','D','10','15',NULL,'FINANCIAL PLANNING IND',NULL,NULL,'"drvFinancialPlanningInd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIEWCMSDM0Z0','50','D','10','16',NULL,'FINANCIAL COACHING IND',NULL,NULL,'"drvFinancialCoachingInd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIEWCMSDM0Z0','50','D','10','17',NULL,'SSN',NULL,NULL,'"drvSsn"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIEWCMSDM0Z0','50','D','10','18',NULL,'PERSONAL PHONE NO',NULL,NULL,'"drvPersonalPhoneNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIEWCMSDM0Z0','50','D','10','19',NULL,'OFFICE PHONE NO',NULL,NULL,'"drvOfficePhoneNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIEWCMSDM0Z0','50','D','10','20',NULL,'OFFICE PHONE NO EXTENSION',NULL,NULL,'"drvOfficePhoneNoExtension"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIEWCMSDM0Z0','50','D','10','21',NULL,'CELL PHONE NO',NULL,NULL,'"drvCellPhoneNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIEWCMSDM0Z0','50','D','10','22',NULL,'HOME PHONE NO',NULL,NULL,'"drvHomePhoneNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIEWCMSDM0Z0','50','D','10','23',NULL,'PERSONAL EMAIL ADDR 1',NULL,NULL,'"drvPersonalEmailAddr1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIEWCMSDM0Z0','50','D','10','24',NULL,'HIRE DT',NULL,NULL,'"drvHireDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIEWCMSDM0Z0','50','D','10','25',NULL,'TERMINATION DT',NULL,NULL,'"drvTerminationDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIEWCMSDM0Z0','50','D','10','26',NULL,'ANNUAL INCOME',NULL,NULL,'"drvAnnualIncome"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIEWCMSDM0Z0','50','D','10','27',NULL,'JOB TITLE',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIEWCMSDM0Z0','50','D','10','28',NULL,'JOB DEPT NAME',NULL,NULL,'"drvJobDeptName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIEWCMSDM0Z0','50','D','10','29',NULL,'MAILING ADDR 1',NULL,NULL,'"drvMailingAddr1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIEWCMSDM0Z0','50','D','10','30',NULL,'MAILING ADDR 2',NULL,NULL,'"drvMailingAddr2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIEWCMSDM0Z0','50','D','10','31',NULL,'MAILING ADDR 3',NULL,NULL,'"drvMailingAddr3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EIEWCMSDM0Z0','50','D','10','32',NULL,'MAILING ADDR CITY',NULL,NULL,'"drvMailingAddrCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EIEWCMSDM0Z0','50','D','10','33',NULL,'MAILING ADDR STATE CD',NULL,NULL,'"drvMailingAddrStateCd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EIEWCMSDM0Z0','50','D','10','34',NULL,'MAILING ADDR ZIP POSTAL CD',NULL,NULL,'"drvMailingAddrZipPostalCd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EIEWCMSDM0Z0','50','D','10','35',NULL,'MAILING ADDR COUNTRY CODE',NULL,NULL,'"drvMailingAddrCountryCode"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIEWCMSDM_20230221.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Morgan Stanley Employee Demogr','202302209','EMPEXPORT','ONDEM_XOE',NULL,'EIEWCMSDM',NULL,NULL,NULL,'202302209','Feb 20 2023  9:34AM','Feb 20 2023  9:34AM','202302201',NULL,'','','202302201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Morgan Stanley Employee -Sched','202302209','EMPEXPORT','SCH_EIEWCM',NULL,'EIEWCMSDM',NULL,NULL,NULL,'202302209','Feb 20 2023  9:34AM','Feb 20 2023  9:34AM','202302201',NULL,'','','202302201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Morgan Stanley Employee -Test','202302209','EMPEXPORT','TEST_XOE',NULL,'EIEWCMSDM',NULL,NULL,NULL,'202302209','Feb 20 2023  9:34AM','Feb 20 2023  9:34AM','202302201',NULL,'','','202302201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIEWCMSDM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIEWCMSDM','D10','dbo.U_EIEWCMSDM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EIEWCMSDM_drvTbl
-----------

IF OBJECT_ID('U_EIEWCMSDM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIEWCMSDM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeId] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSuffix] varchar(1) NOT NULL,
    [drvBirthDt] varchar(8) NULL,
    [drvCompanyEmail] varchar(50) NULL,
    [drvHomeAddressLegal1] varchar(255) NULL,
    [drvHomeAddressLegal2] varchar(255) NULL,
    [drvHomeAddressLegal3] varchar(255) NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvHomeStateCd] varchar(255) NULL,
    [drvHomeZipcode] varchar(50) NULL,
    [drvHomeCountryLegal] varchar(2) NOT NULL,
    [drvFinancialPlanningInd] varchar(1) NOT NULL,
    [drvFinancialCoachingInd] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvPersonalPhoneNo] varchar(1) NOT NULL,
    [drvOfficePhoneNo] varchar(50) NULL,
    [drvOfficePhoneNoExtension] varchar(10) NULL,
    [drvCellPhoneNo] varchar(50) NULL,
    [drvHomePhoneNo] varchar(50) NULL,
    [drvPersonalEmailAddr1] varchar(50) NULL,
    [drvHireDt] varchar(8) NULL,
    [drvTerminationDt] varchar(1) NOT NULL,
    [drvAnnualIncome] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvJobDeptName] varchar(1) NOT NULL,
    [drvMailingAddr1] varchar(1) NOT NULL,
    [drvMailingAddr2] varchar(1) NOT NULL,
    [drvMailingAddr3] varchar(1) NOT NULL,
    [drvMailingAddrCity] varchar(1) NOT NULL,
    [drvMailingAddrStateCd] varchar(1) NOT NULL,
    [drvMailingAddrZipPostalCd] varchar(1) NOT NULL,
    [drvMailingAddrCountryCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EIEWCMSDM_EEList
-----------

IF OBJECT_ID('U_EIEWCMSDM_EEList') IS NULL
CREATE TABLE [dbo].[U_EIEWCMSDM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIEWCMSDM_File
-----------

IF OBJECT_ID('U_EIEWCMSDM_File') IS NULL
CREATE TABLE [dbo].[U_EIEWCMSDM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIEWCMSDM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IEWC

Created By: Marie Waters
Business Analyst: Curlin Beck
Create Date: 02/20/2023
Service Request Number: TekP-2023-1-5-03

Purpose: Morgan Stanley Employee Demographic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIEWCMSDM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIEWCMSDM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIEWCMSDM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIEWCMSDM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIEWCMSDM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIEWCMSDM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIEWCMSDM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIEWCMSDM', 'SCH_EIEWCM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIEWCMSDM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIEWCMSDM';

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
    DELETE FROM dbo.U_EIEWCMSDM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIEWCMSDM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIEWCMSDM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIEWCMSDM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIEWCMSDM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeId = EecEmpNo
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSuffix = ''
        ,drvBirthDt = convert(varchar(8),cast(EepDateofBirth as date),112)
        ,drvCompanyEmail = EepAddressEMail
        ,drvHomeAddressLegal1 = EepAddressLine1
        ,drvHomeAddressLegal2 = EepAddressLine2
        ,drvHomeAddressLegal3 = EepAddressLine3
        ,drvHomeCity = EepAddressCity
        ,drvHomeStateCd = EepAddressState
        ,drvHomeZipcode = CASE WHEN len(eepaddresszipcode) = 5 THEN eepaddresszipcode
                    ELSE left(eepaddresszipcode,5) + '-' + substring(eepaddresszipcode,6,4) END
        ,drvHomeCountryLegal = 'US'
        ,drvFinancialPlanningInd = ''
        ,drvFinancialCoachingInd = ''
        ,drvSsn = eepSSN
        ,drvPersonalPhoneNo = ''
        ,drvOfficePhoneNo = EecPhoneBusinessNumber
        ,drvOfficePhoneNoExtension = EecPhoneBusinessExt
        ,drvCellPhoneNo = EfoPhoneNumber
        ,drvHomePhoneNo = EepPhoneHomeNumber
        ,drvPersonalEmailAddr1 = EepAddressEMail
        ,drvHireDt = convert(varchar(8),cast(EecDateOfLastHire as date),112)
        ,drvTerminationDt = ''
        ,drvAnnualIncome = ''
        ,drvJobTitle = ''
        ,drvJobDeptName = ''
        ,drvMailingAddr1 = ''
        ,drvMailingAddr2 = ''
        ,drvMailingAddr3 = ''
        ,drvMailingAddrCity = ''
        ,drvMailingAddrStateCd = ''
        ,drvMailingAddrZipPostalCd = ''
        ,drvMailingAddrCountryCode = ''
    INTO dbo.U_EIEWCMSDM_drvTbl
    FROM dbo.U_EIEWCMSDM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
     LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
        WHERE EepAddressCountry = 'USA'  and Eecemplstatus IN ('A', 'L')
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
ALTER VIEW dbo.dsi_vwEIEWCMSDM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIEWCMSDM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIEWCMSDM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302131'
       ,expStartPerControl     = '202302131'
       ,expLastEndPerControl   = '202302209'
       ,expEndPerControl       = '202302209'
WHERE expFormatCode = 'EIEWCMSDM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIEWCMSDM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIEWCMSDM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIEWCMSDM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIEWCMSDM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIEWCMSDM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIEWCMSDM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIEWCMSDM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIEWCMSDM', 'UseFileName', 'V', 'Y'


-- End ripout