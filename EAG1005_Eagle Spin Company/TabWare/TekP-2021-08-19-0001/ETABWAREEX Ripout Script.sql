/**********************************************************************************

ETABWAREEX: TabWare Export

FormatCode:     ETABWAREEX
Project:        TabWare Export
Client ID:      USG1000
Date/time:      2022-01-06 10:41:20.930
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_ETABWAREEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETABWAREEX_SavePath') IS NOT NULL DROP TABLE dbo.U_ETABWAREEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETABWAREEX'


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
WHERE FormatCode = 'ETABWAREEX'
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
WHERE ExpFormatCode = 'ETABWAREEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETABWAREEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETABWAREEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETABWAREEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETABWAREEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETABWAREEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETABWAREEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETABWAREEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETABWAREEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETABWAREEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETABWAREEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETABWAREEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETABWAREEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETABWAREEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETABWAREEX];
GO
IF OBJECT_ID('U_ETABWAREEX_File') IS NOT NULL DROP TABLE [dbo].[U_ETABWAREEX_File];
GO
IF OBJECT_ID('U_ETABWAREEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETABWAREEX_EEList];
GO
IF OBJECT_ID('U_ETABWAREEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETABWAREEX_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','ETABWAREEX','TabWare Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','N','S','N','ETABWAREEXZ0','N','Jan  1 1900 12:00AM','C','N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Orglvl 1"','1','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','1',NULL,'Orglvl 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Code"','2','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','2',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','3','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Name (Last Suffix, F"','4','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','4',NULL,'Employee Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status Code"','5','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','5',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','6','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','6',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Hire Date"','7','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','7',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Employee Number"','8','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','8',NULL,'Supervisor Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name (Last Suffix,"','9','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','9',NULL,'Supervisor Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 2 Code"','10','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','10',NULL,'Org Level 2 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','11','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','11',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Shift Code"','12','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','12',NULL,'Shift Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Code"','13','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','13',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary/Hourly Code"','14','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','14',NULL,'Salary/Hourly Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Email"','15','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','15',NULL,'Employee Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone (Formatted)"','16','(''DA''=''T,'')','ETABWAREEXZ0','50','H','01','16',NULL,'Work Phone (Formatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Extension "','17','(''DA''=''T'')','ETABWAREEXZ0','50','H','01','17',NULL,'Work Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl1"','1','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','1',NULL,'Orglvl 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode"','2','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','2',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','3','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeName"','4','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','4',NULL,'Employee Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusCode"','5','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','5',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber2"','6','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','6',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','7','(''UD101''=''T,'')','ETABWAREEXZ0','50','D','10','7',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmployeeNumber"','8','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','8',NULL,'Supervisor Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','9','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','9',NULL,'Supervisor Name (Last Suffix, First MI)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl2Code"','10','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','10',NULL,'Org Level 2 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','11','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','11',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShiftCode"','12','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','12',NULL,'Shift Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','13','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','13',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryHourlyCode"','14','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','14',NULL,'Salary/Hourly Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmail"','15','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','15',NULL,'Employee Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','16','(''UA''=''T,'')','ETABWAREEXZ0','50','D','10','16',NULL,'Work Phone (Formatted)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkExtension"','17','(''UA''=''T'')','ETABWAREEXZ0','50','D','10','17',NULL,'Work Extension',NULL,NULL);

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETABWAREEX_20220106.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TabWare Export','202201069','EMPEXPORT','ONDEM_XOE',NULL,'ETABWAREEX',NULL,NULL,NULL,'202201069','Jan  6 2022  9:44AM','Jan  6 2022  9:44AM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TabWare Export-Sched','202201069','EMPEXPORT','SCH_ETABWA',NULL,'ETABWAREEX',NULL,NULL,NULL,'202201069','Jan  6 2022  9:44AM','Jan  6 2022  9:44AM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'TabWare Export-Test','202201069','EMPEXPORT','TEST_XOE',NULL,'ETABWAREEX',NULL,NULL,NULL,'202201069','Jan  6 2022  9:44AM','Jan  6 2022  9:44AM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETABWAREEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETABWAREEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETABWAREEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETABWAREEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETABWAREEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETABWAREEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETABWAREEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETABWAREEX','D10','dbo.U_ETABWAREEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_ETABWAREEX_drvTbl
-----------

IF OBJECT_ID('U_ETABWAREEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETABWAREEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvOrgLvl1] varchar(25) NULL,
    [drvCompanyCode] char(5) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvEmployeeName] varchar(207) NULL,
    [drvEmploymentStatusCode] char(1) NULL,
    [drvEmployeeNumber2] char(9) NULL,
    [drvLastHireDate] datetime NULL,
    [drvSupervisorEmployeeNumber] char(9) NULL,
    [drvSupervisorName] varchar(204) NULL,
    [drvOrgLvl2Code] varchar(10) NULL,
    [drvLocationCode] char(6) NULL,
    [drvShiftCode] varchar(1) NOT NULL,
    [drvJobCode] char(8) NULL,
    [drvSalaryHourlyCode] char(1) NULL,
    [drvEmployeeEmail] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkExtension] varchar(1) NOT NULL
);

-----------
-- Create table U_ETABWAREEX_EEList
-----------

IF OBJECT_ID('U_ETABWAREEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ETABWAREEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETABWAREEX_File
-----------

IF OBJECT_ID('U_ETABWAREEX_File') IS NULL
CREATE TABLE [dbo].[U_ETABWAREEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETABWAREEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Eagle Spin Company

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 01/06/2022
Service Request Number: TekP-2021-08-19-0001

Purpose: TabWare Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETABWAREEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETABWAREEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETABWAREEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETABWAREEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETABWAREEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETABWAREEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETABWAREEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETABWAREEX', 'SCH_ETABWA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ETABWAREEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETABWAREEX';

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
    DELETE FROM dbo.U_ETABWAREEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETABWAREEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ETABWAREEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETABWAREEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETABWAREEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETABWAREEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvOrgLvl1 = OrgDesc1
        ,drvCompanyCode = CmpCompanyCode
        ,drvEmployeeNumber = EecEmpNo
        ,drvEmployeeName =  '"' + RTRIM(EepNameLast) + ', ' + RTRIM(EepNameFirst) + ' ' + LEFT(ISNULL(EepNameMiddle, ''), 1) + '."'
        ,drvEmploymentStatusCode = EecEmplStatus
        ,drvEmployeeNumber2 = EecEmpNo
        ,drvLastHireDate = EecDateOfLastHire
        ,drvSupervisorEmployeeNumber = (SELECT TOP 1 SUP.EecEmpNo FROM dbo.EmpComp SUP WITH (NOLOCK) WHERE SUP.EecEEID = EC.EecSupervisorId)
        ,drvSupervisorName = SupervisorName
        ,drvOrgLvl2Code = EecOrgLvl2
        ,drvLocationCode = EecLocation
        ,drvShiftCode = ''
        ,drvJobCode = EecJobCode
        ,drvSalaryHourlyCode = EecSalaryOrHourly
        ,drvEmployeeEmail = EepAddressEMail
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkExtension = ''
    INTO dbo.U_ETABWAREEX_drvTbl
    FROM dbo.U_ETABWAREEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EC WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode1, OrgDesc AS OrgDesc1, OrgManagerId AS OrgManagerId1
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 1
            ) AS Org1
        ON OrgCode1 = EecOrgLvl1
    JOIN (
            SELECT EepEEID AS SupervisorID, RTRIM(EepNameLast) + ', ' + RTRIM(EepNameFirst) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '') AS SupervisorName, EepAddressEmail AS SupervisorEmail
            FROM dbo.EmpPers WITH (NOLOCK)) AS Supervisors
        ON SupervisorID = EecSupervisorId
    WHERE EecEmplStatus <> 'T'
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
ALTER VIEW dbo.dsi_vwETABWAREEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETABWAREEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETABWAREEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112301'
       ,expStartPerControl     = '202112301'
       ,expLastEndPerControl   = '202201069'
       ,expEndPerControl       = '202201069'
WHERE expFormatCode = 'ETABWAREEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETABWAREEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETABWAREEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETABWAREEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETABWAREEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETABWAREEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETABWAREEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETABWAREEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETABWAREEX', 'UseFileName', 'V', 'Y'


-- End ripout