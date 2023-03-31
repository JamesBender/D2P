/**********************************************************************************

EFLOCOBEXP: Flores QB Export

FormatCode:     EFLOCOBEXP
Project:        Flores QB Export
Client ID:      FRO1009
Date/time:      2023-03-30 11:31:12.320
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP1DB04
Database:       ULTIPRO_WPFARI
Web Filename:   FRO1009_DKHT7_EEHISTORY_EFLOCOBEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFLOCOBEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EFLOCOBEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFLOCOBEXP'


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
WHERE FormatCode = 'EFLOCOBEXP'
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
WHERE ExpFormatCode = 'EFLOCOBEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFLOCOBEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFLOCOBEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFLOCOBEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFLOCOBEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFLOCOBEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFLOCOBEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFLOCOBEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFLOCOBEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFLOCOBEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFLOCOBEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFLOCOBEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFLOCOBEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFLOCOBEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLOCOBEXP];
GO
IF OBJECT_ID('U_EFLOCOBEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_PEarHist];
GO
IF OBJECT_ID('U_EFLOCOBEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_PDedHist];
GO
IF OBJECT_ID('U_EFLOCOBEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_File];
GO
IF OBJECT_ID('U_EFLOCOBEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_EEList];
GO
IF OBJECT_ID('U_EFLOCOBEXP_drvInsured') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_drvInsured];
GO
IF OBJECT_ID('U_EFLOCOBEXP_drvElectionTbl') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_drvElectionTbl];
GO
IF OBJECT_ID('U_EFLOCOBEXP_drvDepTbl') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_drvDepTbl];
GO
IF OBJECT_ID('U_EFLOCOBEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFLOCOBEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFLOCOBEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFLOCOBEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFLOCOBEXP','Flores QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EFLOCOBEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLOCOBEXPZ0','50','D','10','1',NULL,'Insured Identifier',NULL,NULL,'"1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLOCOBEXPZ0','50','D','10','2',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLOCOBEXPZ0','50','D','10','3',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLOCOBEXPZ0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLOCOBEXPZ0','50','D','10','5',NULL,'Street Address Line 1',NULL,NULL,'"drvStreetAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFLOCOBEXPZ0','50','D','10','6',NULL,'Street Address Line 2',NULL,NULL,'"drvStreetAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFLOCOBEXPZ0','50','D','10','7',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFLOCOBEXPZ0','50','D','10','8',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFLOCOBEXPZ0','50','D','10','9',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFLOCOBEXPZ0','50','D','10','10',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFLOCOBEXPZ0','50','D','10','11',NULL,'Email address',NULL,NULL,'"drvEmailaddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFLOCOBEXPZ0','50','D','10','12',NULL,'Birth date',NULL,NULL,'"drvBirthdate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFLOCOBEXPZ0','50','D','10','13',NULL,'State',NULL,NULL,'"drvStateEmp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFLOCOBEXPZ0','50','D','10','14',NULL,'Type of Event',NULL,NULL,'"drvTypeofEvent"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFLOCOBEXPZ0','50','D','10','15',NULL,'Date of Event',NULL,NULL,'"drvDateofEvent"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFLOCOBEXPZ0','50','D','10','16',NULL,'Benefit Stop Date',NULL,NULL,'"drvBenefitStopDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFLOCOBEXPZ0','50','D','10','17',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFLOCOBEXPZ0','50','D','10','18',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLOCOBEXPZ0','50','D','20','1',NULL,'Dependent Identifier',NULL,NULL,'"2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLOCOBEXPZ0','50','D','20','2',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLOCOBEXPZ0','50','D','20','3',NULL,'Dependent Number',NULL,NULL,'"drvDependentNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLOCOBEXPZ0','50','D','20','4',NULL,'Dependent First Name',NULL,NULL,'"drvDependentFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLOCOBEXPZ0','50','D','20','5',NULL,'Dependent Last Name',NULL,NULL,'"drvDependentLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFLOCOBEXPZ0','50','D','20','6',NULL,'Relation to Insured',NULL,NULL,'"drvRelationtoInsured"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFLOCOBEXPZ0','50','D','20','7',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFLOCOBEXPZ0','50','D','20','8',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLOCOBEXPZ0','50','D','30','1',NULL,'Election Identifier',NULL,NULL,'"3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLOCOBEXPZ0','50','D','30','2',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLOCOBEXPZ0','50','D','30','3',NULL,'Dependent Number',NULL,NULL,'"drvDependentNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLOCOBEXPZ0','50','D','30','4',NULL,'Plan Code Enrolled In',NULL,NULL,'"drvPlanCodeEnrolledIn"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLOCOBEXPZ0','50','D','30','5',NULL,'Monthly Premium',NULL,NULL,'"drvMonthlyPremium"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFLOCOBEXP_20230330.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202302079','EMPEXPORT','OEACTIVE','Feb 12 2023 12:00AM','EFLOCOBEXP',NULL,NULL,NULL,'202302079','Feb  7 2023 12:00AM','Dec 30 1899 12:00AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'us3mLaFRO1009',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202302079','EMPEXPORT','OEPASSIVE',NULL,'EFLOCOBEXP',NULL,NULL,NULL,'202302079','Feb  7 2023 10:54PM','Feb  7 2023 10:54PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores QB Export','202302079','EMPEXPORT','ONDEM_XOE',NULL,'EFLOCOBEXP',NULL,NULL,NULL,'202302079','Feb  7 2023 10:54PM','Feb  7 2023 10:54PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores QB Export-Sched','202302079','EMPEXPORT','SCH_EFLOCO',NULL,'EFLOCOBEXP',NULL,NULL,NULL,'202302079','Feb  7 2023 10:54PM','Feb  7 2023 10:54PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OIGIH',NULL,NULL,NULL,'Flores QB Export-Test','202303209','EMPEXPORT','TEST_XOE','Feb 12 2023 11:25AM','EFLOCOBEXP',NULL,NULL,NULL,'202303209','Feb  7 2023 12:00AM','Dec 30 1899 12:00AM','202303071','347','','','202303071',dbo.fn_GetTimedKey(),NULL,'us3mLaFRO1009',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLOCOBEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLOCOBEXP','D10','dbo.U_EFLOCOBEXP_drvInsured',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLOCOBEXP','D20','dbo.U_EFLOCOBEXP_drvDepTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLOCOBEXP','D30','dbo.U_EFLOCOBEXP_drvElectionTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFLOCOBEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EFLOCOBEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFLOCOBEXP] (
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
-- Create table U_EFLOCOBEXP_DedList
-----------

IF OBJECT_ID('U_EFLOCOBEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFLOCOBEXP_drvDepTbl
-----------

IF OBJECT_ID('U_EFLOCOBEXP_drvDepTbl') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_drvDepTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(12) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] bigint NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvDependentNumber] bigint NULL,
    [drvDependentFirstName] varchar(101) NULL,
    [drvDependentLastName] varchar(101) NULL,
    [drvRelationtoInsured] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvGender] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLOCOBEXP_drvElectionTbl
-----------

IF OBJECT_ID('U_EFLOCOBEXP_drvElectionTbl') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_drvElectionTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(12) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] bigint NULL,
    [drvSubSort3] bigint NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvDependentNumber] bigint NULL,
    [drvPlanCodeEnrolledIn] varchar(4) NULL,
    [drvMonthlyPremium] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLOCOBEXP_drvInsured
-----------

IF OBJECT_ID('U_EFLOCOBEXP_drvInsured') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_drvInsured] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(12) NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvLastName] varchar(101) NULL,
    [drvFirstName] varchar(101) NULL,
    [drvStreetAddressLine1] varchar(255) NULL,
    [drvStreetAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvPhoneNumber] varchar(1) NOT NULL,
    [drvEmailaddress] varchar(50) NULL,
    [drvBirthdate] datetime NULL,
    [drvStateEmp] varchar(255) NULL,
    [drvTypeofEvent] varchar(2) NOT NULL,
    [drvDateofEvent] datetime NULL,
    [drvBenefitStopDate] datetime NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL
);

-----------
-- Create table U_EFLOCOBEXP_EEList
-----------

IF OBJECT_ID('U_EFLOCOBEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFLOCOBEXP_File
-----------

IF OBJECT_ID('U_EFLOCOBEXP_File') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EFLOCOBEXP_PDedHist
-----------

IF OBJECT_ID('U_EFLOCOBEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_PDedHist] (
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

-----------
-- Create table U_EFLOCOBEXP_PEarHist
-----------

IF OBJECT_ID('U_EFLOCOBEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFLOCOBEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLOCOBEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Froehling & Robertson Inc

Created By: Marco Lagrosa
Business Analyst: Curlin Beck/Katherine ricca
Create Date: 02/07/2023
Service Request Number: TekP-2023-01-18-04

Purpose: Flores QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        03/17/2023       TekP-2023-01-18-04 Updated the mapping for plan codes Added Indentifiers to each driver table, removed unnecessay sort fields and updated sort 
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFLOCOBEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFLOCOBEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFLOCOBEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFLOCOBEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFLOCOBEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLOCOBEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLOCOBEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLOCOBEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLOCOBEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLOCOBEXP', 'SCH_EFLOCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFLOCOBEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFLOCOBEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFLOCOBEXP';

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
    DELETE FROM dbo.U_EFLOCOBEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFLOCOBEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED,MEDD,HSA,HSAD,DEN,VIS,FSA'; -- EAP';

    IF OBJECT_ID('U_EFLOCOBEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFLOCOBEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFLOCOBEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);


     -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    
    --   --==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EFLOCOBEXP]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmBenOption]

    )
 Select rectype = 'DEP', dbnCoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey desc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'204'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END, edhbenoption 
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
            WHERE edhChangeReason in ('204') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
                and dbnrunid  = 'QB'
                        Group by dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption


INSERT INTO [dbo].[U_dsi_BDM_EFLOCOBEXP]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey desc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'201'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('201') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
            ----
            /*
            INSERT INTO [dbo].[U_dsi_BDM_EFLOCOBEXP]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 302 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'302'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('302') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
    */
        
    Delete from dbo.U_dsi_BDM_EFLOCOBEXP where bdmdedcode not in (Select dedcode from U_EFLOCOBEXP_DedList)

    Update dbo.U_dsi_BDM_EFLOCOBEXP  
    set bdmNumSpouses = (select count(*) from U_dsi_BDM_EFLOCOBEXP A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid)
    ,bdmNumChildren = (select count(*) from U_dsi_BDM_EFLOCOBEXP A where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
    from dbo.U_dsi_BDM_EFLOCOBEXP  X

    where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason');


    Delete from dbo.U_dsi_BDM_EFLOCOBEXP   where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason') and bdmbenoption is null

    
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFLOCOBEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFLOCOBEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EFLOCOBEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFLOCOBEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EFLOCOBEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFLOCOBEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
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
    INTO dbo.U_EFLOCOBEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFLOCOBEXP_drvInsured
    ---------------------------------
    IF OBJECT_ID('U_EFLOCOBEXP_drvInsured','U') IS NOT NULL
        DROP TABLE dbo.U_EFLOCOBEXP_drvInsured;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  xEEID
        ,drvSubSort =  eepSSN
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeIDNumber = eepSSN
        ,drvLastName = CASE WHEN (BDMChangeReason IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason IN ('201','LEVNT3') or EecTermReason = '203') THEN  ConNameLast ELSE EepNameLast END
        ,drvFirstName = CASE WHEN (BDMChangeReason IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason IN ('201','LEVNT3') or EecTermReason = '203') THEN  ConNameFirst ELSE EepNameFirst END 
        ,drvStreetAddressLine1 = EepAddressLine1
        ,drvStreetAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipcode
        ,drvPhoneNumber = ''
        ,drvEmailaddress = EepAddressEMail
        ,drvBirthdate = CASE WHEN (BDMChangeReason IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason IN ('201','LEVNT3') or EecTermReason = '203') THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvStateEmp = EepAddressState
        ,drvTypeofEvent =  CASE 
                                  WHEN EecTermReason = '203' THEN '3'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') or BdmChangereason IN ('201','LEVNT3')  THEN '5'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') or BdmChangereason IN ('204','LEVNT4')  THEN '4'                                  
                                  WHEN BdmCobraReason = '210' or BdmChangereason = '210' THEN '3'
                                  WHEN BdmCobraReason IN ('203','202') THEN '2'
                                  WHEN BdmCobraReason = '205' THEN '6'
                                  WHEN BdmCobraReason = '206' THEN '2'
                                  WHEN BdmCobraReason IN ('208') or BdmChangereason IN ('208')  or EecTermReason = '202' THEN '1'
                                  WHEN BdmCobraReason = '209' THEN '2'
                                  WHEN EecEmplStatus = 'T' and eectermtype  = 'I' THEN '10'
                                  ELSE '1'
                             END
        ,drvDateofEvent = BdmDateOfCOBRAEvent
        ,drvBenefitStopDate = BdmDateOfCOBRAEvent
        ,drvLocation = ''
        ,drvGender = CASE WHEN (BDMChangeReason IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason IN ('201','LEVNT3') or EecTermReason = '203') AND ConGender  = 'M' THEN 'M' --MW Added 3/17/23 -- MW 3/30/2023  changed from Male to M
                          WHEN( BDMChangeReason IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason IN ('201','LEVNT3') or EecTermReason = '203' )AND ConGender = 'F' THEN 'F' --MW Added 3/17/23 -- MW 3/30/2023 changed from Female to F
                          WHEN (BDMChangeReason NOT IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason NOT IN ('201','LEVNT3') or EecTermReason <> '203' ) AND EepGender = 'M' then 'M'            --Added Employee Gender 2023/02/20 CB  -- MW 3/30/2023  changed from Male to M
                          WHEN (BDMChangeReason NOT IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason NOT IN ('201','LEVNT3') or EecTermReason <> '203')  AND EepGender = 'F' then 'F'                                                   -- MW 3/30/2023 changed from Female to F
                          Else ' ' END
    INTO dbo.U_EFLOCOBEXP_drvInsured
    FROM dbo.U_EFLOCOBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT
                     BdmEEID
                    ,BdmCoID
                    ,BdmDepRecID
                    ,BdmRecType
                    ,BdmCobraReason = MAX(BdmCobraReason)
                    ,BdmChangereason = MAX(BdmChangereason)
                    ,BdmBenStartDate = MIN(BdmBenStartDate)
                    ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                    ,BdmUSGDate1 = MAX(BdmUSGDate1)
                    ,BdmBenStatusDate = MAX(BdmBenStatusDate)
                  FROM dbo.U_dsi_BDM_EFLOCOBEXP WITH (NOLOCK)
                  WHERE BdmIsPQB = 'Y'
                  GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType
          ) BDM
        ON BdmEEID = xeeid
       AND BdmCoID = xcoid
        LEFT  JOIN ( SELECT DISTINCT ConEEID, ConSystemId, UPPER(LEFT(ConNameFirst,1))+LOWER(SUBSTRING(ConNameFirst,2,LEN(ConNameFirst))) AS ConNameFirst, UPPER(LEFT(ConNameLast,1))+LOWER(SUBSTRING(ConNameLast,2,LEN(ConNameLast))) as ConNameLast, ConDateOfBirth, ConGender,conrelationship, ConSSN, ROW_NUMBER() OVER(PARTITION BY ConEEID ORDER BY ConDateOfBirth) AS RN --MW added  3/17/23
            FROM (
                    SELECT DISTINCT  ConEEID, ConSystemId, ConNameFirst, ConNameLast, ConDateOfBirth, ConGender , conrelationship, ConSSN--, ROW_NUMBER() OVER(PARTITION BY ConEEID ORDER BY ConDateOfBirth) AS RN
                                FROM dbo.Contacts WITH (NOLOCK)
                                JOIN dbo.U_dsi_BDM_EFLOCOBEXP iBdm WITH (NOLOCK)
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                             
                                  ) NumberedCon) Con

        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecId
   
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLOCOBEXP_drvDepTbl
    ---------------------------------
    IF OBJECT_ID('U_EFLOCOBEXP_drvDepTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFLOCOBEXP_drvDepTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =xEEID
        ,drvSubSort = eepssn --RN --MW changed 3/17/23
        --CASE WHEN BdmRecType = 'EMP' THEN eepSSN
  --                                ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
  --                           END
        ,drvSubSort2 = RN --MW changed 3/17/23
        --CASE WHEN BdmRecType = 'EMP' THEN eepSSN
  --                                ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
  --                           END
        --ROW_NUMBER() OVER (
  --          PARTITION BY bdmeeid,bdmcoid order by CASE bdmrelationship
  --                           WHEN 'SPS' THEN '1'
                            
  --                           ELSE '9'
  --                    END)
        ,drvSubSort3 = ''
        --CASE WHEN BdmRecType = 'EMP' THEN '2'
  --                               ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
  --                           END
      --  ,RowNum = ''
        --ROW_NUMBER() OVER (
  --          PARTITION BY bdmeeid,bdmcoid order by CASE bdmrelationship
  --                           WHEN 'SPS' THEN '1'
                            
  --                           ELSE '9'
  --                    END)
        -- standard fields above and additional driver fields below
        ,drvEmployeeIDNumber =  CASE WHEN (BDMChangeReason IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason IN ('201','LEVNT3') or EecTermReason = '203') THEN Conssn --MW updated
                                     WHEN (BDMChangeReason NOT IN ('201','204','210','LEVNT3','LEVNT4') or BdmCobraReason NOT IN ('201','LEVNT3') or EecTermReason <> '203') THEN  EepSSN END --MW updated 
        ,drvDependentNumber = RN
        ,drvDependentFirstName = ConNameFirst
        ,drvDependentLastName = ConNameLast
        ,drvRelationtoInsured = Case WHEN Conrelationship in ('SPS','DP') THEN 'S'
                                     WHEN Conrelationship in ('CHL' ,'DPC','STC') THEN 'C'
                                ELSE 'O'
                                END

        ,drvDateofBirth = ConDateOfBirth
        ,drvGender = CASE When ConGender = 'M' THEN 'M'    --Added Dependent Gender 2023/02/20 CB -- MW 3/30/2023 changed from Male to M
                          When ConGender = 'F' THEN 'F' -- MW 3/30/2023 changed from Female to F
                          Else ' ' END
    INTO dbo.U_EFLOCOBEXP_drvDepTbl
    FROM dbo.U_EFLOCOBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
       JOIN (   SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmChangereason = MAX(BdmChangereason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
            ,BdmBenStatusDate = MAX(BdmBenStatusDate)
            ,bdmrelationship = MAX(bdmrelationship)
          FROM dbo.U_dsi_BDM_EFLOCOBEXP WITH (NOLOCK)
          WHERE BdmIsPQB = 'N' 
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) as bdm
          on bdmeeid =  xeeid
          and bdmcoid  = xcoid
    --JOIN dbo.Contacts WITH (NOLOCK) --MW commented out and replaced with Join below
    --    ON ConEEID = BdmEEID
    --   AND ConSystemID = BdmDepRecID
      JOIN ( SELECT DISTINCT ConEEID, ConSystemId, UPPER(LEFT(ConNameFirst,1))+LOWER(SUBSTRING(ConNameFirst,2,LEN(ConNameFirst))) AS ConNameFirst, UPPER(LEFT(ConNameLast,1))+LOWER(SUBSTRING(ConNameLast,2,LEN(ConNameLast))) as ConNameLast, ConDateOfBirth, ConGender,conrelationship, ConSSN, ROW_NUMBER() OVER(PARTITION BY ConEEID ORDER BY ConDateOfBirth) AS RN --MW added  3/17/23
            FROM (
                    SELECT DISTINCT  ConEEID, ConSystemId, ConNameFirst, ConNameLast, ConDateOfBirth, ConGender , conrelationship, ConSSN--, ROW_NUMBER() OVER(PARTITION BY ConEEID ORDER BY ConDateOfBirth) AS RN
                                FROM dbo.Contacts WITH (NOLOCK)
                                JOIN dbo.U_dsi_BDM_EFLOCOBEXP iBdm WITH (NOLOCK)
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                             
                                  ) NumberedCon) Con

        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecId

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFLOCOBEXP_drvElectionTbl
    ---------------------------------
    IF OBJECT_ID('U_EFLOCOBEXP_drvElectionTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFLOCOBEXP_drvElectionTbl;
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),ConSystemId) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = xEEID -- eepssn
        ,drvSubSort = eepssn -- + CASE WHEn ConEEID  IS not null then ISNULL(RN, 0)  END--CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                 -- ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                            -- END
         ,drvSubSort2 =   
                                 CASE WHEN BdmDedCode in ('MED', 'MEDD','MED2') and BdmBenOption = 'EE' THEN '3010'   -- MW updated 3/15/23
                                      WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EES' THEN '3011'
                                      WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EEC' THEN '3012'
                                      WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EEF' THEN '3013'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EE') THEN  '4015'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EES', 'EEDP') THEN  '4016'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EEC') THEN  '4017'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EEF', 'EEDPF') THEN  '4018'                                       
                                      WHEN BdmDedCode in ('DEN') and BdmBenOption in ('EE') THEN  '5020'
                                      WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EES') THEN  '5021'
                                      WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EEC') THEN  '5022'
                                      WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EEF', 'EEDPF') THEN  '5023'
                                      WHEN BdmDedCode in ('VIS') and BdmBenOption in ('EE') THEN  '7030'
                                      WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EES') THEN  '7031'
                                      WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EEC') THEN  '7032'
                                      WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EEF', 'EEDPF') THEN  '7033'
                                      WHEN BdmDedCode in ('FSA') THEN '8001'
                                END + ISNULL(RN, 0)
    
        ,drvSubSort3 =ISNULL(RN, 0)
        -- standard fields above and additional driver fields below
        ,drvEmployeeIDNumber = eepssn
        ,drvDependentNumber = RN --MW chnaged 3/17/23
         --ROW_NUMBER() OVER (
   --         PARTITION BY bdmeeid,bdmcoid order by CASE bdmrelationship
   --                          WHEN 'SPS' THEN '1'
                            
   --                          ELSE '9'
   --                   END)
        ,drvPlanCodeEnrolledIn =  CASE WHEN BdmDedCode in ('MED', 'MEDD','MED2') and BdmBenOption = 'EE' THEN '3010'   -- MW updated 3/15/23
                                      WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EES' THEN '3011'
                                      WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EEC' THEN '3012'
                                      WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EEF' THEN '3013'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EE') THEN  '4015'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EES', 'EEDP') THEN  '4016'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EEC') THEN  '4017'
                                      WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EEF', 'EEDPF') THEN  '4018'                                       
                                      WHEN BdmDedCode in ('DEN') and BdmBenOption in ('EE') THEN  '5020'
                                      WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EES') THEN  '5021'
                                      WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EEC') THEN  '5022'
                                      WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EEF', 'EEDPF') THEN  '5023'
                                      WHEN BdmDedCode in ('VIS') and BdmBenOption in ('EE') THEN  '7030'
                                      WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EES') THEN  '7031'
                                      WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EEC') THEN  '7032'
                                      WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EEF', 'EEDPF') THEN  '7033'
                                      WHEN BdmDedCode in ('FSA') THEN '8001'
                                END
 

        ,drvMonthlyPremium = ''
    INTO dbo.U_EFLOCOBEXP_drvElectionTbl
    FROM dbo.U_EFLOCOBEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            --and EecEEID = 'DP5CVJ000050'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFLOCOBEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN ( SELECT DISTINCT ConEEID, ConSystemId, ConNameFirst, ConNameLast, ConDateOfBirth, ConGender,conrelationship, ROW_NUMBER() OVER(PARTITION BY ConEEID ORDER BY ConDateOfBirth) AS RN --MW Added 3/17/23
            FROM (
                    SELECT DISTINCT  ConEEID, ConSystemId, ConNameFirst, ConNameLast, ConDateOfBirth, ConGender , conrelationship
                                FROM dbo.Contacts WITH (NOLOCK)
                                JOIN dbo.U_dsi_BDM_EFLOCOBEXP iBdm WITH (NOLOCK)
                                    ON iBdm.BdmEEID = ConEEID
                                    AND iBdm.BdmDepRecID = ConSystemId
                                    AND iBdm.BdmRunId = 'QB'
                                    AND iBdm.BdmRecType = 'DEP'
                             
                                  ) NumberedCon) Con

        ON ConEEID = xEEID
        AND ConSystemId = BdmDepRecId

        order by eepssn
                ,CASE WHEN BdmDedCode in ('MED', 'MEDD','MED2') and BdmBenOption = 'EE' THEN '3010'   -- MW updated 3/15/23
                   WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EES' THEN '3011'
                   WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EEC' THEN '3012'
                   WHEN BdmDedCode in ('MED', 'MEDD') and BdmBenOption = 'EEF' THEN '3013'
                   WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EE') THEN  '4015'
                   WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EES', 'EEDP') THEN  '4016'
                   WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EEC') THEN  '4017'
                   WHEN BdmDedCode in ('HSA', 'HSAD') and BdmBenOption in ('EEF', 'EEDPF') THEN  '4018'                                       
                   WHEN BdmDedCode in ('DEN') and BdmBenOption in ('EE') THEN  '5020'
                   WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EES') THEN  '5021'
                   WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EEC') THEN  '5022'
                   WHEN BdmDedCode in ('DEN')  and BdmBenOption in ('EEF', 'EEDPF') THEN  '5023'
                   WHEN BdmDedCode in ('VIS') and BdmBenOption in ('EE') THEN  '7030'
                   WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EES') THEN  '7031'
                   WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EEC') THEN  '7032'
                   WHEN BdmDedCode in ('VIS')  and BdmBenOption in ('EEF', 'EEDPF') THEN  '7033'
                   WHEN BdmDedCode in ('FSA') THEN '8001'
                  END
                ,RN


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
ALTER VIEW dbo.dsi_vwEFLOCOBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLOCOBEXP_File (NOLOCK)
        ORDER BY InitialSort,subsort2,Subsort3,  RecordSet;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFLOCOBEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301311'
       ,expStartPerControl     = '202301311'
       ,expLastEndPerControl   = '202303179'
       ,expEndPerControl       = '202303179'
WHERE expFormatCode = 'EFLOCOBEXP' and expexportcode ='TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFLOCOBEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLOCOBEXP_File (NOLOCK)
        ORDER BY  RecordSet, InitialSort, subsort2 , subsort3;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFLOCOBEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFLOCOBEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFLOCOBEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLOCOBEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFLOCOBEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLOCOBEXP', 'UseFileName', 'V', 'Y'


-- End ripout