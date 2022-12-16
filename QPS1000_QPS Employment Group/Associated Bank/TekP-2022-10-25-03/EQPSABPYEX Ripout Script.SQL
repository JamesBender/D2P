/**********************************************************************************

EQPSABEEXP: Assoc Bank FSA and HSA Enrollment Export

FormatCode:     EQPSABEEXP
Project:        Assoc Bank FSA and HSA Enrollment Export
Client ID:      QPS1000
Date/time:      2022-12-16 12:44:30.217
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB03
Database:       ULTIPRO_WPQPS
Web Filename:   QPS1000_6TRXF_EEHISTORY_EQPSABEEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQPSABEEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EQPSABEEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQPSABEEXP'


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
WHERE FormatCode = 'EQPSABEEXP'
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
WHERE ExpFormatCode = 'EQPSABEEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQPSABEEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQPSABEEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQPSABEEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQPSABEEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQPSABEEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQPSABEEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQPSABEEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQPSABEEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQPSABEEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQPSABEEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQPSABEEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQPSABEEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQPSABEEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQPSABEEXP];
GO
IF OBJECT_ID('U_EQPSABEEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_Trailer];
GO
IF OBJECT_ID('U_EQPSABEEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_Header];
GO
IF OBJECT_ID('U_EQPSABEEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_File];
GO
IF OBJECT_ID('U_EQPSABEEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_EEList];
GO
IF OBJECT_ID('U_EQPSABEEXP_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_drvTbl_PT];
GO
IF OBJECT_ID('U_EQPSABEEXP_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_drvTbl_EN];
GO
IF OBJECT_ID('U_EQPSABEEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_DedList];
GO
IF OBJECT_ID('U_EQPSABEEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_AuditFields];
GO
IF OBJECT_ID('U_EQPSABEEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EQPSABEEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EQPSABEEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQPSABEEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQPSABEEXP','Assoc Bank FSA and HSA Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EQPSABEEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABEEXPZ0','2','H','01','1',NULL,'Record Type ',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABEEXPZ0','3','H','01','2',NULL,'Admin Code ',NULL,NULL,'"ABK"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABEEXPZ0','6','H','01','3',NULL,'Employer Code ',NULL,NULL,'"Q5P7S2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABEEXPZ0','1','H','01','4',NULL,'Synchronize Flag ',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABEEXPZ0','8','H','01','5',NULL,'Created Date ',NULL,NULL,'"drvCreatedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABEEXPZ0','6','H','01','6',NULL,'Created Time ',NULL,NULL,'"drvCreatedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABEEXPZ0','6','H','01','7',NULL,'File Version ',NULL,NULL,'"3.4"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABEEXPZ0','2','D','10','1',NULL,'Record Type ',NULL,NULL,'"PT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABEEXPZ0','50','D','10','2',NULL,'Participant File Import ID ',NULL,NULL,'"drvPartFileID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABEEXPZ0','20','D','10','3',NULL,'Employer Employee ID ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABEEXPZ0','15','D','10','4',NULL,'Employee Number ',NULL,NULL,'"drvEmployeeNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABEEXPZ0','30','D','10','5',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABEEXPZ0','30','D','10','6',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABEEXPZ0','1','D','10','7',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQPSABEEXPZ0','1','D','10','8',NULL,'Gender ',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQPSABEEXPZ0','1','D','10','9',NULL,'Marital Status ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQPSABEEXPZ0','50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQPSABEEXPZ0','8','D','10','11',NULL,'Date of Birth ',NULL,NULL,'"drvDateofBirth"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQPSABEEXPZ0','9','D','10','12',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQPSABEEXPZ0','50','D','10','13',NULL,'Address Line 1 ',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQPSABEEXPZ0','50','D','10','14',NULL,'Address Line 2 ',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQPSABEEXPZ0','50','D','10','15',NULL,'Address Line 3 ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQPSABEEXPZ0','50','D','10','16',NULL,'Address Line 4 ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQPSABEEXPZ0','30','D','10','17',NULL,'City ',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQPSABEEXPZ0','2','D','10','18',NULL,'State ',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQPSABEEXPZ0','10','D','10','19',NULL,'Zip Code ',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQPSABEEXPZ0','2','D','10','20',NULL,'Country ',NULL,NULL,'"US"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQPSABEEXPZ0','10','D','10','21',NULL,'Home Phone ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQPSABEEXPZ0','10','D','10','22',NULL,'Work Phone ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQPSABEEXPZ0','6','D','10','23',NULL,'Work Phone Extension ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQPSABEEXPZ0','125','D','10','24',NULL,'Email Address ',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQPSABEEXPZ0','100','D','10','25',NULL,'Username ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQPSABEEXPZ0','100','D','10','26',NULL,'Password ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQPSABEEXPZ0','8','D','10','27',NULL,'Hire Date ',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQPSABEEXPZ0','100','D','10','28',NULL,'Division ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQPSABEEXPZ0','2','D','10','29',NULL,'Hours Per Week ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQPSABEEXPZ0','100','D','10','30',NULL,'Employee Class ',NULL,NULL,'"All Employees"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQPSABEEXPZ0','50','D','10','31',NULL,'Payroll Frequency ',NULL,NULL,'"Weekly"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQPSABEEXPZ0','8','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQPSABEEXPZ0','20','D','10','33',NULL,'Participant Status',NULL,NULL,'"drvPartStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQPSABEEXPZ0','8','D','10','34',NULL,'Status Effective Date',NULL,NULL,'"drvStatusEffDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQPSABEEXPZ0','1','D','10','35',NULL,'Hold Payroll Deductions ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQPSABEEXPZ0','1','D','10','36',NULL,'Hold Employer Contributions ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQPSABEEXPZ0','1','D','10','37',NULL,'Incur Services ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQPSABEEXPZ0','8','D','10','38',NULL,'Final Payroll Process Date ',NULL,NULL,'"drvFinalPayrollProccessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQPSABEEXPZ0','8','D','10','39',NULL,'Final Contribution Process Date ',NULL,NULL,'"drvFinalContribProccessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQPSABEEXPZ0','100','D','10','40',NULL,'HSA Custodian ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQPSABEEXPZ0','1','D','10','41',NULL,'Medicare Beneficiary ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQPSABEEXPZ0','12','D','10','42',NULL,'Medicare ID ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQPSABEEXPZ0','50','D','10','43',NULL,'Exchange Integration ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EQPSABEEXPZ0','100','D','10','44',NULL,'Reporting Hierarchy Level1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EQPSABEEXPZ0','100','D','10','45',NULL,'Reporting Hierarchy Level2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EQPSABEEXPZ0','100','D','10','46',NULL,'Reporting Hierarchy Level3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EQPSABEEXPZ0','100','D','10','47',NULL,'Reporting Hierarchy Level4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EQPSABEEXPZ0','20','D','10','48',NULL,'CDD_Citizenship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EQPSABEEXPZ0','2','D','10','49',NULL,'CDD_Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EQPSABEEXPZ0','20','D','10','50',NULL,'CDD_Employment Status',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EQPSABEEXPZ0','30','D','10','51',NULL,'CDD_Employer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EQPSABEEXPZ0','30','D','10','52',NULL,'CDD_Job Title',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EQPSABEEXPZ0','8','D','10','53',NULL,'Class Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EQPSABEEXPZ0','20','D','10','54',NULL,'ID Identification Type',NULL,NULL,'"drvIDType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EQPSABEEXPZ0','30','D','10','55',NULL,'ID Number ',NULL,NULL,'"DefIDNum"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EQPSABEEXPZ0','2','D','10','56',NULL,'ID Issuing State ',NULL,NULL,'"WI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EQPSABEEXPZ0','50','D','10','57',NULL,'ID Issuer ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EQPSABEEXPZ0','8','D','10','58',NULL,'ID Issue Date ',NULL,NULL,'"10012017"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EQPSABEEXPZ0','8','D','10','59',NULL,'ID Expiration Date ',NULL,NULL,'"01012050"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABEEXPZ0','2','D','20','1',NULL,'Record Type ',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABEEXPZ0','50','D','20','2',NULL,'Participant File Import ID ',NULL,NULL,'"drvPartFileID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABEEXPZ0','50','D','20','3',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABEEXPZ0','8','D','20','4',NULL,'Enrollment Effective Date ',NULL,NULL,'"drvEnrollmentEffDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABEEXPZ0','8','D','20','5',NULL,'Participant Election Amount ',NULL,NULL,'"drvParticipantElectAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABEEXPZ0','8','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL,'"drvEnrollmentTermDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQPSABEEXPZ0','10','D','20','7',NULL,'Employer Contribution Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQPSABEEXPZ0','8','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQPSABEEXPZ0','1','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQPSABEEXPZ0','30','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQPSABEEXPZ0','1','D','20','11',NULL,'Enrolled in Claims Exchg',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQPSABEEXPZ0','8','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'"drvElecAmtIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQPSABEEXPZ0','6','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQPSABEEXPZ0','8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQPSABEEXPZ0','8','D','20','15',NULL,'Terms & Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQPSABEEXPZ0','6','D','20','16',NULL,'DateTerms & Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQPSABEEXPZ0','6','D','20','17',NULL,'TimeTerms & Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQPSABEEXPZ0','8','D','20','18',NULL,'Change Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQPSABEEXPZ0','2','T','90','1',NULL,'Record Type ',NULL,NULL,'"FF "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQPSABEEXPZ0','20','T','90','2',NULL,'Record Count ',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQPSABEEXPZ0','3','T','90','3',NULL,'Admin Code ',NULL,NULL,'"ABK"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQPSABEEXPZ0','6','T','90','4',NULL,'Employer Code ',NULL,NULL,'"Q5P7S2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQPSABEEXPZ0','8','T','90','5',NULL,'Created Date ',NULL,NULL,'"drvCreatedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQPSABEEXPZ0','6','T','90','6',NULL,'Created Time ',NULL,NULL,'"drvCreatedTime"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQPSABEEXP_20221216.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202212029','EMPEXPORT','OEACTIVE',NULL,'EQPSABEEXP',NULL,NULL,NULL,'202212029','Dec  2 2022  9:54AM','Dec  2 2022  9:54AM','202212021',NULL,'','','202212021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202212029','EMPEXPORT','OEPASSIVE',NULL,'EQPSABEEXP',NULL,NULL,NULL,'202212029','Dec  2 2022  9:54AM','Dec  2 2022  9:54AM','202212021',NULL,'','','202212021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assoc Bank FSA and HSA Enrollm','202212029','EMPEXPORT','ONDEM_XOE',NULL,'EQPSABEEXP',NULL,NULL,NULL,'202212029','Dec  2 2022  9:54AM','Dec  2 2022  9:54AM','202212021',NULL,'','','202212021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assoc Bank FSA and HSA E-Sched','202212029','EMPEXPORT','SCH_EQPSAB',NULL,'EQPSABEEXP',NULL,NULL,NULL,'202212029','Dec  2 2022  9:54AM','Dec  2 2022  9:54AM','202212021',NULL,'','','202212021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Assoc Bank FSA and HSA E-Test','202212029','EMPEXPORT','TEST_XOE',NULL,'EQPSABEEXP',NULL,NULL,NULL,'202212029','Dec  2 2022  9:54AM','Dec  2 2022  9:54AM','202212021',NULL,'','','202212021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQPSABEEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABEEXP','H01','dbo.U_EQPSABEEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABEEXP','D10','dbo.U_EQPSABEEXP_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABEEXP','D20','dbo.U_EQPSABEEXP_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQPSABEEXP','T90','dbo.U_EQPSABEEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQPSABEEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EQPSABEEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQPSABEEXP] (
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
-- Create table U_EQPSABEEXP_Audit
-----------

IF OBJECT_ID('U_EQPSABEEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_Audit] (
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
-- Create table U_EQPSABEEXP_AuditFields
-----------

IF OBJECT_ID('U_EQPSABEEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EQPSABEEXP_DedList
-----------

IF OBJECT_ID('U_EQPSABEEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQPSABEEXP_drvTbl_EN
-----------

IF OBJECT_ID('U_EQPSABEEXP_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvPartFileID] char(11) NULL,
    [drvPlanName] varchar(46) NULL,
    [drvEnrollmentEffDate] varchar(8000) NULL,
    [drvParticipantElectAmt] nvarchar(4000) NULL,
    [drvEnrollmentTermDate] varchar(8000) NULL,
    [drvElecAmtIndicator] varchar(8) NULL
);

-----------
-- Create table U_EQPSABEEXP_drvTbl_PT
-----------

IF OBJECT_ID('U_EQPSABEEXP_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvPartFileID] char(11) NULL,
    [drvEmployeeNo] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvHireDate] varchar(8000) NULL,
    [drvPartStatus] varchar(10) NOT NULL,
    [drvStatusEffDate] varchar(8000) NULL,
    [drvFinalPayrollProccessDate] varchar(8000) NULL,
    [drvFinalContribProccessDate] varchar(8000) NULL,
    [drvIDType] varchar(19) NOT NULL
);

-----------
-- Create table U_EQPSABEEXP_EEList
-----------

IF OBJECT_ID('U_EQPSABEEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQPSABEEXP_File
-----------

IF OBJECT_ID('U_EQPSABEEXP_File') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EQPSABEEXP_Header
-----------

IF OBJECT_ID('U_EQPSABEEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_Header] (
    [drvCreatedDate] varchar(8) NULL,
    [drvCreatedTime] varchar(6) NULL
);

-----------
-- Create table U_EQPSABEEXP_Trailer
-----------

IF OBJECT_ID('U_EQPSABEEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EQPSABEEXP_Trailer] (
    [drvRecordCount] varchar(20) NULL,
    [drvCreatedDate] varchar(8) NULL,
    [drvCreatedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQPSABEEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: QPS Employment

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 12/02/2022
Service Request Number: TekP-2022-10-25-04

Purpose: Assoc Bank FSA and HSA Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQPSABEEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQPSABEEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQPSABEEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQPSABEEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQPSABEEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABEEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABEEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABEEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABEEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQPSABEEXP', 'SCH_EQPSAB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQPSABEEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQPSABEEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(6);

    -- Set FormatCode
    SELECT @FormatCode = 'EQPSABEEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = REPLACE(CONVERT (CHAR(10),GETDATE(), 101),'/','')
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(10), GETDATE(), 108),':',SPACE(0))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EQPSABEEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQPSABEEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EQPSABEEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_AuditFields;
    CREATE TABLE dbo.U_EQPSABEEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EQPSABEEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EQPSABEEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_Audit;
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
    INTO dbo.U_EQPSABEEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EQPSABEEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EQPSABEEXP_Audit ON dbo.U_EQPSABEEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EQPSABEEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EQPSABEEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSACF,HSACI,HSAF,HSAI,HSAIC,LFSA,FSAD,FSA,HEFSA';

    IF OBJECT_ID('U_EQPSABEEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQPSABEEXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABEEXP_drvTbl_PT
    ---------------------------------
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABEEXP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EQPSABEEXP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvPartFileID = eepSSN
        ,drvEmployeeNo = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvDateofBirth = REPLACE(CONVERT (CHAR(10), EepDateOfBirth, 101),'/','')
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvEmail = EepAddressEMail
        ,drvHireDate =  REPLACE(CONVERT (CHAR(10),EecDateofLastHire , 101),'/','')
        ,drvPartStatus = CASE WHEN eecemplstatus = 'T' Then 'Terminated' Else 'Active' ENd
        ,drvStatusEffDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN EecDateofTermination Else EecDateofLastHire END, 101),'/','')
        ,drvFinalPayrollProccessDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN DateAdd(d,30,EecDateofTermination) END, 101),'/','')
        ,drvFinalContribProccessDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN DateAdd(d,30,EecDateofTermination) END, 101),'/','')
        ,drvIDType = 'US Driver''s License'
    INTO dbo.U_EQPSABEEXP_drvTbl_PT
    FROM dbo.U_EQPSABEEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQPSABEEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     LEFT JOIN dbo.U_EQPSABEEXP_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        Where eecEEtype <> 'TES'
        And  EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audDateTime BETWEEN @StartDate AND @EndDate)
  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQPSABEEXP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EQPSABEEXP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvPartFileID = Eepssn
        ,drvPlanName = CASE WHEN Bdmdedcode  IN ('FSA', 'HEFSA') THEN 'Flexible Spending Account Plan'
                            WHEN Bdmdedcode  = 'FSAD' THEN 'Dependent Care'
                            WHEN Bdmdedcode  = 'LFSA' THEN 'Flexible Spending Account Plan Limited Purpose'
                            WHEN Bdmdedcode  IN ( 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC') THEN 'Health Savings Account'
                        END

        ,drvEnrollmentEffDate = REPLACE(CONVERT (CHAR(10),CASE WHEN  Bdmdedcode  IN (  'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC','LFSA','FSAD','FSA', 'HEFSA') THEN Bdmbenstartdate END, 101),'/','')
        ,drvParticipantElectAmt = CASE WHEN Bdmdedcode  IN ( 'FSA', 'HEFSA', 'FSAD', 'LFSA' ) THEN FORMAT(BdmEEGoalAmt, '0.00') else '0.00' END
        ,drvEnrollmentTermDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus <> 'T' and Bdmdedcode  IN ('FSA', 'HEFSA', 'FSAD', 'LFSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC' ) THEN Bdmbenstopdate END, 101),'/','')
        ,drvElecAmtIndicator = CASE WHEN  Bdmdedcode  IN ( 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC' ) THEN 'PlanYear' END
    INTO dbo.U_EQPSABEEXP_drvTbl_EN
    FROM dbo.U_EQPSABEEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EQPSABEEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
       -- AND Bdmdedcode IN ( 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAIC','LFSA','FSAD','FSA', 'HEFSA')
     LEFT JOIN dbo.U_EQPSABEEXP_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
      Where eecEEtype <> 'TES'
        And  EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audDateTime BETWEEN @StartDate AND @EndDate)
  
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EQPSABEEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_Header;
    SELECT DISTINCT
         drvCreatedDate = @RunDate
        ,drvCreatedTime = @RunTime
    INTO dbo.U_EQPSABEEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EQPSABEEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EQPSABEEXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = CAST( (Select (Select count(*) from dbo.U_EQPSABEEXP_drvTbl_PT) + (select count(*) from dbo.U_EQPSABEEXP_drvTbl_EN)) as varchar(20))
        ,drvCreatedDate = @RunDate
        ,drvCreatedTime = @RunTime
    INTO dbo.U_EQPSABEEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEQPSABEEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQPSABEEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EQPSABEEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202211251'
       ,expStartPerControl     = '202211251'
       ,expLastEndPerControl   = '202212029'
       ,expEndPerControl       = '202212029'
WHERE expFormatCode = 'EQPSABEEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEQPSABEEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EQPSABEEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQPSABEEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQPSABEEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQPSABEEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQPSABEEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQPSABEEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQPSABEEXP', 'UseFileName', 'V', 'Y'


-- End ripout