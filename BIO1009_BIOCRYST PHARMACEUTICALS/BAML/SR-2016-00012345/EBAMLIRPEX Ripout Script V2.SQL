/**********************************************************************************

EBAMLIRPEX: BAML IRP&I

FormatCode:     EBAMLIRPEX
Project:        BAML IRP&I
Client ID:      BIO1009
Date/time:      2023-12-08 07:25:36.003
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP5DB04
Database:       ULTIPRO_WPBIPH
Web Filename:   BIO1009_7533F_EEHISTORY_EBAMLIRPEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBAMLIRPEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EBAMLIRPEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBAMLIRPEX'


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
WHERE FormatCode = 'EBAMLIRPEX'
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
WHERE ExpFormatCode = 'EBAMLIRPEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBAMLIRPEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBAMLIRPEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBAMLIRPEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBAMLIRPEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBAMLIRPEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBAMLIRPEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBAMLIRPEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBAMLIRPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBAMLIRPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBAMLIRPEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBAMLIRPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBAMLIRPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBAMLIRPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAMLIRPEX];
GO
IF OBJECT_ID('U_EBAMLIRPEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_Trailer];
GO
IF OBJECT_ID('U_EBAMLIRPEX_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_PTaxHist];
GO
IF OBJECT_ID('U_EBAMLIRPEX_File') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_File];
GO
IF OBJECT_ID('U_EBAMLIRPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_EEList];
GO
IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_IBSH') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_drvTbl_IBSH];
GO
IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_IBEN') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_drvTbl_IBEN];
GO
IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BSH01') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_drvTbl_BSH01];
GO
IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BCS01') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_drvTbl_BCS01];
GO
IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BAC01') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_drvTbl_BAC01];
GO
IF OBJECT_ID('U_EBAMLIRPEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_DedList];
GO
IF OBJECT_ID('U_EBAMLIRPEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_AuditFields];
GO
IF OBJECT_ID('U_EBAMLIRPEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBAMLIRPEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBAMLIRPEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBAMLIRPEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBAMLIRPEX','BAML IRP&I','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6000','S','N','EBAMLIRPEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAMLIRPEXZ0','6','D','10','1',NULL,'IB_RECORD_TYPE',NULL,NULL,'"IBSH00"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAMLIRPEXZ0','10','D','10','2',NULL,'IB_COMPANY_ID',NULL,NULL,'"125003"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAMLIRPEXZ0','15','D','10','3',NULL,'IB_INBOUND_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAMLIRPEXZ0','8','D','10','4',NULL,'IBSH00_CURRENT_PROCESS_DATE',NULL,NULL,'"drvProcessDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAMLIRPEXZ0','6','D','10','5',NULL,'IBSH00_PROCESSING_TIME',NULL,NULL,'"drvProcessTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAMLIRPEXZ0','8','D','10','6',NULL,'IBSH00_CYCLE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAMLIRPEXZ0','8','D','10','7',NULL,'IBSH00_PAYCHECK_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAMLIRPEXZ0','8','D','10','8',NULL,'IBSH00_ELIG_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAMLIRPEXZ0','1','D','10','9',NULL,'IBSH00_FILE_STATUS',NULL,NULL,'"drvFileStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAMLIRPEXZ0','4','D','10','10',NULL,'IBSH00_DC_COMPANY_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAMLIRPEXZ0','30','D','10','11',NULL,'IBSH00_DB_PAYROLL_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAMLIRPEXZ0','1','D','10','12',NULL,'IBSH00_MW_FILE_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAMLIRPEXZ0','8','D','10','13',NULL,'IBSH00_MW_PRIOR_PAY_PERIOD_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAMLIRPEXZ0','4','D','10','14',NULL,'IBSH00_MW_PLAN_YEAR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAMLIRPEXZ0','2','D','10','15',NULL,'IBSH00_TRANSMISSION_SITE',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAMLIRPEXZ0','30','D','10','16',NULL,'IBSH00_CONTACT_NAME',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAMLIRPEXZ0','30','D','10','17',NULL,'IBSH00_CONTACT_NUMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAMLIRPEXZ0','100','D','10','18',NULL,'IBSH00_CONTACT_EMAIL',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAMLIRPEXZ0','1','D','10','19',NULL,'IBSH00_ESPP_AUTO_ENROLL',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAMLIRPEXZ0','12','D','10','20',NULL,'IBSH00_ESPP_COMPANY_CODE',NULL,NULL,'"BCRX"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAMLIRPEXZ0','20','D','10','21',NULL,'IBSH00_FILE_DESCRIPTION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAMLIRPEXZ0','1','D','10','22',NULL,'IBSH00_AUTOREHIRE_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAMLIRPEXZ0','1','D','10','23',NULL,'IBSH00_MATCH_CALC_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAMLIRPEXZ0','1','D','10','24',NULL,'IBSH00_CHANGES_ONLY_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAMLIRPEXZ0','3','D','10','25',NULL,'IBSH00_PAYROLL_LOCATION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAMLIRPEXZ0','5182','D','10','26',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAMLIRPEXZ0','6','D','20','1',NULL,'IB_RECORD_TYPE',NULL,NULL,'"IBEN01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAMLIRPEXZ0','10','D','20','2',NULL,'IB_COMPANY_ID',NULL,NULL,'"125003"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAMLIRPEXZ0','10','D','20','3',NULL,'IBEN01_PRODUCT_TYPE',NULL,NULL,'"drvProductType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAMLIRPEXZ0','10','D','20','4',NULL,'IBEN01_CASE_NUMBER',NULL,NULL,'"drvCaseNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAMLIRPEXZ0','9','D','20','5',NULL,'IBEN01_PLAN_NUMBER',NULL,NULL,'"drvPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAMLIRPEXZ0','3','D','20','6',NULL,'IBEN01_Plan_Version_Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAMLIRPEXZ0','10','D','20','7',NULL,'IBEN01_PART_NUMBER',NULL,NULL,'"drvPartNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAMLIRPEXZ0','1','D','20','8',NULL,'IBEN01_NQNewHire_Indicator',NULL,NULL,'"drvNqnewhireIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAMLIRPEXZ0','10','D','20','9',NULL,'IBEN01_EMPLOYEE_ID',NULL,NULL,'"drvEmployeeId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAMLIRPEXZ0','5431','D','20','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAMLIRPEXZ0','6','D','30','1',NULL,'IB_RECORD_TYPE',NULL,NULL,'"IBSH01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAMLIRPEXZ0','10','D','30','2',NULL,'IB_COMPANY_ID',NULL,NULL,'"125003"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAMLIRPEXZ0','10','D','30','3',NULL,'IB_PRODUCT_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAMLIRPEXZ0','10','D','30','4',NULL,'IB_CASE_NUMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAMLIRPEXZ0','9','D','30','5',NULL,'IB_PLAN_NUMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAMLIRPEXZ0','3','D','30','6',NULL,'IBSH01_Plan_Version_Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAMLIRPEXZ0','10','D','30','7',NULL,'IBSH01_PART_NUMBER',NULL,NULL,'"drvPartNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAMLIRPEXZ0','9','D','30','8',NULL,'IBSH01_SEARCH_KEY',NULL,NULL,'"drvSearchKey"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAMLIRPEXZ0','1','D','30','9',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAMLIRPEXZ0','10','D','30','10',NULL,'IBSH01_EMPLOYEE_NUMBER',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAMLIRPEXZ0','10','D','30','11',NULL,'IBSH01_OLD_SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAMLIRPEXZ0','9','D','30','12',NULL,'IBSH01_TAX_IDENTIFICATION_NUMBER',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAMLIRPEXZ0','1','D','30','13',NULL,'IBSH01_TIN_TYPE',NULL,NULL,'"drvTinType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAMLIRPEXZ0','15','D','30','14',NULL,'IBSH01_LAST_NAME',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAMLIRPEXZ0','15','D','30','15',NULL,'IBSH01_FIRST_NAME',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAMLIRPEXZ0','1','D','30','16',NULL,'IBSH01_MIDDLE_NAME',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAMLIRPEXZ0','30','D','30','17',NULL,'IBSH01_FULL_NAME',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAMLIRPEXZ0','15','D','30','18',NULL,'IBSH01_LAST_NAME_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAMLIRPEXZ0','15','D','30','19',NULL,'IBSH01_FIRST_NAME_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAMLIRPEXZ0','1','D','30','20',NULL,'IBSH01_MIDDLE_NAME_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAMLIRPEXZ0','15','D','30','21',NULL,'IBSH01_NICKNAME',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAMLIRPEXZ0','8','D','30','22',NULL,'IBSH01_BIRTH_DATE',NULL,NULL,'"drvDOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAMLIRPEXZ0','1','D','30','23',NULL,'IBSH01_GENDER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAMLIRPEXZ0','1','D','30','24',NULL,'IBSH01_MARITAL_STATUS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAMLIRPEXZ0','30','D','30','25',NULL,'IBSH01_STREET_ADDRESS_L1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAMLIRPEXZ0','30','D','30','26',NULL,'IBSH01_STREET_ADDRESS_L2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBAMLIRPEXZ0','30','D','30','27',NULL,'IBSH01_STREET_ADDRESS_L3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBAMLIRPEXZ0','30','D','30','28',NULL,'IBSH01_STREET_ADDRESS_L4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBAMLIRPEXZ0','30','D','30','29',NULL,'IBSH01_STREET_ADDRESS_L5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBAMLIRPEXZ0','18','D','30','30',NULL,'IBSH01_CITY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBAMLIRPEXZ0','2','D','30','31',NULL,'IBSH01_STATE',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBAMLIRPEXZ0','5','D','30','32',NULL,'IBSH01_ZIP',NULL,NULL,'"drvAddressZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBAMLIRPEXZ0','4','D','30','33',NULL,'IBSH01_ZIP_SUFFIX',NULL,NULL,'"drvAddressZipSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBAMLIRPEXZ0','18','D','30','34',NULL,'IBSH01_FOREIGN_POSTAL_CODE',NULL,NULL,'"drvForeignZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBAMLIRPEXZ0','3','D','30','35',NULL,'IBSH01_Country',NULL,NULL,'"drvCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBAMLIRPEXZ0','3','D','30','36',NULL,'IBSH01_COUNTRY_OF_RESIDENCE',NULL,NULL,'"drvCountryofResidence"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBAMLIRPEXZ0','8','D','30','37',NULL,'IBSH01_COUNTRY_RESIDENCE_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBAMLIRPEXZ0','3','D','30','38',NULL,'IBSH01_COUNTRY_OF_CITIZENSHIP',NULL,NULL,'"drvCountryOfCitizenship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBAMLIRPEXZ0','2','D','30','39',NULL,'IBSH01_ALTERNATE_STATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBAMLIRPEXZ0','1','D','30','40',NULL,'IBSH01_FOREIGN_RES_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBAMLIRPEXZ0','2','D','30','41',NULL,'IBSH01_BONAFIDE_RESIDENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBAMLIRPEXZ0','1','D','30','42',NULL,'IBSH01_TAX_JURISDICTION',NULL,NULL,'"drvTaxJurisdiction"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBAMLIRPEXZ0','3','D','30','43',NULL,'IBSH01_TAX_CODE',NULL,NULL,'"drvTaxcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBAMLIRPEXZ0','50','D','30','44',NULL,'IBSH01_BUS_EMAIL_ADDRESS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBAMLIRPEXZ0','15','D','30','45',NULL,'IBSH01_PHONE_NUMBER_1',NULL,NULL,'"drvPhone1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBAMLIRPEXZ0','1','D','30','46',NULL,'IBSH01_PHONE_NUMBER_1_TYPE',NULL,NULL,'"drvPhone1Type"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBAMLIRPEXZ0','15','D','30','47',NULL,'IBSH01_PHONE_NUMBER_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBAMLIRPEXZ0','1','D','30','48',NULL,'IBSH01_PHONE_NUMBER_2_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBAMLIRPEXZ0','15','D','30','49',NULL,'IBSH01_FAX_NUMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBAMLIRPEXZ0','1','D','30','50',NULL,'IBSH01_MAIL_CODE',NULL,NULL,'"drvMailCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBAMLIRPEXZ0','30','D','30','51',NULL,'IBSH01_SPECIAL_MAIL_HANDLING_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBAMLIRPEXZ0','3','D','30','52',NULL,'IBSH01_PREFERRED_CURRENCY',NULL,NULL,'"drvPreferredCurrency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBAMLIRPEXZ0','3','D','30','53',NULL,'IBSH01_LANGUAGE_PREFERENCE_CODE',NULL,NULL,'"drvLanguagePrefCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBAMLIRPEXZ0','15','D','30','54',NULL,'IBSH01_SPOUSE_SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBAMLIRPEXZ0','8','D','30','55',NULL,'IBSH01_SPOUSE_DATE_OF_BIRTH',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBAMLIRPEXZ0','8','D','30','56',NULL,'IBSH01_SPOUSE_DATE_OF_DEATH',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBAMLIRPEXZ0','8','D','30','57',NULL,'IBSH01_SPOUSE_DATE_OF_MARRIAGE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBAMLIRPEXZ0','8','D','30','58',NULL,'IBSH01_SPOUSE_DATE_OF_DIVORCE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBAMLIRPEXZ0','4','D','30','59',NULL,'IBSH01_DIV_SUB',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBAMLIRPEXZ0','1','D','30','60',NULL,'IBSH01_EE_NON_EE_IND',NULL,NULL,'"drvEENonEEInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBAMLIRPEXZ0','1','D','30','61',NULL,'IBSH01_FSE_LSE_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBAMLIRPEXZ0','5','D','30','62',NULL,'IBSH01_EMPLOYMENT_STATUS',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBAMLIRPEXZ0','8','D','30','63',NULL,'IBSH01_ORIGINAL_HIRE_DATE',NULL,NULL,'"EecDateOfOriginalHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBAMLIRPEXZ0','8','D','30','64',NULL,'IBSH01_REHIRE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBAMLIRPEXZ0','1','D','30','65',NULL,'IBSH01_LEAVE_ABSENCE_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBAMLIRPEXZ0','8','D','30','66',NULL,'IBSH01_TERM_RETIRE_DATE',NULL,NULL,'"drvTermRehireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBAMLIRPEXZ0','10','D','30','67',NULL,'IBSH01_TERMINATION_ID',NULL,NULL,'"drvTermID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBAMLIRPEXZ0','8','D','30','68',NULL,'IBSH01_COUNTRY_OF_CITIZENSHIP_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBAMLIRPEXZ0','8','D','30','69',NULL,'IBSH01_FSE_LSE_INDICATOR_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBAMLIRPEXZ0','8','D','30','70',NULL,'IBSH01_DIV_SUB_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBAMLIRPEXZ0','8','D','30','71',NULL,'IBSH01_EMPLOYMENT_STATUS_EFFECTIVE_DATE',NULL,NULL,'"drvEmploymentStatusEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBAMLIRPEXZ0','8','D','30','72',NULL,'IBSH01_ENTITY_CODE_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBAMLIRPEXZ0','100','D','30','73',NULL,'IBSH01_ALT_EXTENDED_EMAIL_ADDRESS',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBAMLIRPEXZ0','10','D','30','74',NULL,'IBSH01_TITLE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBAMLIRPEXZ0','40','D','30','75',NULL,'IBSH01_EXTENDED_FULL_NAME',NULL,NULL,'"drvFullName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBAMLIRPEXZ0','25','D','30','76',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBAMLIRPEXZ0','40','D','30','77',NULL,'IBSH01_PROVINCE (added July 2016)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBAMLIRPEXZ0','15','D','30','78',NULL,'IBSH01_UNIQUE_PPT_KEY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EBAMLIRPEXZ0','40','D','30','79',NULL,'IBSH01_EXTENDED_ADDRESS_1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EBAMLIRPEXZ0','40','D','30','80',NULL,'IBSH01_EXTENDED_ADDRESS_2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EBAMLIRPEXZ0','40','D','30','81',NULL,'IBSH01_EXTENDED_ADDRESS_3',NULL,NULL,'"drvAddressLine3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EBAMLIRPEXZ0','40','D','30','82',NULL,'IBSH01_EXTENDED_ADDRESS_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EBAMLIRPEXZ0','22','D','30','83',NULL,'IBSH01_EXTENDED_CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EBAMLIRPEXZ0','1','D','30','84',NULL,'IBSH01_GREEN_CARD_HOLDER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EBAMLIRPEXZ0','3','D','30','85',NULL,'IBSH01_NATIONALITY_1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EBAMLIRPEXZ0','3','D','30','86',NULL,'IBSH01_NATIONALITY_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EBAMLIRPEXZ0','3','D','30','87',NULL,'IBSH01_NATIONALITY_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EBAMLIRPEXZ0','38','D','30','88',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EBAMLIRPEXZ0','1','D','30','89',NULL,'IBSH01_LAST_NAME_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EBAMLIRPEXZ0','1','D','30','90',NULL,'IBSH01_FIRST_NAME_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EBAMLIRPEXZ0','1','D','30','91',NULL,'IBSH01_MIDDLE_NAME_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EBAMLIRPEXZ0','1','D','30','92',NULL,'IBSH01_NICKNAME_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EBAMLIRPEXZ0','1','D','30','93',NULL,'IBSH01_BIRTH_DATE_FLAG',NULL,NULL,'"drvDOBFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EBAMLIRPEXZ0','1','D','30','94',NULL,'IBSH01_STREET_ADDRESS_L1_FLAG',NULL,NULL,'"drvAddressLine1Flag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EBAMLIRPEXZ0','1','D','30','95',NULL,'IBSH01_STREET_ADDRESS_L2_FLAG',NULL,NULL,'"drvAddressLine2Flag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EBAMLIRPEXZ0','1','D','30','96',NULL,'IBSH01_STREET_ADDRESS_L3_FLAG',NULL,NULL,'"drvAddressLine3Flag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EBAMLIRPEXZ0','1','D','30','97',NULL,'IBSH01_STREET_ADDRESS_L4_FLAG',NULL,NULL,'"drvAddressLine4Flag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EBAMLIRPEXZ0','1','D','30','98',NULL,'IBSH01_STREET_ADDRESS_L5_FLAG',NULL,NULL,'"drvAddressLine5Flag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EBAMLIRPEXZ0','1','D','30','99',NULL,'IBSH01_CITY_FLAG',NULL,NULL,'"drvCityFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EBAMLIRPEXZ0','1','D','30','100',NULL,'IBSH01_STATE_FLAG',NULL,NULL,'"drvStateFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EBAMLIRPEXZ0','1','D','30','101',NULL,'IBSH01_ZIP_FLAG',NULL,NULL,'"drvZipFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EBAMLIRPEXZ0','1','D','30','102',NULL,'IBSH01_ZIP_SUFFIX_FLAG',NULL,NULL,'"drvZipSuffixFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EBAMLIRPEXZ0','1','D','30','103',NULL,'IBSH01_Country_FLAG',NULL,NULL,'"drvCountryFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EBAMLIRPEXZ0','1','D','30','104',NULL,'IBSH01_COUNTRY_OF_RESIDENCE_FLAG',NULL,NULL,'"drvCountryofResidenceFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EBAMLIRPEXZ0','1','D','30','105',NULL,'IBSH01_COUNTRY_RESIDENCE_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EBAMLIRPEXZ0','1','D','30','106',NULL,'IBSH01_COUNTRY_OF_CITIZENSHIP_FLAG',NULL,NULL,'"drvCitizenshipFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EBAMLIRPEXZ0','1','D','30','107',NULL,'IBSH01_TAX_JURISDICTION_FLAG',NULL,NULL,'"drvTaxJurisdictionFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EBAMLIRPEXZ0','1','D','30','108',NULL,'IBSH01_BUS_EMAIL_ADDRESS_FLAG',NULL,NULL,'"drvBusEmailFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EBAMLIRPEXZ0','1','D','30','109',NULL,'IBSH01_PHONE_NUMBER_FLAG',NULL,NULL,'"drvPhoneNumberFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EBAMLIRPEXZ0','1','D','30','110',NULL,'IBSH01_FAX_NUMBER_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EBAMLIRPEXZ0','1','D','30','111',NULL,'IBSH01_MAIL_CODE_FLAG',NULL,NULL,'"drvMailCodeFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EBAMLIRPEXZ0','1','D','30','112',NULL,'IBSH01_LANGUAGE_PREFERENCE_CODE_FLAG',NULL,NULL,'"drvLanguagePrefCodeFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EBAMLIRPEXZ0','1','D','30','113',NULL,'IBSH01_EE_NON_EE_IND_FLAG',NULL,NULL,'"drvEENonEEIndFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EBAMLIRPEXZ0','1','D','30','114',NULL,'IBSH01_RECENT_HIRE_DATE_FLAG',NULL,NULL,'"drvRecentHireDateFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EBAMLIRPEXZ0','1','D','30','115',NULL,'IBSH01_TERM_RETIRE_DATE_FLAG',NULL,NULL,'"drvTermRehireDateFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EBAMLIRPEXZ0','1','D','30','116',NULL,'IBSH01_TERMINATION_ID_FLAG',NULL,NULL,'"drvTerminationIDFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EBAMLIRPEXZ0','8','D','30','117',NULL,'IBSH01_SERVICE_SEPARATION_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EBAMLIRPEXZ0','8','D','30','118',NULL,'IBSH01_RETIREE_MEDICAL_ELIG_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EBAMLIRPEXZ0','30','D','30','119',NULL,'IBSH01_WORK_ADDR1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EBAMLIRPEXZ0','30','D','30','120',NULL,'IBSH01_WORK_ADDR2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EBAMLIRPEXZ0','18','D','30','121',NULL,'IBSH01_WORK_CITY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EBAMLIRPEXZ0','2','D','30','122',NULL,'IBSH01_WORK_STATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EBAMLIRPEXZ0','5','D','30','123',NULL,'IBSH01_WORK_ZIP_5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EBAMLIRPEXZ0','4','D','30','124',NULL,'IBSH01_WORK_ZIP_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EBAMLIRPEXZ0','8','D','30','125',NULL,'IBSH01_IB_COUNTRY_OF_RESIDENCE_EFFDATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EBAMLIRPEXZ0','8','D','30','126',NULL,'IBSH01_SEVERANCE_START_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EBAMLIRPEXZ0','8','D','30','127',NULL,'IBSH01_SEVERANCE_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EBAMLIRPEXZ0','10','D','30','128',NULL,'IBSH01_SEVERANCE_PLAN_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EBAMLIRPEXZ0','8','D','30','129',NULL,'IBSH01_RETIREMENT_BRIDGING_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EBAMLIRPEXZ0','10','D','30','130',NULL,'IBSH01_IB_UDF1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EBAMLIRPEXZ0','10','D','30','131',NULL,'IBSH01_IB_UDF2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EBAMLIRPEXZ0','30','D','30','132',NULL,'IBSH01_IB_UDF3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EBAMLIRPEXZ0','15','D','30','133',NULL,'IBSH01_IB_UDF4A',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EBAMLIRPEXZ0','15','D','30','134',NULL,'IBSH01_IB_UDF4B',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EBAMLIRPEXZ0','30','D','30','135',NULL,'IBSH01_IB_UDF5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EBAMLIRPEXZ0','30','D','30','136',NULL,'IBSH01_IB_UDF6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EBAMLIRPEXZ0','30','D','30','137',NULL,'IBSH01_IB_UDF7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EBAMLIRPEXZ0','30','D','30','138',NULL,'IBSH01_IB_UDF8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EBAMLIRPEXZ0','30','D','30','139',NULL,'IBSH01_IB_UDF9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EBAMLIRPEXZ0','30','D','30','140',NULL,'IBSH01_IB_UDF10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EBAMLIRPEXZ0','3','D','30','141',NULL,'IBSH01_BENEFITS_POPULATION_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EBAMLIRPEXZ0','1','D','30','142',NULL,'IBSH01_INTERNATIONAL_ASSIGNEE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EBAMLIRPEXZ0','10','D','30','143',NULL,'IBSH01_PH-UDF-TEXT-1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EBAMLIRPEXZ0','10','D','30','144',NULL,'IBSH01_PH-UDF-TEXT-2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EBAMLIRPEXZ0','41','D','30','145',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EBAMLIRPEXZ0','8','D','30','146',NULL,'IBSH01_TRANSFER EFFECTIVE DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EBAMLIRPEXZ0','8','D','30','147',NULL,'IBSH01_ADJ_HIRE_DATE_VEST_OVERRIDE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EBAMLIRPEXZ0','1','D','30','148',NULL,'IBSH01_ADJ_HIRE_DATE_VEST_OVERRIDE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EBAMLIRPEXZ0','8','D','30','149',NULL,'IBSH01_TERM_STATUS_EFF_DT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EBAMLIRPEXZ0','1','D','30','150',NULL,'IBSH01_REHIRE_CREDIT_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EBAMLIRPEXZ0','2','D','30','151',NULL,'IBSH01_REHIRE_ADJUSTED_MONTHS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EBAMLIRPEXZ0','8','D','30','152',NULL,'IBSH01_DC_VESTING_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EBAMLIRPEXZ0','8','D','30','153',NULL,'IBSH01_DC_ADJUSTED_SERVICE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EBAMLIRPEXZ0','1','D','30','154',NULL,'IBSH01_DC_ELIGIBILITY_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EBAMLIRPEXZ0','9','D','30','155',NULL,'IBSH01_DC_BENEFIT_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EBAMLIRPEXZ0','4','D','30','156',NULL,'IBSH01_DC_ELECT_BT_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EBAMLIRPEXZ0','4','D','30','157',NULL,'IBSH01_DC_ELECT_AT_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EBAMLIRPEXZ0','1','D','30','158',NULL,'IBSH01_DC_SAVE_RATE_USAGE_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EBAMLIRPEXZ0','8','D','30','159',NULL,'IBSH01_DC_VESTING_START_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EBAMLIRPEXZ0','8','D','30','160',NULL,'IBSH01_DC_USERRA_START_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EBAMLIRPEXZ0','8','D','30','161',NULL,'IBSH01_DC_USERRA_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EBAMLIRPEXZ0','8','D','30','162',NULL,'IBSH01_DC_LOA_START_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EBAMLIRPEXZ0','8','D','30','163',NULL,'IBSH01_DC_LOA_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EBAMLIRPEXZ0','2','D','30','164',NULL,'IBSH01_DC_DC_PLAN_STATUS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EBAMLIRPEXZ0','1','D','30','165',NULL,'IBSH01_PAYROLL_FREQ',NULL,NULL,'"drvPayrollFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EBAMLIRPEXZ0','4','D','30','166',NULL,'IBSH01_DC_PAYROLL_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EBAMLIRPEXZ0','1','D','30','167',NULL,'IBSH01_DC_HCE_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EBAMLIRPEXZ0','1','D','30','168',NULL,'IBSH01_DC_SECTION_16_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EBAMLIRPEXZ0','1','D','30','169',NULL,'IBSH01_DC_EXECUTIVE_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EBAMLIRPEXZ0','8','D','30','170',NULL,'IBSH01_DC_PLAN_ENTRY_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EBAMLIRPEXZ0','5','D','30','171',NULL,'IBSH01_DC_HOURS_CREDITED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EBAMLIRPEXZ0','7','D','30','172',NULL,'IBSH01_DC_HOURS_SERVICE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EBAMLIRPEXZ0','9','D','30','173',NULL,'IBSH01_DC_YTD_415_COMPENSATION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EBAMLIRPEXZ0','10','D','30','174',NULL,'IBSH01_DC_Y_AND_R_FILE_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EBAMLIRPEXZ0','6','D','30','175',NULL,'IBSH01_DC_SMALLMKT_ELEG_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EBAMLIRPEXZ0','8','D','30','176',NULL,'IBSH01_DC_ELIGIBILITY_COMP_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EBAMLIRPEXZ0','4','D','30','177',NULL,'IBSH01_DC_BASIC',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EBAMLIRPEXZ0','4','D','30','178',NULL,'IBSH01_DC_SUPPL',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EBAMLIRPEXZ0','4','D','30','179',NULL,'IBSH01_DC_ADDL_SUPPL',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EBAMLIRPEXZ0','1','D','30','180',NULL,'IBSH01_DC_UDF_1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EBAMLIRPEXZ0','1','D','30','181',NULL,'IBSH01_DC_UDF_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EBAMLIRPEXZ0','1','D','30','182',NULL,'IBSH01_DC_UDF_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EBAMLIRPEXZ0','1','D','30','183',NULL,'IBSH01_DC_UDF_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EBAMLIRPEXZ0','1','D','30','184',NULL,'IBSH01_DC_UDF_5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EBAMLIRPEXZ0','2','D','30','185',NULL,'IBSH01_DC_UDF_6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EBAMLIRPEXZ0','2','D','30','186',NULL,'IBSH01_DC_UDF_7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EBAMLIRPEXZ0','10','D','30','187',NULL,'IBSH01_ANNUAL_ADVICE_SALARY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EBAMLIRPEXZ0','5','D','30','188',NULL,'IBSH01_DC_MW_COMPANY_PAYROLL_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EBAMLIRPEXZ0','4','D','30','189',NULL,'IBSH01_DC_MW_ELECT_SUPPL_BT_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EBAMLIRPEXZ0','4','D','30','190',NULL,'IBSH01_DC_MW_ELECT_SUPPL_AT_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EBAMLIRPEXZ0','6','D','30','191',NULL,'IBSH01_DC_MW_CPAY_HRS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EBAMLIRPEXZ0','11','D','30','192',NULL,'IBSH01_DC_MW_CPAY_PLAN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EBAMLIRPEXZ0','11','D','30','193',NULL,'IBSH01_DC_MW_CPAY_STAT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EBAMLIRPEXZ0','11','D','30','194',NULL,'IBSH01_DC_MW_CPAY_TOT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EBAMLIRPEXZ0','11','D','30','195',NULL,'IBSH01_DC_MW_PYTD_PLAN_PAY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EBAMLIRPEXZ0','11','D','30','196',NULL,'IBSH01_DC_MW_PYTD_TOT_PAY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EBAMLIRPEXZ0','1','D','30','197',NULL,'IBSH01_DC_MW_EXEMPT_NONEX_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EBAMLIRPEXZ0','1','D','30','198',NULL,'IBSH01_DC_MW_TRANSFER_CD',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EBAMLIRPEXZ0','8','D','30','199',NULL,'IBSH01_DC_SALARY_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EBAMLIRPEXZ0','4','D','30','200',NULL,'IBSH01_DC_ROTH_ELECT_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EBAMLIRPEXZ0','1','D','30','201',NULL,'IBSH01_DC_ROTH_SAVE_RATE_USAGE_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EBAMLIRPEXZ0','4','D','30','202',NULL,'IBSH01_DC_MW_ELECT_SUPPL_ROTH_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EBAMLIRPEXZ0','5','D','30','203',NULL,'IBSH01_DC_ROTH_ELECT_FLAT_SAVE_RATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EBAMLIRPEXZ0','10','D','30','204',NULL,'IBSH01_DC_ANNUALIZED_LTD_COMP',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EBAMLIRPEXZ0','3','D','30','205',NULL,'IBSH01_SALARY_BAND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EBAMLIRPEXZ0','396','D','30','206',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EBAMLIRPEXZ0','4','D','30','207',NULL,'IBSH01_NQ_Entity_Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EBAMLIRPEXZ0','15','D','30','208',NULL,'IBSH01_NQ_Participant Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EBAMLIRPEXZ0','1','D','30','209',NULL,'IBSH01_NQ_FA_Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EBAMLIRPEXZ0','3','D','30','210',NULL,'IBSH01_NQ_PLAN_STATUS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EBAMLIRPEXZ0','11','D','30','211',NULL,'IBSH01_NQ_Compensation_1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EBAMLIRPEXZ0','1','D','30','212',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EBAMLIRPEXZ0','11','D','30','213',NULL,'IBSH01_NQ_Compensation_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EBAMLIRPEXZ0','1','D','30','214',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EBAMLIRPEXZ0','4','D','30','215',NULL,'IBSH01_NQ_PAYROLL_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EBAMLIRPEXZ0','1','D','30','216',NULL,'IBSH01_NQ_KEY_EMPLOYEE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EBAMLIRPEXZ0','499','D','30','217',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EBAMLIRPEXZ0','8','D','30','218',NULL,'IBSH01_DB_SERVICE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EBAMLIRPEXZ0','8','D','30','219',NULL,'IBSH01_DB_DATE_OF_PARTICIPATION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EBAMLIRPEXZ0','8','D','30','220',NULL,'IBSH01_DB_DATE_OF_LAST_TRANSFER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EBAMLIRPEXZ0','1','D','30','221',NULL,'IBSH01_DB_TRANSFERRED_EMPLOYEE_RECORD_INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EBAMLIRPEXZ0','2','D','30','222',NULL,'IBSH01_DB_NUMBER_OF_FEDERAL_EXEMPTION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EBAMLIRPEXZ0','1','D','30','223',NULL,'IBSH01_DB_FEDERAL_INCOME_TAX_FILING_STATUS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EBAMLIRPEXZ0','10','D','30','224',NULL,'IBSH01_DB_GROUP_DATE1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EBAMLIRPEXZ0','25','D','30','225',NULL,'IBSH01_DB_GROUP_CODE1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EBAMLIRPEXZ0','10','D','30','226',NULL,'IBSH01_DB_GROUP_DATE2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EBAMLIRPEXZ0','25','D','30','227',NULL,'IBSH01_DB_GROUP_CODE2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EBAMLIRPEXZ0','10','D','30','228',NULL,'IBSH01_DB_GROUP_DATE3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EBAMLIRPEXZ0','25','D','30','229',NULL,'IBSH01_DB_GROUP_CODE3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EBAMLIRPEXZ0','10','D','30','230',NULL,'IBSH01_DB_GROUP_DATE4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EBAMLIRPEXZ0','25','D','30','231',NULL,'IBSH01_DB_GROUP_CODE4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EBAMLIRPEXZ0','10','D','30','232',NULL,'IBSH01_DB_GROUP_DATE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EBAMLIRPEXZ0','25','D','30','233',NULL,'IBSH01_DB_GROUP_CODE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EBAMLIRPEXZ0','10','D','30','234',NULL,'IBSH01_DB_STATUS_DATE1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EBAMLIRPEXZ0','25','D','30','235',NULL,'IBSH01_DB_STATUS_CODE1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EBAMLIRPEXZ0','25','D','30','236',NULL,'IBSH01_DB_STATUS_REASON1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EBAMLIRPEXZ0','10','D','30','237',NULL,'IBSH01_DB_STATUS_DATE2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EBAMLIRPEXZ0','25','D','30','238',NULL,'IBSH01_DB_STATUS_CODE2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EBAMLIRPEXZ0','25','D','30','239',NULL,'IBSH01_DB_STATUS_REASON2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EBAMLIRPEXZ0','10','D','30','240',NULL,'IBSH01_DB_STATUS_DATE3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EBAMLIRPEXZ0','25','D','30','241',NULL,'IBSH01_DB_STATUS_CODE3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EBAMLIRPEXZ0','25','D','30','242',NULL,'IBSH01_DB_STATUS_REASON3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EBAMLIRPEXZ0','10','D','30','243',NULL,'IBSH01_DB_STATUS_DATE4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EBAMLIRPEXZ0','25','D','30','244',NULL,'IBSH01_DB_STATUS_CODE4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EBAMLIRPEXZ0','25','D','30','245',NULL,'IBSH01_DB_STATUS_REASON4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EBAMLIRPEXZ0','10','D','30','246',NULL,'IBSH01_DB_STATUS_DATE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EBAMLIRPEXZ0','25','D','30','247',NULL,'IBSH01_DB_STATUS_CODE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EBAMLIRPEXZ0','25','D','30','248',NULL,'IBSH01_DB_STATUS_REASON5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EBAMLIRPEXZ0','10','D','30','249',NULL,'IBSH01_DB_GROUP_DATE6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EBAMLIRPEXZ0','25','D','30','250',NULL,'IBSH01_DB_GROUP_CODE6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EBAMLIRPEXZ0','10','D','30','251',NULL,'IBSH01_DB_GROUP_DATE7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EBAMLIRPEXZ0','25','D','30','252',NULL,'IBSH01_DB_GROUP_CODE7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EBAMLIRPEXZ0','10','D','30','253',NULL,'IBSH01_DB_GROUP_DATE8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EBAMLIRPEXZ0','25','D','30','254',NULL,'IBSH01_DB_GROUP_CODE8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','EBAMLIRPEXZ0','10','D','30','255',NULL,'IBSH01_DB_GROUP_DATE9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','EBAMLIRPEXZ0','25','D','30','256',NULL,'IBSH01_DB_GROUP_CODE9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','EBAMLIRPEXZ0','10','D','30','257',NULL,'IBSH01_DB_GROUP_DATE10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','EBAMLIRPEXZ0','25','D','30','258',NULL,'IBSH01_DB_GROUP_CODE10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','EBAMLIRPEXZ0','10','D','30','259',NULL,'IBSH01_DB_GROUP_DATE11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','EBAMLIRPEXZ0','25','D','30','260',NULL,'IBSH01_DB_GROUP_CODE11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','EBAMLIRPEXZ0','10','D','30','261',NULL,'IBSH01_DB_GROUP_DATE12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','EBAMLIRPEXZ0','25','D','30','262',NULL,'IBSH01_DB_GROUP_CODE12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','EBAMLIRPEXZ0','10','D','30','263',NULL,'IBSH01_DB_GROUP_DATE13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','EBAMLIRPEXZ0','25','D','30','264',NULL,'IBSH01_DB_GROUP_CODE13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','EBAMLIRPEXZ0','10','D','30','265',NULL,'IBSH01_DB_GROUP_DATE14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','EBAMLIRPEXZ0','25','D','30','266',NULL,'IBSH01_DB_GROUP_CODE14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','EBAMLIRPEXZ0','10','D','30','267',NULL,'IBSH01_DB_GROUP_DATE15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','EBAMLIRPEXZ0','25','D','30','268',NULL,'IBSH01_DB_GROUP_CODE15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','EBAMLIRPEXZ0','150','D','30','269',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','EBAMLIRPEXZ0','10','D','30','270',NULL,'IBSH01_AC_OPTIONEE_ID',NULL,NULL,'"drvACOPTIONEEID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','EBAMLIRPEXZ0','10','D','30','271',NULL,'IBSH01_AC_ALT_OPTIONEE_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','EBAMLIRPEXZ0','1','D','30','272',NULL,'IBSH01_AC_ALT_OPTIONEE_ID_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','EBAMLIRPEXZ0','8','D','30','273',NULL,'IBSH01_AC_SUBSIDIARY_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','EBAMLIRPEXZ0','8','D','30','274',NULL,'IBSH01_AC_SUBSIDIARY_CODE_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','EBAMLIRPEXZ0','8','D','30','275',NULL,'IBSH01_AC_LOCATION_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','EBAMLIRPEXZ0','8','D','30','276',NULL,'IBSH01_AC_LOCATION_CODE_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','EBAMLIRPEXZ0','8','D','30','277',NULL,'IBSH01_AC_TITLE_CODE',NULL,NULL,'"drvACTitleCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','EBAMLIRPEXZ0','8','D','30','278',NULL,'IBSH01_AC_OFFICER_CODE',NULL,NULL,'"drvACOfficerCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','EBAMLIRPEXZ0','8','D','30','279',NULL,'IBSH01_AC_TAX_CODE',NULL,NULL,'"drvACTaxCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','EBAMLIRPEXZ0','1','D','30','280',NULL,'IBSH01_AC_FICA_APPLICABLE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','EBAMLIRPEXZ0','8','D','30','281',NULL,'IBSH01_AC_LAST_DATE_TO_EXERCISE_SERIAL_SEV_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','EBAMLIRPEXZ0','8','D','30','282',NULL,'IBSH01_AC_USER_CODE1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','EBAMLIRPEXZ0','8','D','30','283',NULL,'IBSH01_AC_USER_CODE1_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','EBAMLIRPEXZ0','8','D','30','284',NULL,'IBSH01_AC_USER_CODE2',NULL,NULL,'"drvACUserCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','EBAMLIRPEXZ0','8','D','30','285',NULL,'IBSH01_AC_USER_CODE2_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','EBAMLIRPEXZ0','8','D','30','286',NULL,'IBSH01_AC_USER_CODE3',NULL,NULL,'"drvACUsercode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','EBAMLIRPEXZ0','8','D','30','287',NULL,'IBSH01_AC_USER_CODE3_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','EBAMLIRPEXZ0','15','D','30','288',NULL,'IBSH01_AC_USER_NUMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','EBAMLIRPEXZ0','15','D','30','289',NULL,'IBSH01_AC_YTD_TAXABLE_COMP',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','EBAMLIRPEXZ0','8','D','30','290',NULL,'IBSH01_AC_SALARY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','EBAMLIRPEXZ0','8','D','30','291',NULL,'IBSH01_AC_BROKER_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','EBAMLIRPEXZ0','20','D','30','292',NULL,'IBSH01_AC_USER_TEXT1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','EBAMLIRPEXZ0','20','D','30','293',NULL,'IBSH01_AC_USER_TEXT2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','EBAMLIRPEXZ0','8','D','30','294',NULL,'IBSH01_AC_USER_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','EBAMLIRPEXZ0','15','D','30','295',NULL,'IBSH01_AC_YTD_FICA_OAS',NULL,NULL,'"drvACYTDFICAOAS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','EBAMLIRPEXZ0','30','D','30','296',NULL,'IBSH01_AC_REGION',NULL,NULL,'"drvACRegion"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','EBAMLIRPEXZ0','20','D','30','297',NULL,'IBSH01_AC_BANK_ACCOUNT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','EBAMLIRPEXZ0','3','D','30','298',NULL,'IBSH01_AC_EE_LEVEL_RESTRICTION_CODE',NULL,NULL,'"drvACEELvlRestrictCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','EBAMLIRPEXZ0','15','D','30','299',NULL,'IBSH01_AC_AFFILIATE_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','EBAMLIRPEXZ0','1','D','30','300',NULL,'IBSH01_AC_REHIRE_CORRECT_TERM_IND',NULL,NULL,'"drvACRehireCorrTermInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','EBAMLIRPEXZ0','15','D','30','301',NULL,'IBSH01_AC_YTD_MEDICARE',NULL,NULL,'"drvACYTDMedicare"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','EBAMLIRPEXZ0','15','D','30','302',NULL,'IBSH01_AC_YTD_TAX_FIELD_1',NULL,NULL,'"drvACYTDTaxField1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','EBAMLIRPEXZ0','15','D','30','303',NULL,'IBSH01_AC_YTD_TAX_FIELD_2',NULL,NULL,'"drvACYTDTaxField2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','EBAMLIRPEXZ0','15','D','30','304',NULL,'IBSH01_AC_YTD_TAX_FIELD_3',NULL,NULL,'"drvACYTDTaxField3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','EBAMLIRPEXZ0','15','D','30','305',NULL,'IBSH01_AC_YTD_TAX_FIELD_4',NULL,NULL,'"drvACYTDTaxField4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','EBAMLIRPEXZ0','15','D','30','306',NULL,'IBSH01_AC_YTD_TAX_FIELD_5',NULL,NULL,'"drvACYTDTaxField5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','EBAMLIRPEXZ0','15','D','30','307',NULL,'IBSH01_AC_YTD_TAX_FIELD_6',NULL,NULL,'"drvACYTDTaxField6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','EBAMLIRPEXZ0','15','D','30','308',NULL,'IBSH01_AC_YTD_TAX_FIELD_7',NULL,NULL,'"drvACYTDTaxField7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','EBAMLIRPEXZ0','15','D','30','309',NULL,'IBSH01_AC_YTD_TAX_FIELD_8',NULL,NULL,'"drvACYTDTaxField8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','EBAMLIRPEXZ0','2','D','30','310',NULL,'IBSH01_AC_GRANT_TYPES_TO_APPLY_FICA_OAS',NULL,NULL,'"drvACGRANTTYPESTOFICAOAS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','EBAMLIRPEXZ0','2','D','30','311',NULL,'IBSH01_AC_GRANT_TYPES_TO_APPLY_MEDICARE',NULL,NULL,'"drvACGRANTTYPESTMEDICARE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','EBAMLIRPEXZ0','1','D','30','312',NULL,'IBSH01_AC_MSOP_IND',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','EBAMLIRPEXZ0','8','D','30','313',NULL,'IBSH01_AC_EE_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','EBAMLIRPEXZ0','15','D','30','314',NULL,'IBSH01_AC_POPULATION_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','EBAMLIRPEXZ0','15','D','30','315',NULL,'IBSH01_AC_SUPPLEMENTAL_COMP',NULL,NULL,'"drvAC_SUPPLEMENTAL_COMP"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','EBAMLIRPEXZ0','8','D','30','316',NULL,'IBSH01_AC_RETIREE_ELIGIBLE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','EBAMLIRPEXZ0','1','D','30','317',NULL,'IBSH01_AC_TRANSACTION_TAX_VERIFICATION_ELIGIBLE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','EBAMLIRPEXZ0','30','D','30','318',NULL,'IBSH01_AC_USER_TEXT_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','EBAMLIRPEXZ0','10','D','30','319',NULL,'IBSH01_AC_USER_TEXT_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','EBAMLIRPEXZ0','10','D','30','320',NULL,'IBSH01_AC_USER_TEXT_5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','EBAMLIRPEXZ0','8','D','30','321',NULL,'IBSH01_AC_USER_TEXT_6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','EBAMLIRPEXZ0','8','D','30','322',NULL,'IBSH01_AC_USER_TEXT_7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','EBAMLIRPEXZ0','4','D','30','323',NULL,'IBSH01_AC_USER_TEXT_8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','EBAMLIRPEXZ0','4','D','30','324',NULL,'IBSH01_AC_USER_TEXT_9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','EBAMLIRPEXZ0','50','D','30','325',NULL,'IBSH01_AC_USER_TEXT_10',NULL,NULL,'"drvAC_USER_TEXT_10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','EBAMLIRPEXZ0','12','D','30','326',NULL,'IBSH01_AC_USER_TEXT_11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','EBAMLIRPEXZ0','2','D','30','327',NULL,'IBSH01_AC_WORK_STATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','EBAMLIRPEXZ0','1','D','30','328',NULL,'IBSH01_AC_WORK_STATE_UPD_FLG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('329','EBAMLIRPEXZ0','3','D','30','329',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('330','EBAMLIRPEXZ0','1','D','30','330',NULL,'IBSH01_AC_IB_EEF_DATE_COUNTRY_OF_RESIDENCE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('331','EBAMLIRPEXZ0','1','D','30','331',NULL,'IBSH01_AC_SEVERANCE_START_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('332','EBAMLIRPEXZ0','1','D','30','332',NULL,'IBSH01_AC_SEVERANCE_END_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('333','EBAMLIRPEXZ0','1','D','30','333',NULL,'IBSH01_AC_SEVERANCE_PLAN_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('334','EBAMLIRPEXZ0','1','D','30','334',NULL,'IBSH01_AC_RETIREMENT_BRIDGING_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('335','EBAMLIRPEXZ0','1','D','30','335',NULL,'IBSH01_AC_IB_UDF1_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('336','EBAMLIRPEXZ0','1','D','30','336',NULL,'IBSH01_AC_IB_UDF2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('337','EBAMLIRPEXZ0','1','D','30','337',NULL,'IBSH01_AC_IB_UDF3_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('338','EBAMLIRPEXZ0','1','D','30','338',NULL,'IBSH01_AC_IB_UDF4A_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('339','EBAMLIRPEXZ0','1','D','30','339',NULL,'IBSH01_AC_IB_UDF4B_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('340','EBAMLIRPEXZ0','1','D','30','340',NULL,'IBSH01_AC_IB_UDF5_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('341','EBAMLIRPEXZ0','1','D','30','341',NULL,'IBSH01_AC_IB_UDF6_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('342','EBAMLIRPEXZ0','1','D','30','342',NULL,'IBSH01_AC_IB_UDF7_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('343','EBAMLIRPEXZ0','1','D','30','343',NULL,'IBSH01_AC_IB_UDF8_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('344','EBAMLIRPEXZ0','1','D','30','344',NULL,'IBSH01_AC_IB_UDF9_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('345','EBAMLIRPEXZ0','1','D','30','345',NULL,'IBSH01_AC_IB_UDF10_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('346','EBAMLIRPEXZ0','8','D','30','346',NULL,'IBSH01_AC_MOBILITY_EFFECTIVE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('347','EBAMLIRPEXZ0','3','D','30','347',NULL,'IBSH01_AC_ALLOCATION_%_1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('348','EBAMLIRPEXZ0','20','D','30','348',NULL,'IBSH01_AC_ALLOCATION_CODE_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('349','EBAMLIRPEXZ0','3','D','30','349',NULL,'IBSH01_AC_ALLOCATION_%_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('350','EBAMLIRPEXZ0','20','D','30','350',NULL,'IBSH01_AC_ALLOCATION_CODE_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('351','EBAMLIRPEXZ0','3','D','30','351',NULL,'IBSH01_AC_ALLOCATION_%_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('352','EBAMLIRPEXZ0','20','D','30','352',NULL,'IBSH01_AC_ALLOCATION_CODE_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('353','EBAMLIRPEXZ0','3','D','30','353',NULL,'IBSH01_AC_ALLOCATION_%_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('354','EBAMLIRPEXZ0','1','D','30','354',NULL,'IBSH01_AC_MOBILITY_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('355','EBAMLIRPEXZ0','1','D','30','355',NULL,'IBSH01_AC_RETIREE_ELIGIBLE_DATE_OVERRIDE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('356','EBAMLIRPEXZ0','8','D','30','356',NULL,'IBSH01_AC_USER_DATE_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('357','EBAMLIRPEXZ0','8','D','30','357',NULL,'IBSH01_AC_USER_DATE_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('358','EBAMLIRPEXZ0','20','D','30','358',NULL,'IBSH01_AC_TRANSFER_AGENT_ACCT_NO',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('359','EBAMLIRPEXZ0','8','D','30','359',NULL,'IBSH01_AC_ALTERNATE_TERM_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('360','EBAMLIRPEXZ0','192','D','30','360',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('361','EBAMLIRPEXZ0','1','D','30','361',NULL,'IBSH01_AC_ALT_OPTIONEE_ID_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('362','EBAMLIRPEXZ0','1','D','30','362',NULL,'IBSH01_AC_ALT_OPTIONEE_ID_IND_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('363','EBAMLIRPEXZ0','1','D','30','363',NULL,'IBSH01_AC_SUBSIDIARY_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('364','EBAMLIRPEXZ0','1','D','30','364',NULL,'IBSH01_AC_SUBSIDIARY_CODE_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('365','EBAMLIRPEXZ0','1','D','30','365',NULL,'IBSH01_AC_LOCATION_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('366','EBAMLIRPEXZ0','1','D','30','366',NULL,'IBSH01_AC_LOCATION_CODE_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('367','EBAMLIRPEXZ0','1','D','30','367',NULL,'IBSH01_AC_TITLE_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('368','EBAMLIRPEXZ0','1','D','30','368',NULL,'IBSH01_AC_OFFICER_CODE_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('369','EBAMLIRPEXZ0','1','D','30','369',NULL,'IBSH01_AC_TAX_CODE_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('370','EBAMLIRPEXZ0','1','D','30','370',NULL,'IBSH01_AC_FICA_APPLICABLE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('371','EBAMLIRPEXZ0','1','D','30','371',NULL,'IBSH01_AC_LASTDATETOEXERCISE_SERIAL_SEV_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('372','EBAMLIRPEXZ0','1','D','30','372',NULL,'IBSH01_AC_USER_CODE1_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('373','EBAMLIRPEXZ0','1','D','30','373',NULL,'IBSH01_AC_USER_CODE1_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('374','EBAMLIRPEXZ0','1','D','30','374',NULL,'IBSH01_AC_USER_CODE2_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('375','EBAMLIRPEXZ0','1','D','30','375',NULL,'IBSH01_AC_USER_CODE2_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('376','EBAMLIRPEXZ0','1','D','30','376',NULL,'IBSH01_AC_USER_CODE3_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('377','EBAMLIRPEXZ0','1','D','30','377',NULL,'IBSH01_AC_USER_CODE3_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('378','EBAMLIRPEXZ0','1','D','30','378',NULL,'IBSH01_AC_USER_NUMBER_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('379','EBAMLIRPEXZ0','1','D','30','379',NULL,'IBSH01_AC_YTD_TAXABLE_COMP_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('380','EBAMLIRPEXZ0','1','D','30','380',NULL,'IBSH01_AC_SALARY_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('381','EBAMLIRPEXZ0','1','D','30','381',NULL,'IBSH01_AC_BROKER_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('382','EBAMLIRPEXZ0','1','D','30','382',NULL,'IBSH01_AC_USER_TEXT1_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('383','EBAMLIRPEXZ0','1','D','30','383',NULL,'IBSH01_AC_USER_TEXT2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('384','EBAMLIRPEXZ0','1','D','30','384',NULL,'IBSH01_AC_USER_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('385','EBAMLIRPEXZ0','1','D','30','385',NULL,'IBSH01_AC_YTD_FICA_OAS_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('386','EBAMLIRPEXZ0','1','D','30','386',NULL,'IBSH01_AC_REGION_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('387','EBAMLIRPEXZ0','1','D','30','387',NULL,'IBSH01_AC_BANK_ACCOUNT_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('388','EBAMLIRPEXZ0','1','D','30','388',NULL,'IBSH01_AC_EE_LEVEL_RESTRICTION_CODE_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('389','EBAMLIRPEXZ0','1','D','30','389',NULL,'IBSH01_AC_AFFILIATE_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('390','EBAMLIRPEXZ0','1','D','30','390',NULL,'IBSH01_AC_YTD_MEDICARE_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('391','EBAMLIRPEXZ0','1','D','30','391',NULL,'IBSH01_AC_YTD_TAX_FIELD_1_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('392','EBAMLIRPEXZ0','1','D','30','392',NULL,'IBSH01_AC_YTD_TAX_FIELD_2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('393','EBAMLIRPEXZ0','1','D','30','393',NULL,'IBSH01_AC_YTD_TAX_FIELD_3_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('394','EBAMLIRPEXZ0','1','D','30','394',NULL,'IBSH01_AC_YTD_TAX_FIELD_4_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('395','EBAMLIRPEXZ0','1','D','30','395',NULL,'IBSH01_AC_YTD_TAX_FIELD_5_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('396','EBAMLIRPEXZ0','1','D','30','396',NULL,'IBSH01_AC_YTD_TAX_FIELD_6_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('397','EBAMLIRPEXZ0','1','D','30','397',NULL,'IBSH01_AC_YTD_TAX_FIELD_7_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('398','EBAMLIRPEXZ0','1','D','30','398',NULL,'IBSH01_AC_YTD_TAX_FIELD_8_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('399','EBAMLIRPEXZ0','1','D','30','399',NULL,'IBSH01_AC_GRANT_TYPES_TO_APPLY_FICA_OAS_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('400','EBAMLIRPEXZ0','1','D','30','400',NULL,'IBSH01_AC_GRANT_TYPES_TO_APPLY_MEDICARE_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('401','EBAMLIRPEXZ0','1','D','30','401',NULL,'IBSH01_AC_MSOP_IND_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('402','EBAMLIRPEXZ0','1','D','30','402',NULL,'IBSH01_AC_EE_EFFECTIVE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('403','EBAMLIRPEXZ0','1','D','30','403',NULL,'IBSH01_AC_POPULATION_CODE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('404','EBAMLIRPEXZ0','1','D','30','404',NULL,'IBSH01_AC_SUPPLEMENTAL_COMP_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('405','EBAMLIRPEXZ0','1','D','30','405',NULL,'IBSH01_AC_RETIREE_ELIGIBLE_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('406','EBAMLIRPEXZ0','1','D','30','406',NULL,'IBSH01_AC_TRANSACTION_TAX_VERIFICATION_ELIGIBLE_FL',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('407','EBAMLIRPEXZ0','1','D','30','407',NULL,'IBSH01_AC_USER_TEXT_3_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('408','EBAMLIRPEXZ0','1','D','30','408',NULL,'IBSH01_AC_USER_TEXT_4_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('409','EBAMLIRPEXZ0','1','D','30','409',NULL,'IBSH01_AC_USER_TEXT_5_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('410','EBAMLIRPEXZ0','1','D','30','410',NULL,'IBSH01_AC_USER_TEXT_6_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('411','EBAMLIRPEXZ0','1','D','30','411',NULL,'IBSH01_AC_USER_TEXT_7_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('412','EBAMLIRPEXZ0','1','D','30','412',NULL,'IBSH01_AC_USER_TEXT_8_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('413','EBAMLIRPEXZ0','1','D','30','413',NULL,'IBSH01_AC_USER_TEXT_9_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('414','EBAMLIRPEXZ0','1','D','30','414',NULL,'IBSH01_AC_USER_TEXT_10_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('415','EBAMLIRPEXZ0','1','D','30','415',NULL,'IBSH01_AC_USER_TEXT_11_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('416','EBAMLIRPEXZ0','1','D','30','416',NULL,'IBSH01_AC_MOBILITY_EFFECTIVE_DATE_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('417','EBAMLIRPEXZ0','1','D','30','417',NULL,'IBSH01_AC_ALLOCATION_%_1_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('418','EBAMLIRPEXZ0','1','D','30','418',NULL,'IBSH01_AC_ALLOCATION_CODE_2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('419','EBAMLIRPEXZ0','1','D','30','419',NULL,'IBSH01_AC_ALLOCATION_%_2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('420','EBAMLIRPEXZ0','1','D','30','420',NULL,'IBSH01_AC_ALLOCATION_CODE_3_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('421','EBAMLIRPEXZ0','1','D','30','421',NULL,'IBSH01_AC_ALLOCATION_%_3_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('422','EBAMLIRPEXZ0','1','D','30','422',NULL,'IBSH01_AC_ALLOCATION_CODE_4_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('423','EBAMLIRPEXZ0','1','D','30','423',NULL,'IBSH01_AC_ALLOCATION_%_4_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('424','EBAMLIRPEXZ0','1','D','30','424',NULL,'IBSH01_AC_UPD_MOBILITY_FLAG',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('425','EBAMLIRPEXZ0','1','D','30','425',NULL,'IBSH01_AC_RETIREE_ELIGIBLE_DATE_OVERRIDE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('426','EBAMLIRPEXZ0','1','D','30','426',NULL,'IBSH01_UPDATE_USER_DATE_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('427','EBAMLIRPEXZ0','1','D','30','427',NULL,'IBSH01_UPDATE_USER_DATE_4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('428','EBAMLIRPEXZ0','1','D','30','428',NULL,'IBSH01_AC_GREEN_CARD_HOLDER_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('429','EBAMLIRPEXZ0','1','D','30','429',NULL,'IBSH01_AC_NATIONALITY_1_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('430','EBAMLIRPEXZ0','1','D','30','430',NULL,'IBSH01_AC_NATIONALITY_2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('431','EBAMLIRPEXZ0','1','D','30','431',NULL,'IBSH01_AC_NATIONALITY_3_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('432','EBAMLIRPEXZ0','1','D','30','432',NULL,'IBSH01_AC_TRANSFER_AGENT_ACCT_NO_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('433','EBAMLIRPEXZ0','1','D','30','433',NULL,'IBSH01_AC_ALTERNATE_TERM_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('434','EBAMLIRPEXZ0','1','D','30','434',NULL,'IBSH01_PHONE_NUMBER_1_TYPE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('435','EBAMLIRPEXZ0','1','D','30','435',NULL,'IBSH01_PHONE_NUMBER_2_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('436','EBAMLIRPEXZ0','1','D','30','436',NULL,'IBSH01_PHONE_NUMBER_2_TYPE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('437','EBAMLIRPEXZ0','1','D','30','437',NULL,'IBSH01_PRE_CLEARANCE  ',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('438','EBAMLIRPEXZ0','1','D','30','438',NULL,'IBSH01_PRE_CLEARANCE_FLAG  ',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('439','EBAMLIRPEXZ0','1','D','30','439',NULL,'IBSH01_RULE_144',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('440','EBAMLIRPEXZ0','1','D','30','440',NULL,'IBSH01_RULE_144_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('441','EBAMLIRPEXZ0','1','D','30','441',NULL,'IBSH01_NON_ EMP_DIRECTOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('442','EBAMLIRPEXZ0','1','D','30','442',NULL,'IBSH01_NON_ EMP_DIRECTOR_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('443','EBAMLIRPEXZ0','8','D','30','443',NULL,'IBSH01_RULE_144_START_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('444','EBAMLIRPEXZ0','1','D','30','444',NULL,'IBSH01_RULE_144_START_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('445','EBAMLIRPEXZ0','8','D','30','445',NULL,'IBSH01_RULE_144_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('446','EBAMLIRPEXZ0','1','D','30','446',NULL,'IBSH01_RULE_144_END_DATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('447','EBAMLIRPEXZ0','1','D','30','447',NULL,'IBSH01_DC_SECTION_16_IND_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('448','EBAMLIRPEXZ0','8','D','30','448',NULL,'IBSH01_Award_Level_Tax_Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('449','EBAMLIRPEXZ0','15','D','30','449',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('450','EBAMLIRPEXZ0','1','D','30','450',NULL,'Upd Award Level Tax Code YTD Tax Field 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('451','EBAMLIRPEXZ0','15','D','30','451',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('452','EBAMLIRPEXZ0','1','D','30','452',NULL,'Upd Award Level Tax Code YTD Tax Field 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('453','EBAMLIRPEXZ0','15','D','30','453',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('454','EBAMLIRPEXZ0','1','D','30','454',NULL,'Upd Award Level Tax Code YTD Tax Field 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('455','EBAMLIRPEXZ0','15','D','30','455',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('456','EBAMLIRPEXZ0','1','D','30','456',NULL,'Upd Award Level Tax Code YTD Tax Field 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('457','EBAMLIRPEXZ0','15','D','30','457',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('458','EBAMLIRPEXZ0','1','D','30','458',NULL,'Upd Award Level Tax Code YTD Tax Field 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('459','EBAMLIRPEXZ0','15','D','30','459',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('460','EBAMLIRPEXZ0','1','D','30','460',NULL,'Upd Award Level Tax Code YTD Tax Field 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('461','EBAMLIRPEXZ0','15','D','30','461',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('462','EBAMLIRPEXZ0','1','D','30','462',NULL,'Upd Award Level Tax Code YTD Tax Field 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('463','EBAMLIRPEXZ0','15','D','30','463',NULL,'IBSH01_Award_ Level_ Tax_ Code_YTD_Tax_Field8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('464','EBAMLIRPEXZ0','1','D','30','464',NULL,'Upd Award Level Tax Code YTD Tax Field 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('465','EBAMLIRPEXZ0','79','D','30','465',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('466','EBAMLIRPEXZ0','13','D','30','466',NULL,'IBSH01_ESPP_EMPLOYEE_ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('467','EBAMLIRPEXZ0','10','D','30','467',NULL,'IBSH01_ESPP_HOLDER_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('468','EBAMLIRPEXZ0','12','D','30','468',NULL,'IBSH01_ESPP_PAYROLL_ID',NULL,NULL,'"drvPayrollID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('469','EBAMLIRPEXZ0','3','D','30','469',NULL,'IBSH01_ESPP_PAYROLL_CURRENCY',NULL,NULL,'"drvPayrollCurrency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('470','EBAMLIRPEXZ0','1','D','30','470',NULL,'IBSH01_ESPP_KEY_OFFICER_STATUS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('471','EBAMLIRPEXZ0','15','D','30','471',NULL,'IBSH01_ESPP_ANNUAL_SALARY',NULL,NULL,'"drvAnnSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('472','EBAMLIRPEXZ0','5','D','30','472',NULL,'IBSH01_ESPP_CONTRACT_HOURS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('473','EBAMLIRPEXZ0','3','D','30','473',NULL,'IBSH01_ESPP_MAIL_TO_ADDRESS_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('474','EBAMLIRPEXZ0','20','D','30','474',NULL,'IBSH01_ESPP_EXTENDED_TIN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('475','EBAMLIRPEXZ0','3','D','30','475',NULL,'IBSH01_ESPP_HOST_COUNTRY_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('476','EBAMLIRPEXZ0','8','D','30','476',NULL,'IBSH01_ESPP_PAYROLL_BASE_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('477','EBAMLIRPEXZ0','3','D','30','477',NULL,'IBSH01_ESPP_ADDRESS_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('478','EBAMLIRPEXZ0','2','D','30','478',NULL,'IBSH01_ESPP_DIVISION_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('479','EBAMLIRPEXZ0','10','D','30','479',NULL,'IBSH01_ESPP_LOCATION_CODE',NULL,NULL,'"drvESPPLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('480','EBAMLIRPEXZ0','8','D','30','480',NULL,'IBSH01_CUSIP',NULL,NULL,'"drvCUSIP"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('481','EBAMLIRPEXZ0','4','D','30','481',NULL,'IBSH01_ESPP_INTERNAL_PLAN_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('482','EBAMLIRPEXZ0','8','D','30','482',NULL,'IBSH01_ADJ_HIRE_DATE_VEST',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('483','EBAMLIRPEXZ0','20','D','30','483',NULL,'IBSH01_WORK_COUNTY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('484','EBAMLIRPEXZ0','1','D','30','484',NULL,'IBSH01_AC_ADJ_HIRE_DATE_VEST_UPDATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('485','EBAMLIRPEXZ0','1','D','30','485',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('486','EBAMLIRPEXZ0','1','D','30','486',NULL,'IBSH01_AC_Service_Months_update_flag',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('487','EBAMLIRPEXZ0','5','D','30','487',NULL,'IBSH01_AC_Service_Months',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('488','EBAMLIRPEXZ0','8','D','30','488',NULL,'IBSH01_AC_RULE_OF_60_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('489','EBAMLIRPEXZ0','1','D','30','489',NULL,'IBSH01_AC_RULE_OF_60_DATE_UPDATE_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('490','EBAMLIRPEXZ0','3','D','30','490',NULL,'IBSH01_PAYROLL_NAME_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('491','EBAMLIRPEXZ0','3','D','30','491',NULL,'IBSH01_WORK_COUNTRY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('492','EBAMLIRPEXZ0','18','D','30','492',NULL,'IBSH01_WORK_FOREIGN_POSTAL_CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('493','EBAMLIRPEXZ0','2','D','30','493',NULL,'IBSH01_TRANSMISSION_SITE',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('494','EBAMLIRPEXZ0','10','D','30','494',NULL,'IBSH01_AC_USER_CODE4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('495','EBAMLIRPEXZ0','1','D','30','495',NULL,'IBSH01_AC_USER_CODE4_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('496','EBAMLIRPEXZ0','10','D','30','496',NULL,'IBSH01_AC_USER_CODE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('497','EBAMLIRPEXZ0','1','D','30','497',NULL,'IBSH01_AC_USER_CODE5_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('498','EBAMLIRPEXZ0','10','D','30','498',NULL,'IBSH01_AC_USER_CODE6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('499','EBAMLIRPEXZ0','1','D','30','499',NULL,'IBSH01_AC_USER_CODE6_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('500','EBAMLIRPEXZ0','10','D','30','500',NULL,'IBSH01_AC_USER_CODE7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('501','EBAMLIRPEXZ0','1','D','30','501',NULL,'IBSH01_AC_USER_CODE7_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('502','EBAMLIRPEXZ0','10','D','30','502',NULL,'IBSH01_AC_USER_CODE8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('503','EBAMLIRPEXZ0','1','D','30','503',NULL,'IBSH01_AC_USER_CODE8_FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('504','EBAMLIRPEXZ0','39','D','30','504',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAMLIRPEXZ0','6','D','40','1',NULL,'IB_RECORD_TYPE',NULL,NULL,'"IBCS01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAMLIRPEXZ0','10','D','40','2',NULL,'IB_COMPANY_ID',NULL,NULL,'"125003"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAMLIRPEXZ0','12','D','40','3',NULL,'IBCS01_PLAN_NUMBER',NULL,NULL,'"BCRX"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAMLIRPEXZ0','9','D','40','4',NULL,'IBCS01_SEARCH_KEY',NULL,NULL,'"drvSearchKey"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAMLIRPEXZ0','9','D','40','5',NULL,'IBCS01_PART_NUMBER',NULL,NULL,'"drvPartNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAMLIRPEXZ0','10','D','40','6',NULL,'IBCS01_PRODUCT_IDENTIFIER',NULL,NULL,'"drvProductIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAMLIRPEXZ0','10','D','40','7',NULL,'IBCS01_PLAN_IDENTIFIER',NULL,NULL,'"drvPlanIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAMLIRPEXZ0','8','D','40','8',NULL,'IBCS01_AWARD_DATE',NULL,NULL,'"drvAwardDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAMLIRPEXZ0','1','D','40','9',NULL,'IBCS01_ELIG_FLAG',NULL,NULL,'"drvEligFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAMLIRPEXZ0','15','D','40','10',NULL,'IBCS01_MIN_AMT_SECURITY',NULL,NULL,'"drvMin_AmtSecurity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAMLIRPEXZ0','15','D','40','11',NULL,'IBCS01_MAX_AMT_SECURITY',NULL,NULL,'"drvMax_AmtSecurity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAMLIRPEXZ0','15','D','40','12',NULL,'IBCS01_MIN_AMT_LOCAL',NULL,NULL,'"drvMin_AmtLocal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAMLIRPEXZ0','15','D','40','13',NULL,'IBCS01_MAX_AMT_LOCAL',NULL,NULL,'"drvMax_AmtLocal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAMLIRPEXZ0','5','D','40','14',NULL,'IBCS01_MIN_PCT_PAY',NULL,NULL,'"drvMin_PctPay"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAMLIRPEXZ0','5','D','40','15',NULL,'IBCS01_MAX_PCT_PAY',NULL,NULL,'"drvMax_PctPay"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAMLIRPEXZ0','15','D','40','16',NULL,'IBCS01_MIN_SHARES',NULL,NULL,'"drvMinShares"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAMLIRPEXZ0','15','D','40','17',NULL,'IBCS01_MAX_SHARES',NULL,NULL,'"drvMaxShares"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAMLIRPEXZ0','10','D','40','18',NULL,'IBCS01_EMPLOYEE_NUMBER',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAMLIRPEXZ0','13','D','40','19',NULL,'IBCS01_ESPP_EMPLOYEE_ID',NULL,NULL,'"drvEspp_EmployeeId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAMLIRPEXZ0','9','D','40','20',NULL,'IBCS01_TAX_IDENTIFICATION_NUMBER',NULL,NULL,'"drvTax_IdentificationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAMLIRPEXZ0','12','D','40','21',NULL,'IBCS01_ESPP_PAYROLL_ID',NULL,NULL,'"UKG"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAMLIRPEXZ0','1','D','40','22',NULL,'IBCS01_ESPP_PAYROLL_FREQ',NULL,NULL,'"drvEspp_PayrollFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAMLIRPEXZ0','3','D','40','23',NULL,'IBCS01_ESPP_PAYROLL_CURRENCY',NULL,NULL,'"drvEspp_PayrollCurrency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAMLIRPEXZ0','8','D','40','24',NULL,'IBCS01_CUSIP',NULL,NULL,'"drvIbcs01Cusip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAMLIRPEXZ0','15','D','40','25',NULL,'IBCS01_ESPP_ANNUAL_SALARY',NULL,NULL,'"drvEspp_AnnualSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAMLIRPEXZ0','2','D','40','26',NULL,'IBCS01_ESPP_TRANSMISSION_SITE',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBAMLIRPEXZ0','5252','D','40','27',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAMLIRPEXZ0','6','D','50','1',NULL,'IB_RECORD_TYPE',NULL,NULL,'"IBAC01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAMLIRPEXZ0','10','D','50','2',NULL,'IB_COMPANY_ID',NULL,NULL,'"125003"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAMLIRPEXZ0','9','D','50','3',NULL,'IBAC01_PLAN_NUMBER',NULL,NULL,'"XOP2127"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAMLIRPEXZ0','2','D','50','4',NULL,'IBAC01_TABLE_CODE',NULL,NULL,'"drvTableCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAMLIRPEXZ0','10','D','50','5',NULL,'IBAC01_CODE',NULL,NULL,'"drvCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAMLIRPEXZ0','30','D','50','6',NULL,'IBAC01_CODE_DESCRIPTION',NULL,NULL,'"drvCodeDesc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAMLIRPEXZ0','1','D','50','7',NULL,'IBAC01_CODE_DESCRIPTION_FLAG',NULL,NULL,'"drvCodeDescFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAMLIRPEXZ0','5432','D','50','8',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAMLIRPEXZ0','6','T','90','1',NULL,'IB_RECORD_TYPE',NULL,NULL,'"IBSH99"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAMLIRPEXZ0','10','T','90','2',NULL,'IB_COMPANY_ID',NULL,NULL,'"125003"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAMLIRPEXZ0','15','T','90','3',NULL,'IB_INBOUND_ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAMLIRPEXZ0','8','T','90','4',NULL,'IBSH99_RECORD_COUNT',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAMLIRPEXZ0','5461','T','90','5',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBAMLIRPEX_20231208.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BAML IRP&I','202310259','EMPEXPORT','ONDEM_XOE',NULL,'EBAMLIRPEX',NULL,NULL,NULL,'202310259','Oct 17 2023  1:09PM','Oct 17 2023  1:09PM','202310111',NULL,'','','202310111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BAML IRP&I-Sched','202310259','EMPEXPORT','SCH_EBAMLI',NULL,'EBAMLIRPEX',NULL,NULL,NULL,'202310259','Oct 17 2023  1:09PM','Oct 17 2023  1:09PM','202310111',NULL,'','','202310111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'BAML IRP&I-Test','202311169','EMPEXPORT','TEST_XOE',NULL,'EBAMLIRPEX',NULL,NULL,NULL,'202311169','Oct 17 2023  1:09PM','Oct 17 2023  1:09PM','202311021',NULL,'','','202311021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAMLIRPEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAMLIRPEX','D10','dbo.U_EBAMLIRPEX_drvTbl_IBSH',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAMLIRPEX','D20','dbo.U_EBAMLIRPEX_drvTbl_IBEN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAMLIRPEX','D30','dbo.U_EBAMLIRPEX_drvTbl_BSH01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAMLIRPEX','D40','dbo.U_EBAMLIRPEX_drvTbl_BCS01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAMLIRPEX','D50','dbo.U_EBAMLIRPEX_drvTbl_BAC01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAMLIRPEX','T90','dbo.U_EBAMLIRPEX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBAMLIRPEX
-----------

IF OBJECT_ID('U_dsi_BDM_EBAMLIRPEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBAMLIRPEX] (
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
-- Create table U_EBAMLIRPEX_Audit
-----------

IF OBJECT_ID('U_EBAMLIRPEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_Audit] (
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
-- Create table U_EBAMLIRPEX_AuditFields
-----------

IF OBJECT_ID('U_EBAMLIRPEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBAMLIRPEX_DedList
-----------

IF OBJECT_ID('U_EBAMLIRPEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBAMLIRPEX_drvTbl_BAC01
-----------

IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BAC01') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_drvTbl_BAC01] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(2) NOT NULL,
    [drvTableCode] varchar(2) NULL,
    [drvCode] varchar(15) NULL,
    [drvCodeDesc] varchar(40) NULL,
    [drvCodeDescFlag] varchar(1) NOT NULL
);

-----------
-- Create table U_EBAMLIRPEX_drvTbl_BCS01
-----------

IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BCS01') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_drvTbl_BCS01] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSearchKey] char(9) NULL,
    [drvPartNumber] char(11) NULL,
    [drvProductIdentifier] varchar(3) NULL,
    [drvPlanIdentifier] varchar(3) NULL,
    [drvAwardDate] varchar(34) NULL,
    [drvEligFlag] varchar(1) NOT NULL,
    [drvMin_AmtSecurity] varchar(24) NULL,
    [drvMax_AmtSecurity] varchar(24) NULL,
    [drvMin_AmtLocal] varchar(24) NULL,
    [drvMax_AmtLocal] varchar(24) NULL,
    [drvMin_PctPay] varchar(24) NULL,
    [drvMax_PctPay] varchar(24) NULL,
    [drvMinShares] varchar(24) NULL,
    [drvMaxShares] varchar(24) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvEspp_EmployeeId] char(9) NULL,
    [drvTax_IdentificationNumber] char(11) NULL,
    [drvEspp_PayrollFreq] varchar(1) NULL,
    [drvEspp_PayrollCurrency] varchar(3) NOT NULL,
    [drvIbcs01Cusip] varchar(8) NOT NULL,
    [drvEspp_AnnualSalary] varchar(25) NULL
);

-----------
-- Create table U_EBAMLIRPEX_drvTbl_BSH01
-----------

IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BSH01') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_drvTbl_BSH01] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPartNumber] varchar(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvSearchKey] char(9) NULL,
    [drvSSN] varchar(11) NULL,
    [drvTinType] varchar(1) NULL,
    [drvDOB] varchar(30) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(5) NULL,
    [drvAddressZipSuffix] varchar(4) NULL,
    [drvForeignZip] varchar(50) NULL,
    [drvCountry] varchar(3) NULL,
    [drvCountryofResidence] varchar(3) NULL,
    [drvCountryOfCitizenship] varchar(3) NULL,
    [drvTaxJurisdiction] varchar(1) NULL,
    [drvTaxcode] varchar(3) NULL,
    [drvPhone1] varchar(50) NULL,
    [drvPhone1Type] varchar(1) NULL,
    [drvMailCode] varchar(1) NULL,
    [drvPreferredCurrency] varchar(3) NOT NULL,
    [drvLanguagePrefCode] varchar(3) NULL,
    [drvEENonEEInd] varchar(1) NOT NULL,
    [drvEmploymentStatus] varchar(2) NOT NULL,
    [EecDateOfOriginalHire] varchar(30) NULL,
    [drvTermRehireDate] varchar(30) NULL,
    [drvTermID] varchar(8) NULL,
    [drvEmploymentStatusEffDate] varchar(30) NULL,
    [drvEmail] varchar(50) NULL,
    [drvFullName] varchar(8000) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvDOBFlag] varchar(1) NOT NULL,
    [drvAddressLine1Flag] varchar(1) NOT NULL,
    [drvAddressLine2Flag] varchar(1) NOT NULL,
    [drvAddressLine3Flag] varchar(1) NOT NULL,
    [drvAddressLine4Flag] varchar(1) NOT NULL,
    [drvAddressLine5Flag] varchar(1) NOT NULL,
    [drvCityFlag] varchar(1) NOT NULL,
    [drvStateFlag] varchar(1) NOT NULL,
    [drvZipFlag] varchar(1) NOT NULL,
    [drvZipSuffixFlag] varchar(1) NOT NULL,
    [drvCountryFlag] varchar(1) NOT NULL,
    [drvCountryofResidenceFlag] varchar(1) NOT NULL,
    [drvCitizenshipFlag] varchar(1) NOT NULL,
    [drvTaxJurisdictionFlag] varchar(1) NOT NULL,
    [drvBusEmailFlag] varchar(1) NOT NULL,
    [drvPhoneNumberFlag] varchar(1) NOT NULL,
    [drvMailCodeFlag] varchar(1) NOT NULL,
    [drvLanguagePrefCodeFlag] varchar(1) NOT NULL,
    [drvEENonEEIndFlag] varchar(1) NOT NULL,
    [drvRecentHireDateFlag] varchar(1) NOT NULL,
    [drvTermRehireDateFlag] varchar(1) NULL,
    [drvTerminationIDFlag] varchar(1) NULL,
    [drvPayrollFreq] varchar(1) NULL,
    [drvACOPTIONEEID] char(9) NULL,
    [drvACTitleCode] varchar(1) NOT NULL,
    [drvACOfficerCode] varchar(25) NULL,
    [drvACTaxCode] varchar(3) NULL,
    [drvACUserCode2] char(15) NULL,
    [drvACUsercode3] char(15) NULL,
    [drvACYTDFICAOAS] varchar(28) NULL,
    [drvACRegion] varchar(1) NULL,
    [drvACEELvlRestrictCode] varchar(3) NOT NULL,
    [drvACRehireCorrTermInd] varchar(1) NULL,
    [drvACYTDMedicare] varchar(28) NULL,
    [drvACYTDTaxField1] varchar(1) NOT NULL,
    [drvACYTDTaxField2] varchar(1) NOT NULL,
    [drvACYTDTaxField3] varchar(1) NOT NULL,
    [drvACYTDTaxField4] varchar(1) NOT NULL,
    [drvACYTDTaxField5] varchar(1) NOT NULL,
    [drvACYTDTaxField6] varchar(1) NOT NULL,
    [drvACYTDTaxField7] varchar(1) NOT NULL,
    [drvACYTDTaxField8] varchar(1) NOT NULL,
    [drvACGRANTTYPESTOFICAOAS] varchar(2) NULL,
    [drvACGRANTTYPESTMEDICARE] varchar(2) NULL,
    [drvAC_SUPPLEMENTAL_COMP] varchar(24) NULL,
    [drvAC_USER_TEXT_10] varchar(8000) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvPayrollID] varchar(3) NOT NULL,
    [drvPayrollCurrency] varchar(3) NOT NULL,
    [drvAnnSalary] varchar(25) NULL,
    [drvESPPLocationCode] varchar(2) NOT NULL,
    [drvCUSIP] varchar(8) NOT NULL
);

-----------
-- Create table U_EBAMLIRPEX_drvTbl_IBEN
-----------

IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_IBEN') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_drvTbl_IBEN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvProductType] varchar(4) NULL,
    [drvCaseNumber] varchar(1) NOT NULL,
    [drvPlanNumber] varchar(7) NOT NULL,
    [drvPartNumber] char(11) NULL,
    [drvNqnewhireIndicator] varchar(1) NOT NULL,
    [drvEmployeeId] char(9) NULL
);

-----------
-- Create table U_EBAMLIRPEX_drvTbl_IBSH
-----------

IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_IBSH') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_drvTbl_IBSH] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvProcessDate] varchar(30) NULL,
    [drvProcessTime] varchar(8000) NULL,
    [drvFileStatus] varchar(1) NOT NULL
);

-----------
-- Create table U_EBAMLIRPEX_EEList
-----------

IF OBJECT_ID('U_EBAMLIRPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBAMLIRPEX_File
-----------

IF OBJECT_ID('U_EBAMLIRPEX_File') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EBAMLIRPEX_PTaxHist
-----------

IF OBJECT_ID('U_EBAMLIRPEX_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthFICATaxAmtYTD] money NULL,
    [PthSupComp] money NULL,
    [PthMedicare] money NULL
);

-----------
-- Create table U_EBAMLIRPEX_Trailer
-----------

IF OBJECT_ID('U_EBAMLIRPEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EBAMLIRPEX_Trailer] (
    [drvRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAMLIRPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: BIOCRYST PHARMACEUTICALS INC

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 08/21/2023
Service Request Number: SR-2016-00012345

Purpose: BAML IRP&I

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBAMLIRPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBAMLIRPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBAMLIRPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBAMLIRPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBAMLIRPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAMLIRPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAMLIRPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAMLIRPEX', 'SCH_EBAMLI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBAMLIRPEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBAMLIRPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBAMLIRPEX';

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
    DELETE FROM dbo.U_EBAMLIRPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBAMLIRPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    ----==========================================
 --   -- Audit Section
 --   --==========================================
 --   -- Get data from audit fields table. Add fields here if auditing
 --   IF OBJECT_ID('U_EBAMLIRPEX_AuditFields','U')  IS NOT NULL
 --       DROP TABLE dbo.U_EBAMLIRPEX_AuditFields;
 --   CREATE TABLE dbo.U_EBAMLIRPEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

 --  -- INSERT INTO dbo.U_EBAMLIRPEX_AuditFields VALUES ('EmpComp','EecOrgLvl3');
    ----INSERT INTO dbo.U_EBAMLIRPEX_AuditFields VALUES ('OrgLevel','OrgGLSegment');
    ----INSERT INTO dbo.U_EBAMLIRPEX_AuditFields VALUES ('OrgLevel','OrgDesc');
    --INSERT INTO dbo.U_EBAMLIRPEX_AuditFields VALUES ('EmpComp','eecEmplStatus');    

 --   -- Create audit table based on fields defined above
 --   IF OBJECT_ID('U_EBAMLIRPEX_Audit','U')  IS NOT NULL
 --       DROP TABLE dbo.U_EBAMLIRPEX_Audit;
 --   SELECT 
 --       audEEID  = audKey1Value
 --       ,audCOID = audKey2Value
 --       ,audKey3 = audKey3Value
 --       ,audTableName
 --       ,audFieldName
 --       ,audAction
 --       ,audDateTime
 --       ,audOldValue
 --       ,audNewValue
 --       ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --    --,audUser2 = Case when  audtablename  = 'OrgLevel'  and audfieldname = 'OrgGLSegment' and audOldValue  IS NOT NULL and audNewValue  IS NOT NULL then audNewValue END
    --    --,audUser3 = Case when  audtablename  = 'EmpComp'  and audfieldname = 'EecOrgLvl3' and audOldValue  IS NOT NULL and audNewValue  IS NOT NULL then audNewValue END
    --    --,audOrgDesc = Case when  audtablename  = 'OrgLevel'  and audfieldname = 'OrgDesc' and audOldValue  IS NOT NULL and audNewValue  IS NOT NULL then audNewValue END
 --   INTO dbo.U_EBAMLIRPEX_Audit
 --   FROM dbo.vw_AuditData WITH (NOLOCK) 
 --   JOIN dbo.U_EBAMLIRPEX_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
 --   WHERE audDateTime BETWEEN @StartDate AND @EndDate    
 --      AND audAction <> 'DELETE';

 --   -- Create Index
 --   CREATE CLUSTERED INDEX CDX_U_EBAMLIRPEX_Audit ON dbo.U_EBAMLIRPEX_Audit (audEEID,audCOID);

  
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ESPP,ESPP1,ESPP2,ESPPS';

    IF OBJECT_ID('U_EBAMLIRPEX_DedList','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBAMLIRPEX_DedList
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
    -- Run BDM Module
    
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

  -----------------------------
    -- Working Table - YTD FICA Withholdings
    -----------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_PTaxHist','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_PTaxHist;
    SELECT DISTINCT
         PthEEID
        --,PrgPayDate             = MAX(PrgPayDate)
        -- YTD Payroll Amount/Hours
        ,PthFICATaxAmtYTD           = SUM(CASE WHEn PthTaxCode IN ('USFIT') THEn PthCurTaxAmt END)--MW Updated from using IN ('USSOCEE','USMEDEE')
        ,PthSupComp                    = SUM(CASE WHEN PthTaxCode IN ('USFIT') THEN PthCurSuppTaxAmt END)
        ,PthMedicare                = SUM(Case when PthTaxCode IN ('USMEDEE', 'USMEDER') THEN PthCurTaxAmt  END) 
    INTO dbo.U_EBAMLIRPEX_PTaxHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    GROUP BY PthEEID
    HAVING SUM(PthCurTaxAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBAMLIRPEX_drvTbl_IBSH
    ---------------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_IBSH','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_drvTbl_IBSH;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvProcessDate = CONVERT(VARCHAR, GETDATE(), 112) 
        ,drvProcessTime =  REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '')
        ,drvFileStatus = CASE WHEN @ExportCode = 'TEST_XOE' THEN 'T' ELSE 'L' END
    INTO dbo.U_EBAMLIRPEX_drvTbl_IBSH
    FROM dbo.U_dsi_Parameters
    WHERE FormatCode = @FormatCode;
    --FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAMLIRPEX_drvTbl_IBEN
    ---------------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_IBEN','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_drvTbl_IBEN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvProductType = 'AC'
        ,drvCaseNumber = ''  
        ,drvPlanNumber = 'XOP2127'  
        ,drvPartNumber = CASE WHEN EepAddressCountry = 'USA' THEN EepSSN END  
        ,drvNqnewhireIndicator = ''
        ,drvEmployeeId = EecEmpNo
    INTO dbo.U_EBAMLIRPEX_drvTbl_IBEN
    FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     LEFT JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmDedCode NOT IN ('ESPP','ESPP1','ESPP2','ESPPS')
         JOIN jobcode on jbcjobcode = eecjobcode
        WHERE EecEEType IN ('FEL', 'FTC', 'REG') AND (EecEmplstatus <> 'T' or ( EecEmplstatus = 'T' and Convert( varchar,EecDateofTermination,112) > = Convert(Varchar,(DateAdd(d, -180, GETDATE() )),112)))
         --AND ( CASE WHEN EepAddressCountry = 'USA' THEN ISNULL(EepSSN,'') END <> '' 
         --OR LEFT(EepSSN, 4) NOT IN  ('0000' , '1001') )
   
    Union

     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvProductType = CASE WHEN BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'ESPP' END
        ,drvCaseNumber = ''  
        ,drvPlanNumber = 'BCRX'  
        ,drvPartNumber = CASE WHEN EepAddressCountry = 'USA' THEN EepSSN END
        ,drvNqnewhireIndicator = ''
        ,drvEmployeeId = EecEmpNo
   -- INTO dbo.U_EBAMLIRPEX_drvTbl_IBEN
    FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS')
        JOIN jobcode on jbcjobcode = eecjobcode
       WHERE EecEEType IN ('FEL', 'FTC', 'REG') AND (EecEmplstatus <> 'T' or ( EecEmplstatus = 'T' and  Convert( varchar,EecDateofTermination,112) > = Convert(Varchar,(DateAdd(d, -180, GETDATE() )),112)))
        --AND ( CASE WHEN EepAddressCountry = 'USA' THEN ISNULL(EepSSN,'') END <> '' OR
        --LEFT(EepSSN, 4) NOT IN  ('0000' , '1001') )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAMLIRPEX_drvTbl_BSH01
    ---------------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BSH01','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_drvTbl_BSH01;
      SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartNumber = Case when EepAddressCountry = 'USA' THEN EepSSN ELSE '' END
        ,drvEmployeeNumber = EecEmpno
        ,drvSearchKey = EecEmpno
        ,drvSSN = CASE WHEN EepAddressCountry = 'USA' THEN EepSSN ELSE '' END
        ,drvTinType = Case when EepAddressCountry = 'USA' THEN 'S' 
                           when EepAddressCountry <> 'USA' THEN 'E'
                          END
        ,drvDOB = CONVERT(VARCHAR,EepDateOfBirth,112)
        ,drvAddressState = CASE WHEN EepAddressCountry = 'USA' THEN EepAddressState END
        ,drvAddressZip = CASE WHEN EepAddressCountry = 'USA' THEN LEFT(EepAddressZipCode,5) END
        ,drvAddressZipSuffix = CASE WHEN EepAddressCountry = 'USA' and Len(EepAddressZipCode) = 9 THEN Right(EepAddressZipCode, 4) End

        ,drvForeignZip = CASE WHEN EepAddressCountry <> 'USA' THEN EepAddressZipCode END

        ,drvCountry = LEFT(EepAddressCountry,3)
        ,drvCountryofResidence = LEFT(EepAddressCountry,3)
        ,drvCountryOfCitizenship = LEFT(EepAddressCountry,3)
        ,drvTaxJurisdiction = Case when EepAddressCountry <> 'USA' THEN '2' END

        ,drvTaxcode = Case when EepAddressCountry = 'USA' THEN 'USA'
                           When EepAddressCountry <> 'USA' THEN LEFT(EepAddressCountry,3)
                        END
        ,drvPhone1 = Case when efoPhoneNumber   IS NOT NULL THEN  efoPhoneNumber  END----Case when ISNULL(EecPhoneBusinessNumber, '') <> '' THEN EecPhoneBusinessNumber END

        ,drvPhone1Type = Case when efoPhoneNumber   IS NOT NULL THEN  'C' END --Case when ISNULL(EecPhoneBusinessNumber, '') <> '' THEN 'W' END
                            --Case when BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'W' END
        ,drvMailCode =  Case when EepAddressCountry = 'USA' THEN 'D'
                             when EepAddressCountry <> 'USA' THEN 'I'
                            END
        ,drvPreferredCurrency = 'USD'
        ,drvLanguagePrefCode = Case when EecLanguageCode  IS NOT NULL THEN
                                    Case when EecLanguageCode = 'EN' THEN 'ENG'
                                         when EecLanguageCode ='FR' THEN 'FRA'
                                         when EecLanguageCode = 'SP' THEN 'SPA'
                                        END
                                END

        ,drvEENonEEInd = '1'
        ,drvEmploymentStatus = Case when EecEmplStatus = 'T' THEN '05' Else '04' END
        ,EecDateOfOriginalHire = Convert(Varchar, EecDateOfOriginalHire,112)
        ,drvTermRehireDate = Case when EecEmplStatus = 'T' THEN CONVERT(VARCHAR,EecDateOfTermination, 112) END
        ,drvTermID = Case when EecEmplStatus = 'T' THEN
                            CASE when BdmChangeReason =  '210' OR EecTermReason = '203' THEN 'DEATH' 
                            when BdmChangeReason = '206' THEN 'DISABLED'
                            when BdmChangeReason ='208' OR EecTermReason = '202' THEN 'RETIRED'
                            ELSE 'TERM'
                                --when BdmChangeReason <> '210' OR EecTermReason <> '203' THEN 'TERM' --EecTermReason IN ('100','101','102','103','104','200','201','204','205','207','209','210','211','212','213')
                            END
                        END

        ,drvEmploymentStatusEffDate = Case  when EecEmplStatus = 'T' THEN CONVERT(VARCHAR,EecDateOfTermination, 112)
                                            when EecEmplStatus <> 'T' and EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR,EecDateOfLastHire , 112)                                           
                                            WHEn EecEmplStatus <> 'T' and (EecDateOfLastHire  IS NULL or (EecDateOfLastHire = EecDateOfOriginalHire)) THEN CONVERT(VARCHAR,EecDateOfOriginalHire , 112)
                                        END

        ,drvEmail = Case when EecEmplStatus = 'A' THEN EepAddressEmail else EepAddressEMailAlternate END
        ,drvFullName =UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(dbo.dsi_fnRemoveChars('.,/-',(EepNameLast+', '+EepNameFirst)), 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'è', 'e'), 'à', 'a'), 'ô', 'o'), 'ç', 'c'), 'ë', 'e'),'€','c'),'§','s'),'Ž','z'),'Å','A'), 'ö','o'),'ä','a'))
        ,drvAddressLine1 =UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'Ö', 'O'), 'ñ', 'n'), 'ü','u'), 'ô', 'o'), 'ë', 'e'), 'è', 'e'),'€','c'),'§','s'),'Ž','z'),'º','No'),'Å','A'), 'ö','o'),'ä','a'))
        ,drvAddressLine2 = CASE WHEN LEFT(eepaddresscountry, 3) = 'CAN' and ISNULL(EepAddressLine2, '') = '' then UPPER(EepAddressState) 
                                ELSE UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine2, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'Ö', 'O'), 'ñ', 'n'), 'ü','u'), 'ô', 'o'), 'ë', 'e'), 'è', 'e'),'€','c'),'§','s'),'Ž','z'),'º','No'),'Å','A'), 'ö','o'),'ä','a'))
                            END
        ,drvAddressLine3 =  CASE WHEN LEFT(eepaddresscountry, 3) = 'CAN' and ISNULL(EepAddressLine2, '') <> '' then UPPER(EepAddressState)  END
        ,drvAddressCity = UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressCity, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'Ö', 'O'), 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'è', 'e'), 'à', 'a'), 'ô', 'o'), 'ç', 'c'), 'ë', 'e'),'€','c'),'§','s'),'Ž','z'),'º','No'),'Å','A'), 'ö','o'),'ä','a')) 
        ,drvDOBFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END

        ,drvAddressLine1Flag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END

        ,drvAddressLine2Flag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvAddressLine3Flag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvAddressLine4Flag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvAddressLine5Flag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvCityFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvStateFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvZipFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvZipSuffixFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvCountryFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvCountryofResidenceFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvCitizenshipFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvTaxJurisdictionFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvBusEmailFlag = Case WHEN EepAddressEMail  IS NOT NULL then 'Y' ELSE 'N' END
        ,drvPhoneNumberFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvMailCodeFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvLanguagePrefCodeFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvEENonEEIndFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvRecentHireDateFlag = Case when BDMDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvTermRehireDateFlag = Case when EecEmplStatus = 'T' THEN 'Y' END
        ,drvTerminationIDFlag = Case when EecEmplStatus = 'T' THEN 'Y' END
        ,drvPayrollFreq = Case pgrPayFrequency 
                            WHEN 'S' THEN 'S'
                            WHEN 'B' THEN 'B'
                            WHEN 'M' THEN 'M'END

        ,drvACOPTIONEEID = EecEmpno
        ,drvACTitleCode = ''--CASE when EepAddressCountry = 'USA' THEN LEFT(EecStateSUI,2)
                             --  when EepAddressCountry <> 'USA' THEN LEFT(EepAddressCountry, 3)
                           -- END
        ,drvACOfficerCode = CASE WHEN EecIsHighlyComp = 'Y' THEN  JbcDesc END
        ,drvACTaxCode = CASE when EepAddressCountry = 'USA' THEN LEFT(EecStateSUI,2)
                               when EepAddressCountry <> 'USA' THEN LEFT(EepAddressCountry, 3)
                            END
        ,drvACUserCode2 = cmpGlSegment --Left(u2.OrgGLSegment, 3) --GL Segment (3 digits)-- MW updated 11/7/23 per layout update
        ,drvACUsercode3 = u3.OrgGLSegment --Cost Center (4 digits)
        ,drvACYTDFICAOAS = dbo.dsi_fnpadzero(Replace(PthFICATaxAmtYTD, '.', ''), 11, 0) + '0000' ---EetYTDGrossSupTaxWag
        ,drvACRegion = Case when EecUDField01  IS NOT NULL THEN '1' END
        ,drvACEELvlRestrictCode = Case when EecEmplStatus = 'T' AND (BdmChangeReason = '210' OR EecTermReason = '203') THEN '100' ELSE '163' END
        ,drvACRehireCorrTermInd = Case when EecDateOfLastHire <> EecDateOfOriginalHire AND (EecJobChangeReason = '101' OR EecHireSource = 'REHIRE') THEN 'R' END
        ,drvACYTDMedicare = dbo.dsi_fnpadzero(Replace(PthMedicare, '.', ''), 11, 0) + '0000' 
        ,drvACYTDTaxField1 = ''
        ,drvACYTDTaxField2 = ''
        ,drvACYTDTaxField3 = ''
        ,drvACYTDTaxField4 = ''
        ,drvACYTDTaxField5 = ''
        ,drvACYTDTaxField6 = ''
        ,drvACYTDTaxField7 = ''
        ,drvACYTDTaxField8 = ''
        ,drvACGRANTTYPESTOFICAOAS = Case when EepAddressCountry = 'USA' THEN 'EV'
                                        When EepAddressCountry <> 'USA' THEN '00'
                                    END
        ,drvACGRANTTYPESTMEDICARE = Case when EepAddressCountry = 'USA' THEN 'EV'
                                        When EepAddressCountry <> 'USA' THEN '00'
                                    END
                            
        ,drvAC_SUPPLEMENTAL_COMP = dbo.dsi_fnpadzero(Replace(PthSupComp, '.', ''), 15, 0) --+ '0000'  --Case when PthTaxCode IN ('USFIT)' THEN  SUM(PthCurSuppTaxAmt) for first percontrol to the latest for the year.-- 000000000123456 decimal is implied after 13th position for this field

        ,drvAC_USER_TEXT_10 = UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(dbo.dsi_fnRemoveChars('./-',(EepNameLast+', '+EepNameFirst)), 'ñ', 'n'), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'è', 'e'), 'à', 'a'), 'ô', 'o'), 'ç', 'c'), 'ë', 'e'),'€','c'),'§','s'),'Ž','z'))
        ,drvEmployeeID = EecEmpNo
        ,drvPayrollID = 'UKG'
        ,drvPayrollCurrency = 'USD'
        ,drvAnnSalary = dbo.dsi_fnpadzero(Replace(EecAnnSalary, '.', ''), 14, 0) + '0' --000000057234560
        ,drvESPPLocationCode = '01'
        ,drvCUSIP = '09058V10'
    INTO dbo.U_EBAMLIRPEX_drvTbl_BSH01
    FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.company WITH (NOLOCK) -- MW added 11/7/23
        ON cmpcoid = xcoid
   LEFT JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS')
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN dbo.OrgLevel U2  WITH(NOLOCK) 
        ON eecorglvl1 = U2.orgcode
         and Left(U2.OrgGLSegment, 3) IN ('110','115','125','510','210','215','220','225','230','235','240','245') 
    LEFT JOIN dbo.OrgLevel U3  WITH(NOLOCK) 
        ON eecorglvl1 = U3.orgcode
         and u3.OrgGLSegment IN ('1105','1110','1115','1205','1210','1215','1220','1225','1230','1235','1240','1305','3105',
                                    '3110','3115','3120','3130','3140','3205','3210','4105','4205','7105','7110','7205','7215','7305','7310','7315','7405','7410','7505','7506') 
    LEFT JOIN dbo.U_EBAMLIRPEX_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    JOIN jobcode on jbcjobcode = eecjobcode
 LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoeeid =Xeeid
        and efoPhoneType = 'CEL'
         WHERE EecEEType IN ('FEL', 'FTC', 'REG') AND (EecEmplstatus <> 'T' or ( EecEmplstatus = 'T' and  Convert( varchar,EecDateofTermination,112) > = Convert(Varchar,(DateAdd(d, -180, GETDATE() )),112)))
        -- AND ( CASE WHEN EepAddressCountry = 'USA' THEN ISNULL(EepSSN,'') END <> '' OR
        -- LEFT(EepSSN, 4) NOT IN  ('0000' , '1001') )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAMLIRPEX_drvTbl_BCS01
    ---------------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BCS01','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_drvTbl_BCS01;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSearchKey = Case when BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN EecEmpNo END
        ,drvPartNumber = EepSSN  --Case when EepAddressCountry = 'USA' THEN EepSSN END
        ,drvProductIdentifier = Case when EepAddressCountry = 'USA' THEN 'ES1'
                                        when EepAddressCountry <> 'USA' THEN 'ES2'
                                    END
        ,drvPlanIdentifier = Case when EepAddressCountry = 'USA' THEN 'ES1'
                                        when EepAddressCountry <> 'USA' THEN 'ES2'
                                    END
        ,drvAwardDate =    CASE --WHEN  CONVERT(VARCHAR,Getdate(),112) < (cast((Year(GetDate())) as varchar) +  '-12-01') THEN cast((Year(GetDate())) as varchar) +  '-08-01'
                                WHEN  CONVERT(VARCHAR,Getdate(),112) < =   (cast((Year(GetDate())-1) as varchar) +  '1201')and CONVERT(VARCHAR,Getdate(),112) < (cast((Year(GetDate())+1) as varchar) +  '0601') THEN cast((Year(GetDate())) as varchar) +  '0201'
                                WHEN  CONVERT(VARCHAR,Getdate(),112) > =  (cast((Year(GetDate())) as varchar) +  '0601') and CONVERT(VARCHAR,Getdate(),112) < (cast((Year(GetDate())) as varchar) +  '1201') THEN cast((Year(GetDate())+1) as varchar) +  '0801'
                                WHEN  CONVERT(VARCHAR,Getdate(),112) < =   (cast((Year(GetDate())+1) as varchar) +  '1201')and CONVERT(VARCHAR,Getdate(),112) < (cast((Year(GetDate())+1) as varchar) +  '0601') THEN cast((Year(GetDate())+1) as varchar) +  '0201'
                                WHEN  CONVERT(VARCHAR,Getdate(),112) > =  (cast((Year(GetDate())+1) as varchar) +  '0601') and CONVERT(VARCHAR,Getdate(),112) < (cast((Year(GetDate())+1) as varchar) +  '1201') THEN cast((Year(GetDate())+1) as varchar) +  '0801'
                            END
        


        ,drvEligFlag = Case when bdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') THEN 'Y' ELSE 'N' END
        ,drvMin_AmtSecurity = dbo.dsi_fnpadzero(0, 15,0)
        ,drvMax_AmtSecurity = dbo.dsi_fnpadzero(0, 15,0)
        ,drvMin_AmtLocal = dbo.dsi_fnpadzero(0, 15,0)
        ,drvMax_AmtLocal = dbo.dsi_fnpadzero(0, 15,0)
        ,drvMin_PctPay = dbo.dsi_fnpadzero(0, 5,0)
        ,drvMax_PctPay =dbo.dsi_fnpadzero(0, 5,0)
        ,drvMinShares = dbo.dsi_fnpadzero(0, 15,0)
        ,drvMaxShares = dbo.dsi_fnpadzero(0, 15,0)
        ,drvEmployeeNumber = EecEmpNo
        ,drvEspp_EmployeeId = EecEmpNo
        ,drvTax_IdentificationNumber = EepSSN  --Case when BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS') AND EepAddressCountry = 'USA' THEN EepSSN END
        ,drvEspp_PayrollFreq = Case pgrPayFrequency 
                                        WHEN 'S' THEN 'S'
                                        WHEN 'B' THEN 'B'
                                        WHEN 'M' THEN 'M'
                                    END
        ,drvEspp_PayrollCurrency = 'USD'
        ,drvIbcs01Cusip = '09058V10' 
        ,drvEspp_AnnualSalary = dbo.dsi_fnpadzero(Replace(EecAnnSalary, '.', ''), 14, 0)+ '0' 
      
    INTO dbo.U_EBAMLIRPEX_drvTbl_BCS01
    FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS')
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
       WHERE EecEEType IN ('FEL', 'FTC', 'REG')  AND (EecEmplstatus <> 'T' or ( EecEmplstatus = 'T' and Convert( varchar,EecDateofTermination,112) > = Convert(Varchar,(DateAdd(d, -180, GETDATE() )),112)))
         --AND ( CASE WHEN EepAddressCountry = 'USA' THEN ISNULL(EepSSN,'') END <> '' OR
         --LEFT(EepSSN, 4) NOT IN  ('0000' , '1001') )
         --and xeeid = 'DF1S9I000050'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBAMLIRPEX_drvTbl_BAC01
    ---------------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_drvTbl_BAC01','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_drvTbl_BAC01;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort =  '05'   --Left(u2.OrgGLSegment, 3) -- MW 12/5/23                       
              
        -- standard fields above and additional driver fields below 
        ,drvTableCode = CASE WHEN CmpGLSegment   IS NOT NULL  THEN '05' END --Left(u2.OrgGLSegment, 3) -- MW 12/5/23                           
                        
        ,drvCode = Case  when CmpGLSegment   IS NOT NULL   THEN CmpGLSegment  END  -- MW 12/5/23                            
                       
            --       CASE WHEN u2.OrgGLSegment  IS NOT NULL and audUser2  IS NOT NULL and u2.OrgGLSegment <> audUser2 THEN LEFT(audUser2, 3) 
                        --when EjhOrglvl3 <> EecOrgLvl3  and audUser3  IS NOT NULL THEN audUser3 
                        --END
        ,drvCodeDesc = CASE WHEN ISNULL(CmpGLSegment, '') <> ''     THEN cmpcompanyName  END -- MW 12/8/23 
            --       CASE WHEN u2.OrgGLSegment  IS NOT NULL and audUser2  IS NOT NULL and u2.OrgGLSegment <> audUser2 THEN audOrgDesc
                        --    when EjhOrglvl3 <> EecOrgLvl3  and audUser3  IS NOT NULL THEN audOrgDesc
                        --END
         --CASE WHEN LEFT(GLSegment,3) THEN AudNewValue (the new code description) for 05=IBSH01_AC_USER_CODE2 
                        --CASE WHEN EjhOrglvl3<>EecOrglvl3 (CostCenter) THEN AudNewValue (the new code description) for 06=IBSH01_AC_USER_CODE4
        ,drvCodeDescFlag = 'Y' -- per request MW updated to be hardcoded again 11/16/23 -- CASE WHEN EecDedGroupCode NOT In ( 'CONT', 'INTNO') THEN 'N' ELSE 'Y' END -- 'Y' -- MW updated 11/7/23 per layout update
   INTO dbo.U_EBAMLIRPEX_drvTbl_BAC01
    FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS')
    JOIN dbo.company WITH (NOLOCK) -- MW added 12/5/23
        ON cmpcoid = xcoid
    LEFT JOIN dbo.OrgLevel U2  WITH(NOLOCK) 
        ON eecorglvl1 = U2.orgcode
    --     and Left(U2.OrgGLSegment, 3) IN ('110','115','125','510','210','215','220','225','230','235','240','245') 
    LEFT JOIN dbo.OrgLevel U3  WITH(NOLOCK) 
        ON eecorglvl3 = U3.orgcode
         and u3.OrgGLSegment IN ('1105','1110','1115','1205','1210','1215','1220','1225','1230','1235','1240','1305','3105',
                                    '3110','3115','3120','3130','3140','3205','3210','4105','4205','7105','7110','7205','7215','7305','7310','7315','7405','7410','7505','7506') 
    LEFT JOIN dbo.U_EBAMLIRPEX_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN dbo.OrgLevel U4 WITH(NOLOCK) 
        ON CmpGLSegment = U4.orgcode
    LEFT JOIN (SELECT * FROM  (SELECT Ejheeid,ejhCoid, EjhOrglvl3, EjhJobEffDate,ROW_NUMBER() OVER(PARTITION BY ejheeid ORDER BY auditkey DESC) as Row_Num from dbo.EmphJob WITH (NOLOCK)
                where EjhOrglvl3  IS NOT NULL
            ) A WHERE Row_Num = 1) as User3
            ON User3.ejheeid = xeeid
            and User3.EjhCoid =XCOID
        --Left JOIN dbo.TmpAlloc TGL WITH(NOLOCK) 
        --ON TGL.Eeid = Xeeid
    --LEFT JOIN dbo.U_EBAMLIRPEX_Audit  WITH (NOLOCK)
    --    ON Audeeid = XEEID
    --    and AudCoid = XCOID
       WHERE EecEEType IN ('FEL', 'FTC', 'REG')  AND (EecEmplstatus <> 'T' or ( EecEmplstatus = 'T' and  Convert( varchar,EecDateofTermination,112) > = Convert(Varchar,(DateAdd(d, -180, GETDATE() )),112)))
        
         --AND ( CASE WHEN EepAddressCountry = 'USA' THEN ISNULL(EepSSN,'') END <> '' OR
         --LEFT(EepSSN, 4) NOT IN  ('0000' , '1001') )
         --and xeeid = 'DF1S9I000050'    

  UNION


SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort =  '06'
                         
        -- standard fields above and additional driver fields below 
        ,drvTableCode = CASE WHEN  CmpGLSegment   IS NOT NULL and ISNULL(EecOrglvl1,'') <> ''   THEN '06'  END--Left(u2.OrgGLSegment, 3)
                        
        ,drvCode = CASE WHEN  CmpGLSegment   IS NOT NULL and ISNULL(EecOrglvl1,'') <> ''   THEN EecOrglvl1  END
            --       CASE WHEN u2.OrgGLSegment  IS NOT NULL and audUser2  IS NOT NULL and u2.OrgGLSegment <> audUser2 THEN LEFT(audUser2, 3) 
                        --when EjhOrglvl3 <> EecOrgLvl3  and audUser3  IS NOT NULL THEN audUser3 
                        --END
        ,drvCodeDesc = CASE WHEN  CmpGLSegment   IS NOT NULL and ISNULL(EecOrglvl1,'') <> ''   THEN  U2.orgdesc END
            --       CASE WHEN u2.OrgGLSegment  IS NOT NULL and audUser2  IS NOT NULL and u2.OrgGLSegment <> audUser2 THEN audOrgDesc
                        --    when EjhOrglvl3 <> EecOrgLvl3  and audUser3  IS NOT NULL THEN audOrgDesc
                        --END
         --CASE WHEN LEFT(GLSegment,3) THEN AudNewValue (the new code description) for 05=IBSH01_AC_USER_CODE2 
                        --CASE WHEN EjhOrglvl3<>EecOrglvl3 (CostCenter) THEN AudNewValue (the new code description) for 06=IBSH01_AC_USER_CODE4
        ,drvCodeDescFlag = 'Y' -- per request MW updated to be hardcoded again 11/16/23 -- CASE WHEN EecDedGroupCode NOT In ( 'CONT', 'INTNO') THEN 'N' ELSE 'Y' END -- 'Y' -- MW updated 11/7/23 per layout update
    --INTO dbo.U_EBAMLIRPEX_drvTbl_BAC01
    FROM dbo.U_EBAMLIRPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EBAMLIRPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and BdmDedCode IN ('ESPP','ESPP1','ESPP2','ESPPS')
    JOIN dbo.company WITH (NOLOCK) -- MW added 12/5/23
        ON cmpcoid = xcoid
    LEFT JOIN dbo.OrgLevel U2  WITH(NOLOCK) 
        ON eecorglvl1 = U2.orgcode
    --     and Left(U2.OrgGLSegment, 3) IN ('110','115','125','510','210','215','220','225','230','235','240','245') 
    LEFT JOIN dbo.OrgLevel U3  WITH(NOLOCK) 
        ON eecorglvl3 = U3.orgcode
         and u3.OrgGLSegment IN ('1105','1110','1115','1205','1210','1215','1220','1225','1230','1235','1240','1305','3105',
                                    '3110','3115','3120','3130','3140','3205','3210','4105','4205','7105','7110','7205','7215','7305','7310','7315','7405','7410','7505','7506') 
    LEFT JOIN dbo.U_EBAMLIRPEX_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN dbo.OrgLevel U4 WITH(NOLOCK) 
        ON CmpGLSegment = U4.orgcode
    LEFT JOIN (SELECT * FROM  (SELECT Ejheeid,ejhCoid, EjhOrglvl3, EjhJobEffDate,ROW_NUMBER() OVER(PARTITION BY ejheeid ORDER BY auditkey DESC) as Row_Num from dbo.EmphJob WITH (NOLOCK)
                where EjhOrglvl3  IS NOT NULL
            ) A WHERE Row_Num = 1) as User3
            ON User3.ejheeid = xeeid
            and User3.EjhCoid =XCOID
        --Left JOIN dbo.TmpAlloc TGL WITH(NOLOCK) 
        --ON TGL.Eeid = Xeeid
    --LEFT JOIN dbo.U_EBAMLIRPEX_Audit  WITH (NOLOCK)
    --    ON Audeeid = XEEID
    --    and AudCoid = XCOID
       WHERE EecEEType IN ('FEL', 'FTC', 'REG')  AND (EecEmplstatus <> 'T' or ( EecEmplstatus = 'T' and  Convert( varchar,EecDateofTermination,112) > = Convert(Varchar,(DateAdd(d, -180, GETDATE() )),112)))
        
         --AND ( CASE WHEN EepAddressCountry = 'USA' THEN ISNULL(EepSSN,'') END <> '' OR
         --LEFT(EepSSN, 4) NOT IN  ('0000' , '1001') )
         --and xeeid = 'DF1S9I000050'

        

        
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBAMLIRPEX_Trailer','U')  IS NOT NULL
        DROP TABLE dbo.U_EBAMLIRPEX_Trailer;
    SELECT DISTINCT
         drvRecordCount = ((Select count(*) from dbo.U_EBAMLIRPEX_drvTbl_IBEN) + (Select count(*) from dbo.U_EBAMLIRPEX_drvTbl_BSH01) + 2)
    INTO dbo.U_EBAMLIRPEX_Trailer
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
ALTER VIEW dbo.dsi_vwEBAMLIRPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAMLIRPEX_File (NOLOCK)
    ORDER BY  InitialSort,RIGHT(RecordSet,2), SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBAMLIRPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202310241'
       ,expStartPerControl     = '202310241'
       ,expLastEndPerControl   = '202311079'
       ,expEndPerControl       = '202311079'
WHERE expFormatCode = 'EBAMLIRPEX' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBAMLIRPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAMLIRPEX_File (NOLOCK)
    ORDER BY  InitialSort,RIGHT(RecordSet,2), SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBAMLIRPEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBAMLIRPEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBAMLIRPEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAMLIRPEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBAMLIRPEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAMLIRPEX', 'UseFileName', 'V', 'Y'


-- End ripout