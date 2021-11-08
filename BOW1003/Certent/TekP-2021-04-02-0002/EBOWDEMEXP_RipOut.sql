/**********************************************************************************

EBOWDEMEXP: Bowman Certent Demographic

FormatCode:     EBOWDEMEXP
Project:        Bowman Certent Demographic
Client ID:      BOW1003
Date/time:      2021-11-08 18:34:17.357
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP2DB01
Database:       ULTIPRO_WPBOWMN
Web Filename:   BOW1003_941BF_EEHISTORY_EBOWDEMEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBOWDEMEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EBOWDEMEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBOWDEMEXP'


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
WHERE FormatCode = 'EBOWDEMEXP'
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
WHERE ExpFormatCode = 'EBOWDEMEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBOWDEMEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBOWDEMEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBOWDEMEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBOWDEMEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBOWDEMEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBOWDEMEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBOWDEMEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBOWDEMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBOWDEMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBOWDEMEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBOWDEMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBOWDEMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBOWDEMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBOWDEMEXP];
GO
IF OBJECT_ID('U_EBOWDEMEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_Trailer];
GO
IF OBJECT_ID('U_EBOWDEMEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_PEarHist];
GO
IF OBJECT_ID('U_EBOWDEMEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_PDedHist];
GO
IF OBJECT_ID('U_EBOWDEMEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_Header];
GO
IF OBJECT_ID('U_EBOWDEMEXP_HdrTrl') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_HdrTrl];
GO
IF OBJECT_ID('U_EBOWDEMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_File];
GO
IF OBJECT_ID('U_EBOWDEMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_EEList];
GO
IF OBJECT_ID('U_EBOWDEMEXP_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_drvTbl_CT];
GO
IF OBJECT_ID('U_EBOWDEMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_drvTbl];
GO
IF OBJECT_ID('U_EBOWDEMEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_DedList];
GO
IF OBJECT_ID('U_EBOWDEMEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_AuditFields];
GO
IF OBJECT_ID('U_EBOWDEMEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBOWDEMEXP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBOWDEMEXP','Bowman Certent Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EBOWDEMEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOWDEMEXPZ0','50','H','01','1',NULL,'EquityholderCode/ParticipantID',NULL,NULL,'"hrvEquholdCode_PartID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOWDEMEXPZ0','50','H','01','2',NULL,'SSN/Tax ID',NULL,NULL,'"hrvSSN_Tax_ID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOWDEMEXPZ0','50','H','01','3',NULL,'FirstName',NULL,NULL,'"hrvFirstName "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOWDEMEXPZ0','50','H','01','4',NULL,'LastName',NULL,NULL,'"hrvLastName "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOWDEMEXPZ0','50','H','01','5',NULL,'UserCode1',NULL,NULL,'"hrvUserCode1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOWDEMEXPZ0','50','H','01','6',NULL,'HomeAddressLine1',NULL,NULL,'"hrvHomeAddressLine1 "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOWDEMEXPZ0','50','H','01','7',NULL,'HomeAddressLine2',NULL,NULL,'"hrvHomeAddressLine2 "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOWDEMEXPZ0','50','H','01','8',NULL,'HomeDistrictorRegion',NULL,NULL,'"hrvHomeDistRegion "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBOWDEMEXPZ0','50','H','01','9',NULL,'HomeCity',NULL,NULL,'"hrvHomeCity "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBOWDEMEXPZ0','50','H','01','10',NULL,'CurrentStateorProvince',NULL,NULL,'"hrvCurrStateorProv"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBOWDEMEXPZ0','50','H','01','11',NULL,'CurrentPostalCode',NULL,NULL,'"hrvCurrPostalCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBOWDEMEXPZ0','50','H','01','12',NULL,'CurrentCountry',NULL,NULL,'"hrvCurrCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBOWDEMEXPZ0','50','H','01','13',NULL,'UserCode2',NULL,NULL,'"hrvUserCode2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBOWDEMEXPZ0','50','H','01','14',NULL,'Current/WorkEmailAddress',NULL,NULL,'"hrvCurr_WorkEmailAdd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBOWDEMEXPZ0','50','H','01','15',NULL,'UserCode3',NULL,NULL,'"hrvUserCode3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBOWDEMEXPZ0','50','H','01','16',NULL,'DateRelationshipStarted',NULL,NULL,'"hrvDateRelatshipStart"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBOWDEMEXPZ0','50','H','01','17',NULL,'TerminationDate',NULL,NULL,'"hrvTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBOWDEMEXPZ0','50','H','01','18',NULL,'TerminationType',NULL,NULL,'"hrvTerminationType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBOWDEMEXPZ0','50','H','01','19',NULL,'Section16Employee',NULL,NULL,'"hrvSect16Emp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBOWDEMEXPZ0','50','H','01','20',NULL,'CurrentJobTitle',NULL,NULL,'"hrvCurrJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBOWDEMEXPZ0','50','H','01','21',NULL,'CurrentDepartment',NULL,NULL,'"hrvCurrDept"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBOWDEMEXPZ0','50','H','01','22',NULL,'CurrentSection',NULL,NULL,'"hrvCurrSection"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBOWDEMEXPZ0','50','H','01','23',NULL,'CurrentBranch',NULL,NULL,'"hrvCurrBranch"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBOWDEMEXPZ0','50','H','01','24',NULL,'SubsidiaryCode',NULL,NULL,'"hrvSubsCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBOWDEMEXPZ0','50','H','01','25',NULL,'ExperienceGroup',NULL,NULL,'"hrvExpGroup  "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBOWDEMEXPZ0','50','H','01','26',NULL,'UserCode4',NULL,NULL,'"hrvUserCode4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBOWDEMEXPZ0','50','H','01','27',NULL,'DateofBirth',NULL,NULL,'"hrvDateofBirth"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBOWDEMEXPZ0','50','H','01','28',NULL,'AsofDate',NULL,NULL,'"hrvAsofDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBOWDEMEXPZ0','50','H','01','29',NULL,'AnnualSalary',NULL,NULL,'"hrvAnnualSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBOWDEMEXPZ0','50','H','01','30',NULL,'RetirementEligibilityDate',NULL,NULL,'"hrvRetEligDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBOWDEMEXPZ0','50','H','01','31',NULL,'RelationshiptoCompany',NULL,NULL,'"hrvRelattoCompany"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBOWDEMEXPZ0','50','D','10','1',NULL,'EquityholderCode/ParticipantID',NULL,NULL,'"drvEqholderCd_PartID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBOWDEMEXPZ0','50','D','10','2',NULL,'SSN/Tax ID',NULL,NULL,'"drvSSN_TaxID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBOWDEMEXPZ0','50','D','10','3',NULL,'FirstName',NULL,NULL,'"drvFirstName "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBOWDEMEXPZ0','50','D','10','4',NULL,'LastName',NULL,NULL,'"drvLastName "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBOWDEMEXPZ0','50','D','10','5',NULL,'UserCode1',NULL,NULL,'"drvUserCode1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBOWDEMEXPZ0','50','D','10','6',NULL,'HomeAddressLine1',NULL,NULL,'"drvHomeAddressLine1 "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBOWDEMEXPZ0','50','D','10','7',NULL,'HomeAddressLine2',NULL,NULL,'"drvHomeAddressLine2 "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBOWDEMEXPZ0','50','D','10','8',NULL,'HomeDistrictorRegion',NULL,NULL,'"drvHomeDistrictorRegion "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBOWDEMEXPZ0','50','D','10','9',NULL,'HomeCity',NULL,NULL,'"drvHomeCity "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBOWDEMEXPZ0','50','D','10','10',NULL,'CurrentStateorProvince',NULL,NULL,'"drvCurrentStateorProvince"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBOWDEMEXPZ0','50','D','10','11',NULL,'CurrentPostalCode',NULL,NULL,'"drvCurrentPostalCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBOWDEMEXPZ0','50','D','10','12',NULL,'CurrentCountry',NULL,NULL,'"drvCurrentCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBOWDEMEXPZ0','50','D','10','13',NULL,'UserCode2',NULL,NULL,'"drvUserCode2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBOWDEMEXPZ0','50','D','10','14',NULL,'Current/WorkEmailAddress',NULL,NULL,'"drvCurr_WorkEmailAddr"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBOWDEMEXPZ0','50','D','10','15',NULL,'UserCode3',NULL,NULL,'"drvUserCode3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBOWDEMEXPZ0','50','D','10','16',NULL,'DateRelationshipStarted',NULL,NULL,'"drvDateRelatStarted"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBOWDEMEXPZ0','50','D','10','17',NULL,'TerminationDate',NULL,NULL,'"drvTermDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBOWDEMEXPZ0','50','D','10','18',NULL,'TerminationType',NULL,NULL,'"drvTermType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBOWDEMEXPZ0','50','D','10','19',NULL,'Section16Employee',NULL,NULL,'"drvSect16Emp"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBOWDEMEXPZ0','50','D','10','20',NULL,'CurrentJobTitle',NULL,NULL,'"drvCurrJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBOWDEMEXPZ0','50','D','10','21',NULL,'CurrentDepartment',NULL,NULL,'"drvCurrDept"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBOWDEMEXPZ0','50','D','10','22',NULL,'CurrentSection',NULL,NULL,'"drvCurrSection"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBOWDEMEXPZ0','50','D','10','23',NULL,'CurrentBranch',NULL,NULL,'"drvCurrBranch"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBOWDEMEXPZ0','50','D','10','24',NULL,'SubsidiaryCode',NULL,NULL,'"drvSubsCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBOWDEMEXPZ0','50','D','10','25',NULL,'ExperienceGroup',NULL,NULL,'"drvExpGroup  "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBOWDEMEXPZ0','50','D','10','26',NULL,'UserCode4',NULL,NULL,'"drvUserCode4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBOWDEMEXPZ0','50','D','10','27',NULL,'DateofBirth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBOWDEMEXPZ0','50','D','10','28',NULL,'AsofDate',NULL,NULL,'"drvAsofDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBOWDEMEXPZ0','50','D','10','29',NULL,'AnnualSalary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBOWDEMEXPZ0','50','D','10','30',NULL,'RetirementEligibilityDate',NULL,NULL,'"drvRetEligibilityDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBOWDEMEXPZ0','50','D','10','31',NULL,'RelationshiptoCompany',NULL,NULL,'"drvReltoCompany"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBOWDEMEXP_20211108.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Bowman Certent Demographic','202108319','EMPEXPORT','ONDEM_XOE','Aug 23 2021  1:12PM','EBOWDEMEXP',NULL,NULL,NULL,'202108319','Aug 13 2021 12:00AM','Dec 30 1899 12:00AM','202108011','134','','','202108011',dbo.fn_GetTimedKey(),NULL,'us3rVaBOW1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Bowman Certent Demograph-Sched','202108319','EMPEXPORT','SCH_EBOWDE',NULL,'EBOWDEMEXP',NULL,NULL,NULL,'202108319','Aug  6 2021 10:41AM','Aug  6 2021 10:41AM','202108011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Bowman Certent Demograph-Test','202110191','EMPEXPORT','TEST_XOE','Oct 20 2021 10:16AM','EBOWDEMEXP',NULL,NULL,NULL,'202110191','Oct 19 2021 12:00AM','Dec 30 1899 12:00AM','202110051','956','','','202110051',dbo.fn_GetTimedKey(),NULL,'us3rVaBOW1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWDEMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWDEMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWDEMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBOWDEMEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOWDEMEXP','H01','dbo.U_EBOWDEMEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBOWDEMEXP','D10','dbo.U_EBOWDEMEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBOWDEMEXP_Audit
-----------

IF OBJECT_ID('U_EBOWDEMEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EBOWDEMEXP_AuditFields
-----------

IF OBJECT_ID('U_EBOWDEMEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBOWDEMEXP_DedList
-----------

IF OBJECT_ID('U_EBOWDEMEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBOWDEMEXP_drvTbl
-----------

IF OBJECT_ID('U_EBOWDEMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEqholderCd_PartID] char(9) NULL,
    [drvSSN_TaxID] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvUserCode1] varchar(100) NULL,
    [drvHomeAddressLine1] varchar(255) NULL,
    [drvHomeAddressLine2] varchar(255) NULL,
    [drvHomeDistrictorRegion] varchar(1) NOT NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvCurrentStateorProvince] varchar(255) NULL,
    [drvCurrentPostalCode] varchar(50) NULL,
    [drvCurrentCountry] char(3) NULL,
    [drvUserCode2] varchar(255) NULL,
    [drvCurr_WorkEmailAddr] varchar(50) NULL,
    [drvUserCode3] varchar(50) NULL,
    [drvDateRelatStarted] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvTermType] varchar(25) NULL,
	drvSect16Emp varchar(10) NULL,
    [drvCurrJobTitle] varchar(150) NULL,
    [drvCurrDept] varchar(5) NULL,
    [drvCurrSection] varchar(25) NULL,
    [drvCurrBranch] varchar(24) NULL,
    [drvSubsCode] varchar(25) NULL,
    [drvExpGroup] varchar(6) NULL,
    [drvUserCode4] varchar(15) NULL,
    [drvDateofBirth] datetime NULL,
    [drvAsofDate] datetime NOT NULL,
    [drvAnnualSalary] varchar(1) NOT NULL,
    [drvRetEligibilityDate] varchar(1) NOT NULL,
    [drvReltoCompany] varchar(1) NOT NULL
);

-----------
-- Create table U_EBOWDEMEXP_drvTbl_CT
-----------

IF OBJECT_ID('U_EBOWDEMEXP_drvTbl_CT') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_drvTbl_CT] (
    [drvEEID] char(12) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvPlanName] char(30) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionDescription] char(30) NULL,
    [drvContributionAmount] money NULL
);

-----------
-- Create table U_EBOWDEMEXP_EEList
-----------

IF OBJECT_ID('U_EBOWDEMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBOWDEMEXP_File
-----------

IF OBJECT_ID('U_EBOWDEMEXP_File') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EBOWDEMEXP_HdrTrl
-----------

IF OBJECT_ID('U_EBOWDEMEXP_HdrTrl') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_HdrTrl] (
    [drvAdministratorCode] varchar(3) NOT NULL,
    [drvRecordCount] int NULL,
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(8000) NULL,
    [drvFileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_EBOWDEMEXP_Header
-----------

IF OBJECT_ID('U_EBOWDEMEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_Header] (
    [hrvEquholdCode_PartID] varchar(30) NOT NULL,
    [hrvSSN_Tax_ID] varchar(10) NOT NULL,
    [hrvFirstName] varchar(9) NOT NULL,
    [hrvLastName] varchar(8) NOT NULL,
    [hrvUserCode1] varchar(9) NOT NULL,
    [hrvHomeAddressLine1] varchar(16) NOT NULL,
    [hrvHomeAddressLine2] varchar(16) NOT NULL,
    [hrvHomeDistRegion] varchar(20) NOT NULL,
    [hrvHomeCity] varchar(8) NOT NULL,
    [hrvCurrStateorProv] varchar(22) NOT NULL,
    [hrvCurrPostalCode] varchar(17) NOT NULL,
    [hrvCurrCountry] varchar(14) NOT NULL,
    [hrvUserCode2] varchar(9) NOT NULL,
    [hrvCurr_WorkEmailAdd] varchar(24) NOT NULL,
    [hrvUserCode3] varchar(9) NOT NULL,
    [hrvDateRelatshipStart] varchar(23) NOT NULL,
    [hrvTerminationDate] varchar(15) NOT NULL,
    [hrvTerminationType] varchar(15) NOT NULL,
	hrvSect16Emp	varchar(12) NOT NULL,
    [hrvCurrJobTitle] varchar(15) NOT NULL,
    [hrvCurrDept] varchar(17) NOT NULL,
    [hrvCurrSection] varchar(14) NOT NULL,
    [hrvCurrBranch] varchar(13) NOT NULL,
    [hrvSubsCode] varchar(14) NOT NULL,
    [hrvExpGroup] varchar(15) NOT NULL,
    [hrvUserCode4] varchar(9) NOT NULL,
    [hrvDateofBirth] varchar(11) NOT NULL,
    [hrvAsofDate] varchar(8) NOT NULL,
    [hrvAnnualSalary] varchar(12) NOT NULL,
    [hrvRetEligDate] varchar(25) NOT NULL,
    [hrvRelattoCompany] varchar(21) NOT NULL
);

-----------
-- Create table U_EBOWDEMEXP_PDedHist
-----------

IF OBJECT_ID('U_EBOWDEMEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPaydate] datetime NULL,
    [PdhPlanName] char(30) NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhContribDesc] char(30) NULL,
    [PdhCurAmt] money NULL
);

-----------
-- Create table U_EBOWDEMEXP_PEarHist
-----------

IF OBJECT_ID('U_EBOWDEMEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PthCurTaxAmt] numeric NULL,
    [PthCurTaxAmtYTD] numeric NULL,
    [PehStateSUIYTD] numeric NULL,
    [PehCurAmtYTDSupp] numeric NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EBOWDEMEXP_Trailer
-----------

IF OBJECT_ID('U_EBOWDEMEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EBOWDEMEXP_Trailer] (
    [drvRecordCount] int NULL,
    [drvEmployerCode] varchar(13) NOT NULL,
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBOWDEMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bowman

Created By: Luis Lugo
Business Analyst: Richard Vars
Create Date: 08/06/2021
Service Request Number: TekP-2021-04-02-0002

Purpose: Bowman Certent Demographic

Revision History
----------------
11/08/2021 by AP:
		- Added Section16Employee field and header and value.
		- Removed employees from dataset that are CON, SUM, INT, TES, TMP, REG and STU.
		- Added 'E' to Relationship to Company as the exclusive value due to the change above.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBOWDEMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBOWDEMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBOWDEMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBOWDEMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBOWDEMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOWDEMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOWDEMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBOWDEMEXP', 'SCH_EBOWDE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBOWDEMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBOWDEMEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(@StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBOWDEMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBOWDEMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    

     -- Include terms within the last 90 days of the effective date.
    DELETE El
    FROM dbo.U_EBOWDEMEXP_EEList El
    INNER JOIN dbo.vw_int_EmpComp
        ON xEEID = EecEEID
        AND xCoID = EecCoID
        --AND EecEmplStatus = 'T'
        AND EecDateOfTermination < DATEADD(DAY, -90, CONVERT(DATE, @EndDate))
        

    -- Removing Employee Types
    DELETE El
    FROM dbo.U_EBOWDEMEXP_EEList El
    INNER JOIN dbo.vw_int_EmpComp
        ON xEEID = EecEEID
        AND xCoID = EecCoID
        AND eeceetype IN ('CON','SUM','INT','TES','TMP','REG','STU')

      

    ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBOWDEMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBOWDEMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBOWDEMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEqholderCd_PartID = EecEmpNo
        ,drvSSN_TaxID = EepSsn
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvUserCode1 = EepNamePreferred
        ,drvHomeAddressLine1 = EepAddressLine1
        ,drvHomeAddressLine2 = EepAddressLine2
        ,drvHomeDistrictorRegion = '' --leave blank
        ,drvHomeCity = EepAddressCity
        ,drvCurrentStateorProvince = EepAddressState
        ,drvCurrentPostalCode = EepAddressZipCode
        ,drvCurrentCountry = EepAddressCountry
        ,drvUserCode2 = EepAddressState
        ,drvCurr_WorkEmailAddr = EepAddressEMail
        ,drvUserCode3 = eepAddressEMailAlternate
        ,drvDateRelatStarted = EecDateOfOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTermType =  TchDesc
		,drvSect16Emp = CASE WHEN EepUDField07 = 'Yes' THEN 'Insider' ELSE 'No' END
        ,drvCurrJobTitle = EecJobTitle
        ,drvCurrDept = CASE WHEN Cmpcompanycode = 'BCG' THEN 'BCG'
                            WHEN Cmpcompanycode = 'BRCLC' THEN 'BRCLC'
                            WHEN Cmpcompanycode = 'NCPC2' THEN 'NCPC2'
                            END


        ,drvCurrSection = CASE WHEN EecOrgLvl2 = 'AA' THEN 'xAnnapolis'
                               WHEN EecOrgLvl2 = 'ANN' THEN 'xAnnapolis'
                               WHEN EecOrgLvl2 = 'AUS' THEN 'Austin'
                               WHEN EecOrgLvl2 = 'AZ' THEN 'Arizona'
                               WHEN EecOrgLvl2 = 'C1' THEN 'xDenver'
                               WHEN EecOrgLvl2 = 'CAR' THEN 'Carolinas'
                               WHEN EecOrgLvl2 = 'CEG' THEN 'Construction Engineering'
                               WHEN EecOrgLvl2 = 'CH' THEN 'xFairfax'
                               WHEN EecOrgLvl2 = 'CHI' THEN 'Chicago'
                               WHEN EecOrgLvl2 = 'CHS' THEN 'Charleston'
                               WHEN EecOrgLvl2 = 'CO' THEN 'Corporate'
                               WHEN EecOrgLvl2 = 'COL' THEN 'Colorado'
                               WHEN EecOrgLvl2 = 'COR' THEN 'Corporate'
                               WHEN EecOrgLvl2 = 'CRO' THEN 'Central Overhead'
                               WHEN EecOrgLvl2 = 'DAL' THEN 'Dallas'
                               WHEN EecOrgLvl2 = 'DC' THEN 'DC Region'
                               WHEN EecOrgLvl2 = 'DRO' THEN 'DC Overhead'
                               WHEN EecOrgLvl2 = 'EV' THEN 'xEnvironmental'
                               WHEN EecOrgLvl2 = 'FB' THEN 'xFredericksburg'
                               WHEN EecOrgLvl2 = 'FFX' THEN 'Fairfax'
                               WHEN EecOrgLvl2 = 'FL' THEN 'Florida'
                               WHEN EecOrgLvl2 = 'FRB' THEN 'Fredericksburg'
                               WHEN EecOrgLvl2 = 'I1' THEN 'xChicago'
                               WHEN EecOrgLvl2 = 'IS' THEN 'xInspection Services'
                               WHEN EecOrgLvl2 = 'KRO' THEN 'KTA Regional Overhead'
                               WHEN EecOrgLvl2 = 'KTA' THEN 'KTA'
                               WHEN EecOrgLvl2 = 'LD' THEN 'xLansdowne'
                               WHEN EecOrgLvl2 = 'LSB' THEN 'Leesburg'
                               WHEN EecOrgLvl2 = 'MAR' THEN 'Mid-Atlantic Right-of-Way'
                               WHEN EecOrgLvl2 = 'MDA' THEN 'MDA'
                               WHEN EecOrgLvl2 = 'NJ' THEN 'New Jersey'
                               WHEN EecOrgLvl2 = 'RD' THEN  'xRichmond'
                               WHEN EecOrgLvl2 = 'ROW' THEN 'xRight of Way'
                               WHEN EecOrgLvl2 = 'RVA' THEN 'Richmond'
                               WHEN EecOrgLvl2 = 'S1' THEN 'xCharleston'
                               WHEN EecOrgLvl2 = 'SCA' THEN 'Survey - Carolinas'
                               WHEN EecOrgLvl2 = 'SEO' THEN 'Southeast Overhead'
                               WHEN EecOrgLvl2 = 'SER' THEN 'Southeast Right-of-Way'
                               WHEN EecOrgLvl2 = 'SFL' THEN 'Survey - Florida'
                               WHEN EecOrgLvl2 = 'SMA' THEN 'Survey - Virginia'
                               WHEN EecOrgLvl2 = 'SNE' THEN 'Survey - Northeast'
                               WHEN EecOrgLvl2 = 'SOH' THEN 'Survey - Ohio Valley'
                               WHEN EecOrgLvl2 = 'SPA' THEN 'xSurvey - Pittsburgh'
                               WHEN EecOrgLvl2 = 'SRO' THEN 'Survey Regional Overhead'
                               WHEN EecOrgLvl2 = 'SV' THEN 'Survey'
                               WHEN EecOrgLvl2 = 'SWE' THEN 'Survey - West'
                               WHEN EecOrgLvl2 = 'T1' THEN 'xAustin'
                               WHEN EecOrgLvl2 = 'TX' THEN  'zz-Texas'
                               WHEN EecOrgLvl2 ='VA' THEN 'xSurvey East'
                               WHEN EecOrgLvl2 = 'VRO' THEN 'VA South Region Overhead'
                               WHEN EecOrgLvl2 = 'WDC' THEN 'DCPC Washington DC'
                               WHEN EecOrgLvl2 = 'WRO' THEN 'West Region Overhead'
                               WHEN EecOrgLvl2 = 'WW' THEN 'Water \ Wastewater'
                               WHEN EecOrgLvl2 = 'WW' THEN 'xCLOSED - Worldwide'
                               WHEN EecOrgLvl2 = 'XPU' THEN 'xPre-UltiPro'
                               ELSE NULL
                               END


        ,drvCurrBranch = CASE WHEN EecOrgLvl1 = 'AT' THEN 'xAtlantic'
                              WHEN EecOrgLvl1 = 'AZ' THEN 'Arizona'
                              WHEN EecOrgLvl1 = 'CE' THEN 'Central'
                              WHEN EecOrgLvl1 = 'CO' THEN 'Corporate'
                              WHEN EecOrgLvl1 = 'DC' THEN 'DC Region'
                              WHEN EecOrgLvl1 = 'EA' THEN 'zCLOSED - Eastern BU'
                              WHEN EecOrgLvl1 = 'IS' THEN 'xInspection Services'
                              WHEN EecOrgLvl1 = 'KT' THEN 'KT Region'
                              WHEN EecOrgLvl1 = 'KTA' THEN 'KTA'
                              WHEN EecOrgLvl1 = 'MA' THEN 'MDA'
                              WHEN EecOrgLvl1 = 'MD' THEN 'xCLOSED - Maryland BU'
                              WHEN EecOrgLvl1 = 'MW' THEN 'xCLOSED - Mid West'
                              WHEN EecOrgLvl1 = 'NC' THEN 'xCLOSED - NonConsolid'
                              WHEN EecOrgLvl1 = 'SE' THEN 'Southeast'
                              WHEN EecOrgLvl1 = 'SV' THEN 'Survey'
                              WHEN EecOrgLvl1 = 'VA' THEN 'xSurvey East'
                              WHEN EecOrgLvl1 = 'VS' THEN 'Virginia South Region'
                              WHEN EecOrgLvl1 = 'WA' THEN 'xWestern Region - Austin'
                              WHEN EecOrgLvl1 = 'WC' THEN 'xCLOSED - West Coast'
                              WHEN EecOrgLvl1 = 'WE' THEN 'West Region'
                              WHEN EecOrgLvl1 = 'WR' THEN 'XCLOSED - Western BU' 
                              ELSE NULL 
                              END
        ,drvSubsCode = CASE WHEN EecOrgLvl3 = '001' THEN 'xClose Divers. Growth'
                            WHEN EecOrgLvl3 = '0AA' THEN 'xClosed--Annapolis'
                            WHEN EecOrgLvl3 = '0AL' THEN 'xCLOSED--Alexandria'
                            WHEN EecOrgLvl3 = '0AZ' THEN 'xCLOSED--Arizona'
                            WHEN EecOrgLvl3 = '0BD' THEN 'xCLOSEDBowman Dev Adv'
                            WHEN EecOrgLvl3 = '0C1' THEN 'xCLOSED--Denver'
                            WHEN EecOrgLvl3 = '0CH' THEN 'xCLOSED--Fairfax'
                            WHEN EecOrgLvl3 = '0CO' THEN 'xCLOSED--Corporate'
                            WHEN EecOrgLvl3 = '0DC' THEN 'xCLOSED--D.C.'
                            WHEN EecOrgLvl3 = '0EV' THEN 'xCLOSED-Environmental'
                            WHEN EecOrgLvl3 = '0F2' THEN 'xCLOSED--Stuart'
                            WHEN EecOrgLvl3 = '0FB' THEN 'xCLOSEDFredericksburg'
                            WHEN EecOrgLvl3 = '0I1' THEN 'xCLOSED--Chicago'
                            WHEN EecOrgLvl3 = '0IS' THEN 'xCLOSED-Inspect Svcs'
                            WHEN EecOrgLvl3 = 'NN' THEN 'xAnnapolis'
                            WHEN EecOrgLvl3    = 'ANS' THEN 'Survey Annapolis'
                            WHEN EecOrgLvl3    = 'ATL' THEN 'Atlanta'
                            WHEN EecOrgLvl3    = 'ATS' THEN 'Survey Atlanta'
                            WHEN EecOrgLvl3    = 'AUS' THEN 'Austin'
                            WHEN EecOrgLvl3    = 'CEG' THEN 'Construction Engineering'
                            WHEN EecOrgLvl3 = 'CHA' THEN 'Charlotte'
                            WHEN EecOrgLvl3    = 'CHI' THEN 'Chicago'
                            WHEN EecOrgLvl3    = 'CHS' THEN 'Charleston'
                            WHEN EecOrgLvl3    = 'CKN' THEN 'Cedar Knolls'
                            WHEN EecOrgLvl3    = 'CKS' THEN 'Survey Cedar Knolls'
                            WHEN EecOrgLvl3    = 'CO'  THEN 'Corporate'
                            WHEN EecOrgLvl3    = 'COH' THEN 'KT Commissioning Herndon'
                            WHEN EecOrgLvl3    = 'COR' THEN 'Corporate'
                            WHEN EecOrgLvl3    = 'COS' THEN 'Survey Ohio Valley'
                            WHEN EecOrgLvl3    = 'DAL' THEN 'Dallas'
                            WHEN EecOrgLvl3    = 'DC'  THEN 'DC Region'
                            WHEN EecOrgLvl3    = 'DEN' THEN 'Denver'
                            WHEN EecOrgLvl3    = 'DES' THEN 'Survey Denver'
                            WHEN EecOrgLvl3    = 'DRO' THEN 'DC Overhead'
                            WHEN EecOrgLvl3 = 'DUS' THEN 'zz-DC Subsurface Utility'
                            WHEN EecOrgLvl3    = 'ENH' THEN 'KT Engineering Herndon'
                            WHEN EecOrgLvl3    = 'F2'  THEN 'xFlorida'
                            WHEN EecOrgLvl3    = 'FFX' THEN 'Fairfax'
                            WHEN EecOrgLvl3    = 'FHD' THEN 'Freehold'
                            WHEN EecOrgLvl3    = 'FHS' THEN 'Survey Freehold'
                            WHEN EecOrgLvl3    = 'FRA' THEN 'zz-Fraser'
                            WHEN EecOrgLvl3    = 'FRB' THEN 'Fredericksburg'
                            WHEN EecOrgLvl3    = 'FRS' THEN 'Survey Fredericksburg'
                            WHEN EecOrgLvl3    = 'FRW' THEN 'FL Right of Way'
                            WHEN EecOrgLvl3    = 'FTL' THEN 'Ft. Lauderdale'
                            WHEN EecOrgLvl3    = 'FUS' THEN 'FL Subsurface Utility'
                            WHEN EecOrgLvl3    = 'FXS' THEN 'Survey Fairfax'
                            WHEN EecOrgLvl3    = 'GLD' THEN 'zz-Golden'
                            WHEN EecOrgLvl3    = 'GLN' THEN 'zz-Glendale'
                            WHEN EecOrgLvl3    = 'IS'  THEN 'xInspection Services'
                            WHEN EecOrgLvl3    = 'KRO' THEN 'KTA Regional Overhead'
                            WHEN EecOrgLvl3    = 'KTA' THEN 'KTA'
                            WHEN EecOrgLvl3    = 'LBS' THEN 'Survey Leesburg'
                            WHEN EecOrgLvl3    = 'LDG' THEN 'Land Development-Glendale'
                            WHEN EecOrgLvl3    = 'LDM' THEN 'Land Development-Mesa'
                            WHEN EecOrgLvl3    = 'LDP' THEN 'Land Development-Tempe'
                            WHEN EecOrgLvl3    = 'LDT' THEN 'Land Development-Tucson'
                            WHEN EecOrgLvl3    = 'LIS' THEN 'zz-Lisle'
                            WHEN EecOrgLvl3    = 'LSB' THEN 'Leesburg'
                            WHEN EecOrgLvl3    = 'MEL' THEN 'Melbourne'
                            WHEN EecOrgLvl3    = 'MIT' THEN 'Mining -  Tucson'
                            WHEN EecOrgLvl3    = 'MLD' THEN 'Maryland'
                            WHEN EecOrgLvl3    = 'MUS' THEN 'Municipal - Safford'
                            WHEN EecOrgLvl3    = 'NY'  THEN 'zz-New York'
                            WHEN EecOrgLvl3 = 'ORL' THEN 'Orlando'
                            WHEN EecOrgLvl3 = 'PEO' THEN 'xPeoria'
                            WHEN EecOrgLvl3 = 'PLH' THEN 'KT Plan Review Herndon'
                            WHEN EecOrgLvl3 = 'PSL' THEN 'Port St. Lucie'
                            WHEN EecOrgLvl3 = 'PTS' THEN 'zz-Survey Pittsburgh'
                            WHEN EecOrgLvl3 = 'PWM' THEN 'Prince William'
                            WHEN EecOrgLvl3 = 'ROW' THEN 'xRight of Way'
                            WHEN EecOrgLvl3 = 'RVA' THEN 'Richmond'
                            WHEN EecOrgLvl3 = 'RVS' THEN 'Survey Richmond'
                            WHEN EecOrgLvl3 = 'SAF' THEN 'zz-Safford'
                            WHEN EecOrgLvl3 = 'SAS' THEN 'Survey Safford'
                            WHEN EecOrgLvl3 = 'SAU' THEN 'Survey Austin'
                            WHEN EecOrgLvl3 = 'SCH' THEN 'Survey Charleston'
                            WHEN EecOrgLvl3    = 'SDC' THEN 'xSurvey DC'
                            WHEN EecOrgLvl3 = 'SEO' THEN 'Southeast Overhead'
                            WHEN EecOrgLvl3 = 'SGP' THEN 'Southwest Gas-Tempe'
                            WHEN EecOrgLvl3 = 'SGS' THEN 'Southwest Gas-Safford'
                            WHEN EecOrgLvl3 = 'SMC' THEN 'San Marcos'
                            WHEN EecOrgLvl3 = 'SNE' THEN 'Survey - Northeast'
                            WHEN EecOrgLvl3 = 'SPA' THEN 'xSurvey Pittsburgh'
                            WHEN EecOrgLvl3 = 'SRO' THEN 'Survey Regional Overhead'
                            WHEN EecOrgLvl3 = 'SSE' THEN 'xSurvey Southeast'
                            WHEN EecOrgLvl3 = 'STS' THEN 'Survey Stuart'
                            WHEN EecOrgLvl3 = 'STU' THEN 'Stuart'
                            WHEN EecOrgLvl3 = 'SUN' THEN 'Sunrise'
                            WHEN EecOrgLvl3 = 'SUW' THEN 'MDA - Suwanee'
                            WHEN EecOrgLvl3 = 'SWE' THEN 'Survey - West'
                            WHEN EecOrgLvl3 = 'TAM' THEN 'Tampa'
                            WHEN EecOrgLvl3 = 'TEM' THEN 'zz-Tempe'
                            WHEN EecOrgLvl3 = 'TES' THEN 'Survey Tempe'
                            WHEN EecOrgLvl3 = 'TUC' THEN 'zz-Tucson'
                            WHEN EecOrgLvl3 = 'VA' THEN  'xSurvey East'
                            WHEN EecOrgLvl3 = 'VRO' THEN 'VA South Region Overhead'
                            WHEN EecOrgLvl3 = 'VRW' THEN 'VA Right of Way'
                            WHEN EecOrgLvl3 = 'WBV' THEN 'Williamsburg'
                            WHEN EecOrgLvl3 = 'WDC' THEN 'DCPC Washington DC'
                            WHEN EecOrgLvl3 = 'WRO' THEN 'West Region Overhead'
                            WHEN EecOrgLvl3 = 'WVS' THEN 'Survey West Virginia'
                            ELSE NUll
                            End


        ,drvExpGroup = CASE WHEN EecOrgLvl4 = '0AA0EN' THEN '0AA0EN'--'xAnnapolis Engineering'
                            WHEN EecOrgLvl4 = '0AA0PL' THEN '0AA0PL'--'xAnnapolis Planning'
                            WHEN EecOrgLvl4 = '0AL000' THEN '0AL000'--'xAlexandria Adminstration'
                            WHEN EecOrgLvl4 = '0AL0EN' THEN '0AL0EN'--'xAlexandria Engineering'
                            WHEN EecOrgLvl4 = '0AZ000' THEN '0AZ000'--'xArizona Ofc. Administrat'
                            WHEN EecOrgLvl4 = '0AZ0EN' THEN '0AZ0EN'--'xArizona Ofc. Engineering'
                            WHEN EecOrgLvl4 = '0AZ0SV' THEN '0AZ0SV'--'xArizona Ofc. Survey'
                            WHEN EecOrgLvl4 = '0BD000' THEN '0BD000'--'xBDA Administratio'
                            WHEN EecOrgLvl4 = '0C1000' THEN '0C1000'--'xDenver, CO Adminstration'
                            WHEN EecOrgLvl4 = '0C10EN' THEN '0C10EN'--'xDenver CO, Engineering'
                            WHEN EecOrgLvl4 = '0C10SV' THEN '0C10SV'--'xDenver CO, Survey'
                            WHEN EecOrgLvl4 = '0CH000' THEN '0CH000'--'xFairfax Administration'
                            WHEN EecOrgLvl4 = '0CH0EN' THEN '0CH0EN'--'xFairfax Engineering'
                            WHEN EecOrgLvl4 = '0CH0PL' THEN '0CH0PL'--'xFairfax Planning'
                            WHEN EecOrgLvl4 = '0CO000' THEN '0CO000'--'xCorporate'
                            WHEN EecOrgLvl4 = '0CO0FN' THEN '0CO0FN'--'xCorporate Finance'
                            WHEN EecOrgLvl4 = '0CO0LC' THEN '0CO0LC'--'zz-Lansdowne Construction'
                            WHEN EecOrgLvl4 = '0CO0LD' THEN '0CO0LD'--'zz-Lansdowne Development'
                            WHEN EecOrgLvl4 = '0CO0MV' THEN '0CO0MV'--'xMaevelle Geothermal'
                            WHEN EecOrgLvl4 = '0DC0EN' THEN '0DC0EN'--'xDC Office Engineering'
                            WHEN EecOrgLvl4 = '0EV000' THEN '0EV000'--'xEnvironmental Dept Admin'
                            WHEN EecOrgLvl4 = '0EV0EE' THEN '0EV0EE'--'xEnviro. Dept Environmen.'
                            WHEN EecOrgLvl4 = '0F2000' THEN '0F2000'--'xFL Stuart Administration'
                            WHEN EecOrgLvl4 = '0F20EN' THEN '0F20EN'--'xFL Stuart Engineering'
                            WHEN EecOrgLvl4 = '0F20SV' THEN '0F20SV'--'xFL Stuart Survey'
                            WHEN EecOrgLvl4 = '0FB000' THEN '0FB000'--'xFredericksburg Admin'
                            WHEN EecOrgLvl4 = '0FB0EN' THEN '0FB0EN'--'xFredericksburg Eng'
                            WHEN EecOrgLvl4 = '0I10EN' THEN '0I10EN'--'xChicago Engineering'
                            WHEN EecOrgLvl4 = '0IS000' THEN '0IS000'--'xInspection Srvcs Admin'
                            WHEN EecOrgLvl4 = '0IS0IN' THEN '0IS0IN'--'xInspection Svc Inspector'
                            WHEN EecOrgLvl4 = '0J1000' THEN '0J1000'--'xNJ Cedar Knolls Admin'
                            WHEN EecOrgLvl4 = '0J10EN' THEN '0J10EN'--'xNJ Cedar Knolls Engineer'
                            WHEN EecOrgLvl4 = '0J20EN' THEN '0J20EN'--'xNJ Freehold Engineering'
                            WHEN EecOrgLvl4 = '0OS000' THEN '0OS000'--'xWest Operations Services'
                            WHEN EecOrgLvl4 = '0PB000' THEN '0PB000'--'xPittsburgh Admin'
                            WHEN EecOrgLvl4 = '0PB0EE' THEN '0PB0EE'--'xPittsburgh Environmental'
                            WHEN EecOrgLvl4 = '0PB0EG' THEN '0PB0EG'--'xPittsburgh Energy'
                            WHEN EecOrgLvl4 = '0PB0EN' THEN '0PB0EN'--'xPittsburgh Engineering'
                            WHEN EecOrgLvl4 = '0PB0SV' THEN '0PB0SV'--'xPittsburgh Survey'
                            WHEN EecOrgLvl4 = '0PW000' THEN '0PW000'--'xPr William Admin'
                            WHEN EecOrgLvl4 = '0PW0EN' THEN '0PW0EN'--'xPr William Engineering'
                            WHEN EecOrgLvl4 = '0PW0PL' THEN '0PW0PL'--'xPr William Planning'
                            WHEN EecOrgLvl4 = '0RD000' THEN '0RD000'--'xRichmond Administration'
                            WHEN EecOrgLvl4 = '0RD0EN' THEN '0RD0EN'--'xRichmond Engineering'
                            WHEN EecOrgLvl4 = '0RD0RW' THEN '0RD0RW'--'xRichmond Right of Way'
                            WHEN EecOrgLvl4 = '0RD0TR' THEN '0RD0TR'--'xRichmond Traffic'
                            WHEN EecOrgLvl4 = '0S10EN' THEN '0S10EN'--'xCharleston Engineering'
                            WHEN EecOrgLvl4 = '0SJ0EN' THEN '0SJ0EN'--'xSan Jose engineering'
                            WHEN EecOrgLvl4 = '0T1000' THEN '0T1000'--'xTX Austin Administration'
                            WHEN EecOrgLvl4 = '0T10EE' THEN '0T10EE'--'xTX Austin Environmental'
                            WHEN EecOrgLvl4 = '0T10EN' THEN '0T10EN'--'xTX Austin Engineering'
                            WHEN EecOrgLvl4 = '0T10SV' THEN '0T10SV'--'xTX Austin Survey'
                            WHEN EecOrgLvl4 = '0TH000' THEN '0TH000'--'xAZ Thatcher Administrati'
                            WHEN EecOrgLvl4 = '0TH0EN' THEN '0TH0EN'--'xAZ Thatcher Eng'
                            WHEN EecOrgLvl4 = '0TH0SV' THEN '0TH0SV'--'xAZ Thatcher Survey'
                            WHEN EecOrgLvl4 = '0VA000' THEN '0VA000'--'xSurvey Dept. Admin.'
                            WHEN EecOrgLvl4 = '0VA0SD' THEN '0VA0SD'--'xSurvey Department'
                            WHEN EecOrgLvl4 = '0VB000' THEN '0VB000'--'xVA Beach Administration'
                            WHEN EecOrgLvl4 = '0VB0EN' THEN '0VB0EN'--'xVA Beach Engineering'
                            WHEN EecOrgLvl4 = '0VB0PL' THEN '0VB0PL'--'xVA Beach Planning'
                            WHEN EecOrgLvl4 = '0WB000' THEN '0WB000'--'xWater\Wastewater Admin'
                            WHEN EecOrgLvl4 = '0WB0EN' THEN '0WB0EN'--'xWater\Wastewater Eng'
                            WHEN EecOrgLvl4 = '0WB0WW' THEN '0WB0WW'--'xWater\Wastewater Waste'
                            WHEN EecOrgLvl4 = 'ANN000' THEN 'ANN000'--'xAnnapolis Overhead'
                            WHEN EecOrgLvl4 = 'ANNENG' THEN 'ANNENG'--'xAnnapolis Engineering'
                            WHEN EecOrgLvl4 = 'ANNPLA' THEN 'ANNPLA'--'xAnnapolis Planning'
                            WHEN EecOrgLvl4 = 'ANSAN1' THEN 'ANSAN1'--'zz-SV Annapolis'
                            WHEN EecOrgLvl4 = 'ATLENG' THEN 'ATLENG'--'Atlanta Engineering'
                            WHEN EecOrgLvl4 = 'ATSAT1' THEN 'ATSAT1'--'SV Atlanta'
                            WHEN EecOrgLvl4 = 'AUS000' THEN 'AUS000'--'Austin Overhead'
                            WHEN EecOrgLvl4 = 'AUSENG' THEN 'AUSENG'--'Austin Engineering'
                            WHEN EecOrgLvl4 = 'CEGENG' THEN 'CEGENG'--'Construction Engineering'
                            WHEN EecOrgLvl4 = 'CHA000' THEN 'CHA000'--'Charlotte Overhead'
                            WHEN EecOrgLvl4 = 'CHAENG' THEN 'CHAENG'--'Charlotte Engineering'
                            WHEN EecOrgLvl4 = 'CHIENG' THEN 'CHIENG'--'Chicago Engineering'
                            WHEN EecOrgLvl4 = 'CHS000' THEN 'CHS000'--'Charleston Overhead'
                            WHEN EecOrgLvl4 = 'CHSENG' THEN 'CHSENG'--'Charleston Engineering'
                            WHEN EecOrgLvl4 = 'CKN000' THEN 'CKN000'--'Cedar Knolls Overhead'
                            WHEN EecOrgLvl4 = 'CKNENG' THEN 'CKNENG'--'Cedar Knolls Engineering'
                            WHEN EecOrgLvl4 = 'CKNPLA' THEN 'CKNPLA'--'CE Cedar Knolls Planning'
                            WHEN EecOrgLvl4 = 'CKSCK1' THEN 'CKSCK1'--'SV Cedar Knolls'
                            WHEN EecOrgLvl4 = 'CO000' THEN 'CO000'--'xCorporate Overhead'
                            WHEN EecOrgLvl4 = 'COCO00' THEN 'COCO00'--'xCorporate'
                            WHEN EecOrgLvl4 = 'COHCOM' THEN 'COHCOM'--'KT Commissioning'
                            WHEN EecOrgLvl4 = 'CORACT' THEN 'CORACT'--'Accounting'
                            WHEN EecOrgLvl4 = 'CORBD0' THEN 'CORBD0'--'Business Development'
                            WHEN EecOrgLvl4 = 'CORCSO' THEN 'CORCSO'--'Corporate Strategy'
                            WHEN EecOrgLvl4 = 'COREXC' THEN 'COREXC'--'Executive'
                            WHEN EecOrgLvl4 = 'CORHR0' THEN 'CORHR0'--'Human Resources'
                            WHEN EecOrgLvl4 = 'CORIT0' THEN 'CORIT0'--'Info Technology'
                            WHEN EecOrgLvl4 = 'CORLEG' THEN 'CORLEG'--'Legal'
                            WHEN EecOrgLvl4 = 'CORMKT' THEN 'CORMKT'--'Marketing'
                            WHEN EecOrgLvl4 = 'CORSTG' THEN 'CORSTG'--'Strategic'
                            WHEN EecOrgLvl4 = 'COSCO1' THEN 'COSCO1'--'SV - Columbus'
                            WHEN EecOrgLvl4 = 'DALENG' THEN 'DALENG'--'Dallas Engineering'
                            WHEN EecOrgLvl4 = 'DEN000' THEN 'DEN000'--'Denver Overhead'
                            WHEN EecOrgLvl4 = 'DENENG' THEN 'DENENG'--'Denver Engineering'
                            WHEN EecOrgLvl4 = 'DESDE1' THEN 'DESDE1'--'SV Denver'
                            WHEN EecOrgLvl4 = 'DRO000' THEN 'DRO000'--'DC Regional  Overhead'
                            WHEN EecOrgLvl4 = 'DUSDU1' THEN 'DUSDU1'--'zz-SV DC Sub Utility'
                            WHEN EecOrgLvl4 = 'EADCEN' THEN 'EADCEN'--'xD.C. Office Engineering'
                            WHEN EecOrgLvl4 = 'ENH000' THEN 'ENH000'--'KT Engineering Overhead'
                            WHEN EecOrgLvl4 = 'ENHENG' THEN 'ENHENG'--'KT Engineering'
                            WHEN EecOrgLvl4 = 'FFX000' THEN 'FFX000'--'Fairfax Overhead'
                            WHEN EecOrgLvl4 = 'FFXENG' THEN 'FFXENG'--'Fairfax Engineering'
                            WHEN EecOrgLvl4 = 'FFXPLA' THEN 'FFXPLA'--'Fairfax Planning'
                            WHEN EecOrgLvl4 = 'FHD000' THEN 'FHD000'--'Freehold Overhead'
                            WHEN EecOrgLvl4 = 'FHDENG' THEN 'FHDENG'--'Freehold Engineering'
                            WHEN EecOrgLvl4 = 'FHDPLA' THEN 'FHDPLA'--'Freehold Planning'
                            WHEN EecOrgLvl4 = 'FHSFH0' THEN 'FHSFH0'--'SV Freehold Overhead'
                            WHEN EecOrgLvl4 = 'FHSFH1' THEN 'FHSFH1'--'SV Freehold'
                            WHEN EecOrgLvl4 = 'FRAENG' THEN 'FRAENG'--'zz-Fraser Engineering'
                            WHEN EecOrgLvl4 = 'FRB000' THEN 'FRB000'--'Fredericksburg Overhead'
                            WHEN EecOrgLvl4 = 'FRBENG' THEN 'FRBENG'--'Fredericksburg Eng'
                            WHEN EecOrgLvl4 = 'FRBENV' THEN 'FRBENV'--'Fredericksburg Environ'
                            WHEN EecOrgLvl4 = 'FRSFR0' THEN 'FRSFR0'--'SV Fredericksburg Ovrhd'
                            WHEN EecOrgLvl4 = 'FRSFR1' THEN 'FRSFR1'--'SV Fredericksburg'
                            WHEN EecOrgLvl4 = 'FRW000' THEN 'FRW000'--'FL Right of Way-Overhead'
                            WHEN EecOrgLvl4 = 'FRWBRD' THEN 'FRWBRD'--'FL Right of Way-Broward'
                            WHEN EecOrgLvl4 = 'FRWEAS' THEN 'FRWEAS'--'FL Right of Way-Eastern'
                            WHEN EecOrgLvl4 = 'FRWFRW' THEN 'FRWFRW'--'FL Right of Way'
                            WHEN EecOrgLvl4 = 'FRWNOR' THEN 'FRWNOR'--'FL Right of Way-Northern'
                            WHEN EecOrgLvl4 = 'FRWTAM' THEN 'FRWTAM'--'FL Right of Way-Tampa'
                            WHEN EecOrgLvl4 = 'FTL000' THEN 'FTL000'--'Ft. Lauderdale Overhead'
                            WHEN EecOrgLvl4 = 'FTLENG' THEN 'FTLENG'--'Ft Lauderdale Engineering'
                            WHEN EecOrgLvl4 = 'FUSFU1' THEN 'FUSFU1'--'SV FL SUE'
                            WHEN EecOrgLvl4 = 'FXSFX0' THEN 'FXSFX0'--'SV Fairfax Overhead'
                            WHEN EecOrgLvl4 = 'FXSFX1' THEN 'FXSFX1'--'SV Fairfax'
                            WHEN EecOrgLvl4 = 'GLDENG' THEN 'GLDENG'--'xGolden Engineering'
                            WHEN EecOrgLvl4 = 'GLNENG' THEN 'GLNENG'--'zz-Glendale Engineering'
                            WHEN EecOrgLvl4 = 'KRO000' THEN 'KRO000'--'KTA Regional Overhead'
                            WHEN EecOrgLvl4 = 'KTA' THEN 'KTA'
                            WHEN EecOrgLvl4 = 'LBSLB1' THEN 'LBSLB1'--'SV Leesburg'
                            WHEN EecOrgLvl4 = 'LDG000' THEN 'LDG000'--'Land Dev Glendale Overhed'
                            WHEN EecOrgLvl4 = 'LDGENG' THEN 'LDGENG'--'Land Dev Glendale Eng'
                            WHEN EecOrgLvl4 = 'LDMENG' THEN 'LDMENG'--'Land Dev Mesa Engineering'
                            WHEN EecOrgLvl4 = 'LDP000' THEN 'LDP000'--'Land Dev Tempe Overhead'
                            WHEN EecOrgLvl4 = 'LDPENG' THEN 'LDPENG'--'Land Dev Tempe Eng'
                            WHEN EecOrgLvl4 = 'LDT000' THEN 'LDT000'--'Land Dev Tucson Overhead'
                            WHEN EecOrgLvl4 = 'LDTENG' THEN 'LDTENG'--'Land Dev Tucson Eng'
                            WHEN EecOrgLvl4 = 'LISENG' THEN 'LISENG'--'zz-Lisle Construction Eng'
                            WHEN EecOrgLvl4 = 'LSB000' THEN 'LSB000'--'Leesburg Overhead'
                            WHEN EecOrgLvl4 = 'LSBENG' THEN 'LSBENG'--'Leesburg Engineering'
                            WHEN EecOrgLvl4 = 'LSBPLA' THEN 'LSBPLA'--'Leesburg Planning'
                            WHEN EecOrgLvl4 = 'MEL000' THEN 'MEL000'--'Melbourne Overhead'
                            WHEN EecOrgLvl4 = 'MELENG' THEN 'MELENG'--'Melbourne Engineering'
                            WHEN EecOrgLvl4 = 'MITENG' THEN 'MITENG'--'Mining Tucson - Eng'
                            WHEN EecOrgLvl4 = 'MLDENG' THEN 'MLDENG'--'Maryland Engineering'
                            WHEN EecOrgLvl4 = 'MUS000' THEN 'MUS000'--'Municipal Safford OVH'
                            WHEN EecOrgLvl4 = 'MUSENG' THEN 'MUSENG'--'Municipal Safford Eng'
                            WHEN EecOrgLvl4 = 'NCF2EN' THEN 'NCF2EN'--'xFL Stuart Engineering'
                            WHEN EecOrgLvl4 = 'NCIS00' THEN 'NCIS00'--'xInspections Admin'
                            WHEN EecOrgLvl4 = 'NCISIN' THEN 'NCISIN'--'xInspections Inspectors'
                            WHEN EecOrgLvl4 = 'NCVASD' THEN 'NCVASD'--'xSurvey Department'
                            WHEN EecOrgLvl4 = 'NYENG' THEN 'NYENG'--'zz-New York Engineering'
                            WHEN EecOrgLvl4 = 'ORLENG' THEN 'ORLENG'--'Orlando Engineering'
                            WHEN EecOrgLvl4 = 'PEO000' THEN 'PEO000'--'xPeoria Overhead'
                            WHEN EecOrgLvl4 = 'PEOENG' THEN 'PEOENG'--'xPeoria Engineering'
                            WHEN EecOrgLvl4 = 'PLHPLR' THEN 'PLHPLR'--'KT Plan Review'
                            WHEN EecOrgLvl4 = 'PSLENG' THEN 'PSLENG'--'Port St Lucie Engineering'
                            WHEN EecOrgLvl4 = 'PTSPT0' THEN 'PTSPT0'--'zz-SV Pittsburgh Overhead'
                            WHEN EecOrgLvl4 = 'PTSPT1' THEN 'PTSPT1'--'zz-SV Pittsburgh'
                            WHEN EecOrgLvl4 = 'PWMENG' THEN 'PWMENG'--'Prince William Eng'
                            WHEN EecOrgLvl4 = 'ROWROW' THEN 'ROWROW'--'xRight of  Way'
                            WHEN EecOrgLvl4 = 'RVA000' THEN 'RVA000'--'Richmond Overhead'
                            WHEN EecOrgLvl4 = 'RVAENG' THEN 'RVAENG'--'Richmond Engineering'
                            WHEN EecOrgLvl4 = 'RVAROW' THEN 'RVAROW'--'xRichmond Right of Way'
                            WHEN EecOrgLvl4 = 'RVATRA' THEN 'RVATRA'--'Richmond Traffic'
                            WHEN EecOrgLvl4 = 'RVSRV1' THEN 'RVSRV1'--'SV Richmond'
                            WHEN EecOrgLvl4 = 'SAF000' THEN 'SAF000'--'zz-Safford Overhead'
                            WHEN EecOrgLvl4 = 'SAFENG' THEN 'SAFENG'--'zz-Safford Engineering'
                            WHEN EecOrgLvl4 = 'SASSA1' THEN 'SASSA1'--'SV Safford'
                            WHEN EecOrgLvl4 = 'SAUAU1' THEN 'SAUAU1'--'SV Austin'
                            WHEN EecOrgLvl4 = 'SCHCS1' THEN 'SCHCS1'--'SV Charleston'
                            WHEN EecOrgLvl4 = 'SDCAN1' THEN 'SDCAN1'--'xSurvey Annapolis'
                            WHEN EecOrgLvl4 = 'SDCFR1' THEN 'SDCFR1'--'xSurvey Fredericksburg'
                            WHEN EecOrgLvl4 = 'SDCFX1' THEN 'SDCFX1'--'xSurvey Fairfax'
                            WHEN EecOrgLvl4 = 'SDCLB1' THEN 'SDCLB1'--'xSurvey Leesburg'
                            WHEN EecOrgLvl4 = 'SDCRV1' THEN 'SDCRV1'--'xSurvey Richmond'
                            WHEN EecOrgLvl4 = 'SEO000' THEN 'SEO000'--'Southeast Overhead'
                            WHEN EecOrgLvl4 = 'SGPENG' THEN 'SGPENG'--'SW Gas Tempe - Eng'
                            WHEN EecOrgLvl4 = 'SGSENG' THEN 'SGSENG'--'SW Gas Safford Eng'
                            WHEN EecOrgLvl4 = 'SMC000' THEN 'SMC000'--'San Marcos Overhead'
                            WHEN EecOrgLvl4 = 'SMCENV' THEN 'SMCENV'--'San Marcos Environmental'
                            WHEN EecOrgLvl4 = 'SNECK1' THEN 'SNECK1'--'xSurvey Cedar Knolls'
                            WHEN EecOrgLvl4 = 'SNEFH1' THEN 'SNEFH1'--'xSurvey Freehold'
                            WHEN EecOrgLvl4 = 'SPAPT1' THEN 'SPAPT1'--'xSurvey Pittsburgh'
                            WHEN EecOrgLvl4 = 'SRO000' THEN 'SRO000'--'SV Survey Reg Ovrhead'
                            WHEN EecOrgLvl4 = 'SSEAT1' THEN 'SSEAT1'--'xSurvey Atlanta'
                            WHEN EecOrgLvl4 = 'SSECL1' THEN 'SSECL1'--'xSurvey Charlotte'
                            WHEN EecOrgLvl4 = 'SSECS1' THEN 'SSECS1'--'xSurvey Charleston'
                            WHEN EecOrgLvl4 = 'SSEME1' THEN 'SSEME1'--'xSurvey Melbourne'
                            WHEN EecOrgLvl4 = 'SSEST0' THEN 'SSEST0'--'xSurvey Stuart Overhead'
                            WHEN EecOrgLvl4 = 'SSEST1' THEN 'SSEST1'--'xSurvey Stuart'
                            WHEN EecOrgLvl4 = 'SSESU1' THEN 'SSESU1'--'xSurvey SE Subsurface Uti'
                            WHEN EecOrgLvl4 = 'STSST0' THEN 'STSST0'--'SV Stuart Overhead'
                            WHEN EecOrgLvl4 = 'STSST1' THEN 'STSST1'--'SV Stuart'
                            WHEN EecOrgLvl4 = 'STUENG' THEN 'STUENG'--'Stuart Engineering'
                            WHEN EecOrgLvl4 = 'SUNENG' THEN 'SUNENG'--'Sunrise Engineering'
                            WHEN EecOrgLvl4 = 'SUW000' THEN 'SUW000'--'MDA Overhead'
                            WHEN EecOrgLvl4 = 'SUWENG' THEN 'SUWENG'--'MDA Engineering'
                            WHEN EecOrgLvl4 = 'SUWSRV' THEN 'SUWSRV'--'MDA Survey'
                            WHEN EecOrgLvl4 = 'SWEAU1' THEN 'SWEAU1'--'xSurvey Austin'
                            WHEN EecOrgLvl4 = 'SWEDE1' THEN 'SWEDE1'--'xSurvey Denver'
                            WHEN EecOrgLvl4 = 'SWESA1' THEN 'SWESA1'--'xSurvey Safford'
                            WHEN EecOrgLvl4 = 'SWETE1' THEN 'SWETE1'--'xSurvey Tempe'
                            WHEN EecOrgLvl4 = 'TAMENG' THEN 'TAMENG'--'Tampa Engineering'
                            WHEN EecOrgLvl4 = 'TEM000' THEN 'TEM000'--'zz-Tempe Overhead'
                            WHEN EecOrgLvl4 = 'TEMENG' THEN 'TEMENG'--'zz-Tempe Engineering'
                            WHEN EecOrgLvl4 = 'TESTE0' THEN 'TESTE0'--'SV Tempe Overhead'
                            WHEN EecOrgLvl4 = 'TESTE1' THEN 'TESTE1'--'SV Tempe'
                            WHEN EecOrgLvl4 = 'TUCENG' THEN 'TUCENG'--'zz-Tucson Engineering'
                            WHEN EecOrgLvl4 = 'VRO000' THEN 'VRO000'--'VA South Region Overhead'
                            WHEN EecOrgLvl4 = 'VRW000' THEN 'VRW000'--'VA RoW Overhead'
                            WHEN EecOrgLvl4 = 'VRWVRW' THEN 'VRWVRW'--'VA Right of Way'
                            WHEN EecOrgLvl4 = 'WBV000' THEN 'WBV000'--'Williamsburg Overhead'
                            WHEN EecOrgLvl4 = 'WBVENG' THEN 'WBVENG'--'Williamsburg Engineering'
                            WHEN EecOrgLvl4 = 'WBVWWW' THEN 'WBVWWW'--'WBG Water Wastewater'
                            WHEN EecOrgLvl4 = 'WDC000' THEN 'WDC000'--'DC Overhead'
                            WHEN EecOrgLvl4 = 'WDCENG' THEN 'WDCENG'--'DC Engineering'
                            WHEN EecOrgLvl4 = 'WRO000' THEN 'WRO000'--'West Region Overhead'
                            WHEN EecOrgLvl4 = 'WVSWV1' THEN 'WVSWV1'--'SV - West Virginia'
                            ELSE NULL
                            END

        ,drvUserCode4 = gl.OrgLvl4Seg --leave Blank
        ,drvDateofBirth = EepDateOfBirth
        ,drvAsofDate = getdate()
        ,drvAnnualSalary = '' --leave blank
        ,drvRetEligibilityDate = '' --leave blank
        ,drvReltoCompany = 'E'
		
		--CASE WHEN  eeceetype IN ('EVN','EVP','EXN','HNE','LSS','P','PN','PRE','SE','SNE','VP','VPN') THEN 'E' 
  --                         else 'E' END
    INTO dbo.U_EBOWDEMEXP_drvTbl
    FROM dbo.U_EBOWDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
         
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCoID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
             
    LEFT JOIN (SELECT DISTINCT 
                OrgCode
                ,OrgDesc
          FROM dbo.OrgLevel WITH (NOLOCK)
          GROUP BY AuditKey, OrgCode,OrgDesc)OrgCode1
          ON OrgCode1.OrgCode = EecOrgLvl1
          --AND LTRIM(OrgCode1.OrgDesc,-1) <> 'x'

     LEFT JOIN (SELECT DISTINCT OrgCode,OrgDesc
          FROM dbo.OrgLevel WITH (NOLOCK)
          GROUP BY OrgCode,OrgDesc)OrgCode2
          ON OrgCode2.OrgCode = EecOrgLvl2

    LEFT JOIN (SELECT DISTINCT EEID,OrgLvl4,OrgLvl4Seg
         FROM dbo.Tmpalloc WITH (NOLOCK)
         GROUP BY EEID,OrgLvl4,OrgLvl4Seg) gl
         ON gl.OrgLvl4 = EecOrgLvl4

	WHERE EecEEType NOT IN ('CON', 'SUM', 'INT', 'TES', 'TMP', 'REG', 'STU')


 --   --JOIN dbo.OrgLevel org2 WITH (NOLOCK)
 --   --    ON org2.OrgCode = EecOrgLvl2
    
    --LEFT JOIN (SELECT DISTINCT OrgCode,OrgDesc
    --      FROM dbo.OrgLevel WITH (NOLOCK)
    --      GROUP BY OrgCode,OrgDesc)OrgCode3
 --         ON OrgCode3.OrgCode = EecOrgLvl3 
 --   --JOIN dbo.OrgLevel org3 WITH (NOLOCK)
 --   --    ON org3.OrgCode = EecOrgLvl3

    --LEFT JOIN (SELECT DISTINCT OrgCode,OrgDesc
    --      FROM dbo.OrgLevel WITH (NOLOCK)
    --      GROUP BY OrgCode,OrgDesc)OrgCode4
 --         ON OrgCode4.OrgCode = EecOrgLvl4 
 --   --JOIN dbo.OrgLevel org4 WITH (NOLOCK)
 --   --    ON org4.OrgCode = EecOrgLvl4  
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBOWDEMEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBOWDEMEXP_Header;
    SELECT DISTINCT
         hrvEquholdCode_PartID = 'EquityholderCode/ParticipantID'
        ,hrvSSN_Tax_ID = 'SSN/Tax ID'
        ,hrvFirstName = 'FirstName'
        ,hrvLastName = 'LastName'
        ,hrvUserCode1 = 'UserCode1'
        ,hrvHomeAddressLine1 = 'HomeAddressLine1'
        ,hrvHomeAddressLine2 = 'HomeAddressLine2'
        ,hrvHomeDistRegion = 'HomeDistrictorRegion'
        ,hrvHomeCity = 'HomeCity'
        ,hrvCurrStateorProv = 'CurrentStateorProvince'
        ,hrvCurrPostalCode = 'CurrentPostalCode'
        ,hrvCurrCountry = 'CurrentCountry'
        ,hrvUserCode2 = 'UserCode2'
        ,hrvCurr_WorkEmailAdd = 'Current/WorkEmailAddress'
        ,hrvUserCode3 = 'UserCode3'
        ,hrvDateRelatshipStart = 'DateRelationshipStarted'
        ,hrvTerminationDate = 'TerminationDate' -- CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,hrvTerminationType = 'TerminationType'
		,hrvSect16Emp = 'Section16Employee'
        ,hrvCurrJobTitle = 'CurrentJobTitle'
        ,hrvCurrDept = 'CurrentDepartment'
        ,hrvCurrSection = 'CurrentSection'
        ,hrvCurrBranch = 'CurrentBranch'
        ,hrvSubsCode = 'SubsidiaryCode'
        ,hrvExpGroup = 'ExperienceGroup'
        ,hrvUserCode4 = 'UserCode4'
        ,hrvDateofBirth = 'DateofBirth'
        ,hrvAsofDate = 'AsofDate'
        ,hrvAnnualSalary = 'AnnualSalary'
        ,hrvRetEligDate = 'RetirementEligibilityDate'
        ,hrvRelattoCompany = 'RelationshiptoCompany'
    INTO dbo.U_EBOWDEMEXP_Header
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Bowman_Demographic_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEBOWDEMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBOWDEMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBOWDEMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108011'
       ,expStartPerControl     = '202108011'
       ,expLastEndPerControl   = '202108319'
       ,expEndPerControl       = '202108319'
WHERE expFormatCode = 'EBOWDEMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBOWDEMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBOWDEMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBOWDEMEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBOWDEMEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBOWDEMEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBOWDEMEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBOWDEMEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBOWDEMEXP', 'UseFileName', 'V', 'Y'


-- End ripout