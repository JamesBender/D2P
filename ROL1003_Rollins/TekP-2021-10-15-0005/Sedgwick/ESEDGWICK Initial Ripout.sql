/**********************************************************************************

ESEDGWICK: Sedgwick Export

FormatCode:     ESEDGWICK
Project:        Sedgwick Export
Client ID:      ROL1002
Date/time:      2021-12-08 20:27:49.930
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
ExportPath:    \\us.saas\E0\data_exchange\ROL1002\Exports\
OnDemandPath:  \\us.saas\E0\data_exchange\ROL1002\Exports\
TestPath:      \\us.saas\E4\Public\ROL1002\Exports\Sedgwick\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESEDGWICK_SavePath') IS NOT NULL DROP TABLE dbo.U_ESEDGWICK_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESEDGWICK'


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
WHERE FormatCode = 'ESEDGWICK'
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
WHERE ExpFormatCode = 'ESEDGWICK'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESEDGWICK')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESEDGWICK'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESEDGWICK'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESEDGWICK'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESEDGWICK'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESEDGWICK'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESEDGWICK'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESEDGWICK'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESEDGWICK'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESEDGWICK'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESEDGWICK_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESEDGWICK_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESEDGWICK') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEDGWICK];
GO
IF OBJECT_ID('U_ESEDGWICK_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_Trailer];
GO
IF OBJECT_ID('U_ESEDGWICK_MiscFields') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_MiscFields];
GO
IF OBJECT_ID('U_ESEDGWICK_Header') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_Header];
GO
IF OBJECT_ID('U_ESEDGWICK_File') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_File];
GO
IF OBJECT_ID('U_ESEDGWICk_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICk_EEList];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_Trailer];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_TAM') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_TAM];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_PY2') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_PY2];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_MST') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_MST];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_Header') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_Header];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_DTL') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_DTL];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_DED') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_DED];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_DDP') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_DDP];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_D30') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_D30];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_D20') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_D20];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_D10') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_D10];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_CUS') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_CUS];
GO
IF OBJECT_ID('U_ESEDGWICK_drvTbl_CON') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_drvTbl_CON];
GO
IF OBJECT_ID('U_ESEDGWICK_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_AuditFields];
GO
IF OBJECT_ID('U_ESEDGWICK_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESEDGWICK_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ESEDGWICK','Sedgwick Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ESEDGWICK0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEDGWICK0Z0','3','H','01','1',NULL,'Header',NULL,NULL,'"drvHeader"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEDGWICK0Z0','8','H','01','4',NULL,'Create Date',NULL,NULL,'"drvCreateDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEDGWICK0Z0','6','H','01','12',NULL,'Create Time',NULL,NULL,'"drvCreateTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEDGWICK0Z0','30','H','01','18',NULL,'File Name',NULL,NULL,'"drvFileName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEDGWICK0Z0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"drvRecordType10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEDGWICK0Z0','1','D','10','4',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEDGWICK0Z0','4','D','10','5',NULL,'Client Number',NULL,NULL,'"drvClientNumber10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEDGWICK0Z0','9','D','10','9',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESEDGWICK0Z0','25','D','10','18',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESEDGWICK0Z0','15','D','10','43',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESEDGWICK0Z0','1','D','10','58',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESEDGWICK0Z0','30','D','10','59',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESEDGWICK0Z0','30','D','10','89',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESEDGWICK0Z0','25','D','10','119',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESEDGWICK0Z0','2','D','10','144',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESEDGWICK0Z0','15','D','10','146',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESEDGWICK0Z0','3','D','10','161',NULL,'Country Code',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESEDGWICK0Z0','20','D','10','164',NULL,'County',NULL,NULL,'"drvCounty"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESEDGWICK0Z0','10','D','10','184',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESEDGWICK0Z0','10','D','10','194',NULL,'Work Phone Number',NULL,NULL,'"drvWorkPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESEDGWICK0Z0','8','D','10','204',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESEDGWICK0Z0','8','D','10','212',NULL,'Date of Hire',NULL,NULL,'"drvDateofHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESEDGWICK0Z0','8','D','10','220',NULL,'Date of Termination',NULL,NULL,'"drvDateofTermination"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESEDGWICK0Z0','8','D','10','228',NULL,'Date of Rehire',NULL,NULL,'"drvDateofRehire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESEDGWICK0Z0','8','D','10','236',NULL,'Date of Net Credited Service',NULL,NULL,'"drvDateofNetCreditedService"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESEDGWICK0Z0','1','D','10','244',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESEDGWICK0Z0','1','D','10','245',NULL,'Marital Code',NULL,NULL,'"drvMaritalCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESEDGWICK0Z0','9','D','10','246',NULL,'Prior SSN',NULL,NULL,'"drvPriorSSN10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESEDGWICK0Z0','3','D','10','255',NULL,'Company Code',NULL,NULL,'"drvCompanyCode10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESEDGWICK0Z0','30','D','10','258',NULL,'Work Address 1',NULL,NULL,'"drvWorkAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESEDGWICK0Z0','30','D','10','288',NULL,'Work Address 2',NULL,NULL,'"drvWorkAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESEDGWICK0Z0','30','D','10','318',NULL,'Work City',NULL,NULL,'"drvWorkCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESEDGWICK0Z0','2','D','10','348',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESEDGWICK0Z0','15','D','10','350',NULL,'Work Postal Code',NULL,NULL,'"drvWorkPostalCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESEDGWICK0Z0','3','D','10','365',NULL,'Work Country',NULL,NULL,'"drvWorkCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESEDGWICK0Z0','15','D','10','368',NULL,'Work County',NULL,NULL,'"drvWorkCounty"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESEDGWICK0Z0','6','D','10','383',NULL,'Pay Cycle Indicator',NULL,NULL,'"drvPayCycleIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESEDGWICK0Z0','40','D','10','389',NULL,'Email ID',NULL,NULL,'"drvEmailID10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESEDGWICK0Z0','15','D','10','429',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESEDGWICK0Z0','8','D','10','444',NULL,'Death Date',NULL,NULL,'"drvDeathDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESEDGWICK0Z0','4','D','10','452',NULL,'Last Name Suffix',NULL,NULL,'"drvLastNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESEDGWICK0Z0','30','D','10','456',NULL,'Optional Name',NULL,NULL,'"drvOptionalName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESEDGWICK0Z0','10','D','10','486',NULL,'Work Phone Number Extension',NULL,NULL,'"drvWorkPhoneNumberExtension"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESEDGWICK0Z0','18','D','10','496',NULL,'Fax Number',NULL,NULL,'"drvFaxNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESEDGWICK0Z0','25','D','10','514',NULL,'Employee Unique Number',NULL,NULL,'"drvEEUniqueNumber10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESEDGWICK0Z0','25','D','10','539',NULL,'Employee Unique Number Prior',NULL,NULL,'"drvEmployeeUniqueNumberPrior"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESEDGWICK0Z0','320','D','10','564',NULL,'Email ID',NULL,NULL,'"drvEmailID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEDGWICK0Z0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"drvRecordType20"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEDGWICK0Z0','1','D','20','4',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType20"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEDGWICK0Z0','4','D','20','5',NULL,'Client Number',NULL,NULL,'"drvClientNumber20"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEDGWICK0Z0','9','D','20','9',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESEDGWICK0Z0','8','D','20','18',NULL,'Date Effective',NULL,NULL,'"drvDateEffective20"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESEDGWICK0Z0','9','D','20','26',NULL,'Prior SSN',NULL,NULL,'"drvPriorSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESEDGWICK0Z0','3','D','20','35',NULL,'Action Code',NULL,NULL,'"drvActionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESEDGWICK0Z0','1','D','20','38',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESEDGWICK0Z0','30','D','20','39',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESEDGWICK0Z0','8','D','20','69',NULL,'Job Title Date',NULL,NULL,'"drvJobTitleDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESEDGWICK0Z0','15','D','20','77',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESEDGWICK0Z0','1','D','20','92',NULL,'Shift Worked',NULL,NULL,'"drvShiftWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESEDGWICK0Z0','3','D','20','93',NULL,'Union Code',NULL,NULL,'"drvUnionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESEDGWICK0Z0','4','D','20','96',NULL,'Union Local',NULL,NULL,'"drvUnionLocal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESEDGWICK0Z0','9','D','20','100',NULL,'Business Group',NULL,NULL,'"drvBusinessGroup"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESEDGWICK0Z0','10','D','20','109',NULL,'Location ID',NULL,NULL,'"drvLocationID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESEDGWICK0Z0','10','D','20','119',NULL,'Base Pay Amt',NULL,NULL,'"drvBasePayAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESEDGWICK0Z0','1','D','20','129',NULL,'Base Pay Freq',NULL,NULL,'"drvBasePayFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESEDGWICK0Z0','5','D','20','130',NULL,'Hours Per Week',NULL,NULL,'"drvHoursPerWeek"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESEDGWICK0Z0','1','D','20','135',NULL,'Pay Type',NULL,NULL,'"drvPayType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESEDGWICK0Z0','5','D','20','136',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESEDGWICK0Z0','3','D','20','141',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESEDGWICK0Z0','1','D','20','144',NULL,'Regular/Temp',NULL,NULL,'"drvRegularTemp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESEDGWICK0Z0','1','D','20','145',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESEDGWICK0Z0','1','D','20','146',NULL,'Bargained',NULL,NULL,'"drvBargained"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESEDGWICK0Z0','1','D','20','147',NULL,'Full Time',NULL,NULL,'"drvFullTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESEDGWICK0Z0','1','D','20','148',NULL,'FLSA Status',NULL,NULL,'"drvFLSAStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESEDGWICK0Z0','10','D','20','149',NULL,'Other Pay Amount',NULL,NULL,'"drvOtherPayAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESEDGWICK0Z0','1','D','20','159',NULL,'Other Pay Freq',NULL,NULL,'"drvOtherPayFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESEDGWICK0Z0','9','D','20','160',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESEDGWICK0Z0','2','D','20','169',NULL,'Employee Class',NULL,NULL,'"drvEmployeeClass"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESEDGWICK0Z0','6','D','20','171',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESEDGWICK0Z0','15','D','20','177',NULL,'Department Number',NULL,NULL,'"drvDepartmentNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESEDGWICK0Z0','8','D','20','192',NULL,'Action Code Date',NULL,NULL,'"drvActionCodeDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESEDGWICK0Z0','15','D','20','200',NULL,'Supervisor Employee ID',NULL,NULL,'"drvSupervisorEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESEDGWICK0Z0','30','D','20','215',NULL,'Supervisor E-mail',NULL,NULL,'"drvSupEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESEDGWICK0Z0','6','D','20','245',NULL,'Length of Service',NULL,NULL,'"drvLengthofService"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESEDGWICK0Z0','1','D','20','251',NULL,'Buy Up Tax Indicator',NULL,NULL,'"drvBuyUpTaxIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESEDGWICK0Z0','10','D','20','252',NULL,'Organization',NULL,NULL,'"drvOrganization"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESEDGWICK0Z0','3','D','20','262',NULL,'Action Reason',NULL,NULL,'"drvActionReason"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESEDGWICK0Z0','2','D','20','265',NULL,'Event Sequence Number',NULL,NULL,'"drvEventSequenceNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESEDGWICK0Z0','4','D','20','267',NULL,'Hours Per Day',NULL,NULL,'"drvHoursPerDay"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESEDGWICK0Z0','1','D','20','271',NULL,'Days Per Week',NULL,NULL,'"drvDaysPerWeek"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESEDGWICK0Z0','4','D','20','272',NULL,'Scheduled Hours',NULL,NULL,'"drvScheduledHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESEDGWICK0Z0','4','D','20','276',NULL,'Business Unit Salary Grade',NULL,NULL,'"drvBusinessUnitSalaryGrade"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESEDGWICK0Z0','15','D','20','280',NULL,'Short Term Disability Plan ID',NULL,NULL,'"drvShortTermDisabilityPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESEDGWICK0Z0','8','D','20','295',NULL,'Short Term Disability Plan Effective Date',NULL,NULL,'"drvSTDPlanEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESEDGWICK0Z0','8','D','20','303',NULL,'Short Term Disability Plan Expiration Date',NULL,NULL,'"drvSTDPlanExpirationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESEDGWICK0Z0','15','D','20','311',NULL,'Long Term Disability Plan ID',NULL,NULL,'"drvLongTermDisabilityPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESEDGWICK0Z0','8','D','20','326',NULL,'Long Term Disability Plan Effective Date',NULL,NULL,'"drvLTDPlanEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESEDGWICK0Z0','8','D','20','334',NULL,'Long Term Disability Plan Expiration Date',NULL,NULL,'"drvLTDPlanExpirationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESEDGWICK0Z0','15','D','20','342',NULL,'Supplemental Disability Plan ID',NULL,NULL,'"drvSuppDisPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESEDGWICK0Z0','8','D','20','357',NULL,'Supplemental Disability Plan Effective Date',NULL,NULL,'"drvSuppDisPlanEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESEDGWICK0Z0','8','D','20','365',NULL,'Supplemental Disability Plan Expiration Date',NULL,NULL,'"drvSuppDisPlanExpirationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESEDGWICK0Z0','15','D','20','373',NULL,'Voluntary Pay Plan ID',NULL,NULL,'"drvVoluntaryPayPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESEDGWICK0Z0','8','D','20','388',NULL,'Voluntary Pay Effective Date',NULL,NULL,'"drvVoluntaryPayEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESEDGWICK0Z0','8','D','20','396',NULL,'Voluntary pay Expiration Date',NULL,NULL,'"drvVoluntarypayExpirationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESEDGWICK0Z0','15','D','20','404',NULL,'Paid Family Leave Plan ID',NULL,NULL,'"drvPaidFamilyLeavePlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESEDGWICK0Z0','8','D','20','419',NULL,'Paid Family Leave Effective Date',NULL,NULL,'"drvFMLAEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESEDGWICK0Z0','8','D','20','427',NULL,'Paid Family Leave Expiration Date',NULL,NULL,'"drvFMLAExpirationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESEDGWICK0Z0','6','D','20','435',NULL,'Class Code',NULL,NULL,'"drvClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESEDGWICK0Z0','1','D','20','441',NULL,'OMNI User',NULL,NULL,'"drvOMNIUser"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESEDGWICK0Z0','25','D','20','442',NULL,'Employee Unique Number',NULL,NULL,'"drvEEUniqueNumber20"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESEDGWICK0Z0','50','D','20','467',NULL,'Location Node',NULL,NULL,'"drvLocationNode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESEDGWICK0Z0','25','D','20','517',NULL,'Supervisor Employee Unique Number',NULL,NULL,'"drvSupEEUniqueNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESEDGWICK0Z0','320','D','20','542',NULL,'Supervisor E-mail (Longer)',NULL,NULL,'"drvSupervisorEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEDGWICK0Z0','3','D','30','1',NULL,'Record Type',NULL,NULL,'"drvRecordType30"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEDGWICK0Z0','1','D','30','4',NULL,'Transaction Type',NULL,NULL,'"drvTransactionType30"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEDGWICK0Z0','4','D','30','5',NULL,'Client Number',NULL,NULL,'"drvClientNumber30"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEDGWICK0Z0','9','D','30','9',NULL,'Filler',NULL,NULL,'"drvFiller3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESEDGWICK0Z0','8','D','30','18',NULL,'Date Effective',NULL,NULL,'"drvDateEffective"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESEDGWICK0Z0','3','D','30','26',NULL,'Misc. Field Number',NULL,NULL,'"drvMiscFieldNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESEDGWICK0Z0','65','D','30','29',NULL,'Misc. Field Value',NULL,NULL,'"drvMiscFieldValue"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESEDGWICK0Z0','25','D','30','94',NULL,'Employee Unique Number',NULL,NULL,'"drvEEUniqueNumber30"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEDGWICK0Z0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"drvRecordTypeTrl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEDGWICK0Z0','8','T','90','4',NULL,'Date Create',NULL,NULL,'"drvDateCreate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEDGWICK0Z0','6','T','90','12',NULL,'Time Create',NULL,NULL,'"drvTimeCreate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEDGWICK0Z0','8','T','90','18',NULL,'Total Records***',NULL,NULL,'"drvTotalRecords"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESEDGWICK0Z0','6','T','90','26',NULL,'Master',NULL,NULL,'"drvMaster"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESEDGWICK0Z0','6','T','90','32',NULL,'Detail',NULL,NULL,'"drvDetail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESEDGWICK0Z0','6','T','90','38',NULL,'Filler',NULL,NULL,'"drvFiller4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESEDGWICK0Z0','6','T','90','44',NULL,'Direct Deposit',NULL,NULL,'"drvDirectDeposit"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESEDGWICK0Z0','8','T','90','50',NULL,'Earnings',NULL,NULL,'"drvEarnings"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESEDGWICK0Z0','6','T','90','58',NULL,'Filler',NULL,NULL,'"drvFiller5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESEDGWICK0Z0','6','T','90','64',NULL,'Payroll',NULL,NULL,'"drvPayroll"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESEDGWICK0Z0','8','T','90','70',NULL,'Deduction',NULL,NULL,'"drvDeduction"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESEDGWICK0Z0','8','T','90','78',NULL,'Earnings History',NULL,NULL,'"drvEarningsHistory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESEDGWICK0Z0','8','T','90','86',NULL,'Accrual Balances',NULL,NULL,'"drvAccrualBalances"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESEDGWICK0Z0','8','T','90','94',NULL,'TAMS',NULL,NULL,'"drvTAMS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESEDGWICK0Z0','8','T','90','102',NULL,'Dependent',NULL,NULL,'"drvDependent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESEDGWICK0Z0','8','T','90','110',NULL,'Contact',NULL,NULL,'"drvContact"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESEDGWICK0Z0','8','T','90','118',NULL,'Misc Client Field',NULL,NULL,'"drvMiscClientField"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESEDGWICK0Z0','5','T','90','126',NULL,'Filler',NULL,NULL,'"drvFiller6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESEDGWICK0Z0','6','T','90','131',NULL,'Misc Custom',NULL,NULL,'"drvMiscCustom"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESEDGWICK0Z0','6','T','90','137',NULL,'Payroll V2',NULL,NULL,'"drvPayrollV2"','(''UA''=''F'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sedgwick Export','201810159','EMPEXPORT','ONDEMAND','Oct 15 2018  3:32PM','ESEDGWICK',NULL,NULL,NULL,'201810159','Oct 15 2018 12:00AM','Dec 30 1899 12:00AM','201809181','35604','','','201809181',dbo.fn_GetTimedKey(),NULL,'ULTI_ROLIN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'1ZD15,1ZF3V,1ZF8F,1ZFAD,1ZFC8,F1IYF,48TKI,1ZFDM,1ZFF0,Z9MT2,1ZFIB,1ZFJD,1ZFN3,1ZFOF,1ZFPN,2STMJ,5D666,1ZFGN',NULL,NULL,NULL,'Scheduled Session','202112059','EMPEXPORT','SCHEDULED','Dec  6 2021 10:07PM','ESEDGWICK',NULL,NULL,NULL,'202112059','Jun 20 2021 12:00AM','Dec 30 1899 12:00AM','202112051',NULL,'','','202112051',dbo.fn_GetTimedKey(),NULL,'ESWEET',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201909229','EMPEXPORT','TEST','Sep 27 2019 11:32AM','ESEDGWICK',NULL,NULL,NULL,'201909229','Sep 22 2019 12:00AM','Dec 30 1899 12:00AM','201909151','56222','','','201909151',dbo.fn_GetTimedKey(),NULL,'ESWEET',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','ExportPath','V','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','OnDemandPath','V','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','SubSort','C','EepNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','SubSort2','C','EepNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','TestPath','V','\\us.saas\E4\Public\ROL1002\Exports\Sedgwick\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','UDESPath','C','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEDGWICK','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEDGWICK','H01','dbo.U_ESEDGWICK_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEDGWICK','D10','dbo.U_ESEDGWICK_drvTbl_D10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEDGWICK','D20','dbo.U_ESEDGWICK_drvTbl_D20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEDGWICK','D30','dbo.U_ESEDGWICK_drvTbl_D30',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEDGWICK','T90','dbo.U_ESEDGWICK_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESEDGWICK_Audit
-----------

IF OBJECT_ID('U_ESEDGWICK_Audit') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_Audit] (
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
-- Create table U_ESEDGWICK_AuditFields
-----------

IF OBJECT_ID('U_ESEDGWICK_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_CON
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_CON') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_CON] (
    [drvContactID] char(10) NULL,
    [drvContactType] varchar(3) NOT NULL,
    [drvContactNameFirst] varchar(100) NULL,
    [drvContactNameLast] varchar(100) NULL,
    [drvContactPhoneBusinessNumber] char(10) NULL,
    [drvEmpNo] char(9) NULL,
    [drvContactAddressEmail] varchar(50) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_CUS
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_CUS') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_CUS] (
    [drvFileDate] varchar(8) NULL,
    [drvLongDesc] varchar(40) NULL,
    [drvOrgLvl2] char(6) NULL,
    [drvLocDesc] varchar(25) NULL,
    [drvCompanyName] varchar(40) NULL,
    [drvTermReason] char(6) NULL,
    [drvEmpNo] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_D10
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_D10') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [EepNameLast] char(11) NULL,
    [EepNameFirst] varchar(1) NOT NULL,
    [drvRecordType10] varchar(3) NOT NULL,
    [drvTransactionType10] varchar(1) NOT NULL,
    [drvClientNumber10] varchar(4) NOT NULL,
    [drvSSN] varchar(8000) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountryCode] char(3) NULL,
    [drvCounty] varchar(255) NULL,
    [drvHomePhoneNumber] varchar(1) NOT NULL,
    [drvWorkPhoneNumber] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofHire] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvDateofRehire] varchar(1) NOT NULL,
    [drvDateofNetCreditedService] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvMaritalCode] varchar(1) NOT NULL,
    [drvPriorSSN10] varchar(1) NOT NULL,
    [drvCompanyCode10] char(10) NULL,
    [drvWorkAddress1] varchar(1) NOT NULL,
    [drvWorkAddress2] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvWorkPostalCode] varchar(1) NOT NULL,
    [drvWorkCountry] varchar(1) NOT NULL,
    [drvWorkCounty] varchar(1) NOT NULL,
    [drvPayCycleIndicator] varchar(1) NOT NULL,
    [drvEmailID10] varchar(50) NULL,
    [drvEmployeeID] varchar(15) NULL,
    [drvDeathDate] varchar(1) NOT NULL,
    [drvLastNameSuffix] varchar(1) NOT NULL,
    [drvOptionalName] varchar(30) NULL,
    [drvWorkPhoneNumberExtension] varchar(1) NOT NULL,
    [drvFaxNumber] varchar(1) NOT NULL,
    [drvEEUniqueNumber10] varchar(25) NULL,
    [drvEmployeeUniqueNumberPrior] varchar(1) NOT NULL,
    [drvEmailID] varchar(1) NOT NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_D20
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_D20') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_D20] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [EepNameLast] char(11) NULL,
    [EepNameFirst] varchar(1) NOT NULL,
    [drvRecordType20] varchar(3) NOT NULL,
    [drvTransactionType20] varchar(1) NOT NULL,
    [drvClientNumber20] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvDateEffective20] varchar(8) NULL,
    [drvPriorSSN] varchar(1) NOT NULL,
    [drvActionCode] varchar(1) NOT NULL,
    [drvEmployeeStatus] varchar(1) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvJobTitleDate] datetime NULL,
    [drvDepartment] varchar(10) NULL,
    [drvShiftWorked] varchar(1) NOT NULL,
    [drvUnionCode] varchar(1) NOT NULL,
    [drvUnionLocal] varchar(1) NOT NULL,
    [drvBusinessGroup] varchar(10) NULL,
    [drvLocationID] varchar(10) NULL,
    [drvBasePayAmt] varchar(4) NOT NULL,
    [drvBasePayFreq] varchar(1) NOT NULL,
    [drvHoursPerWeek] varchar(4) NOT NULL,
    [drvPayType] varchar(1) NOT NULL,
    [drvLocationCode] varchar(1) NOT NULL,
    [drvCompanyCode] char(10) NULL,
    [drvRegularTemp] varchar(1) NOT NULL,
    [drvManager] varchar(1) NOT NULL,
    [drvBargained] varchar(1) NOT NULL,
    [drvFullTime] char(1) NULL,
    [drvFLSAStatus] varchar(1) NOT NULL,
    [drvOtherPayAmount] varchar(1) NOT NULL,
    [drvOtherPayFreq] varchar(1) NOT NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvEmployeeClass] varchar(1) NOT NULL,
    [drvJobCode] char(8) NULL,
    [drvDepartmentNumber] varchar(1) NOT NULL,
    [drvActionCodeDate] varchar(1) NOT NULL,
    [drvSupervisorEmployeeID] varchar(1) NOT NULL,
    [drvSupEmail] varchar(1) NOT NULL,
    [drvLengthofService] varchar(1) NOT NULL,
    [drvBuyUpTaxIndicator] varchar(1) NOT NULL,
    [drvOrganization] varchar(1) NOT NULL,
    [drvActionReason] varchar(1) NOT NULL,
    [drvEventSequenceNumber] varchar(2) NOT NULL,
    [drvHoursPerDay] varchar(4) NOT NULL,
    [drvDaysPerWeek] varchar(1) NOT NULL,
    [drvScheduledHours] varchar(4) NOT NULL,
    [drvBusinessUnitSalaryGrade] varchar(1) NOT NULL,
    [drvShortTermDisabilityPlanID] varchar(1) NOT NULL,
    [drvSTDPlanEffectiveDate] varchar(1) NOT NULL,
    [drvSTDPlanExpirationDate] varchar(1) NOT NULL,
    [drvLongTermDisabilityPlanID] varchar(1) NOT NULL,
    [drvLTDPlanEffectiveDate] varchar(1) NOT NULL,
    [drvLTDPlanExpirationDate] varchar(1) NOT NULL,
    [drvSuppDisPlanID] varchar(1) NOT NULL,
    [drvSuppDisPlanEffectiveDate] varchar(1) NOT NULL,
    [drvSuppDisPlanExpirationDate] varchar(1) NOT NULL,
    [drvVoluntaryPayPlanID] varchar(1) NOT NULL,
    [drvVoluntaryPayEffectiveDate] varchar(1) NOT NULL,
    [drvVoluntarypayExpirationDate] varchar(1) NOT NULL,
    [drvPaidFamilyLeavePlanID] varchar(1) NOT NULL,
    [drvFMLAEffectiveDate] varchar(1) NOT NULL,
    [drvFMLAExpirationDate] varchar(1) NOT NULL,
    [drvClassCode] varchar(1) NOT NULL,
    [drvOMNIUser] varchar(1) NOT NULL,
    [drvEEUniqueNumber20] varchar(25) NULL,
    [drvLocationNode] varchar(1) NOT NULL,
    [drvSupEEUniqueNumber] varchar(1) NOT NULL,
    [drvSupervisorEmail] varchar(1) NOT NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_D30
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_D30') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_D30] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [EepNameLast] char(11) NULL,
    [EepNameFirst] varchar(2) NULL,
    [drvRecordType30] varchar(3) NOT NULL,
    [drvTransactionType30] varchar(1) NOT NULL,
    [drvClientNumber30] varchar(4) NOT NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvDateEffective] varchar(8) NULL,
    [drvMiscFieldNumber] varchar(2) NULL,
    [drvMiscFieldValue] char(20) NULL,
    [drvEEUniqueNumber30] varchar(25) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_DDP
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_DDP') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_DDP] (
    [drvAcctNum] char(22) NOT NULL,
    [drvAcctType] char(1) NULL,
    [drvEmpNo] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_DED
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_DED') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_DED] (
    [drvDedCategory] varchar(5) NOT NULL,
    [drvDeductionID] varchar(3) NULL,
    [drvStartDate] datetime NULL,
    [drvStopDate] datetime NULL,
    [drvDedAmt] money NULL,
    [drvPayPeriod] char(1) NULL,
    [drvDedType] varchar(1) NULL,
    [drvEmpNo] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_DTL
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_DTL') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_DTL] (
    [drvFileDate] varchar(8) NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvJbcDesc] varchar(25) NOT NULL,
    [drvUnionNational] char(12) NULL,
    [drvUnionLocal] char(12) NULL,
    [drvOrgLvl1] char(6) NULL,
    [drvBasePay] decimal NULL,
    [drvBasePayFreq] varchar(1) NOT NULL,
    [drvWeeklyHours] decimal NULL,
    [drvSalaryOrHourly] char(1) NULL,
    [drvEEType] varchar(1) NOT NULL,
    [drvBargained] varchar(1) NOT NULL,
    [drvFullTimeOrPartTime] char(1) NULL,
    [drvFLSAStatus] varchar(1) NOT NULL,
    [drvEmpClass] varchar(2) NOT NULL,
    [drvJobCode] char(8) NULL,
    [drvOrgLvl2] char(6) NULL,
    [drvSalaryGrade] char(3) NULL,
    [drvOMNIUser] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_Header
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_Header') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_Header] (
    [drvRunDate] varchar(8) NULL,
    [drvRunTime] varchar(6) NULL,
    [drvFileName] varchar(30) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_MST
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_MST') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_MST] (
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] char(10) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateCreditedService] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalCode] varchar(1) NOT NULL,
    [drvLocAddressLine1] varchar(255) NULL,
    [drvLocAddressLine2] varchar(255) NULL,
    [drvLocAddressCity] varchar(255) NULL,
    [drvLocAddressState] varchar(255) NULL,
    [drvLocAddressZipCode] varchar(50) NULL,
    [drvLocAddressCountry] char(3) NULL,
    [drvPayPeriod] char(1) NULL,
    [drvEmpNo] char(9) NULL,
    [drvDateDeceased] datetime NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_PY2
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_PY2') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_PY2] (
    [drvEmpNo] char(9) NULL,
    [drvFedStatus] char(1) NULL,
    [drvFedExemptions] int NULL,
    [drvExemptFromTax] varchar(1) NOT NULL,
    [drvStateWorked] varchar(2) NULL,
    [drvStateExemptions] int NULL,
    [drvStateNotSubjectToTax] varchar(1) NOT NULL,
    [drvStateStatus] char(1) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvStateLivedExemptions] int NULL,
    [drvStateLivedNotSubjectToTax] varchar(1) NOT NULL,
    [drvStateLivedStatus] char(1) NULL,
    [drvStatesDifferent] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_TAM
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_TAM') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_TAM] (
    [drvEffDate] datetime NULL,
    [drvHoursPrevYear] numeric NULL,
    [drvEmpNo] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);

-----------
-- Create table U_ESEDGWICK_drvTbl_Trailer
-----------

IF OBJECT_ID('U_ESEDGWICK_drvTbl_Trailer') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_drvTbl_Trailer] (
    [drvFileDate] varchar(8) NULL,
    [drvFileTime] varchar(6) NULL,
    [drvTotalCountFile] int NOT NULL,
    [drvTotalCountMST] int NULL,
    [drvTotalCountDTL] int NULL,
    [drvTotalCountDDP] int NULL,
    [drvTotalCountDED] int NULL,
    [drvTotalCountTAM] int NULL,
    [drvTotalCountCON] int NULL,
    [drvTotalCountCUS] int NULL,
    [drvTotalCountPY2] int NULL
);

-----------
-- Create table U_ESEDGWICk_EEList
-----------

IF OBJECT_ID('U_ESEDGWICk_EEList') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICk_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESEDGWICK_File
-----------

IF OBJECT_ID('U_ESEDGWICK_File') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ESEDGWICK_Header
-----------

IF OBJECT_ID('U_ESEDGWICK_Header') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_Header] (
    [drvHeader] varchar(3) NOT NULL,
    [drvCreateDate] varchar(8) NULL,
    [drvCreateTime] varchar(8000) NULL,
    [drvFileName] varchar(8000) NULL
);

-----------
-- Create table U_ESEDGWICK_MiscFields
-----------

IF OBJECT_ID('U_ESEDGWICK_MiscFields') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_MiscFields] (
    [MiscEEID] char(12) NULL,
    [MiscCoID] char(5) NULL,
    [MiscField] varchar(11) NOT NULL,
    [MiscValue] char(20) NULL
);

-----------
-- Create table U_ESEDGWICK_Trailer
-----------

IF OBJECT_ID('U_ESEDGWICK_Trailer') IS NULL
CREATE TABLE [dbo].[U_ESEDGWICK_Trailer] (
    [drvRecordTypeTrl] varchar(3) NOT NULL,
    [drvDateCreate] varchar(8) NULL,
    [drvTimeCreate] varchar(8000) NULL,
    [drvTotalRecords] varchar(8) NULL,
    [drvMaster] varchar(6) NULL,
    [drvDetail] varchar(6) NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvDirectDeposit] varchar(6) NULL,
    [drvEarnings] varchar(8) NULL,
    [drvFiller5] varchar(1) NOT NULL,
    [drvPayroll] varchar(6) NULL,
    [drvDeduction] varchar(8) NULL,
    [drvEarningsHistory] varchar(1) NOT NULL,
    [drvAccrualBalances] varchar(8) NULL,
    [drvTAMS] varchar(8) NULL,
    [drvDependent] varchar(8) NULL,
    [drvContact] varchar(8) NULL,
    [drvMiscClientField] varchar(8) NULL,
    [drvFiller6] varchar(1) NOT NULL,
    [drvMiscCustom] varchar(6) NULL,
    [drvPayrollV2] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEDGWICK]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Robert Dulaney
Business Analyst: Patrick Clare
Create Date: 09/18/2018
Service Request Number: SR-2018-00200697

Purpose: Sedgwick Export

Revision History
----------------
Update By           Date            Request Num            Desc
Greg Travetti        4/22/2019        SR-2019-235218        Updated Location ID to use the Orglvl3 as is for import code = 1 and 1st 4 digits for import code = 6


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESEDGWICK';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESEDGWICK';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESEDGWICK';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESEDGWICK';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESEDGWICK' ORDER BY RunID DESC;


Scheduling
------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = 'ROLIN - Sedgwick Export (ESEDGWICK) - Weekly, Monday 10:00 PM ET', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = 'ROLIN - Sedgwick Export (ESEDGWICK) - Weekly, Monday 10:00 PM ET', @set_owner_to_self = 1;


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEDGWICK', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEDGWICK', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEDGWICK', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESEDGWICK', @AllObjects = 'Y', @IsWeb = 'N'
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
            ,@TermDateLimit        VARCHAR(10);

    -- Set FormatCode
    SELECT @FormatCode = 'ESEDGWICK';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@TermDateLimit      = CONVERT(VARCHAR(10), GETDATE() - 30, 112)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESEDGWICK_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESEDGWICK_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Cleans EE out that have a term date older than 30 days prior to the file running
    DELETE FROM dbo.U_ESEDGWICK_EEList
    WHERE xCoID + xEEID IN (SELECT EecCoID + EecEEID FROM dbo.vw_int_EmpComp WHERE EecEmplStatus = 'T' AND EecDateOfTermination < @TermDateLimit)


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESEDGWICK_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_AuditFields;
    CREATE TABLE dbo.U_ESEDGWICK_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESEDGWICK_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESEDGWICK_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_Audit;
    SELECT 
        audEEID            = audKey1Value
        ,audKey2        = audKey2Value
        ,audKey3        = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo        = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ESEDGWICK_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESEDGWICK_AuditFields WITH (NOLOCK) 
      ON audTableName = aTableName
     AND audFieldName = aFieldName
   WHERE audDateTime BETWEEN @StartDate AND @EndDate
     AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESEDGWICK_Audit ON dbo.U_ESEDGWICK_Audit (audEEID,audKey2);

    --==========================================
    -- Build Working Tables
    --==========================================

    --------------------------------------------
    -- MISCELLANEOUS CLIENT FIELDS TABLE
    --------------------------------------------
    IF OBJECT_ID('U_ESEDGWICK_MiscFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_MiscFields;
    
    --JOB CODE
    SELECT
          MiscEEID    = xEEID
         ,MiscCoID    = xCoID
         ,MiscField    = 'JobCode'
         ,MiscValue    = JbcWCCode
    INTO  dbo.U_ESEDGWICK_MiscFields
    FROM  dbo.U_ESEDGWICK_EEList WITH (NOLOCK)
    JOIN  dbo.vw_int_EmpComp WITH (NOLOCK)
      ON  EecEEID = xEEID
     AND  EecCoID = xCoID
    JOIN  dbo.JobCode WITH (NOLOCK)
      ON  JbcJobCode = EecJobCode
    WHERE JbcCountryCode = 'USA'
      AND JbcStatus = 'A'

    UNION ALL

    -- LICENSE PROVIDER
    SELECT
          MiscEEID    = xEEID
         ,MiscCoID    = xCoID
         ,MiscField    = 'ElcProvider'
         ,MiscValue    = ElcProvider
    FROM  dbo.U_ESEDGWICK_EEList WITH (NOLOCK)
    JOIN  dbo.vw_int_EmpComp WITH (NOLOCK)
      ON  EecEEID = xEEID
     AND  EecCoID = xCoID
    JOIN  dbo.EmpLicns WITH (NOLOCK)
      ON  ElcEEID = xEEID
    WHERE ElcLicenseID = 'DRLIC'

    UNION ALL

    -- LICENSE NUMBER

    SELECT
         MiscEEID    = xEEID
        ,MiscCoID    = xCoID
        ,MiscField    = 'ElcNumber'
        ,MiscValue    = ElcNumber
    FROM dbo.U_ESEDGWICK_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCoID = xCoID
    JOIN dbo.EmpLicns WITH (NOLOCK)
      ON ElcEEID = xEEID
   WHERE ElcLicenseID = 'DRLIC';


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESEDGWICK_drvTbl_D10 - MASTER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESEDGWICK_drvTbl_D10','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_drvTbl_D10;
    SELECT DISTINCT
         drvEEID                        = xEEID
        ,drvCoID                        = xCoID
        ,EepNameLast                    = EepSSN
        ,EepNameFirst                    = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType10                = 'MST'
        ,drvTransactionType10            = 'A'
        ,drvClientNumber10                = '2288'
        ,drvSSN                            = REPLACE(EepSSN,'-','')
        ,drvLastName                    = EepNameLast
        ,drvFirstName                    = EepNameFirst
        ,drvMiddleInitial                = LEFT(EepNameMiddle,1)
        ,drvAddress1                    = EepAddressLine1
        ,drvAddress2                    = EepAddressLine2
        ,drvCity                        = EepAddressCity
        ,drvState                        = EepAddressState
        ,drvPostalCode                    = EepAddressZipCode
        ,drvCountryCode                    = EepAddressCountry
        ,drvCounty                        = EepAddressCounty
        ,drvHomePhoneNumber                = ''
        ,drvWorkPhoneNumber                = ''
        ,drvDateofBirth                    = EepDateOfBirth
        ,drvDateofHire                    = EecDateOfOriginalHire
        ,drvDateofTermination            = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateofRehire                = ''
        ,drvDateofNetCreditedService    = ''
        ,drvGender                        = EepGender
        ,drvMaritalCode                    = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvPriorSSN10                    = ''
        ,drvCompanyCode10                = CmpImportCode
        ,drvWorkAddress1                = ''
        ,drvWorkAddress2                = ''
        ,drvWorkCity                    = ''
        ,drvWorkState                    = ''
        ,drvWorkPostalCode                = ''
        ,drvWorkCountry                    = ''
        ,drvWorkCounty                    = ''
        ,drvPayCycleIndicator            = ''
        ,drvEmailID10                    = EepAddressEMail
        ,drvEmployeeID                    = RIGHT(SPACE(15) + RIGHT(REPLICATE('0',9) + LTRIM(RTRIM(EecEmpNo)), 9), 15)
        ,drvDeathDate                    = ''                  
        ,drvLastNameSuffix                = ''                  
        ,drvOptionalName                = RIGHT(SPACE(30) + RIGHT(REPLICATE('0',9) + LTRIM(RTRIM(EecEmpNo)), 9), 30)
        ,drvWorkPhoneNumberExtension    = ''                  
        ,drvFaxNumber                    = ''                  
        ,drvEEUniqueNumber10            = RIGHT(SPACE(25) + RIGHT(REPLICATE('0',9) + LTRIM(RTRIM(EecEmpNo)), 9), 25)
        ,drvEmployeeUniqueNumberPrior    = ''
        ,drvEmailID                        = ''

    INTO  dbo.U_ESEDGWICK_drvTbl_D10
    FROM  dbo.U_ESEDGWICK_EEList WITH (NOLOCK)
    JOIN  dbo.vw_int_EmpComp WITH (NOLOCK)
      ON  EecEEID = xEEID 
     AND  EecCoID = xCoID
    JOIN  dbo.EmpPers WITH (NOLOCK)
      ON  EepEEID = xEEID
    JOIN  dbo.Company WITH (NOLOCK) 
      ON  CmpCOID = xCOID
    JOIN  dbo.Location WITH (NOLOCK) 
      ON  LocCode = EecLocation
    WHERE LocAddressCountry = 'USA'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESEDGWICK_drvTbl_D20 - DETAIL RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESEDGWICK_drvTbl_D20','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_drvTbl_D20;
    SELECT DISTINCT
         drvEEID                        = xEEID
        ,drvCoID                        = xCoID
        ,EepNameLast                    = EepSSN
        ,EepNameFirst                    = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType20                = 'DTL'
        ,drvTransactionType20            = 'A'
        ,drvClientNumber20                = '2288'
        ,drvFiller1                        = ''
        ,drvDateEffective20                = CONVERT(VARCHAR(8), GETDATE(), 112) 
        ,drvPriorSSN                    = ''
        ,drvActionCode                    = ''
        ,drvEmployeeStatus                = CASE
                                            WHEN EecEmplStatus = 'T' THEN
                                                CASE
                                                    WHEN EecTermReason = '202'                THEN 'R'
                                                    WHEN EecTermReason = '203'                THEN 'D'
                                                    WHEN EecTermReason NOT IN ('202','203') THEN 'T'
                                                END
                                            WHEN EecEmplStatus = 'L' THEN 'L'
                                            WHEN EecEmplStatus = 'S' THEN 'S'
                                            ELSE 'A'
                                          END
        ,drvJobTitle                    = JbcDesc
        ,drvJobTitleDate                = CASE WHEN Ejh.EjhJobEffDate IS NULL THEN EecDateOfLastHire ELSE Ejh.EjhJobEffDate END
        ,drvDepartment                    = EecOrgLvl3
        ,drvShiftWorked                    = ''
        ,drvUnionCode                    = ''
        ,drvUnionLocal                    = ''
        ,drvBusinessGroup                = EecOrgLvl3
        ,drvLocationID                    = CASE
                                            --WHEN CmpImportCode = '1'  THEN RIGHT(REPLICATE('0',5) + LEFT(EecOrgLvl3,2), 5)
                                            WHEN CmpImportCode = '1'  THEN EecOrgLvl3 --Updated per SR-2019-235218
                                            WHEN CmpImportCode = '2'  THEN 
                                                CASE
                                                    WHEN LEN(EecOrgLvl3) = 3 THEN '00' + LEFT(EecOrgLvl3,2)
                                                    WHEN LEN(EecOrgLvl3) = 4 THEN '0'  + LEFT(EecOrgLvl3,3)
                                                    WHEN LEN(EecOrgLvl3) = 5 THEN EecOrgLvl3
                                                END
                                            --WHEN CmpImportCode = '6'  THEN LEFT(EecOrgLvl3,5)
                                            WHEN CmpImportCode = '6'  THEN LEFT(EecOrgLvl3,4) --Updated per SR-2019-235218
                                            WHEN CmpImportCode = '26' THEN
                                                CASE
                                                    WHEN EecOrgLvl1 = 'WHO'  THEN LEFT(EecOrgLvl3,4)
                                                    WHEN EecOrgLvl1 = 'WIN'  THEN 
                                                        CASE
                                                            WHEN LEN(EecOrgLvl3) = 3 THEN '00' + LEFT(EecOrgLvl3,2)
                                                            WHEN LEN(EecOrgLvl3) = 4 THEN '0'  + LEFT(EecOrgLvl3,3) 
                                                            WHEN LEN(EecOrgLvl3) = 5 THEN EecOrgLvl3
                                                        END
                                                END
                                            ELSE EecOrgLvl3
                                          END
        ,drvBasePayAmt                    = '0.00'
        ,drvBasePayFreq                    = ''
        ,drvHoursPerWeek                = '0.00'
        ,drvPayType                        = ''
        ,drvLocationCode                = ''
        ,drvCompanyCode                    = CmpImportCode
        ,drvRegularTemp                    = ''
        ,drvManager                        = ''
        ,drvBargained                    = ''
        ,drvFullTime                    = EecFullTimeOrPartTime
        ,drvFLSAStatus                    = ''
        ,drvOtherPayAmount                = ''
        ,drvOtherPayFreq                = ''
        ,drvFiller2                        = ''
        ,drvEmployeeClass                = ''
        ,drvJobCode                        = EecJobCode
        ,drvDepartmentNumber            = ''
        ,drvActionCodeDate                = ''
        ,drvSupervisorEmployeeID        = ''
        ,drvSupEmail                    = ''
        ,drvLengthofService                = ''
        ,drvBuyUpTaxIndicator            = ''
        ,drvOrganization                = ''
        ,drvActionReason                = ''
        ,drvEventSequenceNumber            = '00'
        ,drvHoursPerDay                    = '0.00'
        ,drvDaysPerWeek                    = ''
        ,drvScheduledHours                = '0.00'
        ,drvBusinessUnitSalaryGrade        = ''
        ,drvShortTermDisabilityPlanID    = ''
        ,drvSTDPlanEffectiveDate        = ''
        ,drvSTDPlanExpirationDate        = ''
        ,drvLongTermDisabilityPlanID    = ''
        ,drvLTDPlanEffectiveDate        = ''
        ,drvLTDPlanExpirationDate        = ''
        ,drvSuppDisPlanID                = ''
        ,drvSuppDisPlanEffectiveDate    = ''
        ,drvSuppDisPlanExpirationDate    = ''
        ,drvVoluntaryPayPlanID            = ''
        ,drvVoluntaryPayEffectiveDate    = ''
        ,drvVoluntarypayExpirationDate    = ''
        ,drvPaidFamilyLeavePlanID        = ''
        ,drvFMLAEffectiveDate            = ''
        ,drvFMLAExpirationDate            = ''
        ,drvClassCode                    = ''
        ,drvOMNIUser                    = ''
        ,drvEEUniqueNumber20            = RIGHT(SPACE(25) + RIGHT(REPLICATE('0',9) + LTRIM(RTRIM(EecEmpNo)), 9), 25)
        ,drvLocationNode                = ''
        ,drvSupEEUniqueNumber            = ''
        ,drvSupervisorEmail                = ''

    INTO  dbo.U_ESEDGWICK_drvTbl_D20
    FROM  dbo.U_ESEDGWICK_EEList WITH (NOLOCK)
    JOIN  dbo.vw_int_EmpComp WITH (NOLOCK)
      ON  EecEEID = xEEID 
     AND  EecCoID = xCoID
    JOIN  dbo.Company WITH (NOLOCK)
      ON  CmpCoID = xCoID
    JOIN  dbo.EmpPers WITH (NOLOCK)
      ON  EepEEID = xEEID
    JOIN  dbo.JobCode WITH (NOLOCK)
      ON  JbcJobCode = EecJobCode
    LEFT  JOIN 
            (
              SELECT
                 EjhCoID
                ,EjhEEID
                ,EjhJobEffDate    = MAX(EjhJobEffDate)
              FROM     dbo.vw_int_EmpHJob WITH (NOLOCK)
              WHERE    EjhIsJobChange = 'Y'
              GROUP BY EjhEEID, EjhCoID
            ) Ejh
      ON  Ejh.EjhEEID = xEEID
     AND  Ejh.EjhCoID = xCoID
    JOIN  dbo.Location WITH (NOLOCK) 
      ON  LocCode = EecLocation
    WHERE LocAddressCountry = 'USA'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESEDGWICK_drvTbl_D30 - MISC CLIENT RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESEDGWICK_drvTbl_D30','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_drvTbl_D30;
    SELECT DISTINCT
         drvEEID                        = xEEID
        ,drvCoID                        = xCoID
        ,EepNameLast                    = EepSSN
        ,EepNameFirst                    = CASE
                                            WHEN MiscField = 'JobCode'     THEN '14'
                                            WHEN MiscField = 'ElcProvider' THEN '17'
                                            WHEN MiscField = 'ElcNumber'   THEN '18'
                                          END
        -- standard fields above and additional driver fields below
        ,drvRecordType30                = 'MCF'
        ,drvTransactionType30            = 'A'
        ,drvClientNumber30                = '2288'
        ,drvFiller3                        = ''
        ,drvDateEffective                = CONVERT(VARCHAR(8), GETDATE(), 112)  
        ,drvMiscFieldNumber                = CASE
                                            WHEN MiscField = 'JobCode'     THEN '14'
                                            WHEN MiscField = 'ElcProvider' THEN '17'
                                            WHEN MiscField = 'ElcNumber'   THEN '18'
                                          END
        ,drvMiscFieldValue                = MiscValue
        ,drvEEUniqueNumber30            = RIGHT(SPACE(25) + RIGHT(REPLICATE('0',9) + LTRIM(RTRIM(EecEmpNo)), 9), 25)

    INTO  dbo.U_ESEDGWICK_drvTbl_D30
    FROM  dbo.U_ESEDGWICK_EEList WITH (NOLOCK)
    JOIN  dbo.vw_int_EmpComp WITH (NOLOCK)
      ON  EecEEID = xEEID 
     AND  EecCoID = xCoID
    JOIN  dbo.Company WITH (NOLOCK)
      ON  CmpCoID = xCoID
    JOIN  dbo.EmpPers WITH (NOLOCK)
      ON  EepEEID = xEEID
    LEFT  JOIN dbo.U_ESEDGWICK_MiscFields WITH (NOLOCK)
      ON  MiscEEID = xEEID
     AND  MiscCoID = xCoID
    JOIN  dbo.Location WITH (NOLOCK) 
      ON  LocCode = EecLocation
    WHERE LocAddressCountry = 'USA'
    ;
    
    --================================
    -- DELETE NULL RECORDS FROM MISC FIELD DRIVER
    --================================

    DELETE FROM dbo.U_ESEDGWICK_drvTbl_D30
    WHERE drvMiscFieldValue IS NULL 
       OR drvMiscFieldValue = ''
    ;


    --================================
    --TRAILER COUNT VARIABLES
    --================================

    DECLARE @cnt10  INT
    DECLARE @cnt20  INT
    DECLARE @cnt30  INT
    DECLARE @ttlCnt INT

    SELECT  @cnt10 = COUNT(*) FROM U_ESEDGWICK_drvTbl_D10
    SELECT  @cnt20 = COUNT(*) FROM U_ESEDGWICK_drvTbl_D20
    SELECT  @cnt30 = COUNT(*) FROM U_ESEDGWICK_drvTbl_D30

    SELECT  @ttlCnt = @cnt10 + @cnt20 + @cnt30
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESEDGWICK_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_Header;
    SELECT DISTINCT
         drvHeader                        = 'HDR'
        ,drvCreateDate                    = CONVERT(VARCHAR(8), GETDATE(), 112) 
        ,drvCreateTime                    = REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '')  
        ,drvFileName                    = 'HR2288_' + CONVERT(VARCHAR(8), GETDATE(), 112) +  REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '') + '.txt'

    INTO dbo.U_ESEDGWICK_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESEDGWICK_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ESEDGWICK_Trailer;
    SELECT DISTINCT
         drvRecordTypeTrl                = 'TR2'
        ,drvDateCreate                    = CONVERT(VARCHAR(8), GETDATE(), 112)  
        ,drvTimeCreate                    = REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '')   
        ,drvTotalRecords                = CONVERT(VARCHAR(8), @ttlCnt + 2)
        ,drvMaster                        = RIGHT(REPLICATE('0',6)  + CONVERT(VARCHAR(6), @cnt10), 6)
        ,drvDetail                        = RIGHT(REPLICATE('0',6) + CONVERT(VARCHAR(6), @cnt20), 6)
        ,drvFiller4                        = ''
        ,drvDirectDeposit                = REPLICATE('0',6)
        ,drvEarnings                    = REPLICATE('0',8)
        ,drvFiller5                        = ''
        ,drvPayroll                        = REPLICATE('0',6)
        ,drvDeduction                    = REPLICATE('0',8)
        ,drvEarningsHistory                = ''
        ,drvAccrualBalances                = REPLICATE('0',8)
        ,drvTAMS                        = REPLICATE('0',8)
        ,drvDependent                    = REPLICATE('0',8)
        ,drvContact                        = REPLICATE('0',8)
        ,drvMiscClientField                = REPLICATE('0',8)
        ,drvFiller6                        = ''
        ,drvMiscCustom                    = RIGHT(REPLICATE('0',6) + CONVERT(VARCHAR(6), @cnt30), 6)
        ,drvPayrollV2                    = REPLICATE('0',6)
    INTO dbo.U_ESEDGWICK_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE 
                                WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_HR2288_' + CONVERT(VARCHAR(8), GETDATE(), 112) +  REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '') + '.txt '
                                                               ELSE 'HR2288_' + CONVERT(VARCHAR(8), GETDATE(), 112) +  REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '') + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;

/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESEDGWICK_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ESEDGWICK_File (NOLOCK)
    ORDER BY Initialsort, SubSort, recordset, SubSort2;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESEDGWICK%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201809111'
       ,expStartPerControl     = '201809111'
       ,expLastEndPerControl   = '201809189'
       ,expEndPerControl       = '201809189'
WHERE expFormatCode = 'ESEDGWICK';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESEDGWICK_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ESEDGWICK_File (NOLOCK)
    ORDER BY Initialsort, SubSort, recordset, SubSort2;

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESEDGWICK'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESEDGWICK'
   AND rpoParmType = 'expSystemID'


-- End ripout