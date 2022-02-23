/**********************************************************************************

ECIGNAFMLA: Cigna FMLA Disability Export

FormatCode:     ECIGNAFMLA
Project:        Cigna FMLA Disability Export
Client ID:      CIR1003
Date/time:      2021-12-09 21:07:05.317
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP4DB03
Database:       ULTIPRO_WPCIRR
Web Filename:   CIR1003_B61C4_EEHISTORY_ECIGNAFMLA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECIGNAFMLA_SavePath') IS NOT NULL DROP TABLE dbo.U_ECIGNAFMLA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECIGNAFMLA'


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
WHERE FormatCode = 'ECIGNAFMLA'
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
WHERE ExpFormatCode = 'ECIGNAFMLA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECIGNAFMLA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECIGNAFMLA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECIGNAFMLA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECIGNAFMLA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECIGNAFMLA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECIGNAFMLA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECIGNAFMLA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECIGNAFMLA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECIGNAFMLA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECIGNAFMLA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_fnlib_GetSupervisorField_ECIGNAFMLA') IS NOT NULL DROP FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_ECIGNAFMLA];
GO
IF OBJECT_ID('dsi_vwECIGNAFMLA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGNAFMLA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGNAFMLA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNAFMLA];
GO
IF OBJECT_ID('U_ECIGNAFMLA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_Trailer];
GO
IF OBJECT_ID('U_ECIGNAFMLA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_PEarHist];
GO
IF OBJECT_ID('U_ECIGNAFMLA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_PDedHist];
GO
IF OBJECT_ID('U_ECIGNAFMLA_Header') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_Header];
GO
IF OBJECT_ID('U_ECIGNAFMLA_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_File];
GO
IF OBJECT_ID('U_ECIGNAFMLA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_EEList];
GO
IF OBJECT_ID('U_ECIGNAFMLA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_drvTbl];
GO
IF OBJECT_ID('U_ECIGNAFMLA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNAFMLA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGNAFMLA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGNAFMLA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECIGNAFMLA','Cigna FMLA Disability Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECIGNAFMLAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIGNAFMLAZ0','2','H','01','1',NULL,'File Record Identifier',NULL,NULL,'"HD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIGNAFMLAZ0','15','H','01','3',NULL,'DUNS Number',NULL,NULL,'"605901982"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIGNAFMLAZ0','1','H','01','18',NULL,'Production/Test Indicator',NULL,NULL,'"drvProdTestIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIGNAFMLAZ0','8','H','01','19',NULL,'File Creation Date',NULL,NULL,'"drvFileCreationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIGNAFMLAZ0','35','H','01','27',NULL,'Employer Name',NULL,NULL,'"Cirrus Design Corporation"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIGNAFMLAZ0','1','H','01','62',NULL,'File Type',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIGNAFMLAZ0','2','H','01','63',NULL,'Life & Accident File Maintenance Reason Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIGNAFMLAZ0','1','H','01','65',NULL,'Disability File Maintenance Reason Type',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIGNAFMLAZ0','2935','H','01','66',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIGNAFMLAZ0','9','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIGNAFMLAZ0','11','D','10','10',NULL,'Employee Identification Number',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIGNAFMLAZ0','10','D','10','21',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIGNAFMLAZ0','4','D','10','31',NULL,'Eligibility Billing Location',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIGNAFMLAZ0','9','D','10','35',NULL,'CIGNA Internal Company Number',NULL,NULL,'"000031932"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIGNAFMLAZ0','9','D','10','44',NULL,'Employee Group Number ID',NULL,NULL,'"000022848"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIGNAFMLAZ0','3','D','10','53',NULL,'Employee Class Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIGNAFMLAZ0','8','D','10','56',NULL,'Class Change Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIGNAFMLAZ0','10','D','10','64',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIGNAFMLAZ0','35','D','10','74',NULL,'Employee Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIGNAFMLAZ0','25','D','10','109',NULL,'Employee First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIGNAFMLAZ0','15','D','10','134',NULL,'Employee Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIGNAFMLAZ0','10','D','10','149',NULL,'Employee Name Prefix',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIGNAFMLAZ0','10','D','10','159',NULL,'Employee Name Suffix',NULL,NULL,'"drvNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIGNAFMLAZ0','8','D','10','169',NULL,'Employee Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIGNAFMLAZ0','1','D','10','177',NULL,'Employee Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIGNAFMLAZ0','1','D','10','178',NULL,'Employee Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIGNAFMLAZ0','4','D','10','179',NULL,'Employee’s PIN Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIGNAFMLAZ0','1','D','10','183',NULL,'Employee Smoker Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIGNAFMLAZ0','34','D','10','184',NULL,'Employee E-mail Address',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIGNAFMLAZ0','1','D','10','218',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECIGNAFMLAZ0','34','D','10','219',NULL,'Supplemental E-mail Address 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECIGNAFMLAZ0','1','D','10','253',NULL,'E-mail 1 Type',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECIGNAFMLAZ0','34','D','10','254',NULL,'Supplemental E-mail Address 2',NULL,NULL,'"drvSuppEmailAdd2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECIGNAFMLAZ0','1','D','10','288',NULL,'E-mail 2 Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECIGNAFMLAZ0','35','D','10','289',NULL,'Employee Mail Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECIGNAFMLAZ0','35','D','10','324',NULL,'Employee Mail Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECIGNAFMLAZ0','30','D','10','359',NULL,'Employee Mail City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECIGNAFMLAZ0','2','D','10','389',NULL,'Employee Mail State',NULL,NULL,'"drvAddressSate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECIGNAFMLAZ0','10','D','10','391',NULL,'Employee Mail Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECIGNAFMLAZ0','30','D','10','401',NULL,'Employee Country',NULL,NULL,'"USA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECIGNAFMLAZ0','2','D','10','431',NULL,'Country Code',NULL,NULL,'"US"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECIGNAFMLAZ0','2','D','10','433',NULL,'Employee Residence State',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECIGNAFMLAZ0','3','D','10','435',NULL,'Province',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECIGNAFMLAZ0','1','D','10','438',NULL,'Type of Address',NULL,NULL,'"R"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECIGNAFMLAZ0','8','D','10','439',NULL,'Effective Date of the Address',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECIGNAFMLAZ0','20','D','10','447',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECIGNAFMLAZ0','1','D','10','467',NULL,'Phone Usage code',NULL,NULL,'"drvPhoneUsageCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECIGNAFMLAZ0','45','D','10','468',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECIGNAFMLAZ0','2','D','10','513',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECIGNAFMLAZ0','2','D','10','515',NULL,'Employment Status Code',NULL,NULL,'"drvEmploymentStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECIGNAFMLAZ0','8','D','10','517',NULL,'Employee Status Effective Date',NULL,NULL,'"drvEmployeeStatusEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECIGNAFMLAZ0','1','D','10','525',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECIGNAFMLAZ0','8','D','10','526',NULL,'Employee Date of Hire',NULL,NULL,'"drvEmployeeDateOfHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECIGNAFMLAZ0','8','D','10','534',NULL,'Adjusted Service Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECIGNAFMLAZ0','20','D','10','542',NULL,'Employee Work-site Location',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECIGNAFMLAZ0','9','D','10','562',NULL,'Employee Annual Salary for Life Benefit',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECIGNAFMLAZ0','1','D','10','571',NULL,'Mode For Disability Earnings',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECIGNAFMLAZ0','9','D','10','572',NULL,'Employee Earnings for Disability Products',NULL,NULL,'"drvEarningForDisabilitiy"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECIGNAFMLAZ0','8','D','10','581',NULL,'Last Earnings Change Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECIGNAFMLAZ0','1','D','10','589',NULL,'Salaried Indicator',NULL,NULL,'"drvSalariedIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECIGNAFMLAZ0','1','D','10','590',NULL,'Full Time Indicator',NULL,NULL,'"drvFullTimeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECIGNAFMLAZ0','1','D','10','591',NULL,'Commission Bonus Indicator',NULL,NULL,'"N"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECIGNAFMLAZ0','1','D','10','592',NULL,'Work At Home Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECIGNAFMLAZ0','1','D','10','593',NULL,'Exempt Indicator',NULL,NULL,'"drvExemptIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECIGNAFMLAZ0','5','D','10','594',NULL,'Number of Hours Worked Per Week',NULL,NULL,'"drvHoursWorkedPerWeek"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECIGNAFMLAZ0','2','D','10','599',NULL,'Tax Filing State Code',NULL,NULL,'"drvTaxFilingStateCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECIGNAFMLAZ0','9','D','10','601',NULL,'Occupation Classification Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECIGNAFMLAZ0','65','D','10','610',NULL,'Job Description',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECIGNAFMLAZ0','12','D','10','675',NULL,'Company Job Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECIGNAFMLAZ0','30','D','10','687',NULL,'Organization Name',NULL,NULL,'"drvOrganizationName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECIGNAFMLAZ0','15','D','10','717',NULL,'Client Organization Code',NULL,NULL,'"drvClientOrganizationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECIGNAFMLAZ0','12','D','10','732',NULL,'Client Location Code',NULL,NULL,'"drvClientLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECIGNAFMLAZ0','10','D','10','744',NULL,'Union Local Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECIGNAFMLAZ0','30','D','10','754',NULL,'Union Local Name',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECIGNAFMLAZ0','1','D','10','784',NULL,'Union Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECIGNAFMLAZ0','1','D','10','785',NULL,'Health Plan Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECIGNAFMLAZ0','30','D','10','786',NULL,'Health Plan Description',NULL,NULL,'"drvHealthPlanDesc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECIGNAFMLAZ0','6','D','10','816',NULL,'Accrued Sick Time',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECIGNAFMLAZ0','1','D','10','822',NULL,'Key Employee Indicator',NULL,NULL,'"drvKeyEmployeeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ECIGNAFMLAZ0','4','D','10','823',NULL,'Actual Annual Hours',NULL,NULL,'"drvActualAnnualHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ECIGNAFMLAZ0','2','D','10','827',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ECIGNAFMLAZ0','50','D','10','829',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ECIGNAFMLAZ0','2','D','10','879',NULL,'Maintenance Reason Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ECIGNAFMLAZ0','8','D','10','881',NULL,'Maintenance Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ECIGNAFMLAZ0','9','D','10','889',NULL,'Spouse SSN',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ECIGNAFMLAZ0','35','D','10','898',NULL,'Spouse Last Name',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ECIGNAFMLAZ0','25','D','10','933',NULL,'Spouse First Name',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ECIGNAFMLAZ0','15','D','10','958',NULL,'Spouse Middle Name',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ECIGNAFMLAZ0','10','D','10','973',NULL,'Spouse Name Prefix',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ECIGNAFMLAZ0','10','D','10','983',NULL,'Spouse Name Suffix',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ECIGNAFMLAZ0','8','D','10','993',NULL,'Spouse Date of Birth',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ECIGNAFMLAZ0','1','D','10','1001',NULL,'Spouse Gender',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ECIGNAFMLAZ0','1','D','10','1002',NULL,'Spouse Smoker Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ECIGNAFMLAZ0','20','D','10','1003',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ECIGNAFMLAZ0','2','D','10','1023',NULL,'Number of products',NULL,NULL,'"03"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ECIGNAFMLAZ0','4','D','10','1025',NULL,'Coverage code',NULL,NULL,'"FMLA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ECIGNAFMLAZ0','9','D','10','1029',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ECIGNAFMLAZ0','3','D','10','1038',NULL,'Policy Symbol',NULL,NULL,'"FML"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ECIGNAFMLAZ0','7','D','10','1041',NULL,'Policy Number',NULL,NULL,'"0752446"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ECIGNAFMLAZ0','8','D','10','1048',NULL,'Provision Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ECIGNAFMLAZ0','5','D','10','1056',NULL,'Elected Benefits Percent',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ECIGNAFMLAZ0','9','D','10','1061',NULL,'Elected Benefits Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ECIGNAFMLAZ0','5','D','10','1070',NULL,'Employee Contribution Percent',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ECIGNAFMLAZ0','8','D','10','1075',NULL,'Election Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ECIGNAFMLAZ0','1','D','10','1083',NULL,'Post Tax Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ECIGNAFMLAZ0','1','D','10','1084',NULL,'50/75 Rule',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ECIGNAFMLAZ0','59','D','10','1085',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ECIGNAFMLAZ0','4','D','10','1144',NULL,'Coverage code',NULL,NULL,'"drvCoverageCodeLoop2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ECIGNAFMLAZ0','9','D','10','1148',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ECIGNAFMLAZ0','3','D','10','1157',NULL,'Policy Symbol',NULL,NULL,'"drvPolicySymbol2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ECIGNAFMLAZ0','7','D','10','1160',NULL,'Policy Number',NULL,NULL,'"drvPolicyNumber2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ECIGNAFMLAZ0','8','D','10','1167',NULL,'Provision Effective Date',NULL,NULL,'"drvProvisionEffDateLoop2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ECIGNAFMLAZ0','5','D','10','1175',NULL,'Elected Benefits Percent',NULL,NULL,'"drvElectedBenefitPct2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ECIGNAFMLAZ0','9','D','10','1180',NULL,'Elected Benefits Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ECIGNAFMLAZ0','5','D','10','1189',NULL,'Employee Contribution Percent',NULL,NULL,'"drvEmpContribPct2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ECIGNAFMLAZ0','8','D','10','1194',NULL,'Election Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ECIGNAFMLAZ0','1','D','10','1202',NULL,'Post Tax Indicator',NULL,NULL,'"drvPostTaxIndicator2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ECIGNAFMLAZ0','30','D','10','1203',NULL,'Benefit Description',NULL,NULL,'"drvBenefitDescription2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ECIGNAFMLAZ0','30','D','10','1233',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ECIGNAFMLAZ0','4','D','10','1263',NULL,'Coverage code',NULL,NULL,'"drvCoverageCodeLoop3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ECIGNAFMLAZ0','9','D','10','1267',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ECIGNAFMLAZ0','3','D','10','1276',NULL,'Policy Symbol',NULL,NULL,'"drvPolicySymbol3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ECIGNAFMLAZ0','7','D','10','1279',NULL,'Policy Number',NULL,NULL,'"drvPoicyNumber3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ECIGNAFMLAZ0','8','D','10','1286',NULL,'Provision Effective Date',NULL,NULL,'"drvProvisionEffDateLoop3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ECIGNAFMLAZ0','5','D','10','1294',NULL,'Elected Benefits Percent',NULL,NULL,'"drvElectedBenefitPct3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ECIGNAFMLAZ0','9','D','10','1299',NULL,'Elected Benefits Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ECIGNAFMLAZ0','5','D','10','1308',NULL,'Employee Contribution Percent',NULL,NULL,'"drvEmployeeContribAmt3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ECIGNAFMLAZ0','8','D','10','1313',NULL,'Election Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ECIGNAFMLAZ0','1','D','10','1321',NULL,'Post Tax Indicator',NULL,NULL,'"drvPostTaxIndicatorLoop3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ECIGNAFMLAZ0','30','D','10','1322',NULL,'Benefit Description',NULL,NULL,'"drvBenefitDescriptionLoop3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ECIGNAFMLAZ0','30','D','10','1352',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ECIGNAFMLAZ0','4','D','10','1382',NULL,'Coverage code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ECIGNAFMLAZ0','9','D','10','1386',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ECIGNAFMLAZ0','3','D','10','1395',NULL,'Policy Symbol',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ECIGNAFMLAZ0','7','D','10','1398',NULL,'Policy Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ECIGNAFMLAZ0','8','D','10','1405',NULL,'Provision Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ECIGNAFMLAZ0','5','D','10','1413',NULL,'Elected Benefits Percent',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ECIGNAFMLAZ0','9','D','10','1418',NULL,'Elected Benefits Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ECIGNAFMLAZ0','5','D','10','1427',NULL,'Employee Contribution Percent',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ECIGNAFMLAZ0','8','D','10','1432',NULL,'Election Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ECIGNAFMLAZ0','1','D','10','1440',NULL,'Post Tax Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ECIGNAFMLAZ0','30','D','10','1441',NULL,'Benefit Description',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ECIGNAFMLAZ0','30','D','10','1471',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','ECIGNAFMLAZ0','2','D','10','1501',NULL,'Number of Products',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','ECIGNAFMLAZ0','3','D','10','1503',NULL,'Product Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','ECIGNAFMLAZ0','3','D','10','1506',NULL,'Policy Symbol',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','ECIGNAFMLAZ0','6','D','10','1509',NULL,'Policy Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','ECIGNAFMLAZ0','1','D','10','1515',NULL,'Assignment Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','ECIGNAFMLAZ0','9','D','10','1516',NULL,'Employee Previous Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','ECIGNAFMLAZ0','4','D','10','1525',NULL,'Employee Previous Salary Multiple',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','ECIGNAFMLAZ0','9','D','10','1529',NULL,'Spouse Previous Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','ECIGNAFMLAZ0','9','D','10','1538',NULL,'Child Previous Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','ECIGNAFMLAZ0','9','D','10','1547',NULL,'Employee Issued Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','ECIGNAFMLAZ0','4','D','10','1556',NULL,'Employee Issued Salary Multiple',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','ECIGNAFMLAZ0','9','D','10','1560',NULL,'Spouse Issued Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','ECIGNAFMLAZ0','9','D','10','1569',NULL,'Child Issued Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','ECIGNAFMLAZ0','9','D','10','1578',NULL,'Employee Applied Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','ECIGNAFMLAZ0','4','D','10','1587',NULL,'Employee Applied Salary Multiple',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','ECIGNAFMLAZ0','9','D','10','1591',NULL,'Spouse Applied Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','ECIGNAFMLAZ0','9','D','10','1600',NULL,'Child Applied Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','ECIGNAFMLAZ0','9','D','10','1609',NULL,'Employee Pending Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','ECIGNAFMLAZ0','4','D','10','1618',NULL,'Employee Pending Salary Multiple',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','ECIGNAFMLAZ0','9','D','10','1622',NULL,'Spouse Pending Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','ECIGNAFMLAZ0','9','D','10','1631',NULL,'Child Pending Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','ECIGNAFMLAZ0','9','D','10','1640',NULL,'Employee Monthly Cash Accumulation Fund Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','ECIGNAFMLAZ0','9','D','10','1649',NULL,'Spouse Monthly Cash Accumulation Fund Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','ECIGNAFMLAZ0','1','D','10','1658',NULL,'Employee AIO Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','ECIGNAFMLAZ0','1','D','10','1659',NULL,'Employee ADD/ADB Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','ECIGNAFMLAZ0','1','D','10','1660',NULL,'Spouse ADD/ADB Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','ECIGNAFMLAZ0','1','D','10','1661',NULL,'Employee APB Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','ECIGNAFMLAZ0','1','D','10','1662',NULL,'Spouse APB Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','ECIGNAFMLAZ0','1','D','10','1663',NULL,'PAI plan option',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','ECIGNAFMLAZ0','925','D','10','1664',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','ECIGNAFMLAZ0','7','D','10','2589',NULL,'H&W Deduction # 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','ECIGNAFMLAZ0','7','D','10','2596',NULL,'H&W Deduction # 2',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','ECIGNAFMLAZ0','7','D','10','2603',NULL,'H&W Deduction # 3',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','ECIGNAFMLAZ0','7','D','10','2610',NULL,'H&W Deduction # 4',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','ECIGNAFMLAZ0','7','D','10','2617',NULL,'H&W Deduction # 5',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','ECIGNAFMLAZ0','7','D','10','2624',NULL,'H&W Deduction # 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','ECIGNAFMLAZ0','7','D','10','2631',NULL,'H&W Deduction # 7',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','ECIGNAFMLAZ0','7','D','10','2638',NULL,'H&W Deduction # 8',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','ECIGNAFMLAZ0','7','D','10','2645',NULL,'H&W Deduction # 9',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','ECIGNAFMLAZ0','7','D','10','2652',NULL,'H&W Deduction # 10',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','ECIGNAFMLAZ0','7','D','10','2659',NULL,'H&W Deduction # 11',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','ECIGNAFMLAZ0','7','D','10','2666',NULL,'H&W Deduction # 12',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','ECIGNAFMLAZ0','178','D','10','2673',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','ECIGNAFMLAZ0','50','D','10','2851',NULL,'Extended Employee E-mail Address',NULL,NULL,'"drvExtendedEmpEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','ECIGNAFMLAZ0','50','D','10','2901',NULL,'Extended Supplemental E-mail Address 2',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','ECIGNAFMLAZ0','50','D','10','2951',NULL,'Extended Supplemental E-mail Address 1',NULL,NULL,'"drvExtendedSuppEmpEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIGNAFMLAZ0','2','T','90','1',NULL,'File Record Identifier',NULL,NULL,'"TR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIGNAFMLAZ0','15','T','90','3',NULL,'DUNS Number',NULL,NULL,'"605901982"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIGNAFMLAZ0','1','T','90','18',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIGNAFMLAZ0','9','T','90','19',NULL,'Number of Records',NULL,NULL,'"drvNumberOfRecords"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIGNAFMLAZ0','2973','T','90','28',NULL,'Reserved',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECIGNAFMLA_20211209.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202103199','EMPEXPORT','OEACTIVE','Oct 29 2020  6:09PM','ECIGNAFMLA',NULL,NULL,NULL,'202103199','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202103011','2','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202103199','EMPEXPORT','OEPASSIVE','Oct 29 2020  6:09PM','ECIGNAFMLA',NULL,NULL,NULL,'202103199','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202103011','1290','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Cigna FMLA Disability Export','202103199','EMPEXPORT','ONDEM_XOE','Oct 29 2020  6:09PM','ECIGNAFMLA',NULL,NULL,NULL,'202103199','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202103011','1290','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',KD708,KD723,KD74A',NULL,NULL,NULL,'Cigna FMLA Dis - Wed 2:10pm','202103199','EMPEXPORT','SCH_ECIGFM','Oct 29 2020  6:09PM','ECIGNAFMLA',NULL,NULL,NULL,'202112089','Oct 29 2020 12:30PM','Oct 29 2020 12:30PM','202112011','1290','','','202103011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','KD708,KD723,KD74A',NULL,NULL,NULL,'Cigna FMLA Disability Ex-Test','202107079','EMPEXPORT','TEST_XOE','Jul 13 2021  4:08PM','ECIGNAFMLA',NULL,NULL,NULL,'202107079','Jul  7 2021 12:00AM','Dec 30 1899 12:00AM','202106301','1718','','','202106301',dbo.fn_GetTimedKey(),NULL,'us3lKiCIR1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAFMLA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAFMLA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAFMLA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAFMLA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNAFMLA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNAFMLA','H01','dbo.U_ECIGNAFMLA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNAFMLA','D10','dbo.U_ECIGNAFMLA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNAFMLA','T90','dbo.U_ECIGNAFMLA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECIGNAFMLA
-----------

IF OBJECT_ID('U_dsi_BDM_ECIGNAFMLA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGNAFMLA] (
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
-- Create table U_ECIGNAFMLA_DedList
-----------

IF OBJECT_ID('U_ECIGNAFMLA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECIGNAFMLA_drvTbl
-----------

IF OBJECT_ID('U_ECIGNAFMLA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvSuppEmailAdd2] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressSate] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneNumber] varchar(1) NOT NULL,
    [drvPhoneUsageCode] varchar(1) NOT NULL,
    [drvEmploymentStatusCode] varchar(2) NOT NULL,
    [drvEmployeeStatusEffDate] datetime NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvEmployeeDateOfHire] datetime NULL,
    [drvEarningForDisabilitiy] varchar(9) NOT NULL,
    [drvSalariedIndicator] varchar(1) NOT NULL,
    [drvFullTimeIndicator] varchar(1) NOT NULL,
    [drvExemptIndicator] varchar(1) NOT NULL,
    [drvHoursWorkedPerWeek] nvarchar(4000) NULL,
    [drvTaxFilingStateCode] varchar(255) NULL,
    [drvOrganizationName] varchar(40) NULL,
    [drvClientOrganizationCode] char(5) NOT NULL,
    [drvClientLocationCode] char(6) NULL,
    [drvHealthPlanDesc] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvActualAnnualHours] nvarchar(4000) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvCoverageCodeLoop2] varchar(3) NULL,
    [drvPolicySymbol2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(7) NULL,
    [drvProvisionEffDateLoop2] datetime NULL,
    [drvElectedBenefitPct2] varchar(5) NULL,
    [drvEmpContribPct2] varchar(5) NULL,
    [drvPostTaxIndicator2] varchar(1) NULL,
    [drvBenefitDescription2] varchar(7) NULL,
    [drvCoverageCodeLoop3] varchar(3) NULL,
    [drvPolicySymbol3] varchar(2) NULL,
    [drvPoicyNumber3] varchar(7) NULL,
    [drvProvisionEffDateLoop3] datetime NULL,
    [drvElectedBenefitPct3] varchar(5) NULL,
    [drvEmployeeContribAmt3] varchar(5) NULL,
    [drvPostTaxIndicatorLoop3] varchar(1) NULL,
    [drvBenefitDescriptionLoop3] varchar(7) NULL,
    [drvExtendedEmpEmail] varchar(50) NULL,
    [drvExtendedSuppEmpEmail] varchar(256) NULL
);

-----------
-- Create table U_ECIGNAFMLA_EEList
-----------

IF OBJECT_ID('U_ECIGNAFMLA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECIGNAFMLA_File
-----------

IF OBJECT_ID('U_ECIGNAFMLA_File') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);

-----------
-- Create table U_ECIGNAFMLA_Header
-----------

IF OBJECT_ID('U_ECIGNAFMLA_Header') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_Header] (
    [drvProdTestIndicator] varchar(1) NOT NULL,
    [drvFileCreationDate] datetime NOT NULL
);

-----------
-- Create table U_ECIGNAFMLA_PDedHist
-----------

IF OBJECT_ID('U_ECIGNAFMLA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_PDedHist] (
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
-- Create table U_ECIGNAFMLA_PEarHist
-----------

IF OBJECT_ID('U_ECIGNAFMLA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_PEarHist] (
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

-----------
-- Create table U_ECIGNAFMLA_Trailer
-----------

IF OBJECT_ID('U_ECIGNAFMLA_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECIGNAFMLA_Trailer] (
    [drvNumberOfRecords] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNAFMLA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cirrus Design

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 3/26/2021
Service Request Number: TekP-2021-02-23-0003

Purpose: Cigna FMLA Disability Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGNAFMLA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGNAFMLA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGNAFMLA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGNAFMLA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGNAFMLA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAFMLA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAFMLA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAFMLA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAFMLA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNAFMLA', 'SCH_ECIGFM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGNAFMLA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECIGNAFMLA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGNAFMLA';

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
    DELETE FROM dbo.U_ECIGNAFMLA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGNAFMLA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECIGNAFMLA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES') or eeclocation = 'AUQU' or eecpaygroup = 'NPG'
    )

    DELETE FROM dbo.U_ECIGNAFMLA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEmpNo IN ('111111','888888','777777','333333','222222','444444','666666','555555','123456')
    )

    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTDT,LTD,STD,STDT';

    IF OBJECT_ID('U_ECIGNAFMLA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAFMLA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGNAFMLA_DedList
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
    IF OBJECT_ID('U_ECIGNAFMLA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAFMLA_PDedHist;
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
    INTO dbo.U_ECIGNAFMLA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIGNAFMLA_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECIGNAFMLA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAFMLA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode IN ('REG','OT') THEN PehCurHrs END)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECIGNAFMLA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND 
    PehPerControl <= @EndPerControl
    AND PehPerControl > FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd') + '1'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIGNAFMLA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGNAFMLA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAFMLA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvNameLast = REPLACE(REPLACE(EepNameLast, '(', ''), ')', '')
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = CASE WHEN ISNULL(EepGender, '') <> '' THEN EepGender ELSE 'F' END
        ,drvMaritalStatus =    CASE WHEN EepMaritalStatus IN ('D','M','W') THEN EepMaritalStatus
                                WHEN EepMaritalStatus = 'S' THEN 'I'
                                ELSE 'K'
                            END
        ,drvSuppEmailAdd2 = ''--dbo.dsi_fnlib_GetSupervisorField_ECIGNAFMLA(EecCoid, EecEEID,' AddressEMail')      --eepaddressemail from EecSupervisorID
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressSate = EepAddressState
        ,drvAddressZipCode =    CASE WHEN LEN(RTRIM(EepAddressZipCode)) = 5 THEN EepAddressZipCode
                                    ELSE LEFT(EepAddressZipCode, 5) + '-' + RIGHT(RTRIM(EepAddressZipCode), 4)
                                END
        ,drvPhoneNumber = '' -- leave blank --CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber ELSE EfoPhoneNumber END
        ,drvPhoneUsageCode = ''-- leave blank --CASE WHEN (EepPhoneHomeNumber IS NOT NULL AND LEN(EepPhoneHomeNumber) > 0 ) OR EfoPhoneNumber IS NOT NULL THEN 'R' END
        ,drvEmploymentStatusCode =    CASE WHEN EecEmplStatus = 'L' THEN 'L1'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RT'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DI'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') THEN 'TE'
                                        ELSE 'AC'
                                    END
        ,drvEmployeeStatusEffDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                    END
        ,drvEmployeeType = 'P' --CASE WHEN EecEEType = 'REG' THEN 'P' ELSE 'T' END
        ,drvEmployeeDateOfHire = EecDateOfLastHire
        ,drvEarningForDisabilitiy = '000000000'--FORMAT(EecAnnSalary*100, '000000000')
        ,drvSalariedIndicator = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvFullTimeIndicator = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Y' ELSE 'N' END
        ,drvExemptIndicator = CASE WHEN EjhFLSACategory = 'E' THEN 'Y' ELSE 'N' END

        ,drvHoursWorkedPerWeek =  FORMAT((EecScheduledWorkHrs*100)/2, '00000') 
        ,drvTaxFilingStateCode = EepAddressState
        ,drvOrganizationName =  UPPER(CmpCompanyName) --REPLACE(UPPER(OrgDesc1), '/', ' ')
        ,drvClientOrganizationCode = EecCOID --EecOrgLvl1
        ,drvClientLocationCode = EecLocation
        ,drvHealthPlanDesc = CASE WHEN EecDedGroupCode IN ('FPE','INTGB','INTUS') THEN 'Y' ELSE 'N' END
        ,drvKeyEmployeeIndicator = ''--space fill --CASE WHEN JbcJobFamily = '7' THEN 'Y' ELSE 'N' END
        ,drvActualAnnualHours = FORMAT(CAST(PehCurHrsYTD AS INT), '0000') 
        
                        --ISNULL(CASE WHEN EecEmpNo IN ('000001','111802','111687','010196','009970','111783','111516') THEN '04000' 
                                --    ELSE FORMAT(CAST(CASE WHEN PehCurHrsYTD % 1 >= .45 THEN PehCurHrsYTD+ 1 ELSE PehCurHrsYTD END AS INT), '0000')
                                --    --FORMAT(PehCurHrsYTD*100, '00000') 
                                --END, '0000')
        ,drvWorkState = LocAddressState
        ,drvCoverageCodeLoop2 = CASE WHEN STD_DedCode IS NOT NULL THEN 'STD' END

        ,drvPolicySymbol2 = CASE WHEN STD_DedCode IS NOT NULL THEN 'LK' END
        ,drvPolicyNumber2 = CASE WHEN STD_DedCode IS NOT NULL THEN '0752446' END

        ,drvProvisionEffDateLoop2 = CASE WHEN STD_DedCode IS NOT NULL THEN Min_STDS END

        ,drvElectedBenefitPct2 = CASE WHEN STD_DedCode IS NOT NULL THEN '06000' END
        ,drvEmpContribPct2 = CASE WHEN STD_DedCode IS NOT NULL THEN '00000' END
        ,drvPostTaxIndicator2 = CASE WHEN STD_DedCode IS NOT NULL THEN 'N' END
        ,drvBenefitDescription2 = CASE WHEN (STD_DedCode IS NOT NULL) and eepI9WorkAuth IN ('A', 'N', 'S') THEN 'Class 2' 
                                         WHEN (STD_DedCode IS NOT NULL) THEN 'Class 1'
                                        END  
                                        
        --CASE WHEN (STD_DedCode IS NOT NULL or LTD1_DedCode is NOT NULL or LTD2_DedCode is NOT NULL) and  ISNULL(eepI9WorkAuth ,'') = '' or eepI9WorkAuth IN ('A citizen of the United States', 'Citizen or Nation of the US Pre July 2009') THEN 'Class 1' ELSE 'Class 2' END

        ,drvCoverageCodeLoop3 = CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL THEN 'LTD' END

        ,drvPolicySymbol3 =  CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL THEN 'LK' END
        ,drvPoicyNumber3 =  CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL THEN '0965897' END


        ,drvProvisionEffDateLoop3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN Min_LTD1
                                        WHEN LTD2_DedCode IS NOT NULL THEN Min_LTD2
                                    END
        ,drvElectedBenefitPct3 = CASE WHEN LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL  THEN '06000' END
        ,drvEmployeeContribAmt3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN '10000'
                                        WHEN LTD2_DedCode IS NOT NULL THEN '00000'
                                    END
        ,drvPostTaxIndicatorLoop3 =    CASE WHEN LTD1_DedCode IS NOT NULL THEN 'Y'
                                        WHEN LTD2_DedCode IS NOT NULL THEN 'N'
                                    END
        ,drvBenefitDescriptionLoop3 =   CASE WHEN (LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL) and eepI9WorkAuth IN ('A', 'N', 'S') THEN 'Class 2' 
                                              WHEN (LTD1_DedCode IS NOT NULL OR LTD2_DedCode IS NOT NULL) THEN 'Class 1'
                                    --    ELSE 'Class 1'
                                        END   
                                        --CASE WHEN LTD1_DedCode IS NOT NULL THEN 'Class 1'
          --                                  WHEN LTD2_DedCode IS NOT NULL THEN 'Class 2'
          --                              END
        ,drvExtendedEmpEmail = eepAddressEMail 
        ,drvExtendedSuppEmpEmail = dbo.dsi_fnlib_GetSupervisorField_ECIGNAFMLA(EecCoid, EecEEID, 'AddressEMail') 
    INTO dbo.U_ECIGNAFMLA_drvTbl
    FROM dbo.U_ECIGNAFMLA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID --AND (EecEEType <> 'TES' or Eeclocation <> 'AUQU' or Eecpaygroup <> 'NPG')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.company WITH (NOLOCK) 
        ON cmpCOID = xCOID
--    JOIN dbo.U_dsi_BDM_ECIGNAFMLA WITH (NOLOCK)
--        ON BdmEEID = xEEID 
--        AND BdmCoID = xCoID
  left  JOIN (
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode IN ('STD','STDT') THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD1_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTDT' THEN BdmDedCode END) AS LTD2_DedCode
            FROM dbo.U_dsi_BDM_ECIGNAFMLA WITH (NOLOCK)
            GROUP By BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode1, OrgDesc AS OrgDesc1, OrgManagerId AS OrgManagerId1
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 1
            ) AS Org1
        ON OrgCode1 = EecOrgLvl1
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_ECIGNAFMLA_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
   left JOIN (
            SELECT EdhEEID, EdhCOID
                ,MIN(CASE WHEN EdhDedCode = 'LTD' THEN  EdhBenStartDate END ) AS Min_LTD1
                ,MIN(CASE WHEN EdhDedCode = 'LTDT' THEN  EdhBenStartDate END ) AS Min_LTD2
                ,MIN(CASE WHEN EdhDedCode IN ('STD','STDT') THEN  EdhBenStartDate END ) AS Min_STDS
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('LTDT','LTD','STD','STDT')
            GROUP BY EdhEEID, EdhCOID) AS Edh
    ON EdhEEID = xEEID
    AND EdhCOID = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate and @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECIGNAFMLA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAFMLA_Header;
    SELECT DISTINCT
         drvProdTestIndicator = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvFileCreationDate = GETDATE()
    INTO dbo.U_ECIGNAFMLA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECIGNAFMLA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNAFMLA_Trailer;
    SELECT DISTINCT
         drvNumberOfRecords = FORMAT((SELECT COUNT(*) FROM dbo.U_ECIGNAFMLA_drvTbl WITH (NOLOCK)), '000000000')
    INTO dbo.U_ECIGNAFMLA_Trailer
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
ALTER VIEW dbo.dsi_vwECIGNAFMLA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGNAFMLA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGNAFMLA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202103011'
       ,expStartPerControl     = '202103011'
       ,expLastEndPerControl   = '202103199'
       ,expEndPerControl       = '202103199'
WHERE expFormatCode = 'ECIGNAFMLA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGNAFMLA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGNAFMLA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_ECIGNAFMLA] (    
@COID            VARCHAR(5),    
@EEID            VARCHAR(12),    
@FieldName       VARCHAR(32)    
)    
    
RETURNS VARCHAR(256)    
WITH EXECUTE AS CALLER    
AS    
    
/************************************************************    
    
Created By: John Transier    
Create Date: 08/16/2017    
    
Revision History    
----------------    
Update By            Date            Desc    
XXXX                 XX/XX/16        Added 1234    
    
Purpose: Pulls basic supervisor fields for an employee, e.g. name, employee number.    
             
Description    
-----------    
Pulls basic supervisor fields, e.g. name, employee number. If COID is left blank it will pull the employee's current COID.    
    
    
Commands     
--------    
SELECT     
    
EecEEID,     
EecSupervisorID,    
dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First')     
    
FROM dbo.EmpComp    
    
************************************************************/    
    
