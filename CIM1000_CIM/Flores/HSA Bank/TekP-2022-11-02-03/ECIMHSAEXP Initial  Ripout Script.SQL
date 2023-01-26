/**********************************************************************************

ECIMHSAEXP: HSA Bank FSA, HSA, Parking & Transit Enrollment

FormatCode:     ECIMHSAEXP
Project:        HSA Bank FSA, HSA, Parking & Transit Enrollment
Client ID:      USG1000
Date/time:      2023-01-24 13:50:47.920
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ECIMHSAEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECIMHSAEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ECIMHSAEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECIMHSAEXP'


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
WHERE FormatCode = 'ECIMHSAEXP'
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
WHERE ExpFormatCode = 'ECIMHSAEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECIMHSAEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECIMHSAEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECIMHSAEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECIMHSAEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECIMHSAEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECIMHSAEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECIMHSAEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECIMHSAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECIMHSAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECIMHSAEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECIMHSAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIMHSAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIMHSAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIMHSAEXP];
GO
IF OBJECT_ID('U_ECIMHSAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_PDedHist];
GO
IF OBJECT_ID('U_ECIMHSAEXP_Header_FH') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_Header_FH];
GO
IF OBJECT_ID('U_ECIMHSAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_File];
GO
IF OBJECT_ID('U_ECIMHSAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_EEList];
GO
IF OBJECT_ID('U_ECIMHSAEXP_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_drvTbl_PT];
GO
IF OBJECT_ID('U_ECIMHSAEXP_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_drvTbl_EN];
GO
IF OBJECT_ID('U_ECIMHSAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_DedList];
GO
IF OBJECT_ID('U_ECIMHSAEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_AuditFields];
GO
IF OBJECT_ID('U_ECIMHSAEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECIMHSAEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECIMHSAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIMHSAEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIMHSAEXP','HSA Bank FSA, HSA, Parking & Transit Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECIMHSAEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIMHSAEXPZ0','2','H','01','1',NULL,'Record Type ',NULL,NULL,'"FH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIMHSAEXPZ0','1','H','01','2',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIMHSAEXPZ0','6','H','01','3',NULL,'Employer or Partner Code',NULL,NULL,'"CIM326"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIMHSAEXPZ0','40','H','01','4',NULL,'Emai Address',NULL,NULL,'"manoff@cimgroup.com"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIMHSAEXPZ0','8','H','01','5',NULL,'Date ',NULL,NULL,'"drvDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIMHSAEXPZ0','5','H','01','6',NULL,'Number of Records ',NULL,NULL,'"drvNumberOfRecords"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIMHSAEXPZ0','5','H','01','7',NULL,'File  Version Number',NULL,NULL,'"2.2.0"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIMHSAEXPZ0','2','H','01','8',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIMHSAEXPZ0','2','D','10','1',NULL,'Record Type',NULL,NULL,'"PT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIMHSAEXPZ0','10','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIMHSAEXPZ0','30','D','10','3',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIMHSAEXPZ0','30','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIMHSAEXPZ0','1','D','10','5',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIMHSAEXPZ0','9','D','10','6',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIMHSAEXPZ0','8','D','10','7',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIMHSAEXPZ0','1','D','10','8',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIMHSAEXPZ0','50','D','10','9',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIMHSAEXPZ0','50','D','10','10',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIMHSAEXPZ0','2','D','10','11',NULL,'Mailing Method',NULL,NULL,'"drvMailingMethod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIMHSAEXPZ0','50','D','10','12',NULL,'Street Address Line 1',NULL,NULL,'"drvStreetAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIMHSAEXPZ0','50','D','10','13',NULL,'Street Address Line 2',NULL,NULL,'"drvStreetAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIMHSAEXPZ0','30','D','10','14',NULL,'Street Address City',NULL,NULL,'"drvStreAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIMHSAEXPZ0','2','D','10','15',NULL,'Street Address State',NULL,NULL,'"drvStreAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIMHSAEXPZ0','10','D','10','16',NULL,'Street Address Zip Code',NULL,NULL,'"drvStreetAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIMHSAEXPZ0','2','D','10','17',NULL,'Street Address Country',NULL,NULL,'"drvStreAddressCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIMHSAEXPZ0','50','D','10','18',NULL,'Mailing Address Line1',NULL,NULL,'"drvMailAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIMHSAEXPZ0','50','D','10','19',NULL,'Mailing Address Line2',NULL,NULL,'"drvMailAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIMHSAEXPZ0','30','D','10','20',NULL,'Mailing City',NULL,NULL,'"drvMailingCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIMHSAEXPZ0','2','D','10','21',NULL,'Mariling State',NULL,NULL,'"drvMarilingState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECIMHSAEXPZ0','9','D','10','22',NULL,'Mailing ZipCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECIMHSAEXPZ0','2','D','10','23',NULL,'Mailing Country',NULL,NULL,'"drvMailingCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECIMHSAEXPZ0','10','D','10','24',NULL,'Hone Phone',NULL,NULL,'"drvHonePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECIMHSAEXPZ0','10','D','10','25',NULL,'Business Phone',NULL,NULL,'"drvBusinessPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECIMHSAEXPZ0','6','D','10','26',NULL,'Business Phone Extension',NULL,NULL,'"drvBusiPhoneExtension"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECIMHSAEXPZ0','124','D','10','27',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECIMHSAEXPZ0','1','D','10','28',NULL,'Participant Employment Status',NULL,NULL,'"drvPartEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECIMHSAEXPZ0','8','D','10','29',NULL,'Status Effective Date',NULL,NULL,'"drvStatEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECIMHSAEXPZ0','3','D','10','30',NULL,'Citizenship Status',NULL,NULL,'"drvCitizenshipStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECIMHSAEXPZ0','2','D','10','31',NULL,'Country of Citizenship',NULL,NULL,'"drvCountryofCitizenship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECIMHSAEXPZ0','1','D','10','32',NULL,'Employemnt Status',NULL,NULL,'"drvEmployemntStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECIMHSAEXPZ0','150','D','10','33',NULL,'Employer Name',NULL,NULL,'"drvEmployerName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECIMHSAEXPZ0','30','D','10','34',NULL,'Job Title Profession',NULL,NULL,'"drvJobTitleProfession"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECIMHSAEXPZ0','8','D','10','35',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECIMHSAEXPZ0','100','D','10','36',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECIMHSAEXPZ0','2','D','10','37',NULL,'Hours Per Week',NULL,NULL,'"drvHourPerWeek"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECIMHSAEXPZ0','2','D','10','38',NULL,'Employer Class',NULL,NULL,'"drvEmployerClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECIMHSAEXPZ0','50','D','10','39',NULL,'Payroll Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECIMHSAEXPZ0','8','D','10','40',NULL,'Payroll Frequency Effective Date',NULL,NULL,'"drvPayrollFrequencyEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECIMHSAEXPZ0','8','D','10','41',NULL,'Final Payroll Process Date',NULL,NULL,'"drvFinalPayrollProcessDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECIMHSAEXPZ0','8','D','10','42',NULL,'Final Cont Process Date',NULL,NULL,'"drvFinalContProcessDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECIMHSAEXPZ0','9','D','10','43',NULL,'FedID or EIN',NULL,NULL,'"drvFedIorEIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECIMHSAEXPZ0','20','D','10','44',NULL,'Plan Preference',NULL,NULL,'"drvPlanPreference"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECIMHSAEXPZ0','1','D','10','45',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECIMHSAEXPZ0','1','D','10','46',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECIMHSAEXPZ0','1','D','10','47',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECIMHSAEXPZ0','1','D','10','48',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECIMHSAEXPZ0','1','D','10','49',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECIMHSAEXPZ0','1','D','10','50',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECIMHSAEXPZ0','1','D','10','51',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECIMHSAEXPZ0','1','D','10','52',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECIMHSAEXPZ0','1','D','10','53',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECIMHSAEXPZ0','1','D','10','54',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECIMHSAEXPZ0','1','D','10','55',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIMHSAEXPZ0','2','D','20','1',NULL,'Record Type',NULL,NULL,'"EN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIMHSAEXPZ0','20','D','20','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIMHSAEXPZ0','100','D','20','3',NULL,'Plan Type',NULL,NULL,'"drvPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIMHSAEXPZ0','255','D','20','4',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIMHSAEXPZ0','8','D','20','5',NULL,'Enrollment Effective Date  ',NULL,NULL,'"drvEnrollEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIMHSAEXPZ0','12','D','20','6',NULL,'Participant Election Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIMHSAEXPZ0','2','D','20','7',NULL,'Employer Contrib Level',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIMHSAEXPZ0','12','D','20','8',NULL,'Employer Contrib Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIMHSAEXPZ0','2','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIMHSAEXPZ0','2','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIMHSAEXPZ0','1','D','20','11',NULL,'EnrolledinClaimsExchange',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIMHSAEXPZ0','2','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'"drvElectionAmountInd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIMHSAEXPZ0','1','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL,'"drvHDHPCovLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIMHSAEXPZ0','8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIMHSAEXPZ0','8','D','20','15',NULL,'Enrollment Termination Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIMHSAEXPZ0','1','D','20','16',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIMHSAEXPZ0','1','D','20','17',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIMHSAEXPZ0','1','D','20','18',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIMHSAEXPZ0','1','D','20','19',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIMHSAEXPZ0','1','D','20','20',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIMHSAEXPZ0','1','D','20','21',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECIMHSAEXPZ0','1','D','20','22',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECIMHSAEXPZ0','1','D','20','23',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECIMHSAEXPZ0','1','D','20','24',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECIMHSAEXPZ0','1','D','20','25',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECIMHSAEXP_20230124.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202301249','EMPEXPORT','OEACTIVE',NULL,'ECIMHSAEXP',NULL,NULL,NULL,'202301249','Jan 24 2023 12:28PM','Jan 24 2023 12:28PM','202301241',NULL,'','','202301241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202301249','EMPEXPORT','OEPASSIVE',NULL,'ECIMHSAEXP',NULL,NULL,NULL,'202301249','Jan 24 2023 12:28PM','Jan 24 2023 12:28PM','202301241',NULL,'','','202301241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HSA Bank FSA, HSA, Parking & T','202301249','EMPEXPORT','ONDEM_XOE',NULL,'ECIMHSAEXP',NULL,NULL,NULL,'202301249','Jan 24 2023 12:28PM','Jan 24 2023 12:28PM','202301241',NULL,'','','202301241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HSA Bank FSA, HSA, Parki-Sched','202301249','EMPEXPORT','SCH_ECIMHS',NULL,'ECIMHSAEXP',NULL,NULL,NULL,'202301249','Jan 24 2023 12:28PM','Jan 24 2023 12:28PM','202301241',NULL,'','','202301241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HSA Bank FSA, HSA, Parki-Test','202301249','EMPEXPORT','TEST_XOE',NULL,'ECIMHSAEXP',NULL,NULL,NULL,'202301249','Jan 24 2023 12:28PM','Jan 24 2023 12:28PM','202301241',NULL,'','','202301241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIMHSAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIMHSAEXP','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIMHSAEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIMHSAEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIMHSAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIMHSAEXP','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIMHSAEXP','H01','dbo.U_ECIMHSAEXP_Header_FH',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIMHSAEXP','D10','dbo.U_ECIMHSAEXP_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIMHSAEXP','D20','dbo.U_ECIMHSAEXP_drvTbl_EN',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECIMHSAEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ECIMHSAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIMHSAEXP] (
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
-- Create table U_ECIMHSAEXP_Audit
-----------

IF OBJECT_ID('U_ECIMHSAEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_Audit] (
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
-- Create table U_ECIMHSAEXP_AuditFields
-----------

IF OBJECT_ID('U_ECIMHSAEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECIMHSAEXP_DedList
-----------

IF OBJECT_ID('U_ECIMHSAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECIMHSAEXP_drvTbl_EN
-----------

IF OBJECT_ID('U_ECIMHSAEXP_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeId] char(9) NULL,
    [drvPlanType] varchar(7) NULL,
    [drvPlanName] varchar(38) NULL,
    [drvEnrollEffDate] datetime NULL,
    [drvElectionAmountInd] varchar(2) NOT NULL,
    [drvHDHPCovLevel] varchar(1) NULL
);

-----------
-- Create table U_ECIMHSAEXP_drvTbl_PT
-----------

IF OBJECT_ID('U_ECIMHSAEXP_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeId] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvSSN] char(11) NULL,
    [drvDOB] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvMailingMethod] varchar(2) NOT NULL,
    [drvStreetAddressLine1] varchar(255) NULL,
    [drvStreetAddressLine2] varchar(255) NULL,
    [drvStreAddressCity] varchar(255) NULL,
    [drvStreAddressState] varchar(255) NULL,
    [drvStreetAddressZipCode] varchar(50) NULL,
    [drvStreAddressCountry] varchar(2) NULL,
    [drvMailAddressLine1] varchar(255) NULL,
    [drvMailAddressLine2] varchar(255) NULL,
    [drvMailingCity] varchar(255) NULL,
    [drvMarilingState] varchar(255) NULL,
    [drvMailingCountry] varchar(2) NULL,
    [drvHonePhone] varchar(1) NOT NULL,
    [drvBusinessPhone] varchar(1) NOT NULL,
    [drvBusiPhoneExtension] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(1) NOT NULL,
    [drvPartEmploymentStatus] varchar(1) NULL,
    [drvStatEffectiveDate] datetime NULL,
    [drvCitizenshipStatus] varchar(1) NOT NULL,
    [drvCountryofCitizenship] varchar(1) NOT NULL,
    [drvEmployemntStatus] varchar(1) NOT NULL,
    [drvEmployerName] varchar(9) NOT NULL,
    [drvJobTitleProfession] varchar(150) NULL,
    [drvHireDate] datetime NULL,
    [drvDivision] char(5) NOT NULL,
    [drvHourPerWeek] varchar(1) NOT NULL,
    [drvEmployerClass] varchar(2) NOT NULL,
    [drvPayrollFrequency] varchar(1) NOT NULL,
    [drvPayrollFrequencyEffDate] varchar(1) NOT NULL,
    [drvFinalPayrollProcessDate] varchar(1) NOT NULL,
    [drvFinalContProcessDate] varchar(1) NOT NULL,
    [drvFedIorEIN] char(9) NULL,
    [drvPlanPreference] varchar(1) NOT NULL
);

-----------
-- Create table U_ECIMHSAEXP_EEList
-----------

IF OBJECT_ID('U_ECIMHSAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECIMHSAEXP_File
-----------

IF OBJECT_ID('U_ECIMHSAEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECIMHSAEXP_Header_FH
-----------

IF OBJECT_ID('U_ECIMHSAEXP_Header_FH') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_Header_FH] (
    [drvDate] varchar(8) NULL,
    [drvNumberOfRecords] int NULL
);

-----------
-- Create table U_ECIMHSAEXP_PDedHist
-----------

IF OBJECT_ID('U_ECIMHSAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIMHSAEXP_PDedHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIMHSAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CIM Group

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/24/2023
Service Request Number: TekP-2022-11-02-03 

Purpose: HSA Bank FSA, HSA, Parking & Transit Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIMHSAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIMHSAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIMHSAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIMHSAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIMHSAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIMHSAEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIMHSAEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIMHSAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIMHSAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIMHSAEXP', 'SCH_ECIMHS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIMHSAEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECIMHSAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@MinCovDate        DATETIME;;

    -- Set FormatCode
    SELECT @FormatCode = 'ECIMHSAEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate        = Replace(CONVERT(VARCHAR(10),GETDATE(),101), '/', '')
        ,@MinCovDate      = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECIMHSAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIMHSAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECIMHSAEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_AuditFields;
    CREATE TABLE dbo.U_ECIMHSAEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECIMHSAEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_Audit;
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
    INTO dbo.U_ECIMHSAEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECIMHSAEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECIMHSAEXP_Audit ON dbo.U_ECIMHSAEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECIMHSAEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECIMHSAEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CMPOT,CMPRT,FSADC,FSAI,FSAMD,HSA,HSAER,PKPOT,PKPRT';

    IF OBJECT_ID('U_ECIMHSAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIMHSAEXP_DedList
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
    IF OBJECT_ID('U_ECIMHSAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_PDedHist;
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
    INTO dbo.U_ECIMHSAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIMHSAEXP_DedList WITH (NOLOCK)
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
    -- DETAIL RECORD - U_ECIMHSAEXP_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_ECIMHSAEXP_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo 
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvEmployeeId = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvSSN = eepSSN
        ,drvDOB = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('M', 'S') THEN EepMaritalStatus ELSE 'U' END
        ,drvMailingMethod = CASE WHEN eepaddressline1 LIKE '%PO Box%' THEN 'PO' else 'ST' END
        ,drvStreetAddressLine1 = CASE WHEN eepaddressline1 NOT LIKE '%PO Box%' THEN EepAddressLine1 END
        ,drvStreetAddressLine2 = CASE WHEN eepaddressline1 NOT LIKE '%PO Box%' THEN EepAddressLine2 END
        ,drvStreAddressCity = CASE WHEN eepaddressline1 NOT LIKE '%PO Box%'  THEN EepAddressCity END
        ,drvStreAddressState = CASE WHEN eepaddressline1 NOT LIKE '%PO Box%' THEN EepAddressState END
        ,drvStreetAddressZipCode = CASE WHEN eepaddressline1 NOT LIKE '%PO Box%'  THEN EepAddressZipCode END
        ,drvStreAddressCountry = CASE WHEN eepaddressline1 NOT LIKE '%PO Box%'  THEN 'US' END
        ,drvMailAddressLine1 = CASE WHEN eepaddressline1 LIKE '%PO Box%' THEN EepAddressLine1 END
        ,drvMailAddressLine2 = CASE WHEN eepaddressline1  LIKE '%PO Box%' THEN EepAddressLine2 END
        ,drvMailingCity = CASE WHEN eepaddressline1  LIKE '%PO Box%'  THEN EepAddressCity END
        ,drvMarilingState = CASE WHEN eepaddressline1 LIKE '%PO Box%' THEN EepAddressState END
        ,drvMailingCountry = CASE WHEN eepaddressline1 LIKE '%PO Box%'  THEN 'US' END
        ,drvHonePhone = ''
        ,drvBusinessPhone = ''
        ,drvBusiPhoneExtension = ''--EecPhoneBusinessExt
        ,drvEmailAddress = ''--EepAddressEMail
        ,drvPartEmploymentStatus = CASE WHEN Eecemplstatus IN ('T', 'L') THEN Eecemplstatus ELSE 'A' END
        ,drvStatEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEn EecDateOfTermination
                                     WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate 
                                     ELSE EecDateOfLastHire END
        ,drvCitizenshipStatus = ''
        ,drvCountryofCitizenship = ''
        ,drvEmployemntStatus = 'E'
        ,drvEmployerName = 'CIM Group'
        ,drvJobTitleProfession =  EecJobtitle
        ,drvHireDate = EecDateOfLastHire
        ,drvDivision = cmpCOID
        ,drvHourPerWeek = ''
        ,drvEmployerClass = 'CL'
        ,drvPayrollFrequency = 'O'
        ,drvPayrollFrequencyEffDate = ''
        ,drvFinalPayrollProcessDate = ''
        ,drvFinalContProcessDate = ''
        ,drvFedIorEIN = CmpFedTaxID
        ,drvPlanPreference = ''
    INTO dbo.U_ECIMHSAEXP_drvTbl_PT
    FROM dbo.U_ECIMHSAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ECIMHSAEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID    
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = XCOID
        Where cmpCOID in ( 'LGVXB','K74QY','QFNXX','EM225','WS9FU','YRIRY','BDJ37','KF5AF','0X1OT','KF5IS','FIRFC')

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECIMHSAEXP_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_ECIMHSAEXP_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo 
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvEmployeeId = EecEmpNo
        ,drvPlanType = CASE WHEN Bdmdedcode IN ('FSADC','FSAI','FSAMD') THEN 'FSA'
                            WHEN BdmdedCode IN ('HSA','HSAER') THEN 'HSA' 
                            WHEN BdmdedCode IN ('CMPOT','CMPRT') THEN 'Transit' 
                            WHEN BdmdedCode IN ('PKPOT','PKPRT') THEN 'Parking'
                            END
        ,drvPlanName = CASE WHEN Bdmdedcode = 'HSA'  THEN 'Health Savings Account'
                            WHEN Bdmdedcode= 'FSAMD' THEN  'Medical FSA'
                            WHEN Bdmdedcode= 'FSAI'  THEN  'Limited FSA'
                            WHEN Bdmdedcode= 'FSADC' THEN  'Dependent Care'
                            WHEN Bdmdedcode= 'CMPRT' THEN  'Commuter Benefit Mass Transit Pre Tax'
                            WHEN Bdmdedcode= 'PKPRT' THEN  'Commuter Benefit Parking Pre Tax'
                            WHEN Bdmdedcode= 'CMPOT' THEN  'Commuter Benefit Mass Transit Post Tax'
                            WHEN Bdmdedcode= 'PKPOT' THEN  'Commuter Benefit Parking Post Tax'
                            END
        ,drvEnrollEffDate =  dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, BdmBenStartDate) 
        ,drvElectionAmountInd = 'PY'
        ,drvHDHPCovLevel = CASE WHEN eepMaritalStatus = 'S' THEN 'S' 
                                WHEN eepMaritalStatus = 'M' THEN 'F'
                                END
    INTO dbo.U_ECIMHSAEXP_drvTbl_EN
    FROM dbo.U_ECIMHSAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECIMHSAEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECIMHSAEXP_Header_FH','U') IS NOT NULL
        DROP TABLE dbo.U_ECIMHSAEXP_Header_FH;
    SELECT DISTINCT
         drvDate = @RunDate 
        ,drvNumberOfRecords = ((Select Count(*) from dbo.U_ECIMHSAEXP_drvTbl_EN) + (Select Count(*) from dbo.U_ECIMHSAEXP_drvTbl_PT))
    INTO dbo.U_ECIMHSAEXP_Header_FH
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
ALTER VIEW dbo.dsi_vwECIMHSAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIMHSAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECIMHSAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301171'
       ,expStartPerControl     = '202301171'
       ,expLastEndPerControl   = '202301249'
       ,expEndPerControl       = '202301249'
WHERE expFormatCode = 'ECIMHSAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIMHSAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIMHSAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECIMHSAEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECIMHSAEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECIMHSAEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIMHSAEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECIMHSAEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIMHSAEXP', 'UseFileName', 'V', 'Y'


-- End ripout