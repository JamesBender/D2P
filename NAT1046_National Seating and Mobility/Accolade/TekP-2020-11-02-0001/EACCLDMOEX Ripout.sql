/**********************************************************************************

EACCLDMOEX: Accolade Demo & Eligibiliy Export

FormatCode:     EACCLDMOEX
Project:        Accolade Demo & Eligibiliy Export
Client ID:      NAT1046
Date/time:      2021-12-26 16:57:58.087
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB02
Database:       ULTIPRO_WPNSMIN
Web Filename:   NAT1046_FT16A_EEHISTORY_EACCLDMOEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EACCLDMOEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EACCLDMOEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EACCLDMOEX'


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
WHERE FormatCode = 'EACCLDMOEX'
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
WHERE ExpFormatCode = 'EACCLDMOEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EACCLDMOEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EACCLDMOEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EACCLDMOEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EACCLDMOEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EACCLDMOEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EACCLDMOEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EACCLDMOEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EACCLDMOEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EACCLDMOEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EACCLDMOEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEACCLDMOEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEACCLDMOEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EACCLDMOEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EACCLDMOEX];
GO
IF OBJECT_ID('U_EACCLDMOEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_Trailer];
GO
IF OBJECT_ID('U_EACCLDMOEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_Header];
GO
IF OBJECT_ID('U_EACCLDMOEX_File') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_File];
GO
IF OBJECT_ID('U_EACCLDMOEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_EEList];
GO
IF OBJECT_ID('U_EACCLDMOEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_drvTbl];
GO
IF OBJECT_ID('U_EACCLDMOEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_DedList];
GO
IF OBJECT_ID('U_EACCLDMOEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_AuditFields];
GO
IF OBJECT_ID('U_EACCLDMOEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EACCLDMOEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EACCLDMOEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EACCLDMOEX','Accolade Demo & Eligibiliy Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EACCLDMOEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EACCLDMOEXZ0','50','H','01','1',NULL,'Plan Sponsor Name',NULL,NULL,'"NSM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EACCLDMOEXZ0','50','H','01','2',NULL,'Data Partner Name',NULL,NULL,'"NSM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EACCLDMOEXZ0','50','H','01','3',NULL,'Date/Time of Extract',NULL,NULL,'"drvCurrentDateAndTime"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EACCLDMOEXZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EACCLDMOEXZ0','50','D','10','2',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EACCLDMOEXZ0','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EACCLDMOEXZ0','50','D','10','4',NULL,'Dependent ID',NULL,NULL,'"drvDependentID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EACCLDMOEXZ0','50','D','10','5',NULL,'Alternate Employee ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EACCLDMOEXZ0','50','D','10','6',NULL,'Alternate Dependent ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EACCLDMOEXZ0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EACCLDMOEXZ0','50','D','10','8',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EACCLDMOEXZ0','50','D','10','9',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EACCLDMOEXZ0','50','D','10','10',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EACCLDMOEXZ0','50','D','10','11',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EACCLDMOEXZ0','50','D','10','12',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EACCLDMOEXZ0','50','D','10','13',NULL,'Relationship to Employee',NULL,NULL,'"drvRelationshipToEmployee"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EACCLDMOEXZ0','50','D','10','14',NULL,'Dependent Special Status',NULL,NULL,'"drvDependentSpecialStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EACCLDMOEXZ0','50','D','10','15',NULL,'Qualified Medical Support Order',NULL,NULL,'"drvQualifiedMedSupportOrder"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EACCLDMOEXZ0','50','D','10','16',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EACCLDMOEXZ0','50','D','10','17',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EACCLDMOEXZ0','50','D','10','18',NULL,'Address City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EACCLDMOEXZ0','50','D','10','19',NULL,'Address State',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EACCLDMOEXZ0','50','D','10','20',NULL,'Address Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EACCLDMOEXZ0','50','D','10','21',NULL,'Address Country Code',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EACCLDMOEXZ0','50','D','10','22',NULL,'Primary Phone Number',NULL,NULL,'"drvPrimaryPhoneNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EACCLDMOEXZ0','50','D','10','23',NULL,'Mobile Cell Phone Number',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EACCLDMOEXZ0','50','D','10','24',NULL,'Email Address 1',NULL,NULL,'"drvEmailAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EACCLDMOEXZ0','50','D','10','25',NULL,'Email Address 2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EACCLDMOEXZ0','50','D','10','26',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EACCLDMOEXZ0','50','D','10','27',NULL,'Employee Hire Date',NULL,NULL,'"drvEmployeeHireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EACCLDMOEXZ0','50','D','10','28',NULL,'Employee Termination Date',NULL,NULL,'"drvEmployeeTerminationDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EACCLDMOEXZ0','50','D','10','29',NULL,'Reg/Temp Indicator',NULL,NULL,'"drvRegTempIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EACCLDMOEXZ0','50','D','10','30',NULL,'Full-Time / Part-Time Indicator',NULL,NULL,'"drvFullPartTimeIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EACCLDMOEXZ0','50','D','10','31',NULL,'Benefit Eligibility Flag',NULL,NULL,'"Y"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EACCLDMOEXZ0','50','D','10','32',NULL,'Benefit Eligibility Date',NULL,NULL,'"drvBenefitEligbilityDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EACCLDMOEXZ0','50','D','10','33',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EACCLDMOEXZ0','50','D','10','34',NULL,'Work Location',NULL,NULL,'"drvWorkLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EACCLDMOEXZ0','50','D','10','35',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EACCLDMOEXZ0','50','D','10','36',NULL,'Job Description',NULL,NULL,'"drvJobDescription"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EACCLDMOEXZ0','50','D','10','37',NULL,'Union Code',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EACCLDMOEXZ0','50','D','10','38',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EACCLDMOEXZ0','50','D','10','39',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EACCLDMOEXZ0','50','D','10','40',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EACCLDMOEXZ0','50','D','10','41',NULL,'Status Change Date',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EACCLDMOEXZ0','50','D','10','42',NULL,'Hours',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EACCLDMOEXZ0','50','D','10','43',NULL,'Pay Frequency',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EACCLDMOEXZ0','50','D','10','44',NULL,'Pay Group',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EACCLDMOEXZ0','50','D','10','45',NULL,'Company ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EACCLDMOEXZ0','50','D','10','46',NULL,'Directory Key',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EACCLDMOEXZ0','50','D','10','47',NULL,'Benefit Type',NULL,NULL,'"drvBenefitType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EACCLDMOEXZ0','50','D','10','48',NULL,'Benefit Plan ID',NULL,NULL,'"drvBenefitPlanId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EACCLDMOEXZ0','50','D','10','49',NULL,'Coverage Tier',NULL,NULL,'"drvCoverageTier"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EACCLDMOEXZ0','50','D','10','50',NULL,'Benefit Coverage Effective Date',NULL,NULL,'"drvBenefitCoverageEffDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EACCLDMOEXZ0','50','D','10','51',NULL,'Benefit Coverage Expiration Date',NULL,NULL,'"drvBenefitCoverageExpDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EACCLDMOEXZ0','50','D','10','52',NULL,'Benefit Plan Year',NULL,NULL,'"drvBenefitPlanYear"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EACCLDMOEXZ0','50','D','10','53',NULL,'Coverage Status Modifier',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EACCLDMOEXZ0','50','D','10','54',NULL,'COBRA Paid Through Date',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EACCLDMOEXZ0','50','D','10','55',NULL,'COBRA End Date',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EACCLDMOEXZ0','50','D','10','56',NULL,'CDF 1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EACCLDMOEXZ0','50','D','10','57',NULL,'CDF 2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EACCLDMOEXZ0','50','D','10','58',NULL,'CDF 3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EACCLDMOEXZ0','50','D','10','59',NULL,'CDF 4',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EACCLDMOEXZ0','50','D','10','60',NULL,'CDF 5',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EACCLDMOEXZ0','50','D','10','61',NULL,'CDF 6',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EACCLDMOEXZ0','50','D','10','62',NULL,'CDF 7',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EACCLDMOEXZ0','50','D','10','63',NULL,'CDF 8',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EACCLDMOEXZ0','50','D','10','64',NULL,'CDF 9',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EACCLDMOEXZ0','50','D','10','65',NULL,'CDF 10',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EACCLDMOEXZ0','50','T','90','1',NULL,'Plan Sponsor Name',NULL,NULL,'"NSM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EACCLDMOEXZ0','50','T','90','2',NULL,'Data Partner Name',NULL,NULL,'"NSM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EACCLDMOEXZ0','50','T','90','3',NULL,'Date/Time of Extract',NULL,NULL,'"drvCurrentDateAndTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EACCLDMOEXZ0','50','T','90','4',NULL,'Total Number of Records',NULL,NULL,'"drvTotalNumberOfRecords"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EACCLDMOEX_20211226.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202103159','EMPEXPORT','OEACTIVE','Dec 23 2020  2:09PM','EACCLDMOEX',NULL,NULL,NULL,'202103159','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202101011','7722','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3lKiNAT1046',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202103159','EMPEXPORT','OEPASSIVE',NULL,'EACCLDMOEX',NULL,NULL,NULL,'202103159','Dec 15 2020  2:04PM','Dec 15 2020  2:04PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Accolade Demo & Eligibiliy Exp','202103159','EMPEXPORT','ONDEM_XOE',NULL,'EACCLDMOEX',NULL,NULL,NULL,'202103159','Dec 15 2020  2:04PM','Dec 15 2020  2:04PM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',GUKOG,GUKTI,Z9C1Y,Z9AQA,Z996B,GUKJM,Z96I6,GUK5L',NULL,NULL,NULL,'Accolade Ben Elig - Tues 7am','202103159','EMPEXPORT','SCH_EACCLD',NULL,'EACCLDMOEX',NULL,NULL,NULL,'202112219','Dec 15 2020  2:04PM','Dec 15 2020  2:04PM','202112141',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Accolade Demo & Eligibil-Test','202105049','EMPEXPORT','TEST_XOE','May  4 2021  1:41PM','EACCLDMOEX',NULL,NULL,NULL,'202105049','May  4 2021 12:00AM','Dec 30 1899 12:00AM','202104271','8191','','','202104271',dbo.fn_GetTimedKey(),NULL,'us3lKiNAT1046',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACCLDMOEX','H01','dbo.U_EACCLDMOEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACCLDMOEX','D10','dbo.U_EACCLDMOEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACCLDMOEX','T90','dbo.U_EACCLDMOEX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EACCLDMOEX
-----------

IF OBJECT_ID('U_dsi_BDM_EACCLDMOEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EACCLDMOEX] (
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
-- Create table U_EACCLDMOEX_Audit
-----------

IF OBJECT_ID('U_EACCLDMOEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL
);

-----------
-- Create table U_EACCLDMOEX_AuditFields
-----------

IF OBJECT_ID('U_EACCLDMOEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EACCLDMOEX_DedList
-----------

IF OBJECT_ID('U_EACCLDMOEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EACCLDMOEX_drvTbl
-----------

IF OBJECT_ID('U_EACCLDMOEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(13) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvDependentID] nvarchar(4000) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvMaritalStatus] varchar(2) NOT NULL,
    [drvRelationshipToEmployee] varchar(1) NULL,
    [drvDependentSpecialStatus] varchar(1) NULL,
    [drvQualifiedMedSupportOrder] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPrimaryPhoneNumber] varchar(50) NULL,
    [drvEmailAddress1] varchar(50) NULL,
    [drvEmployeeStatus] varchar(1) NOT NULL,
    [drvEmployeeHireDate] datetime NULL,
    [drvEmployeeTerminationDate] datetime NULL,
    [drvRegTempIndicator] varchar(1) NOT NULL,
    [drvFullPartTimeIndicator] char(1) NULL,
    [drvBenefitEligbilityDate] datetime NULL,
    [drvDivision] char(5) NULL,
    [drvWorkLocation] char(6) NULL,
    [drvJobCode] char(8) NULL,
    [drvJobDescription] varchar(25) NOT NULL,
    [drvDepartment] varchar(10) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvRehireDate] datetime NULL,
    [drvBenefitType] varchar(1) NULL,
    [drvBenefitPlanId] varchar(40) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvBenefitCoverageEffDate] datetime NULL,
    [drvBenefitCoverageExpDate] datetime NULL,
    [drvBenefitPlanYear] int NULL
);

-----------
-- Create table U_EACCLDMOEX_EEList
-----------

IF OBJECT_ID('U_EACCLDMOEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EACCLDMOEX_File
-----------

IF OBJECT_ID('U_EACCLDMOEX_File') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EACCLDMOEX_Header
-----------

IF OBJECT_ID('U_EACCLDMOEX_Header') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_Header] (
    [drvCurrentDateAndTime] varchar(17) NULL
);

-----------
-- Create table U_EACCLDMOEX_Trailer
-----------

IF OBJECT_ID('U_EACCLDMOEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_Trailer] (
    [drvCurrentDateAndTime] varchar(17) NULL,
    [drvTotalNumberOfRecords] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EACCLDMOEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: National Seating & Mobility

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/15/2020
Service Request Number: TekP-2020-11-02-0001

Purpose: Accolade Demo & Eligibiliy Export

Revision History
----------------
Update By           Date           Request Num            Desc
Darren Collard      12/26.2021     TekP-2021-11-12-0005   Added DEN3

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EACCLDMOEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EACCLDMOEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EACCLDMOEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EACCLDMOEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EACCLDMOEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'SCH_EACCLD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EACCLDMOEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EACCLDMOEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EACCLDMOEX';

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
    DELETE FROM dbo.U_EACCLDMOEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EACCLDMOEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EACCLDMOEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE EecDedGroupCode IN ('PTEE')
    )

    DELETE FROM dbo.U_EACCLDMOEX_EEList WHERE xEEID IN ('C1GLT600Z0K0','C7DCV600M0K0','C7HHZS0000K0','C8YWUV0000K0');

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN1,DEN2,DEN3,MED1,MED2,MED3,VIS,MED4,MED5';

    IF OBJECT_ID('U_EACCLDMOEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EACCLDMOEX_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate'); --'AuditDate');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate'); --'AuditDate');

    
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


    INSERT INTO [dbo].[U_dsi_BDM_EACCLDMOEX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB])
    SELECT DISTINCT RecType = 'DEP' 
        ,EecCOID 
        ,EecEEID 
        ,DbnDepRecID
        ,DbnDepRecID
        ,''
        ,'Deduction termed within/after date range'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedCode 
        ,EedBenOption
        ,EedBenStatus
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,DbnBenStatusDate
        ,''
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,'N'
    FROM dbo.U_dsi_BDM_DepDeductions 
        JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = DbnEEID
        JOIN dbo.EmpDed ON EedEEID = DbnEEID AND EedDedCode = DbnDedCode
    WHERE DbnBenStartDate = DbnBenStopDate 
        AND DbnBenStartDate BETWEEN @StartDate AND @EndDate
        AND DbnFormatCode = 'EACCLDMOEX'    








/*    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EACCLDMOEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_AuditFields;
    CREATE TABLE dbo.U_EACCLDMOEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EACCLDMOEX_AuditFields VALUES ('EmpDed','EedBenOption');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EACCLDMOEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_Audit;
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
    INTO dbo.U_EACCLDMOEX_Audit
    FROM dbo.U_EACCLDMOEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EACCLDMOEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime <= @EndDate
    AND audAction <> 'DELETE'
    AND AudKey3Value IN ('DEN1','DEN2','DEN3','MED1','MED2','MED3','VIS','MED4','MED5')
    AND ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EACCLDMOEX_Audit WHERE audRowNo > 1;*/






    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EACCLDMOEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EACCLDMOEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeSSN = eepSSN
        ,drvSSN = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvDependentID = CASE WHEN BdmRecType = 'DEP' THEN ISNULL(ConNameLast, '') + ISNULL(FORMAT(ConDateOfBirth, 'MMddyyyy'), '') + ISNULL(RIGHT(RTRIM(ConSSN),4), '') END
        ,drvNameFirst = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle, 1) END
        ,drvNameLast = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvGender = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateOfBirth = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMaritalStatus = CASE EepMaritalStatus
                                WHEN 'M' THEN '1'
                                WHEN 'S' THEN '2'
                                WHEN 'D' THEN '3'
                                WHEN 'W' THEN '4'
                                ELSE '10'
                            END
        ,drvRelationshipToEmployee =    CASE WHEN BdmRecType = 'DEP' THEN
                                            CASE WHEN ConRelationship = 'SPS' THEN '3'
                                                WHEN ConRelationship = 'DP' THEN '5'
                                                WHEN ConRelationship IN ('CHL','DIS','DPC','LEG','STC') THEN '7'
                                            END
                                        END
        ,drvDependentSpecialStatus = CASE WHEN BdmRecType = 'DEP' AND ConRelationship = 'DIS' AND ConIsDisabled = 'Y' THEN '2' END
        ,drvQualifiedMedSupportOrder = CASE WHEN BdmRecType = 'DEP' AND ConRelationship = 'LEG' THEN 'Y' ELSE 'N' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPrimaryPhoneNumber = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN EepPhoneHomeNumber ELSE EfoPhoneNumber END
        ,drvEmailAddress1 = EepAddressEmail
        ,drvEmployeeStatus =    CASE WHEN EecEmplStatus = 'T' AND EdhChangeReason = '210' THEN '2'
                                    WHEN EecEmplStatus = 'T' THEN '7'
                                    WHEN EecEmplStatus = 'L' AND EecLeaveReason <> '300' THEN '3'
                                    WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN '4'
                                    ELSE '1'
                                END
        ,drvEmployeeHireDate = EecDateOfLastHire
        ,drvEmployeeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRegTempIndicator = CASE WHEN EecEEType = 'TMP' THEN '0' ELSE '1' END
        ,drvFullPartTimeIndicator = EecFullTimeOrPartTime
        ,drvBenefitEligbilityDate = EecDateOfBenefitSeniority
        ,drvDivision = EecDedGroupCode
        ,drvWorkLocation = EecLocation
        ,drvJobCode = EecJobCode
        ,drvJobDescription = JbcDesc
        ,drvDepartment = EecOrgLvl3
        ,drvWorkState = LocAddressState
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvBenefitType =    CASE WHEN BdmDedCode IN ('MED1','MED2','MED3','MED4','MED5') THEN '1'
                                WHEN BdmDedCode IN ('DEN1','DEN2','DEN3') THEN '2'
                                WHEN BdmDedCode IN ('VIS') THEN '3'
                            END
        ,drvBenefitPlanId = DedLongDesc
        ,drvCoverageTier =    CASE WHEN BdmBenStopDate IS NULL THEN
                                CASE WHEN BdmBenOption = 'EE' THEN '1'
                                    WHEN BdmBenOption IN ('EES','EEDP') THEN '2'
                                    WHEN BdmBenOption IN ('EEC') THEN '3'
                                    WHEN BdmBenOption IN ('EEF','EEDPF') THEN '4'
                                END
                            ELSE 
                                CASE (SELECT TOP 1 EdhBenOption FROM dbo.EmpHDed WITH (NOLOCK) WHERE EdhEEID = xEEID AND EdhDedCode = BdmDedCode AND EdhBenStatusDate <= BdmBenStopDate ORDER BY EdhEffDate DESC)
                                    WHEN 'EE' THEN '1'
                                    WHEN 'EES' THEN '2'
                                    WHEN 'EEDP' THEN '2'
                                    WHEN 'EEC' THEN '3'
                                    WHEN 'EEF' THEN '4'
                                    WHEN 'EEDPF' THEN '4'
                                END
                            END
        --CASE WHEN AudNewValue IS NULL THEN -- 1/1 to end of Feb; emp should have 1 cov tier, dep should have 3 cov tier and a stop date
                                /*CASE WHEN AudDateTime <= @EndDate THEN
                                    CASE WHEN AudNewValue = 'EE' THEN '1'
                                        WHEN AudNewValue IN ('EES','EEDP') THEN '2'
                                        WHEN AudNewValue IN ('EEC') THEN '3'
                                        WHEN AudNewValue IN ('EEF','EEDPF') THEN '4'
                                        --ELSE '10'
                                    END
                                ELSE
                                    CASE WHEN AudOldValue = 'EE' THEN '1'
                                        WHEN AudOldValue IN ('EES','EEDP') THEN '2'
                                        WHEN AudOldValue IN ('EEC') THEN '3'
                                        WHEN AudOldValue IN ('EEF','EEDPF') THEN '4'
                                        --ELSE '10'
                                    END
                                END*/
                            --ELSE AudNewValue END
        ,drvBenefitCoverageEffDate = CASE WHEN OptBenStatusDate BETWEEN @StartDate AND @EndDate AND BdmBenStopDate IS NULL THEN OptBenStatusDate ELSE BdmBenStartDate END
        ,drvBenefitCoverageExpDate = BdmBenStopDate
        ,drvBenefitPlanYear =    CASE WHEN BdmDedCode IN ('MED1','MED2','MED3','MED4','MED5','DEN1','DEN2','DEN3','VIS') THEN
                                    CASE WHEN @ExportCode NOT IN ('OEPASSIVE','OEACTIVE') THEN DATEPART(YEAR,GETDATE()) ELSE DATEPART(YEAR,GETDATE()) + 1 END
                                END
    INTO dbo.U_EACCLDMOEX_drvTbl
    FROM dbo.U_EACCLDMOEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_EACCLDMOEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND efoPhoneType = 'CEL'
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStatusDate DESC) AS RN 
                        FROM EmpHDed
                        WHERE EdhDedCode IN ('DEN1','DEN2','DEN3','MED1','MED2','MED3','VIS')) AS X
                WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    LEFT JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = BdmDedCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
