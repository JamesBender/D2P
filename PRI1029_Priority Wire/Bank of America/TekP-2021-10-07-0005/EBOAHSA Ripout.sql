/**********************************************************************************

EBOAHSA: Bank of America HSA

FormatCode:     EBOAHSA
Project:        Bank of America HSA
Client ID:      PRI1029
Date/time:      2021-12-18 16:47:41.010
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPPWC
Web Filename:   PRI1029_3Y7VH_EEHISTORY_EBOAHSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBOAHSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EBOAHSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBOAHSA'


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
WHERE FormatCode = 'EBOAHSA'
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
WHERE ExpFormatCode = 'EBOAHSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBOAHSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBOAHSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBOAHSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBOAHSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBOAHSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBOAHSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBOAHSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBOAHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBOAHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBOAHSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBOAHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBOAHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBOAHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBOAHSA];
GO
IF OBJECT_ID('U_EBOAHSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_Trailer];
GO
IF OBJECT_ID('U_EBOAHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_PDedHist];
GO
IF OBJECT_ID('U_EBOAHSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_Header];
GO
IF OBJECT_ID('U_EBOAHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_File];
GO
IF OBJECT_ID('U_EBOAHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_EEList];
GO
IF OBJECT_ID('U_EBOAHSA_drvTbl_Participant') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_drvTbl_Participant];
GO
IF OBJECT_ID('U_EBOAHSA_drvTbl_Enrollment') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_drvTbl_Enrollment];
GO
IF OBJECT_ID('U_EBOAHSA_drvTbl_Contribution') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_drvTbl_Contribution];
GO
IF OBJECT_ID('U_EBOAHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBOAHSA_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBOAHSA','Bank of America HSA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EBOAHSA000Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOAHSA000Z0','2','H','01','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOAHSA000Z0','3','H','01','2',NULL,'AdministratorCode',NULL,NULL,'"drvAdministratorCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOAHSA000Z0','6','H','01','3',NULL,'EmployerCode',NULL,NULL,'"drvEmployerCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOAHSA000Z0','1','H','01','4',NULL,'SynchronizeFlag',NULL,NULL,'"drvSynchronizeFlag"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOAHSA000Z0','8','H','01','5',NULL,'CreationDate',NULL,NULL,'"drvCreationDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOAHSA000Z0','6','H','01','6',NULL,'CreationTime',NULL,NULL,'"drvCreationTime"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOAHSA000Z0','6','H','01','7',NULL,'FileVersion',NULL,NULL,'"drvFileVersion"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOAHSA000Z0','2','D','10','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOAHSA000Z0','9','D','10','2',NULL,'ParticipantFileImpID',NULL,NULL,'"drvParticipantFileImpID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOAHSA000Z0','20','D','10','3',NULL,'EmplrEmployeeD',NULL,NULL,'"drvEmplrEmployeeD"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOAHSA000Z0','15','D','10','4',NULL,'EmployeeNumber',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOAHSA000Z0','30','D','10','5',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOAHSA000Z0','30','D','10','6',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOAHSA000Z0','1','D','10','7',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOAHSA000Z0','1','D','10','8',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBOAHSA000Z0','1','D','10','9',NULL,'MaritalStatus',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBOAHSA000Z0','50','D','10','10',NULL,'MotherMaidenName',NULL,NULL,'"drvMotherMaidenName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBOAHSA000Z0','10','D','10','11',NULL,'DateOfBirth',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBOAHSA000Z0','9','D','10','12',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBOAHSA000Z0','50','D','10','13',NULL,'AddressLine1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBOAHSA000Z0','50','D','10','14',NULL,'AddressLine2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBOAHSA000Z0','50','D','10','15',NULL,'AddressLine3',NULL,NULL,'"drvAddressLine3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBOAHSA000Z0','50','D','10','16',NULL,'AddressLine4',NULL,NULL,'"drvAddressLine4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBOAHSA000Z0','30','D','10','17',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBOAHSA000Z0','2','D','10','18',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBOAHSA000Z0','9','D','10','19',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBOAHSA000Z0','2','D','10','20',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBOAHSA000Z0','10','D','10','21',NULL,'HomePhone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBOAHSA000Z0','10','D','10','22',NULL,'WorkPhone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBOAHSA000Z0','6','D','10','23',NULL,'WorkPhoneExt',NULL,NULL,'"drvWorkPhoneExt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBOAHSA000Z0','125','D','10','24',NULL,'EmailAddress',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBOAHSA000Z0','100','D','10','25',NULL,'Username',NULL,NULL,'"drvUsername"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBOAHSA000Z0','100','D','10','26',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBOAHSA000Z0','10','D','10','27',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBOAHSA000Z0','100','D','10','28',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBOAHSA000Z0','2','D','10','29',NULL,'HoursPerWeek',NULL,NULL,'"drvHoursPerWeek"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBOAHSA000Z0','100','D','10','30',NULL,'EmployeeClass',NULL,NULL,'"drvEmployeeClass"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBOAHSA000Z0','10','D','10','31',NULL,'PayrollFrequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBOAHSA000Z0','10','D','10','32',NULL,'PayrollFreqEffDate',NULL,NULL,'"drvPayrollFreqEffDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBOAHSA000Z0','20','D','10','33',NULL,'ParticipantStatus',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBOAHSA000Z0','10','D','10','34',NULL,'StatusEffDate',NULL,NULL,'"drvStatusEffDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBOAHSA000Z0','1','D','10','35',NULL,'HoldPayrollDeds',NULL,NULL,'"drvHoldPayrollDeds"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBOAHSA000Z0','1','D','10','36',NULL,'HoldEmployerContrib',NULL,NULL,'"drvHoldEmployerContrib"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBOAHSA000Z0','1','D','10','37',NULL,'IncurServices',NULL,NULL,'"drvIncurServices"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBOAHSA000Z0','8','D','10','38',NULL,'FinalPayrollProcessDate',NULL,NULL,'"drvFinalPayrollProcessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBOAHSA000Z0','8','D','10','39',NULL,'FinalContribProcDate',NULL,NULL,'"drvFinalContribProcDate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOAHSA000Z0','2','D','20','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOAHSA000Z0','9','D','20','2',NULL,'ParticipantImpId',NULL,NULL,'"drvParticipantImpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOAHSA000Z0','35','D','20','3',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOAHSA000Z0','10','D','20','4',NULL,'EnrollEffectDate',NULL,NULL,'"drvEnrollEffectDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOAHSA000Z0','8','D','20','5',NULL,'PartElectionAmount',NULL,NULL,'"drvPartElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOAHSA000Z0','10','D','20','6',NULL,'EnrollmentTermDate',NULL,NULL,'"drvEnrollmentTermDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOAHSA000Z0','10','D','20','7',NULL,'EmployerContribLvl',NULL,NULL,'"drvEmployerContribLvl"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOAHSA000Z0','8','D','20','8',NULL,'EmployerContribAmt',NULL,NULL,'"drvEmployerContribAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBOAHSA000Z0','30','D','20','9',NULL,'Filler1',NULL,NULL,'"drvFiller1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBOAHSA000Z0','30','D','20','10',NULL,'Filler2',NULL,NULL,'"drvFiller2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBOAHSA000Z0','1','D','20','11',NULL,'EnrolledClaimsExc',NULL,NULL,'"drvEnrolledClaimsExc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBOAHSA000Z0','8','D','20','12',NULL,'ElectionAmtIndic',NULL,NULL,'"drvElectionAmtIndic"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBOAHSA000Z0','6','D','20','13',NULL,'HDHPCovLvl',NULL,NULL,'"drvHDHPCovLvl"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBOAHSA000Z0','8','D','20','14',NULL,'Filler3',NULL,NULL,'"drvFiller3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBOAHSA000Z0','1','D','20','15',NULL,'Filler4',NULL,NULL,'"drvFiller4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBOAHSA000Z0','1','D','20','16',NULL,'Filler5',NULL,NULL,'"drvFiller5"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBOAHSA000Z0','1','D','20','17',NULL,'Filler6',NULL,NULL,'"drvFiller6"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBOAHSA000Z0','1','D','20','18',NULL,'Filler7',NULL,NULL,'"drvFiller7"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBOAHSA000Z0','1','D','20','19',NULL,'SpendDown',NULL,NULL,'"drvSpendDown"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOAHSA000Z0','2','D','30','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOAHSA000Z0','9','D','30','2',NULL,'ParticFileImportId',NULL,NULL,'"drvParticFileImportId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOAHSA000Z0','35','D','30','3',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOAHSA000Z0','10','D','30','4',NULL,'ContribDate',NULL,NULL,'"drvContribDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOAHSA000Z0','30','D','30','5',NULL,'ContribDesc',NULL,NULL,'"drvContribDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOAHSA000Z0','9','D','30','6',NULL,'ContribAmt',NULL,NULL,'"drvContribAmt"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOAHSA000Z0','6','D','30','7',NULL,'AmountType',NULL,NULL,'"drvAmountType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOAHSA000Z0','7','D','30','8',NULL,'TaxYear',NULL,NULL,'"drvTaxYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBOAHSA000Z0','500','D','30','9',NULL,'Notes',NULL,NULL,'"drvNotes"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOAHSA000Z0','2','T','90','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOAHSA000Z0','20','T','90','2',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOAHSA000Z0','3','T','90','3',NULL,'AdminCode',NULL,NULL,'"drvAdminCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOAHSA000Z0','6','T','90','4',NULL,'EmployerCode',NULL,NULL,'"drvEmployerCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOAHSA000Z0','8','T','90','5',NULL,'CreationDate',NULL,NULL,'"drvCreationDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOAHSA000Z0','6','T','90','6',NULL,'CreationTime',NULL,NULL,'"drvCreationTime"','(''UDMDY''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBOAHSA_20211218.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202002269','EMPEXPORT','OEACTIVE',NULL,'EBOAHSA',NULL,NULL,NULL,'202002269','Feb 26 2020 11:03AM','Feb 26 2020 11:03AM','202002261',NULL,'','','202002261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Bank of America HSA','202012041','EMPEXPORT','ONDEMAND','Dec  4 2020 12:00AM','EBOAHSA',NULL,NULL,NULL,'202012041','Dec  4 2020 12:00AM','Nov 28 2020 12:00AM','202012041','220','eecPayGroup','HOURLY','202012041',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPWC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202002269','EMPEXPORT','SCHEDULED',NULL,'EBOAHSA',NULL,NULL,NULL,'202002269','Feb 26 2020 11:03AM','Feb 26 2020 11:03AM','202002261',NULL,'','','202002261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202101159','EMPEXPORT','TEST','Jan 19 2021 11:10AM','EBOAHSA',NULL,NULL,NULL,'202101159','Jan 15 2021 12:00AM','Dec 30 1899 12:00AM','202101151','1858','eecPayGroup','HOURLY,SALARY','202101151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPWC',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOAHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOAHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOAHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOAHSA','UDESPath','C','\\us.saas\E0\data_exchange\PRI1029\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOAHSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOAHSA','H01','dbo.U_EBOAHSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOAHSA','D10','dbo.U_EBOAHSA_drvTbl_Participant',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOAHSA','D20','dbo.U_EBOAHSA_drvTbl_Enrollment',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOAHSA','D30','dbo.U_EBOAHSA_drvTbl_Contribution',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOAHSA','T90','dbo.U_EBOAHSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBOAHSA_DedList
-----------

IF OBJECT_ID('U_EBOAHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBOAHSA_drvTbl_Contribution
-----------

IF OBJECT_ID('U_EBOAHSA_drvTbl_Contribution') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_drvTbl_Contribution] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticFileImportId] char(9) NULL,
    [drvPlanName] varchar(22) NOT NULL,
    [drvContribDate] datetime NULL,
    [drvContribDesc] varchar(21) NULL,
    [drvContribAmt] numeric NULL,
    [drvAmountType] varchar(6) NOT NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvNotes] varchar(1) NOT NULL
);

-----------
-- Create table U_EBOAHSA_drvTbl_Enrollment
-----------

IF OBJECT_ID('U_EBOAHSA_drvTbl_Enrollment') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_drvTbl_Enrollment] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticipantImpId] char(9) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvEnrollEffectDate] datetime NULL,
    [drvPartElectionAmount] varchar(4) NOT NULL,
    [drvEnrollmentTermDate] varchar(1) NOT NULL,
    [drvEmployerContribLvl] varchar(1) NOT NULL,
    [drvEmployerContribAmt] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvEnrolledClaimsExc] varchar(1) NOT NULL,
    [drvElectionAmtIndic] varchar(6) NOT NULL,
    [drvHDHPCovLvl] varchar(6) NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvFiller5] varchar(1) NOT NULL,
    [drvFiller6] varchar(1) NOT NULL,
    [drvFiller7] varchar(1) NOT NULL,
    [drvSpendDown] varchar(1) NOT NULL
);

-----------
-- Create table U_EBOAHSA_drvTbl_Participant
-----------

IF OBJECT_ID('U_EBOAHSA_drvTbl_Participant') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_drvTbl_Participant] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticipantFileImpID] char(9) NULL,
    [drvEmplrEmployeeD] char(9) NULL,
    [drvEmployeeNumber] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvMotherMaidenName] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressLine4] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] varchar(2) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvUsername] varchar(1) NOT NULL,
    [drvPassword] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvHoursPerWeek] numeric NULL,
    [drvEmployeeClass] varchar(3) NOT NULL,
    [drvPayrollFrequency] varchar(1) NOT NULL,
    [drvPayrollFreqEffDate] varchar(1) NOT NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffDate] datetime NULL,
    [drvHoldPayrollDeds] varchar(1) NOT NULL,
    [drvHoldEmployerContrib] varchar(1) NOT NULL,
    [drvIncurServices] varchar(1) NOT NULL,
    [drvFinalPayrollProcessDate] varchar(1) NOT NULL,
    [drvFinalContribProcDate] varchar(1) NOT NULL
);

-----------
-- Create table U_EBOAHSA_EEList
-----------

IF OBJECT_ID('U_EBOAHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBOAHSA_File
-----------

IF OBJECT_ID('U_EBOAHSA_File') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EBOAHSA_Header
-----------

IF OBJECT_ID('U_EBOAHSA_Header') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_Header] (
    [drvRecordType] varchar(2) NOT NULL,
    [drvAdministratorCode] varchar(3) NOT NULL,
    [drvEmployerCode] varchar(6) NOT NULL,
    [drvSynchronizeFlag] varchar(1) NOT NULL,
    [drvCreationDate] nvarchar(4000) NULL,
    [drvCreationTime] nvarchar(4000) NULL,
    [drvFileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_EBOAHSA_PDedHist
-----------

IF OBJECT_ID('U_EBOAHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhType] varchar(2) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL
);

-----------
-- Create table U_EBOAHSA_Trailer
-----------

IF OBJECT_ID('U_EBOAHSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EBOAHSA_Trailer] (
    [drvRecordType] varchar(2) NOT NULL,
    [drvRecordCount] int NULL,
    [drvAdminCode] varchar(3) NOT NULL,
    [drvEmployerCode] varchar(6) NOT NULL,
    [drvCreationDate] nvarchar(4000) NULL,
    [drvCreationTime] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBOAHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Priority Wire

Created By: Brian Lennox
Business Analyst: Michael Christopher
Create Date: 02/26/2020
Service Request Number: SR-2019-00257414

Purpose: Bank of America HSA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBOAHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBOAHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBOAHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBOAHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBOAHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOAHSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOAHSA', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOAHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOAHSA', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBOAHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBOAHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBOAHSA';

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
    DELETE FROM dbo.U_EBOAHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBOAHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA,HSAI,HSAF,HSI,ER';

    IF OBJECT_ID('U_EBOAHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBOAHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','HSA,HSAI,HSAF,HSI');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    IF OBJECT_ID('U_EBOAHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhType = CASE WHEN PdhDedCode IN ('ER') THEN 'ER' ELSE 'EE' END
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EBOAHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBOAHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('ER') THEN 'ER' ELSE 'EE' END
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBOAHSA_drvTbl_Participant
    ---------------------------------
    IF OBJECT_ID('U_EBOAHSA_drvTbl_Participant','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_drvTbl_Participant;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'PT'
        ,drvParticipantFileImpID = EecEmpNo
        ,drvEmplrEmployeeD = EecEmpNo
        ,drvEmployeeNumber = ''
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END
        ,drvMotherMaidenName = ''
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvAddressLine4 = ''
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN CONCAT(SUBSTRING(EepAddressZipCode,1,5),'-',SUBSTRING(EepAddressZipCode,6,4)) ELSE EepAddressZipCode END
        ,drvCountry = SUBSTRING(EepAddressCountry,1,2)
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = ''
        ,drvEmailAddress = EepAddressEMail
        ,drvUsername = ''
        ,drvPassword = ''
        ,drvHireDate = EecDateOfOriginalHire
        ,drvDivision = ''
        ,drvHoursPerWeek = CASE EecPayPeriod
                            WHEN 'B' THEN (CAST(EecScheduledWorkHrs as numeric)/2)
                            WHEN 'S' THEN ((CAST(EecScheduledWorkHrs as numeric)*24)/52)
                            WHEN 'M' THEN ((CAST(EecScheduledWorkHrs as numeric)*12)/2)
                           END
        ,drvEmployeeClass = 'ALL'
        ,drvPayrollFrequency = 'W'
        ,drvPayrollFreqEffDate = ''
        ,drvParticipantStatus = CASE WHEN EecEmplStatus IN ('L','A') THEN 'Active' ELSE 'Terminated' END
        ,drvStatusEffDate = CASE WHEN EecEmplStatus = 'T' OR EedBenStatus IN ('T','C') THEN EedBenStopDate ELSE EecDateOfLastHire END
        ,drvHoldPayrollDeds = ''
        ,drvHoldEmployerContrib = ''
        ,drvIncurServices = ''
        ,drvFinalPayrollProcessDate = ''
        ,drvFinalContribProcDate = ''
    INTO dbo.U_EBOAHSA_drvTbl_Participant
    FROM dbo.U_EBOAHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EBOAHSA_drvTbl_Enrollment
    ---------------------------------
    IF OBJECT_ID('U_EBOAHSA_drvTbl_Enrollment','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_drvTbl_Enrollment;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'EN'
        ,drvParticipantImpId = EecEmpNo
        ,drvPlanName = CASE WHEN EedDedCode IN ('HSA','HSAI','HSAF','HSI') THEN 'Health Savings Account' END
        ,drvEnrollEffectDate = EedBenStartDate
        ,drvPartElectionAmount = '0.00'
        ,drvEnrollmentTermDate = ''
        ,drvEmployerContribLvl = ''
        ,drvEmployerContribAmt = ''
        ,drvFiller1 = ''
        ,drvFiller2 = ''
        ,drvEnrolledClaimsExc = ''
        ,drvElectionAmtIndic = 'PerPay'
        ,drvHDHPCovLvl = CASE 
                         WHEN EedDedCode IN ('HSA','HSAF') THEN 'FAMILY' 
                         WHEN EedDedCode IN ('HSI','HSAI') THEN 'SINGLE' 
                         END
        ,drvFiller3 = ''
        ,drvFiller4 = ''
        ,drvFiller5 = ''
        ,drvFiller6 = ''
        ,drvFiller7 = ''
        ,drvSpendDown = ''
    INTO dbo.U_EBOAHSA_drvTbl_Enrollment
    FROM dbo.U_EBOAHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBOAHSA_drvTbl_Contribution
    ---------------------------------
    IF OBJECT_ID('U_EBOAHSA_drvTbl_Contribution','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_drvTbl_Contribution;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'CT'
        ,drvParticFileImportId = EecEmpNo
        ,drvPlanName = 'Health Savings Account'--CASE WHEN EedDedCode IN ('HSA','HSAI','HSAF','HSI') THEN 'Health Savings Account' END
        ,drvContribDate = DATEADD(day,-2,PrgPayDate)
        ,drvContribDesc = CASE PdhType
                        WHEN 'EE' THEN 'Payroll Deduction'
                        WHEN 'ER' THEN 'Employer Contribution'
                        END
        ,drvContribAmt = PdhEECurAmt
        ,drvAmountType = 'Actual'
        ,drvTaxYear = ''
        ,drvNotes = ''
    INTO dbo.U_EBOAHSA_drvTbl_Contribution
    FROM dbo.U_EBOAHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_EBOAHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.vw_int_PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
        AND PrgCOID = xCOID
        AND PrgPayDate BETWEEN @StartDate AND @EndDate
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBOAHSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_Header;
    SELECT DISTINCT
         drvRecordType = 'FH'
        ,drvAdministratorCode = 'BSB'
        ,drvEmployerCode = 'PRIOR1'
        ,drvSynchronizeFlag = ''
        ,drvCreationDate = FORMAT(GETDATE(),'MMddyyyy')
        ,drvCreationTime = FORMAT(GETDATE(),'hhmmss')
        ,drvFileVersion = '2.0'
    INTO dbo.U_EBOAHSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBOAHSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EBOAHSA_Trailer;
    SELECT DISTINCT
         drvRecordType = 'FF'
        ,drvRecordCount = ((SELECT COUNT(*) FROM dbo.U_EBOAHSA_drvTbl_Participant)+(SELECT COUNT(*) FROM dbo.U_EBOAHSA_drvTbl_Enrollment)+(SELECT COUNT(*) FROM dbo.U_EBOAHSA_drvTbl_Contribution))
        ,drvAdminCode = 'BSB'
        ,drvEmployerCode = 'PRIOR1'
        ,drvCreationDate = FORMAT(GETDATE(),'MMddyyyy')
        ,drvCreationTime = FORMAT(GETDATE(),'hhmmss')
    INTO dbo.U_EBOAHSA_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEBOAHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBOAHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBOAHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202002191'
       ,expStartPerControl     = '202002191'
       ,expLastEndPerControl   = '202002269'
       ,expEndPerControl       = '202002269'
WHERE expFormatCode = 'EBOAHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBOAHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBOAHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBOAHSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBOAHSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBOAHSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBOAHSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBOAHSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBOAHSA', 'UseFileName', 'V', 'Y'


-- End ripout