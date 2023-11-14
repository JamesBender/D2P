/**********************************************************************************

ECISLIFEPR: Prudential Term Conversion Portability

FormatCode:     ECISLIFEPR
Project:        Prudential Term Conversion Portability
Client ID:      CIS1000
Date/time:      2023-11-09 14:26:04.387
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPCISIN
Web Filename:   CIS1000_35B05_EEHISTORY_ECISLIFEPR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECISLIFEPR_SavePath') IS NOT NULL DROP TABLE dbo.U_ECISLIFEPR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECISLIFEPR'


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
WHERE FormatCode = 'ECISLIFEPR'
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
WHERE ExpFormatCode = 'ECISLIFEPR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECISLIFEPR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECISLIFEPR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECISLIFEPR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECISLIFEPR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECISLIFEPR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECISLIFEPR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECISLIFEPR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECISLIFEPR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECISLIFEPR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECISLIFEPR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECISLIFEPR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECISLIFEPR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECISLIFEPR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECISLIFEPR];
GO
IF OBJECT_ID('U_ECISLIFEPR_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_Trailer];
GO
IF OBJECT_ID('U_ECISLIFEPR_Header') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_Header];
GO
IF OBJECT_ID('U_ECISLIFEPR_File') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_File];
GO
IF OBJECT_ID('U_ECISLIFEPR_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_EEList];
GO
IF OBJECT_ID('U_ECISLIFEPR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_drvTbl];
GO
IF OBJECT_ID('U_ECISLIFEPR_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_DedList];
GO
IF OBJECT_ID('U_ECISLIFEPR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_AuditFields];
GO
IF OBJECT_ID('U_ECISLIFEPR_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECISLIFEPR_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECISLIFEPR') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECISLIFEPR];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECISLIFEPR','Prudential Term Conversion Portability','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECISLIFEPRZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISLIFEPRZ0','50','H','01','1',NULL,'Record Type Indicator Code',NULL,NULL,'"drvRecordTypeIndCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISLIFEPRZ0','50','H','01','2',NULL,'Version Indicator',NULL,NULL,'"drvVersionIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISLIFEPRZ0','50','H','01','3',NULL,'Create Date',NULL,NULL,'"drvCreateDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISLIFEPRZ0','50','H','01','4',NULL,'Activity Begin Date',NULL,NULL,'"drvActivityBeginDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISLIFEPRZ0','50','H','01','5',NULL,'Activity End Date',NULL,NULL,'"drvActivityEndDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISLIFEPRZ0','50','H','01','6',NULL,'Client Number',NULL,NULL,'"drvClientNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISLIFEPRZ0','50','H','01','7',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISLIFEPRZ0','50','D','10','1',NULL,'Record Type Indicator Code',NULL,NULL,'"drvRecordTypeIndCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISLIFEPRZ0','50','D','10','2',NULL,'Transaction Status Code',NULL,NULL,'"drvTransactionStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISLIFEPRZ0','50','D','10','3',NULL,'Transaction Reason Code',NULL,NULL,'"drvTransactionReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISLIFEPRZ0','50','D','10','4',NULL,'Transaction Effective Date',NULL,NULL,'"drvTransactionEffectiveDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISLIFEPRZ0','50','D','10','5',NULL,'Client Specific Information',NULL,NULL,'"drvClientSpecificInformation"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISLIFEPRZ0','50','D','10','6',NULL,'Employee Hire Date',NULL,NULL,'"drvEmployeeHireDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISLIFEPRZ0','50','D','10','7',NULL,'Employee Annual Salary',NULL,NULL,'"drvEmployeeAnnualSalary"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISLIFEPRZ0','50','D','10','8',NULL,'Assignment Indicator',NULL,NULL,'"drvAssignmentIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISLIFEPRZ0','50','D','10','9',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISLIFEPRZ0','50','D','10','10',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISLIFEPRZ0','50','D','10','11',NULL,'Employee Name Prefix',NULL,NULL,'"drvEmployeeNamePrefix"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISLIFEPRZ0','50','D','10','12',NULL,'Employee Name Suffix',NULL,NULL,'"drvEmployeeNameSuffix"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISLIFEPRZ0','50','D','10','13',NULL,'Employee Last Name',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISLIFEPRZ0','50','D','10','14',NULL,'Employee First Name',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISLIFEPRZ0','50','D','10','15',NULL,'Employee Middle Initial',NULL,NULL,'"drvEmployeeMiddleInitial"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISLIFEPRZ0','50','D','10','16',NULL,'Employee Mail Address 1',NULL,NULL,'"drvEmployeeMailAddress1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISLIFEPRZ0','50','D','10','17',NULL,'Employee Mail Address 2',NULL,NULL,'"drvEmployeeMailAddress2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISLIFEPRZ0','50','D','10','18',NULL,'Employee Mail City',NULL,NULL,'"drvEmployeeMailCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISLIFEPRZ0','50','D','10','19',NULL,'Employee Mail State Code',NULL,NULL,'"drvEmployeeMailStateCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISLIFEPRZ0','50','D','10','20',NULL,'Employee Zip Code',NULL,NULL,'"drvEmployeeZipCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISLIFEPRZ0','50','D','10','21',NULL,'Employee Foreign Address',NULL,NULL,'"drvEmployeeForeignAddress"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISLIFEPRZ0','50','D','10','22',NULL,'Mail Country Name',NULL,NULL,'"drvMailCountryName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISLIFEPRZ0','50','D','10','23',NULL,'Employee Date of Birth',NULL,NULL,'"drvEmployeeDateofBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISLIFEPRZ0','50','D','10','24',NULL,'Spouse Date of Birth',NULL,NULL,'"drvSpouseDateofBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISLIFEPRZ0','50','D','10','25',NULL,'Employee Gender',NULL,NULL,'"drvEmployeeGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISLIFEPRZ0','50','D','10','26',NULL,'Employee Basic Coverage (Life coverage that is emp',NULL,NULL,'"drvEmployeeBasicCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISLIFEPRZ0','50','D','10','27',NULL,'Employee Optional Life Coverage (employee paid)',NULL,NULL,'"drvEmployeeOptionalLifeCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISLIFEPRZ0','50','D','10','28',NULL,'Employee Basic AD&D Coverage (employer paid)',NULL,NULL,'"drvEmployeeBasicADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISLIFEPRZ0','50','D','10','29',NULL,'Employee Optional AD&D Coverage (employee paid)',NULL,NULL,'"drvEmployeeOptionalADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISLIFEPRZ0','50','D','10','30',NULL,'Spouse Basic Coverage (Life coverage that is emplo',NULL,NULL,'"drvSpouseBasicCoverage"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISLIFEPRZ0','50','D','10','31',NULL,'Spouse Optional Life Coverage (employee paid)',NULL,NULL,'"drvSpouseOptionalLifeCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISLIFEPRZ0','50','D','10','32',NULL,'Spouse Optional AD&D Coverage (employee paid)',NULL,NULL,'"drvSpouseOptionalADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISLIFEPRZ0','50','D','10','33',NULL,'Child Basic Coverage (Life coverage that is employ',NULL,NULL,'"drvChildBasicCoverage"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISLIFEPRZ0','50','D','10','34',NULL,'Child Optional Life Coverage (employee paid)',NULL,NULL,'"drvChildOptionalLifeCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISLIFEPRZ0','50','D','10','35',NULL,'Child Optional AD&D Coverage (employee paid)',NULL,NULL,'"drvChildOptionalADDCov"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISLIFEPRZ0','50','D','10','36',NULL,'Employee Smoker Code',NULL,NULL,'"drvEmployeeSmokerCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISLIFEPRZ0','50','D','10','37',NULL,'Spouse Smoker Code',NULL,NULL,'"drvSpouseSmokerCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISLIFEPRZ0','50','D','10','38',NULL,'Employee E-mail Address',NULL,NULL,'"drvEmployeeEmailAddress"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECISLIFEPRZ0','50','D','10','39',NULL,'E-Mail Type',NULL,NULL,'"drvEMailType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECISLIFEPRZ0','50','D','10','40',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECISLIFEPRZ0','50','D','10','41',NULL,'Phone Number Type',NULL,NULL,'"drvPhoneNumberType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECISLIFEPRZ0','50','D','10','42',NULL,'Phone Number II',NULL,NULL,'"drvPhoneNumberI2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECISLIFEPRZ0','50','D','10','43',NULL,'Phone Number II Type',NULL,NULL,'"drvPhoneNumber2Type"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISLIFEPRZ0','51','T','90','1',NULL,'Record Type Indicator Code',NULL,NULL,'"drvRecordTypeIndCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISLIFEPRZ0','52','T','90','2',NULL,'Total Detail Records',NULL,NULL,'"drvTotalDetailRecords"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECISLIFEPR_20231109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Term Conversion Por','202311099','EMPEXPORT','ONDEM_XOE',NULL,'ECISLIFEPR',NULL,NULL,NULL,'202311099','Nov  9 2023  7:39AM','Nov  9 2023  7:39AM','202307021',NULL,'','','202307021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Term Conversi-Sched','202311099','EMPEXPORT','SCH_ECISLI',NULL,'ECISLIFEPR',NULL,NULL,NULL,'202311099','Nov  9 2023  7:39AM','Nov  9 2023  7:39AM','202307021',NULL,'','','202307021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Prudential Term Conversi-Test','202311099','EMPEXPORT','TEST_XOE',NULL,'ECISLIFEPR',NULL,NULL,NULL,'202311099','Nov  9 2023  7:39AM','Nov  9 2023  7:39AM','202307021',NULL,'','','202307021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISLIFEPR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISLIFEPR','H01','dbo.U_ECISLIFEPR_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISLIFEPR','D10','dbo.U_ECISLIFEPR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISLIFEPR','T90','dbo.U_ECISLIFEPR_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECISLIFEPR
-----------

IF OBJECT_ID('U_dsi_BDM_ECISLIFEPR') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECISLIFEPR] (
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
-- Create table U_ECISLIFEPR_Audit
-----------

IF OBJECT_ID('U_ECISLIFEPR_Audit') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_Audit] (
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
-- Create table U_ECISLIFEPR_AuditFields
-----------

IF OBJECT_ID('U_ECISLIFEPR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECISLIFEPR_DedList
-----------

IF OBJECT_ID('U_ECISLIFEPR_DedList') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECISLIFEPR_drvTbl
-----------

IF OBJECT_ID('U_ECISLIFEPR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordTypeIndCode] varchar(1) NOT NULL,
    [drvTransactionStatusCode] varchar(1) NOT NULL,
    [drvTransactionReasonCode] varchar(3) NULL,
    [drvTransactionEffectiveDate] varchar(10) NULL,
    [drvClientSpecificInformation] varchar(1) NOT NULL,
    [drvEmployeeHireDate] varchar(10) NULL,
    [drvEmployeeAnnualSalary] varchar(24) NULL,
    [drvAssignmentIndicator] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvEmployeeNamePrefix] varchar(1) NOT NULL,
    [drvEmployeeNameSuffix] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleInitial] varchar(1) NOT NULL,
    [drvEmployeeMailAddress1] varchar(6000) NULL,
    [drvEmployeeMailAddress2] varchar(6000) NULL,
    [drvEmployeeMailCity] varchar(6000) NULL,
    [drvEmployeeMailStateCode] varchar(2) NULL,
    [drvEmployeeZipCode] varchar(10) NULL,
    [drvEmployeeForeignAddress] varchar(1) NULL,
    [drvMailCountryName] char(3) NULL,
    [drvEmployeeDateofBirth] varchar(10) NULL,
    [drvSpouseDateofBirth] varchar(10) NULL,
    [drvEmployeeGender] varchar(6) NOT NULL,
    [drvEmployeeBasicCov] varchar(24) NOT NULL,
    [drvEmployeeOptionalLifeCov] varchar(24) NOT NULL,
    [drvEmployeeBasicADDCov] varchar(8) NOT NULL,
    [drvEmployeeOptionalADDCov] varchar(24) NOT NULL,
    [drvSpouseBasicCoverage] varchar(8) NOT NULL,
    [drvSpouseOptionalLifeCov] varchar(24) NOT NULL,
    [drvSpouseOptionalADDCov] varchar(24) NOT NULL,
    [drvChildBasicCoverage] varchar(8) NOT NULL,
    [drvChildOptionalLifeCov] varchar(24) NOT NULL,
    [drvChildOptionalADDCov] varchar(24) NOT NULL,
    [drvEmployeeSmokerCode] varchar(1) NOT NULL,
    [drvSpouseSmokerCode] varchar(1) NOT NULL,
    [drvEmployeeEmailAddress] varchar(50) NULL,
    [drvEMailType] varchar(1) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvPhoneNumberType] varchar(1) NULL,
    [drvPhoneNumberI2] varchar(50) NULL,
    [drvPhoneNumber2Type] varchar(1) NULL,
    [eecdateoftermination] datetime NULL
);

-----------
-- Create table U_ECISLIFEPR_EEList
-----------

IF OBJECT_ID('U_ECISLIFEPR_EEList') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECISLIFEPR_File
-----------

IF OBJECT_ID('U_ECISLIFEPR_File') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECISLIFEPR_Header
-----------

IF OBJECT_ID('U_ECISLIFEPR_Header') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_Header] (
    [drvRecordTypeIndCode] varchar(1) NOT NULL,
    [drvVersionIndicator] varchar(2) NOT NULL,
    [drvCreateDate] varchar(10) NULL,
    [drvActivityBeginDate] varchar(10) NULL,
    [drvActivityEndDate] varchar(10) NULL,
    [drvClientNumber] varchar(7) NOT NULL,
    [drvLocationCode] varchar(10) NOT NULL
);

-----------
-- Create table U_ECISLIFEPR_Trailer
-----------

IF OBJECT_ID('U_ECISLIFEPR_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECISLIFEPR_Trailer] (
    [drvRecordTypeIndCode] varchar(1) NOT NULL,
    [drvTotalDetailRecords] varchar(24) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECISLIFEPR]
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

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECISLIFEPR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECISLIFEPR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECISLIFEPR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECISLIFEPR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECISLIFEPR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISLIFEPR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISLIFEPR', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISLIFEPR', 'SCH_ECISLI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECISLIFEPR';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECISLIFEPR', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECISLIFEPR';

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
    DELETE FROM dbo.U_ECISLIFEPR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECISLIFEPR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECISLIFEPR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECISLIFEPR_AuditFields;
    CREATE TABLE dbo.U_ECISLIFEPR_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ECISLIFEPR_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECISLIFEPR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECISLIFEPR_Audit;
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
    INTO dbo.U_ECISLIFEPR_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECISLIFEPR_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName        
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    and ISNULL(audNewValue, '') = 'T';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECISLIFEPR_Audit ON dbo.U_ECISLIFEPR_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECISLIFEPR_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECISLIFEPR_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLIFE,LIFEC,LIFEE,LIFES,LIFSP,LIFCP,LIFEP,GLIFE';

    IF OBJECT_ID('U_ECISLIFEPR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECISLIFEPR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECISLIFEPR_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHD, CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '30')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DatedStopDateDays', '30')

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECISLIFEPR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISLIFEPR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISLIFEPR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordTypeIndCode = '2'
        ,drvTransactionStatusCode = 'T'
        ,drvTransactionReasonCode = CASE WHEN  EecEmplStatus = 'T' AND Bdmchangereason  = '200' then '001'
                                         WHEN  EecEmplStatus = 'T' AND Bdmchangereason  = '204' then '005'
                                         WHEN  EecEmplStatus = 'T' AND Bdmchangereason  = '210' then '006'
                                         WHEN  EecEmplStatus = 'T' AND Bdmchangereason  = '201' then '008'
                                        END
        ,drvTransactionEffectiveDate = CONVERT(VARCHAR(10),BdmBenStopDate, 112)
        ,drvClientSpecificInformation = ''
        ,drvEmployeeHireDate = CONVERT(VARCHAR(10),EecDateOfLastHire, 112)
        ,drvEmployeeAnnualSalary = dbo.dsi_fnpadzero(Replace(EecAnnSalary, '.', ''), 9, 0)
        ,drvAssignmentIndicator = 'N'
        ,drvEmployeeSSN = eepSSN
        ,drvSpouseSSN = ConSSN
        ,drvEmployeeNamePrefix =''-- NULLIF(EepNamePrefix,'Z')
        ,drvEmployeeNameSuffix = ''--NULLIF(EepNameSuffix,'Z')
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleInitial = ''--LEFT(EepNameMiddle,1)
        ,drvEmployeeMailAddress1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvEmployeeMailAddress2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvEmployeeMailCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvEmployeeMailStateCode = Left(EepAddressState, 2)
        ,drvEmployeeZipCode = CASE WHEN  LEN(EepAddressZipCode) > 5 and RIGHT(EepAddressZipCode, 4) <> 0000 THEN LEFT(EepAddressZipCode, 5) + '-' + RIGHT(EepAddressZipCode, 4) ELSE LEFT(EepAddressZipCode, 5) END
        ,drvEmployeeForeignAddress = CASE WHEN  ISNULL(EepAddressCountry,'')  NOT IN  ('',  'USA') THEN  'Y' END
        ,drvMailCountryName = CASE WHEN  ISNULL(EepAddressCountry,'')  NOT IN  ('',  'USA') THEN EepAddressCountry END
        ,drvEmployeeDateofBirth = CONVERT(VARCHAR(10),EepDateOfBirth, 112)
        ,drvSpouseDateofBirth = CASE WHEN ConRelationship IN  ('SPS','DP') and SPDedcode is not null THEN CONVERT(VARCHAR(10),ConDateOfBirth,112) END
        ,drvEmployeeGender = CASE WHEN  EepGender = 'M' THEN 'MALE' else 'FEMALE' END 
        ,drvEmployeeBasicCov = ISNULL(CASE WHEN BDMBLIFE = 'BLIFE' AND Bdmchangereason In ( '204','210','201') THEN '00000000' 
                                    WHEN BDMBLIFE = 'BLIFE' AND Bdmchangereason  NOT In ( '204','210','201') THEN dbo.dsi_fnPadZero(REPLACE(BDMBLIFEAmt  , '.',''), 8,0)                                     
                                END, '00000000' )
        ,drvEmployeeOptionalLifeCov = ISNULL( CASE WHEN BDMLIFEE in ('LIFEE', 'LIFEP') AND Bdmchangereason  In ( '204','210','201')  THEN '00000000' 
                                           WHEN BDMLIFEE in ('LIFEE', 'LIFEP') AND Bdmchangereason  NOT In ( '204','210','201') THEN dbo.dsi_fnPadZero(REPLACE(BDMLIFEEamt , '.',''), 8,0)  
                                           END, '00000000' )
        ,drvEmployeeBasicADDCov = '00000000'
        ,drvEmployeeOptionalADDCov = ISNULL(CASE WHEN BDMGLIFE in ('GLIFE') AND Bdmchangereason  In ( '204','210','201')  THEN '00000000' 
                                          WHEN BDMGLIFE in('GLIFE') AND Bdmchangereason  NOT In ( '204','210','201') THEN dbo.dsi_fnPadZero(REPLACE(BDMGLIFEAmt , '.',''), 8,0)
                                          END, '00000000' )
        ,drvSpouseBasicCoverage = '00000000'
        ,drvSpouseOptionalLifeCov = ISNULL(CASE WHEN BDMLIFES in('LIFES', 'LIFSP') THEN dbo.dsi_fnPadZero(REPLACE(BDMLIFECAmt, '.',''), 8,0) END, '00000000' )
        ,drvSpouseOptionalADDCov = ISNULL(CASE WHEN BDMADDSP in('ADDSP') THEN dbo.dsi_fnPadZero(REPLACE(BDMADDSPAmt, '.',''), 8,0) END, '00000000' )
                                    
        ,drvChildBasicCoverage = '00000000'
        ,drvChildOptionalLifeCov = ISNULL(CASE WHEN BDMLIFEC in('LIFEC', 'LIFCP') THEN  dbo.dsi_fnPadZero(REPLACE(BDMLIFECAmt, '.',''), 8,0) END, '00000000' )
                                     
        ,drvChildOptionalADDCov = ISNULL(CASE WHEN BDMADDCH in('ADDCP') THEN  dbo.dsi_fnPadZero(REPLACE(BDMADDCHAmt, '.',''), 8,0) END, '00000000' ) 
                                    
        ,drvEmployeeSmokerCode = ''
        ,drvSpouseSmokerCode = ''
        ,drvEmployeeEmailAddress = EepAddressEmailAlternate
        ,drvEMailType = CASE WHEN ISNULL(EepAddressEmailAlternate, '') <> '' THEN '2' END
        ,drvPhoneNumber = CASE WHEN ISNULL(EfoPhoneNumber, '') <> ''   THEN EfoPhoneNumber  END
        ,drvPhoneNumberType = CASE WHEN ISNULL(EfoPhoneNumber, '') <> '' THEN '1' END
        ,drvPhoneNumberI2 = CASE WHEN  ISNULL(eepPhoneHomeNumber, '') <> ISNULL(EfoPhoneNumber, '') THEN eepPhoneHomeNumber END
        ,drvPhoneNumber2Type = CASE WHEN  ISNULL(eepPhoneHomeNumber, '') <> ISNULL(EfoPhoneNumber, '') THEN '3' END
        ,eecdateoftermination
    INTO dbo.U_ECISLIFEPR_drvTbl
    FROM dbo.U_ECISLIFEPR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN(Select  Bdm.BDMEEID, BDMCOID, MAX(BdmDateofBirth) AS BdmDateofBirth , MAX(BDMBenStartDate) As BdmBenStartDate, MAX(BdmBenstopdate) BdmBenstopdate
                    ,MAX(Bdmchangereason) as Bdmchangereason
                    ,MAX(CASE WHEN Bdmdedcode = 'BLIFE' THEN Bdmdedcode END ) AS BDMBLIFE
                    ,MAX(CASE WHEN Bdmdedcode = 'BLIFE' THEN BcaBenAmtCalc END ) AS BDMBLIFEAmt
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEE', 'LIFEP') THEN Bdmdedcode END ) AS BDMLIFEE
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEE', 'LIFEP') THEN BcaBenAmtCalc END ) AS BDMLIFEEAmt
                    ,MAX(CASE WHEN Bdmdedcode IN ( 'LIFES','LIFSP', 'ADDSP') THEN BdmDedCode END ) AS SPDedcode
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFES', 'LIFSP') THEN Bdmdedcode END ) AS BDMLIFES
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFES', 'LIFSP') THEN BcaBenAmtCalc END ) AS BDMLIFESAmt
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEC', 'LIFCP') THEN Bdmdedcode END ) AS BDMLIFEC
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEC', 'LIFCP') THEN BcaBenAmtCalc END ) AS BDMLIFECAmt
                    ,MAX(CASE WHEN Bdmdedcode IN ('GLIFE') THEN Bdmdedcode END ) AS BDMGLIFE
                    ,MAX(CASE WHEN Bdmdedcode IN ('GLIFE') THEN BdmBenstartDate END ) AS BDMGLIFEStartDate
                    ,MAX(CASE WHEN Bdmdedcode IN ('GLIFE') THEN BcaBenAmtCalc  END ) AS BDMGLIFEAmt
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFES') THEN Bdmdedcode END ) AS BDMADDSP
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFES') THEN BdmBenstartDate END ) AS BDMADDSPStartDate
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFES') THEN BcaBenAmtCalc END ) AS BDMADDSPAmt
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEC') THEN Bdmdedcode END ) AS BDMADDCH
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEC') THEN BdmBenstartDate END ) AS BDMADDCHStartDate
                    ,MAX(CASE WHEN Bdmdedcode IN ('LIFEC') THEN BcaBenAmtCalc END ) AS BDMADDCHAmt
                FROM dbo.U_dsi_BDM_ECISLIFEPR bdm
                JOIN dbo.u_dsi_bdm_BenCalculationAmounts bca
                 ON bdmeeid = bcaeeid 
                  AND bdmcoid = bcacoid
                  AND bdmdedcode = bcadedcode
                  AND bcaFormatCode = 'ECISLIFEPR'
                Where BdmBenstatus NOT IN ('W', 'C')
                Group by   Bdm.BDMEEID, BDMCOID
            ) Bdmcomb
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON Coneeid = Xeeid
        --and ConSystemID = BdmDepRecID
        and ConRelationship IN  ('SPS','DP')
         LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoeeid =Xeeid
        and efoPhoneType = 'CEL'
    LEFT JOIN dbo.U_ECISLIFEPR_Audit WITH (NOLOCK)
          ON  audeeid = Xeeid
    Where EecEmplStatus = 'T' and (audNewValue = 'T' and audDateTime Between @Startdate and @EndDate )
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECISLIFEPR_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECISLIFEPR_Header;
    SELECT DISTINCT
         drvRecordTypeIndCode = '1'
        ,drvVersionIndicator = 'V2'
        ,drvCreateDate = CONVERT(VARCHAR(10), GETDATE(), 112)
        ,drvActivityBeginDate = CONVERT(VARCHAR(10), GETDATE() -6, 112)
        ,drvActivityEndDate = CONVERT(VARCHAR(10), GETDATE(), 112)
        ,drvClientNumber = '0071802'
        ,drvLocationCode = 'cisionusin'
    INTO dbo.U_ECISLIFEPR_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECISLIFEPR_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECISLIFEPR_Trailer;
    SELECT DISTINCT
         drvRecordTypeIndCode = '3'
        ,drvTotalDetailRecords = dbo.dsi_fnPadZero((Select Count(*) from dbo.U_ECISLIFEPR_drvTbl), 7, 0)
    INTO dbo.U_ECISLIFEPR_Trailer

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN   dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECISLIFEPR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECISLIFEPR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECISLIFEPR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307021'
       ,expStartPerControl     = '202307021'
       ,expLastEndPerControl   = '202311099'
       ,expEndPerControl       = '202311099'
WHERE expFormatCode = 'ECISLIFEPR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECISLIFEPR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECISLIFEPR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECISLIFEPR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECISLIFEPR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECISLIFEPR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECISLIFEPR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECISLIFEPR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECISLIFEPR', 'UseFileName', 'V', 'Y'


-- End ripout