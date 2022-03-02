/**********************************************************************************

EWEXCTREXP: WEX FSA/DepCare/HAS/T & P Export

FormatCode:     EWEXCTREXP
Project:        WEX FSA/DepCare/HAS/T & P Export
Client ID:      COA1009
Date/time:      2022-03-02 06:07:49.560
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB02
Database:       ULTIPRO_WPCOSYI
Web Filename:   COA1009_RL8W2_EEHISTORY_EWEXCTREXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWEXCTREXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EWEXCTREXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWEXCTREXP'


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
WHERE FormatCode = 'EWEXCTREXP'
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
WHERE ExpFormatCode = 'EWEXCTREXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWEXCTREXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWEXCTREXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWEXCTREXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWEXCTREXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWEXCTREXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWEXCTREXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWEXCTREXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWEXCTREXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWEXCTREXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWEXCTREXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWEXCTREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWEXCTREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWEXCTREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXCTREXP];
GO
IF OBJECT_ID('U_EWEXCTREXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_Trailer];
GO
IF OBJECT_ID('U_EWEXCTREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_PDedHist];
GO
IF OBJECT_ID('U_EWEXCTREXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_Header];
GO
IF OBJECT_ID('U_EWEXCTREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_File];
GO
IF OBJECT_ID('U_EWEXCTREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_EEList];
GO
IF OBJECT_ID('U_EWEXCTREXP_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_drvTbl_PT];
GO
IF OBJECT_ID('U_EWEXCTREXP_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_drvTbl_EN];
GO
IF OBJECT_ID('U_EWEXCTREXP_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_drvTbl_CT];
GO
IF OBJECT_ID('U_EWEXCTREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWEXCTREXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EWEXCTREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWEXCTREXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWEXCTREXP','WEX FSA/DepCare/HAS/T & P Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EWEXCTREXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXCTREXPZ0','50','H','01','1',NULL,'Record Type ',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXCTREXPZ0','50','H','01','2',NULL,'Administrator Code ',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXCTREXPZ0','50','H','01','3',NULL,'Employer Code ',NULL,NULL,'"43264"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXCTREXPZ0','50','H','01','4',NULL,'Synchronize Flag ',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXCTREXPZ0','50','H','01','5',NULL,'Submitted Date ',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXCTREXPZ0','50','H','01','6',NULL,'Submitted Time ',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXCTREXPZ0','50','H','01','7',NULL,'File Version ',NULL,NULL,'"3.5"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXCTREXPZ0','50','D','10','1',NULL,'Record Type ',NULL,NULL,'"PT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXCTREXPZ0','50','D','10','2',NULL,'Participant File Import ID ',NULL,NULL,'"drvParticipantFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXCTREXPZ0','50','D','10','3',NULL,'Employer Employee ID ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXCTREXPZ0','50','D','10','4',NULL,'Employee Number ',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXCTREXPZ0','50','D','10','5',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXCTREXPZ0','50','D','10','6',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXCTREXPZ0','50','D','10','7',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWEXCTREXPZ0','50','D','10','8',NULL,'Gender ',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWEXCTREXPZ0','50','D','10','9',NULL,'Marital Status ',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWEXCTREXPZ0','50','D','10','10',NULL,'Mothers Maiden Name ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWEXCTREXPZ0','50','D','10','11',NULL,'Date Of Birth ',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWEXCTREXPZ0','50','D','10','12',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWEXCTREXPZ0','50','D','10','13',NULL,'Address Line 1 ',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWEXCTREXPZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWEXCTREXPZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWEXCTREXPZ0','50','D','10','16',NULL,'Address Line 4 ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWEXCTREXPZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWEXCTREXPZ0','50','D','10','18',NULL,'State ',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWEXCTREXPZ0','50','D','10','19',NULL,'Zip Code ',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWEXCTREXPZ0','50','D','10','20',NULL,'Country ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWEXCTREXPZ0','50','D','10','21',NULL,'Home Phone ',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWEXCTREXPZ0','50','D','10','22',NULL,'Work Phone ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWEXCTREXPZ0','50','D','10','23',NULL,'Work Phone Extension ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWEXCTREXPZ0','50','D','10','24',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWEXCTREXPZ0','50','D','10','25',NULL,'Username ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWEXCTREXPZ0','50','D','10','26',NULL,'Password ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWEXCTREXPZ0','50','D','10','27',NULL,'Hire Date ',NULL,NULL,'"drvHireDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWEXCTREXPZ0','50','D','10','28',NULL,'Division ',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EWEXCTREXPZ0','50','D','10','29',NULL,'Hours Per Week',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EWEXCTREXPZ0','50','D','10','30',NULL,'Employee Class',NULL,NULL,'"E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EWEXCTREXPZ0','50','D','10','31',NULL,'Payroll Frequency ',NULL,NULL,'"Payroll"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EWEXCTREXPZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EWEXCTREXPZ0','50','D','10','33',NULL,'Participant Status ',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EWEXCTREXPZ0','50','D','10','34',NULL,'Status Effective Date ',NULL,NULL,'"drvStatusEffectiveDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EWEXCTREXPZ0','50','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EWEXCTREXPZ0','50','D','10','36',NULL,'Hold Employer Contributions ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EWEXCTREXPZ0','50','D','10','37',NULL,'Incur Services',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWEXCTREXPZ0','50','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'"drvFinalPayrollProcessDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EWEXCTREXPZ0','50','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'"drvFinalContribProcessDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EWEXCTREXPZ0','50','D','10','40',NULL,'HSA Custodian ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EWEXCTREXPZ0','50','D','10','41',NULL,'Medicare Beneficiary ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EWEXCTREXPZ0','50','D','10','42',NULL,'Medicare ID ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EWEXCTREXPZ0','50','D','10','43',NULL,'Exchange Integration ID ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EWEXCTREXPZ0','50','D','10','44',NULL,'Reporting Hierarchy Level 1 ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EWEXCTREXPZ0','50','D','10','45',NULL,'Reporting Hierarchy Level 2 ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EWEXCTREXPZ0','50','D','10','46',NULL,'Reporting Hierarchy Level 3 ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EWEXCTREXPZ0','50','D','10','47',NULL,'Reporting Hierarchy Level 4 ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EWEXCTREXPZ0','50','D','10','48',NULL,'CDD_Citizenship ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EWEXCTREXPZ0','50','D','10','49',NULL,'CDD_Country',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EWEXCTREXPZ0','50','D','10','50',NULL,'CDD_Employm entStatus ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EWEXCTREXPZ0','50','D','10','51',NULL,'CDD_Employer',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EWEXCTREXPZ0','50','D','10','52',NULL,'CDD_JobTitle ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EWEXCTREXPZ0','50','D','10','53',NULL,'Class Effective Date ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EWEXCTREXPZ0','50','D','10','54',NULL,'ID_Identification Type ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EWEXCTREXPZ0','50','D','10','55',NULL,'ID_Identification Number ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EWEXCTREXPZ0','50','D','10','56',NULL,'ID_IssuingState',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EWEXCTREXPZ0','50','D','10','57',NULL,'ID_Issuer ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EWEXCTREXPZ0','50','D','10','58',NULL,'ID_IssueDate',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EWEXCTREXPZ0','50','D','10','59',NULL,'ID_ExpirationDa te ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EWEXCTREXPZ0','50','D','10','60',NULL,'Mobile Carrier ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EWEXCTREXPZ0','50','D','10','61',NULL,'Mobile Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EWEXCTREXPZ0','50','D','10','62',NULL,'Time Zone',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXCTREXPZ0','50','D','20','1',NULL,'Record Type ',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXCTREXPZ0','50','D','20','2',NULL,'Participant File Import Id ',NULL,NULL,'"drvParticipantFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXCTREXPZ0','50','D','20','3',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXCTREXPZ0','50','D','20','4',NULL,'Enrollment Effective Date ',NULL,NULL,'"drvEnrollmentEffectiveDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXCTREXPZ0','50','D','20','5',NULL,'Participant Election Amount ',NULL,NULL,'"drvParticipantElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXCTREXPZ0','50','D','20','6',NULL,'Enrollment Termination Date ',NULL,NULL,'"drvEnrollmentTerminationDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXCTREXPZ0','50','D','20','7',NULL,'Employer Contribution Level ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWEXCTREXPZ0','50','D','20','8',NULL,'Employer Contribution Amount ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWEXCTREXPZ0','50','D','20','9',NULL,'Primary Reimbursement ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWEXCTREXPZ0','50','D','20','10',NULL,'Alternate Reimbursement ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWEXCTREXPZ0','50','D','20','11',NULL,'Enrolled In Claims Exchange ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWEXCTREXPZ0','50','D','20','12',NULL,'Election Amount Indicator ',NULL,NULL,'"drvElectionAmountIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWEXCTREXPZ0','50','D','20','13',NULL,'HDHP Coverage Level ',NULL,NULL,'"drvHDHPCoverageLevel"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWEXCTREXPZ0','50','D','20','14',NULL,'Plan Year Start Date ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWEXCTREXPZ0','50','D','20','15',NULL,'Terms and Conditions Accepted ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWEXCTREXPZ0','50','D','20','16',NULL,'Date Terms Conditions Accepted ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWEXCTREXPZ0','50','D','20','17',NULL,'Time Terms Conditions Accepted ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWEXCTREXPZ0','50','D','20','18',NULL,'Change Date ',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWEXCTREXPZ0','50','D','20','19',NULL,'Spend Down ',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXCTREXPZ0','50','D','30','1',NULL,'Record Type ',NULL,NULL,'"CT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXCTREXPZ0','50','D','30','2',NULL,'Participant File Import Id ',NULL,NULL,'"drvParticipantFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXCTREXPZ0','50','D','30','3',NULL,'Plan Name ',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXCTREXPZ0','50','D','30','4',NULL,'Contribution Date ',NULL,NULL,'"drvContributionDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXCTREXPZ0','50','D','30','5',NULL,'Contribution Description ',NULL,NULL,'"drvContributionDescription"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXCTREXPZ0','50','D','30','6',NULL,'Contribution Amount ',NULL,NULL,'"drvContributionAmont"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXCTREXPZ0','50','D','30','7',NULL,'Amount Type ',NULL,NULL,'"Actual"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWEXCTREXPZ0','50','D','30','8',NULL,'Tax Year ',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXCTREXPZ0','50','T','90','1',NULL,'Record Type ',NULL,NULL,'"FF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXCTREXPZ0','50','T','90','2',NULL,'Record Count ',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXCTREXPZ0','50','T','90','3',NULL,'Administrator Code ',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXCTREXPZ0','50','T','90','4',NULL,'Employer Code ',NULL,NULL,'"43264"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXCTREXPZ0','50','T','90','5',NULL,'Submitted Date ',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXCTREXPZ0','50','T','90','6',NULL,'Submitted Time ',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWEXCTREXP_20220302.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202202289','EMPEXPORT','OEACTIVE',NULL,'EWEXCTREXP',NULL,NULL,NULL,'202202289','Mar  1 2022  9:35AM','Mar  1 2022  9:35AM','202202281',NULL,'','','202202281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202202289','EMPEXPORT','OEPASSIVE',NULL,'EWEXCTREXP',NULL,NULL,NULL,'202202289','Mar  1 2022  9:35AM','Mar  1 2022  9:35AM','202202281',NULL,'','','202202281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA/DepCare/HAS/T & P Exp','202202289','EMPEXPORT','ONDEM_XOE',NULL,'EWEXCTREXP',NULL,NULL,NULL,'202202289','Mar  1 2022  9:35AM','Mar  1 2022  9:35AM','202202281',NULL,'','','202202281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA/DepCare/HAS/T & -Sched','202202289','EMPEXPORT','SCH_EWEXCT',NULL,'EWEXCTREXP',NULL,NULL,NULL,'202202289','Mar  1 2022  9:35AM','Mar  1 2022  9:35AM','202202281',NULL,'','','202202281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'WEX FSA/DepCare/HAS/T & -Test','202202289','EMPEXPORT','TEST_XOE',NULL,'EWEXCTREXP',NULL,NULL,NULL,'202202289','Mar  1 2022  9:35AM','Mar  1 2022  9:35AM','202202281',NULL,'','','202202281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXCTREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXCTREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXCTREXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXCTREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXCTREXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXCTREXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXCTREXP','H01','dbo.U_EWEXCTREXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXCTREXP','D10','dbo.U_EWEXCTREXP_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXCTREXP','D20','dbo.U_EWEXCTREXP_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXCTREXP','D30','dbo.U_EWEXCTREXP_drvTbl_CT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXCTREXP','T90','dbo.U_EWEXCTREXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EWEXCTREXP
-----------

IF OBJECT_ID('U_dsi_BDM_EWEXCTREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWEXCTREXP] (
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
-- Create table U_EWEXCTREXP_DedList
-----------

IF OBJECT_ID('U_EWEXCTREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EWEXCTREXP_drvTbl_CT
-----------

IF OBJECT_ID('U_EWEXCTREXP_drvTbl_CT') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_drvTbl_CT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticipantFileImportId] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionDescription] varchar(21) NULL,
    [drvContributionAmont] nvarchar(4000) NULL
);

-----------
-- Create table U_EWEXCTREXP_drvTbl_EN
-----------

IF OBJECT_ID('U_EWEXCTREXP_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticipantFileImportId] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvEnrollmentEffectiveDate] datetime NULL,
    [drvParticipantElectionAmount] nvarchar(4000) NULL,
    [drvEnrollmentTerminationDate] datetime NULL,
    [drvElectionAmountIndicator] varchar(8) NULL,
    [drvHDHPCoverageLevel] varchar(6) NULL
);

-----------
-- Create table U_EWEXCTREXP_drvTbl_PT
-----------

IF OBJECT_ID('U_EWEXCTREXP_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticipantFileImportId] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvDivision] varchar(36) NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvFinalPayrollProcessDate] datetime NULL,
    [drvFinalContribProcessDate] datetime NULL,
    [drvMobileNumber] varchar(50) NULL
);

-----------
-- Create table U_EWEXCTREXP_EEList
-----------

IF OBJECT_ID('U_EWEXCTREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWEXCTREXP_File
-----------

IF OBJECT_ID('U_EWEXCTREXP_File') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EWEXCTREXP_Header
-----------

IF OBJECT_ID('U_EWEXCTREXP_Header') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_Header] (
    [drvSubmittedDate] date NULL,
    [drvSubmittedTime] varchar(6) NULL
);

-----------
-- Create table U_EWEXCTREXP_PDedHist
-----------

IF OBJECT_ID('U_EWEXCTREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayDate] datetime NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSourceFSA] numeric NULL,
    [PdhSourceFSAD] numeric NULL,
    [PdhSourceFSAL] numeric NULL,
    [PdhSourceHSA] numeric NULL,
    [PdhSourceTRANS] numeric NULL,
    [PdhSourcePARK] numeric NULL
);

-----------
-- Create table U_EWEXCTREXP_Trailer
-----------

IF OBJECT_ID('U_EWEXCTREXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EWEXCTREXP_Trailer] (
    [drvRecordCount] int NULL,
    [drvSubmittedDate] date NULL,
    [drvSubmittedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXCTREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Coalfire Systems

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 03/01/2022
Service Request Number: SR-2016-00012345

Purpose: WEX FSA/DepCare/HAS/T & P Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWEXCTREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWEXCTREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWEXCTREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWEXCTREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWEXCTREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXCTREXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXCTREXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXCTREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXCTREXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXCTREXP', 'SCH_EWEXCT';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWEXCTREXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWEXCTREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWEXCTREXP';

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
    DELETE FROM dbo.U_EWEXCTREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWEXCTREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAD,FSAL,HSACF,HSACI,HSAF,HSAI,TRANS,PARK,PARKP';

    IF OBJECT_ID('U_EWEXCTREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWEXCTREXP_DedList
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
    IF OBJECT_ID('U_EWEXCTREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhPayDate = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSourceFSA        = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSourceFSAD        = SUM(CASE WHEN PdhDedCode IN ('FSAD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSourceFSAL        = SUM(CASE WHEN PdhDedCode IN ('FSAL')  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSourceHSA        = SUM(CASE WHEN PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSRF','HSAER','HSERF','HSERI')  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSourceTRANS        = SUM(CASE WHEN PdhDedCode IN ('TRANS')  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSourcePARK        = SUM(CASE WHEN PdhDedCode IN ('PARK','PARKP')  THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EWEXCTREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EWEXCTREXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWEXCTREXP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_EWEXCTREXP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportId = EepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus IN ('S','M') THEN EepMaritalStatus END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = REPLACE(REPLACE(EepAddressLine2, '  ', ' '), 'PO Box', 'Post Office Box')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfOriginalHire
        ,drvDivision =    CASE WHEN EecCOID = 'T6LB7' THEN 'Coalfire Systems Inc'
                        WHEN EecCOID = 'T6L7H' THEN 'Veris Group LLC DBA Coalfire Federal'
                        END
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
        ,drvFinalPayrollProcessDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END
        ,drvFinalContribProcessDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END
        ,drvMobileNumber = EfoPhoneNumber
    INTO dbo.U_EWEXCTREXP_drvTbl_PT
    FROM dbo.U_EWEXCTREXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWEXCTREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWEXCTREXP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EWEXCTREXP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportId = EepSSN
        ,drvPlanName =    CASE WHEN BdmDedCode = 'FSA' THEN 'Medical FSA'
                        WHEN BdmDedCode = 'FSAD' THEN 'Dependent Care FSA'
                        WHEN BdmDedCode = 'FSAL' THEN 'Limited Medical FSA'
                        WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI') THEN 'Health Savings Account'
                        WHEN BdmDedCode = 'TRANS' THEN 'Mass Transit'
                        WHEN BdmDedCode IN ('PARK','PARKP') THEN 'Parking'
                        END
        ,drvEnrollmentEffectiveDate =    CASE WHEN BdmDedCode IN ('FSA','FSAD','FSAL') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0))
                                        WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI','TRANS','PARK','PARKP') THEN dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/2022')
                                        END
        ,drvParticipantElectionAmount =    FORMAT(
                                            CASE WHEN BdmDedCode IN ('FSA','FSAD','FSAL','TRANS','PARK','PARKP') THEN BdmEEGoalAmt
                                            WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI') THEN 0.00
                                            END
                                        , '#0.00')
        ,drvEnrollmentTerminationDate =    CASE WHEN EecEmplStatus = 'T' AND BdmDedCode IN ('FSA','FSAD','FSAL, TRANS, PARK, PARKP') THEN BdmBenStopDate 
                                        END
        ,drvElectionAmountIndicator =    CASE WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI') THEN 'PerPay'
                                        WHEN BdmDedCode IN ('TRANS','PARK','PARKP') THEN 'PerMonth'
                                        END
        ,drvHDHPCoverageLevel =    CASE WHEN BdmDedCode IN ('HSACF','HSAF') THEN 'Family'
                                WHEN BdmDedCode IN ('HSACI','HSAI') THEN 'Single'
                                END
    INTO dbo.U_EWEXCTREXP_drvTbl_EN
    FROM dbo.U_EWEXCTREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EWEXCTREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWEXCTREXP_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_EWEXCTREXP_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportId = EepSSN
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('FSA') THEN 'Medical FSA'
                        WHEN BdmDedCode IN ('FSAD') THEN 'Dependent Care FSA'
                        WHEN BdmDedCode IN ('FSAL') THEN 'Limited Medical FSA'
                        WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSRF','HSAER','HSERF','HSERI') THEN 'Health Savings Account'
                        WHEN BdmDedCode IN ('TRANS') THEN 'Mass Transit'
                        WHEN BdmDedCode IN ('PARK','PARKP') THEN 'Parking'
                        END
        ,drvContributionDate = PdhPayDate
        ,drvContributionDescription =    CASE WHEN BdmDedCode IN ('FSA','FSAD','FSAL','HSACF','HSACI','HSAF','HSAI','TRANS','PARK','PARKP') THEN 'Payroll Deduction'
                                        WHEN BdmDedCode IN ('HSRF','HSAER','HSERF','HSERI') THEN 'Employer Contribution'
                                        END
        ,drvContributionAmont =    FORMAT(
                                    CASE WHEN BdmDedCode IN ('FSA') THEN PdhSourceFSA
                                    WHEN BdmDedCode IN ('FSAD') THEN PdhSourceFSAD
                                    WHEN BdmDedCode IN ('FSAL') THEN PdhSourceFSAL
                                    WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSRF','HSAER','HSERF','HSERI') THEN PdhSourceHSA
                                    WHEN BdmDedCode IN ('TRANS') THEN PdhSourceTRANS
                                    WHEN BdmDedCode IN ('PARK','PARKP') THEN PdhSourcePARK
                                    END
                                , '#0.00')
    INTO dbo.U_EWEXCTREXP_drvTbl_CT
    FROM dbo.U_EWEXCTREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWEXCTREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EWEXCTREXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;

    DELETE dbo.U_EWEXCTREXP_drvTbl_CT WHERE drvContributionAmont = '0.00';

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    DECLARE @CurrentDate DATE, @CurrentTime VARCHAR(6);

    SELECT @CurrentDate = GETDATE();
    SELECT @CurrentTime = FORMAT(GETDATE(), 'HHmmss')

    IF OBJECT_ID('U_EWEXCTREXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_Header;
    SELECT DISTINCT
         drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EWEXCTREXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWEXCTREXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXCTREXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EWEXCTREXP_drvTbl_PT) + (SELECT COUNT(*) FROM dbo.U_EWEXCTREXP_drvTbl_EN) + (SELECT COUNT(*) FROM dbo.U_EWEXCTREXP_drvTbl_CT)
        ,drvSubmittedDate = @CurrentDate
        ,drvSubmittedTime = @CurrentTime
    INTO dbo.U_EWEXCTREXP_Trailer
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
ALTER VIEW dbo.dsi_vwEWEXCTREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWEXCTREXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EWEXCTREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202281'
       ,expStartPerControl     = '202202281'
       ,expLastEndPerControl   = '202202289'
       ,expEndPerControl       = '202202289'
WHERE expFormatCode = 'EWEXCTREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWEXCTREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWEXCTREXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWEXCTREXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWEXCTREXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWEXCTREXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWEXCTREXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWEXCTREXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWEXCTREXP', 'UseFileName', 'V', 'Y'


-- End ripout