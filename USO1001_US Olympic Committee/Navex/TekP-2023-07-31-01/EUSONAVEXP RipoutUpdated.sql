/**********************************************************************************

EUSONAVEXP: Navex Demographic Export

FormatCode:     EUSONAVEXP
Project:        Navex Demographic Export
Client ID:      USO1001
Date/time:      2023-10-04 14:53:35.160
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUSOC
Web Filename:   USO1001_839B6_EEHISTORY_EUSONAVEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUSONAVEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EUSONAVEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUSONAVEXP'


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
WHERE FormatCode = 'EUSONAVEXP'
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
WHERE ExpFormatCode = 'EUSONAVEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUSONAVEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUSONAVEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUSONAVEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUSONAVEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUSONAVEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUSONAVEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUSONAVEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUSONAVEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUSONAVEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUSONAVEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUSONAVEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUSONAVEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUSONAVEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUSONAVEXP];
GO
IF OBJECT_ID('U_EUSONAVEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EUSONAVEXP_Header];
GO
IF OBJECT_ID('U_EUSONAVEXP_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUSONAVEXP_HDR_drvTbl];
GO
IF OBJECT_ID('U_EUSONAVEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUSONAVEXP_File];
GO
IF OBJECT_ID('U_EUSONAVEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUSONAVEXP_EEList];
GO
IF OBJECT_ID('U_EUSONAVEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUSONAVEXP_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUSONAVEXP','Navex Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EUSONAVEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUSONAVEXPZ0','50','H','01','1',NULL,'ClientSuppliedUserIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUSONAVEXPZ0','50','H','01','2',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUSONAVEXPZ0','50','H','01','3',NULL,'MiddleName',NULL,NULL,'"drvMiddleName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUSONAVEXPZ0','50','H','01','4',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUSONAVEXPZ0','50','H','01','5',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUSONAVEXPZ0','50','H','01','6',NULL,'UserName',NULL,NULL,'"drvUserName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUSONAVEXPZ0','50','H','01','7',NULL,'Active',NULL,NULL,'"drvActive"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUSONAVEXPZ0','50','H','01','8',NULL,'ContentManagementActive',NULL,NULL,'"drvContentManagementActive"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUSONAVEXPZ0','50','H','01','9',NULL,'Site',NULL,NULL,'"drvSite"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUSONAVEXPZ0','50','H','01','10',NULL,'Department',NULL,NULL,'"drvDept"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUSONAVEXPZ0','50','H','01','11',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUSONAVEXPZ0','50','H','01','12',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUSONAVEXPZ0','50','H','01','13',NULL,'Manager Name',NULL,NULL,'"drvManagerName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUSONAVEXPZ0','50','H','01','14',NULL,'Manager Email',NULL,NULL,'"drvManagerEmail"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUSONAVEXPZ0','50','H','01','15',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=TT)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUSONAVEXPZ0','50','H','01','16',NULL,'Employee Type',NULL,NULL,'"drvEmpType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUSONAVEXPZ0','50','D','10','1',NULL,'ClientSuppliedUserIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUSONAVEXPZ0','50','D','10','2',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUSONAVEXPZ0','50','D','10','3',NULL,'MiddleName',NULL,NULL,'"drvMiddleName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUSONAVEXPZ0','50','D','10','4',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUSONAVEXPZ0','50','D','10','5',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUSONAVEXPZ0','50','D','10','6',NULL,'UserName',NULL,NULL,'"drvUserName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUSONAVEXPZ0','50','D','10','7',NULL,'Active',NULL,NULL,'"drvActive"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUSONAVEXPZ0','50','D','10','8',NULL,'ContentManagementActive',NULL,NULL,'"drvContentManagementActive"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUSONAVEXPZ0','50','D','10','9',NULL,'Site',NULL,NULL,'"drvSite"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUSONAVEXPZ0','50','D','10','10',NULL,'Department',NULL,NULL,'"drvDept"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUSONAVEXPZ0','50','D','10','11',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUSONAVEXPZ0','50','D','10','12',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUSONAVEXPZ0','50','D','10','13',NULL,'Manager Name',NULL,NULL,'"drvManagerName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUSONAVEXPZ0','50','D','10','14',NULL,'Manager Email',NULL,NULL,'"drvManagerEmail"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUSONAVEXPZ0','50','D','10','15',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUSONAVEXPZ0','50','D','10','16',NULL,'Employee Type',NULL,NULL,'"drvEmpType"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUSONAVEXP_20231004.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',V5C45',NULL,NULL,NULL,'Navex DEM Export On-Demand','202309219','EMPEXPORT','ONDEM_XOE',NULL,'EUSONAVEXP',NULL,NULL,NULL,'202309219','Sep 21 2023  1:07PM','Sep 21 2023  1:07PM','202309211',NULL,'','','202309211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',V5C45',NULL,NULL,NULL,'Navex DEM Export-Scheduled','202309219','EMPEXPORT','SCH_EUSONA',NULL,'EUSONAVEXP',NULL,NULL,NULL,'202309219','Sep 21 2023  1:07PM','Sep 21 2023  1:07PM','202309211',NULL,'','','202309211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',V5C45',NULL,NULL,NULL,'Navex DEM Export-Test','202309219','EMPEXPORT','TEST_XOE',NULL,'EUSONAVEXP',NULL,NULL,NULL,'202309219','Sep 21 2023  1:07PM','Sep 21 2023  1:07PM','202309211',NULL,'','','202309211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSONAVEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUSONAVEXP','H01','dbo.U_EUSONAVEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUSONAVEXP','D10','dbo.U_EUSONAVEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EUSONAVEXP_drvTbl
-----------

IF OBJECT_ID('U_EUSONAVEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUSONAVEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpNo] varchar(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmail] varchar(50) NULL,
    [drvUserName] varchar(50) NULL,
    [drvActive] varchar(1) NOT NULL,
    [drvContentManagementActive] varchar(1) NOT NULL,
    [drvSite] varchar(4) NOT NULL,
    [drvDept] varchar(25) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvManager] varchar(256) NULL,
    [drvManagerName] varchar(514) NULL,
    [drvManagerEmail] varchar(256) NULL,
    [drvHireDate] datetime NULL,
    [drvEmpType] char(3) NULL
);

-----------
-- Create table U_EUSONAVEXP_EEList
-----------

IF OBJECT_ID('U_EUSONAVEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUSONAVEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUSONAVEXP_File
-----------

IF OBJECT_ID('U_EUSONAVEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUSONAVEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EUSONAVEXP_HDR_drvTbl
-----------

IF OBJECT_ID('U_EUSONAVEXP_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUSONAVEXP_HDR_drvTbl] (
    [drvEEID] varchar(4) NOT NULL,
    [drvCoID] varchar(4) NOT NULL,
    [drvDepRecID] varchar(8) NOT NULL,
    [drvInitialSort] varchar(3) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpNo] varchar(9) NOT NULL,
    [drvNameFirst] varchar(9) NOT NULL,
    [drvMiddleName] varchar(10) NOT NULL,
    [drvLastName] varchar(8) NOT NULL,
    [drvEmail] varchar(5) NOT NULL,
    [drvUserName] varchar(8) NOT NULL,
    [drvActive] varchar(6) NOT NULL,
    [drvContentManagementActive] varchar(23) NOT NULL,
    [drvSite] varchar(4) NOT NULL,
    [drvDept] varchar(10) NOT NULL,
    [drvJobTitle] varchar(8) NOT NULL,
    [drvManager] varchar(9) NOT NULL,
    [drvManagerName] varchar(11) NOT NULL,
    [drvManagerEmail] varchar(12) NOT NULL,
    [drvHireDate] varchar(8) NOT NULL,
    [drvEmpType] varchar(7) NOT NULL
);

-----------
-- Create table U_EUSONAVEXP_Header
-----------

IF OBJECT_ID('U_EUSONAVEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EUSONAVEXP_Header] (
    [drvEmpNo] varchar(28) NOT NULL,
    [drvNameFirst] varchar(9) NOT NULL,
    [drvMiddleName] varchar(10) NOT NULL,
    [drvLastName] varchar(8) NOT NULL,
    [drvEmail] varchar(5) NOT NULL,
    [drvUserName] varchar(8) NOT NULL,
    [drvActive] varchar(6) NOT NULL,
    [drvContentManagementActive] varchar(23) NOT NULL,
    [drvSite] varchar(4) NOT NULL,
    [drvDept] varchar(10) NOT NULL,
    [drvJobTitle] varchar(8) NOT NULL,
    [drvManager] varchar(7) NOT NULL,
    [drvManagerName] varchar(12) NOT NULL,
    [drvManagerEmail] varchar(13) NOT NULL,
    [drvHireDate] varchar(9) NOT NULL,
    [drvEmpType] varchar(13) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUSONAVEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Spencer Kerch
Business Analyst: Dawn Ross
Create Date: 09/21/2023
Service Request Number: 

Purpose: Navex Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUSONAVEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUSONAVEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUSONAVEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUSONAVEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUSONAVEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUSONAVEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUSONAVEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUSONAVEXP', 'SCH_EUSONA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUSONAVEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUSONAVEXP';

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
    DELETE FROM dbo.U_EUSONAVEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUSONAVEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUSONAVEXP_drvTbl
    ---------------------------------
     IF OBJECT_ID('U_EUSONAVEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUSONAVEXP_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
       , drvEmpNo = SUBSTRING(EecEmpNo, PATINDEX('%[^0 ]%', EecEmpNo + 'a'), LEN(EecEmpNo))--EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvLastName = EepNameLast
        ,drvEmail = eepAddressEMail
        ,drvUserName = case when len(eepaddressemail) > 0 then left(EepAddressEmail, CHARINDEX('@',eepAddressEMail) - 1 ) end
        ,drvActive = '1'
        ,drvContentManagementActive = '1'
        ,drvSite = 'USOC'
        ,drvDept = OrgDesc
        ,drvJobTitle = JbcDesc
        ,drvManager = dbo.dsi_fnlib_GetSupervisorField('',EecEEID,'EmpNo')
        ,drvManagerName = Case When dbo.dsi_fnlib_GetSupervisorField('',EecEEID,'NameFirst') <> '' then dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast') + ', ' + dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Namefirst')
                          else ''
                          end
        ,drvManagerEmail = dbo.dsi_fnlib_GetSupervisorField('',EecEEID,'AddressEMail')
        ,drvHireDate = EecDateOfLastHire
        ,drvEmpType = EecEEType
    INTO dbo.U_EUSONAVEXP_drvTbl
    FROM dbo.U_EUSONAVEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl2
    where EecEmplStatus = 'A' and eeceetype <> 'TES'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUSONAVEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUSONAVEXP_Header;
    SELECT DISTINCT
         drvEmpNo = 'ClientSuppliedUserIdentifier'
        ,drvNameFirst = 'FirstName'
        ,drvMiddleName = 'MiddleName'
        ,drvLastName = 'LastName'
        ,drvEmail = 'Email'
        ,drvUserName = 'UserName'
        ,drvActive = 'Active'
        ,drvContentManagementActive = 'ContentManagementActive'
        ,drvSite = 'Site'
        ,drvDept = 'Department'
        ,drvJobTitle = 'JobTitle'
        ,drvManager ='Manager'
        ,drvManagerName = 'Manager Name'
        ,drvManagerEmail = 'Manager Email'
        ,drvHireDate = 'Hire Date'
        ,drvEmpType = 'Employee Type'
    INTO dbo.U_EUSONAVEXP_Header
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
ALTER VIEW dbo.dsi_vwEUSONAVEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUSONAVEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUSONAVEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202309141'
       ,expStartPerControl     = '202309141'
       ,expLastEndPerControl   = '202309219'
       ,expEndPerControl       = '202309219'
WHERE expFormatCode = 'EUSONAVEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUSONAVEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUSONAVEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUSONAVEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUSONAVEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUSONAVEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUSONAVEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUSONAVEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUSONAVEXP', 'UseFileName', 'V', 'Y'


-- End ripout