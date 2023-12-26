/**********************************************************************************

ISCHWAB401: Schwab Deferral Import

FormatCode:     ISCHWAB401
Project:        Schwab Deferral Import
Client ID:      PRI1029
Date/time:      2023-09-07 14:06:42.107
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPPWC
Web Filename:   PRI1029_3Y7VH_EEHISTORY_ISCHWAB401_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\nw1\NW15\PWC\PRI1029\Imports\StandardImport\Archive\
ExportPath:    
ImportPath:    \\us.saas\nw1\NW15\PWC\PRI1029\Imports\Schwab\
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ISCHWAB401_SavePath') IS NOT NULL DROP TABLE dbo.U_ISCHWAB401_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ISCHWAB401'


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
WHERE FormatCode = 'ISCHWAB401'
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
WHERE ExpFormatCode = 'ISCHWAB401'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ISCHWAB401')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ISCHWAB401'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ISCHWAB401'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ISCHWAB401'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ISCHWAB401'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ISCHWAB401'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ISCHWAB401'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ISCHWAB401'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ISCHWAB401'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ISCHWAB401'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwISCHWAB401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwISCHWAB401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ISCHWAB401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ISCHWAB401];
GO
IF OBJECT_ID('U_ISCHWAB401_Raw') IS NOT NULL DROP TABLE [dbo].[U_ISCHWAB401_Raw];
GO
IF OBJECT_ID('U_ISCHWAB401_Import') IS NOT NULL DROP TABLE [dbo].[U_ISCHWAB401_Import];
GO
IF OBJECT_ID('U_ISCHWAB401_File') IS NOT NULL DROP TABLE [dbo].[U_ISCHWAB401_File];
GO
IF OBJECT_ID('U_ISCHWAB401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ISCHWAB401_EEList];
GO
IF OBJECT_ID('U_ISCHWAB401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ISCHWAB401_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N',NULL,'Y','0',NULL,NULL,'N',NULL,'N','E','013010','BENEFITIMP','SDF','ISCHWAB401','Scwab Deferral Import','N','I','FORM_ASCIIIMPORTBENEFITS','N','N',dbo.fn_GetTimedKey(),'D',NULL,'S','N','ISCHWAB401Z1','N',NULL,'N',NULL,'N',NULL,'N');
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ISCHWAB401','Schwab Deferral Import','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ISCHWAB401Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ISCHWAB401Z0','50','H','01','1',NULL,'Participant_SSN',NULL,NULL,'"Participant_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ISCHWAB401Z0','50','H','01','2',NULL,'Participant_Division',NULL,NULL,'"Participant_Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ISCHWAB401Z0','50','H','01','3',NULL,'Participant_Alt_Key1',NULL,NULL,'"Participant_Alt_Key1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ISCHWAB401Z0','50','H','01','4',NULL,'Participant_Alt_Key2',NULL,NULL,'"Participant_Alt_Key2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ISCHWAB401Z0','50','H','01','5',NULL,'Deferral_Change_Source_lndex',NULL,NULL,'"Deferral_Change_Source_lndex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ISCHWAB401Z0','50','H','01','6',NULL,'Deferral_Change_New_Percentage',NULL,NULL,'"Deferral_Change_New_Percentage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ISCHWAB401Z0','50','H','01','7',NULL,'Deferral_Chanee_New_Dollar_Amt',NULL,NULL,'"Deferral_Chanee_New_Dollar_Amt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ISCHWAB401Z0','50','H','01','8',NULL,'Deferral_Change_Effective_Date',NULL,NULL,'"Deferral_Change_Effective_Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ISCHWAB401Z0','50','H','01','9',NULL,'Loan_ID',NULL,NULL,'"Loan_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ISCHWAB401Z0','50','H','01','10',NULL,'Loan_Origination_Date',NULL,NULL,'"Loan_Origination_Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ISCHWAB401Z0','50','H','01','11',NULL,'Loan_First_Payment_Date',NULL,NULL,'"Loan_First_Payment_Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ISCHWAB401Z0','50','H','01','12',NULL,'Loan_Maturity_Date',NULL,NULL,'"Loan_Maturity_Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ISCHWAB401Z0','50','H','01','13',NULL,'Loan_Payment_Amount',NULL,NULL,'"Loan_Payment_Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ISCHWAB401Z0','50','H','01','14',NULL,'Import Type',NULL,NULL,'"Import Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ISCHWAB401Z0','50','H','01','15',NULL,'Action',NULL,NULL,'"Action"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ISCHWAB401Z0','50','H','01','16',NULL,'Error Message',NULL,NULL,'"Error Message"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ISCHWAB401Z0','50','D','10','1',NULL,'Participant_SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ISCHWAB401Z0','50','D','10','2',NULL,'Participant_Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ISCHWAB401Z0','50','D','10','3',NULL,'Participant_Alt_Key1',NULL,NULL,'"drvAltKey1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ISCHWAB401Z0','50','D','10','4',NULL,'Participant_Alt_Key2',NULL,NULL,'"drvAltKey2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ISCHWAB401Z0','50','D','10','5',NULL,'Deferral_Change_Source_lndex',NULL,NULL,'"drvChangeSource"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ISCHWAB401Z0','50','D','10','6',NULL,'Deferral_Change_New_Percentage',NULL,NULL,'"drvChangePct"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ISCHWAB401Z0','50','D','10','7',NULL,'Deferral_Chanee_New_Dollar_Amt',NULL,NULL,'"drvChangeAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ISCHWAB401Z0','50','D','10','8',NULL,'Deferral_Change_Effective_Date',NULL,NULL,'"drvChangeDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ISCHWAB401Z0','50','D','10','8',NULL,'Loan_ID',NULL,NULL,'"drvLoanID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ISCHWAB401Z0','50','D','10','10',NULL,'Loan_Origination_Date',NULL,NULL,'"drvLoanOrgDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ISCHWAB401Z0','50','D','10','11',NULL,'Loan_First_Payment_Date',NULL,NULL,'"drvLoanPayDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ISCHWAB401Z0','50','D','10','12',NULL,'Loan_Maturity_Date',NULL,NULL,'"drvLoanMatDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ISCHWAB401Z0','50','D','10','13',NULL,'Loan_Payment_Amount',NULL,NULL,'"drvLoanAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ISCHWAB401Z0','50','D','10','14',NULL,'Import Type',NULL,NULL,'"drvImportType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ISCHWAB401Z0','50','D','10','15',NULL,'Action',NULL,NULL,'"drvAction"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ISCHWAB401Z0','250','D','10','16',NULL,'Error',NULL,NULL,'"drvError"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ISCHWAB401_20230907.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Schwab Deferral Import ONDEM','202303229','EMPEXPORT','IMPORT','Mar 22 2023 12:00AM','ISCHWAB401',NULL,NULL,NULL,'202303229','Mar 22 2023 12:00AM','Dec 30 1899 12:00AM','202303221',NULL,'','','202303221',dbo.fn_GetTimedKey(),NULL,'us3dFoPRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','YHCR6,XRAEE,A0L99,2RHEW,XRS43,YHCNM',NULL,NULL,NULL,'Schwab Deferral Import SCHED','202303229','EMPEXPORT','SCH_ISCHWA','Mar 22 2023 12:00AM','ISCHWAB401',NULL,NULL,NULL,'202309039','Mar 22 2023 12:00AM','Dec 30 1899 12:00AM','202309011',NULL,'','','202303221',dbo.fn_GetTimedKey(),NULL,'us3dFoPRI1029',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','ArchivePath','V','\\us.saas\nw1\NW15\PWC\PRI1029\Imports\StandardImport\Archive\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','ImportPath','V','\\us.saas\nw1\NW15\PWC\PRI1029\Imports\Schwab\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ISCHWAB401','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ISCHWAB401','D10','dbo.U_ISCHWAB401_drvTbl WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ISCHWAB401_drvTbl
-----------

IF OBJECT_ID('U_ISCHWAB401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ISCHWAB401_drvTbl] (
    [drvSurrogateKey] varchar(50) NULL,
    [drvSSN] varchar(50) NULL,
    [drvDivision] varchar(50) NULL,
    [drvAltKey1] varchar(50) NULL,
    [drvBenefitStatus] varchar(50) NULL,
    [drvBenefitStatusDate] varchar(50) NULL,
    [drvBenefitStartDate] varchar(50) NULL,
    [drvBenefitStopDate] varchar(50) NULL,
    [drvDeductionStartDate] varchar(50) NULL,
    [drvDeductionStopDate] varchar(50) NULL,
    [drvAltKey2] varchar(50) NULL,
    [drvChangeSource] varchar(50) NULL,
    [drvEmployerPercent] varchar(50) NULL,
    [drvEmployerAmount] varchar(50) NULL,
    [drvBenefitOption] varchar(50) NULL,
    [drvBenefitAmount] varchar(50) NULL,
    [drvBenefitChangeReason] varchar(50) NULL,
    [drvLoanNumber] varchar(50) NULL,
    [drvChangePct] varchar(50) NULL,
    [drvChangeAmt] varchar(50) NULL,
    [drvChangeDate] varchar(50) NULL,
    [drvLoanID] varchar(50) NULL,
    [drvLoanOrgDate] varchar(50) NULL,
    [drvLoanPayDate] varchar(50) NULL,
    [drvLoanMatDate] varchar(50) NULL,
    [drvLoanAmt] varchar(50) NULL,
    [drvAction] varchar(50) NULL,
    [drvError] varchar(250) NULL,
    [drvImported] tinyint NOT NULL DEFAULT ((0)),
    [drvEEID] varchar(12) NULL,
    [drvCOID] varchar(5) NULL,
    [drvDedCode] varchar(50) NULL,
    [drvImportType] varchar(50) NULL,
    [drvPeriodStartDate] varchar(50) NULL,
    [drvPendingUpdateID] char(20) NULL,
    [drvInitialSort] varchar(50) NULL
);

-----------
-- Create table U_ISCHWAB401_EEList
-----------

IF OBJECT_ID('U_ISCHWAB401_EEList') IS NULL
CREATE TABLE [dbo].[U_ISCHWAB401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ISCHWAB401_File
-----------

IF OBJECT_ID('U_ISCHWAB401_File') IS NULL
CREATE TABLE [dbo].[U_ISCHWAB401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ISCHWAB401_Import
-----------

IF OBJECT_ID('U_ISCHWAB401_Import') IS NULL
CREATE TABLE [dbo].[U_ISCHWAB401_Import] (
    [RowNo] int NOT NULL,
    [FileName] varchar(max) NULL,
    [EEID] char(12) NULL,
    [COID] char(5) NULL,
    [RunID] varchar(50) NULL,
    [Error] varchar(250) NULL,
    [PayPeriodStartDate] datetime NULL,
    [PayPeriodEndDate] datetime NULL,
    [PriorPayPeriodStartDate] datetime NULL,
    [PriorPayPeriodEndDate] datetime NULL,
    [NextPayPeriodStartDate] datetime NULL,
    [NextPayPeriodEndDate] datetime NULL,
    [CompanyCode] varchar(100) NULL,
    [EmployeeNo] varchar(10) NULL,
    [EmployeeName] varchar(250) NULL,
    [Field1] varchar(max) NULL,
    [Field2] varchar(max) NULL,
    [Field3] varchar(max) NULL,
    [Field4] varchar(max) NULL,
    [Field5] varchar(max) NULL,
    [Field6] varchar(max) NULL,
    [Field7] varchar(max) NULL,
    [Field8] varchar(max) NULL,
    [Field9] varchar(max) NULL,
    [Field10] varchar(max) NULL,
    [Field11] varchar(max) NULL,
    [Field12] varchar(max) NULL,
    [Field13] varchar(max) NULL,
    [UDField1] varchar(250) NULL,
    [UDField2] varchar(250) NULL,
    [UDField3] varchar(250) NULL,
    [UDField4] varchar(250) NULL,
    [UDField5] varchar(250) NULL
);

-----------
-- Create table U_ISCHWAB401_Raw
-----------

IF OBJECT_ID('U_ISCHWAB401_Raw') IS NULL
CREATE TABLE [dbo].[U_ISCHWAB401_Raw] (
    [Field1] varchar(max) NULL,
    [Field2] varchar(max) NULL,
    [Field3] varchar(max) NULL,
    [Field4] varchar(max) NULL,
    [Field5] varchar(max) NULL,
    [Field6] varchar(max) NULL,
    [Field7] varchar(max) NULL,
    [Field8] varchar(max) NULL,
    [Field9] varchar(max) NULL,
    [Field10] varchar(max) NULL,
    [Field11] varchar(max) NULL,
    [Field12] varchar(max) NULL,
    [Field13] varchar(max) NULL,
    [RowNo] int IDENTITY(1,1) NOT NULL,
    [RunID] varchar(50) NULL,
    [FileName] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ISCHWAB401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Priority Wire & Cable, Inc.

Created By: Dan Fox (MCG)
Business Analyst: Radu Mocanu (MCG)
Create Date: 03/01/2023
Service Request Number: N/A

Purpose: Scwab Deferral Import

NOTE TO SUPPORT: This is an Automated Web Import that uses the Import Tool for Validating/Posting Records

Revision History
----------------
Update By           Date            Request Num         Desc
Dan Fox (MCG)        8/18/2023                            Replaced drvPeriodStartDate logic with drvChangeDate

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ISCHWAB401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ISCHWAB401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ISCHWAB401';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'ISCHWAB401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ISCHWAB401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ISCHWAB401', 'IMPORT';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'ISCHWAB401', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==================================================
    -- Declare Variables
    --==================================================
    DECLARE  @FormatCode VARCHAR(10)
            ,@ImportPath VARCHAR(1000)
            ,@FileName VARCHAR(1000)
            ,@ExportCode VARCHAR(12)
            ,@EnableStandardWebImport CHAR(1);

    SET @FormatCode = 'ISCHWAB401'
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');
    SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);

    --==================================================
    -- Set FileName
    --==================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = 'DeferralLoanImport_' + LTRIM(RTRIM(@ExportCode)) + '_'
                            + CONVERT(CHAR(8),GETDATE(),112)                          -- YYMMDD
                            + REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMss
                            + '.csv'
        WHERE FormatCode = @FormatCode;
    END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_ISCHWAB401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ISCHWAB401_drvTbl;
    CREATE TABLE dbo.U_ISCHWAB401_drvTbl (
        drvSurrogateKey VARCHAR(50) NULL
        ,drvSSN VARCHAR(50) NULL
        ,drvDivision VARCHAR(50) NULL
        ,drvAltKey1 VARCHAR(50) NULL
        ,drvBenefitStatus VARCHAR(50) NULL
        ,drvBenefitStatusDate VARCHAR(50) NULL
        ,drvBenefitStartDate VARCHAR(50) NULL
        ,drvBenefitStopDate VARCHAR(50) NULL
        ,drvDeductionStartDate VARCHAR(50) NULL
        ,drvDeductionStopDate VARCHAR(50) NULL
        ,drvAltKey2 VARCHAR(50) NULL
        ,drvChangeSource VARCHAR(50) NULL
        ,drvEmployerPercent VARCHAR(50) NULL
        ,drvEmployerAmount VARCHAR(50) NULL
        ,drvBenefitOption VARCHAR(50) NULL
        ,drvBenefitAmount VARCHAR(50) NULL
        ,drvBenefitChangeReason VARCHAR(50) NULL
        ,drvLoanNumber VARCHAR(50) NULL
        ,drvChangePct VARCHAR(50) NULL
        ,drvChangeAmt VARCHAR(50) NULL
        ,drvChangeDate VARCHAR(50) NULL
        ,drvLoanID VARCHAR(50) NULL
        ,drvLoanOrgDate VARCHAR(50) NULL
        ,drvLoanPayDate VARCHAR(50) NULL
        ,drvLoanMatDate VARCHAR(50) NULL
        ,drvLoanAmt VARCHAR(50) NULL
        ,drvAction VARCHAR(50) NULL
        ,drvError VARCHAR(250) NULL
        ,drvImported TINYINT DEFAULT 0 NOT NULL
        ,drvEEID VARCHAR(12) NULL
        ,drvCOID VARCHAR(5) NULL
        ,drvDedCode VARCHAR(50) NULL
        ,drvImportType VARCHAR(50) NULL
        ,drvPeriodStartDate VARCHAR(50) NULL
        ,drvPendingUpdateID CHAR(20) NULL
        ,drvInitialSort VARCHAR(50) NULL
    );

    --==================================================
    -- Benefit Import Module (BIM) - Deferral Records
    --==================================================
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEFERRAL');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','PCS*Deferral*'); --File Name contains "Deferral"
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','13');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        ------------------------------------------------------------------------------
        -- Only Retain Deferral Records where Record ID <> 'PARTICIPANT_SSN' (Deferral) in Field# 1
        ------------------------------------------------------------------------------
        DELETE FROM dbo.U_ISCHWAB401_Import WHERE RunID = 'DEFERRAL' AND LTRIM(RTRIM(Field1)) = 'PARTICIPANT_SSN' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_ISCHWAB401_drvTbl (drvError)
       SELECT 'Error Processing Delimited Deferral File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    ----==================================================
    ---- Benefit Import Module (BIM) - Loan Records
    ----==================================================
    --BEGIN TRY
    --    DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'AddToPreviousRun','Y');
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','LOAN');
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*Loans*'); --File Name contains "Loans"
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'FileFormat','Delimited',',');
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','13');
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','SSN');
    --    INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

    --    -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
    --    IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
    --    BEGIN
    --        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
    --    END
    --    ELSE
    --    BEGIN
    --        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
    --    END;

    --    EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

    --    ------------------------------------------------------------------------------
    --    -- Only Retain Loan Records where Record ID = '3' (Loan) in Field# 1
    --    ------------------------------------------------------------------------------
    --    DELETE FROM dbo.U_ISCHWAB401_Import WHERE RunID = 'LOAN' AND LTRIM(RTRIM(Field1)) <> '3' AND ISNULL(Error,'') = '';
    --END TRY
    --BEGIN CATCH
    --   -- Report SQL Error in Error Report File
    --   INSERT INTO dbo.U_ISCHWAB401_drvTbl (drvError)
    --   SELECT 'Error Processing Delimited Loan File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

    --   -- Stop Processing
    --   RETURN;
    --END CATCH;

    ----==============================================================
    ---- If Error During BIM, then Report Error and Stop Processing
    ----==============================================================
    --IF EXISTS (SELECT 1 FROM dbo.U_ISCHWAB401_Import WHERE ISNULL(Error,'') <> '')
    --BEGIN
    --    INSERT INTO dbo.U_ISCHWAB401_drvTbl (drvError,drvImported)
    --    SELECT Error, 2 FROM dbo.U_ISCHWAB401_Import WHERE ISNULL(Error,'') <> '';

    --    -- Stop Processing
    --    RETURN;
    --END;

    --==================================================
    -- Build Driver Table - Deferrals
    --==================================================
    BEGIN TRY
        INSERT INTO dbo.U_ISCHWAB401_drvTbl(drvSurrogateKey,drvSSN,drvChangeSource,drvChangePct,drvChangeAmt,drvChangeDate
            ,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
        SELECT DISTINCT
            drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
            ,drvSSN = NULLIF(Field1,'')
            ,drvChangeSource = NULLIF(Field5,'')
            ,drvChangePct = CASE WHEN NULLIF(Field6,'') IS NOT NULL THEN CONVERT(MONEY,Field6)/1 ELSE NULL END
            ,drvChangeAmt = CASE WHEN NULLIF(Field7,'') IS NOT NULL THEN CONVERT(MONEY,Field7) ELSE NULL END
            ,drvChangeDate = NULLIF(Field8,'')
            ,drvAction = CASE WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match [Participant SSN] in File to Employee in UltiPro
                              WHEN EecEmplStatus = 'T' THEN 'REJECTED' -- Terminated Employee
                              WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.
                             -- WHEN CONVERT(MONEY,Field6)/100 = 0.00 AND CONVERT(MONEY,Field7) = 0.00 THEN
                                --CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
                                --     ELSE 'REJECTED' --No Deduction/Benefit Plan to Stop
                                --END
                            ELSE
                                CASE WHEN EedDedCode IS NOT NULL THEN
                                        CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
                                             ELSE 'CHANGE'
                                        END
                                     ELSE 'ADD'
                                END
                         END
            ,drvError = CASE WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match [Participant SSN] in File to Employee in UltiPro.'
                             WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Terminated Employee in UltiPro.'
                             WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
                             WHEN EedDedCode IS NULL AND CONVERT(MONEY,Field6)/1 = 0.00 AND CONVERT(MONEY,Field7) = 0.00 THEN 'Record Rejected: Cannot STOP Record - Deduction/Benefit Plan Does Not Exist for Employee in UltiPro.'
                        END
            ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
                                WHEN EEID IS NULL THEN 2 --Unable to Match [Participant SSN] in File to Employee in UltiPro
                                WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
                                WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.
                                WHEN EedDedCode IS NULL AND CONVERT(MONEY,Field6)/1 = 0.00 AND CONVERT(MONEY,Field7) = 0.00 THEN 2 --No Deduction/Benefit Plan to Stop
                                ELSE 0
                           END
            ,drvEEID = EEID
            ,drvCOID = COID
            ,drvDedCode = CASE  WHEN Field5 = '01' AND NULLIF(Field7,'') IS NOT NULL THEN '401' --401K Flat
                                WHEN Field5 = '01' AND NULLIF(Field6,'') IS NOT NULL THEN '81' --401K Pct
                                WHEN Field5 = '02' AND NULLIF(Field7,'') IS NOT NULL THEN '401FB' --Roth Flat
                                WHEN Field5 = '02' AND NULLIF(Field6,'') IS NOT NULL THEN '401PB' --Roth Pct
                                WHEN Field5 = '03' AND NULLIF(Field7,'') IS NOT NULL THEN 'ROT' --401K Bonus Flat
                                WHEN Field5 = '03' AND NULLIF(Field6,'') IS NOT NULL THEN '82' --401K Bonus Pct
                                WHEN Field5 = '13' AND NULLIF(Field7,'') IS NOT NULL THEN 'RTHFB' --Roth Bonus Flat
                                WHEN Field5 = '13' AND NULLIF(Field6,'') IS NOT NULL THEN 'RTHPB' --Roth Bonus Pct
                            END
            ,drvImportType = RunID
            ,drvPeriodStartDate = CONVERT(VARCHAR(10),PayPeriodStartDate,101)
            ,drvInitialSort = ISNULL(Field1,'')
        FROM dbo.U_ISCHWAB401_Import
        LEFT JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = EEID
            AND EecCoID = COID
        LEFT JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = CASE  WHEN Field5 = '01' AND NULLIF(Field7,'') IS NOT NULL THEN '401' --401K Flat
                                WHEN Field5 = '01' AND NULLIF(Field6,'') IS NOT NULL THEN '81' --401K Pct
                                WHEN Field5 = '02' AND NULLIF(Field7,'') IS NOT NULL THEN '401FB' --Roth Flat
                                WHEN Field5 = '02' AND NULLIF(Field6,'') IS NOT NULL THEN '401PB' --Roth Pct
                                WHEN Field5 = '03' AND NULLIF(Field7,'') IS NOT NULL THEN 'ROT' --401K Bonus Flat
                                WHEN Field5 = '03' AND NULLIF(Field6,'') IS NOT NULL THEN '82' --401K Bonus Pct
                                WHEN Field5 = '13' AND NULLIF(Field7,'') IS NOT NULL THEN 'RTHFB' --Roth Bonus Flat
                                WHEN Field5 = '13' AND NULLIF(Field6,'') IS NOT NULL THEN 'RTHPB' --Roth Bonus Pct
                            END
        LEFT JOIN dbo.EmpDed WITH (NOLOCK)
            ON  EedEEID = EEID
            AND EedCOID = COID
            AND EedDedCode = DedDedCode
        WHERE RunID = 'DEFERRAL';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_ISCHWAB401_drvTbl (drvError)
       SELECT 'Error Processing Deferral File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    ----==================================================
    ---- Build Driver Table - Loans
    ----==================================================
    --BEGIN TRY
    --    INSERT INTO dbo.U_ISCHWAB401_drvTbl(drvSurrogateKey,drvSSN,drvDivision,drvSSN,drvAltKey1,drvDeductionStartDate,drvDeductionStopDate
    --        ,drvLoanNumber,drvChangePct,drvChangeAmt,drvChangeDate,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
    --    SELECT DISTINCT
    --        drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
    --        ,drvSSN = EecEmpNo
    --        ,drvDivision = RTRIM(EepNameFirst) + SPACE(1) + RTRIM(EepNameLast)
    --        ,drvSSN = NULLIF(Field1,'')
    --        ,drvAltKey1 = NULLIF(Field2,'')
    --        ,drvDeductionStartDate = NULLIF(Field7,'')
    --        ,drvDeductionStopDate = NULLIF(Field8,'')
    --        ,drvLoanNumber = NULLIF(Field16,'')
    --        ,drvChangePct = NULLIF(Field17,'')
    --        ,drvChangeAmt = NULLIF(Field18,'')
    --        ,drvChangeDate = CONVERT(VARCHAR(50),Field19)
    --        ,drvAction = CASE WHEN NULLIF(Field1,'') IS NULL THEN 'REJECTED' --Missing [SSN] Value in File.
    --                          WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match Employee in UltiPro based on [SSN] Value in File.
    --                          WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
    --                          WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
    --                          ELSE
    --                            CASE WHEN CONVERT(MONEY,Field17) = 0.00 THEN
    --                                    CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
    --                                         ELSE 'REJECTED' --No Deduction/Benefit Plan to STOP
    --                                    END
    --                                 WHEN EedDedCode IS NOT NULL THEN
    --                                    CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
    --                                         ELSE 'CHANGE'
    --                                    END
    --                                 ELSE 'ADD'
    --                            END
    --                     END
    --        ,drvError = CASE WHEN NULLIF(Field1,'') IS NULL THEN 'Record Rejected: Missing [SSN] Value in File.'
    --                         WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match Employee in UltiPro based on [SSN] Value in File.'
    --                         WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Employee is Terminated in UltiPro - Do Not Process.'
    --                         WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
    --                         WHEN CONVERT(MONEY,Field17) = 0.00 AND EedDedCode IS NULL THEN 'Record Rejected: No Deduction/Benefit Plan to STOP for Employee in UltiPro.'
    --                    END
    --        ,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
    --                            WHEN NULLIF(Field1,'') IS NULL THEN 2 --Missing [SSN] Value in File.
    --                            WHEN EEID IS NULL THEN 2 --Unable to Match Employee in UltiPro based on [SSN] Value in File.
    --                            WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
    --                            WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
    --                            WHEN CONVERT(MONEY,Field17) = 0.00 AND EedDedCode IS NULL THEN 2 --No Deduction/Benefit Plan to STOP
    --                            ELSE 0
    --                       END
    --        ,drvEEID = EEID
    --        ,drvCOID = COID
    --        ,drvDedCode = DedDedCode
    --        ,drvImportType = RunID
    --        ,drvPeriodStartDate = CONVERT(CHAR(10),PayPeriodStartDate,101)
    --        ,drvInitialSort = Field1
    --    FROM dbo.U_ISCHWAB401_Import
    --    LEFT JOIN dbo.EmpComp WITH (NOLOCK)
    --        ON EecEEID = EEID
    --        AND EecCoID = COID
    --    LEFT JOIN dbo.EmpPers WITH (NOLOCK)
    --        ON eepEEID = EEID
    --    LEFT JOIN dbo.DedCode WITH (NOLOCK)
    --        ON DedDedCode = Field2
    --    LEFT JOIN dbo.EmpDed WITH (NOLOCK)
    --        ON EedEEID = EEID
    --        AND EedCoID = COID
    --        AND EedDedCode = DedDedCode
    --    WHERE RunID = 'LOAN';

    --    --=====================================================
    --    -- Reject Add/Restarts where Participant_Alt_Key1 is NULL
    --    --=====================================================
    --    UPDATE D1
    --    SET D1.drvError = 'Record Ignored: Recycling Participant_Alt_Key1: ' + ISNULL(D1.DrvDedCode,'')
    --        ,drvAction = 'IGNORED'
    --        ,DrvImported = 2
    --    FROM dbo.U_ISCHWAB401_drvTbl D1
    --    JOIN dbo.U_ISCHWAB401_drvTbl D2
    --        ON D2.DrvEEID = D1.DrvEEID
    --        AND D2.DrvCOID = D1.DrvCOID
    --        AND D2.DrvDedCode = D1.DrvDedCode
    --        AND D2.drvImported = D1.drvImported
    --    WHERE D1.drvImported = 0 AND D1.drvAction = 'STOP' AND D2.drvAction <> 'STOP';

    --    --=====================================================
    --    -- Reject Add/Restarts where Participant_Alt_Key1 is NULL
    --    --=====================================================
    --    UPDATE dbo.U_ISCHWAB401_drvTbl
    --    SET drvError = 'Record Rejected: Maximum Allowed Active Loans Exceeded.'
    --        ,drvAction = 'REJECTED'
    --        ,DrvImported = 2
    --    WHERE drvImported = 0 AND drvAction IN ('ADD','RESTART') AND drvDedCode IS NULL;

    --    --=====================================================
    --    -- Reject Stops/Changes where Participant_Alt_Key1 is NULL
    --    --=====================================================
    --    UPDATE dbo.U_ISCHWAB401_drvTbl
    --    SET drvError = 'Record Rejected: No Active Participant_Alt_Key1 to STOP/CHANGE in UltiPro.'
    --        ,drvAction = 'REJECTED'
    --        ,DrvImported = 2
    --    WHERE drvImported = 0 AND drvAction IN ('STOP','CHANGE') AND drvDedCode IS NULL;
    --END TRY
    --BEGIN CATCH
    --   -- Report SQL Error in Error Report File
    --   INSERT INTO dbo.U_ISCHWAB401_drvTbl (drvError)
    --   SELECT 'Error Processing Loan File: ' + ISNULL(ERROR_MESSAGE(),'');

    --   -- Stop Processing
    --   RETURN;
    --END CATCH;

    --==================================================
    -- Update PendingUpdateID for Valid Records
    --==================================================
    UPDATE dbo.U_ISCHWAB401_drvTbl
    SET drvPendingUpdateID = LEFT(@FormatCode + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --============================================================
    -- Generate XML File for Standard Web Import for Automation
    --============================================================
    BEGIN TRY
        -----------------------------------
        -- Clear BIM Tables by FormatCode
        -----------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;

        ---------------------------------------------------------
        -- Populate Lod Deduction Table (LodEDed) for Deferrals
        ---------------------------------------------------------
        INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedEEAmt,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate,EedStopDate
            ,EedPendingEffDate,EedPendingTransType,EedChangeReason,EedPendingUpdateID) --EedEECalcRule
        SELECT EedFormatCode = @FormatCode
            ,EedEEID = drvEEID
            ,EedCOID = drvCOID
            ,EedDedCode = drvDedCode
                --,DedEECalcRule
            ,EedEECalcRateOrPct = CASE -- Only Populate for Employee (EE) Non-Flat Amount Calc Rule ('20')
                                       WHEN DedEECalcRule <> '20' THEN
                                           CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
                                                WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvChangePct)
                                            END
                                  END
            ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
                             WHEN DedEECalcRule = '20' AND NULLIF(drvChangeAmt,'') IS NOT NULL THEN
                                    CONVERT(MONEY,drvChangeAmt)
                        END
                --,drvAction
            ,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
                                    WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvChangeDate,101)    --drvPeriodStartDate
                                    ELSE '12/30/1899'
                               END
            ,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvChangeDate,101)    --drvPeriodStartDate
                                 ELSE '12/30/1899'
                            END
            ,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
                                     WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(CHAR(10),drvChangeDate,101)    --drvPeriodStartDate
                                     ELSE '12/30/1899'
                                END
            ,EedBenStopDate = CASE     WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
                                    WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),drvChangeDate,101)    --CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
                                    ELSE '01/01/1900'
                              END
            ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),drvChangeDate,101)    --CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
                                ELSE '01/01/1900'
                           END
            ,EedPendingEffDate = CONVERT(CHAR(10),drvChangeDate,101)    --CONVERT(CHAR(10),GETDATE(),101)
            ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
                                        ELSE 'U'
                                   END
            ,EedChangeReason = CASE WHEN drvAction = 'STOP' THEN '401'
                                    WHEN drvAction = 'ADD' THEN '400'
                                    WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
                                END
            ,EedPendingUpdateID = drvPendingUpdateID
        FROM dbo.U_ISCHWAB401_drvTbl WITH (NOLOCK)
        JOIN dbo.DedCode WITH (NOLOCK)
            ON DedDedCode = drvDedCode
        WHERE drvImported = 0 AND drvImportType = 'DEFERRAL';

        -----------------------------------------------------------
        ---- Populate Lod Deduction Table (LodEDed) for Loan File
        -----------------------------------------------------------
        --INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEEMemberOrCaseNo,EedEEAmt,EedEEGoalAmt,EedEEGTDAmt,EedStartDate,EedStopDate
        --    ,EedChangeReason,EedPendingTransType,EedPendingEffDate,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
        --SELECT EedFormatCode = @FormatCode
        --    ,EedEEID = drvEEID
        --    ,EedCOID = drvCOID
        --    ,EedDedCode = drvDedCode
        --    ,EedEEMemberOrCaseNo = drvLoanNumber
        --    ,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
        --                     WHEN DedEECalcRule = '20' THEN
        --                        CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
        --                             WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvChangePct
        --                        END
        --                END
        --    ,EedEEGoalAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
        --                        WHEN DedEEGoalRule <> 'Z' THEN CONVERT(MONEY,drvChangeAmt)
        --                   END
        --    ,EedEEGTDAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
        --                        WHEN DedEEGoalRule <> 'Z' THEN
        --                            CASE WHEN drvAction = 'RESTART' THEN CONVERT(MONEY,0.00) END
        --                   END
        --    ,EedStartDate = CASE WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvDeductionStartDate
        --                         ELSE '12/30/1899'
        --                    END
        --    ,EedStopDate = CASE WHEN drvAction = 'STOP' THEN drvDeductionStopDate
        --                        ELSE '01/01/1900'
        --                   END
        --    ,EedChangeReason = CASE WHEN drvAction = 'ADD' THEN '400'
        --                            WHEN drvAction = 'STOP' THEN '401'
        --                            WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
        --                       END
        --    ,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
        --                                ELSE 'U'
        --                           END
        --    ,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
        --    ,EedInclInAddlChk = DedInclInAddlChk
        --    ,EedInclInManlChk = DedInclInManlChk
        --    ,EedPendingUpdateID = drvPendingUpdateID
        --FROM dbo.U_ISCHWAB401_drvTbl WITH (NOLOCK)
        --JOIN dbo.DedCode WITH (NOLOCK)
        --    ON DedDedCode = drvDedCode
        --WHERE drvImported = 0 AND drvImportType = 'LOAN';

        --============================================================
        -- Generate XML File for Web Import Tool
        --============================================================
        DECLARE @XMLFilePath VARCHAR(1000) = '' --dbo.Dsi_fnVariable(@FormatCode,'XMLPath')
            ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_ISCHWAB401_drvTbl (drvError)
       SELECT 'Error Loading Records for Validation/Posting: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==========================
    -- Report Successful Update
    --==========================
    UPDATE dbo.U_ISCHWAB401_drvTbl
        SET drvError = 'Loaded Successfully'
            ,drvImported = 1
    WHERE drvImported = 0
    AND EXISTS (SELECT * FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode AND EedPendingUpdateID = drvPendingUpdateID);

    --===========================
    -- Reject Remaining Records
    --===========================
    UPDATE dbo.u_ISCHWAB401_drvTbl
        SET drvError = 'Record Rejected'
            ,drvAction = 'REJECTED'
            ,drvImported = 2
    WHERE drvImported = 0;

END
/**********************************************************************************

--Create the View
CREATE VIEW dbo.dsi_vwISCHWAB401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ISCHWAB401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ISCHWAB401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201901011'
       ,ExpStartPerControl     = '201901011'
       ,ExpLastEndPerControl   = '201901019'
       ,ExpEndPerControl       = '201901019'
WHERE ExpFormatCode = 'ISCHWAB401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwISCHWAB401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ISCHWAB401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ISCHWAB401' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ISCHWAB401'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ISCHWAB401'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ISCHWAB401', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ISCHWAB401', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ISCHWAB401', 'UseFileName', 'V', 'Y'


-- End ripout