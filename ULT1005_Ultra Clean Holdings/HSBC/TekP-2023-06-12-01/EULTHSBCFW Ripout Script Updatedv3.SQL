/**********************************************************************************

EULTHSBCFW: HSBC Positive Pay

FormatCode:     EULTHSBCFW
Project:        HSBC Positive Pay
Client ID:      ULT1005
Date/time:      2024-01-04 11:52:21.077
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP2DB01
Database:       ULTIPRO_WPUCH
Web Filename:   ULT1005_QZ2PT_EEHISTORY_EULTHSBCFW_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EULTHSBCFW_SavePath') IS NOT NULL DROP TABLE dbo.U_EULTHSBCFW_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EULTHSBCFW'


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
WHERE FormatCode = 'EULTHSBCFW'
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
WHERE ExpFormatCode = 'EULTHSBCFW'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EULTHSBCFW')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EULTHSBCFW'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EULTHSBCFW'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EULTHSBCFW'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EULTHSBCFW'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EULTHSBCFW'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EULTHSBCFW'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EULTHSBCFW'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EULTHSBCFW'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EULTHSBCFW'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEULTHSBCFW_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEULTHSBCFW_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EULTHSBCFW') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EULTHSBCFW];
GO
IF OBJECT_ID('U_EULTHSBCFW_VOIDS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EULTHSBCFW_VOIDS_drvTbl];
GO
IF OBJECT_ID('U_EULTHSBCFW_TRL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EULTHSBCFW_TRL_drvTbl];
GO
IF OBJECT_ID('U_EULTHSBCFW_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EULTHSBCFW_HDR_drvTbl];
GO
IF OBJECT_ID('U_EULTHSBCFW_File') IS NOT NULL DROP TABLE [dbo].[U_EULTHSBCFW_File];
GO
IF OBJECT_ID('U_EULTHSBCFW_EEList') IS NOT NULL DROP TABLE [dbo].[U_EULTHSBCFW_EEList];
GO
IF OBJECT_ID('U_EULTHSBCFW_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EULTHSBCFW_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EULTHSBCFW','HSBC Positive Pay','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','300','S','N','EULTHSBCFWZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EULTHSBCFWZ0','4','H','01','1',NULL,'Record Type',NULL,NULL,'"HOST"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EULTHSBCFWZ0','18','H','01','5',NULL,'HSBCnet Customer ID',NULL,NULL,'"drvHSBCnetCustomerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EULTHSBCFWZ0','11','H','01','23',NULL,'Connect Profile ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EULTHSBCFWZ0','16','H','01','34',NULL,'File Type',NULL,NULL,'"FUPOSPY"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EULTHSBCFWZ0','16','H','01','50',NULL,'File Format',NULL,NULL,'"US300"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EULTHSBCFWZ0','1','H','01','66',NULL,'Auth Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EULTHSBCFWZ0','86','H','01','67',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EULTHSBCFWZ0','35','H','01','153',NULL,'File Name',NULL,NULL,'"ULTPOSPAY"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EULTHSBCFWZ0','26','H','01','188',NULL,'File Creation Timestamp',NULL,NULL,'"drvFileCreation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EULTHSBCFWZ0','3','H','01','214',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EULTHSBCFWZ0','35','H','01','217',NULL,'File Reference',NULL,NULL,'"drvFileReference"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EULTHSBCFWZ0','9','H','01','252',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EULTHSBCFWZ0','15','H','01','261',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EULTHSBCFWZ0','13','D','10','1',NULL,'HSBC Account Number',NULL,NULL,'"drvHSBCAccountNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EULTHSBCFWZ0','10','D','10','14',NULL,'Check Serial Number',NULL,NULL,'"drvCheckSerialNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EULTHSBCFWZ0','10','D','10','24',NULL,'Check Amount',NULL,NULL,'"drvCheckAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EULTHSBCFWZ0','8','D','10','34',NULL,'Check Issue Date',NULL,NULL,'"drvCheckIssueDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EULTHSBCFWZ0','1','D','10','42',NULL,'Void Indicator',NULL,NULL,'"drvVoidIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EULTHSBCFWZ0','50','D','10','43',NULL,'Payee Name One',NULL,NULL,'"drvPayeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EULTHSBCFWZ0','50','D','10','93',NULL,'Payee Name Two',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EULTHSBCFWZ0','158','D','10','143',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EULTHSBCFWZ0','1','T','90','1',NULL,'Trailer Record Indicator',NULL,NULL,'"T"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EULTHSBCFWZ0','13','T','90','2',NULL,'HSBC Account Number',NULL,NULL,'"drvHSBCAccountNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EULTHSBCFWZ0','5','T','90','15',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EULTHSBCFWZ0','10','T','90','20',NULL,'Total Items',NULL,NULL,'"drvTotalItems"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EULTHSBCFWZ0','5','T','90','30',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EULTHSBCFWZ0','12','T','90','35',NULL,'Total Dollar Amount',NULL,NULL,'"drvTotalDollarAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EULTHSBCFWZ0','254','T','90','47',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EULTHSBCFWZ0','1','T','95','1',NULL,'Trailer Record Indicator',NULL,NULL,'"T"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EULTHSBCFWZ0','13','T','95','2',NULL,'HSBC Account Number',NULL,NULL,'"drvHSBCAccountNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EULTHSBCFWZ0','5','T','95','15',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EULTHSBCFWZ0','10','T','95','20',NULL,'Total Items',NULL,NULL,'"drvTotalItems"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EULTHSBCFWZ0','5','T','95','30',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EULTHSBCFWZ0','12','T','95','35',NULL,'Total Dollar Amount',NULL,NULL,'"drvTotalDollarAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EULTHSBCFWZ0','5','T','95','47',NULL,'Void Trailer Indicator',NULL,NULL,'"VOIDS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EULTHSBCFWZ0','249','T','95','52',NULL,'Spaces',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EULTHSBCFW_20240104.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',TWZNN,A0GJH',NULL,NULL,NULL,'HSBC Positive Pay ONDEM','202311279','EMPEXPORT','ONDEM_XOE',NULL,'EULTHSBCFW',NULL,NULL,NULL,'202311279','Aug  8 2023 10:27AM','Aug  8 2023 10:27AM','202311271',NULL,'','','202311271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',TWZNN,A0GJH',NULL,NULL,NULL,'HSBC Positive Pay-Sched','202311279','EMPEXPORT','SCH_EULTHS',NULL,'EULTHSBCFW',NULL,NULL,NULL,'202311279','Aug  8 2023 10:27AM','Aug  8 2023 10:27AM','202311271',NULL,'','','202311271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',TWZNN,A0GJH',NULL,NULL,NULL,'HSBC Positive Pay-Test','202401051','EMPEXPORT','TEST_XOE',NULL,'EULTHSBCFW',NULL,NULL,NULL,'202401051','Aug  8 2023 10:27AM','Aug  8 2023 10:27AM','202401051',NULL,'','','202401051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EULTHSBCFW','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EULTHSBCFW','H01','dbo.U_EULTHSBCFW_HDR_drvTbl','ISNULL(drvRecordCount,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EULTHSBCFW','D10','dbo.U_EULTHSBCFW_drvTbl','ISNULL(drvAmt2,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EULTHSBCFW','T90','dbo.U_EULTHSBCFW_TRL_drvTbl','ISNULL(drvTotalDollarAmt,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EULTHSBCFW','T95','dbo.U_EULTHSBCFW_VOIDS_drvTbl','ISNULL(drvTotalDollarAmt,'''') <>''''');

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EULTHSBCFW_drvTbl
-----------

IF OBJECT_ID('U_EULTHSBCFW_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EULTHSBCFW_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(10) NULL,
    [drvHSBCAccountNo] varchar(22) NULL,
    [drvCheckSerialNo] varchar(8000) NULL,
    [drvCheckAmount] nvarchar(4000) NULL,
    [drvCheckIssueDate] datetime NULL,
    [drvVoidIndicator] varchar(1) NULL,
    [drvPayeeName] varchar(61) NOT NULL,
    [drvAmt] nvarchar(4000) NULL,
    [drvAmt2] money NULL
);

-----------
-- Create table U_EULTHSBCFW_EEList
-----------

IF OBJECT_ID('U_EULTHSBCFW_EEList') IS NULL
CREATE TABLE [dbo].[U_EULTHSBCFW_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EULTHSBCFW_File
-----------

IF OBJECT_ID('U_EULTHSBCFW_File') IS NULL
CREATE TABLE [dbo].[U_EULTHSBCFW_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(300) NULL
);

-----------
-- Create table U_EULTHSBCFW_HDR_drvTbl
-----------

IF OBJECT_ID('U_EULTHSBCFW_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EULTHSBCFW_HDR_drvTbl] (
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvHSBCnetCustomerID] varchar(11) NOT NULL,
    [drvFileCreation] nvarchar(4000) NULL,
    [drvFileReference] nvarchar(4000) NULL,
    [drvRecordCount] nvarchar(4000) NULL
);

-----------
-- Create table U_EULTHSBCFW_TRL_drvTbl
-----------

IF OBJECT_ID('U_EULTHSBCFW_TRL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EULTHSBCFW_TRL_drvTbl] (
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvHSBCAccountNo] varchar(9) NOT NULL,
    [drvTotalItems] nvarchar(4000) NULL,
    [drvTotalDollarAmt] nvarchar(4000) NULL
);

-----------
-- Create table U_EULTHSBCFW_VOIDS_drvTbl
-----------

IF OBJECT_ID('U_EULTHSBCFW_VOIDS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EULTHSBCFW_VOIDS_drvTbl] (
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvHSBCAccountNo] varchar(9) NOT NULL,
    [drvTotalItems] nvarchar(4000) NULL,
    [drvTotalDollarAmt] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EULTHSBCFW]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ultra Clean Holdings Inc

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 08/08/2023
Service Request Number: TekP-2023-06-12-01

Purpose: HSBC Positive Pay

Revision History
----------------
Update By           Date           Request Num          Desc
Marie Waters       11/2/2023      TekP-2023-06-12-01    Removed +2 from counts of TotalItems
LeaK                11/30/23      TekP-2023-06-12-01    Correct trailers and set to not send if blank file
Marie Waters       12/8/2023      TekP-2023-06-12-01    Updated code for header count

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EULTHSBCFW';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EULTHSBCFW';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EULTHSBCFW';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EULTHSBCFW';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EULTHSBCFW' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311101'
       ,expStartPerControl     = '202311101'
       ,expLastEndPerControl   = '202311109'
       ,expEndPerControl       = '202311109'
WHERE expFormatCode = 'EULTHSBCFW';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EULTHSBCFW', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EULTHSBCFW', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EULTHSBCFW', 'SCH_EULTHS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EULTHSBCFW', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EULTHSBCFW';

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
    DELETE FROM dbo.U_EULTHSBCFW_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EULTHSBCFW_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EULTHSBCFW_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EULTHSBCFW_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EULTHSBCFW_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = LTRIM(RTRIM(PrgDocNo))
        -- standard fields above and additional driver fields below
        ,drvHSBCAccountNo = BnkBankAcctNo
        ,drvCheckSerialNo = REPLICATE('0', (10-LEN(LTRIM(PrgDocNo))))+ LTRIM(PrgDocNo)
        ,drvCheckAmount = FORMAT(ABS(PrgCheckAmt*100),'0000000000')
        ,drvCheckIssueDate = PrgPayDate
        ,drvVoidIndicator = Case when PrgISVoidingRecord = 'Y' THEN 'V' END
        ,drvPayeeName = CONCAT(PrgNameFirst, ' ', PrgNameLast)
        ,drvAmt = FORMAT(PrgCheckAmt*100,'##000')
        ,drvAmt2 = PrgCheckAmt
    INTO dbo.U_EULTHSBCFW_drvTbl
    FROM dbo.U_EULTHSBCFW_EEList WITH (NOLOCK)
       JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
        AND PrgCoID = xCOID
    LEFT JOIN dbo.EmpPers WITH (NOLOCK)
    On EepEEID = xEEID
    JOIN dbo.Bank WITH (NOLOCK)
        ON PrgCoBankID = BnkCoBankID
        AND BnkBankAcctNo = '953000273'
    LEFT JOIN dbo.ChkHead WITH (NOLOCK)
        ON ckhEEID = xEEID
        AND CONVERT(VARCHAR(10),LTRIM(RTRIM(PrgDocNo))) = CONVERT(VARCHAR(10),LTRIM(RTRIM(ckhCheckNo)))
        AND PrgGenNumber = ckhGenNumber
    WHERE Prgpercontrol BETWEEN @StartPerControl AND @EndPerControl
    AND PrgCheckAddMode IN ('R','M','A','D','B')
    AND PrgPrinted = 'Y'
    AND PrgTransactionType IN ('C')
    AND (PrgPostOnly = 'N'
        OR PrgIsVoidingRecord = 'Y'
    );
  
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EULTHSBCFW_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EULTHSBCFW_HDR_drvTbl;
     SELECT DISTINCT
         drvEmpNoSort = ''
        ,drvHSBCnetCustomerID = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'PC000024709' ELSE 'PC000038632' END
        ,drvFileCreation = FORMAT(GetDate(), 'yyyy-MM-ddThh:mm:ss.ffff') -- MW updated 1/4/2024 from REPLACE(format(getdate(),'yyyy-MM-ddTHH:mm:ss.MSMSMS'),'S','')--CCYY-MM-DDTHH:MN:SS.MSMSMS
        ,drvFileReference = format(getdate(),'yyyyMMddHHmm')
        ,drvRecordCount =  CASE WHEN (((Select count(drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK)  where ISNULL(drvVoidIndicator, '')  <> 'V' and drvCheckAmount <> '0000000000')> 0 and  (Select count(drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK) where ISNULL(drvVoidIndicator, '') = 'V' and drvCheckAmount <> '0000000000') = 0 ) 
                                            or ((Select count(drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK)  where ISNULL(drvVoidIndicator, '')  <> 'V' and drvCheckAmount <> '0000000000') = 0 and  (Select count(drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK) where ISNULL(drvVoidIndicator, '') = 'V' and drvCheckAmount <> '0000000000') > 0 )) 
                                    THEN FORMaT( ( SELECT count(distinct drvEEID)+1  FROM dbo.U_EULTHSBCFW_drvTbl b WITH (NOLOCK) where ISNULL(drvVoidIndicator,'')  = 'V' and drvCheckAmount <> '0000000000')  + ( SELECT count( drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl    where ISNULL(drvVoidIndicator, '')  = ' ' and drvCheckAmount <> '0000000000'),'000000000')
        
                                WHEN( (Select count(drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK)  where ISNULL(drvVoidIndicator, '')  <> 'V' and drvCheckAmount <> '0000000000')> 0 and (Select count(drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK) where ISNULL(drvVoidIndicator, '') = 'V' and drvCheckAmount <> '0000000000')> 0 ) 
                                THEN FORMaT( ( SELECT count(distinct drvEEID)+2  FROM dbo.U_EULTHSBCFW_drvTbl b WITH (NOLOCK) where ISNULL(drvVoidIndicator,'')  = 'V' and drvCheckAmount <> '0000000000')  + ( SELECT count( drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl    where ISNULL(drvVoidIndicator, '')  = ' ' and drvCheckAmount <> '0000000000'),'000000000')
                                END 
        --FORMaT( ( SELECT count(distinct drvEEID)  FROM dbo.U_EULTHSBCFW_drvTbl b WITH (NOLOCK) where ISNULL(drvVoidIndicator,'')  = 'V' and drvCheckAmount <> '0000000000')  + ( SELECT count( drvEEID) FROM dbo.U_EULTHSBCFW_drvTbl    where ISNULL(drvVoidIndicator, '')  = ' ' and drvCheckAmount <> '0000000000'),'000000000') ---- MW updated 12/8 FORMAT(count(drvEEID)+2,'000000000')
    INTO dbo.U_EULTHSBCFW_HDR_drvTbl
    FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK) where  drvCheckAmount <> '0000000000'
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EULTHSBCFW_TRL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EULTHSBCFW_TRL_drvTbl;
    SELECT DISTINCT
         drvEmpNoSort = ''
        ,drvHSBCAccountNo = '953000273'
        ,drvTotalItems = FORMAT(count(drvEEID),'0000000000') --MW updated to remove + 2 FORMAT(count(drvEEID)+2,'0000000000')
        ,drvTotalDollarAmt = FORMAT(ABS(sum(drvAmt2)*100),'0000000000')
    INTO dbo.U_EULTHSBCFW_TRL_drvTbl
    FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK)
    where ISNULL(drvVoidIndicator, '')  <> 'V' and drvCheckAmount <> '0000000000' --MW changed from  drvVoidIndicator IS NULL
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EULTHSBCFW_VOIDS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EULTHSBCFW_VOIDS_drvTbl;
    SELECT DISTINCT
         drvEmpNoSort = ''
         ,drvHSBCAccountNo = '953000273'
        ,drvTotalItems = FORMAT(count(drvEEID),'0000000000')--MW updated to remove + 2 FORMAT(count(drvEEID)+2,'0000000000')
        ,drvTotalDollarAmt = FORMAT(ABS(sum(drvAmt2)*100),'0000000000')
    INTO dbo.U_EULTHSBCFW_VOIDS_drvTbl
    FROM dbo.U_EULTHSBCFW_drvTbl WITH (NOLOCK)
    where ISNULL(drvVoidIndicator, '') = 'V' and drvCheckAmount <> '0000000000'
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'US_POS_PAY_CSV.TXT'
                                  ELSE 'US_POS_PAY_CSV.TXT'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEULTHSBCFW_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EULTHSBCFW_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2);
    
    --, InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EULTHSBCFW%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208011'
       ,expStartPerControl     = '202208011'
       ,expLastEndPerControl   = '202308089'
       ,expEndPerControl       = '202308089'
WHERE expFormatCode = 'EULTHSBCFW';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEULTHSBCFW_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EULTHSBCFW_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2)---, InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EULTHSBCFW' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EULTHSBCFW'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EULTHSBCFW'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EULTHSBCFW', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EULTHSBCFW', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EULTHSBCFW', 'UseFileName', 'V', 'Y'


-- End ripout