BEGIN    
    
-----------    
-- Declare and set variables    
-----------    
    
DECLARE @Return         VARCHAR(256)    
DECLARE @SupervisorCOID VARCHAR(5)    
DECLARE @SupervisorEEID VARCHAR(12)    
    
SET @COID      = LTRIM(RTRIM(COALESCE(@COID, '')))    
SET @EEID      = LTRIM(RTRIM(COALESCE(@EEID, '')))    
SET @FieldName = LTRIM(RTRIM(COALESCE(@FieldName, '')))    
    
IF @EEID      = '' RETURN ''    
IF @FieldName = '' RETURN ''    
    
IF @COID = '' SET @COID = dbo.dsi_fn_GetCurrentCOID(@EEID)     
    
    
-----------    
-- Set supervisor fields    
-----------    
    
SELECT     
    
@SupervisorEEID = LTRIM(RTRIM(COALESCE(EecSupervisorID, ''))),    
@SupervisorCOID = dbo.dsi_fn_GetCurrentCOID(EecSupervisorID)     
       
FROM dbo.EmpComp    
WHERE EecCOID = @COID    
  AND EecEEID = @EEID    
    
IF @SupervisorEEID = '' RETURN ''    
    
    
-----------    
-- Get supervisor data 

-----------    
    
SELECT @Return = CASE    
                    WHEN @FieldName = 'SSN'               THEN EepSSN    
                    WHEN @FieldName = 'NameFirst'         THEN EepNameFirst    
                    WHEN @FieldName = 'NameLast'          THEN EepNameLast    
                    WHEN @FieldName = 'NameMiddle'        THEN EepNameMiddle    
                    WHEN @FieldName = 'NameMiddleInit'    THEN LEFT(EepNameMiddle, 1)    
                    WHEN @FieldName = 'NameLast, First'   THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))    
                    WHEN @FieldName = 'NameLast, First M' THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + COALESCE(LEFT(EepNameMiddle, 1), '')  
                    WHEN @FieldName = 'NameFirst Last'    THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'NameFML'           THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(COALESCE(EepNameMiddle, ''))) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'AddressEMail'      THEN EepAddressEMail    
                    WHEN @FieldName = 'PhoneHomeNumber'   THEN EepPhoneHomeNumber    
                    WHEN @FieldName = 'EmpNo'             THEN EecEmpNo    
                    WHEN @FieldName = 'Status'            THEN EecEmplStatus    
                    WHEN @FieldName = 'JobDesc'           THEN JbcDesc    
                    WHEN @FieldName = 'PhoneBusinessNumber'    THEN EecPhoneBusinessNumber
                    WHEN @FieldName = 'SupervisorExt'     THEN EecPhoneBusinessExt 
                    WHEN @FieldName = 'COID'              THEN @SupervisorCOID    
     ELSE ''    
     END    
FROM EmpPers    
JOIN EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = @SupervisorCOID    
JOIN dbo.JobCode WITH (NOLOCK) ON JbcJobCode = EecJobCode    
WHERE EepEEID = @SupervisorEEID    
    
    
-----------    
-- Return    
-----------    
    
RETURN LTRIM(RTRIM(COALESCE(@Return, '')))    
    
END    

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECIGNAFMLA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECIGNAFMLA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECIGNAFMLA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIGNAFMLA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECIGNAFMLA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIGNAFMLA', 'UseFileName', 'V', 'Y'


-- End ripout