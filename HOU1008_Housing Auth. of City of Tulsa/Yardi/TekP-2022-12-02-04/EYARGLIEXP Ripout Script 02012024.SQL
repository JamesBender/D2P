/**********************************************************************************

EYARGLIEXP: Yardi GL Payroll Export

FormatCode:     EYARGLIEXP
Project:        Yardi GL Payroll Export
Client ID:      HOU1008
Date/time:      2024-02-01 09:48:05.227
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB03
Database:       ULTIPRO_WPHACT
Web Filename:   HOU1008_Z4QCY_EEHISTORY_EYARGLIEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EYARGLIEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EYARGLIEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EYARGLIEXP'


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
WHERE FormatCode = 'EYARGLIEXP'
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
WHERE ExpFormatCode = 'EYARGLIEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EYARGLIEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EYARGLIEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EYARGLIEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EYARGLIEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EYARGLIEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EYARGLIEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EYARGLIEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EYARGLIEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EYARGLIEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EYARGLIEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEYARGLIEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEYARGLIEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EYARGLIEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EYARGLIEXP];
GO
IF OBJECT_ID('U_EYARGLIEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EYARGLIEXP_PEarHist];
GO
IF OBJECT_ID('U_EYARGLIEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EYARGLIEXP_File];
GO
IF OBJECT_ID('U_EYARGLIEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EYARGLIEXP_EEList];
GO
IF OBJECT_ID('U_EYARGLIEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EYARGLIEXP_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EYARGLIEXP','Yardi GL Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EYARGLIEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EYARGLIEXPZ0','50','H','01','1',NULL,'TYPE',NULL,NULL,'"TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EYARGLIEXPZ0','50','H','01','2',NULL,'TRANNUM',NULL,NULL,'"TRANNUM"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EYARGLIEXPZ0','50','H','01','3',NULL,'DATE',NULL,NULL,'"DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EYARGLIEXPZ0','50','H','01','4',NULL,'POSTMONTH',NULL,NULL,'"POSTMONTH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EYARGLIEXPZ0','50','H','01','5',NULL,'REF',NULL,NULL,'"REF"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EYARGLIEXPZ0','50','H','01','6',NULL,'REMARK',NULL,NULL,'"REMARK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EYARGLIEXPZ0','50','H','01','7',NULL,'PROPERTY',NULL,NULL,'"PROPERTY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EYARGLIEXPZ0','50','H','01','8',NULL,'AMOUNT',NULL,NULL,'"AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EYARGLIEXPZ0','50','H','01','9',NULL,'ACCOUNT',NULL,NULL,'"ACCOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EYARGLIEXPZ0','50','H','01','10',NULL,'DESC',NULL,NULL,'"DESC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EYARGLIEXPZ0','50','H','01','11',NULL,'BOOKNUM',NULL,NULL,'"BOOKNUM"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EYARGLIEXPZ0','50','H','01','12',NULL,'ISINTERCOMPANY',NULL,NULL,'"ISINTERCOMPANY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EYARGLIEXPZ0','50','H','01','13',NULL,'DISPLAYTYPE',NULL,NULL,'"DISPLAYTYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EYARGLIEXPZ0','50','H','01','14',NULL,'COMPANY',NULL,NULL,'"COMPANY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EYARGLIEXPZ0','50','H','01','15',NULL,'FUNDINGENTITY',NULL,NULL,'"FUNDINGENTITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EYARGLIEXPZ0','50','H','01','16',NULL,'JOB',NULL,NULL,'"JOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EYARGLIEXPZ0','50','H','01','17',NULL,'CATEGORY',NULL,NULL,'"CATEGORY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EYARGLIEXPZ0','50','H','01','18',NULL,'SEGMENT2',NULL,NULL,'"SEGMENT2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EYARGLIEXPZ0','100','D','10','1',NULL,'TYPE',NULL,NULL,'"drvTYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EYARGLIEXPZ0','100','D','10','2',NULL,'TRANNUM',NULL,NULL,'"drvTRANNUM"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EYARGLIEXPZ0','100','D','10','3',NULL,'DATE',NULL,NULL,'"drvDATE"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EYARGLIEXPZ0','100','D','10','4',NULL,'POSTMONTH',NULL,NULL,'"drvPOSTMONTH"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EYARGLIEXPZ0','100','D','10','5',NULL,'REF',NULL,NULL,'"drvREF"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EYARGLIEXPZ0','100','D','10','6',NULL,'REMARK',NULL,NULL,'"drvREMARK"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EYARGLIEXPZ0','100','D','10','7',NULL,'PROPERTY',NULL,NULL,'"drvPROPERTY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EYARGLIEXPZ0','100','D','10','8',NULL,'AMOUNT',NULL,NULL,'"drvAMOUNT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EYARGLIEXPZ0','100','D','10','9',NULL,'ACCOUNT',NULL,NULL,'"drvACCOUNT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EYARGLIEXPZ0','100','D','10','10',NULL,'DESC',NULL,NULL,'"drvDESC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EYARGLIEXPZ0','100','D','10','11',NULL,'BOOKNUM',NULL,NULL,'"drvBOOKNUM"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EYARGLIEXPZ0','100','D','10','12',NULL,'ISINTERCOMPANY',NULL,NULL,'"drvISINTERCOMPANY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EYARGLIEXPZ0','100','D','10','13',NULL,'DISPLAYTYPE',NULL,NULL,'"drvDISPLAYTYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EYARGLIEXPZ0','100','D','10','14',NULL,'COMPANY',NULL,NULL,'"drvCOMPANY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EYARGLIEXPZ0','100','D','10','15',NULL,'FUNDINGENTITY',NULL,NULL,'"drvFUNDINGENTITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EYARGLIEXPZ0','100','D','10','16',NULL,'JOB',NULL,NULL,'"drvJOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EYARGLIEXPZ0','100','D','10','17',NULL,'CATEGORY',NULL,NULL,'"drvCATEGORY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EYARGLIEXPZ0','100','D','10','18',NULL,'SEGMENT2',NULL,NULL,'"drvSEGMENT2"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EYARGLIEXP_20240201.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Yardi GL Payroll Export','202301189','EMPEXPORT','ONDEM_XOE',NULL,'EYARGLIEXP',NULL,NULL,NULL,'202301189','Jan 18 2023  8:55PM','Jan 18 2023  8:55PM','202301181',NULL,'','','202301181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202301189','EMPEXPORT','SCH_YARGSH',NULL,'EYARGLIEXP',NULL,NULL,NULL,'202301189','Jan 18 2023  8:55PM','Jan 18 2023  8:55PM','202301181',NULL,'','','202301181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','EQ5ZN',NULL,NULL,NULL,'Test Purposes Only','202401059','EMPEXPORT','TEST_XOE',NULL,'EYARGLIEXP',NULL,NULL,NULL,'202401059','Jan 18 2023  8:55PM','Jan 18 2023  8:55PM','202401051',NULL,'','','202401051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYARGLIEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EYARGLIEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EYARGLIEXP','D10','dbo.U_EYARGLIEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EYARGLIEXP_drvTbl
-----------

IF OBJECT_ID('U_EYARGLIEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EYARGLIEXP_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvTYPE] varchar(1) NOT NULL,
    [drvTRANNUM] varchar(1) NOT NULL,
    [drvDATE] varchar(10) NULL,
    [drvPOSTMONTH] datetime NULL,
    [drvREF] varchar(1) NOT NULL,
    [drvREMARK] varchar(18) NULL,
    [drvPROPERTY] varchar(6) NULL,
    [drvAMOUNT] money NULL,
    [drvACCOUNT] varchar(50) NULL,
    [drvDESC] varchar(106) NOT NULL,
    [drvBOOKNUM] varchar(1) NOT NULL,
    [drvISINTERCOMPANY] varchar(4) NOT NULL,
    [drvDISPLAYTYPE] varchar(32) NOT NULL,
    [drvCOMPANY] varchar(10) NOT NULL,
    [drvFUNDINGENTITY] varchar(6) NOT NULL,
    [drvJOB] varchar(15) NULL,
    [drvCATEGORY] varchar(8) NULL,
    [drvSEGMENT2] varchar(15) NULL
);

-----------
-- Create table U_EYARGLIEXP_EEList
-----------

IF OBJECT_ID('U_EYARGLIEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EYARGLIEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EYARGLIEXP_File
-----------

IF OBJECT_ID('U_EYARGLIEXP_File') IS NULL
CREATE TABLE [dbo].[U_EYARGLIEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EYARGLIEXP_PEarHist
-----------

IF OBJECT_ID('U_EYARGLIEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EYARGLIEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EYARGLIEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Housing Authority of the City of Tulsa

Created By: Marco Lagrosa
Business Analyst: Curlin Beck
Create Date: 01/18/2023
Service Request Number: TekP-2022-12-02-04

Purpose: Yardi GL Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        2/1/2024       TekP-2022-12-02-04 Updated Category field
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EYARGLIEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EYARGLIEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EYARGLIEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EYARGLIEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EYARGLIEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EYARGLIEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EYARGLIEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EYARGLIEXP', 'SCH_YARGSH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EYARGLIEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EYARGLIEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EYARGLIEXP';

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
    --DELETE FROM dbo.U_EYARGLIEXP_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EYARGLIEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

 
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EYARGLIEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EYARGLIEXP_PEarHist;
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
    INTO dbo.U_EYARGLIEXP_PEarHist
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
    -- DETAIL RECORD - U_EYARGLIEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EYARGLIEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EYARGLIEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvDepRecID = '' --CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '' --vLocation + RTRIM(vGLBaseSeg) + case when vProject IS NULL   then vorglvl1   when vProject='Z'   then '  '   When vProject IS NOT NULL then  rtrim(vProject) end + vorglvl2
        ,drvSubSort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvTYPE = 'J'
        ,drvTRANNUM = '1'
        ,drvDATE = CONVERT(VARCHAR(10),vPayDate,101)
        ,drvPOSTMONTH =  DATEADD(month, DATEDIFF(month, 0, vPayDate), 0)
        ,drvREF = ''
        ,drvREMARK = CONVERT(VARCHAR(10),vPayDate,101) + '-Payroll'
        ,drvPROPERTY =  CASE WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then 'thauth'
                            else vLocation  END 
        ,drvAMOUNT = SUM(CAST(IIF(vGlAcctType = 'D', vDebitAmt,0.00) AS MONEY)) + SUM(CAST(IIF(vGlAcctType = 'C', vCreditAmt * -1,0.00) AS MONEY))
                --CASE WHEN vCreditAmt > 0.00 then -ABS(vCreditAmt) else abs(vDebitAmt) END  --  
                --CASE WHEN vCreditAmt > 0.00 then ((vCreditAmt)*(-1)) else vDebitAmt END Credits and Debit Column total should equal 0.00 20230207 CB
        ,drvACCOUNT = RTRIM(vGLBaseSeg)
        ,drvDESC = concat(rtrim(CONVERT(VARCHAR(10),vPayDate,101)),'-',rtrim(vLocation),'-',rtrim(vGLBaseSeg),'-', rtrim(vOrgLvl1),'-',case when vProject is not null then rtrim(vProject) else '    ' end, '-', rtrim(vOrgLvl2)) -- Client want the order changed CB 20230206
        ,drvBOOKNUM = '1'
        ,drvISINTERCOMPANY = 'TRUE'
        ,drvDISPLAYTYPE = 'Job Cost IC Journal Display Type'
        ,drvCOMPANY = 'THAcentral'
        ,drvFUNDINGENTITY = 'thauth'
        ,drvJOB = case WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then ''
                    WHEN vProject is null or rtrim(vProject) = 'z' then ''
                    else rtrim(vProject)
                    end  
        ,drvCATEGORY = CASE WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then ''
                            WHEN vProject is null or rtrim(vProject) = 'z' then ''
                           -- else vOrgLvl2 -- MW commented out 2/1/24
                           ELSE vJobCode -- MW added 2/1/24
                          END  
        ,drvSEGMENT2 = CASE WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then ''
                            WHEN vProject is null or rtrim(vProject) = 'z' then vOrgLvl1
                            else rtrim(vProject)
                           END  
        ---case when vProject IS NULL   then vorglvl1   when vProject='Z'   then vorglvl1   When vProject IS NOT NULL then  rtrim(vProject) end  --Update the Segment to send Project when it is not equal to 'Z' or NULL else send OrgLevel1 20230207 CB
    INTO dbo.U_EYARGLIEXP_drvTbl
    FROM dbo.vw_Dsi_Tmpalloc  WITH (NOLOCK)
    GROUP BY vGLBaseSeg, vPayDate, vGlAcctType, vLocation, vOrgLvl1, vOrgLvl2, vProject, vJobCode
    ;

  
    
    --order by 
 --CASE WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then 'thauth' else vLocation  END , 
 --   RTRIM(vGLBaseSeg),
 --   case when vProject IS NULL then vorglvl1   when vProject='Z'   then '  '   When vProject IS NOT NULL then  rtrim(vProject) end,
 --   CASE WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then ''
    --                        WHEN vProject is null or vProject = 'z' then ''
    --                        else vorglvl2
 --                            END 
 --   ,CASE WHEN LEFT(vGLBaseSeg,1) in ('1','2')  then ''
    --                        WHEN vProject is null or vProject = 'z' then ''
    --                        else vorglvl1
 --                            END ;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEYARGLIEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EYARGLIEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EYARGLIEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202401051'
       ,expStartPerControl     = '202401051'
       ,expLastEndPerControl   = '202401059'
       ,expEndPerControl       = '202401059'
WHERE expFormatCode = 'EYARGLIEXP' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEYARGLIEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EYARGLIEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EYARGLIEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EYARGLIEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EYARGLIEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EYARGLIEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EYARGLIEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EYARGLIEXP', 'UseFileName', 'V', 'Y'


-- End ripout