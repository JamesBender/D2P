/**********************************************************************************

EFLORESFSA: Flores FSA Enrollment

FormatCode:     EFLORESFSA
Project:        Flores FSA Enrollment
Client ID:      USG1000
Date/time:      2024-01-04 13:20:28.253
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EFLORESFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFLORESFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EFLORESFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFLORESFSA'


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
WHERE FormatCode = 'EFLORESFSA'
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
WHERE ExpFormatCode = 'EFLORESFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFLORESFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFLORESFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFLORESFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFLORESFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFLORESFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFLORESFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFLORESFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFLORESFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFLORESFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFLORESFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFLORESFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFLORESFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFLORESFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLORESFSA];
GO
IF OBJECT_ID('U_EFLORESFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EFLORESFSA_File];
GO
IF OBJECT_ID('U_EFLORESFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFLORESFSA_EEList];
GO
IF OBJECT_ID('U_EFLORESFSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFLORESFSA_drvTbl];
GO
IF OBJECT_ID('U_EFLORESFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFLORESFSA_DedList];
GO
IF OBJECT_ID('U_EFLORESFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFLORESFSA_AuditFields];
GO
IF OBJECT_ID('U_EFLORESFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFLORESFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFLORESFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFLORESFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFLORESFSA','Flores FSA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EFLORESFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFLORESFSAZ0','9','D','10','1',NULL,'Employee ID Number*',NULL,NULL,'"drvEmpIDNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFLORESFSAZ0','25','D','10','2',NULL,'Last Name*',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFLORESFSAZ0','15','D','10','3',NULL,'First Name*',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFLORESFSAZ0','30','D','10','4',NULL,'Address Line 1*',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFLORESFSAZ0','30','D','10','5',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFLORESFSAZ0','20','D','10','6',NULL,'City*',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFLORESFSAZ0','2','D','10','7',NULL,'State*',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFLORESFSAZ0','9','D','10','8',NULL,'Zip*',NULL,NULL,'"drvAddressZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFLORESFSAZ0','2','D','10','9',NULL,'Pay Frequency*',NULL,NULL,'"drvPayFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFLORESFSAZ0','6','D','10','10',NULL,'MRA Per Period Amount*',NULL,NULL,'"drvMRAPerPeriodAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFLORESFSAZ0','7','D','10','11',NULL,'MRA Annual Amount*',NULL,NULL,'"drvMRAAnnualAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFLORESFSAZ0','6','D','10','12',NULL,'DCRA Per Pay Period Amount*',NULL,NULL,'"drvDCRAPerPayAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFLORESFSAZ0','7','D','10','13',NULL,'DCRA Annual Amount*',NULL,NULL,'"drvDCRAAnnualAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFLORESFSAZ0','6','D','10','14',NULL,'QTE Per Pay Period Amount',NULL,NULL,'"drvQTEPerPayAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFLORESFSAZ0','7','D','10','15',NULL,'QTE Annual Amount',NULL,NULL,'"drvQTEAnnualAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFLORESFSAZ0','10','D','10','16',NULL,'Date Entered MRA*',NULL,NULL,'"drvDateEnteredMRA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFLORESFSAZ0','10','D','10','17',NULL,'Date Left MRA*',NULL,NULL,'"drvDateLeftMRA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFLORESFSAZ0','10','D','10','18',NULL,'Date Entered DCRA*',NULL,NULL,'"drvDateEnteredDCRA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFLORESFSAZ0','10','D','10','19',NULL,'Date Left DCRA*',NULL,NULL,'"drvDateLeftDCRA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFLORESFSAZ0','10','D','10','20',NULL,'Date Entered QTE',NULL,NULL,'"drvDateEnteredQTE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EFLORESFSAZ0','10','D','10','21',NULL,'Date Left QTE',NULL,NULL,'"drvDateLeftQTE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EFLORESFSAZ0','1','D','10','22',NULL,'Limited FSA',NULL,NULL,'"drvLimitedFSA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EFLORESFSAZ0','4','D','10','23',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EFLORESFSAZ0','50','D','10','24',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFLORESFSA_20240104.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202401049','EMPEXPORT','OEACTIVE',NULL,'EFLORESFSA',NULL,NULL,NULL,'202401049','Jan  4 2024 12:37PM','Jan  4 2024 12:37PM','202401041',NULL,'','','202401041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202401049','EMPEXPORT','OEPASSIVE',NULL,'EFLORESFSA',NULL,NULL,NULL,'202401049','Jan  4 2024 12:37PM','Jan  4 2024 12:37PM','202401041',NULL,'','','202401041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores FSA Enrollment','202401049','EMPEXPORT','ONDEM_XOE',NULL,'EFLORESFSA',NULL,NULL,NULL,'202401049','Jan  4 2024 12:37PM','Jan  4 2024 12:37PM','202401041',NULL,'','','202401041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores FSA Enrollment-Sched','202401049','EMPEXPORT','SCH_EFLORE',NULL,'EFLORESFSA',NULL,NULL,NULL,'202401049','Jan  4 2024 12:37PM','Jan  4 2024 12:37PM','202401041',NULL,'','','202401041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flores FSA Enrollment-Test','202401049','EMPEXPORT','TEST_XOE',NULL,'EFLORESFSA',NULL,NULL,NULL,'202401049','Jan  4 2024 12:37PM','Jan  4 2024 12:37PM','202401041',NULL,'','','202401041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORESFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORESFSA','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORESFSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORESFSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORESFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFLORESFSA','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFLORESFSA','D10','dbo.U_EFLORESFSA_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFLORESFSA
-----------

IF OBJECT_ID('U_dsi_BDM_EFLORESFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFLORESFSA] (
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
-- Create table U_EFLORESFSA_Audit
-----------

IF OBJECT_ID('U_EFLORESFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EFLORESFSA_Audit] (
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
-- Create table U_EFLORESFSA_AuditFields
-----------

IF OBJECT_ID('U_EFLORESFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFLORESFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EFLORESFSA_DedList
-----------

IF OBJECT_ID('U_EFLORESFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EFLORESFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFLORESFSA_drvTbl
-----------

IF OBJECT_ID('U_EFLORESFSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFLORESFSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpIDNo] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvPayFrequency] varchar(1) NOT NULL,
    [drvMRAPerPeriodAmt] money NULL,
    [drvMRAAnnualAmt] money NULL,
    [drvDCRAPerPayAmt] money NULL,
    [drvDCRAAnnualAmt] money NULL,
    [drvQTEPerPayAmt] money NULL,
    [drvQTEAnnualAmt] money NULL,
    [drvDateEnteredMRA] varchar(30) NULL,
    [drvDateLeftMRA] varchar(30) NULL,
    [drvDateEnteredDCRA] varchar(30) NULL,
    [drvDateLeftDCRA] varchar(30) NULL,
    [drvDateEnteredQTE] varchar(30) NULL,
    [drvDateLeftQTE] varchar(30) NULL,
    [drvLimitedFSA] varchar(1) NOT NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_EFLORESFSA_EEList
-----------

IF OBJECT_ID('U_EFLORESFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EFLORESFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFLORESFSA_File
-----------

IF OBJECT_ID('U_EFLORESFSA_File') IS NULL
CREATE TABLE [dbo].[U_EFLORESFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFLORESFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Net Health

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/04/2024
Service Request Number: TekP-2023-11-08-06 

Purpose: Flores FSA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2024     SR-2024-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFLORESFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFLORESFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFLORESFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFLORESFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFLORESFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORESFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORESFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORESFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORESFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFLORESFSA', 'SCH_EFLORE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFLORESFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFLORESFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFLORESFSA';

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
    DELETE FROM dbo.U_EFLORESFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFLORESFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFLORESFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORESFSA_AuditFields;
    CREATE TABLE dbo.U_EFLORESFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_EFLORESFSA_AuditFields VALUES ('EmpComp','EeEmplstatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFLORESFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORESFSA_Audit;
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
    INTO dbo.U_EFLORESFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EFLORESFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction = 'UPDATE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EFLORESFSA_Audit ON dbo.U_EFLORESFSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EFLORESFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFLORESFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAER,FSADC,FSAL,FSAC';

    IF OBJECT_ID('U_EFLORESFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORESFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFLORESFSA_DedList
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



    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFLORESFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORESFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhMRA     = SUM(CASE WHEN PdhDedCode IN ('FSA', 'FSAL') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDCRA    = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhQTE     = SUM(CASE WHEN PdhDedCode IN ('FSAC') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_EFLORESFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFLORESFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFLORESFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFLORESFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFLORESFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = Xeeid
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpIDNo = Eepssn
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipcode
        ,drvPayFrequency = 'B'
        ,drvMRAPerPeriodAmt = CASE WHEN BdmDedcode IN ('FSA', 'FSAL') AND BdmEEAmt > 0.00 THEN BdmEEAmt END
        ,drvMRAAnnualAmt =    CASE WHEN BdmDedcode IN ('FSA', 'FSAL') and BdmEEgoalAmt > 0.00  THEN BdmEEGoalAmt END
        ,drvDCRAPerPayAmt =   CASE WHEN BdmDedcode IN ('FSADC') AND BdmEEAmt > 0.00 THEN BdmEEAmt END
        ,drvDCRAAnnualAmt =   CASE WHEN BdmDedcode IN ('FSADC') and BdmEEgoalAmt > 0.00  THEN BdmEEGoalAmt END
        ,drvQTEPerPayAmt =    CASE WHEN BdmDedcode  IN ('FSAC') AND BdmEEAmt > 0.00 THEN BdmEEAmt END
        ,drvQTEAnnualAmt =    CASE WHEN BdmDedcode  IN ('FSAC') and BdmEEgoalAmt > 0.00  THEN BdmEEGoalAmt END
        ,drvDateEnteredMRA =  CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSA', 'FSAL') THEN Convert(Varchar,CAST(cast (YEAR(@Startdate+1 )as varchar ) + '0101' as datetime), 101)  END
                                 WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSA', 'FSAL')  THEN Convert(Varchar,CAST(cast (YEAR(@Startdate )as varchar ) + '0101' as datetime), 101) END 
                                END
        ,drvDateLeftMRA =    CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSA', 'FSAL')    THEN  Convert(Varchar,CAST(cast (YEAR(@Startdate +1 )as varchar ) + '1231' as datetime), 101)   END
                               WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSA', 'FSAL') and EecEmplStatus <> 'T' THEN Convert(Varchar,dbo.dsi_fnGetMINMaxDates('MAX',BdmBenstopDate, CAST(cast (YEAR(@Startdate )as varchar ) + '1231' as datetime) ), 101)
                                         WHEN BdmDedcode IN ('FSA', 'FSAL') and EecEmplStatus = 'T' and BdmBenstopDate is not null THEN Convert(Varchar,BdmBenstopDate  , 101)           
                                    END
                              END
        ,drvDateEnteredDCRA = CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSADC') THEN  Convert(Varchar,CAST(cast (YEAR(@Startdate+1 )as varchar ) + '0101' as datetime), 101)  END
                                 WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSADC')  THEN Convert(Varchar,CAST(cast (YEAR(@Startdate )as varchar ) + '0101' as datetime), 101) END 
                                END
        ,drvDateLeftDCRA = CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode  in ('FSADC')    THEN  Convert(Varchar,CAST(cast (YEAR(@Startdate +1 )as varchar ) + '1231' as datetime), 101)   END
                               WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSADC') and EecEmplStatus <> 'T' THEN Convert(Varchar,dbo.dsi_fnGetMINMaxDates('MAX',BdmBenstopDate, CAST(cast (YEAR(@Startdate )as varchar ) + '1231' as datetime) ), 101)
                                         WHEN BdmDedcode IN ('FSADC') and EecEmplStatus = 'T' and BdmBenstopDate is not null THEN Convert(Varchar,BdmBenstopDate  , 101)          
                                    END
                              END
        ,drvDateEnteredQTE = CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSAC') THEN  Convert(Varchar,CAST(cast (YEAR(@Startdate+1 )as varchar ) + '0101' as datetime), 101)  END
                                 WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN BdmDedcode IN ('FSAC')  THEN Convert(Varchar,CAST(cast (YEAR(@Startdate )as varchar ) + '0101' as datetime), 101) END 
                                END
        ,drvDateLeftQTE = CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN  BdmDedcode  in ('FSAC')    THEN  Convert(Varchar, CAST(cast (YEAR(@Startdate +1 )as varchar ) + '1231' as datetime) , 101)  END
                               WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN  BdmDedcode IN ('FSAC') and EecEmplStatus <> 'T' THEN Convert(Varchar,dbo.dsi_fnGetMINMaxDates('MAX',BdmBenstopDate, CAST(cast (YEAR(@Startdate )as varchar ) + '1231' as datetime) ), 101)
                                         WHEN  BdmDedcode IN ('FSAC') and EecEmplStatus = 'T' and BdmBenstopDate is not null THEN Convert(Varchar,BdmBenstopDate, 101)            
                                    END
                              END
        ,drvLimitedFSA = 'Y'
        ,drvLocation = ''
        ,drvEmailAddress = ISNULL(NULLIF(EepAddressEMailAlternate,''),EepAddressEmail)
    INTO dbo.U_EFLORESFSA_drvTbl
    FROM dbo.U_EFLORESFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFLORESFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EFLORESFSA_Audit WITH (NOLOCK)
        ON Audeeid = XEEID
         Where eecEEtype <> 'TES' 
        AND  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (EecDateofTermination  BETWEEN  @StartDate AND @EndDate or audDatetime is not null) ))
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
ALTER VIEW dbo.dsi_vwEFLORESFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFLORESFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFLORESFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202312281'
       ,expStartPerControl     = '202312281'
       ,expLastEndPerControl   = '202401049'
       ,expEndPerControl       = '202401049'
WHERE expFormatCode = 'EFLORESFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFLORESFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFLORESFSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFLORESFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFLORESFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFLORESFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLORESFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFLORESFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFLORESFSA', 'UseFileName', 'V', 'Y'


-- End ripout