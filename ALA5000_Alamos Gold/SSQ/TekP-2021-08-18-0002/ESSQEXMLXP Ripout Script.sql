/**********************************************************************************

ESSQEXMLXP: SSQ Benefits XML Export

FormatCode:     ESSQEXMLXP
Project:        SSQ Benefits XML Export
Client ID:      ALA5000
Date/time:      2021-11-24 08:14:39.827
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    TZ12
Server:         TZ1SUP2DB02
Database:       ULTIPRO_ALAG
Web Filename:   ALA5000_OBWQ9_EEHISTORY_ESSQEXMLXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESSQEXMLXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ESSQEXMLXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESSQEXMLXP'


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
WHERE FormatCode = 'ESSQEXMLXP'
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
WHERE ExpFormatCode = 'ESSQEXMLXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESSQEXMLXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESSQEXMLXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESSQEXMLXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESSQEXMLXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESSQEXMLXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESSQEXMLXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESSQEXMLXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESSQEXMLXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESSQEXMLXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESSQEXMLXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESSQEXMLXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESSQEXMLXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESSQEXMLXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESSQEXMLXP];
GO
IF OBJECT_ID('U_ESSQEXMLXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_PEarHist];
GO
IF OBJECT_ID('U_ESSQEXMLXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_PDedHist];
GO
IF OBJECT_ID('U_ESSQEXMLXP_Header') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_Header];
GO
IF OBJECT_ID('U_ESSQEXMLXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_File];
GO
IF OBJECT_ID('U_ESSQEXMLXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_EEList];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ParticipantGroupClose') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_ParticipantGroupClose];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Identification') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_Identification];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_GroupAffiliation') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_GroupAffiliation];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_EmploymentRecord') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_EmploymentRecord];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_DependentsGroupOpen') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_DependentsGroupOpen];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_DependentsGroupClose') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_DependentsGroupClose];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Dependent') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_Dependent];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_CoveragesGroupClose') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_CoveragesGroupClose];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Coverage') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_Coverage];
GO
IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ContactInformation') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_drvTbl_ContactInformation];
GO
IF OBJECT_ID('U_ESSQEXMLXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESSQEXMLXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESSQEXMLXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESSQEXMLXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESSQEXMLXP','SSQ Benefits XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESSQEXMLXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','H','01','1',NULL,'Envelope Header',NULL,NULL,'"<?xml version ="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','H','01','2',NULL,'Envelope Header',NULL,NULL,'"1.0"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','H','01','3',NULL,'Envelope Header',NULL,NULL,'" encoding="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','H','01','4',NULL,'Envelope Header',NULL,NULL,'"UTF-8"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','H','01','5',NULL,'Envelope Header',NULL,NULL,'"?>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','H','02','1',NULL,'FileHeader',NULL,NULL,'"<hrFile>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','H','03','1',NULL,'Header',NULL,NULL,'"<header>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','H','03','2',NULL,'Header',NULL,NULL,'"<senderId>00043</senderId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','H','03','3',NULL,'Header',NULL,NULL,'"<fileTypeCode>1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','H','03','4',NULL,'Header',NULL,NULL,'"</fileTypeCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','H','03','5',NULL,'Header',NULL,NULL,'"<frequency>10</frequency>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','H','03','6',NULL,'Header',NULL,NULL,'"<extractionDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','H','03','7',NULL,'Header',NULL,NULL,'"drvFileRunDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','H','03','8',NULL,'Header',NULL,NULL,'"</extractionDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','H','03','9',NULL,'Header',NULL,NULL,'"<nbOfParticipants>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESSQEXMLXPZ0','50','H','03','10',NULL,'Header',NULL,NULL,'"drvNbOfParticipants"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESSQEXMLXPZ0','50','H','03','11',NULL,'Header',NULL,NULL,'"</nbOfParticipants>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESSQEXMLXPZ0','50','H','03','12',NULL,'Header',NULL,NULL,'"</header>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','H','04','1',NULL,'Participants Header',NULL,NULL,'"<participants>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','10','1',NULL,'Participant Group Open',NULL,NULL,'"drvParticipantHeader"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','15','1',NULL,'Group Affiliation Header',NULL,NULL,'"<groupAffiliation>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','D','15','2',NULL,'Policy Number Open',NULL,NULL,'"<policyId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','D','15','3',NULL,'Policy Number',NULL,NULL,'"drvPolicyNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','D','15','4',NULL,'Establishment Number Open',NULL,NULL,'"</policyId><establishmentId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','D','15','5',NULL,'Establishment Number',NULL,NULL,'"drvEstablishmentNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','D','15','6',NULL,'Group ID Open',NULL,NULL,'"</establishmentId><groupId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','D','15','7',NULL,'Group ID',NULL,NULL,'"drvGroupId"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','D','15','8',NULL,'Group ID Close',NULL,NULL,'"</groupId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','D','15','9',NULL,'Group Affiliation Close',NULL,NULL,'"</groupAffiliation>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','20','1',NULL,'Identification Header',NULL,NULL,'"<identification>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','D','20','2',NULL,'Participant Id Open',NULL,NULL,'"<participantId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','D','20','3',NULL,'Participant Id',NULL,NULL,'"drvParticipant"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','D','20','4',NULL,'Participant Id Close',NULL,NULL,'"</participantId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','D','20','5',NULL,'Certificate Id Open',NULL,NULL,'"<certificateId>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','D','20','6',NULL,'Certificate Id',NULL,NULL,'"drvCertificateId"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','D','20','7',NULL,'Last Name Open',NULL,NULL,'"</certificateId><lastName>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','D','20','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','D','20','9',NULL,'First Name Open',NULL,NULL,'"</lastName><firstName>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESSQEXMLXPZ0','50','D','20','10',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESSQEXMLXPZ0','50','D','20','11',NULL,'DateOfBirth Open',NULL,NULL,'"</firstName><dateOfBirth>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESSQEXMLXPZ0','50','D','20','12',NULL,'DateOfBirth',NULL,NULL,'"drvDateOfBirth"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESSQEXMLXPZ0','50','D','20','13',NULL,'Gender Open',NULL,NULL,'"</dateOfBirth><gender>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESSQEXMLXPZ0','50','D','20','14',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESSQEXMLXPZ0','50','D','20','15',NULL,'Language Code Open',NULL,NULL,'"</gender><languageCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESSQEXMLXPZ0','50','D','20','16',NULL,'Language Code',NULL,NULL,'"drvLanguageCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESSQEXMLXPZ0','50','D','20','17',NULL,'Smoker Status Open',NULL,NULL,'"</languageCode><smokerStatus>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESSQEXMLXPZ0','50','D','20','18',NULL,'Smoker Status',NULL,NULL,'"drvSmokerStatus"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESSQEXMLXPZ0','50','D','20','19',NULL,'Smoker Status Close',NULL,NULL,'"</smokerStatus>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESSQEXMLXPZ0','50','D','20','20',NULL,'Identification Close',NULL,NULL,'"</identification>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','25','1',NULL,'Contact Information Header',NULL,NULL,'"<contactInformation>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','D','25','2',NULL,'Effective Start Date Open',NULL,NULL,'"<effectiveStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','D','25','3',NULL,'Effective Start Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','D','25','4',NULL,'Effective Start Date Close',NULL,NULL,'"</effectiveStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','D','25','5',NULL,'Attention Line Open',NULL,NULL,'"<attentionLine>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','D','25','6',NULL,'Attention Line',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','D','25','7',NULL,'Attention Line Close',NULL,NULL,'"</attentionLine>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','D','25','8',NULL,'Address Line 1 Open',NULL,NULL,'"<addressLine1>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','D','25','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESSQEXMLXPZ0','50','D','25','10',NULL,'Address Line 2 Open',NULL,NULL,'"</addressLine1><addressLine2>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESSQEXMLXPZ0','50','D','25','11',NULL,'Address Line 2 Open',NULL,NULL,'"drvAddressLine2"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESSQEXMLXPZ0','50','D','25','12',NULL,'Address Line 3 Open',NULL,NULL,'"</addressLine2><addressLine3>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESSQEXMLXPZ0','50','D','25','13',NULL,'Address Line 3',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESSQEXMLXPZ0','50','D','25','14',NULL,'Address City Open',NULL,NULL,'"</addressLine3><addressCity>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESSQEXMLXPZ0','50','D','25','15',NULL,'Address City',NULL,NULL,'"drvAddressCity"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESSQEXMLXPZ0','50','D','25','16',NULL,'Address City Close',NULL,NULL,'"</addressCity>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESSQEXMLXPZ0','50','D','25','17',NULL,'Province State Code Open',NULL,NULL,'"<provinceStatecode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESSQEXMLXPZ0','50','D','25','18',NULL,'Province State Code',NULL,NULL,'"drvProvinceStateCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESSQEXMLXPZ0','50','D','25','19',NULL,'Province State Code Close',NULL,NULL,'"</provinceStatecode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESSQEXMLXPZ0','50','D','25','20',NULL,'Postal Code Open',NULL,NULL,'"<postalCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESSQEXMLXPZ0','50','D','25','21',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESSQEXMLXPZ0','50','D','25','22',NULL,'Country Code Open',NULL,NULL,'"</postalCode><country>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESSQEXMLXPZ0','50','D','25','23',NULL,'Country Code',NULL,NULL,'"drvCountry"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESSQEXMLXPZ0','50','D','25','24',NULL,'Home Phone Open',NULL,NULL,'"</country><homePhoneNb>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESSQEXMLXPZ0','50','D','25','25',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESSQEXMLXPZ0','50','D','25','26',NULL,'Cell Phone Open',NULL,NULL,'"</homePhoneNb><cellPhoneNb>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESSQEXMLXPZ0','50','D','25','27',NULL,'Cell Phone',NULL,NULL,'"drvCellPhone"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESSQEXMLXPZ0','50','D','25','28',NULL,'Work Phone Open',NULL,NULL,'"</cellPhoneNb><workPhoneNb>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESSQEXMLXPZ0','50','D','25','29',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESSQEXMLXPZ0','50','D','25','30',NULL,'Work Phone Ext Open',NULL,NULL,'"</workPhoneNb><workPhoneExt>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESSQEXMLXPZ0','50','D','25','31',NULL,'Work Phone Ext',NULL,NULL,'"drvWorkPhoneExt"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESSQEXMLXPZ0','50','D','25','32',NULL,'Email Open',NULL,NULL,'"</workPhoneExt><email>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESSQEXMLXPZ0','50','D','25','33',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESSQEXMLXPZ0','50','D','25','34',NULL,'Contact Information Close',NULL,NULL,'"</email></contactInformation>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','30','1',NULL,'Employment Record Header',NULL,NULL,'"<employmentRecord>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','D','30','2',NULL,'Salary Start Date Open',NULL,NULL,'"<salaryStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','D','30','3',NULL,'Salary Start Date',NULL,NULL,'"drvSalaryStartDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','D','30','4',NULL,'Salary Start Date Close',NULL,NULL,'"</salaryStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','D','30','5',NULL,'Salary Amount Open',NULL,NULL,'"<salaryAmount>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','D','30','6',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','D','30','7',NULL,'Hiring Date Open',NULL,NULL,'"</salaryAmount><hiringDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','D','30','8',NULL,'Hiring Date',NULL,NULL,'"drvHiringDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','D','30','9',NULL,'Hiring Date Close',NULL,NULL,'"</hiringDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESSQEXMLXPZ0','50','D','30','10',NULL,'Eligibility Date Open',NULL,NULL,'"<eligibilityDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESSQEXMLXPZ0','50','D','30','11',NULL,'Eligibility Date',NULL,NULL,'"drvEligibilityDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESSQEXMLXPZ0','50','D','30','12',NULL,'Eligibility Date Close',NULL,NULL,'"</eligibilityDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESSQEXMLXPZ0','50','D','30','13',NULL,'Status Start Date Open',NULL,NULL,'"<statusStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESSQEXMLXPZ0','50','D','30','14',NULL,'Status Start Date',NULL,NULL,'"drvStatusStartDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESSQEXMLXPZ0','50','D','30','15',NULL,'Status Start Date Close',NULL,NULL,'"</statusStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESSQEXMLXPZ0','50','D','30','16',NULL,'Employment Status Code Open',NULL,NULL,'"<employmentStatusCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESSQEXMLXPZ0','50','D','30','17',NULL,'Employment Status Code',NULL,NULL,'"drvEmploymentStatusCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESSQEXMLXPZ0','50','D','30','18',NULL,'Employment Status Code Close',NULL,NULL,'"</employmentStatusCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESSQEXMLXPZ0','50','D','30','19',NULL,'Employment Status Detail Open',NULL,NULL,'"<employmentStatusDetail>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESSQEXMLXPZ0','50','D','30','20',NULL,'Employment Status Detail',NULL,NULL,'"drvEmploymentStatusDetail"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESSQEXMLXPZ0','50','D','30','21',NULL,'Employment Status Detail Close',NULL,NULL,'"</employmentStatusDetail>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESSQEXMLXPZ0','50','D','30','22',NULL,'Employment Record Close',NULL,NULL,'"</employmentRecord>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','35','1',NULL,'Dependents Group Open',NULL,NULL,'"drvDependentsGroupOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','40','1',NULL,'Dependent Open',NULL,NULL,'"<dependent>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','D','40','2',NULL,'Relation Code Open',NULL,NULL,'"<relationCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','D','40','3',NULL,'Relation Code',NULL,NULL,'"drvRelationCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','D','40','4',NULL,'Last Name Open',NULL,NULL,'"</relationCode><lastName>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','D','40','5',NULL,'Last Name',NULL,NULL,'"drvConNameLast"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','D','40','6',NULL,'First Name Open',NULL,NULL,'"</lastName><firstName>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','D','40','7',NULL,'First Name',NULL,NULL,'"drvConNameFirst"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','D','40','8',NULL,'Gender Open',NULL,NULL,'"</firstName><gender>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','D','40','9',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESSQEXMLXPZ0','50','D','40','10',NULL,'DateOfBirth Open',NULL,NULL,'"</gender><dateOfBirth>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESSQEXMLXPZ0','50','D','40','11',NULL,'Date Of Birth',NULL,NULL,'"drvConDateOfBirth"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESSQEXMLXPZ0','50','D','40','12',NULL,'Smoker Status Open',NULL,NULL,'"</dateOfBirth><smokerStatus>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESSQEXMLXPZ0','50','D','40','13',NULL,'Smoker Status',NULL,NULL,'"drvSmokerStatus"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESSQEXMLXPZ0','50','D','40','14',NULL,'Smoker Status Close',NULL,NULL,'"</smokerStatus>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESSQEXMLXPZ0','50','D','40','15',NULL,'Dependent Status Code Open',NULL,NULL,'"<dependentStatusCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESSQEXMLXPZ0','50','D','40','16',NULL,'Dependent Status Code',NULL,NULL,'"drvDependentStatusCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESSQEXMLXPZ0','50','D','40','17',NULL,'Dependent Status Code Close',NULL,NULL,'"</dependentStatusCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESSQEXMLXPZ0','50','D','40','18',NULL,'Status Start Date Open',NULL,NULL,'"<statusStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESSQEXMLXPZ0','50','D','40','19',NULL,'Status Start Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESSQEXMLXPZ0','50','D','40','20',NULL,'Status Start Date Close',NULL,NULL,'"</statusStartDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESSQEXMLXPZ0','50','D','40','21',NULL,'Status End Date Open',NULL,NULL,'"<statusEndDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESSQEXMLXPZ0','50','D','40','22',NULL,'Status End Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESSQEXMLXPZ0','50','D','40','23',NULL,'Dependent Close',NULL,NULL,'"</statusEndDate></dependent>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','45','1',NULL,'Dependents Group Close',NULL,NULL,'"drvDependentsGroupClose"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','50','1',NULL,'Coverages Group Open',NULL,NULL,'"drvCoveragesGroupOpen"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','55','1',NULL,'Coverage Open',NULL,NULL,'"<coverage>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESSQEXMLXPZ0','50','D','55','2',NULL,'Start Date Open',NULL,NULL,'"<startDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESSQEXMLXPZ0','50','D','55','3',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESSQEXMLXPZ0','50','D','55','4',NULL,'End Date Open',NULL,NULL,'"</startDate><endDate>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESSQEXMLXPZ0','50','D','55','5',NULL,'End Date',NULL,NULL,'"drvEndDate"','(''UD23''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESSQEXMLXPZ0','50','D','55','6',NULL,'Code Open',NULL,NULL,'"</endDate><code>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESSQEXMLXPZ0','50','D','55','7',NULL,'Code',NULL,NULL,'"drvCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESSQEXMLXPZ0','50','D','55','8',NULL,'Scope Open',NULL,NULL,'"</code><scope>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESSQEXMLXPZ0','50','D','55','9',NULL,'Scope',NULL,NULL,'"drvScope"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESSQEXMLXPZ0','50','D','55','10',NULL,'Option Open',NULL,NULL,'"</scope><option>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESSQEXMLXPZ0','50','D','55','11',NULL,'Option',NULL,NULL,'"drvOption"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESSQEXMLXPZ0','50','D','55','12',NULL,'Status Code Open',NULL,NULL,'"</option><statusCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESSQEXMLXPZ0','50','D','55','13',NULL,'Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESSQEXMLXPZ0','50','D','55','14',NULL,'Status Code Close',NULL,NULL,'"</statusCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESSQEXMLXPZ0','50','D','55','15',NULL,'Volume Type Code Open',NULL,NULL,'"<volumeTypeCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESSQEXMLXPZ0','50','D','55','16',NULL,'Volume Type Code',NULL,NULL,'"drvVolumeTypeCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESSQEXMLXPZ0','50','D','55','17',NULL,'Volume Type Code Close',NULL,NULL,'"</volumeTypeCode>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESSQEXMLXPZ0','50','D','55','18',NULL,'Volume Open',NULL,NULL,'"<volume>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESSQEXMLXPZ0','50','D','55','19',NULL,'Volume',NULL,NULL,'"drvVolume"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESSQEXMLXPZ0','50','D','55','20',NULL,'Coverage Close',NULL,NULL,'"</volume></coverage>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','D','60','1',NULL,'Participant Group Close',NULL,NULL,'"drvParticipantGroupClose"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','T','90','1',NULL,'Participants Header',NULL,NULL,'"</participants>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESSQEXMLXPZ0','50','T','95','1',NULL,'File Footer',NULL,NULL,'"</hrFile>"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESSQEXMLXP_20211124.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202111199','EMPEXPORT','OEACTIVE','Nov 19 2021 10:24AM','ESSQEXMLXP',NULL,NULL,NULL,'202111199','Nov 19 2021  5:29AM','Nov 19 2021  5:29AM','202111191','6','','','202111191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202111199','EMPEXPORT','OEPASSIVE','Nov 19 2021 10:25AM','ESSQEXMLXP',NULL,NULL,NULL,'202111199','Nov 19 2021  5:29AM','Nov 19 2021  5:29AM','202111191','14500','','','202111191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'SSQ Benefits XML Export','202111199','EMPEXPORT','ONDEM_XOE','Nov 19 2021 10:25AM','ESSQEXMLXP',NULL,NULL,NULL,'202111199','Nov 19 2021  5:29AM','Nov 19 2021  5:29AM','202111191','14500','','','202111191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'SSQ Benefits XML Export-Sched','202111199','EMPEXPORT','SCH_ESSQEX','Nov 19 2021 10:30AM','ESSQEXMLXP',NULL,NULL,NULL,'202111199','Nov 19 2021  5:29AM','Nov 19 2021  5:29AM','202111191','14500','','','202111191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'SSQ Benefits XML Export-Test','202111199','EMPEXPORT','TEST_XOE','Nov 19 2021 10:30AM','ESSQEXMLXP',NULL,NULL,NULL,'202111199','Nov 19 2021  5:29AM','Nov 19 2021  5:29AM','202111191','14500','','','202111191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESSQEXMLXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESSQEXMLXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESSQEXMLXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESSQEXMLXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESSQEXMLXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESSQEXMLXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','H03','dbo.U_ESSQEXMLXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D10','dbo.U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D15','dbo.U_ESSQEXMLXP_drvTbl_GroupAffiliation',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D20','dbo.U_ESSQEXMLXP_drvTbl_Identification',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D25','dbo.U_ESSQEXMLXP_drvTbl_ContactInformation',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D30','dbo.U_ESSQEXMLXP_drvTbl_EmploymentRecord',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D35','dbo.U_ESSQEXMLXP_drvTbl_DependentsGroupOpen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D40','dbo.U_ESSQEXMLXP_drvTbl_Dependent',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D45','dbo.U_ESSQEXMLXP_drvTbl_DependentsGroupClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D50','dbo.U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D55','dbo.U_ESSQEXMLXP_drvTbl_CoveragesGroupClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','D60','dbo.U_ESSQEXMLXP_drvTbl_ParticipantGroupClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','T90','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESSQEXMLXP','T95','None',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESSQEXMLXP
-----------

IF OBJECT_ID('U_dsi_BDM_ESSQEXMLXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESSQEXMLXP] (
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
-- Create table U_ESSQEXMLXP_DedList
-----------

IF OBJECT_ID('U_ESSQEXMLXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_ContactInformation
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ContactInformation') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_ContactInformation] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvProvinceStateCode] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvCellPhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(10) NULL,
    [drvEmail] varchar(50) NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_Coverage
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Coverage') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_Coverage] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvStartDate] varchar(1) NOT NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvCode] varchar(1) NOT NULL,
    [drvScope] varchar(1) NOT NULL,
    [drvOption] varchar(1) NOT NULL,
    [drvStatusCode] varchar(1) NOT NULL,
    [drvVolumeTypeCode] varchar(1) NOT NULL,
    [drvVolume] varchar(1) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_CoveragesGroupClose
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_CoveragesGroupClose') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_CoveragesGroupClose] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] datetime NULL,
    [drvCode] varchar(5) NULL,
    [drvScope] varchar(1) NOT NULL,
    [drvOption] varchar(1) NOT NULL,
    [drvStatusCode] varchar(2) NOT NULL,
    [drvVolumeTypeCode] varchar(2) NULL,
    [drvVolume] varchar(5) NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvCoveragesGroupOpen] varchar(11) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_Dependent
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Dependent') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_Dependent] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvRelationCode] varchar(1) NULL,
    [drvConNameLast] varchar(100) NULL,
    [drvConNameFirst] varchar(100) NULL,
    [drvGender] varchar(1) NULL,
    [drvConDateOfBirth] datetime NULL,
    [drvSmokerStatus] varchar(1) NOT NULL,
    [drvDependentStatusCode] varchar(1) NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_DependentsGroupClose
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_DependentsGroupClose') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_DependentsGroupClose] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvDependentsGroupClose] varchar(13) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_DependentsGroupOpen
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_DependentsGroupOpen') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_DependentsGroupOpen] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvDependentsGroupOpen] varchar(12) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_EmploymentRecord
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_EmploymentRecord') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_EmploymentRecord] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvSalaryStartDate] datetime NULL,
    [drvSalaryAmount] nvarchar(4000) NULL,
    [drvHiringDate] datetime NULL,
    [drvEligibilityDate] datetime NULL,
    [drvStatusStartDate] datetime NULL,
    [drvEmploymentStatusCode] varchar(3) NULL,
    [drvEmploymentStatusDetail] varchar(4) NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_GroupAffiliation
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_GroupAffiliation') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_GroupAffiliation] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPolicyNumber] varchar(5) NOT NULL,
    [drvEstablishmentNumber] varchar(5) NOT NULL,
    [drvGroupId] varchar(5) NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_Identification
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Identification') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_Identification] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticipant] char(9) NULL,
    [drvCertificateId] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvLanguageCode] varchar(1) NULL,
    [drvSmokerStatus] varchar(1) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_ParticipantGroupClose
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ParticipantGroupClose') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_ParticipantGroupClose] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticipantGroupClose] varchar(27) NULL
);

-----------
-- Create table U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen
-----------

IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvParticipantHeader] varchar(13) NOT NULL
);

-----------
-- Create table U_ESSQEXMLXP_EEList
-----------

IF OBJECT_ID('U_ESSQEXMLXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESSQEXMLXP_File
-----------

IF OBJECT_ID('U_ESSQEXMLXP_File') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ESSQEXMLXP_Header
-----------

IF OBJECT_ID('U_ESSQEXMLXP_Header') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_Header] (
    [drvFileRunDate] datetime NOT NULL,
    [drvNbOfParticipants] int NULL
);

-----------
-- Create table U_ESSQEXMLXP_PDedHist
-----------

IF OBJECT_ID('U_ESSQEXMLXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_PDedHist] (
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

-----------
-- Create table U_ESSQEXMLXP_PEarHist
-----------

IF OBJECT_ID('U_ESSQEXMLXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESSQEXMLXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESSQEXMLXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Alamos Gold

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/19/2021
Service Request Number: TekP-2021-08-18-0002

Purpose: SSQ Benefits XML Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESSQEXMLXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESSQEXMLXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESSQEXMLXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESSQEXMLXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESSQEXMLXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESSQEXMLXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESSQEXMLXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESSQEXMLXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESSQEXMLXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESSQEXMLXP', 'SCH_ESSQEX';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESSQEXMLXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESSQEXMLXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESSQEXMLXP';

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
    DELETE FROM dbo.U_ESSQEXMLXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESSQEXMLXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '25217, 25017, 25917, 25216, 25016, 25916, 25018, 25211, 25011, 25911, 25219, 25019, 25919, 25012, 25221, 25222, 25021, 25022, 25921, 25922, 25023, 25224, 25024, 25924, 25225, 25025, 25925, 2502Q, 2522Q, 2592Q, 25026, 25226, 25926, 25127, 25117, 25116, 25118, 25119, 25112, 25122, 25123, 25124, 2512Q, 25126, 25027, 25419, 25412, 25416, 25417, 25418, 25422, 25423, 25424, 25427, 2542Q';

    IF OBJECT_ID('U_ESSQEXMLXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESSQEXMLXP_DedList
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
    IF OBJECT_ID('U_ESSQEXMLXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_PDedHist;
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
    INTO dbo.U_ESSQEXMLXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESSQEXMLXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESSQEXMLXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_PEarHist;
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
    INTO dbo.U_ESSQEXMLXP_PEarHist
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
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' A'
        -- standard fields above and additional driver fields below
        ,drvParticipantHeader = '<participant>'
    INTO dbo.U_ESSQEXMLXP_drvTbl_ParticipantGroupOpen
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_GroupAffiliation
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_GroupAffiliation','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_GroupAffiliation;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' B'
        -- standard fields above and additional driver fields below
        ,drvPolicyNumber = '13JA0'
        ,drvEstablishmentNumber = '25883'
        ,drvGroupId =    CASE EecDedGroupCode
                        WHEN '20EXE' THEN '13JA4'
                        WHEN '20FXT' THEN '13JA5'
                        WHEN '20SAL' THEN '13JA3'
                        WHEN '21FXT' THEN '13JA8'
                        WHEN '21GDF' THEN '13JA9'
                        WHEN '21HRL' THEN '13JA6'
                        WHEN '21SAL' THEN '13JA7'
                        WHEN '22FBN' THEN '13JA2'
                        WHEN '22HRL' THEN '13JA0'
                        WHEN '22SAL' THEN '13JA1'
                        WHEN '23FBN' THEN '13JB2'
                        WHEN '23HRL' THEN '13JB0'
                        WHEN '23SAL' THEN '13JB1'
                        WHEN '23SQC' THEN '13JB1'
                        END
    INTO dbo.U_ESSQEXMLXP_drvTbl_GroupAffiliation
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_Identification
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Identification','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_Identification;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' C'
        -- standard fields above and additional driver fields below
        ,drvParticipant = EecEmpNo
        ,drvCertificateId = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender =    CASE WHEN EepGender = 'M' THEN '1' 
                        WHEN EepGender = 'F' THEN '2' 
                        END
        ,drvLanguageCode =    CASE WHEN EecLanguageCode = 'FR' THEN '1'
                            WHEN EecLanguageCode = 'EN' THEN '2'
                            END
        ,drvSmokerStatus = CASE WHEN EepIsSmoker = 'Y' THEN '1' ELSE '2' END
    INTO dbo.U_ESSQEXMLXP_drvTbl_Identification
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_ContactInformation
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ContactInformation','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_ContactInformation;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' D'
        -- standard fields above and additional driver fields below
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvProvinceStateCode = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvCellPhone = EfoPhoneNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = EecPhoneBusinessExt
        ,drvEmail = CASE WHEN ISNULL(EepAddressEmailAlternate, '') <> '' THEN EepAddressEmailAlternate ELSE EepAddressEMail END
    INTO dbo.U_ESSQEXMLXP_drvTbl_ContactInformation
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
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
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_EmploymentRecord
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_EmploymentRecord','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_EmploymentRecord;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' E'
        -- standard fields above and additional driver fields below
        ,drvSalaryStartDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvSalaryAmount = FORMAT(EecAnnSalary, '#0.00')
        ,drvHiringDate = EecDateOfOriginalHire
        ,drvEligibilityDate = EecDateOfOriginalHire
        ,drvStatusStartDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                WHEN EecEmplStatus = 'A' AND EshEmplStatus = 'L' THEN EshStatusStopDate
                                WHEN EecEmplStatus = 'A' THEN EecDateOfOriginalHire
                                END
        ,drvEmploymentStatusCode =    CASE WHEN EecEmplStatus = 'A' THEN '100'
                                    WHEN EecEmplStatus = 'L' AND EecLeaveReason IN ('105','106','400') THEN '100'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('211','210','213','212') THEN '300'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202') THEN '301'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203','215') THEN '302'
                                    WHEN  EecEmplStatus = 'T' AND EecTermReason IN ('208') THEN '304'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('201','214') THEN '305'
                                    WHEN EecEmplStatus = 'L' AND EecLeaveReason NOT IN ('105','106','400') THEN '400'
                                    END
        ,drvEmploymentStatusDetail =    CASE WHEN EecEmplStatus = 'L' AND EecLeaveReason = '100' THEN '0301'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '101' THEN '0301'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '102' THEN '0401'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '103' THEN '0401'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '104' THEN '0401'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '200' THEN '0301'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN '0301'
                                        WHEN EecEmplStatus = 'L' AND EecLeaveReason = '500' THEN '0301'
                                        END
    INTO dbo.U_ESSQEXMLXP_drvTbl_EmploymentRecord
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) ) AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_DependentsGroupOpen
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_DependentsGroupOpen','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_DependentsGroupOpen;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' F'
        -- standard fields above and additional driver fields below
        ,drvDependentsGroupOpen = '<dependents>'
    INTO dbo.U_ESSQEXMLXP_drvTbl_DependentsGroupOpen
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_Dependent
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_Dependent','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_Dependent;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' G'
        -- standard fields above and additional driver fields below
        ,drvRelationCode =    CASE WHEN ConRelationship IN ('CHL','STC') THEN '2'
                            WHEN ConRelationship IN ('COM','SPS') THEN '1'
                            END
        ,drvConNameLast = ConNameLast
        ,drvConNameFirst = ConNameFirst
        ,drvGender =    CASE WHEN ConGender = 'M' THEN '1'
                        WHEN ConGender = 'F' THEN '2'
                        END
        ,drvConDateOfBirth = ConDateOfBirth
        ,drvSmokerStatus = CASE WHEN ConIsSmoker = 'Y' THEN '1' ELSE '2' END
        ,drvDependentStatusCode = CASE WHEN ConRelationship IN ('CHL','STC') THEN '9' END
    INTO dbo.U_ESSQEXMLXP_drvTbl_Dependent
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON xEEID = ConEEID
        AND BdmDepRecId = ConSystemId
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_DependentsGroupClose
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_DependentsGroupClose','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_DependentsGroupClose;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' H'
        -- standard fields above and additional driver fields below
        ,drvDependentsGroupClose = '</dependents>'
    INTO dbo.U_ESSQEXMLXP_drvTbl_DependentsGroupClose
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' I'
        -- standard fields above and additional driver fields below
        ,drvCoveragesGroupOpen = '<coverages>'
    INTO dbo.U_ESSQEXMLXP_drvTbl_CoveragesGroupOpen
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_CoveragesGroupClose
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_CoveragesGroupClose','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_CoveragesGroupClose;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' J'
        -- standard fields above and additional driver fields below
        ,drvStartDate = BdmBenStartDate
        ,drvEndDate = BdmBenStopDate
        ,drvCode =    CASE WHEN BdmDedCode IN ('25017','25016','25018','25011','25019','25012','25021','25022','25023','25024','25025','2502Q','25026','25027') THEN '10110'
                    WHEN BdmDedCode IN ('25127','25117','25116','25118','25119','25112','25122','25123','25124','2512Q','25126') THEN '10120'
                    WHEN BdmDedCode IN ('25217','25216','25211','25219','25221','25222','25224','25225','2522Q','25226') THEN '10410'
                    WHEN BdmDedCode IN ('25419','25412','25416','25417','25418','25422','25423','25424','25427','2542Q','25426') THEN '10421'
                    WHEN BdmDedCode IN ('25917','25916','25911','25919','25921','25922','25924','25925','2592Q','25926') THEN '20210'                    
                    END
        ,drvScope = ''
        ,drvOption = ''
        ,drvStatusCode = '01'
        ,drvVolumeTypeCode = CASE WHEN BdmDedCode IN ('25127','25117','25116','25118','25119','25112','25122','25123','25124','2512Q','25126','25419','25412','25416','25417','25418','25422','25423','25424','25427','2542Q','25426') THEN '02' END
        ,drvVolume = CASE WHEN BdmDedCode IN ('25127','25117','25116','25118','25119','25112','25122','25123','25124','2512Q','25126','25419','25412','25416','25417','25418','25422','25423','25424','25427','2542Q','25426') THEN '10000' END
    INTO dbo.U_ESSQEXMLXP_drvTbl_CoveragesGroupClose
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESSQEXMLXP_drvTbl_ParticipantGroupClose
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_drvTbl_ParticipantGroupClose','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_drvTbl_ParticipantGroupClose;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' K'
        -- standard fields above and additional driver fields below
        ,drvParticipantGroupClose = '</coverages>' + CHAR(13) + '</participant>'
    INTO dbo.U_ESSQEXMLXP_drvTbl_ParticipantGroupClose
    FROM dbo.U_ESSQEXMLXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESSQEXMLXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESSQEXMLXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESSQEXMLXP_Header;
    SELECT DISTINCT
         drvFileRunDate = GETDATE()
        ,drvNbOfParticipants = (SELECT COUNT(DISTINCT drvParticipant) FROM dbo.U_ESSQEXMLXP_drvTbl_Identification)
    INTO dbo.U_ESSQEXMLXP_Header
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
ALTER VIEW dbo.dsi_vwESSQEXMLXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESSQEXMLXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESSQEXMLXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202111121'
       ,expStartPerControl     = '202111121'
       ,expLastEndPerControl   = '202111199'
       ,expEndPerControl       = '202111199'
WHERE expFormatCode = 'ESSQEXMLXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESSQEXMLXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESSQEXMLXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESSQEXMLXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESSQEXMLXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESSQEXMLXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESSQEXMLXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESSQEXMLXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESSQEXMLXP', 'UseFileName', 'V', 'Y'


-- End ripout