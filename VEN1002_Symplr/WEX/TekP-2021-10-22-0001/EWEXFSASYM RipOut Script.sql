/**********************************************************************************

EWEXFSASYM: WEX FSA Export

FormatCode:     EWEXFSASYM
Project:        WEX FSA Export
Client ID:      VEN1002
Date/time:      2022-04-21 06:47:21.250
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB02
Database:       ULTIPRO_WPVCR
Web Filename:   VEN1002_0A9J7_EEHISTORY_EWEXFSASYM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWEXFSASYM_SavePath') IS NOT NULL DROP TABLE dbo.U_EWEXFSASYM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWEXFSASYM'


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
WHERE FormatCode = 'EWEXFSASYM'
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
WHERE ExpFormatCode = 'EWEXFSASYM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWEXFSASYM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWEXFSASYM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWEXFSASYM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWEXFSASYM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWEXFSASYM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWEXFSASYM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWEXFSASYM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWEXFSASYM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWEXFSASYM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWEXFSASYM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWEXFSASYM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWEXFSASYM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWEXFSASYM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXFSASYM];
GO
IF OBJECT_ID('U_EWEXFSASYM_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_trlTbl];
GO
IF OBJECT_ID('U_EWEXFSASYM_PTTbl') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_PTTbl];
GO
IF OBJECT_ID('U_EWEXFSASYM_PHist') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_PHist];
GO
IF OBJECT_ID('U_EWEXFSASYM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_PEarHist];
GO
IF OBJECT_ID('U_EWEXFSASYM_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_PDedHist];
GO
IF OBJECT_ID('U_EWEXFSASYM_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_hdrTbl];
GO
IF OBJECT_ID('U_EWEXFSASYM_File') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_File];
GO
IF OBJECT_ID('U_EWEXFSASYM_ENTbl') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_ENTbl];
GO
IF OBJECT_ID('U_EWEXFSASYM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_EEList];
GO
IF OBJECT_ID('U_EWEXFSASYM_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_DedList];
GO
IF OBJECT_ID('U_EWEXFSASYM_CTTbl') IS NOT NULL DROP TABLE [dbo].[U_EWEXFSASYM_CTTbl];
GO
IF OBJECT_ID('U_dsi_BDM_EWEXFSASYM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWEXFSASYM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWEXFSASYM','WEX FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EWEXFSASYMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXFSASYMZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"hdr01RecType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXFSASYMZ0','50','H','01','2',NULL,'Administrator Code',NULL,NULL,'"hdr01AdminCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXFSASYMZ0','50','H','01','3',NULL,'Employer Code',NULL,NULL,'"hdr01EmpCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXFSASYMZ0','50','H','01','4',NULL,'Synchronize Flag',NULL,NULL,'"hdr01SyncFlag"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXFSASYMZ0','50','H','01','5',NULL,'Submitted Date',NULL,NULL,'"hdr01SubmitDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXFSASYMZ0','50','H','01','6',NULL,'Submitted Time',NULL,NULL,'"hdr01SubmitTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXFSASYMZ0','50','H','01','7',NULL,'File Version',NULL,NULL,'"hdr01FileVersion"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXFSASYMZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"drv10RecType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXFSASYMZ0','50','D','10','2',NULL,'Participant File Import ID',NULL,NULL,'"drv10PartFileId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXFSASYMZ0','50','D','10','3',NULL,'Employer Employee ID',NULL,NULL,'"drv10EmployerEmpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXFSASYMZ0','50','D','10','4',NULL,'Employee Number',NULL,NULL,'"drv10EmpNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXFSASYMZ0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drv10LName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXFSASYMZ0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drv10FName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXFSASYMZ0','50','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drv10MI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWEXFSASYMZ0','50','D','10','8',NULL,'Gender',NULL,NULL,'"drv10Gender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWEXFSASYMZ0','50','D','10','9',NULL,'Marital Status',NULL,NULL,'"drv10MaritalStat"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWEXFSASYMZ0','50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL,'"drv10MotherMN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWEXFSASYMZ0','50','D','10','11',NULL,'Date Of Birth',NULL,NULL,'"drv10DOB"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWEXFSASYMZ0','50','D','10','12',NULL,'SSN',NULL,NULL,'"drv10SSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWEXFSASYMZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL,'"drv10Add1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWEXFSASYMZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drv10Add2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWEXFSASYMZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'"drv10Add3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWEXFSASYMZ0','50','D','10','16',NULL,'Address Line 4',NULL,NULL,'"drv10Add4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWEXFSASYMZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drv10City"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWEXFSASYMZ0','50','D','10','18',NULL,'State',NULL,NULL,'"drv10State"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWEXFSASYMZ0','50','D','10','19',NULL,'Zip Code',NULL,NULL,'"drv10ZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWEXFSASYMZ0','50','D','10','20',NULL,'Country',NULL,NULL,'"drv10Country"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWEXFSASYMZ0','50','D','10','21',NULL,'Home Phone',NULL,NULL,'"drv10HPh"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWEXFSASYMZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL,'"drv10WPh"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWEXFSASYMZ0','50','D','10','23',NULL,'Work Phone Extension',NULL,NULL,'"drv10WPhExt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWEXFSASYMZ0','50','D','10','24',NULL,'Email Address',NULL,NULL,'"drv10EmailAdd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWEXFSASYMZ0','50','D','10','25',NULL,'Username',NULL,NULL,'"drv10User"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWEXFSASYMZ0','50','D','10','26',NULL,'Password',NULL,NULL,'"drv10Pass"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWEXFSASYMZ0','50','D','10','27',NULL,'Hire Date',NULL,NULL,'"drv10HireDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWEXFSASYMZ0','50','D','10','28',NULL,'Division',NULL,NULL,'"drv10Div"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EWEXFSASYMZ0','50','D','10','29',NULL,'Hours Per Week',NULL,NULL,'"drv10HrsPerWk"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EWEXFSASYMZ0','50','D','10','30',NULL,'Employee Class',NULL,NULL,'"drv10EmpClass"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EWEXFSASYMZ0','50','D','10','31',NULL,'Payroll Frequency',NULL,NULL,'"drv10PayrollFreq"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EWEXFSASYMZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'"drv10PayrollFreqEffDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EWEXFSASYMZ0','50','D','10','33',NULL,'Participant Status',NULL,NULL,'"drv10PartStat"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EWEXFSASYMZ0','50','D','10','34',NULL,'Status Effective Date',NULL,NULL,'"drv10StatEffDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EWEXFSASYMZ0','50','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'"drv10HoldPayDed"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EWEXFSASYMZ0','50','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL,'"drv10HoldEmployerCont"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EWEXFSASYMZ0','50','D','10','37',NULL,'Incur Services',NULL,NULL,'"drv10IncurServ"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWEXFSASYMZ0','50','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'"drv10FinalPayProcDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EWEXFSASYMZ0','50','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'"drv10FinalContProcDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EWEXFSASYMZ0','50','D','10','40',NULL,'HSA Custodian',NULL,NULL,'"drv10HSACust"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EWEXFSASYMZ0','50','D','10','41',NULL,'Medicare Beneficiary',NULL,NULL,'"drv10MediBen"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EWEXFSASYMZ0','50','D','10','42',NULL,'Medicare ID',NULL,NULL,'"drv10MediId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EWEXFSASYMZ0','50','D','10','43',NULL,'Exchange Integration ID',NULL,NULL,'"drv10ExIntId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EWEXFSASYMZ0','50','D','10','44',NULL,'Reporting Hierarchy Level 1',NULL,NULL,'"drv10RepLvl1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EWEXFSASYMZ0','51','D','10','45',NULL,'Reporting Hierarchy Level 2',NULL,NULL,'"drv10RepLvl2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EWEXFSASYMZ0','52','D','10','46',NULL,'Reporting Hierarchy Level 3',NULL,NULL,'"drv10RepLvl3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EWEXFSASYMZ0','53','D','10','47',NULL,'Reporting Hierarchy Level 4',NULL,NULL,'"drv10RepLvl4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EWEXFSASYMZ0','54','D','10','48',NULL,'CDD_Citizenship',NULL,NULL,'"drv10CDDCitizen"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EWEXFSASYMZ0','54','D','10','49',NULL,'CDD_Country',NULL,NULL,'"drv10CDDCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EWEXFSASYMZ0','54','D','10','50',NULL,'CDD_EmploymentStatus',NULL,NULL,'"drv10CDDEmpStat"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EWEXFSASYMZ0','54','D','10','51',NULL,'CDD_Employer',NULL,NULL,'"drv10Employer"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EWEXFSASYMZ0','54','D','10','52',NULL,'CDD_JobTitle',NULL,NULL,'"drv10JobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EWEXFSASYMZ0','54','D','10','53',NULL,'Class Effective Date',NULL,NULL,'"drv10ClassEffDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EWEXFSASYMZ0','54','D','10','54',NULL,'ID_Identification Type',NULL,NULL,'"drv10IDIdentType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EWEXFSASYMZ0','54','D','10','55',NULL,'ID_Identification Number',NULL,NULL,'"drv10IDIdentNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EWEXFSASYMZ0','54','D','10','56',NULL,'ID_IssuingState',NULL,NULL,'"drv10IDIssuingState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EWEXFSASYMZ0','54','D','10','57',NULL,'ID_Issuer',NULL,NULL,'"drv10IDIssuer"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EWEXFSASYMZ0','54','D','10','58',NULL,'ID_IssueDate',NULL,NULL,'"drv10IDIssueDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EWEXFSASYMZ0','54','D','10','59',NULL,'ID_ExpirationDate',NULL,NULL,'"drv10IDExpirationDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EWEXFSASYMZ0','54','D','10','60',NULL,'MobileCarrier',NULL,NULL,'"drv10MobileCar"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EWEXFSASYMZ0','54','D','10','61',NULL,'MobileNumber',NULL,NULL,'"drv10MobileNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EWEXFSASYMZ0','54','D','10','62',NULL,'TimeZone',NULL,NULL,'"drv10TimeZone"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXFSASYMZ0','54','D','20','1',NULL,'Record Type',NULL,NULL,'"drv20RecType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXFSASYMZ0','54','D','20','2',NULL,'Participant File Import ID',NULL,NULL,'"drv20PartFileImpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXFSASYMZ0','54','D','20','3',NULL,'Plan Name',NULL,NULL,'"drv20PlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXFSASYMZ0','54','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL,'"drv20EnrollEffDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXFSASYMZ0','54','D','20','5',NULL,'Participant Election Amount',NULL,NULL,'"drv20PartElectAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXFSASYMZ0','54','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL,'"drv20EnrollTermDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXFSASYMZ0','54','D','20','7',NULL,'Employer Contribution Level',NULL,NULL,'"drv20EmployerContribLvl"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWEXFSASYMZ0','54','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL,'"drv20EmployerContribAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWEXFSASYMZ0','54','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'"drv20PrimReimburse"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWEXFSASYMZ0','54','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'"drv20AltReimburse"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWEXFSASYMZ0','54','D','20','11',NULL,'Enrolled In Claims',NULL,NULL,'"drv20EnrolledInClaims"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWEXFSASYMZ0','54','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'"drv20ElectAmtIndic"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWEXFSASYMZ0','54','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL,'"drv20HDHPCovLvl"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWEXFSASYMZ0','54','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'"drv20PlanYearStartDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWEXFSASYMZ0','54','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL,'"drv20TermCondAccept"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWEXFSASYMZ0','54','D','20','16',NULL,'Time Terms Conditions Accepted',NULL,NULL,'"drv20TimeTermCondAccpt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWEXFSASYMZ0','54','D','20','17',NULL,'Change Date',NULL,NULL,'"drv20ChangeDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWEXFSASYMZ0','54','D','20','18',NULL,'Spend Down',NULL,NULL,'"drv20SpendDown"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXFSASYMZ0','54','D','30','1',NULL,'Record Type',NULL,NULL,'"drv30RecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXFSASYMZ0','54','D','30','2',NULL,'Participant File Import ID',NULL,NULL,'"drv30PartFileImpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXFSASYMZ0','54','D','30','3',NULL,'Plan Name',NULL,NULL,'"drv30PlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXFSASYMZ0','54','D','30','4',NULL,'Contribution Date',NULL,NULL,'"drv30ContDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXFSASYMZ0','54','D','30','5',NULL,'Contribution Description',NULL,NULL,'"drv30ContDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXFSASYMZ0','54','D','30','6',NULL,'Contribution Amount',NULL,NULL,'"drv30ContAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWEXFSASYMZ0','54','D','30','7',NULL,'Amount Type',NULL,NULL,'"drv30AmtType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWEXFSASYMZ0','54','D','30','8',NULL,'Tax Year',NULL,NULL,'"drv30TaxYear"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWEXFSASYMZ0','54','T','90','1',NULL,'Record Type',NULL,NULL,'"trl90RecType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWEXFSASYMZ0','54','T','90','2',NULL,'Record Count',NULL,NULL,'"trl90RecCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWEXFSASYMZ0','54','T','90','3',NULL,'Administrator Code',NULL,NULL,'"trl90AdminCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWEXFSASYMZ0','54','T','90','4',NULL,'Employer Code',NULL,NULL,'"trl90EmpCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWEXFSASYMZ0','54','T','90','5',NULL,'Submitted Date',NULL,NULL,'"trl90SubmitDt"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWEXFSASYMZ0','54','T','90','6',NULL,'Submitted Time',NULL,NULL,'"trl90SubmitTime"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWEXFSASYM_20220421.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA Export','202201279','EMPEXPORT','ONDEM_XOE',NULL,'EWEXFSASYM',NULL,NULL,NULL,'202201279','Jan 27 2022  9:19PM','Jan 27 2022  9:19PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA Export-Sched','202201279','EMPEXPORT','SCH_EWEXFS',NULL,'EWEXFSASYM',NULL,NULL,NULL,'202201279','Jan 27 2022  9:19PM','Jan 27 2022  9:19PM','202201271',NULL,'','','202201271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'WEX FSA Export-Test','202204159','EMPEXPORT','TEST_XOE','Apr 12 2022  4:46PM','EWEXFSASYM',NULL,NULL,NULL,'202204159','Apr 15 2022 12:00AM','Dec 30 1899 12:00AM','202204081','885','','','202204081',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWEXFSASYM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXFSASYM','H01','dbo.U_EWEXFSASYM_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXFSASYM','D10','dbo.U_EWEXFSASYM_PTTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXFSASYM','D20','dbo.U_EWEXFSASYM_ENTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXFSASYM','D30','dbo.U_EWEXFSASYM_CTTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWEXFSASYM','T90','dbo.U_EWEXFSASYM_trlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EWEXFSASYM
-----------

IF OBJECT_ID('U_dsi_BDM_EWEXFSASYM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWEXFSASYM] (
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
-- Create table U_EWEXFSASYM_CTTbl
-----------

IF OBJECT_ID('U_EWEXFSASYM_CTTbl') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_CTTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drv30RecordType] varchar(2) NOT NULL,
    [drv30PartFileImpId] char(11) NULL,
    [drv30PlanName] varchar(18) NOT NULL,
    [drv30ContDt] datetime NULL,
    [drv30ContDesc] varchar(17) NOT NULL,
    [drv30ContAmt] varchar(30) NULL,
    [drv30AmtType] varchar(6) NOT NULL,
    [drv30TaxYear] varchar(7) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EWEXFSASYM_DedList
-----------

IF OBJECT_ID('U_EWEXFSASYM_DedList') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EWEXFSASYM_EEList
-----------

IF OBJECT_ID('U_EWEXFSASYM_EEList') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWEXFSASYM_ENTbl
-----------

IF OBJECT_ID('U_EWEXFSASYM_ENTbl') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_ENTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drv20RecType] varchar(2) NOT NULL,
    [drv20PartFileImpId] char(11) NULL,
    [drv20PlanName] varchar(18) NULL,
    [drv20EnrollEffDt] datetime NULL,
    [drv20PartElectAmt] money NULL,
    [drv20EnrollTermDt] varchar(30) NOT NULL,
    [drv20EmployerContribLvl] varchar(1) NOT NULL,
    [drv20EmployerContribAmt] varchar(1) NOT NULL,
    [drv20PrimReimburse] varchar(1) NOT NULL,
    [drv20AltReimburse] varchar(1) NOT NULL,
    [drv20EnrolledInClaims] varchar(1) NOT NULL,
    [drv20ElectAmtIndic] varchar(1) NOT NULL,
    [drv20HDHPCovLvl] varchar(1) NOT NULL,
    [drv20PlanYearStartDt] varchar(1) NOT NULL,
    [drv20TermCondAccept] varchar(1) NOT NULL,
    [drv20TimeTermCondAccpt] varchar(1) NOT NULL,
    [drv20ChangeDt] varchar(1) NOT NULL,
    [drv20SpendDown] varchar(1) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EWEXFSASYM_File
-----------

IF OBJECT_ID('U_EWEXFSASYM_File') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EWEXFSASYM_hdrTbl
-----------

IF OBJECT_ID('U_EWEXFSASYM_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_hdrTbl] (
    [hdr01RecType] varchar(2) NOT NULL,
    [hdr01AdminCode] varchar(3) NOT NULL,
    [hdr01EmpCode] varchar(5) NOT NULL,
    [hdr01SyncFlag] varchar(1) NOT NULL,
    [hdr01SubmitDt] datetime NOT NULL,
    [hdr01SubmitTime] varchar(10) NULL,
    [hdr01FileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_EWEXFSASYM_PDedHist
-----------

IF OBJECT_ID('U_EWEXFSASYM_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
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
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EWEXFSASYM_PEarHist
-----------

IF OBJECT_ID('U_EWEXFSASYM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL
);

-----------
-- Create table U_EWEXFSASYM_PHist
-----------

IF OBJECT_ID('U_EWEXFSASYM_PHist') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_PHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL
);

-----------
-- Create table U_EWEXFSASYM_PTTbl
-----------

IF OBJECT_ID('U_EWEXFSASYM_PTTbl') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_PTTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drv10RecType] varchar(2) NOT NULL,
    [drv10PartFileId] char(11) NULL,
    [drv10EmployerEmpId] varchar(1) NOT NULL,
    [drv10EmpNum] char(9) NULL,
    [drv10LName] varchar(100) NULL,
    [drv10FName] varchar(100) NULL,
    [drv10MI] varchar(1) NULL,
    [drv10Gender] char(1) NULL,
    [drv10MaritalStat] varchar(1) NOT NULL,
    [drv10MotherMN] varchar(1) NOT NULL,
    [drv10DOB] datetime NULL,
    [drv10SSN] char(11) NULL,
    [drv10Add1] varchar(255) NULL,
    [drv10Add2] varchar(255) NULL,
    [drv10Add3] varchar(1) NOT NULL,
    [drv10Add4] varchar(1) NOT NULL,
    [drv10City] varchar(255) NULL,
    [drv10State] varchar(255) NULL,
    [drv10ZipCode] varchar(50) NULL,
    [drv10Country] varchar(2) NOT NULL,
    [drv10HPh] varchar(1) NOT NULL,
    [drv10WPh] varchar(1) NOT NULL,
    [drv10WPhExt] varchar(1) NOT NULL,
    [drv10EmailAdd] varchar(50) NULL,
    [drv10User] varchar(1) NOT NULL,
    [drv10Pass] varchar(1) NOT NULL,
    [drv10HireDt] datetime NULL,
    [drv10Div] varchar(1) NOT NULL,
    [drv10HrsPerWk] varchar(1) NOT NULL,
    [drv10EmpClass] varchar(1) NOT NULL,
    [drv10PayrollFreq] varchar(7) NOT NULL,
    [drv10PayrollFreqEffDt] varchar(1) NOT NULL,
    [drv10PartStat] varchar(10) NOT NULL,
    [drv10StatEffDt] datetime NULL,
    [drv10HoldPayDed] varchar(1) NOT NULL,
    [drv10HoldEmployerCont] varchar(1) NOT NULL,
    [drv10IncurServ] varchar(1) NOT NULL,
    [drv10FinalPayProcDt] varchar(30) NOT NULL,
    [drv10FinalContProcDt] varchar(30) NOT NULL,
    [drv10HSACust] varchar(1) NOT NULL,
    [drv10MediBen] varchar(1) NOT NULL,
    [drv10MediId] varchar(1) NOT NULL,
    [drv10ExIntId] varchar(1) NOT NULL,
    [drv10RepLvl1] varchar(1) NOT NULL,
    [drv10RepLvl2] varchar(1) NOT NULL,
    [drv10RepLvl3] varchar(1) NOT NULL,
    [drv10RepLvl4] varchar(1) NOT NULL,
    [drv10CDDCitizen] varchar(1) NOT NULL,
    [drv10CDDCountry] char(3) NULL,
    [drv10CDDEmpStat] varchar(1) NOT NULL,
    [drv10Employer] varchar(1) NOT NULL,
    [drv10JobTitle] varchar(1) NOT NULL,
    [drv10ClassEffDt] varchar(1) NOT NULL,
    [drv10IDIdentType] varchar(1) NOT NULL,
    [drv10IDIdentNum] varchar(1) NOT NULL,
    [drv10IDIssuingState] varchar(255) NULL,
    [drv10IDIssuer] varchar(1) NOT NULL,
    [drv10IDIssueDt] varchar(1) NOT NULL,
    [drv10IDExpirationDt] varchar(1) NOT NULL,
    [drv10MobileCar] varchar(1) NOT NULL,
    [drv10MobileNum] varchar(1) NOT NULL,
    [drv10TimeZone] varchar(1) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EWEXFSASYM_trlTbl
-----------

IF OBJECT_ID('U_EWEXFSASYM_trlTbl') IS NULL
CREATE TABLE [dbo].[U_EWEXFSASYM_trlTbl] (
    [trl90RecType] varchar(2) NOT NULL,
    [trl90RecCount] int NULL,
    [trl90AdminCode] varchar(3) NOT NULL,
    [trl90EmpCode] varchar(5) NOT NULL,
    [trl90SubmitDt] datetime NOT NULL,
    [trl90SubmitTime] varchar(10) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWEXFSASYM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 01/27/2022
Service Request Number: TekP-2021-10-22-0001

Purpose: WEX FSA Export

Revision History
----------------
02/07/2022 by AP:
    - Fixed sort order of PT, EN, CT.
    - Status effective date format change.
    - Enrollment effective date format change.
    - FSADC fix for dependent lines in EN.
    - Contribution date changed to PrgPayDate.
    - Breakout of deduction applied by grouping by PdhDedCode.

02/17/2022 by AP:
    - Removed "IsValidExport" from empdeductions tables to make sure we don't exclude term employees.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWEXFSASYM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWEXFSASYM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWEXFSASYM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWEXFSASYM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWEXFSASYM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXFSASYM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXFSASYM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWEXFSASYM', 'SCH_EWEXFS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWEXFSASYM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWEXFSASYM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWEXFSASYM';

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
    DELETE FROM dbo.U_EWEXFSASYM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWEXFSASYM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC';

    IF OBJECT_ID('U_EWEXFSASYM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWEXFSASYM_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EWEXFSASYM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EWEXFSASYM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EWEXFSASYM_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    IF OBJECT_ID('U_EWEXFSASYM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_PEarHist;

    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
    INTO dbo.U_EWEXFSASYM_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID--,PrgPayGroup
    HAVING SUM(PehCurAmt) <> 0.00;



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWEXFSASYM_PTTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_PTTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_PTTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv10RecType = 'PT'
        ,drv10PartFileId = EepSSN
        ,drv10EmployerEmpId = ''
        ,drv10EmpNum = EecEmpNo
        ,drv10LName = EepNameLast
        ,drv10FName = EepNameFirst
        ,drv10MI = LEFT(EepNameMiddle, 1)
        ,drv10Gender = EepGender
        ,drv10MaritalStat = ''
        ,drv10MotherMN = ''
        ,drv10DOB = EepDateOfBirth
        ,drv10SSN = EepSSN
        ,drv10Add1 = EepAddressLine1
        ,drv10Add2 = EepAddressLine2
        ,drv10Add3 = ''
        ,drv10Add4 = ''
        ,drv10City = EepAddressCity
        ,drv10State = EepAddressState
        ,drv10ZipCode = EepAddressZipCode
        ,drv10Country = 'US'
        ,drv10HPh = ''
        ,drv10WPh = ''
        ,drv10WPhExt = ''
        ,drv10EmailAdd = EepAddressEMail
        ,drv10User = ''
        ,drv10Pass = ''
        ,drv10HireDt = EecDateOfLastHire
        ,drv10Div = ''
        ,drv10HrsPerWk = ''
        ,drv10EmpClass = 'E'
        ,drv10PayrollFreq = 'Payroll'
        ,drv10PayrollFreqEffDt = ''
        ,drv10PartStat = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' ELSE 'Active' END
        ,drv10StatEffDt = CASE WHEN EecEmplStatus = 'T' THEN EedBenStopDate + 1 ELSE EecDateOfLastHire END
        ,drv10HoldPayDed = ''
        ,drv10HoldEmployerCont = ''
        ,drv10IncurServ = ''
        ,drv10FinalPayProcDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END), 101), '')
        ,drv10FinalContProcDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination) END), 101), '')
        ,drv10HSACust = ''
        ,drv10MediBen = ''
        ,drv10MediId = ''
        ,drv10ExIntId = ''
        ,drv10RepLvl1 = ''
        ,drv10RepLvl2 = ''
        ,drv10RepLvl3 = ''
        ,drv10RepLvl4 = ''
        ,drv10CDDCitizen = ''
        ,drv10CDDCountry = EepAddressCountry
        ,drv10CDDEmpStat = ''
        ,drv10Employer = ''
        ,drv10JobTitle = ''
        ,drv10ClassEffDt = ''
        ,drv10IDIdentType = ''
        ,drv10IDIdentNum = ''
        ,drv10IDIssuingState = EepAddressState
        ,drv10IDIssuer = ''
        ,drv10IDIssueDt = ''
        ,drv10IDExpirationDt = ''
        ,drv10MobileCar = ''
        ,drv10MobileNum = ''
        ,drv10TimeZone = ''
        ,drvInitialSort = '1' + LTRIM(RTRIM(EepSSN))
        ,drvSubSort = '1' 
    INTO dbo.U_EWEXFSASYM_PTTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK) 
    ON xEEID = EepEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
    ON EecEEID = xEEID
    AND EecCOID = xCOID
--    JOIN dbo.U_EWEXFSASYM_PDedHist WITH(NOLOCK)
--    ON PdhEEID = xEEID
--    AND PdhCOID = xCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON EedEEID = xEEID
    AND EedCOID = xCOID
    AND EedFormatCode = @FormatCode
    AND (EedValidForExport = 'Y' OR EedDedRowStatus = 'Deduction Termed') -- VALUE CAUSING TERMED EMPLOYEES NOT TO LOAD ON FINAL PAY
    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWEXFSASYM_ENTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_ENTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_ENTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv20RecType = 'EN'
        ,drv20PartFileImpId = EepSSN
        ,drv20PlanName = CASE WHEN EedDedCode = 'FSA' THEN 'Medical FSA'
                                WHEN EedDedCode = 'FSADC' THEN 'Dependent Care FSA' END
        ,drv20EnrollEffDt = EedBenStartDate
        ,drv20PartElectAmt = EedEEGoalAmt
        ,drv20EnrollTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus <> 'T' THEN EedBenStopDate END), 101), '')
        ,drv20EmployerContribLvl = ''
        ,drv20EmployerContribAmt = ''
        ,drv20PrimReimburse = ''
        ,drv20AltReimburse = ''
        ,drv20EnrolledInClaims = ''
        ,drv20ElectAmtIndic = ''
        ,drv20HDHPCovLvl = ''
        ,drv20PlanYearStartDt = ''   --'0101' + CAST(YEAR(GETDATE()) AS VARCHAR)
        ,drv20TermCondAccept = ''
        ,drv20TimeTermCondAccpt = ''
        ,drv20ChangeDt = ''
        ,drv20SpendDown = ''
        ,drvInitialSort
        ,drvSubSort = '2'
    INTO dbo.U_EWEXFSASYM_ENTbl
    FROM dbo.U_EWEXFSASYM_PTTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK) 
    ON drvEEID = EepEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
    ON EecEEID = drvEEID
    AND EecCOID = drvCOID
--    JOIN dbo.U_EWEXFSASYM_PDedHist WITH(NOLOCK)
--    ON PdhEEID = drvEEID
--    AND PdhCOID = drvCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON EedEEID = drvEEID
    AND EedCOID = drvCOID
    AND EedFormatCode = @FormatCode
    AND (EedValidForExport = 'Y' OR EedDedRowStatus = 'Deduction Termed') -- VALUE CAUSING TERMED EMPLOYEES NOT TO LOAD ON FINAL PAY
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWEXFSASYM_CTTbl
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_CTTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_CTTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drv30RecordType = 'CT'
        ,drv30PartFileImpId = EepSSN
        ,drv30PlanName = CASE WHEN EedDedCode = 'FSA' THEN 'Medical FSA' ELSE 'Dependent Care FSA' END
        ,drv30ContDt = PrgPayDate
        ,drv30ContDesc = 'Payroll Deduction'
        ,drv30ContAmt = CAST(CAST(PdhEECurAmt AS DECIMAL(10,2)) AS VARCHAR)
        ,drv30AmtType = 'Actual'
        ,drv30TaxYear = 'Current'
        ,drvInitialSort
        ,drvSubSort = '3'
    INTO dbo.U_EWEXFSASYM_CTTbl
    FROM dbo.U_EWEXFSASYM_PTTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK) 
    ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
    ON EecEEID = drvEEID
    AND EecCOID = drvCOID
    JOIN dbo.U_EWEXFSASYM_PEarHist WITH(NOLOCK)
    ON PehEEID = drvEEID
    AND PehCOID = drvCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON EedEEID = drvEEID
    AND EedCOID = drvCOID
    AND EedFormatCode = @FormatCode
    AND (EedValidForExport = 'Y' OR EedDedRowStatus = 'Deduction Termed') -- VALUE CAUSING TERMED EMPLOYEES NOT TO LOAD ON FINAL PAY
    JOIN dbo.U_EWEXFSASYM_PDedHist WITH(NOLOCK)
    ON PdhEEID = drvEEID
    AND PdhCOID = drvCOID
    AND PdhDedCode = EedDedCode
    --JOIN dbo.PayGroup WITH(NOLOCK)
    --ON PgrPayGroup = EecPayGroup
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_hdrTbl;
    SELECT DISTINCT
         hdr01RecType = 'FH'
        ,hdr01AdminCode = 'DBI'
        ,hdr01EmpCode = '43104'
        ,hdr01SyncFlag = 'N'
        ,hdr01SubmitDt = GETDATE()
        ,hdr01SubmitTime = CONVERT(VARCHAR(10), GETDATE(), 108)
        ,hdr01FileVersion = '3.5'
    INTO dbo.U_EWEXFSASYM_hdrTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EWEXFSASYM_trlTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWEXFSASYM_trlTbl;
    SELECT DISTINCT
         trl90RecType = 'FF'
        ,trl90RecCount = (SELECT COUNT(1) FROM dbo.U_EWEXFSASYM_PTTbl WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_EWEXFSASYM_ENTbl WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_EWEXFSASYM_CTTbl WITH(NOLOCK)) 
        ,trl90AdminCode = 'DBI'
        ,trl90EmpCode = '43104'
        ,trl90SubmitDt = GETDATE()
        ,trl90SubmitTime = CONVERT(VARCHAR(10), GETDATE(), 108)
    INTO dbo.U_EWEXFSASYM_trlTbl
    FROM dbo.U_EWEXFSASYM_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEWEXFSASYM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWEXFSASYM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EWEXFSASYM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201201'
       ,expStartPerControl     = '202201201'
       ,expLastEndPerControl   = '202201279'
       ,expEndPerControl       = '202201279'
WHERE expFormatCode = 'EWEXFSASYM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWEXFSASYM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EWEXFSASYM_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWEXFSASYM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWEXFSASYM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWEXFSASYM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWEXFSASYM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWEXFSASYM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWEXFSASYM', 'UseFileName', 'V', 'Y'


-- End ripout