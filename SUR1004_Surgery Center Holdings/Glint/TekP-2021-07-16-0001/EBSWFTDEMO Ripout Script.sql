/**********************************************************************************

EBSWFTDEMO: Bswift Demographics Export

FormatCode:     EBSWFTDEMO
Project:        Bswift Demographics Export
Client ID:      SUR1004
Date/time:      2022-03-17 12:37:50.813
Ripout version: 7.4
Export Type:    Back Office
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_SRGY
ExportPath:    \\us.saas\E0\data_exchange\SUR1004\Exports\
OnDemandPath:  \\us.saas\E0\data_exchange\SUR1004\Exports\
TestPath:      \\us.saas\E4\Public\SUR1004\Exports\BSwift\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBSWFTDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_EBSWFTDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBSWFTDEMO'


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
WHERE FormatCode = 'EBSWFTDEMO'
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
WHERE ExpFormatCode = 'EBSWFTDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBSWFTDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBSWFTDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBSWFTDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBSWFTDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBSWFTDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBSWFTDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBSWFTDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBSWFTDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBSWFTDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBSWFTDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBSWFTDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBSWFTDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBSWFTDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBSWFTDEMO];
GO
IF OBJECT_ID('U_EBSWFTDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_File];
GO
IF OBJECT_ID('U_EBSWFTDEMO_EmpHJob_Transfer') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_EmpHJob_Transfer];
GO
IF OBJECT_ID('U_EBSWFTDEMO_EmpHJob_RateChange') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_EmpHJob_RateChange];
GO
IF OBJECT_ID('U_EBSWFTDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_EEList];
GO
IF OBJECT_ID('U_EBSWFTDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_drvTbl];
GO
IF OBJECT_ID('U_EBSWFTDEMO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_AuditFields];
GO
IF OBJECT_ID('U_EBSWFTDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBSWFTDEMO_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBSWFTDEMO','Bswift Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','50000','S','N','EBSWFTDEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBSWFTDEMOZ0','50','H','01','1',NULL,'Group Number',NULL,NULL,'"Group Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBSWFTDEMOZ0','50','H','01','2',NULL,'UserID',NULL,NULL,'"User ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBSWFTDEMOZ0','50','H','01','3',NULL,'EmployeeID',NULL,NULL,'"Employee ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBSWFTDEMOZ0','50','H','01','4',NULL,'Relation',NULL,NULL,'"Relation"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBSWFTDEMOZ0','50','H','01','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBSWFTDEMOZ0','50','H','01','6',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBSWFTDEMOZ0','50','H','01','7',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBSWFTDEMOZ0','50','H','01','8',NULL,'Nick Name',NULL,NULL,'"Nick Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBSWFTDEMOZ0','50','H','01','9',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBSWFTDEMOZ0','50','H','01','10',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBSWFTDEMOZ0','50','H','01','11',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBSWFTDEMOZ0','50','H','01','12',NULL,'Home Address1',NULL,NULL,'"Home Address1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBSWFTDEMOZ0','50','H','01','13',NULL,'Home Address2',NULL,NULL,'"Home Address2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBSWFTDEMOZ0','50','H','01','14',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBSWFTDEMOZ0','50','H','01','15',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBSWFTDEMOZ0','50','H','01','16',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBSWFTDEMOZ0','50','H','01','17',NULL,'Home Address1',NULL,NULL,'"Home Phone"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBSWFTDEMOZ0','50','H','01','18',NULL,'Home Address2',NULL,NULL,'"Home E-Mail"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBSWFTDEMOZ0','50','H','01','19',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBSWFTDEMOZ0','50','H','01','20',NULL,'Re-hire Date',NULL,NULL,'"Re-hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBSWFTDEMOZ0','50','H','01','21',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBSWFTDEMOZ0','50','H','01','22',NULL,'Time Status',NULL,NULL,'"Time Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBSWFTDEMOZ0','50','H','01','23',NULL,'Pay Frequency',NULL,NULL,'"Pay Frequency"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBSWFTDEMOZ0','50','H','01','24',NULL,'Department Code',NULL,NULL,'"Department Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBSWFTDEMOZ0','50','H','01','25',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBSWFTDEMOZ0','50','H','01','26',NULL,'Location Effective Date',NULL,NULL,'"Location Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBSWFTDEMOZ0','50','H','01','27',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBSWFTDEMOZ0','50','H','01','28',NULL,'Work Phone',NULL,NULL,'"Work Phone"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBSWFTDEMOZ0','50','H','01','29',NULL,'Work E-mail',NULL,NULL,'"Work E-mail"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBSWFTDEMOZ0','50','H','01','30',NULL,'Benefit Class Date',NULL,NULL,'"Benefit Class Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBSWFTDEMOZ0','50','H','01','31',NULL,'Login Access',NULL,NULL,'"Login Access"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBSWFTDEMOZ0','50','H','01','32',NULL,'Compensation Date',NULL,NULL,'"Compensation Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBSWFTDEMOZ0','50','H','01','33',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBSWFTDEMOZ0','50','H','01','34',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBSWFTDEMOZ0','50','H','01','35',NULL,'Hours Per Week',NULL,NULL,'"Hours Per Week"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBSWFTDEMOZ0','50','H','01','36',NULL,'Termination Reason',NULL,NULL,'"Termination Reason"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBSWFTDEMOZ0','50','H','01','37',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBSWFTDEMOZ0','50','H','01','38',NULL,'Auto-Enroll',NULL,NULL,'"Auto-Enroll"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBSWFTDEMOZ0','50','H','01','39',NULL,'Benefit Drop Down 1',NULL,NULL,'"Benefit Drop Down 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBSWFTDEMOZ0','50','H','01','40',NULL,'CoCode',NULL,NULL,'"CoCode"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBSWFTDEMOZ0','50','D','10','1',NULL,'Group Number',NULL,NULL,'"drvGroupNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBSWFTDEMOZ0','50','D','10','2',NULL,'UserID',NULL,NULL,'"drvUserID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBSWFTDEMOZ0','50','D','10','3',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBSWFTDEMOZ0','50','D','10','4',NULL,'Relation',NULL,NULL,'"drvRelation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBSWFTDEMOZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBSWFTDEMOZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBSWFTDEMOZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBSWFTDEMOZ0','50','D','10','8',NULL,'Nick Name',NULL,NULL,'"drvNickName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBSWFTDEMOZ0','50','D','10','9',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBSWFTDEMOZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBSWFTDEMOZ0','50','D','10','11',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBSWFTDEMOZ0','50','D','10','12',NULL,'Home Address1',NULL,NULL,'"drvAddress1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBSWFTDEMOZ0','50','D','10','13',NULL,'Home Address2',NULL,NULL,'"drvAddress2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBSWFTDEMOZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBSWFTDEMOZ0','50','D','10','15',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBSWFTDEMOZ0','50','D','10','16',NULL,'ZIP',NULL,NULL,'"drvZIP"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBSWFTDEMOZ0','50','D','10','17',NULL,'Home Address1',NULL,NULL,'"drvHomePhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBSWFTDEMOZ0','50','D','10','18',NULL,'Home Address2',NULL,NULL,'"drvEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBSWFTDEMOZ0','50','D','10','19',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBSWFTDEMOZ0','50','D','10','20',NULL,'Re-hire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBSWFTDEMOZ0','50','D','10','21',NULL,'Employment Status',NULL,NULL,'"drvEEStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBSWFTDEMOZ0','50','D','10','22',NULL,'Time Status',NULL,NULL,'"drvTimeStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBSWFTDEMOZ0','50','D','10','23',NULL,'Pay Frequency',NULL,NULL,'"drvPayFreq"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBSWFTDEMOZ0','50','D','10','24',NULL,'Department Code',NULL,NULL,'"drvDepartmentCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBSWFTDEMOZ0','50','D','10','25',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBSWFTDEMOZ0','50','D','10','26',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBSWFTDEMOZ0','50','D','10','27',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBSWFTDEMOZ0','50','D','10','28',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBSWFTDEMOZ0','50','D','10','29',NULL,'Work E-mail',NULL,NULL,'"drvWorkEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBSWFTDEMOZ0','50','D','10','30',NULL,'Benefit Class Date',NULL,NULL,'"drvBenClassDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBSWFTDEMOZ0','50','D','10','31',NULL,'Login Access',NULL,NULL,'"drvLoginAccess"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBSWFTDEMOZ0','50','D','10','32',NULL,'Compensation Date',NULL,NULL,'"drvCompDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBSWFTDEMOZ0','50','D','10','33',NULL,'Salary',NULL,NULL,'"drvAnnSalary"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBSWFTDEMOZ0','50','D','10','34',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyRate"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBSWFTDEMOZ0','50','D','10','35',NULL,'Hours Per Week',NULL,NULL,'"drvHrsPerWeek"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBSWFTDEMOZ0','50','D','10','36',NULL,'Termination Reason',NULL,NULL,'"drvTermReason"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBSWFTDEMOZ0','50','D','10','37',NULL,'Termination Date',NULL,NULL,'"drvTermDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBSWFTDEMOZ0','50','D','10','38',NULL,'Auto-Enroll',NULL,NULL,'"drvAutoEnroll"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBSWFTDEMOZ0','50','D','10','39',NULL,'Benefit Drop Down 1',NULL,NULL,'"drvBenDropDown1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBSWFTDEMOZ0','50','D','10','40',NULL,'CoCode',NULL,NULL,'"drvCoCode"','(''UA''=''Q,'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'7W7EV,7W796,NN6G7,NMW5K,FNO87,TI7GQ,2576Y,2574S,FNPDG,256YG,256MV,NMW0Z,NN6KJ,NN8S3,UU6Y9,XICS1,NN6QX,FPDJB,NN6O4,TEMVK,FPDPO,TEM9Y,FPD16,TEMPN,24TAO,FPDV6,FPDWO,FPDY2,FPE0Q,FNNS1,FPE29,7W7IT,FPDSE,YWFC5,7V4WB,UUA7X,NMW9X,FPD6E,FPDZH,FPE7L,FPDI4',NULL,NULL,NULL,'OnDemand','202008019','EMPEXPORT','ONDEMAND','Dec 28 2021 12:00AM','EBSWFTDEMO',NULL,NULL,NULL,'202008019','Aug  1 2020 12:00AM','Dec 30 1899 12:00AM','202007301','6391','','','202007301',dbo.fn_GetTimedKey(),NULL,'TSAWYER02',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'7W7EV,7W796,NN6G7,NMW5K,FNO87,TI7GQ,2576Y,2574S,FNPDG,256YG,256MV,NMW0Z,NN6KJ,NN8S3,UU6Y9,XICS1,NN6QX,FPDJB,NN6O4,TEMVK,FPDPO,TEM9Y,FPD16,TEMPN,24TAO,FPDV6,FPDWO,FPDY2,FPE0Q,FNNS1,FPE29,7W7IT,FPDSE,YWFC5,7V4WB,UUA7X,NMW9X,FPD6E,FPDZH,FPE7L,FPDI4',NULL,NULL,NULL,'Scheduled Session','202112259','EMPEXPORT','SCHEDULED','Dec 28 2021 12:00AM','EBSWFTDEMO',NULL,NULL,NULL,'202203149','Dec 25 2021 12:00AM','Dec 30 1899 12:00AM','202203121','594','','','202112231',dbo.fn_GetTimedKey(),NULL,'TSAWYER02',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'7W7EV,7W796,NN6G7,NMW5K,FNO87,TI7GQ,2576Y,2574S,FNPDG,256YG,256MV,NMW0Z,NN6KJ,NN8S3,UU6Y9,XICS1,NN6QX,FPDJB,NN6O4,TEMVK,FPDPO,TEM9Y,FPD16,TEMPN,24TAO,FPDV6,FPDWO,FPDY2,FPE0Q,FNNS1,FPE29,7W7IT,FPDSE,YWFC5,7V4WB,UUA7X,NMW9X,FPD6E,FPDZH,FPE7L,FPDI4',NULL,NULL,NULL,'Test Purposes Only','202203149','EMPEXPORT','TEST','Dec  7 2021 12:00AM','EBSWFTDEMO',NULL,NULL,NULL,'202203149','Dec  4 2020 12:00AM','Dec  5 2020 12:00AM','202203121','6442','','','202203121',dbo.fn_GetTimedKey(),NULL,'TSAWYER02',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','ExportPath','V','\\us.saas\E0\data_exchange\SUR1004\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','OnDemandPath','V','\\us.saas\E0\data_exchange\SUR1004\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','TestPath','V','\\us.saas\E4\Public\SUR1004\Exports\BSwift\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','UDESPath','C','\\us.saas\E0\data_exchange\SUR1004\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBSWFTDEMO','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBSWFTDEMO','D10','dbo.U_EBSWFTDEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBSWFTDEMO_Audit
-----------

IF OBJECT_ID('U_EBSWFTDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL
);

-----------
-- Create table U_EBSWFTDEMO_AuditFields
-----------

IF OBJECT_ID('U_EBSWFTDEMO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBSWFTDEMO_drvTbl
-----------

IF OBJECT_ID('U_EBSWFTDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_drvTbl] (
    [drvGroupNumber] varchar(2) NOT NULL,
    [drvUserID] char(11) NULL,
    [drvEmployeeID] varchar(25) NULL,
    [drvRelation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvNickName] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDOB] datetime NULL,
    [drvGender] char(1) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvEEStatus] varchar(1) NULL,
    [drvTimeStatus] varchar(1) NULL,
    [drvPayFreq] varchar(1) NULL,
    [drvDepartmentCode] varchar(10) NULL,
    [drvLocationCode] varchar(25) NULL,
    [drvLocEffDate] datetime NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvBenClassDate] datetime NULL,
    [drvLoginAccess] varchar(1) NOT NULL,
    [drvCompDate] datetime NULL,
    [drvAnnSalary] money NULL,
    [drvHourlyRate] varchar(30) NULL,
    [drvHrsPerWeek] varchar(30) NULL,
    [drvTermReason] varchar(45) NULL,
    [drvTermDate] datetime NULL,
    [drvAutoEnroll] varchar(1) NOT NULL,
    [drvBenDropDown1] varchar(1) NOT NULL,
    [drvCoCode] char(10) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL
);

-----------
-- Create table U_EBSWFTDEMO_EEList
-----------

IF OBJECT_ID('U_EBSWFTDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBSWFTDEMO_EmpHJob_RateChange
-----------

IF OBJECT_ID('U_EBSWFTDEMO_EmpHJob_RateChange') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_EmpHJob_RateChange] (
    [EjhEEID] char(12) NOT NULL,
    [EjhEffDate] datetime NULL
);

-----------
-- Create table U_EBSWFTDEMO_EmpHJob_Transfer
-----------

IF OBJECT_ID('U_EBSWFTDEMO_EmpHJob_Transfer') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_EmpHJob_Transfer] (
    [EjhEEID] char(12) NOT NULL,
    [EjhEffDate] datetime NULL
);

-----------
-- Create table U_EBSWFTDEMO_File
-----------

IF OBJECT_ID('U_EBSWFTDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EBSWFTDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBSWFTDEMO]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Bswift Demographics Export

Created By: Richard Gray
Business Analyst: Karen Formicone
Create Date: 05/21/2019
Service Request Number: SR-2019-00225090

Purpose: Bswift Demographics Export

Revision History
----------------
Update By            Date            Request Num                Desc        
SBEEVER              07/01/2019      SR-00225090                v1.08
SBEEVER              07/05/2019      SR-00225090                v1.09
SBEEVER              07/11/2019      SR-00225090                v1.10
SBEEVER              07/12/2019      SR-00225090                v1.11
N Wetherbee          10/09/2019      SR-00225090                Set drvHrsPerWeek to not just post time for hourly emps
Kaitlyn Duesler         04/09/2020         SR-00268517                Add UDField05 logic to EENo., populate DepartmentCode with OrgLvl3
Darren Collard       12/22/2021      TekP-2021-07-16-0001       Map Term Reason Code to Business Rule




SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBSWFTDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBSWFTDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBSWFTDEMO';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'EBSWFTDEMO';

SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBSWFTDEMO' ORDER BY RunID DESC;

UPDATE dbo.U_dsi_Configuration
SET CfgValue = 'Y'
WHERE CfgName = 'UseFileName' AND FormatCode = 'EBSWFTDEMO'

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBSWFTDEMO', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBSWFTDEMO', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBSWFTDEMO', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBSWFTDEMO', @AllObjects = 'Y', @IsWeb = 'N';

**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9)

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EBSWFTDEMO';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBSWFTDEMO_EEList WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);


    --==========================================
    -- Remove EEs With 'NOPAY' Paygroup 
    --==========================================

    
    DELETE dbo.U_EBSWFTDEMO_EEList
    FROM dbo.U_EBSWFTDEMO_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecPayGroup = 'NOPAY'



    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBSWFTDEMO_AuditFields') IS NOT NULL
        DROP TABLE dbo.U_EBSWFTDEMO_AuditFields;
    CREATE TABLE dbo.U_EBSWFTDEMO_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EBSWFTDEMO_AuditFields values ('EmpComp','EecDateOfTermination')    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBSWFTDEMO_Audit') IS NOT NULL
        DROP TABLE dbo.U_EBSWFTDEMO_Audit;
    SELECT
        audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
    INTO dbo.U_EBSWFTDEMO_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EBSWFTDEMO_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EBSWFTDEMO_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6)
    AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate


    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------------
    -- vw_int_EmpHJob - Transfer Effective Date
    ---------------------------------    
    
    IF OBJECT_ID('U_EBSWFTDEMO_EmpHJob_Transfer','U') IS NOT NULL
       DROP TABLE dbo.U_EBSWFTDEMO_EmpHJob_Transfer;
    SELECT DISTINCT
        EjhEEID
        ,EjhEffDate    = MAX(EjhJobEffDate)
    INTO dbo.U_EBSWFTDEMO_EmpHJob_Transfer
    FROM dbo.vw_int_EmpHJob
    WHERE EjhIsTransfer = 'Y'
    GROUP BY EjhEEID

    ---------------------------------
    -- vw_int_EmpHJob - Rate Change Effective Date
    ---------------------------------    
    
    IF OBJECT_ID('U_EBSWFTDEMO_EmpHJob_RateChange','U') IS NOT NULL
       DROP TABLE dbo.U_EBSWFTDEMO_EmpHJob_RateChange;
    SELECT DISTINCT
        EjhEEID
        ,EjhEffDate    = MAX(EjhJobEffDate)
    INTO dbo.U_EBSWFTDEMO_EmpHJob_RateChange
    FROM dbo.vw_int_EmpHJob
    WHERE EjhIsRateChange = 'Y'
    GROUP BY EjhEEID
    
    ------------------
    -- DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EBSWFTDEMO_drvTbl') IS NOT NULL
        DROP TABLE dbo.U_EBSWFTDEMO_drvTbl;
    SELECT DISTINCT
        drvGroupNumber = 'SP'
        ,drvUserID = eepSSN
        ,drvEmployeeID =    CASE
                            WHEN ISNULL(EecUDField05,'') <> '' THEN EecUDField05    -- 4/9/20 KD added
                            ELSE ISNULL(SUBSTRING(EepNameFirst,1,1),'') + ISNULL(SUBSTRING(EepNameLast,1,1),'') + ISNULL(SUBSTRING(EepSSN,6,4),'')
                            END
                            /*CASE
                            WHEN ISNULL(EecUDField03,'') <> '' THEN EecUDField03
                            ELSE ISNULL(SUBSTRING(EepNameFirst,1,1),'') + ISNULL(SUBSTRING(EepNameLast,1,1),'') + ISNULL(SUBSTRING(EepSSN,6,4),'')
                            END*/
        ,drvRelation = 'E'
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = SUBSTRING(ISNULL(EepNameMiddle,''),1,1)
        ,drvLastName = EepNameLast
        ,drvNickName = ''
        ,drvSSN = EepSSN
        ,drvDOB = EepDateOfBirth
        ,drvGender = EepGender
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZIP = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvEmail = eepAddressEMailAlternate
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate =    CASE
                            WHEN EecDateOfLastHire > EecDateOfOriginalHire THEN EecDateOfLastHire
                            END
        ,drvEEStatus =        CASE
                            WHEN EecEmplStatus IN ('O','R','S') THEN 'T'
                            WHEN EecEmplStatus = 'L' THEN 'A'
                            ELSE EecEmplStatus
                            END
        ,drvTimeStatus =    CASE
                            WHEN EecEEType IN ('CON','PRN') THEN '4'
                            WHEN EecEEType IN ('INT', 'OTH', 'STU', 'SUM', 'TMP') AND EecSalaryOrHourly = 'S' THEN '3'
                            WHEN EecEEType IN ('INT', 'OTH', 'STU', 'SUM', 'TMP') AND EecSalaryOrHourly = 'H' THEN '7'
                            WHEN EecEEType NOT IN ('CON', 'INT', 'OTH', 'STU', 'SUM', 'TMP') THEN
                                CASE
                                WHEN EecSalaryOrHourly = 'S' AND EecFullTimeOrPartTime = 'F' THEN '1'
                                WHEN EecSalaryOrHourly = 'S' AND EecFullTimeOrPartTime = 'P' THEN '6'
                                WHEN EecSalaryOrHourly = 'H' AND EecFullTimeOrPartTime = 'F' THEN '5'
                                WHEN EecSalaryOrHourly = 'H' AND EecFullTimeOrPartTime = 'P' THEN '2'
                                END
                            END
        ,drvPayFreq =        CASE
                            WHEN EecPayPeriod = 'W' THEN '4'
                            WHEN EecPayPeriod = 'S' THEN '2'
                            WHEN EecPayPeriod = 'B' THEN '3'
                            WHEN EecPayPeriod = 'M' THEN '1'
                            END
        ,drvDepartmentCode = EecOrgLvl3 -- ''    4/9/20 KD added
        ,drvLocationCode =    EecUDField04 /*CASE                                 WHEN EecOrgLvl2 = '100000' AND EecLocation = 'AZ' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'CA' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'CO' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'CT' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'IL' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'IN' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'JCFL10' AND EecUDField01 = '7DJ'   THEN 'RIVBM'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'KY' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'LA' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'LA' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'MI' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'MLFL2' AND EecUDField01 = '7DJ'    THEN 'PRFPP'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'MO' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'MS' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'MT' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NC' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = '7DJ'    THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'SS0954' THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'DN5584' THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = '930'    THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'RN0842' THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'DP2880' THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'RL7289' THEN 'CORP'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'DF5337' THEN 'CORP'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' AND EecUDField01 = 'DB0308' THEN 'CORP'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'RTPA3' AND EecUDField01 = '7DJ'    THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'SC' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'SRFL2' AND EecUDField01 = '7DJ'    THEN 'PRSPR'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TMFL1' AND EecUDField01 = '7DJ'    THEN 'CRPSP'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TMFL4' AND EecUDField01 = '7DJ'    THEN 'PRHAB'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TMFL7' AND EecUDField01 = '7DJ'    THEN 'APSSP'                                WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TN' AND EecUDField01 = '7DJ'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'AL' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'AR' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'CA' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'GA' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'GA' AND EecUDField01 = '930'       THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'IL' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'IL' AND EecUDField01 = '930'       THEN 'CRPDP'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'IL' AND EecUDField01 = '930'       THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'MO' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'MO' AND EecUDField01 = '930'       THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'MT' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'NC' AND EecUDField01 = '930'       THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'NSTN1' AND EecUDField01 = '930'    THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'NSTN1' AND EecUDField01 = '930'    THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'NSTN1' AND EecUDField01 = '7DJ'    THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'NSTN1' AND EecUDField01 = '930'    THEN 'CRPSP'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'RTLA1' AND EecUDField01 = '930'    THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'RTMO1' AND EecUDField01 = '930'    THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'RTPA1' AND EecUDField01 = '930'    THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'RTPA2' AND EecUDField01 = '930'    THEN '500'                                WHEN EecOrgLvl2 = '100001' AND EecLocation = 'WI' AND EecUDField01 = '930'       THEN 'CRPCH'                                WHEN EecOrgLvl2 = '100002' AND EecLocation = 'TMFL1' AND EecUDField01 = '7DJ'    THEN 'CRPSP'                                WHEN EecOrgLvl2 = '100002' AND EecLocation = 'TMFL1' AND EecUDField01 = 'MM2114' THEN 'CRPSP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'AZ' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'CA' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'CO' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'FL' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'GA' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'GA' AND EecUDField01 = 'Q2S'       THEN 'CRPSP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'IA' AND EecUDField01 = 'Q2S'       THEN '500'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'IL' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'IN' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'KS' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'KY01' AND EecUDField01 = 'Q2S'     THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'LA' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'MN' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'MO' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'NC' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'NSTN1' AND EecUDField01 = '7DJ'    THEN '500'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'OH' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'RTPA4' AND EecUDField01 = 'Q2S'    THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'SC' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'TN' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'TX' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'UT' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'VA' AND EecUDField01 = 'Q2S'       THEN 'MBSSP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'WI' AND EecUDField01 = 'Q2S'       THEN 'OSH'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'WI' AND EecUDField01 = 'Q2S'       THEN 'CORP'                                WHEN EecOrgLvl2 = '103000' AND EecLocation = 'WY' AND EecUDField01 = 'Q2S'       THEN 'MBSSP'                                WHEN EecOrgLvl2 = '208001' AND EecLocation = 'JCFL10' AND EecUDField01 = 'SW6'   THEN 'ARIVR'                                WHEN EecOrgLvl2 = '209002' AND EecLocation = 'JCFL10' AND EecUDField01 = 'SBF'   THEN 'RIVBM'                                WHEN EecOrgLvl2 = '209002' AND EecLocation = 'JCFL10' AND EecUDField01 = '7DJ'   THEN '500'                                WHEN EecOrgLvl2 = '209002' AND EecLocation = 'JCFL10' AND EecUDField01 = 'SWA'   THEN 'PRROP'                                WHEN EecOrgLvl2 = '209002' AND EecLocation = 'JCFL3' AND EecUDField01 = 'SWA'    THEN 'PRROP'                                WHEN EecOrgLvl2 = '210000' AND EecLocation = 'BRGA1' AND EecUDField01 = '023'     THEN 'PRBRN'                                WHEN EecOrgLvl2 = '210000' AND EecLocation = 'JSGA2' AND EecUDField01 = '023'     THEN 'PRBRN'                                WHEN EecOrgLvl2 = '210100' AND EecLocation = 'ATGA2' AND EecUDField01 = 'PWN'    THEN 'OMEWA'                                WHEN EecOrgLvl2 = '210100' AND EecLocation = 'ATGA2' AND EecUDField01 = 'SB3184' THEN 'OMEWA'                                WHEN EecOrgLvl2 = '210100' AND EecLocation = 'ATGA2' AND EecUDField01 = 'HP1389' THEN 'OMEWA'                                WHEN EecOrgLvl2 = '210100' AND EecLocation = 'ATGA2' AND EecUDField01 = 'BM5094' THEN 'OMEWA'                                WHEN EecOrgLvl2 = '211001' AND EecLocation = 'BRGA1' AND EecUDField01 = '213'    THEN 'PRBRN'                                WHEN EecOrgLvl2 = '211001' AND EecLocation = 'BRGA1' AND EecUDField01 = '023'     THEN 'PRBRN'                                WHEN EecOrgLvl2 = '211001' AND EecLocation = 'JSGA2' AND EecUDField01 = 'SH5736' THEN 'PRBRN'                                WHEN EecOrgLvl2 = '214000' AND EecLocation = 'SMKY1' AND EecUDField01 = 'BWK'    THEN 'ADUPT'                                WHEN EecOrgLvl2 = '214000' AND EecLocation = 'SMKY1' AND EecUDField01 = 'BWK'    THEN 'ADMEW'                                WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL3' AND EecUDField01 = 'SBF'    THEN 'RIVBM'                                WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL3' AND EecUDField01 = 'SWA'    THEN 'PRROP'                                WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL4' AND EecUDField01 = 'SWA'    THEN 'PRRIV'                                WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL6' AND EecUDField01 = 'SWA'    THEN 'PRRAT'                                WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL6' AND EecUDField01 = 'RB1869' THEN 'PRRAT'                                WHEN EecOrgLvl2 = '215001' AND EecLocation = 'JBFL1' AND EecUDField01 = 'SWA'    THEN 'PRRBE'                                WHEN EecOrgLvl2 = '215001' AND EecLocation = 'JBFL1' AND EecUDField01 = 'MB1843' THEN 'PRRBE'                                WHEN EecOrgLvl2 = '215002' AND EecLocation = 'JCFL4' AND EecUDField01 = 'SWA'    THEN 'PRRIV'                                WHEN EecOrgLvl2 = '215003' AND EecLocation = 'JCFL2' AND EecUDField01 = 'SWA'    THEN 'PRRLB'                                WHEN EecOrgLvl2 = '215004' AND EecLocation = 'JCFL3' AND EecUDField01 = 'SWA'    THEN 'PRROP'                                WHEN EecOrgLvl2 = '215004' AND EecLocation = 'JCFL3' AND EecUDField01 = 'TS2763' THEN 'PRROP'                                WHEN EecOrgLvl2 = '215100' AND EecLocation = 'TMFL2' AND EecUDField01 = 'KG7'    THEN 'LOGLB'                                WHEN EecOrgLvl2 = '215100' AND EecLocation = 'TMFL2' AND EecUDField01 = '930'    THEN '500'                                WHEN EecOrgLvl2 = '221000' AND EecLocation = 'FRCT1' AND EecUDField01 = 'QBP'    THEN 'FSC'                                ELSE ''                             END*/
        
                           /*CASE
                            WHEN EecOrgLvl2 = '210100' AND EecLocation = 'ATGA2' THEN 'OMEWA'
                            WHEN EecOrgLvl2 = '210000' AND EecLocation = 'BRGA1' THEN 'PRBRN'
                            WHEN EecOrgLvl2 = '211001' AND EecLocation = 'BRGA1' THEN 'PRBRN'
                            WHEN EecOrgLvl2 = '216001' AND EecLocation = 'FRCT1' THEN 'FSC'
                            WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JBFL1' THEN 'PRRBE'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'JCFL10' THEN 'RIVBM'
                            WHEN EecOrgLvl2 = '208001' AND EecLocation = 'JCFL10' THEN 'ARIVR'
                            WHEN EecOrgLvl2 = '209002' AND EecLocation = 'JCFL10' THEN 'RIVBM'
                            WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL2' THEN 'PRRLB'
                            WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL3' THEN 'PRROP'
                            WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL4' THEN 'PRRIV'
                            WHEN EecOrgLvl2 = '215000' AND EecLocation = 'JCFL6' THEN 'PRRAT'
                            WHEN EecOrgLvl2 = '210000' AND EecLocation = 'JSGA2' THEN 'PRJES'
                            WHEN EecOrgLvl2 = '214000' AND EecLocation = 'LSKY2' THEN 'ADMEW'
                            WHEN EecOrgLvl2 = '214001' AND EecLocation = 'LSKY2' THEN 'ADUPT'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'MLFL2' THEN 'PRFPP'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'NSTN1' THEN '500'
                            WHEN EecOrgLvl2 = '100001' AND EecLocation = 'NSTN1' THEN 'CRPDP'
                            WHEN EecOrgLvl2 = '100003' AND EecLocation = 'NSTN1' THEN 'CRPCH'
                            WHEN EecOrgLvl2 = '103000' AND EecLocation = 'NSTN1' THEN 'CORP'
                            WHEN EecOrgLvl2 = '210000' AND EecLocation = 'RCGA1' THEN 'PRRIC'
                            WHEN EecOrgLvl2 = '211001' AND EecLocation = 'RCGA1' THEN 'PRRIC'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'SRFL2' THEN 'PRSPR'
                            WHEN EecOrgLvl2 = '215000' AND EecLocation = 'STFL1' THEN 'PRRSA'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TMFL1' THEN 'CRPSP'
                            WHEN EecOrgLvl2 = '215100' AND EecLocation = 'TMFL2' THEN 'LOGLB'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TMFL4' THEN 'PRHAB'
                            WHEN EecOrgLvl2 = '100000' AND EecLocation = 'TMFL7' THEN 'APSSP'
                            WHEN EecOrgLvl2 = '210000' AND EecLocation = 'WYGA1' THEN 'PRWAY'
                            WHEN EecOrgLvl2 = '211001' AND EecLocation = 'WYGA1' THEN 'PRWAY'
                            END*/
        ,drvLocEffDate =    CASE
                            WHEN Transfer.EjhEffDate > EecDateOfLastHire THEN Transfer.EjhEffDate
                            ELSE EecDateOfLastHire
                            END
        ,drvJobTitle =     ''
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkEmail = eepAddressEMail
        ,drvBenClassDate = isnull(JobEffDate_301,EecDateOfLastHire)
        ,drvLoginAccess =    CASE
                            WHEN EecEmplStatus = 'T' THEN '0'
                            ELSE '1'
                            END
        ,drvCompDate =    CASE
                        WHEN RateChange.EjhEffDate > EecDateOfLastHire THEN RateChange.EjhEffDate
                        ELSE EecDateOfLastHire
                        END
        ,drvAnnSalary =        CASE
                            WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary
                            END
        ,drvHourlyRate =    CASE
                            WHEN EecSalaryOrHourly = 'H' THEN CONVERT(VARCHAR,CONVERT(MONEY,EecHourlyPayRate))
                            ELSE ''
                            END
        ,drvHrsPerWeek =    CASE
                                WHEN EecPayPeriod = 'W' THEN CONVERT(VARCHAR,CONVERT(MONEY,EecScheduledWorkHrs))
                                WHEN EecPayPeriod = 'S' THEN CONVERT(VARCHAR,CONVERT(MONEY,(EecScheduledWorkHrs * (24.00/52.00))))
                                WHEN EecPayPeriod = 'B' THEN CONVERT(VARCHAR,CONVERT(MONEY,(EecScheduledWorkHrs * (26.00/52.00))))
                                WHEN EecPayPeriod = 'M' THEN CONVERT(VARCHAR,CONVERT(MONEY,(EecScheduledWorkHrs * (12.00/52.00))))
                                ELSE ''
                            END
        ,drvTermReason =    CASE 
                            WHEN EecEmplStatus = 'T' THEN
                                ISNULL((SELECT codDesc FROM dbo.Codes where codTable = 'CO_BSWIFTTERMINATION' AND codCode = EecTermReason),'')
                            END
