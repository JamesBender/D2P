/**********************************************************************************

ERSPRIN401: Principal 401K Contribution Export

FormatCode:     ERSPRIN401
Project:        Principal 401K Contribution Export
Client ID:      USG1000
Date/time:      2023-12-05 14:56:53.733
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ERSPRIN401_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ERSPRIN401_SavePath') IS NOT NULL DROP TABLE dbo.U_ERSPRIN401_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ERSPRIN401'


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
WHERE FormatCode = 'ERSPRIN401'
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
WHERE ExpFormatCode = 'ERSPRIN401'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ERSPRIN401')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ERSPRIN401'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ERSPRIN401'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ERSPRIN401'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ERSPRIN401'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ERSPRIN401'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ERSPRIN401'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ERSPRIN401'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ERSPRIN401'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ERSPRIN401'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwERSPRIN401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERSPRIN401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERSPRIN401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERSPRIN401];
GO
IF OBJECT_ID('U_ERSPRIN401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_PEarHist];
GO
IF OBJECT_ID('U_ERSPRIN401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_PDedHist];
GO
IF OBJECT_ID('U_ERSPRIN401_File') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_File];
GO
IF OBJECT_ID('U_ERSPRIN401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_EEList];
GO
IF OBJECT_ID('U_ERSPRIN401_drvTbl_407') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_drvTbl_407];
GO
IF OBJECT_ID('U_ERSPRIN401_drvTbl_240') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_drvTbl_240];
GO
IF OBJECT_ID('U_ERSPRIN401_drvTbl_220_I') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_drvTbl_220_I];
GO
IF OBJECT_ID('U_ERSPRIN401_drvTbl_220_D') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_drvTbl_220_D];
GO
IF OBJECT_ID('U_ERSPRIN401_drvTbl_181') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_drvTbl_181];
GO
IF OBJECT_ID('U_ERSPRIN401_drvTbl_180') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_drvTbl_180];
GO
IF OBJECT_ID('U_ERSPRIN401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_DedList];
GO
IF OBJECT_ID('U_ERSPRIN401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_AuditFields];
GO
IF OBJECT_ID('U_ERSPRIN401_Audit') IS NOT NULL DROP TABLE [dbo].[U_ERSPRIN401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ERSPRIN401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ERSPRIN401];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERSPRIN401','Principal 401K Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ERSPRIN401Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERSPRIN401Z0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERSPRIN401Z0','1','D','10','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERSPRIN401Z0','6','D','10','3',NULL,'Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERSPRIN401Z0','1','D','10','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERSPRIN401Z0','9','D','10','5',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERSPRIN401Z0','1','D','10','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERSPRIN401Z0','24','D','10','7',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERSPRIN401Z0','10','D','10','8',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERSPRIN401Z0','1','D','10','9',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERSPRIN401Z0','10','D','10','10',NULL,'Date of Employment',NULL,NULL,'"drvDateofEmployment"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERSPRIN401Z0','1','D','10','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERSPRIN401Z0','1','D','10','12',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERSPRIN401Z0','7','D','10','13',NULL,'Location Number',NULL,NULL,'"drvLocationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERSPRIN401Z0','1','D','10','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERSPRIN401Z0','9','D','10','15',NULL,'Social Security Number',NULL,NULL,'"drvSocialSecurityNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERSPRIN401Z0','1','D','10','16',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ERSPRIN401Z0','10','D','10','17',NULL,'Service Date/PED',NULL,NULL,'"drvServiceDatePED"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ERSPRIN401Z0','1','D','10','18',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ERSPRIN401Z0','5','D','10','19',NULL,'Class Code',NULL,NULL,'"drvClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ERSPRIN401Z0','1','D','10','20',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ERSPRIN401Z0','1','D','10','21',NULL,'Key Status',NULL,NULL,'"drvKeyStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ERSPRIN401Z0','7','D','10','22',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ERSPRIN401Z0','20','D','10','23',NULL,'Alternate ID',NULL,NULL,'"drvAlternateID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ERSPRIN401Z0','1','D','10','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ERSPRIN401Z0','8','D','10','25',NULL,'Eligibility Hours',NULL,NULL,'"drvEligibilityHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ERSPRIN401Z0','1','D','10','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ERSPRIN401Z0','10','D','10','27',NULL,'Hours Begin Date',NULL,NULL,'"drvHoursBeginDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ERSPRIN401Z0','1','D','10','28',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ERSPRIN401Z0','10','D','10','29',NULL,'Hours End Date',NULL,NULL,'"drvHoursEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ERSPRIN401Z0','56','D','10','30',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ERSPRIN401Z0','10','D','10','31',NULL,'Benefit Event Date',NULL,NULL,'"drvBenefitEventDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ERSPRIN401Z0','1','D','10','32',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ERSPRIN401Z0','4','D','10','33',NULL,'Vesting Hours',NULL,NULL,'"drvVestingHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ERSPRIN401Z0','4','D','10','34',NULL,'Benefit Event Reason',NULL,NULL,'"drvBenefitEventReason"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ERSPRIN401Z0','1','D','10','35',NULL,'Payroll Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ERSPRIN401Z0','1','D','10','36',NULL,'Union Status',NULL,NULL,'"drvUnionStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ERSPRIN401Z0','1','D','10','37',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERSPRIN401Z0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERSPRIN401Z0','1','D','20','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERSPRIN401Z0','6','D','20','3',NULL,'Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERSPRIN401Z0','1','D','20','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERSPRIN401Z0','9','D','20','5',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERSPRIN401Z0','1','D','20','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERSPRIN401Z0','24','D','20','7',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERSPRIN401Z0','31','D','20','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERSPRIN401Z0','9','D','20','9',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERSPRIN401Z0','1','D','20','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERSPRIN401Z0','10','D','20','11',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERSPRIN401Z0','144','D','20','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERSPRIN401Z0','3','D','30','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERSPRIN401Z0','1','D','30','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERSPRIN401Z0','6','D','30','3',NULL,'Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERSPRIN401Z0','1','D','30','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERSPRIN401Z0','9','D','30','5',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERSPRIN401Z0','1','D','30','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERSPRIN401Z0','1','D','30','7',NULL,'Foreign Indicator',NULL,NULL,'"drvForeignIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERSPRIN401Z0','1','D','30','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERSPRIN401Z0','50','D','30','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERSPRIN401Z0','50','D','30','10',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERSPRIN401Z0','50','D','30','11',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERSPRIN401Z0','30','D','30','12',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERSPRIN401Z0','2','D','30','13',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERSPRIN401Z0','5','D','30','14',NULL,'Zip',NULL,NULL,'"drvZip5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERSPRIN401Z0','4','D','30','15',NULL,'+4 for Zip Code',NULL,NULL,'"drvZip4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERSPRIN401Z0','26','D','30','16',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERSPRIN401Z0','3','D','40','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERSPRIN401Z0','1','D','40','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERSPRIN401Z0','6','D','40','3',NULL,'Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERSPRIN401Z0','1','D','40','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERSPRIN401Z0','9','D','40','5',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERSPRIN401Z0','1','D','40','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERSPRIN401Z0','1','D','40','7',NULL,'Foreign Indicator',NULL,NULL,'"drvForeignIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERSPRIN401Z0','1','D','40','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERSPRIN401Z0','50','D','40','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERSPRIN401Z0','50','D','40','10',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERSPRIN401Z0','50','D','40','11',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERSPRIN401Z0','50','D','40','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERSPRIN401Z0','17','D','40','13',NULL,'Country Code',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERSPRIN401Z0','3','D','50','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERSPRIN401Z0','1','D','50','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERSPRIN401Z0','6','D','50','3',NULL,'Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERSPRIN401Z0','1','D','50','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERSPRIN401Z0','9','D','50','5',NULL,'Identification Number',NULL,NULL,'"drvIdentificationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERSPRIN401Z0','1','D','50','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERSPRIN401Z0','75','D','50','7',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERSPRIN401Z0','75','D','50','8',NULL,'Personal Email Address',NULL,NULL,'"drvPersonalEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERSPRIN401Z0','17','D','50','9',NULL,'Work Phone Number',NULL,NULL,'"drvWorkPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERSPRIN401Z0','7','D','50','10',NULL,'Work Phone Number Extension',NULL,NULL,'"drvWorkphoneext"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERSPRIN401Z0','17','D','50','11',NULL,'Home Phone Number',NULL,NULL,'"drvHomephone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERSPRIN401Z0','7','D','50','12',NULL,'Home Phone Number Extension',NULL,NULL,'"drvHomephoneext"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERSPRIN401Z0','18','D','50','13',NULL,'Mobile Phone Number',NULL,NULL,'"drvMobile"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERSPRIN401Z0','3','D','50','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERSPRIN401Z0','3','D','60','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERSPRIN401Z0','1','D','60','2',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERSPRIN401Z0','6','D','60','3',NULL,'Contract Number',NULL,NULL,'"drvContractNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERSPRIN401Z0','1','D','60','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERSPRIN401Z0','9','D','60','5',NULL,'Identification Number',NULL,NULL,'"drvIdentificationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERSPRIN401Z0','9','D','60','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERSPRIN401Z0','2','D','60','7',NULL,'Investment Type',NULL,NULL,'"drvInvestmentType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERSPRIN401Z0','4','D','60','8',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERSPRIN401Z0','10','D','60','9',NULL,'Pay Period Ending Date/Pay Date',NULL,NULL,'"drvPayDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERSPRIN401Z0','27','D','60','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERSPRIN401Z0','1','D','60','11',NULL,'Contribution Qualifier Type',NULL,NULL,'"drvContributionType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERSPRIN401Z0','3','D','60','12',NULL,'Elective Deferral',NULL,NULL,'"drvElectiveDeferral"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERSPRIN401Z0','10','D','60','13',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERSPRIN401Z0','1','D','60','14',NULL,'Contribution Qualifier Type',NULL,NULL,'"drvContributionType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERSPRIN401Z0','3','D','60','15',NULL,'Contribution Qualifier',NULL,NULL,'"drvContributionQualifier2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERSPRIN401Z0','10','D','60','16',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ERSPRIN401Z0','1','D','60','17',NULL,'Contribution Qualifier Type',NULL,NULL,'"drvContributionType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ERSPRIN401Z0','3','D','60','18',NULL,'Contribution Qualifier',NULL,NULL,'"drvContributionQualifier3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ERSPRIN401Z0','10','D','60','19',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ERSPRIN401Z0','1','D','60','20',NULL,'Contribution Qualifier Type',NULL,NULL,'"drvContributionType3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ERSPRIN401Z0','3','D','60','21',NULL,'Contribution Qualifier',NULL,NULL,'"drvContributionQualifier4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ERSPRIN401Z0','10','D','60','22',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ERSPRIN401Z0','1','D','60','23',NULL,'Contribution Qualifier Type',NULL,NULL,'"drvContributionType4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ERSPRIN401Z0','3','D','60','24',NULL,'Contribution Qualifier',NULL,NULL,'"drvContributionQualifier5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ERSPRIN401Z0','10','D','60','25',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ERSPRIN401Z0','1','D','60','26',NULL,'Contribution Qualifier Type',NULL,NULL,'"drvContributionType5"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ERSPRIN401_20231205.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202312059','EMPEXPORT','ONDEM_XOE',NULL,'ERSPRIN401',NULL,NULL,NULL,'202312059','Dec  5 2023  2:49PM','Dec  5 2023  2:49PM','202312051',NULL,'','','202312051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202312059','EMPEXPORT','SCH_ERSPRI',NULL,'ERSPRIN401',NULL,NULL,NULL,'202312059','Dec  5 2023  2:49PM','Dec  5 2023  2:49PM','202312051',NULL,'','','202312051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202312059','EMPEXPORT','TEST_XOE',NULL,'ERSPRIN401',NULL,NULL,NULL,'202312059','Dec  5 2023  2:49PM','Dec  5 2023  2:49PM','202312051',NULL,'','','202312051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERSPRIN401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERSPRIN401','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERSPRIN401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERSPRIN401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERSPRIN401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERSPRIN401','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERSPRIN401','D10','dbo.U_ERSPRIN401_drvTbl_180',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERSPRIN401','D20','dbo.U_ERSPRIN401_drvTbl_181',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERSPRIN401','D30','dbo.U_ERSPRIN401_drvTbl_220_D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERSPRIN401','D40','dbo.U_ERSPRIN401_drvTbl_220_I',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERSPRIN401','D50','dbo.U_ERSPRIN401_drvTbl_240',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERSPRIN401','D60','dbo.U_ERSPRIN401_drvTbl_407',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ERSPRIN401
-----------

IF OBJECT_ID('U_dsi_BDM_ERSPRIN401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ERSPRIN401] (
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
-- Create table U_ERSPRIN401_Audit
-----------

IF OBJECT_ID('U_ERSPRIN401_Audit') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_Audit] (
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
-- Create table U_ERSPRIN401_AuditFields
-----------

IF OBJECT_ID('U_ERSPRIN401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ERSPRIN401_DedList
-----------

IF OBJECT_ID('U_ERSPRIN401_DedList') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ERSPRIN401_drvTbl_180
-----------

IF OBJECT_ID('U_ERSPRIN401_drvTbl_180') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_drvTbl_180] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvEmployeeName] varchar(204) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvDateofEmployment] varchar(30) NULL,
    [drvSex] char(1) NULL,
    [drvLocationNumber] varchar(6) NOT NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvServiceDatePED] varchar(1) NOT NULL,
    [drvClassCode] varchar(1) NOT NULL,
    [drvKeyStatus] varchar(1) NOT NULL,
    [drvAlternateID] varchar(1) NOT NULL,
    [drvEligibilityHours] varchar(1) NOT NULL,
    [drvHoursBeginDate] varchar(1) NOT NULL,
    [drvHoursEndDate] varchar(1) NOT NULL,
    [drvBenefitEventDate] varchar(30) NULL,
    [drvVestingHours] nvarchar(4000) NULL,
    [drvBenefitEventReason] varchar(4) NULL,
    [drvPayrollFrequency] varchar(1) NOT NULL,
    [drvUnionStatus] varchar(1) NOT NULL
);

-----------
-- Create table U_ERSPRIN401_drvTbl_181
-----------

IF OBJECT_ID('U_ERSPRIN401_drvTbl_181') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_drvTbl_181] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvEmployeeName] varchar(204) NULL,
    [drvSSN] char(11) NULL,
    [drvRehireDate] varchar(30) NULL
);

-----------
-- Create table U_ERSPRIN401_drvTbl_220_D
-----------

IF OBJECT_ID('U_ERSPRIN401_drvTbl_220_D') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_drvTbl_220_D] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvForeignIndicator] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip5] varchar(5) NULL,
    [drvZip4] varchar(1) NOT NULL
);

-----------
-- Create table U_ERSPRIN401_drvTbl_220_I
-----------

IF OBJECT_ID('U_ERSPRIN401_drvTbl_220_I') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_drvTbl_220_I] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvForeignIndicator] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvCountryCode] varchar(2) NULL
);

-----------
-- Create table U_ERSPRIN401_drvTbl_240
-----------

IF OBJECT_ID('U_ERSPRIN401_drvTbl_240') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_drvTbl_240] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvIdentificationNumber] char(11) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvPersonalEmail] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkphoneext] varchar(1) NOT NULL,
    [drvHomephone] varchar(50) NULL,
    [drvHomephoneext] varchar(1) NOT NULL,
    [drvMobile] varchar(50) NULL
);

-----------
-- Create table U_ERSPRIN401_drvTbl_407
-----------

IF OBJECT_ID('U_ERSPRIN401_drvTbl_407') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_drvTbl_407] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvContractNumber] varchar(6) NOT NULL,
    [drvIdentificationNumber] char(11) NULL,
    [drvInvestmentType] varchar(2) NOT NULL,
    [drvTransactionType] varchar(3) NOT NULL,
    [drvPayDate] datetime NULL,
    [drvContributionType] varchar(1) NOT NULL,
    [drvElectiveDeferral] varchar(3) NOT NULL,
    [drvContributionAmount1] varchar(30) NULL,
    [drvContributionType1] varchar(1) NOT NULL,
    [drvContributionQualifier2] varchar(3) NOT NULL,
    [drvContributionAmount2] varchar(30) NULL,
    [drvContributionType2] varchar(1) NOT NULL,
    [drvContributionQualifier3] varchar(3) NOT NULL,
    [drvContributionAmount3] varchar(1) NOT NULL,
    [drvContributionType3] varchar(1) NOT NULL,
    [drvContributionQualifier4] varchar(3) NOT NULL,
    [drvContributionAmount4] varchar(1) NOT NULL,
    [drvContributionType4] varchar(1) NOT NULL,
    [drvContributionQualifier5] varchar(3) NOT NULL,
    [drvContributionAmount5] varchar(30) NULL,
    [drvContributionType5] varchar(1) NOT NULL
);

-----------
-- Create table U_ERSPRIN401_EEList
-----------

IF OBJECT_ID('U_ERSPRIN401_EEList') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ERSPRIN401_File
-----------

IF OBJECT_ID('U_ERSPRIN401_File') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ERSPRIN401_PDedHist
-----------

IF OBJECT_ID('U_ERSPRIN401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401] numeric NULL,
    [Pdh401C] numeric NULL,
    [Pdh401KM] numeric NULL
);

-----------
-- Create table U_ERSPRIN401_PEarHist
-----------

IF OBJECT_ID('U_ERSPRIN401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ERSPRIN401_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERSPRIN401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Roaring Spring Blank Book Company 

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 12/05/2023
Service Request Number: TekP-2023-06-28-02

Purpose: Principal 401K Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERSPRIN401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERSPRIN401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERSPRIN401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERSPRIN401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERSPRIN401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERSPRIN401', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERSPRIN401', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERSPRIN401', 'SCH_ERSPRI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERSPRIN401';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ERSPRIN401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERSPRIN401';

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
    DELETE FROM dbo.U_ERSPRIN401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERSPRIN401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


   --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ERSPRIN401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_AuditFields;
    CREATE TABLE dbo.U_ERSPRIN401_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ERSPRIN401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_Audit;
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
    INTO dbo.U_ERSPRIN401_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ERSPRIN401_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ERSPRIN401_Audit ON dbo.U_ERSPRIN401_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ERSPRIN401_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ERSPRIN401_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401P,401KS,401CF,401CP,401KM';

    IF OBJECT_ID('U_ERSPRIN401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ERSPRIN401_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ERSPRIN401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts  
        ,Pdh401     = SUM(CASE WHEN PdhDedCode IN ('401F', '401P','401KS') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401C     = SUM(CASE WHEN PdhDedCode IN ('401CF', '401CP') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401KM   = SUM(CASE WHEN PdhDedCode IN ('401KM') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ERSPRIN401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ERSPRIN401_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ERSPRIN401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
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
    INTO dbo.U_ERSPRIN401_PEarHist
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
    -- DETAIL RECORD - U_ERSPRIN401_drvTbl_180
    ---------------------------------
    IF OBJECT_ID('U_ERSPRIN401_drvTbl_180','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_drvTbl_180;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '180'
        ,drvContractNumber = '635164'
        ,drvEmployeeIDNumber = Eepssn
        ,drvEmployeeName =  EepNameLast + ', ' + EepNameFirst + ' ' + Left(EepNameMiddle,1) 
        ,drvDateofBirth = Convert(varchar,EepDateOfBirth, 101)
        ,drvDateofEmployment = Convert(varchar,EecDateOfOriginalHire, 101)
        ,drvSex = CASE WHEN Eepgender IN ('M', 'F') THEN Eepgender END 
        ,drvLocationNumber = '000001'
        ,drvSocialSecurityNumber = Eepssn
        ,drvServiceDatePED = ''
        ,drvClassCode = ''
        ,drvKeyStatus = ''
        ,drvAlternateID = ''
        ,drvEligibilityHours = ''
        ,drvHoursBeginDate = ''
        ,drvHoursEndDate = ''
        ,drvBenefitEventDate = Convert(varchar,EecDateOfTermination, 101)
        ,drvVestingHours = CASE WHEN EecEmplStatus = 'T' THEN format(PehCurHrsYTD,'0000') END
        ,drvBenefitEventReason = CASE WHEN EecEmplStatus = 'T' THEN '0001' END
        ,drvPayrollFrequency = ''
        ,drvUnionStatus = ''
    INTO dbo.U_ERSPRIN401_drvTbl_180
    FROM dbo.U_ERSPRIN401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ERSPRIN401_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ERSPRIN401_drvTbl_181
    ---------------------------------
    IF OBJECT_ID('U_ERSPRIN401_drvTbl_181','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_drvTbl_181;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '181'
        ,drvContractNumber = '635164'
        ,drvEmployeeIDNumber = EepSsn
        ,drvEmployeeName = EepNameLast + ', ' + EepNameFirst + ' ' + Left(EepNameMiddle,1)
        ,drvSSN = eepSSN
        ,drvRehireDate =  CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND EecJobChangeReason = '101' THEN Convert(varchar,EecDateOfLastHire , 101) END
    INTO dbo.U_ERSPRIN401_drvTbl_181
    FROM dbo.U_ERSPRIN401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ERSPRIN401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ERSPRIN401_drvTbl_220_D
    ---------------------------------
    IF OBJECT_ID('U_ERSPRIN401_drvTbl_220_D','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_drvTbl_220_D;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '220'
        ,drvContractNumber = '635164'
        ,drvEmployeeIDNumber = EepSSN
        ,drvForeignIndicator = '2' --CASE WHEN EepAddressCountry = 'USA' THEN '2' ELSE '1' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip5 = LEFT(EepAddressZipcode,5)
        ,drvZip4 = ''--CASE WHEN LEN(EepAddressZipcode) > 5 THEN RIGHT(EepAddressZipcode,4) END
    INTO dbo.U_ERSPRIN401_drvTbl_220_D
    FROM dbo.U_ERSPRIN401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ERSPRIN401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE EepAddressCountry = 'USA' 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ERSPRIN401_drvTbl_220_I
    ---------------------------------
    IF OBJECT_ID('U_ERSPRIN401_drvTbl_220_I','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_drvTbl_220_I;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '220'
        ,drvContractNumber = '635164'
        ,drvEmployeeIDNumber = EepSSN
        ,drvForeignIndicator = '1'
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = EepAddressCity
        ,drvCountryCode = LEFt(EepAddressCountry,2)
    INTO dbo.U_ERSPRIN401_drvTbl_220_I
    FROM dbo.U_ERSPRIN401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ERSPRIN401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        WHERE EepAddressCountry <> 'USA' 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ERSPRIN401_drvTbl_240
    ---------------------------------
    IF OBJECT_ID('U_ERSPRIN401_drvTbl_240','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_drvTbl_240;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '240'
        ,drvContractNumber = '635164'
        ,drvIdentificationNumber = EepSSN
        ,drvWorkEmail = EepAddressEMail
        ,drvPersonalEmail = ''--EepAddressEMail
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkphoneext =''-- EecPhoneBusinessNumber
        ,drvHomephone = EepPhoneHomeNumber
        ,drvHomephoneext = ''--EepPhoneHomeNumber
        ,drvMobile = efoPhoneNumber
    INTO dbo.U_ERSPRIN401_drvTbl_240
    FROM dbo.U_ERSPRIN401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ERSPRIN401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoeeid =Xeeid
        and efoPhoneType = 'CEL'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ERSPRIN401_drvTbl_407
    ---------------------------------
    IF OBJECT_ID('U_ERSPRIN401_drvTbl_407','U') IS NOT NULL
        DROP TABLE dbo.U_ERSPRIN401_drvTbl_407;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = '407'
        ,drvContractNumber = '635164'
        ,drvIdentificationNumber = EepSSN
        ,drvInvestmentType = '00'
        ,drvTransactionType = '001'
        ,drvPayDate = PrgPayDate
        ,drvContributionType = 'L'
        ,drvElectiveDeferral = '001'
        ,drvContributionAmount1 =  Cast(dbo.dsi_fnpadzero(Pdh401, 10,0)as varchar)
        ,drvContributionType1 = 'L'
        ,drvContributionQualifier2 = '017'
        ,drvContributionAmount2 =  Cast(dbo.dsi_fnpadzero(Pdh401C,10,0) as varchar)
        ,drvContributionType2 = 'L'
        ,drvContributionQualifier3 = '021'
        ,drvContributionAmount3 = ''
        ,drvContributionType3 = 'L'
        ,drvContributionQualifier4 = '041'
        ,drvContributionAmount4 = ''
        ,drvContributionType4 = 'L'
        ,drvContributionQualifier5 = '008'
        ,drvContributionAmount5 =  cast(dbo.dsi_fnpadzero(Pdh401KM,10,0)as varchar)
        ,drvContributionType5 = ''
    INTO dbo.U_ERSPRIN401_drvTbl_407
    FROM dbo.U_ERSPRIN401_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ERSPRIN401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ERSPRIN401_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    LEFT JOIN dbo.U_ERSPRIN401_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
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
/**********************************************************************************'*/
GO
CREATE VIEW dbo.dsi_vwERSPRIN401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERSPRIN401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ERSPRIN401' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ERSPRIN401'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ERSPRIN401'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ERSPRIN401', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ERSPRIN401', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ERSPRIN401', 'UseFileName', 'V', 'Y'


-- End ripout