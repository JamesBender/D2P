/**********************************************************************************

EPCSROTHV2: PCS 401K ROTH Export V2

FormatCode:     EPCSROTHV2
Project:        PCS 401K ROTH Export V2
Client ID:      TUR1007
Date/time:      2022-06-27 12:20:16.310
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB02
Database:       ULTIPRO_WPTPCC
Web Filename:   TUR1007_2ELM4_EEHISTORY_EPCSROTHV2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPCSROTHV2_SavePath') IS NOT NULL DROP TABLE dbo.U_EPCSROTHV2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPCSROTHV2'


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
WHERE FormatCode = 'EPCSROTHV2'
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
WHERE ExpFormatCode = 'EPCSROTHV2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPCSROTHV2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPCSROTHV2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPCSROTHV2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPCSROTHV2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPCSROTHV2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPCSROTHV2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPCSROTHV2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPCSROTHV2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPCSROTHV2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPCSROTHV2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPCSROTHV2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPCSROTHV2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPCSROTHV2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPCSROTHV2];
GO
IF OBJECT_ID('U_EPCSROTHV2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_PEarHist];
GO
IF OBJECT_ID('U_EPCSROTHV2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_PDedHist];
GO
IF OBJECT_ID('U_EPCSROTHV2_File') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_File];
GO
IF OBJECT_ID('U_EPCSROTHV2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_EEList];
GO
IF OBJECT_ID('U_EPCSROTHV2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_drvTbl];
GO
IF OBJECT_ID('U_EPCSROTHV2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_DedList];
GO
IF OBJECT_ID('U_EPCSROTHV2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_AuditFields];
GO
IF OBJECT_ID('U_EPCSROTHV2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPCSROTHV2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPCSROTHV2','PCS 401K ROTH Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EPCSROTHV2Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPCSROTHV2Z0','50','H','01','1',NULL,'Check Date',NULL,NULL,'"Check Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPCSROTHV2Z0','50','H','01','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPCSROTHV2Z0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPCSROTHV2Z0','50','H','01','4',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPCSROTHV2Z0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPCSROTHV2Z0','50','H','01','6',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPCSROTHV2Z0','50','H','01','7',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPCSROTHV2Z0','50','H','01','8',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPCSROTHV2Z0','50','H','01','9',NULL,'Employee Status',NULL,NULL,'"Employee Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPCSROTHV2Z0','50','H','01','10',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPCSROTHV2Z0','50','H','01','11',NULL,'Company/Division Code',NULL,NULL,'"Company/Division Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPCSROTHV2Z0','50','H','01','12',NULL,'Union Status',NULL,NULL,'"Union Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPCSROTHV2Z0','50','H','01','13',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPCSROTHV2Z0','50','H','01','14',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPCSROTHV2Z0','50','H','01','15',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPCSROTHV2Z0','50','H','01','16',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPCSROTHV2Z0','50','H','01','17',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPCSROTHV2Z0','50','H','01','18',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPCSROTHV2Z0','50','H','01','19',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPCSROTHV2Z0','50','H','01','20',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPCSROTHV2Z0','50','H','01','21',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPCSROTHV2Z0','50','H','01','22',NULL,'Gross Earnings',NULL,NULL,'"Gross Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPCSROTHV2Z0','50','H','01','23',NULL,'Pay Period Hours',NULL,NULL,'"Pay Period Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPCSROTHV2Z0','50','H','01','24',NULL,'Employee Deferral',NULL,NULL,'"Employee Deferral"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPCSROTHV2Z0','50','H','01','25',NULL,'Employee Roth',NULL,NULL,'"Employee Roth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPCSROTHV2Z0','50','H','01','26',NULL,'Loan Payments',NULL,NULL,'"Loan Payments"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPCSROTHV2Z0','50','H','01','27',NULL,'Employee After Tax',NULL,NULL,'"Employee After Tax"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPCSROTHV2Z0','50','H','01','28',NULL,'Employer Match',NULL,NULL,'"Employer Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPCSROTHV2Z0','50','H','01','29',NULL,'Safe Harbor Match',NULL,NULL,'"Safe Harbor Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPCSROTHV2Z0','50','H','01','30',NULL,'Safe Harbor Non-Elective',NULL,NULL,'"Safe Harbor Non-Elective"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPCSROTHV2Z0','50','H','01','31',NULL,'Qualified Matching Contribution',NULL,NULL,'"Qualified Matching Contribution"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPCSROTHV2Z0','50','H','01','32',NULL,'Qualified Non-Elective Contribution',NULL,NULL,'"Qualified Non-Elective Contribution"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPCSROTHV2Z0','50','H','01','33',NULL,'Profit Sharing',NULL,NULL,'"Profit Sharing"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPCSROTHV2Z0','50','H','01','34',NULL,'Money Purchase',NULL,NULL,'"Money Purchase"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPCSROTHV2Z0','50','H','01','35',NULL,'Pay Frequency',NULL,NULL,'"Pay Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPCSROTHV2Z0','50','H','01','36',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPCSROTHV2Z0','50','H','01','37',NULL,'Phone Number',NULL,NULL,'"Phone Number"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPCSROTHV2Z0','50','D','10','1',NULL,'Check Date',NULL,NULL,'"drvPrgPayDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPCSROTHV2Z0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPCSROTHV2Z0','50','D','10','3',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPCSROTHV2Z0','50','D','10','4',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPCSROTHV2Z0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPCSROTHV2Z0','50','D','10','6',NULL,'Title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPCSROTHV2Z0','50','D','10','7',NULL,'Employee ID',NULL,NULL,'"drvEecEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPCSROTHV2Z0','50','D','10','8',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPCSROTHV2Z0','50','D','10','9',NULL,'Employee Status',NULL,NULL,'"drvEmpStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPCSROTHV2Z0','50','D','10','10',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPCSROTHV2Z0','50','D','10','11',NULL,'Company/Division Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPCSROTHV2Z0','50','D','10','12',NULL,'Union Status',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPCSROTHV2Z0','50','D','10','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPCSROTHV2Z0','50','D','10','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPCSROTHV2Z0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPCSROTHV2Z0','50','D','10','16',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPCSROTHV2Z0','50','D','10','17',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPCSROTHV2Z0','50','D','10','18',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPCSROTHV2Z0','50','D','10','19',NULL,'Hire Date',NULL,NULL,'"drvDateOfOriginalHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPCSROTHV2Z0','50','D','10','20',NULL,'Termination Date',NULL,NULL,'"drvDateOfTermination"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPCSROTHV2Z0','50','D','10','21',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPCSROTHV2Z0','50','D','10','22',NULL,'Gross Earnings',NULL,NULL,'"drvGrossEarn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPCSROTHV2Z0','50','D','10','23',NULL,'Pay Period Hours',NULL,NULL,'"drvPayPrdHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPCSROTHV2Z0','50','D','10','24',NULL,'Employee Deferral',NULL,NULL,'"drvEmpDef"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPCSROTHV2Z0','50','D','10','25',NULL,'Employee Roth',NULL,NULL,'"drvEmpRoth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPCSROTHV2Z0','50','D','10','26',NULL,'Loan Payments',NULL,NULL,'"drvLoanPayments"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPCSROTHV2Z0','50','D','10','27',NULL,'Employee After Tax',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPCSROTHV2Z0','50','D','10','28',NULL,'Employer Match',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPCSROTHV2Z0','50','D','10','29',NULL,'Safe Harbor Match',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPCSROTHV2Z0','50','D','10','30',NULL,'Safe Harbor Non-Elective',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPCSROTHV2Z0','50','D','10','31',NULL,'Qualified Matching Contribution',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPCSROTHV2Z0','50','D','10','32',NULL,'Qualified Non-Elective Contribution',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPCSROTHV2Z0','50','D','10','33',NULL,'Profit Sharing',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPCSROTHV2Z0','50','D','10','34',NULL,'Money Purchase',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPCSROTHV2Z0','50','D','10','35',NULL,'Pay Frequency',NULL,NULL,'"drvPayFreq"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPCSROTHV2Z0','50','D','10','36',NULL,'Email',NULL,NULL,'"drvAddressEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPCSROTHV2Z0','50','D','10','37',NULL,'Phone Number',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPCSROTHV2_20220627.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PCS 401K ROTH Export V2','202206079','EMPEXPORT','ONDEM_XOE',NULL,'EPCSROTHV2',NULL,NULL,NULL,'202206079','Jul 14 2021  8:36AM','Jul 14 2021  8:36AM','202206011',NULL,'','','202206011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PCS 401K ROTH Export V2-Sched','202206079','EMPEXPORT','SCH_EPCS40',NULL,'EPCSROTHV2',NULL,NULL,NULL,'202206079','Jul 14 2021  8:36AM','Jul 14 2021  8:36AM','202206011',NULL,'','','202206011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'PCS 401K ROTH Export V2-Test','202206079','EMPEXPORT','TEST_XOE','Sep 15 2021  2:40PM','EPCSROTHV2',NULL,NULL,NULL,'202206079','Sep  7 2021 12:00AM','Dec 30 1899 12:00AM','202206011','659','eecPayGroup','001','202206011',dbo.fn_GetTimedKey(),NULL,'us3cPeTUR1007',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPCSROTHV2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPCSROTHV2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPCSROTHV2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPCSROTHV2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPCSROTHV2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPCSROTHV2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPCSROTHV2','D10','dbo.U_EPCSROTHV2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPCSROTHV2_Audit
-----------

IF OBJECT_ID('U_EPCSROTHV2_Audit') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EPCSROTHV2_AuditFields
-----------

IF OBJECT_ID('U_EPCSROTHV2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPCSROTHV2_DedList
-----------

IF OBJECT_ID('U_EPCSROTHV2_DedList') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPCSROTHV2_drvTbl
-----------

IF OBJECT_ID('U_EPCSROTHV2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvPrgPayDate] datetime NULL,
    [drvSSN] varchar(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvTitle] varchar(25) NOT NULL,
    [drvEecEmpNo] char(9) NULL,
    [drvGender] char(1) NULL,
    [drvEmpStatus] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvGrossEarn] varchar(8) NULL,
    [drvPayPrdHours] varchar(8) NULL,
    [drvEmpDef] varchar(8) NULL,
    [drvEmpRoth] varchar(8) NULL,
    [drvLoanPayments] varchar(8) NULL,
    [drvPayFreq] char(1) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL
);

-----------
-- Create table U_EPCSROTHV2_EEList
-----------

IF OBJECT_ID('U_EPCSROTHV2_EEList') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPCSROTHV2_File
-----------

IF OBJECT_ID('U_EPCSROTHV2_File') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EPCSROTHV2_PDedHist
-----------

IF OBJECT_ID('U_EPCSROTHV2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEmpDef] money NULL,
    [PdhROTH] money NULL,
    [PdhRLOAN] money NULL,
    [PdhLOAN3] money NULL
);

-----------
-- Create table U_EPCSROTHV2_PEarHist
-----------

IF OBJECT_ID('U_EPCSROTHV2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPCSROTHV2_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] money NULL,
    [PehCurHrs] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPCSROTHV2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Turning Point of Central California

Created By: Keary McCutchen
Business Analyst: Cheryl Petitti
Create Date: 07/14/2021
Service Request Number: SR-2016-00012345

Purpose: PCS 401K ROTH Export V2

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters      06/07/2022    TekP-2022-06-06-01   Add new deduction code logic for loan amounts

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPCSROTHV2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPCSROTHV2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPCSROTHV2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPCSROTHV2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPCSROTHV2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPCSROTHV2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPCSROTHV2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPCSROTHV2', 'SCH_EPCS40';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPCSROTHV2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPCSROTHV2';

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
    DELETE FROM dbo.U_EPCSROTHV2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPCSROTHV2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Pay Group 001 Only
    DELETE EE
       FROM dbo.U_EPCSROTHV2_EEList EE
      JOIN dbo.EmpComp WITH (NOLOCK)    
          ON EecEEID = xEEID
         AND EecCOID = xCOID
     WHERE EecPayGroup <> '001'
     ;
     --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EPCSROTHV2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPCSROTHV2_AuditFields;
    CREATE TABLE dbo.U_EPCSROTHV2_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EPCSROTHV2_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPCSROTHV2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPCSROTHV2_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EPCSROTHV2_Audit
    FROM dbo.U_EPCSROTHV2_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EPCSROTHV2_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN DATEADD(day,-30,@StartDate) AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    ;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403B,403P,ROTH,ROTHP,RLOAN,LOAN3';

    IF OBJECT_ID('U_EPCSROTHV2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPCSROTHV2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPCSROTHV2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPCSROTHV2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPCSROTHV2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Categorize Payroll Amounts
        ,PdhEmpDef      = SUM(CASE WHEN PdhDedCode IN ('403P','403B') THEN PdhEECurAmt END)
        ,PdhROTH        = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTHP') THEN PdhEECurAmt END)
        ,PdhRLOAN       = SUM(CASE WHEN PdhDedCode IN ('RLOAN') THEN PdhEECurAmt END)
        ,PdhLOAN3        = SUM(CASE WHEN PdhDedCode IN ('LOAN3') THEN PdhEECurAmt END) -- Added 6/27/22
    INTO dbo.U_EPCSROTHV2_PDedHist
    FROM dbo.U_EPCSROTHV2_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EPCSROTHV2_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING SUM(CASE WHEN PdhDedCode IN ('403P','403B') THEN PdhEECurAmt END) IS NOT NULL
        OR SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTHP') THEN PdhEECurAmt END) IS NOT NULL
        OR SUM(CASE WHEN PdhDedCode IN ('RLOAN') THEN PdhEECurAmt END) IS NOT NULL
        OR SUM(CASE WHEN PdhDedCode IN ('LOAN3') THEN PdhEECurAmt END) IS NOT NULL
    ;
    
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPCSROTHV2_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPCSROTHV2_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PehCurAmt              = SUM(CASE WHEN PehEarnCode NOT IN ('MIL') THEN PehCurAmt END)
        ,PehCurHrs              = SUM(CASE WHEN PehEarnCode NOT IN ('HRWK','MIL','LWOP') THEN PehCurHrs END)
    INTO dbo.U_EPCSROTHV2_PEarHist
    FROM dbo.U_EPCSROTHV2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(CASE WHEN PehEarnCode NOT IN ('MIL') THEN PehCurAmt END) IS NOT NULL
        OR SUM(CASE WHEN PehEarnCode NOT IN ('HRWK','MIL','LWOP') THEN PehCurHrs END) IS NOT NULL
    ;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPCSROTHV2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPCSROTHV2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPCSROTHV2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvPrgPayDate = (SELECT MAX(PrgPayDate) FROM dbo.U_EPCSROTHV2_PEarHist WITH (nolock))
        ,drvSSN =  SUBSTRING(eepSSN, 1, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6,4)  
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvTitle = JbcDesc
        ,drvEecEmpNo = EecEmpNo
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvEmpStatus = CASE WHEN EecEmplStatus = 'A' THEN 'E'
                             WHEN EecEmplStatus = 'L' THEN 'L'
                             WHEN EecEmplStatus = 'T' THEN 'T'
                             WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                             WHEN EecEmplStatus = 'T' AND EecTermREason = '202' THEN 'R'
                        END
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus IN ('S','M','D','W') THEN EepMaritalStatus ELSE 'O' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                                     WHEN EecEmplStatus IN ('A','L') AND EecDateOfLastHire <> EecDateOfOriginalHire THEN  EecUDField07 
                                 END
        ,drvRehireDate =  CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvGrossEarn = LTRIM(STR(CASE WHEN PehCurAmt = 0.00 THEN NULL ELSE PehCurAmt END,8,2))
        ,drvPayPrdHours = LTRIM(STR(CASE WHEN PehCurHrs = 0.00 THEN NULL ELSE PehCurHrs END,8,2)) 
        ,drvEmpDef = LTRIM(STR(CASE WHEN PdhEmpDef = 0.00 THEN NULL ELSE PdhEmpDef END,8,2)) 
        ,drvEmpRoth = LTRIM(STR(CASE WHEN PdhROTH = 0.00 THEN NULL ELSE PdhROTH END,8,2)) 
        ,drvLoanPayments = LTRIM(STR(CASE WHEN PdhLoan3 = 0.00 THEN NULL ELSE PdhLoan3 END,8,2)) -- Added 6/27/22
        ,drvPayFreq = CASE WHEN PgrPayFrequency = 'S' THEN PgrPayFrequency END
        ,drvAddressEmail = EepAddressEMail
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
    INTO dbo.U_EPCSROTHV2_drvTbl
    FROM dbo.U_EPCSROTHV2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecCoID = xCoID
        AND (EecEmplStatus <> 'T' OR EXISTS (Select 1 from dbo.U_EPCSROTHV2_Audit where xEEID = AudEEID and AudFieldName = 'EecDateOfTermination'))  
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_EPCSROTHV2_PEarHist WITH (NOLOCK)    
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EPCSROTHV2_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup= EecPayGroup
    
                               
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
ALTER VIEW dbo.dsi_vwEPCSROTHV2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPCSROTHV2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPCSROTHV2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206011'
       ,expStartPerControl     = '202206011'
       ,expLastEndPerControl   = '202206079'
       ,expEndPerControl       = '202206079'
WHERE expFormatCode = 'EPCSROTHV2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPCSROTHV2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPCSROTHV2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPCSROTHV2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPCSROTHV2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPCSROTHV2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPCSROTHV2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPCSROTHV2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPCSROTHV2', 'UseFileName', 'V', 'Y'


-- End ripout