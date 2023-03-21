/**********************************************************************************

EMSSUNLIFE: Sunlife Demographic Retirement Export

FormatCode:     EMSSUNLIFE
Project:        Sunlife Demographic Retirement Export
Client ID:      MOV1001
Date/time:      2023-03-21 16:56:48.973
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N33
Server:         N3SUP3DB01
Database:       ULTIPRO_MVS
Web Filename:   MOV1001_M3D41_EEHISTORY_EMSSUNLIFE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMSSUNLIFE_SavePath') IS NOT NULL DROP TABLE dbo.U_EMSSUNLIFE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMSSUNLIFE'


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
WHERE FormatCode = 'EMSSUNLIFE'
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
WHERE ExpFormatCode = 'EMSSUNLIFE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMSSUNLIFE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMSSUNLIFE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMSSUNLIFE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMSSUNLIFE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMSSUNLIFE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMSSUNLIFE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMSSUNLIFE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMSSUNLIFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMSSUNLIFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMSSUNLIFE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMSSUNLIFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMSSUNLIFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMSSUNLIFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSSUNLIFE];
GO
IF OBJECT_ID('U_EMSSUNLIFE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_PEarHist];
GO
IF OBJECT_ID('U_EMSSUNLIFE_Header') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_Header];
GO
IF OBJECT_ID('U_EMSSUNLIFE_File') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_File];
GO
IF OBJECT_ID('U_EMSSUNLIFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_EEList];
GO
IF OBJECT_ID('U_EMSSUNLIFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_drvTbl];
GO
IF OBJECT_ID('U_EMSSUNLIFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_AuditFields];
GO
IF OBJECT_ID('U_EMSSUNLIFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMSSUNLIFE_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMSSUNLIFE','Sunlife Demographic Retirement Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EMSSUNLIFEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSSUNLIFEZ0','1','H','01','1',NULL,'Record Type Code',NULL,NULL,'"H"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSSUNLIFEZ0','3','H','01','2',NULL,'Tape ID',NULL,NULL,'"MCR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSSUNLIFEZ0','5','H','01','3',NULL,'Client ID',NULL,NULL,'"C005O"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMSSUNLIFEZ0','9','H','01','4',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMSSUNLIFEZ0','1982','H','01','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSSUNLIFEZ0','1','D','10','1',NULL,'Record Type Code',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSSUNLIFEZ0','3','D','10','2',NULL,'Tape ID',NULL,NULL,'"MCR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSSUNLIFEZ0','5','D','10','3',NULL,'Client ID',NULL,NULL,'"C005O"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMSSUNLIFEZ0','2','D','10','4',NULL,'Plan ID',NULL,NULL,'"05"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMSSUNLIFEZ0','9','D','10','5',NULL,'Member Number',NULL,NULL,'"drvMemberNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMSSUNLIFEZ0','9','D','10','6',NULL,'Social Insurance Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMSSUNLIFEZ0','32','D','10','7',NULL,'Last Name ',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMSSUNLIFEZ0','32','D','10','8',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMSSUNLIFEZ0','32','D','10','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMSSUNLIFEZ0','32','D','10','10',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMSSUNLIFEZ0','32','D','10','11',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMSSUNLIFEZ0','32','D','10','12',NULL,'Address Line 4',NULL,NULL,'"drvAddressLine4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMSSUNLIFEZ0','6','D','10','13',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMSSUNLIFEZ0','3','D','10','14',NULL,'Residence Code',NULL,NULL,'"drvResidenceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMSSUNLIFEZ0','977','D','10','15',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMSSUNLIFEZ0','3','D','10','16',NULL,'Province of Employment',NULL,NULL,'"drvProvinceEmployment1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMSSUNLIFEZ0','8','D','10','17',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMSSUNLIFEZ0','8','D','10','18',NULL,'Date of Birth (Member)',NULL,NULL,'"drvDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMSSUNLIFEZ0','8','D','10','19',NULL,'Date of Hire',NULL,NULL,'"drvDateHire1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMSSUNLIFEZ0','8','D','10','20',NULL,'Date of Coverage',NULL,NULL,'"drvDateCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMSSUNLIFEZ0','18','D','10','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMSSUNLIFEZ0','1','D','10','22',NULL,'Language Code',NULL,NULL,'"drvLanguageCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMSSUNLIFEZ0','9','D','10','23',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMSSUNLIFEZ0','9','D','10','24',NULL,'Current Year Salary Wages',NULL,NULL,'"drvCurrentYearSalaryWages"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMSSUNLIFEZ0','34','D','10','25',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMSSUNLIFEZ0','1','D','10','26',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMSSUNLIFEZ0','8','D','10','27',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEmployStatusEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMSSUNLIFEZ0','5','D','10','28',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMSSUNLIFEZ0','1','D','10','29',NULL,'Gender (Member)',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMSSUNLIFEZ0','30','D','10','30',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMSSUNLIFEZ0','1','D','10','31',NULL,'Plan Flag',NULL,NULL,'"drvPlanFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMSSUNLIFEZ0','67','D','10','32',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMSSUNLIFEZ0','3','D','10','33',NULL,'Province of Employment',NULL,NULL,'"drvProvinceEmployment2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMSSUNLIFEZ0','16','D','10','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMSSUNLIFEZ0','8','D','10','35',NULL,'Date of Hire',NULL,NULL,'"drvDateHire2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMSSUNLIFEZ0','1','D','10','36',NULL,'Member Language Code',NULL,NULL,'"drvMemberLanguageCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMSSUNLIFEZ0','1','D','10','37',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMSSUNLIFEZ0','8','D','10','38',NULL,'Member Date of Birth',NULL,NULL,'"drvMemberDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMSSUNLIFEZ0','8','D','10','39',NULL,'Member Date of Coverage',NULL,NULL,'"drvMemberDateofCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMSSUNLIFEZ0','10','D','10','40',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMSSUNLIFEZ0','2','D','10','41',NULL,'Subdivision',NULL,NULL,'"drvSubdivision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMSSUNLIFEZ0','15','D','10','42',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMSSUNLIFEZ0','1','D','10','43',NULL,'Enrolment Flag',NULL,NULL,'"drvEnrolmentFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMSSUNLIFEZ0','1','D','10','44',NULL,'Email Flag',NULL,NULL,'"drvEmailFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMSSUNLIFEZ0','64','D','10','45',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMSSUNLIFEZ0','1','D','10','46',NULL,'Phone Flag',NULL,NULL,'"drvPhoneFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMSSUNLIFEZ0','5','D','10','47',NULL,'Phone Country Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMSSUNLIFEZ0','5','D','10','48',NULL,'Phone City Code ',NULL,NULL,'"drvPhoneAreaCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMSSUNLIFEZ0','12','D','10','49',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMSSUNLIFEZ0','5','D','10','50',NULL,'Phone Extension',NULL,NULL,'"drvPhoneExtension"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMSSUNLIFEZ0','63','D','10','51',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMSSUNLIFEZ0','11','D','10','52',NULL,'Filler',NULL,NULL,'"drvFiller"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMSSUNLIFEZ0','408','D','10','53',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMSSUNLIFE_20230321.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Demographic Retirement','202303219','EMPEXPORT','ONDEM_XOE',NULL,'EMSSUNLIFE',NULL,NULL,NULL,'202303219','Mar 21 2023  2:24PM','Mar 21 2023  2:24PM','202303211',NULL,'','','202303211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Demographic Reti-Sched','202303219','EMPEXPORT','SCH_EMSSUN',NULL,'EMSSUNLIFE',NULL,NULL,NULL,'202303219','Mar 21 2023  2:24PM','Mar 21 2023  2:24PM','202303211',NULL,'','','202303211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Sunlife Demographic Reti-Test','202303219','EMPEXPORT','TEST_XOE','Mar 21 2023 12:00AM','EMSSUNLIFE',NULL,NULL,NULL,'202303219','Mar 21 2023 12:00AM','Dec 30 1899 12:00AM','202303211',NULL,'','','202303211',dbo.fn_GetTimedKey(),NULL,'us3mWaMOV1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSSUNLIFE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSSUNLIFE','H01','dbo.U_EMSSUNLIFE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSSUNLIFE','D10','dbo.U_EMSSUNLIFE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EMSSUNLIFE_Audit
-----------

IF OBJECT_ID('U_EMSSUNLIFE_Audit') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audTerm] varchar(1) NOT NULL,
    [audTermdate] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EMSSUNLIFE_AuditFields
-----------

IF OBJECT_ID('U_EMSSUNLIFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMSSUNLIFE_drvTbl
-----------

IF OBJECT_ID('U_EMSSUNLIFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvMemberNumber] varchar(11) NOT NULL,
    [drvSSN] int NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvAddressLine4] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvResidenceCode] varchar(3) NULL,
    [drvProvinceEmployment1] varchar(3) NULL,
    [drvDateofbirth] varchar(30) NULL,
    [drvDateHire1] varchar(30) NULL,
    [drvDateCoverage] varchar(30) NULL,
    [drvLanguageCode] varchar(1) NOT NULL,
    [drvCurrentYearSalaryWages] varchar(30) NULL,
    [drvEmploymentStatus] varchar(1) NULL,
    [drvEmployStatusEffDate] varchar(30) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvPlanFlag] varchar(1) NOT NULL,
    [drvProvinceEmployment2] varchar(3) NULL,
    [drvDateHire2] varchar(30) NULL,
    [drvMemberLanguageCode] varchar(1) NOT NULL,
    [drvMemberDateofBirth] varchar(30) NULL,
    [drvMemberDateofCoverage] varchar(30) NULL,
    [drvSubdivision] varchar(2) NOT NULL,
    [drvEnrolmentFlag] varchar(1) NOT NULL,
    [drvEmailFlag] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPhoneFlag] varchar(1) NOT NULL,
    [drvPhoneAreaCode] varchar(3) NULL,
    [drvPhone] varchar(7) NULL,
    [drvPhoneExtension] varchar(1) NOT NULL,
    [drvFiller] varchar(24) NULL
);

-----------
-- Create table U_EMSSUNLIFE_EEList
-----------

IF OBJECT_ID('U_EMSSUNLIFE_EEList') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMSSUNLIFE_File
-----------

IF OBJECT_ID('U_EMSSUNLIFE_File') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EMSSUNLIFE_Header
-----------

IF OBJECT_ID('U_EMSSUNLIFE_Header') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_Header] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EMSSUNLIFE_PEarHist
-----------

IF OBJECT_ID('U_EMSSUNLIFE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMSSUNLIFE_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSSUNLIFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Move Sales

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 03/21/2023
Service Request Number: TekP-2023-02-07-03

Purpose: Sunlife Demographic Retirement Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMSSUNLIFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMSSUNLIFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMSSUNLIFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMSSUNLIFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMSSUNLIFE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSSUNLIFE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSSUNLIFE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSSUNLIFE', 'SCH_EMSSUN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMSSUNLIFE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMSSUNLIFE';

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
    DELETE FROM dbo.U_EMSSUNLIFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMSSUNLIFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMSSUNLIFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMSSUNLIFE_AuditFields;
    CREATE TABLE dbo.U_EMSSUNLIFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMSSUNLIFE_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EMSSUNLIFE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EMSSUNLIFE_AuditFields VALUES ('EmpComp','EecTermReason');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMSSUNLIFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMSSUNLIFE_Audit;
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
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audTermdate = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecDateofTermination' AND ISNULL(audNewValue,'') = '' THEN audNewValue  END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EMSSUNLIFE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMSSUNLIFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMSSUNLIFE_Audit ON dbo.U_EMSSUNLIFE_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EMSSUNLIFE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMSSUNLIFE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EMSSUNLIFE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMSSUNLIFE_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehEarnCode IN ('CCMML','CCMMS','CCMPL','CFTO','CFTOT','CSTO','CVACT') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
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
    INTO dbo.U_EMSSUNLIFE_PEarHist
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
    -- DETAIL RECORD - U_EMSSUNLIFE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMSSUNLIFE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMSSUNLIFE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvMemberNumber = Concat('MC',EecEmpNo)
        ,drvSSN = CASE WHEN ISNULL(eepSSN, '' ) <> '' THEN eepSSN ELSE 999999999 END
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = EepAddressLine3
        ,drvAddressLine4 = EepAddressLine4
        ,drvPostalCode = EepAddressZipCode
        ,drvResidenceCode = CASE  EepAddressState
                                    WHEN 'NL' then '101'
                                    WHEN 'PE' then '102'
                                    WHEN 'NS' then '103'
                                    WHEN 'NB' then '104'
                                    WHEN 'QC' then '105'
                                    WHEN 'ON' then '106'
                                    WHEN 'MB' then '107'
                                    WHEN 'SK' then '108'
                                    WHEN 'AB' then '109'
                                    WHEN 'BC' then '110'
                                    WHEN 'YT' then '111'
                                    WHEN 'NT' then '112'
                                    WHEN 'NU' then '113'
                            END

        ,drvProvinceEmployment1 = CASE  EepAddressState
                                    WHEN 'NL' then '101'
                                    WHEN 'PE' then '102'
                                    WHEN 'NS' then '103'
                                    WHEN 'NB' then '104'
                                    WHEN 'QC' then '105'
                                    WHEN 'ON' then '106'
                                    WHEN 'MB' then '107'
                                    WHEN 'SK' then '108'
                                    WHEN 'AB' then '109'
                                    WHEN 'BC' then '110'
                                    WHEN 'YT' then '111'
                                    WHEN 'NT' then '112'
                                    WHEN 'NU' then '113'
                            END
        ,drvDateofbirth = Convert(varchar, EepDateOfBirth, 112)
        ,drvDateHire1 = Convert(varchar, EecDateOfLastHire, 112)
        ,drvDateCoverage = Convert(varchar, EecDateOfLastHire, 112)
        ,drvLanguageCode = 'E'
        ,drvCurrentYearSalaryWages = Convert(varchar, dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), 112)
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus IN ( 'A', 'L' ) THEN EecEmplStatus
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                    ELSE 'T'
                                END

        ,drvEmployStatusEffDate = Convert(varchar, CASE  WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                        WHEN EecEmplStatus = 'A' and  EshEmplStatus = 'L' THEN  EshStatusStopDate
                                    END, 112)


        ,drvGender =  CASE WHEN EepGender = 'M' THEN 'M' ELSE 'F' END
        ,drvPlanFlag = 'Y'
        ,drvProvinceEmployment2 = CASE  EepAddressState
                                    WHEN 'NL' then '101'
                                    WHEN 'PE' then '102'
                                    WHEN 'NS' then '103'
                                    WHEN 'NB' then '104'
                                    WHEN 'QC' then '105'
                                    WHEN 'ON' then '106'
                                    WHEN 'MB' then '107'
                                    WHEN 'SK' then '108'
                                    WHEN 'AB' then '109'
                                    WHEN 'BC' then '110'
                                    WHEN 'YT' then '111'
                                    WHEN 'NT' then '112'
                                    WHEN 'NU' then '113'
                            END
        ,drvDateHire2 = Convert(varchar, EecDateOfLastHire, 112)
        ,drvMemberLanguageCode = 'E'
        ,drvMemberDateofBirth = Convert(varchar, EepDateOfBirth, 112)
        ,drvMemberDateofCoverage = Convert(varchar, EecDateOfLastHire, 112)
        ,drvSubdivision = '01'
        ,drvEnrolmentFlag = CASE WHEN (YEAR(Getdate()) - Year(EepDateOfBirth)) >= '71' or (EecEmplStatus IN ('T', 'R', 'D') or EecTermReason IN ('203','202')) THEN 'N' ELSE 'Y' END
        ,drvEmailFlag = CASE WHEn EepAddressEMail is not null then 'Y' ELSE 'N' END
        ,drvEmailAddress = EepAddressEMail
        ,drvPhoneFlag = CASE WHEn EepPhoneHomeNumber IS not null then 'Y' ELSE 'N' END
        ,drvPhoneAreaCode = Substring(EepPhoneHomeNumber,1,3) 
        ,drvPhone = Substring(EepPhoneHomeNumber,4,7) 
        ,drvPhoneExtension = ''
        ,drvFiller = CASE WHEN PehCurAmt <> 0.0000 THEN  dbo.dsi_fnpadzero((ISNULL(REPLACE((PehCurAmt + EecAnnSalary),'.', ''),0)),11,0) ELSE dbo.dsi_fnpadzero((ISNULL(REPLACE(EecAnnSalary,'.', ''),0)),11,0) END
    INTO dbo.U_EMSSUNLIFE_drvTbl
    FROM dbo.U_EMSSUNLIFE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    LEFT JOIN dbo.U_EMSSUNLIFE_PEarHist WITH (NOLOCK)
        ON PehEEID  = XEEID
    JOIN dbo.company WITH (NOLOCK) 
        on cmpcoid = xcoid
     LEFT JOIN dbo.U_EMSSUNLIFE_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    WHERE cmpCompanyCode = 'MVSC'  and EecEEType = 'REG'
     AND EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audterm  = 'Y' AND audTermDate is not null)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMSSUNLIFE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EMSSUNLIFE_Header;
    SELECT DISTINCT
         drvRecordCount = (Select Count(*) from dbo.U_EMSSUNLIFE_drvTbl)
    INTO dbo.U_EMSSUNLIFE_Header
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
ALTER VIEW dbo.dsi_vwEMSSUNLIFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMSSUNLIFE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMSSUNLIFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303141'
       ,expStartPerControl     = '202303141'
       ,expLastEndPerControl   = '202303219'
       ,expEndPerControl       = '202303219'
WHERE expFormatCode = 'EMSSUNLIFE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMSSUNLIFE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMSSUNLIFE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMSSUNLIFE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMSSUNLIFE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMSSUNLIFE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMSSUNLIFE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMSSUNLIFE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMSSUNLIFE', 'UseFileName', 'V', 'Y'


-- End ripout