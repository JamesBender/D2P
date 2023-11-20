/**********************************************************************************

ECISPRULIF: Prudential Term Conversion Portability

FormatCode:     ECISPRULIF
Project:        Prudential Term Conversion Portability
Client ID:      USG1000
Date/time:      2023-11-09 07:27:57.410
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ECISPRULIF_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECISPRULIF_SavePath') IS NOT NULL DROP TABLE dbo.U_ECISPRULIF_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECISPRULIF'


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
WHERE FormatCode = 'ECISPRULIF'
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
WHERE ExpFormatCode = 'ECISPRULIF'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECISPRULIF')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECISPRULIF'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECISPRULIF'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECISPRULIF'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECISPRULIF'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECISPRULIF'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECISPRULIF'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECISPRULIF'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECISPRULIF'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECISPRULIF'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECISPRULIF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECISPRULIF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECISPRULIF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECISPRULIF];
GO
IF OBJECT_ID('U_ECISPRULIF_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_Trailer];
GO
IF OBJECT_ID('U_ECISPRULIF_Header') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_Header];
GO
IF OBJECT_ID('U_ECISPRULIF_File') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_File];
GO
IF OBJECT_ID('U_ECISPRULIF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_EEList];
GO
IF OBJECT_ID('U_ECISPRULIF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_drvTbl];
GO
IF OBJECT_ID('U_ECISPRULIF_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_DedList];
GO
IF OBJECT_ID('U_ECISPRULIF_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_AuditFields];
GO
IF OBJECT_ID('U_ECISPRULIF_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECISPRULIF_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECISPRULIF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECISPRULIF];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECISPRULIF','Prudential Term Conversion Portability','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECISPRULIFZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRULIFZ0','50','H','01','1',NULL,'Record Type Indicator Code',NULL,NULL,'"drvRecordTypeIndCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRULIFZ0','50','H','01','2',NULL,'Version Indicator',NULL,NULL,'"drvVersionIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRULIFZ0','50','H','01','3',NULL,'Create Date',NULL,NULL,'"drvCreateDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRULIFZ0','50','H','01','4',NULL,'Activity Begin Date',NULL,NULL,'"drvActivityBeginDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRULIFZ0','50','H','01','5',NULL,'Activity End Date',NULL,NULL,'"drvActivityEndDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRULIFZ0','50','H','01','6',NULL,'Client Number',NULL,NULL,'"drvClientNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRULIFZ0','50','H','01','7',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRULIFZ0','50','D','10','1',NULL,'Record Type Indicator Code',NULL,NULL,'"drvRecordTypeIndCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRULIFZ0','50','D','10','2',NULL,'Transaction Status Code',NULL,NULL,'"drvTransactionStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRULIFZ0','50','D','10','3',NULL,'Transaction Reason Code',NULL,NULL,'"drvTransactionReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRULIFZ0','50','D','10','4',NULL,'Transaction Effective Date',NULL,NULL,'"drvTransactionEffectiveDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRULIFZ0','50','D','10','5',NULL,'Client Specific Information',NULL,NULL,'"drvClientSpecificInformation"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRULIFZ0','50','D','10','6',NULL,'Employee Hire Date',NULL,NULL,'"drvEmployeeHireDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRULIFZ0','50','D','10','7',NULL,'Employee Annual Salary',NULL,NULL,'"drvEmployeeAnnualSalary"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRULIFZ0','50','D','10','8',NULL,'Assignment Indicator',NULL,NULL,'"drvAssignmentIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRULIFZ0','50','D','10','9',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRULIFZ0','50','D','10','10',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRULIFZ0','50','D','10','11',NULL,'Employee Name Prefix',NULL,NULL,'"drvEmployeeNamePrefix"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRULIFZ0','50','D','10','12',NULL,'Employee Name Suffix',NULL,NULL,'"drvEmployeeNameSuffix"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRULIFZ0','50','D','10','13',NULL,'Employee Last Name',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRULIFZ0','50','D','10','14',NULL,'Employee First Name',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRULIFZ0','50','D','10','15',NULL,'Employee Middle Initial',NULL,NULL,'"drvEmployeeMiddleInitial"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRULIFZ0','50','D','10','16',NULL,'Employee Mail Address 1',NULL,NULL,'"drvEmployeeMailAddress1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRULIFZ0','50','D','10','17',NULL,'Employee Mail Address 2',NULL,NULL,'"drvEmployeeMailAddress2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRULIFZ0','50','D','10','18',NULL,'Employee Mail City',NULL,NULL,'"drvEmployeeMailCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRULIFZ0','50','D','10','19',NULL,'Employee Mail State Code',NULL,NULL,'"drvEmployeeMailStateCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRULIFZ0','50','D','10','20',NULL,'Employee Zip Code',NULL,NULL,'"drvEmployeeZipCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRULIFZ0','50','D','10','21',NULL,'Employee Foreign Address',NULL,NULL,'"drvEmployeeForeignAddress"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRULIFZ0','50','D','10','22',NULL,'Mail Country Name',NULL,NULL,'"drvMailCountryName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRULIFZ0','50','D','10','23',NULL,'Employee Date of Birth',NULL,NULL,'"drvEmployeeDateofBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRULIFZ0','50','D','10','24',NULL,'Spouse Date of Birth',NULL,NULL,'"drvSpouseDateofBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRULIFZ0','50','D','10','25',NULL,'Employee Gender',NULL,NULL,'"drvEmployeeGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRULIFZ0','50','D','10','26',NULL,'Employee Basic Coverage (Life coverage that is emp',NULL,NULL,'"drvEmployeeBasicCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISPRULIFZ0','50','D','10','27',NULL,'Employee Optional Life Coverage (employee paid)',NULL,NULL,'"drvEmployeeOptionalLifeCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISPRULIFZ0','50','D','10','28',NULL,'Employee Basic AD&D Coverage (employer paid)',NULL,NULL,'"drvEmployeeBasicADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISPRULIFZ0','50','D','10','29',NULL,'Employee Optional AD&D Coverage (employee paid)',NULL,NULL,'"drvEmployeeOptionalADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISPRULIFZ0','50','D','10','30',NULL,'Spouse Basic Coverage (Life coverage that is emplo',NULL,NULL,'"drvSpouseBasicCoverage"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISPRULIFZ0','50','D','10','31',NULL,'Spouse Optional Life Coverage (employee paid)',NULL,NULL,'"drvSpouseOptionalLifeCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISPRULIFZ0','50','D','10','32',NULL,'Spouse Optional AD&D Coverage (employee paid)',NULL,NULL,'"drvSpouseOptionalADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISPRULIFZ0','50','D','10','33',NULL,'Child Basic Coverage (Life coverage that is employ',NULL,NULL,'"drvChildBasicCoverage"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISPRULIFZ0','50','D','10','34',NULL,'Child Optional Life Coverage (employee paid)',NULL,NULL,'"drvChildOptionalLifeCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISPRULIFZ0','50','D','10','35',NULL,'Child Optional AD&D Coverage (employee paid)',NULL,NULL,'"drvChildOptionalADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISPRULIFZ0','50','D','10','36',NULL,'Employee Smoker Code',NULL,NULL,'"drvEmployeeSmokerCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISPRULIFZ0','50','D','10','37',NULL,'Spouse Smoker Code',NULL,NULL,'"drvSpouseSmokerCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISPRULIFZ0','50','D','10','38',NULL,'Employee E-mail Address',NULL,NULL,'"drvEmployeeEmailAddress"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECISPRULIFZ0','50','D','10','39',NULL,'E-Mail Type',NULL,NULL,'"drvEMailType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECISPRULIFZ0','50','D','10','40',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECISPRULIFZ0','50','D','10','41',NULL,'Phone Number Type',NULL,NULL,'"drvPhoneNumberType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECISPRULIFZ0','50','D','10','42',NULL,'Phone Number II',NULL,NULL,'"drvPhoneNumberI2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECISPRULIFZ0','50','D','10','43',NULL,'Phone Number II Type',NULL,NULL,'"drvPhoneNumber2Type"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRULIFZ0','51','T','90','1',NULL,'Record Type Indicator Code',NULL,NULL,'"drvRecordTypeIndCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRULIFZ0','52','T','90','2',NULL,'Total Detail Records',NULL,NULL,'"drvTotalDetailRecords"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECISPRULIF_20231109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Term Conversion Por','202311099','EMPEXPORT','ONDEM_XOE',NULL,'ECISPRULIF',NULL,NULL,NULL,'202311099','Nov  9 2023  7:26AM','Nov  9 2023  7:26AM','202311091',NULL,'','','202311091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Term Conversi-Sched','202311099','EMPEXPORT','SCH_ECISPR',NULL,'ECISPRULIF',NULL,NULL,NULL,'202311099','Nov  9 2023  7:26AM','Nov  9 2023  7:26AM','202311091',NULL,'','','202311091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Term Conversi-Test','202311099','EMPEXPORT','TEST_XOE',NULL,'ECISPRULIF',NULL,NULL,NULL,'202311099','Nov  9 2023  7:26AM','Nov  9 2023  7:26AM','202311091',NULL,'','','202311091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRULIF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRULIF','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRULIF','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRULIF','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRULIF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRULIF','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRULIF','H01','dbo.U_ECISPRULIF_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRULIF','D10','dbo.U_ECISPRULIF_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRULIF','T90','dbo.U_ECISPRULIF_Trailer',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECISPRULIF
-----------

IF OBJECT_ID('U_dsi_BDM_ECISPRULIF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECISPRULIF] (
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
-- Create table U_ECISPRULIF_Audit
-----------

IF OBJECT_ID('U_ECISPRULIF_Audit') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_Audit] (
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
-- Create table U_ECISPRULIF_AuditFields
-----------

IF OBJECT_ID('U_ECISPRULIF_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECISPRULIF_DedList
-----------

IF OBJECT_ID('U_ECISPRULIF_DedList') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECISPRULIF_drvTbl
-----------

IF OBJECT_ID('U_ECISPRULIF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordTypeIndCode] varchar(1) NOT NULL,
    [drvTransactionStatusCode] varchar(1) NOT NULL,
    [drvTransactionReasonCode] varchar(1) NOT NULL,
    [drvTransactionEffectiveDate] varchar(1) NOT NULL,
    [drvClientSpecificInformation] varchar(1) NOT NULL,
    [drvEmployeeHireDate] datetime NULL,
    [drvEmployeeAnnualSalary] varchar(1) NOT NULL,
    [drvAssignmentIndicator] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvEmployeeNamePrefix] varchar(30) NULL,
    [drvEmployeeNameSuffix] varchar(30) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleInitial] varchar(1) NULL,
    [drvEmployeeMailAddress1] varchar(255) NULL,
    [drvEmployeeMailAddress2] varchar(255) NULL,
    [drvEmployeeMailCity] varchar(255) NULL,
    [drvEmployeeMailStateCode] varchar(255) NULL,
    [drvEmployeeZipCode] varchar(50) NULL,
    [drvEmployeeForeignAddress] varchar(1) NOT NULL,
    [drvMailCountryName] char(3) NULL,
    [drvEmployeeDateofBirth] datetime NULL,
    [drvSpouseDateofBirth] datetime NULL,
    [drvEmployeeGender] char(1) NULL,
    [drvEmployeeBasicCov] varchar(1) NOT NULL,
    [drvEmployeeOptionalLifeCov] varchar(1) NOT NULL,
    [drvEmployeeBasicADDCov] varchar(1) NOT NULL,
    [drvEmployeeOptionalADDCov] varchar(1) NOT NULL,
    [drvSpouseBasicCoverage] varchar(1) NOT NULL,
    [drvSpouseOptionalLifeCov] varchar(1) NOT NULL,
    [drvSpouseOptionalADDCov] varchar(1) NOT NULL,
    [drvChildBasicCoverage] varchar(1) NOT NULL,
    [drvChildOptionalLifeCov] varchar(1) NOT NULL,
    [drvChildOptionalADDCov] varchar(1) NOT NULL,
    [drvEmployeeSmokerCode] varchar(1) NOT NULL,
    [drvSpouseSmokerCode] varchar(1) NOT NULL,
    [drvEmployeeEmailAddress] varchar(50) NULL,
    [drvEMailType] varchar(50) NULL,
    [drvPhoneNumber] varchar(1) NOT NULL,
    [drvPhoneNumberType] varchar(1) NOT NULL,
    [drvPhoneNumberI2] varchar(1) NOT NULL,
    [drvPhoneNumber2Type] varchar(1) NOT NULL
);

-----------
-- Create table U_ECISPRULIF_EEList
-----------

IF OBJECT_ID('U_ECISPRULIF_EEList') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECISPRULIF_File
-----------

IF OBJECT_ID('U_ECISPRULIF_File') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECISPRULIF_Header
-----------

IF OBJECT_ID('U_ECISPRULIF_Header') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_Header] (
    [drvRecordTypeIndCode] varchar(1) NOT NULL,
    [drvVersionIndicator] varchar(1) NOT NULL,
    [drvCreateDate] varchar(1) NOT NULL,
    [drvActivityBeginDate] varchar(1) NOT NULL,
    [drvActivityEndDate] varchar(1) NOT NULL,
    [drvClientNumber] varchar(1) NOT NULL,
    [drvLocationCode] varchar(1) NOT NULL
);

-----------
-- Create table U_ECISPRULIF_Trailer
-----------

IF OBJECT_ID('U_ECISPRULIF_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECISPRULIF_Trailer] (
    [drvRecordTypeIndCode] varchar(1) NOT NULL,
    [drvTotalDetailRecords] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECISPRULIF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cision US, Inc.

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 11/09/2023
Service Request Number: TekP-2023-08-18-05

Purpose: Prudential Term Conversion Portability

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECISPRULIF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECISPRULIF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECISPRULIF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECISPRULIF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECISPRULIF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRULIF', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRULIF', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRULIF', 'SCH_ECISPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECISPRULIF';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECISPRULIF', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECISPRULIF';

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
    DELETE FROM dbo.U_ECISPRULIF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECISPRULIF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECISPRULIF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRULIF_AuditFields;
    CREATE TABLE dbo.U_ECISPRULIF_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECISPRULIF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRULIF_Audit;
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
    INTO dbo.U_ECISPRULIF_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECISPRULIF_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECISPRULIF_Audit ON dbo.U_ECISPRULIF_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_ECISPRULIF_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECISPRULIF_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ECISPRULIF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRULIF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECISPRULIF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRULIF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRULIF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRULIF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordTypeIndCode = ''
        ,drvTransactionStatusCode = ''
        ,drvTransactionReasonCode = ''
        ,drvTransactionEffectiveDate = ''
        ,drvClientSpecificInformation = ''
        ,drvEmployeeHireDate = EecDateOfLastHire
        ,drvEmployeeAnnualSalary = ''
        ,drvAssignmentIndicator = ''
        ,drvEmployeeSSN = eepSSN
        ,drvSpouseSSN = eepSSN
        ,drvEmployeeNamePrefix = NULLIF(EepNamePrefix,'Z')
        ,drvEmployeeNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvEmployeeMailAddress1 = EepAddressLine1
        ,drvEmployeeMailAddress2 = EepAddressLine2
        ,drvEmployeeMailCity = EepAddressCity
        ,drvEmployeeMailStateCode = EepAddressState
        ,drvEmployeeZipCode = EepAddressZipCode
        ,drvEmployeeForeignAddress = ''
        ,drvMailCountryName = EepAddressCountry
        ,drvEmployeeDateofBirth = EepDateOfBirth
        ,drvSpouseDateofBirth = EepDateOfBirth
        ,drvEmployeeGender = EepGender
        ,drvEmployeeBasicCov = ''
        ,drvEmployeeOptionalLifeCov = ''
        ,drvEmployeeBasicADDCov = ''
        ,drvEmployeeOptionalADDCov = ''
        ,drvSpouseBasicCoverage = ''
        ,drvSpouseOptionalLifeCov = ''
        ,drvSpouseOptionalADDCov = ''
        ,drvChildBasicCoverage = ''
        ,drvChildOptionalLifeCov = ''
        ,drvChildOptionalADDCov = ''
        ,drvEmployeeSmokerCode = ''
        ,drvSpouseSmokerCode = ''
        ,drvEmployeeEmailAddress = EepAddressEMail
        ,drvEMailType = EepAddressEMail
        ,drvPhoneNumber = ''
        ,drvPhoneNumberType = ''
        ,drvPhoneNumberI2 = ''
        ,drvPhoneNumber2Type = ''
    INTO dbo.U_ECISPRULIF_drvTbl
    FROM dbo.U_ECISPRULIF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECISPRULIF WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECISPRULIF_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRULIF_Header;
    SELECT DISTINCT
         drvRecordTypeIndCode = ''
        ,drvVersionIndicator = ''
        ,drvCreateDate = ''
        ,drvActivityBeginDate = ''
        ,drvActivityEndDate = ''
        ,drvClientNumber = ''
        ,drvLocationCode = ''
    INTO dbo.U_ECISPRULIF_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECISPRULIF_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRULIF_Trailer;
    SELECT DISTINCT
         drvRecordTypeIndCode = ''
        ,drvTotalDetailRecords = ''
    INTO dbo.U_ECISPRULIF_Trailer
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
ALTER VIEW dbo.dsi_vwECISPRULIF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECISPRULIF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECISPRULIF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311021'
       ,expStartPerControl     = '202311021'
       ,expLastEndPerControl   = '202311099'
       ,expEndPerControl       = '202311099'
WHERE expFormatCode = 'ECISPRULIF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECISPRULIF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECISPRULIF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECISPRULIF' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECISPRULIF'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECISPRULIF'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECISPRULIF', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECISPRULIF', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECISPRULIF', 'UseFileName', 'V', 'Y'


-- End ripout