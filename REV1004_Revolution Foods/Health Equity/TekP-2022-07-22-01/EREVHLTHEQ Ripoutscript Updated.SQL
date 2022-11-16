/**********************************************************************************

EREVHLTHEQ: Health Equity Export

FormatCode:     EREVHLTHEQ
Project:        Health Equity Export
Client ID:      REV1004
Date/time:      2022-11-15 14:45:22.820
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB02
Database:       ULTIPRO_WPREVO
Web Filename:   REV1004_88DE5_EEHISTORY_EREVHLTHEQ_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EREVHLTHEQ_SavePath') IS NOT NULL DROP TABLE dbo.U_EREVHLTHEQ_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EREVHLTHEQ'


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
WHERE FormatCode = 'EREVHLTHEQ'
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
WHERE ExpFormatCode = 'EREVHLTHEQ'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EREVHLTHEQ')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EREVHLTHEQ'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EREVHLTHEQ'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EREVHLTHEQ'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EREVHLTHEQ'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EREVHLTHEQ'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EREVHLTHEQ'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EREVHLTHEQ'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EREVHLTHEQ'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EREVHLTHEQ'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEREVHLTHEQ_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREVHLTHEQ_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREVHLTHEQ') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREVHLTHEQ];
GO
IF OBJECT_ID('U_EREVHLTHEQ_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_PEarHist];
GO
IF OBJECT_ID('U_EREVHLTHEQ_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_PDedHist];
GO
IF OBJECT_ID('U_EREVHLTHEQ_File') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_File];
GO
IF OBJECT_ID('U_EREVHLTHEQ_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_EEList];
GO
IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_PRO') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_drvTbl_PRO];
GO
IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_ENR') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_drvTbl_ENR];
GO
IF OBJECT_ID('U_EREVHLTHEQ_DedList') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_DedList];
GO
IF OBJECT_ID('U_EREVHLTHEQ_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_AuditFields];
GO
IF OBJECT_ID('U_EREVHLTHEQ_Audit') IS NOT NULL DROP TABLE [dbo].[U_EREVHLTHEQ_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EREVHLTHEQ') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EREVHLTHEQ];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREVHLTHEQ','Health Equity Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EREVHLTHEQZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREVHLTHEQZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"PRO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREVHLTHEQZ0','50','D','10','2',NULL,'Group ID',NULL,NULL,'"drvGroupID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREVHLTHEQZ0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREVHLTHEQZ0','50','D','10','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREVHLTHEQZ0','50','D','10','5',NULL,'Change to Unique ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREVHLTHEQZ0','50','D','10','6',NULL,'Old Unique ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREVHLTHEQZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREVHLTHEQZ0','50','D','10','8',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREVHLTHEQZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREVHLTHEQZ0','50','D','10','10',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREVHLTHEQZ0','50','D','10','11',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREVHLTHEQZ0','50','D','10','12',NULL,'Street Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREVHLTHEQZ0','50','D','10','13',NULL,'Street Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREVHLTHEQZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREVHLTHEQZ0','50','D','10','15',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREVHLTHEQZ0','50','D','10','16',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EREVHLTHEQZ0','50','D','10','17',NULL,'Zip Code Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EREVHLTHEQZ0','50','D','10','18',NULL,'Work ZIP Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EREVHLTHEQZ0','50','D','10','19',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EREVHLTHEQZ0','50','D','10','20',NULL,'Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EREVHLTHEQZ0','50','D','10','21',NULL,'Phone Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EREVHLTHEQZ0','50','D','10','22',NULL,'Employment Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EREVHLTHEQZ0','50','D','10','23',NULL,'Employment Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EREVHLTHEQZ0','50','D','10','24',NULL,'Benefit Group Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EREVHLTHEQZ0','50','D','10','25',NULL,'Benefit Group Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EREVHLTHEQZ0','50','D','10','26',NULL,'Payroll Group Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EREVHLTHEQZ0','50','D','10','27',NULL,'Payroll Group Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EREVHLTHEQZ0','50','D','10','28',NULL,'Location Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EREVHLTHEQZ0','50','D','10','29',NULL,'Company Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EREVHLTHEQZ0','50','D','10','30',NULL,'For Future Use 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EREVHLTHEQZ0','50','D','10','31',NULL,'For Future Use 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EREVHLTHEQZ0','50','D','10','32',NULL,'Bank Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EREVHLTHEQZ0','50','D','10','33',NULL,'Bank Account Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EREVHLTHEQZ0','50','D','10','34',NULL,'Bank Routing Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EREVHLTHEQZ0','50','D','10','35',NULL,'Bank Account Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EREVHLTHEQZ0','50','D','10','36',NULL,'Payment Preference',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EREVHLTHEQZ0','50','D','10','37',NULL,'Commuter Program Benefit Group Code',NULL,NULL,'"drvCommuterProgramBenefit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREVHLTHEQZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"ENR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREVHLTHEQZ0','50','D','20','2',NULL,'Group ID',NULL,NULL,'"drvGroupID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREVHLTHEQZ0','50','D','20','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREVHLTHEQZ0','50','D','20','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREVHLTHEQZ0','50','D','20','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREVHLTHEQZ0','50','D','20','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREVHLTHEQZ0','50','D','20','7',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREVHLTHEQZ0','50','D','20','8',NULL,'Plan Action Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREVHLTHEQZ0','50','D','20','9',NULL,'Election Amount',NULL,NULL,'"drvElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREVHLTHEQZ0','50','D','20','10',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREVHLTHEQZ0','50','D','20','11',NULL,'Coverage End Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREVHLTHEQZ0','50','D','20','12',NULL,'HSA-Compatible FSA Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREVHLTHEQZ0','50','D','20','13',NULL,'HSA-Compatible FSA Option Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREVHLTHEQZ0','51','D','20','14',NULL,'Standard FSA Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREVHLTHEQZ0','52','D','20','15',NULL,'Standard FSA Option Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREVHLTHEQZ0','53','D','20','16',NULL,'Deductible Requirement Met',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EREVHLTHEQZ0','54','D','20','17',NULL,'Automatic Health Plan Claims',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EREVHLTHEQZ0','55','D','20','18',NULL,'Terms & Conditions Accept Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EREVHLTHEQZ0','56','D','20','19',NULL,'Terms & Conditions Timestamp',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EREVHLTHEQZ0','57','D','20','20',NULL,'Custodian Statement Preference',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EREVHLTHEQZ0','58','D','20','21',NULL,'Period of Non-Coverage Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EREVHLTHEQZ0','59','D','20','22',NULL,'Period of Non-Coverage End Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EREVHLTHEQZ0','60','D','20','23',NULL,'Period of Non-Coverage Reason',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EREVHLTHEQZ0','61','D','20','24',NULL,'HDHP Coverage Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EREVHLTHEQZ0','62','D','20','25',NULL,'HDHP Coverage Calendar Year',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EREVHLTHEQZ0','63','D','20','26',NULL,'HRA Coverage Tier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EREVHLTHEQZ0','64','D','20','27',NULL,'For Internal Use1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EREVHLTHEQZ0','65','D','20','28',NULL,'For Internal Use2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EREVHLTHEQZ0','66','D','20','29',NULL,'FSA/HRA Post Deductible Met',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EREVHLTHEQ_20221115.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202211079','EMPEXPORT','OEACTIVE','Nov  8 2022 12:00AM','EREVHLTHEQ',NULL,NULL,NULL,'202211079','Nov  7 2022 12:00AM','Dec 30 1899 12:00AM','202211071',NULL,'','','202211071',dbo.fn_GetTimedKey(),NULL,'us3mWaREV1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202211079','EMPEXPORT','OEPASSIVE',NULL,'EREVHLTHEQ',NULL,NULL,NULL,'202211079','Nov  7 2022  3:51PM','Nov  7 2022  3:51PM','202211071',NULL,'','','202211071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity Export','202211079','EMPEXPORT','ONDEM_XOE',NULL,'EREVHLTHEQ',NULL,NULL,NULL,'202211079','Nov  7 2022  3:51PM','Nov  7 2022  3:51PM','202211071',NULL,'','','202211071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity Export-Sched','202211079','EMPEXPORT','SCH_EREVHL',NULL,'EREVHLTHEQ',NULL,NULL,NULL,'202211079','Nov  7 2022  3:51PM','Nov  7 2022  3:51PM','202211071',NULL,'','','202211071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Health Equity Export-Test','202211079','EMPEXPORT','TEST_XOE','Nov  8 2022 12:00AM','EREVHLTHEQ',NULL,NULL,NULL,'202211079','Nov  7 2022 12:00AM','Dec 30 1899 12:00AM','202210281',NULL,'','','202210281',dbo.fn_GetTimedKey(),NULL,'us3mWaREV1004',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREVHLTHEQ','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREVHLTHEQ','D10','dbo.U_EREVHLTHEQ_drvTbl_PRO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREVHLTHEQ','D20','dbo.U_EREVHLTHEQ_drvTbl_ENR',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EREVHLTHEQ
-----------

IF OBJECT_ID('U_dsi_BDM_EREVHLTHEQ') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EREVHLTHEQ] (
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
-- Create table U_EREVHLTHEQ_Audit
-----------

IF OBJECT_ID('U_EREVHLTHEQ_Audit') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_Audit] (
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
-- Create table U_EREVHLTHEQ_AuditFields
-----------

IF OBJECT_ID('U_EREVHLTHEQ_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EREVHLTHEQ_DedList
-----------

IF OBJECT_ID('U_EREVHLTHEQ_DedList') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EREVHLTHEQ_drvTbl_ENR
-----------

IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_ENR') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_drvTbl_ENR] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvGroupID] varchar(5) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvUniqueId] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvPlanCode] varchar(9) NULL,
    [drvElectionAmount] nvarchar(4000) NULL,
    [drvCovEffectiveDate] char(10) NULL
);

-----------
-- Create table U_EREVHLTHEQ_drvTbl_PRO
-----------

IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_PRO') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_drvTbl_PRO] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvGroupID] varchar(5) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvUniqueId] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NOT NULL,
    [drvBirthDate] char(10) NULL,
    [drvGender] varchar(1) NULL,
    [drvAddressLine1] varchar(30) NULL,
    [drvAddressLine2] varchar(266) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] char(10) NULL,
    [drvTerminationDate] char(10) NULL,
    [drvCommuterProgramBenefit] varchar(1) NOT NULL
);

-----------
-- Create table U_EREVHLTHEQ_EEList
-----------

IF OBJECT_ID('U_EREVHLTHEQ_EEList') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EREVHLTHEQ_File
-----------

IF OBJECT_ID('U_EREVHLTHEQ_File') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EREVHLTHEQ_PDedHist
-----------

IF OBJECT_ID('U_EREVHLTHEQ_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSAH1] numeric NULL,
    [PdhFSAD1] numeric NULL
);

-----------
-- Create table U_EREVHLTHEQ_PEarHist
-----------

IF OBJECT_ID('U_EREVHLTHEQ_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EREVHLTHEQ_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREVHLTHEQ]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Revolution Foods

Created By: Marie Waters
Business Analyst: Cheryl Petitti\Katherine Ricca
Create Date: 11/07/2022
Service Request Number: TekP-2022-07-22-01

Purpose: Health Equity Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREVHLTHEQ';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREVHLTHEQ';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREVHLTHEQ';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREVHLTHEQ';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREVHLTHEQ' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVHLTHEQ', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVHLTHEQ', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVHLTHEQ', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVHLTHEQ', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREVHLTHEQ', 'SCH_EREVHL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EREVHLTHEQ';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREVHLTHEQ', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREVHLTHEQ';

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
    DELETE FROM dbo.U_EREVHLTHEQ_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREVHLTHEQ_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EREVHLTHEQ_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_AuditFields;
    CREATE TABLE dbo.U_EREVHLTHEQ_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_EREVHLTHEQ_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EREVHLTHEQ_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EREVHLTHEQ_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_Audit;
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
    INTO dbo.U_EREVHLTHEQ_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EREVHLTHEQ_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN Dateadd(d, -30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EREVHLTHEQ_Audit ON dbo.U_EREVHLTHEQ_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EREVHLTHEQ_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EREVHLTHEQ_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAH1,FSAD1,TRC,TRP';

    IF OBJECT_ID('U_EREVHLTHEQ_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EREVHLTHEQ_DedList
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
    IF OBJECT_ID('U_EREVHLTHEQ_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFSAH1     = SUM(CASE WHEN PdhDedCode IN ('FSAH1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSAD1     = SUM(CASE WHEN PdhDedCode IN ('FSAD1') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EREVHLTHEQ_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EREVHLTHEQ_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EREVHLTHEQ_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_PEarHist;
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
    INTO dbo.U_EREVHLTHEQ_PEarHist
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
    -- DETAIL RECORD - U_EREVHLTHEQ_drvTbl_PRO
    ---------------------------------
    IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_PRO','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_drvTbl_PRO;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = '1'
        -- standard fields above and additional driver fields below
        ,drvGroupID = '60423'
        ,drvEmployeeID = EecEmpNo
        ,drvUniqueId = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = ''-- LEFT(EepNameMiddle,1)
        ,drvBirthDate = CONVERT (CHAR(10),EepDateOfBirth, 101)
        ,drvGender = CASE WHEN EepGender IN ( 'M', 'F') THEN EepGender ELSE 'U' END
        ,drvAddressLine1 = Left(EepAddressLine1, 30)
        ,drvAddressLine2 = CASE When LEN(EepAddressLine1) > 30 THEN  (SUBSTRING(EepAddressLine1,30, 10) + ' ' +  EepAddressLine1) ELSE EepAddressLine2 END
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Left(EepAddressZipCode, 5)
        ,drvEmailAddress = CASE WHEN ISNULL(eepaddressemailalternate, '' ) <> '' THEN eepaddressemailalternate ELSE EepAddressEMail END
        ,drvHireDate = CONVERT(CHAR(10),EecDateOfLastHire, 101)  --CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN CONVERT(CHAR(10),EecDateOfLastHire, 101) END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN CONVERT (CHAR(10),EecDateOfTermination, 101) END
        ,drvCommuterProgramBenefit = CASE WHEN BdmDedCode in ('TRC', 'TRP')  THEN 'Y' ELSE 'N' END
    INTO dbo.U_EREVHLTHEQ_drvTbl_PRO
    FROM dbo.U_EREVHLTHEQ_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EREVHLTHEQ WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EREVHLTHEQ_PDedHist WITH (NOLOCK)
        ON Pdheeid = xeeid
    LEFT JOIN dbo.U_EREVHLTHEQ_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        WHERE EecEEtype = 'REG' and EecFullTimeOrPartTime = 'F'
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and ((FORMAT(PdhFSAH1 , '0.00') <> '0.00' or FORMAT(PdhFSAD1 , '0.00') <> '0.00') or audFieldName = 'EecDateOfTermination' and audDateTime  BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate)))

    ---------------------------------
    -- DETAIL RECORD - U_EREVHLTHEQ_drvTbl_ENR
    ---------------------------------
    IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_ENR','U') IS NOT NULL
        DROP TABLE dbo.U_EREVHLTHEQ_drvTbl_ENR;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = '2'
        -- standard fields above and additional driver fields below
        ,drvGroupID = '60423'
        ,drvEmployeeID = EecEmpNo
        ,drvUniqueId = eepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvPlanCode = CASE WHEN Bdmdedcode = 'FSAH1' THEN 'HCFSA2023'
                            WHEN Bdmdedcode = 'FSAD1' THEN 'DCFSA2023'
                            END
        ,drvElectionAmount = CASE WHEN Bdmdedcode  IN ( 'FSAH1','FSAD1') THEN Format(BdmEEGoalAmt, '0.00') END
        ,drvCovEffectiveDate = CASE WHEN Bdmdedcode  IN ( 'FSAH1','FSAD1') THEN CONVERT (CHAR(10), dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '01/01/2023'), 101) END
    INTO dbo.U_EREVHLTHEQ_drvTbl_ENR
    FROM dbo.U_EREVHLTHEQ_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EREVHLTHEQ WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EREVHLTHEQ_PDedHist WITH (NOLOCK)
        ON Pdheeid = xeeid
    LEFT JOIN dbo.U_EREVHLTHEQ_Audit WITH (NOLOCK)
        ON audEEID = xEEID
     WHERE EecEEtype = 'REG' and EecFullTimeOrPartTime = 'F'
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and ((FORMAT(PdhFSAH1 , '0.00') <> '0.00' or FORMAT(PdhFSAD1 , '0.00') <> '0.00') or audFieldName = 'EecDateOfTermination' and audDateTime  BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate)))

    ;
 --   ---------------------------------
 --   -- DETAIL RECORD - U_EREVHLTHEQ_drvTbl_FND
 --   ---------------------------------
 --   IF OBJECT_ID('U_EREVHLTHEQ_drvTbl_FND','U') IS NOT NULL
 --       DROP TABLE dbo.U_EREVHLTHEQ_drvTbl_FND;
 --   SELECT DISTINCT
 --        drvEEID = xEEID
 --       ,drvCoID = xCoID
 --       ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
 --       ,drvInitialSort = eepSSN
 --       ,drvSubsort = '3'
 --       -- standard fields above and additional driver fields below
 --       ,drvGroupID = '60423'
 --       ,drvEmployeeID = EecEmpNo
 --       ,drvUniqueID = eepSSN
 --       ,drvLastName = EepNameLast
 --       ,drvFirstName = EepNameFirst
 --       ,drvPlanCode = CASE WHEN Bdmdedcode = 'FSAH1' THEN 'HCFSA2023'
 --                           WHEN Bdmdedcode = 'FSAD1' THEN 'DCFSA2023'
 --                           END
 --       ,drvPrePayrollDeduction = CASE WHEN Bdmdedcode = 'FSAH1' and FORMAT(PdhFSAH1 , '0.00') > '0.00' THEN FORMAT(PdhFSAH1 , '0.00')
 --                                      WHEN Bdmdedcode = 'FSAH1' and FORMAT(PdhFSAH1 , '0.00') <= '0.00' THEN FORMAT(PdhFSAH1 , '-0.00')
 --                                      WHEN Bdmdedcode = 'FSAD1' and FORMAT(PdhFSAD1 , '0.00') > '0.00' THEN FORMAT(PdhFSAD1 , '0.00')
 --                                      WHEN Bdmdedcode = 'FSAD1' and FORMAT(PdhFSAD1 , '0.00') < =  '0.00' THEN FORMAT(PdhFSAD1 , '-0.00')
 --                                  END
 --       ,dnvFundingDate = CASE WHEN Bdmdedcode  IN ( 'FSAH1','FSAD1') THEN CONVERT (CHAR(10), dateadd( d, -2, PrgPayDate), 101) END
 --   INTO dbo.U_EREVHLTHEQ_drvTbl_FND
 --   FROM dbo.U_EREVHLTHEQ_EEList WITH (NOLOCK)
 --   JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
 --       ON EecEEID = xEEID 
 --       AND EecCoID = xCoID
 --   JOIN dbo.EmpPers WITH (NOLOCK)
 --       ON EepEEID = xEEID
 --   JOIN dbo.U_dsi_BDM_EREVHLTHEQ WITH (NOLOCK)
 --       ON BdmEEID = xEEID 
 --       AND BdmCoID = xCoID
 --   LEFT JOIN dbo.U_EREVHLTHEQ_PDedHist WITH (NOLOCK)
 --       ON Pdheeid = xeeid
 --   LEFT JOIN dbo.U_EREVHLTHEQ_PEarHist WITH (NOLOCK)
 --       ON PehEEID = XEEID
    --LEFT JOIN dbo.U_EREVHLTHEQ_Audit WITH (NOLOCK)
    --    ON audEEID = xEEID
    -- WHERE EecEEtype = 'REG' and EecFullTimeOrPartTime = 'F'
    --    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and ((FORMAT(PdhFSAH1 , '0.00') <> '0.00' or FORMAT(PdhFSAD1 , '0.00') <> '0.00') or audFieldName = 'EecDateOfTermination' and audDateTime  BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate)))

 --   ;

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
ALTER VIEW dbo.dsi_vwEREVHLTHEQ_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREVHLTHEQ_File (NOLOCK)
    ORDER BY InitialSort, SubSort, RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREVHLTHEQ%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209301'
       ,expStartPerControl     = '202209301'
       ,expLastEndPerControl   = '202211079'
       ,expEndPerControl       = '202211079'
WHERE expFormatCode = 'EREVHLTHEQ';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEREVHLTHEQ_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREVHLTHEQ_File (NOLOCK)
    ORDER BY InitialSort, SubSort, RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EREVHLTHEQ' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EREVHLTHEQ'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EREVHLTHEQ'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREVHLTHEQ', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EREVHLTHEQ', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREVHLTHEQ', 'UseFileName', 'V', 'Y'


-- End ripout