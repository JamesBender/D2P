/**********************************************************************************

EPRUCIRPRE: Prudential ACC Premium Summary

FormatCode:     EPRUCIRPRE
Project:        Prudential ACC Premium Summary
Client ID:      CIR1003
Date/time:      2023-03-23 12:27:04.017
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP4DB03
Database:       ULTIPRO_WPCIRR
Web Filename:   CIR1003_B61C4_EEHISTORY_EPRUCIRPRE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPRUCIRPRE_SavePath') IS NOT NULL DROP TABLE dbo.U_EPRUCIRPRE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPRUCIRPRE'


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
WHERE FormatCode = 'EPRUCIRPRE'
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
WHERE ExpFormatCode = 'EPRUCIRPRE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPRUCIRPRE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPRUCIRPRE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPRUCIRPRE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPRUCIRPRE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPRUCIRPRE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPRUCIRPRE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPRUCIRPRE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPRUCIRPRE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPRUCIRPRE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPRUCIRPRE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPRUCIRPRE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUCIRPRE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUCIRPRE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUCIRPRE];
GO
IF OBJECT_ID('U_EPRUCIRPRE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUCIRPRE_PEarHist];
GO
IF OBJECT_ID('U_EPRUCIRPRE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUCIRPRE_PDedHist];
GO
IF OBJECT_ID('U_EPRUCIRPRE_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUCIRPRE_File];
GO
IF OBJECT_ID('U_EPRUCIRPRE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUCIRPRE_EEList];
GO
IF OBJECT_ID('U_EPRUCIRPRE_drvDepTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUCIRPRE_drvDepTbl];
GO
IF OBJECT_ID('U_EPRUCIRPRE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUCIRPRE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EPRUCIRPRE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPRUCIRPRE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPRUCIRPRE','Prudential ACC Premium Summary','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EPRUCIRPREZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUCIRPREZ0','50','H','01','1',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUCIRPREZ0','50','H','01','2',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUCIRPREZ0','50','H','01','3',NULL,'Person Id',NULL,NULL,'"Person Id "','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUCIRPREZ0','50','H','01','4',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUCIRPREZ0','50','H','01','5',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUCIRPREZ0','50','H','01','6',NULL,'Stop Date',NULL,NULL,'"Stop Date"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUCIRPREZ0','50','H','01','7',NULL,'Internal ID',NULL,NULL,'"Internal ID"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUCIRPREZ0','50','H','01','8',NULL,'Plan Code',NULL,NULL,'"Plan Code"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUCIRPREZ0','50','H','01','9',NULL,'Enrollment ID',NULL,NULL,'"Enrollment ID"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUCIRPREZ0','50','H','01','10',NULL,'Premium Amount Employee',NULL,NULL,'"Premium Amount Employee"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUCIRPREZ0','50','H','01','11',NULL,'Premium Amount Employer',NULL,NULL,'"Premium Amount Employer"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUCIRPREZ0','50','H','01','12',NULL,'Reason',NULL,NULL,'"Reason"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUCIRPREZ0','50','H','01','13',NULL,'Reason Date',NULL,NULL,'"Reason Date"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUCIRPREZ0','50','H','01','14',NULL,'Comment',NULL,NULL,'"Comment"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUCIRPREZ0','50','D','10','1',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUCIRPREZ0','50','D','10','2',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUCIRPREZ0','50','D','10','3',NULL,'Person Id',NULL,NULL,'"drvPersonId"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUCIRPREZ0','50','D','10','4',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUCIRPREZ0','50','D','10','5',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUCIRPREZ0','50','D','10','6',NULL,'Stop Date',NULL,NULL,'"drvStopDate"','(''UD101''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUCIRPREZ0','50','D','10','7',NULL,'Internal ID',NULL,NULL,'"drvInternalId"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUCIRPREZ0','50','D','10','8',NULL,'Plan Code',NULL,NULL,'"drvPlancode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUCIRPREZ0','50','D','10','9',NULL,'Enrollment ID',NULL,NULL,'"drvEnrollmentId"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUCIRPREZ0','50','D','10','10',NULL,'Premium Amount Employee',NULL,NULL,'"drvEEPremium"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUCIRPREZ0','50','D','10','11',NULL,'Premium Amount Employer',NULL,NULL,'"drvERPremium"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUCIRPREZ0','50','D','10','12',NULL,'Reason',NULL,NULL,'"drvReason"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUCIRPREZ0','50','D','10','13',NULL,'Reason Date',NULL,NULL,'"drvReasonDate"','(''UD101''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUCIRPREZ0','50','D','10','14',NULL,'Comment',NULL,NULL,'"drvComment"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPRUCIRPRE_20230323.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202212309','EMPEXPORT','OEACTIVE',NULL,'EPRUCIRPRE',NULL,NULL,NULL,'202212309','Jan  5 2023 11:08PM','Jan  5 2023 11:08PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202212309','EMPEXPORT','OEPASSIVE',NULL,'EPRUCIRPRE',NULL,NULL,NULL,'202212309','Jan  5 2023 11:08PM','Jan  5 2023 11:08PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',KD708,KD723',NULL,NULL,NULL,'Prudential ACC Premium Summary','202212309','EMPEXPORT','ONDEM_XOE',NULL,'EPRUCIRPRE',NULL,NULL,NULL,'202212309','Jan  5 2023 11:08PM','Jan  5 2023 11:08PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential ACC Premium S-Sched','202212309','EMPEXPORT','SCH_EPRUCI',NULL,'EPRUCIRPRE',NULL,NULL,NULL,'202212309','Jan  5 2023 11:08PM','Jan  5 2023 11:08PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',KD708,KD723',NULL,NULL,NULL,'Prudential ACC Premium S-Test','202302059','EMPEXPORT','TEST_XOE',NULL,'EPRUCIRPRE',NULL,NULL,NULL,'202302059','Jan  5 2023 11:08PM','Jan  5 2023 11:08PM','202301231',NULL,'','','202301231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','InitialSort','C','drvinitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','SubSort2','C','drvsubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUCIRPRE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUCIRPRE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUCIRPRE','D10','dbo.U_EPRUCIRPRE_drvDepTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPRUCIRPRE
-----------

IF OBJECT_ID('U_dsi_BDM_EPRUCIRPRE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPRUCIRPRE] (
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
-- Create table U_EPRUCIRPRE_DedList
-----------

IF OBJECT_ID('U_EPRUCIRPRE_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUCIRPRE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPRUCIRPRE_drvDepTbl
-----------

IF OBJECT_ID('U_EPRUCIRPRE_drvDepTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUCIRPRE_drvDepTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvinitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvsubsort2] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvPersonId] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvStartDate] datetime NULL,
    [drvStopDate] datetime NULL,
    [drvInternalId] varchar(3) NULL,
    [drvPlancode] varchar(4) NULL,
    [drvEnrollmentId] varchar(1) NOT NULL,
    [drvEEPremium] varchar(30) NULL,
    [drvERPremium] varchar(30) NULL,
    [drvReason] varchar(1) NOT NULL,
    [drvReasonDate] varchar(1) NOT NULL,
    [drvComment] varchar(3) NULL
);

-----------
-- Create table U_EPRUCIRPRE_EEList
-----------

IF OBJECT_ID('U_EPRUCIRPRE_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUCIRPRE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRUCIRPRE_File
-----------

IF OBJECT_ID('U_EPRUCIRPRE_File') IS NULL
CREATE TABLE [dbo].[U_EPRUCIRPRE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EPRUCIRPRE_PDedHist
-----------

IF OBJECT_ID('U_EPRUCIRPRE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRUCIRPRE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhDedCode] char(5) NOT NULL,
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

-----------
-- Create table U_EPRUCIRPRE_PEarHist
-----------

IF OBJECT_ID('U_EPRUCIRPRE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRUCIRPRE_PEarHist] (
    [PehEEID] char(12) NOT NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUCIRPRE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cirrus

Created By: Marco Lagrosa
Business Analyst: Katherine Ricca
Create Date: 01/05/2023
Service Request Number: SR-2016-00012345

Purpose: Prudential ACC Premium Summary

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        03/23/23       TekP-2022-11-04-03  Made multiple changes to code - Corrected Dedcode and switched from using bca table to using Empded    
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUCIRPRE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUCIRPRE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUCIRPRE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUCIRPRE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUCIRPRE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUCIRPRE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUCIRPRE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUCIRPRE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUCIRPRE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUCIRPRE', 'SCH_EPRUCI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUCIRPRE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPRUCIRPRE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPRUCIRPRE';

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
    DELETE FROM dbo.U_EPRUCIRPRE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUCIRPRE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCDT,CIEE,CISP,CICH,HSPTH'; -- HSPTH was missing the P so deduction was not pulling

    IF OBJECT_ID('U_EPRUCIRPRE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUCIRPRE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUCIRPRE_DedList
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

    -- EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode; MW commented out since it was not pulling correct amounts

    --MW Commented out working tables as were not being used
    
    ----==========================================
    ---- Build Working Tables
    ----==========================================

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_EPRUCIRPRE_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EPRUCIRPRE_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    ,PdhDedCode
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EPRUCIRPRE_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EPRUCIRPRE_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID,PdhDedcode
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    --IF OBJECT_ID('U_EPRUCIRPRE_PEarHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EPRUCIRPRE_PEarHist;
    --SELECT DISTINCT
    --     PehEEID
    --    ,PrgPayDate             = MAX(PrgPayDate)
    --    -- Current Payroll Amount/Hours
    --    ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --    ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --    -- YTD Payroll Amount/Hours
    --    ,PehCurAmtYTD           = SUM(PehCurAmt)
    --    ,PehCurHrsYTD           = SUM(PehCurHrs)
    --    -- Current Include Deferred Comp Amount/Hours
    --    ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --    ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --    -- YTD Include Deferred Comp Amount/Hours
    --    ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --    ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    --INTO dbo.U_EPRUCIRPRE_PEarHist
    --FROM dbo.vw_int_PayReg WITH (NOLOCK)
    --JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --    ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUCIRPRE_drvDepTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUCIRPRE_drvDepTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUCIRPRE_drvDepTbl;


        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvinitialSort = eepSSN
        ,drvSubsort = ''
        ,drvsubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvPersonId = eecEmpNo
        ,drvSSN = eepSSN
        ,drvStartDate = bdmbenstartdate
        ,drvStopDate = bdmbenstopdate
        ,drvInternalId = dedcode
        ,drvPlancode =  CASE WHEN dedcode in ('CI') THEN '6382'
                             WHEN dedcode = 'ATB' AND bdmbenoption in ('HPEE','HPEEC','HPEES','HPEEF') THEN '6380' 
                             WHEN dedcode = 'ATB' AND bdmbenoption in ('LPEE','LPEEC','LPEES','LPEEF') THEN '6381' 
                             WHEN dedcode = 'HIP' AND bdmbenoption in ('HPEE','HPEEC','HPEES','HPEEF') THEN '6494'
                             WHEN dedcode = 'HIP' AND bdmbenoption in ('LPEE','LPEEC','LPEES','LPEEF') THEN '6384'
                        END
        ,drvEnrollmentId = ''
        ,drvEEPremium =  CAST(EEAmount as varchar)
        ,drvERPremium =  CAST(ERAmount as varchar)
        ,drvReason = ''
        ,drvReasonDate = ''
        ,drvComment = CASE WHEN eecpayperiod  = 'W' THEN '001'
                           WHEN eecpayperiod  = 'B' THEN '002'
                       END
    INTO dbo.U_EPRUCIRPRE_drvDepTbl
    FROM dbo.U_EPRUCIRPRE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID
    AND EecCOID = xCOID
    JOIN (Select bdmcoid
                ,bdmeeid  
                ,bdmbenoption = max(bdmbenoption) 
                ,dedcode =  CASE WHEN bdmdedcode = 'ACCDT' THEN 'ATB' 
                                 WHEN bdmdedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
                                 WHEN bdmdedcode = 'HSPTH' THEN 'HIP'                        
                              END 
                ,bdmbenstartdate = max(bdmbenstartdate)  
                ,bdmbenstopdate  = max(bdmbenstopdate)  
                FROM dbo.U_dsi_BDM_EPRUCIRPRE WITH (NOLOCK) 
                GROUP BY bdmcoid
                        ,bdmeeid
                        ,CASE WHEN  bdmdedcode = 'ACCDT' THEN 'ATB' 
                              WHEN bdmdedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
                              WHEN bdmdedcode = 'HSPTH'THEN 'HIP'                             
                        END
                        ) as FlatBDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (     select eedeeid
                  ,eedcoid
                  ,Plancode = CASE WHEN eeddedcode = 'ACCDT' THEN 'ATB' 
                                   WHEN eeddedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
                                   WHEN eeddedcode = 'HSPTH' THEN 'HIP'                             
                                 END 
                ,EEAmount = sum(EedEELstAmt) 
                ,ERAmount = SUM(EedERLstAmt)
                FROM dbo.empdedfull WITH (NOLOCK)
        WHERE eeddedcode in ('CICH', 'CIEE', 'CISP', 'HSPTH' ,'ACCDT') 
        group by eedeeid
                ,eedcoid
                ,CASE WHEN eeddedcode = 'ACCDT' THEN 'ATB' 
                      WHEN eeddedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
                      WHEN eeddedcode = 'HSPTH' THEN 'HIP'
                    END 
            ) as AmtData
        on eedeeid = bdmeeid
        AND eedcoid =  bdmcoid
        AND Plancode = dedcode


    ---    MW Changed to pull correct Amounts 3/23/23
  --  SELECT DISTINCT
  --       drvEEID = xEEID
  --      ,drvCoID = xCoID
  --      ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
  --      ,drvinitialSort = eepSSN
  --      ,drvSubsort = ''
  --      ,drvsubsort2 = ''
  --      -- standard fields above and additional driver fields below
  --      ,drvLastName = EepNameLast
  --      ,drvFirstName = EepNameFirst
  --      ,drvPersonId = eecEmpNo
  --      ,drvSSN = eepSSN
  --      ,drvStartDate = bdmbenstartdate
  --      ,drvStopDate = bdmbenstopdate
  --      ,drvInternalId = dedcode
  --      ,drvPlancode =  CASE WHEN  dedcode = 'ATB' and bdmbenoption in ('HPEE','HPEEC','HPEES','HPEEF') THEN '6380' 
        --                     WHEN   dedcode = 'ATB' and bdmbenoption in ('LPEE','LPEEC','LPEES','LPEEF') THEN '6381' 
        --                      WHEN dedcode in ('CI') THEN '6382'
        --                     WHEN dedcode = 'HIP' and bdmbenoption in ('HPEE','HPEEC','HPEES','HPEEF') THEN '6494'
        --                     WHEN dedcode = 'HIP' and bdmbenoption in ('LPEE','LPEEC','LPEES','LPEEF') THEN '6384'
        --                END
  --      ,drvEnrollmentId = ''
  --      ,drvEEPremium = CAST(case when code = 'ATB' THEN EEAmount
        --when code = 'CI' THEN EEAmount
        --when code = 'HIP' THEN EEAmount
        --                        END
        --                    as varchar)
  --      ,drvERPremium =  CAST(case when code = 'ATB' THEN ERAmount
        --when code = 'CI' THEN ERAmount
        --when code = 'HIP' THEN ERAmount
        --                        END
        --                    as varchar)
  --      ,drvReason = ''
  --      ,drvReasonDate = ''
  --      ,drvComment = CASE WHEN eecpayperiod  = 'W' THEN '001'
        --                 WHEN eecpayperiod  = 'B' THEN '002'
        --            END
  --  INTO dbo.U_EPRUCIRPRE_drvDepTbl
  --  FROM dbo.U_EPRUCIRPRE_EEList WITH (NOLOCK)
  --  JOIN dbo.EmpPers WITH (NOLOCK)
  --      ON EepEEID = xEEID
  --  JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
  --  ON EecEEID = xEEID
  --  AND EecCOID = xCOID
  --  JOIN (Select bdmcoid,bdmeeid,  max(bdmbenoption) as bdmbenoption, CASE WHEN  bdmdedcode = 'ACCDT' THEN 'ATB' 
        --                      WHEN bdmdedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
        --                     WHEN bdmdedcode = 'HSPTH'THEN 'HIP'
                            
        --                END as dedcode,
        --                max(bdmbenstartdate) as bdmbenstartdate,
        --                        max(bdmbenstopdate) as bdmbenstopdate

        --                from U_dsi_BDM_EPRUCIRPRE group by 
        --                bdmcoid,bdmeeid,CASE WHEN  bdmdedcode = 'ACCDT' THEN 'ATB' 
        --                      WHEN bdmdedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
        --                     WHEN bdmdedcode = 'HSPTH' THEN 'HIP'
                             
        --                END
        --                ) as FlatBDM
  --      ON BdmEEID = xEEID 
  --      AND BdmCoID = xCoID
  --  JOIN (
    
        --select CASE WHEN  bcadedcode = 'ACCDT' THEN 'ATB' 
        --                      WHEN bcadedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
        --                     WHEN bcadedcode = 'HSPTH' THEN 'HIP'
        --                END as code,sum(BcaEEAmt) as EEAmount,
        --                sum(BcaERAmt) as ERAmount,
        --        bcaeeid,bcacoid from 
                

        --dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        --where bcaformatcode  = @FormatCode
        --group by bcaeeid,bcacoid,CASE WHEN  bcadedcode = 'ACCDT' THEN 'ATB' 
        --                      WHEN bcadedcode in ('CICH', 'CIEE', 'CISP') THEN 'CI'
        --                     WHEN bcadedcode = 'HSPTH' THEN 'HIP'
        --                END) as BcaData
  --      on BcaData.BcaEEID = bdmeeid
        --and bcadata.bcacoid  =  bdmcoid
        --and bcadata.code = dedcode
    
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
ALTER VIEW dbo.dsi_vwEPRUCIRPRE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUCIRPRE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EPRUCIRPRE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202212301'
       ,expStartPerControl     = '202212301'
       ,expLastEndPerControl   = '202212309'
       ,expEndPerControl       = '202212309'
WHERE expFormatCode = 'EPRUCIRPRE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRUCIRPRE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPRUCIRPRE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPRUCIRPRE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPRUCIRPRE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPRUCIRPRE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRUCIRPRE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPRUCIRPRE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRUCIRPRE', 'UseFileName', 'V', 'Y'


-- End ripout