/*    LEFT JOIN dbo.U_EACCLDMOEX_Audit WITH (NOLOCK) 
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audKey3 = BdmDedCode*/
    LEFT JOIN (
                SELECT EdhEEID AS OptEEID, EdhDedCode AS OptDedCode, EdhBenStatusDate AS OptBenStatusDate
                FROM (
                        SELECT EdhEEID, EdhDedCode, EdhBenStatusDate, EdhEffDate, EdhBenOption, EdhDateTimeCreated, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhDedCode ORDER BY EdhBenStatusDate DESC, EdhEffDate DESC) AS RN
                        FROM dbo.EmpHDed WITH (NOLOCK)
                        WHERE EdhDedCode IN ('DEN1','DEN2','DEN3','MED1','MED2','MED3','VIS','MED4','MED5')
                    ) AS OptDateI
                WHERE RN = 1 ) AS OptDate
        ON OptEEID = xEEID
        AND OptDedCode = BdmDedCode
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
    ;


    ---------------------------------
    -- HEADER RECORD
    ---------------------------------

    DECLARE @CurrentDate VARCHAR(17);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'yyyyMMdd hh:mm:ss');

    IF OBJECT_ID('U_EACCLDMOEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_Header;
    SELECT DISTINCT
         drvCurrentDateAndTime = @CurrentDate
    INTO dbo.U_EACCLDMOEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EACCLDMOEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_Trailer;
    SELECT DISTINCT
         drvCurrentDateAndTime = @CurrentDate
        ,drvTotalNumberOfRecords = (SELECT COUNT(*) FROM dbo.U_EACCLDMOEX_drvTbl)
    INTO dbo.U_EACCLDMOEX_Trailer
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
ALTER VIEW dbo.dsi_vwEACCLDMOEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EACCLDMOEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EACCLDMOEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202103159'
       ,expEndPerControl       = '202103159'
WHERE expFormatCode = 'EACCLDMOEX';

UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012011'
       ,expStartPerControl     = '202012011'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'EACCLDMOEX';

UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112021'
       ,expStartPerControl     = '202112021'
       ,expLastEndPerControl   = '202112319'
       ,expEndPerControl       = '202112319'
WHERE expFormatCode = 'EACCLDMOEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEACCLDMOEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EACCLDMOEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EACCLDMOEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EACCLDMOEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EACCLDMOEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EACCLDMOEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EACCLDMOEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EACCLDMOEX', 'UseFileName', 'V', 'Y'


-- End ripout