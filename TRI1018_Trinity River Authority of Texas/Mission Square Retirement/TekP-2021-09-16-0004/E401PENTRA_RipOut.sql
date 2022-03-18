/**********************************************************************************

E401PENTRA: 401a Pension Elig Export

FormatCode:     E401PENTRA
Project:        401a Pension Elig Export
Client ID:      TRI1018
Date/time:      2021-12-15 23:16:32.600
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP4DB02
Database:       ULTIPRO_WPTRNTY
Web Filename:   TRI1018_9B2D2_EEHISTORY_E401PENTRA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_E401PENTRA_SavePath') IS NOT NULL DROP TABLE dbo.U_E401PENTRA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'E401PENTRA'


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
WHERE FormatCode = 'E401PENTRA'
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
WHERE ExpFormatCode = 'E401PENTRA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'E401PENTRA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'E401PENTRA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'E401PENTRA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'E401PENTRA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'E401PENTRA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'E401PENTRA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'E401PENTRA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'E401PENTRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'E401PENTRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'E401PENTRA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwE401PENTRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwE401PENTRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_E401PENTRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E401PENTRA];
GO
IF OBJECT_ID('U_E401PENTRA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_PDedHist];
GO
IF OBJECT_ID('U_E401PENTRA_File') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_File];
GO
IF OBJECT_ID('U_E401PENTRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_EEList];
GO
IF OBJECT_ID('U_E401PENTRA_drvTermTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvTermTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvTerm') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvTerm];
GO
IF OBJECT_ID('U_E401PENTRA_drvRehireTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvRehireTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvRehire') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvRehire];
GO
IF OBJECT_ID('U_E401PENTRA_drvNewEnrollTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvNewEnrollTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvNewEnroll') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvNewEnroll];
GO
IF OBJECT_ID('U_E401PENTRA_drvMaintTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvMaintTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvMaintData') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvMaintData];
GO
IF OBJECT_ID('U_E401PENTRA_drvGTTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvGTTrl];
GO
IF OBJECT_ID('U_E401PENTRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_DedList];
GO
IF OBJECT_ID('U_E401PENTRA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_AuditFields];
GO
IF OBJECT_ID('U_E401PENTRA_Audit') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_E401PENTRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_E401PENTRA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','E401PENTRA','401a Pension Elig Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','500','S','N','E401PENTRAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','10','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','10','7',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','10','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','10','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','30','D','10','26',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E401PENTRAZ0','12','D','10','56',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E401PENTRAZ0','3','D','10','68',NULL,'Foreign Address Code',NULL,NULL,'"drvForeignAddressCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E401PENTRAZ0','30','D','10','71',NULL,'Address Line 1',NULL,NULL,'"drvAdd1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E401PENTRAZ0','30','D','10','101',NULL,'Address Line 2',NULL,NULL,'"drvAdd2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E401PENTRAZ0','18','D','10','131',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E401PENTRAZ0','3','D','10','149',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E401PENTRAZ0','9','D','10','152',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E401PENTRAZ0','1','D','10','161',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E401PENTRAZ0','8','D','10','162',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E401PENTRAZ0','8','D','10','170',NULL,'Date of Hire',NULL,NULL,'"drvDOH"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E401PENTRAZ0','8','D','10','178',NULL,'Eligible Plan Entry',NULL,NULL,'"drvEligPlanEntry"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E401PENTRAZ0','1','D','10','186',NULL,'Marital Status',NULL,NULL,'"drvMaritalStat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E401PENTRAZ0','12','D','10','187',NULL,'Home Phone #',NULL,NULL,'"drvHomePh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E401PENTRAZ0','2','D','10','199',NULL,'Status Code',NULL,NULL,'"drvStatCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E401PENTRAZ0','32','D','10','201',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E401PENTRAZ0','12','D','10','233',NULL,'Work Phone #',NULL,NULL,'"drvWorkPh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E401PENTRAZ0','26','D','10','245',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E401PENTRAZ0','4','D','10','271',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E401PENTRAZ0','11','D','10','275',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E401PENTRAZ0','60','D','10','286',NULL,'Email Address',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E401PENTRAZ0','155','D','10','346',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','20','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','20','7',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','20','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','20','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','475','D','20','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','30','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','30','7',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','30','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','30','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','30','D','30','26',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E401PENTRAZ0','12','D','30','56',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E401PENTRAZ0','3','D','30','68',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E401PENTRAZ0','30','D','30','71',NULL,'Address Line 1',NULL,NULL,'"drvAdd1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E401PENTRAZ0','30','D','30','101',NULL,'Address Line 2',NULL,NULL,'"drvAdd2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E401PENTRAZ0','18','D','30','131',NULL,'City',NULL,NULL,'"drvCit"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E401PENTRAZ0','3','D','30','149',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E401PENTRAZ0','9','D','30','152',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E401PENTRAZ0','1','D','30','161',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E401PENTRAZ0','8','D','30','162',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E401PENTRAZ0','8','D','30','170',NULL,'Date of Hire',NULL,NULL,'"drvDOH"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E401PENTRAZ0','8','D','30','178',NULL,'Plan Entry Date',NULL,NULL,'"drvPlanEntryDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E401PENTRAZ0','1','D','30','186',NULL,'Marital Status',NULL,NULL,'"drvMaritalStat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E401PENTRAZ0','12','D','30','187',NULL,'Home Phone #',NULL,NULL,'"drvHomePh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E401PENTRAZ0','2','D','30','199',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E401PENTRAZ0','32','D','30','201',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E401PENTRAZ0','12','D','30','233',NULL,'Work Phone #',NULL,NULL,'"drvWorkPh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E401PENTRAZ0','26','D','30','245',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E401PENTRAZ0','4','D','30','271',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E401PENTRAZ0','11','D','30','275',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E401PENTRAZ0','60','D','30','286',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E401PENTRAZ0','8','D','30','346',NULL,'Pre-Tax Deferral Amt',NULL,NULL,'"drvPreTaxDefAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','E401PENTRAZ0','8','D','30','354',NULL,'Pre-Tax Deferral Percent',NULL,NULL,'"drvPreTaxDefPrcnt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','E401PENTRAZ0','8','D','30','362',NULL,'Post-Tax Deferral Amt',NULL,NULL,'"drvPostTaxDefAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','E401PENTRAZ0','8','D','30','370',NULL,'Post-Tax Deferral Percent',NULL,NULL,'"drvPostTaxDefPrcnt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','E401PENTRAZ0','123','D','30','378',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','40','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','40','7',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','40','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','40','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','475','D','40','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','50','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','50','7',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','50','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','50','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','45','D','50','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E401PENTRAZ0','30','D','50','71',NULL,'Address Line 1',NULL,NULL,'"drvAdd1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E401PENTRAZ0','30','D','50','101',NULL,'Address Line 2',NULL,NULL,'"drvAdd2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E401PENTRAZ0','18','D','50','131',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E401PENTRAZ0','3','D','50','149',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E401PENTRAZ0','9','D','50','152',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E401PENTRAZ0','1','D','50','161',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E401PENTRAZ0','8','D','50','162',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E401PENTRAZ0','29','D','50','170',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E401PENTRAZ0','8','D','50','199',NULL,'Status Code',NULL,NULL,'"drvStatCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E401PENTRAZ0','8','D','50','207',NULL,'Date of Separation',NULL,NULL,'"drvDateOfSep"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E401PENTRAZ0','1','D','50','215',NULL,'Term Reason Code',NULL,NULL,'"drvTermReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E401PENTRAZ0','276','D','50','216',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','60','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','60','7',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','60','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','60','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','475','D','60','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','70','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','70','7',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','70','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','70','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','30','D','70','26',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E401PENTRAZ0','12','D','70','56',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E401PENTRAZ0','3','D','70','68',NULL,'Foreign Address Code',NULL,NULL,'"drvForeignAddressCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E401PENTRAZ0','30','D','70','71',NULL,'Address Line 1',NULL,NULL,'"drvAdd1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E401PENTRAZ0','30','D','70','101',NULL,'Address Line 2',NULL,NULL,'"drvAdd2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E401PENTRAZ0','18','D','70','131',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E401PENTRAZ0','3','D','70','149',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E401PENTRAZ0','9','D','70','152',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E401PENTRAZ0','1','D','70','161',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E401PENTRAZ0','8','D','70','162',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E401PENTRAZ0','8','D','70','170',NULL,'Date of Hire',NULL,NULL,'"drvDOH"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E401PENTRAZ0','8','D','70','178',NULL,'Eligible Plan Entry',NULL,NULL,'"drvEligPlanEntry"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E401PENTRAZ0','1','D','70','186',NULL,'Marital Status',NULL,NULL,'"drvMaritalStat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E401PENTRAZ0','12','D','70','187',NULL,'Home Phone #',NULL,NULL,'"drvHomePh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E401PENTRAZ0','2','D','70','199',NULL,'Status Code',NULL,NULL,'"drvStatCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E401PENTRAZ0','32','D','70','201',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E401PENTRAZ0','12','D','70','233',NULL,'Work Phone #',NULL,NULL,'"drvWorkPh"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E401PENTRAZ0','26','D','70','245',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E401PENTRAZ0','4','D','70','271',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E401PENTRAZ0','11','D','70','275',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E401PENTRAZ0','215','D','70','286',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','D','80','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','D','80','7',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','D','80','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','D','80','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','475','D','80','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E401PENTRAZ0','6','T','90','1',NULL,'ICMA-RC Plan Number',NULL,NULL,'"drvRCPlanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E401PENTRAZ0','9','T','90','7',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E401PENTRAZ0','9','T','90','16',NULL,'Sequence #',NULL,NULL,'"drvSeqNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E401PENTRAZ0','1','T','90','25',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E401PENTRAZ0','475','T','90','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'E401PENTRA_20211215.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'401a Pension Elig Export','202110269','EMPEXPORT','ONDEM_XOE',NULL,'E401PENTRA',NULL,NULL,NULL,'202110269','Oct 26 2021  5:03PM','Oct 26 2021  5:03PM','202110261',NULL,'','','202110261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'401a Pension Elig Export-Sched','202110269','EMPEXPORT','SCH_E401PE',NULL,'E401PENTRA',NULL,NULL,NULL,'202110269','Oct 26 2021  5:03PM','Oct 26 2021  5:03PM','202110261',NULL,'','','202110261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'401a Pension Elig Export-Test','202112149','EMPEXPORT','TEST_XOE','Dec 14 2021 11:38AM','E401PENTRA',NULL,NULL,NULL,'202112149','Dec 14 2021 12:00AM','Dec 30 1899 12:00AM','202108011','511','','','202108011',dbo.fn_GetTimedKey(),NULL,'us3lKiTRI1018',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D10','dbo.U_E401PENTRA_drvNewEnroll',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D20','dbo.U_E401PENTRA_drvNewEnrollTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D30','dbo.U_E401PENTRA_drvMaintData',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D40','dbo.U_E401PENTRA_drvMaintTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D50','dbo.U_E401PENTRA_drvTerm',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D60','dbo.U_E401PENTRA_drvTermTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D70','dbo.U_E401PENTRA_drvRehire',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D80','dbo.U_E401PENTRA_drvRehireTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','T90','dbo.U_E401PENTRA_drvGTTrl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_E401PENTRA
-----------

IF OBJECT_ID('U_dsi_BDM_E401PENTRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_E401PENTRA] (
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
-- Create table U_E401PENTRA_Audit
-----------

IF OBJECT_ID('U_E401PENTRA_Audit') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_Audit] (
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
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audBenefitChange] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_AuditFields
-----------

IF OBJECT_ID('U_E401PENTRA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_E401PENTRA_DedList
-----------

IF OBJECT_ID('U_E401PENTRA_DedList') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvGTTrl
-----------

IF OBJECT_ID('U_E401PENTRA_drvGTTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvGTTrl] (
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvSSN] varchar(9) NOT NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvMaintData
-----------

IF OBJECT_ID('U_E401PENTRA_drvMaintData') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvMaintData] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvPartName] varchar(204) NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCit] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvBirthDate] datetime NULL,
    [drvDOH] datetime NULL,
    [drvPlanEntryDt] datetime NULL,
    [drvMaritalStat] varchar(1) NOT NULL,
    [drvHomePh] varchar(12) NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvSalary] varchar(11) NULL,
    [drvPreTaxDefAmt] varchar(1) NOT NULL,
    [drvPreTaxDefPrcnt] varchar(1) NOT NULL,
    [drvPostTaxDefAmt] varchar(1) NOT NULL,
    [drvPostTaxDefPrcnt] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvMaintTrl
-----------

IF OBJECT_ID('U_E401PENTRA_drvMaintTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvMaintTrl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvSSN] varchar(9) NOT NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvNewEnroll
-----------

IF OBJECT_ID('U_E401PENTRA_drvNewEnroll') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvNewEnroll] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvPartName] varchar(204) NULL,
    [drvForeignAddressCode] varchar(1) NOT NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvBirthDate] datetime NULL,
    [drvDOH] datetime NULL,
    [drvEligPlanEntry] datetime NULL,
    [drvMaritalStat] varchar(1) NOT NULL,
    [drvHomePh] varchar(12) NULL,
    [drvStatCode] varchar(2) NOT NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvSalary] varchar(11) NULL,
    [drvEmail] varchar(50) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvNewEnrollTrl
-----------

IF OBJECT_ID('U_E401PENTRA_drvNewEnrollTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvNewEnrollTrl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvSSN] varchar(9) NOT NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvRehire
-----------

IF OBJECT_ID('U_E401PENTRA_drvRehire') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvRehire] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvPartName] varchar(204) NULL,
    [drvForeignAddressCode] varchar(1) NOT NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvBirthDate] datetime NULL,
    [drvDOH] datetime NULL,
    [drvEligPlanEntry] datetime NULL,
    [drvMaritalStat] varchar(1) NOT NULL,
    [drvHomePh] varchar(12) NULL,
    [drvStatCode] varchar(2) NOT NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvSalary] varchar(11) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvRehireTrl
-----------

IF OBJECT_ID('U_E401PENTRA_drvRehireTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvRehireTrl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvSSN] varchar(9) NOT NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvTerm
-----------

IF OBJECT_ID('U_E401PENTRA_drvTerm') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvTerm] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvStatCode] varchar(2) NOT NULL,
    [drvDateOfSep] datetime NULL,
    [drvTermReasonCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_drvTermTrl
-----------

IF OBJECT_ID('U_E401PENTRA_drvTermTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvTermTrl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvSSN] varchar(9) NOT NULL,
    [drvSeqNum] varchar(9) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E401PENTRA_EEList
-----------

IF OBJECT_ID('U_E401PENTRA_EEList') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_E401PENTRA_File
-----------

IF OBJECT_ID('U_E401PENTRA_File') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(500) NULL
);

-----------
-- Create table U_E401PENTRA_PDedHist
-----------

IF OBJECT_ID('U_E401PENTRA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E401PENTRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Trinity River Authority of Texas

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 10/26/2021
Service Request Number: TekP-2021-09-16-0004

Purpose: 401a Pension Elig Export

Revision History
----------------
11/03/2021 by AP:
        - Updates to salary format, home phone format and sequence number applied. 
        - Fix for maintenance section applied.

11/18/2021 by AP:
        - Updated sequence across all tables and fixed RIGHT padding.
        - Adjusted ending position from 1000 to 500 (output value is 501 as requested).

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'E401PENTRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'E401PENTRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'E401PENTRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'E401PENTRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'E401PENTRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E401PENTRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E401PENTRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E401PENTRA', 'SCH_E401PE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'E401PENTRA';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'E401PENTRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'E401PENTRA';

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
    DELETE FROM dbo.U_E401PENTRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_E401PENTRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BCPA,BCPN';

    IF OBJECT_ID('U_E401PENTRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_E401PENTRA_DedList
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
    IF OBJECT_ID('U_E401PENTRA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_PDedHist;
    SELECT DISTINCT
         PdhEEID
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
    INTO dbo.U_E401PENTRA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_E401PENTRA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

      --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_E401PENTRA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_AuditFields;
    CREATE TABLE dbo.U_E401PENTRA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpDedFull', 'EedBenStartDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_E401PENTRA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
        ,audBenefitChange = CASE WHEN audTableName = 'EmpDedFull' AND audFieldName = 'EedBenStartDate' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
    INTO dbo.U_E401PENTRA_Audit
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_E401PENTRA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

	---- REMOVE TEST EMPLOYEES ----
	DELETE dbo.U_E401PENTRA_EEList
	WHERE EXISTS (SELECT *
					FROM dbo.emppers
					WHERE dbo.U_E401PENTRA_EEList.xeeid = eepeeid
					AND EepSSN IN ('999991234', '999991235', '999991222'))
	-------------------------------

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvNewEnroll
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvNewEnroll','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvNewEnroll;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = RIGHT('000000000' + CAST(ROW_NUMBER() OVER(PARTITION BY '1' ORDER BY xEEID) AS VARCHAR), 9)
        --CONCAT('00000000', ROW_NUMBER() OVER(PARTITION BY '1' ORDER BY xEEID))
        ,drvTransCode = 'E'
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '')
        ,drvForeignAddressCode = ''
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvBirthDate = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvEligPlanEntry = EedBenStartDate
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvHomePh = SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 7, 4)
        ,drvStatCode = '00'
        ,drvWorkPh = ''
        ,drvJobTitle = ''
        ,drvSalary = RIGHT('00000000000' + REPLACE(EecAnnSalary, '.', ''), 11)
        ,drvEmail = EepAddressEMail
        ,drvInitialSort = '1'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvNewEnroll
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audNewHire = 'Y' 
        AND audReHire = 'N'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;

    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvNewEnrollTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvNewEnrollTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvNewEnrollTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT RIGHT('000000000' + CAST(count(1) AS VARCHAR), 9) FROM dbo.U_E401PENTRA_drvNewEnroll WITH(NOLOCK))
        ,drvTransCode = 'E'
        ,drvInitialSort = '1'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvNewEnrollTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvMaintData
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvMaintData','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvMaintData;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = RIGHT('000000000' + CAST(ROW_NUMBER() OVER(PARTITION BY '1' ORDER BY xEEID) AS VARCHAR), 9)
        ,drvTransCode = 'M'
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '')
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCit = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvBirthDate = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvPlanEntryDt = EedBenStartDate
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvHomePh = SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 7, 4)
        ,drvWorkPh = ''
        ,drvJobTitle = ''
        ,drvSalary = RIGHT('00000000000' + REPLACE(EecAnnSalary, '.', ''), 11)  --EecAnnSalary
        ,drvPreTaxDefAmt = ''
        ,drvPreTaxDefPrcnt = ''
        ,drvPostTaxDefAmt = ''
        ,drvPostTaxDefPrcnt = ''
        ,drvInitialSort = '2'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvMaintData
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (SELECT DISTINCT EedEEID, EedCOID, MAX(EedBenStartDate) AS EedBenStartDate
            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
            WHERE EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID) Eed ON Eed.EedEEID = xEEID AND Eed.EedCOID = xCOID
    --JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
    --    ON EedEEID = xEEID
    --    AND EedCOID = xCOID
    --    AND EedFormatCode = @FormatCode
    --    AND EedValidForExport = 'Y'
    JOIN (SELECT DISTINCT audEEID
                FROM dbo.U_E401PENTRA_Audit WITH(NOLOCK)
                WHERE audNewHire = 'N') aud on aud.audEEID = xEEID
        --ON audEEID = xEEID
        --AND audKey2 = xCOID
        --AND audBenefitChange = 'Y'
        --AND audNewHire = 'N'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvMaintTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvMaintTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvMaintTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT RIGHT('000000000' + CAST(count(1) AS VARCHAR), 9) FROM dbo.U_E401PENTRA_drvMaintData WITH(NOLOCK))
        ,drvTransCode = 'M'
        ,drvInitialSort = '2'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvMaintTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvTerm
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvTerm','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvTerm;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = RIGHT('000000000' + CAST(ROW_NUMBER() OVER(PARTITION BY '1' ORDER BY xEEID) AS VARCHAR), 9)
        ,drvTransCode = 'T'
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvBirthDate = EepDateOfBirth
        ,drvStatCode = '30'
        ,drvDateOfSep = EecDateOfTermination
        ,drvTermReasonCode = 'V'
        ,drvInitialSort = '3'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvTerm
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audTerm = 'Y'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvTermTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvTermTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvTermTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT RIGHT('000000000' + CAST(count(1) AS VARCHAR), 9) FROM dbo.U_E401PENTRA_drvTerm WITH(NOLOCK))
        ,drvTransCode = 'T'
        ,drvInitialSort = '3'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvTermTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvRehire
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvRehire','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvRehire;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = RIGHT('000000000' + CAST(ROW_NUMBER() OVER(PARTITION BY '1' ORDER BY xEEID) AS VARCHAR), 9)
        ,drvTransCode = 'R'
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '')
        ,drvForeignAddressCode = ''
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvBirthDate = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvEligPlanEntry = EedBenStartDate
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvHomePh = SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 7, 4)
        ,drvStatCode = '00'
        ,drvWorkPh = ''
        ,drvJobTitle = ''
        ,drvSalary = RIGHT('00000000000' + REPLACE(EecAnnSalary, '.', ''), 11)
        ,drvInitialSort = '4'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvRehire
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audRehire = 'Y'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID

    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvRehireTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvRehireTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvRehireTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT RIGHT('000000000' + CAST(count(1) AS VARCHAR), 9) FROM dbo.U_E401PENTRA_drvRehire WITH(NOLOCK))
        ,drvTransCode = 'R'
        ,drvInitialSort = '4'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvRehireTrl
   -- FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvGTTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvGTTrl;
    SELECT DISTINCT
         drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = RIGHT('000000000' + CAST((SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvNewEnroll WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvMaintData WITH(NOLOCK))
                        + (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvTerm WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvRehire WITH(NOLOCK)) AS VARCHAR), 9)
        ,drvTransCode = '*'
        ,drvInitialSort = '5'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvGTTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
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
ALTER VIEW dbo.dsi_vwE401PENTRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_E401PENTRA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'E401PENTRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110191'
       ,expStartPerControl     = '202110191'
       ,expLastEndPerControl   = '202110269'
       ,expEndPerControl       = '202110269'
WHERE expFormatCode = 'E401PENTRA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwE401PENTRA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_E401PENTRA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'E401PENTRA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'E401PENTRA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'E401PENTRA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'E401PENTRA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'E401PENTRA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'E401PENTRA', 'UseFileName', 'V', 'Y'


-- End ripout