/**********************************************************************************

ECUNA401QF: CUNA - 401k

FormatCode:     ECUNA401QF
Project:        CUNA - 401k
Client ID:      QUO1000
Date/time:      2022-01-10 08:43:05.687
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB01
Database:       ULTIPRO_WPQFCU
Web Filename:   QUO1000_E1214_EEHISTORY_ECUNA401QF_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECUNA401QF_SavePath') IS NOT NULL DROP TABLE dbo.U_ECUNA401QF_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECUNA401QF'


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
WHERE FormatCode = 'ECUNA401QF'
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
WHERE ExpFormatCode = 'ECUNA401QF'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECUNA401QF')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECUNA401QF'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECUNA401QF'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECUNA401QF'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECUNA401QF'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECUNA401QF'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECUNA401QF'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECUNA401QF'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECUNA401QF'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECUNA401QF'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECUNA401QF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECUNA401QF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECUNA401QF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUNA401QF];
GO
IF OBJECT_ID('U_ECUNA401QF_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_PEarHist];
GO
IF OBJECT_ID('U_ECUNA401QF_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_PDedHist];
GO
IF OBJECT_ID('U_ECUNA401QF_File') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_File];
GO
IF OBJECT_ID('U_ECUNA401QF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_EEList];
GO
IF OBJECT_ID('U_ECUNA401QF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_drvTbl];
GO
IF OBJECT_ID('U_ECUNA401QF_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_DedList];
GO
IF OBJECT_ID('U_ECUNA401QF_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_AuditFields];
GO
IF OBJECT_ID('U_ECUNA401QF_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECUNA401QF_Audit];
GO
IF OBJECT_ID('U_dsi_ECUNA401QF_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECUNA401QF_TrlTbl];
GO
IF OBJECT_ID('U_dsi_ECUNA401QF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECUNA401QF_drvTbl];
GO
IF OBJECT_ID('U_dsi_ECUNA401QF_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECUNA401QF_DedHist];
GO
IF OBJECT_ID('U_dsi_BDM_ECUNA401QF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECUNA401QF];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECUNA401QF','CUNA - 401k','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECUNA401QFZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECUNA401QFZ0','50','H','01','1',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECUNA401QFZ0','50','H','01','2',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECUNA401QFZ0','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECUNA401QFZ0','50','H','01','4',NULL,'EE Deferral',NULL,NULL,'"EE Deferral"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECUNA401QFZ0','50','H','01','5',NULL,'EE Roth',NULL,NULL,'"EE Roth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECUNA401QFZ0','50','H','01','6',NULL,'Match',NULL,NULL,'"Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECUNA401QFZ0','50','H','01','7',NULL,'1st Loan No',NULL,NULL,'"1st Loan No"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECUNA401QFZ0','50','H','01','8',NULL,'1st Loan Pmt',NULL,NULL,'"1st Loan Pmt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECUNA401QFZ0','50','H','01','9',NULL,'Period Hours',NULL,NULL,'"Period Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECUNA401QFZ0','50','H','01','10',NULL,'Period Gross Comp',NULL,NULL,'"Period Gross Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECUNA401QFZ0','50','H','01','11',NULL,'Period Excluded Comp',NULL,NULL,'"Period Excluded Comp"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECUNA401QFZ0','50','H','01','12',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECUNA401QFZ0','50','H','01','13',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECUNA401QFZ0','50','H','01','14',NULL,'Entry Date',NULL,NULL,'"Entry Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECUNA401QFZ0','50','H','01','15',NULL,'Status Change Date',NULL,NULL,'"Status Change Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECUNA401QFZ0','50','H','01','16',NULL,'Status Change Reason',NULL,NULL,'"Status Change Reason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECUNA401QFZ0','50','H','01','17',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECUNA401QFZ0','50','H','01','18',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECUNA401QFZ0','50','H','01','19',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECUNA401QFZ0','50','H','01','20',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECUNA401QFZ0','50','H','01','21',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECUNA401QFZ0','50','H','01','22',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECUNA401QFZ0','50','H','01','23',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECUNA401QFZ0','50','D','10','1',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECUNA401QFZ0','50','D','10','2',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECUNA401QFZ0','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECUNA401QFZ0','50','D','10','4',NULL,'EE Deferral',NULL,NULL,'"drvEEDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECUNA401QFZ0','50','D','10','5',NULL,'EE Roth',NULL,NULL,'"drvEERoth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECUNA401QFZ0','50','D','10','6',NULL,'Match',NULL,NULL,'"drvMatch"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECUNA401QFZ0','50','D','10','7',NULL,'1st Loan No',NULL,NULL,'"drvFirstLoanNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECUNA401QFZ0','50','D','10','8',NULL,'1st Loan Pmt',NULL,NULL,'"drvFirstLoadPmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECUNA401QFZ0','50','D','10','9',NULL,'Period Hours',NULL,NULL,'"drvPeriodHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECUNA401QFZ0','50','D','10','10',NULL,'Period Gross Comp',NULL,NULL,'"drvPeriodGrossComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECUNA401QFZ0','50','D','10','11',NULL,'Period Excluded Comp',NULL,NULL,'"drvPeriodExcludComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECUNA401QFZ0','50','D','10','12',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECUNA401QFZ0','50','D','10','13',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECUNA401QFZ0','50','D','10','14',NULL,'Entry Date',NULL,NULL,'"drvEntryDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECUNA401QFZ0','50','D','10','15',NULL,'Status Change Date',NULL,NULL,'"drvStatusChangeDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECUNA401QFZ0','50','D','10','16',NULL,'Status Change Reason',NULL,NULL,'"drvStatusChangeReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECUNA401QFZ0','50','D','10','17',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECUNA401QFZ0','50','D','10','18',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECUNA401QFZ0','50','D','10','19',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECUNA401QFZ0','50','D','10','20',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECUNA401QFZ0','50','D','10','21',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECUNA401QFZ0','50','D','10','22',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECUNA401QFZ0','50','D','10','23',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECUNA401QF_20220110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202108029','EMPEXPORT','OEACTIVE','Aug  2 2021 12:44PM','ECUNA401QF',NULL,NULL,NULL,'202108029','Aug  2 2021 10:22AM','Aug  2 2021 10:22AM','202107011','27','','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202108029','EMPEXPORT','OEPASSIVE','Aug  2 2021 12:44PM','ECUNA401QF',NULL,NULL,NULL,'202108029','Aug  2 2021 10:22AM','Aug  2 2021 10:22AM','202107011','166','','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'CUNA - 401k V2','202108029','EMPEXPORT','ONDEM_XOE','Aug  2 2021 12:45PM','ECUNA401QF',NULL,NULL,NULL,'202108029','Aug  2 2021 10:22AM','Aug  2 2021 10:22AM','202107011','166','','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'CUNA - 401k V2-Sched','202108029','EMPEXPORT','SCH_ECUNA4','Aug  2 2021 12:45PM','ECUNA401QF',NULL,NULL,NULL,'202108029','Aug  2 2021 10:22AM','Aug  2 2021 10:22AM','202107011','166','','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG,SSMNA',NULL,NULL,NULL,'CUNA - 401k V2-Test','202201079','EMPEXPORT','TEST_XOE','Jan 10 2022  6:31AM','ECUNA401QF',NULL,NULL,NULL,'202201079','Jan  7 2022 12:00AM','Dec 30 1899 12:00AM','202201071','157','','BWQFCU,BWVOFC,BWVOFK','202201071',dbo.fn_GetTimedKey(),NULL,'us3jBeQUO1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUNA401QF','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNA401QF','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUNA401QF','D10','dbo.U_ECUNA401QF_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECUNA401QF
-----------

IF OBJECT_ID('U_dsi_BDM_ECUNA401QF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECUNA401QF] (
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
-- Create table U_dsi_ECUNA401QF_DedHist
-----------

IF OBJECT_ID('U_dsi_ECUNA401QF_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_ECUNA401QF_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
    [heecalcrateorpct] decimal NULL,
    [heeamt] money NULL,
    [heramt] money NULL
);

-----------
-- Create table U_dsi_ECUNA401QF_drvTbl
-----------

IF OBJECT_ID('U_dsi_ECUNA401QF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECUNA401QF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvEmpName] varchar(8000) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEEContr] money NULL,
    [drvEERothContr] money NULL,
    [drvERMatchContr] money NULL,
    [drvLoanPmt] money NULL,
    [drvPartTotal] money NULL,
    [drvPayDate] varchar(10) NULL,
    [drvFromPayPer] varchar(10) NULL,
    [drvToPayPer] varchar(10) NULL,
    [drvEmlName] varchar(10) NOT NULL,
    [drvContractNo] varchar(10) NOT NULL,
    [drvAnnivDate] varchar(5) NOT NULL
);

-----------
-- Create table U_dsi_ECUNA401QF_TrlTbl
-----------

IF OBJECT_ID('U_dsi_ECUNA401QF_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECUNA401QF_TrlTbl] (
    [drvrectype] varchar(1) NOT NULL,
    [drvTotals] varchar(6) NOT NULL,
    [drvTotEEContr] money NULL,
    [drvTotEERothContr] money NULL,
    [drvTotERMatchContr] money NULL,
    [drvTotLoanPmt] money NULL,
    [drvTotPartTotal] money NULL
);

-----------
-- Create table U_ECUNA401QF_Audit
-----------

IF OBJECT_ID('U_ECUNA401QF_Audit') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_ECUNA401QF_AuditFields
-----------

IF OBJECT_ID('U_ECUNA401QF_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECUNA401QF_DedList
-----------

IF OBJECT_ID('U_ECUNA401QF_DedList') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECUNA401QF_drvTbl
-----------

IF OBJECT_ID('U_ECUNA401QF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEEDeferral] nvarchar(4000) NULL,
    [drvEERoth] nvarchar(4000) NULL,
    [drvMatch] nvarchar(4000) NULL,
    [drvFirstLoanNo] varchar(1) NOT NULL,
    [drvFirstLoadPmt] nvarchar(4000) NULL,
    [drvPeriodHours] nvarchar(4000) NULL,
    [drvPeriodGrossComp] nvarchar(4000) NULL,
    [drvPeriodExcludComp] nvarchar(4000) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvEntryDate] varchar(1) NOT NULL,
    [drvStatusChangeDate] datetime NULL,
    [drvStatusChangeReason] varchar(1) NULL,
    [drvRehireDate] datetime NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_ECUNA401QF_EEList
-----------

IF OBJECT_ID('U_ECUNA401QF_EEList') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECUNA401QF_File
-----------

IF OBJECT_ID('U_ECUNA401QF_File') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECUNA401QF_PDedHist
-----------

IF OBJECT_ID('U_ECUNA401QF_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhEEDeferral] numeric NULL,
    [PdhEERoth] numeric NULL,
    [PdhERMatch] numeric NULL,
    [PdhLoanPmt1] numeric NULL
);

-----------
-- Create table U_ECUNA401QF_PEarHist
-----------

IF OBJECT_ID('U_ECUNA401QF_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECUNA401QF_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurExcludedAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUNA401QF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Quorum Federal Credit Union

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 08/02/2021
Service Request Number: TekP-2021-05-03-0003

Purpose: CUNA - 401k V2

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECUNA401QF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECUNA401QF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECUNA401QF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECUNA401QF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECUNA401QF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNA401QF', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNA401QF', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNA401QF', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNA401QF', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUNA401QF', 'SCH_ECUNA4';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECUNA401QF';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECUNA401QF', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECUNA401QF';

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

    DELETE FROM dbo.U_ECUNA401QF_EEList where xEEID = 'DZMHIB000020'

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECUNA401QF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECUNA401QF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CP,401P,401KR,401RC,401L,401L2,401M';

    IF OBJECT_ID('U_ECUNA401QF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNA401QF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECUNA401QF_DedList
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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECUNA401QF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNA401QF_AuditFields;
    CREATE TABLE dbo.U_ECUNA401QF_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECUNA401QF_AuditFields VALUES ('EmpComp','EecEmplStatus');


    IF OBJECT_ID('U_ECUNA401QF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNA401QF_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ECUNA401QF_Audit 
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECUNA401QF_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    JOIN dbo.U_ECUNA401QF_EEList WITH (NOLOCK)
        ON audKey1Value = xEEID
        AND audKey2Value = xCOID
    WHERE AudDateTime BETWEEN DATEADD(DAY, -60 ,@EndDate) AND @EndDate
        AND AudAction <> 'DELETE'
        AND audNewValue = 'T'
    ;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECUNA401QF_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNA401QF_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEEDeferral        = SUM(CASE WHEN PdhDedCode IN ('401CF','401P','401CP') THEN PdhEECurAmt ELSE 0.00 END)      
        ,PdhEERoth            = SUM(CASE WHEN PdhDedCode IN ('401KR','401RC') THEN PdhEECurAmt ELSE 0.00 END)     
        ,PdhERMatch            = SUM(CASE WHEN PdhDedCode IN ('401M') THEN PdhERCurAmt ELSE 0.00 END)     
        ,PdhLoanPmt1        = SUM(CASE WHEN PdhDedCode IN ('401L','401L2') THEN PdhEECurAmt ELSE 0.00 END)     
    INTO dbo.U_ECUNA401QF_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECUNA401QF_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECUNA401QF_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNA401QF_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurExcludedAmt      = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnInclInDefCompHrs = 'N' THEN PehCurAmt ELSE 0.00 END)
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
    INTO dbo.U_ECUNA401QF_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.Earncode WITH (NOLOCK)
        ON PehEarnCode = ErnEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECUNA401QF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECUNA401QF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECUNA401QF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmplStatus
        -- standard fields above and additional driver fields below
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEEDeferral = FORMAT(PdhEEDeferral, '#0.##')
        ,drvEERoth = FORMAT(PdhEERoth, '#0.##')
        ,drvMatch = FORMAT(PdhERMatch, '#0.##')
        ,drvFirstLoanNo = '0'
        ,drvFirstLoadPmt = FORMAT(PdhLoanPmt1, '#0.##')
        ,drvPeriodHours = FORMAT(PehCurHrs, '#0.##')
        ,drvPeriodGrossComp = FORMAT(PehCurAmt, '#0.##')
        ,drvPeriodExcludComp = FORMAT(PehCurExcludedAmt, '#0.##')
        ,drvDateOfBirth = EepDateOfBirth
        ,drvHireDate =    CASE WHEN ISNULL(EepUDField05, '') <> '' THEN EepUDField05 ELSE EecDateOfOriginalHire END
        ,drvEntryDate = ''
        ,drvStatusChangeDate =    CASE WHEN EecEmplStatus = 'T' AND audDateTime BETWEEN DATEADD(DAY, -30 ,@EndDate) AND @EndDate THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'L' AND EecEmplStatusStartDate BETWEEN @StartDate AND @EndDate THEN EecEmplStatusStartDate
                                    WHEN EecEmplStatus = 'A' AND EshStatusStopDate BETWEEN @StartDate AND @EndDate THEN EshStatusStopDate 
                                END
        ,drvStatusChangeReason =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('203','202') AND EecDateOfTermination BETWEEN DATEADD(DAY, -30 ,@EndDate) AND @EndDate THEN '1'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203') AND EecDateOfTermination BETWEEN DATEADD(DAY, -30 ,@EndDate) AND @EndDate THEN '5'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202') AND EecDateOfTermination BETWEEN DATEADD(DAY, -30 ,@EndDate) AND @EndDate THEN '7'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' AND EecEmplStatusStartDate BETWEEN @StartDate AND @EndDate THEN '2'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason NOT IN ('300') AND EecEmplStatusStartDate BETWEEN @StartDate AND @EndDate THEN '4'
                                        WHEN EecEmplStatus = 'A' AND EshStatusStartDate IS NOT NULL AND EshStatusStopDate BETWEEN @StartDate AND @EndDate THEN '8'
                                    END
        ,drvRehireDate = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN EecDateOfLastHire END
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvEmailAddress = EepAddressEMail
    INTO dbo.U_ECUNA401QF_drvTbl
    FROM dbo.U_ECUNA401QF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_ECUNA401QF WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECUNA401QF_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_ECUNA401QF_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN (
                SELECT BdmEEID AS EdEEID, BdmCOID AS EdCOID
                    ,MAX(CASE WHEN BdmDedCode = '401M' THEN BdmBenStartDate END) AS EdBenStartDate 
                FROM dbo.U_dsi_BDM_ECUNA401QF WITH (NOLOCK)
                WHERE BdmDedCode = '401M'
                GROUP BY BdmEEID, BdmCOID ) AS ED
        ON EdEEID = xEEID
        AND EdCOID = xCOID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) ) AS LoaDates
                WHERE RN = 2 AND EshEmplStatus = 'L') AS StatusChange
        ON EshEEID = xEEID
        AND EshCOID = xCOID
    LEFT JOIN dbo.U_ECUNA401QF_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudCOID = xCOID
    WHERE    (
                (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audDateTime BETWEEN DATEADD(DAY, -30 ,@EndDate) AND @EndDate))
                OR
                (PdhEEDeferral <> 0.00 OR PdhEERoth <> 0.00 OR PdhERMatch <> 0.00 OR PdhLoanPmt1 <> 0.00)
            )
            --AND NOT (PdhEEDeferral IS NULL AND PdhEERoth IS NULL AND PdhERMatch IS NULL AND PdhLoanPmt1 IS NULL AND BdmDedCode IS NULL)
            AND NOT (EecEmplStatus <> 'T' AND (PdhEEDeferral IS NULL AND PdhEERoth IS NULL AND PdhERMatch IS NULL AND PdhLoanPmt1 IS NULL AND BdmDedCode IS NULL))
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
ALTER VIEW dbo.dsi_vwECUNA401QF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECUNA401QF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECUNA401QF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107011'
       ,expStartPerControl     = '202107011'
       ,expLastEndPerControl   = '202108029'
       ,expEndPerControl       = '202108029'
WHERE expFormatCode = 'ECUNA401QF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECUNA401QF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECUNA401QF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECUNA401QF' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECUNA401QF'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECUNA401QF'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECUNA401QF', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECUNA401QF', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECUNA401QF', 'UseFileName', 'V', 'Y'


-- End ripout