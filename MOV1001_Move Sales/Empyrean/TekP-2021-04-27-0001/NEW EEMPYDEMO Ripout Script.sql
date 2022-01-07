/**********************************************************************************

EEMPYDEMO: Empyrean Demographic Export

FormatCode:     EEMPYDEMO
Project:        Empyrean Demographic Export
Client ID:      MOV1001
Date/time:      2022-01-05 04:23:00.403
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    N33
Server:         N3SUP3DB01
Database:       ULTIPRO_MVS
Web Filename:   MOV1001_M3D41_EEHISTORY_EEMPYDEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EEMPYDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_EEMPYDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EEMPYDEMO'


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
WHERE FormatCode = 'EEMPYDEMO'
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
WHERE ExpFormatCode = 'EEMPYDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EEMPYDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EEMPYDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EEMPYDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EEMPYDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EEMPYDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EEMPYDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EEMPYDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EEMPYDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EEMPYDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EEMPYDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEEMPYDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPYDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPYDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPYDEMO];
GO
IF OBJECT_ID('U_EEMPYDEMO_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_PEarHist];
GO
IF OBJECT_ID('U_EEMPYDEMO_Mapping_Actions') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_Mapping_Actions];
GO
IF OBJECT_ID('U_EEMPYDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_File];
GO
IF OBJECT_ID('U_EEMPYDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_EEList];
GO
IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_T91') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_DrvTbl_T91];
GO
IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_H01') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_DrvTbl_H01];
GO
IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_D11') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_DrvTbl_D11];
GO
IF OBJECT_ID('U_EEMPYDEMO_AuditFields_Action') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_AuditFields_Action];
GO
IF OBJECT_ID('U_EEMPYDEMO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_AuditFields];
GO
IF OBJECT_ID('U_EEMPYDEMO_Audit_WTF') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_Audit_WTF];
GO
IF OBJECT_ID('U_EEMPYDEMO_Audit_Action') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_Audit_Action];
GO
IF OBJECT_ID('U_EEMPYDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEMPYDEMO_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEMPYDEMO','Empyrean Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EEMPYDEMO0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPYDEMO0Z0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPYDEMO0Z0','50','H','01','2',NULL,'Client Name',NULL,NULL,'"Realtor"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPYDEMO0Z0','50','H','01','3',NULL,'File creation Date',NULL,NULL,'"drvFileCreationDate"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPYDEMO0Z0','50','D','11','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPYDEMO0Z0','50','D','11','2',NULL,'Sub Company',NULL,NULL,'"drvSubCompany"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPYDEMO0Z0','50','D','11','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPYDEMO0Z0','50','D','11','4',NULL,'Previous SSN',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPYDEMO0Z0','50','D','11','5',NULL,'Employee ID',NULL,NULL,'"drvEmpNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPYDEMO0Z0','50','D','11','6',NULL,'Person Type',NULL,NULL,'"E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPYDEMO0Z0','50','D','11','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMPYDEMO0Z0','50','D','11','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMPYDEMO0Z0','50','D','11','9',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EEMPYDEMO0Z0','50','D','11','10',NULL,'Date Of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EEMPYDEMO0Z0','50','D','11','11',NULL,'WORK E-MAIL ADDRESS',NULL,NULL,'"drvAddressEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EEMPYDEMO0Z0','50','D','11','12',NULL,'Marital Status',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EEMPYDEMO0Z0','50','D','11','13',NULL,'Marital Status Effective Date',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EEMPYDEMO0Z0','50','D','11','14',NULL,'ORIGINAL HIRE DATE',NULL,NULL,'"drvDateOfSeniority"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EEMPYDEMO0Z0','50','D','11','15',NULL,'LATEST HIRE DATE',NULL,NULL,'"drvDateOfLastHire"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EEMPYDEMO0Z0','50','D','11','16',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EEMPYDEMO0Z0','50','D','11','17',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EEMPYDEMO0Z0','50','D','11','18',NULL,'Company Code Effective Date',NULL,NULL,'"drvCompanyCodeEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EEMPYDEMO0Z0','50','D','11','19',NULL,'JOB TITLE',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EEMPYDEMO0Z0','50','D','11','20',NULL,'WORK PHONE',NULL,NULL,'"drvPhoneBusinessNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EEMPYDEMO0Z0','50','D','11','21',NULL,'Permanent Telephone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EEMPYDEMO0Z0','50','D','11','22',NULL,'Permanent ADDRESS 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EEMPYDEMO0Z0','50','D','11','23',NULL,'Permanent ADDRESS 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EEMPYDEMO0Z0','50','D','11','24',NULL,'Permanent ADDRESS 3',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EEMPYDEMO0Z0','50','D','11','25',NULL,'Permanent CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EEMPYDEMO0Z0','50','D','11','26',NULL,'Permanent STATE',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EEMPYDEMO0Z0','50','D','11','27',NULL,'Permanent COUNTRY',NULL,NULL,'"drvAddressCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EEMPYDEMO0Z0','50','D','11','28',NULL,'Permanent Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EEMPYDEMO0Z0','50','D','11','29',NULL,'ADDRESS EFFECTIVE DATE',NULL,NULL,'"drvAddressEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EEMPYDEMO0Z0','50','D','11','30',NULL,'FLSA code',NULL,NULL,'"drvFLSAType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EEMPYDEMO0Z0','50','D','11','31',NULL,'Union Code',NULL,NULL,'"drvUnionCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EEMPYDEMO0Z0','50','D','11','32',NULL,'Union Code Effective Date',NULL,NULL,'"drvUnionCodeEffDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EEMPYDEMO0Z0','50','D','11','33',NULL,'Department Code',NULL,NULL,'"drvOrgLvl2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EEMPYDEMO0Z0','50','D','11','34',NULL,'Department Code Effective Date',NULL,NULL,'"drvDepartmentEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EEMPYDEMO0Z0','50','D','11','35',NULL,'FULL-TIME/PART-TIME ATTRIBUTE',NULL,NULL,'"drvFullTimeOrPartTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EEMPYDEMO0Z0','50','D','11','36',NULL,'FULL-TIME/PART-TIME ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvFullTimeOrPartTimeEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EEMPYDEMO0Z0','50','D','11','37',NULL,'REG TEMP Indicator',NULL,NULL,'"R"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EEMPYDEMO0Z0','50','D','11','38',NULL,'REG TEMP Indicator EFFECTIVE DATE',NULL,NULL,'"drvRegTempIndicatorEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EEMPYDEMO0Z0','50','D','11','39',NULL,'Work State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EEMPYDEMO0Z0','50','D','11','40',NULL,'Work State Effective Date',NULL,NULL,'"drvWorkStateEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EEMPYDEMO0Z0','50','D','11','41',NULL,'Benefit Program',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EEMPYDEMO0Z0','50','D','11','42',NULL,'Benefit Program Effective Date',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EEMPYDEMO0Z0','50','D','11','43',NULL,'ADP Pay Group',NULL,NULL,'"drvPayGroup"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EEMPYDEMO0Z0','50','D','11','44',NULL,'ADP Pay Group Effective Date',NULL,NULL,'"drvADPPayGroupEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EEMPYDEMO0Z0','50','D','11','45',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EEMPYDEMO0Z0','50','D','11','46',NULL,'Pay Frequency Effective Date',NULL,NULL,'"drvPayFrequencyEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EEMPYDEMO0Z0','50','D','11','47',NULL,'Salaried Hourly Indicator',NULL,NULL,'"drvHourlyOrSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EEMPYDEMO0Z0','50','D','11','48',NULL,'Salaried Hourly Effective Date',NULL,NULL,'"drvSalariedHourlyEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EEMPYDEMO0Z0','50','D','11','49',NULL,'ANNUAL SALARY',NULL,NULL,'"drvAnnSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EEMPYDEMO0Z0','50','D','11','50',NULL,'Annual SALARY EFFECTIVE DATE',NULL,NULL,'"drvAnnualSalaryEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EEMPYDEMO0Z0','50','D','11','51',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyPayRate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EEMPYDEMO0Z0','50','D','11','52',NULL,'Hourly Rate EFFECTIVE DATE',NULL,NULL,'"drvHourlyRateEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EEMPYDEMO0Z0','50','D','11','53',NULL,'STANDARD HOURS Per Week',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EEMPYDEMO0Z0','50','D','11','54',NULL,'STANDARD HOURS Per Week EFFECTIVE DATE',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EEMPYDEMO0Z0','50','D','11','55',NULL,'Incentive Pay',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EEMPYDEMO0Z0','50','D','11','56',NULL,'Incentive Pay Effective Date',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EEMPYDEMO0Z0','50','D','11','57',NULL,'Bonus',NULL,NULL,'"drvBonus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EEMPYDEMO0Z0','50','D','11','58',NULL,'Bonus Effective Date',NULL,NULL,'"drvBonusEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EEMPYDEMO0Z0','50','D','11','59',NULL,'ACTION CODE',NULL,NULL,'"drvActionCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EEMPYDEMO0Z0','50','D','11','60',NULL,'ACTION CODE EFFECTIVE DATE',NULL,NULL,'"drvActionCodeEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EEMPYDEMO0Z0','50','D','11','61',NULL,'ACTION Reason CODE',NULL,NULL,'"drvActionReasonCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EEMPYDEMO0Z0','50','D','11','62',NULL,'ACTION Reason CODE EFFECTIVE DATE',NULL,NULL,'"drvActionReasonCodeEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EEMPYDEMO0Z0','50','D','11','63',NULL,'Seniority Date',NULL,NULL,'"drvDateOfSeniority2"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EEMPYDEMO0Z0','50','D','11','64',NULL,'Last Term Date',NULL,NULL,'"drvDateOfTermination"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EEMPYDEMO0Z0','50','D','11','65',NULL,'JOB Level',NULL,NULL,'"spaces"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EEMPYDEMO0Z0','50','D','11','66',NULL,'Severance End Date',NULL,NULL,'"spaces"','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPYDEMO0Z0','50','T','91','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPYDEMO0Z0','50','T','91','2',NULL,'Total Number of Records',NULL,NULL,'"drvTotalNumberOfRecords"','(''UNT0''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EEMPYDEMO_20220105.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OG4IV,NR767',NULL,NULL,NULL,'Empyrean Demographic','202110281','EMPEXPORT','ONDMD_XOE','Oct 28 2021  8:19PM','EEMPYDEMO',NULL,NULL,NULL,'202110281','Oct 28 2021 12:00AM','Dec 30 1899 12:00AM','202110211','1805','','','202110211',dbo.fn_GetTimedKey(),NULL,'US3CPEMOV1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',OG4IV,NR767',NULL,NULL,NULL,'Empyrean Demographic Sched','202108169','EMPEXPORT','SCHEDULED',NULL,'EEMPYDEMO',NULL,NULL,NULL,'202112299','Nov  1 2019  2:50PM','Nov  1 2019  2:50PM','202112221',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OG4IV,NR767',NULL,NULL,NULL,'Empyrean Demographic Test','202201041','EMPEXPORT','TEST_XOE','Jan  4 2022 11:18PM','EEMPYDEMO',NULL,NULL,NULL,'202201041','Jan  4 2022 12:00AM','Dec 30 1899 12:00AM','202112231','1751','','','202112231',dbo.fn_GetTimedKey(),NULL,'US3CPEMOV1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPYDEMO','ArchivePath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPYDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPYDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPYDEMO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPYDEMO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPYDEMO','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPYDEMO','H01','dbo.U_EEMPYDEMO_DrvTbl_H01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPYDEMO','D11','dbo.U_EEMPYDEMO_DrvTbl_D11',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPYDEMO','T91','dbo.U_EEMPYDEMO_DrvTbl_T91',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EEMPYDEMO_Audit
-----------

IF OBJECT_ID('U_EEMPYDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [AudUniqueKey] int NOT NULL,
    [AudActionCode] varchar(30) NULL,
    [AudActionDesc] varchar(30) NULL,
    [AudActionEffDate] datetime NULL,
    [AudPriority] int NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EEMPYDEMO_Audit_Action
-----------

IF OBJECT_ID('U_EEMPYDEMO_Audit_Action') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_Audit_Action] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [AudUniqueKey] int NOT NULL,
    [AudActionCode] varchar(30) NULL,
    [AudActionDesc] varchar(30) NULL,
    [AudActionEffDate] datetime NULL,
    [AudPriority] int NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EEMPYDEMO_Audit_WTF
-----------

IF OBJECT_ID('U_EEMPYDEMO_Audit_WTF') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_Audit_WTF] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [AudUniqueKey] int NOT NULL,
    [AudActionCode] varchar(30) NULL,
    [AudActionDesc] varchar(30) NULL,
    [AudActionEffDate] datetime NULL,
    [AudPriority] int NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EEMPYDEMO_AuditFields
-----------

IF OBJECT_ID('U_EEMPYDEMO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EEMPYDEMO_AuditFields_Action
-----------

IF OBJECT_ID('U_EEMPYDEMO_AuditFields_Action') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_AuditFields_Action] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EEMPYDEMO_DrvTbl_D11
-----------

IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_D11') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_DrvTbl_D11] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvRowNo] bigint NULL,
    [drvSubCompany] varchar(4) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvDateOfSeniority] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvLocation] char(6) NULL,
    [drvCompanyCode] char(5) NULL,
    [drvCompanyCodeEffectiveDate] datetime NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressEffectiveDate] datetime NOT NULL,
    [drvFLSAType] varchar(1) NOT NULL,
    [drvUnionCode] varchar(4) NULL,
    [drvUnionCodeEffDate] datetime NULL,
    [drvOrgLvl2] varchar(10) NULL,
    [drvDepartmentEffectiveDate] datetime NULL,
    [drvFullTimeOrPartTime] char(1) NULL,
    [drvFullTimeOrPartTimeEffectiveDate] datetime NULL,
    [drvRegTempIndicatorEffectiveDate] datetime NULL,
    [drvState] varchar(255) NULL,
    [drvWorkStateEffectiveDate] datetime NULL,
    [drvPayGroup] varchar(6) NOT NULL,
    [drvADPPayGroupEffectiveDate] datetime NULL,
    [drvPayFrequency] char(1) NULL,
    [drvPayFrequencyEffectiveDate] datetime NULL,
    [drvHourlyOrSalary] char(1) NULL,
    [drvSalariedHourlyEffectiveDate] datetime NULL,
    [drvAnnSalary] varchar(8000) NULL,
    [drvAnnualSalaryEffectiveDate] datetime NULL,
    [drvHourlyPayRate] varchar(30) NULL,
    [drvHourlyRateEffectiveDate] datetime NULL,
    [drvBonus] varchar(30) NULL,
    [drvBonusEffectiveDate] datetime NULL,
    [drvActionCode] nvarchar(2000) NULL,
    [drvActionCodeEffectiveDate] datetime NULL,
    [drvActionReasonCode] varchar(50) NULL,
    [drvActionReasonCodeEffectiveDate] datetime NULL,
    [drvDateOfSeniority2] datetime NULL,
    [drvDateOfTermination] datetime NULL
);

-----------
-- Create table U_EEMPYDEMO_DrvTbl_H01
-----------

IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_H01') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_DrvTbl_H01] (
    [drvFileCreationDate] datetime NOT NULL
);

-----------
-- Create table U_EEMPYDEMO_DrvTbl_T91
-----------

IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_T91') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_DrvTbl_T91] (
    [drvTotalNumberOfRecords] int NULL
);

-----------
-- Create table U_EEMPYDEMO_EEList
-----------

IF OBJECT_ID('U_EEMPYDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EEMPYDEMO_File
-----------

IF OBJECT_ID('U_EEMPYDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EEMPYDEMO_Mapping_Actions
-----------

IF OBJECT_ID('U_EEMPYDEMO_Mapping_Actions') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_Mapping_Actions] (
    [ActCode] varchar(15) NULL,
    [ActDesc] varchar(50) NULL
);

-----------
-- U_EEMPYDEMO_Mapping_Actions inserts
-----------

INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('100','New hire');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('101','Rehire');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('200','Merit increase');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('201','Salary adjustment');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('202','Salary reduction');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('205','Bonus');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('300','Promotion');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('301','Reclassification');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('400','Hours increase');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('401','Hours reduction');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('502','Supervisor Change');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('503','Title Change');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('504','Dept Change');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('700','Status change');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('800','Termination');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('TRI','Transferred in');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('TRO','Transferred out');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('WLC','Work location change');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('Z','<None>');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('119','Care of Fmly CA only');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('121','Care of Fmly non CA');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('123','Administrative Paid');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('124','Administrative Unpaid');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('LTD','Long Term Disability');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('MAS','Military - Active Service');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('MFM','Military - Family');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PBIRTH','Paid Birth');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PADOPT','Paid Adoption');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PFOSTR','Paid Foster');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PSURRO','Paid Surrogacy');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('UPBRTH','Unpaid Birth');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('UPADPT','Unpaid Adoption');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('UPFOST','Unpaid Foster');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('UPSURR','Unpaid Surrogacy');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PERSNL','Personal');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('WKCOMP','Workers Comp');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PDM05','Paid Medical 0-5');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PDM610','Paid Medical 6-10');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PDM11','Paid Medical 11+');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('RFL','Return From Leave');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('203','Cost of living adjustment');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('302','Demotion');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('303','Job Leveling');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('500','Transfer');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('501','Reorganization');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('505','Conv to Reg from Temp');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('506','Payroll Maintenance');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('600','Management request');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('601','Employee request');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('900','Mass update');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('COFF','Counter Offer');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('DCOR','Data Correction');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('EQI','Grant Indicator');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('HOME','Home Company');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('PCEU','Position Control Update');
INSERT INTO [dbo].[U_EEMPYDEMO_Mapping_Actions] (ActCode,ActDesc) VALUES ('TRB','Transferred back');

-----------
-- Create table U_EEMPYDEMO_PEarHist
-----------

IF OBJECT_ID('U_EEMPYDEMO_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMPYDEMO_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmtIncentive] numeric NULL,
    [PehCurAmtBonus] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPYDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Move Sales, Inc.

Created By: Wyle Cordero
Business Analyst: Bridget Amsden
Create Date: 11/01/2019
Service Request Number: SR-2019-00247274

Purpose: Empyrean Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
Luis Lugo           07/26/2021     SR-2021-00314467   TekP-2021-04-27-0001/Updated to consider New Hires changes

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPYDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPYDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPYDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMPYDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPYDEMO' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPYDEMO', 'ONDMD_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPYDEMO', 'TEST_XOE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EEMPYDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMPYDEMO';

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
    DELETE FROM dbo.U_EEMPYDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPYDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Only include company OG4IV
    DELETE El
    FROM dbo.U_EEMPYDEMO_EEList El
    WHERE xCoID <> 'OG4IV'
    AND xCoID <> 'NR767';

    -- Only include EecEEType 'REG'
    DELETE El
    FROM dbo.U_EEMPYDEMO_EEList El
    INNER JOIN dbo.vw_int_EmpComp
        ON xEEID = EecEEID
        AND xCoID = EecCoID
        --AND EecEEType <> 'REG'
        AND EecEEType NOT IN ('REG','INT','STU','TMP')  --<> 'REG'
    ;

    -- Include terms within the last 30 days of the effective date.
    DELETE El
    FROM dbo.U_EEMPYDEMO_EEList El
    INNER JOIN dbo.vw_int_EmpComp
        ON xEEID = EecEEID
        AND xCoID = EecCoID
        AND EecEmplStatus = 'T'
        AND EecDateOfTermination < DATEADD(DAY, -30, CONVERT(DATE, @EndDate))
    ;

    -- Exclude employees where EecDateOfLastHire > @EndDate
    DELETE el
    FROM dbo.U_EEMPYDEMO_EEList el
    INNER JOIN dbo.vw_int_EmpComp
        ON xEEID = EecEEID
        AND xCoID = EecCoID
        AND EecDateOfLastHire > GETDATE()
    ;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEMPYDEMO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_AuditFields;
    CREATE TABLE dbo.U_EEMPYDEMO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhReason');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhAnnSalary');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhEEType');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhEmplStatus');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhFullTimeOrPartTime');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhSalaryOrHourly');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhHourlyPayRate');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhOrgLvl2');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhPayPeriod');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhPayGroup');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhIsPromotion');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhIsRateChange');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhSupervisorID');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhJobTitle');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhLocation');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHJob','EjhJobEffDate');

    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpComp','EecStateSUI');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpComp','EecLeaveReason');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpComp','EecJobChangeReason');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');

    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpHStat','EshEmplStatusReason');

    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields VALUES ('EmpPers','EepPhoneHomeNumber');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEMPYDEMO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,AudUniqueKey = AudUniqueKey
        ,AudActionCode = CONVERT(VARCHAR, NULL) -- Custom field
        ,AudActionDesc = CONVERT(VARCHAR, NULL) -- Custom field
        ,AudActionEffDate = CONVERT(DATETIME, NULL) -- Custom field
        ,AudPriority = 0
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EEMPYDEMO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPYDEMO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audAction <> 'DELETE'
    AND EXISTS (SELECT 1 FROM dbo.U_EEMPYDEMO_EEList WITH (NOLOCK) WHERE xEEID = audKey1Value AND xCoID = audKey2Value);

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPYDEMO_Audit ON dbo.U_EEMPYDEMO_Audit (audEEID,audKey2, audDateTime);



    IF OBJECT_ID('U_EEMPYDEMO_AuditFields_Action','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_AuditFields_Action;

    CREATE TABLE dbo.U_EEMPYDEMO_AuditFields_Action (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EEMPYDEMO_AuditFields_Action VALUES ('EmpHJob','EjhReason');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields_Action VALUES ('EmpComp','EecLeaveReason');
    INSERT INTO dbo.U_EEMPYDEMO_AuditFields_Action VALUES ('EmpComp','EecJobChangeReason');
    --INSERT INTO dbo.U_EEMPYDEMO_AuditFields_Action VALUES ('EmpComp','EecJobChangeReason');
        
    IF OBJECT_ID('U_EEMPYDEMO_Audit_Action','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_Audit_Action;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,AudUniqueKey = AudUniqueKey
        ,AudActionCode = CONVERT(VARCHAR, NULL) -- Custom field
        ,AudActionDesc = CONVERT(VARCHAR, NULL) -- Custom field
        ,AudActionEffDate = CONVERT(DATETIME, NULL) -- Custom field
        ,AudPriority = 0
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EEMPYDEMO_Audit_Action
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPYDEMO_AuditFields_Action WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audAction <> 'DELETE'
        AND audNewValue IN ('PDM11','PBIRTH','119','121','123','124','505','LTD','MAS','MFM','PADOPT','PFOSTR','PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL')
    --AND EXISTS (SELECT 1 FROM dbo.U_EEMPYDEMO_EEList WITH (NOLOCK) WHERE xEEID = audKey1Value AND xCoID = audKey2Value);

    DELETE dbo.U_EEMPYDEMO_Audit_Action WHERE audRowNo <> 1;

    -- Only keep the most recent change in audit.
   DELETE Aud
    FROM dbo.U_EEMPYDEMO_Audit Aud
    WHERE AudRowNo <> 1
       
    -- Update action codes in audit.
    UPDATE Aud
    SET AudActionCode = 
        CASE 
            WHEN (EecEmplStatus = 'T' AND AudFieldName IN ('EjhEmplStatus', 'EecEmplStatus') AND AudNewValue = 'T') OR (AudFieldName = 'EecFullTimeOrPartTime' AND audOldValue = 'F' AND audNewValue = 'P') THEN '800'
            WHEN AudFieldName = 'EjhFullTimeOrPartTime' AND audNewValue = 'P' AND EXISTS 
                (SELECT 1 FROM dbo.U_EEMPYDEMO_Audit a2 WHERE a2.audEEID = aud.audEEID AND a2.audKey2 = aud.audKey2 AND a2.audFieldName = 'EecFullTimeOrPartTime' AND a2.audOldValue = 'F' AND a2.audNewValue = 'P') THEN '800'
            WHEN AudFieldName IN ('EjhReason', 'EecJobChangeReason') AND AudNewValue IN (SELECT ActCode FROM [dbo].[U_EEMPYDEMO_Mapping_Actions]) THEN audNewValue
            WHEN audFieldName = 'EecLeaveReason' AND audNewValue IN (SELECT ActCode FROM [dbo].[U_EEMPYDEMO_Mapping_Actions]) THEN audNewValue
            WHEN audTableName = 'EmpPers' THEN 'ADDR'
            WHEN audFieldName = 'EecStateSUI' THEN 'LOC'
        END
    FROM dbo.U_EEMPYDEMO_Audit Aud
    INNER JOIN dbo.vw_int_EmpComp Ec
        ON AudEEID = EecEEID
        AND AudKey2 = EecCoID
    ;
    -- Update action description in audit.
    UPDATE Aud
    SET AudActionDesc =  ActDesc
    FROM dbo.U_EEMPYDEMO_Audit Aud
    LEFT JOIN [dbo].[U_EEMPYDEMO_Mapping_Actions]
        ON AudActionCode = ActCode
    ;

    -- Update action effective date in audit for employee job changes.
  UPDATE AUD
    SET AudActionEffDate = (SELECT MAX(EjhJobEffDate) FROM dbo.vw_int_EmpHJob
        WHERE AUD.AudEEID = EjhEEID
        AND AUD.AudKey2 = EjhCoID        
       -- AND AUD.AudUniqueKey = AuditKey
        AND AUD.Audtablename = 'EmpHJob')
        FROM dbo.U_EEMPYDEMO_Audit AUD 
        
        --select * from U_EEMPYDEMO_Audit where audeeid = 'C5OK8V0000K0'
    --UPDATE Aud
    --SET AudActionEffDate = EjhJobEffDate
    --FROM dbo.U_EEMPYDEMO_Audit Aud
    --INNER JOIN dbo.vw_int_EmpHJob
    --    ON AudEEID = EjhEEID
    --    AND AudKey2 = EjhCoID
    --    AND AudUniqueKey = AuditKey
    ;

    -- Update action effective date in audit for employee LOA changes.
    UPDATE Aud
    SET AudActionEffDate = EshStatusStartDate
    FROM dbo.U_EEMPYDEMO_Audit Aud
    INNER JOIN dbo.vw_int_EmpComp
        ON EecEEID = audEEID
        AND EecCoID = audKey2
        AND EecEmplStatus = 'L'
    INNER JOIN dbo.EmpHStat
        ON EshEEID = EecEEID
        AND EshCoID = EecCoID
        AND EshEmplStatus = EecEmplStatus
        AND EshIsCurrent = 'Y'
    WHERE audFieldName = 'EecLeaveReason'
    ;

    -- Update action effective date for table EmpPers & Location
    UPDATE Aud
    SET AudActionEffDate = audDateTime
    FROM dbo.U_EEMPYDEMO_Audit Aud
    WHERE audTableName = 'EmpPers'
    OR audFieldName = 'EecStateSUI';

    -- Update audit priority for sorting.
    UPDATE aud
    SET AudPriority = 
        CASE 
            WHEN AudActionCode = '800' THEN '1'
            WHEN AudActionCode IN ('100', '101') AND AudActionEffDate NOT BETWEEN @StartDate AND @EndDate THEN '3'
            ELSE '2'
        END
    FROM dbo.U_EEMPYDEMO_Audit Aud   


/***********************************************************************************************************************************
-- Importing appendix files provided by the client for mapping purposes.
-- Run the scripts below if the files need to be imported again.
--===================================
-- Benefits File for Total Rewards:
--====================================
CREATE TABLE [ULTIPRO_MVS].[dbo].[U_EEMPYDEMO_Mapping_Actions] (
    [ActCode] VARCHAR(15)
    ,[ActDesc] VARCHAR(50)
)
BULK INSERT [ULTIPRO_MVS].[dbo].[U_EEMPYDEMO_Mapping_Actions]
FROM '\\us.saas\N3\Public\MOV1001\Exports\Empyrean\Appendix\Actions Mappings.csv'
    WITH
    (
        FIELDTERMINATOR = '|'
        ,ROWTERMINATOR = '\n'
        ,FIRSTROW = 2
    )
-- DROP TABLE [dbo].[U_EEMPYDEMO_Mapping_Actions]
***********************************************************************************************************************************/

    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_EEMPYDEMO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmtIncentive = SUM(CASE WHEN ErnLongDesc LIKE '%Incentive%' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtBonus = SUM(CASE WHEN ErnTaxCategory = 'BONPY' THEN PehCurAmt ELSE 0.00 END)
    INTO dbo.U_EEMPYDEMO_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    INNER JOIN dbo.EarnCode WITH (NOLOCK)
        ON PehEarnCode = ErnEarnCode
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPYDEMO_PEarHist ON dbo.U_EEMPYDEMO_PEarHist (PehEEID, PrgPayDate);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMPYDEMO_DrvTbl_D11
    ---------------------------------
    IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_D11','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_DrvTbl_D11;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort =  EepSSN
        ,drvRowNo = ROW_NUMBER() OVER (PARTITION BY xEEID, xCoID ORDER BY aud.AudDateTime, AudPriority)
        -- standard fields above and additional driver fields below
        ,drvSubCompany = 'MVSU' -- CASE WHEN EecCoID = 'MVSU' THEN 'MVSU'
                                 --WHEN EecCoID = 'MSIMU'THEN 'MSIM' END
        ,drvSSN = eepSSN
        ,drvEmpNo = SUBSTRING(EecEmpNo, PATINDEX('%[^0]%', EecEmpNo+'.'), LEN(EecEmpNo))
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'M' ELSE 'F' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressEmail = EepAddressEMail
        ,drvDateOfSeniority = EecDateOfSeniority
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvLocation = EecLocation
        ,drvCompanyCode = CmpCompanyCode
        -- 18
        ,drvCompanyCodeEffectiveDate = CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                    /*CASE WHEN EecEmplStatus = 'T'
                                       THEN eecdateoftermination
                                       ELSE ejhJobEffDate --auddate.audActionEffDate --CASE WHEN aud.audRowNo = '1' AND aud.audFieldName = 'EjhJobEffDate' THEN aud.audActionEffDate END
                                       END   */             
        
                                        --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhCoID'), aud.AudActionEffDate)



        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressCountry = EepAddressCountry
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressEffectiveDate = getdate()--COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudTableName = 'EmpPers'), aud.AudActionEffDate)
        ,drvFLSAType = CASE WHEN JbcFLSAType = 'N' THEN 'N' ELSE 'E' END
        ,drvUnionCode = CASE WHEN EecPayGroup IN ('MSIMHR','MSIMSL') THEN 'MSIM'
                             WHEN EecPayGroup IN ('USASLY', 'USAHRL','EXECS') THEN 'MVSU'
                             WHEN EecPayGroup IN ('OPHRLY','OPSRLY','OPEXEC')THEN 'OPC' END

        ,drvUnionCodeEffDate = CASE WHEN EecJobChangeReason = '100' 
                                    AND EecCoID = 'NR767' 
                                    THEN EjhJobEffDate
                                    WHEN EecJobChangeReason IN ('500','TRI') THEN EjhJobEffDate
                                    ELSE EecDateOfLastHire
                                    --ELSE (dbo.empcomp.dsi_fnlib_GetPayGroup_EffDate) 
                                    END
        ,drvOrgLvl2 = EecOrgLvl2
        -- 34
        ,drvDepartmentEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                            --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhOrgLvl2'), aud.AudActionEffDate)
        ,drvFullTimeOrPartTime = EecFullTimeOrPartTime
        -- 36
        ,drvFullTimeOrPartTimeEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                                WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                                WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                                    CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                                WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                                ELSE OEjhJobEffDate 
                                                END
                                                --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhFullTimeOrPartTime'), aud.AudActionEffDate)
        -- 38
        ,drvRegTempIndicatorEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                            WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                            WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                                CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                            WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                            ELSE OEjhJobEffDate 
                                            END
                                            --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhEEType'), aud.audActionEffDate)
        ,drvState = LocAddressState
        -- 40
        ,drvWorkStateEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                          /*COALESCE((SELECT MAX(AudActionEffDate) 
                                          FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) 
                                          INNER JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                                          ON EecLocation = audEEID AND EecEEID = xEEID 
                                          AND EecCoID = xCoID 
                                          WHERE audTableName = 'Location'), aud.AudActionEffDate,EecDateOfLastHire)*/
                                         
                                          
        ,drvPayGroup = CASE  WHEN EecPayGroup IN ('OPSRLY', 'OPHRLY', 'OPEXEC') THEN 'Opcity' 
                             ELSE 'MVSU' END
        -- 44
        ,drvADPPayGroupEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                        --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhPayGroup'), aud.AudActionEffDate)
        ,drvPayFrequency = EecPayPeriod
        -- 46
        ,drvPayFrequencyEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                        --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhPayPeriod'), aud.AudActionEffDate)
        ,drvHourlyOrSalary = EecSalaryOrHourly
        -- 48
        ,drvSalariedHourlyEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                            WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                            WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                                CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                            WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                            ELSE OEjhJobEffDate 
                                            END
                                            --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhSalaryOrHourly'), aud.AudActionEffDate)
        ,drvAnnSalary = REPLACE(CONVERT(VARCHAR, CAST(EecAnnSalary AS DECIMAL(11, 2))), '.', '')
        -- 50
        ,drvAnnualSalaryEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                        --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhAnnSalary'), aud.AudActionEffDate)
        ,drvHourlyPayRate = CONVERT(VARCHAR, CAST(EecHourlyPayRate AS DECIMAL(11, 2)))
        -- 52
        ,drvHourlyRateEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END  -- fix me
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate  -- EshStatusStopDate
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
                                        --COALESCE((SELECT MAX(AudActionEffDate) FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK) WHERE xEEID = AudEEID AND xCoID = AudKey2 AND AudFieldName = 'EjhHourlyPayRate'), aud.AudActionEffDate)
        ,drvBonus = CASE WHEN PehCurAmtBonus = 0.00 THEN '' ELSE CONVERT(VARCHAR, CAST(PehCurAmtBonus AS DECIMAL(11, 2))) END
        ,drvBonusEffectiveDate = CASE WHEN PehCurAmtBonus > 0.00 THEN PrgPayDate END

        -- field 59
       ,drvActionCode =    CASE WHEN TermActionCode IS NOT NULL THEN  TermActionCode
                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionCode ELSE OEjhReason END
                        WHEN ActActionCode IS NOT NULL THEN ActActionCode 
                        ELSE OEjhReason 
                        END
         -- field 60                 
        ,drvActionCodeEffectiveDate =    CASE WHEN TermActionCode = 'PERSNL' OR ActActionCode = 'PERSNL' OR OejhReason = 'PERSNL' THEN   
                                            CASE WHEN EshStatusStopDate IS NOT NULL THEN EshStatusStopDate
                                            WHEN OejhReason IS NOT NULL THEN OEjhJobEffDate
                                            END
                                        WHEN TermActionCode IS NOT NULL THEN TermActionEffDate 
                                        WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                        WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                        ELSE OEjhJobEffDate 
                                        END
         --field 61                                                         
        ,drvActionReasonCode =    CASE WHEN TermActionCode IS NOT NULL THEN TermActionDesc
                                WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                            CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionDesc ELSE B.ActDesc END
                                WHEN ActActionCode IS NOT NULL THEN ActActionDesc 
                                ELSE B.ActDesc 
                                END 
        -- field 62                                                     
        ,drvActionReasonCodeEffectiveDate =    CASE WHEN TermActionCode IS NOT NULL THEN TermActionEffDate 
                                            WHEN ActActionCode IS NOT NULL AND OEjhReason  IS NOT NULL THEN
                                                CASE WHEN ActActionEffDate > OEjhJobEffDate THEN ActActionEffDate ELSE OEjhJobEffDate END
                                            WHEN ActActionCode IS NOT NULL THEN ActActionEffDate 
                                            ELSE OEjhJobEffDate 
                                            END
                                    /*CASE WHEN EecEmplStatus = 'T'
                                      THEN eecdateoftermination
                                      ELSE ejhJobEffDate --auddate.audActionEffDate -- CASE WHEN aud.audRowNo = '1' AND aud.audFieldName = 'EjhJobEffDate' THEN aud.audActionEffDate END
                                      END*/

        ,drvDateOfSeniority2 = EecDateOfSeniority
        ,drvDateOfTermination = 

                        CASE WHEN EecEmplStatus = 'T' 
                        AND EecTermReason <> 'TRO'
                        OR  EecJobChangeReason <> '500' 
                        OR EecJobChangeReason <> 'TRO' THEN eecdateoftermination
                        WHEN EecEmplStatus = 'T'
                        AND EecJobChangeReason = '500' 
                        OR  EecJobChangeReason = 'TRO' 
                        --and employee transfered to Company Move Canada Systems (EecCoID = PJ6ZD) 
                        THEN eecdateoftermination END

    INTO dbo.U_EEMPYDEMO_DrvTbl_D11
    FROM dbo.U_EEMPYDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    INNER JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = JbcJobCode
    INNER JOIN dbo.[Location] WITH (NOLOCK)
        ON EecLocation = LocCode
    LEFT JOIN (    SELECT 
                        audEEID
                        ,audKey2
                        ,AudActionEffDate = MAX(audActionEffDate)
                    FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                    WHERE NULLIF(audActionCode, '') IS NOT NULL
                    AND audActionCode NOT IN ('ADDR', 'LOC')
                    GROUP BY audEEID, audKey2
                ) audMax
        ON audMax.audEEID = xEEId
        AND audMax.audKey2 = xCoID
    LEFT JOIN dbo.U_EEMPYDEMO_Audit aud WITH (NOLOCK)
        ON aud.audEEID = xEEId
        AND aud.audKey2 = xCoID
        AND aud.AudActionEffDate = audMax.AudActionEffDate
        AND NULLIF(aud.audActionCode, '') IS NOT NULL


    

    LEFT JOIN (
                SELECT audEEID, audKey2, audFieldName = MAX(audFieldName) ,AudActionEffDate = MAX(audActionEffDate), audActionCode =MAX (audActionCode), audactiondesc = MAX (audactiondesc), audNewValue = MAX(audNewValue)--actdesc =MAX(actdesc)
                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                JOIN dbo.U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                    ON actCode=audActionCode
                WHERE NULLIF(audActionCode, '') IS NOT NULL
                    AND audActionCode  IN ('ADDR', 'LOC','900','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900','COFF','CONV','DCOR','EQI','HOME','PCEU','TRB','200','201')
                    
                            --('ADDR', 'LOC','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900',
                            --'COFF','CONV','DCOR','EQI','HOME','PCEU','TRB','Z','121','123','124','LTD','MAS','MFM','PADOPT','PFOSTR',
                            --'PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL') 
                    GROUP BY audEEID, audKey2) audActive
                    ON audActive.audEEID = xEEId
                    AND audActive.audKey2 = xCoID




                  --  LEFT JOIN (SELECT audEEID, audKey2, audFieldName = MAX(audFieldName) ,AudActionEffDate = MAX(audActionEffDate), audActionCode =MAX (audActionCode), audactiondesc = MAX (audactiondesc), audNewValue = MAX(audNewValue), actdesc = MAX(actdesc)
                  -- FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                  --JOIN dbo.U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                  -- ON actCode=audActionCode
                  --  WHERE NULLIF(audActionCode, '') IS NOT NULL
                  --  AND audFieldName = 'EjhEmplStatus'
                  --  AND audNewValue = 'L'
                  --  AND audActionCode  IN ('PBIRTH','PDM11','PDM05','LTD')
                    
                  --          --('ADDR', 'LOC','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900',
                  --          --'COFF','CONV','DCOR','EQI','HOME','PCEU','TRB','Z','121','123','124','LTD','MAS','MFM','PADOPT','PFOSTR',
                  --          --'PSURRO','UPBRTH','UPADPT','UPFOST','UPSURR','PERSNL','WKCOMP','PDM05','PDM610','RFL') 
                  --  GROUP BY audEEID, audKey2) audLeave
                  --  ON audLeave.audEEID = xEEId
                  --  AND audLeave.audKey2 = xCoID





 LEFT JOIN (Select * from (Select ejheeid,ejhcoid,ejhReason,ejhJobEffDate,ejhEmplStatus,actDesc,actcode,
               ROW_NUMBER() OVER (PARTITION BY ejheeid,ejhcoid ORDER BY ejhJobEffDate desc) 
               row_num from dbo.EmpHJob  
              Join dbo.U_EEMPYDEMO_Mapping_Actions 
               on ejhReason = ActCode            
              -- where ejhEmplStatus = 'A'
               AND ejhReason NOT IN ('ADDR', 'LOC','900','202','203','205','300','301','302','303','500','501','502','503','504','506','600','601','700','900','COFF','CONV','DCOR','EQI','HOME','PCEU','TRB')) JobHistActive
               Where JobHistActive.row_num = 1 ) as JobActive
               on JobActive.ejheeid = xEEId
               and JobActive.ejhcoid = xcoid


