/**********************************************************************************

EBEN1RSTPY: BenefitsFirst Elig Export

FormatCode:     EBEN1RSTPY
Project:        BenefitsFirst Elig Export
Client ID:      SCO1001
Date/time:      2022-01-12 11:08:19.037
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N13
Server:         N1SUP3DB54
Database:       ULTIPRO_SGLLC
Web Filename:   SCO1001_95320_EEHISTORY_EBEN1RSTPY_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBEN1RSTPY_SavePath') IS NOT NULL DROP TABLE dbo.U_EBEN1RSTPY_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBEN1RSTPY'


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
WHERE FormatCode = 'EBEN1RSTPY'
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
WHERE ExpFormatCode = 'EBEN1RSTPY'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBEN1RSTPY')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBEN1RSTPY'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBEN1RSTPY'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBEN1RSTPY'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBEN1RSTPY'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBEN1RSTPY'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBEN1RSTPY'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBEN1RSTPY'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBEN1RSTPY'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBEN1RSTPY'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBEN1RSTPY_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBEN1RSTPY_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBEN1RSTPY') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBEN1RSTPY];
GO
IF OBJECT_ID('U_EBEN1RSTPY_File') IS NOT NULL DROP TABLE [dbo].[U_EBEN1RSTPY_File];
GO
IF OBJECT_ID('U_EBEN1RSTPY_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBEN1RSTPY_EEList];
GO
IF OBJECT_ID('U_EBEN1RSTPY_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBEN1RSTPY_drvTbl];
GO
IF OBJECT_ID('U_EBEN1RSTPY_Ded_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBEN1RSTPY_Ded_AuditFields];
GO
IF OBJECT_ID('U_EBEN1RSTPY_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBEN1RSTPY_AuditFields];
GO
IF OBJECT_ID('U_EBEN1RSTPY_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBEN1RSTPY_Audit];
GO
IF OBJECT_ID('U_Ded_EBEN1RSTPY_Ded_Audit') IS NOT NULL DROP TABLE [dbo].[U_Ded_EBEN1RSTPY_Ded_Audit];
GO
IF OBJECT_ID('U_Ded_EBEN1RSTPY_Audit') IS NOT NULL DROP TABLE [dbo].[U_Ded_EBEN1RSTPY_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBEN1RSTPY','BenefitsFirst Elig Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EBEN1RSTPYZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBEN1RSTPYZ0','50','H','01','1',NULL,'ClientID',NULL,NULL,'"ClientID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBEN1RSTPYZ0','50','H','01','2',NULL,'EmpSSN',NULL,NULL,'"EmpSSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBEN1RSTPYZ0','50','H','01','3',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBEN1RSTPYZ0','50','H','01','4',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBEN1RSTPYZ0','50','H','01','5',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBEN1RSTPYZ0','50','H','01','6',NULL,'MiddleInitial',NULL,NULL,'"MiddleInitial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBEN1RSTPYZ0','50','H','01','7',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBEN1RSTPYZ0','50','H','01','8',NULL,'HAdd1',NULL,NULL,'"HAdd1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBEN1RSTPYZ0','50','H','01','9',NULL,'HAdd2',NULL,NULL,'"HAdd2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBEN1RSTPYZ0','50','H','01','10',NULL,'HCity',NULL,NULL,'"HCity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBEN1RSTPYZ0','50','H','01','11',NULL,'HStateCd',NULL,NULL,'"HStateCd"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBEN1RSTPYZ0','50','H','01','12',NULL,'HZip',NULL,NULL,'"HZip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBEN1RSTPYZ0','50','H','01','13',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBEN1RSTPYZ0','50','H','01','14',NULL,'SexCd',NULL,NULL,'"SexCd"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBEN1RSTPYZ0','50','H','01','15',NULL,'MaritalStatus',NULL,NULL,'"MaritalStatus"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBEN1RSTPYZ0','50','H','01','16',NULL,'DateOfBirth',NULL,NULL,'"DateOfBirth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBEN1RSTPYZ0','50','H','01','17',NULL,'HireDate',NULL,NULL,'"HireDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBEN1RSTPYZ0','50','H','01','18',NULL,'RehireDate',NULL,NULL,'"RehireDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBEN1RSTPYZ0','50','H','01','19',NULL,'CPhone',NULL,NULL,'"CPhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBEN1RSTPYZ0','50','H','01','20',NULL,'HPhone',NULL,NULL,'"HPhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBEN1RSTPYZ0','50','H','01','21',NULL,'WPhone',NULL,NULL,'"WPhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBEN1RSTPYZ0','50','H','01','22',NULL,'DeptNum',NULL,NULL,'"DeptNum"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBEN1RSTPYZ0','50','H','01','23',NULL,'DeptName',NULL,NULL,'"DeptName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBEN1RSTPYZ0','50','H','01','24',NULL,'CompanyCd',NULL,NULL,'"CompanyCd"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBEN1RSTPYZ0','50','H','01','25',NULL,'EmpNum',NULL,NULL,'"EmpNum"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBEN1RSTPYZ0','50','H','01','26',NULL,'LocationID',NULL,NULL,'"LocationID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBEN1RSTPYZ0','50','H','01','27',NULL,'EmployeeType',NULL,NULL,'"EmployeeType"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBEN1RSTPYZ0','50','H','01','28',NULL,'ChangeEffectiveDate',NULL,NULL,'"ChangeEffectiveDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBEN1RSTPYZ0','50','H','01','29',NULL,'PayType',NULL,NULL,'"PayType"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBEN1RSTPYZ0','50','H','01','30',NULL,'ScheduledPay',NULL,NULL,'"ScheduledPay"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBEN1RSTPYZ0','50','H','01','31',NULL,'ScheduledHours',NULL,NULL,'"ScheduledHours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBEN1RSTPYZ0','50','H','01','32',NULL,'EligibilityDate',NULL,NULL,'"EligibilityDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBEN1RSTPYZ0','50','H','01','33',NULL,'EmpTermDate',NULL,NULL,'"EmpTermDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBEN1RSTPYZ0','50','H','01','34',NULL,'EmpTermReason',NULL,NULL,'"EmpTermReason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBEN1RSTPYZ0','50','H','01','35',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBEN1RSTPYZ0','50','H','01','36',NULL,'WHState',NULL,NULL,'"WHState"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBEN1RSTPYZ0','50','H','01','37',NULL,'PayPeriods',NULL,NULL,'"PayPeriods"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBEN1RSTPYZ0','50','H','01','38',NULL,'DedPeriods',NULL,NULL,'"DedPeriods"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBEN1RSTPYZ0','50','H','01','39',NULL,'Wellness',NULL,NULL,'"Wellness"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBEN1RSTPYZ0','50','H','01','40',NULL,'Exempt Status',NULL,NULL,'"Exempt Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBEN1RSTPYZ0','50','H','01','41',NULL,'Exempt Status',NULL,NULL,'"Benefit Eligibility Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBEN1RSTPYZ0','50','D','10','1',NULL,'ClientID',NULL,NULL,'"739"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBEN1RSTPYZ0','50','D','10','2',NULL,'EmpSSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBEN1RSTPYZ0','50','D','10','3',NULL,'Status',NULL,NULL,'"drvEecEmplStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBEN1RSTPYZ0','50','D','10','4',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBEN1RSTPYZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBEN1RSTPYZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBEN1RSTPYZ0','50','D','10','7',NULL,'Suffix',NULL,NULL,'"drvNameSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBEN1RSTPYZ0','50','D','10','8',NULL,'HAdd1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBEN1RSTPYZ0','50','D','10','9',NULL,'HAdd2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBEN1RSTPYZ0','50','D','10','10',NULL,'HCity',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBEN1RSTPYZ0','50','D','10','11',NULL,'HStateCd',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBEN1RSTPYZ0','50','D','10','12',NULL,'HZip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBEN1RSTPYZ0','50','D','10','13',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBEN1RSTPYZ0','50','D','10','14',NULL,'SexCd',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBEN1RSTPYZ0','50','D','10','15',NULL,'MaritalStatus',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBEN1RSTPYZ0','50','D','10','16',NULL,'DateOfBirth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBEN1RSTPYZ0','50','D','10','17',NULL,'HireDate',NULL,NULL,'"drvDateOfOriginalHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBEN1RSTPYZ0','50','D','10','18',NULL,'RehireDate',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBEN1RSTPYZ0','50','D','10','19',NULL,'CPhone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBEN1RSTPYZ0','50','D','10','20',NULL,'HPhone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBEN1RSTPYZ0','50','D','10','21',NULL,'WPhone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBEN1RSTPYZ0','50','D','10','22',NULL,'DeptNum',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBEN1RSTPYZ0','50','D','10','23',NULL,'DeptName',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBEN1RSTPYZ0','50','D','10','24',NULL,'CompanyCd',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBEN1RSTPYZ0','50','D','10','25',NULL,'EmpNum',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBEN1RSTPYZ0','50','D','10','26',NULL,'LocationID',NULL,NULL,'"drvLocDesc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBEN1RSTPYZ0','50','D','10','27',NULL,'EmployeeType',NULL,NULL,'"drvFullTimeOrPartTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBEN1RSTPYZ0','50','D','10','28',NULL,'ChangeEffectiveDate',NULL,NULL,'"drvFullTimeOrPartTimeEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBEN1RSTPYZ0','50','D','10','29',NULL,'PayType',NULL,NULL,'"drvSalaryOrHourly"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBEN1RSTPYZ0','50','D','10','30',NULL,'ScheduledPay',NULL,NULL,'"drvAnnSalary"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBEN1RSTPYZ0','50','D','10','31',NULL,'ScheduledHours',NULL,NULL,'"drvSchedHrs"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBEN1RSTPYZ0','50','D','10','32',NULL,'EligibilityDate',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBEN1RSTPYZ0','50','D','10','33',NULL,'EmpTermDate',NULL,NULL,'"drvDateOfTermination"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBEN1RSTPYZ0','50','D','10','34',NULL,'EmpTermReason',NULL,NULL,'"drvTermReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBEN1RSTPYZ0','50','D','10','35',NULL,'Title',NULL,NULL,'"drvJobDesc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBEN1RSTPYZ0','50','D','10','36',NULL,'WHState',NULL,NULL,'"drvLocAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBEN1RSTPYZ0','50','D','10','37',NULL,'PayPeriods',NULL,NULL,'"drvPayPeriods"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBEN1RSTPYZ0','50','D','10','38',NULL,'DedPeriods',NULL,NULL,'"drvDedPeriods"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBEN1RSTPYZ0','50','D','10','39',NULL,'Wellness',NULL,NULL,'"drvWellness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBEN1RSTPYZ0','50','D','10','40',NULL,'Exempt Status',NULL,NULL,'"drvExcemptStat"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBEN1RSTPYZ0','50','D','10','41',NULL,'Benefit Eligibility Date',NULL,NULL,'"drvBenefitEligibilityDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBEN1RSTPY_20220112.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Benefitfirst Payroll Export','202108139','EMPEXPORT','ONDEM_XOE',NULL,'EBEN1RSTPY',NULL,NULL,NULL,'202108139','Aug 13 2021  9:01AM','Aug 13 2021  9:01AM','202108131',NULL,'','','202108131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Benefitfirst Payroll Exp-Sched','202108139','EMPEXPORT','SCH_EBEN1R',NULL,'EBEN1RSTPY',NULL,NULL,NULL,'202108139','Aug 13 2021  9:01AM','Aug 13 2021  9:01AM','202108131',NULL,'','','202108131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'Benefitfirst Payroll Exp-Test','202112279','EMPEXPORT','TEST_XOE','Dec 27 2021  5:55PM','EBEN1RSTPY',NULL,NULL,NULL,'202112279','Dec 27 2021 12:00AM','Dec 30 1899 12:00AM','202112131','533','','','202112131',dbo.fn_GetTimedKey(),NULL,'us3lKiSCO1001','',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBEN1RSTPY','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBEN1RSTPY','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBEN1RSTPY','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBEN1RSTPY','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBEN1RSTPY','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBEN1RSTPY','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBEN1RSTPY','D10','dbo.U_EBEN1RSTPY_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_Ded_EBEN1RSTPY_Audit
-----------

IF OBJECT_ID('U_Ded_EBEN1RSTPY_Audit') IS NULL
CREATE TABLE [dbo].[U_Ded_EBEN1RSTPY_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audProcessedDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_Ded_EBEN1RSTPY_Ded_Audit
-----------

IF OBJECT_ID('U_Ded_EBEN1RSTPY_Ded_Audit') IS NULL
CREATE TABLE [dbo].[U_Ded_EBEN1RSTPY_Ded_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audProcessedDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EBEN1RSTPY_Audit
-----------

IF OBJECT_ID('U_EBEN1RSTPY_Audit') IS NULL
CREATE TABLE [dbo].[U_EBEN1RSTPY_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audProcessedDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EBEN1RSTPY_AuditFields
-----------

IF OBJECT_ID('U_EBEN1RSTPY_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBEN1RSTPY_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBEN1RSTPY_Ded_AuditFields
-----------

IF OBJECT_ID('U_EBEN1RSTPY_Ded_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBEN1RSTPY_Ded_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBEN1RSTPY_drvTbl
-----------

IF OBJECT_ID('U_EBEN1RSTPY_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBEN1RSTPY_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEecEmplStatus] char(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvEmpNo] char(9) NULL,
    [drvLocDesc] varchar(25) NULL,
    [drvFullTimeOrPartTime] char(1) NULL,
    [drvFullTimeOrPartTimeEffDate] datetime NULL,
    [drvSalaryOrHourly] char(1) NULL,
    [drvAnnSalary] money NULL,
    [drvSchedHrs] decimal NULL,
    [drvDateOfTermination] datetime NULL,
    [drvTermReason] char(6) NULL,
    [drvJobDesc] varchar(8000) NULL,
    [drvLocAddressState] varchar(255) NULL,
    [drvPayPeriods] varchar(2) NULL,
    [drvDedPeriods] varchar(2) NULL,
    [drvWellness] varchar(1) NOT NULL,
    [drvExcemptStat] varchar(10) NOT NULL,
    [drvBenefitEligibilityDate] datetime NULL
);

-----------
-- Create table U_EBEN1RSTPY_EEList
-----------

IF OBJECT_ID('U_EBEN1RSTPY_EEList') IS NULL
CREATE TABLE [dbo].[U_EBEN1RSTPY_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBEN1RSTPY_File
-----------

IF OBJECT_ID('U_EBEN1RSTPY_File') IS NULL
CREATE TABLE [dbo].[U_EBEN1RSTPY_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBEN1RSTPY]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Scotsman Group LLC

Created By: Keary McCutchen
Business Analyst: Lea King
Create Date: 08/13/2021
Service Request Number: SR-2021-00323263

Purpose: Benefitfirst Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBEN1RSTPY';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBEN1RSTPY';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBEN1RSTPY';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBEN1RSTPY';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBEN1RSTPY' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBEN1RSTPY', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBEN1RSTPY', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBEN1RSTPY', 'SCH_EBEN1R';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBEN1RSTPY', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBEN1RSTPY';

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
    DELETE FROM dbo.U_EBEN1RSTPY_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBEN1RSTPY_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBEN1RSTPY_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBEN1RSTPY_AuditFields;
    CREATE TABLE dbo.U_EBEN1RSTPY_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Employee Information
    INSERT INTO dbo.U_EBEN1RSTPY_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EBEN1RSTPY_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EBEN1RSTPY_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EBEN1RSTPY_AuditFields VALUES ('JobCode','JbcFLSAType');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBEN1RSTPY_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBEN1RSTPY_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audProcessedDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EBEN1RSTPY_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBEN1RSTPY_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audProcessedDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';



     IF OBJECT_ID('U_EBEN1RSTPY_Ded_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBEN1RSTPY_Ded_AuditFields;
    CREATE TABLE dbo.U_EBEN1RSTPY_Ded_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Employee Information
    INSERT INTO dbo.U_EBEN1RSTPY_Ded_AuditFields VALUES ('EmpDed','EedBenStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_Ded_EBEN1RSTPY_Ded_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_Ded_EBEN1RSTPY_Ded_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audProcessedDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_Ded_EBEN1RSTPY_Ded_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBEN1RSTPY_Ded_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audProcessedDateTime BETWEEN @StartDate AND @EndDate
    AND audKey3Value IN ('BC1W','BC2W','BC3W','BC4W')
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBEN1RSTPY_Audit ON dbo.U_EBEN1RSTPY_Audit (audEEID,audCOID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BC1W,BC2W,BC3W,BC4W';

    IF OBJECT_ID('U_ESEQUOIA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQUOIA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESEQUOIA_DedList
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

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBEN1RSTPY_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBEN1RSTPY_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBEN1RSTPY_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEecEmplStatus = EecEmplStatus
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvAddressLine1 = REPLACE(EepAddressLine1,',',' ')
        ,drvAddressLine2 = REPLACE(EepAddressLine2,',',' ')
        ,drvAddressCity = REPLACE(EepAddressCity,',',' ')
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvEmpNo = EecEmpNo
        ,drvLocDesc = LocDesc
        ,drvFullTimeOrPartTime = EecFullTimeOrPartTime
        -- ChangeEffectiveDate 
        ,drvFullTimeOrPartTimeEffDate = CASE WHEN JBC.audProcessedDateTime IS NOT NULL THEN EJH2.EjhJobEffDate
                                        WHEN DedCode.audProcessedDateTime IS NOT NULL THEN DedCode.audProcessedDateTime
                                        END
        --(SELECT TOP 1 audProcessedDateTime FROM dbo.U_EBEN1RSTPY_Audit WHERE audEEID = xEEID AND audCOID = xCOID AND audFieldName IN ('EecFullTimeOrPartTime','EecSalaryOrHourly') AND audRowNo = 1) 
        ,drvSalaryOrHourly = EecSalaryOrHourly
        ,drvAnnSalary = EecAnnSalary
        ,drvSchedHrs = PgrSchedHrs
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTermReason = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvJobDesc = REPLACE(JbcDesc,',',' ')
        ,drvLocAddressState = EepAddressState
        ,drvPayPeriods = CASE PgrPayFrequency 
                              WHEN 'W' THEN '52'
                              WHEN 'B' THEN '26'
                          END
        ,drvDedPeriods = CASE PgrPayFrequency 
                              WHEN 'W' THEN '52'
                              WHEN 'B' THEN '26'
                          END
        ,drvWellness = CASE WHEN EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedBenStopDate IS NULL) THEN 'Y' ELSE 'N' END
        ,drvExcemptStat = CASE WHEN JbcFLSAType = 'E' THEN 'Exempt' ELSE 'Non Exempt' END
        ,drvBenefitEligibilityDate = CASE WHEN EjhReason IS NOT NULL AND EjhReason = '209' THEN EecDateOfBenefitSeniority END
    INTO dbo.U_EBEN1RSTPY_drvTbl
    FROM dbo.U_EBEN1RSTPY_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecEmplStatus <> 'T'
         OR (eecEmplStatus  = 'T' 
             AND EecTermReason <>'TRO' 
             AND EXISTS(SELECT 1 FROM dbo.U_EBEN1RSTPY_Audit WHERE audEEID = xEEID AND audCOID = xCOID AND audFieldName = 'EecEmplStatus' and audNewValue = 'T'))
            )
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
            FROM dbo.EmpHJob WITH (NOLOCK)
            WHERE EjhJobEffDate BETWEEN DATEADD(DAY, -14, @EndDate) AND @EndDate 
            AND EjhReason = '209') AS EJH
        ON xEEID = EjhEEID
        AND xCOID = EjhCOID
    LEFT JOIN dbo.U_EBEN1RSTPY_Audit JBC WITH (NOLOCK)
        ON JBC.audEEID = EecJobCode
    LEFT JOIN dbo.U_Ded_EBEN1RSTPY_Ded_Audit DedCode WITH (NOLOCK)
        ON DedCode.audEEID = xEEID
        AND DedCode.audCOID = xCOID
        AND DedCode.audRowNo = 1
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH2
        ON EJH2.EjhEEID = xEEID
        AND EJH2.EjhCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEBEN1RSTPY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBEN1RSTPY_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBEN1RSTPY%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108061'
       ,expStartPerControl     = '202108061'
       ,expLastEndPerControl   = '202108139'
       ,expEndPerControl       = '202108139'
WHERE expFormatCode = 'EBEN1RSTPY';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBEN1RSTPY_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBEN1RSTPY_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort 

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBEN1RSTPY' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBEN1RSTPY'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBEN1RSTPY'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBEN1RSTPY', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBEN1RSTPY', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBEN1RSTPY', 'UseFileName', 'V', 'Y'


-- End ripout