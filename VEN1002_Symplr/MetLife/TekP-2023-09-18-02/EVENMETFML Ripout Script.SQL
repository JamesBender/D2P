/**********************************************************************************

EVENMETFML: Metlife FMLA, STD, LTD Export

FormatCode:     EVENMETFML
Project:        Metlife FMLA, STD, LTD Export
Client ID:      VEN1002
Date/time:      2023-10-23 14:17:58.640
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB02
Database:       ULTIPRO_WPVCR
Web Filename:   VEN1002_0A9J7_EEHISTORY_EVENMETFML_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EVENMETFML_SavePath') IS NOT NULL DROP TABLE dbo.U_EVENMETFML_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EVENMETFML'


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
WHERE FormatCode = 'EVENMETFML'
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
WHERE ExpFormatCode = 'EVENMETFML'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EVENMETFML')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EVENMETFML'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EVENMETFML'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EVENMETFML'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EVENMETFML'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EVENMETFML'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EVENMETFML'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EVENMETFML'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EVENMETFML'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EVENMETFML'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEVENMETFML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVENMETFML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVENMETFML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVENMETFML];
GO
IF OBJECT_ID('U_EVENMETFML_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_Trailer];
GO
IF OBJECT_ID('U_EVENMETFML_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_PEarHist];
GO
IF OBJECT_ID('U_EVENMETFML_Header') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_Header];
GO
IF OBJECT_ID('U_EVENMETFML_File') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_File];
GO
IF OBJECT_ID('U_EVENMETFML_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_EEList];
GO
IF OBJECT_ID('U_EVENMETFML_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_drvTbl];
GO
IF OBJECT_ID('U_EVENMETFML_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_DedList];
GO
IF OBJECT_ID('U_EVENMETFML_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_AuditFields];
GO
IF OBJECT_ID('U_EVENMETFML_Audit') IS NOT NULL DROP TABLE [dbo].[U_EVENMETFML_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EVENMETFML') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EVENMETFML];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EVENMETFML','Metlife FMLA, STD, LTD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EVENMETFMLZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENMETFMLZ0','1','H','01','1',NULL,'Record Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENMETFMLZ0','7','H','01','2',NULL,'UIS Customer Number',NULL,NULL,'"drvUISCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENMETFMLZ0','8','H','01','9',NULL,'Date File Created',NULL,NULL,'"drvFileDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENMETFMLZ0','50','H','01','17',NULL,'Employer Name',NULL,NULL,'"drvEmployerName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENMETFMLZ0','1','H','01','67',NULL,'Changes Only Indicator',NULL,NULL,'"drvChangesOnlyInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENMETFMLZ0','1','D','10','1',NULL,'Record Type',NULL,NULL,'"E"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENMETFMLZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENMETFMLZ0','11','D','10','9',NULL,'[Employee] Social Security Number',NULL,NULL,'"drvEmpSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENMETFMLZ0','9','D','10','20',NULL,'Personnel ID',NULL,NULL,'"drvPersonnelID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENMETFMLZ0','13','D','10','29',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVENMETFMLZ0','1','D','10','42',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVENMETFMLZ0','20','D','10','43',NULL,'[Employee] Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVENMETFMLZ0','12','D','10','63',NULL,'[Employee] First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVENMETFMLZ0','1','D','10','75',NULL,'[Employee] Middle Initial',NULL,NULL,'"drvMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EVENMETFMLZ0','8','D','10','76',NULL,'[Employee] Birth Date',NULL,NULL,'"drvDateofBirth"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EVENMETFMLZ0','1','D','10','84',NULL,'[Employee] Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EVENMETFMLZ0','1','D','10','85',NULL,'[Employee] Sex',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EVENMETFMLZ0','8','D','10','86',NULL,'[Employee''s] Employment Date',NULL,NULL,'"drvDateofLastHire"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EVENMETFMLZ0','8','D','10','94',NULL,'Pension Eligibility Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EVENMETFMLZ0','10','D','10','102',NULL,'[Employee] Home Phone Number',NULL,NULL,'"drvEmpHomePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EVENMETFMLZ0','1','D','10','112',NULL,'Foreign Address Indicator',NULL,NULL,'"drvForeignAddressIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EVENMETFMLZ0','32','D','10','113',NULL,'[Employee] Mailing Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EVENMETFMLZ0','32','D','10','145',NULL,'[Employee] Mailing Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EVENMETFMLZ0','21','D','10','177',NULL,'[Employee] Mailing Address -City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EVENMETFMLZ0','2','D','10','198',NULL,'[Employee] Mailing Address -State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EVENMETFMLZ0','9','D','10','200',NULL,'[Employee] Mailing Address -Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EVENMETFMLZ0','2','D','10','209',NULL,'[Employee] Work State',NULL,NULL,'"drvWorkState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EVENMETFMLZ0','12','D','10','211',NULL,'Location Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EVENMETFMLZ0','1','D','10','223',NULL,'Foreign Language Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EVENMETFMLZ0','1','D','10','224',NULL,'Federal Marital Tax Code',NULL,NULL,'"drvFederalMaritalTaxCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EVENMETFMLZ0','2','D','10','225',NULL,'Number of Federal Exemptions',NULL,NULL,'"drvNumberofFedExemptions"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EVENMETFMLZ0','1','D','10','227',NULL,'[Work] Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EVENMETFMLZ0','8','D','10','228',NULL,'[Work] Status as of Date',NULL,NULL,'"drvStatusasofDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EVENMETFMLZ0','9','D','10','236',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EVENMETFMLZ0','1','D','10','245',NULL,'MD',NULL,NULL,'"drvMD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EVENMETFMLZ0','8','D','10','246',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectiveDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EVENMETFMLZ0','3','D','10','254',NULL,'Weekly Scheduled Work Hours',NULL,NULL,'"drvWeeklySchWorkHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EVENMETFMLZ0','2','D','10','257',NULL,'Wrk Wk Schedule',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EVENMETFMLZ0','44','D','10','259',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EVENMETFMLZ0','2','D','10','303',NULL,'STD Coverage',NULL,NULL,'"drvSTDCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EVENMETFMLZ0','8','D','10','305',NULL,'STD Coverage Start Date',NULL,NULL,'"drvSTDCoverageStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EVENMETFMLZ0','8','D','10','313',NULL,'STD Coverage Stop Date',NULL,NULL,'"drvSTDCoverageStopDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EVENMETFMLZ0','7','D','10','321',NULL,'STD Report Number',NULL,NULL,'"drvSTDReportNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EVENMETFMLZ0','4','D','10','328',NULL,'STD SubCode',NULL,NULL,'"drvSTDSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EVENMETFMLZ0','4','D','10','332',NULL,'STD SubPoint',NULL,NULL,'"drvSTDSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EVENMETFMLZ0','2','D','10','336',NULL,'STD Plan code',NULL,NULL,'"drvSTDPlancode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EVENMETFMLZ0','8','D','10','338',NULL,'STD Flat Benefit Amount',NULL,NULL,'"drvSTDFlatBenefitAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EVENMETFMLZ0','1','D','10','346',NULL,'STD Contributory Plan Indicator',NULL,NULL,'"drvSTDContribPlanIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EVENMETFMLZ0','3','D','10','347',NULL,'STD Contributory Plan Percentage',NULL,NULL,'"drvSTDContribPlanPercentage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EVENMETFMLZ0','3','D','10','350',NULL,'STD Contributory Pre-tax Percentage',NULL,NULL,'"drvSTDContribPretaxPercentage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EVENMETFMLZ0','2','D','10','353',NULL,'LTD Coverage',NULL,NULL,'"drvLTDCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EVENMETFMLZ0','8','D','10','355',NULL,'LTD Coverage Start Date',NULL,NULL,'"drvLTDCoverageStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EVENMETFMLZ0','8','D','10','363',NULL,'LTD Coverage Stop Date',NULL,NULL,'"drvLTDCoverageStopDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EVENMETFMLZ0','7','D','10','371',NULL,'LTD Report Number',NULL,NULL,'"drvLTDReportNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EVENMETFMLZ0','4','D','10','378',NULL,'LTD SubCode',NULL,NULL,'"drvLTDSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EVENMETFMLZ0','4','D','10','382',NULL,'LTD SubPoint',NULL,NULL,'"drvLTDSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EVENMETFMLZ0','2','D','10','386',NULL,'LTD Plan code',NULL,NULL,'"drvLTDPlancode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EVENMETFMLZ0','8','D','10','388',NULL,'LTD Salary',NULL,NULL,'"drvLTDSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EVENMETFMLZ0','1','D','10','396',NULL,'LTD Contributory Plan Indicator',NULL,NULL,'"drvLTDContribPlanIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EVENMETFMLZ0','3','D','10','397',NULL,'LTD Contributory Plan Percentage',NULL,NULL,'"drvLTDContribPlanPercentage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EVENMETFMLZ0','3','D','10','400',NULL,'LTD Contributory Pre-tax Percentage',NULL,NULL,'"drvLTDContribPretaxPercentage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EVENMETFMLZ0','2','D','10','403',NULL,'NY PFL Coverage',NULL,NULL,'"drvNYPFLCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EVENMETFMLZ0','8','D','10','405',NULL,'NY PFL Coverage Start Date',NULL,NULL,'"drvNYPFLCoverageStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EVENMETFMLZ0','8','D','10','413',NULL,'NY PFL Coverage Stop Date',NULL,NULL,'"drvNYPFLCoverageStopDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EVENMETFMLZ0','7','D','10','421',NULL,'NY PFL Report Number',NULL,NULL,'"drvPFLReportNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EVENMETFMLZ0','4','D','10','428',NULL,'NY PFL SubCode',NULL,NULL,'"drvPFLSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EVENMETFMLZ0','4','D','10','432',NULL,'NY PFL SubPoint',NULL,NULL,'"drvPFLSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EVENMETFMLZ0','2','D','10','436',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EVENMETFMLZ0','1','D','10','438',NULL,'Job Status Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EVENMETFMLZ0','8','D','10','439',NULL,'Job Status (full time/part time) As of Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EVENMETFMLZ0','1','D','10','447',NULL,'Variable Work Schedule Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EVENMETFMLZ0','2','D','10','448',NULL,'Work Hours Per Day',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EVENMETFMLZ0','4','D','10','450',NULL,'Hours Worked in Past 12 Months',NULL,NULL,'"drvHoursWorkedinPast12mths"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EVENMETFMLZ0','8','D','10','454',NULL,'Hours Worked in Past 12 Months Start Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EVENMETFMLZ0','8','D','10','462',NULL,'Total Hrs Wkd in Prior12 Mos End Dt',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EVENMETFMLZ0','1','D','10','470',NULL,'Temp to Permanent indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EVENMETFMLZ0','8','D','10','471',NULL,'Permanent Start Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EVENMETFMLZ0','2','D','10','479',NULL,'Paid Family Leave Coverage Code',NULL,NULL,'"drvPaidFamilyLeaveCovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EVENMETFMLZ0','8','D','10','481',NULL,'Paid Family Leave Coverage Start Date',NULL,NULL,'"drvPaidFamilyLeaveStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EVENMETFMLZ0','8','D','10','489',NULL,'Paid Family LeaveCoverage Stop Date',NULL,NULL,'"drvPaidFamilyLeaveStopDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EVENMETFMLZ0','7','D','10','497',NULL,'Paid Family Leave Report Number',NULL,NULL,'"drvPaidFamilyLeaveReportNumb"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EVENMETFMLZ0','4','D','10','504',NULL,'Paid Family Leave SubCode',NULL,NULL,'"drvPaidFamilyLeaveSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EVENMETFMLZ0','4','D','10','508',NULL,'Paid Family Leave SubPoint',NULL,NULL,'"drvPaidFamilyLeaveSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EVENMETFMLZ0','2','D','10','512',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EVENMETFMLZ0','2','D','10','514',NULL,'Paid Medical Leave Coverage Code',NULL,NULL,'"drvPaidMedicalLeaveCovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EVENMETFMLZ0','8','D','10','516',NULL,'Paid Medical Leave Coverage Start Date',NULL,NULL,'"drvPaidMedicalLeaveStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EVENMETFMLZ0','8','D','10','524',NULL,'Paid Medical LeaveCoverage Stop Date',NULL,NULL,'"drvPaidMedicalLeaveStopDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EVENMETFMLZ0','7','D','10','532',NULL,'Paid Medical Leave Report Number',NULL,NULL,'"drvPaidMedicalLeaveReportNumb"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EVENMETFMLZ0','4','D','10','539',NULL,'Paid Medical Leave SubCode',NULL,NULL,'"drvPaidMedicalLeaveSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EVENMETFMLZ0','4','D','10','543',NULL,'Paid Medical Leave SubPoint',NULL,NULL,'"drvPaidMedicalLeaveSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EVENMETFMLZ0','5','D','10','547',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EVENMETFMLZ0','2','D','10','552',NULL,'Absence Management Coverage',NULL,NULL,'"drvAbsenceMngmtCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EVENMETFMLZ0','8','D','10','554',NULL,'Absence Management Coverage Start Date',NULL,NULL,'"drvAbsenceMngmtStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EVENMETFMLZ0','8','D','10','562',NULL,'Absence Management Coverage Stop Date (Administrat',NULL,NULL,'"drvAbsenceMngmtStopDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EVENMETFMLZ0','7','D','10','570',NULL,'Absence Management Report Number (Group Number)',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EVENMETFMLZ0','4','D','10','577',NULL,'Absence Management SubCode (Subdivision)',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EVENMETFMLZ0','4','D','10','581',NULL,'Absence Management SubPoint (Branch)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EVENMETFMLZ0','2','D','10','585',NULL,'Absence Management Plan code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EVENMETFMLZ0','14','D','10','587',NULL,'Unique File ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EVENMETFMLZ0','8','D','10','601',NULL,'Employee Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EVENMETFMLZ0','8','D','10','609',NULL,'Seniority Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EVENMETFMLZ0','8','D','10','617',NULL,'Temp Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EVENMETFMLZ0','1','D','10','625',NULL,'Regular/Temporary',NULL,NULL,'"drvRegOrTemp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EVENMETFMLZ0','1','D','10','626',NULL,'FLSA Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EVENMETFMLZ0','1','D','10','627',NULL,'Salaried/Hourly',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EVENMETFMLZ0','1','D','10','628',NULL,'Union\NonUnion',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EVENMETFMLZ0','10','D','10','629',NULL,'Union Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EVENMETFMLZ0','10','D','10','639',NULL,'Collective Bargaining Group Identifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EVENMETFMLZ0','1','D','10','649',NULL,'Mgmt/Occupational/Executive',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EVENMETFMLZ0','32','D','10','650',NULL,'[Employee Work] Mailing Address 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EVENMETFMLZ0','32','D','10','682',NULL,'[Employee Work] Mailing Address 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EVENMETFMLZ0','21','D','10','714',NULL,'[Employee Work] Mailing Address -City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EVENMETFMLZ0','2','D','10','735',NULL,'[Employee Work] Mailing Address -State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EVENMETFMLZ0','9','D','10','737',NULL,'[Employee Work] Mailing Address -Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EVENMETFMLZ0','10','D','10','746',NULL,'[Employee Work] Phone Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EVENMETFMLZ0','11','D','10','756',NULL,'[Employee Work] Fax Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EVENMETFMLZ0','1','D','10','767',NULL,'Key Employee Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EVENMETFMLZ0','1','D','10','768',NULL,'FMLA Eligibility Flag',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EVENMETFMLZ0','8','D','10','769',NULL,'FMLA Eligibility Flag as of Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EVENMETFMLZ0','40','D','10','777',NULL,'Employee Work E-mail Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EVENMETFMLZ0','40','D','10','817',NULL,'Employee Alternate E-mail Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EVENMETFMLZ0','3','D','10','857',NULL,'Benefit Months',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EVENMETFMLZ0','8','D','10','860',NULL,'Benefit Months As Of Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EVENMETFMLZ0','8','D','10','868',NULL,'Fixed Date for FMLA exhaustion Method',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EVENMETFMLZ0','3','D','10','876',NULL,'Actual Weekly Hours Worked',NULL,NULL,'"drvActualWklyHrsWked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EVENMETFMLZ0','50','D','10','879',NULL,'Employee Job Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EVENMETFMLZ0','1','D','10','929',NULL,'Leave Program Indicator 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EVENMETFMLZ0','1','D','10','930',NULL,'Leave Program Indicator 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EVENMETFMLZ0','1','D','10','931',NULL,'Leave Program Indicator 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EVENMETFMLZ0','1','D','10','932',NULL,'Leave Program Indicator 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EVENMETFMLZ0','1','D','10','933',NULL,'Leave Program Indicator 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EVENMETFMLZ0','8','D','10','934',NULL,'Termination Date 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EVENMETFMLZ0','8','D','10','942',NULL,'Termination Date 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EVENMETFMLZ0','8','D','10','950',NULL,'Termination Date 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EVENMETFMLZ0','8','D','10','958',NULL,'Termination Date 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EVENMETFMLZ0','8','D','10','966',NULL,'Termination Date 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EVENMETFMLZ0','8','D','10','974',NULL,'Re-Hire Date 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EVENMETFMLZ0','8','D','10','982',NULL,'Re-Hire Date 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EVENMETFMLZ0','8','D','10','990',NULL,'Re-Hire Date 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EVENMETFMLZ0','8','D','10','998',NULL,'Re-Hire Date 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EVENMETFMLZ0','8','D','10','1006',NULL,'Re-Hire Date 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EVENMETFMLZ0','6','D','10','1014',NULL,'Holiday Schedule',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EVENMETFMLZ0','4','D','10','1020',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EVENMETFMLZ0','10','D','10','1024',NULL,'Shift \ Schedule designation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EVENMETFMLZ0','4','D','10','1034',NULL,'Monday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EVENMETFMLZ0','4','D','10','1038',NULL,'Tuesday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EVENMETFMLZ0','4','D','10','1042',NULL,'Wednesday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EVENMETFMLZ0','4','D','10','1046',NULL,'Thursday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EVENMETFMLZ0','4','D','10','1050',NULL,'Friday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EVENMETFMLZ0','4','D','10','1054',NULL,'Saturday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EVENMETFMLZ0','4','D','10','1058',NULL,'Sunday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EVENMETFMLZ0','9','D','10','1062',NULL,'Leave\Absence 1 Approver ID (Email / Web Access 1)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EVENMETFMLZ0','31','D','10','1071',NULL,'Leave\Absence 1 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EVENMETFMLZ0','40','D','10','1102',NULL,'Leave\Absence 1 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EVENMETFMLZ0','2','D','10','1142',NULL,'Leave\Absence 1 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EVENMETFMLZ0','9','D','10','1144',NULL,'Leave\Absence 2 Approver ID (Email / Web Access 2)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EVENMETFMLZ0','31','D','10','1153',NULL,'Leave\Absence 2 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EVENMETFMLZ0','40','D','10','1184',NULL,'Leave\Absence 2 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EVENMETFMLZ0','2','D','10','1224',NULL,'Leave\Absence 2 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EVENMETFMLZ0','9','D','10','1226',NULL,'Leave\Absence 3 Approver ID (Email / Web Access 3)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EVENMETFMLZ0','31','D','10','1235',NULL,'Leave\Absence 3 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EVENMETFMLZ0','40','D','10','1266',NULL,'Leave\Absence 3 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EVENMETFMLZ0','2','D','10','1306',NULL,'Leave\Absence 3 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EVENMETFMLZ0','20','D','10','1308',NULL,'Leave\Absence 4 Approver ID (Email / Web Access 4)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EVENMETFMLZ0','20','D','10','1328',NULL,'Leave\Absence 4 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EVENMETFMLZ0','40','D','10','1348',NULL,'Leave\Absence 4 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EVENMETFMLZ0','2','D','10','1388',NULL,'Leave\Absence 4 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EVENMETFMLZ0','20','D','10','1390',NULL,'Leave\Absence 5 Approver ID (Email / Web Access 5)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EVENMETFMLZ0','20','D','10','1410',NULL,'Leave\Absence 5 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EVENMETFMLZ0','40','D','10','1430',NULL,'Leave\Absence 5 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EVENMETFMLZ0','2','D','10','1470',NULL,'Leave\Absence 5 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EVENMETFMLZ0','20','D','10','1472',NULL,'Leave\Absence 6 Approver ID (Email / Web Access 6)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EVENMETFMLZ0','20','D','10','1492',NULL,'Leave\Absence 6 Alt ApproverID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EVENMETFMLZ0','40','D','10','1512',NULL,'Leave\Absence 6 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EVENMETFMLZ0','2','D','10','1552',NULL,'Leave\Absence 6 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EVENMETFMLZ0','20','D','10','1554',NULL,'Leave\Absence 7 Approver ID (Email / Web Access 7)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EVENMETFMLZ0','20','D','10','1574',NULL,'Leave\Absence 7 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EVENMETFMLZ0','40','D','10','1594',NULL,'Leave\Absence 7 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EVENMETFMLZ0','2','D','10','1634',NULL,'Leave\Absence 7 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EVENMETFMLZ0','20','D','10','1636',NULL,'Leave\Absence 8 Approver ID (Email / Web Access 8)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EVENMETFMLZ0','20','D','10','1656',NULL,'Leave\Absence 8 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EVENMETFMLZ0','40','D','10','1676',NULL,'Leave\Absence 8 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EVENMETFMLZ0','2','D','10','1716',NULL,'Leave\Absence 8 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EVENMETFMLZ0','20','D','10','1718',NULL,'Leave\Absence 9 Approver ID (Email / Web Access 9)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EVENMETFMLZ0','20','D','10','1738',NULL,'Leave\Absence 9 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EVENMETFMLZ0','40','D','10','1758',NULL,'Leave\Absence 9 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EVENMETFMLZ0','2','D','10','1798',NULL,'Leave\Absence 9 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EVENMETFMLZ0','20','D','10','1800',NULL,'Leave\Absence 10 Approver ID (Email / Web Access 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EVENMETFMLZ0','20','D','10','1820',NULL,'Leave\Absence 10 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EVENMETFMLZ0','40','D','10','1840',NULL,'Leave\Absence 10 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EVENMETFMLZ0','2','D','10','1880',NULL,'Leave\Absence 10 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EVENMETFMLZ0','1','D','10','1882',NULL,'AccrualFunction1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EVENMETFMLZ0','10','D','10','1883',NULL,'AccrualAmount1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EVENMETFMLZ0','8','D','10','1893',NULL,'AccrualDate1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EVENMETFMLZ0','1','D','10','1901',NULL,'AccrualFunction2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EVENMETFMLZ0','10','D','10','1902',NULL,'AccrualAmount2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EVENMETFMLZ0','8','D','10','1912',NULL,'AccrualDate2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EVENMETFMLZ0','1','D','10','1920',NULL,'AccrualFunction3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EVENMETFMLZ0','10','D','10','1921',NULL,'AccrualAmount3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EVENMETFMLZ0','8','D','10','1931',NULL,'AccrualDate3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EVENMETFMLZ0','1','D','10','1939',NULL,'AccrualFunction4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EVENMETFMLZ0','10','D','10','1940',NULL,'AccrualAmount4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EVENMETFMLZ0','8','D','10','1950',NULL,'AccrualDate4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EVENMETFMLZ0','1','D','10','1958',NULL,'AccrualFunction5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EVENMETFMLZ0','10','D','10','1959',NULL,'AccrualAmount5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EVENMETFMLZ0','8','D','10','1969',NULL,'AccrualDate5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EVENMETFMLZ0','1','D','10','1977',NULL,'AccrualFunction6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EVENMETFMLZ0','10','D','10','1978',NULL,'AccrualAmount6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EVENMETFMLZ0','8','D','10','1988',NULL,'AccrualDate6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EVENMETFMLZ0','1','D','10','1996',NULL,'AccrualFunction7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EVENMETFMLZ0','10','D','10','1997',NULL,'AccrualAmount7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EVENMETFMLZ0','8','D','10','2007',NULL,'AccrualDate7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EVENMETFMLZ0','1','D','10','2015',NULL,'AccrualFunction8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EVENMETFMLZ0','10','D','10','2016',NULL,'AccrualAmount8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EVENMETFMLZ0','8','D','10','2026',NULL,'AccrualDate8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EVENMETFMLZ0','1','D','10','2034',NULL,'AccrualFunction9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EVENMETFMLZ0','10','D','10','2035',NULL,'AccrualAmount9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EVENMETFMLZ0','8','D','10','2045',NULL,'AccrualDate9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EVENMETFMLZ0','1','D','10','2053',NULL,'AccrualFunction10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EVENMETFMLZ0','10','D','10','2054',NULL,'AccrualAmount10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EVENMETFMLZ0','8','D','10','2064',NULL,'AccrualDate10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EVENMETFMLZ0','1','D','10','2072',NULL,'AccrualFunction11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EVENMETFMLZ0','10','D','10','2073',NULL,'AccrualAmount11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EVENMETFMLZ0','8','D','10','2083',NULL,'AccrualDate11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EVENMETFMLZ0','1','D','10','2091',NULL,'AccrualFunction12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EVENMETFMLZ0','10','D','10','2092',NULL,'AccrualAmount12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EVENMETFMLZ0','8','D','10','2102',NULL,'AccrualDate12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EVENMETFMLZ0','1','D','10','2110',NULL,'AccrualFunction13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EVENMETFMLZ0','10','D','10','2111',NULL,'AccrualAmount13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EVENMETFMLZ0','8','D','10','2121',NULL,'AccrualDate13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EVENMETFMLZ0','1','D','10','2129',NULL,'AccrualFunction14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EVENMETFMLZ0','10','D','10','2130',NULL,'AccrualAmount14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EVENMETFMLZ0','8','D','10','2140',NULL,'AccrualDate14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EVENMETFMLZ0','1','D','10','2148',NULL,'AccrualFunction15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EVENMETFMLZ0','10','D','10','2149',NULL,'AccrualAmount15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EVENMETFMLZ0','8','D','10','2159',NULL,'AccrualDate15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EVENMETFMLZ0','1','D','10','2167',NULL,'AccrualFunction16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EVENMETFMLZ0','10','D','10','2168',NULL,'AccrualAmount16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EVENMETFMLZ0','8','D','10','2178',NULL,'AccrualDate16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EVENMETFMLZ0','1','D','10','2186',NULL,'AccrualFunction17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EVENMETFMLZ0','10','D','10','2187',NULL,'AccrualAmount17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EVENMETFMLZ0','8','D','10','2197',NULL,'AccrualDate17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EVENMETFMLZ0','1','D','10','2205',NULL,'AccrualFunction18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EVENMETFMLZ0','10','D','10','2206',NULL,'AccrualAmount18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EVENMETFMLZ0','8','D','10','2216',NULL,'AccrualDate18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EVENMETFMLZ0','1','D','10','2224',NULL,'AccrualFunction19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EVENMETFMLZ0','10','D','10','2225',NULL,'AccrualAmount19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EVENMETFMLZ0','8','D','10','2235',NULL,'AccrualDate19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EVENMETFMLZ0','1','D','10','2243',NULL,'AccrualFunction20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EVENMETFMLZ0','10','D','10','2244',NULL,'AccrualAmount20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EVENMETFMLZ0','8','D','10','2254',NULL,'AccrualDate20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EVENMETFMLZ0','40','D','10','2262',NULL,'Customer Defined Field 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EVENMETFMLZ0','40','D','10','2302',NULL,'Customer Defined Field 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EVENMETFMLZ0','40','D','10','2342',NULL,'Customer Defined Field 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EVENMETFMLZ0','40','D','10','2382',NULL,'Customer Defined Field 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EVENMETFMLZ0','40','D','10','2422',NULL,'Customer Defined Field 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EVENMETFMLZ0','7','D','10','2462',NULL,'ADA Group number*',NULL,NULL,'"drvADAGroupNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EVENMETFMLZ0','4','D','10','2469',NULL,'ADA Subcode*',NULL,NULL,'"drvADASubcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EVENMETFMLZ0','4','D','10','2473',NULL,'ADA Branch*',NULL,NULL,'"drvADABranch"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENMETFMLZ0','1','T','90','1',NULL,'Record Type',NULL,NULL,'"Z"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENMETFMLZ0','7','T','90','2',NULL,'UIS Customer Number',NULL,NULL,'"trvUISCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENMETFMLZ0','8','T','90','9',NULL,'Total Record Count',NULL,NULL,'"trvTotalRecordCount"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EVENMETFML_20231023.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Metlife FMLA, STD, LTD Export','202310239','EMPEXPORT','ONDEM_XOE',NULL,'EVENMETFML',NULL,NULL,NULL,'202310239','Oct 23 2023  2:03PM','Oct 23 2023  2:03PM','202310231',NULL,'','','202310231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Metlife FMLA, STD, LTD E-Sched','202310239','EMPEXPORT','SCH_EVENME',NULL,'EVENMETFML',NULL,NULL,NULL,'202310239','Oct 23 2023  2:03PM','Oct 23 2023  2:03PM','202310231',NULL,'','','202310231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Metlife FMLA, STD, LTD E-Test','202310239','EMPEXPORT','TEST_XOE',NULL,'EVENMETFML',NULL,NULL,NULL,'202310239','Oct 23 2023  2:03PM','Oct 23 2023  2:03PM','202310231',NULL,'','','202310231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENMETFML','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENMETFML','H01','dbo.U_EVENMETFML_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENMETFML','D10','dbo.U_EVENMETFML_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENMETFML','T90','dbo.U_EVENMETFML_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EVENMETFML
-----------

IF OBJECT_ID('U_dsi_BDM_EVENMETFML') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EVENMETFML] (
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
-- Create table U_EVENMETFML_Audit
-----------

IF OBJECT_ID('U_EVENMETFML_Audit') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_EVENMETFML_AuditFields
-----------

IF OBJECT_ID('U_EVENMETFML_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EVENMETFML_DedList
-----------

IF OBJECT_ID('U_EVENMETFML_DedList') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EVENMETFML_drvTbl
-----------

IF OBJECT_ID('U_EVENMETFML_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvEmpSSN] varchar(13) NULL,
    [drvPersonnelID] char(9) NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvDateofBirth] varchar(8000) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateofLastHire] datetime NULL,
    [drvEmpHomePhone] varchar(50) NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvWorkState] varchar(2) NULL,
    [drvFederalMaritalTaxCode] varchar(1) NULL,
    [drvNumberofFedExemptions] varchar(1) NOT NULL,
    [drvStatusCode] char(1) NULL,
    [drvStatusasofDate] varchar(8000) NULL,
    [drvSalaryAmount] nvarchar(4000) NULL,
    [drvMD] varchar(1) NOT NULL,
    [drvSalaryEffectiveDate] varchar(8000) NULL,
    [drvWeeklySchWorkHours] nvarchar(4000) NULL,
    [drvSTDCoverage] varchar(2) NULL,
    [drvSTDCoverageStartDate] varchar(8000) NULL,
    [drvSTDCoverageStopDate] varchar(8000) NULL,
    [drvSTDReportNumber] varchar(7) NULL,
    [drvSTDSubCode] varchar(4) NULL,
    [drvSTDSubPoint] varchar(4) NULL,
    [drvSTDPlancode] varchar(1) NOT NULL,
    [drvSTDFlatBenefitAmount] varchar(1) NOT NULL,
    [drvSTDContribPlanIndicator] varchar(1) NULL,
    [drvSTDContribPlanPercentage] varchar(3) NULL,
    [drvSTDContribPretaxPercentage] varchar(3) NULL,
    [drvLTDCoverage] varchar(2) NULL,
    [drvLTDCoverageStartDate] varchar(8000) NULL,
    [drvLTDCoverageStopDate] varchar(8000) NULL,
    [drvLTDReportNumber] varchar(7) NULL,
    [drvLTDSubCode] varchar(4) NULL,
    [drvLTDSubPoint] varchar(4) NULL,
    [drvLTDPlancode] varchar(1) NOT NULL,
    [drvLTDSalary] nvarchar(4000) NULL,
    [drvLTDContribPlanIndicator] varchar(1) NULL,
    [drvLTDContribPlanPercentage] varchar(3) NULL,
    [drvLTDContribPretaxPercentage] varchar(3) NULL,
    [drvNYPFLCoverage] varchar(2) NULL,
    [drvNYPFLCoverageStartDate] varchar(8000) NULL,
    [drvNYPFLCoverageStopDate] varchar(8000) NULL,
    [drvPFLReportNumber] varchar(7) NULL,
    [drvPFLSubCode] varchar(4) NULL,
    [drvPFLSubPoint] varchar(4) NULL,
    [drvHoursWorkedinPast12mths] nvarchar(4000) NULL,
    [drvPaidFamilyLeaveCovCode] varchar(2) NULL,
    [drvPaidFamilyLeaveStartDate] varchar(8000) NULL,
    [drvPaidFamilyLeaveStopDate] varchar(8000) NULL,
    [drvPaidFamilyLeaveReportNumb] varchar(7) NULL,
    [drvPaidFamilyLeaveSubCode] varchar(4) NULL,
    [drvPaidFamilyLeaveSubPoint] varchar(4) NULL,
    [drvPaidMedicalLeaveCovCode] varchar(2) NULL,
    [drvPaidMedicalLeaveStartDate] varchar(8000) NULL,
    [drvPaidMedicalLeaveStopDate] varchar(8000) NULL,
    [drvPaidMedicalLeaveReportNumb] varchar(7) NULL,
    [drvPaidMedicalLeaveSubCode] varchar(4) NULL,
    [drvPaidMedicalLeaveSubPoint] varchar(4) NULL,
    [drvAbsenceMngmtCoverage] varchar(2) NOT NULL,
    [drvAbsenceMngmtStartDate] varchar(8000) NULL,
    [drvAbsenceMngmtStopDate] nvarchar(4000) NULL,
    [drvOriginalHireDate] varchar(8000) NULL,
    [drvRegOrTemp] varchar(1) NULL,
    [drvActualWklyHrsWked] nvarchar(4000) NULL,
    [drvADAGroupNumber] varchar(7) NOT NULL,
    [drvADASubcode] varchar(4) NOT NULL,
    [drvADABranch] varchar(4) NOT NULL
);

-----------
-- Create table U_EVENMETFML_EEList
-----------

IF OBJECT_ID('U_EVENMETFML_EEList') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EVENMETFML_File
-----------

IF OBJECT_ID('U_EVENMETFML_File') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);

-----------
-- Create table U_EVENMETFML_Header
-----------

IF OBJECT_ID('U_EVENMETFML_Header') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_Header] (
    [drvUISCustomerNumber] varchar(7) NOT NULL,
    [drvFileDate] varchar(8000) NULL,
    [drvEmployerName] varchar(45) NOT NULL,
    [drvChangesOnlyInd] varchar(1) NOT NULL
);

-----------
-- Create table U_EVENMETFML_PEarHist
-----------

IF OBJECT_ID('U_EVENMETFML_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL
);

-----------
-- Create table U_EVENMETFML_Trailer
-----------

IF OBJECT_ID('U_EVENMETFML_Trailer') IS NULL
CREATE TABLE [dbo].[U_EVENMETFML_Trailer] (
    [trvUISCustomerNumber] varchar(7) NOT NULL,
    [trvTotalRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVENMETFML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Add a comment

Created By: Marie Waters
Business Analyst: Linda Noonan
Create Date: 10/23/2023
Service Request Number: TekP-2023-09-18-02

Purpose: Metlife FMLA, STD, LTD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVENMETFML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVENMETFML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVENMETFML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVENMETFML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVENMETFML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENMETFML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENMETFML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENMETFML', 'SCH_EVENME';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVENMETFML';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EVENMETFML', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EVENMETFML';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = '01/01/2024'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EVENMETFML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVENMETFML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EVENMETFML_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_AuditFields;
    CREATE TABLE dbo.U_EVENMETFML_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EVENMETFML_AuditFields VALUES ('Empcomp','eecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EVENMETFML_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EVENMETFML_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EVENMETFML_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EVENMETFML_Audit ON dbo.U_EVENMETFML_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EVENMETFML_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EVENMETFML_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
     SET @DedList = 'LTD,STD';

    IF OBJECT_ID('U_EVENMETFML_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVENMETFML_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStartDates', 'N')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStopDates', 'N')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays', '30')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '30')

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EVENMETFML_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs            = SUM(CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurHrs ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @Last52WeekPerControl and ErnIsRegularPayCode = 'Y' THEN PehCurHrs ELSE 0.00 END)

        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
    INTO dbo.U_EVENMETFML_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE PrgPayDate BETWEEN DATEADD(YY,-1,@EndDate) AND @EndDate
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EVENMETFML_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVENMETFML_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_drvTbl;
       SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvCustomerNumber = '0254347'
        ,drvEmpSSN = '00'+ eepSSN
        ,drvPersonnelID = EecEmpNo
        ,drvRelationshipCode = ''
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvDateofBirth = REPLACE(CONVERT (CHAR(10),EepDateOfBirth, 101),'/','')
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus in ('M','S') THEN eepMaritalStatus ELSE 'U' END
        ,drvGender = CASE WHEN EepGender in ('F','M') THEN EepGender else 'U' END
        ,drvDateofLastHire = EecDateOfLastHire
        ,drvEmpHomePhone = EepPhoneHomeNumber
        ,drvForeignAddressIndicator = CASE WHEN EepAddressCountry <> 'USA' then 'F' Else 'D' END
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvWorkState = LEFT(EecStateSUI,2)
        ,drvFederalMaritalTaxCode = Case    WHEN EetTaxCode = 'USFIT' AND EetFilingStatus in('M') THEN 'M'
                                            WHEN EetTaxCode = 'USFIT' AND EetFilingStatus in ('S') THEN 'S'
                                            WHEN EetTaxCode = 'USFIT' and EetExemptFromTax = 'Y' THEN 'E'
                                            END

        ,drvNumberofFedExemptions = ''
        ,drvStatusCode = Case WHEN EecEmplStatus in ('A','T') THEN EecEmplStatus 
                            --  WHEN EecEmplStatus in ('L') THEN 'P'
                             END
        ,drvStatusasofDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN EecDateOfTermination
                                  WHEN eecemplstatus = 'A' THEN EecDateOfLastHire
                                 -- WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                 ELSE EecEmplStatusStartDate
                                END, 101),'/','')
        ,drvSalaryAmount = FORMAT((EecAnnSalary*100), '000000000')
        ,drvMD = 'Y'
        ,drvSalaryEffectiveDate = REPLACE(CONVERT (CHAR(10),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate (EecEEID, EecCOID, GetDate(),EecDateOfLastHire), 101),'/','')
        ,drvWeeklySchWorkHours = Case   WHEN EecPayPeriod = 'W' then FORMAT(EecScheduledWorkHrs, '##')  
                                        WHEN EecPayPeriod = 'B' then FORMAT(((EecScheduledWorkHrs * 26)/52), '##') 
                                        WHEN EecPayPeriod = 'S' then FORMAT(((EecScheduledWorkHrs*24)/52), '##')  
                                        WHEN EecPayPeriod = 'M' then FORMAT(((EecScheduledWorkHrs*12)/52), '##')  
                                        END
        ,drvSTDCoverage =  CASE WHEN STD_DedCode IS NOT NULL  then 'ST' END
        ,drvSTDCoverageStartDate = CASE WHEN STD_DedCode IS NOT NULL  THEN  REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',  '2024-01-01' , STD_BenStartDate ), 101),'/','')
  --                                      WHEN STD_DedCode IS NOT NULL  AND cast(STD_BenStartDate as date) < '2024-01-01' THEN '2024-01-01' 
                                     END
        ,drvSTDCoverageStopDate = CASE WHEN STD_DedCode IS NOT NULL  THEN REPLACE(CONVERT (CHAR(10),STD_BenStopDate , 101),'/','') END
        ,drvSTDReportNumber = CASE WHEN STD_DedCode IS NOT NULL  THEN '0254450' END 
        ,drvSTDSubCode = CASE WHEN STD_DedCode IS NOT NULL  THEN '0001' END
        ,drvSTDSubPoint = CASE WHEN STD_DedCode IS NOT NULL  THEN '0001' END
        ,drvSTDPlancode = ''
        ,drvSTDFlatBenefitAmount = ''
        ,drvSTDContribPlanIndicator = CASE WHEN STD_DedCode IS NOT NULL  THEN 'N' END
        ,drvSTDContribPlanPercentage = CASE WHEN STD_DedCode IS NOT NULL  THEN '100' END
        ,drvSTDContribPretaxPercentage = CASE WHEN STD_DedCode IS NOT NULL THEN '000' END
        ,drvLTDCoverage = CASE WHEN LTD_DedCode IS NOT NULL THEN 'LT' END
        ,drvLTDCoverageStartDate = 
                  CASE WHEN LTD_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',  '2024-01-01' , LTD_BenStartDate ), 101),'/','')
                                        --WHEN LTD_DedCode IS NOT NULL AND cast(LTD_BenStartDate as date)  < '2024-01-01' THEN '2024-01-01' 
                                       END
        ,drvLTDCoverageStopDate = CASE WHEN LTD_DedCode IS NOT NULL  THEN REPLACE(CONVERT (CHAR(10),LTD_BenStopDate, 101),'/','')  END
        ,drvLTDReportNumber = CASE WHEN LTD_DedCode IS NOT NULL THEN '0254347' END
        ,drvLTDSubCode = CASE WHEN LTD_DedCode IS NOT NULL THEN '0004' END
        ,drvLTDSubPoint = CASE WHEN LTD_DedCode IS NOT NULL THEN '0001' END
        ,drvLTDPlancode =  ''
        ,drvLTDSalary = CASE WHEN LTD_DedCode IS NOT NULL THEN FORMAT((EecAnnSalary*100), '000000000') END
        ,drvLTDContribPlanIndicator = CASE WHEN LTD_DedCode IS NOT NULL THEN 'N' END
        ,drvLTDContribPlanPercentage = CASE WHEN LTD_DedCode IS NOT NULL THEN '100' END
        ,drvLTDContribPretaxPercentage = CASE WHEN LTD_DedCode IS NOT NULL THEN '000' END
        ,drvNYPFLCoverage = CASE WHEN LEFT(EecStateSUI,2) = 'NY' then 'PF' END
        ,drvNYPFLCoverageStartDate = CASE WHEN LEFT(EecStateSUI,2) = 'NY'  THEN REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',  '2024-01-01' , EecDateOfLastHire ), 101),'/','')  END
        ,drvNYPFLCoverageStopDate =  CASE WHEN LEFT(EecStateSUI,2) = 'NY' and EecEmplStatus IN ('T') AND LEFT(EecStateSUI,2) = 'NY' then REPLACE(CONVERT (CHAR(10),EecDateOfTermination , 101),'/','')END
        ,drvPFLReportNumber =  CASE WHEN LEFT(EecStateSUI,2) = 'NY' THEN '0254453' END
        ,drvPFLSubCode = CASE WHEN LEFT(EecStateSUI,2) = 'NY' THEN '0001' END
        ,drvPFLSubPoint = CASE WHEN LEFT(EecStateSUI,2) = 'NY' THEN '0001' END
        ,drvHoursWorkedinPast12mths = CASE    WHEN PehCurHrs is null THEN '0'
                                            WHEN PehCurHrs < 1000 THEN  FORMAT(ceiling(PehCurHrs), '0###')
                                            ELSE FORMAT(ceiling(PehCurHrs), '####') END 
        ,drvPaidFamilyLeaveCovCode = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') THEN 'FL' END
        ,drvPaidFamilyLeaveStartDate = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','MA','NH','OR')  THEN REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX', '2023-01-01', EecDateOfLastHire), 101),'/','')                                          
                                            WHEN LEFT(EecStateSUI,2) = 'CT' THEN  REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX', '2023-04-01', EecDateOfLastHire), 101),'/','')
                                           END
        ,drvPaidFamilyLeaveStopDate = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') and EecEmplStatus IN ('T') then REPLACE(CONVERT (CHAR(10),EecDateOfTermination, 101),'/','') END
        ,drvPaidFamilyLeaveReportNumb = CASE WHEN LEFT(EecStateSUI,2) ='CO' THEN '0255432'
                                             WHEN LEFT(EecStateSUI,2) = 'CT' THEN '0255249'
                                             WHEN LEFT(EecStateSUI,2) = 'MA' THEN '0255175'
                                             WHEN LEFT(EecStateSUI,2) = 'NH' THEN '0255247'
                                             WHEN LEFT(EecStateSUI,2) = 'OR' THEN '0254455'
                                            END

        ,drvPaidFamilyLeaveSubCode = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') THEN '0001' END
        ,drvPaidFamilyLeaveSubPoint = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') THEN '0001' END
        ,drvPaidMedicalLeaveCovCode = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') THEN 'ML' END
        ,drvPaidMedicalLeaveStartDate = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','MA','NH','OR')  THEN REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX', '2024-01-01', EecDateOfLastHire) , 101),'/','')                                          
                                             WHEN LEFT(EecStateSUI,2) = 'CT' THEN  REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX', '2024-04-01', EecDateOfLastHire), 101),'/','')
                                           END
        ,drvPaidMedicalLeaveStopDate = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') and EecEmplStatus IN ('T') then REPLACE(CONVERT (CHAR(10),EecDateOfTermination, 101),'/','') END
        ,drvPaidMedicalLeaveReportNumb = CASE WHEN LEFT(EecStateSUI,2) ='CO' THEN '0255433'
                                             WHEN LEFT(EecStateSUI,2) = 'CT' THEN '0255250'
                                             WHEN LEFT(EecStateSUI,2) = 'MA' THEN '0255176'
                                             WHEN LEFT(EecStateSUI,2) = 'NH' THEN '0255248'
                                             WHEN LEFT(EecStateSUI,2) = 'OR' THEN '0254456'
                                            END
        ,drvPaidMedicalLeaveSubCode = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') THEN '0001' END
        ,drvPaidMedicalLeaveSubPoint = CASE WHEN LEFT(EecStateSUI,2) IN ('CO','CT','MA','NH','OR') THEN '0001' END
        ,drvAbsenceMngmtCoverage = 'AM'
        ,drvAbsenceMngmtStartDate =   REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX', '2024-01-01', EecDateOfLastHire), 101),'/','')
        ,drvAbsenceMngmtStopDate = CASE WHEN EecEmplStatus = 'T' THEN format(EecDateOfTermination, 'MMDDYYY') END
        ,drvOriginalHireDate = REPLACE(CONVERT (CHAR(10),CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire 
                                        Else EecDateofOriginalHire
                                        END, 101),'/','')
        ,drvRegOrTemp = CASE WHEN EecEEType = 'REG' THEN 'R'
                             WHEN EecEEType IN ('TMP', 'INT', 'STU') THEN 'T'
                             WHEN EecEEType = 'SUM' THEN 'S'
                             WHEN EecEEType = 'CON' THEN 'C'
                            END

        ,drvActualWklyHrsWked =  CASE WHEN EecPayPeriod = 'W' then FORMAT(EecScheduledWorkHrs, '##')  
                                      WHEN EecPayPeriod = 'B' then FORMAT(((EecScheduledWorkHrs * 26)/52), '##') 
                                      WHEN EecPayPeriod = 'S' then FORMAT(((EecScheduledWorkHrs*24)/52), '##')  
                                      WHEN EecPayPeriod = 'M' then FORMAT(((EecScheduledWorkHrs*12)/52), '##')  
                                    END
        
        --Case WHEN EecPayPeriod = 'W' then FORMAT(EecScheduledWorkHrs, '#.00') END
        ,drvADAGroupNumber = '0319680'
        ,drvADASubcode = '0001'
        ,drvADABranch = '0001'
    INTO dbo.U_EVENMETFML_drvTbl
    FROM dbo.U_EVENMETFML_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
  JOIN (
            SELECT BdmEEID, BdmCOID, BdmDepRecID, BdmRecType
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode    
            ,MAX(CASE WHEN BdmDedCode in ('LTD')  THEN BdmDedCode END) AS LTD_DedCode
           
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate    
            ,MAX(CASE WHEN BdmDedCode in ('LTD') THEN BdmBenStartDate END) AS LTD_BenStartDate
         
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate    
            ,MAX(CASE WHEN BdmDedCode in ('LTD')  THEN BdmBenStopDate END) AS LTD_BenStopDate
          
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenOption END) AS STD_BenOption    
            ,MAX(CASE WHEN BdmDedCode in ('LTD') THEN BdmBenOption END) AS LTD_BenOption
         
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmEEAmt END) AS STD_BenAmt    
            ,MAX(CASE WHEN BdmDedCode in ('LTD')  THEN BdmEEAmt END) AS LTD_BenAmt
            
        FROM  dbo.U_dsi_BDM_EVENMETFML WITH (NOLOCK)
        GROUP BY BdmEEID, BdmCOID, BdmDepRecID, BdmRecType ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpTax WITH (NOLOCK)
        ON EecCoID = EetCoID
        AND EecEEID = EetEEID
        AND eetTaxCode = 'USFIT'
    --LEFT JOIN dbo.dsi_fnlib_JobHistoryTable_v4 ('EjhFLSACategory') JHT
    --    ON JHT.EEID = EecEEID
       -- AND JHT.CoID = EecCoID
    LEFT JOIN dbo.U_EVENMETFML_PEarHist
        ON PehEEID = xEEID
    WHERE EecEEType <>  'TES'
    AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_EVENMETFML_Audit where audEEID = xEEID AND audCoId = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENMETFML_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_Header;
    SELECT DISTINCT
         drvUISCustomerNumber = '0254347'
        ,drvFileDate = REPLACE(CONVERT (CHAR(10),GetDate(), 101),'/','')
        ,drvEmployerName = 'Vendor Credentialing Services, LLC dba symplr'
        ,drvChangesOnlyInd = 'N'
    INTO dbo.U_EVENMETFML_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENMETFML_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EVENMETFML_Trailer;
    SELECT DISTINCT
         trvUISCustomerNumber = '0254347'
        ,trvTotalRecordCount = count(drvEEID)
    INTO dbo.U_EVENMETFML_Trailer
    FROM dbo.U_EVENMETFML_drvTbl 
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
ALTER VIEW dbo.dsi_vwEVENMETFML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVENMETFML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EVENMETFML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202310161'
       ,expStartPerControl     = '202310161'
       ,expLastEndPerControl   = '202401239'
       ,expEndPerControl       = '202401239'
WHERE expFormatCode = 'EVENMETFML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVENMETFML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVENMETFML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EVENMETFML' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EVENMETFML'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EVENMETFML'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVENMETFML', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EVENMETFML', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVENMETFML', 'UseFileName', 'V', 'Y'


-- End ripout