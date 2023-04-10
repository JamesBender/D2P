/**********************************************************************************

EBYTWEXFSA: Wex FSA Export

FormatCode:     EBYTWEXFSA
Project:        Wex FSA Export
Client ID:      BOM1001
Date/time:      2023-04-06 10:21:44.317
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB01
Database:       ULTIPRO_WPBOCOR
Web Filename:   BOM1001_FPR3Z_EEHISTORY_EBYTWEXFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBYTWEXFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EBYTWEXFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBYTWEXFSA'


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
WHERE FormatCode = 'EBYTWEXFSA'
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
WHERE ExpFormatCode = 'EBYTWEXFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBYTWEXFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBYTWEXFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBYTWEXFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBYTWEXFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBYTWEXFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBYTWEXFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBYTWEXFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBYTWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBYTWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBYTWEXFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBYTWEXFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBYTWEXFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBYTWEXFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBYTWEXFSA];
GO
IF OBJECT_ID('U_EBYTWEXFSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_Trailer];
GO
IF OBJECT_ID('U_EBYTWEXFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_PEarHist];
GO
IF OBJECT_ID('U_EBYTWEXFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_PDedHist];
GO
IF OBJECT_ID('U_EBYTWEXFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_Header];
GO
IF OBJECT_ID('U_EBYTWEXFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_File];
GO
IF OBJECT_ID('U_EBYTWEXFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_EEList];
GO
IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_drvTbl_PT];
GO
IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_drvTbl_EN];
GO
IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_drvTbl_CT];
GO
IF OBJECT_ID('U_EBYTWEXFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_DedList];
GO
IF OBJECT_ID('U_EBYTWEXFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_AuditFields];
GO
IF OBJECT_ID('U_EBYTWEXFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBYTWEXFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBYTWEXFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBYTWEXFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBYTWEXFSA','Wex FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EBYTWEXFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBYTWEXFSAZ0','2','H','01','1',NULL,'Record Type',NULL,NULL,'"FH "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBYTWEXFSAZ0','3','H','01','2',NULL,'Administrator Code',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBYTWEXFSAZ0','6','H','01','3',NULL,'Employer Code',NULL,NULL,'"41748"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBYTWEXFSAZ0','1','H','01','4',NULL,'Synchronize Flag',NULL,NULL,'"N "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBYTWEXFSAZ0','8','H','01','5',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBYTWEXFSAZ0','6','H','01','6',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBYTWEXFSAZ0','6','H','01','7',NULL,'File Version',NULL,NULL,'"3.5"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBYTWEXFSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL,'"PT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBYTWEXFSAZ0','50','D','10','2',NULL,'Participant File Import ID',NULL,NULL,'"drvParticipantID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBYTWEXFSAZ0','20','D','10','3',NULL,'Employer Employee ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBYTWEXFSAZ0','15','D','10','4',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBYTWEXFSAZ0','30','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBYTWEXFSAZ0','30','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBYTWEXFSAZ0','1','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBYTWEXFSAZ0','1','D','10','8',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBYTWEXFSAZ0','1','D','10','9',NULL,'Marital Status',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBYTWEXFSAZ0','50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBYTWEXFSAZ0','8','D','10','11',NULL,'Date Of Birth',NULL,NULL,'"drvDateOfBirth"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBYTWEXFSAZ0','9','D','10','12',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBYTWEXFSAZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBYTWEXFSAZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBYTWEXFSAZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBYTWEXFSAZ0','50','D','10','16',NULL,'Address Line 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBYTWEXFSAZ0','30','D','10','17',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBYTWEXFSAZ0','2','D','10','18',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBYTWEXFSAZ0','10','D','10','19',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBYTWEXFSAZ0','2','D','10','20',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBYTWEXFSAZ0','10','D','10','21',NULL,'Home Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBYTWEXFSAZ0','10','D','10','22',NULL,'Work Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBYTWEXFSAZ0','6','D','10','23',NULL,'Work Phone Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBYTWEXFSAZ0','125','D','10','24',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBYTWEXFSAZ0','100','D','10','25',NULL,'Username',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBYTWEXFSAZ0','100','D','10','26',NULL,'Password',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBYTWEXFSAZ0','8','D','10','27',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBYTWEXFSAZ0','100','D','10','28',NULL,'Division',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBYTWEXFSAZ0','2','D','10','29',NULL,'Hours Per Week',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBYTWEXFSAZ0','100','D','10','30',NULL,'Employee Class',NULL,NULL,'"E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBYTWEXFSAZ0','100','D','10','31',NULL,'Payroll  Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBYTWEXFSAZ0','8','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBYTWEXFSAZ0','20','D','10','33',NULL,'Participant Status',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBYTWEXFSAZ0','8','D','10','34',NULL,'Status Effective Date',NULL,NULL,'"drvStatusEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBYTWEXFSAZ0','1','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBYTWEXFSAZ0','1','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBYTWEXFSAZ0','1','D','10','37',NULL,'Incur Services',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBYTWEXFSAZ0','8','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'"drvFinalPayrollProcessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBYTWEXFSAZ0','8','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'"drvFinalContribProcessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBYTWEXFSAZ0','100','D','10','40',NULL,'HSA Custodian',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBYTWEXFSAZ0','1','D','10','41',NULL,'Medicare Beneficiary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBYTWEXFSAZ0','12','D','10','42',NULL,'Medicare ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBYTWEXFSAZ0','50','D','10','43',NULL,'Exchange Integration ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBYTWEXFSAZ0','100','D','10','44',NULL,'Reporting Hierarchy Level 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBYTWEXFSAZ0','100','D','10','45',NULL,'Reporting Hierarchy Level 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBYTWEXFSAZ0','100','D','10','46',NULL,'Reporting Hierarchy Level 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBYTWEXFSAZ0','100','D','10','47',NULL,'Reporting Hierarchy Level 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBYTWEXFSAZ0','20','D','10','48',NULL,'CDD_Citizenshi p',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBYTWEXFSAZ0','2','D','10','49',NULL,'CDD_Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBYTWEXFSAZ0','20','D','10','50',NULL,'CDD_Employm entStatus',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBYTWEXFSAZ0','30','D','10','51',NULL,'CDD_Employer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBYTWEXFSAZ0','30','D','10','52',NULL,'CDD_JobTitle',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBYTWEXFSAZ0','8','D','10','53',NULL,'Class Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBYTWEXFSAZ0','20','D','10','54',NULL,'ID_Identification Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBYTWEXFSAZ0','30','D','10','55',NULL,'ID_Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBYTWEXFSAZ0','2','D','10','56',NULL,'ID_IssuingState',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBYTWEXFSAZ0','50','D','10','57',NULL,'ID_Issuer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBYTWEXFSAZ0','8','D','10','58',NULL,'ID_IssueDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBYTWEXFSAZ0','8','D','10','59',NULL,'ID_ExpirationDa te',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBYTWEXFSAZ0','20','D','10','60',NULL,'Mobile Carrier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBYTWEXFSAZ0','10','D','10','61',NULL,'Mobile Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBYTWEXFSAZ0','15','D','10','62',NULL,'Time Zone',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBYTWEXFSAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBYTWEXFSAZ0','50','D','20','2',NULL,'Participant File Import Id',NULL,NULL,'"drvParticipantFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBYTWEXFSAZ0','100','D','20','3',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBYTWEXFSAZ0','8','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL,'"drvEnrollmentEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBYTWEXFSAZ0','8','D','20','5',NULL,'Participant Election Amount',NULL,NULL,'"drvParticipantElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBYTWEXFSAZ0','8','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL,'"drvEnrollmentTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBYTWEXFSAZ0','10','D','20','7',NULL,'Employer Contribution Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBYTWEXFSAZ0','8','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBYTWEXFSAZ0','30','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBYTWEXFSAZ0','30','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBYTWEXFSAZ0','1','D','20','11',NULL,'Enrolled In Claims',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBYTWEXFSAZ0','8','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBYTWEXFSAZ0','6','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBYTWEXFSAZ0','8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBYTWEXFSAZ0','1','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBYTWEXFSAZ0','8','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBYTWEXFSAZ0','6','D','20','17',NULL,'Time Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBYTWEXFSAZ0','8','D','20','18',NULL,'Change Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBYTWEXFSAZ0','1','D','20','19',NULL,'Spend Down',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBYTWEXFSAZ0','2','D','30','1',NULL,'Record Type',NULL,NULL,'"CT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBYTWEXFSAZ0','50','D','30','2',NULL,'Participant File Import Id',NULL,NULL,'"drvParticipantFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBYTWEXFSAZ0','100','D','30','3',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBYTWEXFSAZ0','8','D','30','4',NULL,'Contribution Date',NULL,NULL,'"drvContributionDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBYTWEXFSAZ0','30','D','30','5',NULL,'Contribution Description',NULL,NULL,'"drvContributionDescription"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBYTWEXFSAZ0','9','D','30','6',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBYTWEXFSAZ0','6','D','30','7',NULL,'Amount Type',NULL,NULL,'"drvAmountType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBYTWEXFSAZ0','7','D','30','8',NULL,'Tax Year',NULL,NULL,'"drvTaxYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBYTWEXFSAZ0','2','T','90','1',NULL,'Record Type',NULL,NULL,'"FF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBYTWEXFSAZ0','20','T','90','2',NULL,'Record Count',NULL,NULL,'"trvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBYTWEXFSAZ0','3','T','90','3',NULL,'Administrator Code',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBYTWEXFSAZ0','6','T','90','4',NULL,'Employer Code',NULL,NULL,'"41748"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBYTWEXFSAZ0','8','T','90','5',NULL,'Submitted Date',NULL,NULL,'"trvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBYTWEXFSAZ0','6','T','90','6',NULL,'Submitted Time',NULL,NULL,'"trvSubmittedTime"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBYTWEXFSA_20230406.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202303079','EMPEXPORT','OEACTIVE',NULL,'EBYTWEXFSA',NULL,NULL,NULL,'202303079','Feb  7 2023  1:14PM','Feb  7 2023  1:14PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202303079','EMPEXPORT','OEPASSIVE',NULL,'EBYTWEXFSA',NULL,NULL,NULL,'202303079','Feb  7 2023  1:14PM','Feb  7 2023  1:14PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wex FSA Export','202303079','EMPEXPORT','ONDEM_XOE',NULL,'EBYTWEXFSA',NULL,NULL,NULL,'202303079','Feb  7 2023  1:14PM','Feb  7 2023  1:14PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wex FSA Export-Sched','202303079','EMPEXPORT','SCH_EBYTWE',NULL,'EBYTWEXFSA',NULL,NULL,NULL,'202303079','Feb  7 2023  1:14PM','Feb  7 2023  1:14PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Wex FSA Export-Test','202303079','EMPEXPORT','TEST_XOE',NULL,'EBYTWEXFSA',NULL,NULL,NULL,'202303079','Feb  7 2023  1:14PM','Feb  7 2023  1:14PM','202302071',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBYTWEXFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBYTWEXFSA','H01','dbo.U_EBYTWEXFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBYTWEXFSA','D10','dbo.U_EBYTWEXFSA_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBYTWEXFSA','D20','dbo.U_EBYTWEXFSA_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBYTWEXFSA','D30','dbo.U_EBYTWEXFSA_drvTbl_CT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBYTWEXFSA','T90','dbo.U_EBYTWEXFSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBYTWEXFSA
-----------

IF OBJECT_ID('U_dsi_BDM_EBYTWEXFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBYTWEXFSA] (
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
-- Create table U_EBYTWEXFSA_Audit
-----------

IF OBJECT_ID('U_EBYTWEXFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_Audit] (
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
-- Create table U_EBYTWEXFSA_AuditFields
-----------

IF OBJECT_ID('U_EBYTWEXFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBYTWEXFSA_DedList
-----------

IF OBJECT_ID('U_EBYTWEXFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBYTWEXFSA_drvTbl_CT
-----------

IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_CT') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_drvTbl_CT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantFileImportId] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvContributionDate] varchar(8000) NULL,
    [drvContributionDescription] varchar(17) NOT NULL,
    [drvContributionAmount] nvarchar(4000) NULL,
    [drvAmountType] varchar(6) NOT NULL,
    [drvTaxYear] varchar(1) NOT NULL
);

-----------
-- Create table U_EBYTWEXFSA_drvTbl_EN
-----------

IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantFileImportId] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvEnrollmentEffectiveDate] varchar(8000) NULL,
    [drvParticipantElectionAmount] nvarchar(4000) NULL,
    [drvEnrollmentTerminationDate] varchar(8000) NULL
);

-----------
-- Create table U_EBYTWEXFSA_drvTbl_PT
-----------

IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantID] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] varchar(8000) NULL,
    [drvPayrollFrequency] varchar(12) NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffectiveDate] varchar(8000) NULL,
    [drvFinalPayrollProcessDate] varchar(8000) NULL,
    [drvFinalContribProcessDate] varchar(8000) NULL
);

-----------
-- Create table U_EBYTWEXFSA_EEList
-----------

IF OBJECT_ID('U_EBYTWEXFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBYTWEXFSA_File
-----------

IF OBJECT_ID('U_EBYTWEXFSA_File') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EBYTWEXFSA_Header
-----------

IF OBJECT_ID('U_EBYTWEXFSA_Header') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_Header] (
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(6) NULL
);

-----------
-- Create table U_EBYTWEXFSA_PDedHist
-----------

IF OBJECT_ID('U_EBYTWEXFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPerControl] char(9) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSAMD] numeric NULL,
    [PdhFSADC] numeric NULL,
    [PdhFSAI] numeric NULL
);

-----------
-- Create table U_EBYTWEXFSA_PEarHist
-----------

IF OBJECT_ID('U_EBYTWEXFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL
);

-----------
-- Create table U_EBYTWEXFSA_Trailer
-----------

IF OBJECT_ID('U_EBYTWEXFSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EBYTWEXFSA_Trailer] (
    [trvRecordCount] int NULL,
    [trvSubmittedDate] datetime NULL,
    [trvSubmittedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBYTWEXFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Beyondtrust Corporation

Created By: Marie Waters
Business Analyst: Curlin Beck/Katherine Ricca
Create Date: 02/07/2023
Service Request Number: TekP-2022-10-27-03

Purpose: Wex FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBYTWEXFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBYTWEXFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBYTWEXFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBYTWEXFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBYTWEXFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBYTWEXFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBYTWEXFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBYTWEXFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBYTWEXFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBYTWEXFSA', 'SCH_EBYTWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBYTWEXFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBYTWEXFSA', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
     DECLARE @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@RunDate           Datetime
            ,@PlanYearStart     DATETIME
            ,@RunTime           VARCHAR(6);

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
        ,@RunTime         = format(getdate(),'HHmmss')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EBYTWEXFSA';

    -- Set FSA Plan Year Start
    SET @PlanYearStart = CASE WHEN MONTH(@EndDate) = 12 THEN '01/01/' + CONVERT(CHAR(4),YEAR(DATEADD(YEAR,1,@EndDate)))
                              ELSE '01/01/' + CONVERT(CHAR(4),YEAR(@EndDate))
                         END;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBYTWEXFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBYTWEXFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBYTWEXFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_AuditFields;
    CREATE TABLE dbo.U_EBYTWEXFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EBYTWEXFSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EBYTWEXFSA_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBYTWEXFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_Audit;
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
    INTO dbo.U_EBYTWEXFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBYTWEXFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBYTWEXFSA_Audit ON dbo.U_EBYTWEXFSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EBYTWEXFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBYTWEXFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD,FSADC,FSAI';

    IF OBJECT_ID('U_EBYTWEXFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBYTWEXFSA_DedList
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
    IF OBJECT_ID('U_EBYTWEXFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhPerControl = MAX(PdhPerControl)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFSAMD    = SUM(CASE WHEN PdhDedCode IN ('FSAMD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSADC    = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)             
        ,PdhFSAI     = SUM(CASE WHEN PdhDedCode IN ('FSAI') THEN PdhEECurAmt ELSE 0.00 END)
        
    INTO dbo.U_EBYTWEXFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBYTWEXFSA_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EBYTWEXFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ---- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EBYTWEXFSA_PEarHist
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
    -- DETAIL RECORD - U_EBYTWEXFSA_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort  = '2_' + xEEID + '_1'

        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvParticipantID = EepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvDateOfBirth = REPLACE(CONVERT (CHAR(10),EepDateOfBirth, 101),'/','')
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = REPLACE(CONVERT (CHAR(10),EecDateOfLastHire, 101),'/','') 
        ,drvPayrollFrequency = CASE WHEN EecPayPeriod = 'B' THEN 'Bi-Weekly' WHEN EecPayPeriod = 'M' THEN 'Monthly' WHEN EecPayPeriod = 'S' THEN 'Semi-monthly' WHEN EecPayPeriod = 'W' THEN 'Weekly' END
               --                 CASE When EecPayPeriod = 'M' THEN 'Monthly'   --Payroll
                                    --When EecPayPeriod = 'B' THEN 'Biweekly'
                                    --END
        ,drvParticipantStatus =  CASE EecEmplStatus
                                     WHEN 'T' THEN 'Terminated' 
                                     ELSE'Active'                                                                 
                                END
        ,drvStatusEffectiveDate =  REPLACE(CONVERT (CHAR(10),CASE EecEmplStatus
                                     WHEN 'T' THEN eecdateoftermination 
                                     ELSE eecdateoflasthire                                                                
                                END, 101),'/','') 
        ,drvFinalPayrollProcessDate = CASE EecEmplStatus
                                     WHEN 'T' THEN REPLACE(CONVERT (CHAR(10),BdmBenstopDate , 101),'/','')                                                                                          
                                END
        ,drvFinalContribProcessDate = CASE EecEmplStatus
                                     WHEN 'T' THEN REPLACE(CONVERT (CHAR(10),BdmBenstopDate  , 101),'/','')                                                                                               
                                END
    INTO dbo.U_EBYTWEXFSA_drvTbl_PT
    FROM dbo.U_EBYTWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBYTWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBYTWEXFSA_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_drvTbl_EN;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  '2_' + xEEID + '_2'
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportId = EepSSN
        ,drvPlanName = CASE WHEN Bdmdedcode = 'FSAMD' THEN 'Medical FSA'
                            WHEN Bdmdedcode = 'FSADC' THEN 'Dependent Care FSA'
                            WHEN Bdmdedcode = 'FSAI' THEN 'Limited Medical FSA'
                        END
        ,drvEnrollmentEffectiveDate = REPLACE(CONVERT (CHAR(10),PrgPayDate , 101),'/','')
        ,drvParticipantElectionAmount = CASE WHEN  Bdmdedcode IN  ('FSADC', 'FSAMD', 'FSAI') THEN FORMAT(BdmEEGoalAmt, '0.00') END
        ,drvEnrollmentTerminationDate = REPLACE(CONVERT (CHAR(10),CASE WHEN  EecEmplStatus = 'T' THEN EecDateOfTermination
                                             WHEN eecemplstatus <> 'T' and BDMDedCode IN  ('FSADC', 'FSAMD', 'FSAI') and Bdmbenstopdate is not null  THEN Bdmbenstopdate  END, 101),'/','')
    INTO dbo.U_EBYTWEXFSA_drvTbl_EN
    FROM dbo.U_EBYTWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBYTWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EBYTWEXFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    JOIN dbo.U_EBYTWEXFSA_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBYTWEXFSA_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_EBYTWEXFSA_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2_' + xEEID + '_3'
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportId = EepSSN
        ,drvPlanName = CASE WHEN Bdmdedcode = 'FSAMD' THEN 'Medical FSA'
                            WHEN Bdmdedcode = 'FSADC' THEN 'Dependent Care FSA'
                            WHEN Bdmdedcode = 'FSAI' THEN 'Limited Medical FSA'
                        END
        ,drvContributionDate =   REPLACE(CONVERT (CHAR(10),Cast(Left(PdhPerControl,8) as date), 101),'/','')
        ,drvContributionDescription = 'Payroll Deduction'
        ,drvContributionAmount =  CASE WHEN  Bdmdedcode IN ('FSADC') AND PdhFSADC > 0.00 THEN FORMAT(PdhFSADC,'0.00')
                                       WHEN  Bdmdedcode IN ('FSAMD') AND PdhFSAMD > 0.00 THEN FORMAT(PdhFSAMD,'0.00')
                                       WHEN  Bdmdedcode IN ('FSAI')  AND PdhFSAI  > 0.00 THEN FORMAT(PdhFSAI ,'0.00')
                                    END
        ,drvAmountType = 'Actual'
        ,drvTaxYear = ''-- Current
    INTO dbo.U_EBYTWEXFSA_drvTbl_CT
    FROM dbo.U_EBYTWEXFSA_EEList WITH (NOLOCK)
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBYTWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EBYTWEXFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    WHERE @ExportCode NOT LIKE 'OE%';
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBYTWEXFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_Header;
    SELECT DISTINCT
         drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
    INTO dbo.U_EBYTWEXFSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBYTWEXFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EBYTWEXFSA_Trailer;
    SELECT DISTINCT
         trvRecordCount = (SELECT COUNT(1) FROM dbo.U_EBYTWEXFSA_drvTbl_PT) +
                          (SELECT COUNT(1) FROM dbo.U_EBYTWEXFSA_drvTbl_EN) +
                          (SELECT COUNT(1) FROM dbo.U_EBYTWEXFSA_drvTbl_CT) 
        ,trvSubmittedDate = @RunDate
        ,trvSubmittedTime = @Runtime
    INTO dbo.U_EBYTWEXFSA_Trailer
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
ALTER VIEW dbo.dsi_vwEBYTWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBYTWEXFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBYTWEXFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302071'
       ,expStartPerControl     = '202302071'
       ,expLastEndPerControl   = '202303079'
       ,expEndPerControl       = '202303079'
WHERE expFormatCode = 'EBYTWEXFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBYTWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBYTWEXFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBYTWEXFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBYTWEXFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBYTWEXFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBYTWEXFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBYTWEXFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBYTWEXFSA', 'UseFileName', 'V', 'Y'


-- End ripout