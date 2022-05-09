/**********************************************************************************

ELMSCSVUTC: Torch LMS Export V2

FormatCode:     ELMSCSVUTC
Project:        Torch LMS Export V2
Client ID:      UTA1000
Date/time:      2022-05-05 12:05:20.770
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUTCFC
Web Filename:   UTA1000_E52D4_EEHISTORY_ELMSCSVUTC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELMSCSVUTC_SavePath') IS NOT NULL DROP TABLE dbo.U_ELMSCSVUTC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELMSCSVUTC'


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
WHERE FormatCode = 'ELMSCSVUTC'
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
WHERE ExpFormatCode = 'ELMSCSVUTC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELMSCSVUTC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELMSCSVUTC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELMSCSVUTC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELMSCSVUTC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELMSCSVUTC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELMSCSVUTC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELMSCSVUTC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELMSCSVUTC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELMSCSVUTC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELMSCSVUTC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELMSCSVUTC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELMSCSVUTC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELMSCSVUTC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELMSCSVUTC];
GO
IF OBJECT_ID('U_ELMSCSVUTC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUTC_PEarHist];
GO
IF OBJECT_ID('U_ELMSCSVUTC_File') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUTC_File];
GO
IF OBJECT_ID('U_ELMSCSVUTC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUTC_EEList];
GO
IF OBJECT_ID('U_ELMSCSVUTC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELMSCSVUTC_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELMSCSVUTC','Torch LMS Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','8000','S','N','ELMSCSVUTCZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELMSCSVUTCZ0','50','H','01','1',NULL,'User ID',NULL,NULL,'"User ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELMSCSVUTCZ0','50','H','01','2',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELMSCSVUTCZ0','50','H','01','3',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELMSCSVUTCZ0','50','H','01','4',NULL,'Username',NULL,NULL,'"Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELMSCSVUTCZ0','50','H','01','5',NULL,'Manager',NULL,NULL,'"Manager"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELMSCSVUTCZ0','50','H','01','6',NULL,'Allow Reconciliation',NULL,NULL,'"Allow Reconciliation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELMSCSVUTCZ0','50','H','01','7',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELMSCSVUTCZ0','50','H','01','8',NULL,'Required Training Approvals',NULL,NULL,'"Required Training Approvals"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELMSCSVUTCZ0','50','H','01','9',NULL,'Exempt',NULL,NULL,'"Exempt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELMSCSVUTCZ0','50','H','01','10',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELMSCSVUTCZ0','50','H','01','11',NULL,'Last Hire Date',NULL,NULL,'"Last Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELMSCSVUTCZ0','50','H','01','12',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELMSCSVUTCZ0','50','H','01','13',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELMSCSVUTCZ0','50','H','01','14',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELMSCSVUTCZ0','50','H','01','15',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELMSCSVUTCZ0','50','H','01','16',NULL,'Termination Date',NULL,NULL,'"UKG Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELMSCSVUTCZ0','50','H','01','17',NULL,'Full Time',NULL,NULL,'"Full Time"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELMSCSVUTCZ0','50','H','01','18',NULL,'Exempt Payroll',NULL,NULL,'"Exempt Payroll"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELMSCSVUTCZ0','50','H','01','19',NULL,'Local System ID',NULL,NULL,'"Local System ID"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELMSCSVUTCZ0','50','D','10','1',NULL,'User ID',NULL,NULL,'"drvUserId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELMSCSVUTCZ0','50','D','10','2',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELMSCSVUTCZ0','50','D','10','3',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELMSCSVUTCZ0','50','D','10','4',NULL,'User Name',NULL,NULL,'"drvUsername"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELMSCSVUTCZ0','50','D','10','5',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELMSCSVUTCZ0','50','D','10','6',NULL,'Allow Reconciliation',NULL,NULL,'"drvAllowReconciliation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELMSCSVUTCZ0','50','D','10','7',NULL,'Emal',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELMSCSVUTCZ0','50','D','10','8',NULL,'Required Training Approvals',NULL,NULL,'"drvRequiredTrainingApprov"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELMSCSVUTCZ0','50','D','10','9',NULL,'Exempt',NULL,NULL,'"drvExempt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELMSCSVUTCZ0','50','D','10','10',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELMSCSVUTCZ0','50','D','10','11',NULL,'Last Hire Date',NULL,NULL,'"drvLastHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELMSCSVUTCZ0','50','D','10','12',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELMSCSVUTCZ0','50','D','10','13',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELMSCSVUTCZ0','50','D','10','14',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELMSCSVUTCZ0','50','D','10','15',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELMSCSVUTCZ0','50','D','10','16',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELMSCSVUTCZ0','50','D','10','17',NULL,'Full Time',NULL,NULL,'"drvFullTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELMSCSVUTCZ0','50','D','10','18',NULL,'Exempt Payroll',NULL,NULL,'"drvExemptPayroll"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELMSCSVUTCZ0','50','D','10','19',NULL,'Local System ID',NULL,NULL,'"drvLocalSystemID"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELMSCSVUTC_20220505.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XAH9W',NULL,NULL,NULL,'Torch LMS Export','201903139','EMPEXPORT','ONDEMAND','Feb  2 2022  8:48AM','ELMSCSVUTC',NULL,NULL,NULL,'201905029','Feb 12 2019  9:27AM','Feb 12 2019  9:27AM','201905011','1109','','','201903061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','XAH9W',NULL,NULL,NULL,'Scheduled Session','201903139','EMPEXPORT','SCHEDULED',NULL,'ELMSCSVUTC',NULL,NULL,NULL,'202108319','Feb 12 2019  9:27AM','Feb 12 2019  9:27AM','202108301',NULL,'','','201903061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202204151','EMPEXPORT','TEST','Apr 15 2022 12:00AM','ELMSCSVUTC',NULL,NULL,NULL,'202204151','Apr 15 2022 12:00AM','Apr 15 2022 12:00AM','202204151','580','','','202204151',dbo.fn_GetTimedKey(),NULL,'us3cPeUTA1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'XAH9W',NULL,NULL,NULL,'Torch LMS OE Export','202001019','EMPEXPORT','TorOE',NULL,'ELMSCSVUTC',NULL,NULL,NULL,'202001019',NULL,NULL,'202001011',NULL,NULL,'','202001011',dbo.fn_GetTimedKey(),NULL,NULL,NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','InitialSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','SubSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMSCSVUTC','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELMSCSVUTC','D10','dbo.U_ELMSCSVUTC_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ELMSCSVUTC_drvTbl
-----------

IF OBJECT_ID('U_ELMSCSVUTC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUTC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvUserId] varchar(255) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvUsername] varchar(50) NULL,
    [drvManager] varchar(50) NULL,
    [drvAllowReconciliation] varchar(4) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvRequiredTrainingApprov] varchar(1) NOT NULL,
    [drvExempt] varchar(1) NOT NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvLastHireDate] datetime NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvDivision] char(10) NULL,
    [drvJobTitle] char(8) NULL,
    [drvDepartment] char(10) NULL,
    [drvTerminationDate] datetime NULL,
    [drvFullTime] varchar(1) NOT NULL,
    [drvExemptPayroll] varchar(1) NOT NULL,
    [drvLocalSystemID] char(9) NULL
);

-----------
-- Create table U_ELMSCSVUTC_EEList
-----------

IF OBJECT_ID('U_ELMSCSVUTC_EEList') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUTC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELMSCSVUTC_File
-----------

IF OBJECT_ID('U_ELMSCSVUTC_File') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUTC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_ELMSCSVUTC_PEarHist
-----------

IF OBJECT_ID('U_ELMSCSVUTC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELMSCSVUTC_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PgrPayGroup] char(6) NULL,
    [PrgPayDate] datetime NULL,
    [PgrPayFrequency] char(1) NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELMSCSVUTC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Utah Community Federal Credit Union

Created By: Sean Farrell
Business Analyst: Nick Watkins
Create Date: 02/12/2019
Service Request Number: SR-2018-00221045

Purpose: Torch LMS Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELMSCSVUTC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELMSCSVUTC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELMSCSVUTC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELMSCSVUTC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELMSCSVUTC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELMSCSVUTC', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELMSCSVUTC', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELMSCSVUTC', @AllObjects = 'Y', @IsWeb = 'Y'

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELMSCSVUTC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELMSCSVUTC';

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
    DELETE FROM dbo.U_ELMSCSVUTC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELMSCSVUTC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    DELETE dbo.U_ELMSCSVUTC_EEList
    FROM dbo.U_ELMSCSVUTC_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID
    AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND EecDateOfTermination <= DATEADD(dd,-90,@EndDate)


    -------------------------------
    ---- Working Table - PEarHist YTD
    -------------------------------
    IF OBJECT_ID('U_ELMSCSVUTC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELMSCSVUTC_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PgrPayGroup = MAX(PgrPayGroup)
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ELMSCSVUTC_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELMSCSVUTC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELMSCSVUTC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELMSCSVUTC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID

        ,drvUserId =    CASE WHEN ISNULL((SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername  WHERE sucEEID = xEEID),'') = '' THEN EEP.EepAddressEmail
                        ELSE (SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername  WHERE sucEEID = xEEID)
                        END
                --susUserName --EEP.EepAddressEmail
        ,drvNameFirst = EEP.EepNamePreferredOrFirst -- EEP.EepNameFirst
        ,drvNameLast = EEP.EepNameLast
        ,drvUsername = EEP.EepAddressEmail  --EEC.EecEmpNo
        ,drvManager = SUPP.eepAddressEMail
        ,drvAllowReconciliation = 'TRUE'
        ,drvEmail = EEP.EepAddressEmail
        ,drvRequiredTrainingApprov = '1'
        ,drvExempt = CASE WHEN PgrPayGroup = 'EXEMPT' THEN '1' ELSE '0' END --CASE WHEN EjhFLSACategory = 'E' THEN '1' ELSE '0' END
        ,drvOriginalHireDate = EEC.EecDateOfOriginalHire
        ,drvLastHireDate = EEC.EecDateOfLastHire
        ,drvStatus = CASE WHEN EEC.EecEmplStatus = 'A' THEN '1' ELSE '0' END
        ,drvDivision = O1.OrgCode
        ,drvJobTitle = EEC.EecJobCode
        ,drvDepartment = O2.OrgCode
        ,drvTerminationDate = EEC.EecDateOfTermination
        ,drvFullTime = CASE WHEN EEC.EecFullTimeOrPartTime = 'F' THEN '1' ELSE '0' END
        ,drvExemptPayroll = CASE WHEN PgrPayGroup = 'EXEMPT' THEN '1' ELSE '0' END -- CASE WHEN EjhFLSACategory = 'E' THEN '1' ELSE '0' END
        ,drvLocalSystemID = EecEmpNO
    /*
        -- standard fields above and additional driver fields below
        ,drvUsername = CASE WHEN ISNULL((SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername  WHERE sucEEID = xEEID),'') = '' THEN EepAddressEmail
                                ELSE (SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername  WHERE sucEEID = xEEID)
                        END
        ,drvAddressEmail = EepAddressEMail
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = ISNULL(EepNamePreferred,EepNameFirst)
        ,drvNameLast = EepNameLast
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvEmplStatus = CASE EecEmplStatus WHEN 'A' THEN '1' ELSE '0' END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvSupervisorEmail = (SELECT UPN FROM dbo.vw_ADFS_GetSSOUsers JOIN dbo.vw_rbsUserFind ON dbo.vw_ADFS_GetSSOUsers.sususername = dbo.vw_rbsUserFind.sususername 
                                WHERE SucEEID IN (SELECT EecSupervisorID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecEEID = xEEID AND EecCOID = xCOID))
        
                            --(SELECT EepAddressEMail FROM dbo.EmpPers WITH (NOLOCK) 
                                    --WHERE EepEEID IN (SELECT EecSupervisorId FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecEEID = xEEID AND EecCOID = xCOID))
        ,drvRole1 = CASE WHEN EecOrgLvl1 = 'TR' THEN 'Super Admin'
                         WHEN EecOrgLvl1 <> 'TR' THEN CASE WHEN (SELECT TOP 1 RolName FROM dbo.RbsUserRoles JOIN dbo.RbsRoles ON RurRoleID = RolID 
                                                                 WHERE RolName NOT IN ('MOBILE','HEALTHCAREMEASUREMENT','UTMUSEREMPLOYEE','PERCEPTIONADMIN') AND RurEEID = xEEID
                                                                 Order BY RurDateTimeCreated DESC) = 'MGR' THEN 'MGR'
                                                           
                                                           WHEN (SELECT TOP 1 RolName FROM dbo.RbsUserRoles JOIN dbo.RbsRoles ON RurRoleID = RolID 
                                                                 WHERE RolName NOT IN ('MOBILE','HEALTHCAREMEASUREMENT','UTMUSEREMPLOYEE','PERCEPTIONADMIN') AND RurEEID = xEEID
                                                                 AND RolDefaultRole = '0'
                                                                 Order BY RurDateTimeCreated DESC) = 'ASSTMGR' THEN 'ASSTMGR'
                                                           ELSE 'User'
                                                      END
                    END
        ,drvRole2 = CASE When EecOrgLvl1 = 'TR' THEN 'Instructor' ELSE '' END
        ,drvOrgLvl1 = (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl1 AND EecEEID = xEEID AND EecCOID = xCOID)
        ,drvOrgLvl2 = CASE WHEN EecOrgLvl1 = 'BO' THEN 
                            (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl2 AND EecEEID = xEEID AND EecCOID = xCOID AND OrgLvl = '2')
                        ELSE ''
                    END
        ,drvAdmin1 = (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl1 AND EecEEID = xEEID AND EecCOID = xCOID)
        ,drvAdmin2 = CASE WHEN EecOrgLvl1 = 'BO' THEN 
                            (SELECT TOP 1 OrgDesc From dbo.vw_int_OrgLevel JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON OrgCode = EecOrgLvl2 AND EecEEID = xEEID AND EecCOID = xCOID AND OrgLvl ='2')
                        ELSE ''
                    END
        ,drvJobTitle = JbcDesc*/
    INTO dbo.U_ELMSCSVUTC_drvTbl
    FROM dbo.U_ELMSCSVUTC_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EEC WITH (NOLOCK)
        ON EEC.EecEEID = xEEID 
        AND EEC.EecCoID = xCoID
    JOIN dbo.EmpPers EEP WITH (NOLOCK)
        ON EEP.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EEC.EecJobCode
    --LEFT JOIN dbo.vw_int_EmpComp SUP WITH (NOLOCK)
