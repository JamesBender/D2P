/**********************************************************************************

EMETVLTDVE: MetLife L/VL L/STD Den Vis Export

FormatCode:     EMETVLTDVE
Project:        MetLife L/VL L/STD Den Vis Export
Client ID:      CLI1006
Date/time:      2022-01-11 11:18:19.557
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP4DB03
Database:       ULTIPRO_WPCLREM
Web Filename:   CLI1006_D141B_EEHISTORY_EMETVLTDVE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMETVLTDVE_SavePath') IS NOT NULL DROP TABLE dbo.U_EMETVLTDVE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMETVLTDVE'


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
WHERE FormatCode = 'EMETVLTDVE'
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
WHERE ExpFormatCode = 'EMETVLTDVE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMETVLTDVE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMETVLTDVE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMETVLTDVE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMETVLTDVE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMETVLTDVE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMETVLTDVE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMETVLTDVE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMETVLTDVE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMETVLTDVE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMETVLTDVE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMETVLTDVE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETVLTDVE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETVLTDVE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETVLTDVE];
GO
IF OBJECT_ID('U_EMETVLTDVE_File') IS NOT NULL DROP TABLE [dbo].[U_EMETVLTDVE_File];
GO
IF OBJECT_ID('U_EMETVLTDVE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETVLTDVE_EEList];
GO
IF OBJECT_ID('U_EMETVLTDVE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETVLTDVE_drvTbl];
GO
IF OBJECT_ID('U_EMETVLTDVE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETVLTDVE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMETVLTDVE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETVLTDVE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMETVLTDVE','MetLife L/VL L/STD Den Vis Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EMETVLTDVEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMETVLTDVEZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL,'"drvTransactionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMETVLTDVEZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMETVLTDVEZ0','11','D','10','9',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMETVLTDVEZ0','11','D','10','20',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMETVLTDVEZ0','9','D','10','31',NULL,'Member Social Security Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMETVLTDVEZ0','20','D','10','40',NULL,'Member Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMETVLTDVEZ0','12','D','10','60',NULL,'Member First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMETVLTDVEZ0','1','D','10','72',NULL,'Member Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMETVLTDVEZ0','8','D','10','73',NULL,'Member Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMETVLTDVEZ0','1','D','10','81',NULL,'Member Marital Status',NULL,NULL,'"drvMemberMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMETVLTDVEZ0','1','D','10','82',NULL,'Member Gender',NULL,NULL,'"drvMemberGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMETVLTDVEZ0','2','D','10','83',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMETVLTDVEZ0','8','D','10','85',NULL,'Employee''s Date of Hire',NULL,NULL,'"drvEmployeesDateOfHire"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMETVLTDVEZ0','11','D','10','93',NULL,'Personnel Identification',NULL,NULL,'"drvPersonalIdentification"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMETVLTDVEZ0','1','D','10','104',NULL,'Employee Smoker Code',NULL,NULL,'"U"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMETVLTDVEZ0','1','D','10','105',NULL,'Spouse Smoker Code',NULL,NULL,'"U"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMETVLTDVEZ0','10','D','10','106',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMETVLTDVEZ0','40','D','10','116',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMETVLTDVEZ0','14','D','10','156',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMETVLTDVEZ0','1','D','10','170',NULL,'Foreign Address Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMETVLTDVEZ0','32','D','10','171',NULL,'Care of Address',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMETVLTDVEZ0','32','D','10','203',NULL,'Street Address',NULL,NULL,'"drvStreetAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMETVLTDVEZ0','21','D','10','235',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMETVLTDVEZ0','2','D','10','256',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMETVLTDVEZ0','9','D','10','258',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMETVLTDVEZ0','2','D','10','267',NULL,'Coverage Code - 1',NULL,NULL,'"drvCoverageCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMETVLTDVEZ0','8','D','10','269',NULL,'Coverage Start Date - 1',NULL,NULL,'"drvCoverageStartDate1"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMETVLTDVEZ0','8','D','10','277',NULL,'Coverage Stop Date - 1',NULL,NULL,'"drvCoverageStopDate1"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMETVLTDVEZ0','7','D','10','285',NULL,'Group Number - 1',NULL,NULL,'"drvGroupNumber1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMETVLTDVEZ0','8','D','10','292',NULL,'Subcode - 1',NULL,NULL,'"drvSubCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMETVLTDVEZ0','2','D','10','300',NULL,'Plan Code - 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMETVLTDVEZ0','1','D','10','302',NULL,'Status Code - 1',NULL,NULL,'"drvStatusCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMETVLTDVEZ0','1','D','10','303',NULL,'Members Covered Code - 1',NULL,NULL,'"drvMembersCoveredCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMETVLTDVEZ0','2','D','10','304',NULL,'Cancel Reason - 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMETVLTDVEZ0','1','D','10','306',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMETVLTDVEZ0','8','D','10','307',NULL,'Facility ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMETVLTDVEZ0','15','D','10','315',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMETVLTDVEZ0','2','D','10','330',NULL,'Coverage Code - 2',NULL,NULL,'"drvCoverageCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMETVLTDVEZ0','8','D','10','332',NULL,'Coverage Start Date - 2',NULL,NULL,'"drvCoverageStartDate2"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMETVLTDVEZ0','8','D','10','340',NULL,'Coverage Stop Date - 2',NULL,NULL,'"drvCoverageStopDate2"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMETVLTDVEZ0','7','D','10','348',NULL,'Group Number - 2',NULL,NULL,'"drvGroupNumber2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMETVLTDVEZ0','8','D','10','355',NULL,'Subcode - 2',NULL,NULL,'"drvSubCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMETVLTDVEZ0','2','D','10','363',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMETVLTDVEZ0','1','D','10','365',NULL,'Status Code - 2',NULL,NULL,'"drvStatusCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMETVLTDVEZ0','1','D','10','366',NULL,'Members Covered Code - 2',NULL,NULL,'"drvMembersCoveredCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMETVLTDVEZ0','10','D','10','367',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMETVLTDVEZ0','8','D','10','377',NULL,'Annual Benefit Amount - 2',NULL,NULL,'"drvAnnualBenefitAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMETVLTDVEZ0','1','D','10','385',NULL,'Salary Mode - 2',NULL,NULL,'"drvSalaryMode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMETVLTDVEZ0','7','D','10','386',NULL,'Salary Amount - 2',NULL,NULL,'"drvSalaryAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMETVLTDVEZ0','2','D','10','393',NULL,'Coverage Code - 3',NULL,NULL,'"drvCoverageCode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMETVLTDVEZ0','8','D','10','395',NULL,'Coverage Start Date - 3',NULL,NULL,'"drvCoverageStartDate3"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMETVLTDVEZ0','8','D','10','403',NULL,'Coverage Stop Date - 3',NULL,NULL,'"drvCoverageStopDate3"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMETVLTDVEZ0','7','D','10','411',NULL,'Group Number - 3',NULL,NULL,'"drvGroupNumber3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMETVLTDVEZ0','8','D','10','418',NULL,'Subcode - 3',NULL,NULL,'"drvSubCode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMETVLTDVEZ0','2','D','10','426',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMETVLTDVEZ0','1','D','10','428',NULL,'Status Code - 3',NULL,NULL,'"drvStatusCode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMETVLTDVEZ0','1','D','10','429',NULL,'Members Covered Code - 3',NULL,NULL,'"drvMembersCoveredCode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMETVLTDVEZ0','10','D','10','430',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMETVLTDVEZ0','8','D','10','440',NULL,'Annual Benefit Amount - 3',NULL,NULL,'"drvAnnualBenefitAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMETVLTDVEZ0','1','D','10','448',NULL,'Salary Mode - 3',NULL,NULL,'"drvSalaryMode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMETVLTDVEZ0','7','D','10','449',NULL,'Salary Amount - 3',NULL,NULL,'"drvSalaryAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMETVLTDVEZ0','2','D','10','456',NULL,'Coverage Code - 4',NULL,NULL,'"drvCoverageCode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMETVLTDVEZ0','8','D','10','458',NULL,'Coverage Start Date - 4',NULL,NULL,'"drvCoverageStartDate4"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EMETVLTDVEZ0','8','D','10','466',NULL,'Coverage Stop Date - 4',NULL,NULL,'"drvCoverageStopDate4"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EMETVLTDVEZ0','7','D','10','474',NULL,'Group Number - 4',NULL,NULL,'"drvGroupNumber4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EMETVLTDVEZ0','8','D','10','481',NULL,'Subcode - 4',NULL,NULL,'"drvSubCode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EMETVLTDVEZ0','2','D','10','489',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EMETVLTDVEZ0','1','D','10','491',NULL,'Status Code - 4',NULL,NULL,'"drvStatusCode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EMETVLTDVEZ0','1','D','10','492',NULL,'Members Covered Code - 4',NULL,NULL,'"drvMembersCoveredCode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EMETVLTDVEZ0','10','D','10','493',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EMETVLTDVEZ0','8','D','10','503',NULL,'Monthly Benefit Amount - 4',NULL,NULL,'"drvMonthlyBenefitAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EMETVLTDVEZ0','1','D','10','511',NULL,'Salary Mode - 4',NULL,NULL,'"drvSalaryMode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EMETVLTDVEZ0','7','D','10','512',NULL,'Salary Amount - 4',NULL,NULL,'"drvSalaryAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EMETVLTDVEZ0','2','D','10','519',NULL,'Coverage Code - 5',NULL,NULL,'"drvCoverageCode5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EMETVLTDVEZ0','8','D','10','521',NULL,'Coverage Start Date - 5',NULL,NULL,'"drvCoverageStartDate5"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EMETVLTDVEZ0','8','D','10','529',NULL,'Coverage Stop Date - 5',NULL,NULL,'"drvCoverageStopDAte5"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EMETVLTDVEZ0','7','D','10','537',NULL,'Group Number - 5',NULL,NULL,'"drvGroupNumber5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EMETVLTDVEZ0','8','D','10','544',NULL,'Subcode - 5',NULL,NULL,'"drvSubCode5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EMETVLTDVEZ0','2','D','10','552',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EMETVLTDVEZ0','1','D','10','554',NULL,'Status Code - 5',NULL,NULL,'"drvStatusCode5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EMETVLTDVEZ0','1','D','10','555',NULL,'Members Covered Code - 5',NULL,NULL,'"drvMembersCoveredCode5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EMETVLTDVEZ0','10','D','10','556',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EMETVLTDVEZ0','8','D','10','566',NULL,'Weekly Benefit Amount - 5',NULL,NULL,'"drvWeeklyBenefitAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EMETVLTDVEZ0','1','D','10','574',NULL,'Salary Mode - 5',NULL,NULL,'"drvSalaryMode5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EMETVLTDVEZ0','7','D','10','575',NULL,'Salary Amount - 5',NULL,NULL,'"drvSalaryAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EMETVLTDVEZ0','2','D','10','582',NULL,'Coverage Code - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EMETVLTDVEZ0','8','D','10','584',NULL,'Coverage Start Date - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EMETVLTDVEZ0','8','D','10','592',NULL,'Coverage Stop Date - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EMETVLTDVEZ0','7','D','10','600',NULL,'Group Number - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EMETVLTDVEZ0','4','D','10','607',NULL,'Subcode - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EMETVLTDVEZ0','4','D','10','611',NULL,'Branch - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EMETVLTDVEZ0','2','D','10','615',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EMETVLTDVEZ0','1','D','10','617',NULL,'Status Code - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EMETVLTDVEZ0','1','D','10','618',NULL,'Members Covered Code - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EMETVLTDVEZ0','10','D','10','619',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EMETVLTDVEZ0','8','D','10','629',NULL,'Annual Benefit Amount - 6',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EMETVLTDVEZ0','8','D','10','637',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EMETVLTDVEZ0','2','D','10','645',NULL,'Coverage Code - 7',NULL,NULL,'"drvCoverageCode7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EMETVLTDVEZ0','8','D','10','647',NULL,'Coverage Start Date - 7',NULL,NULL,'"drvCoverageStartDate7"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EMETVLTDVEZ0','8','D','10','655',NULL,'Coverage Stop Date - 7',NULL,NULL,'"drvCoverageStopDate7"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EMETVLTDVEZ0','7','D','10','663',NULL,'Group Number - 7',NULL,NULL,'"drvGroupNumber7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EMETVLTDVEZ0','4','D','10','670',NULL,'Subcode - 7',NULL,NULL,'"drvSubCode7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EMETVLTDVEZ0','4','D','10','674',NULL,'Branch - 7',NULL,NULL,'"drvBranch7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EMETVLTDVEZ0','2','D','10','678',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EMETVLTDVEZ0','1','D','10','680',NULL,'Status Code - 7',NULL,NULL,'"drvStatusCode7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EMETVLTDVEZ0','1','D','10','681',NULL,'Members Covered Code - 7',NULL,NULL,'"drvMembersCoveredCode7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EMETVLTDVEZ0','10','D','10','682',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EMETVLTDVEZ0','8','D','10','692',NULL,'Annual Benefit Amount - 7',NULL,NULL,'"drvAnnualBenefitAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EMETVLTDVEZ0','1','D','10','700',NULL,'Salary Mode - 7',NULL,NULL,'"drvSalaryMode7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EMETVLTDVEZ0','7','D','10','701',NULL,'Salary Amount - 7',NULL,NULL,'"drvSalaryAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EMETVLTDVEZ0','2','D','10','708',NULL,'Coverage Code - 8',NULL,NULL,'"drvCodeCode8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EMETVLTDVEZ0','8','D','10','710',NULL,'Coverage Start Date - 8',NULL,NULL,'"drvCoverageStartDate8"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EMETVLTDVEZ0','8','D','10','718',NULL,'Coverage Stop Date - 8',NULL,NULL,'"drvCoverageStopDate8"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EMETVLTDVEZ0','7','D','10','726',NULL,'Group Number - 8',NULL,NULL,'"drvGroupNumber8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EMETVLTDVEZ0','4','D','10','733',NULL,'Subcode - 8',NULL,NULL,'"drvSubCode8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EMETVLTDVEZ0','4','D','10','737',NULL,'Branch - 8',NULL,NULL,'"drvBranch8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EMETVLTDVEZ0','2','D','10','741',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EMETVLTDVEZ0','1','D','10','743',NULL,'Status Code - 8',NULL,NULL,'"drvStatusCode8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EMETVLTDVEZ0','1','D','10','744',NULL,'Members Covered Code - 8',NULL,NULL,'"drvMembersCoveredCode8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EMETVLTDVEZ0','10','D','10','745',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EMETVLTDVEZ0','8','D','10','755',NULL,'Annual Benefit Amount - 8',NULL,NULL,'"drvAnnualBenefitAmount8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EMETVLTDVEZ0','8','D','10','763',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EMETVLTDVEZ0','2','D','10','771',NULL,'Coverage Code - 9',NULL,NULL,'"drvCoverageCode9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EMETVLTDVEZ0','8','D','10','773',NULL,'Coverage Start Date - 9',NULL,NULL,'"drvCoverageStartDate9"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EMETVLTDVEZ0','8','D','10','781',NULL,'Coverage Stop Date - 9',NULL,NULL,'"drvCoverageStopDate9"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EMETVLTDVEZ0','7','D','10','789',NULL,'Group Number - 9',NULL,NULL,'"drvGroupNumber9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EMETVLTDVEZ0','4','D','10','796',NULL,'Subcode - 9',NULL,NULL,'"drvSubCode9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EMETVLTDVEZ0','4','D','10','800',NULL,'Branch - 9',NULL,NULL,'"drvBranch9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EMETVLTDVEZ0','2','D','10','804',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EMETVLTDVEZ0','1','D','10','806',NULL,'Status Code - 9',NULL,NULL,'"drvStatusCode9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EMETVLTDVEZ0','1','D','10','807',NULL,'Members Covered Code - 9',NULL,NULL,'"drvMembersCoveredCode9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EMETVLTDVEZ0','10','D','10','808',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EMETVLTDVEZ0','8','D','10','818',NULL,'Annual Benefit Amount - 9',NULL,NULL,'"drvAnnualBenefitAmount9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EMETVLTDVEZ0','8','D','10','826',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EMETVLTDVEZ0','2','D','10','834',NULL,'Coverage Code - 10',NULL,NULL,'"drvCoverageCode10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EMETVLTDVEZ0','8','D','10','836',NULL,'Coverage Start Date - 10',NULL,NULL,'"drvCoverageStartDate10"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EMETVLTDVEZ0','8','D','10','844',NULL,'Coverage Stop Date - 10',NULL,NULL,'"drvCoverageStopDate10"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EMETVLTDVEZ0','7','D','10','852',NULL,'Group Number - 10',NULL,NULL,'"drvGroupNumber10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EMETVLTDVEZ0','4','D','10','859',NULL,'Subcode - 10',NULL,NULL,'"drvSubCode10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EMETVLTDVEZ0','4','D','10','863',NULL,'Branch - 10',NULL,NULL,'"drvBranch10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EMETVLTDVEZ0','2','D','10','867',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EMETVLTDVEZ0','1','D','10','869',NULL,'Status Code - 10',NULL,NULL,'"drvStatusCode10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EMETVLTDVEZ0','1','D','10','870',NULL,'Members Covered Code - 10',NULL,NULL,'"drvMembersCoveredCode10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EMETVLTDVEZ0','10','D','10','871',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EMETVLTDVEZ0','8','D','10','881',NULL,'Annual Benefit Amount - 10',NULL,NULL,'"drvAnnualBenefitAmount10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EMETVLTDVEZ0','1','D','10','889',NULL,'Salary Mode - 10',NULL,NULL,'"drvSalaryMode10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EMETVLTDVEZ0','7','D','10','890',NULL,'Salary Amount - 10',NULL,NULL,'"drvSalaryAmount10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EMETVLTDVEZ0','2','D','10','897',NULL,'Coverage Code - 11',NULL,NULL,'"drvCoverageCode11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EMETVLTDVEZ0','8','D','10','899',NULL,'Coverage Start Date - 11',NULL,NULL,'"drvCoverageStartDate11"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EMETVLTDVEZ0','8','D','10','907',NULL,'Coverage Stop Date - 11',NULL,NULL,'"drvCoverageStopDate11"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EMETVLTDVEZ0','7','D','10','915',NULL,'Group Number - 11',NULL,NULL,'"drvGroupNumber11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EMETVLTDVEZ0','4','D','10','922',NULL,'Subcode - 11',NULL,NULL,'"drvSubCode11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EMETVLTDVEZ0','4','D','10','926',NULL,'Branch - 11',NULL,NULL,'"drvBranch11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EMETVLTDVEZ0','2','D','10','930',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EMETVLTDVEZ0','1','D','10','932',NULL,'Status Code - 11',NULL,NULL,'"drvStatusCode11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EMETVLTDVEZ0','1','D','10','933',NULL,'Members Covered Code - 11',NULL,NULL,'"drvMembersCoveredCode11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EMETVLTDVEZ0','10','D','10','934',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EMETVLTDVEZ0','8','D','10','944',NULL,'Annual Benefit Amount - 11',NULL,NULL,'"drvAnnualBenefitAmount11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EMETVLTDVEZ0','8','D','10','952',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EMETVLTDVEZ0','2','D','10','960',NULL,'Coverage Code - 12',NULL,NULL,'"drvCoverageCode12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EMETVLTDVEZ0','8','D','10','962',NULL,'Coverage Start Date - 12',NULL,NULL,'"drvCoverageStartDate12"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EMETVLTDVEZ0','8','D','10','970',NULL,'Coverage Stop Date - 12',NULL,NULL,'"drvCoverageStopDate12"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EMETVLTDVEZ0','7','D','10','978',NULL,'Group Number - 12',NULL,NULL,'"drvCoverageGroupNumer12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EMETVLTDVEZ0','4','D','10','985',NULL,'Subcode - 12',NULL,NULL,'"drvSubCode12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EMETVLTDVEZ0','4','D','10','989',NULL,'Branch - 12',NULL,NULL,'"drvBranch12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EMETVLTDVEZ0','2','D','10','993',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EMETVLTDVEZ0','1','D','10','995',NULL,'Status Code - 12',NULL,NULL,'"drvStatusCode12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EMETVLTDVEZ0','1','D','10','996',NULL,'Members Covered Code - 12',NULL,NULL,'"drvMembersCoveredCode12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EMETVLTDVEZ0','10','D','10','997',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EMETVLTDVEZ0','8','D','10','1007',NULL,'Annual Benefit Amount - 12',NULL,NULL,'"drvAnnualBenefitAmount12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EMETVLTDVEZ0','8','D','10','1015',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EMETVLTDVEZ0','2','D','10','1023',NULL,'Coverage Code - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EMETVLTDVEZ0','8','D','10','1025',NULL,'Coverage Start Date - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EMETVLTDVEZ0','8','D','10','1033',NULL,'Coverage Stop Date - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EMETVLTDVEZ0','7','D','10','1041',NULL,'Group Number - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EMETVLTDVEZ0','4','D','10','1048',NULL,'Subcode - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EMETVLTDVEZ0','4','D','10','1052',NULL,'Branch - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EMETVLTDVEZ0','2','D','10','1056',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EMETVLTDVEZ0','1','D','10','1058',NULL,'Status Code - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EMETVLTDVEZ0','1','D','10','1059',NULL,'Members Covered Code - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EMETVLTDVEZ0','10','D','10','1060',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EMETVLTDVEZ0','8','D','10','1070',NULL,'Annual Benefit Amount - 13',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EMETVLTDVEZ0','8','D','10','1078',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EMETVLTDVEZ0','2','D','10','1086',NULL,'Coverage Code - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EMETVLTDVEZ0','8','D','10','1088',NULL,'Coverage Start Date - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EMETVLTDVEZ0','8','D','10','1096',NULL,'Coverage Stop Date - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EMETVLTDVEZ0','7','D','10','1104',NULL,'Group Number - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EMETVLTDVEZ0','4','D','10','1111',NULL,'Subcode - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EMETVLTDVEZ0','4','D','10','1115',NULL,'Branch - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EMETVLTDVEZ0','2','D','10','1119',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EMETVLTDVEZ0','1','D','10','1121',NULL,'Status Code - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EMETVLTDVEZ0','1','D','10','1122',NULL,'Members Covered Code - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EMETVLTDVEZ0','10','D','10','1123',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EMETVLTDVEZ0','8','D','10','1133',NULL,'Annual Benefit Amount - 14',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EMETVLTDVEZ0','12','D','10','1141',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EMETVLTDVEZ0','2','D','10','1153',NULL,'Coverage Code - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EMETVLTDVEZ0','8','D','10','1155',NULL,'Coverage Start Date - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EMETVLTDVEZ0','8','D','10','1163',NULL,'Coverage Stop Date - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EMETVLTDVEZ0','7','D','10','1171',NULL,'Group Number - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EMETVLTDVEZ0','4','D','10','1178',NULL,'Subcode - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EMETVLTDVEZ0','4','D','10','1182',NULL,'Branch - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EMETVLTDVEZ0','2','D','10','1186',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EMETVLTDVEZ0','1','D','10','1188',NULL,'Status Code - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EMETVLTDVEZ0','1','D','10','1189',NULL,'Members Covered Code - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EMETVLTDVEZ0','10','D','10','1190',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EMETVLTDVEZ0','8','D','10','1200',NULL,'Annual Benefit Amount - 15',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EMETVLTDVEZ0','8','D','10','1208',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EMETVLTDVEZ0','2','D','10','1216',NULL,'Coverage Code - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EMETVLTDVEZ0','8','D','10','1218',NULL,'Coverage Start Date - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EMETVLTDVEZ0','8','D','10','1226',NULL,'Coverage Stop Date - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EMETVLTDVEZ0','7','D','10','1234',NULL,'Group Number - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EMETVLTDVEZ0','4','D','10','1241',NULL,'Subcode - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EMETVLTDVEZ0','4','D','10','1245',NULL,'Branch - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EMETVLTDVEZ0','2','D','10','1249',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EMETVLTDVEZ0','1','D','10','1251',NULL,'Status Code - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EMETVLTDVEZ0','1','D','10','1252',NULL,'Members Covered Code - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EMETVLTDVEZ0','10','D','10','1253',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EMETVLTDVEZ0','8','D','10','1263',NULL,'Annual Benefit Amount - 16',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EMETVLTDVEZ0','8','D','10','1271',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EMETVLTDVEZ0','2','D','10','1279',NULL,'Coverage Code - 17',NULL,NULL,'"drvCoverageCode17"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EMETVLTDVEZ0','8','D','10','1281',NULL,'Coverage Start Date - 17',NULL,NULL,'"drvCoverageStartDate17"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EMETVLTDVEZ0','8','D','10','1289',NULL,'Coverage Stop Date - 17',NULL,NULL,'"drvCoverageStopDate17"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EMETVLTDVEZ0','7','D','10','1297',NULL,'Group Number - 17',NULL,NULL,'"drvGroupNumber17"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EMETVLTDVEZ0','4','D','10','1304',NULL,'Subcode - 17',NULL,NULL,'"drvSubCode17"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EMETVLTDVEZ0','4','D','10','1308',NULL,'Branch - 17',NULL,NULL,'"drvBranch17"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EMETVLTDVEZ0','2','D','10','1312',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EMETVLTDVEZ0','1','D','10','1314',NULL,'Status Code - 17',NULL,NULL,'"drvStatusCode17"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EMETVLTDVEZ0','1','D','10','1315',NULL,'Members Covered Code - 17',NULL,NULL,'"drvMembersCoveredCode17"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EMETVLTDVEZ0','2','D','10','1316',NULL,'Cancel Reason - 17',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EMETVLTDVEZ0','23','D','10','1318',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EMETVLTDVEZ0','1','D','10','1341',NULL,'Employee Status Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EMETVLTDVEZ0','8','D','10','1342',NULL,'Status Code Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EMETVLTDVEZ0','10','D','10','1350',NULL,'Department Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EMETVLTDVEZ0','10','D','10','1360',NULL,'Group ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EMETVLTDVEZ0','5','D','10','1370',NULL,'Location ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EMETVLTDVEZ0','10','D','10','1375',NULL,'Schedule ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EMETVLTDVEZ0','2','D','10','1385',NULL,'Pay Frequency',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EMETVLTDVEZ0','2','D','10','1387',NULL,'Coverage Code - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EMETVLTDVEZ0','8','D','10','1389',NULL,'Coverage Start Date - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EMETVLTDVEZ0','8','D','10','1397',NULL,'Coverage Stop Date - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EMETVLTDVEZ0','7','D','10','1405',NULL,'Group Number - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EMETVLTDVEZ0','4','D','10','1412',NULL,'Subcode - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EMETVLTDVEZ0','4','D','10','1416',NULL,'Branch - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EMETVLTDVEZ0','1','D','10','1420',NULL,'Status Code - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EMETVLTDVEZ0','1','D','10','1421',NULL,'Members Covered Code - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EMETVLTDVEZ0','1','D','10','1422',NULL,'Enrollment Status - 18',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EMETVLTDVEZ0','2','D','10','1423',NULL,'Coverage Code - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EMETVLTDVEZ0','8','D','10','1425',NULL,'Coverage Start Date - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EMETVLTDVEZ0','8','D','10','1433',NULL,'Coverage Stop Date - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EMETVLTDVEZ0','7','D','10','1441',NULL,'Group Number - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EMETVLTDVEZ0','4','D','10','1448',NULL,'Subcode - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EMETVLTDVEZ0','4','D','10','1452',NULL,'Branch - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EMETVLTDVEZ0','1','D','10','1456',NULL,'Members Covered Code - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EMETVLTDVEZ0','1','D','10','1457',NULL,'Enrollment Status - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','EMETVLTDVEZ0','8','D','10','1458',NULL,'Benefit Amount - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','EMETVLTDVEZ0','2','D','10','1466',NULL,'Voluntary Cancellation Ind - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','EMETVLTDVEZ0','1','D','10','1468',NULL,'Taveover Indicator - 19',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','EMETVLTDVEZ0','9','D','10','1469',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','EMETVLTDVEZ0','2','D','10','1478',NULL,'Coverage Code - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','EMETVLTDVEZ0','8','D','10','1480',NULL,'Coverage Start Date - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','EMETVLTDVEZ0','8','D','10','1488',NULL,'Coverage Stop Date - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','EMETVLTDVEZ0','7','D','10','1496',NULL,'Group Number - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','EMETVLTDVEZ0','4','D','10','1503',NULL,'Subcode - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','EMETVLTDVEZ0','4','D','10','1507',NULL,'Branch - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','EMETVLTDVEZ0','1','D','10','1511',NULL,'Members Covered Code - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','EMETVLTDVEZ0','1','D','10','1512',NULL,'Enrollment Status - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','EMETVLTDVEZ0','8','D','10','1513',NULL,'Benefit Amount - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','EMETVLTDVEZ0','2','D','10','1521',NULL,'Voluntary Cancellation Ind - 20',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','EMETVLTDVEZ0','8','D','10','1523',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','EMETVLTDVEZ0','2','D','10','1531',NULL,'Coverage Code - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','EMETVLTDVEZ0','8','D','10','1533',NULL,'Coverage Start Date - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','EMETVLTDVEZ0','8','D','10','1541',NULL,'Coverage Stop Date - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','EMETVLTDVEZ0','7','D','10','1549',NULL,'Group Number - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','EMETVLTDVEZ0','4','D','10','1556',NULL,'Subcode - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','EMETVLTDVEZ0','4','D','10','1560',NULL,'Branch - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','EMETVLTDVEZ0','1','D','10','1564',NULL,'Members Covered Code - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','EMETVLTDVEZ0','1','D','10','1565',NULL,'Enrollment Status - 21',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','EMETVLTDVEZ0','3','D','10','1566',NULL,'GPC Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','EMETVLTDVEZ0','2','D','10','1569',NULL,'Paypoint',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','EMETVLTDVEZ0','3','D','10','1571',NULL,'Payroll Deduction',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','EMETVLTDVEZ0','2','D','10','1574',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','EMETVLTDVEZ0','2','D','10','1576',NULL,'Coverage Code - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','EMETVLTDVEZ0','8','D','10','1578',NULL,'Coverage Start Date - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','EMETVLTDVEZ0','8','D','10','1586',NULL,'Coverage Stop Date - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','EMETVLTDVEZ0','7','D','10','1594',NULL,'Group Number - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','EMETVLTDVEZ0','4','D','10','1601',NULL,'Subcode - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','EMETVLTDVEZ0','4','D','10','1605',NULL,'Branch - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','EMETVLTDVEZ0','1','D','10','1609',NULL,'Members Covered Code - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','EMETVLTDVEZ0','1','D','10','1610',NULL,'Enrollment Status - 22',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','EMETVLTDVEZ0','2','D','10','1611',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','EMETVLTDVEZ0','2','D','10','1613',NULL,'Coverage Code - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','EMETVLTDVEZ0','8','D','10','1615',NULL,'Coverage Start Date - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','EMETVLTDVEZ0','8','D','10','1623',NULL,'Coverage Stop Date - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','EMETVLTDVEZ0','7','D','10','1631',NULL,'Group Number - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','EMETVLTDVEZ0','4','D','10','1638',NULL,'Subcode - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','EMETVLTDVEZ0','4','D','10','1642',NULL,'Branch - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','EMETVLTDVEZ0','1','D','10','1646',NULL,'Members Covered Code - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','EMETVLTDVEZ0','1','D','10','1647',NULL,'Enrollment Status - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','EMETVLTDVEZ0','2','D','10','1648',NULL,'Voluntary Cancellation Ind - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','EMETVLTDVEZ0','1','D','10','1650',NULL,'Takeover Indicator - 23',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','EMETVLTDVEZ0','9','D','10','1651',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','EMETVLTDVEZ0','2','D','10','1660',NULL,'Coverage Code - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','EMETVLTDVEZ0','8','D','10','1662',NULL,'Coverage Start Date - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','EMETVLTDVEZ0','8','D','10','1670',NULL,'Coverage Stop Date - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','EMETVLTDVEZ0','7','D','10','1678',NULL,'Group Number - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','EMETVLTDVEZ0','4','D','10','1685',NULL,'Subcode - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','EMETVLTDVEZ0','4','D','10','1689',NULL,'Branch - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','EMETVLTDVEZ0','1','D','10','1693',NULL,'Members Covered Code - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','EMETVLTDVEZ0','1','D','10','1694',NULL,'Enrollment Status - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','EMETVLTDVEZ0','2','D','10','1695',NULL,'Voluntary Cancellation Ind - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','EMETVLTDVEZ0','1','D','10','1697',NULL,'Takeover Indicator - 24',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','EMETVLTDVEZ0','9','D','10','1698',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','EMETVLTDVEZ0','2','D','10','1707',NULL,'Coverage Code - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','EMETVLTDVEZ0','8','D','10','1709',NULL,'Coverage Start Date - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','EMETVLTDVEZ0','8','D','10','1717',NULL,'Coverage Stop Date - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','EMETVLTDVEZ0','7','D','10','1725',NULL,'Group Number - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','EMETVLTDVEZ0','4','D','10','1732',NULL,'Subcode - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','EMETVLTDVEZ0','4','D','10','1736',NULL,'Branch - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','EMETVLTDVEZ0','1','D','10','1740',NULL,'Members Covered Code - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','EMETVLTDVEZ0','1','D','10','1741',NULL,'Enrollment Status - 25',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','EMETVLTDVEZ0','10','D','10','1742',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','EMETVLTDVEZ0','95','D','10','1752',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','EMETVLTDVEZ0','2','D','10','1847',NULL,'Coverage Code - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','EMETVLTDVEZ0','8','D','10','1849',NULL,'Coverage Start Date - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','EMETVLTDVEZ0','8','D','10','1857',NULL,'Coverage Stop Date - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','EMETVLTDVEZ0','7','D','10','1865',NULL,'Group Number - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','EMETVLTDVEZ0','4','D','10','1872',NULL,'Subcode - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','EMETVLTDVEZ0','4','D','10','1876',NULL,'Branch - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('329','EMETVLTDVEZ0','1','D','10','1880',NULL,'Status Code - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('330','EMETVLTDVEZ0','1','D','10','1881',NULL,'Members Covered Code - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('331','EMETVLTDVEZ0','8','D','10','1882',NULL,'Benefit Amount - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('332','EMETVLTDVEZ0','1','D','10','1890',NULL,'Takeover Indicator - 27',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('333','EMETVLTDVEZ0','10','D','10','1891',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('334','EMETVLTDVEZ0','2','D','10','1901',NULL,'Coverage Code - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('335','EMETVLTDVEZ0','8','D','10','1903',NULL,'Coverage Start Date - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('336','EMETVLTDVEZ0','8','D','10','1911',NULL,'Coverage Stop Date - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('337','EMETVLTDVEZ0','7','D','10','1919',NULL,'Group Number - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('338','EMETVLTDVEZ0','4','D','10','1926',NULL,'Subcode - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('339','EMETVLTDVEZ0','4','D','10','1930',NULL,'Branch - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('340','EMETVLTDVEZ0','1','D','10','1934',NULL,'Members Covered Code - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('341','EMETVLTDVEZ0','1','D','10','1935',NULL,'Enrollment Status - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('342','EMETVLTDVEZ0','8','D','10','1936',NULL,'Benefit Amount - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('343','EMETVLTDVEZ0','2','D','10','1944',NULL,'Voluntary Cancellation Ind - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('344','EMETVLTDVEZ0','1','D','10','1946',NULL,'Takeover Indicator - 28',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('345','EMETVLTDVEZ0','9','D','10','1947',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('346','EMETVLTDVEZ0','2','D','10','1956',NULL,'Coverage Code - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('347','EMETVLTDVEZ0','8','D','10','1958',NULL,'Coverage Start Date - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('348','EMETVLTDVEZ0','8','D','10','1966',NULL,'Coverage Stop Date - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('349','EMETVLTDVEZ0','7','D','10','1974',NULL,'Group Number - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('350','EMETVLTDVEZ0','4','D','10','1981',NULL,'Subcode - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('351','EMETVLTDVEZ0','4','D','10','1985',NULL,'Branch - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('352','EMETVLTDVEZ0','1','D','10','1989',NULL,'Members Covered Code - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('353','EMETVLTDVEZ0','1','D','10','1990',NULL,'Enrollment Status - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('354','EMETVLTDVEZ0','8','D','10','1991',NULL,'Benefit Amount - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('355','EMETVLTDVEZ0','2','D','10','1999',NULL,'Voluntary Cancellation Ind - 29',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('356','EMETVLTDVEZ0','10','D','10','2001',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('357','EMETVLTDVEZ0','2','D','10','2011',NULL,'Work State',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('358','EMETVLTDVEZ0','1','D','10','2013',NULL,'Job Status Code (full time/part time indicator)',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('359','EMETVLTDVEZ0','8','D','10','2014',NULL,'Job Status (full time/part time) As of Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('360','EMETVLTDVEZ0','1','D','10','2022',NULL,'Federal Marital Tax Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('361','EMETVLTDVEZ0','2','D','10','2023',NULL,'Number of Federal Exemptions',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('362','EMETVLTDVEZ0','1','D','10','2025',NULL,'Work Status Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('363','EMETVLTDVEZ0','8','D','10','2026',NULL,'Work Status Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('364','EMETVLTDVEZ0','9','D','10','2034',NULL,'Salary Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('365','EMETVLTDVEZ0','1','D','10','2043',NULL,'Salary Mode',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('366','EMETVLTDVEZ0','8','D','10','2044',NULL,'Salary Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('367','EMETVLTDVEZ0','3','D','10','2052',NULL,'Average Weekly Scheduled Work Hours',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('368','EMETVLTDVEZ0','2','D','10','2055',NULL,'Work Week Schedule',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('369','EMETVLTDVEZ0','2','D','10','2057',NULL,'Coverage Code - 30',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('370','EMETVLTDVEZ0','8','D','10','2059',NULL,'Coverage Start Date - 30',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('371','EMETVLTDVEZ0','8','D','10','2067',NULL,'Coverage Stop Date - 30',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('372','EMETVLTDVEZ0','7','D','10','2075',NULL,'Group Number - 30',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('373','EMETVLTDVEZ0','4','D','10','2082',NULL,'Subcode - 30',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('374','EMETVLTDVEZ0','4','D','10','2086',NULL,'Branch - 30',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('375','EMETVLTDVEZ0','2','D','10','2090',NULL,'Coverage Code - 31',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('376','EMETVLTDVEZ0','8','D','10','2092',NULL,'Coverage Start Date - 31',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('377','EMETVLTDVEZ0','8','D','10','2100',NULL,'Coverage Stop Date - 31',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('378','EMETVLTDVEZ0','7','D','10','2108',NULL,'Group Number - 31',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('379','EMETVLTDVEZ0','4','D','10','2115',NULL,'Subcode - 31',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('380','EMETVLTDVEZ0','4','D','10','2119',NULL,'Branch - 31',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('381','EMETVLTDVEZ0','2','D','10','2123',NULL,'Coverage Code - 32',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('382','EMETVLTDVEZ0','8','D','10','2125',NULL,'Coverage Start Date - 32',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('383','EMETVLTDVEZ0','8','D','10','2133',NULL,'Coverage Stop Date - 32',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('384','EMETVLTDVEZ0','7','D','10','2141',NULL,'Group Number - 32',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('385','EMETVLTDVEZ0','4','D','10','2148',NULL,'Subcode - 32',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('386','EMETVLTDVEZ0','4','D','10','2152',NULL,'Branch - 32',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('387','EMETVLTDVEZ0','2','D','10','2156',NULL,'Coverage Code - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('388','EMETVLTDVEZ0','8','D','10','2158',NULL,'Coverage Start Date - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('389','EMETVLTDVEZ0','8','D','10','2166',NULL,'Coverage Stop Date - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('390','EMETVLTDVEZ0','7','D','10','2174',NULL,'Group Number - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('391','EMETVLTDVEZ0','4','D','10','2181',NULL,'Subcode - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('392','EMETVLTDVEZ0','4','D','10','2185',NULL,'Branch - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('393','EMETVLTDVEZ0','2','D','10','2189',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('394','EMETVLTDVEZ0','1','D','10','2191',NULL,'Status Code - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('395','EMETVLTDVEZ0','1','D','10','2192',NULL,'Members Covered Code - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('396','EMETVLTDVEZ0','2','D','10','2193',NULL,'Cancel Reason - 33',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('397','EMETVLTDVEZ0','2','D','10','2195',NULL,'Coverage Code - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('398','EMETVLTDVEZ0','8','D','10','2197',NULL,'Coverage Start Date - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('399','EMETVLTDVEZ0','8','D','10','2205',NULL,'Coverage Stop Date - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('400','EMETVLTDVEZ0','7','D','10','2213',NULL,'Group Number - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('401','EMETVLTDVEZ0','4','D','10','2220',NULL,'Subcode - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('402','EMETVLTDVEZ0','4','D','10','2224',NULL,'Branch - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('403','EMETVLTDVEZ0','2','D','10','2228',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('404','EMETVLTDVEZ0','1','D','10','2230',NULL,'Status Code - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('405','EMETVLTDVEZ0','1','D','10','2231',NULL,'Members Covered Code - 34',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('406','EMETVLTDVEZ0','2','D','10','2232',NULL,'Cancel Reason - 34',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMETVLTDVE_20220111.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202201079','EMPEXPORT','OEACTIVE',NULL,'EMETVLTDVE',NULL,NULL,NULL,'202201079','Jan  7 2022 10:51AM','Jan  7 2022 10:51AM','202201071',NULL,'','','202201071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202201079','EMPEXPORT','OEPASSIVE',NULL,'EMETVLTDVE',NULL,NULL,NULL,'202201079','Jan  7 2022 10:51AM','Jan  7 2022 10:51AM','202201071',NULL,'','','202201071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife L/VL L/STD D/V Export','202201079','EMPEXPORT','ONDEM_XOE',NULL,'EMETVLTDVE',NULL,NULL,NULL,'202201079','Jan  7 2022 10:51AM','Jan  7 2022 10:51AM','202201071',NULL,'','','202201071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife L/VL L/STD D/V E-Sched','202201079','EMPEXPORT','SCH_EMETVL',NULL,'EMETVLTDVE',NULL,NULL,NULL,'202201079','Jan  7 2022 10:51AM','Jan  7 2022 10:51AM','202201071',NULL,'','','202201071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'MetLife L/VL L/STD D/V E-Test','202201079','EMPEXPORT','TEST_XOE',NULL,'EMETVLTDVE',NULL,NULL,NULL,'202201079','Jan  7 2022 10:51AM','Jan  7 2022 10:51AM','202201071',NULL,'','','202201071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETVLTDVE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETVLTDVE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETVLTDVE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETVLTDVE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETVLTDVE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETVLTDVE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETVLTDVE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETVLTDVE','D10','dbo.U_EMETVLTDVE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMETVLTDVE
-----------

IF OBJECT_ID('U_dsi_BDM_EMETVLTDVE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETVLTDVE] (
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
-- Create table U_EMETVLTDVE_DedList
-----------

IF OBJECT_ID('U_EMETVLTDVE_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETVLTDVE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMETVLTDVE_drvTbl
-----------

IF OBJECT_ID('U_EMETVLTDVE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETVLTDVE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(15) NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvCustomerNumber] varchar(7) NULL,
    [drvEmployeeNumber] varchar(13) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvMemberMaritalStatus] char(1) NULL,
    [drvMemberGender] char(1) NULL,
    [drvRelationshipCode] varchar(2) NOT NULL,
    [drvEmployeesDateOfHire] datetime NULL,
    [drvPersonalIdentification] char(9) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvStreetAddress] varchar(511) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCoverageCode1] varchar(1) NULL,
    [drvCoverageStartDate1] datetime NULL,
    [drvCoverageStopDate1] datetime NULL,
    [drvGroupNumber1] varchar(7) NULL,
    [drvSubCode1] varchar(4) NULL,
    [drvStatusCode1] varchar(1) NULL,
    [drvMembersCoveredCode1] varchar(1) NULL,
    [drvCoverageCode2] varchar(2) NULL,
    [drvCoverageStartDate2] datetime NULL,
    [drvCoverageStopDate2] datetime NULL,
    [drvGroupNumber2] varchar(7) NULL,
    [drvSubCode2] varchar(4) NULL,
    [drvStatusCode2] varchar(1) NULL,
    [drvMembersCoveredCode2] varchar(1) NULL,
    [drvAnnualBenefitAmount2] nvarchar(4000) NULL,
    [drvSalaryMode2] varchar(1) NULL,
    [drvSalaryAmount2] nvarchar(4000) NULL,
    [drvCoverageCode3] varchar(2) NULL,
    [drvCoverageStartDate3] datetime NULL,
    [drvCoverageStopDate3] datetime NULL,
    [drvGroupNumber3] varchar(7) NULL,
    [drvSubCode3] varchar(4) NULL,
    [drvStatusCode3] varchar(1) NULL,
    [drvMembersCoveredCode3] varchar(1) NULL,
    [drvAnnualBenefitAmount3] nvarchar(4000) NULL,
    [drvSalaryMode3] varchar(1) NULL,
    [drvSalaryAmount3] nvarchar(4000) NULL,
    [drvCoverageCode4] varchar(2) NULL,
    [drvCoverageStartDate4] datetime NULL,
    [drvCoverageStopDate4] datetime NULL,
    [drvGroupNumber4] varchar(7) NULL,
    [drvSubCode4] varchar(4) NULL,
    [drvStatusCode4] varchar(1) NULL,
    [drvMembersCoveredCode4] varchar(1) NULL,
    [drvMonthlyBenefitAmount4] nvarchar(4000) NULL,
    [drvSalaryMode4] varchar(1) NULL,
    [drvSalaryAmount4] nvarchar(4000) NULL,
    [drvCoverageCode5] varchar(2) NULL,
    [drvCoverageStartDate5] datetime NULL,
    [drvCoverageStopDAte5] datetime NULL,
    [drvGroupNumber5] varchar(7) NULL,
    [drvSubCode5] varchar(4) NULL,
    [drvStatusCode5] varchar(1) NULL,
    [drvMembersCoveredCode5] varchar(1) NULL,
    [drvWeeklyBenefitAmount5] nvarchar(4000) NULL,
    [drvSalaryMode5] varchar(1) NULL,
    [drvSalaryAmount5] nvarchar(4000) NULL,
    [drvCoverageCode7] varchar(2) NULL,
    [drvCoverageStartDate7] datetime NULL,
    [drvCoverageStopDate7] datetime NULL,
    [drvGroupNumber7] varchar(7) NULL,
    [drvSubCode7] varchar(4) NULL,
    [drvBranch7] varchar(4) NULL,
    [drvStatusCode7] varchar(1) NULL,
    [drvMembersCoveredCode7] varchar(1) NULL,
    [drvAnnualBenefitAmount7] nvarchar(4000) NULL,
    [drvSalaryMode7] varchar(1) NULL,
    [drvSalaryAmount7] nvarchar(4000) NULL,
    [drvCodeCode8] varchar(2) NULL,
    [drvCoverageStartDate8] datetime NULL,
    [drvCoverageStopDate8] datetime NULL,
    [drvGroupNumber8] varchar(7) NULL,
    [drvSubCode8] varchar(4) NULL,
    [drvBranch8] varchar(4) NULL,
    [drvStatusCode8] varchar(1) NULL,
    [drvMembersCoveredCode8] varchar(1) NULL,
    [drvAnnualBenefitAmount8] nvarchar(4000) NULL,
    [drvCoverageCode9] varchar(2) NULL,
    [drvCoverageStartDate9] datetime NULL,
    [drvCoverageStopDate9] datetime NULL,
    [drvGroupNumber9] varchar(7) NULL,
    [drvSubCode9] varchar(4) NULL,
    [drvBranch9] varchar(4) NULL,
    [drvStatusCode9] varchar(1) NULL,
    [drvMembersCoveredCode9] varchar(1) NULL,
    [drvAnnualBenefitAmount9] nvarchar(4000) NULL,
    [drvCoverageCode10] varchar(2) NULL,
    [drvCoverageStartDate10] datetime NULL,
    [drvCoverageStopDate10] datetime NULL,
    [drvGroupNumber10] varchar(7) NULL,
    [drvSubCode10] varchar(4) NULL,
    [drvBranch10] varchar(4) NULL,
    [drvStatusCode10] varchar(1) NULL,
    [drvMembersCoveredCode10] varchar(1) NULL,
    [drvAnnualBenefitAmount10] nvarchar(4000) NULL,
    [drvSalaryMode10] varchar(1) NULL,
    [drvSalaryAmount10] nvarchar(4000) NULL,
    [drvCoverageCode11] varchar(2) NULL,
    [drvCoverageStartDate11] datetime NULL,
    [drvCoverageStopDate11] datetime NULL,
    [drvGroupNumber11] varchar(7) NULL,
    [drvSubCode11] varchar(4) NULL,
    [drvBranch11] varchar(4) NULL,
    [drvStatusCode11] varchar(1) NULL,
    [drvMembersCoveredCode11] varchar(1) NULL,
    [drvAnnualBenefitAmount11] nvarchar(4000) NULL,
    [drvCoverageCode12] varchar(2) NULL,
    [drvCoverageStartDate12] datetime NULL,
    [drvCoverageStopDate12] datetime NULL,
    [drvCoverageGroupNumer12] varchar(7) NULL,
    [drvSubCode12] varchar(4) NULL,
    [drvBranch12] varchar(4) NULL,
    [drvStatusCode12] varchar(1) NULL,
    [drvMembersCoveredCode12] varchar(1) NULL,
    [drvAnnualBenefitAmount12] nvarchar(4000) NULL,
    [drvCoverageCode17] varchar(2) NULL,
    [drvCoverageStartDate17] datetime NULL,
    [drvCoverageStopDate17] datetime NULL,
    [drvGroupNumber17] varchar(7) NULL,
    [drvSubCode17] varchar(4) NULL,
    [drvBranch17] varchar(4) NULL,
    [drvStatusCode17] varchar(1) NULL,
    [drvMembersCoveredCode17] varchar(1) NULL
);

-----------
-- Create table U_EMETVLTDVE_EEList
-----------

IF OBJECT_ID('U_EMETVLTDVE_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETVLTDVE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMETVLTDVE_File
-----------

IF OBJECT_ID('U_EMETVLTDVE_File') IS NULL
CREATE TABLE [dbo].[U_EMETVLTDVE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETVLTDVE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ICON

Created By: James Bender
Business Analyst: Lea King
Create Date: 01/07/2022
Service Request Number: TekP-2021-10-19-0007

Purpose: MetLife L/VL L/STD Den Vis Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETVLTDVE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETVLTDVE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETVLTDVE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETVLTDVE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETVLTDVE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETVLTDVE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETVLTDVE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETVLTDVE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETVLTDVE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETVLTDVE', 'SCH_EMETVL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETVLTDVE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMETVLTDVE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMETVLTDVE';

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
    DELETE FROM dbo.U_EMETVLTDVE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETVLTDVE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ADD2X,ADD50,DENC,DENH,GLIF5,GLIFE,LCH,LCH,LIF,LIF,LSP,LSP,LTD,STD2,VISC,VISE';

    IF OBJECT_ID('U_EMETVLTDVE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETVLTDVE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETVLTDVE_DedList
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
    -- Build Driver Tables
    --==========================================

    DECLARE 
        @GLIFEPct        DECIMAL
        ,@GLIF5MaxAmt    MONEY
        ,@LTDPCt        DECIMAL
        ,@STD2Pct        DECIMAL
    ;

    SELECT @GLIFEPct = DedBenAmtRateOrPct FROM dbo.DedCode WITH (NOLOCK) WHERE DedDedCode = 'GLIFE';
    SELECT @GLIF5MaxAmt = DedBenAmtMax FROM dbo.DedCode WITH (NOLOCK) WHERE DedDedCode = 'GLIF5';
    SELECT @LTDPct = DedBenAmtRateOrPct FROM dbo.DedCode WITH (NOLOCK) WHERE DedDedCode = 'LTD';
    SELECT @STD2Pct = DedBenAmtRateOrPct FROM dbo.DedCode WITH (NOLOCK) WHERE DedDedCode = 'STD2';

    
    ---------------------------------
    -- DETAIL RECORD - U_EMETVLTDVE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETVLTDVE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETVLTDVE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' ' +    CASE WHEN ConRelationship IN ('DP','SPS') THEN '01'
                                    WHEN ConRelationship IN ('CHL','STC','DPC','DCH') THEN '02'
                                    ELSE '00'
                                    END
        -- standard fields above and additional driver fields below
        ,drvTransactionCode = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        ,drvCustomerNumber =    CASE WHEN ADD2X_DedCode IS NOT NULL OR 
                                    ADD50_DedCode IS NOT NULL OR 
                                    DENC_DedCode IS NOT NULL OR 
                                    DENH_DedCode IS NOT NULL OR 
                                    GLIF5_DedCode IS NOT NULL OR 
                                    GLIFE_DedCode IS NOT NULL OR 
                                    LCH_DedCode IS NOT NULL OR 
                                    LIF_DedCode IS NOT NULL OR 
                                    LSP_DedCode IS NOT NULL OR 
                                    LTD_DedCode IS NOT NULL OR 
                                    STD2_DedCode IS NOT NULL OR 
                                    VISC_DedCode IS NOT NULL OR 
                                    VISE_DedCode IS NOT NULL THEN '5391831'
                                END
        ,drvEmployeeNumber = '00' + RTRIM(EepSSN)
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle, 1) END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfbirth ELSE ConDateOfBirth END
        ,drvMemberMaritalStatus = eepMaritalStatus
        ,drvMemberGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvRelationshipCode =    CASE WHEN ConRelationship IN ('DP','SPS') THEN '01'
                                WHEN ConRelationship IN ('CHL','STC','DPC','DCH') THEN '02'
                                ELSE '00'
                                END
        ,drvEmployeesDateOfHire = EecDateOfLastHire
        ,drvPersonalIdentification = EecEmpNo
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvStreetAddress = RTRIM(ISNULL(EepAddressLine1, '') + ' ' + ISNULL(EepAddressLine2, ''))
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvCoverageCode1 = CASE WHEN DENC_DedCode IS NOT NULL OR DENH_DedCode IS NOT NULL THEN 'D' END
        ,drvCoverageStartDate1 =    CASE WHEN DENC_DedCode IS NOT NULL THEN DENC_BenStartDate
                                    WHEN DENH_DedCode IS NOT NULL THEN DENH_BenStartDate 
                                    END
        ,drvCoverageStopDate1 =    CASE WHEN DENC_DedCode IS NOT NULL THEN DENC_BenStopDate
                                WHEN DENH_DedCode IS NOT NULL THEN DENH_BenStopDate 
                                END
        ,drvGroupNumber1 = CASE WHEN DENC_DedCode IS NOT NULL OR DENH_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode1 = CASE WHEN DENC_DedCode IS NOT NULL OR DENH_DedCode IS NOT NULL THEN '0002' END
        ,drvStatusCode1 = CASE WHEN DENC_DedCode IS NOT NULL OR DENH_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode1 =    CASE WHEN DENC_DedCode IS NOT NULL THEN 
                                        CASE WHEN DENC_BenOption = 'EE' THEN '1'
                                        WHEN DENC_BenOption = 'EEF' THEN '4'
                                        WHEN DENC_BenOption = 'EEC' THEN '2'
                                        WHEN DENC_BenOption = 'EES' THEN '3'
                                        END
                                    WHEN DENH_DedCode IS NOT NULL THEN
                                        CASE WHEN DENH_BenOption = 'EE' THEN '1'
                                        WHEN DENH_BenOption = 'EEF' THEN '4'
                                        WHEN DENH_BenOption = 'EEC' THEN '2'
                                        WHEN DENH_BenOption = 'EES' THEN '3'
                                        END
                                    END
        ,drvCoverageCode2 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN 'CP' END
        ,drvCoverageStartDate2 =    CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BenStartDate
                                    WHEN GLIF5_DedCode IS NOT NULL THEN GLIF5_BenStartDate 
                                    END
        ,drvCoverageStopDate2 = CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BenStopDate
                                WHEN GLIF5_DedCode IS NOT NULL THEN GLIF5_BenStopDate 
                                END
        ,drvGroupNumber2 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode2 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN '0001' END
        ,drvStatusCode2 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode2 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmount2 = FORMAT(CASE WHEN GLIFE_DedCode IS NOT NULL THEN @GLIFEPct * EecAnnSalary
                                    WHEN GLIF5_DedCode IS NOT NULL THEN @GLIF5MaxAmt
                                    END, '00000000')
        ,drvSalaryMode2 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN 'A' END
        ,drvSalaryAmount2 = FORMAT(CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN EecAnnSalary END * 100, '0000000')


        ,drvCoverageCode3 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN 'AD' END
        ,drvCoverageStartDate3 =    CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BenStartDate
                                    WHEN GLIF5_DedCode IS NOT NULL THEN GLIF5_BenStartDate 
                                    END
        ,drvCoverageStopDate3 =    CASE WHEN GLIFE_DedCode IS NOT NULL THEN GLIFE_BenStopDate
                                WHEN GLIF5_DedCode IS NOT NULL THEN GLIF5_BenStopDate 
                                END
        ,drvGroupNumber3 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode3 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN '0001' END
        ,drvStatusCode3 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode3 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmount3 =    FORMAT(CASE WHEN GLIFE_DedCode IS NOT NULL THEN @GLIFEPct * EecAnnSalary
                                    WHEN GLIF5_DedCode IS NOT NULL THEN @GLIF5MaxAmt
                                    END, '00000000')
        ,drvSalaryMode3 = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN 'A' END
        ,drvSalaryAmount3 = FORMAT(CASE WHEN GLIFE_DedCode IS NOT NULL OR GLIF5_DedCode IS NOT NULL THEN EecAnnSalary END * 100, '0000000')

        ,drvCoverageCode4 = CASE WHEN LTD_DedCode IS NOT NULL THEN 'AD' END
        ,drvCoverageStartDate4 = CASE WHEN LTD_DedCode IS NOT NULL THEN LTD_BenStartDate END
        ,drvCoverageStopDate4 = CASE WHEN LTD_DedCode IS NOT NULL THEN LTD_BenStopDate END
        ,drvGroupNumber4 = CASE WHEN LTD_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode4 = CASE WHEN LTD_DedCode IS NOT NULL THEN '0001' END
        ,drvStatusCode4 = CASE WHEN LTD_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode4 = CASE WHEN LTD_DedCode IS NOT NULL THEN '1' END
        ,drvMonthlyBenefitAmount4 = FORMAT(CASE WHEN LTD_DedCode IS NOT NULL THEN ((EecAnnSalary * @LTDPct)/ 12) END, '00000000')
        ,drvSalaryMode4 = CASE WHEN LTD_DedCode IS NOT NULL THEN 'A' END
        ,drvSalaryAmount4 = FORMAT(CASE WHEN LTD_DedCode IS NOT NULL THEN EecAnnSalary END * 100, '0000000')
        
        ,drvCoverageCode5 = CASE WHEN STD2_DedCode IS NOT NULL THEN 'AS' END
        ,drvCoverageStartDate5 = CASE WHEN STD2_DedCode IS NOT NULL THEN STD2_BenStartDate END
        ,drvCoverageStopDAte5 = CASE WHEN STD2_DedCode IS NOT NULL THEN STD2_BenStopDate END
        ,drvGroupNumber5 = CASE WHEN STD2_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode5 = CASE WHEN STD2_DedCode IS NOT NULL THEN '0001' END
        ,drvStatusCode5 = CASE WHEN STD2_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode5 = CASE WHEN STD2_DedCode IS NOT NULL THEN '1' END
        ,drvWeeklyBenefitAmount5 = FORMAT(CASE WHEN STD2_DedCode IS NOT NULL THEN ((EecAnnSalary * @LTDPct)/ 52) END, '00000000')
        ,drvSalaryMode5 = CASE WHEN STD2_DedCode IS NOT NULL THEN 'A' END
        ,drvSalaryAmount5 = FORMAT(CASE WHEN STD2_DedCode IS NOT NULL THEN EecAnnSalary END * 100, '0000000')


        ,drvCoverageCode7 = CASE WHEN LIF_DedCode IS NOT NULL THEN 'OP' END
        ,drvCoverageStartDate7 = CASE WHEN LIF_DedCode IS NOT NULL THEN LIF_BenStartDate END
        ,drvCoverageStopDate7 = CASE WHEN LIF_DedCode IS NOT NULL THEN LIF_BenStopDate END
        ,drvGroupNumber7 = CASE WHEN LIF_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode7 = CASE WHEN LIF_DedCode IS NOT NULL THEN '0001' END
        ,drvBranch7 =    CASE WHEN LIF_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN '0001' 
                        WHEN LIF_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN '0002' 
                        END
        ,drvStatusCode7 = CASE WHEN LIF_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode7 = CASE WHEN LIF_DedCode IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmount7 = FORMAT(CASE WHEN LIF_DedCode IS NOT NULL THEN LIF_Amt.EedBenAmt END, '00000000')
        ,drvSalaryMode7 = CASE WHEN LIF_DedCode IS NOT NULL THEN 'A' END
        ,drvSalaryAmount7 = FORMAT(CASE WHEN LIF_DedCode IS NOT NULL THEN EecAnnSalary END * 100, '0000000')


        ,drvCodeCode8 = CASE WHEN LSP_DedCode IS NOT NULL THEN 'LZ' END
        ,drvCoverageStartDate8 = CASE WHEN LSP_DedCode IS NOT NULL THEN LSP_BenStartDate END
        ,drvCoverageStopDate8 = CASE WHEN LSP_DedCode IS NOT NULL THEN LSP_BenStopDate END
        ,drvGroupNumber8 = CASE WHEN LSP_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode8 = CASE WHEN LSP_DedCode IS NOT NULL THEN '0001' END
        ,drvBranch8 =    CASE WHEN LSP_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN '0001' 
                        WHEN LSP_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN '0002' 
                        END
        ,drvStatusCode8 = CASE WHEN LSP_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode8 = CASE WHEN LSP_DedCode IS NOT NULL THEN 'A' END
        ,drvAnnualBenefitAmount8 = FORMAT(CASE WHEN LSP_DedCode IS NOT NULL THEN LSP_Amt.EedBenAmt END, '00000000')


        ,drvCoverageCode9 = CASE WHEN LCH_DedCode IS NOT NULL THEN 'LZ' END
        ,drvCoverageStartDate9 = CASE WHEN LCH_DedCode IS NOT NULL THEN LCH_BenStartDate END
        ,drvCoverageStopDate9 = CASE WHEN LCH_DedCode IS NOT NULL THEN LCH_BenStopDate END
        ,drvGroupNumber9 = CASE WHEN LCH_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode9 = CASE WHEN LCH_DedCode IS NOT NULL THEN '0001' END
        ,drvBranch9 =    CASE WHEN LCH_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN '0001' 
                        WHEN LCH_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN '0002' 
                        END
        ,drvStatusCode9 = CASE WHEN LCH_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode9 = CASE WHEN LCH_DedCode IS NOT NULL THEN 'A' END
        ,drvAnnualBenefitAmount9 = FORMAT(CASE WHEN LCH_DedCode IS NOT NULL THEN LCH_Amt.EedBenAmt END, '00000000')


        ,drvCoverageCode10 = CASE WHEN LIF_DedCode IS NOT NULL THEN 'OD' END
        ,drvCoverageStartDate10 = CASE WHEN LIF_DedCode IS NOT NULL THEN LIF_BenStartDate END
        ,drvCoverageStopDate10 = CASE WHEN LIF_DedCode IS NOT NULL THEN LIF_BenStopDate END
        ,drvGroupNumber10 = CASE WHEN LIF_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode10 = CASE WHEN LIF_DedCode IS NOT NULL THEN '0001' END
        ,drvBranch10 =    CASE WHEN LIF_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN '0001' 
                        WHEN LIF_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN '0002' 
                        END
        ,drvStatusCode10 = CASE WHEN LIF_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode10 = CASE WHEN LIF_DedCode IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmount10 = FORMAT(CASE WHEN LIF_DedCode IS NOT NULL THEN LIF_Amt.EedBenAmt END, '00000000')
        ,drvSalaryMode10 = CASE WHEN LIF_DedCode IS NOT NULL THEN 'A' END
        ,drvSalaryAmount10 = FORMAT(CASE WHEN LIF_DedCode IS NOT NULL THEN EecAnnSalary END * 100, '0000000')


        ,drvCoverageCode11 = CASE WHEN LSP_DedCode IS NOT NULL THEN 'AE' END
        ,drvCoverageStartDate11 = CASE WHEN LSP_DedCode IS NOT NULL THEN LSP_BenStartDate END
        ,drvCoverageStopDate11 = CASE WHEN LSP_DedCode IS NOT NULL THEN LSP_BenStopDate END
        ,drvGroupNumber11 = CASE WHEN LSP_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode11 = CASE WHEN LSP_DedCode IS NOT NULL THEN '0001' END
        ,drvBranch11 =    CASE WHEN LSP_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN '0001' 
                        WHEN LSP_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN '0002' 
                        END
        ,drvStatusCode11 = CASE WHEN LSP_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode11 = CASE WHEN LSP_DedCode IS NOT NULL THEN 'A' END
        ,drvAnnualBenefitAmount11 = FORMAT(CASE WHEN LSP_DedCode IS NOT NULL THEN LSP_Amt.EedBenAmt END, '00000000')

        ,drvCoverageCode12 = CASE WHEN LCH_DedCode IS NOT NULL THEN 'AT' END
        ,drvCoverageStartDate12 = CASE WHEN LCH_DedCode IS NOT NULL THEN LCH_BenStartDate END
        ,drvCoverageStopDate12 = CASE WHEN LCH_DedCode IS NOT NULL THEN LCH_BenStopDate END
        ,drvCoverageGroupNumer12 = CASE WHEN LCH_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode12 = CASE WHEN LCH_DedCode IS NOT NULL THEN '0001' END
        ,drvBranch12 =    CASE WHEN LCH_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN '0001' 
                        WHEN LCH_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN '0002' 
                        END
        ,drvStatusCode12 = CASE WHEN LCH_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode12 = CASE WHEN LCH_DedCode IS NOT NULL THEN 'A' END
        ,drvAnnualBenefitAmount12 = FORMAT(CASE WHEN LSP_DedCode IS NOT NULL THEN LCH_Amt.EedBenAmt END, '00000000')

        ,drvCoverageCode17 = CASE WHEN VISC_DedCode IS NOT NULL OR VISE_DedCode IS NOT NULL THEN 'VV' END
        ,drvCoverageStartDate17 =    CASE WHEN VISC_DedCode IS NOT NULL THEN VISC_BenStartDate
                                    WHEN VISE_DedCode IS NOT NULL THEN VISE_BenStartDate 
                                    END
        ,drvCoverageStopDate17 =    CASE WHEN VISC_DedCode IS NOT NULL THEN VISC_BenStopDate
                                    WHEN VISE_DedCode IS NOT NULL THEN VISE_BenStopDate 
                                    END
        ,drvGroupNumber17 = CASE WHEN VISC_DedCode IS NOT NULL OR VISE_DedCode IS NOT NULL THEN '5391831' END
        ,drvSubCode17 = CASE WHEN VISC_DedCode IS NOT NULL OR VISE_DedCode IS NOT NULL THEN '0003' END
        ,drvBranch17 =    CASE WHEN VISE_DedCode IS NOT NULL AND GLIFE_DedCode IS NOT NULL THEN 'L002' 
                        WHEN VISC_DedCode IS NOT NULL AND GLIF5_DedCode IS NOT NULL THEN 'H001' 
                        END
        ,drvStatusCode17 = CASE WHEN VISC_DedCode IS NOT NULL OR VISE_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode17 =    CASE WHEN VISC_DedCode IS NOT NULL THEN    
                                        CASE WHEN VISC_BenOption = 'EE' THEN '1'
                                        WHEN VISC_BenOption = 'EEF' THEN '4'
                                        WHEN VISC_BenOption = 'EEC' THEN '2'
                                        WHEN VISC_BenOption = 'EES' THEN '3'
                                        END
                                    WHEN VISE_DedCode IS NOT NULL THEN
                                        CASE WHEN VISE_BenOption = 'EE' THEN '1'
                                        WHEN VISE_BenOption = 'EEF' THEN '4'
                                        WHEN VISE_BenOption = 'EEC' THEN '2'
                                        WHEN VISE_BenOption = 'EES' THEN '3'
                                        END
                                    END
    INTO dbo.U_EMETVLTDVE_drvTbl
    FROM dbo.U_EMETVLTDVE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmDepRecID, BdmRecType
            ,MAX(CASE WHEN BdmDedCode = 'ADD2X' THEN BdmDedCode END) AS ADD2x_DedCode    
            ,MAX(CASE WHEN BdmDedCode = 'ADD50' THEN BdmDedCode END) AS ADD50_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'DENC' THEN BdmDedCode END) AS DENC_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'DENH' THEN BdmDedCode END) AS DENH_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'GLIF5' THEN BdmDedCode END) AS GLIF5_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'LCH' THEN BdmDedCode END) AS LCH_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'LIF' THEN BdmDedCode END) AS LIF_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'LSP' THEN BdmDedCode END) AS LSP_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmDedCode END) AS STD2_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'VISC' THEN BdmDedCode END) AS VISC_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'VISE' THEN BdmDedCode END) AS VISE_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'ADD2X' THEN BdmBenStartDate END) AS ADD2x_BenStartDate    
            ,MAX(CASE WHEN BdmDedCode = 'ADD50' THEN BdmBenStartDate END) AS ADD50_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'DENC' THEN BdmBenStartDate END) AS DENC_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'DENH' THEN BdmBenStartDate END) AS DENH_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIF5' THEN BdmBenStartDate END) AS GLIF5_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LCH' THEN BdmBenStartDate END) AS LCH_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LIF' THEN BdmBenStartDate END) AS LIF_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LSP' THEN BdmBenStartDate END) AS LSP_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmBenStartDate END) AS STD2_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'VISC' THEN BdmBenStartDate END) AS VISC_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'VISE' THEN BdmBenStartDate END) AS VISE_BenStartDate

            ,MAX(CASE WHEN BdmDedCode = 'ADD2X' THEN BdmBenStopDate END) AS ADD2x_BenStopDate    
            ,MAX(CASE WHEN BdmDedCode = 'ADD50' THEN BdmBenStopDate END) AS ADD50_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'DENC' THEN BdmBenStopDate END) AS DENC_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'DENH' THEN BdmBenStopDate END) AS DENH_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIF5' THEN BdmBenStopDate END) AS GLIF5_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LCH' THEN BdmBenStopDate END) AS LCH_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LIF' THEN BdmBenStopDate END) AS LIF_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LSP' THEN BdmBenStopDate END) AS LSP_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmBenStopDate END) AS STD2_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'VISC' THEN BdmBenStopDate END) AS VISC_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'VISE' THEN BdmBenStopDate END) AS VISE_BenStopDate

            ,MAX(CASE WHEN BdmDedCode = 'ADD2X' THEN BdmBenOption END) AS ADD2x_BenOption    
            ,MAX(CASE WHEN BdmDedCode = 'ADD50' THEN BdmBenOption END) AS ADD50_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'DENC' THEN BdmBenOption END) AS DENC_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'DENH' THEN BdmBenOption END) AS DENH_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'GLIF5' THEN BdmBenOption END) AS GLIF5_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenOption END) AS GLIFE_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'LCH' THEN BdmBenOption END) AS LCH_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'LIF' THEN BdmBenOption END) AS LIF_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'LSP' THEN BdmBenOption END) AS LSP_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenOption END) AS LTD_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmBenOption END) AS STD2_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'VISC' THEN BdmBenOption END) AS VISC_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'VISE' THEN BdmBenOption END) AS VISE_BenOption

            ,MAX(CASE WHEN BdmDedCode = 'ADD2X' THEN BdmEEAmt END) AS ADD2x_BenAmt    
            ,MAX(CASE WHEN BdmDedCode = 'ADD50' THEN BdmEEAmt END) AS ADD50_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'DENC' THEN BdmEEAmt END) AS DENC_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'DENH' THEN BdmEEAmt END) AS DENH_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'GLIF5' THEN BdmEEAmt END) AS GLIF5_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmEEAmt END) AS GLIFE_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'LCH' THEN BdmEEAmt END) AS LCH_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'LIF' THEN BdmEEAmt END) AS LIF_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'LSP' THEN BdmEEAmt END) AS LSP_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmEEAmt END) AS LTD_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmEEAmt END) AS STD2_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'VISC' THEN BdmEEAmt END) AS VISC_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'VISE' THEN BdmEEAmt END) AS VISE_BenAmt

        FROM dbo.U_dsi_BDM_EMETVLTDVE WITH (NOLOCK)
        GROUP BY BdmEEID, BdmCOID, BdmDepRecID, BdmRecType ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON xEEID = ConEEID
        AND BdmDepRecId = ConSystemId
    LEFT JOIN dbo.EmpDed AS LIF_Amt WITH (NOLOCK)
        ON LIF_Amt.EedEEID = xEEID
        AND LIF_Amt.EedCoID = xCOID
        AND LIF_Amt.EedDedCode = 'LIF'
    LEFT JOIN dbo.EmpDed AS LSP_Amt WITH (NOLOCK)
        ON LSP_Amt.EedEEID = xEEID
        AND LSP_Amt.EedCoID = xCOID
        AND LSP_Amt.EedDedCode = 'LSP'
    LEFT JOIN dbo.EmpDed AS LCH_Amt WITH (NOLOCK)
        ON LCH_Amt.EedEEID = xEEID
        AND LCH_Amt.EedCoID = xCOID
        AND LCH_Amt.EedDedCode = 'LCH'
    
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
ALTER VIEW dbo.dsi_vwEMETVLTDVE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETVLTDVE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETVLTDVE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112311'
       ,expStartPerControl     = '202112311'
       ,expLastEndPerControl   = '202201079'
       ,expEndPerControl       = '202201079'
WHERE expFormatCode = 'EMETVLTDVE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETVLTDVE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMETVLTDVE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMETVLTDVE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMETVLTDVE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMETVLTDVE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMETVLTDVE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMETVLTDVE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMETVLTDVE', 'UseFileName', 'V', 'Y'


-- End ripout