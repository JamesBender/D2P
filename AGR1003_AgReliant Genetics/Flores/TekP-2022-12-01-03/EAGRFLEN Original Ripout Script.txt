/**********************************************************************************

EAGRFLEN: Flores FSA Enrollment

FormatCode:     EAGRFLEN
Project:        Flores FSA Enrollment
Client ID:      AGR1003
Date/time:      2024-02-07 16:27:27.907
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP6DB02
Database:       ULTIPRO_WPARGI
Web Filename:   AGR1003_WU4E0_EEHISTORY_EAGRFLEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAGRFLEN_SavePath') IS NOT NULL DROP TABLE dbo.U_EAGRFLEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAGRFLEN'


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
WHERE FormatCode = 'EAGRFLEN'
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
WHERE ExpFormatCode = 'EAGRFLEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAGRFLEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAGRFLEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAGRFLEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAGRFLEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAGRFLEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAGRFLEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAGRFLEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAGRFLEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAGRFLEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAGRFLEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAGRFLEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAGRFLEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAGRFLEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAGRFLEN];
GO
IF OBJECT_ID('U_EAGRFLEN_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_PDedHist];
GO
IF OBJECT_ID('U_EAGRFLEN_File') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_File];
GO
IF OBJECT_ID('U_EAGRFLEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_EEList];
GO
IF OBJECT_ID('U_EAGRFLEN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_drvTbl];
GO
IF OBJECT_ID('U_EAGRFLEN_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_DedList];
GO
IF OBJECT_ID('U_EAGRFLEN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_AuditFields];
GO
IF OBJECT_ID('U_EAGRFLEN_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAGRFLEN_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EAGRFLEN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAGRFLEN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAGRFLEN','Flores FSA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EAGRFLEN00Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAGRFLEN00Z0','9','D','10','1',NULL,'Employee ID Number',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAGRFLEN00Z0','25','D','10','2',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAGRFLEN00Z0','15','D','10','3',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAGRFLEN00Z0','30','D','10','4',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAGRFLEN00Z0','30','D','10','5',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAGRFLEN00Z0','20','D','10','6',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAGRFLEN00Z0','2','D','10','7',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAGRFLEN00Z0','9','D','10','8',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAGRFLEN00Z0','2','D','10','9',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAGRFLEN00Z0','6','D','10','10',NULL,'MRA Per Period Amount',NULL,NULL,'"drvMRAPerPeriodAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAGRFLEN00Z0','7','D','10','11',NULL,'MRA Annual Amount',NULL,NULL,'"drvMRAAnnualAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAGRFLEN00Z0','6','D','10','12',NULL,'DCRA Per Period Amount',NULL,NULL,'"drvDCRAPerPeriodAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAGRFLEN00Z0','7','D','10','13',NULL,'DCRA Annual Amount',NULL,NULL,'"drvDCRAAnnualAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAGRFLEN00Z0','6','D','10','14',NULL,'QTE Per Pay Period Amount',NULL,NULL,'"drvQTEPerPeriodAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAGRFLEN00Z0','7','D','10','15',NULL,'QTE Annual Amount',NULL,NULL,'"drvQTEAnnualAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAGRFLEN00Z0','10','D','10','16',NULL,'Date Entered MRA',NULL,NULL,'"drvDateEnteredMRA"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAGRFLEN00Z0','10','D','10','17',NULL,'Date Left MRA',NULL,NULL,'"drvDateLeftMRA"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAGRFLEN00Z0','10','D','10','18',NULL,'Date Entered DCRA',NULL,NULL,'"drvDateEnteredDCRA"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAGRFLEN00Z0','10','D','10','19',NULL,'Date Left DCRA',NULL,NULL,'"drvDateLeftDCRA"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAGRFLEN00Z0','10','D','10','20',NULL,'Date Entered QTE',NULL,NULL,'"drvDateEnteredQTE"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAGRFLEN00Z0','10','D','10','21',NULL,'Date Left QTE',NULL,NULL,'"drvDateLeftQTE"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAGRFLEN00Z0','1','D','10','22',NULL,'Limited FSA',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAGRFLEN00Z0','4','D','10','23',NULL,'Location',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAGRFLEN00Z0','50','D','10','24',NULL,'Email Address',NULL,NULL,'"drvAddressEmail"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAGRFLEN_20240207.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Flores FSA Enroll - OE Active','202304069','EMPEXPORT','OEACTIVE',NULL,'EAGRFLEN',NULL,NULL,NULL,'202304069','Feb  3 2023 10:39AM','Feb  3 2023 10:39AM','202303011',NULL,'','','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Flores FSA Enroll - OE Passive','202304069','EMPEXPORT','OEPASSIVE',NULL,'EAGRFLEN',NULL,NULL,NULL,'202304069','Feb  3 2023 10:39AM','Feb  3 2023 10:39AM','202303011',NULL,'','','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',WY9ZA,WY8V4',NULL,NULL,NULL,'Flores FSA Enrollment','202304069','EMPEXPORT','ONDEM_XOE',NULL,'EAGRFLEN',NULL,NULL,NULL,'202304069','Feb  3 2023 10:39AM','Feb  3 2023 10:39AM','202303011',NULL,'','','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','WY8V4',NULL,NULL,NULL,'Flores FSA EN Genec Wed 1130P','202304069','EMPEXPORT','SCH_EAGGEN',NULL,'EAGRFLEN',NULL,NULL,NULL,'202401319','Feb  3 2023 10:39AM','Feb  3 2023 10:39AM','202401241',NULL,'eecPaygroup','GNHRLY,GNSLRY','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','WY9ZA',NULL,NULL,NULL,'Flores FSA EN AgRel Wed 1140P','202304069','EMPEXPORT','SCH_FSAAG',NULL,'EAGRFLEN',NULL,NULL,NULL,'202401319','Feb  3 2023 10:39AM','Feb  3 2023 10:39AM','202401241',NULL,'eecPaygroup','USHRLY,USSLRY','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Flores FSA Enrollment-Test','202304069','EMPEXPORT','TEST_XOE',NULL,'EAGRFLEN',NULL,NULL,NULL,'202304069','Feb  3 2023 10:39AM','Feb  3 2023 10:39AM','202303011',NULL,'','','202303011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLEN','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLEN','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAGRFLEN','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAGRFLEN','D10','dbo.U_EAGRFLEN_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EAGRFLEN
-----------

IF OBJECT_ID('U_dsi_BDM_EAGRFLEN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAGRFLEN] (
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
-- Create table U_EAGRFLEN_Audit
-----------

IF OBJECT_ID('U_EAGRFLEN_Audit') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_Audit] (
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
-- Create table U_EAGRFLEN_AuditFields
-----------

IF OBJECT_ID('U_EAGRFLEN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAGRFLEN_DedList
-----------

IF OBJECT_ID('U_EAGRFLEN_DedList') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAGRFLEN_drvTbl
-----------

IF OBJECT_ID('U_EAGRFLEN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPayFrequency] varchar(1) NOT NULL,
    [drvMRAPerPeriodAmt] nvarchar(4000) NULL,
    [drvMRAAnnualAmt] nvarchar(4000) NULL,
    [drvDCRAPerPeriodAmt] nvarchar(4000) NULL,
    [drvDCRAAnnualAmt] nvarchar(4000) NULL,
    [drvQTEPerPeriodAmt] nvarchar(4000) NULL,
    [drvQTEAnnualAmt] nvarchar(4000) NULL,
    [drvDateEnteredMRA] datetime NULL,
    [drvDateLeftMRA] datetime NULL,
    [drvDateEnteredDCRA] datetime NULL,
    [drvDateLeftDCRA] datetime NULL,
    [drvDateEnteredQTE] datetime NULL,
    [drvDateLeftQTE] datetime NULL,
    [drvAddressEmail] varchar(50) NULL
);

-----------
-- Create table U_EAGRFLEN_EEList
-----------

IF OBJECT_ID('U_EAGRFLEN_EEList') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAGRFLEN_File
-----------

IF OBJECT_ID('U_EAGRFLEN_File') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EAGRFLEN_PDedHist
-----------

IF OBJECT_ID('U_EAGRFLEN_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAGRFLEN_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSA] numeric NULL,
    [PdhGFSA] numeric NULL,
    [PdhFSADC] numeric NULL,
    [PdhGFSAD] numeric NULL,
    [PdhGROUP] numeric NULL,
    [PdhFSA_GFSA] numeric NULL,
    [PdhFSADC_GFSAD] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAGRFLEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: AgReliant Genetics LLC

Created By: Marie Thomerson
Business Analyst: Katherine Ricca
Create Date: 02/03/2023
Service Request Number: TekP-2022-12-01-03

Purpose: Flores FSA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAGRFLEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAGRFLEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAGRFLEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAGRFLEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAGRFLEN' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303011'
       ,expStartPerControl     = '202303011'
       ,expLastEndPerControl   = '202304069'
       ,expEndPerControl       = '202304069'
WHERE expFormatCode = 'EAGRFLEN';

Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLEN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLEN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLEN', 'SCH_FSAAG';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLEN', 'SCH_EAGGEN';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLEN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAGRFLEN', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAGRFLEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAGRFLEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FSAMinCoverageDate    DATETIME
            ,@OEFSAMinCoverageDate    DATETIME
            ,@GFSAMinCoverageDate   DATETIME
            ,@OEGFSAMinCoverageDate DATETIME
            ,@MRAFSAMinCoverageDate        DATETIME
            ,@MRAOEFSAMinCoverageDate    DATETIME
            ,@MRAGFSAMinCoverageDate    DATETIME
            ,@MRAOEGFSAMinCoverageDate    DATETIME
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EAGRFLEN';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FSAMinCoverageDate = CAST('04/01/'+LEFT(EndPerControl,4) AS DATETIME)
        ,@OEFSAMinCoverageDate = CAST('04/01/' +CAST(YEAR(@EndDate)+1 as Varchar(4)) AS DATETIME)
        ,@GFSAMinCoverageDate = CAST('03/01/'+LEFT(EndPerControl,4) AS DATETIME)
        ,@OEGFSAMinCoverageDate = CAST('03/01/' +CAST(YEAR(@EndDate)+1 as Varchar(4)) AS DATETIME)
        ,@MRAFSAMinCoverageDate = CAST('03/31/'+LEFT(EndPerControl,4) AS DATETIME)
        ,@MRAOEFSAMinCoverageDate = CAST('03/31/' +CAST(YEAR(@EndDate)+1 as Varchar(4)) AS DATETIME)
        ,@MRAGFSAMinCoverageDate = CAST('02/28/'+LEFT(EndPerControl,4) AS DATETIME)
        ,@MRAOEGFSAMinCoverageDate = CAST('02/28/' +CAST(YEAR(@EndDate)+1 as Varchar(4)) AS DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EAGRFLEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAGRFLEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAGRFLEN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLEN_AuditFields;
    CREATE TABLE dbo.U_EAGRFLEN_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EAGRFLEN_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EAGRFLEN_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EAGRFLEN_AuditFields VALUES ('EmpDed','EedBenStopDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAGRFLEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLEN_Audit;
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
    INTO dbo.U_EAGRFLEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAGRFLEN_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN  DATEADD(DAY,-14,@StartDate) AND DATEADD(DAY,14,@EndDate)
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EAGRFLEN_Audit ON dbo.U_EAGRFLEN_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA, GFSA, FSADC, GFSAD, GROUP';

    IF OBJECT_ID('U_EAGRFLEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAGRFLEN_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','FSA, GFSA, FSADC, GFSAD, GROUP');
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EAGRFLEN_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EAGRFLEN_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhFSA     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhGFSA    = SUM(CASE WHEN PdhDedCode IN ('GFSA') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhFSADC   = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)        
    --    ,PdhGFSAD   = SUM(CASE WHEN PdhDedCode IN ('GFSAD') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhGROUP   = SUM(CASE WHEN PdhDedCode IN ('GROUP') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhFSA_GFSA = SUM(CASE WHEN PdhDedCode IN ('FSA','GFSA') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhFSADC_GFSAD = SUM(CASE WHEN PdhDedCode IN ('FSADC','GFSAD') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EAGRFLEN_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EAGRFLEN_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedEEGTDAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EAGRFLEN
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedEEGoalAmt)
    FROM dbo.U_dsi_bdm_EAGRFLEN
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
        AND EedFormatCode = 'EAGRFLEN';

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAGRFLEN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAGRFLEN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAGRFLEN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPayFrequency = 'B'
        ,drvMRAPerPeriodAmt = FORMAT(EEAmt_FSA_GFSA,'##0.00')
        ,drvMRAAnnualAmt = FORMAT(USGField_FSA_GFSA,'##0.00')
        ,drvDCRAPerPeriodAmt = FORMAT(EEAmt_FSADC_GFSAD,'##0.00')
        ,drvDCRAAnnualAmt = FORMAT(USGField_FSADC_GFSAD,'##0.00')
        ,drvQTEPerPeriodAmt = FORMAT(EEAmt_Group,'##0.00')
        ,drvQTEAnnualAmt = FORMAT(USGField_Group,'##0.00')
        ,drvDateEnteredMRA = CASE WHEN DedCode_FSA = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @OEFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_FSA >= @FSAMinCoverageDate THEN StartDate_FSA
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_FSA < @FSAMinCoverageDate THEN @FSAMinCoverageDate
                                        END 
                            WHEN DedCode_GFSA = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @OEGFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GFSA >= @GFSAMinCoverageDate THEN StartDate_GFSA
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GFSA < @GFSAMinCoverageDate THEN @GFSAMinCoverageDate
                                        END 
                                        END
        ,drvDateLeftMRA =    CASE WHEN DedCode_FSA = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @MRAOEFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_FSA >= @MRAFSAMinCoverageDate THEN StopDate_FSA
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_FSA < @MRAFSAMinCoverageDate THEN @MRAFSAMinCoverageDate
                                        END 
                                WHEN DedCode_GFSA = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @MRAOEGFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_GFSA >= @MRAGFSAMinCoverageDate THEN StopDate_GFSA
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_GFSA < @MRAGFSAMinCoverageDate THEN @MRAGFSAMinCoverageDate
                                        END 
                                        END
        ,drvDateEnteredDCRA = CASE WHEN DedCode_FSADC = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @OEFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_FSADC >= @FSAMinCoverageDate THEN StartDate_FSADC
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_FSADC < @FSAMinCoverageDate THEN @FSAMinCoverageDate
                                        END 
                                WHEN DedCode_GFSAD = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @OEGFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GFSAD >= @GFSAMinCoverageDate THEN StartDate_GFSAD
                                        WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GFSAD < @GFSAMinCoverageDate THEN @GFSAMinCoverageDate
                                        END 
                                        END
        ,drvDateLeftDCRA = CASE WHEN DedCode_FSADC = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @MRAOEFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_FSADC >= @MRAFSAMinCoverageDate THEN StopDate_FSADC
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_FSADC < @MRAFSAMinCoverageDate THEN @MRAFSAMinCoverageDate
                                        END 
                                WHEN DedCode_GFSAD = 'Y' THEN
                                CASE    WHEN @ExportCode LIKE 'OE%' THEN @MRAOEGFSAMinCoverageDate
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_GFSAD >= @MRAGFSAMinCoverageDate THEN StopDate_GFSAD
                                        WHEN @ExportCode NOT LIKE 'OE%' AND EecEmplStatus = 'T' AND StopDate_GFSAD < @MRAGFSAMinCoverageDate THEN @MRAGFSAMinCoverageDate
                                        END 
                                        END
        ,drvDateEnteredQTE = CASE    WHEN DedCode_GROUP = 'Y' AND EecPayGroup in ('USHRLY', 'USSLRY') THEN
                                    CASE    WHEN @ExportCode LIKE 'OE%' THEN @OEFSAMinCoverageDate
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP >= @FSAMinCoverageDate THEN StartDate_GROUP
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP < @FSAMinCoverageDate THEN @FSAMinCoverageDate
                                            END 
                                    WHEN DedCode_GROUP = 'Y' AND EecPayGroup in ('GNHRLY', 'GNSLRY') THEN
                                    CASE    WHEN @ExportCode LIKE 'OE%' THEN @OEGFSAMinCoverageDate
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP >= @GFSAMinCoverageDate THEN StartDate_GROUP
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP < @GFSAMinCoverageDate THEN @GFSAMinCoverageDate
                                            END 
                                        END
        ,drvDateLeftQTE = CASE    WHEN DedCode_GROUP = 'Y' AND EecPayGroup in ('USHRLY', 'USSLRY') THEN
                                    CASE    WHEN @ExportCode LIKE 'OE%' THEN @MRAOEFSAMinCoverageDate
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP >= @MRAFSAMinCoverageDate THEN StopDate_GROUP
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP < @MRAFSAMinCoverageDate THEN @MRAFSAMinCoverageDate
                                            END 
                                    WHEN DedCode_GROUP = 'Y' AND EecPayGroup in ('GNHRLY', 'GNSLRY') THEN
                                    CASE    WHEN @ExportCode LIKE 'OE%' THEN  @MRAOEGFSAMinCoverageDate
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP >= @MRAGFSAMinCoverageDate THEN StopDate_GROUP
                                            WHEN @ExportCode NOT LIKE 'OE%' AND StartDate_GROUP < @MRAGFSAMinCoverageDate THEN @MRAGFSAMinCoverageDate
                                            END 
                                        END
        ,drvAddressEmail = EepAddressEMail
    INTO dbo.U_EAGRFLEN_drvTbl
    FROM dbo.U_EAGRFLEN_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
                        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_EAGRFLEN_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID, BdmRunId, BdmBenStatus
                ,MAX(BdmBenStartDate) AS BdmBenStartDate
                ,MAX(BdmBenStopDate) AS BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode in ('FSA','GFSA') THEN 'Y' END) AS DedCode_FSA_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA','GFSA') THEN BdmBenStartDate END) AS StartDate_FSA_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA','GFSA') THEN BdmBenStopDate END) AS StopDate_FSA_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA','GFSA') THEN CAST(BdmUSGField1 as money) END) AS USGField_FSA_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA','GFSA') THEN BdmEEamt END) AS EEAmt_FSA_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN 'Y' END) AS DedCode_FSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN BdmBenStartDate END) AS StartDate_FSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN BdmBenStopDate END) AS StopDate_FSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN CAST(BdmUSGField1 as money) END) AS USGField_FSA
                ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN BdmEEAmt END) AS EEAmt_FSA
                ,MAX(CASE WHEN BdmDedCode in ('GFSA') THEN 'Y' END) AS DedCode_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('GFSA') THEN BdmBenStartDate END) AS StartDate_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('GFSA') THEN BdmBenStopDate END) AS StopDate_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('GFSA') THEN CAST(BdmUSGField1 as money) END) AS USGField_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('GFSA') THEN BdmEEAmt END) AS EEAmt_GFSA
                ,MAX(CASE WHEN BdmDedCode in ('FSADC','GFSAD') THEN 'Y' END) AS DedCode_FSADC_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('FSADC','GFSAD') THEN BdmBenStartDate END) AS StartDate_FSADC_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('FSADC','GFSAD') THEN BdmBenStopDate END) AS StopDate_FSADC_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('FSADC','GFSAD') THEN CAST(BdmUSGField1 as money) END) AS USGField_FSADC_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('FSADC','GFSAD') THEN BdmEEAmt  END) AS EEAmt_FSADC_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('FSADC') THEN 'Y' END) AS DedCode_FSADC
                ,MAX(CASE WHEN BdmDedCode in ('FSADC') THEN BdmBenStartDate END) AS StartDate_FSADC
                ,MAX(CASE WHEN BdmDedCode in ('FSADC') THEN BdmBenStopDate END) AS StopDate_FSADC
                ,MAX(CASE WHEN BdmDedCode in ('FSADC') THEN CAST(BdmUSGField1 as money) END) AS USGField_FSADC
                ,MAX(CASE WHEN BdmDedCode in ('FSADC') THEN BdmEEAmt END) AS EEAmt_FSADC
                ,MAX(CASE WHEN BdmDedCode in ('GFSAD') THEN 'Y' END) AS DedCode_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('GFSAD') THEN BdmBenStartDate END) AS StartDate_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('GFSAD') THEN BdmBenStopDate END) AS StopDate_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('GFSAD') THEN CAST(BdmUSGField1 as money) END) AS USGField_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('GFSAD') THEN BdmEEAmt END) AS EEAmt_GFSAD
                ,MAX(CASE WHEN BdmDedCode in ('GROUP') THEN 'Y' END) AS DedCode_GROUP
                ,MAX(CASE WHEN BdmDedCode in ('GROUP') THEN BdmBenStartDate END) AS StartDate_GROUP
                ,MAX(CASE WHEN BdmDedCode in ('GROUP') THEN BdmBenStopDate END) AS StopDate_GROUP
                ,MAX(CASE WHEN BdmDedCode in ('GROUP') THEN CAST(BdmUSGField1 as money) END) AS USGField_GROUP
                ,MAX(CASE WHEN BdmDedCode in ('GROUP') THEN BdmEEAmt END) AS EEAmt_GROUP
            FROM dbo.U_dsi_BDM_EAGRFLEN WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmRunId, BdmBenStatus
        ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'EMP'
        AND BdmBenStatus <> 'C'
        AND (BdmBenStopDate > '2023-04-01' or BdmBenStopDate is null)
    --LEFT JOIN dbo.U_EAGRFLEN_PDedHist WITH (NOLOCK)
    --    On PdhEEID = xEEID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'AGR_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'AGR_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEAGRFLEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAGRFLEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAGRFLEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301271'
       ,expStartPerControl     = '202301271'
       ,expLastEndPerControl   = '202302039'
       ,expEndPerControl       = '202302039'
WHERE expFormatCode = 'EAGRFLEN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAGRFLEN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAGRFLEN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAGRFLEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAGRFLEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAGRFLEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAGRFLEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAGRFLEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAGRFLEN', 'UseFileName', 'V', 'Y'


-- End ripout