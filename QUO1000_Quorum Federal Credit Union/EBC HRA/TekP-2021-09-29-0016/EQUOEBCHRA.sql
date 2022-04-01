/**********************************************************************************

EQUOEBCHRA: EBC HRA Enrollment

FormatCode:     EQUOEBCHRA
Project:        EBC HRA Enrollment
Client ID:      QUO1000
Date/time:      2022-03-16 08:10:18.087
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB01
Database:       ULTIPRO_WPQFCU
Web Filename:   QUO1000_E1214_EEHISTORY_EQUOEBCHRA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQUOEBCHRA_SavePath') IS NOT NULL DROP TABLE dbo.U_EQUOEBCHRA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQUOEBCHRA'


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
WHERE FormatCode = 'EQUOEBCHRA'
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
WHERE ExpFormatCode = 'EQUOEBCHRA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQUOEBCHRA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQUOEBCHRA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQUOEBCHRA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQUOEBCHRA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQUOEBCHRA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQUOEBCHRA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQUOEBCHRA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQUOEBCHRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQUOEBCHRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQUOEBCHRA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQUOEBCHRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQUOEBCHRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQUOEBCHRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQUOEBCHRA];
GO
IF OBJECT_ID('U_EQUOEBCHRA_ftrTbl') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_ftrTbl];
GO
IF OBJECT_ID('U_EQUOEBCHRA_File') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_File];
GO
IF OBJECT_ID('U_EQUOEBCHRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_EEList];
GO
IF OBJECT_ID('U_EQUOEBCHRA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_drvTbl];
GO
IF OBJECT_ID('U_EQUOEBCHRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_DedList];
GO
IF OBJECT_ID('U_EQUOEBCHRA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_AuditFields];
GO
IF OBJECT_ID('U_EQUOEBCHRA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EQUOEBCHRA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EQUOEBCHRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQUOEBCHRA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQUOEBCHRA','EBC HRA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EQUOEBCHRAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQUOEBCHRAZ0','50','H','01','1',NULL,'PartnerID',NULL,NULL,'"PartnerID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQUOEBCHRAZ0','50','H','01','2',NULL,'InsuredID',NULL,NULL,'"InsuredID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQUOEBCHRAZ0','50','H','01','3',NULL,'MemberID',NULL,NULL,'"MemberID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQUOEBCHRAZ0','50','H','01','4',NULL,'Relation',NULL,NULL,'"Relation"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQUOEBCHRAZ0','50','H','01','5',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQUOEBCHRAZ0','50','H','01','6',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQUOEBCHRAZ0','50','H','01','7',NULL,'MI',NULL,NULL,'"MI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQUOEBCHRAZ0','50','H','01','8',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQUOEBCHRAZ0','50','H','01','9',NULL,'GroupID',NULL,NULL,'"GroupID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQUOEBCHRAZ0','50','H','01','10',NULL,'GroupName',NULL,NULL,'"GroupName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQUOEBCHRAZ0','50','H','01','11',NULL,'Addr1',NULL,NULL,'"Addr1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQUOEBCHRAZ0','50','H','01','12',NULL,'Addr2',NULL,NULL,'"Addr2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQUOEBCHRAZ0','50','H','01','13',NULL,'City',NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQUOEBCHRAZ0','50','H','01','14',NULL,'State',NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQUOEBCHRAZ0','50','H','01','15',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQUOEBCHRAZ0','50','H','01','16',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQUOEBCHRAZ0','50','H','01','17',NULL,'DOH',NULL,NULL,'"DOH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQUOEBCHRAZ0','50','H','01','18',NULL,'PrimaryPhone',NULL,NULL,'"PrimaryPhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQUOEBCHRAZ0','50','H','01','19',NULL,'Extension',NULL,NULL,'"Extension"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQUOEBCHRAZ0','50','H','01','20',NULL,'SecondaryPhone',NULL,NULL,'"SecondaryPhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQUOEBCHRAZ0','50','H','01','21',NULL,'SecondaryExtension',NULL,NULL,'"SecondaryExtension"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQUOEBCHRAZ0','50','H','01','22',NULL,'CellPhone',NULL,NULL,'"CellPhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQUOEBCHRAZ0','50','H','01','23',NULL,'Fax',NULL,NULL,'"Fax"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQUOEBCHRAZ0','50','H','01','24',NULL,'WorkEmail',NULL,NULL,'"WorkEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQUOEBCHRAZ0','50','H','01','25',NULL,'PersonalEmail',NULL,NULL,'"PersonalEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQUOEBCHRAZ0','50','H','01','26',NULL,'UseWorkEmail',NULL,NULL,'"UseWorkEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQUOEBCHRAZ0','50','H','01','27',NULL,'EffDate',NULL,NULL,'"EffDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQUOEBCHRAZ0','50','H','01','28',NULL,'EndDate',NULL,NULL,'"EndDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQUOEBCHRAZ0','50','H','01','29',NULL,'PlanType',NULL,NULL,'"PlanType"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQUOEBCHRAZ0','50','H','01','30',NULL,'Election',NULL,NULL,'"Election"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQUOEBCHRAZ0','50','H','01','31',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQUOEBCHRAZ0','50','H','01','32',NULL,'AltID',NULL,NULL,'"AltID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQUOEBCHRAZ0','50','H','01','33',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQUOEBCHRAZ0','50','H','01','34',NULL,'HICN',NULL,NULL,'"HICN"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQUOEBCHRAZ0','50','D','10','1',NULL,'PartnerID',NULL,NULL,'"Ultimate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQUOEBCHRAZ0','50','D','10','2',NULL,'InsuredID',NULL,NULL,'"drvInsuredID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQUOEBCHRAZ0','50','D','10','3',NULL,'MemberID',NULL,NULL,'"drvMemberID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQUOEBCHRAZ0','50','D','10','4',NULL,'Relation',NULL,NULL,'"drvRelation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQUOEBCHRAZ0','50','D','10','5',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQUOEBCHRAZ0','50','D','10','6',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQUOEBCHRAZ0','50','D','10','7',NULL,'MI',NULL,NULL,'"drvMI"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQUOEBCHRAZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQUOEBCHRAZ0','50','D','10','9',NULL,'GroupID',NULL,NULL,'"Q1038HRA"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQUOEBCHRAZ0','50','D','10','10',NULL,'GroupName',NULL,NULL,'"Q1038 HRA Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQUOEBCHRAZ0','50','D','10','11',NULL,'Addr1',NULL,NULL,'"drvAddr1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQUOEBCHRAZ0','50','D','10','12',NULL,'Addr2',NULL,NULL,'"drvAddr2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQUOEBCHRAZ0','50','D','10','13',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQUOEBCHRAZ0','50','D','10','14',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQUOEBCHRAZ0','50','D','10','15',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQUOEBCHRAZ0','50','D','10','16',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD23''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQUOEBCHRAZ0','50','D','10','17',NULL,'DOH',NULL,NULL,'"drvDOH"','(''UD23''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQUOEBCHRAZ0','50','D','10','18',NULL,'PrimaryPhone',NULL,NULL,'"drvPrimaryPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQUOEBCHRAZ0','50','D','10','19',NULL,'Extension',NULL,NULL,'"drvExtension"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQUOEBCHRAZ0','50','D','10','20',NULL,'SecondaryPhone',NULL,NULL,'"drvSecondaryPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQUOEBCHRAZ0','50','D','10','21',NULL,'SecondaryExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQUOEBCHRAZ0','50','D','10','22',NULL,'CellPhone',NULL,NULL,'"drvCellPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQUOEBCHRAZ0','50','D','10','23',NULL,'Fax',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQUOEBCHRAZ0','50','D','10','24',NULL,'WorkEmail',NULL,NULL,'"drvWorkEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQUOEBCHRAZ0','50','D','10','25',NULL,'PersonalEmail',NULL,NULL,'"drvPersonalEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQUOEBCHRAZ0','50','D','10','26',NULL,'UseWorkEmail',NULL,NULL,'"drvUseWorkEmail"','(''UNT0''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQUOEBCHRAZ0','50','D','10','27',NULL,'EffDate',NULL,NULL,'"drvEffDate"','(''UD23''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQUOEBCHRAZ0','50','D','10','28',NULL,'EndDate',NULL,NULL,'"drvEndDate"','(''UD23''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQUOEBCHRAZ0','50','D','10','29',NULL,'PlanType',NULL,NULL,'"HRA"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQUOEBCHRAZ0','50','D','10','30',NULL,'Election',NULL,NULL,'"drvElection"','(''UNT0''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQUOEBCHRAZ0','50','D','10','31',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQUOEBCHRAZ0','50','D','10','32',NULL,'AltID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQUOEBCHRAZ0','50','D','10','33',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQUOEBCHRAZ0','50','D','10','34',NULL,'HICN',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQUOEBCHRAZ0','50','T','90','1',NULL,'TotalRecordCount',NULL,NULL,'"TotalRecordCount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQUOEBCHRAZ0','50','T','90','2',NULL,'RecCount',NULL,NULL,'"drvRecCount"','(''UNT0''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQUOEBCHRAZ0','50','T','90','3',NULL,'TotalNumberofParticipants',NULL,NULL,'"TotalNumberofParticipants"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQUOEBCHRAZ0','50','T','90','4',NULL,'ParticipantCount',NULL,NULL,'"drvPartCount"','(''UNT0''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQUOEBCHRA_20220316.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202112169','EMPEXPORT','OEACTIVE',NULL,'EQUOEBCHRA',NULL,NULL,NULL,'202112169','Dec 16 2021  8:28AM','Dec 16 2021  8:28AM','202112161',NULL,'','','202112161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202112169','EMPEXPORT','OEPASSIVE',NULL,'EQUOEBCHRA',NULL,NULL,NULL,'202112169','Dec 16 2021  8:28AM','Dec 16 2021  8:28AM','202112161',NULL,'','','202112161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'EBC HRA Enrollment','202112169','EMPEXPORT','ONDEM_XOE',NULL,'EQUOEBCHRA',NULL,NULL,NULL,'202112169','Dec 16 2021  8:28AM','Dec 16 2021  8:28AM','202112161',NULL,'','','202112161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'EBC HRA Enrollment-Sched','202112169','EMPEXPORT','SCH_EQUOEB',NULL,'EQUOEBCHRA',NULL,NULL,NULL,'202112169','Dec 16 2021  8:28AM','Dec 16 2021  8:28AM','202112161',NULL,'','','202112161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'EBC HRA Enrollment-Test','202202071','EMPEXPORT','TEST_XOE','Feb  7 2022  2:35PM','EQUOEBCHRA',NULL,NULL,NULL,'202202071','Feb  7 2022 12:00AM','Dec 30 1899 12:00AM','202201311','293','','','202201311',dbo.fn_GetTimedKey(),NULL,'us3cPeQUO1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUOEBCHRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUOEBCHRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUOEBCHRA','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUOEBCHRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUOEBCHRA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUOEBCHRA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQUOEBCHRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQUOEBCHRA','D10','dbo.U_EQUOEBCHRA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQUOEBCHRA','T90','dbo.U_EQUOEBCHRA_ftrTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQUOEBCHRA
-----------

IF OBJECT_ID('U_dsi_BDM_EQUOEBCHRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQUOEBCHRA] (
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
-- Create table U_EQUOEBCHRA_Audit
-----------

IF OBJECT_ID('U_EQUOEBCHRA_Audit') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_Audit] (
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
-- Create table U_EQUOEBCHRA_AuditFields
-----------

IF OBJECT_ID('U_EQUOEBCHRA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EQUOEBCHRA_DedList
-----------

IF OBJECT_ID('U_EQUOEBCHRA_DedList') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQUOEBCHRA_drvTbl
-----------

IF OBJECT_ID('U_EQUOEBCHRA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvInsuredID] char(11) NULL,
    [drvMemberID] nvarchar(4000) NULL,
    [drvRelation] varchar(2) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMI] varchar(1) NULL,
    [drvSSN] char(11) NULL,
    [drvAddr1] varchar(255) NULL,
    [drvAddr2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] char(10) NULL,
    [drvDOB] datetime NULL,
    [drvDOH] datetime NULL,
    [drvPrimaryPhone] varchar(50) NULL,
    [drvExtension] varchar(10) NULL,
    [drvSecondaryPhone] varchar(50) NULL,
    [drvCellPhone] varchar(50) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvPersonalEmail] varchar(50) NULL,
    [drvUseWorkEmail] int NOT NULL,
    [drvEffDate] datetime NULL,
    [drvEndDate] datetime NULL,
    [drvElection] money NULL,
    [drvDivision] varchar(5) NULL,
    [drvGender] varchar(1) NOT NULL
);

-----------
-- Create table U_EQUOEBCHRA_EEList
-----------

IF OBJECT_ID('U_EQUOEBCHRA_EEList') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQUOEBCHRA_File
-----------

IF OBJECT_ID('U_EQUOEBCHRA_File') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EQUOEBCHRA_ftrTbl
-----------

IF OBJECT_ID('U_EQUOEBCHRA_ftrTbl') IS NULL
CREATE TABLE [dbo].[U_EQUOEBCHRA_ftrTbl] (
    [drvRecCount] int NULL,
    [drvPartCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQUOEBCHRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Quorum Federal Credit Union

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 12/16/2021
Service Request Number: TekP-2021-09-29-0016

Purpose: EBC HRA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQUOEBCHRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQUOEBCHRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQUOEBCHRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQUOEBCHRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQUOEBCHRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUOEBCHRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUOEBCHRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUOEBCHRA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUOEBCHRA', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQUOEBCHRA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQUOEBCHRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EQUOEBCHRA';

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
    DELETE FROM dbo.U_EQUOEBCHRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQUOEBCHRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EQUOEBCHRA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EQUOEBCHRA_AuditFields;
    CREATE TABLE dbo.U_EQUOEBCHRA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EQUOEBCHRA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EQUOEBCHRA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EQUOEBCHRA_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EQUOEBCHRA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EQUOEBCHRA_Audit;
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
    INTO dbo.U_EQUOEBCHRA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EQUOEBCHRA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EQUOEBCHRA_Audit ON dbo.U_EQUOEBCHRA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    ----================
    --DELETE FROM dbo.U_EQUOEBCHRA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EQUOEBCHRA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EQUOEBCHRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQUOEBCHRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQUOEBCHRA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','HRA');
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
    -- DETAIL RECORD - U_EQUOEBCHRA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EQUOEBCHRA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EQUOEBCHRA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSsn
        -- standard fields above and additional driver fields below
        ,drvInsuredID = EepSsn
        ,drvMemberID = CASE WHEN BdmRecType = 'EMP' THEN rtrim(EepSsn) + '01'
                            WHEN BdmRecType = 'DEP' AND BdmRelationship in ('DP','PAR','SPS') THEN rtrim(EepSsn) + '02'
                            WHEN BdmRecType = 'DEP' AND BdmRelationship in ('CHL','DPC','STC') THEN rtrim(EepSsn) + RN -- '03'
                            END
--The last 2 digits will change for dependent records if there are multiple child dependents
--The file will need to create a sequence starting with the oldest child (use condateofbirth).
--The value for the oldest child will be EepSsn plus 03
--The value for the next oldest child will be EepSsn plus 04
--And so on for all child dependents
        ,drvRelation = CASE WHEN BdmRecType = 'EMP' THEN '18'
                            WHEN BdmRecType = 'DEP' AND BdmRelationship in ('DP','PAR','SPS') THEN '01'
                            WHEN BdmRecType = 'DEP' AND BdmRelationship in ('CHL','DPC','STC') THEN '19'
                            END
        ,drvLastName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                            WHEN BdmRecType = 'DEP' THEN ConNameLast
                            END
        ,drvFirstName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                            WHEN BdmRecType = 'DEP' THEN ConNameFirst
                            END
        ,drvMI = CASE WHEN BdmRecType = 'EMP' THEN substring(EepNameMiddle,1,1)
                            WHEN BdmRecType = 'DEP' THEN substring(ConNameMiddle,1,1)
                            END
        ,drvSSN = CASE WHEN BdmRecType = 'EMP' THEN [dbo].[usi_fn_SSNDash] (eepSSN)
                            WHEN BdmRecType = 'DEP' THEN [dbo].[usi_fn_SSNDash] (ConSSN)
                            END
        ,drvAddr1 = EepAddressLine1
        ,drvAddr2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = [dbo].[fn_ZipCode](EepAddressZipCode)
        ,drvDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                            WHEN BdmRecType = 'DEP' THEN ConDateOfBirth
                            END
        ,drvDOH = EecDateOfLastHire
        ,drvPrimaryPhone = EecPhoneBusinessNumber
        ,drvExtension = EecPhoneBusinessExt
        ,drvSecondaryPhone = EepPhoneHomeNumber
        ,drvCellPhone = dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL')
        ,drvWorkEmail = EepAddressEMail
        ,drvPersonalEmail = eepAddressEMailAlternate
        ,drvUseWorkEmail = 0
        ,drvEffDate = CASE WHEN BdmBenStartDate <  DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)THEN  DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)ELSE BdmBenStartDate END
        ,drvEndDate = CASE    
                            WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                            Else '9999-12-31' 
                            END
        ,drvElection = BdmEEGoalAmt
        ,drvDivision = CASE WHEN EecCoID = 'IAGFG' THEN 'QFCU'
                            WHEN EecCoID = 'SSMNA' THEN 'VOFCO'
                        END
        ,drvGender = CASE    
                            WHEN BdmRecType = 'EMP' AND EepGender = 'M' THEN 'M'
                            WHEN BdmRecType = 'EMP' AND EepGender = 'F'  THEN 'F'
                            WHEN BdmRecType = 'DEP' AND ConGender = 'M' THEN 'M'
                            WHEN BdmRecType = 'DEP' AND ConGender = 'F'  THEN 'F'
                            Else 'U'
                            END
    INTO dbo.U_EQUOEBCHRA_drvTbl
    FROM dbo.U_EQUOEBCHRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EQUOEBCHRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
             And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_EQUOEBCHRA_Audit where audEEID = Bdmcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = BdmEEID
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    LEFT JOIN (
                
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, RN 
                FROM ( 
                        SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, '02' AS RN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EQUOEBCHRA BDMS WITH (NOLOCK)
                                ON ConSystemID = BDMS.BdmDepRecID
                        WHERE ConRelationship IN ('SPS','DP','PAR')
        
                        UNION
        
                        SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth DESC)+2, '00') AS RN 
                        FROM ( 
                                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                                FROM dbo.Contacts WITH (NOLOCK) 
                                JOIN dbo.U_dsi_BDM_EQUOEBCHRA BDMC WITH (NOLOCK)
                                ON ConSystemID = BDMC.BdmDepRecID
                                WHERE ConRelationship IN ('CHL','STC','DPC')) AS CHLD
                    ) AS Con 
                --ORDER BY Con.ConEEID, Con.RN
                ) AS AllCon
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;

    ---------------------------------
    -- FOOTER RECORD - U_EQUOEBCHRA_ftrTbl
    ---------------------------------
    IF OBJECT_ID('U_EQUOEBCHRA_ftrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EQUOEBCHRA_ftrTbl;
    SELECT DISTINCT
        drvRecCount = (Select count(*) from dbo.U_EQUOEBCHRA_drvTbl) 
        ,drvPartCount = (Select count(*) from dbo.U_EQUOEBCHRA_drvTbl WHERE drvRelation = 18)
    INTO dbo.U_EQUOEBCHRA_ftrTbl
    FROM dbo.U_EQUOEBCHRA_drvTbl WITH (NOLOCK);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Q1038_FSAElig_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss_TEST.txt.pgp'
                                  ELSE 'Q1038_HRAElig_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss.txt.pgp'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEQUOEBCHRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQUOEBCHRA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EQUOEBCHRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112091'
       ,expStartPerControl     = '202112091'
       ,expLastEndPerControl   = '202112169'
       ,expEndPerControl       = '202112169'
WHERE expFormatCode = 'EQUOEBCHRA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEQUOEBCHRA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EQUOEBCHRA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQUOEBCHRA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQUOEBCHRA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQUOEBCHRA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQUOEBCHRA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQUOEBCHRA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQUOEBCHRA', 'UseFileName', 'V', 'Y'


-- End ripout