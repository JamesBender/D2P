/**********************************************************************************

ESTRATDEMO: Stratus Demographic

FormatCode:     ESTRATDEMO
Project:        Stratus Demographic
Client ID:      ROL1002
Date/time:      2023-06-15 11:43:45.540
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
Web Filename:   ROL1002_C9MXB_EEHISTORY_ESTRATDEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESTRATDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_ESTRATDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESTRATDEMO'


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
WHERE FormatCode = 'ESTRATDEMO'
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
WHERE ExpFormatCode = 'ESTRATDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESTRATDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESTRATDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESTRATDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESTRATDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESTRATDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESTRATDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESTRATDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESTRATDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESTRATDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESTRATDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESTRATDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTRATDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTRATDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTRATDEMO];
GO
IF OBJECT_ID('U_ESTRATDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_ESTRATDEMO_File];
GO
IF OBJECT_ID('U_ESTRATDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTRATDEMO_EEList];
GO
IF OBJECT_ID('U_ESTRATDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTRATDEMO_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTRATDEMO','Stratus Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','ESTRATDEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTRATDEMOZ0','50','H','01','1',NULL,'EmployeeId',NULL,NULL,'"EmployeeId"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTRATDEMOZ0','50','H','01','2',NULL,'Prefix',NULL,NULL,'"Prefix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTRATDEMOZ0','50','H','01','3',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTRATDEMOZ0','50','H','01','4',NULL,'MiddleName',NULL,NULL,'"MiddleName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTRATDEMOZ0','50','H','01','5',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTRATDEMOZ0','50','H','01','6',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTRATDEMOZ0','50','H','01','7',NULL,'UserName',NULL,NULL,'"UserName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTRATDEMOZ0','50','H','01','8',NULL,'Password',NULL,NULL,'"Password"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTRATDEMOZ0','50','H','01','9',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTRATDEMOZ0','50','H','01','10',NULL,'WorkPhoneNumber',NULL,NULL,'"WorkPhoneNumber"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTRATDEMOZ0','50','H','01','11',NULL,'AddressLine1',NULL,NULL,'"AddressLine1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTRATDEMOZ0','50','H','01','12',NULL,'AddressLine2',NULL,NULL,'"AddressLine2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTRATDEMOZ0','50','H','01','13',NULL,'PostalCode',NULL,NULL,'"PostalCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTRATDEMOZ0','50','H','01','14',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTRATDEMOZ0','50','H','01','15',NULL,'StateOrProvince',NULL,NULL,'"StateOrProvince"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTRATDEMOZ0','50','H','01','16',NULL,'JobTitle',NULL,NULL,'"JobTitle"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTRATDEMOZ0','50','H','01','17',NULL,'DefaultPayPeriodOverride',NULL,NULL,'"DefaultPayPeriodOverride"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTRATDEMOZ0','50','H','01','18',NULL,'SuggestedGiftAmount',NULL,NULL,'"SuggestedGiftAmount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTRATDEMOZ0','50','H','01','19',NULL,'SuggestedGivingLevels',NULL,NULL,'"SuggestedGivingLevels"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTRATDEMOZ0','50','H','01','20',NULL,'OrgCode',NULL,NULL,'"OrgCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTRATDEMOZ0','50','H','01','21',NULL,'BusinessUnit1',NULL,NULL,'"BusinessUnit1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTRATDEMOZ0','50','H','01','22',NULL,'BusinessUnit2',NULL,NULL,'"BusinessUnit2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTRATDEMOZ0','50','H','01','23',NULL,'BusinessUnit3',NULL,NULL,'"BusinessUnit3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTRATDEMOZ0','50','H','01','24',NULL,'BusinessUnit4',NULL,NULL,'"BusinessUnit4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTRATDEMOZ0','50','H','01','25',NULL,'BusinessUnit5',NULL,NULL,'"BusinessUnit5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTRATDEMOZ0','50','H','01','26',NULL,'BusinessUnit6',NULL,NULL,'"BusinessUnit6"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTRATDEMOZ0','50','H','01','27',NULL,'EmploymentStatus',NULL,NULL,'"EmploymentStatus"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTRATDEMOZ0','50','H','01','28',NULL,'EmployerPostalCode',NULL,NULL,'"EmployerPostalCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTRATDEMOZ0','50','H','01','29',NULL,'Supervisor1',NULL,NULL,'"Supervisor1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTRATDEMOZ0','50','H','01','30',NULL,'Supervisor2',NULL,NULL,'"Supervisor2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTRATDEMOZ0','50','H','01','31',NULL,'UserDefined1',NULL,NULL,'"UserDefined1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTRATDEMOZ0','50','H','01','32',NULL,'UserDefined2',NULL,NULL,'"UserDefined2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTRATDEMOZ0','50','H','01','33',NULL,'UserDefined3',NULL,NULL,'"UserDefined3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTRATDEMOZ0','50','H','01','34',NULL,'UserDefined4',NULL,NULL,'"UserDefined4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTRATDEMOZ0','50','H','01','35',NULL,'UserDefined5',NULL,NULL,'"UserDefined5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTRATDEMOZ0','50','H','01','36',NULL,'UserDefined6',NULL,NULL,'"UserDefined6"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTRATDEMOZ0','50','H','01','37',NULL,'UserDefined7',NULL,NULL,'"UserDefined7"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTRATDEMOZ0','50','H','01','38',NULL,'UserDefined8',NULL,NULL,'"UserDefined8"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTRATDEMOZ0','50','H','01','39',NULL,'UserDefined9',NULL,NULL,'"UserDefined9"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTRATDEMOZ0','50','H','01','40',NULL,'UserDefined10',NULL,NULL,'"UserDefined10"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTRATDEMOZ0','50','H','01','41',NULL,'ContributionTypes',NULL,NULL,'"ContributionTypes"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTRATDEMOZ0','50','H','01','42',NULL,'Roles',NULL,NULL,'"Roles"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTRATDEMOZ0','50','H','01','43',NULL,'ExternalAccountCode',NULL,NULL,'"ExternalAccountCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESTRATDEMOZ0','50','H','01','44',NULL,'SecondaryEmail',NULL,NULL,'"SecondaryEmail"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESTRATDEMOZ0','50','H','01','45',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESTRATDEMOZ0','50','H','01','46',NULL,'GenderIdentity',NULL,NULL,'"GenderIdentity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESTRATDEMOZ0','50','H','01','47',NULL,'Pronoun',NULL,NULL,'"Pronoun"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESTRATDEMOZ0','50','H','01','48',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESTRATDEMOZ0','50','H','01','49',NULL,'Origin',NULL,NULL,'"Origin"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESTRATDEMOZ0','50','H','01','50',NULL,'DateOfBirth',NULL,NULL,'"DateOfBirth"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTRATDEMOZ0','50','D','10','1',NULL,'EmployeeId',NULL,NULL,'"EmployeeId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTRATDEMOZ0','50','D','10','2',NULL,'Prefix',NULL,NULL,'"Prefix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTRATDEMOZ0','50','D','10','3',NULL,'FirstName',NULL,NULL,'"FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTRATDEMOZ0','50','D','10','4',NULL,'MiddleName',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTRATDEMOZ0','51','D','10','5',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTRATDEMOZ0','52','D','10','6',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTRATDEMOZ0','53','D','10','7',NULL,'UserName',NULL,NULL,'"drvUserName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTRATDEMOZ0','54','D','10','8',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTRATDEMOZ0','55','D','10','9',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTRATDEMOZ0','56','D','10','10',NULL,'WorkPhoneNumber',NULL,NULL,'"drvWorkPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTRATDEMOZ0','57','D','10','11',NULL,'AddressLine1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTRATDEMOZ0','58','D','10','12',NULL,'AddressLine2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTRATDEMOZ0','59','D','10','13',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTRATDEMOZ0','60','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTRATDEMOZ0','61','D','10','15',NULL,'StateOrProvince',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTRATDEMOZ0','62','D','10','16',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTRATDEMOZ0','63','D','10','17',NULL,'DefaultPayPeriodOverride',NULL,NULL,'"drvDefaultPayPeriodOverride"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTRATDEMOZ0','64','D','10','18',NULL,'SuggestedGiftAmount',NULL,NULL,'"drvSuggestedGiftAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTRATDEMOZ0','65','D','10','19',NULL,'SuggestedGivingLevels',NULL,NULL,'"drvSuggestedGivingLevels"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTRATDEMOZ0','66','D','10','20',NULL,'OrgCode',NULL,NULL,'"drvOrgCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTRATDEMOZ0','67','D','10','21',NULL,'BusinessUnit1',NULL,NULL,'"drvBusinessUnit1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTRATDEMOZ0','68','D','10','22',NULL,'BusinessUnit2',NULL,NULL,'"drvBusinessUnit2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTRATDEMOZ0','69','D','10','23',NULL,'BusinessUnit3',NULL,NULL,'"drvBusinessUnit3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTRATDEMOZ0','70','D','10','24',NULL,'BusinessUnit4',NULL,NULL,'"drvBusinessUnit4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTRATDEMOZ0','71','D','10','25',NULL,'BusinessUnit5',NULL,NULL,'"drvBusinessUnit5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTRATDEMOZ0','72','D','10','26',NULL,'BusinessUnit6',NULL,NULL,'"drvBusinessUnit6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTRATDEMOZ0','73','D','10','27',NULL,'EmploymentStatus',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTRATDEMOZ0','74','D','10','28',NULL,'EmployerPostalCode',NULL,NULL,'"drvEmployerPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTRATDEMOZ0','75','D','10','29',NULL,'Supervisor1',NULL,NULL,'"drvSupervisor1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTRATDEMOZ0','76','D','10','30',NULL,'Supervisor2',NULL,NULL,'"drvSupervisor2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTRATDEMOZ0','77','D','10','31',NULL,'UserDefined1',NULL,NULL,'"drvUserDefined1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTRATDEMOZ0','78','D','10','32',NULL,'UserDefined2',NULL,NULL,'"drvUserDefined2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTRATDEMOZ0','79','D','10','33',NULL,'UserDefined3',NULL,NULL,'"drvUserDefined3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTRATDEMOZ0','80','D','10','34',NULL,'UserDefined4',NULL,NULL,'"drvUserDefined4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTRATDEMOZ0','81','D','10','35',NULL,'UserDefined5',NULL,NULL,'"drvUserDefined5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTRATDEMOZ0','82','D','10','36',NULL,'UserDefined6',NULL,NULL,'"drvUserDefined6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTRATDEMOZ0','83','D','10','37',NULL,'UserDefined7',NULL,NULL,'"drvUserDefined7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTRATDEMOZ0','84','D','10','38',NULL,'UserDefined8',NULL,NULL,'"drvUserDefined8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTRATDEMOZ0','85','D','10','39',NULL,'UserDefined9',NULL,NULL,'"drvUserDefined9"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTRATDEMOZ0','86','D','10','40',NULL,'UserDefined10',NULL,NULL,'"drvUserDefined10"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTRATDEMOZ0','87','D','10','41',NULL,'ContributionTypes',NULL,NULL,'"drvContributionTypes"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTRATDEMOZ0','88','D','10','42',NULL,'Roles',NULL,NULL,'"drvRoles"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTRATDEMOZ0','89','D','10','43',NULL,'ExternalAccountCode',NULL,NULL,'"drvExternalAccountCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESTRATDEMOZ0','90','D','10','44',NULL,'SecondaryEmail',NULL,NULL,'"drvSecondaryEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESTRATDEMOZ0','91','D','10','45',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESTRATDEMOZ0','92','D','10','46',NULL,'GenderIdentity',NULL,NULL,'"drvGenderIdentity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESTRATDEMOZ0','93','D','10','47',NULL,'Pronoun',NULL,NULL,'"drvPronoun"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESTRATDEMOZ0','94','D','10','48',NULL,'Ethnicity',NULL,NULL,'"drvEthnicity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESTRATDEMOZ0','95','D','10','49',NULL,'Origin',NULL,NULL,'"drvOrigin"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESTRATDEMOZ0','96','D','10','50',NULL,'DateOfBirth',NULL,NULL,'"drvDateOfBirth"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESTRATDEMO_20230615.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Stratus Demographic','202306159','EMPEXPORT','ONDEM_XOE',NULL,'ESTRATDEMO',NULL,NULL,NULL,'202306159','Jun 15 2023  9:38AM','Jun 15 2023  9:38AM','202306151',NULL,'','','202306151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Stratus Demographic-Sched','202306159','EMPEXPORT','SCH_ESTRAT',NULL,'ESTRATDEMO',NULL,NULL,NULL,'202306159','Jun 15 2023  9:38AM','Jun 15 2023  9:38AM','202306151',NULL,'','','202306151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Stratus Demographic-Test','202306159','EMPEXPORT','TEST_XOE',NULL,'ESTRATDEMO',NULL,NULL,NULL,'202306159','Jun 15 2023  9:38AM','Jun 15 2023  9:38AM','202306151',NULL,'','','202306151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTRATDEMO','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTRATDEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTRATDEMO','D10','dbo.U_ESTRATDEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESTRATDEMO_drvTbl
-----------

IF OBJECT_ID('U_ESTRATDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTRATDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [EmployeeId] char(9) NULL,
    [Prefix] varchar(30) NULL,
    [FirstName] varchar(8000) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvUserName] char(9) NULL,
    [drvPassword] varchar(23) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCity] varchar(8000) NULL,
    [drvStateOrProvince] varchar(8000) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvDefaultPayPeriodOverride] varchar(2) NULL,
    [drvSuggestedGiftAmount] varchar(1) NOT NULL,
    [drvSuggestedGivingLevels] varchar(1) NOT NULL,
    [drvOrgCode] varchar(8000) NULL,
    [drvBusinessUnit1] varchar(10) NULL,
    [drvBusinessUnit2] varchar(8000) NULL,
    [drvBusinessUnit3] varchar(10) NULL,
    [drvBusinessUnit4] varchar(8000) NULL,
    [drvBusinessUnit5] varchar(10) NULL,
    [drvBusinessUnit6] varchar(8000) NULL,
    [drvEmploymentStatus] varchar(8) NOT NULL,
    [drvEmployerPostalCode] varchar(50) NULL,
    [drvSupervisor1] varchar(8000) NULL,
    [drvSupervisor2] varchar(8000) NULL,
    [drvUserDefined1] varchar(8000) NULL,
    [drvUserDefined2] varchar(1) NOT NULL,
    [drvUserDefined3] varchar(1) NOT NULL,
    [drvUserDefined4] varchar(1) NOT NULL,
    [drvUserDefined5] varchar(1) NOT NULL,
    [drvUserDefined6] varchar(1) NOT NULL,
    [drvUserDefined7] varchar(1) NOT NULL,
    [drvUserDefined8] varchar(1) NOT NULL,
    [drvUserDefined9] varchar(1) NOT NULL,
    [drvUserDefined10] varchar(1) NOT NULL,
    [drvContributionTypes] varchar(1) NOT NULL,
    [drvRoles] varchar(1) NOT NULL,
    [drvExternalAccountCode] varchar(1) NOT NULL,
    [drvSecondaryEmail] varchar(1) NOT NULL,
    [drvSex] varchar(1) NOT NULL,
    [drvGenderIdentity] varchar(1) NOT NULL,
    [drvPronoun] varchar(1) NOT NULL,
    [drvEthnicity] varchar(1) NOT NULL,
    [drvOrigin] varchar(1) NOT NULL,
    [drvDateOfBirth] varchar(1) NOT NULL
);

-----------
-- Create table U_ESTRATDEMO_EEList
-----------

IF OBJECT_ID('U_ESTRATDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTRATDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESTRATDEMO_File
-----------

IF OBJECT_ID('U_ESTRATDEMO_File') IS NULL
CREATE TABLE [dbo].[U_ESTRATDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTRATDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Marie Waters
Business Analyst: Leah King
Create Date: 06/15/2023
Service Request Number: TekP-2023-05-26-02

Purpose: Stratus Demographic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTRATDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTRATDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTRATDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTRATDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTRATDEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTRATDEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTRATDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTRATDEMO', 'SCH_ESTRAT';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESTRATDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTRATDEMO';

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
    DELETE FROM dbo.U_ESTRATDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTRATDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTRATDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTRATDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTRATDEMO_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,EmployeeId = EecEmpNo
        ,Prefix = CASE WHEN eepnameprefix <> 'Z' THEN eepnameprefix END
        ,FirstName = REPLACE(EepNameFirst, ',', '')
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = REPLACE(EepNameLast, ',', '')
        ,drvSuffix = CASE WHEN EepNameSuffix <> 'Z' THEN EepNameSuffix END
        ,drvUserName = eecempno
        ,drvPassword = Concat('r',eecempno, eecOrglvl3,Left(eepnameFirst,1),'',Left(eepnameLast,1))
        ,drvEmail = EepAddressEMail
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = REPLACE(EepAddressLine2, ',', '')
        ,drvPostalCode = EepAddressZipCode
        ,drvCity = REPLACE(EepAddressCity, ',', '')
        ,drvStateOrProvince = REPLACE(EepAddressState, ',', '')
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvDefaultPayPeriodOverride = CASE WHEN PgrPayFrequency = 'B' THEN '26'
                                            WHEN PgrPayFrequency = 'S' THEN '24'
                                            WHEN PgrPayFrequency = 'W' THEN '52'
                                            END
        ,drvSuggestedGiftAmount = ''
        ,drvSuggestedGivingLevels = ''
        ,drvOrgCode = REPLACE(CmpCompanyName, ',', '') --'Company'
        ,drvBusinessUnit1 = EecOrgLvl1
        ,drvBusinessUnit2 = REPLACE(OrgLvl1Desc, ',', '')
        ,drvBusinessUnit3 = EecOrgLvl2
        ,drvBusinessUnit4 = REPLACE(OrgLvl2Desc, ',', '')
        ,drvBusinessUnit5 = EecOrgLvl3
        ,drvBusinessUnit6 = REPLACE(OrgLvl3Desc, ',', '')
        ,drvEmploymentStatus = CASE WHEN  EecEmplStatus = 'A' THEN 'Active' else 'Inactive' END
        ,drvEmployerPostalCode = LocAddressZipcode
        ,drvSupervisor1 = REPLACE(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Namefirst') + ' ' + dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast'), ',', '')
        ,drvSupervisor2 = REPLACE(sup2fname + ' ' + Sup2lname  , ',', '')
        ,drvUserDefined1 = REPLACE(EepNamePreferredOrFirst, ',', '')
        ,drvUserDefined2 = 'N'
        ,drvUserDefined3 = ''
        ,drvUserDefined4 = ''
        ,drvUserDefined5 = ''
        ,drvUserDefined6 = ''
        ,drvUserDefined7 = ''
        ,drvUserDefined8 = ''
        ,drvUserDefined9 = ''
        ,drvUserDefined10 = ''
        ,drvContributionTypes = ''
        ,drvRoles = ''
        ,drvExternalAccountCode = ''
        ,drvSecondaryEmail = ''
        ,drvSex = ''
        ,drvGenderIdentity = ''
        ,drvPronoun = ''
        ,drvEthnicity = ''
        ,drvOrigin = ''
        ,drvDateOfBirth = ''
    INTO dbo.U_ESTRATDEMO_drvTbl
    FROM dbo.U_ESTRATDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl1Code, OrgDesc AS OrgLvl1Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl1
        ON EecOrgLvl1 = OrgLvl1Code
     LEFT JOIN (
                SELECT OrgCode AS OrgLvl2Code, OrgDesc AS OrgLvl2Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl2
        ON EecOrgLvl2 = OrgLvl2Code
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl3Code, OrgDesc AS OrgLvl3Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
                ) AS Lvl3
        ON EecOrgLvl3 = OrgLvl3Code
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
Left join (select eepEEID seeid, b.eeccoid scoid,eepnamefirst as sup2fname, eepnamelast as Sup2lname             
                FROM  dbo.vw_int_EmpComp c  WITH (NOLOCK)
                join vw_int_EmpComp b on b.eeceeid = c.eecsupervisorid
                join emppers on emppers.eepeeid = b.eeceeid
                ) super on super.sEEID = XEEID
            Where EecEmplstatus <> 'T' OR  (EecEmplstatus = 'T' and Eectermreason <> 'TRO' and EecDateofTermination Between @StartDate and @EndDate)
    ;
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
ALTER VIEW dbo.dsi_vwESTRATDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTRATDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESTRATDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202306081'
       ,expStartPerControl     = '202306081'
       ,expLastEndPerControl   = '202306159'
       ,expEndPerControl       = '202306159'
WHERE expFormatCode = 'ESTRATDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTRATDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTRATDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESTRATDEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESTRATDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESTRATDEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESTRATDEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESTRATDEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESTRATDEMO', 'UseFileName', 'V', 'Y'


-- End ripout