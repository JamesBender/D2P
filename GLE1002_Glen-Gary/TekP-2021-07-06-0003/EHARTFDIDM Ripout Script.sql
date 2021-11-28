/**********************************************************************************

EHARTFDIDM: Hartford Export V2

FormatCode:     EHARTFDIDM
Project:        Hartford Export V2
Client ID:      GLE1002
Date/time:      2021-11-10 03:42:53.807
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    E32
Server:         E3SUP2ST01
Database:       ULTIPRO_GLEN
Web Filename:   GLE1002_E37C5_EEHISTORY_EHARTFDIDM_ExportCode_YYYYMMDD_HHMMSS.txt
ArchivePath:   \\us.saas\e3\Public\GLE1002\Exports\Hartford\
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHARTFDIDM_SavePath') IS NOT NULL DROP TABLE dbo.U_EHARTFDIDM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHARTFDIDM'


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
WHERE FormatCode = 'EHARTFDIDM'
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
WHERE ExpFormatCode = 'EHARTFDIDM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHARTFDIDM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHARTFDIDM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHARTFDIDM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHARTFDIDM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHARTFDIDM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHARTFDIDM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHARTFDIDM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHARTFDIDM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHARTFDIDM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHARTFDIDM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('fn_EndOfMonth_EHARTFDIDM') IS NOT NULL DROP FUNCTION [dbo].[fn_EndOfMonth_EHARTFDIDM];
GO
IF OBJECT_ID('dsi_fnlib_GetPhoneNumber_EHARTFDIDM') IS NOT NULL DROP FUNCTION [dbo].[dsi_fnlib_GetPhoneNumber_EHARTFDIDM];
GO
IF OBJECT_ID('dsi_vwEHARTFDIDM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHARTFDIDM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHARTFDIDM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHARTFDIDM];
GO
IF OBJECT_ID('U_EHARTFDIDM_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_Trailer];
GO
IF OBJECT_ID('U_EHARTFDIDM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_PEarHist];
GO
IF OBJECT_ID('U_EHARTFDIDM_ISOCountryCodeMapping') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping];
GO
IF OBJECT_ID('U_EHARTFDIDM_Header') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_Header];
GO
IF OBJECT_ID('U_EHARTFDIDM_File') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_File];
GO
IF OBJECT_ID('U_EHARTFDIDM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_EEList];
GO
IF OBJECT_ID('U_EHARTFDIDM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_drvTbl];
GO
IF OBJECT_ID('U_EHARTFDIDM_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_DedList];
GO
IF OBJECT_ID('U_EHARTFDIDM_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHARTFDIDM_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHARTFDIDM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHARTFDIDM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHARTFDIDM','Hartford Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','11566','S','N','EHARTFDIDMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHARTFDIDMZ0','5','H','01','1',NULL,'Section code',NULL,NULL,'"~HDR~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHARTFDIDMZ0','3','H','01','2',NULL,'Customer Count',NULL,NULL,'"drvDetailCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHARTFDIDMZ0','30','H','01','3',NULL,'File Name',NULL,NULL,'"drvFileName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHARTFDIDMZ0','20','H','01','4',NULL,'Date File Created',NULL,NULL,'"drvRunDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHARTFDIDMZ0','20','H','01','5',NULL,'Customer Name',NULL,NULL,'"Glen Gery"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHARTFDIDMZ0','6','H','01','6',NULL,'File Version Number',NULL,NULL,'"002.00"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHARTFDIDMZ0','5','D','10','1',NULL,'Section code',NULL,NULL,'"~PII~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHARTFDIDMZ0','10','D','10','2',NULL,'Customer Number',NULL,NULL,'"1578572"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHARTFDIDMZ0','1','D','10','3',NULL,'Transaction Code',NULL,NULL,'"drvTransCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHARTFDIDMZ0','9','D','10','4',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHARTFDIDMZ0','15','D','10','5',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHARTFDIDMZ0','9','D','10','6',NULL,'Member SSN/Member ID',NULL,NULL,'"drvMemberSSNMemberID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHARTFDIDMZ0','2','D','10','7',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHARTFDIDMZ0','30','D','10','8',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHARTFDIDMZ0','30','D','10','9',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHARTFDIDMZ0','1','D','10','10',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHARTFDIDMZ0','10','D','10','11',NULL,'Name Prefix',NULL,NULL,'"drvNamePrefix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHARTFDIDMZ0','10','D','10','12',NULL,'Name Suffix',NULL,NULL,'"drvNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHARTFDIDMZ0','8','D','10','13',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHARTFDIDMZ0','1','D','10','14',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHARTFDIDMZ0','1','D','10','15',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHARTFDIDMZ0','1','D','10','16',NULL,'Smoker Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHARTFDIDMZ0','5','D','10','17',NULL,'Section Code',NULL,NULL,'"~BNK~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHARTFDIDMZ0','20','D','10','18',NULL,'Bank ABA Routing Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHARTFDIDMZ0','40','D','10','19',NULL,'Bank Account Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHARTFDIDMZ0','1','D','10','20',NULL,'Bank Account Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHARTFDIDMZ0','5','D','10','21',NULL,'Section Code',NULL,NULL,'"~ECI~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHARTFDIDMZ0','40','D','10','22',NULL,'Member Mailing Address 1',NULL,NULL,'"drvMemberMailingAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHARTFDIDMZ0','40','D','10','23',NULL,'Member Mailing Address 2',NULL,NULL,'"drvMemberMailingAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHARTFDIDMZ0','30','D','10','24',NULL,'Member Mailing Address City',NULL,NULL,'"drvMemberMailingAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHARTFDIDMZ0','2','D','10','25',NULL,'Member Mailing Address State',NULL,NULL,'"drvMemberMailingAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHARTFDIDMZ0','10','D','10','26',NULL,'Member Mailing Address Zip Code',NULL,NULL,'"drvMemberMailingAddrZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHARTFDIDMZ0','3','D','10','27',NULL,'Member Mailing Address Country Code',NULL,NULL,'"drvMemberMailingAddrCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHARTFDIDMZ0','2','D','10','28',NULL,'Member Mailing Address Province Code',NULL,NULL,'"drvMemberMailingAddrProvince"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHARTFDIDMZ0','30','D','10','29',NULL,'Member Mailing Address Province Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHARTFDIDMZ0','10','D','10','30',NULL,'Employee Home Phone',NULL,NULL,'"drvEmployeeHomePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHARTFDIDMZ0','10','D','10','31',NULL,'Employee Cell Phone',NULL,NULL,'"drvEmpCellNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHARTFDIDMZ0','50','D','10','32',NULL,'Employee Personal E-mail Address',NULL,NULL,'"drvPersonalEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHARTFDIDMZ0','50','D','10','33',NULL,'Employee Work E-mail Address',NULL,NULL,'"drvEmployeeWorkEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHARTFDIDMZ0','2','D','10','34',NULL,'Employee Work State Code',NULL,NULL,'"drvEmployeeWorkStateCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHARTFDIDMZ0','40','D','10','35',NULL,'Employee Work Address 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHARTFDIDMZ0','40','D','10','36',NULL,'Employee Work Address 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHARTFDIDMZ0','30','D','10','37',NULL,'Employee Work Address City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHARTFDIDMZ0','2','D','10','38',NULL,'Employee Work Address State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHARTFDIDMZ0','10','D','10','39',NULL,'Employee Work Address Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHARTFDIDMZ0','3','D','10','40',NULL,'Employee Work Address Country Code',NULL,NULL,'"drvEmployeeWorkAddressCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHARTFDIDMZ0','10','D','10','41',NULL,'Employee Work Phone',NULL,NULL,'"drvEmployeeWorkPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHARTFDIDMZ0','5','D','10','42',NULL,'Section Code',NULL,NULL,'"~ERC~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHARTFDIDMZ0','30','D','10','43',NULL,'Supervisor Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHARTFDIDMZ0','30','D','10','44',NULL,'Supervisor First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHARTFDIDMZ0','20','D','10','45',NULL,'Supervisor ID',NULL,NULL,'"drvSupervisorID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHARTFDIDMZ0','10','D','10','46',NULL,'Supervisor Work Phone Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHARTFDIDMZ0','50','D','10','47',NULL,'Supervisor Email Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHARTFDIDMZ0','30','D','10','48',NULL,'HR Manager Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHARTFDIDMZ0','30','D','10','49',NULL,'HR Manager First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHARTFDIDMZ0','20','D','10','50',NULL,'HR Manager ID',NULL,NULL,'"drvHRManagerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHARTFDIDMZ0','10','D','10','51',NULL,'HR Manager Work Phone Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHARTFDIDMZ0','50','D','10','52',NULL,'HR Manager Email Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHARTFDIDMZ0','30','D','10','53',NULL,'ER Contact Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHARTFDIDMZ0','30','D','10','54',NULL,'ER Contact First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHARTFDIDMZ0','20','D','10','55',NULL,'ER ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHARTFDIDMZ0','50','D','10','56',NULL,'ER Contact Email Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHARTFDIDMZ0','5','D','10','57',NULL,'Section Code',NULL,NULL,'"~EMI~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHARTFDIDMZ0','1','D','10','58',NULL,'Employee Status Code',NULL,NULL,'"drvEmployeeStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHARTFDIDMZ0','8','D','10','59',NULL,'Employee Status Effective Date',NULL,NULL,'"drvEmployeeStatusEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHARTFDIDMZ0','8','D','10','60',NULL,'Employee Service Date',NULL,NULL,'"drvEmployeeServiceDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHARTFDIDMZ0','8','D','10','61',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHARTFDIDMZ0','8','D','10','62',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHARTFDIDMZ0','10','D','10','63',NULL,'Employee Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHARTFDIDMZ0','35','D','10','64',NULL,'Employee Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHARTFDIDMZ0','8','D','10','65',NULL,'Last Day Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHARTFDIDMZ0','2','D','10','66',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHARTFDIDMZ0','1','D','10','67',NULL,'Exempt/Non-Exempt',NULL,NULL,'"drvExemptNonExempt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHARTFDIDMZ0','4','D','10','68',NULL,'Scheduled Hours Per Week',NULL,NULL,'"drvScheduledHoursPerWeek"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHARTFDIDMZ0','9','D','10','69',NULL,'Benefit Salary Amount',NULL,NULL,'"drvBenefitSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHARTFDIDMZ0','1','D','10','70',NULL,'Salary Basis',NULL,NULL,'"Annual"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHARTFDIDMZ0','12','D','10','71',NULL,'Additional Salary Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHARTFDIDMZ0','2','D','10','72',NULL,'Additional Salary/Wage Basis',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHARTFDIDMZ0','8','D','10','73',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHARTFDIDMZ0','9','D','10','74',NULL,'Commission Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHARTFDIDMZ0','9','D','10','75',NULL,'Bonus',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHARTFDIDMZ0','1','D','10','76',NULL,'Payroll Basis',NULL,NULL,'"drvPayrollBasis"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHARTFDIDMZ0','4','D','10','77',NULL,'Pay Grade Level',NULL,NULL,'"drvPayGradeLevel"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHARTFDIDMZ0','2','D','10','78',NULL,'Pay Period Frequency',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHARTFDIDMZ0','8','D','10','79',NULL,'Pay Period Begin Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHARTFDIDMZ0','8','D','10','80',NULL,'Pay Period End Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHARTFDIDMZ0','25','D','10','81',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EHARTFDIDMZ0','1','D','10','82',NULL,'Job Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EHARTFDIDMZ0','10','D','10','83',NULL,'Payroll Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EHARTFDIDMZ0','10','D','10','84',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EHARTFDIDMZ0','10','D','10','85',NULL,'Department Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EHARTFDIDMZ0','10','D','10','86',NULL,'Division Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EHARTFDIDMZ0','10','D','10','87',NULL,'Location Code',NULL,NULL,'"drvLocDesc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EHARTFDIDMZ0','10','D','10','88',NULL,'Region Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EHARTFDIDMZ0','10','D','10','89',NULL,'Account Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EHARTFDIDMZ0','1','D','10','90',NULL,'Union Indicator',NULL,NULL,'"drvUnionIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EHARTFDIDMZ0','10','D','10','91',NULL,'Union Name',NULL,NULL,'"drvUnionName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EHARTFDIDMZ0','30','D','10','92',NULL,'Medical Carrier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EHARTFDIDMZ0','30','D','10','93',NULL,'Mental Health Carrier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EHARTFDIDMZ0','5','D','10','94',NULL,'Section Code',NULL,NULL,'"~CSF~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EHARTFDIDMZ0','30','D','10','95',NULL,'Client-Specific Field #1 Name',NULL,NULL,'"drvClientSpecificField1Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EHARTFDIDMZ0','30','D','10','96',NULL,'Client-Specific Field #1 Value',NULL,NULL,'"drvClientSpecificField1Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EHARTFDIDMZ0','30','D','10','97',NULL,'Client-Specific Field #2 Name',NULL,NULL,'"drvClientSpecificField2Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EHARTFDIDMZ0','30','D','10','98',NULL,'Client-Specific Field #2 Value',NULL,NULL,'"drvClientSpecificField2Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EHARTFDIDMZ0','30','D','10','99',NULL,'Client-Specific Field #3 Name',NULL,NULL,'"drvClientSpecificField3Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EHARTFDIDMZ0','30','D','10','100',NULL,'Client-Specific Field #3 Value',NULL,NULL,'"drvClientSpecificField3Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EHARTFDIDMZ0','30','D','10','101',NULL,'Client-Specific Field#4 Name',NULL,NULL,'"drvClientSpecificField4Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EHARTFDIDMZ0','30','D','10','102',NULL,'Client-Specific Field #4 Value',NULL,NULL,'"drvClientSpecificField4Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EHARTFDIDMZ0','30','D','10','103',NULL,'Client-Specific Field #5 Name',NULL,NULL,'"drvClientSpecificField5Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EHARTFDIDMZ0','30','D','10','104',NULL,'Client-Specific Field #5 Value',NULL,NULL,'"drvClientSpecificField5Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EHARTFDIDMZ0','30','D','10','105',NULL,'Client-Specific Field #6 Name',NULL,NULL,'"drvClientSpecificField6Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EHARTFDIDMZ0','30','D','10','106',NULL,'Client-Specific Field #6 Value',NULL,NULL,'"drvClientSpecificField6Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EHARTFDIDMZ0','30','D','10','107',NULL,'Client-Specific Field #7 Name',NULL,NULL,'"drvClientSpecificField7Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EHARTFDIDMZ0','30','D','10','108',NULL,'Client-Specific Field #7 Value',NULL,NULL,'"drvClientSpecificField7Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EHARTFDIDMZ0','30','D','10','109',NULL,'Client-Specific Field #8 Name',NULL,NULL,'"drvClientSpecificField8Name"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EHARTFDIDMZ0','30','D','10','110',NULL,'Client-Specific Field #8 Value',NULL,NULL,'"drvClientSpecificField8Value"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EHARTFDIDMZ0','5','D','10','111',NULL,'Section Code',NULL,NULL,'"~NST~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EHARTFDIDMZ0','8','D','10','112',NULL,'Coverage Effective Date',NULL,NULL,'"drvNSTCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EHARTFDIDMZ0','8','D','10','113',NULL,'Coverage Termination Date',NULL,NULL,'"drvNSTCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EHARTFDIDMZ0','9','D','10','114',NULL,'STD Covered Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EHARTFDIDMZ0','5','D','10','115',NULL,'STD Coverage Plan Option',NULL,NULL,'"drvSTDCoveragePlanOption"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EHARTFDIDMZ0','5','D','10','116',NULL,'STD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EHARTFDIDMZ0','7','D','10','117',NULL,'Plan Summary',NULL,NULL,'"drvNSTPlanSummary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EHARTFDIDMZ0','5','D','10','118',NULL,'Employee Group ID',NULL,NULL,'"drvNSTEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EHARTFDIDMZ0','3','D','10','119',NULL,'Employee Class Code',NULL,NULL,'"drvNSTEmployeeClass"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EHARTFDIDMZ0','5','D','10','120',NULL,'Section Code',NULL,NULL,'"~NSB~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EHARTFDIDMZ0','8','D','10','121',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EHARTFDIDMZ0','8','D','10','122',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EHARTFDIDMZ0','9','D','10','123',NULL,'STD Covered Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EHARTFDIDMZ0','5','D','10','124',NULL,'STD Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EHARTFDIDMZ0','5','D','10','125',NULL,'STD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EHARTFDIDMZ0','7','D','10','126',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EHARTFDIDMZ0','5','D','10','127',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EHARTFDIDMZ0','3','D','10','128',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EHARTFDIDMZ0','5','D','10','129',NULL,'Section Code',NULL,NULL,'"~STA~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EHARTFDIDMZ0','8','D','10','130',NULL,'Coverage Effective Date',NULL,NULL,'"drvSTACoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EHARTFDIDMZ0','8','D','10','131',NULL,'Coverage Termination Date',NULL,NULL,'"drvSTACoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EHARTFDIDMZ0','5','D','10','132',NULL,'Statutory Coverage Plan Option',NULL,NULL,'"drvSTAStatCvgPlanOption"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EHARTFDIDMZ0','5','D','10','133',NULL,'Statutory Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EHARTFDIDMZ0','7','D','10','134',NULL,'Plan Summary',NULL,NULL,'"drvSTAPlanSummary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EHARTFDIDMZ0','5','D','10','135',NULL,'Employee Group ID',NULL,NULL,'"drvSTAEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EHARTFDIDMZ0','3','D','10','136',NULL,'Employee Class Code',NULL,NULL,'"drvSTAEmplooyeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EHARTFDIDMZ0','5','D','10','137',NULL,'Section Code',NULL,NULL,'"~PFL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EHARTFDIDMZ0','2','D','10','138',NULL,'State PFL Enrolled',NULL,NULL,'"drvPFLStateEnrolled"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EHARTFDIDMZ0','8','D','10','139',NULL,'Coverage Effective Date',NULL,NULL,'"drvPFLCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EHARTFDIDMZ0','8','D','10','140',NULL,'Coverage Termination Date',NULL,NULL,'"drvPFLCoverageTermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EHARTFDIDMZ0','7','D','10','141',NULL,'Plan Summary',NULL,NULL,'"drvPFLPlanSummary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EHARTFDIDMZ0','5','D','10','142',NULL,'Employee Group ID',NULL,NULL,'"drvPFLEmployeeGroupId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EHARTFDIDMZ0','3','D','10','143',NULL,'Employee Class Code',NULL,NULL,'"drvPFLEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EHARTFDIDMZ0','5','D','10','144',NULL,'Section Code',NULL,NULL,'"~FLX~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EHARTFDIDMZ0','8','D','10','145',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EHARTFDIDMZ0','8','D','10','146',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EHARTFDIDMZ0','3','D','10','147',NULL,'DisabilityFLEX Benefit Commencement Period - Day I',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EHARTFDIDMZ0','3','D','10','148',NULL,'DisabilityFLEX Benefit Commencement Period - Day S',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EHARTFDIDMZ0','3','D','10','149',NULL,'DisabilityFLEX Benefit Duration',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EHARTFDIDMZ0','6','D','10','150',NULL,'DisabilityFLEX Benefit Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EHARTFDIDMZ0','7','D','10','151',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EHARTFDIDMZ0','5','D','10','152',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EHARTFDIDMZ0','3','D','10','153',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EHARTFDIDMZ0','5','D','10','154',NULL,'Section Code',NULL,NULL,'"~LTD~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EHARTFDIDMZ0','8','D','10','155',NULL,'Coverage Effective Date',NULL,NULL,'"drvLTDCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EHARTFDIDMZ0','8','D','10','156',NULL,'Coverage Termination Date',NULL,NULL,'"drvLTDCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EHARTFDIDMZ0','10','D','10','157',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EHARTFDIDMZ0','35','D','10','158',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EHARTFDIDMZ0','9','D','10','159',NULL,'LTD Covered Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EHARTFDIDMZ0','5','D','10','160',NULL,'LTD Coverage Plan Option',NULL,NULL,'"drvLTDCoveragePlanOption"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EHARTFDIDMZ0','5','D','10','161',NULL,'LTD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EHARTFDIDMZ0','7','D','10','162',NULL,'Plan Summary',NULL,NULL,'"drvLTDPlanSummary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EHARTFDIDMZ0','5','D','10','163',NULL,'Employee Group ID',NULL,NULL,'"drvLTDEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EHARTFDIDMZ0','3','D','10','164',NULL,'Employee Class Code',NULL,NULL,'"drvLTDEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EHARTFDIDMZ0','5','D','10','165',NULL,'Section Code',NULL,NULL,'"~LDB~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EHARTFDIDMZ0','8','D','10','166',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EHARTFDIDMZ0','8','D','10','167',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EHARTFDIDMZ0','10','D','10','168',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EHARTFDIDMZ0','35','D','10','169',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EHARTFDIDMZ0','9','D','10','170',NULL,'LTD Covered Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EHARTFDIDMZ0','5','D','10','171',NULL,'LTD Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EHARTFDIDMZ0','5','D','10','172',NULL,'LTD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EHARTFDIDMZ0','7','D','10','173',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EHARTFDIDMZ0','5','D','10','174',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EHARTFDIDMZ0','3','D','10','175',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EHARTFDIDMZ0','5','D','10','176',NULL,'Section Code',NULL,NULL,'"~RPL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EHARTFDIDMZ0','20','D','10','177',NULL,'Reporting Level 1',NULL,NULL,'"drvReportingLevel1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EHARTFDIDMZ0','20','D','10','178',NULL,'Reporting Level 2',NULL,NULL,'"drvReportingLevel2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EHARTFDIDMZ0','20','D','10','179',NULL,'Reporting Level 3',NULL,NULL,'"drvReportingLevel3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EHARTFDIDMZ0','20','D','10','180',NULL,'Reporting Level 4',NULL,NULL,'"drvReportingLevel4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EHARTFDIDMZ0','20','D','10','181',NULL,'Reporting Level 5',NULL,NULL,'"drvReportingLevel5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EHARTFDIDMZ0','20','D','10','182',NULL,'Reporting Level 6',NULL,NULL,'"drvReportingLevel6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EHARTFDIDMZ0','20','D','10','183',NULL,'Reporting Level 7',NULL,NULL,'"drvReportingLevel7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EHARTFDIDMZ0','20','D','10','184',NULL,'Reporting Level 8',NULL,NULL,'"drvReportingLevel8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EHARTFDIDMZ0','20','D','10','185',NULL,'Reporting Level 9',NULL,NULL,'"drvReportingLevel9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EHARTFDIDMZ0','20','D','10','186',NULL,'Reporting Level 10',NULL,NULL,'"drvReportingLevel10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EHARTFDIDMZ0','20','D','10','187',NULL,'Reporting Level 11',NULL,NULL,'"drvReportingLevel11"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EHARTFDIDMZ0','20','D','10','188',NULL,'Reporting Level 12',NULL,NULL,'"drvReportingLevel12"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EHARTFDIDMZ0','5','D','10','189',NULL,'Basic Life Plan',NULL,NULL,'"~BLF~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EHARTFDIDMZ0','8','D','10','190',NULL,'Coverage Effective Date',NULL,NULL,'"drvBLFCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EHARTFDIDMZ0','8','D','10','191',NULL,'Coverage Termination Date',NULL,NULL,'"drvBLFCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EHARTFDIDMZ0','10','D','10','192',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EHARTFDIDMZ0','35','D','10','193',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EHARTFDIDMZ0','3','D','10','194',NULL,'Basic Life Multiple of Salary Face Amount',NULL,NULL,'"drvBLFMultiple"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EHARTFDIDMZ0','11','D','10','195',NULL,'Basic Life Face Amount',NULL,NULL,'"drvBLFFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EHARTFDIDMZ0','3','D','10','196',NULL,'Basic Life Multiple of Salary Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EHARTFDIDMZ0','11','D','10','197',NULL,'Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EHARTFDIDMZ0','5','D','10','198',NULL,'Employee Group ID',NULL,NULL,'"drvBLFEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EHARTFDIDMZ0','3','D','10','199',NULL,'Employee Class Code',NULL,NULL,'"drvBLFEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EHARTFDIDMZ0','5','D','10','200',NULL,'Section Code',NULL,NULL,'"~BAD~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EHARTFDIDMZ0','8','D','10','201',NULL,'Coverage Effective Date',NULL,NULL,'"drvBADCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EHARTFDIDMZ0','8','D','10','202',NULL,'Coverage Termination Date',NULL,NULL,'"drvBADCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EHARTFDIDMZ0','10','D','10','203',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EHARTFDIDMZ0','35','D','10','204',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EHARTFDIDMZ0','11','D','10','205',NULL,'Basic AD&D Face Amount',NULL,NULL,'"drvBLFFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EHARTFDIDMZ0','11','D','10','206',NULL,'Basic AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EHARTFDIDMZ0','5','D','10','207',NULL,'Employee Group ID',NULL,NULL,'"drvBADEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EHARTFDIDMZ0','3','D','10','208',NULL,'Employee Class Code',NULL,NULL,'"drvBADEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EHARTFDIDMZ0','5','D','10','209',NULL,'Section Code',NULL,NULL,'"~LIF~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EHARTFDIDMZ0','8','D','10','210',NULL,'Coverage Effective Date',NULL,NULL,'"drvLIFCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EHARTFDIDMZ0','8','D','10','211',NULL,'Coverage Termination Date',NULL,NULL,'"drvLIFCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EHARTFDIDMZ0','10','D','10','212',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EHARTFDIDMZ0','35','D','10','213',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EHARTFDIDMZ0','3','D','10','214',NULL,'Supplemental Life Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EHARTFDIDMZ0','11','D','10','215',NULL,'Supplemental Life Face Amount',NULL,NULL,'"drvLIFFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EHARTFDIDMZ0','3','D','10','216',NULL,'Supplemental Life  Multiple of Salary Requested Am',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EHARTFDIDMZ0','11','D','10','217',NULL,'Supplemental Life Requested Amount',NULL,NULL,'"drvLIFReqAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EHARTFDIDMZ0','5','D','10','218',NULL,'Employee Group ID',NULL,NULL,'"drvLIFEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EHARTFDIDMZ0','3','D','10','219',NULL,'Employee Class Code',NULL,NULL,'"drvLIFEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EHARTFDIDMZ0','5','D','10','220',NULL,'Section Code',NULL,NULL,'"~ADD~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EHARTFDIDMZ0','8','D','10','221',NULL,'Coverage Effective Date',NULL,NULL,'"drvADDCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EHARTFDIDMZ0','8','D','10','222',NULL,'Coverage Termination Date',NULL,NULL,'"drvADDCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EHARTFDIDMZ0','10','D','10','223',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EHARTFDIDMZ0','35','D','10','224',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EHARTFDIDMZ0','3','D','10','225',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EHARTFDIDMZ0','11','D','10','226',NULL,'Supplemental AD&D Face Amount',NULL,NULL,'"drvADDFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EHARTFDIDMZ0','3','D','10','227',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EHARTFDIDMZ0','11','D','10','228',NULL,'Supplemental AD&D Requested Amount',NULL,NULL,'"drvADDReqAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EHARTFDIDMZ0','5','D','10','229',NULL,'Employee Group ID',NULL,NULL,'"drvADDEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EHARTFDIDMZ0','3','D','10','230',NULL,'Employee Class Code',NULL,NULL,'"drvADDEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EHARTFDIDMZ0','5','D','10','231',NULL,'Section Code',NULL,NULL,'"~BSD~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EHARTFDIDMZ0','8','D','10','232',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EHARTFDIDMZ0','8','D','10','233',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EHARTFDIDMZ0','10','D','10','234',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EHARTFDIDMZ0','35','D','10','235',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EHARTFDIDMZ0','3','D','10','236',NULL,'AD&D Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EHARTFDIDMZ0','11','D','10','237',NULL,'AD&D Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EHARTFDIDMZ0','3','D','10','238',NULL,'AD&D Multiple of Salary Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EHARTFDIDMZ0','11','D','10','239',NULL,'AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EHARTFDIDMZ0','1','D','10','240',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EHARTFDIDMZ0','5','D','10','241',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EHARTFDIDMZ0','3','D','10','242',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EHARTFDIDMZ0','5','D','10','243',NULL,'Section Code',NULL,NULL,'"~SSA~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EHARTFDIDMZ0','8','D','10','244',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EHARTFDIDMZ0','8','D','10','245',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EHARTFDIDMZ0','10','D','10','246',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EHARTFDIDMZ0','35','D','10','247',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EHARTFDIDMZ0','3','D','10','248',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EHARTFDIDMZ0','11','D','10','249',NULL,'Supplemental AD&D Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EHARTFDIDMZ0','3','D','10','250',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EHARTFDIDMZ0','11','D','10','251',NULL,'Supplemental AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EHARTFDIDMZ0','1','D','10','252',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EHARTFDIDMZ0','5','D','10','253',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EHARTFDIDMZ0','3','D','10','254',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','EHARTFDIDMZ0','5','D','10','255',NULL,'Section Code',NULL,NULL,'"~BSL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','EHARTFDIDMZ0','8','D','10','256',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','EHARTFDIDMZ0','8','D','10','257',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','EHARTFDIDMZ0','10','D','10','258',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','EHARTFDIDMZ0','35','D','10','259',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','EHARTFDIDMZ0','11','D','10','260',NULL,'Spouse Basic Life Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','EHARTFDIDMZ0','11','D','10','261',NULL,'Spouse Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','EHARTFDIDMZ0','5','D','10','262',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','EHARTFDIDMZ0','3','D','10','263',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','EHARTFDIDMZ0','5','D','10','264',NULL,'Section Code',NULL,NULL,'"~SPL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','EHARTFDIDMZ0','8','D','10','265',NULL,'Coverage Effective Date',NULL,NULL,'"drvSPLCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','EHARTFDIDMZ0','8','D','10','266',NULL,'Coverage Termination Date',NULL,NULL,'"drvSPLCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','EHARTFDIDMZ0','10','D','10','267',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','EHARTFDIDMZ0','35','D','10','268',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','EHARTFDIDMZ0','11','D','10','269',NULL,'Spouse Supplemental Life Face Amount',NULL,NULL,'"drvSPLFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','EHARTFDIDMZ0','11','D','10','270',NULL,'Spouse Supplemental Life Requested Amount',NULL,NULL,'"drvSPLReqAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','EHARTFDIDMZ0','5','D','10','271',NULL,'Employee Group ID',NULL,NULL,'"drvSPLEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','EHARTFDIDMZ0','3','D','10','272',NULL,'Employee Class',NULL,NULL,'"drvSPLEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','EHARTFDIDMZ0','5','D','10','273',NULL,'Section Code',NULL,NULL,'"~BDL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','EHARTFDIDMZ0','8','D','10','274',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','EHARTFDIDMZ0','8','D','10','275',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','EHARTFDIDMZ0','10','D','10','276',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','EHARTFDIDMZ0','35','D','10','277',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','EHARTFDIDMZ0','11','D','10','278',NULL,'Dependent/Child Basic Life Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','EHARTFDIDMZ0','11','D','10','279',NULL,'Dependent/Child Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','EHARTFDIDMZ0','5','D','10','280',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','EHARTFDIDMZ0','3','D','10','281',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','EHARTFDIDMZ0','5','D','10','282',NULL,'Section Code',NULL,NULL,'"~DPL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','EHARTFDIDMZ0','8','D','10','283',NULL,'Coverage Effective Date',NULL,NULL,'"drvDPLCoverageEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','EHARTFDIDMZ0','8','D','10','284',NULL,'Coverage Termination Date',NULL,NULL,'"drvDPLCoverageTerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','EHARTFDIDMZ0','10','D','10','285',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','EHARTFDIDMZ0','35','D','10','286',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','EHARTFDIDMZ0','11','D','10','287',NULL,'Dependent/Child Supplemental Life Face Amount',NULL,NULL,'"drvDPLFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','EHARTFDIDMZ0','11','D','10','288',NULL,'Dependent/Child Supplemental Life Requested Amount',NULL,NULL,'"drvDPLReqAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','EHARTFDIDMZ0','5','D','10','289',NULL,'Employee Group ID',NULL,NULL,'"drvDPLEmployeeGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','EHARTFDIDMZ0','3','D','10','290',NULL,'Employee Class',NULL,NULL,'"drvDPLEmployeeClassCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','EHARTFDIDMZ0','5','D','10','291',NULL,'Section Code',NULL,NULL,'"~BSA~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','EHARTFDIDMZ0','8','D','10','292',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','EHARTFDIDMZ0','8','D','10','293',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','EHARTFDIDMZ0','10','D','10','294',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','EHARTFDIDMZ0','35','D','10','295',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','EHARTFDIDMZ0','11','D','10','296',NULL,'Spouse Basic AD&D Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','EHARTFDIDMZ0','11','D','10','297',NULL,'Spouse Basic AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','EHARTFDIDMZ0','5','D','10','298',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','EHARTFDIDMZ0','3','D','10','299',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','EHARTFDIDMZ0','5','D','10','300',NULL,'Section Code',NULL,NULL,'"~SAD~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','EHARTFDIDMZ0','8','D','10','301',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','EHARTFDIDMZ0','8','D','10','302',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','EHARTFDIDMZ0','10','D','10','303',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','EHARTFDIDMZ0','35','D','10','304',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','EHARTFDIDMZ0','11','D','10','305',NULL,'Spouse Supplemental AD&D Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','EHARTFDIDMZ0','11','D','10','306',NULL,'Spouse Supplemental AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','EHARTFDIDMZ0','5','D','10','307',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','EHARTFDIDMZ0','3','D','10','308',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','EHARTFDIDMZ0','5','D','10','309',NULL,'Section Code',NULL,NULL,'"~BDA~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','EHARTFDIDMZ0','8','D','10','310',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','EHARTFDIDMZ0','8','D','10','311',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','EHARTFDIDMZ0','10','D','10','312',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','EHARTFDIDMZ0','35','D','10','313',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','EHARTFDIDMZ0','11','D','10','314',NULL,'Dependent/Child Basic AD&D Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','EHARTFDIDMZ0','11','D','10','315',NULL,'Dependent/Child Basic AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','EHARTFDIDMZ0','5','D','10','316',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','EHARTFDIDMZ0','3','D','10','317',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','EHARTFDIDMZ0','5','D','10','318',NULL,'Section Code',NULL,NULL,'"~DCA~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','EHARTFDIDMZ0','8','D','10','319',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','EHARTFDIDMZ0','8','D','10','320',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','EHARTFDIDMZ0','10','D','10','321',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','EHARTFDIDMZ0','35','D','10','322',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','EHARTFDIDMZ0','11','D','10','323',NULL,'Dependent/Child Supplemental AD&D Face Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','EHARTFDIDMZ0','11','D','10','324',NULL,'Dependent/Child Supplemental AD&D Requested Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','EHARTFDIDMZ0','5','D','10','325',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','EHARTFDIDMZ0','3','D','10','326',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','EHARTFDIDMZ0','5','D','10','327',NULL,'Section Code',NULL,NULL,'"~VCI~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','EHARTFDIDMZ0','8','D','10','328',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('329','EHARTFDIDMZ0','8','D','10','329',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('330','EHARTFDIDMZ0','10','D','10','330',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('331','EHARTFDIDMZ0','35','D','10','331',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('332','EHARTFDIDMZ0','11','D','10','332',NULL,'CI Benefit Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('333','EHARTFDIDMZ0','1','D','10','333',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('334','EHARTFDIDMZ0','3','D','10','334',NULL,'Plan Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('335','EHARTFDIDMZ0','5','D','10','335',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('336','EHARTFDIDMZ0','3','D','10','336',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('337','EHARTFDIDMZ0','5','D','10','337',NULL,'Section Code',NULL,NULL,'"~CIB~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('338','EHARTFDIDMZ0','8','D','10','338',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('339','EHARTFDIDMZ0','8','D','10','339',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('340','EHARTFDIDMZ0','10','D','10','340',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('341','EHARTFDIDMZ0','35','D','10','341',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('342','EHARTFDIDMZ0','11','D','10','342',NULL,'CI Buy-up Benefit Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('343','EHARTFDIDMZ0','1','D','10','343',NULL,'Buy-Up Coverage Tier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('344','EHARTFDIDMZ0','3','D','10','344',NULL,'Plan Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('345','EHARTFDIDMZ0','5','D','10','345',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('346','EHARTFDIDMZ0','3','D','10','346',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('347','EHARTFDIDMZ0','5','D','10','347',NULL,'Section Code',NULL,NULL,'"~VAC~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('348','EHARTFDIDMZ0','8','D','10','348',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('349','EHARTFDIDMZ0','8','D','10','349',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('350','EHARTFDIDMZ0','10','D','10','350',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('351','EHARTFDIDMZ0','35','D','10','351',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('352','EHARTFDIDMZ0','1','D','10','352',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('353','EHARTFDIDMZ0','50','D','10','353',NULL,'Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('354','EHARTFDIDMZ0','3','D','10','354',NULL,'Plan Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('355','EHARTFDIDMZ0','5','D','10','355',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('356','EHARTFDIDMZ0','3','D','10','356',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('357','EHARTFDIDMZ0','5','D','10','357',NULL,'Section Code',NULL,NULL,'"~HIP~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('358','EHARTFDIDMZ0','8','D','10','358',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('359','EHARTFDIDMZ0','8','D','10','359',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('360','EHARTFDIDMZ0','10','D','10','360',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('361','EHARTFDIDMZ0','35','D','10','361',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('362','EHARTFDIDMZ0','1','D','10','362',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('363','EHARTFDIDMZ0','50','D','10','363',NULL,'Plan Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('364','EHARTFDIDMZ0','3','D','10','364',NULL,'Plan Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('365','EHARTFDIDMZ0','5','D','10','365',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('366','EHARTFDIDMZ0','3','D','10','366',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('367','EHARTFDIDMZ0','5','D','10','367',NULL,'Section Code',NULL,NULL,'"~LMS~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('368','EHARTFDIDMZ0','1','D','10','368',NULL,'Leave Management Services Indicator',NULL,NULL,'"drvLMS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('369','EHARTFDIDMZ0','1','D','10','369',NULL,'Employee Covered by FML 50/75 Rule',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('370','EHARTFDIDMZ0','1','D','10','370',NULL,'Key Employee Indicator',NULL,NULL,'"drvKeyEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('371','EHARTFDIDMZ0','1','D','10','371',NULL,'Forced Eligibility',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('372','EHARTFDIDMZ0','5','D','10','372',NULL,'Leave Management Option',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('373','EHARTFDIDMZ0','6','D','10','373',NULL,'Last 12 Months Hours',NULL,NULL,'"drvLast12MonthsHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('374','EHARTFDIDMZ0','6','D','10','374',NULL,'Last 12 Months Paid Hours',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('375','EHARTFDIDMZ0','7','D','10','375',NULL,'Actual Hours Worked',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('376','EHARTFDIDMZ0','4','D','10','376',NULL,'Usage Time',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('377','EHARTFDIDMZ0','4','D','10','377',NULL,'Regulation Period Basis',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('378','EHARTFDIDMZ0','8','D','10','378',NULL,'Cumulative Hours End Date',NULL,NULL,'"drvCumulativeHoursEndDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('379','EHARTFDIDMZ0','2','D','10','379',NULL,'Cumulative Hours Number of Weeks',NULL,NULL,'"drvCumulativeHoursNumOfWeeks"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('380','EHARTFDIDMZ0','4','D','10','380',NULL,'Sick Leave Hours Remaining',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('381','EHARTFDIDMZ0','4','D','10','381',NULL,'Vacation Hours Remaining',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('382','EHARTFDIDMZ0','3','D','10','382',NULL,'Work Schedule Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('383','EHARTFDIDMZ0','8','D','10','383',NULL,'Work Schedule From Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('384','EHARTFDIDMZ0','4','D','10','384',NULL,'Work schedule - Hours Monday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('385','EHARTFDIDMZ0','4','D','10','385',NULL,'Work Schedule - Hours Tuesday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('386','EHARTFDIDMZ0','4','D','10','386',NULL,'Work Schedule - Hours Wednesday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('387','EHARTFDIDMZ0','4','D','10','387',NULL,'Work Schedule - Hours Thursday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('388','EHARTFDIDMZ0','4','D','10','388',NULL,'Work Schedule - Hours Friday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('389','EHARTFDIDMZ0','4','D','10','389',NULL,'Work Schedule - Hours Saturday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('390','EHARTFDIDMZ0','4','D','10','390',NULL,'Work Schedule - Hours Sunday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('391','EHARTFDIDMZ0','4','D','10','391',NULL,'Number of Days in Repeating Work Schedule',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('392','EHARTFDIDMZ0','4','D','10','392',NULL,'Repeating Schedule - Day 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('393','EHARTFDIDMZ0','4','D','10','393',NULL,'Repeating Schedule - Day 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('394','EHARTFDIDMZ0','4','D','10','394',NULL,'Repeating Schedule - Day 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('395','EHARTFDIDMZ0','4','D','10','395',NULL,'Repeating Schedule - Day 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('396','EHARTFDIDMZ0','4','D','10','396',NULL,'Repeating Schedule - Day 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('397','EHARTFDIDMZ0','4','D','10','397',NULL,'Repeating Schedule - Day 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('398','EHARTFDIDMZ0','4','D','10','398',NULL,'Repeating Schedule - Day 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('399','EHARTFDIDMZ0','4','D','10','399',NULL,'Repeating Schedule - Day 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('400','EHARTFDIDMZ0','4','D','10','400',NULL,'Repeating Schedule - Day 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('401','EHARTFDIDMZ0','4','D','10','401',NULL,'Repeating Schedule - Day 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('402','EHARTFDIDMZ0','4','D','10','402',NULL,'Repeating Schedule - Day 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('403','EHARTFDIDMZ0','4','D','10','403',NULL,'Repeating Schedule - Day 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('404','EHARTFDIDMZ0','4','D','10','404',NULL,'Repeating Schedule - Day 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('405','EHARTFDIDMZ0','4','D','10','405',NULL,'Repeating Schedule - Day 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('406','EHARTFDIDMZ0','4','D','10','406',NULL,'Repeating Schedule - Day 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('407','EHARTFDIDMZ0','4','D','10','407',NULL,'Repeating Schedule - Day 16',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('408','EHARTFDIDMZ0','4','D','10','408',NULL,'Repeating Schedule - Day 17',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('409','EHARTFDIDMZ0','4','D','10','409',NULL,'Repeating Schedule - Day 18',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('410','EHARTFDIDMZ0','4','D','10','410',NULL,'Repeating Schedule - Day 19',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('411','EHARTFDIDMZ0','4','D','10','411',NULL,'Repeating Schedule - Day 20',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('412','EHARTFDIDMZ0','4','D','10','412',NULL,'Repeating Schedule - Day 21',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('413','EHARTFDIDMZ0','4','D','10','413',NULL,'Repeating Schedule - Day 22',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('414','EHARTFDIDMZ0','4','D','10','414',NULL,'Repeating Schedule - Day 23',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('415','EHARTFDIDMZ0','4','D','10','415',NULL,'Repeating Schedule - Day 24',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('416','EHARTFDIDMZ0','4','D','10','416',NULL,'Repeating Schedule - Day 25',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('417','EHARTFDIDMZ0','4','D','10','417',NULL,'Repeating Schedule - Day 26',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('418','EHARTFDIDMZ0','4','D','10','418',NULL,'Repeating Schedule - Day 27',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('419','EHARTFDIDMZ0','4','D','10','419',NULL,'Repeating Schedule - Day 28',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('420','EHARTFDIDMZ0','4','D','10','420',NULL,'Repeating Schedule - Day 29',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('421','EHARTFDIDMZ0','4','D','10','421',NULL,'Repeating Schedule - Day 30',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('422','EHARTFDIDMZ0','4','D','10','422',NULL,'Repeating Schedule - Day 31',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('423','EHARTFDIDMZ0','4','D','10','423',NULL,'Repeating Schedule - Day 32',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('424','EHARTFDIDMZ0','4','D','10','424',NULL,'Repeating Schedule - Day 33',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('425','EHARTFDIDMZ0','4','D','10','425',NULL,'Repeating Schedule - Day 34',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('426','EHARTFDIDMZ0','4','D','10','426',NULL,'Repeating Schedule - Day 35',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('427','EHARTFDIDMZ0','4','D','10','427',NULL,'Repeating Schedule - Day 36',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('428','EHARTFDIDMZ0','4','D','10','428',NULL,'Repeating Schedule - Day 37',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('429','EHARTFDIDMZ0','4','D','10','429',NULL,'Repeating Schedule - Day 38',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('430','EHARTFDIDMZ0','4','D','10','430',NULL,'Repeating Schedule - Day 39',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('431','EHARTFDIDMZ0','4','D','10','431',NULL,'Repeating Schedule - Day 40',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('432','EHARTFDIDMZ0','4','D','10','432',NULL,'Repeating Schedule - Day 41',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('433','EHARTFDIDMZ0','4','D','10','433',NULL,'Repeating Schedule - Day 42',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('434','EHARTFDIDMZ0','4','D','10','434',NULL,'Repeating Schedule - Day 43',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('435','EHARTFDIDMZ0','4','D','10','435',NULL,'Repeating Schedule - Day 44',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('436','EHARTFDIDMZ0','4','D','10','436',NULL,'Repeating Schedule - Day 45',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('437','EHARTFDIDMZ0','4','D','10','437',NULL,'Repeating Schedule - Day 46',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('438','EHARTFDIDMZ0','4','D','10','438',NULL,'Repeating Schedule - Day 47',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('439','EHARTFDIDMZ0','4','D','10','439',NULL,'Repeating Schedule - Day 48',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('440','EHARTFDIDMZ0','4','D','10','440',NULL,'Repeating Schedule - Day 49',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('441','EHARTFDIDMZ0','4','D','10','441',NULL,'Repeating Schedule - Day 50',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('442','EHARTFDIDMZ0','4','D','10','442',NULL,'Repeating Schedule - Day 51',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('443','EHARTFDIDMZ0','4','D','10','443',NULL,'Repeating Schedule - Day 52',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('444','EHARTFDIDMZ0','4','D','10','444',NULL,'Repeating Schedule - Day 53',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('445','EHARTFDIDMZ0','4','D','10','445',NULL,'Repeating Schedule - Day 54',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('446','EHARTFDIDMZ0','4','D','10','446',NULL,'Repeating Schedule - Day 55',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('447','EHARTFDIDMZ0','4','D','10','447',NULL,'Repeating Schedule - Day 56',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('448','EHARTFDIDMZ0','4','D','10','448',NULL,'Repeating Schedule - Day 57',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('449','EHARTFDIDMZ0','4','D','10','449',NULL,'Repeating Schedule - Day 58',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('450','EHARTFDIDMZ0','4','D','10','450',NULL,'Repeating Schedule - Day 59',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('451','EHARTFDIDMZ0','4','D','10','451',NULL,'Repeating Schedule - Day 60',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('452','EHARTFDIDMZ0','2','D','10','452',NULL,'Flight Crew',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('453','EHARTFDIDMZ0','1','D','10','453',NULL,'FMLA Radius',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('454','EHARTFDIDMZ0','5','D','10','454',NULL,'Section Code',NULL,NULL,'"~ROL~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('455','EHARTFDIDMZ0','50','D','10','455',NULL,'Reporting Level 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('456','EHARTFDIDMZ0','50','D','10','456',NULL,'Reporting Level 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('457','EHARTFDIDMZ0','50','D','10','457',NULL,'Reporting Level 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('458','EHARTFDIDMZ0','50','D','10','458',NULL,'Reporting Level 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('459','EHARTFDIDMZ0','50','D','10','459',NULL,'Reporting Level 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('460','EHARTFDIDMZ0','50','D','10','460',NULL,'Reporting Level 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('461','EHARTFDIDMZ0','50','D','10','461',NULL,'Reporting Level 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('462','EHARTFDIDMZ0','50','D','10','462',NULL,'Reporting Level 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('463','EHARTFDIDMZ0','50','D','10','463',NULL,'Reporting Level 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('464','EHARTFDIDMZ0','50','D','10','464',NULL,'Reporting Level 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('465','EHARTFDIDMZ0','50','D','10','465',NULL,'Reporting Level 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('466','EHARTFDIDMZ0','50','D','10','466',NULL,'Reporting Level 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('467','EHARTFDIDMZ0','5','D','10','467',NULL,'Section Code',NULL,NULL,'"~BEN~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('468','EHARTFDIDMZ0','30','D','10','468',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('469','EHARTFDIDMZ0','30','D','10','469',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('470','EHARTFDIDMZ0','9','D','10','470',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('471','EHARTFDIDMZ0','60','D','10','471',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('472','EHARTFDIDMZ0','9','D','10','472',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('473','EHARTFDIDMZ0','8','D','10','473',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('474','EHARTFDIDMZ0','40','D','10','474',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('475','EHARTFDIDMZ0','40','D','10','475',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('476','EHARTFDIDMZ0','30','D','10','476',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('477','EHARTFDIDMZ0','2','D','10','477',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('478','EHARTFDIDMZ0','10','D','10','478',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('479','EHARTFDIDMZ0','2','D','10','479',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('480','EHARTFDIDMZ0','3','D','10','480',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('481','EHARTFDIDMZ0','3','D','10','481',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('482','EHARTFDIDMZ0','1','D','10','482',NULL,'Beneficiary Type Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('483','EHARTFDIDMZ0','8','D','10','483',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('484','EHARTFDIDMZ0','30','D','10','484',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('485','EHARTFDIDMZ0','30','D','10','485',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('486','EHARTFDIDMZ0','9','D','10','486',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('487','EHARTFDIDMZ0','60','D','10','487',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('488','EHARTFDIDMZ0','9','D','10','488',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('489','EHARTFDIDMZ0','8','D','10','489',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('490','EHARTFDIDMZ0','40','D','10','490',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('491','EHARTFDIDMZ0','40','D','10','491',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('492','EHARTFDIDMZ0','30','D','10','492',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('493','EHARTFDIDMZ0','2','D','10','493',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('494','EHARTFDIDMZ0','10','D','10','494',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('495','EHARTFDIDMZ0','2','D','10','495',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('496','EHARTFDIDMZ0','3','D','10','496',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('497','EHARTFDIDMZ0','3','D','10','497',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('498','EHARTFDIDMZ0','1','D','10','498',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('499','EHARTFDIDMZ0','8','D','10','499',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('500','EHARTFDIDMZ0','30','D','10','500',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('501','EHARTFDIDMZ0','30','D','10','501',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('502','EHARTFDIDMZ0','9','D','10','502',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('503','EHARTFDIDMZ0','60','D','10','503',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('504','EHARTFDIDMZ0','9','D','10','504',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('505','EHARTFDIDMZ0','8','D','10','505',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('506','EHARTFDIDMZ0','40','D','10','506',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('507','EHARTFDIDMZ0','40','D','10','507',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('508','EHARTFDIDMZ0','30','D','10','508',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('509','EHARTFDIDMZ0','2','D','10','509',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('510','EHARTFDIDMZ0','10','D','10','510',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('511','EHARTFDIDMZ0','2','D','10','511',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('512','EHARTFDIDMZ0','3','D','10','512',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('513','EHARTFDIDMZ0','3','D','10','513',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('514','EHARTFDIDMZ0','1','D','10','514',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('515','EHARTFDIDMZ0','8','D','10','515',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('516','EHARTFDIDMZ0','30','D','10','516',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('517','EHARTFDIDMZ0','30','D','10','517',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('518','EHARTFDIDMZ0','9','D','10','518',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('519','EHARTFDIDMZ0','60','D','10','519',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('520','EHARTFDIDMZ0','9','D','10','520',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('521','EHARTFDIDMZ0','8','D','10','521',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('522','EHARTFDIDMZ0','40','D','10','522',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('523','EHARTFDIDMZ0','40','D','10','523',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('524','EHARTFDIDMZ0','30','D','10','524',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('525','EHARTFDIDMZ0','2','D','10','525',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('526','EHARTFDIDMZ0','10','D','10','526',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('527','EHARTFDIDMZ0','2','D','10','527',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('528','EHARTFDIDMZ0','3','D','10','528',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('529','EHARTFDIDMZ0','3','D','10','529',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('530','EHARTFDIDMZ0','1','D','10','530',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('531','EHARTFDIDMZ0','8','D','10','531',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('532','EHARTFDIDMZ0','30','D','10','532',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('533','EHARTFDIDMZ0','30','D','10','533',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('534','EHARTFDIDMZ0','9','D','10','534',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('535','EHARTFDIDMZ0','60','D','10','535',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('536','EHARTFDIDMZ0','9','D','10','536',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('537','EHARTFDIDMZ0','8','D','10','537',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('538','EHARTFDIDMZ0','40','D','10','538',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('539','EHARTFDIDMZ0','40','D','10','539',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('540','EHARTFDIDMZ0','30','D','10','540',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('541','EHARTFDIDMZ0','2','D','10','541',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('542','EHARTFDIDMZ0','10','D','10','542',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('543','EHARTFDIDMZ0','2','D','10','543',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('544','EHARTFDIDMZ0','3','D','10','544',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('545','EHARTFDIDMZ0','3','D','10','545',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('546','EHARTFDIDMZ0','1','D','10','546',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('547','EHARTFDIDMZ0','8','D','10','547',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('548','EHARTFDIDMZ0','30','D','10','548',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('549','EHARTFDIDMZ0','30','D','10','549',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('550','EHARTFDIDMZ0','9','D','10','550',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('551','EHARTFDIDMZ0','60','D','10','551',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('552','EHARTFDIDMZ0','9','D','10','552',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('553','EHARTFDIDMZ0','8','D','10','553',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('554','EHARTFDIDMZ0','40','D','10','554',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('555','EHARTFDIDMZ0','40','D','10','555',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('556','EHARTFDIDMZ0','30','D','10','556',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('557','EHARTFDIDMZ0','2','D','10','557',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('558','EHARTFDIDMZ0','10','D','10','558',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('559','EHARTFDIDMZ0','2','D','10','559',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('560','EHARTFDIDMZ0','3','D','10','560',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('561','EHARTFDIDMZ0','3','D','10','561',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('562','EHARTFDIDMZ0','1','D','10','562',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('563','EHARTFDIDMZ0','8','D','10','563',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('564','EHARTFDIDMZ0','30','D','10','564',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('565','EHARTFDIDMZ0','30','D','10','565',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('566','EHARTFDIDMZ0','9','D','10','566',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('567','EHARTFDIDMZ0','60','D','10','567',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('568','EHARTFDIDMZ0','9','D','10','568',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('569','EHARTFDIDMZ0','8','D','10','569',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('570','EHARTFDIDMZ0','40','D','10','570',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('571','EHARTFDIDMZ0','40','D','10','571',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('572','EHARTFDIDMZ0','30','D','10','572',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('573','EHARTFDIDMZ0','2','D','10','573',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('574','EHARTFDIDMZ0','10','D','10','574',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('575','EHARTFDIDMZ0','2','D','10','575',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('576','EHARTFDIDMZ0','3','D','10','576',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('577','EHARTFDIDMZ0','3','D','10','577',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('578','EHARTFDIDMZ0','1','D','10','578',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('579','EHARTFDIDMZ0','8','D','10','579',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('580','EHARTFDIDMZ0','30','D','10','580',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('581','EHARTFDIDMZ0','30','D','10','581',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('582','EHARTFDIDMZ0','9','D','10','582',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('583','EHARTFDIDMZ0','60','D','10','583',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('584','EHARTFDIDMZ0','9','D','10','584',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('585','EHARTFDIDMZ0','8','D','10','585',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('586','EHARTFDIDMZ0','40','D','10','586',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('587','EHARTFDIDMZ0','40','D','10','587',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('588','EHARTFDIDMZ0','30','D','10','588',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('589','EHARTFDIDMZ0','2','D','10','589',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('590','EHARTFDIDMZ0','10','D','10','590',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('591','EHARTFDIDMZ0','2','D','10','591',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('592','EHARTFDIDMZ0','3','D','10','592',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('593','EHARTFDIDMZ0','3','D','10','593',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('594','EHARTFDIDMZ0','1','D','10','594',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('595','EHARTFDIDMZ0','8','D','10','595',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('596','EHARTFDIDMZ0','30','D','10','596',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('597','EHARTFDIDMZ0','30','D','10','597',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('598','EHARTFDIDMZ0','9','D','10','598',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('599','EHARTFDIDMZ0','60','D','10','599',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('600','EHARTFDIDMZ0','9','D','10','600',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('601','EHARTFDIDMZ0','8','D','10','601',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHARTFDIDMZ0','40','D','20','1',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHARTFDIDMZ0','40','D','20','2',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHARTFDIDMZ0','30','D','20','3',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHARTFDIDMZ0','2','D','20','4',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHARTFDIDMZ0','10','D','20','5',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHARTFDIDMZ0','2','D','20','6',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHARTFDIDMZ0','3','D','20','7',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHARTFDIDMZ0','3','D','20','8',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHARTFDIDMZ0','1','D','20','9',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHARTFDIDMZ0','8','D','20','10',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHARTFDIDMZ0','30','D','20','11',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHARTFDIDMZ0','30','D','20','12',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHARTFDIDMZ0','9','D','20','13',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHARTFDIDMZ0','60','D','20','14',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHARTFDIDMZ0','9','D','20','15',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHARTFDIDMZ0','8','D','20','16',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHARTFDIDMZ0','40','D','20','17',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHARTFDIDMZ0','40','D','20','18',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHARTFDIDMZ0','30','D','20','19',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHARTFDIDMZ0','2','D','20','20',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHARTFDIDMZ0','10','D','20','21',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHARTFDIDMZ0','2','D','20','22',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHARTFDIDMZ0','3','D','20','23',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHARTFDIDMZ0','3','D','20','24',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHARTFDIDMZ0','1','D','20','25',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHARTFDIDMZ0','8','D','20','26',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHARTFDIDMZ0','30','D','20','27',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHARTFDIDMZ0','30','D','20','28',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHARTFDIDMZ0','9','D','20','29',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHARTFDIDMZ0','60','D','20','30',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHARTFDIDMZ0','9','D','20','31',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHARTFDIDMZ0','8','D','20','32',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHARTFDIDMZ0','40','D','20','33',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHARTFDIDMZ0','40','D','20','34',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHARTFDIDMZ0','30','D','20','35',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHARTFDIDMZ0','2','D','20','36',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHARTFDIDMZ0','10','D','20','37',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHARTFDIDMZ0','2','D','20','38',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHARTFDIDMZ0','3','D','20','39',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHARTFDIDMZ0','3','D','20','40',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHARTFDIDMZ0','1','D','20','41',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHARTFDIDMZ0','8','D','20','42',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHARTFDIDMZ0','30','D','20','43',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHARTFDIDMZ0','30','D','20','44',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHARTFDIDMZ0','9','D','20','45',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHARTFDIDMZ0','60','D','20','46',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHARTFDIDMZ0','9','D','20','47',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHARTFDIDMZ0','8','D','20','48',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHARTFDIDMZ0','40','D','20','49',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHARTFDIDMZ0','40','D','20','50',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHARTFDIDMZ0','30','D','20','51',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHARTFDIDMZ0','2','D','20','52',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHARTFDIDMZ0','10','D','20','53',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHARTFDIDMZ0','2','D','20','54',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHARTFDIDMZ0','3','D','20','55',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHARTFDIDMZ0','3','D','20','56',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHARTFDIDMZ0','1','D','20','57',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHARTFDIDMZ0','8','D','20','58',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHARTFDIDMZ0','30','D','20','59',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHARTFDIDMZ0','30','D','20','60',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHARTFDIDMZ0','9','D','20','61',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHARTFDIDMZ0','60','D','20','62',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHARTFDIDMZ0','9','D','20','63',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHARTFDIDMZ0','8','D','20','64',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHARTFDIDMZ0','40','D','20','65',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHARTFDIDMZ0','40','D','20','66',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHARTFDIDMZ0','30','D','20','67',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHARTFDIDMZ0','2','D','20','68',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHARTFDIDMZ0','10','D','20','69',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHARTFDIDMZ0','2','D','20','70',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHARTFDIDMZ0','3','D','20','71',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EHARTFDIDMZ0','3','D','20','72',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EHARTFDIDMZ0','1','D','20','73',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EHARTFDIDMZ0','8','D','20','74',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EHARTFDIDMZ0','30','D','20','75',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EHARTFDIDMZ0','30','D','20','76',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EHARTFDIDMZ0','9','D','20','77',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EHARTFDIDMZ0','60','D','20','78',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EHARTFDIDMZ0','9','D','20','79',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EHARTFDIDMZ0','8','D','20','80',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EHARTFDIDMZ0','40','D','20','81',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EHARTFDIDMZ0','40','D','20','82',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EHARTFDIDMZ0','30','D','20','83',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EHARTFDIDMZ0','2','D','20','84',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EHARTFDIDMZ0','10','D','20','85',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EHARTFDIDMZ0','2','D','20','86',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EHARTFDIDMZ0','3','D','20','87',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EHARTFDIDMZ0','3','D','20','88',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EHARTFDIDMZ0','1','D','20','89',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EHARTFDIDMZ0','8','D','20','90',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EHARTFDIDMZ0','30','D','20','91',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EHARTFDIDMZ0','30','D','20','92',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EHARTFDIDMZ0','9','D','20','93',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EHARTFDIDMZ0','60','D','20','94',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EHARTFDIDMZ0','9','D','20','95',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EHARTFDIDMZ0','8','D','20','96',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EHARTFDIDMZ0','40','D','20','97',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EHARTFDIDMZ0','40','D','20','98',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EHARTFDIDMZ0','30','D','20','99',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EHARTFDIDMZ0','2','D','20','100',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EHARTFDIDMZ0','10','D','20','101',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EHARTFDIDMZ0','2','D','20','102',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EHARTFDIDMZ0','3','D','20','103',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EHARTFDIDMZ0','3','D','20','104',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EHARTFDIDMZ0','1','D','20','105',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EHARTFDIDMZ0','8','D','20','106',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EHARTFDIDMZ0','30','D','20','107',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EHARTFDIDMZ0','30','D','20','108',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EHARTFDIDMZ0','9','D','20','109',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EHARTFDIDMZ0','60','D','20','110',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EHARTFDIDMZ0','9','D','20','111',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EHARTFDIDMZ0','8','D','20','112',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EHARTFDIDMZ0','40','D','20','113',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EHARTFDIDMZ0','40','D','20','114',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EHARTFDIDMZ0','30','D','20','115',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EHARTFDIDMZ0','2','D','20','116',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EHARTFDIDMZ0','10','D','20','117',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EHARTFDIDMZ0','2','D','20','118',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EHARTFDIDMZ0','3','D','20','119',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EHARTFDIDMZ0','3','D','20','120',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EHARTFDIDMZ0','1','D','20','121',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EHARTFDIDMZ0','8','D','20','122',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EHARTFDIDMZ0','30','D','20','123',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EHARTFDIDMZ0','30','D','20','124',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EHARTFDIDMZ0','9','D','20','125',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EHARTFDIDMZ0','60','D','20','126',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EHARTFDIDMZ0','9','D','20','127',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EHARTFDIDMZ0','8','D','20','128',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EHARTFDIDMZ0','40','D','20','129',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EHARTFDIDMZ0','40','D','20','130',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EHARTFDIDMZ0','30','D','20','131',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EHARTFDIDMZ0','2','D','20','132',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EHARTFDIDMZ0','10','D','20','133',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EHARTFDIDMZ0','2','D','20','134',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EHARTFDIDMZ0','3','D','20','135',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EHARTFDIDMZ0','3','D','20','136',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EHARTFDIDMZ0','1','D','20','137',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EHARTFDIDMZ0','8','D','20','138',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EHARTFDIDMZ0','30','D','20','139',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EHARTFDIDMZ0','30','D','20','140',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EHARTFDIDMZ0','9','D','20','141',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EHARTFDIDMZ0','60','D','20','142',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EHARTFDIDMZ0','9','D','20','143',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EHARTFDIDMZ0','8','D','20','144',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EHARTFDIDMZ0','40','D','20','145',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EHARTFDIDMZ0','40','D','20','146',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EHARTFDIDMZ0','30','D','20','147',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EHARTFDIDMZ0','2','D','20','148',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EHARTFDIDMZ0','10','D','20','149',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EHARTFDIDMZ0','2','D','20','150',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EHARTFDIDMZ0','3','D','20','151',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EHARTFDIDMZ0','3','D','20','152',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EHARTFDIDMZ0','1','D','20','153',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EHARTFDIDMZ0','8','D','20','154',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EHARTFDIDMZ0','30','D','20','155',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EHARTFDIDMZ0','30','D','20','156',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EHARTFDIDMZ0','9','D','20','157',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EHARTFDIDMZ0','60','D','20','158',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EHARTFDIDMZ0','9','D','20','159',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EHARTFDIDMZ0','8','D','20','160',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EHARTFDIDMZ0','40','D','20','161',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EHARTFDIDMZ0','40','D','20','162',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EHARTFDIDMZ0','30','D','20','163',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EHARTFDIDMZ0','2','D','20','164',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EHARTFDIDMZ0','10','D','20','165',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EHARTFDIDMZ0','2','D','20','166',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EHARTFDIDMZ0','3','D','20','167',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EHARTFDIDMZ0','3','D','20','168',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EHARTFDIDMZ0','1','D','20','169',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EHARTFDIDMZ0','8','D','20','170',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EHARTFDIDMZ0','30','D','20','171',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EHARTFDIDMZ0','30','D','20','172',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EHARTFDIDMZ0','9','D','20','173',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EHARTFDIDMZ0','60','D','20','174',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EHARTFDIDMZ0','9','D','20','175',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EHARTFDIDMZ0','8','D','20','176',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EHARTFDIDMZ0','40','D','20','177',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EHARTFDIDMZ0','40','D','20','178',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EHARTFDIDMZ0','30','D','20','179',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EHARTFDIDMZ0','2','D','20','180',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EHARTFDIDMZ0','10','D','20','181',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EHARTFDIDMZ0','2','D','20','182',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EHARTFDIDMZ0','3','D','20','183',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EHARTFDIDMZ0','3','D','20','184',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EHARTFDIDMZ0','1','D','20','185',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EHARTFDIDMZ0','8','D','20','186',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EHARTFDIDMZ0','5','D','20','187',NULL,'Section Code',NULL,NULL,'"~DED~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EHARTFDIDMZ0','10','D','20','188',NULL,'Benefit Deduct Type 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EHARTFDIDMZ0','6','D','20','189',NULL,'Benefit Deduct Amt 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EHARTFDIDMZ0','8','D','20','190',NULL,'Benefit Deduct Eff Date 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EHARTFDIDMZ0','8','D','20','191',NULL,'Benefit Deduct End Date1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EHARTFDIDMZ0','1','D','20','192',NULL,'Benefit Deduct Pre/Post 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EHARTFDIDMZ0','1','D','20','193',NULL,'Benefit Deduct Basis 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EHARTFDIDMZ0','2','D','20','194',NULL,'Benefit Deduct Order 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EHARTFDIDMZ0','10','D','20','195',NULL,'Benefit Deduct Type 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EHARTFDIDMZ0','6','D','20','196',NULL,'Benefit Deduct Amt 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EHARTFDIDMZ0','8','D','20','197',NULL,'Benefit Deduct Eff Date 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EHARTFDIDMZ0','8','D','20','198',NULL,'Benefit Deduct End Date 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EHARTFDIDMZ0','1','D','20','199',NULL,'Benefit Deduct Pre/Post 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EHARTFDIDMZ0','1','D','20','200',NULL,'Benefit Deduct Basis 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EHARTFDIDMZ0','2','D','20','201',NULL,'Benefit Deduct Order 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EHARTFDIDMZ0','10','D','20','202',NULL,'Benefit Deduct Type 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EHARTFDIDMZ0','6','D','20','203',NULL,'Benefit Deduct Amt 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EHARTFDIDMZ0','8','D','20','204',NULL,'Benefit Deduct Eff Date 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EHARTFDIDMZ0','8','D','20','205',NULL,'Benefit Deduct End Date3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EHARTFDIDMZ0','1','D','20','206',NULL,'Benefit Deduct Pre/Post 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EHARTFDIDMZ0','1','D','20','207',NULL,'Benefit Deduct Basis 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EHARTFDIDMZ0','2','D','20','208',NULL,'Benefit Deduct Order 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EHARTFDIDMZ0','10','D','20','209',NULL,'Benefit Deduct Type 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EHARTFDIDMZ0','6','D','20','210',NULL,'Benefit Deduct Amt 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EHARTFDIDMZ0','8','D','20','211',NULL,'Benefit Deduct Eff Date 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EHARTFDIDMZ0','8','D','20','212',NULL,'Benefit Deduct End Date 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EHARTFDIDMZ0','1','D','20','213',NULL,'Benefit Deduct Pre/Post 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EHARTFDIDMZ0','1','D','20','214',NULL,'Benefit Deduct Basis 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EHARTFDIDMZ0','2','D','20','215',NULL,'Benefit Deduct Order 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EHARTFDIDMZ0','10','D','20','216',NULL,'Benefit Deduct Type 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EHARTFDIDMZ0','6','D','20','217',NULL,'Benefit Deduct Amt 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EHARTFDIDMZ0','8','D','20','218',NULL,'Benefit Deduct Eff Date 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EHARTFDIDMZ0','8','D','20','219',NULL,'Benefit Deduct End Date 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EHARTFDIDMZ0','1','D','20','220',NULL,'Benefit Deduct Pre/Post 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EHARTFDIDMZ0','1','D','20','221',NULL,'Benefit Deduct Basis 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EHARTFDIDMZ0','2','D','20','222',NULL,'Benefit Deduct Order 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EHARTFDIDMZ0','10','D','20','223',NULL,'Benefit Deduct Type 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EHARTFDIDMZ0','6','D','20','224',NULL,'Benefit Deduct Amt 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EHARTFDIDMZ0','8','D','20','225',NULL,'Benefit Deduct Eff Date 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EHARTFDIDMZ0','8','D','20','226',NULL,'Benefit Deduct End Date 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EHARTFDIDMZ0','1','D','20','227',NULL,'Benefit Deduct Pre/Post 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EHARTFDIDMZ0','1','D','20','228',NULL,'Benefit Deduct Basis 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EHARTFDIDMZ0','2','D','20','229',NULL,'Benefit Deduct Order 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EHARTFDIDMZ0','10','D','20','230',NULL,'Benefit Deduct Type 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EHARTFDIDMZ0','6','D','20','231',NULL,'Benefit Deduct Amt 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EHARTFDIDMZ0','8','D','20','232',NULL,'Benefit Deduct Eff Date 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EHARTFDIDMZ0','8','D','20','233',NULL,'Benefit Deduct End Date 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EHARTFDIDMZ0','1','D','20','234',NULL,'Benefit Deduct Pre/Post 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EHARTFDIDMZ0','1','D','20','235',NULL,'Benefit Deduct Basis 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EHARTFDIDMZ0','2','D','20','236',NULL,'Benefit Deduct Order 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EHARTFDIDMZ0','10','D','20','237',NULL,'Benefit Deduct Type 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EHARTFDIDMZ0','6','D','20','238',NULL,'Benefit Deduct Amt 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EHARTFDIDMZ0','8','D','20','239',NULL,'Benefit Deduct Eff Date 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EHARTFDIDMZ0','8','D','20','240',NULL,'Benefit Deduct End Date 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EHARTFDIDMZ0','1','D','20','241',NULL,'Benefit Deduct Pre/Post 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EHARTFDIDMZ0','1','D','20','242',NULL,'Benefit Deduct Basis 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EHARTFDIDMZ0','2','D','20','243',NULL,'Benefit Deduct Order 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EHARTFDIDMZ0','10','D','20','244',NULL,'Benefit Deduct Type 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EHARTFDIDMZ0','6','D','20','245',NULL,'Benefit Deduct Amt 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EHARTFDIDMZ0','8','D','20','246',NULL,'Benefit Deduct Eff Date 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EHARTFDIDMZ0','8','D','20','247',NULL,'Benefit Deduct End Date 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EHARTFDIDMZ0','1','D','20','248',NULL,'Benefit Deduct Pre/Post 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EHARTFDIDMZ0','1','D','20','249',NULL,'Benefit Deduct Basis 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EHARTFDIDMZ0','2','D','20','250',NULL,'Benefit Deduct Order 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EHARTFDIDMZ0','10','D','20','251',NULL,'Benefit Deduct Type 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EHARTFDIDMZ0','6','D','20','252',NULL,'Benefit Deduct Amt 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EHARTFDIDMZ0','8','D','20','253',NULL,'Benefit Deduct Eff Date 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EHARTFDIDMZ0','8','D','20','254',NULL,'Benefit Deduct End Date 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','EHARTFDIDMZ0','1','D','20','255',NULL,'Benefit Deduct Pre/Post 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','EHARTFDIDMZ0','1','D','20','256',NULL,'Benefit Deduct Basis 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','EHARTFDIDMZ0','2','D','20','257',NULL,'Benefit Deduct Order 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','EHARTFDIDMZ0','10','D','20','258',NULL,'Benefit Deduct Type 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','EHARTFDIDMZ0','6','D','20','259',NULL,'Benefit Deduct Amt 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','EHARTFDIDMZ0','8','D','20','260',NULL,'Benefit Deduct Eff Date 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','EHARTFDIDMZ0','8','D','20','261',NULL,'Benefit Deduct End Date 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','EHARTFDIDMZ0','1','D','20','262',NULL,'Benefit Deduct Pre/Post 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','EHARTFDIDMZ0','1','D','20','263',NULL,'Benefit Deduct Basis 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','EHARTFDIDMZ0','2','D','20','264',NULL,'Benefit Deduct Order 11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','EHARTFDIDMZ0','10','D','20','265',NULL,'Benefit Deduct Type 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','EHARTFDIDMZ0','6','D','20','266',NULL,'Benefit Deduct Amt 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','EHARTFDIDMZ0','8','D','20','267',NULL,'Benefit Deduct Eff Date 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','EHARTFDIDMZ0','8','D','20','268',NULL,'Benefit Deduct End Date 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','EHARTFDIDMZ0','1','D','20','269',NULL,'Benefit Deduct Pre/Post 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','EHARTFDIDMZ0','1','D','20','270',NULL,'Benefit Deduct Basis 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','EHARTFDIDMZ0','2','D','20','271',NULL,'Benefit Deduct Order 12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','EHARTFDIDMZ0','10','D','20','272',NULL,'Benefit Deduct Type 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','EHARTFDIDMZ0','6','D','20','273',NULL,'Benefit Deduct Amt 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','EHARTFDIDMZ0','8','D','20','274',NULL,'Benefit Deduct Eff Date 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','EHARTFDIDMZ0','8','D','20','275',NULL,'Benefit Deduct End Date 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','EHARTFDIDMZ0','1','D','20','276',NULL,'Benefit Deduct Pre/Post 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','EHARTFDIDMZ0','1','D','20','277',NULL,'Benefit Deduct Basis 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','EHARTFDIDMZ0','2','D','20','278',NULL,'Benefit Deduct Order 13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','EHARTFDIDMZ0','10','D','20','279',NULL,'Benefit Deduct Type 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','EHARTFDIDMZ0','6','D','20','280',NULL,'Benefit Deduct Amt 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','EHARTFDIDMZ0','8','D','20','281',NULL,'Benefit Deduct Eff Date 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','EHARTFDIDMZ0','8','D','20','282',NULL,'Benefit Deduct End Date 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','EHARTFDIDMZ0','1','D','20','283',NULL,'Benefit Deduct Pre/Post 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','EHARTFDIDMZ0','1','D','20','284',NULL,'Benefit Deduct Basis 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','EHARTFDIDMZ0','2','D','20','285',NULL,'Benefit Deduct Order 14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','EHARTFDIDMZ0','10','D','20','286',NULL,'Benefit Deduct Type 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','EHARTFDIDMZ0','6','D','20','287',NULL,'Benefit Deduct Amt 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','EHARTFDIDMZ0','8','D','20','288',NULL,'Benefit Deduct Eff Date 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','EHARTFDIDMZ0','8','D','20','289',NULL,'Benefit Deduct End Date 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','EHARTFDIDMZ0','1','D','20','290',NULL,'Benefit Deduct Pre/Post 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','EHARTFDIDMZ0','1','D','20','291',NULL,'Benefit Deduct Basis 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','EHARTFDIDMZ0','2','D','20','292',NULL,'Benefit Deduct Order 15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHARTFDIDMZ0','5','T','90','1',NULL,'Section Code',NULL,NULL,'"~FTR~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHARTFDIDMZ0','7','T','90','2',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHARTFDIDM_20211110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102259','EMPEXPORT','OEACTIVE','Sep 29 2021  8:45AM','EHARTFDIDM',NULL,NULL,NULL,'202102259','Feb 25 2021 12:00AM','Dec 30 1899 12:00AM','202102251','1023','','NEHRLY,NESAL,GGSENP,GGH,GGHNP,GGM,GGSNP,GGSE,GGS,GGSOE,GGSON,GGSECA,GMSH,GMSS,HOPEH,HOPES,N51,OBH,OBG,NYE,NYD,OBE,OBA,OBF,OBB,MSH,MBADMN,MBPROD,NRTHFH,NRTHFS,OBS,OBS2,RECRT,PBADMN,PBPROD,PBPRNY,PWPROD,OBD,SIERRA,SPRLT,COAST,COASTC,CORP,CPS','202102251',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102259','EMPEXPORT','OEPASSIVE','Jul 22 2021 12:41PM','EHARTFDIDM',NULL,NULL,NULL,'202102259','Feb 25 2021 12:00AM','Dec 30 1899 12:00AM','202102251','1068','','NEHRLY,NESAL,GGSENP,GGH,GGHNP,GGM,GGSNP,GGSE,GGS,GGSOE,GGSON,GGSECA,GMSH,GMSS,HOPEH,HOPES,N51,OBH,OBG,NYE,NYD,OBE,OBA,OBF,OBB,MSH,MBADMN,MBPROD,NRTHFH,NRTHFS,OBS,OBS2,RECRT,PBADMN,PBPROD,PBPRNY,PWPROD,OBD,SIERRA,SPRLT,COAST,COASTC,CORP,CPS','202102251',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',5WU8J',NULL,NULL,NULL,'The Hartford Disability Leave','202102259','EMPEXPORT','ONDEM_XOE','Jul 22 2021 12:43PM','EHARTFDIDM',NULL,NULL,NULL,'202102259','Feb 25 2021 12:00AM','Dec 30 1899 12:00AM','202102251','1111','eecPayGroup','GGH,GGM,GGSE,GGS','202102251',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','5WU8J',NULL,NULL,NULL,'Scheduled Session','202107169','EMPEXPORT','SCHHARTIDM','Jul 22 2021 12:44PM','EHARTFDIDM',NULL,NULL,NULL,'202107169','Jul 16 2021 12:00AM','Dec 30 1899 12:00AM','202107091','1109','eecPaygroup','GGH,GGM,GGSE,GGS,GGSOE,GGSON','202107091',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',5WU8J',NULL,NULL,NULL,'Test Purposes Only','202110269','EMPEXPORT','TEST_XOE','Oct 26 2021 10:57AM','EHARTFDIDM',NULL,NULL,NULL,'202110269','Oct 26 2021 12:00AM','Dec 30 1899 12:00AM','202110121','1459','','','202110121',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','ArchivePath','V','\\us.saas\e3\Public\GLE1002\Exports\Hartford\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','OverrideCount','V','1459');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHARTFDIDM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHARTFDIDM','H01','dbo.U_EHARTFDIDM_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHARTFDIDM','D10','dbo.U_EHARTFDIDM_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHARTFDIDM','D20','dbo.U_EHARTFDIDM_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHARTFDIDM','T90','dbo.U_EHARTFDIDM_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHARTFDIDM
-----------

IF OBJECT_ID('U_dsi_BDM_EHARTFDIDM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHARTFDIDM] (
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
-- Create table U_EHARTFDIDM_Audit
-----------

IF OBJECT_ID('U_EHARTFDIDM_Audit') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audTerm] varchar(1) NOT NULL,
    [audFMLAChange] varchar(1) NOT NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EHARTFDIDM_DedList
-----------

IF OBJECT_ID('U_EHARTFDIDM_DedList') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHARTFDIDM_drvTbl
-----------

IF OBJECT_ID('U_EHARTFDIDM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(24) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvMemberSSNMemberID] char(11) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvNamePrefix] varchar(1) NOT NULL,
    [drvNameSuffix] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvMemberMailingAddress1] varchar(6000) NULL,
    [drvMemberMailingAddress2] varchar(6000) NULL,
    [drvMemberMailingAddressCity] varchar(255) NULL,
    [drvMemberMailingAddressState] varchar(255) NULL,
    [drvMemberMailingAddrZipCode] varchar(50) NULL,
    [drvMemberMailingAddrCountry] varchar(10) NULL,
    [drvMemberMailingAddrProvince] varchar(1) NOT NULL,
    [drvEmployeeHomePhone] varchar(50) NULL,
    [drvEmpCellNumber] varchar(16) NULL,
    [drvPersonalEmail] varchar(50) NULL,
    [drvEmployeeWorkEmailAddress] varchar(50) NULL,
    [drvEmployeeWorkStateCode] varchar(2) NULL,
    [drvEmployeeWorkAddressCountry] varchar(10) NULL,
    [drvEmployeeWorkPhone] varchar(50) NULL,
    [drvSupervisorID] varchar(1) NOT NULL,
    [drvHRManagerID] varchar(1) NOT NULL,
    [drvEmployeeStatusCode] varchar(1) NULL,
    [drvEmployeeStatusEffDate] datetime NULL,
    [drvEmployeeServiceDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvEmploymentType] char(1) NULL,
    [drvExemptNonExempt] varchar(1) NOT NULL,
    [drvScheduledHoursPerWeek] varchar(24) NULL,
    [drvBenefitSalaryAmount] nvarchar(4000) NULL,
    [drvSalaryEffectiveDate] datetime NULL,
    [drvPayrollBasis] varchar(1) NULL,
    [drvPayGradeLevel] char(3) NULL,
    [drvJobTitle] varchar(25) NULL,
    [drvLocDesc] varchar(10) NULL,
    [drvCompanyCode] char(5) NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvUnionName] varchar(1) NOT NULL,
    [drvClientSpecificField1Name] varchar(1) NOT NULL,
    [drvClientSpecificField1Value] varchar(1) NOT NULL,
    [drvClientSpecificField2Name] varchar(1) NOT NULL,
    [drvClientSpecificField2Value] varchar(1) NOT NULL,
    [drvClientSpecificField3Name] varchar(1) NOT NULL,
    [drvClientSpecificField3Value] varchar(1) NOT NULL,
    [drvClientSpecificField4Name] varchar(1) NOT NULL,
    [drvClientSpecificField4Value] varchar(1) NOT NULL,
    [drvClientSpecificField5Name] varchar(1) NOT NULL,
    [drvClientSpecificField5Value] varchar(1) NOT NULL,
    [drvClientSpecificField6Name] varchar(1) NOT NULL,
    [drvClientSpecificField6Value] varchar(1) NOT NULL,
    [drvClientSpecificField7Name] varchar(1) NOT NULL,
    [drvClientSpecificField7Value] varchar(1) NOT NULL,
    [drvClientSpecificField8Name] varchar(1) NOT NULL,
    [drvClientSpecificField8Value] varchar(1) NOT NULL,
    [drvNSTCoverageEffectiveDate] datetime NULL,
    [drvNSTCoverageTerminationDate] datetime NULL,
    [drvSTDCoveragePlanOption] varchar(5) NOT NULL,
    [drvNSTPlanSummary] varchar(3) NOT NULL,
    [drvNSTEmployeeGroupID] varchar(2) NULL,
    [drvNSTEmployeeClass] varchar(1) NULL,
    [drvSTACoverageEffectiveDate] datetime NULL,
    [drvSTACoverageTerminationDate] datetime NULL,
    [drvSTAStatCvgPlanOption] varchar(255) NULL,
    [drvSTAPlanSummary] varchar(3) NULL,
    [drvSTAEmployeeGroupID] varchar(1) NULL,
    [drvSTAEmplooyeeClassCode] varchar(1) NULL,
    [drvPFLStateEnrolled] varchar(255) NULL,
    [drvPFLCoverageEffectiveDate] datetime NULL,
    [drvPFLCoverageTermDate] datetime NULL,
    [drvPFLPlanSummary] varchar(3) NULL,
    [drvPFLEmployeeGroupId] varchar(1) NULL,
    [drvPFLEmployeeClassCode] varchar(1) NULL,
    [drvLTDCoverageEffectiveDate] datetime NULL,
    [drvLTDCoverageTerminationDate] datetime NULL,
    [drvLTDCoveragePlanOption] varchar(5) NULL,
    [drvLTDPlanSummary] varchar(3) NULL,
    [drvLTDEmployeeGroupID] varchar(2) NULL,
    [drvLTDEmployeeClassCode] varchar(1) NULL,
    [drvReportingLevel1] varchar(21) NOT NULL,
    [drvReportingLevel2] varchar(1) NOT NULL,
    [drvReportingLevel3] varchar(1) NOT NULL,
    [drvReportingLevel4] varchar(1) NOT NULL,
    [drvReportingLevel5] varchar(1) NOT NULL,
    [drvReportingLevel6] varchar(1) NOT NULL,
    [drvReportingLevel7] varchar(1) NOT NULL,
    [drvReportingLevel8] varchar(1) NOT NULL,
    [drvReportingLevel9] varchar(1) NOT NULL,
    [drvReportingLevel10] varchar(1) NOT NULL,
    [drvReportingLevel11] varchar(1) NOT NULL,
    [drvReportingLevel12] varchar(1) NOT NULL,
    [drvBLFCoverageEffectiveDate] datetime NULL,
    [drvBLFCoverageTerminationDate] datetime NULL,
    [drvBLFMultiple] varchar(3) NOT NULL,
    [drvBLFFaceAmt] varchar(20) NULL,
    [drvBLFEmployeeGroupID] varchar(2) NULL,
    [drvBLFEmployeeClassCode] varchar(1) NOT NULL,
    [drvBADCoverageEffectiveDate] datetime NULL,
    [drvBADCoverageTerminationDate] datetime NULL,
    [drvBADEmployeeGroupID] varchar(2) NULL,
    [drvBADEmployeeClassCode] varchar(1) NOT NULL,
    [drvLIFCoverageEffectiveDate] datetime NULL,
    [drvLIFCoverageTerminationDate] datetime NULL,
    [drvLIFFaceAmt] varchar(20) NULL,
    [drvLIFReqAmt] varchar(20) NULL,
    [drvLIFEmployeeGroupID] varchar(2) NULL,
    [drvLIFEmployeeClassCode] varchar(1) NULL,
    [drvADDCoverageEffectiveDate] varchar(1) NOT NULL,
    [drvADDCoverageTerminationDate] varchar(1) NOT NULL,
    [drvADDFaceAmt] varchar(1) NOT NULL,
    [drvADDReqAmt] varchar(1) NOT NULL,
    [drvADDEmployeeGroupID] varchar(1) NOT NULL,
    [drvADDEmployeeClassCode] varchar(1) NOT NULL,
    [drvSPLCoverageEffectiveDate] datetime NULL,
    [drvSPLCoverageTerminationDate] datetime NULL,
    [drvSPLFaceAmt] varchar(20) NULL,
    [drvSPLReqAmt] varchar(20) NULL,
    [drvSPLEmployeeGroupID] varchar(2) NULL,
    [drvSPLEmployeeClassCode] varchar(1) NULL,
    [drvDPLCoverageEffectiveDate] datetime NULL,
    [drvDPLCoverageTerminationDate] datetime NULL,
    [drvDPLFaceAmt] varchar(5) NULL,
    [drvDPLReqAmt] varchar(5) NULL,
    [drvDPLEmployeeGroupID] varchar(2) NULL,
    [drvDPLEmployeeClassCode] varchar(1) NULL,
    [drvLMS] varchar(1) NULL,
    [drvKeyEE] varchar(1) NULL,
    [drvLast12MonthsHours] varchar(24) NULL,
    [drvCumulativeHoursEndDate] datetime NOT NULL,
    [drvCumulativeHoursNumOfWeeks] varchar(2) NOT NULL
);

-----------
-- Create table U_EHARTFDIDM_EEList
-----------

IF OBJECT_ID('U_EHARTFDIDM_EEList') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHARTFDIDM_File
-----------

IF OBJECT_ID('U_EHARTFDIDM_File') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EHARTFDIDM_Header
-----------

IF OBJECT_ID('U_EHARTFDIDM_Header') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_Header] (
    [drvDetailCount] varchar(1) NOT NULL,
    [drvFileName] varchar(200) NULL,
    [drvRunDate] datetime NULL
);

-----------
-- Create table U_EHARTFDIDM_ISOCountryCodeMapping
-----------

IF OBJECT_ID('U_EHARTFDIDM_ISOCountryCodeMapping') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (
    [cCountryCode] varchar(10) NULL,
    [cCountryName] varchar(200) NULL,
    [cISO3166Value] varchar(10) NULL
);

-----------
-- U_EHARTFDIDM_ISOCountryCodeMapping inserts
-----------

INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AFG','Afghanistan','004');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ALA','Aland Islands','248');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ALB','Albania','008');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DZA','Algeria','012');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ASM','American Samoa','016');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AND','Andorra','020');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AGO','Angola','024');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AIA','Anguilla','660');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ATA','Antarctica','010');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ATG','Antigua and Barbuda','028');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ARG','Argentina','032');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ARM','Armenia','051');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ABW','Aruba','533');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AUS','Australia','036');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AUT','Austria','040');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('AZE','Azerbaijan','031');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BHS','Bahamas','044');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BHR','Bahrain','048');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BGD','Bangladesh','050');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BRB','Barbados','052');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BLR','Belarus','112');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BEL','Belgium','056');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BLZ','Belize','084');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BEN','Benin','204');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BMU','Bermuda','060');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BTN','Bhutan','064');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BOL','Bolivia','068');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BES','Bonaire, Sint Eustatius and Saba','535');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BIH','Bosnia and Herzegovina','070');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BWA','Botswana','072');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BVT','Bouvet Island','074');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BRA','Brazil','076');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VGB','Virgin Islands (British)','092');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BRN','Brunei Darussalam','096');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BGR','Bulgaria','100');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BFA','Burkina Faso','854');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BDI','Burundi','108');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KHM','Cambodia','116');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CMR','Cameroon','120');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CAN','Canada','124');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CPV','Cape Verde','132');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CYM','Cayman Islands','136');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CAF','Central African Republic','140');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TCD','Chad','148');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CHL','Chile','152');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CHN','China','156');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CXR','Christmas Island','162');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CCK','Cocos (Keeling) Islands','166');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COL','Colombia','170');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COM','Comoros','174');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COG','Congo','178');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('COK','Cook Islands','184');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CRI','Costa Rica','188');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CIV','Cote dIvoire','384');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HRV','Croatia','191');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CUB','Cuba','192');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CUW','Curacao','531');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CYP','Cyprus','196');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CZE','Czech Republic','203');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DNK','Denmark','208');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DJI','Djibouti','262');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DMA','Dominica','212');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DOM','Dominican Republic','214');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ECU','Ecuador','218');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('EGY','Egypt','818');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SLV','El Salvador','222');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GNQ','Equatorial Guinea','226');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ERI','Eritrea','232');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('EST','Estonia','233');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ETH','Ethiopia','231');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FRO','Faroe Islands','234');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FLK','Falkland Islands (Malvinas)','238');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FJI','Fiji','242');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FIN','Finland','246');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FRA','France','250');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PYF','French Guiana','254');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GUF','French Polynesia','258');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ATF','French Southern Territories','260');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GAB','Gabon','266');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GMB','Gambia','270');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GEO','Georgia','268');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('DEU','Germany','276');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GHA','Ghana','288');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GIB','Gibraltar','292');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GRC','Greece','300');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GRL','Greenland','304');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GRD','Grenada','308');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GLP','Guadeloupe','312');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GUM','Guam','316');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GTM','Guatemala','320');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GGY','Guernsey','831');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GIN','Guinea','324');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GNB','Guinea-Bissau','624');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GUY','Guyana','328');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HTI','Haiti','332');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HMD','Heard Island and McDonald Islands','334');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VAT','Holy See (Vatican City State)','336');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HND','Honduras','340');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HKG','Hong Kong','344');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('HUN','Hungary','348');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ISL','Iceland','352');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IND','India','356');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IDN','Indonesia','360');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IRN','Iran (Islamic Republic of)','364');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IRQ','Iraq','368');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IRL','Ireland','372');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('IMN','Isle of Man','833');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ISR','Israel','376');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ITA','Italy','380');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JAM','Jamaica','388');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JPN','Japan','392');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JER','Jersey','832');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('JOR','Jordan','400');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KAZ','Kazakhstan','398');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KEN','Kenya','404');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KIR','Kiribati','296');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KWT','Kuwait','414');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KGZ','Kyrgyzstan','417');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LAO','Lao Peoples Democratic Republic','418');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LVA','Latvia','428');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LBN','Lebanon','422');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LSO','Lesotho','426');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LBR','Liberia','430');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LBY','Libya','434');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LIE','Liechtenstein','438');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LTU','Lithuania','440');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LUX','Luxembourg','442');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MAC','Macao','446');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MDG','Madagascar','450');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MWI','Malawi','454');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MYS','Malaysia','458');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MDV','Maldives','462');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MLI','Mali','466');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MLT','Malta','470');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MHL','Marshall Islands','584');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MTQ','Martinique','474');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MRT','Mauritania','478');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MUS','Mauritius','480');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MYT','Mayotte','175');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MEX','Mexico','484');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('FSM','Micronesia (Federated States of)','583');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MCO','Monaco','492');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MNG','Mongolia','496');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MNE','Montenegro','499');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MSR','Montserrat','500');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MAR','Morocco','504');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MOZ','Mozambique','508');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MMR','Myanmar','104');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NAM','Namibia','516');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NRU','Nauru','520');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NPL','Nepal','524');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NLD','Netherlands','528');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NCL','New Caledonia','540');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NZL','New Zealand','554');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NIC','Nicaragua','558');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NER','Niger','562');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NGA','Nigeria','566');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NIU','Niue','570');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NFK','Norfolk Island','574');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MNP','Northern Mariana Islands','580');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('NOR','Norway','578');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('OMN','Oman','512');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PAK','Pakistan','586');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PLW','Palau','585');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PSE','Palestine, State of','275');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PAN','Panama','591');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PNG','Papua New Guinea','598');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PRY','Paraguay','600');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PER','Peru','604');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PHL','Philippines','608');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PCN','Pitcairn','612');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('POL','Poland','616');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PRT','Portugal','620');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('PRI','Puerto Rico','630');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('QAT','Qatar','634');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('REU','Reunion','638');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ROU','Romania','642');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('RUS','Russian Federation','643');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('RWA','Rwanda','646');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('BLM','Saint Barthelemy','652');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SHN','Saint Helena, Ascension and Tristan da Cunha','654');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('KNA','Saint Kitts and Nevis','659');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LCA','Saint Lucia','662');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('MAF','Saint Martin (French part)','663');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SPM','Saint Pierre and Miquelon','666');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VCT','Saint Vincent and the Grenadines','670');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('WSM','Samoa','882');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SMR','San Marino','674');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('STP','Sao Tome and Principe','678');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SAU','Saudi Arabia','682');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SEN','Senegal','686');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SRB','Serbia','688');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SYC','Seychelles','690');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SLE','Sierra Leone','694');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SGP','Singapore','702');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SXM','Sint Maarten (Dutch part)','534');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SVK','Slovakia','703');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SVN','Slovenia','705');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SLB','Solomon Islands','090');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SOM','Somalia','706');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ZAF','South Africa','710');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SGS','South Georgia and the South Sandwich Islands','239');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SSD','South Sudan','728');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ESP','Spain','724');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('LKA','Sri Lanka','144');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SDN','Sudan','729');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SUR','Suriname','740');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SJM','Svalbard and Jan Mayen','744');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SWZ','Swaziland','748');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SWE','Sweden','752');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('CHE','Switzerland','756');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('SYR','Syrian Arab Republic','760');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TWN','Taiwan, Province of China[a]','158');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TJK','Tajikistan','762');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('THA','Thailand','764');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TLS','Timor-Leste','626');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TGO','Togo','768');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TKL','Tokelau','772');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TON','Tonga','776');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TTO','Trinidad and Tobago','780');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TUN','Tunisia','788');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TUR','Turkey','792');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TKM','Turkmenistan','795');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TCA','Turks and Caicos Islands','796');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('TUV','Tuvalu','798');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UGA','Uganda','800');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UKR','Ukraine','804');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ARE','United Arab Emirates','784');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('GBR','United Kingdom of Great Britain and Northern Ireland','826');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('USA','United States of America','840');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VIR','Virgin Islands (U.S.)','850');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('URY','Uruguay','858');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UMI','United States Minor Outlying Islands','581');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('UZB','Uzbekistan','860');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VUT','Vanuatu','548');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VEN','Venezuela','862');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('VNM','Viet Nam','704');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('WLF','Wallis and Futuna','876');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ESH','Western Sahara','732');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('YEM','Yemen','887');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ZMB','Zambia','894');
INSERT INTO [dbo].[U_EHARTFDIDM_ISOCountryCodeMapping] (cCountryCode,cCountryName,cISO3166Value) VALUES ('ZWE','Zimbabwe','716');

-----------
-- Create table U_EHARTFDIDM_PEarHist
-----------

IF OBJECT_ID('U_EHARTFDIDM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PehCurHrs] decimal NULL,
    [pehCurAmt_COMM] numeric NULL,
    [pehYTDHrs] decimal NULL
);

-----------
-- Create table U_EHARTFDIDM_Trailer
-----------

IF OBJECT_ID('U_EHARTFDIDM_Trailer') IS NULL
CREATE TABLE [dbo].[U_EHARTFDIDM_Trailer] (
    [drvRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHARTFDIDM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Glen Gery Corporation

Created By: Scott Beever
Business Analyst: Josh Smith
Create Date: 12/11/2020
Service Request Number: SR-2020-00290061

Purpose: The Hartford Disability and Leave Export (IDM)

NOTE TO SUPPORT: Custom Mapping Table used for ISO 3166 Country Code Translations
    -- Table Name: U_EHARTFDIDM_ISOCountryCodeMapping
    -- Full Insert Statement in Comments Section at Bottom of Code

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHARTFDIDM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHARTFDIDM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHARTFDIDM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHARTFDIDM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHARTFDIDM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHARTFDIDM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHARTFDIDM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHARTFDIDM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHARTFDIDM', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHARTFDIDM', 'SCHHARTIDM'; --Scheduled Session Only

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHARTFDIDM';

EXEC dbo._dsi_usp_ExportRipOut_v6 @FormatCode = 'EHARTFDIDM', @AllObjects = 'Y', @IsWeb = 'Y'

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHARTFDIDM', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileName          VARCHAR(200)
            ,@RunDate           DATETIME
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EHARTFDIDM';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
        ,@FileMinCovDate  = '01/01/2021'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Set @FileName Value
    --==========================================
    SET @FileName = CASE --WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_ GlenGery_Ultimate_' + CONVERT(VARCHAR(8),@RunDate,112) + '.txt'
                         WHEN @ExportCode = 'TEST' THEN 'TEST_GlenGery_Ultimate_' + CONVERT(VARCHAR(8),@RunDate,112) + '.txt'
                         ELSE 'GlenGery_Ultimate_' + CONVERT(VARCHAR(8),@RunDate,112) + '.txt'
                    END;

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_EHARTFDIDM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHARTFDIDM_Audit;
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
        ,audTerm = CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audFMLAChange = CASE WHEN audFieldName = 'EecEEType' AND ISNULL(audOldValue,'') NOT IN ('','EXE') AND ISNULL(audNewValue,'') IN ('EXE') THEN 'Y'
                              ELSE 'N'
                         END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EHARTFDIDM_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audTableName = 'EmpComp'
    AND audFieldName IN ('EecEmplStatus','EecEEType','EecDedGroupCode')
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHARTFDIDM_Audit ON dbo.U_EHARTFDIDM_Audit (audEEID,audKey2);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Remove Terminated Employees NOT Found in Audit
    DELETE FROM dbo.U_EHARTFDIDM_EEList
    FROM dbo.U_EHARTFDIDM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND NOT EXISTS (SELECT 1 FROM dbo.U_EHARTFDIDM_Audit WHERE audEEID = xEEID AND audKey2 = xCOID AND audTerm = 'Y' AND audRowNo = 1);

    -- Remove Employees where Pay Group In: IN'GGHNP', 'GGSNP', 'GGSENP'
    DELETE FROM dbo.U_EHARTFDIDM_EEList
    FROM dbo.U_EHARTFDIDM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecPayGroup IN ('GGHNP', 'GGSNP', 'GGSENP');

    -- Remove Employees where EmpType In: IN'TMP', 'INT'
    DELETE FROM dbo.U_EHARTFDIDM_EEList
    FROM dbo.U_EHARTFDIDM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEEType IN ('TMP', 'INT');

    -- Remove Employees where EecUDField02 = N
    DELETE FROM dbo.U_EHARTFDIDM_EEList
    FROM dbo.U_EHARTFDIDM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE LEFT(isnull(EecUDField02,''),1) = 'N'
        AND EecPayGroup <> 'GGSOE' AND EecUnionLocal NOT IN ('786','673','026','179','364','916' );
    
    --==========================================
    -- Create Deduction List
    --==========================================
    IF OBJECT_ID('U_EHARTFDIDM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHARTFDIDM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHARTFDIDM_DedList
    FROM dbo.DedCode WITH (NOLOCK)
    WHERE DedDedCode IN ('OPLEE','OPLSP','OPTCH');

    -- Build Deduction Code List and store in @DedList Variable
    DECLARE @DedList VARCHAR(MAX)
    SELECT @DedList = COALESCE(@DedList+',','') + LTRIM(RTRIM(DedCode))
    FROM dbo.U_EHARTFDIDM_DedList;

    --=================================================
    -- Working Table - PEarHist
    --=================================================
    IF OBJECT_ID('U_EHARTFDIDM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHARTFDIDM_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate          = MAX(PrgPayDate)
        ,PrgPeriodEndDate    = MAX(PrgPeriodEndDate)
        ,PehCurHrs           = SUM(PehCurHrs)
        ,pehCurAmt_COMM      = SUM(CASE WHEN PehEarnCode = 'COMM' THEN pehCurAmt ELSE 0.00 END)
        ,pehYTDHrs           = SUM(CASE WHEN PehEarnCode IN ('DBL', 'DBLM', 'OT', 'OT1', 'OTM', 'REG', 'REGM')  THEN pehCurHrs ELSE 0.00 END)
    INTO dbo.U_EHARTFDIDM_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN CONVERT(CHAR(8),DATEADD(MONTH,-12,@RunDate),112) + '1' AND CONVERT(CHAR(8),@RunDate,112) + '9'
    --AND PehInclInPensionAccum = 'Y'
    GROUP BY PehEEID
    HAVING SUM(PehCurHrs) <> 0.00;

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
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'AllowMultiDedType','Y');
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


    UPDATE A 
    SET eedUSGField1 = cast(cast(CASE WHEN isnull(EedEOIDesiredAmt,0.00) > isnull(A.EedBenAmt, 0.00) THEN isnull(EedEOIDesiredAmt,0.00) ELSE isnull(A.EedBenAmt,0.00) END  as int) as varchar(20))  
    FROM  dbo.U_dsi_BDM_EmpDeductions A
    JOIN dbo.EmpDed B
         ON A.eedeeid = B.eedeeid
         AND A.eedcoid = B.eedCoid
         AND A.eedDedCOde = B.eedDedCode
         AND A.eedFormatCode = 'EHARTFDIDM'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHARTFDIDM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHARTFDIDM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHARTFDIDM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN) +'_'+ isnull(bdmDepRecID,'')
        ,drvDepRecID = bdmDepRecID
        ,drvDedCode = CASE WHEN bdmDepRecID IS NOT NULL THEN  bdmDedCode END
        --,drvFMLAEligibility = MAX(CASE WHEN (E.EecEmplStatus = 'A') OR (audTerm = 'Y' OR audFMLAChange = 'Y') THEN 'Y' END)
        --,drvSTDEligibility = MAX(CASE WHEN DedDedType = 'STD' THEN 'Y' END)
        --,drvLTDEligibility = MAX(CASE WHEN DedDedType = 'LTD' THEN 'Y' END)
        -- standard fields above and additional driver fields below
        --START - Section Code= "~PII~"
        ,drvTransCode = CASE WHEN bdmDepRecID IS NOT NULL THEN 'D' ELSE 'E' END
        ,drvEmployeeSSN = EepSSN -- ISNULL(E.EecPayGroup, 'no') + ' :: ' + ISNULL(E.EecOrgLvl3, 'no') + ' :: ' + ISNULL(E.EecUnionLocal, 'no') -- EepSSN
        ,drvEmployeeID = E.EecEmpNo
        ,drvMemberSSNMemberID = CASE WHEN bdmDepRecID IS NOT NULL THEN ConSSN ELSE EepSSN END
        ,drvRelationshipCode = CASE WHEN bdmDepRecID IS NULL THEN ''
                                    WHEN bdmDedCode = 'OPLSP' THEN 'SP'
                                    WHEN bdmDedCode = 'OPTCH' THEN 'CH'
                                    END
        ,drvLastName = CASE WHEN bdmDepRecID IS NOT NULL THEN ConNameLast ELSE EepNameLast END 
        ,drvFirstName = CASE WHEN bdmDepRecID IS NOT NULL THEN ConNameFirst ELSE EepNameFirst END  
        ,drvMiddleInitial = CASE WHEN bdmDepRecID IS NOT NULL THEN LEFT(ConNameMiddle,1) ELSE LEFT(EepNameMiddle,1) END  
        ,drvNamePrefix = '' --NULLIF(EepNamePrefix,'Z')
        ,drvNameSuffix = '' --NULLIF(EepNameSuffix,'Z')
        ,drvDateofBirth = CASE WHEN bdmDepRecID IS NOT NULL THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvMaritalStatus = CASE WHEN bdmDepRecID IS NOT NULL THEN '' 
                                 WHEN eepMaritalStatus = 'S' THEN 'I' 
                                 ELSE eepMaritalStatus END
        ,drvGender = CASE WHEN bdmDepRecID IS NOT NULL THEN '' 
                          WHEN EepGender NOT IN ('M','F') THEN 'U'
                          ELSE EepGender
                     END
        --END - Section Code= "~PII~"
        --START - Section Code= "~ECI~"
        ,drvMemberMailingAddress1 = dbo.dsi_fnRemoveChars(',.-"',UPPER(CASE WHEN bdmDepRecID IS NOT NULL THEN ConAddressLine1 ELSE EepAddressLine1 END))
        ,drvMemberMailingAddress2 = dbo.dsi_fnRemoveChars(',.-"',UPPER(
                                    CASE WHEN EepAddressCountry IN ('CAN','USA') THEN CASE WHEN bdmDepRecID IS NOT NULL THEN ConAddressLine2 ELSE EepAddressLine2 END
                                         ELSE ISNULL(NULLIF(RTRIM(EepAddressLine2) + SPACE(1),''),'') + ISNULL(LTRIM(RTRIM(EepAddressCity)),'') + SPACE(1) + ISNULL(LTRIM(RTRIM(EepAddressZipCode)),'')
                                    END))
        ,drvMemberMailingAddressCity = CASE WHEN EepAddressCountry IN ('CAN','USA') THEN CASE WHEN bdmDepRecID IS NOT NULL THEN ConAddressCity ELSE EepAddressCity END
                                            ELSE EepAddressCountry
                                       END
        ,drvMemberMailingAddressState = UPPER(CASE WHEN EepAddressCountry IN ('CAN','USA') THEN CASE WHEN bdmDepRecID IS NOT NULL THEN CONAddressState ELSE EepAddressState END END)
        ,drvMemberMailingAddrZipCode = UPPER(CASE WHEN EepAddressCountry IN ('CAN','USA') THEN CASE WHEN bdmDepRecID IS NOT NULL THEN ConAddressZipCode ELSE  EepAddressZipCode END END)
        ,drvMemberMailingAddrCountry = EA.cISO3166Value
        ,drvMemberMailingAddrProvince = ''
        ,drvEmployeeHomePhone = CASE WHEN bdmDepRecID IS NOT NULL THEN '' ELSE  EepPhoneHomeNumber END
        ,drvEmpCellNumber     = CASE WHEN bdmDepRecID IS NOT NULL THEN '' ELSE [dbo].[dsi_fnlib_GetPhoneNumber_EHARTFDIDM] (xeeid,'CEL') END
        ,drvPersonalEmail = CASE WHEN bdmDepRecID IS NOT NULL THEN '' ELSE EepAddressEmailAlternate END
        ,drvEmployeeWorkEmailAddress = CASE WHEN bdmDepRecID IS NOT NULL THEN '' ELSE EepAddressEMail END
        ,drvEmployeeWorkStateCode = CASE WHEN bdmDepRecID IS NOT NULL THEN '' ELSE LEFT(E.EecStateSUI,2) END
        ,drvEmployeeWorkAddressCountry = LA.cISO3166Value
        ,drvEmployeeWorkPhone = CASE WHEN bdmDepRecID IS NOT NULL THEN '' ELSE E.EecPhoneBusinessNumber END
        --END - Section Code= "~ECI~"
        --START - Section Code= "~ERC~"
        ,drvSupervisorID = '' -- Supervisor.EecEmpNo
        ,drvHRManagerID = ''
        --END - Section Code= "~ERC~"
        --START - Section Code= "~EMI~"
        ,drvEmployeeStatusCode = CASE WHEN bdmDepRecID IS NOT NULL THEN ''
                                      WHEN E.EecEmplStatus = 'T' THEN
                                          CASE WHEN E.EecTermReason = '203' THEN 'D'
                                               ELSE 'T'
                                          END
                                      --WHEN MAX(audFMLAChange) = 'Y' THEN 'T'
                                      ELSE E.EecEmplStatus
                                 END
        ,drvEmployeeStatusEffDate = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE E.EecEmplStatusStartDate END
                                    /*CASE WHEN E.EecEmplStatus = 'T' OR E.EecEEType = 'EXE' THEN E.EecEmplStatusStartDate
                                         WHEN MAX(audFMLAChange) = 'Y' THEN @RunDate
                                    END*/
        ,drvEmployeeServiceDate = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE E.EecDateOfLastHire END
        ,drvRehireDate =CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE  E.EecDateOfLastHire END
        ,drvOriginalHireDate = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE E.EecDateOfOriginalHire END
        ,drvEmploymentType = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE E.EecFullTimeOrPartTime END
        ,drvExemptNonExempt = CASE  WHEN bdmDepRecID IS NOT NULL THEN '' 
                                    WHEN E.EecPayGroup = 'GGSE' THEN 'E' 
                                    ELSE 'N' END
                                    --WHEN E.eecSalaryOrHourly = 'S' THEN 'N' ELSE 'E' END
        ,drvScheduledHoursPerWeek = CASE  WHEN bdmDepRecID IS NOT NULL THEN '' 
                                         WHEN E.eecPayPeriod = 'W' THEN dbo.dsi_fnPadZero(E.EecScheduledWorkHrs * 100,4,0)
                                         WHEN E.eecPayPeriod = 'B' THEN dbo.dsi_fnPadZero(E.EecScheduledWorkHrs * 0.5 * 100,4,0)
                                         WHEN E.eecPayPeriod = 'S' THEN dbo.dsi_fnPadZero(E.EecScheduledWorkHrs * 0.75 * 100,4,0)
                                         WHEN E.eecPayPeriod = 'M' THEN dbo.dsi_fnPadZero((E.EecScheduledWorkHrs *12.00)/52.00 * 100,4,0) END
        ,drvBenefitSalaryAmount = FORMAT((E.EecAnnSalary +  ISNULL(pehCurAmt_COMM,0.00)) * 100, '000000000')
                                    --CAST(CAST(CEILING(CONVERT(NUMERIC(12,2), E.EecAnnSalary +  ISNULL(pehCurAmt_COMM,0.00)) / 1000) * 1000  AS INT) AS VARCHAR(20))
                                    --CASE  WHEN bdmDepRecID IS NOT NULL THEN ''  ELSE dbo.dsi_fnPadZero(E.EecAnnSalary * 100,9,0) END
        ,drvSalaryEffectiveDate = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE dbo.dsi_fnlib_GetAnnSalary_EffDate(xEEID,xCOID,E.EecDateOfLastHire) END
        ,drvPayrollBasis = CASE  WHEN bdmDepRecID IS NOT NULL THEN '' ELSE E.EecSalaryOrHourly  END
        ,drvPayGradeLevel = JbcSalaryGrade
        ,drvJobTitle = LEFT(LTRIM(JbcDesc),25)
        ,drvLocDesc = LEFT(LTRIM(LocDesc),10)
        ,drvCompanyCode = CmpCompanyCode
        ,drvUnionIndicator = '' /*CASE WHEN NULLIF(NULLIF(E.EecUnionLocal,''),'Z') IS NOT NULL THEN 'Y'
                                  ELSE 'N'
                             END*/
        ,drvUnionName = '' /* CASE WHEN NULLIF(NULLIF(E.EecUnionLocal,''),'Z') IS NOT NULL THEN E.EecUnionLocal
                             ELSE 'NU'
                        END*/
        --END - Section Code= "~EMI~"
        --START - Section Code= "~CSF~"
        ,drvClientSpecificField1Name = ''
        ,drvClientSpecificField1Value = ''
        ,drvClientSpecificField2Name = ''
        ,drvClientSpecificField2Value = ''
        ,drvClientSpecificField3Name = ''
        ,drvClientSpecificField3Value = ''
        ,drvClientSpecificField4Name = ''
        ,drvClientSpecificField4Value = ''
        ,drvClientSpecificField5Name = ''
        ,drvClientSpecificField5Value = ''
        ,drvClientSpecificField6Name = ''
        ,drvClientSpecificField6Value = ''
        ,drvClientSpecificField7Name = ''
        ,drvClientSpecificField7Value = ''
        ,drvClientSpecificField8Name = ''
        ,drvClientSpecificField8Value = '' --ISNULL(bdmDepRecID, 'no') + ' :: ' + ISNULL(E.EecPayGroup, 'no') + ' :: ' + ISNULL(E.EecUnionLocal, 'no')
        --END - Section Code= "~CSF~"
        --START - Section Code= "~NST~" (STD Plans)
        -- EVeryone except dependents

        ,drvNSTCoverageEffectiveDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                            WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916')) 
                                            OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) --'8/1/2021'
                                            WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) 
                                        END


                        -- if emlpy stats =t and date of term < effective date
        ,drvNSTCoverageTerminationDate =  CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                            /*WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) --'8/1/2021'
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN E.EecEmplStatus = 'T' THEN E.EecDateOFTermination*/
                                            WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',E.EecDateOFTermination, dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) )
                                            ELSE NULL                                         
                                        END    
                                            
        ,drvSTDCoveragePlanOption =  CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510','520') THEN '430'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '66.67'
                                  ELSE '66.67' 
                                   END
        ,drvNSTPlanSummary = CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510','520') THEN '1A3'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '1A1'
                                  ELSE '1A2' 
                             END  
        ,drvNSTEmployeeGroupID =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                        --WHEN bdmDepRecID IS NOT NULL AND E.EecPayGroup = 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN '31'    
                                        --WHEN bdmDepRecID IS NOT NULL AND E.EecPayGroup = 'GGSOE' THEN '31'
                                         WHEN /*bdmDepRecID IS NOT NULL AND*/ E.EecPayGroup = 'GGH' THEN
                                            CASE WHEN E.EecOrgLvl3 ='520' THEN '17'
                                                WHEN E.EecOrgLvl3 ='432' THEN '19'
                                                WHEN E.EecOrgLvl3 ='610' THEN '20'
                                                WHEN E.EecOrgLvl3 ='412' THEN '21'
                                                WHEN E.EecOrgLvl3 ='430' THEN '22'
                                                WHEN E.EecOrgLvl3 ='465' THEN '23'
                                                WHEN E.EecOrgLvl3 ='630' THEN '33'
                                                WHEN E.EecOrgLvl3 ='436' THEN '24'
                                                WHEN E.EecOrgLvl3 in ('425','440') THEN '25'
                                                WHEN E.EecOrgLvl3 ='640' THEN '29'
                                                WHEN E.EecOrgLvl3 ='510' THEN '27'
                                                WHEN E.EecOrgLvl3 ='410' THEN '26'                                                
                                            END
                                        WHEN /*bdmDepRecID IS NOT NULL AND*/ E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '31'    
                                        WHEN /*bdmDepRecID IS NOT NULL AND*/ E.EecPayGroup = 'GGSOE' THEN '31'
                                        ELSE '2'
                                    END
        
                                 
        ,drvNSTEmployeeClass = CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510','520') THEN '3'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '1'
                                  ELSE '2' 
                               END
        -- check
        ,drvSTACoverageEffectiveDate =     CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NULL AND LocAddressState IN ('NY','NJ') AND E.EecEEType NOT IN ('TMP', 'INT') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                        END 

                                        --WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) 
                                            --OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))

                                        /* CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL
                                            WHEN E.EecEEType NOT IN ('TMP', 'INT') AND LocAddressState IN ('NY','NJ') AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN 
                                                dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                        END*/
        ,drvSTACoverageTerminationDate =    CASE WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY','NJ') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,E.EecDateOFTermination) 
                                                WHEN E.EecEmplStatus = 'T' AND LocAddressState IN ('NY','NJ') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            END

                                            /*CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL
                                                WHEN E.EecDateOFTermination is NULL THEN NULL                                                 
                                                WHEN E.EecEEType NOT IN ('TMP', 'INT') AND LocAddressState IN ('NY','NJ') AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,E.EecDateOFTermination) 
                                            END*/
        ,drvSTAStatCvgPlanOption = CASE WHEN /*bdmDepRecID IS NULL OR*/ (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''
                                        WHEN LocAddressState IN ('NY','NJ') AND E.EecPayGroup <> 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN LocAddressState
                                        ELSE ''
                                    END
                                    
        -- jcb
        ,drvSTAPlanSummary =    CASE WHEN /*bdmDepRecID IS NULL OR*/ (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''                            
                                    WHEN LocAddressState = 'NJ' AND E.EecPayGroup <> 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '2C1'
                                    WHEN LocAddressState = 'NY' AND E.EecPayGroup <> 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '3C1'
                                END
                                
                                /*CASE WHEN bdmDepRecID IS NOT NULL AND LocAddressState = 'NJ' AND E.EecEEType NOT IN ('TMP', 'INT') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '2C1'
                                    WHEN bdmDepRecID IS NOT NULL AND LocAddressState = 'NY' AND E.EecEEType NOT IN ('TMP', 'INT') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '3C1'
                                END*/
                                
        ,drvSTAEmployeeGroupID =    CASE WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState = 'NJ' AND   (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '3'
                                        WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState = 'NY' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '4'
                                    END
                                    /*CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''
                                        WHEN LocAddressState = 'NJ' AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN '3'
                                        WHEN LocAddressState = 'NY' AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN '4'
                                    END*/
        ,drvSTAEmplooyeeClassCode =    CASE WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState IN ('NY','NJ') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '1' END
                                    /*CASE WHEN BdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''
                                        WHEN LOcAddressState IN ('NY','NJ') AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN '1'
                                    END*/
        ,drvPFLStateEnrolled = CASE WHEN /*bdmDepRecID IS NOT NULL AND*/ E.EecUnionLocal IN ('786','673','026','179','364','916') THEN '' -- JCB
                                    WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState = 'NY' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN LocAddressState
                                END
                                --CASE WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN LocAddressState END
        
        ,drvPFLCoverageEffectiveDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY') AND E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY') AND E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY') AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NULL AND LocAddressState IN ('NY') AND E.EecEEType NOT IN ('TMP', 'INT') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                        END 
                                        
                                        /*CASE WHEN (E.EecPayGroup = 'GGSON' AND LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NOT NULL AND LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) 
                                        END*/
                                        
        ,drvPFLCoverageTermDate =    CASE WHEN E.EecDateOFTermination is NULL THEN NULL
                                        WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,E.EecDateOFTermination)  
                                    END
                                    /*CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL
                                        WHEN E.EecDateOFTermination is NULL THEN NULL                                                 
                                        WHEN E.EecEEType NOT IN ('TMP', 'INT') AND LocAddressState IN ('NY') AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,E.EecDateOFTermination) 
                                    END*/
        ,drvPFLPlanSummary = CASE WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '1J1' END

        ,drvPFLEmployeeGroupId = CASE WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '4' END
                                    /*CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''
                                        WHEN LocAddressState = 'NY' AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN '4'
                                    END*/
        ,drvPFLEmployeeClassCode = CASE WHEN /*bdmDepRecID IS NOT NULL AND*/ LocAddressState IN ('NY') AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '1' END
                                    /*CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''
                                        WHEN LocAddressState = 'NY' AND E.EecPayGroup <> 'GGSON' AND E.EecUnionLocal NOT IN ('786','673','026','179','364','916') THEN '1'
                                    END*/

        -- MAX(CASE WHEN DedDedType = 'STD' THEN '' --INSERT CASE STATEMENT HERE
          --                       END)
        --END - Section Code= "~NST~" (STD Plans)
        --START - Section Code= "~LTD~"
        -- check
        ,drvLTDCoverageEffectiveDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) OR E.EecPayGroup = 'GGH' THEN NULL 
                                            WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) 
                                            THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) --'8/1/2021'
                                            WHEN E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) --'8/1/2021'
                                            WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) 
                                        END

                                    /*CASE WHEN (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            WHEN bdmDepRecID IS NOT NULL  OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL WHEN E.EecEEType NOT IN ('TMP', 'INT') AND E.eecPayGroup in ('GGS','GGSE','GGSM') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) 
                                        END*/

                                        --CASE WHEN bdmDepRecID IS NOT NULL THEN NULL 
                                        --    WHEN E.EecEEType NOT IN ('TMP', 'INT') AND E.eecPayGroup in ('GGS','GGSE','GGSM') 
                                        --    THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) 
                                        --END


        ,drvLTDCoverageTerminationDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) OR E.EecPayGroup = 'GGH'  THEN NULL 
                                            /*WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) --'8/1/2021'
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN E.EecEmplStatus = 'T' THEN E.EecDateOFTermination*/
                                            WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',E.EecDateOFTermination, dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) )
                                            ELSE NULL                                         
                                        END    
        
                                            --CASE WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire))
                                            --    WHEN bdmDepRecID IS NOT NULL  OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL WHEN E.EecDateOFTermination is NULL THEN NULL WHEN E.EecEEType NOT IN ('TMP', 'INT') AND E.eecPayGroup in ('GGS','GGSE','GGSM')  THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,E.EecDateOFTermination) 
                                            --END
        
        ,drvLTDCoveragePlanOption = CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) OR E.EecPayGroup = 'GGH' THEN NULL 
                                        WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN '60.00'   --AND E.eecPayGroup in ('GGS','GGSE','GGSM') THEN '60.00' 
                                    END
        ,drvLTDPlanSummary =  CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) OR E.EecPayGroup = 'GGH' THEN NULL 
                                    WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN '1B1'   --AND E.eecPayGroup in ('GGS','GGSE','GGSM')THEN '1B1' 
                              END 
        
        ,drvLTDEmployeeGroupID =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) OR E.EecPayGroup = 'GGH' THEN NULL 
                                        WHEN bdmDepRecID IS NOT NULL OR E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))  THEN '30'
                                        WHEN bdmDepRecID IS NOT NULL OR E.EecPayGroup = 'GGSOE' THEN '30'
                                        ELSE '1'
                                    END  -- Correct!
                                    
        ,drvLTDEmployeeClassCode = CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) OR E.EecPayGroup = 'GGH' THEN NULL 
                                    WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN '1' 
                                    END 
        --END - Section Code= "~LTD~"
        --START - Section Code= "~RPL~"
        ,drvReportingLevel1 = 'Glen Gery Corporation'
        ,drvReportingLevel2 = ''
        ,drvReportingLevel3 = ''
        ,drvReportingLevel4 = ''
        ,drvReportingLevel5 = ''
        ,drvReportingLevel6 = ''
        ,drvReportingLevel7 = ''
        ,drvReportingLevel8 = ''
        ,drvReportingLevel9 = ''
        ,drvReportingLevel10 = ''
        ,drvReportingLevel11 = ''
        ,drvReportingLevel12 = ''
        --END - Section Code= "~RPL~"
        --START - Section Code= "~BLF~"
        ,drvBLFCoverageEffectiveDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                            WHEN (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) 
                                            OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) --'8/1/2021'
                                            WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) 
                                        END
        ,drvBLFCoverageTerminationDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                            /*WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) --'8/1/2021'
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN E.EecEmplStatus = 'T' THEN E.EecDateOFTermination*/
                                            WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',E.EecDateOFTermination, dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)))
                                            ELSE NULL                                         
                                        END    
        
        , drvBLFMultiple = CASE WHEN bdmDepRecID IS NOT NULL  OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510') THEN ''
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('520') THEN ''
                                  ELSE '100' 
                                   END
        ,drvBLFFaceAmt =  CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN '' 
                               WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510') THEN '16000'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('520') THEN '15000'
                               WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN  cast(cast(CEILING(CONVERT(NUMERIC(12,2), E.EecAnnSalary +  isnull(pehCurAmt_COMM,0.00)) / 1000) * 1000  as int) as varchar(20))  
                               END
        ,drvBLFEmployeeGroupID =    CASE WHEN bdmDepRecID IS NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN
                                        CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                            WHEN E.EecPayGroup = 'GGH' THEN
                                                CASE WHEN EecOrgLvl3 = '432' THEN '8'
                                                    WHEN EecOrgLvl3 = '520' THEN '6'
                                                    WHEN EecOrgLvl3 = '610' THEN '9'
                                                    WHEN EecOrgLvl3 = '412' THEN '10'
                                                    WHEN EecOrgLvl3 = '430' THEN '11'
                                                    WHEN EecOrgLvl3 = '465' THEN '12'
                                                    WHEN EecOrgLvl3 = '630' THEN '32'
                                                    WHEN EecOrgLvl3 = '436' THEN '13'
                                                    WHEN EecOrgLvl3 in ('425','440') THEN '14'
                                                    WHEN EecOrgLvl3 = '640' THEN '28'
                                                    WHEN EecOrgLvl3 = '510' THEN '16'
                                                    WHEN EecOrgLvl3 = '410' THEN '15'
                                                END
                                            WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '30'
                                            WHEN E.EecPayGroup = 'GGSOE' THEN '30'
                                            ELSE '1'
                                        END
                                    END
                                
                                     /* CASE WHEN bdmDepRecID IS NOT NULL THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510') THEN '1D4'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('520') THEN '1D3'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '1D1'
                                  ELSE '1D2' 
                                   END*/
        ,drvBLFEmployeeClassCode =  CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510') THEN '4'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('520') THEN '3'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '1'
                                  ELSE '2' 
                                   END
        --END - Section Code= "~BLF~"
        --START - Section Code= "~BAD~"
        --check
        ,drvBADCoverageEffectiveDate = CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                            WHEN (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) 
                                            OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire)) --'8/1/2021'
                                            WHEN E.EecEEType NOT IN ('TMP', 'INT') THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) 
                                        END
        ,drvBADCoverageTerminationDate =    CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN NULL 
                                            /*WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) --'8/1/2021'
                                            WHEN bdmDepRecID IS NOT NULL AND E.EecEmplStatus = 'T' AND E.EecPayGroup = 'GGSOE' THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',E.EecDateOFTermination) 
                                            WHEN E.EecEmplStatus = 'T' THEN E.EecDateOFTermination*/
                                            WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',E.EecDateOFTermination, dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,[dbo].[fn_EndOfMonth_EHARTFDIDM](E.EecDateOfORiginalHire) ) )
                                            ELSE NULL                                         
                                        END    
        
        ,drvBADEmployeeGroupID =    CASE WHEN bdmDepRecID IS NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN
                                        CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                            WHEN E.EecPayGroup = 'GGH' THEN
                                                CASE WHEN EecOrgLvl3 = '432' THEN '8'
                                                    WHEN EecOrgLvl3 = '520' THEN '6'
                                                    WHEN EecOrgLvl3 = '610' THEN '9'
                                                    WHEN EecOrgLvl3 = '412' THEN '10'
                                                    WHEN EecOrgLvl3 = '430' THEN '11'
                                                    WHEN EecOrgLvl3 = '465' THEN '12'
                                                    WHEN EecOrgLvl3 = '630' THEN '32'
                                                    WHEN EecOrgLvl3 = '436' THEN '13'
                                                    WHEN EecOrgLvl3 in ('425','440') THEN '14'
                                                    WHEN EecOrgLvl3 = '640' THEN '28'
                                                    WHEN EecOrgLvl3 = '510' THEN '16'
                                                    WHEN EecOrgLvl3 = '410' THEN '15'
                                                END
                                            
                                            WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '30'
                                            WHEN E.EecPayGroup = 'GGSOE' THEN '30'
                                            ELSE '1'
                                        END
                                    END
                            
                                     /* CASE WHEN bdmDepRecID IS NOT NULL THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510') THEN '1D4'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('520') THEN '1D3'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '1D1'
                                  ELSE '1D2' 
                                   END*/
        ,drvBADEmployeeClassCode = CASE WHEN bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN '' 
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('510') THEN '4'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 IN ('520') THEN '3'
                                  WHEN E.EecPayGroup = 'GGH' AND eecOrgLvl3 NOT IN ('510','520') THEN '1'
                                  ELSE '2' 
                                   END
        --END - Section Code= "~BAD~"
        --START - Section Code= "~LIF~"
        --checka
        ,drvLIFCoverageEffectiveDate = CASE WHEN bdmDedCode = 'OPLEE' AND NOT (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',bdmBenStartDate)
                                            WHEN bdmDedCode = 'OPLEE' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate)
                                        END
                                        

                                    /*CASE WHEN eed_LIF.eedDedCode IS NOT NULL AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR RTRIM(E.EecUnionLocal) NOT IN  ('786','673','026','179','364','916'))) OR
                                             (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',Eed_LIF.eedBenStartDate)
                                             WHEN eed_LIF.eedDedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,Eed_LIF.eedBenStartDate)
                                        END*/
                                        
        ,drvLIFCoverageTerminationDate =  CASE WHEN bdmDedCode = 'OPLEE' AND NOT (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN Eed_LIF.eedBenStopDate END    
                                        --CASE WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,Eed_LIF.eedBenStartDate)
                                --                WHEN eed_LIF.eedDedCode IS NOT NULL AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) AND Eed_LIF.eedBenStopDate IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,Eed_LIF.eedBenStopDate) 
                                --            END
        ,drvLIFFaceAmt = CASE WHEN bdmDedCode = 'OPLEE' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN 
                            CASE WHEN cast(Eed_LIF.eedBenAmt as int) = 0 THEN cast('0' as varchar(20)) 
                            ELSE cast(cast(nullif(Eed_LIF.eedBenAmt,0.00) as int) as varchar(20)) END 
                        END
                            /*CASE WHEN bdmDedCode = 'OPLEE' AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN 
                            CASE WHEN cast(Eed_LIF.eedBenAmt as int) = 0 THEN cast('0' as varchar(20)) 
                            ELSE cast(cast(nullif(Eed_LIF.eedBenAmt,0.00) as int) as varchar(20)) END 
                        END*/
        ,drvLIFReqAmt =  CASE WHEN bdmDedCode = 'OPLEE' AND  (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN cast(cast(Eed_LIF.eedUSGField1 as int) as varchar(20)) END
        --CASE WHEN bdmDedCode = 'OPLEE' AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN cast(cast(Eed_LIF.eedUSGField1 as int) as varchar(20)) END
            
        ,drvLIFEmployeeGroupID =    CASE WHEN bdmDedCode = 'OPLEE' THEN -- AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN
                                        CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                            WHEN E.EecPayGroup = 'GGH' THEN
                                                CASE WHEN EecOrgLvl3 = '432' THEN '8'
                                                    WHEN EecOrgLvl3 = '520' THEN '6'
                                                    WHEN EecOrgLvl3 = '610' THEN '9'
                                                    WHEN EecOrgLvl3 = '412' THEN '10'
                                                    WHEN EecOrgLvl3 = '430' THEN '11'
                                                    WHEN EecOrgLvl3 = '465' THEN '12'
                                                    WHEN EecOrgLvl3 = '630' THEN '32'
                                                    WHEN EecOrgLvl3 = '436' THEN '13'
                                                    WHEN EecOrgLvl3 in ('425','440') THEN '14'
                                                    WHEN EecOrgLvl3 = '640' THEN '28'
                                                    WHEN EecOrgLvl3 = '510' THEN '16'
                                                    WHEN EecOrgLvl3 = '410' THEN '15'
                                                END
                                        
                                            WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '30'
                                            WHEN E.EecPayGroup = 'GGSOE' THEN '30'
                                            ELSE '1'
                                        END
                                    END
                                    
        
        ,drvLIFEmployeeClassCode = CASE WHEN bdmDedCode = 'OPLEE' then
                                            CASE WHEN (E.EecUnionLocal IS NOT NULL AND  E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN ''
                                            ELSE
                                                CASE WHEN E.EecSalaryOrHourly = 'S' THEN '2'
                                                WHEN E.EecSalaryOrHourly <> 'S' THEN '1'
                                                END 
                                            END
                                        END
                                /*    CASE WHEN bdmDedCode = 'OPLEE' AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN
                                         CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                         WHEN E.EecPayGroup NOT IN ('GGSON') AND E.EecSalaryOrHourly = 'S' THEN '2'
                                         WHEN E.EecPayGroup NOT IN ('GGSON') AND E.EecSalaryOrHourly <> 'S' THEN '1'
                                         END 
                                    END*/
                                    
        --END - Section Code= "~LIF~"
        --START - Section Code= "~ADD~"
        ,drvADDCoverageEffectiveDate = '' --CASE WHEN eed_LIF.eedeeid IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,Eed_LIF.eedBenStartDate) END
        ,drvADDCoverageTerminationDate = '' -- CASE WHEN eed_LIF.eedeeid IS NOT NULL AND Eed_LIF.eedBenStopDate IS NOT NULL  THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,Eed_LIF.eedBenStopDate) END
        ,drvADDFaceAmt = '' -- CASE WHEN eed_LIF.eedeeid IS NOT NULL THEN dbo.dsi_fnPadZero(cast(Eed_LIF.eedBenAmt as int) ,11,0) END
        ,drvADDReqAmt = '' -- CASE WHEN eed_LIF.eedeeid IS NOT NULL THEN dbo.dsi_fnPadZero(cast(Eed_LIF.eedBenAmt as int) ,11,0) END
        ,drvADDEmployeeGroupID = '' -- CASE WHEN eed_LIF.eedeeid IS NOT NULL  THEN '1' END 
        ,drvADDEmployeeClassCode = '' -- CASE WHEN eed_LIF.eedeeid IS NOT NULL  THEN '1' END 
        --END - Section Code= "~ADD~"
        --START - Section Code= "~SPL~"
        --check
        ,drvSPLCoverageEffectiveDate =  CASE WHEN bdmDedCode = 'OPLSP' AND NOT (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',bdmBenStartDate)
                                            WHEN bdmDedCode = 'OPLSP' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate)
                                        END
                                        
                            /*CASE WHEN bdmDedCode = 'OPLSP' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate) END*/
        ,drvSPLCoverageTerminationDate =  CASE WHEN bdmDedCode = 'OPLSP' AND NOT (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN bdmBenStopDate END
                                     /*CASE WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate)
                                                WHEN bdmDedCode = 'OPLSP' AND (bdmDepRecID IS NOT NULL AND bdmBenStopDate IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStopDate) 
                                        END*/
        ,drvSPLFaceAmt =  CASE WHEN bdmDedCode = 'OPLSP' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN CASE WHEN cast(eed_SPL.eedBenAmt as int) = 0 THEN cast('0' as varchar(20)) ELSE cast(cast(nullif(eed_SPL.eedBenAmt,0.00) as int) as varchar(20)) END END
        ,drvSPLReqAmt =  CASE WHEN bdmDedCode = 'OPLSP' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN cast(cast(eed_SPL.eedUSGField1 as int) as varchar(20)) END
        ,drvSPLEmployeeGroupID =    --CASE WHEN bdmDedCode = 'OPLSP' AND NOT (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916')) THEN
                                        --CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                    CASE WHEN bdmDedCode = 'OPLSP' then -- AND NOT (E.EecUnionLocal IS NULL or E.EecUnionLocal  not IN ('786','673','026','179','364','916')) THEN
                                        CASE WHEN E.EecUnionLocal IS not NULL and E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                            WHEN E.EecPayGroup = 'GGH' THEN
                                                CASE WHEN EecOrgLvl3 = '432' THEN '8'
                                                    WHEN EecOrgLvl3 = '520' THEN '6'
                                                    WHEN EecOrgLvl3 = '610' THEN '9'
                                                    WHEN EecOrgLvl3 = '412' THEN '10'
                                                    WHEN EecOrgLvl3 = '430' THEN '11'
                                                    WHEN EecOrgLvl3 = '465' THEN '12'
                                                    WHEN EecOrgLvl3 = '630' THEN '32'
                                                    WHEN EecOrgLvl3 = '436' THEN '13'
                                                    WHEN EecOrgLvl3 in ('425','440') THEN '14'
                                                    WHEN EecOrgLvl3 = '640' THEN '28'
                                                    WHEN EecOrgLvl3 = '510' THEN '16'
                                                    WHEN EecOrgLvl3 = '410' THEN '15'
                                                END
                                            
                                            WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '30'
                                            WHEN E.EecPayGroup = 'GGSOE' THEN '30'
                                            ELSE '1'
                                        END
                                    END
                                    
        ,drvSPLEmployeeClassCode =    CASE WHEN bdmDedCode = 'OPLSP' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN    
                                        CASE WHEN E.EecSalaryOrHourly = 'S' THEN '2' 
                                        ELSE '1' 
                                        END
                                    END
                                    
        --END - Section Code= "~SPL~"
        --START - Section Code= "~DPL~"
        -- check
        ,drvDPLCoverageEffectiveDate =    CASE WHEN bdmDedCode = 'OPTCH' AND NOT (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',bdmBenStartDate)
                                            WHEN bdmDedCode = 'OPTCH' AND (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate)
                                        END
        
                                    /*CASE WHEN (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN  ('786','673','026','179','364','916'))) OR (E.EecPayGroup = 'GGH' AND E.EecOrgLvl3 IN ('630','640')) OR (E.EecPayGroup = 'GGSOE') THEN dbo.dsi_fnGetMinMaxDates('MAX','8/1/2021',bdmBenStartDate) --'8/1/2021'
                                            WHEN bdmDedCode = 'OPTCH' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate) 
                                      END*/
        ,drvDPLCoverageTerminationDate = CASE WHEN bdmDedCode = 'OPTCH' AND NOT (E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916'))) THEN bdmBenStopDate END
                                        /*CASE WHEN E.EecEmplStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStartDate)
                                                WHEN bdmDedCode = 'OPTCH' AND (bdmDepRecID IS NOT NULL AND bdmBenStopDate IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate,bdmBenStopDate) 
                                            END*/
        ,drvDPLFaceAmt =  CASE WHEN bdmDedCode = 'OPTCH' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN '10000' END --dbo.dsi_fnPadZero(cast(10000 as int) ,11,0) END
        ,drvDPLReqAmt =  CASE WHEN bdmDedCode = 'OPTCH' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN '10000' END -- dbo.dsi_fnPadZero(cast(10000 as int) ,11,0) END
        ,drvDPLEmployeeGroupID =    CASE WHEN bdmDedCode = 'OPTCH' AND bdmDepRecID IS NOT NULL THEN
                                         CASE WHEN E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916') THEN ''
                                         WHEN E.EecPayGroup = 'GGSON' AND (E.EecUnionLocal IS NULL OR E.EecUnionLocal NOT IN ('786','673','026','179','364','916')) THEN '30'
                                         WHEN E.EecPayGroup = 'GGSOE' THEN '30'
                                         WHEN EecPayGroup NOT IN ('GGSOE','GGSON','GGH') THEN '1'
                                         WHEN E.EecPayGroup = 'GGH' THEN
                                                CASE WHEN EecOrgLvl3 = '432' THEN '8'
                                                    WHEN EecOrgLvl3 = '520' THEN '6'
                                                    WHEN EecOrgLvl3 = '610' THEN '9'
                                                    WHEN EecOrgLvl3 = '412' THEN '10'
                                                    WHEN EecOrgLvl3 = '430' THEN '11'
                                                    WHEN EecOrgLvl3 = '465' THEN '12'
                                                    WHEN EecOrgLvl3 = '630' THEN '32'
                                                    WHEN EecOrgLvl3 = '436' THEN '13'
                                                    WHEN EecOrgLvl3 in ('425','440') THEN '14'
                                                    WHEN EecOrgLvl3 = '640' THEN '28'
                                                    WHEN EecOrgLvl3 = '510' THEN '16'
                                                    WHEN EecOrgLvl3 = '410' THEN '15'
                                                END 
                                         END
                                    END
                                
        ,drvDPLEmployeeClassCode =    CASE WHEN bdmDedCode = 'OPTCH' AND (bdmDepRecID IS NOT NULL OR (E.EecPayGroup = 'GGSON' AND E.EecUnionLocal IN ('786','673','026','179','364','916'))) THEN 
                                        CASE WHEN E.EecSalaryOrHourly = 'S' THEN '2' ELSE '1' END
                                    END 
        --END - Section Code= "~DPL~"
        ,drvLMS = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL
                       WHEN E.eecEETYpe NOT IN ('TMP', 'INT') THEN 'Y' 
                       ELSE 'N' END
        ,drvKeyEE = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL
                       WHEN E.eecEETYpe NOT IN ('TMP', 'INT') AND E.eecAnnSalary > 100000.00  THEN 'Y' 
                       ELSE 'N' END
        ,drvLast12MonthsHours = CASE WHEN bdmDepRecID IS NOT NULL THEN NULL ELSE dbo.dsi_fnPadZero(ISNULL(CONVERT(MONEY,pehYTDHrs),0.00) * 100,6,0) END
        ,drvCumulativeHoursEndDate = GETDATE() --COALESCE(PrgPeriodEndDate,@EndDate)
        ,drvCumulativeHoursNumOfWeeks = '52'/* CASE WHEN PrgPayDate IS NULL THEN '1'
                                             WHEN E.EecDateOfSeniority < DATEADD(MONTH,-12,@EndDate) THEN '52'
                                             WHEN DATEDIFF(WEEK,E.EecDateOfSeniority,PrgPeriodEndDate) < 1 THEN '1'
                                             ELSE DATEDIFF(WEEK,E.EecDateOfSeniority,PrgPeriodEndDate)
                                        END*/
    INTO dbo.U_EHARTFDIDM_drvTbl
    FROM dbo.U_EHARTFDIDM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp E WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_dsi_bdm_EHARTFDIDM  WITH (NOLOCK)
        ON bdmEEID = xEEID  
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions eed_LIF WITH (NOLOCK)
        ON eed_LIF.EedEEID = xEEID 
        AND eed_LIF.EedCoID = xCoID
        AND eed_LIF.EedFormatCode = @FormatCode 
        AND eed_LIF.EedValidForExport = 'Y'
        AND eed_LIF.EedBenStatus <> 'W'
        AND eed_LIF.eedDedCode = 'OPLEE'
        --AND eed_LIF.eedDedCode = bdmDedCode
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions eed_SPL WITH (NOLOCK)
        ON eed_SPL.EedEEID = xEEID 
        AND eed_SPL.EedCoID = xCoID
        AND eed_SPL.EedFormatCode = @FormatCode 
        AND eed_SPL.EedValidForExport = 'Y'
        AND eed_SPL.EedBenStatus <> 'W'
        AND eed_SPL.eedDedCode = 'OPLSP'
        AND eed_SPL.eedDedCode = bdmDedCode
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions eed_CH WITH (NOLOCK)
        ON eed_CH.EedEEID = xEEID 
        AND eed_CH.EedCoID = xCoID
        AND eed_CH.EedFormatCode = @FormatCode 
        AND eed_CH.EedValidForExport = 'Y'
        AND eed_CH.EedBenStatus <> 'W'
        AND eed_CH.eedDedCode = 'OPTCH'
        AND eed_CH.eedDedCode = bdmDedCode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xeeid
        and ConSystemID = bdmDepRecID
        and bdmDepRecID IS NOT NULL
    LEFT JOIN dbo.U_EHARTFDIDM_ISOCountryCodeMapping EA WITH (NOLOCK)
        ON EA.cCountryCode = EepAddressCountry
    LEFT JOIN dbo.U_EHARTFDIDM_ISOCountryCodeMapping LA WITH (NOLOCK)
        ON LA.cCountryCode = LocAddressCountry
    LEFT JOIN dbo.U_EHARTFDIDM_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EHARTFDIDM_Audit WITH (NOLOCK)
        ON audeeid = xeeid
    --LEFT JOIN dbo.EmpComp Supervisor WITH (NOLOCK)
    --    ON Supervisor.EecEEID = E.EecSupervisorID
     WHERE (E.EecEmplStatus <> 'T' OR audTerm = 'Y')
     AND (bdmDedCode IS NULL 
          OR bdmDedCode = 'OPLEE' 
          OR (bdmDedCode IN ('OPLSP','OPTCH') AND bdmDepRecID IS NOT NULL)
          OR (bdmDedCode IN ('OPLSP','OPTCH') AND bdmDepRecID IS NULL AND eed_LIF.EedEEID IS NULL) )
    

    /*GROUP BY xEEID,xCoID,EepSSN,E.EecEmpNo,EepNameLast,EepNameFirst,EepNameMiddle,EepNamePrefix,EepNameSuffix,EepDateOfBirth,EepGender
        ,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepAddressCountry,EA.cISO3166Value,EepPhoneHomeNumber
        ,EepAddressEMail,CmpCompanyCode,LocAddressState,LA.cISO3166Value,E.EecPhoneBusinessNumber,Supervisor.EecEmpNo,E.EecEmplStatus,E.EecTermReason
        ,E.EecEEType,E.EecDateOfTermination,E.EecDateofSeniority,E.EecDateOfLastHire,E.EecDateOfOriginalHire,E.EecFullTimeOrPartTime,JbcFLSAType
        ,E.EecScheduledWorkHrs,E.EecSalaryOrHourly,JbcSalaryGrade,JbcDesc,E.EecUnionLocal,E.EecJobCode,PehCurHrs,E.EecAnnSalary,PrgPeriodEndDate
        ,E.EecDateOfLastHire,PrgPayDate,E.EecEmplStatusStartDate;*/

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHARTFDIDM_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EHARTFDIDM_Header;
    SELECT DISTINCT
         drvDetailCount = '1'--COUNT(DISTINCT drvEmployeeSSN)
        ,drvFileName = @FileName
        ,drvRunDate = @RunDate
    INTO dbo.U_EHARTFDIDM_Header
    FROM dbo.U_EHARTFDIDM_drvTbl;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHARTFDIDM_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EHARTFDIDM_Trailer;
    SELECT DISTINCT
         drvRecordCount = COUNT(*)
    INTO dbo.U_EHARTFDIDM_Trailer
    FROM dbo.U_EHARTFDIDM_drvTbl;

    --===============================================================
    -- Override Record Count - Large File Driver Table Duplicated
    --===============================================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_EHARTFDIDM_drvTbl) + 2;

    EXEC dbo.dsi_sp_UpdateConfig @FormatCode, 'OverrideCount','V', @RecordCount;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = @FileName
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEHARTFDIDM_Export AS
    SELECT TOP 20000000 Data = D10.Data + ISNULL(D20.Data,'')
    FROM dbo.U_EHARTFDIDM_File (NOLOCK) D10
    LEFT JOIN dbo.U_EHARTFDIDM_File (NOLOCK) D20
        ON D10.InitialSort = D20.InitialSort
        AND D10.SubSort = D20.SubSort
        AND D20.RecordSet = 'D20'
    WHERE D10.RecordSet <> 'D20'
    ORDER BY RIGHT(D10.RecordSet,2), D10.InitialSort, D10.SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHARTFDIDM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102251'
       ,expStartPerControl     = '202102251'
       ,expLastEndPerControl   = '202102259'
       ,expEndPerControl       = '202102259'
WHERE expFormatCode = 'EHARTFDIDM';

--=================================================
-- Create ISO 3166 Mappings based on Country Name
--=================================================
IF OBJECT_ID('U_EHARTFDIDM_ISOCountryCodeMapping','U') IS NOT NULL
    DROP TABLE dbo.U_EHARTFDIDM_ISOCountryCodeMapping;
CREATE TABLE dbo.U_EHARTFDIDM_ISOCountryCodeMapping (
     cCountryCode VARCHAR(10)
    ,cCountryName VARCHAR(200)
    ,cISO3166Value VARCHAR(10)
);

INSERT INTO dbo.U_EHARTFDIDM_ISOCountryCodeMapping (cCountryCode,cCountryName,cISO3166Value) VALUES
     ('AFG', 'Afghanistan', '004')
    ,('ALA', 'Aland Islands', '248')
    ,('ALB', 'Albania', '008')
    ,('DZA', 'Algeria', '012')
    ,('ASM', 'American Samoa', '016')
    ,('AND', 'Andorra', '020')
    ,('AGO', 'Angola', '024')
    ,('AIA', 'Anguilla', '660')
    ,('ATA', 'Antarctica', '010')
    ,('ATG', 'Antigua and Barbuda', '028')
    ,('ARG', 'Argentina', '032')
    ,('ARM', 'Armenia', '051')
    ,('ABW', 'Aruba', '533')
    ,('AUS', 'Australia', '036')
    ,('AUT', 'Austria', '040')
    ,('AZE', 'Azerbaijan', '031')
    ,('BHS', 'Bahamas', '044')
    ,('BHR', 'Bahrain', '048')
    ,('BGD', 'Bangladesh', '050')
    ,('BRB', 'Barbados', '052')
    ,('BLR', 'Belarus', '112')
    ,('BEL', 'Belgium', '056')
    ,('BLZ', 'Belize', '084')
    ,('BEN', 'Benin', '204')
    ,('BMU', 'Bermuda', '060')
    ,('BTN', 'Bhutan', '064')
    ,('BOL', 'Bolivia', '068')
    ,('BES', 'Bonaire, Sint Eustatius and Saba', '535')
    ,('BIH', 'Bosnia and Herzegovina', '070')
    ,('BWA', 'Botswana', '072')
    ,('BVT', 'Bouvet Island', '074')
    ,('BRA', 'Brazil', '076')
    ,('VGB', 'Virgin Islands (British)', '092')
    ,('BRN', 'Brunei Darussalam', '096')
    ,('BGR', 'Bulgaria', '100')
    ,('BFA', 'Burkina Faso', '854')
    ,('BDI', 'Burundi', '108')
    ,('KHM', 'Cambodia', '116')
    ,('CMR', 'Cameroon', '120')
    ,('CAN', 'Canada', '124')
    ,('CPV', 'Cape Verde', '132')
    ,('CYM', 'Cayman Islands', '136')
    ,('CAF', 'Central African Republic', '140')
    ,('TCD', 'Chad', '148')
    ,('CHL', 'Chile', '152')
    ,('CHN', 'China', '156')
    ,('CXR', 'Christmas Island', '162')
    ,('CCK', 'Cocos (Keeling) Islands', '166')
    ,('COL', 'Colombia', '170')
    ,('COM', 'Comoros', '174')
    ,('COG', 'Congo', '178')
    ,('COK', 'Cook Islands', '184')
    ,('CRI', 'Costa Rica', '188')
    ,('CIV', 'Cote dIvoire', '384')
    ,('HRV', 'Croatia', '191')
    ,('CUB', 'Cuba', '192')
    ,('CUW', 'Curacao', '531')
    ,('CYP', 'Cyprus', '196')
    ,('CZE', 'Czech Republic', '203')
    ,('DNK', 'Denmark', '208')
    ,('DJI', 'Djibouti', '262')
    ,('DMA', 'Dominica', '212')
    ,('DOM', 'Dominican Republic', '214')
    ,('ECU', 'Ecuador', '218')
    ,('EGY', 'Egypt', '818')
    ,('SLV', 'El Salvador', '222')
    ,('GNQ', 'Equatorial Guinea', '226')
    ,('ERI', 'Eritrea', '232')
    ,('EST', 'Estonia', '233')
    ,('ETH', 'Ethiopia', '231')
    ,('FRO', 'Faroe Islands', '234')
    ,('FLK', 'Falkland Islands (Malvinas)', '238')
    ,('FJI', 'Fiji', '242')
    ,('FIN', 'Finland', '246')
    ,('FRA', 'France', '250')
    ,('PYF', 'French Guiana', '254')
    ,('GUF', 'French Polynesia', '258')
    ,('ATF', 'French Southern Territories', '260')
    ,('GAB', 'Gabon', '266')
    ,('GMB', 'Gambia', '270')
    ,('GEO', 'Georgia', '268')
    ,('DEU', 'Germany', '276')
    ,('GHA', 'Ghana', '288')
    ,('GIB', 'Gibraltar', '292')
    ,('GRC', 'Greece', '300')
    ,('GRL', 'Greenland', '304')
    ,('GRD', 'Grenada', '308')
    ,('GLP', 'Guadeloupe', '312')
    ,('GUM', 'Guam', '316')
    ,('GTM', 'Guatemala', '320')
    ,('GGY', 'Guernsey', '831')
    ,('GIN', 'Guinea', '324')
    ,('GNB', 'Guinea-Bissau', '624')
    ,('GUY', 'Guyana', '328')
    ,('HTI', 'Haiti', '332')
    ,('HMD', 'Heard Island and McDonald Islands', '334')
    ,('VAT', 'Holy See (Vatican City State)', '336')
    ,('HND', 'Honduras', '340')
    ,('HKG', 'Hong Kong', '344')
    ,('HUN', 'Hungary', '348')
    ,('ISL', 'Iceland', '352')
    ,('IND', 'India', '356')
    ,('IDN', 'Indonesia', '360')
    ,('IRN', 'Iran (Islamic Republic of)', '364')
    ,('IRQ', 'Iraq', '368')
    ,('IRL', 'Ireland', '372')
    ,('IMN', 'Isle of Man', '833')
    ,('ISR', 'Israel', '376')
    ,('ITA', 'Italy', '380')
    ,('JAM', 'Jamaica', '388')
    ,('JPN', 'Japan', '392')
    ,('JER', 'Jersey', '832')
    ,('JOR', 'Jordan', '400')
    ,('KAZ', 'Kazakhstan', '398')
    ,('KEN', 'Kenya', '404')
    ,('KIR', 'Kiribati', '296')
    ,('KWT', 'Kuwait', '414')
    ,('KGZ', 'Kyrgyzstan', '417')
    ,('LAO', 'Lao Peoples Democratic Republic', '418')
    ,('LVA', 'Latvia', '428')
    ,('LBN', 'Lebanon', '422')
    ,('LSO', 'Lesotho', '426')
    ,('LBR', 'Liberia', '430')
    ,('LBY', 'Libya', '434')
    ,('LIE', 'Liechtenstein', '438')
    ,('LTU', 'Lithuania', '440')
    ,('LUX', 'Luxembourg', '442')
    ,('MAC', 'Macao', '446')
    ,('MDG', 'Madagascar', '450')
    ,('MWI', 'Malawi', '454')
    ,('MYS', 'Malaysia', '458')
    ,('MDV', 'Maldives', '462')
    ,('MLI', 'Mali', '466')
    ,('MLT', 'Malta', '470')
    ,('MHL', 'Marshall Islands', '584')
    ,('MTQ', 'Martinique', '474')
    ,('MRT', 'Mauritania', '478')
    ,('MUS', 'Mauritius', '480')
    ,('MYT', 'Mayotte', '175')
    ,('MEX', 'Mexico', '484')
    ,('FSM', 'Micronesia (Federated States of)', '583')
    ,('MCO', 'Monaco', '492')
    ,('MNG', 'Mongolia', '496')
    ,('MNE', 'Montenegro', '499')
    ,('MSR', 'Montserrat', '500')
    ,('MAR', 'Morocco', '504')
    ,('MOZ', 'Mozambique', '508')
    ,('MMR', 'Myanmar', '104')
    ,('NAM', 'Namibia', '516')
    ,('NRU', 'Nauru', '520')
    ,('NPL', 'Nepal', '524')
    ,('NLD', 'Netherlands', '528')
    ,('NCL', 'New Caledonia', '540')
    ,('NZL', 'New Zealand', '554')
    ,('NIC', 'Nicaragua', '558')
    ,('NER', 'Niger', '562')
    ,('NGA', 'Nigeria', '566')
    ,('NIU', 'Niue', '570')
    ,('NFK', 'Norfolk Island', '574')
    ,('MNP', 'Northern Mariana Islands', '580')
    ,('NOR', 'Norway', '578')
    ,('OMN', 'Oman', '512')
    ,('PAK', 'Pakistan', '586')
    ,('PLW', 'Palau', '585')
    ,('PSE', 'Palestine, State of', '275')
    ,('PAN', 'Panama', '591')
    ,('PNG', 'Papua New Guinea', '598')
    ,('PRY', 'Paraguay', '600')
    ,('PER', 'Peru', '604')
    ,('PHL', 'Philippines', '608')
    ,('PCN', 'Pitcairn', '612')
    ,('POL', 'Poland', '616')
    ,('PRT', 'Portugal', '620')
    ,('PRI', 'Puerto Rico', '630')
    ,('QAT', 'Qatar', '634')
    ,('REU', 'Reunion', '638')
    ,('ROU', 'Romania', '642')
    ,('RUS', 'Russian Federation', '643')
    ,('RWA', 'Rwanda', '646')
    ,('BLM', 'Saint Barthelemy', '652')
    ,('SHN', 'Saint Helena, Ascension and Tristan da Cunha', '654')
    ,('KNA', 'Saint Kitts and Nevis', '659')
    ,('LCA', 'Saint Lucia', '662')
    ,('MAF', 'Saint Martin (French part)', '663')
    ,('SPM', 'Saint Pierre and Miquelon', '666')
    ,('VCT', 'Saint Vincent and the Grenadines', '670')
    ,('WSM', 'Samoa', '882')
    ,('SMR', 'San Marino', '674')
    ,('STP', 'Sao Tome and Principe', '678')
    ,('SAU', 'Saudi Arabia', '682')
    ,('SEN', 'Senegal', '686')
    ,('SRB', 'Serbia', '688')
    ,('SYC', 'Seychelles', '690')
    ,('SLE', 'Sierra Leone', '694')
    ,('SGP', 'Singapore', '702')
    ,('SXM', 'Sint Maarten (Dutch part)', '534')
    ,('SVK', 'Slovakia', '703')
    ,('SVN', 'Slovenia', '705')
    ,('SLB', 'Solomon Islands', '090')
    ,('SOM', 'Somalia', '706')
    ,('ZAF', 'South Africa', '710')
    ,('SGS', 'South Georgia and the South Sandwich Islands', '239')
    ,('SSD', 'South Sudan', '728')
    ,('ESP', 'Spain', '724')
    ,('LKA', 'Sri Lanka', '144')
    ,('SDN', 'Sudan', '729')
    ,('SUR', 'Suriname', '740')
    ,('SJM', 'Svalbard and Jan Mayen', '744')
    ,('SWZ', 'Swaziland', '748')
    ,('SWE', 'Sweden', '752')
    ,('CHE', 'Switzerland', '756')
    ,('SYR', 'Syrian Arab Republic', '760')
    ,('TWN', 'Taiwan, Province of China[a]', '158')
    ,('TJK', 'Tajikistan', '762')
    ,('THA', 'Thailand', '764')
    ,('TLS', 'Timor-Leste', '626')
    ,('TGO', 'Togo', '768')
    ,('TKL', 'Tokelau', '772')
    ,('TON', 'Tonga', '776')
    ,('TTO', 'Trinidad and Tobago', '780')
    ,('TUN', 'Tunisia', '788')
    ,('TUR', 'Turkey', '792')
    ,('TKM', 'Turkmenistan', '795')
    ,('TCA', 'Turks and Caicos Islands', '796')
    ,('TUV', 'Tuvalu', '798')
    ,('UGA', 'Uganda', '800')
    ,('UKR', 'Ukraine', '804')
    ,('ARE', 'United Arab Emirates', '784')
    ,('GBR', 'United Kingdom of Great Britain and Northern Ireland', '826')
    ,('USA', 'United States of America', '840')
    ,('VIR', 'Virgin Islands (U.S.)', '850')
    ,('URY', 'Uruguay', '858')
    ,('UMI', 'United States Minor Outlying Islands', '581')
    ,('UZB', 'Uzbekistan', '860')
    ,('VUT', 'Vanuatu', '548')
    ,('VEN', 'Venezuela', '862')
    ,('VNM', 'Viet Nam', '704')
    ,('WLF', 'Wallis and Futuna', '876')
    ,('ESH', 'Western Sahara', '732')
    ,('YEM', 'Yemen', '887')
    ,('ZMB', 'Zambia', '894')
    ,('ZWE', 'Zimbabwe', '716');

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHARTFDIDM_Export AS
    SELECT TOP 20000000 Data = D10.Data + ISNULL(D20.Data,'')
    FROM dbo.U_EHARTFDIDM_File (NOLOCK) D10
    LEFT JOIN dbo.U_EHARTFDIDM_File (NOLOCK) D20
        ON D10.InitialSort = D20.InitialSort
        AND D10.SubSort = D20.SubSort
        AND D20.RecordSet = 'D20'
    WHERE D10.RecordSet <> 'D20'
    ORDER BY RIGHT(D10.RecordSet,2), D10.InitialSort, D10.SubSort;
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetPhoneNumber_EHARTFDIDM] (
@EEID      VARCHAR(12),
@PhoneType VARCHAR(3)
)

RETURNS VARCHAR(16)
WITH EXECUTE AS CALLER
AS

/************************************************************

Created By: John Transier
Create Date: 08/25/2017

Revision History
----------------
Update By            Date            Desc
XXXX                 XX/XX/16        Added 1234

Purpose: Pulls latest phone number for an employee
         
Description
-----------
Pulls latest phone number for an employee


Commands 
--------
SELECT EepEEID, EepPhoneHomeNumber, EepAddressEmail, dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL') FROM dbo.EmpPers

************************************************************/

BEGIN

DECLARE @Return VARCHAR(16)


-----------
-- Build table variable
-----------

-- This is done in a separate routine because the EE can have multiple cell phones/types of phones
 
SELECT @Return = a.EfoPhoneNumber
 
FROM EmpmPhon a
WHERE a.EfoEEID = @EEID
  AND a.EfoPhoneType = @PhoneType
  AND a.SystemID = (SELECT MAX(b.SystemID) FROM EmpmPhon b
                     WHERE b.EfoEEID = a.EfoEEID
                       AND b.EfoPhoneType = a.EfoPhoneType)


RETURN @Return

END
GO
CREATE  function [dbo].[fn_EndOfMonth_EHARTFDIDM](@inDate smalldatetime)
  returns char(10) as
  begin
    select @inDate = dateadd(m,1,@inDate)
    return convert(char(10),dateadd(dd,1,dateadd(d, -day(@inDate), @inDate)),101)
  end

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHARTFDIDM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHARTFDIDM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHARTFDIDM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHARTFDIDM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHARTFDIDM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHARTFDIDM', 'UseFileName', 'V', 'Y'


-- End ripout