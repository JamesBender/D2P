/**********************************************************************************

EFRAOPQB: OPTUM COBRA QB

FormatCode:     EFRAOPQB
Project:        OPTUM COBRA QB
Client ID:      FRA1003
Date/time:      2024-01-24 08:56:17.540
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N23
Server:         N2SUP3DB02
Database:       ULTIPRO_FRANDSEN
Web Filename:   FRA1003_95710_EEHISTORY_EFRAOPQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFRAOPQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EFRAOPQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFRAOPQB'


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
WHERE FormatCode = 'EFRAOPQB'
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
WHERE ExpFormatCode = 'EFRAOPQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFRAOPQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFRAOPQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFRAOPQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFRAOPQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFRAOPQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFRAOPQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFRAOPQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFRAOPQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFRAOPQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFRAOPQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFRAOPQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFRAOPQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFRAOPQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFRAOPQB];
GO
IF OBJECT_ID('U_EFRAOPQB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_PEarHist];
GO
IF OBJECT_ID('U_EFRAOPQB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_PDedHist];
GO
IF OBJECT_ID('U_EFRAOPQB_File') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_File];
GO
IF OBJECT_ID('U_EFRAOPQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_EEList];
GO
IF OBJECT_ID('U_EFRAOPQB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_drvTbl];
GO
IF OBJECT_ID('U_EFRAOPQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_DedList];
GO
IF OBJECT_ID('U_EFRAOPQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_AuditFields];
GO
IF OBJECT_ID('U_EFRAOPQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFRAOPQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFRAOPQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFRAOPQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFRAOPQB','OPTUM COBRA QB','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','8000','S','N','EFRAOPQB00Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFRAOPQB00Z0','50','H','01','1',NULL,'Employer Code',NULL,NULL,'"Employer Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFRAOPQB00Z0','50','H','01','2',NULL,'Branch Code',NULL,NULL,'"Branch Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFRAOPQB00Z0','50','H','01','3',NULL,'Notification Date',NULL,NULL,'"Notification Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFRAOPQB00Z0','50','H','01','4',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFRAOPQB00Z0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFRAOPQB00Z0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFRAOPQB00Z0','50','H','01','7',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFRAOPQB00Z0','50','H','01','8',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFRAOPQB00Z0','50','H','01','9',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFRAOPQB00Z0','50','H','01','10',NULL,'Town or City',NULL,NULL,'"Town or City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFRAOPQB00Z0','50','H','01','11',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFRAOPQB00Z0','50','H','01','12',NULL,'Postal Code',NULL,NULL,'"Postal Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFRAOPQB00Z0','50','H','01','13',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFRAOPQB00Z0','50','H','01','14',NULL,'Sex',NULL,NULL,'"Sex"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFRAOPQB00Z0','50','H','01','15',NULL,'Qualifying Event Date',NULL,NULL,'"Qualifying Event Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFRAOPQB00Z0','50','H','01','16',NULL,'Qualifying Event',NULL,NULL,'"Qualifying Event"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFRAOPQB00Z0','50','H','01','17',NULL,'COBRA Begins',NULL,NULL,'"COBRA Begins"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFRAOPQB00Z0','50','H','01','18',NULL,'Employee Full Name',NULL,NULL,'"Employee Full Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFRAOPQB00Z0','50','H','01','19',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFRAOPQB00Z0','50','H','01','20',NULL,'Employee Special',NULL,NULL,'"Employee Special"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EFRAOPQB00Z0','50','H','01','21',NULL,'Medical Plan Start Date',NULL,NULL,'"Medical Plan Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EFRAOPQB00Z0','50','H','01','22',NULL,'Medical Plan',NULL,NULL,'"Medical Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EFRAOPQB00Z0','50','H','01','23',NULL,'Medical Coverage',NULL,NULL,'"Medical Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EFRAOPQB00Z0','50','H','01','24',NULL,'Dental Plan',NULL,NULL,'"Dental Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EFRAOPQB00Z0','50','H','01','25',NULL,'Dental Coverage',NULL,NULL,'"Dental Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EFRAOPQB00Z0','50','H','01','26',NULL,'Vision Plan',NULL,NULL,'"Vision Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EFRAOPQB00Z0','50','H','01','27',NULL,'Vision Coverage',NULL,NULL,'"Vision Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EFRAOPQB00Z0','50','H','01','28',NULL,'Other Plan',NULL,NULL,'"Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EFRAOPQB00Z0','50','H','01','29',NULL,'Other Coverage',NULL,NULL,'"Other Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EFRAOPQB00Z0','50','H','01','30',NULL,'Life Plan 1',NULL,NULL,'"Life Plan 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EFRAOPQB00Z0','50','H','01','31',NULL,'Life Plan 1 Coverage',NULL,NULL,'"Life Plan 1 Coverage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EFRAOPQB00Z0','50','H','01','32',NULL,'Life Plan 1 Volume',NULL,NULL,'"Life Plan 1 Volume"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EFRAOPQB00Z0','50','H','01','33',NULL,'Life Plan 2',NULL,NULL,'"Life Plan 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EFRAOPQB00Z0','50','H','01','34',NULL,'Life 2 Coverage',NULL,NULL,'"Life 2 Coverage "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EFRAOPQB00Z0','50','H','01','35',NULL,'Life 2 Volume',NULL,NULL,'"Life 2 Volume"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EFRAOPQB00Z0','50','H','01','36',NULL,'Life Plan 3',NULL,NULL,'"Life Plan 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EFRAOPQB00Z0','50','H','01','37',NULL,'Life 3 Coverage',NULL,NULL,'"Life 3 Coverage "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EFRAOPQB00Z0','50','H','01','38',NULL,'Life 3 Volume',NULL,NULL,'"Life 3 Volume"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EFRAOPQB00Z0','50','H','01','39',NULL,'Life Plan 4',NULL,NULL,'"Life Plan 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EFRAOPQB00Z0','50','H','01','40',NULL,'Life 4 Coverage',NULL,NULL,'"Life 4 Coverage "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EFRAOPQB00Z0','50','H','01','41',NULL,'Life 4 Volume',NULL,NULL,'"Life 4 Volume"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EFRAOPQB00Z0','50','H','01','42',NULL,'Flex Plan',NULL,NULL,'"Flex Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EFRAOPQB00Z0','50','H','01','43',NULL,'Flex Plan Coverage Level',NULL,NULL,'"Flex Plan Coverage Level"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EFRAOPQB00Z0','50','H','01','44',NULL,'Flex Healthcare Amount',NULL,NULL,'"Flex Healthcare Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EFRAOPQB00Z0','50','H','01','45',NULL,'Flex Plan End Date',NULL,NULL,'"Flex Plan End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EFRAOPQB00Z0','50','H','01','46',NULL,'qDep 1.Dep Last Name',NULL,NULL,'"qDep 1.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EFRAOPQB00Z0','50','H','01','47',NULL,'qDep 1.Dep First Name',NULL,NULL,'"qDep 1.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EFRAOPQB00Z0','50','H','01','48',NULL,'qDep 1.Dep SSN',NULL,NULL,'"qDep 1.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EFRAOPQB00Z0','50','H','01','49',NULL,'qDep 1.Gender',NULL,NULL,'"qDep 1.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EFRAOPQB00Z0','50','H','01','50',NULL,'qDep 1.Relationship',NULL,NULL,'"qDep 1.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EFRAOPQB00Z0','50','H','01','51',NULL,'qDep 1.Dep Date of Birth',NULL,NULL,'"qDep 1.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EFRAOPQB00Z0','50','H','01','52',NULL,'qDep 1.Dep Medical',NULL,NULL,'"qDep 1.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EFRAOPQB00Z0','50','H','01','53',NULL,'qDep 1.Dep Dental',NULL,NULL,'"qDep 1.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EFRAOPQB00Z0','50','H','01','54',NULL,'qDep 1.Dep Vision',NULL,NULL,'"qDep 1.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EFRAOPQB00Z0','50','H','01','55',NULL,'qDep 1.Dep Other Plan',NULL,NULL,'"qDep 1.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EFRAOPQB00Z0','50','H','01','56',NULL,'qDep 2.Dep Last Name',NULL,NULL,'"qDep 2.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EFRAOPQB00Z0','50','H','01','57',NULL,'qDep 2.Dep First Name',NULL,NULL,'"qDep 2.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EFRAOPQB00Z0','50','H','01','58',NULL,'qDep 2.Dep SSN',NULL,NULL,'"qDep 2.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EFRAOPQB00Z0','50','H','01','59',NULL,'qDep 2.Gender',NULL,NULL,'"qDep 2.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EFRAOPQB00Z0','50','H','01','60',NULL,'qDep 2.Relationship',NULL,NULL,'"qDep 2.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EFRAOPQB00Z0','50','H','01','61',NULL,'qDep 2.Dep Date of Birth',NULL,NULL,'"qDep 2.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EFRAOPQB00Z0','50','H','01','62',NULL,'qDep 2.Dep Medical',NULL,NULL,'"qDep 2.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EFRAOPQB00Z0','50','H','01','63',NULL,'qDep 2.Dep Dental',NULL,NULL,'"qDep 2.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EFRAOPQB00Z0','50','H','01','64',NULL,'qDep 2.Dep Vision',NULL,NULL,'"qDep 2.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EFRAOPQB00Z0','50','H','01','65',NULL,'qDep 2.Dep Other Plan',NULL,NULL,'"qDep 2.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EFRAOPQB00Z0','50','H','01','66',NULL,'qDep 3.Dep Last Name',NULL,NULL,'"qDep 3.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EFRAOPQB00Z0','50','H','01','67',NULL,'qDep 3.Dep First Name',NULL,NULL,'"qDep 3.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EFRAOPQB00Z0','50','H','01','68',NULL,'qDep 3.Dep SSN',NULL,NULL,'"qDep 3.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EFRAOPQB00Z0','50','H','01','69',NULL,'qDep 3.Gender',NULL,NULL,'"qDep 3.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EFRAOPQB00Z0','50','H','01','70',NULL,'qDep 3.Relationship',NULL,NULL,'"qDep 3.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EFRAOPQB00Z0','50','H','01','71',NULL,'qDep 3.Dep Date of Birth',NULL,NULL,'"qDep 3.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EFRAOPQB00Z0','50','H','01','72',NULL,'qDep 3.Dep Medical',NULL,NULL,'"qDep 3.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EFRAOPQB00Z0','50','H','01','73',NULL,'qDep 3.Dep Dental',NULL,NULL,'"qDep 3.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EFRAOPQB00Z0','50','H','01','74',NULL,'qDep 3.Dep Vision',NULL,NULL,'"qDep 3.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EFRAOPQB00Z0','50','H','01','75',NULL,'qDep 3.Dep Other Plan',NULL,NULL,'"qDep 3.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EFRAOPQB00Z0','50','H','01','76',NULL,'qDep 4.Dep Last Name',NULL,NULL,'"qDep 4.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EFRAOPQB00Z0','50','H','01','77',NULL,'qDep 4.Dep First Name',NULL,NULL,'"qDep 4.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EFRAOPQB00Z0','50','H','01','78',NULL,'qDep 4.Dep SSN',NULL,NULL,'"qDep 4.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EFRAOPQB00Z0','50','H','01','79',NULL,'qDep 4.Gender',NULL,NULL,'"qDep 4.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EFRAOPQB00Z0','50','H','01','80',NULL,'qDep 4.Relationship',NULL,NULL,'"qDep 4.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EFRAOPQB00Z0','50','H','01','81',NULL,'qDep 4.Dep Date of Birth',NULL,NULL,'"qDep 4.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EFRAOPQB00Z0','50','H','01','82',NULL,'qDep 4.Dep Medical',NULL,NULL,'"qDep 4.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EFRAOPQB00Z0','50','H','01','83',NULL,'qDep 4.Dep Dental',NULL,NULL,'"qDep 4.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EFRAOPQB00Z0','50','H','01','84',NULL,'qDep 4.Dep Vision',NULL,NULL,'"qDep 4.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EFRAOPQB00Z0','50','H','01','85',NULL,'qDep 4.Dep Other Plan',NULL,NULL,'"qDep 4.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EFRAOPQB00Z0','50','H','01','86',NULL,'qDep 5.Dep Last Name',NULL,NULL,'"qDep 5.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EFRAOPQB00Z0','50','H','01','87',NULL,'qDep 5.Dep First Name',NULL,NULL,'"qDep 5.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EFRAOPQB00Z0','50','H','01','88',NULL,'qDep 5.Dep SSN',NULL,NULL,'"qDep 5.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EFRAOPQB00Z0','50','H','01','89',NULL,'qDep 5.Gender',NULL,NULL,'"qDep 5.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EFRAOPQB00Z0','50','H','01','90',NULL,'qDep 5.Relationship',NULL,NULL,'"qDep 5.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EFRAOPQB00Z0','50','H','01','91',NULL,'qDep 5.Dep Date of Birth',NULL,NULL,'"qDep 5.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EFRAOPQB00Z0','50','H','01','92',NULL,'qDep 5.Dep Medical',NULL,NULL,'"qDep 5.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EFRAOPQB00Z0','50','H','01','93',NULL,'qDep 5.Dep Dental',NULL,NULL,'"qDep 5.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EFRAOPQB00Z0','50','H','01','94',NULL,'qDep 5.Dep Vision',NULL,NULL,'"qDep 5.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EFRAOPQB00Z0','50','H','01','95',NULL,'qDep 5.Dep Other Plan',NULL,NULL,'"qDep 5.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EFRAOPQB00Z0','50','H','01','96',NULL,'qDep 6.Dep Last Name',NULL,NULL,'"qDep 6.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EFRAOPQB00Z0','50','H','01','97',NULL,'qDep 6.Dep First Name',NULL,NULL,'"qDep 6.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EFRAOPQB00Z0','50','H','01','98',NULL,'qDep 6.Dep SSN',NULL,NULL,'"qDep 6.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EFRAOPQB00Z0','50','H','01','99',NULL,'qDep 6.Gender',NULL,NULL,'"qDep 6.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EFRAOPQB00Z0','50','H','01','100',NULL,'qDep 6.Relationship',NULL,NULL,'"qDep 6.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EFRAOPQB00Z0','50','H','01','101',NULL,'qDep 6.Dep Date of Birth',NULL,NULL,'"qDep 6.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EFRAOPQB00Z0','50','H','01','102',NULL,'qDep 6.Dep Medical',NULL,NULL,'"qDep 6.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EFRAOPQB00Z0','50','H','01','103',NULL,'qDep 6.Dep Dental',NULL,NULL,'"qDep 6.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EFRAOPQB00Z0','50','H','01','104',NULL,'qDep 6.Dep Vision',NULL,NULL,'"qDep 6.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EFRAOPQB00Z0','50','H','01','105',NULL,'qDep 6.Dep Other Plan',NULL,NULL,'"qDep 6.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EFRAOPQB00Z0','50','H','01','106',NULL,'qDep 7.Dep Last Name',NULL,NULL,'"qDep 7.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EFRAOPQB00Z0','50','H','01','107',NULL,'qDep 7.Dep First Name',NULL,NULL,'"qDep 7.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EFRAOPQB00Z0','50','H','01','108',NULL,'qDep 7.Dep SSN',NULL,NULL,'"qDep 7.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EFRAOPQB00Z0','50','H','01','109',NULL,'qDep 7.Gender',NULL,NULL,'"qDep 7.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EFRAOPQB00Z0','50','H','01','110',NULL,'qDep 7.Relationship',NULL,NULL,'"qDep 7.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EFRAOPQB00Z0','50','H','01','111',NULL,'qDep 7.Dep Date of Birth',NULL,NULL,'"qDep 7.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EFRAOPQB00Z0','50','H','01','112',NULL,'qDep 7.Dep Medical',NULL,NULL,'"qDep 7.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EFRAOPQB00Z0','50','H','01','113',NULL,'qDep 7.Dep Dental',NULL,NULL,'"qDep 7.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EFRAOPQB00Z0','50','H','01','114',NULL,'qDep 7.Dep Vision',NULL,NULL,'"qDep 7.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EFRAOPQB00Z0','50','H','01','115',NULL,'qDep 7.Dep Other Plan',NULL,NULL,'"qDep 7.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EFRAOPQB00Z0','50','H','01','116',NULL,'qDep 8.Dep Last Name',NULL,NULL,'"qDep 8.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EFRAOPQB00Z0','50','H','01','117',NULL,'qDep 8.Dep First Name',NULL,NULL,'"qDep 8.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EFRAOPQB00Z0','50','H','01','118',NULL,'qDep 8.Dep SSN',NULL,NULL,'"qDep 8.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EFRAOPQB00Z0','50','H','01','119',NULL,'qDep 8.Gender',NULL,NULL,'"qDep 8.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EFRAOPQB00Z0','50','H','01','120',NULL,'qDep 8.Relationship',NULL,NULL,'"qDep 8.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EFRAOPQB00Z0','50','H','01','121',NULL,'qDep 8.Dep Date of Birth',NULL,NULL,'"qDep 8.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EFRAOPQB00Z0','50','H','01','122',NULL,'qDep 8.Dep Medical',NULL,NULL,'"qDep 8.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EFRAOPQB00Z0','50','H','01','123',NULL,'qDep 8.Dep Dental',NULL,NULL,'"qDep 8.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EFRAOPQB00Z0','50','H','01','124',NULL,'qDep 8.Dep Vision',NULL,NULL,'"qDep 8.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EFRAOPQB00Z0','50','H','01','125',NULL,'qDep 8.Dep Other Plan',NULL,NULL,'"qDep 8.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EFRAOPQB00Z0','50','H','01','126',NULL,'qDep 9.Dep Last Name',NULL,NULL,'"qDep 9.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EFRAOPQB00Z0','50','H','01','127',NULL,'qDep 9.Dep First Name',NULL,NULL,'"qDep 9.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EFRAOPQB00Z0','50','H','01','128',NULL,'qDep 9.Dep SSN',NULL,NULL,'"qDep 9.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EFRAOPQB00Z0','50','H','01','129',NULL,'qDep 9.Gender',NULL,NULL,'"qDep 9.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EFRAOPQB00Z0','50','H','01','130',NULL,'qDep 9.Relationship',NULL,NULL,'"qDep 9.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EFRAOPQB00Z0','50','H','01','131',NULL,'qDep 9.Dep Date of Birth',NULL,NULL,'"qDep 9.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EFRAOPQB00Z0','50','H','01','132',NULL,'qDep 9.Dep Medical',NULL,NULL,'"qDep 9.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EFRAOPQB00Z0','50','H','01','133',NULL,'qDep 9.Dep Dental',NULL,NULL,'"qDep 9.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EFRAOPQB00Z0','50','H','01','134',NULL,'qDep 9.Dep Vision',NULL,NULL,'"qDep 9.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EFRAOPQB00Z0','50','H','01','135',NULL,'qDep 9.Dep Other Plan',NULL,NULL,'"qDep 9.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EFRAOPQB00Z0','50','H','01','136',NULL,'qDep 10.Dep Last Name',NULL,NULL,'"qDep 10.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EFRAOPQB00Z0','50','H','01','137',NULL,'qDep 10.Dep First Name',NULL,NULL,'"qDep 10.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EFRAOPQB00Z0','50','H','01','138',NULL,'qDep 10.Dep SSN',NULL,NULL,'"qDep 10.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EFRAOPQB00Z0','50','H','01','139',NULL,'qDep 10.Gender',NULL,NULL,'"qDep 10.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EFRAOPQB00Z0','50','H','01','140',NULL,'qDep 10.Relationship',NULL,NULL,'"qDep 10.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EFRAOPQB00Z0','50','H','01','141',NULL,'qDep 10.Dep Date of Birth',NULL,NULL,'"qDep 10.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EFRAOPQB00Z0','50','H','01','142',NULL,'qDep 10.Dep Medical',NULL,NULL,'"qDep 10.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EFRAOPQB00Z0','50','H','01','143',NULL,'qDep 10.Dep Dental',NULL,NULL,'"qDep 10.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EFRAOPQB00Z0','50','H','01','144',NULL,'qDep 10.Dep Vision',NULL,NULL,'"qDep 10.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EFRAOPQB00Z0','50','H','01','145',NULL,'qDep 10.Dep Other Plan',NULL,NULL,'"qDep 10.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EFRAOPQB00Z0','50','H','01','146',NULL,'qDep 11.Dep Last Name',NULL,NULL,'"qDep 11.Dep Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EFRAOPQB00Z0','50','H','01','147',NULL,'qDep 11.Dep First Name',NULL,NULL,'"qDep 11.Dep First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EFRAOPQB00Z0','50','H','01','148',NULL,'qDep 11.Dep SSN',NULL,NULL,'"qDep 11.Dep SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EFRAOPQB00Z0','50','H','01','149',NULL,'qDep 11.Gender',NULL,NULL,'"qDep 11.Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EFRAOPQB00Z0','50','H','01','150',NULL,'qDep 11.Relationship',NULL,NULL,'"qDep 11.Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EFRAOPQB00Z0','50','H','01','151',NULL,'qDep 11.Dep Date of Birth',NULL,NULL,'"qDep 11.Dep Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EFRAOPQB00Z0','50','H','01','152',NULL,'qDep 11.Dep Medical',NULL,NULL,'"qDep 11.Dep Medical"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EFRAOPQB00Z0','50','H','01','153',NULL,'qDep 11.Dep Dental',NULL,NULL,'"qDep 11.Dep Dental"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EFRAOPQB00Z0','50','H','01','154',NULL,'qDep 11.Dep Vision',NULL,NULL,'"qDep 11.Dep Vision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EFRAOPQB00Z0','50','H','01','155',NULL,'qDep 11.Dep Other Plan',NULL,NULL,'"qDep 11.Dep Other Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EFRAOPQB00Z0','50','H','01','156',NULL,'Spouse DOB',NULL,NULL,'"Spouse DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EFRAOPQB00Z0','50','H','01','157',NULL,'Special Instructions',NULL,NULL,'"Special Instructions"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFRAOPQB00Z0','50','D','10','1',NULL,'Employer Code',NULL,NULL,'"411881785"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFRAOPQB00Z0','50','D','10','2',NULL,'Branch Code',NULL,NULL,'"drvBranchCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFRAOPQB00Z0','50','D','10','3',NULL,'Notification Date',NULL,NULL,'"drvNotificationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFRAOPQB00Z0','50','D','10','4',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFRAOPQB00Z0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFRAOPQB00Z0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFRAOPQB00Z0','50','D','10','7',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFRAOPQB00Z0','50','D','10','8',NULL,'Address',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFRAOPQB00Z0','50','D','10','9',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFRAOPQB00Z0','50','D','10','10',NULL,'Town or City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFRAOPQB00Z0','50','D','10','11',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFRAOPQB00Z0','50','D','10','12',NULL,'Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFRAOPQB00Z0','50','D','10','13',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFRAOPQB00Z0','50','D','10','14',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFRAOPQB00Z0','50','D','10','15',NULL,'Qualifying Event Date',NULL,NULL,'"drvQualifyingEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFRAOPQB00Z0','50','D','10','16',NULL,'Qualifying Event',NULL,NULL,'"drvQualifyingEvent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFRAOPQB00Z0','50','D','10','17',NULL,'COBRA Begins',NULL,NULL,'"drvCobraBegins"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFRAOPQB00Z0','50','D','10','18',NULL,'Employee Full Name',NULL,NULL,'"drvEmployeeFullName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFRAOPQB00Z0','50','D','10','19',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFRAOPQB00Z0','50','D','10','20',NULL,'Employee Special',NULL,NULL,'"drvEmployeeSpecial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EFRAOPQB00Z0','50','D','10','21',NULL,'Medical Plan Start Date',NULL,NULL,'"drvMedPlanStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EFRAOPQB00Z0','50','D','10','22',NULL,'Medical Plan',NULL,NULL,'"drvMedPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EFRAOPQB00Z0','50','D','10','23',NULL,'Medical Coverage',NULL,NULL,'"drvMedCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EFRAOPQB00Z0','50','D','10','24',NULL,'Dental Plan',NULL,NULL,'"drvDentalPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EFRAOPQB00Z0','50','D','10','25',NULL,'Dental Coverage',NULL,NULL,'"drvDentalCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EFRAOPQB00Z0','50','D','10','26',NULL,'Vision Plan',NULL,NULL,'"drvVisionPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EFRAOPQB00Z0','50','D','10','27',NULL,'Vision Coverage',NULL,NULL,'"drvVisionCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EFRAOPQB00Z0','50','D','10','28',NULL,'Other Plan',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EFRAOPQB00Z0','50','D','10','29',NULL,'Other Coverage',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EFRAOPQB00Z0','50','D','10','30',NULL,'Life Plan 1',NULL,NULL,'"drvLifePlan1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EFRAOPQB00Z0','50','D','10','31',NULL,'Life Plan 1 Coverage',NULL,NULL,'"drvLifePlan1Coverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EFRAOPQB00Z0','50','D','10','32',NULL,'Life Plan 1 Volume',NULL,NULL,'"drvLifePlan1Volume"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EFRAOPQB00Z0','50','D','10','33',NULL,'Life Plan 2',NULL,NULL,'"drvLifePlan2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EFRAOPQB00Z0','50','D','10','34',NULL,'Life 2 Coverage',NULL,NULL,'"drvLife2Coverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EFRAOPQB00Z0','50','D','10','35',NULL,'Life 2 Volume',NULL,NULL,'"drvlife2Volume"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EFRAOPQB00Z0','50','D','10','36',NULL,'Life Plan 3',NULL,NULL,'"drvLifePlan3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EFRAOPQB00Z0','50','D','10','37',NULL,'Life 3 Coverage',NULL,NULL,'"drvLife3Coverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EFRAOPQB00Z0','50','D','10','38',NULL,'Life 3 Volume',NULL,NULL,'"drvLife3Volume"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EFRAOPQB00Z0','50','D','10','39',NULL,'Life Plan 4',NULL,NULL,'"drvLifePlan4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EFRAOPQB00Z0','50','D','10','40',NULL,'Life 4 Coverage',NULL,NULL,'"drvLife4Coverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EFRAOPQB00Z0','50','D','10','41',NULL,'Life 4 Volume',NULL,NULL,'"drvLife4Volume"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EFRAOPQB00Z0','50','D','10','42',NULL,'Flex Plan',NULL,NULL,'"drvFlexPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EFRAOPQB00Z0','50','D','10','43',NULL,'Flex Plan Coverage Level',NULL,NULL,'"drvFlexPlanCovLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EFRAOPQB00Z0','50','D','10','44',NULL,'Flex Healthcare Amount',NULL,NULL,'"drvHealthcareAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EFRAOPQB00Z0','50','D','10','45',NULL,'Flex Plan End Date',NULL,NULL,'"drvFlexPlanEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EFRAOPQB00Z0','50','D','10','46',NULL,'qDep 1.Dep Last Name',NULL,NULL,'"drvDep1LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EFRAOPQB00Z0','50','D','10','47',NULL,'qDep 1.Dep First Name',NULL,NULL,'"drvDep1FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EFRAOPQB00Z0','50','D','10','48',NULL,'qDep 1.Dep SSN',NULL,NULL,'"drvDep1SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EFRAOPQB00Z0','50','D','10','49',NULL,'qDep 1.Gender',NULL,NULL,'"drvDep1Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EFRAOPQB00Z0','50','D','10','50',NULL,'qDep 1.Relationship',NULL,NULL,'"drvDep1Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EFRAOPQB00Z0','50','D','10','51',NULL,'qDep 1.Dep Date of Birth',NULL,NULL,'"drvDep1DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EFRAOPQB00Z0','50','D','10','52',NULL,'qDep 1.Dep Medical',NULL,NULL,'"drvDep1Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EFRAOPQB00Z0','50','D','10','53',NULL,'qDep 1.Dep Dental',NULL,NULL,'"drvDep1Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EFRAOPQB00Z0','50','D','10','54',NULL,'qDep 1.Dep Vision',NULL,NULL,'"drvDep1Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EFRAOPQB00Z0','50','D','10','55',NULL,'qDep 1.Dep Other Plan',NULL,NULL,'"drvDep1Other"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EFRAOPQB00Z0','50','D','10','56',NULL,'qDep 2.Dep Last Name',NULL,NULL,'"drvDep2LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EFRAOPQB00Z0','50','D','10','57',NULL,'qDep 2.Dep First Name',NULL,NULL,'"drvDep2FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EFRAOPQB00Z0','50','D','10','58',NULL,'qDep 2.Dep SSN',NULL,NULL,'"drvDep2SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EFRAOPQB00Z0','50','D','10','59',NULL,'qDep 2.Gender',NULL,NULL,'"drvDep2Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EFRAOPQB00Z0','50','D','10','60',NULL,'qDep 2.Relationship',NULL,NULL,'"drvDep2Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EFRAOPQB00Z0','50','D','10','61',NULL,'qDep 2.Dep Date of Birth',NULL,NULL,'"drvDep2DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EFRAOPQB00Z0','50','D','10','62',NULL,'qDep 2.Dep Medical',NULL,NULL,'"drvDep2Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EFRAOPQB00Z0','50','D','10','63',NULL,'qDep 2.Dep Dental',NULL,NULL,'"drvDep2Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EFRAOPQB00Z0','50','D','10','64',NULL,'qDep 2.Dep Vision',NULL,NULL,'"drvDep2Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EFRAOPQB00Z0','50','D','10','65',NULL,'qDep 2.Dep Other Plan',NULL,NULL,'"drvDep2Other"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EFRAOPQB00Z0','50','D','10','66',NULL,'qDep 3.Dep Last Name',NULL,NULL,'"drvDep3LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EFRAOPQB00Z0','50','D','10','67',NULL,'qDep 3.Dep First Name',NULL,NULL,'"drvDep3FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EFRAOPQB00Z0','50','D','10','68',NULL,'qDep 3.Dep SSN',NULL,NULL,'"drvDep3SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EFRAOPQB00Z0','50','D','10','69',NULL,'qDep 3.Gender',NULL,NULL,'"drvDep3Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EFRAOPQB00Z0','50','D','10','70',NULL,'qDep 3.Relationship',NULL,NULL,'"drvDep3Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EFRAOPQB00Z0','50','D','10','71',NULL,'qDep 3.Dep Date of Birth',NULL,NULL,'"drvDep3DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EFRAOPQB00Z0','50','D','10','72',NULL,'qDep 3.Dep Medical',NULL,NULL,'"drvDep3Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EFRAOPQB00Z0','50','D','10','73',NULL,'qDep 3.Dep Dental',NULL,NULL,'"drvDep3Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EFRAOPQB00Z0','50','D','10','74',NULL,'qDep 3.Dep Vision',NULL,NULL,'"drvDep3Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EFRAOPQB00Z0','50','D','10','75',NULL,'qDep 3.Dep Other Plan',NULL,NULL,'"drvDep3Other"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EFRAOPQB00Z0','50','D','10','76',NULL,'qDep 4.Dep Last Name',NULL,NULL,'"drvDep4LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EFRAOPQB00Z0','50','D','10','77',NULL,'qDep 4.Dep First Name',NULL,NULL,'"drvDep4FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EFRAOPQB00Z0','50','D','10','78',NULL,'qDep 4.Dep SSN',NULL,NULL,'"drvDep4SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EFRAOPQB00Z0','50','D','10','79',NULL,'qDep 4.Gender',NULL,NULL,'"drvDep4Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EFRAOPQB00Z0','50','D','10','80',NULL,'qDep 4.Relationship',NULL,NULL,'"drvDep4Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EFRAOPQB00Z0','50','D','10','81',NULL,'qDep 4.Dep Date of Birth',NULL,NULL,'"drvDep4DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EFRAOPQB00Z0','50','D','10','82',NULL,'qDep 4.Dep Medical',NULL,NULL,'"drvDep4Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EFRAOPQB00Z0','50','D','10','83',NULL,'qDep 4.Dep Dental',NULL,NULL,'"drvDep4Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EFRAOPQB00Z0','50','D','10','84',NULL,'qDep 4.Dep Vision',NULL,NULL,'"drvDep4Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EFRAOPQB00Z0','50','D','10','85',NULL,'qDep 4.Dep Other Plan',NULL,NULL,'"drvDep4Other"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EFRAOPQB00Z0','50','D','10','86',NULL,'qDep 5.Dep Last Name',NULL,NULL,'"drvDep5LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EFRAOPQB00Z0','50','D','10','87',NULL,'qDep 5.Dep First Name',NULL,NULL,'"drvDep5FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EFRAOPQB00Z0','50','D','10','88',NULL,'qDep 5.Dep SSN',NULL,NULL,'"drvDep5SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EFRAOPQB00Z0','50','D','10','89',NULL,'qDep 5.Gender',NULL,NULL,'"drvDep5Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EFRAOPQB00Z0','50','D','10','90',NULL,'qDep 5.Relationship',NULL,NULL,'"drvDep5Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EFRAOPQB00Z0','50','D','10','91',NULL,'qDep 5.Dep Date of Birth',NULL,NULL,'"drvDep5DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EFRAOPQB00Z0','50','D','10','92',NULL,'qDep 5.Dep Medical',NULL,NULL,'"drvDep5Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EFRAOPQB00Z0','50','D','10','93',NULL,'qDep 5.Dep Dental',NULL,NULL,'"drvDep5Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EFRAOPQB00Z0','50','D','10','94',NULL,'qDep 5.Dep Vision',NULL,NULL,'"drvDep5Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EFRAOPQB00Z0','50','D','10','95',NULL,'qDep 5.Dep Other Plan',NULL,NULL,'"drvDep5Other"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EFRAOPQB00Z0','50','D','10','96',NULL,'qDep 6.Dep Last Name',NULL,NULL,'"drvDep6LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EFRAOPQB00Z0','50','D','10','97',NULL,'qDep 6.Dep First Name',NULL,NULL,'"drvDep6FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EFRAOPQB00Z0','50','D','10','98',NULL,'qDep 6.Dep SSN',NULL,NULL,'"drvDep6SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EFRAOPQB00Z0','50','D','10','99',NULL,'qDep 6.Gender',NULL,NULL,'"drvDep6Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EFRAOPQB00Z0','50','D','10','100',NULL,'qDep 6.Relationship',NULL,NULL,'"drvDep6Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EFRAOPQB00Z0','50','D','10','101',NULL,'qDep 6.Dep Date of Birth',NULL,NULL,'"drvDep6DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EFRAOPQB00Z0','50','D','10','102',NULL,'qDep 6.Dep Medical',NULL,NULL,'"drvDep6Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EFRAOPQB00Z0','50','D','10','103',NULL,'qDep 6.Dep Dental',NULL,NULL,'"drvDep6Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EFRAOPQB00Z0','50','D','10','104',NULL,'qDep 6.Dep Vision',NULL,NULL,'"drvDep6Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EFRAOPQB00Z0','50','D','10','105',NULL,'qDep 6.Dep Other Plan',NULL,NULL,'"drvDep6Other"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EFRAOPQB00Z0','50','D','10','106',NULL,'qDep 7.Dep Last Name',NULL,NULL,'"drvDep7LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EFRAOPQB00Z0','50','D','10','107',NULL,'qDep 7.Dep First Name',NULL,NULL,'"drvDep7FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EFRAOPQB00Z0','50','D','10','108',NULL,'qDep 7.Dep SSN',NULL,NULL,'"drvDep7SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EFRAOPQB00Z0','50','D','10','109',NULL,'qDep 7.Gender',NULL,NULL,'"drvDep7Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EFRAOPQB00Z0','50','D','10','110',NULL,'qDep 7.Relationship',NULL,NULL,'"drvDep7Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EFRAOPQB00Z0','50','D','10','111',NULL,'qDep 7.Dep Date of Birth',NULL,NULL,'"drvDep7DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EFRAOPQB00Z0','50','D','10','112',NULL,'qDep 7.Dep Medical',NULL,NULL,'"drvDep7Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EFRAOPQB00Z0','50','D','10','113',NULL,'qDep 7.Dep Dental',NULL,NULL,'"drvDep7Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EFRAOPQB00Z0','50','D','10','114',NULL,'qDep 7.Dep Vision',NULL,NULL,'"drvDep7Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EFRAOPQB00Z0','50','D','10','115',NULL,'qDep 7.Dep Other Plan',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EFRAOPQB00Z0','50','D','10','116',NULL,'qDep 8.Dep Last Name',NULL,NULL,'"drvDep8LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EFRAOPQB00Z0','50','D','10','117',NULL,'qDep 8.Dep First Name',NULL,NULL,'"drvDep8FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EFRAOPQB00Z0','50','D','10','118',NULL,'qDep 8.Dep SSN',NULL,NULL,'"drvDep8SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EFRAOPQB00Z0','50','D','10','119',NULL,'qDep 8.Gender',NULL,NULL,'"drvDep8Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EFRAOPQB00Z0','50','D','10','120',NULL,'qDep 8.Relationship',NULL,NULL,'"drvDep8Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EFRAOPQB00Z0','50','D','10','121',NULL,'qDep 8.Dep Date of Birth',NULL,NULL,'"drvDep8DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EFRAOPQB00Z0','50','D','10','122',NULL,'qDep 8.Dep Medical',NULL,NULL,'"drvDep8Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EFRAOPQB00Z0','50','D','10','123',NULL,'qDep 8.Dep Dental',NULL,NULL,'"drvDep8Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EFRAOPQB00Z0','50','D','10','124',NULL,'qDep 8.Dep Vision',NULL,NULL,'"drvDep8Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EFRAOPQB00Z0','50','D','10','125',NULL,'qDep 8.Dep Other Plan',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EFRAOPQB00Z0','50','D','10','126',NULL,'qDep 9.Dep Last Name',NULL,NULL,'"drvDep9LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EFRAOPQB00Z0','50','D','10','127',NULL,'qDep 9.Dep First Name',NULL,NULL,'"drvDep9FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EFRAOPQB00Z0','50','D','10','128',NULL,'qDep 9.Dep SSN',NULL,NULL,'"drvDep9SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EFRAOPQB00Z0','50','D','10','129',NULL,'qDep 9.Gender',NULL,NULL,'"drvDep9Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EFRAOPQB00Z0','50','D','10','130',NULL,'qDep 9.Relationship',NULL,NULL,'"drvDep9Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EFRAOPQB00Z0','50','D','10','131',NULL,'qDep 9.Dep Date of Birth',NULL,NULL,'"drvDep9DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EFRAOPQB00Z0','50','D','10','132',NULL,'qDep 9.Dep Medical',NULL,NULL,'"drvDep9Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EFRAOPQB00Z0','50','D','10','133',NULL,'qDep 9.Dep Dental',NULL,NULL,'"drvDep9Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EFRAOPQB00Z0','50','D','10','134',NULL,'qDep 9.Dep Vision',NULL,NULL,'"drvDep9Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EFRAOPQB00Z0','50','D','10','135',NULL,'qDep 9.Dep Other Plan',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EFRAOPQB00Z0','50','D','10','136',NULL,'qDep 10.Dep Last Name',NULL,NULL,'"drvDep10LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EFRAOPQB00Z0','50','D','10','137',NULL,'qDep 10.Dep First Name',NULL,NULL,'"drvDep10FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EFRAOPQB00Z0','50','D','10','138',NULL,'qDep 10.Dep SSN',NULL,NULL,'"drvDep10SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EFRAOPQB00Z0','50','D','10','139',NULL,'qDep 10.Gender',NULL,NULL,'"drvDep10Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EFRAOPQB00Z0','50','D','10','140',NULL,'qDep 10.Relationship',NULL,NULL,'"drvDep10Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EFRAOPQB00Z0','50','D','10','141',NULL,'qDep 10.Dep Date of Birth',NULL,NULL,'"drvDep10DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EFRAOPQB00Z0','50','D','10','142',NULL,'qDep 10.Dep Medical',NULL,NULL,'"drvDep10Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EFRAOPQB00Z0','50','D','10','143',NULL,'qDep 10.Dep Dental',NULL,NULL,'"drvDep10Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EFRAOPQB00Z0','50','D','10','144',NULL,'qDep 10.Dep Vision',NULL,NULL,'"drvDep10Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EFRAOPQB00Z0','50','D','10','145',NULL,'qDep 10.Dep Other Plan',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EFRAOPQB00Z0','50','D','10','146',NULL,'qDep 11.Dep Last Name',NULL,NULL,'"drvDep11LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EFRAOPQB00Z0','50','D','10','147',NULL,'qDep 11.Dep First Name',NULL,NULL,'"drvDep11FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EFRAOPQB00Z0','50','D','10','148',NULL,'qDep 11.Dep SSN',NULL,NULL,'"drvDep11SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EFRAOPQB00Z0','50','D','10','149',NULL,'qDep 11.Gender',NULL,NULL,'"drvDep11Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EFRAOPQB00Z0','50','D','10','150',NULL,'qDep 11.Relationship',NULL,NULL,'"drvDep11Relationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EFRAOPQB00Z0','50','D','10','151',NULL,'qDep 11.Dep Date of Birth',NULL,NULL,'"drvDep11DateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EFRAOPQB00Z0','50','D','10','152',NULL,'qDep 11.Dep Medical',NULL,NULL,'"drvDep11Medical"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EFRAOPQB00Z0','50','D','10','153',NULL,'qDep 11.Dep Dental',NULL,NULL,'"drvDep11Dental"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EFRAOPQB00Z0','50','D','10','154',NULL,'qDep 11.Dep Vision',NULL,NULL,'"drvDep11Vision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EFRAOPQB00Z0','50','D','10','155',NULL,'qDep 11.Dep Other Plan',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EFRAOPQB00Z0','50','D','10','156',NULL,'Spouse DOB',NULL,NULL,'"drvSpouseDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EFRAOPQB00Z0','50','D','10','157',NULL,'Special Instructions',NULL,NULL,'"drvSpecialInstructions"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFRAOPQB_20240124.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',S9ZKW,S9ZEQ,S9ZCA,S9Z66,S9Z0A,RCHLG',NULL,NULL,NULL,'OPTUM COBRA QB ON Demand','202310129','EMPEXPORT','ONDEM_XOE','Jul 18 2023 12:00AM','EFRAOPQB',NULL,NULL,NULL,'202310129','Jul  6 2023 12:00AM','Dec 30 1899 12:00AM','202308011','4','','','202308011',dbo.fn_GetTimedKey(),NULL,'us3kEpFRA1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'RCHLG,S9Z0A,S9Z66,S9ZCA,S9ZEQ,S9ZKW',NULL,NULL,NULL,'OPTUM COBQB-SCH WK THU 1140P','202310129','EMPEXPORT','SCH_EFRAOP',NULL,'EFRAOPQB',NULL,NULL,NULL,'202401079','May 22 2023 12:25PM','May 22 2023 12:25PM','202312311',NULL,'','','202308011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',RCHLG,S9Z0A,S9Z66,S9ZKW,S9ZEQ,S9ZCA',NULL,NULL,NULL,'OPTUM COBRA QB-Test','202401239','EMPEXPORT','TEST_XOE','Oct 19 2023  9:35AM','EFRAOPQB',NULL,NULL,NULL,'202401239','Oct 19 2023 12:00AM','Dec 30 1899 12:00AM','202305151','16',NULL,'','202305151',dbo.fn_GetTimedKey(),NULL,'us3lKiFRA1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFRAOPQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFRAOPQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFRAOPQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFRAOPQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFRAOPQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFRAOPQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFRAOPQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFRAOPQB','D10','dbo.U_EFRAOPQB_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFRAOPQB
-----------

IF OBJECT_ID('U_dsi_BDM_EFRAOPQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFRAOPQB] (
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
-- Create table U_EFRAOPQB_Audit
-----------

IF OBJECT_ID('U_EFRAOPQB_Audit') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_Audit] (
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
-- Create table U_EFRAOPQB_AuditFields
-----------

IF OBJECT_ID('U_EFRAOPQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EFRAOPQB_DedList
-----------

IF OBJECT_ID('U_EFRAOPQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFRAOPQB_drvTbl
-----------

IF OBJECT_ID('U_EFRAOPQB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvBranchCode] varchar(7) NULL,
    [drvNotificationDate] varchar(30) NULL,
    [drvSSN] varchar(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateofBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvQualifyingEventDate] datetime NULL,
    [drvQualifyingEvent] varchar(2) NULL,
    [drvCobraBegins] datetime NULL,
    [drvEmployeeFullName] varchar(201) NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvEmployeeSpecial] varchar(3) NULL,
    [drvMedPlanStartDate] datetime NULL,
    [drvMedPlan] varchar(5) NULL,
    [drvMedCoverage] varchar(20) NULL,
    [drvDentalPlan] varchar(5) NULL,
    [drvDentalCoverage] varchar(20) NULL,
    [drvVisionPlan] varchar(5) NULL,
    [drvVisionCoverage] varchar(20) NULL,
    [drvLifePlan1] varchar(6) NULL,
    [drvLifePlan1Coverage] varchar(6) NULL,
    [drvLifePlan1Volume] nvarchar(4000) NULL,
    [drvLifePlan2] varchar(6) NULL,
    [drvLife2Coverage] varchar(6) NULL,
    [drvlife2Volume] nvarchar(4000) NULL,
    [drvLifePlan3] varchar(6) NULL,
    [drvLife3Coverage] varchar(6) NULL,
    [drvLife3Volume] nvarchar(4000) NULL,
    [drvLifePlan4] varchar(6) NULL,
    [drvLife4Coverage] varchar(6) NULL,
    [drvLife4Volume] nvarchar(4000) NULL,
    [drvFlexPlan] varchar(3) NULL,
    [drvFlexPlanCovLevel] varchar(6) NULL,
    [drvHealthcareAmount] money NULL,
    [drvFlexPlanEndDate] date NULL,
    [drvDep1LastName] varchar(6000) NULL,
    [drvDep1FirstName] varchar(6000) NULL,
    [drvDep1SSN] varchar(1) NOT NULL,
    [drvDep1Gender] char(1) NULL,
    [drvDep1Relationship] varchar(9) NULL,
    [drvDep1DateofBirth] datetime NULL,
    [drvDep1Medical] varchar(5) NULL,
    [drvDep1Dental] varchar(5) NULL,
    [drvDep1Vision] varchar(5) NULL,
    [drvDep1Other] varchar(6) NULL,
    [drvDep2LastName] varchar(6000) NULL,
    [drvDep2FirstName] varchar(6000) NULL,
    [drvDep2SSN] varchar(1) NOT NULL,
    [drvDep2Gender] char(1) NULL,
    [drvDep2Relationship] varchar(9) NULL,
    [drvDep2DateofBirth] datetime NULL,
    [drvDep2Medical] varchar(5) NULL,
    [drvDep2Dental] varchar(5) NULL,
    [drvDep2Vision] varchar(5) NULL,
    [drvDep2Other] varchar(1) NOT NULL,
    [drvDep3LastName] varchar(6000) NULL,
    [drvDep3FirstName] varchar(6000) NULL,
    [drvDep3SSN] varchar(1) NOT NULL,
    [drvDep3Gender] char(1) NULL,
    [drvDep3Relationship] varchar(9) NULL,
    [drvDep3DateofBirth] datetime NULL,
    [drvDep3Medical] varchar(5) NULL,
    [drvDep3Dental] varchar(5) NULL,
    [drvDep3Vision] varchar(5) NULL,
    [drvDep3Other] varchar(1) NOT NULL,
    [drvDep4LastName] varchar(6000) NULL,
    [drvDep4FirstName] varchar(6000) NULL,
    [drvDep4SSN] varchar(1) NOT NULL,
    [drvDep4Gender] char(1) NULL,
    [drvDep4Relationship] varchar(9) NULL,
    [drvDep4DateofBirth] datetime NULL,
    [drvDep4Medical] varchar(5) NULL,
    [drvDep4Dental] varchar(5) NULL,
    [drvDep4Vision] varchar(5) NULL,
    [drvDep4Other] varchar(1) NOT NULL,
    [drvDep5LastName] varchar(6000) NULL,
    [drvDep5FirstName] varchar(6000) NULL,
    [drvDep5SSN] varchar(1) NOT NULL,
    [drvDep5Gender] char(1) NULL,
    [drvDep5Relationship] varchar(9) NULL,
    [drvDep5DateofBirth] datetime NULL,
    [drvDep5Medical] varchar(5) NULL,
    [drvDep5Dental] varchar(5) NULL,
    [drvDep5Vision] varchar(5) NULL,
    [drvDep5Other] varchar(1) NOT NULL,
    [drvDep6LastName] varchar(6000) NULL,
    [drvDep6FirstName] varchar(6000) NULL,
    [drvDep6SSN] varchar(1) NOT NULL,
    [drvDep6Gender] char(1) NULL,
    [drvDep6Relationship] varchar(9) NULL,
    [drvDep6DateofBirth] datetime NULL,
    [drvDep6Medical] varchar(5) NULL,
    [drvDep6Dental] varchar(5) NULL,
    [drvDep6Vision] varchar(5) NULL,
    [drvDep6Other] varchar(1) NOT NULL,
    [drvDep7LastName] varchar(1) NOT NULL,
    [drvDep7FirstName] varchar(1) NOT NULL,
    [drvDep7SSN] varchar(1) NOT NULL,
    [drvDep7Gender] varchar(1) NOT NULL,
    [drvDep7Relationship] varchar(1) NOT NULL,
    [drvDep7DateofBirth] varchar(1) NOT NULL,
    [drvDep7Medical] varchar(1) NOT NULL,
    [drvDep7Dental] varchar(1) NOT NULL,
    [drvDep7Vision] varchar(1) NOT NULL,
    [drvDep8LastName] varchar(1) NOT NULL,
    [drvDep8FirstName] varchar(1) NOT NULL,
    [drvDep8SSN] varchar(1) NOT NULL,
    [drvDep8Gender] varchar(1) NOT NULL,
    [drvDep8Relationship] varchar(1) NOT NULL,
    [drvDep8DateofBirth] varchar(1) NOT NULL,
    [drvDep8Medical] varchar(1) NOT NULL,
    [drvDep8Dental] varchar(1) NOT NULL,
    [drvDep8Vision] varchar(1) NOT NULL,
    [drvDep9LastName] varchar(1) NOT NULL,
    [drvDep9FirstName] varchar(1) NOT NULL,
    [drvDep9SSN] varchar(1) NOT NULL,
    [drvDep9Gender] varchar(1) NOT NULL,
    [drvDep9Relationship] varchar(1) NOT NULL,
    [drvDep9DateofBirth] varchar(1) NOT NULL,
    [drvDep9Medical] varchar(1) NOT NULL,
    [drvDep9Dental] varchar(1) NOT NULL,
    [drvDep9Vision] varchar(1) NOT NULL,
    [drvDep10LastName] varchar(1) NOT NULL,
    [drvDep10FirstName] varchar(1) NOT NULL,
    [drvDep10SSN] varchar(1) NOT NULL,
    [drvDep10Gender] varchar(1) NOT NULL,
    [drvDep10Relationship] varchar(1) NOT NULL,
    [drvDep10DateofBirth] varchar(1) NOT NULL,
    [drvDep10Medical] varchar(1) NOT NULL,
    [drvDep10Dental] varchar(1) NOT NULL,
    [drvDep10Vision] varchar(1) NOT NULL,
    [drvDep11LastName] varchar(1) NOT NULL,
    [drvDep11FirstName] varchar(1) NOT NULL,
    [drvDep11SSN] varchar(1) NOT NULL,
    [drvDep11Gender] varchar(1) NOT NULL,
    [drvDep11Relationship] varchar(1) NOT NULL,
    [drvDep11DateofBirth] varchar(1) NOT NULL,
    [drvDep11Medical] varchar(1) NOT NULL,
    [drvDep11Dental] varchar(1) NOT NULL,
    [drvDep11Vision] varchar(1) NOT NULL,
    [drvSpouseDOB] datetime NULL,
    [drvSpecialInstructions] varchar(1) NOT NULL
);

-----------
-- Create table U_EFRAOPQB_EEList
-----------

IF OBJECT_ID('U_EFRAOPQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFRAOPQB_File
-----------

IF OBJECT_ID('U_EFRAOPQB_File') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EFRAOPQB_PDedHist
-----------

IF OBJECT_ID('U_EFRAOPQB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhLIFEPLAN1] numeric NULL,
    [PdhLIFEPLAN2] numeric NULL,
    [PdhLIFEPLAN3] numeric NULL,
    [PdhLIFEPLAN4] numeric NULL
);

-----------
-- Create table U_EFRAOPQB_PEarHist
-----------

IF OBJECT_ID('U_EFRAOPQB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFRAOPQB_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFRAOPQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TekP-2023-02-13-02

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 05/22/2023
Service Request Number: 

Purpose: OPTUM COBRA QB

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        07/18/2023     TekP-2023-02-13-02 Added drvBranchcode and updated dep hierarchy case staments "END ELSE"
Marie Waters        09/26/2023     TekP-2023-02-13-02 Updated Life amounts to use BCA table
Marie Waters        01/24/2024     TekP-2023-12-12-03 Added WMax on bdmchangereason and bdmcobrareason and where event is not null

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFRAOPQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFRAOPQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFRAOPQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFRAOPQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFRAOPQB' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301051'
       ,expStartPerControl     = '202301051'
       ,expLastEndPerControl   = '202310269'
       ,expEndPerControl       = '202310269'
WHERE expFormatCode = 'EFRAOPQB';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFRAOPQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFRAOPQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFRAOPQB', 'SCH_EFRAOP';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFRAOPQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFRAOPQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EFRAOPQB';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('1/1/2023' as DateTime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFRAOPQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFRAOPQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

       ---------------------------------
    -- Delete exclusions
    ---------------------------------
        delete from dbo.U_EFRAOPQB_drvTbl where drvEEID in (
        select xEEID  FROM dbo.U_EFRAOPQB_EEList WITH (NOLOCK) 
        JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID 
        AND EecCoID = 'S9Z0A'
        AND EecTermReason IN ('202') 
        JOIN dbo.fnEmployeeAge(getDAte())
        ON EecEEID = EEID
        AND EmployeeAge >= 60
        );

        ---The client would like us to set the file to exclude all employees where eecemplstatus = T and EecCOID ='S9Z0A' and their age as of the eecdateoftermination is 60.


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFRAOPQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFRAOPQB_AuditFields;
    CREATE TABLE dbo.U_EFRAOPQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EFRAOPQB_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFRAOPQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFRAOPQB_Audit;
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
    INTO dbo.U_EFRAOPQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EFRAOPQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EFRAOPQB_Audit ON dbo.U_EFRAOPQB_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FS177,FS176,VI120,HE047,HE051,HE054,HE043,HE048,HE055,HE044,HE056,HE058,HE057,HE059,HE060,HE061,DE280,DE297,DE281,DE282,DE311,DE291,LI210,LI215,LI220,LI225,SU096,SU097,SU100,SU201';
    --LI219

    IF OBJECT_ID('U_EFRAOPQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFRAOPQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFRAOPQB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','FS177,FS176,VI120,HE047,HE051,HE054,HE043,HE048,HE055,HE044,HE056,HE058,HE057,HE059,HE060,HE061,DE280,DE297,DE281,DE282,DE311,DE291,LI210,LI215,LI220,LI225,SU096,SU097,SU100,SU201');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

        -- Cobra parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #3.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons     
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)    --UPDATE: 20230602 KE - add changereason '302' to file.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');---- - update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','C08,CHL,GCH,STC,S19'); ----- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','O20'); ---- update to the domestic partner relationship code

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

 --    ---==================================================
 ----   Insert into BDM Reason code 204/LEVNT4 (Divorce)
 ----   --==================================================
    INSERT INTO [dbo].[U_dsi_BDM_EFRAOPQB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
    Select Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204/LEVNT4 (Divorce)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,edhEffDate
        ,edhEffDate
        ,edhChangeReason
        ,edhChangeReason 
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND edhChangeReason IN ('204','LEVNT4') 
        AND CASE WHEN NULLIF(EdhBenOption,'')is null then 'Z' else EdhBenOption end = CASE WHEN NULLIF(DbnBenOption,'') is null then 'Z' else DbnBenOption end
        AND dbnformatcode = 'EFRAOPQB'
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T';

 --    ---==================================================
 ----   Insert into BDM Reason code 210 (Death)
 ----   --==================================================
    INSERT INTO [dbo].[U_dsi_BDM_EFRAOPQB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
    Select Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 210 (Death)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,edhEffDate
        ,edhEffDate
        ,edhChangeReason
        ,edhChangeReason 
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND edhChangeReason IN ('210') 
        AND CASE WHEN NULLIF(EdhBenOption,'')is null then 'Z' else EdhBenOption end = CASE WHEN NULLIF(DbnBenOption,'') is null then 'Z' else DbnBenOption end
        AND dbnformatcode = 'EFRAOPQB'
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T';

   ---====================================================
 --   Insert into BDM Reason code 302 (Remove Dependent)
 --   --==================================================
    --INSERT INTO [dbo].[U_dsi_BDM_EFRAOPQB]
    --(    [BdmRecType]
    --       ,[BdmCOID]
    --       ,[BdmEEID]
    --       ,[BdmDepRecID]
    --       ,[BdmSystemID]
    --       ,[BdmRunID]
    --       ,[BdmDedRowStatus]
    --       ,[BdmRelationship]
    --       ,[BdmDateOfBirth]
    --       ,[BdmDedCode]
    --       ,[BdmBenOption]
    --       ,[BdmBenStatus]
    --       ,[BdmBenStartDate]
    --       ,[BdmBenStopDate]
    --       ,[BdmBenStatusDate]
    --       ,[BdmDateOFCobraEvent]
    --       ,[BdmChangeReason]
    --       ,[BdmCobraReason]
    --       ,[BdmStartDate]
    --       ,[BdmStopDate]
    --       ,[BdmIsPQB]
    --        ,[BdmIsCobraCovered]
    --        ,[BdmSessionID]
    --)
    --Select Distinct rectype = 'DEP'
    --    ,EdhCoid
    --    ,EdhEEID
    --    ,DbnDepRecID
    --    ,DbnDepRecID
    --    ,'QB'
    --    ,'Data Inserted for 201/LEVNT3 (Remove Dependent)'
    --    ,DbnRelationship
    --    ,DbnDateOfBirth
    --    ,EdhDedCode
    --    ,DbnBenOption
    --    ,DbnBenStatus
    --    ,EdhBenStartDate
    --    ,DbnBenStopDate
    --    ,edhEffDate
    --    ,edhEffDate
    --    ,'LEVNT3'
    --    ,'LEVNT3'
    --    ,EdhStartDate
    --    ,EdhStopDate
    --    ,'Y'
    --    ,'Y'
    --    ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    --FROM dbo.emphded WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    --    ON dbneeid = edheeid 
    --    AND DbnCoID = EdhCoID
    --    AND EdhDedCode = DbnDedCode
    --    AND edhChangeReason IN ('302','LEVNT3') 
    --    AND CASE WHEN NULLIF(EdhBenOption,'')is null then 'Z' else EdhBenOption end = CASE WHEN NULLIF(DbnBenOption,'') is null then 'Z' else DbnBenOption end
    --    AND dbnformatcode = 'EFRAOPQB'
    --    and DbnBenstopdate BETWEEN @startdate AND @enddate 
    --    AND dbnValidForExport = 'N'
    --    AND DbnBenStatus = 'T';

 --  ---====================================================
 ----   Insert into BDM Reason code 201 (Dependent at max age)
 ----   --==================================================
    INSERT INTO [dbo].[U_dsi_BDM_EFRAOPQB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
    Select Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dependent at max age)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,edhEffDate
        ,edhEffDate
        ,edhChangeReason
        ,edhChangeReason 
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND edhChangeReason IN ('201','LEVNT3')
        AND CASE WHEN NULLIF(EdhBenOption,'')is null then 'Z' else EdhBenOption end = CASE WHEN NULLIF(DbnBenOption,'') is null then 'Z' else DbnBenOption end
        AND dbnformatcode = 'EFRAOPQB'
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T';

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFRAOPQB_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFRAOPQB_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhLIFEPLAN1     = MAX(CASE WHEN PdhDedCode IN ('LI210','LI215','LI220','LI225') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhLIFEPLAN2     = MAX(CASE WHEN PdhDedCode IN ('SU100') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhLIFEPLAN3     = MAX(CASE WHEN PdhDedCode IN ('SU201') THEN PdhDedCalcBasisAmt ELSE 0.00 END)  
        ,PdhLIFEPLAN4     = MAX(CASE WHEN PdhDedCode IN ('SU096','SU097') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
    INTO dbo.U_EFRAOPQB_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFRAOPQB_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFRAOPQB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFRAOPQB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFRAOPQB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvBranchCode = Case when EecCOID ='RCHLG' THEN 'CORPCOB' -- MW Added 7/18/2023
                              when EecCOID ='S9Z0A' THEN 'FFCCOB '
                              when EecCOID ='S9Z66' THEN 'INDCOB'
                              when EecCOID ='NL2LX' THEN 'LAKCOB'
                              when EecCOID ='S9ZCA' THEN 'MILCOB'
                              when EecCOID ='S9ZEQ' THEN 'PLACOB'
                            END
        ,drvNotificationDate = CONVERT(VARCHAR,GETDATE(),101)   ---BdmBenStopDate
        ,drvSSN = CASE WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') 
                            THEN SUBSTRING(Contacts.ConSSN, 1, 3) + '-' + SUBSTRING(Contacts.ConSSN, 4, 2) + '-' + SUBSTRING(Contacts.ConSSN, 6, 4) 
                            --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConSSN
                            --WHEN BdmCobraReason in  ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConSSN   
                            WHEN EecTermReason  = '203'  THEN Contacts.ConSSN
                            ELSE 
                            SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6, 4) END  --eepssn END
        ,drvNameLast = CASE  --WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.connamelast
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.connamelast     
                                WHEN EecTermReason  = '203' THEN Contacts.connamelast 
                                else EepNameLast END
        ,drvNameFirst = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.connamefirst 
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN contacts.connamefirst     
                                WHEN EecTermReason  = '203' THEN Contacts.connamefirst 
                                else 
                                Eepnamefirst END
        ,drvMiddleName = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN LEFT(Spouse.ConNameMiddle,1)
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN LEFT(contacts.ConNameMiddle,1)        
                                WHEN EecTermReason  = '203' THEN LEFT(Contacts.ConNameMiddle,1)
                                else 
                                LEFT(EepNameMiddle,1)  END
        ,drvAddress1 = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConAddressLine1
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConAddressLine1        
                                WHEN EecTermReason  = '203' THEN Contacts.ConAddressLine1
                                else 
                                EepAddressLine1 END
        ,drvAddress2 = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConAddressLine2
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConAddressLine2       
                                WHEN EecTermReason  = '203' THEN Contacts.ConAddressLine2
                                else 
                                EepAddressLine2 END
        ,drvAddressCity = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConAddressCity
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConAddressCity              
                                WHEN EecTermReason  = '203' THEN Contacts.ConAddressCity
                                else 
                                EepAddressCity END
        ,drvAddressState = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConAddressState
                                WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConAddressState       
                                WHEN EecTermReason  = '203' THEN Contacts.ConAddressState
                                else 
                                EepAddressState END
        ,drvAddressZipCode = CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConAddressZipCode
                                    WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConAddressZipCode         
                                    WHEN EecTermReason  = '203' THEN Contacts.ConAddressZipCode
                                    else 
                                    EepAddressZipCode END
        ,drvDateofBirth = CASE --WHEN BdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.ConDateOfBirth
                                  WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.ConDateOfBirth      
                                    WHEN EecTermReason  = '203' THEN Contacts.ConDateOfBirth
                                    else 
                                    dbo.EmpPers.EepDateOfBirth END 
        ,drvGender =  CASE --WHEN bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Spouse.congender 
                            WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Contacts.congender    
                            else 
                            eepgender END
        ,drvQualifyingEventDate = CASE  WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN EdhEffDate       
                                        --ELSE CASE WHEN eepDateOfCOBRAEvent is not null then eepDateOfCOBRAEvent else BdmTVStartDate END 
                                    END
        ,drvQualifyingEvent = CASE  WHEN EecEmplStatus = 'T' AND (BdmCobraReason = '200' or EecTermReason not in ('202','203')) AND EecTermType = 'V' THEN '01'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason not in ('202','203') AND EecTermType = 'V' THEN '01'
                                    WHEN (EecEmplStatus = 'T' AND EecTermReason = '202') or BdmCobraReason = '208' or BdmChangeReason = '208' THEN '02' 
                                    WHEN (EecEmplStatus = 'T' AND EecTermReason = '203') or BdmChangeReason = '210' or BdmChangeReason = '210' THEN '04'
                                    WHEN BdmCobraReason in ('201','LEVNT3') or BdmChangeReason in ('201','LEVNT3') THEN '05'       
                                    WHEN BdmCobraReason in ('202','203') or BdmChangeReason in ('201','LEVNT3') THEN '06'   
                                    WHEN BdmCobraReason in ('204','LEVNT4') or BdmChangeReason in ('204','LEVNT4') THEN '08'     
                                    WHEN EecEmplStatus = 'T' AND EecTermReason not in ('203') AND EecTermType = 'I' THEN '13'
                                    END
        ,drvCobraBegins = BdmBenStopDate
        ,drvEmployeeFullName = CASE WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN Concat(EepNameFirst,' ',EepNameLast) END
        ,drvEmployeeSSN = CASE WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN SUBSTRING(Contacts.ConSSN, 1, 3) + '-' + SUBSTRING(Contacts.ConSSN, 4, 2) + '-' + SUBSTRING(Contacts.ConSSN, 6, 4) 
                                    WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN SUBSTRING(Contacts.ConSSN, 1, 3) + '-' + SUBSTRING(Contacts.ConSSN, 4, 2) + '-' + SUBSTRING(Contacts.ConSSN, 6, 4)
                                    --WHEN EecTermReason  = '203' THEN SUBSTRING(Contacts.ConSSN, 1, 3) + '-' + SUBSTRING(Contacts.ConSSN, 4, 2) + '-' + SUBSTRING(Contacts.ConSSN, 6, 4)
                                  else '' END  
                                  --SUBSTRING(EepSSN, 1, 3) + '-' + SUBSTRING(EepSSN, 4, 2) + '-' + SUBSTRING(EepSSN, 6, 4) END  --UPDATE: 20230615 KE - Per vendor only send for dependent events.
        ,drvEmployeeSpecial = CASE WHEN BdmCobraReason in ('201','204','210','LEVNT3','LEVNT4') or bdmChangeReason in ('201', '204', '210','LEVNT3', 'LEVNT4') THEN 'DEP' END            
        ,drvMedPlanStartDate =  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvMedPlan = MedicalPlan
        ,drvMedCoverage = MedicalCoverage
        ,drvDentalPlan = DentalPlan
        ,drvDentalCoverage = DentalCoverage
        ,drvVisionPlan = VisionPlan
        ,drvVisionCoverage = VisionCoverage
        ,drvLifePlan1 = LifePlan1
        ,drvLifePlan1Coverage = LifePlan1Coverage
        ,drvLifePlan1Volume = LifePlan1Volume
        ,drvLifePlan2 = LifePlan2
        ,drvLife2Coverage = LifePlan2Coverage
        ,drvlife2Volume = LifePlan2Volume
        ,drvLifePlan3 = LifePlan3
        ,drvLife3Coverage = LifePlan3Coverage
        ,drvLife3Volume = LifePlan3Volume
        ,drvLifePlan4 = LifePlan4
        ,drvLife4Coverage = LifePlan4Coverage
        ,drvLife4Volume = Life4Volume
        ,drvFlexPlan = FlexPlan
        ,drvFlexPlanCovLevel = FlexPlanCovLevel
        ,drvHealthcareAmount = FlexHCAmt
        ,drvFlexPlanEndDate = FlexPlanEndDate
        ,drvDep1LastName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child1.ConNameLast) else dbo.dsi_fnRemoveChars('.,/',spouse.conNameLast) END
        ,drvDep1FirstName =  CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child1.ConNameFirst) else dbo.dsi_fnRemoveChars('.,/',spouse.conNameFirst) END 
        ,drvDep1SSN = ''
        ,drvDep1Gender = CASE WHEN spouse.ConNameLast is null then Child1.ConGender else Spouse.ConGender END  
        ,drvDep1Relationship = CASE WHEN spouse.ConNameLast is null then CASE WHEN Child1.ConRelationship in ('C08','CHL') THEN 'Child'
                                    WHEN Child1.ConRelationship in ('S19','STC') THEN 'Stepchild'  END 
                                    WHEN spouse.ConNameLast is not null THEN 'Spouse' END
        ,drvDep1DateofBirth = CASE WHEN spouse.ConNameLast is null then Child1.ConDateofBirth else Spouse.ConDateofBirth END  
        ,drvDep1Medical = CASE WHEN spouse.ConNameLast is null then Child1.depMed else Spouse.depMed END  
        ,drvDep1Dental = CASE WHEN spouse.ConNameLast is null then Child1.depDen else Spouse.DepDen END  
        ,drvDep1Vision = CASE WHEN spouse.ConNameLast is null then Child1.depVis else Spouse.depVis END  
        ,drvDep1Other = CASE WHEN spouse.ConNameLast is null AND Child1.depSU201 = 'SU201' THEN 'LIFE04' else
                        CASE WHEN Spouse.depSU201 = 'Y' THEN 'LIFE04' END  END
        ,drvDep2LastName =  CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child2.ConNameLast) else dbo.dsi_fnRemoveChars('.,/',Child1.conNameLast) END
        ,drvDep2FirstName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child2.ConNameFirst) else dbo.dsi_fnRemoveChars('.,/',Child1.conNameFirst) END 
        ,drvDep2SSN = ''
        ,drvDep2Gender = CASE WHEN spouse.ConNameLast is null then Child2.ConGender else Child1.ConGender END  
        ,drvDep2Relationship =  CASE    WHEN spouse.ConNameLast is null then CASE WHEN Child2.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child2.ConRelationship in ('S19','STC') THEN 'Stepchild' END else 
                                        CASE WHEN Child1.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child1.ConRelationship in ('S19','STC') THEN 'Stepchild'END END 
        ,drvDep2DateofBirth = CASE WHEN spouse.ConNameLast is null then Child2.ConDateofBirth else Child1.ConDateofBirth END  
        ,drvDep2Medical = CASE WHEN spouse.ConNameLast is null then Child2.depMed else Child1.depMed END 
        ,drvDep2Dental = CASE WHEN spouse.ConNameLast is null then Child2.depDen else Child1.DepDen END 
        ,drvDep2Vision = CASE WHEN spouse.ConNameLast is null then Child2.depVis else Child1.depVis END  
        ,drvDep2Other = ''---CASE WHEN spouse.ConNameLast is null AND Child2.depSU201 = 'SU201' THEN 'LIFE04' else CASE WHEN Child1.depSU201 = 'SU201' THEN 'LIFE04' END END 
        ,drvDep3LastName =  CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child3.ConNameLast) else dbo.dsi_fnRemoveChars('.,/',Child2.conNameLast) END
        ,drvDep3FirstName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child3.ConNameFirst) else dbo.dsi_fnRemoveChars('.,/',Child2.conNameFirst) END 
        ,drvDep3SSN = ''
        ,drvDep3Gender = CASE WHEN spouse.ConNameLast is null then Child3.ConGender else Child2.ConGender END  
        ,drvDep3Relationship = CASE    WHEN spouse.ConNameLast is null then CASE WHEN Child3.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child3.ConRelationship in ('S19','STC') THEN 'Stepchild' END else 
                                        CASE WHEN Child2.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child2.ConRelationship in ('S19','STC') THEN 'Stepchild'END END 
        ,drvDep3DateofBirth = CASE WHEN spouse.ConNameLast is null then Child3.ConDateofBirth else Child2.ConDateofBirth END 
        ,drvDep3Medical = CASE WHEN spouse.ConNameLast is null then Child3.depMed else Child2.depMed END 
        ,drvDep3Dental = CASE WHEN spouse.ConNameLast is null then Child3.depDen else Child2.DepDen END 
        ,drvDep3Vision = CASE WHEN spouse.ConNameLast is null then Child3.depVis else Child2.depVis END
        ,drvDep3Other = ''---CASE WHEN spouse.ConNameLast is null AND Child3.depSU201 = 'SU201' THEN 'LIFE04' else CASE WHEN Child2.depSU201 = 'SU201' THEN 'LIFE04' END END 
        ,drvDep4LastName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child4.ConNameLast) else dbo.dsi_fnRemoveChars('.,/',Child3.conNameLast) END
        ,drvDep4FirstName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child4.ConNameFirst) else dbo.dsi_fnRemoveChars('.,/',Child3.conNameFirst) END 
        ,drvDep4SSN = ''
        ,drvDep4Gender = CASE WHEN spouse.ConNameLast is null then Child4.ConGender else Child3.ConGender END 
        ,drvDep4Relationship = CASE    WHEN spouse.ConNameLast is null then CASE WHEN Child4.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child4.ConRelationship in ('S19','STC') THEN 'Stepchild' END else 
                                        CASE WHEN Child3.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child3.ConRelationship in ('S19','STC') THEN 'Stepchild'END END 
        ,drvDep4DateofBirth = CASE WHEN spouse.ConNameLast is null then Child4.ConDateofBirth else Child3.ConDateofBirth END
        ,drvDep4Medical = CASE WHEN spouse.ConNameLast is null then Child4.depMed else Child3.depMed END 
        ,drvDep4Dental = CASE WHEN spouse.ConNameLast is null then Child4.depDen else Child3.DepDen END 
        ,drvDep4Vision = CASE WHEN spouse.ConNameLast is null then Child4.depVis else Child3.depVis END
        ,drvDep4Other = ''---CASE WHEN spouse.ConNameLast is null AND Child4.depSU201 = 'SU201' THEN 'LIFE04' else CASE WHEN Child3.depSU201 = 'SU201' THEN 'LIFE04' END END 
        ,drvDep5LastName =  CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child4.ConNameLast) else dbo.dsi_fnRemoveChars('.,/',Child3.conNameLast) END
        ,drvDep5FirstName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child4.ConNameFirst) else dbo.dsi_fnRemoveChars('.,/',Child3.conNameFirst) END 
        ,drvDep5SSN = ''
        ,drvDep5Gender = CASE WHEN spouse.ConNameLast is null then Child5.ConGender else Child4.ConGender END 
        ,drvDep5Relationship = CASE    WHEN spouse.ConNameLast is null then CASE WHEN Child5.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child5.ConRelationship in ('S19','STC') THEN 'Stepchild' END else 
                                        CASE WHEN Child4.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child4.ConRelationship in ('S19','STC') THEN 'Stepchild'END END 
        ,drvDep5DateofBirth = CASE WHEN spouse.ConNameLast is null then Child5.ConDateofBirth else Child4.ConDateofBirth END
        ,drvDep5Medical = CASE WHEN spouse.ConNameLast is null then Child5.depMed else Child4.depMed END 
        ,drvDep5Dental = CASE WHEN spouse.ConNameLast is null then Child5.depDen else Child4.DepDen END 
        ,drvDep5Vision = CASE WHEN spouse.ConNameLast is null then Child5.depVis else Child4.depVis END
        ,drvDep5Other = ''---CASE WHEN spouse.ConNameLast is null AND Child5.depSU201 = 'SU201' THEN 'LIFE04' else CASE WHEN Child4.depSU201 = 'SU201' THEN 'LIFE04' END END 
        ,drvDep6LastName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child5.ConNameLast) else dbo.dsi_fnRemoveChars('.,/',Child4.conNameLast) END
        ,drvDep6FirstName = CASE WHEN spouse.ConNameLast is null then dbo.dsi_fnRemoveChars('.,/',Child5.ConNameFirst) else dbo.dsi_fnRemoveChars('.,/',Child4.conNameFirst) END
        ,drvDep6SSN = ''
        ,drvDep6Gender = CASE WHEN spouse.ConNameLast is null then Child6.ConGender else Child5.ConGender END
        ,drvDep6Relationship = CASE    WHEN spouse.ConNameLast is null then CASE WHEN Child6.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child6.ConRelationship in ('S19','STC') THEN 'Stepchild' END else 
                                        CASE WHEN Child6.ConRelationship in ('C08','CHL') THEN 'Child'
                                        WHEN Child6.ConRelationship in ('S19','STC') THEN 'Stepchild'END END 
        ,drvDep6DateofBirth = CASE WHEN spouse.ConNameLast is null then Child6.ConDateofBirth else Child5.ConDateofBirth END
        ,drvDep6Medical = CASE WHEN spouse.ConNameLast is null then Child6.depMed else Child5.depMed END 
        ,drvDep6Dental = CASE WHEN spouse.ConNameLast is null then Child6.depDen else Child5.DepDen END
        ,drvDep6Vision = CASE WHEN spouse.ConNameLast is null then Child6.depVis else Child5.depVis END
        ,drvDep6Other = ''---CASE WHEN spouse.ConNameLast is null AND Child6.depSU201 = 'SU201' THEN 'LIFE04' else CASE WHEN Child5.depSU201 = 'SU201' THEN 'LIFE04' END END 
        ,drvDep7LastName = ''
        ,drvDep7FirstName = ''
        ,drvDep7SSN = ''
        ,drvDep7Gender = ''
        ,drvDep7Relationship = ''
        ,drvDep7DateofBirth = ''
        ,drvDep7Medical = ''
        ,drvDep7Dental = ''
        ,drvDep7Vision = ''
        ,drvDep8LastName = ''
        ,drvDep8FirstName = ''
        ,drvDep8SSN = ''
        ,drvDep8Gender = ''
        ,drvDep8Relationship = ''
        ,drvDep8DateofBirth = ''
        ,drvDep8Medical = ''
        ,drvDep8Dental = ''
        ,drvDep8Vision = ''
        ,drvDep9LastName = ''
        ,drvDep9FirstName = ''
        ,drvDep9SSN = ''
        ,drvDep9Gender = ''
        ,drvDep9Relationship = ''
        ,drvDep9DateofBirth = ''
        ,drvDep9Medical = ''
        ,drvDep9Dental = ''
        ,drvDep9Vision = ''
        ,drvDep10LastName = ''
        ,drvDep10FirstName = ''
        ,drvDep10SSN = ''
        ,drvDep10Gender = ''
        ,drvDep10Relationship = ''
        ,drvDep10DateofBirth = ''
        ,drvDep10Medical = ''
        ,drvDep10Dental = ''
        ,drvDep10Vision = ''
        ,drvDep11LastName = ''
        ,drvDep11FirstName = ''
        ,drvDep11SSN = ''
        ,drvDep11Gender = ''
        ,drvDep11Relationship = ''
        ,drvDep11DateofBirth = ''
        ,drvDep11Medical = ''
        ,drvDep11Dental = ''
        ,drvDep11Vision = ''
        ,drvSpouseDOB = CASE WHEN spouse.depSU201 = 'Y' THEN spouse.conDateOfBirth END
        ,drvSpecialInstructions = ''
   INTO dbo.U_EFRAOPQB_drvTbl
    FROM dbo.U_EFRAOPQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.fnEmployeeAge(getDAte())
    --    ON EepEEID = EEID
    --    AND EmployeeAge < 60
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
       AND EecCOID = xCOID
       And EecEEType <> 'TES'
       --AND EecCoID <> 'S9Z0A'
       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason not in ( 'TRO' )
                  AND EXISTS (Select 1 from dbo.U_EFRAOPQB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')
             )
           )
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID,  BdmRunId, BdmIsPQB,BdmDepRecID, BdmBenStatus, MAX(BdmCobraReason) as BdmCobraReason , MAX(BdmChangeReason) as BdmChangeReason  -- MW Added
                ,MAX(BdmBenStartDate) AS BdmBenStartDate
                ,MAX(BdmBenStopDate) AS BdmBenStopDate
                ,MAX(BdmBenStatusDate) AS BdmBenStatusDate
                ,MAX(BdmTVStartDate) as BdmTVStartDate
                ,MAX(CASE   WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01'
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus = 'T' THEN 'MED02'
                            WHEN BdmDedCode IN ('HE043')  AND BdmBenStatus = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048')  AND BdmBenStatus = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus = 'T' THEN 'MED11'
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus = 'T' THEN 'MED12' END
                            ) AS MedicalPlan
                ,MAX(CASE   WHEN BdmDedCode IN ('HE047','HE051','HE054','HE043','HE048','HE055','HE044','HE056','HE058','HE057','HE059','HE060','HE061') 
                            AND BdmBenStatus = 'T' THEN CASE WHEN BdmBenOption IN ('EM525','ZD175') THEN 'Single'
                            WHEN BdmBenOption IN ('EM526','EM570','ZD176') THEN 'Employee + Spouse'
                            WHEN BdmBenOption IN ('EM527','ZD176') AND BdmNumChildren = 1 THEN 'Employee + Child'
                            WHEN BdmBenOption IN ('EM527','EM529','ZD177','ZD178','ZD179','ZD180','ZD181','ZD182','ZD183') AND BdmNumChildren > 1 THEN  'Employee + Child/ren'
                            WHEN BdmBenOption IN ('EM528','ZD177','ZD178','ZD179','ZD180','ZD181','ZD182','ZD183','FA455') THEN 'Family' END END) as MedicalCoverage
                ,MAX(CASE   WHEN BdmDedCode IN ('DE297') AND BdmBenStatus = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' END) as DentalPlan
                ,MAX(CASE   WHEN BdmDedCode IN ('DE280','DE297','DE281','DE282','DE311','DE291') AND BdmBenStatus = 'T' THEN
                            CASE    WHEN BdmBenOption IN ('EM525','ZD175') THEN 'Single'
                                    WHEN BdmBenOption IN ('EM526','EM570','ZD176')THEN 'Participant + One'
                                    WHEN BdmBenOption IN ('EM527','ZD175','ZD176') AND BdmNumChildren = 1 THEN 'Employee + Child'
                                    WHEN BdmBenOption IN ('EM527','ZD177','ZD178','ZD179','ZD180','ZD181','ZD182','ZD183') AND BdmNumChildren > 1 THEN 'Employee + Child/ren'
                                    WHEN BdmBenOption IN ('EM528','ZD177','ZD178','ZD179','ZD180','ZD181','ZD182','ZD183','FA455') THEN 'Family' END END) as DentalCoverage
                ,MAX(CASE WHEN BdmDedCode IN ('VI120') AND BdmBenStatus = 'T' THEN 'VIS01' END) as VisionPlan
                ,MAX(CASE WHEN BdmDedCode IN ('VI120') AND BdmBenStatus = 'T' THEN 
                            CASE    WHEN BdmBenOption IN ('EM525','ZD175') THEN 'Single'
                                    WHEN BdmBenOption IN ('EM526','EM570','ZD176') THEN 'Employee + Spouse'
                                    WHEN BdmBenOption IN ('EM527','EM529','ZD176') AND BdmNumChildren = 1 THEN 'Employee + Child'    --UPDATE: KE 20230602 - incorrect benoption mapping. 'EM527'
                                    WHEN BdmBenOption IN ('EM527','EM528','EM529','ZD177','ZD178','ZD179','ZD180','ZD181','ZD182','ZD183') AND BdmNumChildren > 1 THEN 'Employee + Child/ren'   --UPDATE: KE 20230602 - incorrect benoption mapping. 'EM527'
                                    WHEN BdmBenOption IN ('EM528','ZD177','ZD178','ZD179','ZD180','ZD181','ZD182','ZD183','FA455') THEN 'Family' END END) as VisionCoverage
                ,MAX(CASE WHEN BdmDedCode IN ('LI210','LI215','LI219','LI220','LI225') AND BdmBenStatus = 'T' THEN 'LIFE01' END) as LifePlan1
                ,MAX(CASE WHEN BdmDedCode IN ('LI210','LI215','LI219','LI220','LI225') AND BdmBenStatus = 'T' THEN 'Single' END) as LifePlan1Coverage
                ,MAX(CASE WHEN BdmDedCode IN ('LI210','LI215','LI219','LI220','LI225') AND BdmBenStatus = 'T' THEN FORMAT(BCABenAmtCalc,'00000000') END) as LifePlan1Volume --MW updated to use BCABenAmtCalc from PdhLIFEPLAN1
                ,MAX(CASE WHEN BdmDedCode IN ('SU100')  AND BdmBenStatus = 'T' THEN 'LIFE03' END) as LifePlan2
                ,MAX(CASE WHEN BdmDedCode IN ('SU100')  AND BdmBenStatus = 'T' THEN 'Single' END) as LifePlan2Coverage
                ,MAX(CASE WHEN BdmDedCode IN  ('SU100') AND BdmBenStatus = 'T' THEN FORMAT(BCABenAmtCalc,'00000000') END) as LifePlan2Volume --MW updated to use BCABenAmtCalc from PdhLIFEPLAN2
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T'  THEN 'LIFE04' END) as LifePlan3
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T'  THEN 'Spouse' END) as LifePlan3Coverage
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN FORMAT(BCABenAmtCalc,'00000000') END) as LifePlan3Volume --MW updated to use BCABenAmtCalc from PdhLIFEPLAN3
                ,MAX(CASE WHEN BdmDedCode IN  ('SU096') AND BdmBenStatus = 'T' THEN 'LIFE05' WHEN BdmDedCode IN  ('SU097') AND BdmBenStatus = 'T' THEN 'LIFE06' END) as LifePlan4 
                ,MAX(CASE WHEN BdmDedCode IN  ('SU096','SU097') AND BdmBenStatus = 'T' THEN 'Single' END) as LifePlan4Coverage
                ,MAX(CASE WHEN BdmDedCode IN ('SU096','SU097') AND BdmBenStatus = 'T' THEN FORMAT(BCABenAmtCalc,'00000000') END) as Life4Volume --MW updated to use BCABenAmtCalc from PdhLIFEPLAN4
                ,MAX(CASE WHEN BdmDedCode IN ('FS176','FS177') AND BdmBenStatus = 'T' THEN 'FSA' END) AS FlexPlan
                ,MAX(CASE WHEN BdmDedCode IN ('FS176','FS177') AND BdmBenStatus = 'T' THEN 'Single' END) AS FlexPlanCovLevel
                ,MAX(CASE WHEN BdmDedCode IN ('FS176','FS177') AND BdmBenStatus = 'T' THEN BdmEEAmt  END) AS FlexHCAmt
                ,MAX(CASE WHEN BdmDedCode IN ('FS176','FS177') THEN DATEFROMPARTS(YEAR(GETDATE()), 12, 31) END) AS FlexPlanEndDate
           FROM dbo.U_dsi_BDM_EFRAOPQB WITH (NOLOCK)
     LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        ON BcaFormatCode = @FormatCode
        AND BcaEEID = BdmEEID
        AND BcaCOID = BdmCOID
        AND ISNULL(BcaDepRecID,'') = ISNULL(BdmDepRecID,'')
        AND BcaDedCode = BdmDedCode
        LEFT JOIN dbo.U_EFRAOPQB_PDedHist
        ON PdhEEID = BdmEEID
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmRunId,BdmIsPQB, BdmDepRecID,BdmBenStatus
        ) AS BDM
        ON BDM.BdmEEID = xEEID 
        AND BDM.BdmCoID = xCoID
        AND BDM.BdmRunId = 'QB'
        AND BDM.BdmIsPQB = 'Y'
    LEFT JOIN dbo.Contacts Contacts with (nolock)
        on Contacts.ConEEID = Bdm.BdmEEID
        AND Contacts.ConsystemID = Bdm.BdmDepRecID
    LEFT JOIN (
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, '02' AS RN 
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                 ,MAX(CASE    WHEN BdmDedCode IN ('SU201') THEN 'Y'END) AS depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BDMS.BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship in ('SPS','O20') 
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode
                    ) AS Spouse
                    ON Spouse.ConEEID = BdmEEID
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN1, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child1
                    ON Child1.ConEEID = BdmEEID
                     AND RN1 = '03'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN2,depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child2
                    ON Child2.ConEEID = BdmEEID
                     AND RN2 = '04'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN3, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child3
                    ON Child3.ConEEID = BdmEEID
                    AND RN3 = '05'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN4, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child4
                    ON Child4.ConEEID = BdmEEID
                    AND RN4 = '06'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN5, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child5
                    ON Child5.ConEEID = BdmEEID
                    AND RN5 = '07'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN6, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child6
                    ON Child6.ConEEID = BdmEEID
                    AND RN6 = '08'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN7, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child7
                    ON Child7.ConEEID = BdmEEID
                    AND RN7 = '09'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN,  ConIsStudent, ConIsDisabled,
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN8, depMED,depDEN,depVIS,depSU201
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                ,MAX(CASE    WHEN BdmDedCode IN ('HE047','HE051') AND BdmBenStatus = 'T' THEN 'MED01' 
                            WHEN BdmDedCode IN ('HE054') AND BdmBenStatus  = 'T' THEN 'MED02' 
                            WHEN BdmDedCode IN ('HE043') AND BdmBenStatus  = 'T' THEN 'MED03'
                            WHEN BdmDedCode IN ('HE048') AND BdmBenStatus  = 'T' THEN 'MED04'
                            WHEN BdmDedCode IN ('HE055') AND BdmBenStatus  = 'T' THEN 'MED05'
                            WHEN BdmDedCode IN ('HE044') AND BdmBenStatus  = 'T' THEN 'MED06'
                            WHEN BdmDedCode IN ('HE056') AND BdmBenStatus  = 'T' THEN 'MED07'
                            WHEN BdmDedCode IN ('HE058') AND BdmBenStatus  = 'T' THEN 'MED08'
                            WHEN BdmDedCode IN ('HE057') AND BdmBenStatus  = 'T' THEN 'MED09'
                            WHEN BdmDedCode IN ('HE059') AND BdmBenStatus  = 'T' THEN 'MED10'
                            WHEN BdmDedCode IN ('HE060') AND BdmBenStatus  = 'T' THEN 'MED11' 
                            WHEN BdmDedCode IN ('HE061') AND BdmBenStatus  = 'T' THEN 'MED12' 
                            END) AS depMED
                ,MAX(CASE    WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'RCHLG' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE280','DE281','DE282') AND BdmBenStatus  = 'T' THEN 'DEN01'
                            WHEN BdmDedCode IN ('DE297') AND BdmBenStatus  = 'T' AND BdmCOID = 'S9ZEQ' THEN 'DEN02'
                            WHEN BdmDedCode IN ('DE311','DE291') AND BdmBenStatus  = 'T' THEN 'DEN02' 
                            END) AS depDEN
                ,MAX(CASE    WHEN BdmDedCode IN ('VI120') AND BdmBenStatus  = 'T' THEN 'VIS01'END) AS depVIS
                ,MAX(CASE WHEN BdmDedCode IN ('SU201') AND BdmBenStatus = 'T' THEN 'SU201' END) as depSU201
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EFRAOPQB BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmS.BdmIsPQB <> 'Y'
                 WHERE ConRelationship IN ('C08','CHL','S19','STC')
                 GROUP BY ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConSSN, ConIsStudent, ConIsDisabled
                        ) AS CHILD
                    ) AS Child8
                    ON Child8.ConEEID = BdmEEID
                    AND RN8 = '10'
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('HE047','HE051','HE054','HE043','HE048','HE055','HE044','HE056','HE058','HE057','HE059','HE060','HE061','DE280','DE297','DE281','DE282','DE311','DE291','LI210','LI215','LI219','LI220','LI225','SU096','SU097','SU100','SU201') 
                        AND edhChangeReason IN ('200','201','202','203','204','208','210','LEVNT3','LEVNT4') AND EdhEffDate BETWEEN @StartDate AND @EndDate 
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
        AND BdmRunID = 'QB'
        AND BchIsCobraQualifiedEvent = 'Y'
     WHERE  CASE  WHEN EecEmplStatus = 'T' AND (BdmCobraReason = '200' or EecTermReason not in ('202','203')) AND EecTermType = 'V' THEN '01'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason not in ('202','203') AND EecTermType = 'V' THEN '01'
                                    WHEN (EecEmplStatus = 'T' AND EecTermReason = '202') or BdmCobraReason = '208' or BdmChangeReason = '208' THEN '02' 
                                    WHEN (EecEmplStatus = 'T' AND EecTermReason = '203') or BdmChangeReason = '210' or BdmChangeReason = '210' THEN '04'
                                    WHEN BdmCobraReason in ('201','LEVNT3') or BdmChangeReason in ('201','LEVNT3') THEN '05'       
                                    WHEN BdmCobraReason in ('202','203') or BdmChangeReason in ('201','LEVNT3') THEN '06'   
                                    WHEN BdmCobraReason in ('204','LEVNT4') or BdmChangeReason in ('204','LEVNT4') THEN '08'     
                                    WHEN EecEmplStatus = 'T' AND EecTermReason not in ('203') AND EecTermType = 'I' THEN '13'
                                    END IS NOT null
   ;

 
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'FILE_Test.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'FILE_FullFile.csv'
                                  ELSE 'FILE.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFRAOPQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFRAOPQB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFRAOPQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202305151'
       ,expStartPerControl     = '202305151'
       ,expLastEndPerControl   = '202401239'
       ,expEndPerControl       = '202401239'
WHERE expFormatCode = 'EFRAOPQB' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFRAOPQB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFRAOPQB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFRAOPQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFRAOPQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFRAOPQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFRAOPQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFRAOPQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFRAOPQB', 'UseFileName', 'V', 'Y'


-- End ripout