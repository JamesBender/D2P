/**********************************************************************************

EBAUNYLFML: NYLife FMLA Export

FormatCode:     EBAUNYLFML
Project:        NYLife FMLA Export
Client ID:      BAU1001
Date/time:      2022-06-08 10:05:27.040
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP3DB02
Database:       ULTIPRO_WPBACOI
Web Filename:   BAU1001_F03C1_EEHISTORY_EBAUNYLFML_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBAUNYLFML_SavePath') IS NOT NULL DROP TABLE dbo.U_EBAUNYLFML_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBAUNYLFML'


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
WHERE FormatCode = 'EBAUNYLFML'
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
WHERE ExpFormatCode = 'EBAUNYLFML'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBAUNYLFML')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBAUNYLFML'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBAUNYLFML'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBAUNYLFML'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBAUNYLFML'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBAUNYLFML'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBAUNYLFML'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBAUNYLFML'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBAUNYLFML'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBAUNYLFML'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBAUNYLFML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBAUNYLFML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBAUNYLFML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAUNYLFML];
GO
IF OBJECT_ID('U_EBAUNYLFML_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_Trailer];
GO
IF OBJECT_ID('U_EBAUNYLFML_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_PEarHist];
GO
IF OBJECT_ID('U_EBAUNYLFML_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_PDedHist];
GO
IF OBJECT_ID('U_EBAUNYLFML_Header') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_Header];
GO
IF OBJECT_ID('U_EBAUNYLFML_File') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_File];
GO
IF OBJECT_ID('U_EBAUNYLFML_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_EEList];
GO
IF OBJECT_ID('U_EBAUNYLFML_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_drvTbl];
GO
IF OBJECT_ID('U_EBAUNYLFML_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBAUNYLFML_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EBAUNYLFML') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBAUNYLFML];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBAUNYLFML','NYLife FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EBAUNYLFMLZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAUNYLFMLZ0','2','H','01','1',NULL,'drvFileRecordIdentifier',NULL,NULL,'"drvFileRecordIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAUNYLFMLZ0','15','H','01','2',NULL,'drvDUNSNumber',NULL,NULL,'"drvDUNSNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAUNYLFMLZ0','1','H','01','3',NULL,'drvProductionTestIndicator',NULL,NULL,'"drvProductionTestIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAUNYLFMLZ0','8','H','01','4',NULL,'drvFileCreationDate',NULL,NULL,'"drvFileCreationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAUNYLFMLZ0','35','H','01','5',NULL,'drvEmployerName',NULL,NULL,'"drvEmployerName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAUNYLFMLZ0','1','H','01','6',NULL,'drvFileType',NULL,NULL,'"drvFileType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAUNYLFMLZ0','2','H','01','7',NULL,'drvLife&AccidentFileMaintenanceReasonType',NULL,NULL,'"drvLifeAccidentFileMaintenanceReasonType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAUNYLFMLZ0','1','H','01','8',NULL,'drvDisabilityFileMaintenanceReasonType',NULL,NULL,'"drvDisabilityFileMaintenanceReasonType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAUNYLFMLZ0','2935','H','01','9',NULL,'drvReserved',NULL,NULL,'"drvReserved"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAUNYLFMLZ0','9','D','10','1',NULL,'drvEmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAUNYLFMLZ0','11','D','10','2',NULL,'drvEmployeeIdentificationNumber',NULL,NULL,'"drvEmployeeIdentificationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAUNYLFMLZ0','10','D','10','3',NULL,'drvReserved_Emp',NULL,NULL,'"drvReserved_Emp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAUNYLFMLZ0','4','D','10','4',NULL,'drvEligibilityBillingLocation',NULL,NULL,'"drvEligibilityBillingLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAUNYLFMLZ0','9','D','10','5',NULL,'drvNewYorkLifeInternalCompanyNumber',NULL,NULL,'"drvNewYorkLifeInternalCompanyNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAUNYLFMLZ0','9','D','10','6',NULL,'drvEmployeeGroupNumberID',NULL,NULL,'"drvEmployeeGroupNumberID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAUNYLFMLZ0','3','D','10','7',NULL,'drvEmployeeClassCode',NULL,NULL,'"drvEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAUNYLFMLZ0','8','D','10','8',NULL,'drvClassChangeEffectiveDate',NULL,NULL,'"drvClassChangeEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAUNYLFMLZ0','10','D','10','9',NULL,'drvReserved_Emp2',NULL,NULL,'"drvReserved_Emp2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAUNYLFMLZ0','35','D','10','10',NULL,'drvEmployeeLastName',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAUNYLFMLZ0','25','D','10','11',NULL,'drvEmployeeFirstName',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAUNYLFMLZ0','15','D','10','12',NULL,'drvEmployeeMiddleName',NULL,NULL,'"drvEmployeeMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAUNYLFMLZ0','10','D','10','13',NULL,'drvEmployeeNamePrefix',NULL,NULL,'"drvEmployeeNamePrefix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAUNYLFMLZ0','10','D','10','14',NULL,'drvEmployeeNameSuffix',NULL,NULL,'"drvEmployeeNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAUNYLFMLZ0','8','D','10','15',NULL,'drvEmployeeDateofBirth',NULL,NULL,'"drvEmployeeDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAUNYLFMLZ0','1','D','10','16',NULL,'drvEmployeeGender',NULL,NULL,'"drvEmployeeGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAUNYLFMLZ0','1','D','10','17',NULL,'drvEmployeeMaritalStatus',NULL,NULL,'"drvEmployeeMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAUNYLFMLZ0','4','D','10','18',NULL,'drvEmployeesPINNumber',NULL,NULL,'"drvEmployeesPINNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAUNYLFMLZ0','1','D','10','19',NULL,'drvEmployeeSmokerStatus',NULL,NULL,'"drvEmployeeSmokerStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAUNYLFMLZ0','34','D','10','20',NULL,'drvEmployeeEmailAddress',NULL,NULL,'"drvEmployeeEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAUNYLFMLZ0','1','D','10','21',NULL,'drvReserved_Emp3',NULL,NULL,'"drvReserved_Emp3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAUNYLFMLZ0','34','D','10','22',NULL,'drvSupplementalEmailAddress1',NULL,NULL,'"drvSupplementalEmailAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAUNYLFMLZ0','1','D','10','23',NULL,'drvEmail1Type',NULL,NULL,'"drvEmail1Type"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAUNYLFMLZ0','34','D','10','24',NULL,'drvSupplementalEmailAddress2',NULL,NULL,'"drvSupplementalEmailAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAUNYLFMLZ0','1','D','10','25',NULL,'drvEmail2Type',NULL,NULL,'"drvEmail2Type"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAUNYLFMLZ0','35','D','10','26',NULL,'drvEmployeeMailAddress1',NULL,NULL,'"drvEmployeeMailAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBAUNYLFMLZ0','35','D','10','27',NULL,'drvEmployeeMailAddress2',NULL,NULL,'"drvEmployeeMailAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBAUNYLFMLZ0','30','D','10','28',NULL,'drvEmployeeMailCity',NULL,NULL,'"drvEmployeeMailCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBAUNYLFMLZ0','2','D','10','29',NULL,'drvEmployeeMailState',NULL,NULL,'"drvEmployeeMailState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBAUNYLFMLZ0','10','D','10','30',NULL,'drvEmployeeMailZipCode',NULL,NULL,'"drvEmployeeMailZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBAUNYLFMLZ0','30','D','10','31',NULL,'drvEmployeeCountry',NULL,NULL,'"drvEmployeeCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBAUNYLFMLZ0','2','D','10','32',NULL,'drvCountryCode',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBAUNYLFMLZ0','2','D','10','33',NULL,'drvEmployeeResidenceState',NULL,NULL,'"drvEmployeeResidenceState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBAUNYLFMLZ0','3','D','10','34',NULL,'drvProvince',NULL,NULL,'"drvProvince"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBAUNYLFMLZ0','1','D','10','35',NULL,'drvTypeofAddress',NULL,NULL,'"drvTypeofAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBAUNYLFMLZ0','8','D','10','36',NULL,'drvEffectiveDateoftheAddress',NULL,NULL,'"drvEffectiveDateoftheAddress"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBAUNYLFMLZ0','20','D','10','37',NULL,'drvPhoneNumber',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBAUNYLFMLZ0','1','D','10','38',NULL,'drvPhoneUsagecode',NULL,NULL,'"drvPhoneUsagecode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBAUNYLFMLZ0','45','D','10','39',NULL,'drvReserved_Emp4',NULL,NULL,'"drvReserved_Emp4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBAUNYLFMLZ0','2','D','10','40',NULL,'drvReserved_Emp5',NULL,NULL,'"drvReserved_Emp5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBAUNYLFMLZ0','2','D','10','41',NULL,'drvEmploymentStatusCode',NULL,NULL,'"drvEmploymentStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBAUNYLFMLZ0','8','D','10','42',NULL,'drvEmployeeStatusEffectiveDate',NULL,NULL,'"drvEmployeeStatusEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBAUNYLFMLZ0','1','D','10','43',NULL,'drvEmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBAUNYLFMLZ0','8','D','10','44',NULL,'drvEmployeeDateofHire',NULL,NULL,'"drvEmployeeDateofHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBAUNYLFMLZ0','8','D','10','45',NULL,'drvAdjustedServiceDate',NULL,NULL,'"drvAdjustedServiceDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBAUNYLFMLZ0','20','D','10','46',NULL,'drvEmployeeWorksiteLocation',NULL,NULL,'"drvEmployeeWorksiteLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBAUNYLFMLZ0','9','D','10','47',NULL,'drvEmployeeAnnualSalaryforLifeBenefit',NULL,NULL,'"drvEmployeeAnnualSalaryforLifeBenefit"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBAUNYLFMLZ0','1','D','10','48',NULL,'drvModeForDisabilityEarnings',NULL,NULL,'"drvModeForDisabilityEarnings"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBAUNYLFMLZ0','9','D','10','49',NULL,'drvEmployeeEarningsforDisabilityProducts',NULL,NULL,'"drvEmployeeEarningsforDisabilityProducts"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBAUNYLFMLZ0','8','D','10','50',NULL,'drvLastEarningsChangeDate',NULL,NULL,'"drvLastEarningsChangeDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBAUNYLFMLZ0','1','D','10','51',NULL,'drvSalariedIndicator',NULL,NULL,'"drvSalariedIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBAUNYLFMLZ0','1','D','10','52',NULL,'drvFullTimeIndicator',NULL,NULL,'"drvFullTimeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBAUNYLFMLZ0','1','D','10','53',NULL,'drvCommissionBonusIndicator',NULL,NULL,'"drvCommissionBonusIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBAUNYLFMLZ0','1','D','10','54',NULL,'drvWorkAtHomeIndicator',NULL,NULL,'"drvWorkAtHomeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBAUNYLFMLZ0','1','D','10','55',NULL,'drvExemptIndicator',NULL,NULL,'"drvExemptIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBAUNYLFMLZ0','5','D','10','56',NULL,'drvNumberofHoursWorkedPerWeek',NULL,NULL,'"drvNumberofHoursWorkedPerWeek"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBAUNYLFMLZ0','2','D','10','57',NULL,'drvTaxFilingStateCode',NULL,NULL,'"drvTaxFilingStateCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBAUNYLFMLZ0','9','D','10','58',NULL,'drvOccupationClassificationCode',NULL,NULL,'"drvOccupationClassificationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBAUNYLFMLZ0','65','D','10','59',NULL,'drvJobDescription',NULL,NULL,'"drvJobDescription"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBAUNYLFMLZ0','12','D','10','60',NULL,'drvCompanyJobCode',NULL,NULL,'"drvCompanyJobCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBAUNYLFMLZ0','30','D','10','61',NULL,'drvOrganizationName',NULL,NULL,'"drvOrganizationName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBAUNYLFMLZ0','15','D','10','62',NULL,'drvClientOrganizationCode',NULL,NULL,'"drvClientOrganizationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBAUNYLFMLZ0','12','D','10','63',NULL,'drvClientLocationCode',NULL,NULL,'"drvClientLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBAUNYLFMLZ0','10','D','10','64',NULL,'drvUnionLocalNumber',NULL,NULL,'"drvUnionLocalNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBAUNYLFMLZ0','30','D','10','65',NULL,'drvUnionLocalName',NULL,NULL,'"drvUnionLocalName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBAUNYLFMLZ0','1','D','10','66',NULL,'drvUnionIndicator',NULL,NULL,'"drvUnionIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBAUNYLFMLZ0','1','D','10','67',NULL,'drvHealthPlanType',NULL,NULL,'"drvHealthPlanType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBAUNYLFMLZ0','30','D','10','68',NULL,'drvHealthPlanDescription',NULL,NULL,'"drvHealthPlanDescription"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBAUNYLFMLZ0','6','D','10','69',NULL,'drvAccruedSickTime',NULL,NULL,'"drvAccruedSickTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBAUNYLFMLZ0','1','D','10','70',NULL,'drvKeyEmployeeIndicator',NULL,NULL,'"drvKeyEmployeeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBAUNYLFMLZ0','4','D','10','71',NULL,'drvActualAnnualHours',NULL,NULL,'"drvActualAnnualHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBAUNYLFMLZ0','2','D','10','72',NULL,'drvWorkState',NULL,NULL,'"drvWorkState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBAUNYLFMLZ0','50','D','10','73',NULL,'drvReservedEmp_6',NULL,NULL,'"drvReservedEmp_6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBAUNYLFMLZ0','2','D','10','74',NULL,'drvMaintenanceReasonCode',NULL,NULL,'"drvMaintenanceReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBAUNYLFMLZ0','8','D','10','75',NULL,'drvMaintenanceDate',NULL,NULL,'"drvMaintenanceDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBAUNYLFMLZ0','9','D','10','76',NULL,'drvSpouseSSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBAUNYLFMLZ0','35','D','10','77',NULL,'drvSpouseLastName',NULL,NULL,'"drvSpouseLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBAUNYLFMLZ0','25','D','10','78',NULL,'drvSpouseFirstName',NULL,NULL,'"drvSpouseFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EBAUNYLFMLZ0','15','D','10','79',NULL,'drvSpouseMiddleName',NULL,NULL,'"drvSpouseMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EBAUNYLFMLZ0','10','D','10','80',NULL,'drvSpouseNamePrefix',NULL,NULL,'"drvSpouseNamePrefix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EBAUNYLFMLZ0','10','D','10','81',NULL,'drvSpouseNameSuffix',NULL,NULL,'"drvSpouseNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EBAUNYLFMLZ0','8','D','10','82',NULL,'drvSpouseDateofBirth',NULL,NULL,'"drvSpouseDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EBAUNYLFMLZ0','1','D','10','83',NULL,'drvSpouseGender',NULL,NULL,'"drvSpouseGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EBAUNYLFMLZ0','1','D','10','84',NULL,'drvSpouseSmokerStatus',NULL,NULL,'"drvSpouseSmokerStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EBAUNYLFMLZ0','20','D','10','85',NULL,'drvReserved_Emp7',NULL,NULL,'"drvReserved_Emp7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EBAUNYLFMLZ0','2','D','10','86',NULL,'drvNumberofproducts',NULL,NULL,'"drvNumberofproducts"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EBAUNYLFMLZ0','4','D','10','87',NULL,'drvCoveragecode1',NULL,NULL,'"drvCoveragecode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EBAUNYLFMLZ0','9','D','10','88',NULL,'drvReserved1_1',NULL,NULL,'"drvReserved1_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EBAUNYLFMLZ0','3','D','10','89',NULL,'drvPolicySymbol1',NULL,NULL,'"drvPolicySymbol1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EBAUNYLFMLZ0','7','D','10','90',NULL,'drvPolicyNumber1',NULL,NULL,'"drvPolicyNumber1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EBAUNYLFMLZ0','8','D','10','91',NULL,'drvOriginalBenefitEffectiveDate1',NULL,NULL,'"drvOriginalBenefitEffDate1"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EBAUNYLFMLZ0','5','D','10','92',NULL,'drvIssuedBenefitsPercent1',NULL,NULL,'"drvIssuedBenefitsPercent1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EBAUNYLFMLZ0','9','D','10','93',NULL,'drvIssuedBenefitsAmount1',NULL,NULL,'"drvIssuedBenefitsAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EBAUNYLFMLZ0','5','D','10','94',NULL,'drvEmployeeContributionPercent1',NULL,NULL,'"drvEmployeeContribPercent1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EBAUNYLFMLZ0','8','D','10','95',NULL,'drvVoluntaryBenefitEffDate1',NULL,NULL,'"drvVoluntaryBenefitEffDate1"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EBAUNYLFMLZ0','1','D','10','96',NULL,'drvPostTaxIndicator1',NULL,NULL,'"drvPostTaxIndicator1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EBAUNYLFMLZ0','30','D','10','97',NULL,'drvBenefitDescription1',NULL,NULL,'"drvBenefitDescription1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EBAUNYLFMLZ0','30','D','10','98',NULL,'drvReserved1_2',NULL,NULL,'"drvReserved1_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EBAUNYLFMLZ0','4','D','10','99',NULL,'drvCoveragecode2',NULL,NULL,'"drvCoveragecode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EBAUNYLFMLZ0','9','D','10','100',NULL,'drvReserved2_1',NULL,NULL,'"drvReserved2_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EBAUNYLFMLZ0','3','D','10','101',NULL,'drvPolicySymbol2',NULL,NULL,'"drvPolicySymbol2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EBAUNYLFMLZ0','7','D','10','102',NULL,'drvPolicyNumber2',NULL,NULL,'"drvPolicyNumber2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EBAUNYLFMLZ0','8','D','10','103',NULL,'drvOriginalBenefitEffectiveDate2',NULL,NULL,'"drvOriginalBenefitEffDate2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EBAUNYLFMLZ0','5','D','10','104',NULL,'drvIssuedBenefitsPercent2',NULL,NULL,'"drvIssuedBenefitsPercent2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EBAUNYLFMLZ0','9','D','10','105',NULL,'drvIssuedBenefitsAmount2',NULL,NULL,'"drvIssuedBenefitsAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EBAUNYLFMLZ0','5','D','10','106',NULL,'drvEmployeeContributionPercent2',NULL,NULL,'"drvEmployeeContribPercent2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EBAUNYLFMLZ0','8','D','10','107',NULL,'drvVoluntaryBenefitEffectiveDate2',NULL,NULL,'"drvVoluntaryBenefitEffDate2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EBAUNYLFMLZ0','1','D','10','108',NULL,'drvPostTaxIndicator2',NULL,NULL,'"drvPostTaxIndicator2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EBAUNYLFMLZ0','30','D','10','109',NULL,'drvBenefitDescription2',NULL,NULL,'"drvBenefitDescription2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EBAUNYLFMLZ0','30','D','10','110',NULL,'drvReserved2_2',NULL,NULL,'"drvReserved2_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EBAUNYLFMLZ0','4','D','10','111',NULL,'drvCoveragecode3',NULL,NULL,'"drvCoveragecode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EBAUNYLFMLZ0','9','D','10','112',NULL,'drvReserved3_1',NULL,NULL,'"drvReserved3_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EBAUNYLFMLZ0','3','D','10','113',NULL,'drvPolicySymbol3',NULL,NULL,'"drvPolicySymbol3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EBAUNYLFMLZ0','7','D','10','114',NULL,'drvPolicyNumber3',NULL,NULL,'"drvPolicyNumber3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EBAUNYLFMLZ0','8','D','10','115',NULL,'drvOriginalBenefitEffectiveDate3',NULL,NULL,'"drvOriginalBenefitEffDate3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EBAUNYLFMLZ0','5','D','10','116',NULL,'drvIssuedBenefitsPercent3',NULL,NULL,'"drvIssuedBenefitsPercent3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EBAUNYLFMLZ0','9','D','10','117',NULL,'drvIssuedBenefitsAmount3',NULL,NULL,'"drvIssuedBenefitsAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EBAUNYLFMLZ0','5','D','10','118',NULL,'drvEmployeeContributionPercent3',NULL,NULL,'"drvEmployeeContribPercent3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EBAUNYLFMLZ0','8','D','10','119',NULL,'drvVoluntaryBenefitEffectiveDate3',NULL,NULL,'"drvVoluntaryBenefitEffDate3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EBAUNYLFMLZ0','1','D','10','120',NULL,'drvPostTaxIndicator3',NULL,NULL,'"drvPostTaxIndicator3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EBAUNYLFMLZ0','30','D','10','121',NULL,'drvBenefitDescription3',NULL,NULL,'"drvBenefitDescription3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EBAUNYLFMLZ0','30','D','10','122',NULL,'drvReserved3_2',NULL,NULL,'"drvReserved3_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EBAUNYLFMLZ0','4','D','10','123',NULL,'drvCoveragecode4',NULL,NULL,'"drvCoveragecode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EBAUNYLFMLZ0','9','D','10','124',NULL,'drvReserved4_1',NULL,NULL,'"drvReserved4_1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EBAUNYLFMLZ0','3','D','10','125',NULL,'drvPolicySymbol4',NULL,NULL,'"drvPolicySymbol4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EBAUNYLFMLZ0','7','D','10','126',NULL,'drvPolicyNumber4',NULL,NULL,'"drvPolicyNumber4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EBAUNYLFMLZ0','8','D','10','127',NULL,'drvOriginalBenefitEffectiveDate4',NULL,NULL,'"drvOriginalBenefitEffDate4"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EBAUNYLFMLZ0','5','D','10','128',NULL,'drvIssuedBenefitsPercent4',NULL,NULL,'"drvIssuedBenefitsPercent4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EBAUNYLFMLZ0','9','D','10','129',NULL,'drvIssuedBenefitsAmount4',NULL,NULL,'"drvIssuedBenefitsAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EBAUNYLFMLZ0','5','D','10','130',NULL,'drvEmployeeContributionPercent4',NULL,NULL,'"drvEmployeeContribPercent4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EBAUNYLFMLZ0','8','D','10','131',NULL,'drvVoluntaryBenefitEffectiveDate4',NULL,NULL,'"drvVoluntaryBenefitEffDate4"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EBAUNYLFMLZ0','1','D','10','132',NULL,'drvPostTaxIndicator4',NULL,NULL,'"drvPostTaxIndicator4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EBAUNYLFMLZ0','30','D','10','133',NULL,'drvBenefitDescription4',NULL,NULL,'"drvBenefitDescription4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EBAUNYLFMLZ0','30','D','10','134',NULL,'drvReserved4_2',NULL,NULL,'"drvReserved4_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EBAUNYLFMLZ0','2','D','10','135',NULL,'drvNumberofProducts_2',NULL,NULL,'"drvNumberofProducts_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EBAUNYLFMLZ0','3','D','10','136',NULL,'drvProductCode',NULL,NULL,'"drvProductCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EBAUNYLFMLZ0','3','D','10','137',NULL,'drvPolicySymbol',NULL,NULL,'"drvPolicySymbol"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EBAUNYLFMLZ0','6','D','10','138',NULL,'drvPolicyNumber',NULL,NULL,'"drvPolicyNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EBAUNYLFMLZ0','1','D','10','139',NULL,'drvAssignmentIndicator',NULL,NULL,'"drvAssignmentIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EBAUNYLFMLZ0','9','D','10','140',NULL,'drvEmployeePreviousAmount',NULL,NULL,'"drvEmployeePreviousAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EBAUNYLFMLZ0','4','D','10','141',NULL,'drvEmployeePreviousSalaryMultiple',NULL,NULL,'"drvEmpPreviousSalaryMultiple"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EBAUNYLFMLZ0','9','D','10','142',NULL,'drvSpousePreviousAmount',NULL,NULL,'"drvSpousePreviousAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EBAUNYLFMLZ0','9','D','10','143',NULL,'drvChildPreviousAmount',NULL,NULL,'"drvChildPreviousAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EBAUNYLFMLZ0','9','D','10','144',NULL,'drvEmployeeIssuedAmount',NULL,NULL,'"drvEmployeeIssuedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EBAUNYLFMLZ0','4','D','10','145',NULL,'drvEmployeeIssuedSalaryMultiple',NULL,NULL,'"drvEmpIssuedSalaryMultiple"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EBAUNYLFMLZ0','9','D','10','146',NULL,'drvSpouseIssuedAmount',NULL,NULL,'"drvSpouseIssuedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EBAUNYLFMLZ0','9','D','10','147',NULL,'drvChildIssuedAmount',NULL,NULL,'"drvChildIssuedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EBAUNYLFMLZ0','9','D','10','148',NULL,'drvEmployeeAppliedAmount',NULL,NULL,'"drvEmployeeAppliedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EBAUNYLFMLZ0','4','D','10','149',NULL,'drvEmployeeAppliedSalaryMultiple',NULL,NULL,'"drvEmpAppliedSalaryMultiple"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EBAUNYLFMLZ0','9','D','10','150',NULL,'drvSpouseAppliedAmount',NULL,NULL,'"drvSpouseAppliedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EBAUNYLFMLZ0','9','D','10','151',NULL,'drvChildAppliedAmount',NULL,NULL,'"drvChildAppliedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EBAUNYLFMLZ0','9','D','10','152',NULL,'drvEmployeePendingAmount',NULL,NULL,'"drvEmployeePendingAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EBAUNYLFMLZ0','4','D','10','153',NULL,'drvEmployeePendingSalaryMultiple',NULL,NULL,'"drvEmpPendingSalaryMultiple"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EBAUNYLFMLZ0','9','D','10','154',NULL,'drvSpousePendingAmount',NULL,NULL,'"drvSpousePendingAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EBAUNYLFMLZ0','9','D','10','155',NULL,'drvChildPendingAmount',NULL,NULL,'"drvChildPendingAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EBAUNYLFMLZ0','9','D','10','156',NULL,'drvEmployeeMonthlyCashAccumulationFundAmount',NULL,NULL,'"drvEmpMonthlyCashAccuFundAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EBAUNYLFMLZ0','9','D','10','157',NULL,'drvSpouseMonthlyCashAccumulationFundAmount',NULL,NULL,'"drvSpsMonthlyCashAccFundAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EBAUNYLFMLZ0','1','D','10','158',NULL,'drvEmployeeAIOIndicator',NULL,NULL,'"drvEmployeeAIOIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EBAUNYLFMLZ0','1','D','10','159',NULL,'drvEmployeeADDADBIndicator',NULL,NULL,'"drvEmployeeADDADBIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EBAUNYLFMLZ0','1','D','10','160',NULL,'drvSpouseADDADBIndicator',NULL,NULL,'"drvSpouseADDADBIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EBAUNYLFMLZ0','1','D','10','161',NULL,'drvEmployeeAPBIndicator',NULL,NULL,'"drvEmployeeAPBIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EBAUNYLFMLZ0','1','D','10','162',NULL,'drvSpouseAPBIndicator',NULL,NULL,'"drvSpouseAPBIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EBAUNYLFMLZ0','1','D','10','163',NULL,'drvPAIplanoption',NULL,NULL,'"drvPAIplanoption"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EBAUNYLFMLZ0','925','D','10','164',NULL,'drvReserved',NULL,NULL,'"drvReserved"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EBAUNYLFMLZ0','7','D','10','165',NULL,'drvHWDeduction01',NULL,NULL,'"drvHWDeduction01"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EBAUNYLFMLZ0','7','D','10','166',NULL,'drvHWDeduction02',NULL,NULL,'"drvHWDeduction02"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EBAUNYLFMLZ0','7','D','10','167',NULL,'drvHWDeduction03',NULL,NULL,'"drvHWDeduction03"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EBAUNYLFMLZ0','7','D','10','168',NULL,'drvHWDeduction04',NULL,NULL,'"drvHWDeduction04"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EBAUNYLFMLZ0','7','D','10','169',NULL,'drvHWDeduction05',NULL,NULL,'"drvHWDeduction05"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EBAUNYLFMLZ0','7','D','10','170',NULL,'drvHWDeduction06',NULL,NULL,'"drvHWDeduction06"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EBAUNYLFMLZ0','7','D','10','171',NULL,'drvHWDeduction07',NULL,NULL,'"drvHWDeduction07"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EBAUNYLFMLZ0','7','D','10','172',NULL,'drvHWDeduction08',NULL,NULL,'"drvHWDeduction08"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EBAUNYLFMLZ0','7','D','10','173',NULL,'drvHWDeduction09',NULL,NULL,'"drvHWDeduction09"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EBAUNYLFMLZ0','7','D','10','174',NULL,'drvHWDeduction10',NULL,NULL,'"drvHWDeduction10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EBAUNYLFMLZ0','7','D','10','175',NULL,'drvHWDeduction11',NULL,NULL,'"drvHWDeduction11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EBAUNYLFMLZ0','7','D','10','176',NULL,'drvHWDeduction12',NULL,NULL,'"drvHWDeduction12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EBAUNYLFMLZ0','178','D','10','177',NULL,'drvReserved_Emp8',NULL,NULL,'"drvReserved_Emp8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EBAUNYLFMLZ0','50','D','10','178',NULL,'drvExtendedEmployeeEmailAddress',NULL,NULL,'"drvExtendedEmpEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EBAUNYLFMLZ0','50','D','10','179',NULL,'drvExtendedSupplementalEmailAddress2',NULL,NULL,'"drvExtendedSuppEmailAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EBAUNYLFMLZ0','50','D','10','180',NULL,'drvExtendedSupplementalEmailAddress1',NULL,NULL,'"drvExtSuppllEmailAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAUNYLFMLZ0','2','T','90','1',NULL,'drvFileRecordIdentifier',NULL,NULL,'"drvFileRecordIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAUNYLFMLZ0','15','T','90','2',NULL,'drvDUNSNumber',NULL,NULL,'"drvDUNSNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAUNYLFMLZ0','1','T','90','3',NULL,'drvReserved',NULL,NULL,'"drvReserved"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAUNYLFMLZ0','9','T','90','4',NULL,'drvNumberofRecords',NULL,NULL,'"drvNumberofRecords"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAUNYLFMLZ0','2973','T','90','5',NULL,'drvReserved',NULL,NULL,'"drvReserved2"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBAUNYLFML_20220608.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107289','EMPEXPORT','OEACTIVE',NULL,'EBAUNYLFML',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','NZNYC,NZNW3',NULL,NULL,NULL,'Passive Open Enrollment Export','202201159','EMPEXPORT','OEPASSIVE','Dec 21 2021  1:24PM','EBAUNYLFML',NULL,NULL,NULL,'202201159','Jan 15 2022 12:00AM','Dec 30 1899 12:00AM','202112211','1221','','','202112211',dbo.fn_GetTimedKey(),NULL,'us3lKiDOE1000A',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'NYLife FMLA Export','202107289','EMPEXPORT','ONDEM_XOE',NULL,'EBAUNYLFML',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',QX8A8',NULL,NULL,NULL,'NYLife FMLA - Wed @ 3PM','202107289','EMPEXPORT','SCH_EBAUNY',NULL,'EBAUNYLFML',NULL,NULL,NULL,'202203249','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202203171',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','QX8A8,QX8IW',NULL,NULL,NULL,'NYLife FMLA Export-Test','202205139','EMPEXPORT','TEST_XOE','May 12 2022 12:00AM','EBAUNYLFML',NULL,NULL,NULL,'202205139','May 13 2022 12:00AM','Dec 30 1899 12:00AM','202205131','1217','','','202205131',dbo.fn_GetTimedKey(),NULL,'us3mLaBAU1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAUNYLFML','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAUNYLFML','H01','dbo.U_EBAUNYLFML_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAUNYLFML','D10','dbo.U_EBAUNYLFML_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAUNYLFML','T90','dbo.U_EBAUNYLFML_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBAUNYLFML
-----------

IF OBJECT_ID('U_dsi_BDM_EBAUNYLFML') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBAUNYLFML] (
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
-- Create table U_EBAUNYLFML_DedList
-----------

IF OBJECT_ID('U_EBAUNYLFML_DedList') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBAUNYLFML_drvTbl
-----------

IF OBJECT_ID('U_EBAUNYLFML_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeIdentificationNumber] char(9) NULL,
    [drvReserved_Emp] varchar(1) NOT NULL,
    [drvEligibilityBillingLocation] varchar(1) NOT NULL,
    [drvNewYorkLifeInternalCompanyNumber] varchar(9) NOT NULL,
    [drvEmployeeGroupNumberID] varchar(9) NOT NULL,
    [drvEmployeeClassCode] varchar(1) NOT NULL,
    [drvClassChangeEffectiveDate] varchar(1) NOT NULL,
    [drvReserved_Emp2] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(50) NULL,
    [drvEmployeeNamePrefix] varchar(1) NOT NULL,
    [drvEmployeeNameSuffix] varchar(1) NOT NULL,
    [drvEmployeeDateofBirth] datetime NULL,
    [drvEmployeeGender] char(1) NULL,
    [drvEmployeeMaritalStatus] varchar(1) NOT NULL,
    [drvEmployeesPINNumber] varchar(1) NOT NULL,
    [drvEmployeeSmokerStatus] varchar(1) NOT NULL,
    [drvEmployeeEmailAddress] varchar(1) NOT NULL,
    [drvReserved_Emp3] varchar(1) NOT NULL,
    [drvSupplementalEmailAddress1] varchar(1) NOT NULL,
    [drvEmail1Type] varchar(1) NOT NULL,
    [drvSupplementalEmailAddress2] varchar(1) NOT NULL,
    [drvEmail2Type] varchar(1) NOT NULL,
    [drvEmployeeMailAddress1] varchar(255) NULL,
    [drvEmployeeMailAddress2] varchar(255) NULL,
    [drvEmployeeMailCity] varchar(255) NULL,
    [drvEmployeeMailState] varchar(255) NULL,
    [drvEmployeeMailZipCode] varchar(50) NULL,
    [drvEmployeeCountry] varchar(2) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvEmployeeResidenceState] varchar(1) NOT NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvTypeofAddress] varchar(1) NOT NULL,
    [drvEffectiveDateoftheAddress] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvPhoneUsagecode] varchar(1) NOT NULL,
    [drvReserved_Emp4] varchar(1) NOT NULL,
    [drvReserved_Emp5] varchar(1) NOT NULL,
    [drvEmploymentStatusCode] varchar(2) NULL,
    [drvEmployeeStatusEffectiveDate] datetime NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvEmployeeDateofHire] datetime NULL,
    [drvAdjustedServiceDate] datetime NULL,
    [drvEmployeeWorksiteLocation] varchar(1) NOT NULL,
    [drvEmployeeAnnualSalaryforLifeBenefit] varchar(1) NOT NULL,
    [drvModeForDisabilityEarnings] varchar(1) NOT NULL,
    [drvEmployeeEarningsforDisabilityProducts] varchar(30) NULL,
    [drvLastEarningsChangeDate] varchar(1) NOT NULL,
    [drvSalariedIndicator] varchar(1) NOT NULL,
    [drvFullTimeIndicator] varchar(1) NOT NULL,
    [drvCommissionBonusIndicator] varchar(1) NOT NULL,
    [drvWorkAtHomeIndicator] varchar(1) NOT NULL,
    [drvExemptIndicator] varchar(1) NOT NULL,
    [drvNumberofHoursWorkedPerWeek] varchar(30) NULL,
    [drvTaxFilingStateCode] varchar(255) NULL,
    [drvOccupationClassificationCode] varchar(1) NOT NULL,
    [drvJobDescription] varchar(1) NOT NULL,
    [drvCompanyJobCode] varchar(1) NOT NULL,
    [drvOrganizationName] varchar(1) NOT NULL,
    [drvClientOrganizationCode] varchar(1) NOT NULL,
    [drvClientLocationCode] varchar(1) NOT NULL,
    [drvUnionLocalNumber] varchar(1) NOT NULL,
    [drvUnionLocalName] varchar(1) NOT NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvHealthPlanType] varchar(1) NOT NULL,
    [drvHealthPlanDescription] varchar(1) NOT NULL,
    [drvAccruedSickTime] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvActualAnnualHours] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvReservedEmp_6] varchar(1) NOT NULL,
    [drvMaintenanceReasonCode] varchar(1) NOT NULL,
    [drvMaintenanceDate] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSpouseLastName] varchar(1) NOT NULL,
    [drvSpouseFirstName] varchar(1) NOT NULL,
    [drvSpouseMiddleName] varchar(1) NOT NULL,
    [drvSpouseNamePrefix] varchar(1) NOT NULL,
    [drvSpouseNameSuffix] varchar(1) NOT NULL,
    [drvSpouseDateofBirth] varchar(1) NOT NULL,
    [drvSpouseGender] varchar(1) NOT NULL,
    [drvSpouseSmokerStatus] varchar(1) NOT NULL,
    [drvReserved_Emp7] varchar(1) NOT NULL,
    [drvNumberofproducts] varchar(2) NOT NULL,
    [drvCoveragecode1] varchar(4) NOT NULL,
    [drvReserved1_1] varchar(1) NOT NULL,
    [drvPolicySymbol1] varchar(4) NOT NULL,
    [drvPolicyNumber1] varchar(7) NOT NULL,
    [drvOriginalBenefitEffDate1] varchar(1) NOT NULL,
    [drvIssuedBenefitsPercent1] varchar(1) NOT NULL,
    [drvIssuedBenefitsAmount1] varchar(1) NOT NULL,
    [drvEmployeeContribPercent1] varchar(1) NOT NULL,
    [drvVoluntaryBenefitEffDate1] varchar(1) NOT NULL,
    [drvPostTaxIndicator1] varchar(1) NOT NULL,
    [drvBenefitDescription1] varchar(1) NULL,
    [drvReserved1_2] varchar(1) NOT NULL,
    [drvCoveragecode2] varchar(3) NULL,
    [drvReserved2_1] varchar(1) NOT NULL,
    [drvPolicySymbol2] varchar(3) NULL,
    [drvPolicyNumber2] varchar(7) NULL,
    [drvOriginalBenefitEffDate2] datetime NULL,
    [drvIssuedBenefitsPercent2] varchar(5) NULL,
    [drvIssuedBenefitsAmount2] varchar(1) NOT NULL,
    [drvEmployeeContribPercent2] varchar(5) NULL,
    [drvVoluntaryBenefitEffDate2] varchar(1) NOT NULL,
    [drvPostTaxIndicator2] varchar(1) NULL,
    [drvBenefitDescription2] varchar(7) NULL,
    [drvReserved2_2] varchar(1) NOT NULL,
    [drvCoveragecode3] varchar(3) NULL,
    [drvReserved3_1] varchar(1) NOT NULL,
    [drvPolicySymbol3] varchar(3) NULL,
    [drvPolicyNumber3] varchar(7) NULL,
    [drvOriginalBenefitEffDate3] datetime NULL,
    [drvIssuedBenefitsPercent3] varchar(5) NULL,
    [drvIssuedBenefitsAmount3] varchar(1) NOT NULL,
    [drvEmployeeContribPercent3] varchar(5) NULL,
    [drvVoluntaryBenefitEffDate3] varchar(1) NOT NULL,
    [drvPostTaxIndicator3] varchar(1) NULL,
    [drvBenefitDescription3] varchar(7) NULL,
    [drvReserved3_2] varchar(1) NOT NULL,
    [drvCoveragecode4] varchar(1) NOT NULL,
    [drvReserved4_1] varchar(1) NOT NULL,
    [drvPolicySymbol4] varchar(1) NOT NULL,
    [drvPolicyNumber4] varchar(1) NOT NULL,
    [drvOriginalBenefitEffDate4] varchar(1) NOT NULL,
    [drvIssuedBenefitsPercent4] varchar(1) NOT NULL,
    [drvIssuedBenefitsAmount4] varchar(1) NOT NULL,
    [drvEmployeeContribPercent4] varchar(1) NOT NULL,
    [drvVoluntaryBenefitEffDate4] varchar(1) NOT NULL,
    [drvPostTaxIndicator4] varchar(1) NOT NULL,
    [drvBenefitDescription4] varchar(1) NOT NULL,
    [drvReserved4_2] varchar(1) NOT NULL,
    [drvNumberofProducts_2] varchar(1) NOT NULL,
    [drvProductCode] varchar(1) NOT NULL,
    [drvPolicySymbol] varchar(1) NOT NULL,
    [drvPolicyNumber] varchar(1) NOT NULL,
    [drvAssignmentIndicator] varchar(1) NOT NULL,
    [drvEmployeePreviousAmount] varchar(1) NOT NULL,
    [drvEmpPreviousSalaryMultiple] varchar(1) NOT NULL,
    [drvSpousePreviousAmount] varchar(1) NOT NULL,
    [drvChildPreviousAmount] varchar(1) NOT NULL,
    [drvEmployeeIssuedAmount] varchar(1) NOT NULL,
    [drvEmpIssuedSalaryMultiple] varchar(1) NOT NULL,
    [drvSpouseIssuedAmount] varchar(1) NOT NULL,
    [drvChildIssuedAmount] varchar(1) NOT NULL,
    [drvEmployeeAppliedAmount] varchar(1) NOT NULL,
    [drvEmpAppliedSalaryMultiple] varchar(1) NOT NULL,
    [drvSpouseAppliedAmount] varchar(1) NOT NULL,
    [drvChildAppliedAmount] varchar(1) NOT NULL,
    [drvEmployeePendingAmount] varchar(1) NOT NULL,
    [drvEmpPendingSalaryMultiple] varchar(1) NOT NULL,
    [drvSpousePendingAmount] varchar(1) NOT NULL,
    [drvChildPendingAmount] varchar(1) NOT NULL,
    [drvEmpMonthlyCashAccuFundAmt] varchar(1) NOT NULL,
    [drvSpsMonthlyCashAccFundAmt] varchar(1) NOT NULL,
    [drvEmployeeAIOIndicator] varchar(1) NOT NULL,
    [drvEmployeeADDADBIndicator] varchar(1) NOT NULL,
    [drvSpouseADDADBIndicator] varchar(1) NOT NULL,
    [drvEmployeeAPBIndicator] varchar(1) NOT NULL,
    [drvSpouseAPBIndicator] varchar(1) NOT NULL,
    [drvPAIplanoption] varchar(1) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvHWDeduction01] varchar(1) NOT NULL,
    [drvHWDeduction02] varchar(1) NOT NULL,
    [drvHWDeduction03] varchar(1) NOT NULL,
    [drvHWDeduction04] varchar(1) NOT NULL,
    [drvHWDeduction05] varchar(1) NOT NULL,
    [drvHWDeduction06] varchar(1) NOT NULL,
    [drvHWDeduction07] varchar(1) NOT NULL,
    [drvHWDeduction08] varchar(1) NOT NULL,
    [drvHWDeduction09] varchar(1) NOT NULL,
    [drvHWDeduction10] varchar(1) NOT NULL,
    [drvHWDeduction11] varchar(1) NOT NULL,
    [drvHWDeduction12] varchar(1) NOT NULL,
    [drvReserved_Emp8] varchar(1) NOT NULL,
    [drvExtendedEmpEmailAddress] varchar(50) NULL,
    [drvExtendedSuppEmailAddress2] varchar(1) NOT NULL,
    [drvExtSuppllEmailAddress1] varchar(1) NOT NULL
);

-----------
-- Create table U_EBAUNYLFML_EEList
-----------

IF OBJECT_ID('U_EBAUNYLFML_EEList') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBAUNYLFML_File
-----------

IF OBJECT_ID('U_EBAUNYLFML_File') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EBAUNYLFML_Header
-----------

IF OBJECT_ID('U_EBAUNYLFML_Header') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_Header] (
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvProductionTestIndicator] varchar(1) NOT NULL,
    [drvFileCreationDate] datetime NOT NULL,
    [drvEmployerName] varchar(17) NOT NULL,
    [drvFileType] varchar(1) NOT NULL,
    [drvLifeAccidentFileMaintenanceReasonType] varchar(1) NOT NULL,
    [drvDisabilityFileMaintenanceReasonType] varchar(1) NOT NULL,
    [drvReserved] varchar(1) NOT NULL
);

-----------
-- Create table U_EBAUNYLFML_PDedHist
-----------

IF OBJECT_ID('U_EBAUNYLFML_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_PDedHist] (
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
-- Create table U_EBAUNYLFML_PEarHist
-----------

IF OBJECT_ID('U_EBAUNYLFML_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_PEarHist] (
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
-- Create table U_EBAUNYLFML_Trailer
-----------

IF OBJECT_ID('U_EBAUNYLFML_Trailer') IS NULL
CREATE TABLE [dbo].[U_EBAUNYLFML_Trailer] (
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvNumberofRecords] varchar(24) NULL,
    [drvReserved2] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAUNYLFML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bauer Compressor

Created By: Marco Lagrosa
Business Analyst: Curlin Beck
Create Date: 03/29/2022
Service Request Number: TekP-2022-01-21-01

Purpose: NYLife FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBAUNYLFML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBAUNYLFML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBAUNYLFML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBAUNYLFML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBAUNYLFML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAUNYLFML', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAUNYLFML', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAUNYLFML', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAUNYLFML', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAUNYLFML', 'SCH_EBAUNY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBAUNYLFML';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBAUNYLFML', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBAUNYLFML';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBAUNYLFML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBAUNYLFML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE FROM dbo.U_EBAUNYLFML_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID) and xEEID IN (Select distinct eeceeid from dbo.EmpComp where eeceetype not in ('REG','INT'));

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD,FMLA';

    IF OBJECT_ID('U_EBAUNYLFML_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFML_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBAUNYLFML_DedList
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
    IF OBJECT_ID('U_EBAUNYLFML_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFML_PDedHist;
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
    INTO dbo.U_EBAUNYLFML_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBAUNYLFML_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EBAUNYLFML_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFML_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl and pehEarnCode not in ('JURY', 'PFMLH', 'PFMLS', 'PSLH', 'PTO', 'PTOC', 'SPTO', 'SICK') THEN PehCurHrs ELSE 0.00 END)
        --PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl NOT IN  THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EBAUNYLFML_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN EarnCode
        ON ErnEarnCode = pehEarnCode
    WHERE  PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    
    --Audit Table
    IF OBJECT_ID('U_EBAUNYLFMLAuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFMLAuditFields;
    CREATE TABLE dbo.U_EBAUNYLFMLAuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EBAUNYLFMLAuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EBAUNYLFMLAudit','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFMLAudit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EBAUNYLFMLAudit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EBAUNYLFMLAuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EBAUNYLFMLAuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate  AND @EndDate ;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBAUNYLFMLAudit ON dbo.U_EBAUNYLFMLAudit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBAUNYLFML_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAUNYLFML_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFML_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeIdentificationNumber = EecEmpNo
        ,drvReserved_Emp = ''
        ,drvEligibilityBillingLocation = ''
        ,drvNewYorkLifeInternalCompanyNumber = '000222142'
        ,drvEmployeeGroupNumberID = '000031173'
        ,drvEmployeeClassCode = ''
        ,drvClassChangeEffectiveDate = ''
        ,drvReserved_Emp2 = ''
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleName = EepNameMiddle
        ,drvEmployeeNamePrefix = ''
        ,drvEmployeeNameSuffix = ''--NULLIF(EepNameSuffix,'Z')
        ,drvEmployeeDateofBirth = EepDateOfBirth
        ,drvEmployeeGender = EepGender
        ,drvEmployeeMaritalStatus =   'K' 
        ,drvEmployeesPINNumber = ''
        ,drvEmployeeSmokerStatus = ''
        ,drvEmployeeEmailAddress = ''
        ,drvReserved_Emp3 = ''
        ,drvSupplementalEmailAddress1 = ''
        ,drvEmail1Type = ''
        ,drvSupplementalEmailAddress2 = ''--dbo.dsi_fnlib_GetSupervisorField('',  (Select top 1 OrgManagerId  from dbo.OrgLevel WITH (NOLOCK) Where OrgLvl = 1 and OrgCode = EecOrgLvl1), 'AddressEMail')    
        ,drvEmail2Type = ''
        ,drvEmployeeMailAddress1 = EepAddressLine1
        ,drvEmployeeMailAddress2 = EepAddressLine2
        ,drvEmployeeMailCity = EepAddressCity
        ,drvEmployeeMailState = EepAddressState
        ,drvEmployeeMailZipCode = CASE WHEN LEN (EepAddressZipCode) <= 5 then EepAddressZipCode ELSE LEFT(EepAddressZipCode,5) + '-' + RIGHT(EepAddressZipCode,4) END
        ,drvEmployeeCountry = 'US'
        ,drvCountryCode = 'US'
        ,drvEmployeeResidenceState = ''
        ,drvProvince = ''
        ,drvTypeofAddress = 'R'
        ,drvEffectiveDateoftheAddress = ''
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvPhoneUsagecode = 'R'
        ,drvReserved_Emp4 = ''
        ,drvReserved_Emp5 = ''
        ,drvEmploymentStatusCode = CASE WHEN EecEmplStatus = 'L' THEN 'L1'
                                        WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '202' THEN 'RT'
                                                 WHEN EecTermReason = '203' THEN 'DI'
                                                 WHEN EecTermReason not in  ('202','203') THEN 'TE'
                                            END
                                        ELSE 'AC'
                                   END
        ,drvEmployeeStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T'  THEN EecDateOfTermination
                                            WHEN EecEmplStatus = 'L'  THEN  EecEmplStatusStartDate
                                    END
        ,drvEmployeeType = 'P' --CASE WHEN EecEEType = 'REG' THEN 'P' ELSE 'T' END
        ,drvEmployeeDateofHire = EecDateOfLastHire
        ,drvAdjustedServiceDate = EecDateOfOriginalHire
        ,drvEmployeeWorksiteLocation = ''
        ,drvEmployeeAnnualSalaryforLifeBenefit = ''
        ,drvModeForDisabilityEarnings = 'A'
        ,drvEmployeeEarningsforDisabilityProducts = CASE WHEN EecAnnSalary IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,9,0))  ELSE '000000000' END
        ,drvLastEarningsChangeDate = ''
        ,drvSalariedIndicator = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Y' ELSE 'N' END
        ,drvFullTimeIndicator = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Y' ELSE  'N' END
        ,drvCommissionBonusIndicator = 'N'
        ,drvWorkAtHomeIndicator = ''
        ,drvExemptIndicator = CASE WHEN JobHist.EjhFLSACategory = 'E' THEN 'Y' ELSE 'N' END
        ,drvNumberofHoursWorkedPerWeek = CONVERT(VARCHAR,dbo.dsi_fnPadZero((CASE WHEN EecFullTimeORPartTime = 'F' THEN 40 ELSE EecScheduledWorkHrs END) *100 ,5,0))
                                           
        ,drvTaxFilingStateCode = LocAddressState
        ,drvOccupationClassificationCode = ''
        ,drvJobDescription = ''--dbo.dsi_fnRemoveChars('.,()',(Select top 1 JbcDesc  from dbo.JobCode WITH (NOLOCK) Where JbcJobCode = EecJobCode)) 
        ,drvCompanyJobCode = ''
        ,drvOrganizationName = ''--(Select top 1 OrgDesc  from dbo.OrgLevel WITH (NOLOCK) Where OrgLvl = 1 and OrgCode = EecOrgLvl1) --dbo.dsi_fnRemoveChars('.,',UPPER(cmpcompanyname))
        ,drvClientOrganizationCode = ''--EecOrgLvl1
        ,drvClientLocationCode = ''--eeclocation
        ,drvUnionLocalNumber = ''
        ,drvUnionLocalName = ''
        ,drvUnionIndicator = ''
        ,drvHealthPlanType = ''
        ,drvHealthPlanDescription = ''
        ,drvAccruedSickTime = ''
        ,drvKeyEmployeeIndicator = ''--CASE WHEN EecIsKeyEmployee = 'Y' THEN 'Y' ELSE 'N' END
        ,drvActualAnnualHours = ''--CONVERT(VARCHAR,dbo.dsi_fnPadZero( CONVERT(DECIMAL(4,0),PehCurHrs),4,0))  
        ,drvWorkState = eepAddressState --''--(Select LocAddressState from dbo.Location where LocCode = EecLocation)
        ,drvReservedEmp_6 = ''
        ,drvMaintenanceReasonCode = ''
        ,drvMaintenanceDate = ''
        ,drvSpouseSSN = ''
        ,drvSpouseLastName = ''
        ,drvSpouseFirstName = ''
        ,drvSpouseMiddleName = ''
        ,drvSpouseNamePrefix = ''
        ,drvSpouseNameSuffix = ''
        ,drvSpouseDateofBirth = ''
        ,drvSpouseGender = ''
        ,drvSpouseSmokerStatus = ''
        ,drvReserved_Emp7 = ''
        ,drvNumberofproducts = '03'
        ,drvCoveragecode1 = 'FMLA'
        ,drvReserved1_1 = ''
        ,drvPolicySymbol1 = 'FMLA'
        ,drvPolicyNumber1 = '0613439'
        ,drvOriginalBenefitEffDate1 = ''
        ,drvIssuedBenefitsPercent1 = ''
        ,drvIssuedBenefitsAmount1 = ''
        ,drvEmployeeContribPercent1 = ''
        ,drvVoluntaryBenefitEffDate1 = ''
        ,drvPostTaxIndicator1 = ''
        --If Location = BCI or BSF, it should be 1, if Location = BPTG, BFL, BNY or BTX, it should be 2.
        ,drvBenefitDescription1 = CASE WHEN eecLocation in ('BCI','BSF') THEN '1'
                                       WHEN eecLocation in ('BPTG','BFL','BNY','BTX') THEN '2'
                                END
        ,drvReserved1_2 = ''
        ,drvCoveragecode2 = CASE WHEN STD is not null THEN 'STD' END
        ,drvReserved2_1 = ''
        ,drvPolicySymbol2 =  CASE WHEN STD is not null THEN 'SGD' END
        ,drvPolicyNumber2 =  CASE WHEN STD is not null THEN CASE WHEN EecLocation = 'BNY' THEN '0601159' ELSE '0613439' END END
        ,drvOriginalBenefitEffDate2 = CASE WHEN STD is not null THEN STD_STARTDATE END
        ,drvIssuedBenefitsPercent2 = CASE WHEN STD is not null THEN '06667' END
        ,drvIssuedBenefitsAmount2 = '' -- If EedDedCode='STD' then EedBenAMt If EedDedCode='LTD' then EedBenAMt
        ,drvEmployeeContribPercent2 = CASE WHEN STD is not null THEN '07500' END
        ,drvVoluntaryBenefitEffDate2 = ''
        ,drvPostTaxIndicator2 = CASE WHEN STD is not null THEN 'Y' END
        ,drvBenefitDescription2 = CASE WHEN STD is not null  THEN
                                        'Class 1'--CASE WHEN EecLocation = 'BNY' THEN '1' ELSE '2' END
                                    END
        ,drvReserved2_2 = ''
        ,drvCoveragecode3 = CASE WHEN LTD is not null THEN 'LTD' END
        ,drvReserved3_1 = ''
        ,drvPolicySymbol3 = CASE WHEN LTD is not null THEN 'SGD' END
        ,drvPolicyNumber3 = CASE WHEN LTD is not null THEN '0613440' END
        ,drvOriginalBenefitEffDate3 = CASE WHEN LTD is not null THEN LTD_STARTDATE END
        ,drvIssuedBenefitsPercent3 = CASE WHEN LTD is not null THEN '06000' END
        ,drvIssuedBenefitsAmount3 = ''
        ,drvEmployeeContribPercent3 = CASE WHEN LTD is not null THEN '00000' END
        ,drvVoluntaryBenefitEffDate3 = ''
        ,drvPostTaxIndicator3 = CASE WHEN LTD is not null THEN 'N' END
        ,drvBenefitDescription3 = CASE WHEN LTD is not null THEN 'Class 1' END
        ,drvReserved3_2 = ''
        ,drvCoveragecode4 = ''
        ,drvReserved4_1 = ''
        ,drvPolicySymbol4 = ''
        ,drvPolicyNumber4 = ''
        ,drvOriginalBenefitEffDate4 = ''
        ,drvIssuedBenefitsPercent4 = ''
        ,drvIssuedBenefitsAmount4 = ''
        ,drvEmployeeContribPercent4 = ''
        ,drvVoluntaryBenefitEffDate4 = ''
        ,drvPostTaxIndicator4 = ''
        ,drvBenefitDescription4 = ''
        ,drvReserved4_2 = ''
        ,drvNumberofProducts_2 = ''
        ,drvProductCode = ''
        ,drvPolicySymbol = ''
        ,drvPolicyNumber = ''
        ,drvAssignmentIndicator = ''
        ,drvEmployeePreviousAmount = ''
        ,drvEmpPreviousSalaryMultiple = ''
        ,drvSpousePreviousAmount = ''
        ,drvChildPreviousAmount = ''
        ,drvEmployeeIssuedAmount = ''
        ,drvEmpIssuedSalaryMultiple = ''
        ,drvSpouseIssuedAmount = ''
        ,drvChildIssuedAmount = ''
        ,drvEmployeeAppliedAmount = ''
        ,drvEmpAppliedSalaryMultiple = ''
        ,drvSpouseAppliedAmount = ''
        ,drvChildAppliedAmount = ''
        ,drvEmployeePendingAmount = ''
        ,drvEmpPendingSalaryMultiple = ''
        ,drvSpousePendingAmount = ''
        ,drvChildPendingAmount = ''
        ,drvEmpMonthlyCashAccuFundAmt = ''
        ,drvSpsMonthlyCashAccFundAmt = ''
        ,drvEmployeeAIOIndicator = ''
        ,drvEmployeeADDADBIndicator = ''
        ,drvSpouseADDADBIndicator = ''
        ,drvEmployeeAPBIndicator = ''
        ,drvSpouseAPBIndicator = ''
        ,drvPAIplanoption = ''
        ,drvReserved = ''
        ,drvHWDeduction01 = ''
        ,drvHWDeduction02 = ''
        ,drvHWDeduction03 = ''
        ,drvHWDeduction04 = ''
        ,drvHWDeduction05 = ''
        ,drvHWDeduction06 = ''
        ,drvHWDeduction07 = ''
        ,drvHWDeduction08 = ''
        ,drvHWDeduction09 = ''
        ,drvHWDeduction10 = ''
        ,drvHWDeduction11 = ''
        ,drvHWDeduction12 = ''
        ,drvReserved_Emp8 = ''
        ,drvExtendedEmpEmailAddress = EepAddressEmail 
        ,drvExtendedSuppEmailAddress2 = ''
        ,drvExtSuppllEmailAddress1 = ''
    INTO dbo.U_EBAUNYLFML_drvTbl
    FROM dbo.U_EBAUNYLFML_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EBAUNYLFMLAudit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Company WITH (NOLOCK)
        on cmpcoid = xcoid
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,STD = MAX((CASE WHEN bdmDedCode IN('STD') then bdmDedCode END))
            ,LTD = MAX((CASE WHEN bdmDedCode IN('LTD')   then bdmDedCode END))
            ,FMLA = MAX((CASE WHEN bdmDedCode IN('FMLA') then bdmDedCode END))

            ,STD_STARTDATE = MAX((CASE WHEN bdmDedCode IN('STD')   then BdmBenStartDate END))
            ,LTD_STARTDATE = MAX((CASE WHEN bdmDedCode IN('LTD')   then BdmBenStartDate END))
            ,FMLA_STARTDATE = MAX((CASE WHEN bdmDedCode IN('FMLA')   then BdmBenStartDate END))

            ,STD_STOPDATE = MAX((CASE WHEN bdmDedCode IN('STD')  then BdmBenStopDate END))
            ,LTD_STOPDATE = MAX((CASE WHEN bdmDedCode IN('LTD')  then BdmBenStopDate END))
            ,FMLA_STOPDATE = MAX((CASE WHEN bdmDedCode IN('FMLA')  then BdmBenStopDate END))

            from dbo.U_dsi_BDM_EBAUNYLFML WITH (NOLOCK) 
            group by bdmEEID,bdmcoid) as BdmConsolidated
        ON xEEID =  bdmEEID 
        AND XCOID = bdmCOID
    LEFT JOIN dbo.U_EBAUNYLFML_PEarHist
        on PehEEID =  xeeid
    LEFT JOIN (Select * from  (
Select EjhHourlyPayRate,EjhFLSACategory,Ejheeid,ROW_NUMBER() OVER(PARTITION BY ejheeid ORDER BY auditkey DESC) as Row_Num from dbo.EmphJob WITH (NOLOCK)
) A where Row_Num = 1) as JobHist
    on JobHist.ejheeid = xeeid
    LEFT JOIN dbo.Location  WITH (NOLOCK)
        on LocCode =  eecLocation

    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBAUNYLFML_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFML_Header;
    SELECT DISTINCT
         drvFileRecordIdentifier = 'HD'
        ,drvDUNSNumber = '084142249'
        ,drvProductionTestIndicator = 'P'
		--CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' ELSE 'P' END
        ,drvFileCreationDate = GETDATE()
        ,drvEmployerName = 'Bauer Compressors'
        ,drvFileType = '2'
        ,drvLifeAccidentFileMaintenanceReasonType = ''
        ,drvDisabilityFileMaintenanceReasonType = '2'
        ,drvReserved = ''
    INTO dbo.U_EBAUNYLFML_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBAUNYLFML_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EBAUNYLFML_Trailer;
    SELECT DISTINCT
         drvFileRecordIdentifier = 'TR'
        ,drvDUNSNumber = '084142249'
        ,drvReserved = ''
        ,drvNumberofRecords = dbo.dsi_fnPadZero(CAST( (Select count(*) from dbo.U_EBAUNYLFML_drvTbl) as varchar),9,0) 
        ,drvReserved2 = ''
    INTO dbo.U_EBAUNYLFML_Trailer
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
ALTER VIEW dbo.dsi_vwEBAUNYLFML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAUNYLFML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBAUNYLFML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107211'
       ,expStartPerControl     = '202107211'
       ,expLastEndPerControl   = '202107289'
       ,expEndPerControl       = '202107289'
WHERE expFormatCode = 'EBAUNYLFML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBAUNYLFML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBAUNYLFML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBAUNYLFML' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBAUNYLFML'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBAUNYLFML'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAUNYLFML', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBAUNYLFML', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAUNYLFML', 'UseFileName', 'V', 'Y'


-- End ripout