--LEFT JOIN (Select * from (Select ejheeid ejheeidleave,ejhcoid ejhcoidleave,ejhReason ejhreasonleave,ejhJobEffDate ejhJobEffDateleave ,ejhEmplStatus ejhEmplStatusleave,actDesc actDescleave, 
--               ROW_NUMBER() OVER (PARTITION BY ejheeid,ejhcoid ORDER BY ejhJobEffDate desc) 
--               row_num from dbo.EmpHJob  
--               Join dbo.U_EEMPYDEMO_Mapping_Actions 
--               on ejhReason = ActCode
--               where ejhEmplStatus = 'L'
--               AND ejhReason in ('PBIRTH','PDM11','PDM05','LTD')) JobHistLeave
--               Where JobHistLeave.row_num = 1 ) as JobLeave
--               on JobLeave.ejheeidleave = xEEId
--               and JobLeave.ejhcoidleave = xcoid



    LEFT JOIN (SELECT Distinct audeeid, audKey2, AudActionEffDate = MAX(audActionEffDate)
                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                WHERE audRowNo = '1'
                AND audFieldName = 'EjhJobEffDate'
                GROUP BY audeeid,audKey2)auddate
                ON auddate.audEEID = xEEId
                AND auddate.audKey2 = xCoID

    /*LEFT JOIN dbo.U_EEMPYDEMO_Audit aud WITH (NOLOCK)
               ON aud.audEEID = xEEId
              AND aud.audKey2 = xCoID
             AND aud.AudActionEffDate = audactive.AudActionEffDate
             AND NULLIF(aud.audActionCode, '') IS NOT NULL*/

    LEFT JOIN dbo.U_EEMPYDEMO_PEarHist
        ON xEEID = PehEEID

    LEFT JOIN (
                SELECT EjhEEID AS OEjhEEID, EjhCOID AS OEjhCOID, EjhReason AS OEjhReason, EjhJobEffDate AS OEjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM EmpHJob
                        WHERE EjhReason IN ('100','101','400','401','800','TRI','TRO','200','201')) AS EjhList
                WHERE RN = 1) AS OuterEjhList
        ON OEjhEEID = xEEID
        AND OEjhCOID = xCOID
    LEFT JOIN dbo.U_EEMPYDEMO_Mapping_Actions B WITH (NOLOCK)
        ON OEjhReason = B.ActCode
    LEFT JOIN (            
                SELECT ActEEID, ActCOID, ActActionCode, ActActionEffDate, ActActionDesc
                FROM (
                        SELECT AudEEID AS ActEEID, AudKey2 AS ActCOID, AudNewValue AS ActActionCode, actDesc AS ActActionDesc, audDateTime AS ActActionEffDate, ROW_NUMBER() OVER (PARTITION BY AudEEID, AudKey2 ORDER BY AudActionEffDate DESC) AS RN
                        FROM dbo.U_EEMPYDEMO_Audit_Action WITH (NOLOCK) 
                        JOIN U_EEMPYDEMO_Mapping_Actions WITH (NOLOCK)
                            ON actCode = audNewValue
                        ) AS InAct
                WHERE RN = 1) AS Actions
        ON ActEEID = xEEID
        AND ActCOID = xCOID
    LEFT JOIN (
                SELECT audEEID AS TermEEID, AudKey2 AS TermCOID, audActionCode AS TermActionCode, AudActionDesc AS TermActionDesc, audActionEffDate AS TermActionEffDate 
                FROM dbo.U_EEMPYDEMO_Audit WITH (NOLOCK)
                WHERE audActionCode = '800'
                AND audActionEffDate IS NOT NULL) as InnerTerm
        ON TermEEID = xEEID
        AND TermCOID = xCOID
    LEFT JOIN (
                select EshEEID, EshCOID, MAX(EshStatusStopDate) AS EshStatusStopDate
                FROM EmpHStat
                WHERE EshEmplStatusReason = 'PERSNL'
                GROUP BY EshEEID, EshCOID) AS PERSNL
        ON EshEEID = xEEID
        AND EshCOID = xCOID


    --JOIN dbo.EmpHJob WITH (NOLOCK)
    --     ON EjhEEID = xEEID 
    --     AND EjhCOID = xCOID
    ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPYDEMO_DrvTblD11 ON dbo.U_EEMPYDEMO_DrvTbl_D11 (drvEEID, drvCoID, drvActionReasonCodeEffectiveDate);

    -- Remove records that are missing action codes.
    DELETE D11
    FROM dbo.U_EEMPYDEMO_DrvTbl_D11 D11
    WHERE NULLIF(drvActionCode, '') IS NULL;

    -- One Row per employee.
    DELETE d11
    FROM dbo.U_EEMPYDEMO_DrvTbl_D11 D11
    WHERE drvRowNo > 1;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_H01','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_DrvTbl_H01;
    SELECT DISTINCT
         drvFileCreationDate = GETDATE()
    INTO dbo.U_EEMPYDEMO_DrvTbl_H01;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EEMPYDEMO_DrvTbl_T91','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPYDEMO_DrvTbl_T91;
    SELECT DISTINCT
         drvTotalNumberOfRecords = (SELECT COUNT(*) FROM dbo.U_EEMPYDEMO_DrvTbl_D11)
    INTO dbo.U_EEMPYDEMO_DrvTbl_T91;

END;

/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEEMPYDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPYDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPYDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108011'
       ,expStartPerControl     = '202108011'
       ,expLastEndPerControl   = '202108169'
       ,expEndPerControl       = '202108169'
WHERE expFormatCode = 'EEMPYDEMO';
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPYDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPYDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EEMPYDEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EEMPYDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EEMPYDEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMPYDEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EEMPYDEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMPYDEMO', 'UseFileName', 'V', 'Y'


-- End ripout