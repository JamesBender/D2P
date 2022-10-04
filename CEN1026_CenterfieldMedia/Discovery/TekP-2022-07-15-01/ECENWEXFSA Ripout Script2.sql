/**********************************************************************************

ECENWEXFSA: WEX FSA Enrollment Export

FormatCode:     ECENWEXFSA
Project:        WEX FSA Enrollment Export
Client ID:      CEN1026
Date/time:      2022-10-04 16:00:41.357
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB02
Database:       ULTIPRO_WPCENM
Web Filename:   CEN1026_T1LIX_EEHISTORY_ECENWEXFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECENWEXFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_ECENWEXFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECENWEXFSA'


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
WHERE FormatCode = 'ECENWEXFSA'
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
WHERE ExpFormatCode = 'ECENWEXFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECENWEXFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECENWEXFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECENWEXFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECENWEXFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECENWEXFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECENWEXFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECENWEXFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECENWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECENWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECENWEXFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECENWEXFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECENWEXFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECENWEXFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECENWEXFSA];
GO
IF OBJECT_ID('U_ECENWEXFSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_Trailer];
GO
IF OBJECT_ID('U_ECENWEXFSA_PT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_PT_drvTbl];
GO
IF OBJECT_ID('U_ECENWEXFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_Header];
GO
IF OBJECT_ID('U_ECENWEXFSA_File') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_File];
GO
IF OBJECT_ID('U_ECENWEXFSA_EN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_EN_drvTbl];
GO
IF OBJECT_ID('U_ECENWEXFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_EEList];
GO
IF OBJECT_ID('U_ECENWEXFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_DedList];
GO
IF OBJECT_ID('U_ECENWEXFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_AuditFields];
GO
IF OBJECT_ID('U_ECENWEXFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECENWEXFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECENWEXFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECENWEXFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECENWEXFSA','WEX FSA Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','ECENWEXFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENWEXFSAZ0','2','H','01','1',NULL,'Record Type ',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENWEXFSAZ0','3','H','01','2',NULL,'Administrator Code ',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENWEXFSAZ0','6','H','01','3',NULL,'Employer Code ',NULL,NULL,'"30414"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECENWEXFSAZ0','1','H','01','4',NULL,'Synchronize Flag ',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECENWEXFSAZ0','8','H','01','5',NULL,'Submitted Date ',NULL,NULL,'"drvSubmittedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECENWEXFSAZ0','6','H','01','6',NULL,'Submitted Time ',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECENWEXFSAZ0','6','H','01','7',NULL,'File Version ',NULL,NULL,'"3.5"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENWEXFSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL,'"PT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENWEXFSAZ0','50','D','10','2',NULL,'Participant File Import ID ',NULL,NULL,'"drvParticipantFileImportID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENWEXFSAZ0','20','D','10','3',NULL,'Employer Employee ID ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECENWEXFSAZ0','15','D','10','4',NULL,'Employee Number ',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECENWEXFSAZ0','30','D','10','5',NULL,'Last Name ',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECENWEXFSAZ0','30','D','10','6',NULL,'First Name ',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECENWEXFSAZ0','1','D','10','7',NULL,'Middle Initial ',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECENWEXFSAZ0','1','D','10','8',NULL,'Gender ',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECENWEXFSAZ0','1','D','10','9',NULL,'Marital Status ',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECENWEXFSAZ0','50','D','10','10',NULL,'Mothers Maiden Name ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECENWEXFSAZ0','8','D','10','11',NULL,'Date Of Birth ',NULL,NULL,'"drvDateOfBirth"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECENWEXFSAZ0','9','D','10','12',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECENWEXFSAZ0','50','D','10','13',NULL,'Address Line 1 ',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECENWEXFSAZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECENWEXFSAZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECENWEXFSAZ0','50','D','10','16',NULL,'Address Line 4 ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECENWEXFSAZ0','30','D','10','17',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECENWEXFSAZ0','2','D','10','18',NULL,'State ',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECENWEXFSAZ0','9','D','10','19',NULL,'Zip Code ',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECENWEXFSAZ0','2','D','10','20',NULL,'Country ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECENWEXFSAZ0','10','D','10','21',NULL,'Home Phone ',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECENWEXFSAZ0','10','D','10','22',NULL,'Work Phone ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECENWEXFSAZ0','6','D','10','23',NULL,'Work Phone Extension ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECENWEXFSAZ0','125','D','10','24',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECENWEXFSAZ0','100','D','10','25',NULL,'Username ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECENWEXFSAZ0','100','D','10','26',NULL,'Password ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECENWEXFSAZ0','8','D','10','27',NULL,'Hire Date ',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECENWEXFSAZ0','100','D','10','28',NULL,'Division ',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECENWEXFSAZ0','2','D','10','29',NULL,'Hours Per Week',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECENWEXFSAZ0','100','D','10','30',NULL,'Employee Class',NULL,NULL,'"E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECENWEXFSAZ0','100','D','10','31',NULL,'Payroll Frequency ',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECENWEXFSAZ0','8','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'"drvPayrollfreqEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECENWEXFSAZ0','20','D','10','33',NULL,'Participant Status ',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECENWEXFSAZ0','8','D','10','34',NULL,'StatusEffective Date ',NULL,NULL,'"drvStatusEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECENWEXFSAZ0','1','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECENWEXFSAZ0','1','D','10','36',NULL,'Hold Employer Contributions ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECENWEXFSAZ0','1','D','10','37',NULL,'Incur Services',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECENWEXFSAZ0','8','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECENWEXFSAZ0','8','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECENWEXFSAZ0','100','D','10','40',NULL,'HSA Custodian ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECENWEXFSAZ0','1','D','10','41',NULL,'Medicare Beneficiary ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECENWEXFSAZ0','12','D','10','42',NULL,'Medicare ID ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECENWEXFSAZ0','50','D','10','43',NULL,'Exchange Integration ID ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECENWEXFSAZ0','100','D','10','44',NULL,'Reporting Hierarchy Level 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECENWEXFSAZ0','100','D','10','45',NULL,'Reporting Hierarchy Level 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECENWEXFSAZ0','100','D','10','46',NULL,'Reporting Hierarchy Level 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECENWEXFSAZ0','100','D','10','47',NULL,'Reporting Hierarchy Level 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECENWEXFSAZ0','20','D','10','48',NULL,'CDD_Citizenshi p ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECENWEXFSAZ0','2','D','10','49',NULL,'CDD_Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECENWEXFSAZ0','20','D','10','50',NULL,'CDD_EmploymentStatus ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECENWEXFSAZ0','30','D','10','51',NULL,'CDD_Employer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECENWEXFSAZ0','30','D','10','52',NULL,'CDD_JobTitle ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECENWEXFSAZ0','8','D','10','53',NULL,'Class Effective Date ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECENWEXFSAZ0','20','D','10','54',NULL,'ID_Identification Type ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECENWEXFSAZ0','30','D','10','55',NULL,'ID_Identification Number ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECENWEXFSAZ0','2','D','10','56',NULL,'ID_IssuingState',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECENWEXFSAZ0','50','D','10','57',NULL,'ID_Issuer ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECENWEXFSAZ0','8','D','10','58',NULL,'ID_IssueDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECENWEXFSAZ0','8','D','10','59',NULL,'ID_ExpirationDa te ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECENWEXFSAZ0','20','D','10','60',NULL,'Mobile Carrier ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECENWEXFSAZ0','10','D','10','61',NULL,'Mobile Number',NULL,NULL,'"drvMobilenumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECENWEXFSAZ0','15','D','10','62',NULL,'Time Zone',NULL,NULL,'""','(''SS''=''''T)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENWEXFSAZ0','2','D','20','1',NULL,'Record Type ',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENWEXFSAZ0','50','D','20','2',NULL,'Participant File Import Id ',NULL,NULL,'"drvParticipantFileImportID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENWEXFSAZ0','100','D','20','3',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECENWEXFSAZ0','8','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL,'"drvEnrollmentEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECENWEXFSAZ0','8','D','20','5',NULL,'Participant Election Amount',NULL,NULL,'"drvParticipantElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECENWEXFSAZ0','8','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL,'"drvEmrollmentTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECENWEXFSAZ0','10','D','20','7',NULL,'Employer Contribution Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECENWEXFSAZ0','8','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECENWEXFSAZ0','30','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECENWEXFSAZ0','30','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECENWEXFSAZ0','1','D','20','11',NULL,'Enrolled In Claims Exchange',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECENWEXFSAZ0','8','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECENWEXFSAZ0','6','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECENWEXFSAZ0','8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECENWEXFSAZ0','1','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECENWEXFSAZ0','8','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECENWEXFSAZ0','6','D','20','17',NULL,'Time Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECENWEXFSAZ0','8','D','20','18',NULL,'Change Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECENWEXFSAZ0','1','D','20','19',NULL,'Spend Down',NULL,NULL,'""','(''SS''=''''T)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECENWEXFSAZ0','2','T','90','1',NULL,'Record Type ',NULL,NULL,'"FF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECENWEXFSAZ0','20','T','90','2',NULL,'Record Count ',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECENWEXFSAZ0','3','T','90','3',NULL,'Administrator Code ',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECENWEXFSAZ0','6','T','90','4',NULL,'Employer Code ',NULL,NULL,'"30414"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECENWEXFSAZ0','8','T','90','5',NULL,'Submitted Date ',NULL,NULL,'"drvSubmittedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECENWEXFSAZ0','6','T','90','6',NULL,'Submitted Time ',NULL,NULL,'"drvDubmittedTime"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECENWEXFSA_20221004.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210049','EMPEXPORT','OEACTIVE',NULL,'ECENWEXFSA',NULL,NULL,NULL,'202210049','Aug 24 2022  1:28PM','Aug 24 2022  1:28PM','202209021',NULL,'','','202209021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210049','EMPEXPORT','OEPASSIVE',NULL,'ECENWEXFSA',NULL,NULL,NULL,'202210049','Aug 24 2022  1:28PM','Aug 24 2022  1:28PM','202209021',NULL,'','','202209021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA Enrollment Export','202210049','EMPEXPORT','ONDEM_XOE',NULL,'ECENWEXFSA',NULL,NULL,NULL,'202210049','Aug 24 2022  1:28PM','Aug 24 2022  1:28PM','202209021',NULL,'','','202209021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA Enrollment Expor-Sched','202210049','EMPEXPORT','SCH_ECENWE',NULL,'ECENWEXFSA',NULL,NULL,NULL,'202210049','Aug 24 2022  1:28PM','Aug 24 2022  1:28PM','202209021',NULL,'','','202209021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'WEX FSA Enrollment Expor-Test','202210049','EMPEXPORT','TEST_XOE','Oct  4 2022 12:00AM','ECENWEXFSA',NULL,NULL,NULL,'202210049','Oct  4 2022 12:00AM','Dec 30 1899 12:00AM','202209021',NULL,'','','202209021',dbo.fn_GetTimedKey(),NULL,'us3cPeCEN1026',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','BCPParms','V','-c -t -r"0x0D0A"');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECENWEXFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENWEXFSA','H01','dbo.U_ECENWEXFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENWEXFSA','D10','dbo.U_ECENWEXFSA_PT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENWEXFSA','D20','dbo.U_ECENWEXFSA_EN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECENWEXFSA','T90','dbo.U_ECENWEXFSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECENWEXFSA
-----------

IF OBJECT_ID('U_dsi_BDM_ECENWEXFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECENWEXFSA] (
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
-- Create table U_ECENWEXFSA_Audit
-----------

IF OBJECT_ID('U_ECENWEXFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audEEGoal] varchar(1) NOT NULL,
    [audPayPeriod] varchar(1) NOT NULL
);

-----------
-- Create table U_ECENWEXFSA_AuditFields
-----------

IF OBJECT_ID('U_ECENWEXFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECENWEXFSA_DedList
-----------

IF OBJECT_ID('U_ECENWEXFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECENWEXFSA_EEList
-----------

IF OBJECT_ID('U_ECENWEXFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECENWEXFSA_EN_drvTbl
-----------

IF OBJECT_ID('U_ECENWEXFSA_EN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_EN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvPlanName] varchar(18) NOT NULL,
    [drvEnrollmentEffectiveDate] nvarchar(4000) NULL,
    [drvParticipantElectionAmount] money NULL,
    [drvEmrollmentTerminationDate] nvarchar(4000) NULL
);

-----------
-- Create table U_ECENWEXFSA_File
-----------

IF OBJECT_ID('U_ECENWEXFSA_File') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_ECENWEXFSA_Header
-----------

IF OBJECT_ID('U_ECENWEXFSA_Header') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_Header] (
    [drvSubmittedDate] nvarchar(4000) NULL,
    [drvSubmittedTime] nvarchar(4000) NULL
);

-----------
-- Create table U_ECENWEXFSA_PT_drvTbl
-----------

IF OBJECT_ID('U_ECENWEXFSA_PT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_PT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvDateOfBirth] nvarchar(4000) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] nvarchar(4000) NULL,
    [drvDivision] varchar(33) NULL,
    [drvPayrollFrequency] varchar(12) NULL,
    [drvPayrollfreqEffectiveDate] nvarchar(4000) NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffectiveDate] nvarchar(4000) NULL,
    [drvMobilenumber] varchar(50) NULL
);

-----------
-- Create table U_ECENWEXFSA_Trailer
-----------

IF OBJECT_ID('U_ECENWEXFSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECENWEXFSA_Trailer] (
    [drvRecordCount] varchar(10) NOT NULL,
    [drvSubmittedDate] nvarchar(4000) NULL,
    [drvDubmittedTime] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECENWEXFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Centerfield Media

Created By: Roger Bynum
Business Analyst: Cheryl Petiti
Create Date: 08/24/2022
Service Request Number: TekP-2022-07-15-01

Purpose: WEX FSA Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECENWEXFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECENWEXFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECENWEXFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECENWEXFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECENWEXFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENWEXFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENWEXFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENWEXFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENWEXFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECENWEXFSA', 'SCH_ECENWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECENWEXFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECENWEXFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECENWEXFSA';

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
    DELETE FROM dbo.U_ECENWEXFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECENWEXFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Cleans EE List of Test Employees
    DELETE FROM dbo.U_ECENWEXFSA_EEList
    WHERE EXISTS (SELECT * FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEID = xEEID AND EecEEType = 'TES')

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,DCFSA';

    IF OBJECT_ID('U_ECENWEXFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECENWEXFSA_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

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

    IF OBJECT_ID('U_ECENWEXFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_AuditFields;
    CREATE TABLE dbo.U_ECENWEXFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ECENWEXFSA_AuditFields VALUES ('EmpDed','EedEEGoalAmt');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECENWEXFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_Audit;
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
        ,audEEGoal = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedEEGoalAmt' AND CAST(audOldValue AS Money) <> CAST (audNewValue AS MONEY) AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audPayPeriod = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecPayPeriod' AND audOldValue <> audNewValue AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ECENWEXFSA_Audit
    FROM dbo.U_ECENWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ECENWEXFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -90, @EndDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND LTRIM(RTRIM(audNewValue)) = 'T'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECENWEXFSA_PT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECENWEXFSA_PT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_PT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '2_' + xEEID + '_1'
        ,drvSubSort  = '1'
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = eepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE '' END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('S','M') THEN eepMaritalStatus ELSE '' END
        ,drvDateOfBirth = FORMAT(EepDateOfBirth, 'MMddyyyy')
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN EepPhoneHomeNumber ELSE '' END
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = FORMAT(EecDateOfLastHire, 'MMddyyyy')
        ,drvDivision = CASE EecCOID WHEN 'NXZEW' THEN 'Business'
                                    WHEN 'OF1U9' THEN 'Centerfield Media Holding Company'
                                    WHEN 'ZB5J8' THEN 'DataLot'
                                    WHEN 'ZB5K6' THEN 'QuoteManage'
                                    WHEN 'C9RHG' THEN 'Savings'
                       END
        ,drvPayrollFrequency = CASE EecPayPeriod WHEN 'W' THEN 'Weekly' 
                                                 WHEN 'S' THEN 'Semi-Monthly'
                               END
        ,drvPayrollfreqEffectiveDate = CASE WHEN audPayPeriod = 'Y' THEN (select FORMAT(Max(audDateTime),'MMddyyyy')  from dbo.vw_AuditData WITH (NOLOCK) where  audKey1Label = xEEID AND audKey2Label = xCOID)  ELSE '' END
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' AND EedBenStopDate IS NOT NULL THEN FORMAT(DATEADD(Day, 1, eedBenStopDate), 'MMddyyyy')
                                       ELSE FORMAT(EecDateOfLastHire , 'MMddyyyy')
                                  END
        ,drvMobilenumber = CASE WHEN EfoPhoneType = 'CEL' THEN efoPhonenumber ELSE '' END
    INTO dbo.U_ECENWEXFSA_PT_drvTbl
    FROM dbo.U_ECENWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECENWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpDed WITH(NOLOCK)
        ON EedEEID = xEEID
        AND bdmDedCode = EedDedCode
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
    LEFT JOIN dbo.U_ECENWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audFieldName = 'EecPayPeriod'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECENWEXFSA_EN_drvTbl
    ---------------------------------
     IF OBJECT_ID('U_ECENWEXFSA_EN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_EN_drvTbl;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '2_' + xEEID + '_2'
        ,drvSubSort  = '1'
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName = 'Medical FSA'
        ,drvEnrollmentEffectiveDate = CASE WHEN (CASE WHEN audEEGoal = 'Y' THEN (select Max(EdhEffDate) from dbo.EmpHded WITH (NOLOCK) where EdhDedCode in ('FSA') And EdhEEID = xEEID) 
                                                      ELSE  BdmBenStartDate 
                                                 END)
                                           < CAST(YEAR(GETDATE()) AS CHAR(4)) + '-09-01' THEN '0901' + CAST(YEAR(GETDATE()) AS CHAR(4))
                                           ELSE FORMAT(CASE WHEN audEEGoal = 'Y' THEN (select Max(EdhEffDate) from dbo.EmpHded WITH (NOLOCK) where EdhDedCode in ('FSA') And EdhEEID = xEEID) 
                                                     ELSE  BdmBenStartDate  
                                                END, 'MMddyyyy')
                                      END
        ,drvParticipantElectionAmount = EedEEGoalAmt-- * 100
        ,drvEmrollmentTerminationDate = CASE WHEN EecEmplStatus <> 'T' AND EedBenStopDate IS NOT NULL THEN FORMAT(DATEADD(day, 1, EedBenStopDate), 'MMddyyyy') ELSE '' END
    INTO dbo.U_ECENWEXFSA_EN_drvTbl
    FROM dbo.U_ECENWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECENWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bDmDedCode = 'FSA'
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedDedCode = bdmDedCode
    LEFT JOIN dbo.U_ECENWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audFieldName = 'eedEEGoalAmt'
    
    UNION

        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '2_' + xEEID + '_2'
        ,drvSubSort  = '2'
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName = 'Dependent Care FSA'
        ,drvEnrollmentEffectiveDate = CASE WHEN CASE WHEN audEEGoal = 'Y' THEN (select Max(EdhEffDate) from dbo.EmpHded WITH (NOLOCK) where EdhDedCode in ('DCFSA') And EdhEEID = xEEID) 
                                                     ELSE  BdmBenStartDate 
                                                END
                                           < CAST(YEAR(GETDATE()) AS CHAR(4)) + '-09-01' THEN '0901' + CAST(YEAR(GETDATE()) AS CHAR(4))
                                           ELSE FORMAT(CASE WHEN audEEGoal = 'Y' THEN (select Max(EdhEffDate) from dbo.EmpHded WITH (NOLOCK) where EdhDedCode in ('DCFSA') And EdhEEID = xEEID) 
                                                     ELSE  BdmBenStartDate 
                                                END, 'MMddyyyy')
                                      END
        ,drvParticipantElectionAmount = EedEEGoalAmt --* 100
        ,drvEmrollmentTerminationDate = CASE WHEN EecEmplStatus <> 'T' AND EedBenStopDate IS NOT NULL THEN FORMAT(DATEADD(day, 1, EedBenStopDate), 'MMddyyyy') ELSE '' END
    FROM dbo.U_ECENWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECENWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmDedCode = 'DCFSA'
        JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedDedCode = bdmDedCode
    LEFT JOIN dbo.U_ECENWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audFieldName = 'eedEEGoalAmt'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECENWEXFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_Header;
    SELECT DISTINCT
         drvSubmittedDate = FORMAT(GETDATE(),'MMddyyyy')
        ,drvSubmittedTime = FORMAT(GETDATE(), 'HHmmss')
    INTO dbo.U_ECENWEXFSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECENWEXFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECENWEXFSA_Trailer;
    SELECT DISTINCT
         drvRecordCount = '          '
        ,drvSubmittedDate = FORMAT(GETDATE(),'MMddyyyy')
        ,drvDubmittedTime = FORMAT(GETDATE(), 'HHmmss')
    INTO dbo.U_ECENWEXFSA_Trailer

    DECLARE @RecordCount INT 
    SELECT @RecordCount = Count(*)
        FROM dbo.U_ECENWEXFSA_PT_drvTbl 
    SELECT @RecordCount = @RecordCount + Count(*) FROM dbo.U_ECENWEXFSA_EN_drvTbl

    UPDATE dbo.U_ECENWEXFSA_Trailer
        SET drvRecordCount = CAST(@RecordCount AS VARCHAR)
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
ALTER VIEW dbo.dsi_vwECENWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECENWEXFSA_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECENWEXFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208011'
       ,expStartPerControl     = '202208011'
       ,expLastEndPerControl   = '202209099'
       ,expEndPerControl       = '202209099'
WHERE expFormatCode = 'ECENWEXFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECENWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECENWEXFSA_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECENWEXFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECENWEXFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECENWEXFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECENWEXFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECENWEXFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECENWEXFSA', 'UseFileName', 'V', 'Y'


-- End ripout