--        ON EEC.EecSupervisorId = SUP.EecEEID
    LEFT JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.eepEEID = EEC.EecSupervisorId
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON EEC.EecOrgLvl1 = O1.OrgCode
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON EEC.EecOrgLvl2 = O2.OrgCode
    LEFT JOIN dbo.vw_rbsusers WITH (NOLOCK)
        ON susUserId = EEP.EepUserId
    LEFT JOIN dbo.U_ELMSCSVUTC_PEarHist
        ON PehEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND DATEADD(DAY, 90, EecDateOfTermination) >= @EndDate)    
    ;


    DELETE dbo.U_ELMSCSVUTC_drvTbl WHERE ISNULL(drvUsername, '') = '';

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
ALTER VIEW dbo.dsi_vwELMSCSVUTC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELMSCSVUTC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELMSCSVUTC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201903061'
       ,expStartPerControl     = '201903061'
       ,expLastEndPerControl   = '201903139'
       ,expEndPerControl       = '201903139'
WHERE expFormatCode = 'ELMSCSVUTC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELMSCSVUTC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELMSCSVUTC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELMSCSVUTC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELMSCSVUTC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELMSCSVUTC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELMSCSVUTC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELMSCSVUTC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELMSCSVUTC', 'UseFileName', 'V', 'Y'


-- End ripout