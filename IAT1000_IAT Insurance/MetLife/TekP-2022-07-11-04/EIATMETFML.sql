/**********************************************************************************

EIATMETFML: Metlife FMLA LOA Export

FormatCode:     EIATMETFML
Project:        Metlife FMLA LOA Export
Client ID:      IAT1000
Date/time:      2022-12-01 14:44:42.583
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB03
Database:       ULTIPRO_WPIATIG
Web Filename:   IAT1000_2BDI5_EEHISTORY_EIATMETFML_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIATMETFML_SavePath') IS NOT NULL DROP TABLE dbo.U_EIATMETFML_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIATMETFML'


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
WHERE FormatCode = 'EIATMETFML'
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
WHERE ExpFormatCode = 'EIATMETFML'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIATMETFML')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIATMETFML'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIATMETFML'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIATMETFML'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIATMETFML'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIATMETFML'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIATMETFML'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIATMETFML'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIATMETFML'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIATMETFML'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIATMETFML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIATMETFML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIATMETFML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATMETFML];
GO
IF OBJECT_ID('U_EIATMETFML_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_PEarHist];
GO
IF OBJECT_ID('U_EIATMETFML_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_HDR_drvTbl];
GO
IF OBJECT_ID('U_EIATMETFML_FTR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_FTR_drvTbl];
GO
IF OBJECT_ID('U_EIATMETFML_File') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_File];
GO
IF OBJECT_ID('U_EIATMETFML_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_EEList];
GO
IF OBJECT_ID('U_EIATMETFML_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_drvTbl];
GO
IF OBJECT_ID('U_EIATMETFML_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_DedList];
GO
IF OBJECT_ID('U_EIATMETFML_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_AuditFields];
GO
IF OBJECT_ID('U_EIATMETFML_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIATMETFML_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIATMETFML') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIATMETFML];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EIATMETFML','Metlife FMLA LOA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EIATMETFMLZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATMETFMLZ0','1','H','01','1',NULL,'Record Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATMETFMLZ0','7','H','01','2',NULL,'UIS Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATMETFMLZ0','8','H','01','9',NULL,'Date File Created',NULL,NULL,'"drvDateFileCreated"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATMETFMLZ0','50','H','01','17',NULL,'Employer Name',NULL,NULL,'"IAT INSURANCE GROUP, INC."','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATMETFMLZ0','1','H','01','67',NULL,'Changes Only Indicator',NULL,NULL,'"N"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATMETFMLZ0','1','D','10','1',NULL,'Record Type',NULL,NULL,'"E"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATMETFMLZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATMETFMLZ0','11','D','10','9',NULL,'[Employee] Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATMETFMLZ0','9','D','10','20',NULL,'Personnel ID',NULL,NULL,'""','(''SS=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATMETFMLZ0','13','D','10','29',NULL,'Filler',NULL,NULL,'""','(''SS=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIATMETFMLZ0','1','D','10','42',NULL,'Relationship Code',NULL,NULL,'""','(''SS=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIATMETFMLZ0','20','D','10','43',NULL,'[Employee] Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIATMETFMLZ0','12','D','10','63',NULL,'[Employee] First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIATMETFMLZ0','1','D','10','75',NULL,'[Employee] Middle Initial',NULL,NULL,'"drvMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIATMETFMLZ0','8','D','10','76',NULL,'[Employee] Birth Date',NULL,NULL,'"drvDateofBirth"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIATMETFMLZ0','1','D','10','84',NULL,'[Employee] Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIATMETFMLZ0','1','D','10','85',NULL,'[Employee] Sex',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIATMETFMLZ0','8','D','10','86',NULL,'[Employee''s] Employment Date',NULL,NULL,'"drvDateofLastHire"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIATMETFMLZ0','18','D','10','94',NULL,'Filler1',NULL,NULL,'""','(''SS=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIATMETFMLZ0','1','D','10','112',NULL,'Foreign Address Indicator',NULL,NULL,'"drvForeignAddressIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIATMETFMLZ0','32','D','10','113',NULL,'[Employee] Mailing Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIATMETFMLZ0','32','D','10','145',NULL,'[Employee] Mailing Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIATMETFMLZ0','21','D','10','177',NULL,'[Employee] Mailing Address -City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIATMETFMLZ0','2','D','10','198',NULL,'[Employee] Mailing Address -State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIATMETFMLZ0','9','D','10','200',NULL,'[Employee] Mailing Address -Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIATMETFMLZ0','2','D','10','209',NULL,'[Employee] Work State',NULL,NULL,'"drvWorkState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIATMETFMLZ0','13','D','10','211',NULL,'Filler2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIATMETFMLZ0','1','D','10','224',NULL,'Federal Marital Tax Code',NULL,NULL,'"drvFederalMaritalTaxCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIATMETFMLZ0','2','D','10','225',NULL,'Number of Federal Exemptions',NULL,NULL,'"drvNumberofFedExemptions"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIATMETFMLZ0','1','D','10','227',NULL,'[Work] Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIATMETFMLZ0','8','D','10','228',NULL,'[Work] Status as of Date',NULL,NULL,'"drvStatusDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIATMETFMLZ0','9','D','10','236',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIATMETFMLZ0','1','D','10','245',NULL,'MD (Salary Mode)',NULL,NULL,'"drvMD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIATMETFMLZ0','8','D','10','246',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectiveDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIATMETFMLZ0','3','D','10','254',NULL,'Weekly Scheduled Work Hours',NULL,NULL,'"drvWeeklySchWorkHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIATMETFMLZ0','46','D','10','257',NULL,'Filler3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EIATMETFMLZ0','2','D','10','303',NULL,'STD Coverage',NULL,NULL,'"drvSTDCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EIATMETFMLZ0','8','D','10','305',NULL,'STD Coverage Start Date (Insurance Effective Date)',NULL,NULL,'"drvSTDCoverageStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EIATMETFMLZ0','8','D','10','313',NULL,'STD Coverage Stop Date (Insurance Cancel Date)',NULL,NULL,'"drvSTDCoverageStopDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EIATMETFMLZ0','7','D','10','321',NULL,'STD Report Number (Group Number)',NULL,NULL,'"drvSTDReportNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EIATMETFMLZ0','4','D','10','328',NULL,'STD SubCode (Subdivision)',NULL,NULL,'"drvSTDSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EIATMETFMLZ0','4','D','10','332',NULL,'STD SubPoint (Branch)',NULL,NULL,'"drvSTDSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EIATMETFMLZ0','2','D','10','336',NULL,'STD Plan code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EIATMETFMLZ0','8','D','10','338',NULL,'STD Flat Benefit Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EIATMETFMLZ0','1','D','10','346',NULL,'STD Contributory Plan Indicator',NULL,NULL,'"drvSTDContributoryPlanInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EIATMETFMLZ0','3','D','10','347',NULL,'STD Contributory Plan Percentage',NULL,NULL,'"drvSTDContributoryPlanPer"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EIATMETFMLZ0','3','D','10','350',NULL,'STD Contributory Pre-tax Percentage',NULL,NULL,'"drvSTDContributoryPretaxPer"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EIATMETFMLZ0','2','D','10','353',NULL,'LTD Coverage',NULL,NULL,'"drvLTDCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EIATMETFMLZ0','8','D','10','355',NULL,'LTD Coverage Start Date (Insurance Effective Date)',NULL,NULL,'"drvLTDCoverageStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EIATMETFMLZ0','8','D','10','363',NULL,'LTD Coverage Stop Date (Insurance Cancel Date)',NULL,NULL,'"drvLTDCoverageStopDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EIATMETFMLZ0','7','D','10','371',NULL,'LTD Report Number (Group Number)',NULL,NULL,'"drvLTDReportNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EIATMETFMLZ0','4','D','10','378',NULL,'LTD SubCode (Subdivision)',NULL,NULL,'"drvLTDSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EIATMETFMLZ0','4','D','10','382',NULL,'LTD SubPoint (Branch)',NULL,NULL,'"drvLTDSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EIATMETFMLZ0','2','D','10','386',NULL,'LTD Plan code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EIATMETFMLZ0','8','D','10','388',NULL,'LTD Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EIATMETFMLZ0','1','D','10','396',NULL,'LTD Contributory Plan Indicator',NULL,NULL,'"drvLTDContributoryPlanInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EIATMETFMLZ0','3','D','10','397',NULL,'LTD Contributory Plan Percentage',NULL,NULL,'"drvLTDContributoryPlanPer"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EIATMETFMLZ0','3','D','10','400',NULL,'LTD Contributory Pre-tax Percentage',NULL,NULL,'"drvLTDContributoryPretaxPer"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EIATMETFMLZ0','2','D','10','403',NULL,'NY PFL Coverage',NULL,NULL,'"drvNYPFLCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EIATMETFMLZ0','8','D','10','405',NULL,'NY PFL Coverage Start Date (Insurance Effective Da',NULL,NULL,'"drvNYPFLCoverageStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EIATMETFMLZ0','8','D','10','413',NULL,'NY PFL Coverage Stop Date (Insurance Cancel Date)',NULL,NULL,'"drvNYPFLCoverageStopDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EIATMETFMLZ0','7','D','10','421',NULL,'NY PFL Report Number (Group Number)',NULL,NULL,'"drvPFLReportNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EIATMETFMLZ0','4','D','10','428',NULL,'NY PFL SubCode (Subdivision)',NULL,NULL,'"drvPFLSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EIATMETFMLZ0','4','D','10','432',NULL,'NY PFL SubPoint (Branch)',NULL,NULL,'"drvPFLSubBranch"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EIATMETFMLZ0','2','D','10','436',NULL,'Filler4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EIATMETFMLZ0','1','D','10','438',NULL,'Job Status Code (full time/part time indicator)',NULL,NULL,'"drvJobStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EIATMETFMLZ0','8','D','10','439',NULL,'Job Status (full time/part time) As of Date',NULL,NULL,'"drvJobStatus"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EIATMETFMLZ0','1','D','10','447',NULL,'Variable Work Schedule Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EIATMETFMLZ0','2','D','10','448',NULL,'Work Hours Per Day',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EIATMETFMLZ0','4','D','10','450',NULL,'Hours Worked in Past 12 Months',NULL,NULL,'"drvHoursWorkedinPast12mths"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EIATMETFMLZ0','8','D','10','454',NULL,'Hours Worked in Past 12 Months Start Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EIATMETFMLZ0','8','D','10','462',NULL,'Total Hrs Wkd in Prior12 Mos End Dt',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EIATMETFMLZ0','1','D','10','470',NULL,'Temp to Permanent indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EIATMETFMLZ0','8','D','10','471',NULL,'Permanent Start Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EIATMETFMLZ0','2','D','10','479',NULL,'Paid Family Leave Coverage Code',NULL,NULL,'"drvPaidFamilyLeaveCovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EIATMETFMLZ0','8','D','10','481',NULL,'Paid Family Leave Coverage Start Date (Insurance E',NULL,NULL,'"drvPaidFamilyLeavCovStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EIATMETFMLZ0','8','D','10','489',NULL,'Paid Family LeaveCoverage Stop Date (Insurance Can',NULL,NULL,'"drvPaidFamilyLeavCovStopDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EIATMETFMLZ0','7','D','10','497',NULL,'Paid Family Leave Report Number (Group Number)',NULL,NULL,'"drvPaidFamilyLeavGroupNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EIATMETFMLZ0','4','D','10','504',NULL,'Paid Family Leave SubCode (Subdivision)',NULL,NULL,'"drvPaidMedLeaveSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EIATMETFMLZ0','4','D','10','508',NULL,'Paid Family Leave SubPoint (Branch)',NULL,NULL,'"drvPaidMedLeaveSuPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EIATMETFMLZ0','2','D','10','512',NULL,'Filler5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EIATMETFMLZ0','2','D','10','514',NULL,'Paid Medical Leave Coverage Code',NULL,NULL,'"drvPaidMedLeaveCovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EIATMETFMLZ0','8','D','10','516',NULL,'Paid Medical Leave Coverage Start Date (Insurance',NULL,NULL,'"drvPaidFamilyLeavCovStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EIATMETFMLZ0','8','D','10','524',NULL,'Paid Medical LeaveCoverage Stop Date (Insurance Ca',NULL,NULL,'"drvPaidFamilyLeavCovStopDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EIATMETFMLZ0','7','D','10','532',NULL,'Paid Medical Leave Report Number (Group Number)',NULL,NULL,'"drvPaidMedLeaveGroupNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EIATMETFMLZ0','4','D','10','539',NULL,'Paid Medical Leave SubCode (Subdivision)',NULL,NULL,'"drvPaidMedLeaveSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EIATMETFMLZ0','4','D','10','543',NULL,'Paid Medical Leave SubPoint (Branch)',NULL,NULL,'"drvPaidMedLeaveSuPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EIATMETFMLZ0','5','D','10','547',NULL,'Filler6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EIATMETFMLZ0','2','D','10','552',NULL,'Absence Management Coverage',NULL,NULL,'"drvAbsenceManagementCov"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EIATMETFMLZ0','8','D','10','554',NULL,'Absence Management Coverage Start Date (Administra',NULL,NULL,'"drvAbsenceManagementStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EIATMETFMLZ0','8','D','10','562',NULL,'Absence Management Coverage Stop Date (Administrat',NULL,NULL,'"drvAbsenceManagementStopDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EIATMETFMLZ0','7','D','10','570',NULL,'Absence Management Report Number (Group Number)',NULL,NULL,'"drvAbsenceManagementReportNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EIATMETFMLZ0','4','D','10','577',NULL,'Absence Management SubCode (Subdivision)',NULL,NULL,'"drvAbsenceManagementSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EIATMETFMLZ0','4','D','10','581',NULL,'Absence Management SubPoint (Branch)',NULL,NULL,'"drvAbsenceManagementSubPoint"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EIATMETFMLZ0','2','D','10','585',NULL,'Absence Management Plan code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EIATMETFMLZ0','14','D','10','587',NULL,'Unique File ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EIATMETFMLZ0','8','D','10','601',NULL,'Employee Original Hire Date',NULL,NULL,'"drvEmployeeOriginalHireDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EIATMETFMLZ0','8','D','10','609',NULL,'Seniority Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EIATMETFMLZ0','8','D','10','617',NULL,'Temp Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EIATMETFMLZ0','1','D','10','625',NULL,'Regular/Temporary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EIATMETFMLZ0','1','D','10','626',NULL,'FLSA Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EIATMETFMLZ0','1','D','10','627',NULL,'Salaried/Hourly',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EIATMETFMLZ0','1','D','10','628',NULL,'Union\NonUnion',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EIATMETFMLZ0','10','D','10','629',NULL,'Union Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EIATMETFMLZ0','10','D','10','639',NULL,'Collective Bargaining Group Identifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EIATMETFMLZ0','1','D','10','649',NULL,'Mgmt/Occupational/Executive',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EIATMETFMLZ0','32','D','10','650',NULL,'[Employee Work] Mailing Address 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EIATMETFMLZ0','32','D','10','682',NULL,'[Employee Work] Mailing Address 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EIATMETFMLZ0','21','D','10','714',NULL,'[Employee Work] Mailing Address -City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EIATMETFMLZ0','2','D','10','735',NULL,'[Employee Work] Mailing Address -State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EIATMETFMLZ0','9','D','10','737',NULL,'[Employee Work] Mailing Address -Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EIATMETFMLZ0','10','D','10','746',NULL,'[Employee Work] Phone Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EIATMETFMLZ0','11','D','10','756',NULL,'[Employee Work] Fax Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EIATMETFMLZ0','1','D','10','767',NULL,'Key Employee Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EIATMETFMLZ0','1','D','10','768',NULL,'FMLA Eligibility Flag',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EIATMETFMLZ0','8','D','10','769',NULL,'FMLA Eligibility Flag as of Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EIATMETFMLZ0','40','D','10','777',NULL,'Employee Work E-mail Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EIATMETFMLZ0','40','D','10','817',NULL,'Employee Alternate E-mail Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EIATMETFMLZ0','3','D','10','857',NULL,'Benefit Months',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EIATMETFMLZ0','8','D','10','860',NULL,'Benefit Months As Of Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EIATMETFMLZ0','8','D','10','868',NULL,'Fixed Date for FMLA exhaustion Method',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EIATMETFMLZ0','3','D','10','876',NULL,'Actual Weekly Hours Worked',NULL,NULL,'"drvActualWeeklyHoursWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EIATMETFMLZ0','50','D','10','879',NULL,'Employee Job Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EIATMETFMLZ0','1','D','10','929',NULL,'Leave Program Indicator 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EIATMETFMLZ0','1','D','10','930',NULL,'Leave Program Indicator 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EIATMETFMLZ0','1','D','10','931',NULL,'Leave Program Indicator 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EIATMETFMLZ0','1','D','10','932',NULL,'Leave Program Indicator 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EIATMETFMLZ0','1','D','10','933',NULL,'Leave Program Indicator 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EIATMETFMLZ0','8','D','10','934',NULL,'Termination Date 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EIATMETFMLZ0','8','D','10','942',NULL,'Termination Date 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EIATMETFMLZ0','8','D','10','950',NULL,'Termination Date 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EIATMETFMLZ0','8','D','10','958',NULL,'Termination Date 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EIATMETFMLZ0','8','D','10','966',NULL,'Termination Date 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EIATMETFMLZ0','8','D','10','974',NULL,'Re-Hire Date 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EIATMETFMLZ0','8','D','10','982',NULL,'Re-Hire Date 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EIATMETFMLZ0','8','D','10','990',NULL,'Re-Hire Date 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EIATMETFMLZ0','8','D','10','998',NULL,'Re-Hire Date 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EIATMETFMLZ0','8','D','10','1006',NULL,'Re-Hire Date 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EIATMETFMLZ0','6','D','10','1014',NULL,'Holiday Schedule',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EIATMETFMLZ0','4','D','10','1020',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EIATMETFMLZ0','10','D','10','1024',NULL,'Shift \ Schedule designation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EIATMETFMLZ0','4','D','10','1034',NULL,'Monday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EIATMETFMLZ0','4','D','10','1038',NULL,'Tuesday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EIATMETFMLZ0','4','D','10','1042',NULL,'Wednesday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EIATMETFMLZ0','4','D','10','1046',NULL,'Thursday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EIATMETFMLZ0','4','D','10','1050',NULL,'Friday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EIATMETFMLZ0','4','D','10','1054',NULL,'Saturday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EIATMETFMLZ0','4','D','10','1058',NULL,'Sunday Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EIATMETFMLZ0','9','D','10','1062',NULL,'Leave\Absence 1 Approver ID (Email / Web Access 1)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EIATMETFMLZ0','31','D','10','1071',NULL,'Leave\Absence 1 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EIATMETFMLZ0','40','D','10','1102',NULL,'Leave\Absence 1 Approval Flow type',NULL,NULL,'"APPROVER1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EIATMETFMLZ0','2','D','10','1142',NULL,'Leave\Absence 1 Approval Flow Level',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EIATMETFMLZ0','9','D','10','1144',NULL,'Leave\Absence 2 Approver ID (Email / Web Access 2)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EIATMETFMLZ0','31','D','10','1153',NULL,'Leave\Absence 2 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EIATMETFMLZ0','40','D','10','1184',NULL,'Leave\Absence 2 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EIATMETFMLZ0','2','D','10','1224',NULL,'Leave\Absence 2 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EIATMETFMLZ0','9','D','10','1226',NULL,'Leave\Absence 3 Approver ID (Email / Web Access 3)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EIATMETFMLZ0','31','D','10','1235',NULL,'Leave\Absence 3 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EIATMETFMLZ0','40','D','10','1266',NULL,'Leave\Absence 3 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EIATMETFMLZ0','2','D','10','1306',NULL,'Leave\Absence 3 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EIATMETFMLZ0','20','D','10','1308',NULL,'Leave\Absence 4 Approver ID (Email / Web Access 4)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EIATMETFMLZ0','20','D','10','1328',NULL,'Leave\Absence 4 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EIATMETFMLZ0','40','D','10','1348',NULL,'Leave\Absence 4 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EIATMETFMLZ0','2','D','10','1388',NULL,'Leave\Absence 4 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EIATMETFMLZ0','20','D','10','1390',NULL,'Leave\Absence 5 Approver ID (Email / Web Access 5)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EIATMETFMLZ0','20','D','10','1410',NULL,'Leave\Absence 5 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EIATMETFMLZ0','40','D','10','1430',NULL,'Leave\Absence 5 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EIATMETFMLZ0','2','D','10','1470',NULL,'Leave\Absence 5 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EIATMETFMLZ0','20','D','10','1472',NULL,'Leave\Absence 6 Approver ID (Email / Web Access 6)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EIATMETFMLZ0','20','D','10','1492',NULL,'Leave\Absence 6 Alt ApproverID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EIATMETFMLZ0','40','D','10','1512',NULL,'Leave\Absence 6 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EIATMETFMLZ0','2','D','10','1552',NULL,'Leave\Absence 6 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EIATMETFMLZ0','20','D','10','1554',NULL,'Leave\Absence 7 Approver ID (Email / Web Access 7)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EIATMETFMLZ0','20','D','10','1574',NULL,'Leave\Absence 7 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EIATMETFMLZ0','40','D','10','1594',NULL,'Leave\Absence 7 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EIATMETFMLZ0','2','D','10','1634',NULL,'Leave\Absence 7 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EIATMETFMLZ0','20','D','10','1636',NULL,'Leave\Absence 8 Approver ID (Email / Web Access 8)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EIATMETFMLZ0','20','D','10','1656',NULL,'Leave\Absence 8 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EIATMETFMLZ0','40','D','10','1676',NULL,'Leave\Absence 8 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EIATMETFMLZ0','2','D','10','1716',NULL,'Leave\Absence 8 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EIATMETFMLZ0','20','D','10','1718',NULL,'Leave\Absence 9 Approver ID (Email / Web Access 9)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EIATMETFMLZ0','20','D','10','1738',NULL,'Leave\Absence 9 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EIATMETFMLZ0','40','D','10','1758',NULL,'Leave\Absence 9 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EIATMETFMLZ0','2','D','10','1798',NULL,'Leave\Absence 9 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EIATMETFMLZ0','20','D','10','1800',NULL,'Leave\Absence 10 Approver ID (Email / Web Access 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EIATMETFMLZ0','20','D','10','1820',NULL,'Leave\Absence 10 Alt Approver ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EIATMETFMLZ0','40','D','10','1840',NULL,'Leave\Absence 10 Approval Flow type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EIATMETFMLZ0','2','D','10','1880',NULL,'Leave\Absence 10 Approval Flow Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EIATMETFMLZ0','1','D','10','1882',NULL,'AccrualFunction1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EIATMETFMLZ0','10','D','10','1883',NULL,'AccrualAmount1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EIATMETFMLZ0','7','D','10','1893',NULL,'AccrualDate1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EIATMETFMLZ0','1','D','10','1900',NULL,'AccrualFunction2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EIATMETFMLZ0','10','D','10','1901',NULL,'AccrualAmount2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EIATMETFMLZ0','8','D','10','1911',NULL,'AccrualDate2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EIATMETFMLZ0','1','D','10','1919',NULL,'AccrualFunction3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EIATMETFMLZ0','10','D','10','1920',NULL,'AccrualAmount3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EIATMETFMLZ0','8','D','10','1930',NULL,'AccrualDate3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EIATMETFMLZ0','1','D','10','1938',NULL,'AccrualFunction4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EIATMETFMLZ0','10','D','10','1939',NULL,'AccrualAmount4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EIATMETFMLZ0','8','D','10','1949',NULL,'AccrualDate4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EIATMETFMLZ0','1','D','10','1957',NULL,'AccrualFunction5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EIATMETFMLZ0','10','D','10','1958',NULL,'AccrualAmount5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EIATMETFMLZ0','8','D','10','1968',NULL,'AccrualDate5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EIATMETFMLZ0','1','D','10','1976',NULL,'AccrualFunction6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EIATMETFMLZ0','10','D','10','1977',NULL,'AccrualAmount6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EIATMETFMLZ0','8','D','10','1987',NULL,'AccrualDate6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EIATMETFMLZ0','1','D','10','1995',NULL,'AccrualFunction7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EIATMETFMLZ0','10','D','10','1996',NULL,'AccrualAmount7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EIATMETFMLZ0','8','D','10','2006',NULL,'AccrualDate7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EIATMETFMLZ0','1','D','10','2014',NULL,'AccrualFunction8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EIATMETFMLZ0','10','D','10','2015',NULL,'AccrualAmount8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EIATMETFMLZ0','8','D','10','2025',NULL,'AccrualDate8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EIATMETFMLZ0','1','D','10','2033',NULL,'AccrualFunction9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EIATMETFMLZ0','10','D','10','2034',NULL,'AccrualAmount9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EIATMETFMLZ0','8','D','10','2044',NULL,'AccrualDate9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EIATMETFMLZ0','1','D','10','2052',NULL,'AccrualFunction10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EIATMETFMLZ0','10','D','10','2053',NULL,'AccrualAmount10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EIATMETFMLZ0','8','D','10','2063',NULL,'AccrualDate10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EIATMETFMLZ0','1','D','10','2071',NULL,'AccrualFunction11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EIATMETFMLZ0','10','D','10','2072',NULL,'AccrualAmount11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EIATMETFMLZ0','8','D','10','2082',NULL,'AccrualDate11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EIATMETFMLZ0','1','D','10','2090',NULL,'AccrualFunction12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EIATMETFMLZ0','10','D','10','2091',NULL,'AccrualAmount12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EIATMETFMLZ0','8','D','10','2101',NULL,'AccrualDate12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EIATMETFMLZ0','1','D','10','2109',NULL,'AccrualFunction13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EIATMETFMLZ0','10','D','10','2110',NULL,'AccrualAmount13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EIATMETFMLZ0','8','D','10','2120',NULL,'AccrualDate13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EIATMETFMLZ0','1','D','10','2128',NULL,'AccrualFunction14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EIATMETFMLZ0','10','D','10','2129',NULL,'AccrualAmount14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EIATMETFMLZ0','8','D','10','2139',NULL,'AccrualDate14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EIATMETFMLZ0','1','D','10','2147',NULL,'AccrualFunction15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EIATMETFMLZ0','10','D','10','2148',NULL,'AccrualAmount15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EIATMETFMLZ0','8','D','10','2158',NULL,'AccrualDate15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EIATMETFMLZ0','1','D','10','2166',NULL,'AccrualFunction16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EIATMETFMLZ0','10','D','10','2167',NULL,'AccrualAmount16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EIATMETFMLZ0','8','D','10','2177',NULL,'AccrualDate16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EIATMETFMLZ0','1','D','10','2185',NULL,'AccrualFunction17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EIATMETFMLZ0','10','D','10','2186',NULL,'AccrualAmount17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EIATMETFMLZ0','8','D','10','2196',NULL,'AccrualDate17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EIATMETFMLZ0','1','D','10','2204',NULL,'AccrualFunction18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EIATMETFMLZ0','10','D','10','2205',NULL,'AccrualAmount18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EIATMETFMLZ0','8','D','10','2215',NULL,'AccrualDate18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EIATMETFMLZ0','1','D','10','2223',NULL,'AccrualFunction19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EIATMETFMLZ0','10','D','10','2224',NULL,'AccrualAmount19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EIATMETFMLZ0','8','D','10','2234',NULL,'AccrualDate19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EIATMETFMLZ0','1','D','10','2242',NULL,'AccrualFunction20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EIATMETFMLZ0','10','D','10','2243',NULL,'AccrualAmount20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EIATMETFMLZ0','8','D','10','2253',NULL,'AccrualDate20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EIATMETFMLZ0','40','D','10','2261',NULL,'Customer Defined Field 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EIATMETFMLZ0','40','D','10','2301',NULL,'Customer Defined Field 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EIATMETFMLZ0','40','D','10','2341',NULL,'Customer Defined Field 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EIATMETFMLZ0','40','D','10','2381',NULL,'Customer Defined Field 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EIATMETFMLZ0','41','D','10','2421',NULL,'Customer Defined Field 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EIATMETFMLZ0','7','D','10','2462',NULL,'ADA Group number*',NULL,NULL,'"0318219"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EIATMETFMLZ0','4','D','10','2469',NULL,'ADA Subcode*',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EIATMETFMLZ0','4','D','10','2473',NULL,'ADA Branch*',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATMETFMLZ0','1','T','90','1',NULL,'Record Type',NULL,NULL,'"Z"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATMETFMLZ0','7','T','90','2',NULL,'UIS Customer Number',NULL,NULL,'"0243321"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATMETFMLZ0','8','T','90','9',NULL,'Total Record Count',NULL,NULL,'"drvTotalRecordCount"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIATMETFML_20221201.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210049','EMPEXPORT','OEACTIVE',NULL,'EIATMETFML',NULL,NULL,NULL,'202210049','Oct  4 2022  9:31AM','Oct  4 2022  9:31AM','202210041',NULL,'','','202210041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210049','EMPEXPORT','OEPASSIVE',NULL,'EIATMETFML',NULL,NULL,NULL,'202210049','Oct  4 2022  9:31AM','Oct  4 2022  9:31AM','202210041',NULL,'','','202210041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Metlife FMLA LOA Export','202210049','EMPEXPORT','ONDEM_XOE',NULL,'EIATMETFML',NULL,NULL,NULL,'202210049','Oct  4 2022  9:31AM','Oct  4 2022  9:31AM','202210041',NULL,'','','202210041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',FENUE',NULL,NULL,NULL,'Metlife FMLA LOA Export-Sched','202210049','EMPEXPORT','SCH_EIATME',NULL,'EIATMETFML',NULL,NULL,NULL,'202210049','Oct  4 2022  9:31AM','Oct  4 2022  9:31AM','202210041',NULL,'','','202210041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',FENUE',NULL,NULL,NULL,'Metlife FMLA LOA Export-Test','202211289','EMPEXPORT','TEST_XOE','Nov 30 2022 12:33PM','EIATMETFML',NULL,NULL,NULL,'202211289','Nov 28 2022 12:00AM','Dec 30 1899 12:00AM','202211211','971','','','202211211',dbo.fn_GetTimedKey(),NULL,'us3kEpIAT1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETFML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETFML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETFML','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETFML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETFML','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETFML','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATMETFML','H01','dbo.U_EIATMETFML_HDR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATMETFML','D10','dbo.U_EIATMETFML_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATMETFML','T90','dbo.U_EIATMETFML_FTR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIATMETFML
-----------

IF OBJECT_ID('U_dsi_BDM_EIATMETFML') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIATMETFML] (
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
-- Create table U_EIATMETFML_Audit
-----------

IF OBJECT_ID('U_EIATMETFML_Audit') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_Audit] (
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
-- Create table U_EIATMETFML_AuditFields
-----------

IF OBJECT_ID('U_EIATMETFML_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIATMETFML_DedList
-----------

IF OBJECT_ID('U_EIATMETFML_DedList') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIATMETFML_drvTbl
-----------

IF OBJECT_ID('U_EIATMETFML_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvMaritalStatus] varchar(7) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateofLastHire] datetime NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvWorkState] varchar(2) NULL,
    [drvFederalMaritalTaxCode] varchar(1) NULL,
    [drvNumberofFedExemptions] int NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvStatusDate] datetime NULL,
    [drvSalaryAmount] nvarchar(4000) NULL,
    [drvMD] varchar(1) NOT NULL,
    [drvSalaryEffectiveDate] datetime NULL,
    [drvWeeklySchWorkHours] nvarchar(4000) NULL,
    [drvSTDCoverage] varchar(2) NULL,
    [drvSTDCoverageStartDate] datetime NULL,
    [drvSTDCoverageStopDate] datetime NULL,
    [drvSTDReportNumber] varchar(7) NULL,
    [drvSTDSubCode] varchar(4) NULL,
    [drvSTDSubPoint] varchar(4) NULL,
    [drvSTDContributoryPlanInd] varchar(1) NULL,
    [drvSTDContributoryPlanPer] varchar(3) NULL,
    [drvSTDContributoryPretaxPer] varchar(3) NULL,
    [drvLTDCoverage] varchar(2) NULL,
    [drvLTDCoverageStartDate] datetime NULL,
    [drvLTDCoverageStopDate] datetime NULL,
    [drvLTDReportNumber] varchar(7) NULL,
    [drvLTDSubCode] varchar(4) NULL,
    [drvLTDSubPoint] varchar(4) NULL,
    [drvLTDContributoryPlanInd] varchar(1) NULL,
    [drvLTDContributoryPlanPer] varchar(3) NULL,
    [drvLTDContributoryPretaxPer] varchar(3) NULL,
    [drvNYPFLCoverage] varchar(2) NULL,
    [drvNYPFLCoverageStartDate] datetime NULL,
    [drvNYPFLCoverageStopDate] datetime NULL,
    [drvPFLReportNumber] varchar(7) NULL,
    [drvPFLSubCode] varchar(4) NULL,
    [drvPFLSubBranch] varchar(4) NULL,
    [drvJobStatusCode] char(1) NULL,
    [drvJobStatus] date NULL,
    [drvHoursWorkedinPast12mths] nvarchar(4000) NULL,
    [drvPaidFamilyLeaveCovCode] varchar(2) NULL,
    [drvPaidFamilyLeavCovStartDate] datetime NULL,
    [drvPaidFamilyLeavCovStopDate] datetime NULL,
    [drvPaidFamilyLeavGroupNo] varchar(7) NULL,
    [drvPaidMedLeaveCovCode] varchar(2) NULL,
    [drvPaidMedLeaveGroupNo] varchar(7) NULL,
    [drvPaidMedLeaveSubCode] varchar(4) NULL,
    [drvPaidMedLeaveSuPoint] varchar(4) NULL,
    [drvAbsenceManagementCov] varchar(2) NOT NULL,
    [drvAbsenceManagementStartDate] datetime NULL,
    [drvAbsenceManagementStopDate] datetime NULL,
    [drvAbsenceManagementReportNo] varchar(7) NOT NULL,
    [drvAbsenceManagementSubCode] varchar(4) NOT NULL,
    [drvAbsenceManagementSubPoint] varchar(4) NOT NULL,
    [drvEmployeeOriginalHireDate] datetime NULL,
    [drvActualWeeklyHoursWorked] nvarchar(4000) NULL
);

-----------
-- Create table U_EIATMETFML_EEList
-----------

IF OBJECT_ID('U_EIATMETFML_EEList') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIATMETFML_File
-----------

IF OBJECT_ID('U_EIATMETFML_File') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);

-----------
-- Create table U_EIATMETFML_FTR_drvTbl
-----------

IF OBJECT_ID('U_EIATMETFML_FTR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_FTR_drvTbl] (
    [drvTotalRecordCount] int NULL
);

-----------
-- Create table U_EIATMETFML_HDR_drvTbl
-----------

IF OBJECT_ID('U_EIATMETFML_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_HDR_drvTbl] (
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvDateFileCreated] datetime NOT NULL
);

-----------
-- Create table U_EIATMETFML_PEarHist
-----------

IF OBJECT_ID('U_EIATMETFML_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIATMETFML_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATMETFML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IAT Insurance Inc

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 10/04/2022
Service Request Number: TekP-2022-07-11-04

Purpose: Metlife FMLA LOA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIATMETFML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIATMETFML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIATMETFML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIATMETFML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIATMETFML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETFML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETFML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETFML', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETFML', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETFML', 'SCH_EIATME';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIATMETFML';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIATMETFML', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'EIATMETFML';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    --PRINT 'Last 52 Weeks ' + @Last52WeekPerControl

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EIATMETFML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIATMETFML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIATMETFML_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_AuditFields;
    CREATE TABLE dbo.U_EIATMETFML_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EIATMETFML_AuditFields VALUES ('Empcomp','eecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIATMETFML_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_Audit;
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
    INTO dbo.U_EIATMETFML_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIATMETFML_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIATMETFML_Audit ON dbo.U_EIATMETFML_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EIATMETFML_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EIATMETFML_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD, LTDEL, STD';  --'LTD, LTDEL, STD, IDI';

    IF OBJECT_ID('U_EIATMETFML_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIATMETFML_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','LTD, LTDEL, STD, IDI');
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
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EIATMETFML_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_PEarHist;
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
    INTO dbo.U_EIATMETFML_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    --WHERE  PehPerControl <= @EndPerControl
    WHERE PrgPayDate BETWEEN DATEADD(YY,-1,@EndDate) AND @EndDate
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIATMETFML_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIATMETFML_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvCustomerNumber = '0241091'
        ,drvSSN = '00'+eepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvDateofBirth = EepDateOfBirth
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus in ('M','S') THEN eepMaritalStatus ELSE 'Unknown' END
        ,drvGender = CASE WHEN EepGender in ('F','M') THEN EepGender else 'U' END
        ,drvDateofLastHire = EecDateOfLastHire
        ,drvForeignAddressIndicator = CASE WHEN EepAddressCountry <> 'USA' then 'F' Else 'D' END
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvWorkState = Substring(EecStateSUI,1,2)
        ,drvFederalMaritalTaxCode = Case    WHEN EetTaxCode = 'USFIT' AND EetFilingStatus in('M','B','D','H','E','G','F','T','U','W','Y','V','X') THEN 'M'
                                            WHEN EetTaxCode = 'USFIT' AND EetFilingStatus in ('C','S','A') THEN 'S'
                                            WHEN EetTaxCode = 'USFIT' and EetExemptFromTax = 'Y' THEN 'E'--EetTaxCode = 'USFIT' AND EetFilingStatus in('E') THEN 'E'
                                            END
        ,drvNumberofFedExemptions = EetExemptions
        ,drvStatusCode = Case     WHEN EecEmplStatus in ('A','T') THEN EecEmplStatus 
                                WHEN EecEmplStatus in ('L') THEN 'P'
                                END

        ,drvStatusDate = CASE    WHEN eecemplstatus = 'T' THEN EecDateOfTermination
                                WHEN eecemplstatus = 'A' THEN EecDateOfLastHire
                                WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                END
        ,drvSalaryAmount = FORMAT((EecAnnSalary*100), '000000000')
        ,drvMD = 'Y'
        ,drvSalaryEffectiveDate =  [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (EecEEID, EecCOID, '2010-01-01',EecDateOfLastHire) 
        ,drvWeeklySchWorkHours = Case   WHEN EecPayPeriod = 'W' then FORMAT(EecScheduledWorkHrs, '##')  
                                        WHEN EecPayPeriod = 'B' then FORMAT((EecScheduledWorkHrs/2), '##') 
                                        WHEN EecPayPeriod = 'S' then FORMAT(((EecScheduledWorkHrs*24)/52), '##')  
                                        WHEN EecPayPeriod = 'M' then FORMAT(((EecScheduledWorkHrs*12)/52), '##')  
                                        END
        ---please use 99v9 formatting???
        ,drvSTDCoverage = CASE WHEN STD_DedCode = 'STD' then 'ST' END
        ,drvSTDCoverageStartDate = CASE WHEN STD_DedCode = 'STD' AND cast(STD_BenStartDate as date) >= '2023-01-01' THEN STD_BenStartDate 
                                        WHEN STD_DedCode = 'STD' AND cast(STD_BenStartDate as date) < '2023-01-01' THEN '2023-01-01' 
                                        END
        ---Send a minimum effective date of 01012023 MMDDYYYY , check formatting
        ,drvSTDCoverageStopDate = CASE WHEN STD_DedCode = 'STD' THEN STD_BenStopDate  END
        ,drvSTDReportNumber = CASE    WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) not in ('NY','NJ') THEN '0318219'
                                    WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) ='NY' THEN '0243322'
                                    WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) ='NJ' THEN '0243323'
                                    END
        ,drvSTDSubCode = CASE WHEN STD_DedCode = 'STD' THEN '0001' END
        ,drvSTDSubPoint = CASE WHEN STD_DedCode = 'STD' THEN '0001' END
        ,drvSTDContributoryPlanInd = CASE WHEN STD_DedCode = 'STD' THEN 'N' END
        ,drvSTDContributoryPlanPer = CASE WHEN STD_DedCode = 'STD' THEN '100' END
        ,drvSTDContributoryPretaxPer = CASE WHEN STD_DedCode = 'STD' THEN '000' END
        ,drvLTDCoverage = CASE    WHEN LTD_DedCode = 'LTD' AND EecFulltimeOrPartTime in ('F', 'P') then 'LT' 
                                END
        ,drvLTDCoverageStartDate = CASE WHEN LTD_DedCode = 'LTD' AND cast(LTD_BenStartDate as date) >= '2023-01-01' THEN LTD_BenStartDate 
                                        WHEN LTD_DedCode = 'LTD' AND cast(LTD_BenStartDate as date)  < '2023-01-01' THEN '2023-01-01' 
                                        END
        ,drvLTDCoverageStopDate =  CASE WHEN LTD_DedCode = 'LTD' THEN LTD_BenStopDate  END
        ,drvLTDReportNumber =  CASE    WHEN LTD_DedCode = 'LTD' THEN '0243321'
                                    END
        ,drvLTDSubCode = CASE    WHEN LTD_DedCode = 'LTD' THEN '0002'
                                    END
        ,drvLTDSubPoint = CASE    WHEN LTD_DedCode = 'LTD' THEN
                                    CASE WHEN JbcJobCode in ('AF815', 'AF817', 'AF836', 'AF855', 'AF856' ,'AF876') THEN 'TXC1'
                                        WHEN JbcJobFamily in ('AFM') and EecAnnSalary >= 30000.00 THEN 'TXC2'
                                    ELSE 'TXC3'
                                    END
                                END
        ,drvLTDContributoryPlanInd = CASE WHEN LTD_DedCode = 'LTD' THEN 'N' END
        ,drvLTDContributoryPlanPer = CASE WHEN LTD_DedCode = 'LTD' THEN '100' END
        ,drvLTDContributoryPretaxPer = CASE WHEN LTD_DedCode = 'LTD' THEN '000' END
        ,drvNYPFLCoverage = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' THEN 'PF' END
                                --CASE WHEN STD_DedCode = 'STD' AND EepAddressState in ('NY') THEN 'PF' END
        ,drvNYPFLCoverageStartDate = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' AND cast(STD_BenStartDate as date) >= '2023-01-01' THEN STD_BenStartDate 
                                        WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' AND cast(STD_BenStartDate as date) < '2023-01-01' THEN '2023-01-01' 
                                        END
                                        --CASE WHEN STD_DedCode = 'STD' AND EepAddressState in ('NY') AND cast(STD_BenStartDate as date) >= '2023-01-01' THEN STD_BenStartDate 
          --                              WHEN STD_DedCode = 'STD' AND EepAddressState in ('NY') AND cast(STD_BenStartDate as date) < '2023-01-01' THEN '2023-01-01' 
          --                              END
        ,drvNYPFLCoverageStopDate =  CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' THEN STD_BenStopDate  END
                                --CASE WHEN STD_DedCode = 'STD' AND EepAddressState in ('NY') THEN STD_BenStopDate  END
        ,drvPFLReportNumber = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' THEN '0243324' END
                                --CASE WHEN STD_DedCode = 'STD' AND EepAddressState ='NY' THEN '0243324' END
        ,drvPFLSubCode =  CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' THEN '0001' END
                            --CASE WHEN STD_DedCode = 'STD' AND EepAddressState ='NY' THEN '0001' END
        ,drvPFLSubBranch = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) = 'NY' THEN '0001' END
                            --CASE WHEN STD_DedCode = 'STD' AND EepAddressState ='NY' THEN '0001' END
        ,drvJobStatusCode = CASE WHEN EecFulltimeOrPartTime in ('F', 'P') then EecFulltimeOrPartTime END
        ,drvJobStatus =  CASE WHEN EecFulltimeOrPartTime in ('F', 'P') then JHT.EffDate END
        ,drvHoursWorkedinPast12mths = CASE	WHEN PehCurHrs is null THEN '0'
											WHEN PehCurHrs < 1000 THEN  FORMAT(ceiling(PehCurHrs), '0###')
											ELSE FORMAT(ceiling(PehCurHrs), '####') END 
        ,drvPaidFamilyLeaveCovCode =  CASE    WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) IN ('MA','WA') THEN 'FL' END
        ,drvPaidFamilyLeavCovStartDate = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) in ('MA','WA') AND cast(STD_BenStartDate as date)  >= '2023-01-01' THEN STD_BenStartDate 
                                        WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) in ('MA','WA')  AND cast(STD_BenStartDate as date) < '2023-01-01' THEN '2023-01-01'
                                        END
        ,drvPaidFamilyLeavCovStopDate = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) in ('MA','WA') THEN STD_BenStopDate END
        ,drvPaidFamilyLeavGroupNo = CASE WHEN STD_DedCode = 'STD' THEN 
                                        CASE WHEN Substring(EecStateSUI,1,2) in ('MA') THEN '0243325'
                                             WHEN Substring(EecStateSUI,1,2) in ('WA') THEN '0318216'
                                        END
                                    END
        ,drvPaidMedLeaveCovCode =  CASE    WHEN STD_DedCode = 'STD' AND EepAddressState in ('MA','WA') THEN 'ML' END
        ,drvPaidMedLeaveGroupNo = CASE WHEN STD_DedCode = 'STD' THEN 
                                        CASE WHEN Substring(EecStateSUI,1,2) in ('MA') THEN '0243326'
                                             WHEN Substring(EecStateSUI,1,2) in ('WA') THEN '0318217'
                                        END
                                    END
        ,drvPaidMedLeaveSubCode = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) in ('MA','WA') THEN '0001' END
        ,drvPaidMedLeaveSuPoint = CASE WHEN STD_DedCode = 'STD' AND Substring(EecStateSUI,1,2) in ('MA','WA') THEN '0001' END
        ,drvAbsenceManagementCov = CASE WHEN EecEEType = 'CON' THEN '' ELSE 'AM' END
        ,drvAbsenceManagementStartDate = CASE WHEN EecDateOfLastHire < '2023-01-01' THEN '2023-01-01' ELSE EecDateOfLastHire END    
                                            --CASE WHEN IDI_DedCode = 'IDI' AND cast(IDI_BenStartDate as date) >= '2023-01-01' THEN IDI_BenStartDate 
           --                                     WHEN IDI_DedCode = 'IDI' AND cast(IDI_BenStartDate as date) < '2023-01-01' THEN '2023-01-01' 
           --                                     END
        ,drvAbsenceManagementStopDate =  CASE WHEN eecdateoftermination < '2023-01-01' THEN '2023-01-01' ELSE eecdateoftermination END    --  CASE WHEN IDI_DedCode = 'IDI' THEN IDI_BenStopDate END
        ,drvAbsenceManagementReportNo = '0318218'  --CASE WHEN IDI_DedCode = 'IDI' THEN '0318218' END
        ,drvAbsenceManagementSubCode = '0001'  --CASE WHEN IDI_DedCode = 'IDI' THEN '0001' END
        ,drvAbsenceManagementSubPoint = '0001'  --CASE WHEN IDI_DedCode = 'IDI' THEN '0001' END
        ,drvEmployeeOriginalHireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire 
                                        Else EecDateofOriginalHire
                                        END
        ,drvActualWeeklyHoursWorked = Case WHEN EecPayPeriod = 'W' then FORMAT(EecScheduledWorkHrs, '#.00') END
    INTO dbo.U_EIATMETFML_drvTbl
    FROM dbo.U_EIATMETFML_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEEType in ('REB','REF','REG','REH')
                 and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_EIATMETFML_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
  JOIN (
            SELECT BdmEEID, BdmCOID, BdmDepRecID, BdmRecType
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode    
            ,MAX(CASE WHEN BdmDedCode in ('LTD','LTDEL')  THEN BdmDedCode END) AS LTD_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'IDI' THEN BdmDedCode END) AS IDI_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate    
            ,MAX(CASE WHEN BdmDedCode in ('LTD','LTDEL') THEN BdmBenStartDate END) AS LTD_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'IDI' THEN BdmBenStartDate END) AS IDI_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate    
            ,MAX(CASE WHEN BdmDedCode in ('LTD','LTDEL')  THEN BdmBenStopDate END) AS LTD_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'IDI' THEN BdmBenStopDate END) AS IDI_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenOption END) AS STD_BenOption    
            ,MAX(CASE WHEN BdmDedCode in ('LTD','LTDEL') THEN BdmBenOption END) AS LTD_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'IDI' THEN BdmBenOption END) AS IDI_BenOption
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmEEAmt END) AS STD_BenAmt    
            ,MAX(CASE WHEN BdmDedCode in ('LTD','LTDEL')  THEN BdmEEAmt END) AS LTD_BenAmt
            ,MAX(CASE WHEN BdmDedCode = 'IDI' THEN BdmEEAmt END) AS IDI_BenAmt
        FROM  dbo.U_dsi_BDM_EIATMETFML WITH (NOLOCK)
        GROUP BY BdmEEID, BdmCOID, BdmDepRecID, BdmRecType ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpTax WITH (NOLOCK)
        ON EecCoID = EetCoID
        AND EecEEID = EetEEID
        AND eetTaxCode = 'USFIT'
    LEFT JOIN dbo.dsi_fnlib_JobHistoryTable_v2('EjhFullTimeOrPartTime') JHT
        ON JHT.EEID = EecEEID
        AND JHT.CoID = EecCoID
    LEFT JOIN dbo.U_EIATMETFML_PEarHist
        ON PehEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIATMETFML_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_HDR_drvTbl;
    SELECT DISTINCT
         drvCustomerNumber = '0243321'
        ,drvDateFileCreated = GetDate()
    INTO dbo.U_EIATMETFML_HDR_drvTbl
    --FROM dbo.U_EIATMETFML_EEList WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EIATMETFML WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIATMETFML_FTR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETFML_FTR_drvTbl;
    SELECT DISTINCT
         drvTotalRecordCount = count(drvEEID)
    INTO dbo.U_EIATMETFML_FTR_drvTbl
    FROM dbo.U_EIATMETFML_drvTbl WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EIATMETFML WITH (NOLOCK)
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
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEIATMETFML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIATMETFML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIATMETFML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209271'
       ,expStartPerControl     = '202209271'
       ,expLastEndPerControl   = '202210049'
       ,expEndPerControl       = '202210049'
WHERE expFormatCode = 'EIATMETFML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIATMETFML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIATMETFML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIATMETFML' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIATMETFML'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIATMETFML'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATMETFML', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIATMETFML', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATMETFML', 'UseFileName', 'V', 'Y'


-- End ripout