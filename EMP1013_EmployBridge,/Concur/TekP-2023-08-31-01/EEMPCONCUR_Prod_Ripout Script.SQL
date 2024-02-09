/**********************************************************************************

EEMPCONCUR: Concur Export

FormatCode:     EEMPCONCUR
Project:        Concur Export
Client ID:      EMP1013
Date/time:      2024-02-08 16:03:14.567
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    N34
Server:         N3SUP4DB01
Database:       ULTIPRO_EMPBR
ExportPath:    \\us.saas\N0\data_exchange\EMP1013\Exports\
TestPath:      \\us.saas\n3\Public\EMP1013\Exports\Concur\
UTF8Path:      \\us.saas\n3\Public\EMP1013\Exports\UTF8\EEMPCONCUR\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EEMPCONCUR_SavePath') IS NOT NULL DROP TABLE dbo.U_EEMPCONCUR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EEMPCONCUR'


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
WHERE FormatCode = 'EEMPCONCUR'
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
WHERE ExpFormatCode = 'EEMPCONCUR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EEMPCONCUR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EEMPCONCUR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EEMPCONCUR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EEMPCONCUR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EEMPCONCUR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EEMPCONCUR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EEMPCONCUR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EEMPCONCUR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EEMPCONCUR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EEMPCONCUR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEEMPCONCUR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPCONCUR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPCONCUR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPCONCUR];
GO
IF OBJECT_ID('U_EEMPCONCUR_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_File];
GO
IF OBJECT_ID('U_EEMPCONCUR_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_EEList];
GO
IF OBJECT_ID('U_EEMPCONCUR_drvTbl350') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_drvTbl350];
GO
IF OBJECT_ID('U_EEMPCONCUR_drvTbl320') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_drvTbl320];
GO
IF OBJECT_ID('U_EEMPCONCUR_drvTbl305') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_drvTbl305];
GO
IF OBJECT_ID('U_EEMPCONCUR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_AuditFields];
GO
IF OBJECT_ID('U_EEMPCONCUR_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEMPCONCUR_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEMPCONCUR','Concur Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','8000','S','N','EEMPCONCURZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPCONCURZ0','50','H','02','1',NULL,'Trx Type',NULL,NULL,'"100"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPCONCURZ0','50','H','02','2',NULL,'Error Threshold',NULL,NULL,'"0"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPCONCURZ0','50','H','02','3',NULL,'Password Gen',NULL,NULL,'"welcome"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPCONCURZ0','50','H','02','4',NULL,'Existing Record Handling',NULL,NULL,'"UPDATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPCONCURZ0','50','H','02','5',NULL,'Lang Code',NULL,NULL,'"EN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPCONCURZ0','50','H','02','6',NULL,'Validate Expense Group',NULL,NULL,'"N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPCONCURZ0','50','H','02','7',NULL,'Validate Payment Group',NULL,NULL,'"N"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPCONCURZ0','50','D','30','1',NULL,'Trx Type',NULL,NULL,'"305"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPCONCURZ0','50','D','30','2',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPCONCURZ0','50','D','30','3',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPCONCURZ0','50','D','30','4',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPCONCURZ0','50','D','30','5',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPCONCURZ0','50','D','30','6',NULL,'Login ID',NULL,NULL,'"drvLoginID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPCONCURZ0','50','D','30','7',NULL,'Password',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMPCONCURZ0','50','D','30','8',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMPCONCURZ0','50','D','30','9',NULL,'Locale Code',NULL,NULL,'"en_US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EEMPCONCURZ0','50','D','30','10',NULL,'Ctry Code',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EEMPCONCURZ0','50','D','30','11',NULL,'Ctry Sub Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EEMPCONCURZ0','50','D','30','12',NULL,'Ledger Code',NULL,NULL,'"LAW"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EEMPCONCURZ0','50','D','30','13',NULL,'Reimbursement CRN Code',NULL,NULL,'"USD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EEMPCONCURZ0','50','D','30','14',NULL,'Cash Advance Account Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EEMPCONCURZ0','50','D','30','15',NULL,'Active',NULL,NULL,'"drvActive"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EEMPCONCURZ0','50','D','30','16',NULL,'Org Unit 1',NULL,NULL,'"drvOrgUnit1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EEMPCONCURZ0','50','D','30','17',NULL,'Org Unit 2',NULL,NULL,'"drvOrgUnit2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EEMPCONCURZ0','50','D','30','18',NULL,'Org Unit 3',NULL,NULL,'"drvOrgUnit3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EEMPCONCURZ0','50','D','30','19',NULL,'Org Unit 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EEMPCONCURZ0','50','D','30','20',NULL,'Org Unit 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EEMPCONCURZ0','50','D','30','21',NULL,'Org Unit 6',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EEMPCONCURZ0','50','D','30','22',NULL,'Custom 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EEMPCONCURZ0','50','D','30','23',NULL,'Custom 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EEMPCONCURZ0','50','D','30','24',NULL,'Custom 3',NULL,NULL,'"drvCustom3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EEMPCONCURZ0','50','D','30','25',NULL,'Custom 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EEMPCONCURZ0','50','D','30','26',NULL,'Custom 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EEMPCONCURZ0','50','D','30','27',NULL,'Custom 6',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EEMPCONCURZ0','50','D','30','28',NULL,'Custom 7',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EEMPCONCURZ0','50','D','30','29',NULL,'Custom 8',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EEMPCONCURZ0','50','D','30','30',NULL,'Custom 9',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EEMPCONCURZ0','50','D','30','31',NULL,'Custom 10',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EEMPCONCURZ0','50','D','30','32',NULL,'Custom 11',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EEMPCONCURZ0','50','D','30','33',NULL,'Custom 12',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EEMPCONCURZ0','50','D','30','34',NULL,'Custom 13',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EEMPCONCURZ0','50','D','30','35',NULL,'Custom 14',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EEMPCONCURZ0','50','D','30','36',NULL,'Custom 15',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EEMPCONCURZ0','50','D','30','37',NULL,'Custom 16',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EEMPCONCURZ0','50','D','30','38',NULL,'Custom 17 (AP Vendor ID)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EEMPCONCURZ0','50','D','30','39',NULL,'Custom 18',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EEMPCONCURZ0','50','D','30','40',NULL,'Custom 19',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EEMPCONCURZ0','50','D','30','41',NULL,'Custom 20',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EEMPCONCURZ0','50','D','30','42',NULL,'Custom 21 Concur Expense Group Hierarchy',NULL,NULL,'"CP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EEMPCONCURZ0','50','D','30','43',NULL,'Send email when the cash advance status changes',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EEMPCONCURZ0','50','D','30','44',NULL,'Send email when a cash advance is awaiting approva',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EEMPCONCURZ0','50','D','30','45',NULL,'Send email when the report status changes',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EEMPCONCURZ0','50','D','30','46',NULL,'Send email when a report is awaiting approval',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EEMPCONCURZ0','50','D','30','47',NULL,'Prompt for approver when submitting a report',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EEMPCONCURZ0','50','D','30','48',NULL,'Send email when the travel request status changes',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EEMPCONCURZ0','50','D','30','49',NULL,'Send email when a travel request is awaiting appro',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EEMPCONCURZ0','50','D','30','50',NULL,'Prompt for approver when submitting a travel reque',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EEMPCONCURZ0','50','D','30','51',NULL,'Send email when the payment status changes',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EEMPCONCURZ0','50','D','30','52',NULL,'Send email when a payment is awaiting approval',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EEMPCONCURZ0','50','D','30','53',NULL,'Prompt for approver when submitting a payment',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EEMPCONCURZ0','50','D','30','54',NULL,'Prompt to add company card transactions to report',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EEMPCONCURZ0','50','D','30','55',NULL,'Send email when new company card transactions arri',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EEMPCONCURZ0','50','D','30','56',NULL,'Send email when faxed receipts received',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EEMPCONCURZ0','50','D','30','57',NULL,'Display instructional help on the application page',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EEMPCONCURZ0','50','D','30','58',NULL,'Display imaging introduction page',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EEMPCONCURZ0','50','D','30','59',NULL,'Employee ID of the Expense Report Approver',NULL,NULL,'"drvEmployeeIDOfExpenseApp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EEMPCONCURZ0','50','D','30','60',NULL,'Employee ID of the Cash Advance Approver',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EEMPCONCURZ0','50','D','30','61',NULL,'Employee ID of the Request Approver',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EEMPCONCURZ0','50','D','30','62',NULL,'Employee ID of the Invoice Approver',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EEMPCONCURZ0','50','D','30','63',NULL,'Expense User',NULL,NULL,'"Y"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EEMPCONCURZ0','50','D','30','64',NULL,'Expense and/or Cash Advance Approver',NULL,NULL,'"drvExpenseOrCashApprover"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EEMPCONCURZ0','50','D','30','65',NULL,'Company Card Admin',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EEMPCONCURZ0','50','D','30','66',NULL,'Future Use',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EEMPCONCURZ0','50','D','30','67',NULL,'Receipt Processor',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EEMPCONCURZ0','50','D','30','68',NULL,'Future Use',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EEMPCONCURZ0','50','D','30','69',NULL,'Import/Extract Monitor',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EEMPCONCURZ0','50','D','30','70',NULL,'Company Info Admin',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EEMPCONCURZ0','50','D','30','71',NULL,'Offline User',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EEMPCONCURZ0','50','D','30','72',NULL,'Reporting Config Admin',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EEMPCONCURZ0','50','D','30','73',NULL,'Invoice User',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EEMPCONCURZ0','50','D','30','74',NULL,'Invoice Approver',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EEMPCONCURZ0','50','D','30','75',NULL,'Invoice Vendor Manager',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EEMPCONCURZ0','50','D','30','76',NULL,'Expense Audit Required',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EEMPCONCURZ0','50','D','30','77',NULL,'BI Manager Employee ID',NULL,NULL,'"drvBIManagerEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EEMPCONCURZ0','50','D','30','78',NULL,'Request User',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EEMPCONCURZ0','50','D','30','79',NULL,'Request Approver',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EEMPCONCURZ0','50','D','30','80',NULL,'Expense Report Approver Employee ID 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EEMPCONCURZ0','50','D','30','81',NULL,'A Payment Request has been Assigned',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EEMPCONCURZ0','50','D','30','82',NULL,'Future Use 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EEMPCONCURZ0','50','D','30','83',NULL,'Future Use 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EEMPCONCURZ0','50','D','30','84',NULL,'Tax Administrator',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EEMPCONCURZ0','50','D','30','85',NULL,'FBT Administrator',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EEMPCONCURZ0','50','D','30','86',NULL,'Travel Wizard User',NULL,NULL,'"Y"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EEMPCONCURZ0','50','D','30','87',NULL,'Custom 22 Concur Invoice Group Hierarchy',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EEMPCONCURZ0','50','D','30','88',NULL,'Request Approver Employee ID 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EEMPCONCURZ0','50','D','30','89',NULL,'Is Non Employee',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EEMPCONCURZ0','50','D','30','90',NULL,'Reimbursement Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EEMPCONCURZ0','50','D','30','91',NULL,'ADP Employee ID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EEMPCONCURZ0','50','D','30','92',NULL,'ADP Company Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EEMPCONCURZ0','50','D','30','93',NULL,'ADP Deduction Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EEMPCONCURZ0','50','D','30','94',NULL,'Budget Manager Employee ID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EEMPCONCURZ0','50','D','30','95',NULL,'Budget Owner',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EEMPCONCURZ0','50','D','30','96',NULL,'Budget Viewer',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EEMPCONCURZ0','50','D','30','97',NULL,'Budget Approver',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EEMPCONCURZ0','50','D','30','98',NULL,'Budget Admin',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EEMPCONCURZ0','50','D','30','99',NULL,'Future Use 12',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EEMPCONCURZ0','50','D','30','100',NULL,'Future Use 13',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EEMPCONCURZ0','50','D','30','101',NULL,'Future Use 14',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EEMPCONCURZ0','50','D','30','102',NULL,'Future Use 15',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EEMPCONCURZ0','50','D','30','103',NULL,'Future Use 16',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EEMPCONCURZ0','50','D','30','104',NULL,'Future Use 17',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EEMPCONCURZ0','50','D','30','105',NULL,'Future Use 18',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EEMPCONCURZ0','50','D','30','106',NULL,'Future Use 19',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EEMPCONCURZ0','50','D','30','107',NULL,'Future Use 20',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EEMPCONCURZ0','50','D','30','108',NULL,'Future Use 21',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EEMPCONCURZ0','50','D','30','109',NULL,'Future Use 22',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EEMPCONCURZ0','50','D','30','110',NULL,'Future Use 23',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EEMPCONCURZ0','50','D','30','111',NULL,'Future Use 24',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EEMPCONCURZ0','50','D','30','112',NULL,'Future Use 25',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EEMPCONCURZ0','50','D','30','113',NULL,'Future Use 26',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EEMPCONCURZ0','50','D','30','114',NULL,'Future Use 27',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EEMPCONCURZ0','50','D','30','115',NULL,'Future Use 28',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EEMPCONCURZ0','50','D','30','116',NULL,'Future Use 29',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EEMPCONCURZ0','50','D','30','117',NULL,'Future Use 30',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EEMPCONCURZ0','50','D','30','118',NULL,'Future Use 31',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EEMPCONCURZ0','50','D','30','119',NULL,'Future Use 32',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EEMPCONCURZ0','50','D','30','120',NULL,'Future Use 33',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EEMPCONCURZ0','50','D','30','121',NULL,'Future Use 34',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EEMPCONCURZ0','50','D','30','122',NULL,'Future Use 35',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EEMPCONCURZ0','50','D','30','123',NULL,'Future Use 36',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EEMPCONCURZ0','50','D','30','124',NULL,'Future Use 37',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EEMPCONCURZ0','50','D','30','125',NULL,'Future Use 38',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EEMPCONCURZ0','50','D','30','126',NULL,'Future Use 39',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EEMPCONCURZ0','50','D','30','127',NULL,'Future Use 40',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EEMPCONCURZ0','50','D','30','128',NULL,'Future Use 41',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EEMPCONCURZ0','50','D','30','129',NULL,'Future Use 42',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EEMPCONCURZ0','50','D','30','130',NULL,'Future Use 43',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EEMPCONCURZ0','50','D','30','131',NULL,'Future Use 44',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EEMPCONCURZ0','50','D','30','132',NULL,'Future Use 45',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EEMPCONCURZ0','50','D','30','133',NULL,'Future Use 46',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EEMPCONCURZ0','50','D','30','134',NULL,'Future Use 47',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EEMPCONCURZ0','50','D','30','135',NULL,'Future Use 48',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EEMPCONCURZ0','50','D','30','136',NULL,'Future Use 49',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EEMPCONCURZ0','50','D','30','137',NULL,'Future Use 50',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPCONCURZ0','50','D','40','1',NULL,'Trx Type',NULL,NULL,'"320"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPCONCURZ0','50','D','40','2',NULL,'Current Employee ID',NULL,NULL,'"drvCurrentEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPCONCURZ0','50','D','40','3',NULL,'New Employee ID',NULL,NULL,'"drvNewEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPCONCURZ0','50','D','40','4',NULL,'New Login ID',NULL,NULL,'"drvNewLoginID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPCONCURZ0','50','D','40','5',NULL,'Future Use 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPCONCURZ0','50','D','40','6',NULL,'Future Use 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPCONCURZ0','50','D','40','7',NULL,'Future Use 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMPCONCURZ0','50','D','40','8',NULL,'Future Use 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMPCONCURZ0','50','D','40','9',NULL,'Future Use 5',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPCONCURZ0','50','D','50','1',NULL,'Trx Type',NULL,NULL,'"350"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPCONCURZ0','50','D','50','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPCONCURZ0','50','D','50','3',NULL,'Name Prefix',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPCONCURZ0','50','D','50','4',NULL,'Name Suffix',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPCONCURZ0','50','D','50','5',NULL,'Nick Name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPCONCURZ0','50','D','50','6',NULL,'Redress Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPCONCURZ0','50','D','50','7',NULL,'Gender',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMPCONCURZ0','50','D','50','8',NULL,'Date of Birth',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMPCONCURZ0','50','D','50','9',NULL,'Employee ID of the Travel Approver',NULL,NULL,'"drvEmployeeIDOfTravApp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EEMPCONCURZ0','50','D','50','10',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EEMPCONCURZ0','50','D','50','11',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EEMPCONCURZ0','50','D','50','12',NULL,'Work Phone Extension',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EEMPCONCURZ0','50','D','50','13',NULL,'Work Fax',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EEMPCONCURZ0','50','D','50','14',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EEMPCONCURZ0','50','D','50','15',NULL,'Cell Phone',NULL,NULL,'"drvCellPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EEMPCONCURZ0','50','D','50','16',NULL,'Pager Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EEMPCONCURZ0','50','D','50','17',NULL,'Travel Name Remark',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EEMPCONCURZ0','76','D','50','18',NULL,'Travel Class Name',NULL,NULL,'"drvTravelClassName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EEMPCONCURZ0','50','D','50','19',NULL,'GDS Profile Name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EEMPCONCURZ0','50','D','50','20',NULL,'Org Unit/Division',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EEMPCONCURZ0','50','D','50','21',NULL,'Home Street Address',NULL,NULL,'"drvHomeStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EEMPCONCURZ0','50','D','50','22',NULL,'Home City',NULL,NULL,'"drvHomeCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EEMPCONCURZ0','50','D','50','23',NULL,'Home State',NULL,NULL,'"drvHomeState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EEMPCONCURZ0','50','D','50','24',NULL,'Home Postal Code',NULL,NULL,'"drvHomePostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EEMPCONCURZ0','50','D','50','25',NULL,'Home Country',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EEMPCONCURZ0','50','D','50','26',NULL,'Work Street Address',NULL,NULL,'"drvWorkStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EEMPCONCURZ0','50','D','50','27',NULL,'Work City',NULL,NULL,'"drvWorkCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EEMPCONCURZ0','50','D','50','28',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EEMPCONCURZ0','50','D','50','29',NULL,'Work Postal Code',NULL,NULL,'"drvWorkPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EEMPCONCURZ0','50','D','50','30',NULL,'Work Country',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EEMPCONCURZ0','50','D','50','31',NULL,'Email 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EEMPCONCURZ0','50','D','50','32',NULL,'Email 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EEMPCONCURZ0','50','D','50','33',NULL,'Custom 1',NULL,NULL,'"drvCustom1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EEMPCONCURZ0','50','D','50','34',NULL,'Custom 2',NULL,NULL,'"drvCustom2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EEMPCONCURZ0','50','D','50','35',NULL,'Custom 3',NULL,NULL,'"drvCustom3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EEMPCONCURZ0','50','D','50','36',NULL,'Custom 4',NULL,NULL,'"drvCustom4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EEMPCONCURZ0','50','D','50','37',NULL,'Custom 5',NULL,NULL,'"drvCustom5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EEMPCONCURZ0','50','D','50','38',NULL,'Custom 6',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EEMPCONCURZ0','50','D','50','39',NULL,'Custom 7',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EEMPCONCURZ0','50','D','50','40',NULL,'Custom 8',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EEMPCONCURZ0','50','D','50','41',NULL,'Custom 9',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EEMPCONCURZ0','50','D','50','42',NULL,'Custom 10',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EEMPCONCURZ0','50','D','50','43',NULL,'Custom 11',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EEMPCONCURZ0','50','D','50','44',NULL,'Custom 12',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EEMPCONCURZ0','50','D','50','45',NULL,'Custom 13',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EEMPCONCURZ0','50','D','50','46',NULL,'Custom 14',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EEMPCONCURZ0','50','D','50','47',NULL,'Custom 15',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EEMPCONCURZ0','50','D','50','48',NULL,'Custom 16',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EEMPCONCURZ0','50','D','50','49',NULL,'Custom 17',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EEMPCONCURZ0','50','D','50','50',NULL,'Custom 18',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EEMPCONCURZ0','50','D','50','51',NULL,'Custom 19',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EEMPCONCURZ0','50','D','50','52',NULL,'Custom 20',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EEMPCONCURZ0','50','D','50','53',NULL,'Custom 21',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EEMPCONCURZ0','50','D','50','54',NULL,'Custom 22',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EEMPCONCURZ0','50','D','50','55',NULL,'Custom 23',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EEMPCONCURZ0','50','D','50','56',NULL,'Custom 24',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EEMPCONCURZ0','50','D','50','57',NULL,'Custom 25',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EEMPCONCURZ0','50','D','50','58',NULL,'XML Profile Synchronization ID',NULL,NULL,'"drvXMLProfileSyncID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EEMPCONCURZ0','50','D','50','59',NULL,'Profile User Permission',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EEMPCONCURZ0','50','D','50','60',NULL,'Amadeus User Permission',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EEMPCONCURZ0','50','D','50','61',NULL,'Open Booking User Permission',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EEMPCONCURZ0','50','D','50','62',NULL,'Future Use 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EEMPCONCURZ0','50','D','50','63',NULL,'Future Use 6',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EEMPCONCURZ0','50','D','50','64',NULL,'Future Use 7',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EEMPCONCURZ0','50','D','50','65',NULL,'Future Use 8',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EEMPCONCURZ0','50','D','50','66',NULL,'Future Use 9',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EEMPCONCURZ0','50','D','50','67',NULL,'Future Use 10',NULL,NULL,'""','(''SS''=''T'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'305 & 350 On Demand','202402051','EMPEXPORT','ON_305-350','Feb  5 2024  2:21PM','EEMPCONCUR',NULL,NULL,NULL,'202402051','Feb  5 2024 12:00AM','Dec 30 1899 12:00AM','202402051','5885','','','202402051',dbo.fn_GetTimedKey(),NULL,'TGRAY',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'320 On Demand','202202231','EMPEXPORT','ON_320','Feb 23 2022  5:19PM','EEMPCONCUR',NULL,NULL,NULL,'202202231','Feb 23 2022 12:00AM','Dec 30 1899 12:00AM','202202091','3','','','202202091',dbo.fn_GetTimedKey(),NULL,'MSTEPHAN01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'305 & 350 Scheduled','201910319','EMPEXPORT','SC_305-350','Feb  7 2024  6:30PM','EEMPCONCUR',NULL,NULL,NULL,'202402079','Oct 31 2019  2:52PM','Oct 31 2019  2:52PM','202402071',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'320 Scheduled','201910319','EMPEXPORT','SC_320','Feb  7 2024  7:00PM','EEMPCONCUR',NULL,NULL,NULL,'202402079','Oct 31 2019  2:52PM','Oct 31 2019  2:52PM','202402071',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'320 Test','202310021','EMPEXPORT','TST_320','Oct  2 2023 12:00AM','EEMPCONCUR',NULL,NULL,NULL,'202310021','Oct  2 2023 12:00AM','Dec 30 1899 12:00AM','202309251','2','','','202309251',dbo.fn_GetTimedKey(),NULL,'us3kEpEMP1013',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'305 & 350 Test','202402051','EMPEXPORT','TST305-350','Feb  5 2024  2:29PM','EEMPCONCUR',NULL,NULL,NULL,'202402051','Feb  5 2024 12:00AM','Dec 30 1899 12:00AM','202402051','5885','','','202402051',dbo.fn_GetTimedKey(),NULL,'TGRAY',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','ExportPath','V','\\us.saas\N0\data_exchange\EMP1013\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','InitialSort','C','drvNameLastSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','IsUTF8','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','SubSort','C','drvNameFirstSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','TestPath','V','\\us.saas\n3\Public\EMP1013\Exports\Concur\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','UDESPath','C','\\us.saas\N0\data_exchange\EMP1013\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPCONCUR','UTF8Path','V','\\us.saas\n3\Public\EMP1013\Exports\UTF8\EEMPCONCUR\');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPCONCUR','D30','dbo.U_EEMPCONCUR_drvTbl305',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPCONCUR','D40','dbo.U_EEMPCONCUR_drvTbl320',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPCONCUR','D50','dbo.U_EEMPCONCUR_drvTbl350',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EEMPCONCUR_Audit
-----------

IF OBJECT_ID('U_EEMPCONCUR_Audit') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EEMPCONCUR_AuditFields
-----------

IF OBJECT_ID('U_EEMPCONCUR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EEMPCONCUR_drvTbl305
-----------

IF OBJECT_ID('U_EEMPCONCUR_drvTbl305') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_drvTbl305] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLastSort] varchar(100) NULL,
    [drvNameFirstSort] varchar(100) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvMiddleName] varchar(8000) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvLoginID] varchar(8000) NULL,
    [drvEmailAddress] varchar(8000) NULL,
    [drvActive] varchar(1) NOT NULL,
    [drvOrgUnit1] varchar(10) NULL,
    [drvOrgUnit2] varchar(1) NOT NULL,
    [drvOrgUnit3] varchar(10) NULL,
    [drvCustom3] varchar(24) NULL,
    [drvEmployeeIDOfExpenseApp] varchar(256) NULL,
    [drvExpenseOrCashApprover] varchar(256) NULL,
    [drvBIManagerEmployeeID] varchar(256) NULL
);

-----------
-- Create table U_EEMPCONCUR_drvTbl320
-----------

IF OBJECT_ID('U_EEMPCONCUR_drvTbl320') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_drvTbl320] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLastSort] varchar(100) NULL,
    [drvNameFirstSort] varchar(100) NULL,
    [drvCurrentEmployeeID] char(9) NULL,
    [drvNewEmployeeID] char(9) NULL,
    [drvNewLoginID] varchar(8000) NULL
);

-----------
-- Create table U_EEMPCONCUR_drvTbl350
-----------

IF OBJECT_ID('U_EEMPCONCUR_drvTbl350') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_drvTbl350] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLastSort] varchar(100) NULL,
    [drvNameFirstSort] varchar(100) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeIDOfTravApp] varchar(256) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvCellPhone] varchar(16) NULL,
    [drvTravelClassName] varchar(29) NULL,
    [drvHomeStreetAddress] varchar(8000) NOT NULL,
    [drvHomeCity] varchar(8000) NULL,
    [drvHomeState] varchar(255) NULL,
    [drvHomePostalCode] varchar(50) NULL,
    [drvWorkStreetAddress] varchar(8000) NOT NULL,
    [drvWorkCity] varchar(8000) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkPostalCode] varchar(50) NULL,
    [drvCustom1] varchar(13) NULL,
    [drvCustom2] varchar(8000) NULL,
    [drvCustom3] varchar(27) NULL,
    [drvCustom4] varchar(8000) NULL,
    [drvCustom5] varchar(8000) NULL,
    [drvXMLProfileSyncID] varchar(1) NOT NULL
);

-----------
-- Create table U_EEMPCONCUR_EEList
-----------

IF OBJECT_ID('U_EEMPCONCUR_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EEMPCONCUR_File
-----------

IF OBJECT_ID('U_EEMPCONCUR_File') IS NULL
CREATE TABLE [dbo].[U_EEMPCONCUR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] nvarchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPCONCUR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: EmployBridge, LLC

Created By: Ozzie Vazquez
Business Analyst: Kate Elliott
Create Date: 10/31/2019
Service Request Number: SR-2018-00212146

Purpose: Concur Export

Revision History
----------------
Update By           Date           Request Num        Desc
Ozzie Vazquez       6/30/2021      SR-2021-00307312   Updates per Spec V2.02
Marie Waters        2/09/2024      TekP-2023-08-31-01 Updates to custom4

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPCONCUR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPCONCUR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPCONCUR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMPCONCUR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPCONCUR' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
-- 305 & 350 File
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPCONCUR', 'ON_305-350';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPCONCUR', 'TST305-350';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPCONCUR', 'SC_305-350';

-- 320 File
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPCONCUR', 'ON_320';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPCONCUR', 'TST_320';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPCONCUR', 'SC_320';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EEMPCONCUR', @AllObjects = 'Y', @IsWeb = 'N'

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
    SELECT @FormatCode = 'EEMPCONCUR';

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
    DELETE FROM dbo.U_EEMPCONCUR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPCONCUR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Exclusion Criteria
    DELETE dbo.U_EEMPCONCUR_EEList
    FROM dbo.U_EEMPCONCUR_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    WHERE CmpCompanyCode <> 'ESMI'
        OR ISNULL(NULLIF(EecJobCode,''),'') IN ('EXEC0002','EXEC0006')
        OR ISNULL(NULLIF(EecOrgLvl2,''),'') = 'TERMBE'
        OR ISNULL(NULLIF(EepAddressEmail,''),'') = ''
    ;

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_EEMPCONCUR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPCONCUR_AuditFields;
    CREATE TABLE dbo.U_EEMPCONCUR_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EEMPCONCUR_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EEMPCONCUR_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EEMPCONCUR_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EEMPCONCUR_AuditFields VALUES ('EmpPers','EepAddressEmail');
    
    -- Create audit table
    IF OBJECT_ID('U_EEMPCONCUR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPCONCUR_Audit;
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
    INTO dbo.U_EEMPCONCUR_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EEMPCONCUR_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EEMPCONCUR_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate
      AND (adfFieldName <> 'EepAddressEmail'
        OR adfFieldName = 'EepAddressEmail' AND adfOldData IS NOT NULL);
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPCONCUR_Audit ON dbo.U_EEMPCONCUR_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMPCONCUR_drvTbl305
    ---------------------------------
    IF OBJECT_ID('U_EEMPCONCUR_drvTbl305','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPCONCUR_drvTbl305;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvNameLastSort = EepNameLast
        ,drvNameFirstSort = EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvFirstName = REPLACE(REPLACE(REPLACE(REPLACE(EepNameFirst,CHAR(145),''),CHAR(146),''),'''',''),',','')
        ,drvMiddleName = REPLACE(REPLACE(REPLACE(REPLACE(EepNameMiddle,CHAR(145),''),CHAR(146),''),'''',''),',','')
        ,drvLastName = REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast,CHAR(145),''),CHAR(146),''),'''',''),',','')
        ,drvEmployeeID = EecEmpNo
        ,drvLoginID = CASE 
                          WHEN EecEmplStatus <> 'T' 
                              THEN REPLACE(REPLACE(REPLACE(REPLACE(EepAddressEmail,CHAR(145),''),CHAR(146),''),'''',''),',','')
                      END
        ,drvEmailAddress = REPLACE(REPLACE(REPLACE(REPLACE(EepAddressEmail,CHAR(145),''),CHAR(146),''),'''',''),',','')
        ,drvActive = CASE
                         WHEN EecEmplStatus <> 'T'
                             THEN 'Y'
                         WHEN EecEmplStatus = 'T' AND (EecDateOfTermination > @EndDate OR (TERMS.audKey1Value IS NOT NULL AND TERMS.audNewValue > @EndDate))
                             THEN 'Y'
                         ELSE 'N'
                     END
        ,drvOrgUnit1 = EecOrgLvl3
        ,drvOrgUnit2 = CASE
                           WHEN LEFT(org3.OrgGLSegment,1) = '2'
                               THEN '2'
                           ELSE '1'
                       END
        --CASE
  --                         WHEN EecOrgLvl2 = 'PRDRV'
  --                             THEN '2'
  --                         ELSE '1'
  --                     END
        ,drvOrgUnit3 = EecOrgLvl3
        ,drvCustom3 = CASE
                          WHEN (EecDateOfLastHire BETWEEN @StartDate AND @EndDate OR ADDS.audKey1Value IS NOT NULL)
                              THEN 'New Default Travel Class'
                      END
        ,drvEmployeeIDOfExpenseApp = dbo.dsi_fnlib_GetSupervisorField_v2(xCOID, xEEID, 'EmpNo')
        ,drvExpenseOrCashApprover = dbo.dsi_fnlib_IsSupervisor(EepEEID)
        ,drvBIManagerEmployeeID = dbo.dsi_fnlib_GetSupervisorField_v2(xCOID, xEEID, 'EmpNo')
    INTO dbo.U_EEMPCONCUR_drvTbl305
    FROM dbo.U_EEMPCONCUR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.vw_int_OrgLevel org3 WITH (NOLOCK)
        ON org3.OrgCode = EecOrgLvl3
        AND org3.OrgLvl = '3'
    LEFT JOIN dbo.fn_MP_CustomFields_JobCode_Export (NULL, NULL, NULL, NULL) PCF
        ON PCF.JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_EEMPCONCUR_Audit ADDS WITH (NOLOCK)
        ON ADDS.audKey1Value = xEEID
        AND ADDS.audFieldName = 'EecDateOfLastHire'
    LEFT JOIN dbo.U_EEMPCONCUR_Audit TERMS WITH (NOLOCK)
        ON TERMS.audKey1Value = xEEID
        AND TERMS.audFieldName = 'EecDateOfTermination'
    WHERE @ExportCode LIKE '%305%'
        AND (EecEmplStatus <> 'T'
            OR (EecEmplStatus = 'T' AND EecTermReason NOT IN ('TRI','TRO') AND (EecDateOfTermination BETWEEN @StartDate AND @EndDate OR TERMS.audKey1Value IS NOT NULL)))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EEMPCONCUR_drvTbl320
    ---------------------------------
    IF OBJECT_ID('U_EEMPCONCUR_drvTbl320','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPCONCUR_drvTbl320;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvNameLastSort = EepNameLast
        ,drvNameFirstSort = EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvCurrentEmployeeID = EecEmpNo
        ,drvNewEmployeeID = EecEmpNo
        ,drvNewLoginID = REPLACE(REPLACE(REPLACE(REPLACE(EepAddressEmail,CHAR(145),''),CHAR(146),''),'''',''),',','')
    INTO dbo.U_EEMPCONCUR_drvTbl320
    FROM dbo.U_EEMPCONCUR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EEMPCONCUR_Audit EML WITH (NOLOCK)
        ON EML.audKey1Value = xEEID
        AND EML.audFieldName = 'EepAddressEmail'
    WHERE @ExportCode LIKE '%320%'
        AND EML.audKey1Value IS NOT NULL
        AND EecEmplStatus <> 'T'
    ;

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EEMPCONCUR_drvTbl320
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EEMPCONCUR_Audit WHERE audKey1Value = drvEEID AND audRowNo = 1);

    ---------------------------------
    -- DETAIL RECORD - U_EEMPCONCUR_drvTbl350
    ---------------------------------
    IF OBJECT_ID('U_EEMPCONCUR_drvTbl350','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPCONCUR_drvTbl350;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvNameLastSort = EepNameLast
        ,drvNameFirstSort = EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeIDOfTravApp = CASE
                                      WHEN JbcDesc LIKE '%Chief%' THEN ''
                                      ELSE dbo.dsi_fnlib_GetSupervisorField_v2(xCoID, xEEID, 'EmpNo') 
                                  END
        --CASE
  --                                    WHEN TRVAPP.EecEEID IS NOT NULL                                 THEN '09272021'
  --                                    WHEN EecOrglvl3 IN ('70904','11905','11962','11963','11967')    THEN ''
  --                                    WHEN EecOrgLvl2 = 'CPO'                                         THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'CPO'))
  --                                    WHEN EecOrgLvl2 = 'CHSLS' AND EecOrgLvl3 <> '11967'             THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'CHSLS'))
  --                                    WHEN EecOrgLvl2 = 'CHFIN'                                       THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'CHFIN'))
  --                                    WHEN EecOrgLvl2 = 'CIO'                                         THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'CIO'))
  --                                    WHEN EecOrgLvl2 = 'CTO'                                         THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'CTO'))
  --                                    WHEN EecOrgLvl2 = 'CPRODO'                                      THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'CPRODO'))
  --                                    WHEN EecOrgLvl1 = 'SPEC' AND EecOrgLvl2 = 'PRDRV'               THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'PRDRV'))
  --                                    WHEN EecOrgLvl1 = 'SPEC' AND EecOrgLvl2 = 'REMX'                THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'REMX'))
  --                                    WHEN EecOrgLvl1 = 'SPEC' AND EecOrgLvl2 NOT IN ('PRDRV','REMX') THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'SPEC'))
  --                                    WHEN EecOrgLvl1 = 'COMM'                                        THEN dbo.fn_GetEmpNo((SELECT TOP 1 EecEEID FROM dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) WHERE ISNULL(Employment_ConcurTravelApprover,'') = 'COMM'))                              
  --                                END
        ,drvJobTitle = REPLACE(REPLACE(REPLACE(REPLACE(JbcDesc,CHAR(145),''),CHAR(146),''),'''',''),',','')
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvCellPhone = dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL')
        ,drvTravelClassName = CASE
                                  WHEN (EecDateOfLastHire BETWEEN @StartDate AND @EndDate OR ADDS.audKey1Value IS NOT NULL)
                                      THEN 'Ghost Card Users Travel Class'
                              END
        ,drvHomeStreetAddress = ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1,CHAR(145),''),CHAR(146),''),'''',''),',',''),'') + ' ' + ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine2,CHAR(145),''),CHAR(146),''),'''',''),',',''),'')
        ,drvHomeCity = REPLACE(REPLACE(REPLACE(REPLACE(EepAddressCity,CHAR(145),''),CHAR(146),''),'''',''),',','')
        ,drvHomeState = EepAddressState
        ,drvHomePostalCode = EepAddressZipCode
        ,drvWorkStreetAddress = CASE
                                    WHEN EecLocation LIKE '%REM%'
                                        THEN ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1,CHAR(145),''),CHAR(146),''),'''',''),',',''),'') + ' ' + ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine2,CHAR(145),''),CHAR(146),''),'''',''),',',''),'')
                                    ELSE ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(LocAddressLine1,CHAR(145),''),CHAR(146),''),'''',''),',',''),'') + ' ' + ISNULL(REPLACE(REPLACE(REPLACE(REPLACE(LocAddressLine2,CHAR(145),''),CHAR(146),''),'''',''),',',''),'')
                                END
        ,drvWorkCity = CASE
                           WHEN EecLocation LIKE '%REM%'
                               THEN REPLACE(REPLACE(REPLACE(REPLACE(EepAddressCity,CHAR(145),''),CHAR(146),''),'''',''),',','')
                           ELSE REPLACE(REPLACE(REPLACE(REPLACE(LocAddressCity,CHAR(145),''),CHAR(146),''),'''',''),',','')
                       END
        ,drvWorkState = CASE
                            WHEN EecLocation LIKE '%REM%'
                                THEN EepAddressState
                            ELSE LocAddressState
                        END
        ,drvWorkPostalCode = CASE
                                 WHEN EecLocation LIKE '%REM%'
                                     THEN EepAddressZipCode
                                 ELSE LocAddressZipCode
                             END
        ,drvCustom1 = 'CG=' + LTRIM(RTRIM(EecOrglvl3))
        ,drvCustom2 = 'DIV=' + LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(org4.OrgDesc,CHAR(145),''),CHAR(146),''),'''',''),',','')))
        ,drvCustom3 = CASE
                          WHEN (EecDateOfLastHire BETWEEN @StartDate AND @EndDate OR ADDS.audKey1Value IS NOT NULL)
                              THEN 'DPT=EmployBridge Ghost Card'
                      END    
        ,drvCustom4 =  'MISC=' + CASE
                                    WHEN EecOrgLvl1 = 'CORP' THEN LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(org2.OrgDesc,CHAR(145),''),CHAR(146),''),'''',''),',','')))
                                    WHEN EecOrgLvl1 = 'COMM' AND org2.OrgReportCategory = 'GREATPLAIN' THEN 'President Comm Division – Great Plains'
                                    WHEN EecOrgLvl1 = 'COMM' AND org2.OrgReportCategory = 'WEST' THEN 'President Comm Division – West Coast'
                                    WHEN EecOrgLvl1 = 'COMM' AND org2.OrgReportCategory = 'SOUTHEAST' THEN 'President Comm Division – Southeast'
                                    WHEN EecOrgLvl1 = 'COMM' AND org2.OrgReportCategory = 'NORTH' THEN 'President Comm Division – Northern'
                                    WHEN EecOrgLvl1 = 'COMM'   AND ISNULL(org2.OrgReportCategory, '')  = '' THEN 'President Commercial Division'
                                    WHEN EecOrgLvl1 = 'BLCR' THEN 'Bluecrew'
                                    WHEN EecOrgLvl1 = 'Spec' then 'President Specialty Division'
                                END
        
        
        --'MISC=' + CASE
  --                                  WHEN EecOrgLvl1 = 'CORP'
  --                                      THEN LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(org2.OrgDesc,CHAR(145),''),CHAR(146),''),'''',''),',','')))
  --                                  WHEN EecOrgLvl1 = 'COMM'
  --                                      THEN 'President Commercial Division'
  --                                  WHEN EecOrgLvl1 = 'SPEC'
  --                                      THEN 'President Specialty Division'
  --                              END
        ,drvCustom5 = 'REG=' + LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(org2.OrgDesc,CHAR(145),''),CHAR(146),''),'''',''),',','')))
        ,drvXMLProfileSyncID = ''
    INTO dbo.U_EEMPCONCUR_drvTbl350
    FROM dbo.U_EEMPCONCUR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.vw_int_OrgLevel org2 WITH (NOLOCK)
        ON org2.OrgCode = EecOrgLvl2
        AND org2.OrgLvl = '2'
    LEFT JOIN dbo.vw_int_OrgLevel org4 WITH (NOLOCK)
        ON org4.OrgCode = EecOrgLvl4
        AND org4.OrgLvl = '4'
    LEFT JOIN dbo.U_EEMPCONCUR_Audit ADDS WITH (NOLOCK)
        ON ADDS.audKey1Value = xEEID
        AND ADDS.audFieldName = 'EecDateOfLastHire'
    LEFT JOIN dbo.U_EEMPCONCUR_Audit TERMS WITH (NOLOCK)
        ON TERMS.audKey1Value = xEEID
        AND TERMS.audFieldName = 'EecDateOfTermination'
    LEFT JOIN dbo.fn_MP_CustomFields_EmpComp_Export (NULL, NULL, NULL, NULL) TRVAPP
        ON TRVAPP.EecEEID = xEEID
        AND TRVAPP.EecCoID = xCoID
        --AND TRVAPP.Employment_ConcurTravelApprover IS NOT NULL
    WHERE @ExportCode LIKE '%305%' 
        AND (EecEmplStatus <> 'T'
            OR (EecEmplStatus = 'T' AND EecTermReason NOT IN ('TRI','TRO') AND (EecDateOfTermination BETWEEN @StartDate AND @EndDate OR TERMS.audKey1Value IS NOT NULL)))
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE
                                 WHEN @ExportCode LIKE '%305%' THEN 'employee_p0005779ueaw_305_350_' + FORMAT(GETDATE(),'yyyyMMddhhmmss') + '.txt'
                                 WHEN @ExportCode LIKE '%320%' THEN 'employee_p0005779ueaw_320_' + FORMAT(GETDATE(),'yyyyMMddhhmmss') + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEEMPCONCUR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPCONCUR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPCONCUR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910241'
       ,expStartPerControl     = '201910241'
       ,expLastEndPerControl   = '201910319'
       ,expEndPerControl       = '201910319'
WHERE expFormatCode = 'EEMPCONCUR';



    --------JOB NAME: Concur Export (EEMPCONCUR) - Daily, 6:30pm ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Concur Export (EEMPCONCUR) - Daily, 6:30pm ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (EEMPCONCUR)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-1,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''EEMPCONCUR''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (EEMPCONCUR)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''EEMPCONCUR'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily, 6:30pm ET',
            @enabled=1, 
            @freq_type=4, 
            @freq_interval=1,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20191031,
            @active_end_date=99991231,
            @active_start_time=183000,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPCONCUR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPCONCUR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EEMPCONCUR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EEMPCONCUR'
   AND rpoParmType = 'expSystemID'


-- End ripout