/*        ,drvTermReason =    CASE 
                            WHEN EecEmplStatus = 'T' THEN
                                CASE
                                WHEN EecTermReason IN ('100', '101', '102', '103', '107', '108', '110', '202', '204', '207', '208', '209', '211', '212', '215') THEN '1'
                                WHEN EecTermReason IN ('203') THEN '4'
                                WHEN EecTermReason IN ('200') THEN '6'
                                WHEN EecTermReason IN ('105', '213') THEN '8'
                                WHEN EecTermReason IN ('106', '109', '111', '112', '113') THEN '11'
                                WHEN EecTermReason IN ('104') THEN '15'
                                WHEN EecTermReason IN ('214') THEN '18'
                                WHEN EecTermReason IN ('205') THEN '19'
                                WHEN EecTermReason IN ('EOS', 'SOS', 'SWO') THEN '25'
                                WHEN EecTermReason IN ('114', '201') THEN '28'
                                WHEN EecTermReason IN ('210') THEN '29'
                                WHEN EecTermReason IN ('206') THEN '31'
                                END
                            END*/
        ,drvTermDate = EecDateOfTermination
        ,drvAutoEnroll = '1'
        ,drvBenDropDown1 = ''
        ,drvCoCode = OrgUDField2
        ,drvEEID = xEEID
        ,drvCoID = xCoID
    INTO dbo.U_EBSWFTDEMO_drvTbl
    FROM dbo.U_EBSWFTDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl2
        AND OrgLvl = '2'
        AND OrgCode <> '218022'
    --JOIN dbo.vw_int_OrgLevel O3 WITH (NOLOCK)    -- 3/31/20 KD added
    --    ON O3.OrgCode = EecOrgLvl3
    --    AND O3.OrgLvl = '3'
    LEFT JOIN dbo.U_EBSWFTDEMO_EmpHJob_Transfer Transfer
        ON Transfer.EjhEEID = xEEID
    LEFT JOIN dbo.U_EBSWFTDEMO_EmpHJob_RateChange RateChange
        ON RateChange.EjhEEID = xEEID        
    LEFT JOIN dbo.U_EBSWFTDEMO_Audit WITH (NOLOCK)
        ON audKey1Value = xEEID
    LEFT JOIN (SELECT ejhEEID, MAX(ejhJobEffDate) JobEffDate_301
               FROM dbo.vw_int_EmpHJob WITH (NOLOCK)
               WHERE ejhReason IN ('301','400','401','700')
               GROUP BY ejhEEID) ejh_301
        ON ejh_301.ejhEEID = xeeid
    WHERE EecEmplStatus <> 'T'
        OR (EecEmplStatus = 'T' AND ISNULL(audNewValue,'') <> '')
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EBSWFTDEMO','UseFileName') = 'N')
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE
                                 WHEN @ExportCode = 'TEST' THEN 'SurgeryPartners_EMP_Demo_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                 ELSE 'SurgeryPartners_EMP_Demo_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = 'EBSWFTDEMO';

END

/*

--Alter the View
ALTER VIEW dbo.dsi_vwEBSWFTDEMO_Export as
    SELECT TOP 20000000 Data FROM dbo.U_EBSWFTDEMO_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBSWFTDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201510171'
       ,ExpStartPerControl     = '201510171'
       ,ExpLastEndPerControl   = '201510249'
       ,ExpEndPerControl       = '201510249'
WHERE ExpFormatCode = 'EBSWFTDEMO';

*/
GO
Create View dbo.dsi_vwEBSWFTDEMO_Export as
select top 200000000 Data from dbo.U_EBSWFTDEMO_File with (nolock)
order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBSWFTDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBSWFTDEMO'
   AND rpoParmType = 'expSystemID'


-- End ripout