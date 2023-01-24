/**********************************************************************************

EUCCULDEMO: CultureAmp Demo Export

FormatCode:     EUCCULDEMO
Project:        CultureAmp Demo Export
Client ID:      USO1001
Date/time:      2023-01-19 10:12:56.027
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUSOC
Web Filename:   USO1001_839B6_EEHISTORY_EUCCULDEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUCCULDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_EUCCULDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUCCULDEMO'


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
WHERE FormatCode = 'EUCCULDEMO'
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
WHERE ExpFormatCode = 'EUCCULDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUCCULDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUCCULDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUCCULDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUCCULDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUCCULDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUCCULDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUCCULDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUCCULDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUCCULDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUCCULDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUCCULDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUCCULDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUCCULDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUCCULDEMO];
GO
IF OBJECT_ID('U_EUCCULDEMO_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUCCULDEMO_PEarHist];
GO
IF OBJECT_ID('U_EUCCULDEMO_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUCCULDEMO_PDedHist];
GO
IF OBJECT_ID('U_EUCCULDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EUCCULDEMO_File];
GO
IF OBJECT_ID('U_EUCCULDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUCCULDEMO_EEList];
GO
IF OBJECT_ID('U_EUCCULDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUCCULDEMO_drvTbl];
GO
IF OBJECT_ID('U_EUCCULDEMO_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUCCULDEMO_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUCCULDEMO') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUCCULDEMO];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUCCULDEMO','CultureAmp Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EUCCULDEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUCCULDEMOZ0','50','H','01','1',NULL,'Name',NULL,NULL,'"Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUCCULDEMOZ0','50','H','01','2',NULL,'Preferred Name',NULL,NULL,'"Preferred Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUCCULDEMOZ0','50','H','01','3',NULL,'Employee Id',NULL,NULL,'"Employee Id"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUCCULDEMOZ0','50','H','01','4',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUCCULDEMOZ0','50','H','01','5',NULL,'Date Of Birth',NULL,NULL,'"Date Of Birth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUCCULDEMOZ0','50','H','01','6',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUCCULDEMOZ0','50','H','01','7',NULL,'End Date',NULL,NULL,'"End Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUCCULDEMOZ0','50','H','01','8',NULL,'Language',NULL,NULL,'"Language"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUCCULDEMOZ0','50','H','01','9',NULL,'Supervisor Email',NULL,NULL,'"Supervisor Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUCCULDEMOZ0','50','H','01','10',NULL,'Supervisor',NULL,NULL,'"Supervisor"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUCCULDEMOZ0','50','H','01','11',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUCCULDEMOZ0','50','H','01','12',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUCCULDEMOZ0','50','H','01','13',NULL,'Full/Part Time',NULL,NULL,'"Full/Part Time"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUCCULDEMOZ0','50','H','01','14',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUCCULDEMOZ0','50','H','01','15',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUCCULDEMOZ0','50','H','01','16',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUCCULDEMOZ0','50','H','01','17',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUCCULDEMOZ0','50','H','01','18',NULL,'Team',NULL,NULL,'"Team"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUCCULDEMOZ0','50','H','01','19',NULL,'Compensation Level',NULL,NULL,'"Compensation Level"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUCCULDEMOZ0','50','H','01','20',NULL,'Comparatio',NULL,NULL,'"Comparatio"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUCCULDEMOZ0','50','H','01','21',NULL,'Employee Work Environment',NULL,NULL,'"Employee Work Environment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUCCULDEMOZ0','50','H','01','22',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUCCULDEMOZ0','50','D','10','1',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUCCULDEMOZ0','50','D','10','2',NULL,'Preferred Name',NULL,NULL,'"drvPreferredName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUCCULDEMOZ0','50','D','10','3',NULL,'Employee Id',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUCCULDEMOZ0','50','D','10','4',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUCCULDEMOZ0','50','D','10','5',NULL,'Date Of Birth',NULL,NULL,'"drvDateOfBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUCCULDEMOZ0','50','D','10','6',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUCCULDEMOZ0','50','D','10','7',NULL,'End Date',NULL,NULL,'"drvEndDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUCCULDEMOZ0','50','D','10','8',NULL,'Language',NULL,NULL,'"drvLanguage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUCCULDEMOZ0','50','D','10','9',NULL,'Supervisor Email',NULL,NULL,'"drvSupervisorEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUCCULDEMOZ0','50','D','10','10',NULL,'Supervisor',NULL,NULL,'"drvSupervisor"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUCCULDEMOZ0','60','D','10','11',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUCCULDEMOZ0','50','D','10','12',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUCCULDEMOZ0','50','D','10','13',NULL,'Full/Part Time',NULL,NULL,'"drvFullPartTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUCCULDEMOZ0','50','D','10','14',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUCCULDEMOZ0','50','D','10','15',NULL,'Ethnicity',NULL,NULL,'"drvEthnicity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUCCULDEMOZ0','50','D','10','16',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUCCULDEMOZ0','50','D','10','17',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUCCULDEMOZ0','50','D','10','18',NULL,'Team',NULL,NULL,'"drvTeam"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUCCULDEMOZ0','50','D','10','19',NULL,'Compensation Level',NULL,NULL,'"drvCompensationLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUCCULDEMOZ0','50','D','10','20',NULL,'Comparatio',NULL,NULL,'"drvComparatio"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUCCULDEMOZ0','50','D','10','21',NULL,'Employee Work Environment',NULL,NULL,'"drvEEWorkEnvironment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUCCULDEMOZ0','50','D','10','22',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUCCULDEMO_20230119.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210139','EMPEXPORT','OEACTIVE',NULL,'EUCCULDEMO',NULL,NULL,NULL,'202210139','Oct 13 2022  1:47PM','Oct 13 2022  1:47PM','202210131',NULL,'','','202210131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210139','EMPEXPORT','OEPASSIVE',NULL,'EUCCULDEMO',NULL,NULL,NULL,'202210139','Oct 13 2022  1:47PM','Oct 13 2022  1:47PM','202210131',NULL,'','','202210131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','V5C45',NULL,NULL,NULL,'CultureAmp Demo - Daily 11pm','202210139','EMPEXPORT','SCH_EUCCUL',NULL,'EUCCULDEMO',NULL,NULL,NULL,'202301189','Oct 13 2022  1:47PM','Oct 13 2022  1:47PM','202301171',NULL,'','','202210131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'TestSession','202301049','EMPEXPORT','TEST_XOE','Jan  4 2023  8:34AM','EUCCULDEMO',NULL,NULL,NULL,'202301049','Jan  4 2023 12:00AM','Dec 30 1899 12:00AM','202212211','385','','','202212211',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUCCULDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUCCULDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUCCULDEMO','SubSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUCCULDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUCCULDEMO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUCCULDEMO','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUCCULDEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUCCULDEMO','D10','dbo.U_EUCCULDEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUCCULDEMO
-----------

IF OBJECT_ID('U_dsi_BDM_EUCCULDEMO') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUCCULDEMO] (
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
-- Create table U_EUCCULDEMO_DedList
-----------

IF OBJECT_ID('U_EUCCULDEMO_DedList') IS NULL
CREATE TABLE [dbo].[U_EUCCULDEMO_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUCCULDEMO_drvTbl
-----------

IF OBJECT_ID('U_EUCCULDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUCCULDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvName] varchar(6002) NULL,
    [drvPreferredName] varchar(102) NULL,
    [drvEmployeeID] varchar(52) NULL,
    [drvEmail] varchar(52) NULL,
    [drvDateOfBirth] varchar(32) NOT NULL,
    [drvStartDate] varchar(32) NOT NULL,
    [drvEndDate] varchar(32) NOT NULL,
    [drvLanguage] varchar(4) NOT NULL,
    [drvSupervisorEmail] varchar(258) NOT NULL,
    [drvSupervisor] varchar(6002) NULL,
    [drvJobTitle] varchar(6002) NULL,
    [drvLocation] varchar(27) NOT NULL,
    [drvFullPartTime] varchar(11) NULL,
    [drvGender] varchar(8) NULL,
    [drvEthnicity] varchar(47) NOT NULL,
    [drvDivision] varchar(8000) NOT NULL,
    [drvDepartment] varchar(8000) NOT NULL,
    [drvTeam] varchar(8000) NOT NULL,
    [drvCompensationLevel] varchar(12) NOT NULL,
    [drvComparatio] nvarchar(4000) NOT NULL,
    [drvEEWorkEnvironment] nvarchar(4000) NOT NULL,
    [drvSalary] varchar(32) NULL
);

-----------
-- Create table U_EUCCULDEMO_EEList
-----------

IF OBJECT_ID('U_EUCCULDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EUCCULDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUCCULDEMO_File
-----------

IF OBJECT_ID('U_EUCCULDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EUCCULDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EUCCULDEMO_PDedHist
-----------

IF OBJECT_ID('U_EUCCULDEMO_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUCCULDEMO_PDedHist] (
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
-- Create table U_EUCCULDEMO_PEarHist
-----------

IF OBJECT_ID('U_EUCCULDEMO_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUCCULDEMO_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUCCULDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Roger Bynum
Business Analyst: Lea King
Create Date: 10/13/2022
Service Request Number: TekP2022-09-21-02

Purpose: CultureAmp Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        10/19/2022     TekP2022-09-21-02  Loaded into client enviorment 
Marie Waters        1/19/2023       TekP2022-09-21-02  Added Case Statements to the Name fields to remove space created by suffix

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUCCULDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUCCULDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUCCULDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUCCULDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUCCULDEMO' ORDER BY RunID DESC;

Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUCCULDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUCCULDEMO', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUCCULDEMO', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUCCULDEMO', 'SCH_EUCCUL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUCCULDEMO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUCCULDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUCCULDEMO';

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
    DELETE FROM dbo.U_EUCCULDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUCCULDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EUCCULDEMO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUCCULDEMO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUCCULDEMO_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUCCULDEMO_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUCCULDEMO_PDedHist;
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
    INTO dbo.U_EUCCULDEMO_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUCCULDEMO_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUCCULDEMO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUCCULDEMO_PEarHist;
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
    INTO dbo.U_EUCCULDEMO_PEarHist
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
    -- DETAIL RECORD - U_EUCCULDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUCCULDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUCCULDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvName = CASE WHEN ISNULL(EepNameSuffix,'') <> '' THEN '"' + dbo.dsi_fnRemoveChars('.,/-', TRIM(EepNameFirst) + ' ' + Left(TRIM(ISNULL(EepNameMiddle, '')),1)  + ' ' + TRIM(eepNameLast) + ' ' + TRIM(ISNULL(EepNameSuffix,''))) + '"'
                                ELSE '"' + dbo.dsi_fnRemoveChars('.,/-', TRIM(EepNameFirst) + ' ' + Left(TRIM(ISNULL(EepNameMiddle, '')),1)  + ' ' + TRIM(eepNameLast))+'"'
                            END
        ,drvPreferredName =  '"' +  LTRIM(RTRIM(ISNULL(EepNamePreferred, ''))) + '"'
        ,drvEmployeeID = '"' + EepAddressEMail + '"'
        ,drvEmail = '"' + EepAddressEMail + '"'
        ,drvDateOfBirth = '"' + ISNULL(CONVERT(VARCHAR, EepDateOfBirth, 23),'') + '"'
        ,drvStartDate = '"' + ISNULL(CONVERT(VARCHAR, EecDateOfLastHire, 23),'') + '"'
        ,drvEndDate = '"' + ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 23), '') + '"'
        ,drvLanguage = '"' + EecLanguageCode + '"'
        ,drvSupervisorEmail = '"' + ISNULL(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail'),'') + '"'
        ,drvSupervisor = CASE WHEN ISNULL(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Suffix'),'') <> '' THEN '"' + dbo.dsi_fnRemoveChars('.,/-', ISNULL((dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst')  + ' ' + Left(ISNULL(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameMiddle'),''),1) + ' ' + ISNULL(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast'),'')  + ' ' + dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Suffix')),'')) + '"'
                                ELSE '"' + dbo.dsi_fnRemoveChars('.,/-', (dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst')  + ' ' + Left(ISNULL(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameMiddle'),''),1) + ' ' + (dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast')))) + '"'
                            END
        ,drvJobTitle = '"' + dbo.dsi_fnRemoveChars('.,/-', ISNULL((SELECT JbcLongDesc FROM dbo.JobCode WITH (NOLOCK) WHERE JbcJobCode = EecJobCode),'')) + '"'
        --ISNULL((SELECT REPLACE(JbcLongDesc, ',','') FROM  dbo.JobCode WITH (NOLOCK) WHERE JbcJobCode = EecJobCode),'') + '"'
        ,drvLocation = '"' + ISNULL((SELECT LocDesc from dbo.Location WITH (NOLOCK) WHERE LocCode = EecLocation),'') + '"'
        ,drvFullPartTime = '"' + CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Fulltime'
                                WHEN EecFullTimeOrPartTime = 'P' THEN 'Part-time' 
                           END  + '"'
        ,drvGender = '"' + CASE WHEN eepgender = 'M' THEN 'Male'
                          WHEN eepgender = 'F' THEN 'Female' 
                     END + '"'
        ,drvEthnicity = '"' + ISNULL(LTRIM(RTRIM(Eth.CodDesc)),'') + '"'
        ,drvDivision = '"' + ISNULL(REPLACE(OL1.OrgDesc,',', ''),'') + '"'
        ,drvDepartment = '"' + ISNULL(REPLACE(OL2.OrgDesc,',', ''),'') + '"'
        ,drvTeam = '"' + ISNULL(REPLACE(OL3.OrgDesc,',', ''),'') + '"'
        ,drvCompensationLevel = '"' + ISNULL(RTRIM(EecUDField01),'') + '"'
        ,drvComparatio = '"' + ISNULL(sl.Average,'') + '"'
        ,drvEEWorkEnvironment = '"' + ISNULL((SELECT TOP 1 employment_EmployeeWorkEnvironment from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL) where EecCOID = xCoID AND EecEEID = xEEID),'') + '"'
        ,drvSalary = '"' + CAST(ISNULL(EecAnnSalary,'') AS VARCHAR) + '"'
    INTO dbo.U_EUCCULDEMO_drvTbl
    FROM dbo.U_EUCCULDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EUCCULDEMO WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN (SELECT CodCode,CodDesc from dbo.Codes WITH (NOLOCK) WHERE CodTable = 'ETHNICCODE') Eth
        ON Eth.CodCode =  eepEthnicID
     LEFT JOIN dbo.OrgLevel OL1 WITH (NOLOCK)
        On OL1.OrgLvl = 1
        and OL1.OrgCode = EecOrgLvl1
     LEFT JOIN dbo.OrgLevel OL2 WITH (NOLOCK)
        On OL2.OrgLvl = 2
        and OL2.OrgCode = EecOrgLvl2
    LEFT JOIN dbo.OrgLevel OL3 WITH (NOLOCK)
        On OL3.OrgLvl = 3
        and OL3.OrgCode = EecOrgLvl3
    --LEFT JOIN dbo.OrgLevel OL4 WITH (NOLOCK)
    --    On OL4.OrgLvl = 4
        --and OL4.OrgCode = EecOrgLvl4
    --LEFT JOIN  dbo.Codes TeamDesc WITH (NOLOCK)  
    --    on TeamDesc.CodCode =  Employment_CultureAmpTeam
    --    and TeamDesc.CodTable = 'CO_CULTUREAMPTEAM'
    Left Join (SELECT DISTINCT  eeceeid EEID 
                            ,Jbcjobcode Jobcode
                            ,SlgHourlyMax slgMax
                            ,SlgHourlyMin SlgMin
                            ,SlgSalgrade 
                            ,format((EecHourlyPayRate /  ( Avg(SlgHourlyMax + SlgHourlyMin)/2) * 100 ),'#0.00') AS Average 
                        FROM dbo.JobCode WITH (NOLOCK) 
                        JOIN dbo.EmpComp 
                            ON JbcJobCode =  eecJobCode
                        JOIN dbo.SalGrade WITH (NOLOCK) 
                            ON JbcSalarygrade = SlgSalgrade
                        WHERE EecSalaryOrHourly = 'H' 
                Group by  eeceeid, Jbcjobcode, SlgHourlyMax, SlgHourlyMin,     SlgSalgrade , EecHourlyPayRate

                    UNION

                SELECT DISTINCT eeceeid  
                                ,Jbcjobcode
                                ,SlgAnnualMax 
                                ,SlgAnnualMin 
                                ,SlgSalgrade 
                                , Format((EecAnnSalary /  ( Avg( SlgAnnualMax + SlgAnnualMin)/2) * 100 ),'#0.00') AS Average 
                        FROM dbo.JobCode WITH (NOLOCK) 
                        JOIN dbo.EmpComp 
                            ON JbcJobCode =  eecJobCode
                        JOIN dbo.SalGrade WITH (NOLOCK) 
                            ON JbcSalarygrade = SlgSalgrade
                        WHERE  EecSalaryOrHourly = 'S'
                    Group by  eeceeid, Jbcjobcode, SlgAnnualMax , SlgAnnualMin,     SlgSalgrade ,EecAnnSalary
        ) Sl 
        ON sl.EEID = xEEID
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
ALTER VIEW dbo.dsi_vwEUCCULDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUCCULDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUCCULDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202210061'
       ,expStartPerControl     = '202210061'
       ,expLastEndPerControl   = '202210139'
       ,expEndPerControl       = '202210139'
WHERE expFormatCode = 'EUCCULDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUCCULDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUCCULDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUCCULDEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUCCULDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUCCULDEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUCCULDEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUCCULDEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUCCULDEMO', 'UseFileName', 'V', 'Y'


-- End ripout