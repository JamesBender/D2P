/**********************************************************************************

ETAXSFSACE: TaxSave FSA Combined Export

FormatCode:     ETAXSFSACE
Project:        TaxSave FSA Combined Export
Client ID:      USG1000
Date/time:      2022-08-23 05:50:10.570
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_ETAXSFSACE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETAXSFSACE_SavePath') IS NOT NULL DROP TABLE dbo.U_ETAXSFSACE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETAXSFSACE'


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
WHERE FormatCode = 'ETAXSFSACE'
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
WHERE ExpFormatCode = 'ETAXSFSACE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETAXSFSACE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETAXSFSACE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETAXSFSACE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETAXSFSACE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETAXSFSACE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETAXSFSACE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETAXSFSACE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETAXSFSACE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETAXSFSACE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETAXSFSACE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETAXSFSACE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETAXSFSACE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETAXSFSACE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSFSACE];
GO
IF OBJECT_ID('U_ETAXSFSACE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETAXSFSACE_PDedHist];
GO
IF OBJECT_ID('U_ETAXSFSACE_File') IS NOT NULL DROP TABLE [dbo].[U_ETAXSFSACE_File];
GO
IF OBJECT_ID('U_ETAXSFSACE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSFSACE_EEList];
GO
IF OBJECT_ID('U_ETAXSFSACE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETAXSFSACE_drvTbl];
GO
IF OBJECT_ID('U_ETAXSFSACE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETAXSFSACE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETAXSFSACE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETAXSFSACE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETAXSFSACE','TaxSave FSA Combined Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ETAXSFSACEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETAXSFSACEZ0','50','D','10','1',NULL,'Employee Social Security Number',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETAXSFSACEZ0','50','D','10','2',NULL,'Employee Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETAXSFSACEZ0','50','D','10','3',NULL,'Employee First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETAXSFSACEZ0','50','D','10','4',NULL,'Employee Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETAXSFSACEZ0','50','D','10','5',NULL,'Current deduction for Health FSA',NULL,NULL,'"drvCurrentDedForHealthFSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETAXSFSACEZ0','50','D','10','6',NULL,'Current Year to Date for Health FSA',NULL,NULL,'"drvCurrentYTDForHealthFSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETAXSFSACEZ0','50','D','10','7',NULL,'Annual Goal amount for Health FSA',NULL,NULL,'"drvAnnualGoalAmtForHealth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETAXSFSACEZ0','50','D','10','8',NULL,'Benefit Eligibility Date (mm/dd/yy)',NULL,NULL,'"drvBenefitEligibilityDate1"','(''UD1''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETAXSFSACEZ0','50','D','10','9',NULL,'Benefit Termination Date (mm/dd/yy)',NULL,NULL,'"drvBenefitTerminationDate1"','(''UD1''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETAXSFSACEZ0','50','D','10','10',NULL,'Current deduction for Day Care FSA',NULL,NULL,'"drvCurrenDedForDayCareFSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETAXSFSACEZ0','50','D','10','11',NULL,'Current Year to Date for Day Care FSA',NULL,NULL,'"drvCurrentYTDForDayCareFSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETAXSFSACEZ0','50','D','10','12',NULL,'Annual Goal for Day Care FSA',NULL,NULL,'"drvAnnualGoalAmtForDayCareFSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETAXSFSACEZ0','50','D','10','13',NULL,'Benefit Eligibility Date (mm/dd/yy) ',NULL,NULL,'"drvBenefitEligibilityDate2"','(''UD1''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETAXSFSACEZ0','50','D','10','14',NULL,'Benefit Termination Date (mm/dd/yy)',NULL,NULL,'"drvBenefitTerminationDate2"','(''UD1''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETAXSFSACEZ0','50','D','10','15',NULL,'Employee Street Address ',NULL,NULL,'"drvEmployeeStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETAXSFSACEZ0','50','D','10','16',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETAXSFSACEZ0','50','D','10','17',NULL,'State abbreviation',NULL,NULL,'"drvStateAbbreviation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETAXSFSACEZ0','50','D','10','18',NULL,'Zip code',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETAXSFSACEZ0','50','D','10','19',NULL,'Department or Location',NULL,NULL,'"drvDepartmentOrLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETAXSFSACEZ0','50','D','10','20',NULL,'Employee Checking Account Number',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETAXSFSACEZ0','50','D','10','21',NULL,'Employee ABA Number',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETAXSFSACEZ0','50','D','10','22',NULL,'Checking or savings account',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ETAXSFSACEZ0','50','D','10','23',NULL,'Participants an option to elect the debit card)',NULL,NULL,'"Y"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ETAXSFSACEZ0','50','D','10','24',NULL,'Health Plan elected',NULL,NULL,'"drvHealthPlanElected"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ETAXSFSACEZ0','50','D','10','25',NULL,'Employee email address (work or home)',NULL,NULL,'"drvEmployeeEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ETAXSFSACEZ0','50','D','10','26',NULL,'Pay Cycle (W,B,S,M)',NULL,NULL,'"S"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ETAXSFSACEZ0','50','D','10','27',NULL,'Limited FSA Flag',NULL,NULL,'"N"','(''DA''=''T,'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETAXSFSACE_20220823.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202008239','EMPEXPORT','OEACTIVE',NULL,'ETAXSFSACE',NULL,NULL,NULL,'202008239','Aug 23 2022  5:05AM','Aug 23 2022  5:05AM','202208161',NULL,'','','202208161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202008239','EMPEXPORT','OEPASSIVE',NULL,'ETAXSFSACE',NULL,NULL,NULL,'202008239','Aug 23 2022  5:05AM','Aug 23 2022  5:05AM','202208161',NULL,'','','202208161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSave FSA Combined Export','202008239','EMPEXPORT','ONDEM_XOE',NULL,'ETAXSFSACE',NULL,NULL,NULL,'202008239','Aug 23 2022  5:05AM','Aug 23 2022  5:05AM','202208161',NULL,'','','202208161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSave FSA Combined Exp-Sched','202008239','EMPEXPORT','SCH_ETAXSF',NULL,'ETAXSFSACE',NULL,NULL,NULL,'202008239','Aug 23 2022  5:05AM','Aug 23 2022  5:05AM','202208161',NULL,'','','202208161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TaxSave FSA Combined Exp-Test','202008239','EMPEXPORT','TEST_XOE',NULL,'ETAXSFSACE',NULL,NULL,NULL,'202008239','Aug 23 2022  5:05AM','Aug 23 2022  5:05AM','202208161',NULL,'','','202208161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSFSACE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSFSACE','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSFSACE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSFSACE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETAXSFSACE','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSFSACE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETAXSFSACE','D10','dbo.U_ETAXSFSACE_drvTbl',NULL);

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
-- Create table U_dsi_BDM_ETAXSFSACE
-----------

IF OBJECT_ID('U_dsi_BDM_ETAXSFSACE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETAXSFSACE] (
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
-- Create table U_ETAXSFSACE_DedList
-----------

IF OBJECT_ID('U_ETAXSFSACE_DedList') IS NULL
CREATE TABLE [dbo].[U_ETAXSFSACE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ETAXSFSACE_drvTbl
-----------

IF OBJECT_ID('U_ETAXSFSACE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETAXSFSACE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvCurrentDedForHealthFSA] nvarchar(4000) NULL,
    [drvCurrentYTDForHealthFSA] nvarchar(4000) NULL,
    [drvAnnualGoalAmtForHealth] nvarchar(4000) NULL,
    [drvBenefitEligibilityDate1] datetime NULL,
    [drvBenefitTerminationDate1] datetime NULL,
    [drvCurrenDedForDayCareFSA] nvarchar(4000) NULL,
    [drvCurrentYTDForDayCareFSA] nvarchar(4000) NULL,
    [drvAnnualGoalAmtForDayCareFSA] nvarchar(4000) NULL,
    [drvBenefitEligibilityDate2] datetime NULL,
    [drvBenefitTerminationDate2] datetime NULL,
    [drvEmployeeStreetAddress] varchar(511) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvStateAbbreviation] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvDepartmentOrLocation] varchar(25) NULL,
    [drvHealthPlanElected] varchar(1) NULL,
    [drvEmployeeEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_ETAXSFSACE_EEList
-----------

IF OBJECT_ID('U_ETAXSFSACE_EEList') IS NULL
CREATE TABLE [dbo].[U_ETAXSFSACE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETAXSFSACE_File
-----------

IF OBJECT_ID('U_ETAXSFSACE_File') IS NULL
CREATE TABLE [dbo].[U_ETAXSFSACE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ETAXSFSACE_PDedHist
-----------

IF OBJECT_ID('U_ETAXSFSACE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETAXSFSACE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSAorFSAMD] numeric NULL,
    [PdhFSADCorFSADN] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETAXSFSACE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Berry Appleman

Created By: James Bender
Business Analyst: Lea King
Create Date: 08/23/2022
Service Request Number: TekP-2022-07-20-01

Purpose: TaxSave FSA Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETAXSFSACE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETAXSFSACE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETAXSFSACE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETAXSFSACE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETAXSFSACE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSFSACE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSFSACE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSFSACE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSFSACE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETAXSFSACE', 'SCH_ETAXSF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETAXSFSACE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ETAXSFSACE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETAXSFSACE';

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
    DELETE FROM dbo.U_ETAXSFSACE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETAXSFSACE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC,FSADN,FSAMD';

    IF OBJECT_ID('U_ETAXSFSACE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSFSACE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETAXSFSACE_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETAXSFSACE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSFSACE_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFSAorFSAMD            = SUM(CASE WHEN PdhDedCode IN ('FSA','FSAMD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSADCorFSADN        = SUM(CASE WHEN PdhDedCode IN ('FSADC','FSAND') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_ETAXSFSACE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETAXSFSACE_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETAXSFSACE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETAXSFSACE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETAXSFSACE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvCurrentDedForHealthFSA = CASE WHEN FSA_DedCode IS NOT NULL OR FSAMD_DedCode IS NOT NULL THEN FORMAT(PdhFSAorFSAMD, '#0.00') END
        ,drvCurrentYTDForHealthFSA =    CASE WHEN FSA_DedCode IS NOT NULL THEN FORMAT(FSAGTDAmt, '#0.00')
                                        WHEN FSAMD_DedCode IS NOT NULL THEN FORMAT(FSAMDGTDAmt, '#0.00')
                                        END
        ,drvAnnualGoalAmtForHealth =    CASE WHEN FSA_DedCode IS NOT NULL THEN FORMAT(FSAGoalAmt, '#0.00')
                                        WHEN FSAMD_DedCode IS NOT NULL THEN FORMAT(FSAMDGoalAmt, '#0.00')
                                        END
        ,drvBenefitEligibilityDate1 =    CASE WHEN FSA_DedCode IS NOT NULL THEN FSA_BenStartDate
                                        WHEN FSAMD_DedCode IS NOT NULL THEN FSAMD_BenStartDate
                                        END
        ,drvBenefitTerminationDate1 =    CASE WHEN FSA_DedCode IS NOT NULL THEN FSA_BenStopDate
                                        WHEN FSAMD_DedCode IS NOT NULL THEN FSAMD_BenStopDate
                                        END
        ,drvCurrenDedForDayCareFSA = CASE WHEN FSADC_DedCode IS NOT NULL OR FSADN_DedCode IS NOT NULL THEN FORMAT(PdhFSADCorFSADN, '#0.00') END
        ,drvCurrentYTDForDayCareFSA =    CASE WHEN FSADC_DedCode IS NOT NULL THEN FORMAT(FSADCGTDAmt, '#0.00')
                                        WHEN FSADN_DedCode IS NOT NULL THEN FORMAT(FSADNGTDAmt, '#0.00')
                                        END
        ,drvAnnualGoalAmtForDayCareFSA =    CASE WHEN FSADC_DedCode IS NOT NULL THEN FORMAT(FSADCGoalAmt, '#0.00')
                                            WHEN FSADN_DedCode IS NOT NULL THEN FORMAT(FSADNGoalAmt, '#0.00')
                                            END
        ,drvBenefitEligibilityDate2 =    CASE WHEN FSADC_DedCode IS NOT NULL THEN FSADC_BenStartDate
                                        WHEN FSADN_DedCode IS NOT NULL THEN FSADN_BenStartDate
                                        END
        ,drvBenefitTerminationDate2 =    CASE WHEN FSADC_DedCode IS NOT NULL THEN FSADC_BenStopDate
                                        WHEN FSADN_DedCode IS NOT NULL THEN FSADN_BenStopDate
                                        END
        ,drvEmployeeStreetAddress = CONCAT(EepAddressLine1, ' ', EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvStateAbbreviation = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDepartmentOrLocation = LocDesc
        ,drvHealthPlanElected = HealthPlanElected
        ,drvEmployeeEmailAddress = EepAddressEMailAlternate
    INTO dbo.U_ETAXSFSACE_drvTbl
    FROM dbo.U_ETAXSFSACE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN ( --dbo.U_dsi_BDM_ETAXSFSACE WITH (NOLOCK)
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode IN ('FSA') THEN BdmDedCode END) AS FSA_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('FSA') THEN BdmBenStartDate END) AS FSA_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSA') THEN BdmBenStopDate END) AS FSA_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSAMD') THEN BdmDedCode END) AS FSAMD_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('FSAMD') THEN BdmBenStartDate END) AS FSAMD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSAMD') THEN BdmBenStopDate END) AS FSAMD_BenStopDate


                ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmDedCode END) AS FSADC_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmBenStartDate END) AS FSADC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmBenStopDate END) AS FSADC_BenStopDate

                ,MAX(CASE WHEN BdmDedCode IN ('FSADN') THEN BdmDedCode END) AS FSADN_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('FSADN') THEN BdmBenStartDate END) AS FSADN_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSADN') THEN BdmBenStopDate END) AS FSADN_BenStopDate
            FROM dbo.U_dsi_BDM_ETAXSFSACE WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_ETAXSFSACE_PDedHist WITH (NOLOCK)
        ON xEEID = PdhEEID
    JOIN (
            SELECT EedEEID, EedCOID
                ,MAX(CASE WHEN EedDedCode = 'FSA' THEN EedEEGTDAmt ELSE 0.00 END) AS FSAGTDAmt
                ,MAX(CASE WHEN EedDedCode = 'FSA' THEN EedEEGoalAmt ELSE 0.00 END) AS FSAGoalAmt
                ,MAX(CASE WHEN EedDedCode = 'FSAMD' THEN EedEEGTDAmt ELSE 0.00 END) AS FSAMDGTDAmt
                ,MAX(CASE WHEN EedDedCode = 'FSAMD' THEN EedEEGoalAmt ELSE 0.00 END) AS FSAMDGoalAmt
                ,MAX(CASE WHEN EedDedCode = 'FSADC' THEN EedEEGTDAmt ELSE 0.00 END) AS FSADCGTDAmt
                ,MAX(CASE WHEN EedDedCode = 'FSADC' THEN EedEEGoalAmt ELSE 0.00 END) AS FSADCGoalAmt
                ,MAX(CASE WHEN EedDedCode = 'FSADN' THEN EedEEGTDAmt ELSE 0.00 END) AS FSADNGTDAmt
                ,MAX(CASE WHEN EedDedCode = 'FSADN' THEN EedEEGoalAmt ELSE 0.00 END) AS FSADNGoalAmt
                ,MAX(CASE WHEN EedDedCode IN (' CGOAP','EPCGO','EPCOR','ICOR1','ICOR2','IPRM1','IPRM2','MEDC') THEN 'Y' END) AS HealthPlanElected
            FROM dbo.EmpDed WITH (NOLOCK)
            GROUP BY EedEEID, EedCOID) AS EmpDed
        ON EedEEID = xEEID
        AND EedCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
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
ALTER VIEW dbo.dsi_vwETAXSFSACE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETAXSFSACE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ETAXSFSACE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208161'
       ,expStartPerControl     = '202208161'
       ,expLastEndPerControl   = '202008239'
       ,expEndPerControl       = '202008239'
WHERE expFormatCode = 'ETAXSFSACE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETAXSFSACE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETAXSFSACE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETAXSFSACE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETAXSFSACE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETAXSFSACE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETAXSFSACE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETAXSFSACE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETAXSFSACE', 'UseFileName', 'V', 'Y'


-- End ripout