/**********************************************************************************

EMICWEXFSA: WEX FSA HSA DEP

FormatCode:     EMICWEXFSA
Project:        WEX FSA HSA DEP
Client ID:      MIC1008
Date/time:      2022-03-08 13:34:17.590
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB02
Database:       ULTIPRO_WPMICPT
Web Filename:   MIC1008_57A0E_EEHISTORY_EMICWEXFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMICWEXFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EMICWEXFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMICWEXFSA'


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
WHERE FormatCode = 'EMICWEXFSA'
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
WHERE ExpFormatCode = 'EMICWEXFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMICWEXFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMICWEXFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMICWEXFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMICWEXFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMICWEXFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMICWEXFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMICWEXFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMICWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMICWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMICWEXFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMICWEXFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMICWEXFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMICWEXFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMICWEXFSA];
GO
IF OBJECT_ID('U_EMICWEXFSA_PT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_PT_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_PDedHist];
GO
IF OBJECT_ID('U_EMICWEXFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_File];
GO
IF OBJECT_ID('U_EMICWEXFSA_FH_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_FH_hdrTbl];
GO
IF OBJECT_ID('U_EMICWEXFSA_FF_ftrTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_FF_ftrTbl];
GO
IF OBJECT_ID('U_EMICWEXFSA_EN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_EN_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_EEList];
GO
IF OBJECT_ID('U_EMICWEXFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_DedList];
GO
IF OBJECT_ID('U_EMICWEXFSA_CT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_CT_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_AuditFields];
GO
IF OBJECT_ID('U_EMICWEXFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMICWEXFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMICWEXFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMICWEXFSA','WEX FSA HSA DEP','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EMICWEXFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXFSAZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXFSAZ0','50','H','01','2',NULL,'Administrator Code',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXFSAZ0','50','H','01','3',NULL,'Employer Code',NULL,NULL,'"drvEmployerCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXFSAZ0','50','H','01','4',NULL,'Synchronize Flag',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXFSAZ0','50','H','01','5',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXFSAZ0','50','H','01','6',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UDHMS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXFSAZ0','50','H','01','7',NULL,'File Version',NULL,NULL,'"drvFileVersion"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXFSAZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"PT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXFSAZ0','50','D','10','2',NULL,'Participant File Import ID',NULL,NULL,'"drvParticipantID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXFSAZ0','50','D','10','3',NULL,'Employer Employee ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXFSAZ0','50','D','10','4',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXFSAZ0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXFSAZ0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXFSAZ0','50','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMICWEXFSAZ0','50','D','10','8',NULL,'Gender',NULL,NULL,'"drvGenderGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMICWEXFSAZ0','50','D','10','9',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMICWEXFSAZ0','50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMICWEXFSAZ0','50','D','10','11',NULL,'Date Of Birth',NULL,NULL,'"drvDateBirth"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMICWEXFSAZ0','50','D','10','12',NULL,'SSN',NULL,NULL,'"drvSSNSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMICWEXFSAZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMICWEXFSAZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMICWEXFSAZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMICWEXFSAZ0','50','D','10','16',NULL,'Address Line 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMICWEXFSAZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drvCityCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMICWEXFSAZ0','50','D','10','18',NULL,'State',NULL,NULL,'"drvStateState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMICWEXFSAZ0','50','D','10','19',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMICWEXFSAZ0','50','D','10','20',NULL,'Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMICWEXFSAZ0','50','D','10','21',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMICWEXFSAZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMICWEXFSAZ0','50','D','10','23',NULL,'Work Phone Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMICWEXFSAZ0','50','D','10','24',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMICWEXFSAZ0','50','D','10','25',NULL,'Username',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMICWEXFSAZ0','50','D','10','26',NULL,'Password',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMICWEXFSAZ0','50','D','10','27',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMICWEXFSAZ0','50','D','10','28',NULL,'Division',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMICWEXFSAZ0','50','D','10','29',NULL,'Hours Per Week',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMICWEXFSAZ0','50','D','10','30',NULL,'Employee Class',NULL,NULL,'"E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMICWEXFSAZ0','50','D','10','31',NULL,'Payroll Frequency',NULL,NULL,'"Payroll"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMICWEXFSAZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMICWEXFSAZ0','50','D','10','33',NULL,'Participant Status',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMICWEXFSAZ0','50','D','10','34',NULL,'Status Effective Date',NULL,NULL,'"drvStatusDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMICWEXFSAZ0','50','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMICWEXFSAZ0','50','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMICWEXFSAZ0','50','D','10','37',NULL,'Incur Services',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMICWEXFSAZ0','50','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'"drvFinalPayProcDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMICWEXFSAZ0','50','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'"drvFinalContribProcDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMICWEXFSAZ0','50','D','10','40',NULL,'HAS Custodian',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMICWEXFSAZ0','50','D','10','41',NULL,'Medicare Beneficiary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMICWEXFSAZ0','50','D','10','42',NULL,'Medicare ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMICWEXFSAZ0','50','D','10','43',NULL,'Exchange Integration ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMICWEXFSAZ0','50','D','10','44',NULL,'Reporting Hierarchy Level 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMICWEXFSAZ0','50','D','10','45',NULL,'Reporting Hierarchy Level 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMICWEXFSAZ0','50','D','10','46',NULL,'Reporting Hierarchy Level 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMICWEXFSAZ0','50','D','10','47',NULL,'Reporting Hierarchy Level 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMICWEXFSAZ0','50','D','10','48',NULL,'CDD_Citizenship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMICWEXFSAZ0','50','D','10','49',NULL,'CDD_Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMICWEXFSAZ0','50','D','10','50',NULL,'CDD_EmploymentStatus',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMICWEXFSAZ0','50','D','10','51',NULL,'CDD_Employer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMICWEXFSAZ0','50','D','10','52',NULL,'CDD_JobTitle',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMICWEXFSAZ0','50','D','10','53',NULL,'Class Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMICWEXFSAZ0','50','D','10','54',NULL,'ID_Identification Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMICWEXFSAZ0','50','D','10','55',NULL,'ID_Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMICWEXFSAZ0','50','D','10','56',NULL,'ID_IssuingState',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMICWEXFSAZ0','50','D','10','57',NULL,'ID_Issuer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMICWEXFSAZ0','50','D','10','58',NULL,'ID_IssueDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMICWEXFSAZ0','50','D','10','59',NULL,'ID_ExpirationDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMICWEXFSAZ0','50','D','10','60',NULL,'Mobile Carrier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMICWEXFSAZ0','50','D','10','61',NULL,'Mobile Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMICWEXFSAZ0','50','D','10','62',NULL,'Time Zone',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXFSAZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXFSAZ0','50','D','20','2',NULL,'Participant File Import ID',NULL,NULL,'"drvParticipantID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXFSAZ0','50','D','20','3',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXFSAZ0','50','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL,'"drvEnrollEffDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXFSAZ0','50','D','20','5',NULL,'Participant Election Amount',NULL,NULL,'"drvParticipantAmount"','(''UNT2''''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXFSAZ0','50','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL,'"drvEnrollTermDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXFSAZ0','50','D','20','7',NULL,'Employer Contribution Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMICWEXFSAZ0','50','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMICWEXFSAZ0','50','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMICWEXFSAZ0','50','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMICWEXFSAZ0','50','D','20','11',NULL,'Enrolled In Claims Exchange',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMICWEXFSAZ0','50','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'"drvElectionIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMICWEXFSAZ0','50','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL,'"drvHDHPLevel"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMICWEXFSAZ0','50','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMICWEXFSAZ0','50','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMICWEXFSAZ0','50','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMICWEXFSAZ0','50','D','20','17',NULL,'Time Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMICWEXFSAZ0','50','D','20','18',NULL,'Change Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMICWEXFSAZ0','50','D','20','19',NULL,'Spend Down',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXFSAZ0','50','D','30','1',NULL,'Record Type',NULL,NULL,'"CT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXFSAZ0','50','D','30','2',NULL,'Participant File Import Id',NULL,NULL,'"drvParticipantId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXFSAZ0','50','D','30','3',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXFSAZ0','50','D','30','4',NULL,'Contribution Date',NULL,NULL,'"drvContributionDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXFSAZ0','50','D','30','5',NULL,'Contribution Description',NULL,NULL,'"drvContributionDescription"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXFSAZ0','50','D','30','6',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UNT2''''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXFSAZ0','50','D','30','7',NULL,'Amount Type',NULL,NULL,'"Actual"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMICWEXFSAZ0','50','D','30','8',NULL,'Tax Year',NULL,NULL,'"drvTaxYear"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXFSAZ0','50','T','90','1',NULL,'Record Type',NULL,NULL,'"FF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXFSAZ0','50','T','90','2',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXFSAZ0','50','T','90','3',NULL,'Administrator Code',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXFSAZ0','50','T','90','4',NULL,'Employer Code',NULL,NULL,'"drvEmployerCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXFSAZ0','50','T','90','5',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXFSAZ0','50','T','90','6',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UDHMS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMICWEXFSA_20220308.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202201299','EMPEXPORT','OEACTIVE',NULL,'EMICWEXFSA',NULL,NULL,NULL,'202201299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202201299','EMPEXPORT','OEPASSIVE',NULL,'EMICWEXFSA',NULL,NULL,NULL,'202201299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA HSA DEP','202201299','EMPEXPORT','ONDEM_XOE',NULL,'EMICWEXFSA',NULL,NULL,NULL,'202201299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA HSA DEP-Sched','202201299','EMPEXPORT','SCH_EMICWE',NULL,'EMICWEXFSA',NULL,NULL,NULL,'202201299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'WEX FSA HSA DEP-Test','202201289','EMPEXPORT','TEST_XOE','Mar  1 2022  6:44PM','EMICWEXFSA',NULL,NULL,NULL,'202201289','Jan 28 2022 12:00AM','Dec 30 1899 12:00AM','202201141','423','eecPayGroup','HOURLY,SALARY','202201141',dbo.fn_GetTimedKey(),NULL,'us3cPeMIC1008',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXFSA','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXFSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXFSA','H01','dbo.U_EMICWEXFSA_FH_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXFSA','D10','dbo.U_EMICWEXFSA_PT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXFSA','D20','dbo.U_EMICWEXFSA_EN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXFSA','D30','dbo.U_EMICWEXFSA_CT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXFSA','T90','dbo.U_EMICWEXFSA_FF_ftrTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMICWEXFSA
-----------

IF OBJECT_ID('U_dsi_BDM_EMICWEXFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMICWEXFSA] (
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
-- Create table U_EMICWEXFSA_Audit
-----------

IF OBJECT_ID('U_EMICWEXFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_Audit] (
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
-- Create table U_EMICWEXFSA_AuditFields
-----------

IF OBJECT_ID('U_EMICWEXFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMICWEXFSA_CT_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXFSA_CT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_CT_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantId] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionDescription] varchar(21) NULL,
    [drvContributionAmount] numeric NULL,
    [drvTaxYear] varchar(7) NULL
);

-----------
-- Create table U_EMICWEXFSA_DedList
-----------

IF OBJECT_ID('U_EMICWEXFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMICWEXFSA_EEList
-----------

IF OBJECT_ID('U_EMICWEXFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMICWEXFSA_EN_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXFSA_EN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_EN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantID] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvEnrollEffDate] varchar(8) NULL,
    [drvParticipantAmount] numeric NULL,
    [drvEnrollTermDate] datetime NULL,
    [drvElectionIndicator] varchar(6) NULL,
    [drvHDHPLevel] varchar(6) NULL
);

-----------
-- Create table U_EMICWEXFSA_FF_ftrTbl
-----------

IF OBJECT_ID('U_EMICWEXFSA_FF_ftrTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_FF_ftrTbl] (
    [drvRecordCount] int NULL,
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(8000) NULL
);

-----------
-- Create table U_EMICWEXFSA_FH_hdrTbl
-----------

IF OBJECT_ID('U_EMICWEXFSA_FH_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_FH_hdrTbl] (
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(8000) NULL,
    [drvFileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_EMICWEXFSA_File
-----------

IF OBJECT_ID('U_EMICWEXFSA_File') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EMICWEXFSA_PDedHist
-----------

IF OBJECT_ID('U_EMICWEXFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCoID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL
);

-----------
-- Create table U_EMICWEXFSA_PT_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXFSA_PT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXFSA_PT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantID] char(11) NULL,
    [drvEmployeeNum] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvGenderGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvDateBirth] datetime NULL,
    [drvSSNSSN] char(11) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCityCity] varchar(255) NULL,
    [drvStateState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusDate] datetime NULL,
    [drvFinalPayProcDate] datetime NULL,
    [drvFinalContribProcDate] datetime NULL,
    [drvMobileNumber] varchar(16) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMICWEXFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Microport Orthopedics, Inc

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 12/22/2021
Service Request Number: TekP-2021-10-18-0002

Purpose: WEX FSA HSA DEP

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMICWEXFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMICWEXFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMICWEXFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMICWEXFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMICWEXFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXFSA', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMICWEXFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMICWEXFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate            DATETIME
            ,@PdhPayDate         DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EMICWEXFSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

     -- Set @PdhPayDate to MAX Pay Date for File Header
    SET @PdhPayDate = (SELECT MAX(PrgPayDate) FROM dbo.PayReg WITH (NOLOCK) WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

     --Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMICWEXFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMICWEXFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMICWEXFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_AuditFields;
    CREATE TABLE dbo.U_EMICWEXFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMICWEXFSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EMICWEXFSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EMICWEXFSA_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMICWEXFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_Audit;
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
    INTO dbo.U_EMICWEXFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMICWEXFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -60, @EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMICWEXFSA_Audit ON dbo.U_EMICWEXFSA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EMICWEXFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMICWEXFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA, FSADC, HSA, HSACF, HSACI, HSAF, HSAI';

    IF OBJECT_ID('U_EMICWEXFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMICWEXFSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','FSA, FSADC, HSA, HSACF, HSACI, HSAF, HSAI');
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
    -- Get rid of dependent records
    -----------------------------
    DELETE FROM dbo.U_dsi_BDM_EMICWEXFSA  WHERE BdmRecType <> 'EMP'

       ---==========================================
 --   -- Insert Term info (dbo.U_dsi_BDM_EMICWEXFSA)
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EMICWEXFSA]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           --,[BdmDepRecID]
           --,[BdmSystemID]
           --,[BdmRunID]
           --,[BdmDedRowStatus]
           --,[BdmRelationship]
           --,[BdmDateOfBirth]
           ,[BdmDedCode]
           --,[BdmBenOption]
           --,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           --,[BdmChangeReason]
           --,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmEEGoalAmt]
    )
    SELECT Distinct rectype = 'EMP'
        ,EdhCoid
        ,EdhEEID
        --,DbnDepRecID
        --,DbnDepRecID
        --,'QB'
        --,'Data Inserted for Terms'
        --,DbnRelationship
        --,DbnDateOfBirth
        ,EdhDedCode
        --,DbnBenOption
        --,DbnBenStatus
        ,max(EdhBenStartDate)
        ,Max(EdhBenStopDate)
        --,DbnBenStopDate
        ,Max(EdhBenStatusDate)
        ,Max(EdhEffDate)
        --,'204'
        --,'204'
        ,Max(EdhStartDate)
        ,Max(EdhStopDate)
        ,Max(EdhEEGoalAmt)
    FROM dbo.emphded WITH (NOLOCK)
        --JOIN dbo.U_dsi_BDM_DepDeductions 
        --    ON dbneeid = edheeid 
        --    AND dbnformatcode = 'EMICWEXFSA'
        JOIN dbo.U_EMICWEXFSA_Audit 
            ON audEEID = edheeid  
            and audfieldname = 'eecemplstatus' 
            and audNewValue = 'T'
            AND EdhDedCode in ('FSA', 'FSADC', 'HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI')
            AND EdhBenStopDate BETWEEN dateadd(D, -60, @EndDate) AND @EndDate
            AND EdhBenStatus = 'T'
            Group by EdhCoid ,EdhEEID,EdhDedCode
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMICWEXFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhCoID
         ,PdhDedCode
         --,PdhGoalAmt = MAX(PdhEEGoalAmt)
         --,PdhStopDate = Max(EedBenStopDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('HSAER') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('HSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('HSACF') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('HSACI') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('HSAF') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('HSAI') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EMICWEXFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    --LEFT JOIN dbo.EmpDed WITH (NOLOCK)
    --ON EedEEID = PdhEEID
    --AND EedCoID =PdhCoID
    --AND EedDedCode = PdhDedCode
    WHERE PdhDedCode in ('FSADC', 'FSA',  'HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAER' )
    AND LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCoID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --==========================================
    -- Build Driver Tables
    --==========================================

        ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMICWEXFSA_FH_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_FH_hdrTbl;
    SELECT DISTINCT
         drvEmployerCode = '41875'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = REPLACE(CONVERT(VARCHAR(8),@RunDate,108),':',SPACE(0))
        ,drvFileVersion = '3.5'
    INTO dbo.U_EMICWEXFSA_FH_hdrTbl
    FROM dbo.U_EMICWEXFSA_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMICWEXFSA_PT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMICWEXFSA_PT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_PT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN + ' 1'
        -- standard fields above and additional driver fields below
        ,drvParticipantID = EepSSN
        ,drvEmployeeNum = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGenderGender = CASE WHEN EepGender in ('M','F') THEN EepGender END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus in ('S','M') THEN eepMaritalStatus END
        ,drvDateBirth = EepDateOfBirth
        ,drvSSNSSN = eepSSN
        ,drvAddressLine1 = REPLACE(Eepaddressline1,'PO Box', 'Post Office Box')
        ,drvAddressLine2 = Eepaddressline2
        ,drvCityCity = EepAddressCity
        ,drvStateState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfLastHire
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateofTermination ELSE EecDateOfLastHire END
        ,drvFinalPayProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(Day, 30, EecDateofTermination) END
        ,drvFinalContribProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(Day, 30, EecDateofTermination) END
        ,drvMobileNumber = dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL')
    INTO dbo.U_EMICWEXFSA_PT_drvTbl
    FROM dbo.U_EMICWEXFSA_EEList WITH (NOLOCK)
        JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
             And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
            and EXISTS (Select 1 from dbo.U_EMICWEXFSA_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
       JOIN dbo.U_dsi_BDM_EMICWEXFSA WITH (NOLOCK)
            ON BdmEEID = xEEID 
            AND BdmCoID = xCoID
        LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
            ON efoEEID = xEEID
    --LEFT JOIN dbo.U_EMICWEXFSA_Audit WITH (NOLOCK)
    --    ON audEEID = xEEID
    --    AND AudFieldName  = 'eecemplstatus' 
    --    AND AudNewValue = 'T'
        LEFT JOIN dbo.U_EMICWEXFSA_PDedHist WITH (NOLOCK)
            ON pdhEEID = xEEID
			AND PdhCoID = xCoID
   -- WHERE (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
   --         OR (ISNULL(PdhSource1, 0.00) > 0.00
   --             OR ISNULL(PdhSource2, 0.00) > 0.00
   --             OR ISNULL(PdhSource3, 0.00) > 0.00
   --             OR ISNULL(PdhSource4, 0.00) > 0.00
   --             OR ISNULL(PdhSource5, 0.00) > 0.00
   --             OR ISNULL(PdhSource6, 0.00) > 0.00
   --             OR ISNULL(PdhSource7, 0.00) > 0.00
   --             OR ISNULL(PdhSource8, 0.00) > 0.00
   --             )
          --and EXISTS (Select 1 from dbo.U_EMICWEXFSA_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMICWEXFSA_EN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMICWEXFSA_EN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_EN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN + ' 2'
        -- standard fields above and additional driver fields below
        ,drvParticipantID = EepSSN
        ,drvPlanName =                              CASE    WHEN BdmDedCode is null THEN 
                                                    CASE    WHEN PdhDedCode = 'FSA' THEN 'Medical FSA' 
                                                            WHEN PdhDedCode = 'FSADC' THEN 'Dependent Care FSA' 
                                                            --WHEN PdhDedCode = 'FSADC' THEN 'Dependent Care FSA'
                                                            WHEN PdhDedCode  in ('HSA','HSACF','HSACI','HSAF','HSAI') THEN 'Health Savings Account'END
                                                    ELSE 
                                                    CASE    WHEN BdmDedCode = 'FSA' THEN 'Medical FSA'
                                                            WHEN BdmDedCode = 'FSADC' THEN 'Dependent Care FSA'
                                                            WHEN BdmDedCode in ('HSA','HSACF','HSACI','HSAF','HSAI') THEN 'Health Savings Account'
                                                    END
                                                    END
        ,drvEnrollEffDate =                            CASE    WHEN BdmDedCode is null THEN 
                                                    CASE    WHEN PdhDedCode  in ('FSA', 'FSADC', 'HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI')  THEN  '0101'+ CONVERT(VARCHAR(4), CASE WHEN DATEPART(YEAR, GETDATE() ) < 2022 THEN '2022' ELSE DATEPART(YEAR, GETDATE()) END ) 
                                                    END
                                                    ELSE 
                                                    CASE    WHEN BdmDedCode in ('FSA', 'FSADC', 'HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI') THEN '0101'+ CONVERT(VARCHAR(4), CASE WHEN DATEPART(YEAR, GETDATE() ) < 2022 THEN '2022' ELSE DATEPART(YEAR, GETDATE()) END ) 
                                                    END
                                                    END 
        ,drvParticipantAmount =                        CASE    WHEN BdmDedCode is null THEN 
                                                    CASE    WHEN PdhDedCode  in ('FSADC', 'FSA') THEN 0  END 
                                                    ELSE
                                                    CASE    WHEN BdmDedCode in ('FSADC', 'FSA') THEN BdmEEGoalAmt 
                                                            WHEN BdmDedCode in ('HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI') THEN 0.00
                                                            WHEN PdhDedCode in ('HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI') THEN 0.00
                                                    END END
        ,drvEnrollTermDate = CASE    WHEN eecemplstatus <> 'T' and  BdmDedCode in ('FSADC', 'FSA') THEN BdmBenStopDate 
                                    WHEN eecemplstatus <> 'T' and PdhDedCode in  ('FSADC', 'FSA') THEN 0
                                    END
        ,drvElectionIndicator = CASE    WHEN BdmDedCode in ('HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI') THEN 'PerPay' 
                                        WHEN PdhDedCode in ('HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI') THEN 'PerPay' 
                                        END
        ,drvHDHPLevel = CASE WHEN BdmDedCode in ('HSACF','HSAF') THEN 'Family' 
                             WHEN BdmDedCode in ('HSA','HSACI', 'HSAI') THEN 'Single' 
                             WHEN PdhDedCode in ('HSACF','HSAF') THEN 'Family' 
                             WHEN PdhDedCode in ('HSA','HSACI', 'HSAI') THEN 'Single' 
                             END
    INTO dbo.U_EMICWEXFSA_EN_drvTbl
    FROM dbo.U_EMICWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
             And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_EMICWEXFSA_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMICWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpDed WITH (NOLOCK) 
        ON xEEID  = EedEEID 
        AND xCoID = EedCOID
        --AND BdmDedCode in ('FSADC', 'FSA',  'HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI' )
        --('FSA', 'FSADC', 'HSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI')
        --AND BdmRecType = 'EMP'
    --LEFT JOIN dbo.U_EMICWEXFSA_Audit WITH (NOLOCK)
    --    ON audEEID = xEEID
    --    AND AudFieldName  = 'eecemplstatus' 
    --    AND AudNewValue = 'T'
    LEFT JOIN dbo.U_EMICWEXFSA_PDedHist WITH (NOLOCK)
        ON pdhEEID = BdmEEID 
		AND PdhCoID = BdmCoID
		AND PdhDedCode = BdmDedCode
    --WHERE 
    --(eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
 --       OR (
        --ISNULL(PdhSource1, 0.00) > 0.00
  --              OR ISNULL(PdhSource2, 0.00) > 0.00
  --              OR ISNULL(PdhSource3, 0.00) > 0.00
  --              OR ISNULL(PdhSource4, 0.00) > 0.00
  --              OR ISNULL(PdhSource5, 0.00) > 0.00
  --              OR ISNULL(PdhSource6, 0.00) > 0.00
  --              OR ISNULL(PdhSource7, 0.00) > 0.00
  --              OR ISNULL(PdhSource8, 0.00) > 0.00
  --              --)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMICWEXFSA_CT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMICWEXFSA_CT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_CT_drvTbl;
    SELECT DISTINCT
         drvEEID = pdhEEID
        ,drvCoID = PdhCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN + ' 3'
        -- standard fields above and additional driver fields below
        ,drvParticipantId = EepSSN
        ,drvPlanName = CASE WHEN PdhDedCode = 'FSA' THEN 'Medical FSA'
                            WHEN PdhDedCode = 'FSADC' THEN 'Dependent Care FSA'
                            WHEN PdhDedCode in ('HSA','HSACF','HSACI','HSAF','HSAI','HSAER') THEN 'Health Savings Account'
                            END
        ,drvContributionDate = @PdhPayDate
        ,drvContributionDescription = CASE    WHEN PdhDedCode in ('FSADC', 'FSA', 'HSA', 'HSACF', 'HSACI','HSAF', 'HSAI') THEN 'Payroll Deduction'
                                            WHEN PdhDedCode = 'HSAER' THEN 'Employer Contribution'
                                            END
        ,drvContributionAmount = CASE WHEN PdhDedCode = 'HSAER' AND PdhSource1 > 0 THEN PdhSource1  
                                      WHEN PdhDedCode = 'FSADC' AND PdhSource2 > 0 THEN PdhSource2  
                                      WHEN PdhDedCode = 'FSA' AND PdhSource3 > 0 THEN PdhSource3  
                                      WHEN PdhDedCode = 'HSA' AND PdhSource4 > 0 THEN PdhSource4  
                                      WHEN PdhDedCode = 'HSACF' AND PdhSource5 > 0 THEN PdhSource5 
                                      WHEN PdhDedCode = 'HSACI' AND PdhSource6 > 0 THEN PdhSource6
                                      WHEN PdhDedCode = 'HSAF' AND PdhSource7 > 0 THEN PdhSource7
                                      WHEN PdhDedCode = 'HSAI' AND PdhSource8 > 0 THEN PdhSource8
                                      END
        ,drvTaxYear = CASE 
                            WHEN PdhDedCode in ('FSADC','FSA') THEN '' 
                            WHEN PdhDedCode in ('HSA', 'HSACF', 'HSACI','HSAF', 'HSAI') THEN 'Current' 
                            END
    INTO dbo.U_EMICWEXFSA_CT_drvTbl
    FROM dbo.U_EMICWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.U_EMICWEXFSA_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = pdhEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            -- And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          --and EXISTS (Select 1 from dbo.U_EMICWEXFSA_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    LEFT JOIN dbo.U_EMICWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND AudFieldName  = 'eecemplstatus' 
        AND AudNewValue = 'T'    
    WHERE (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
        OR (ISNULL(PdhSource1, 0.00) > 0.00
                OR ISNULL(PdhSource2, 0.00) > 0.00
                OR ISNULL(PdhSource3, 0.00) > 0.00
                OR ISNULL(PdhSource4, 0.00) > 0.00
                OR ISNULL(PdhSource5, 0.00) > 0.00
                OR ISNULL(PdhSource6, 0.00) > 0.00
                OR ISNULL(PdhSource7, 0.00) > 0.00
                OR ISNULL(PdhSource8, 0.00) > 0.00
                )
    ;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMICWEXFSA_FF_ftrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXFSA_FF_ftrTbl;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM  dbo.U_EMICWEXFSA_PT_drvTbl) + (SELECT COUNT(*) FROM dbo.U_EMICWEXFSA_EN_drvTbl) + (SELECT COUNT(*) FROM dbo.U_EMICWEXFSA_CT_drvTbl) 
        ,drvEmployerCode = '41875'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = REPLACE(CONVERT(VARCHAR(8),@RunDate,108),':',SPACE(0))
    INTO dbo.U_EMICWEXFSA_FF_ftrTbl
    FROM dbo.U_EMICWEXFSA_EEList WITH (NOLOCK)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_41875_MicroPort.txt'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_41875_MicroPort.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMICWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMICWEXFSA_File (NOLOCK)
    ORDER BY CASE WHEN InitialSort = '1' THEN '1' WHEN InitialSort = '9999' THEN '3' ELSE '2' END,  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMICWEXFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201011'
       ,expStartPerControl     = '202201011'
       ,expLastEndPerControl   = '202201299'
       ,expEndPerControl       = '202201299'
WHERE expFormatCode = 'EMICWEXFSA';

--202201281    202201289
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMICWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMICWEXFSA_File (NOLOCK)
    ORDER BY CASE WHEN InitialSort = '1' THEN '1' WHEN InitialSort = '9999' THEN '3' ELSE '2' END,  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMICWEXFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMICWEXFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMICWEXFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMICWEXFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMICWEXFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMICWEXFSA', 'UseFileName', 'V', 'Y'


-- End ripout