/**********************************************************************************

ELKD365EXP: Dynamics 365 Payroll Expense

FormatCode:     ELKD365EXP
Project:        Dynamics 365 Payroll Expense
Client ID:      LAI1001
Date/time:      2023-07-20 20:32:04.580
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPLAIKA
Web Filename:   LAI1001_K8KNG_EEHISTORY_ELKD365EXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELKD365EXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ELKD365EXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELKD365EXP'


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
WHERE FormatCode = 'ELKD365EXP'
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
WHERE ExpFormatCode = 'ELKD365EXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELKD365EXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELKD365EXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELKD365EXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELKD365EXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELKD365EXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELKD365EXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELKD365EXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELKD365EXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELKD365EXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELKD365EXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELKD365EXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELKD365EXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELKD365EXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELKD365EXP];
GO
IF OBJECT_ID('U_ELKD365EXP_WorkingTbl') IS NOT NULL DROP TABLE [dbo].[U_ELKD365EXP_WorkingTbl];
GO
IF OBJECT_ID('U_ELKD365EXP_Header') IS NOT NULL DROP TABLE [dbo].[U_ELKD365EXP_Header];
GO
IF OBJECT_ID('U_ELKD365EXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELKD365EXP_File];
GO
IF OBJECT_ID('U_ELKD365EXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELKD365EXP_EEList];
GO
IF OBJECT_ID('U_ELKD365EXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELKD365EXP_drvTbl];
GO
IF OBJECT_ID('U_ELKD365EXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELKD365EXP_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELKD365EXP','Dynamics 365 Payroll Expense','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ELKD365EXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELKD365EXPZ0','50','H','01','1',NULL,'JOURNALNAME',NULL,NULL,'"JOURNALNAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELKD365EXPZ0','50','H','01','2',NULL,'DESCRIPTION',NULL,NULL,'"DESCRIPTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELKD365EXPZ0','50','H','01','3',NULL,'VOUCHER',NULL,NULL,'"VOUCHER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELKD365EXPZ0','50','H','01','4',NULL,'DOCUMENTDATE',NULL,NULL,'"DOCUMENTDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELKD365EXPZ0','50','H','01','5',NULL,'TRANSDATE',NULL,NULL,'"TRANSDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELKD365EXPZ0','50','H','01','6',NULL,'DEBITAMOUNT',NULL,NULL,'"DEBITAMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELKD365EXPZ0','50','H','01','7',NULL,'CREDITAMOUNT',NULL,NULL,'"CREDITAMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELKD365EXPZ0','50','H','01','8',NULL,'ACCOUNTDISPLAYVALUE',NULL,NULL,'"ACCOUNTDISPLAYVALUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELKD365EXPZ0','50','H','01','9',NULL,'DEFAULTDIMENSIONDISPLAYVALUE',NULL,NULL,'"DEFAULTDIMENSIONDISPLAYVALUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELKD365EXPZ0','50','H','01','10',NULL,'TEXT',NULL,NULL,'"TEXT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELKD365EXPZ0','50','H','01','11',NULL,'REVERSEDATE',NULL,NULL,'"REVERSEDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELKD365EXPZ0','50','H','01','12',NULL,'REVERSEENTRY',NULL,NULL,'"REVERSEENTRY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELKD365EXPZ0','50','H','01','13',NULL,'JOURNALBATCHNUMBER',NULL,NULL,'"JOURNALBATCHNUMBER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELKD365EXPZ0','50','H','01','14',NULL,'ACCOUNTTYPE',NULL,NULL,'"ACCOUNTTYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELKD365EXPZ0','50','H','01','15',NULL,'CURRENCYCODE',NULL,NULL,'"CURRENCYCODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELKD365EXPZ0','50','H','01','16',NULL,'EXCHANGERATE',NULL,NULL,'"EXCHANGERATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELKD365EXPZ0','50','H','01','17',NULL,'DCVAMCOMPANY',NULL,NULL,'"DCVAMCOMPANY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELKD365EXPZ0','50','H','01','18',NULL,'LINENUMBER',NULL,NULL,'"LINENUMBER"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELKD365EXPZ0','50','D','10','1',NULL,'JOURNALNAME',NULL,NULL,'"drvJournalName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELKD365EXPZ0','50','D','10','2',NULL,'DESCRIPTION',NULL,NULL,'"drvDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELKD365EXPZ0','50','D','10','3',NULL,'VOUCHER',NULL,NULL,'"drvVoucher"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELKD365EXPZ0','50','D','10','4',NULL,'DOCUMENTDATE',NULL,NULL,'"drvDocumentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELKD365EXPZ0','50','D','10','5',NULL,'TRANSDATE',NULL,NULL,'"drvTransDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELKD365EXPZ0','50','D','10','6',NULL,'DEBITAMOUNT',NULL,NULL,'"drvDebitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELKD365EXPZ0','50','D','10','7',NULL,'CREDITAMOUNT',NULL,NULL,'"drvCreditAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELKD365EXPZ0','50','D','10','8',NULL,'ACCOUNTDISPLAYVALUE',NULL,NULL,'"drvAccountDisplayValue"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELKD365EXPZ0','50','D','10','9',NULL,'DEFAULTDIMENSIONDISPLAYVALUE',NULL,NULL,'"drvDefaultDimensionDisplayVal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELKD365EXPZ0','50','D','10','10',NULL,'TEXT',NULL,NULL,'"drvText"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELKD365EXPZ0','50','D','10','11',NULL,'REVERSEDATE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELKD365EXPZ0','51','D','10','12',NULL,'REVERSEENTRY',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELKD365EXPZ0','52','D','10','13',NULL,'JOURNALBATCHNUMBER',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELKD365EXPZ0','53','D','10','14',NULL,'ACCOUNTTYPE',NULL,NULL,'"LEDGER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELKD365EXPZ0','54','D','10','15',NULL,'CURRENCYCODE',NULL,NULL,'"USD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELKD365EXPZ0','64','D','10','16',NULL,'EXCHANGERATE',NULL,NULL,'"100"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELKD365EXPZ0','64','D','10','17',NULL,'DCVAMCOMPANY',NULL,NULL,'"LINC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELKD365EXPZ0','76','D','10','19',NULL,'LINENUMBER',NULL,NULL,'"drvLINENUMBER"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELKD365EXP_20230720.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Dynamics 365 Payroll Expense','202305109','EMPEXPORT','ONDEM_XOE',NULL,'ELKD365EXP',NULL,NULL,NULL,'202305109','May 10 2023 11:15AM','May 10 2023 11:15AM','202305031',NULL,'','','202305031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dynamics 365 Payroll Exp-Sched','202305109','EMPEXPORT','SCH_ELKD3X',NULL,'ELKD365EXP',NULL,NULL,NULL,'202305109','May 10 2023 11:15AM','May 10 2023 11:15AM','202305031',NULL,'','','202305031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','W7V17',NULL,NULL,NULL,'Dynamics 365 Payroll Exp-Test','202307079','EMPEXPORT','TEST_XOE',NULL,'ELKD365EXP',NULL,NULL,NULL,'202307079','May 10 2023 11:15AM','May 10 2023 11:15AM','202306241',NULL,'','','202306241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELKD365EXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELKD365EXP','H01','dbo.U_ELKD365EXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELKD365EXP','D10','dbo.U_ELKD365EXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ELKD365EXP_DedList
-----------

IF OBJECT_ID('U_ELKD365EXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELKD365EXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ELKD365EXP_drvTbl
-----------

IF OBJECT_ID('U_ELKD365EXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELKD365EXP_drvTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] bigint NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalName] varchar(7) NOT NULL,
    [drvDescription] varchar(103) NULL,
    [drvVoucher] varchar(1) NOT NULL,
    [drvDocumentDate] varchar(30) NULL,
    [drvTransDate] varchar(30) NULL,
    [drvDebitAmount] nvarchar(4000) NULL,
    [drvCreditAmount] nvarchar(4000) NULL,
    [drvAccountDisplayValue] varchar(8000) NULL,
    [drvDefaultDimensionDisplayVal] varchar(8000) NULL,
    [drvText] varchar(102) NOT NULL,
    [drvLineNumber] bigint IDENTITY(1,1) NOT NULL
);

-----------
-- Create table U_ELKD365EXP_EEList
-----------

IF OBJECT_ID('U_ELKD365EXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELKD365EXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELKD365EXP_File
-----------

IF OBJECT_ID('U_ELKD365EXP_File') IS NULL
CREATE TABLE [dbo].[U_ELKD365EXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ELKD365EXP_Header
-----------

IF OBJECT_ID('U_ELKD365EXP_Header') IS NULL
CREATE TABLE [dbo].[U_ELKD365EXP_Header] (
    [drvOFFSETDEFAULTDIMDISPLAYVAL] varchar(28) NOT NULL
);

-----------
-- Create table U_ELKD365EXP_WorkingTbl
-----------

IF OBJECT_ID('U_ELKD365EXP_WorkingTbl') IS NULL
CREATE TABLE [dbo].[U_ELKD365EXP_WorkingTbl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(35) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvJournalName] varchar(7) NOT NULL,
    [drvDescription] varchar(103) NULL,
    [drvVoucher] varchar(1) NOT NULL,
    [drvDocumentDate] varchar(30) NULL,
    [drvTransDate] varchar(30) NULL,
    [drvDebitAmount] nvarchar(4000) NULL,
    [drvCreditAmount] nvarchar(4000) NULL,
    [drvAccountDisplayValue] varchar(8000) NULL,
    [drvDefaultDimensionDisplayVal] varchar(8000) NULL,
    [drvText] varchar(102) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELKD365EXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Laika 

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 05/10/2023
Service Request Number: TekP-2023-02-23-03 

Purpose: Dynamics 365 Payroll Expense

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELKD365EXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELKD365EXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELKD365EXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELKD365EXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELKD365EXP' ORDER BY RunID DESC;



UPDATE dbo.AscExp
    SET expLastStartPerControl = '202306151'
       ,expStartPerControl     = '202306151'
       ,expLastEndPerControl   = '202306169'
       ,expEndPerControl       = '202306169'
WHERE expFormatCode = 'ELKD365EXP' and expexportcode = 'TEST_XOE';


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELKD365EXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELKD365EXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELKD365EXP', 'SCH_ELKD3X';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELKD365EXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELKD365EXP';

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
    DELETE FROM dbo.U_ELKD365EXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELKD365EXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_ELKD365EXP_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_ELKD365EXP_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_ELKD365EXP_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    --Build Working Tables
    -- IF OBJECT_ID('U_ELKD365EXP_CreditTbl','U') IS NOT NULL
 --       DROP TABLE dbo.U_ELKD365EXP_CreditTbl;

 --  Select veeid as CreditEEID, LEFT(vGLAcctNumber,11) AS CreditGLAcctNumber,VGLBaseSeg AS CreditGLBaseSeg, Sum(vCreditAmt) AS CreditAmt, vAcctdesc AS CreditAcctDesc
 --  INTO dbo.U_ELKD365EXP_CreditTbl
 --  FROM dbo.vw_Dsi_Tmpalloc With (Nolock) 
 --    Where vGLAcctNumber <> 'NOGL'
    -- AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
 --   AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112)
    --group by veeid, LEFT(vGLAcctNumber,11),VGLBaseSeg,vacctdesc
    --having Sum(vCreditAmt) <> 0.00
    --order by veeid, LEFT(vGLAcctNumber,11), VGLBaseSeg


    --IF OBJECT_ID('U_ELKD365EXP_DebitTbl','U') IS NOT NULL
 --       DROP TABLE dbo.U_ELKD365EXP_DebitTbl;
    --Select veeid as DebitEEID, LEFT(vGLAcctNumber,11) AS DebitGLAcctNumber,VGLBaseSeg AS DebitGLBaseSeg, Sum(vDebitAmt) AS DebitAmt, vAcctdesc AS DebitAcctDesc
    -- INTO dbo.U_ELKD365EXP_DebitTbl
 --    FROM --dbo.U_ELKD365EXP_EEList WITH (NOLOCK)
 --      dbo.vw_Dsi_Tmpalloc With (Nolock) 
 --    Where vGLAcctNumber <> 'NOGL'
    -- AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
 --    AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112) 
    --group by veeid, LEFT(vGLAcctNumber,11),VGLBaseSeg,vacctdesc
    --having Sum(vDebitAmt) <> 0.00
    --order by veeid, LEFT(vGLAcctNumber,11),VGLBaseSeg


    IF OBJECT_ID('dbo.U_ELKD365EXP_WorkingTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELKD365EXP_WorkingTbl;

        SELECT  
         drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort = (select CONVERT(varchar,substring('00000',1,2)) +
       RIGHT(REPLICATE('0',5) + convert(varchar,(CONVERT(int, substring('00000',3,5)) + 1)) ,5))--  dbo.dsi_fnPadZero(ROW_NUMBER() OVER(ORDER BY LEFT(max(GLAcctNumber),11) ASC), 6, 0)
        ,drvSubSort = ''
        ,drvJournalName = 'PAYROLL'
        ,drvDescription = max(lDescription)
        ,drvVoucher = '1'
        ,drvDocumentDate  = max(DocumentDate)
        ,drvTransDate = max(TransDate)
        ,drvDebitAmount =  Format(sum(DebitAmt),'0.00')
        ,drvCreditAmount = Format(sum(CreditAmt), '0.00')
        ,drvAccountDisplayValue = AccountDisplayValue
        ,drvDefaultDimensionDisplayVal =  DefaultDimensionDisplayVal
        ,drvText = lText
        
         INTO dbo.U_ELKD365EXP_WorkingTbl
     
    FROM (

        Select 
             veeid as EEID
            ,vcode  
            ,GLAcctNumber =LEFT(vGLAcctNumber,11) 
            ,VGLBaseSeg AS GLBaseSeg
            ,Sum(vDebitAmt) AS DebitAmt
            ,CreditAmt = Sum(0.00)
            ,vAcctdesc AS AcctDesc
            ,lDescription =  Concat('UKG', cast(Month(MAX(VPercontrolDate))as varchar) ,'/',cast(YEAR(Max(VPercontrolDate))as varchar),'_PR-GL_', 'PP',cast(datepart(wk,max(VPercontrolDate))/2 as varchar) )
            ,DocumentDate =Convert(varchar,MAX(vPaydate), 101)
            ,TransDate = Convert(varchar,MAX(vPeriodEndDate), 101)
            ,AccountDisplayValue =  CASE WHEN (Left(max(VGLBaseSeg), 1) IN ( '5', '6') or max(VGLBaseSeg) = '212020')  THEN  MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
                                        WHEN  (Left(max(VGLBaseSeg), 1) NOT IN ( '5', '6') and max(VGLBaseSeg) <> '212020')  THEN MAX(Concat(RTRIM(vGLBaseSeg),'.','' ,'.','','.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
                                     END
            ,DefaultDimensionDisplayVal =  CASE WHEN (Left(Max(VGLBaseSeg), 1) IN ( '5', '6') or max(VGLBaseSeg) = '212020')  THEN  MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
                                                WHEN(Left(max(VGLBaseSeg), 1) NOT IN ( '6', '5') and max(VGLBaseSeg) <> '212020')  THEN MAX(Concat(RTRIM((vGLBaseSeg)),'.','' ,'.','','.',LTRIm(RTRIM(Replace((vProject), 'Z',''))),'.',vEmpNo))
                                            END
            ,lText =  Concat(Convert(varchar, MAX(vPeriodStartDate), 101),'-',convert(Varchar, Max(vPeriodEndDate), 101) ,'/',max(VAcctDesc))
         
    --INTO dbo.U_ELKD365EXP_DebitTbl
     FROM --dbo.U_ELKD365EXP_EEList WITH (NOLOCK)
       dbo.vw_Dsi_Tmpalloc With (Nolock) 
     Where vGLAcctNumber <> 'NOGL'
     AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
   --  AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112) 

    group by veeid, vcode, LEFT(vGLAcctNumber,11), VGLBaseSeg,vacctdesc ,vDebitAmt, vcreditamt
    having Sum(vDebitAmt) <> 0.00
    --order by veeid,vcode, LEFT(vGLAcctNumber,11),VGLBaseSeg
    ) a
    Group by   eeid, vcode, GLAcctNumber, AccountDisplayValue, DefaultDimensionDisplayVal, lText

    INSERT  INTO dbo.U_ELKD365EXP_WorkingTbl
    (
     
         drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        ,drvJournalName 
        ,drvDescription 
        ,drvVoucher 
        ,drvDocumentDate 
        ,drvTransDate 
        ,drvDebitAmount 
        ,drvCreditAmount 
        ,drvAccountDisplayValue 
        ,drvDefaultDimensionDisplayVal 
        ,drvText 
        
        )


    SELECt  drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort = (select CONVERT(varchar,substring('00000',1,2)) +
       RIGHT(REPLICATE('0',5) + convert(varchar,(CONVERT(int, substring('00000',3,5)) + 1)) ,5))--=   dbo.dsi_fnPadZero(ROW_NUMBER() OVER(ORDER BY (count(*)) ASC), 6, 0)
        ,drvSubSort = ''
        ,drvJournalName = 'PAYROLL'
        ,drvDescription = max(lDescription)
        ,drvVoucher = '1'
        ,drvDocumentDate  = max(DocumentDate)
        ,drvTransDate = max(TransDate)
        ,drvDebitAmount =  Format(sum(DebitAmt),'0.00')
        ,drvCreditAmount = Format(sum(CreditAmt), '0.00')
        ,drvAccountDisplayValue = AccountDisplayValue
        ,drvDefaultDimensionDisplayVal =  DefaultDimensionDisplayVal
        ,drvText = lText
       -- ,drvLINENUMBER =  '' --ROW_NUMBER() OVER(ORDER BY (count(*)) ASC)
    
    FROm(
   Select 
             veeid as EEID
            ,vcode  
            ,LEFT(vGLAcctNumber,11) AS GLAcctNumber
            ,VGLBaseSeg AS GLBaseSeg
            ,DebitAmt = sum(0.00)
            ,Sum(vCreditAmt) as CreditAmt
            ,vAcctdesc AS AcctDesc
            ,lDescription =  Concat('UKG', cast(Month(MAX(VPercontrolDate))as varchar) ,'/',cast(YEAR(Max(VPercontrolDate))as varchar),'_PR-GL_', 'PP',cast(datepart(wk,max(VPercontrolDate))/2 as varchar) )
            ,DocumentDate =Convert(varchar,MAX(vPaydate), 101)
            ,TransDate = Convert(varchar,MAX(vPeriodEndDate), 101)
            ,AccountDisplayValue =  CASE WHEN (Left(max(VGLBaseSeg), 1) IN ( '5', '6') or max(VGLBaseSeg) = '212020')  THEN  MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
                                        WHEN  (Left(max(VGLBaseSeg), 1) NOT IN ( '5', '6') and max(VGLBaseSeg) <> '212020')  THEN MAX(Concat(RTRIM(vGLBaseSeg),'.','' ,'.','','.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
                                     END
            ,DefaultDimensionDisplayVal =  CASE WHEN (Left(Max(VGLBaseSeg), 1) IN ( '5', '6') or max(VGLBaseSeg) = '212020')  THEN  MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
                                                WHEN(Left(max(VGLBaseSeg), 1) NOT IN ( '6', '5') and max(VGLBaseSeg) <> '212020')  THEN MAX(Concat(RTRIM((vGLBaseSeg)),'.','' ,'.','','.',LTRIm(RTRIM(Replace((vProject), 'Z',''))),'.',vEmpNo))
                                            END
            ,lText =  Concat(Convert(varchar, MAX(vPeriodStartDate), 101),'-',convert(Varchar, Max(vPeriodEndDate), 101) ,'/',max(VAcctDesc))
    
 --  INTO dbo.U_ELKD365EXP_CreditTbl
   FROM dbo.vw_Dsi_Tmpalloc With (Nolock) 
     Where vGLAcctNumber <> 'NOGL'
     AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
    --AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112)

    group by veeid, vcode, LEFT(vGLAcctNumber,11),vCreditAmt, VGLBaseSeg,vacctdesc
    having Sum(vCreditAmt) <> 0.00
    --order by veeid,vcode, LEFT(vGLAcctNumber,11), VGLBaseSeg 
    ) a
    Group by   eeid, vcode, GLAcctNumber, AccountDisplayValue, DefaultDimensionDisplayVal, lText
--    order by eeid, vcode, GLAcctNumber, a.DebitAmt, a.CreditAmt

    

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELKD365EXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELKD365EXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELKD365EXP_drvTbl;

        SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
       -- ,drvDepRecID = ''CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ROW_NUMBER() OVER(ORDER BY drvAccountDisplayValue )
        ,drvSubSort = ''
        ,drvJournalName 
        ,drvDescription 
        ,drvVoucher 
        ,drvDocumentDate  
        ,drvTransDate  
        ,drvDebitAmount 
        ,drvCreditAmount 
        ,drvAccountDisplayValue 
        ,drvDefaultDimensionDisplayVal 
        ,drvText 
        , IDENTITY(bigint, 1, 1) as drvLineNumber
        


        INTO dbo.U_ELKD365EXP_drvTbl
       FROm dbo.U_ELKD365EXP_WorkingTbl w
       
    --      UPDATE dbo.U_ELKD365EXP_drvTbl
    --SET drvInitialSort =  convert(varchar, drvLineNumber)
     
    
    ;
 --   SELECT DISTINCT
 --      drvEEID = ''
 --       ,drvCoID = ''
 --      -- ,drvDepRecID = ''CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
 --       ,drvInitialSort =   dbo.dsi_fnPadZero(ROW_NUMBER() OVER(ORDER BY LEFT(max(vGLAcctNumber),11) ASC), 6, 0)
 --       ,drvSubSort = ''
 --       -- standard fields above and additional driver fields below
 --       ,drvJournalName = 'PAYROLL'
 --       ,drvDescription = Concat('UKG', cast(Month(MAX(VPercontrolDate))as varchar) ,'/',cast(YEAR(Max(VPercontrolDate))as varchar),'_PR-GL_', 'PP',cast(datepart(wk,max(VPercontrolDate))/2 as varchar) )
 --       ,drvVoucher = '1'
 --      -- ,drvLineNumber = LEFT(vGLAcctNumber,11)
 --       ,drvDocumentDate =Convert(varchar,MAX(vPaydate), 101) 
 --       ,drvTransDate = Convert(varchar,MAX(vPeriodEndDate), 101) 
 --       ,drvDebitAmount = DebitAmt
 --       ,drvCreditAmount = CreditAmt
 --       ,drvAccountDisplayValue = CASE WHEN (Left(VGLBaseSeg, 1) IN ( '5', '6') or VGLBaseSeg = '212020')  THEN  MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
    --     WHEN  (Left(VGLBaseSeg, 1) NOT IN ( '5', '6') and VGLBaseSeg <> '212020')  THEN MAX(Concat(RTRIM(vGLBaseSeg),'.','' ,'.','','.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
    --     END
 --       ,drvDefaultDimensionDisplayVal =  CASE WHEN (Left(VGLBaseSeg, 1) IN ( '5', '6') or VGLBaseSeg = '212020')  THEN  MAX(Concat(RTRIM(vGLBaseSeg),'.',RTRIM(vOrgLvl1Seg) ,'.',RTRIM(vOrgLvl2Seg),'.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
    --     WHEN(Left(VGLBaseSeg, 1) NOT IN ( '6', '5') and VGLBaseSeg <> '212020')  THEN MAX(Concat(RTRIM(vGLBaseSeg),'.','' ,'.','','.',LTRIm(RTRIM(Replace(vProject, 'Z',''))),'.',vEmpNo))
    --     END
 --       ,drvText =  Concat(Convert(varchar, MAX(vPeriodStartDate), 101),'-',convert(Varchar, Max(vPeriodEndDate), 101) ,'/',VAcctDesc)
    --    ,drvLINENUMBER =  ROW_NUMBER() OVER(ORDER BY LEFT(MAX(vGLAcctNumber),11) ASC)
 --   INTO dbo.U_ELKD365EXP_drvTbl
 --   FROM --dbo.U_ELKD365EXP_EEList WITH (NOLOCK)
 --       dbo.vw_Dsi_Tmpalloc With (Nolock) 
    --LEFT JOIN dbo.U_ELKD365EXP_DebitTbl ON Debiteeid = Veeid and DebitGLAcctNumber = LEFT(vGLAcctNumber,11) and DebitGLBaseSeg = VGLBaseSeg and DebitAcctDesc = vAcctDesc 
    --LEFT JOIN dbo.U_ELKD365EXP_CreditTbl ON Crediteeid = Veeid and CreditGLAcctNumber = LEFT(vGLAcctNumber,11) and CreditGLBaseSeg = VGLBaseSeg and CreditAcctDesc = vAcctDesc 
 --    Where vGLAcctNumber <> 'NOGL'
    ---- and vempno = '02706'
    --and (  (DebitAmt is null and CreditAmt is not null) or   (DebitAmt is not null and CreditAmt  is null)) 
    --AND Convert(varchar,vPeriodstartdate, 112) = Convert(varchar, @StartDate,112) and vPeriodEndDate = Convert(varchar, @EndDate,112) 
 --  --  AND Convert(varchar,vPaydate, 112) between Convert(varchar, @StartDate,112) and Convert(varchar, @EndDate,112)
    -- Group by veeid,VAcctDesc, DebitAmt, CreditAmt, VGLBaseSeg
 --   ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELKD365EXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ELKD365EXP_Header;
    SELECT DISTINCT
         drvOFFSETDEFAULTDIMDISPLAYVAL = 'DEFAULTDIMENSIONDISPLAYVALUE'
    INTO dbo.U_ELKD365EXP_Header
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
ALTER VIEW dbo.dsi_vwELKD365EXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELKD365EXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELKD365EXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
     SET expLastStartPerControl = '202305271'
       ,expStartPerControl     = '202305271'
       ,expLastEndPerControl   = '202306099'
       ,expEndPerControl       = '202306099'
WHERE expFormatCode = 'ELKD365EXP' and expexportcode = 'TEST_XOE' ;

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELKD365EXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELKD365EXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELKD365EXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELKD365EXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELKD365EXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELKD365EXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELKD365EXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELKD365EXP', 'UseFileName', 'V', 'Y'


-- End ripout