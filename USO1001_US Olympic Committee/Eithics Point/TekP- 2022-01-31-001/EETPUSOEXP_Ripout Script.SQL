/**********************************************************************************

EETPUSOEXP: Ethics Point Demo Export

FormatCode:     EETPUSOEXP
Project:        Ethics Point Demo Export
Client ID:      USO1001
Date/time:      2022-08-18 11:49:07.407
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUSOC
Web Filename:   USO1001_839B6_EEHISTORY_EETPUSOEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EETPUSOEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EETPUSOEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EETPUSOEXP'


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
WHERE FormatCode = 'EETPUSOEXP'
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
WHERE ExpFormatCode = 'EETPUSOEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EETPUSOEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EETPUSOEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EETPUSOEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EETPUSOEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EETPUSOEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EETPUSOEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EETPUSOEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EETPUSOEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EETPUSOEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EETPUSOEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEETPUSOEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEETPUSOEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EETPUSOEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EETPUSOEXP];
GO
IF OBJECT_ID('U_EETPUSOEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_PEarHist];
GO
IF OBJECT_ID('U_EETPUSOEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_PDedHist];
GO
IF OBJECT_ID('U_EETPUSOEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_File];
GO
IF OBJECT_ID('U_EETPUSOEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_EEList];
GO
IF OBJECT_ID('U_EETPUSOEXP_driverTbl') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_driverTbl];
GO
IF OBJECT_ID('U_EETPUSOEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_DedList];
GO
IF OBJECT_ID('U_EETPUSOEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_AuditFields];
GO
IF OBJECT_ID('U_EETPUSOEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EETPUSOEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EETPUSOEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EETPUSOEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EETPUSOEXP','Ethics Point Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EETPUSOEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EETPUSOEXPZ0','50','H','01','1',NULL,'First name',NULL,NULL,'"First name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EETPUSOEXPZ0','50','H','01','2',NULL,'Preferred Name',NULL,NULL,'"Preferred Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EETPUSOEXPZ0','50','H','01','3',NULL,'Last name',NULL,NULL,'"Last name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EETPUSOEXPZ0','50','H','01','4',NULL,'HRID number',NULL,NULL,'"HRID number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EETPUSOEXPZ0','50','H','01','5',NULL,'Phone number',NULL,NULL,'"Phone number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EETPUSOEXPZ0','50','H','01','6',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EETPUSOEXPZ0','50','H','01','7',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EETPUSOEXPZ0','50','H','01','8',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EETPUSOEXPZ0','50','H','01','9',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EETPUSOEXPZ0','50','H','01','10',NULL,'Time in Job',NULL,NULL,'"Time in Job"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EETPUSOEXPZ0','50','H','01','11',NULL,'Tenure',NULL,NULL,'"Tenure"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EETPUSOEXPZ0','50','H','01','12',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EETPUSOEXPZ0','50','H','01','13',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EETPUSOEXPZ0','50','H','01','14',NULL,'City',NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EETPUSOEXPZ0','50','H','01','15',NULL,'State',NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EETPUSOEXPZ0','50','H','01','16',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EETPUSOEXPZ0','50','H','01','17',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EETPUSOEXPZ0','50','H','01','18',NULL,'Supervisor First Name',NULL,NULL,'"Supervisor First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EETPUSOEXPZ0','50','H','01','19',NULL,'Supervisor Last Name',NULL,NULL,'"Supervisor Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EETPUSOEXPZ0','50','H','01','20',NULL,'Compensation Level for Bonus',NULL,NULL,'"Compensation Level for Bonus"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EETPUSOEXPZ0','50','H','01','21',NULL,'Executive Level Code',NULL,NULL,'"Executive Level Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EETPUSOEXPZ0','50','H','01','22',NULL,'Executive Level',NULL,NULL,'"Executive Level"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EETPUSOEXPZ0','50','H','01','23',NULL,'Division Code',NULL,NULL,'"Division Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EETPUSOEXPZ0','50','H','01','24',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EETPUSOEXPZ0','50','H','01','25',NULL,'Department Code',NULL,NULL,'"Department Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EETPUSOEXPZ0','50','H','01','26',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EETPUSOEXPZ0','50','H','01','27',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EETPUSOEXPZ0','50','H','01','28',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EETPUSOEXPZ0','50','H','01','29',NULL,'Age',NULL,NULL,'"Age"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EETPUSOEXPZ0','50','H','01','30',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EETPUSOEXPZ0','50','H','01','31',NULL,'Compa-ratio',NULL,NULL,'"Compa-ratio"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EETPUSOEXPZ0','50','D','10','1',NULL,'First name',NULL,NULL,'"drvFirstname"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EETPUSOEXPZ0','50','D','10','2',NULL,'Preferred Name',NULL,NULL,'"drvPreferredName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EETPUSOEXPZ0','50','D','10','3',NULL,'Last name',NULL,NULL,'"drvLastname"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EETPUSOEXPZ0','50','D','10','4',NULL,'HRID number',NULL,NULL,'"drvHRIDnumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EETPUSOEXPZ0','50','D','10','5',NULL,'Phone number',NULL,NULL,'"drvPhonenumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EETPUSOEXPZ0','50','D','10','6',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EETPUSOEXPZ0','100','D','10','7',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EETPUSOEXPZ0','100','D','10','8',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EETPUSOEXPZ0','100','D','10','9',NULL,'Date of Hire',NULL,NULL,'"drvDateofHire"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EETPUSOEXPZ0','100','D','10','10',NULL,'Time in Job',NULL,NULL,'"drvTimeinJob"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EETPUSOEXPZ0','100','D','10','11',NULL,'Tenure',NULL,NULL,'"drvTenure"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EETPUSOEXPZ0','100','D','10','12',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EETPUSOEXPZ0','100','D','10','13',NULL,'Address',NULL,NULL,'"drvAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EETPUSOEXPZ0','100','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EETPUSOEXPZ0','100','D','10','15',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EETPUSOEXPZ0','100','D','10','16',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EETPUSOEXPZ0','100','D','10','17',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EETPUSOEXPZ0','100','D','10','18',NULL,'Supervisor First Name',NULL,NULL,'"drvSupervisorFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EETPUSOEXPZ0','100','D','10','19',NULL,'Supervisor Last Name',NULL,NULL,'"drvSupervisorLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EETPUSOEXPZ0','100','D','10','20',NULL,'Compensation Level for Bonus',NULL,NULL,'"drvCompensationLevelforBonus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EETPUSOEXPZ0','100','D','10','21',NULL,'Executive Level Code',NULL,NULL,'"drvExecutiveLevelCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EETPUSOEXPZ0','100','D','10','22',NULL,'Executive Level',NULL,NULL,'"drvExecutiveLevel"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EETPUSOEXPZ0','100','D','10','23',NULL,'Division Code',NULL,NULL,'"drvDivisionCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EETPUSOEXPZ0','100','D','10','24',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EETPUSOEXPZ0','100','D','10','25',NULL,'Department Code',NULL,NULL,'"drvDepartmentCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EETPUSOEXPZ0','100','D','10','26',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EETPUSOEXPZ0','100','D','10','27',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EETPUSOEXPZ0','100','D','10','28',NULL,'Ethnicity',NULL,NULL,'"drvEthnicity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EETPUSOEXPZ0','100','D','10','29',NULL,'Age',NULL,NULL,'"drvAge"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EETPUSOEXPZ0','100','D','10','30',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EETPUSOEXPZ0','100','D','10','31',NULL,'Compa-ratio',NULL,NULL,'"drvComparatio"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EETPUSOEXP_20220818.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202205109','EMPEXPORT','OE ACTIVE',NULL,'EETPUSOEXP',NULL,NULL,NULL,'202205109','May 10 2022  8:48PM','May 10 2022  8:48PM','202205101',NULL,'','','202205101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202205109','EMPEXPORT','OE PASSIVE',NULL,'EETPUSOEXP',NULL,NULL,NULL,'202205109','May 10 2022  8:48PM','May 10 2022  8:48PM','202205101',NULL,'','','202205101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ethics Point Demo Export','202205109','EMPEXPORT','ONDEM_XOE',NULL,'EETPUSOEXP',NULL,NULL,NULL,'202205109','May 10 2022  8:48PM','May 10 2022  8:48PM','202205101',NULL,'','','202205101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202205109','EMPEXPORT','SCH_EETPUS',NULL,'EETPUSOEXP',NULL,NULL,NULL,'202205109','May 10 2022  8:48PM','May 10 2022  8:48PM','202205101',NULL,'','','202205101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','V5C45',NULL,NULL,NULL,'Test Purposes Only','202208179','EMPEXPORT','TEST_XOE','Jul  1 2022  3:19PM','EETPUSOEXP',NULL,NULL,NULL,'202208179','Jul  1 2022 12:00AM','Dec 30 1899 12:00AM','202208171','551','','','202208171',dbo.fn_GetTimedKey(),NULL,'us3jReUSO1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EETPUSOEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EETPUSOEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EETPUSOEXP','D10','dbo.U_EETPUSOEXP_driverTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EETPUSOEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EETPUSOEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EETPUSOEXP] (
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
-- Create table U_EETPUSOEXP_Audit
-----------

IF OBJECT_ID('U_EETPUSOEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_Audit] (
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
-- Create table U_EETPUSOEXP_AuditFields
-----------

IF OBJECT_ID('U_EETPUSOEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EETPUSOEXP_DedList
-----------

IF OBJECT_ID('U_EETPUSOEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EETPUSOEXP_driverTbl
-----------

IF OBJECT_ID('U_EETPUSOEXP_driverTbl') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_driverTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvFirstname] varchar(100) NULL,
    [drvPreferredName] varchar(100) NULL,
    [drvLastname] varchar(100) NULL,
    [drvHRIDnumber] char(9) NULL,
    [drvPhonenumber] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvEmploymentStatus] char(1) NULL,
    [drvDateofHire] datetime NULL,
    [drvTimeinJob] datetime NULL,
    [drvTenure] varchar(30) NULL,
    [drvTerminationDate] datetime NULL,
    [drvAddress] varchar(511) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvLocation] char(6) NULL,
    [drvSupervisorFirstName] varchar(256) NULL,
    [drvSupervisorLastName] varchar(256) NULL,
    [drvCompensationLevelforBonus] char(10) NULL,
    [drvExecutiveLevelCode] char(10) NULL,
    [drvExecutiveLevel] varchar(25) NULL,
    [drvDivisionCode] char(10) NULL,
    [drvDivision] varchar(25) NULL,
    [drvDepartmentCode] char(10) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvGender] char(1) NULL,
    [drvEthnicity] varchar(45) NULL,
    [drvAge] varchar(30) NULL,
    [drvSalary] varchar(30) NULL,
    [drvComparatio] nvarchar(4000) NULL
);

-----------
-- Create table U_EETPUSOEXP_EEList
-----------

IF OBJECT_ID('U_EETPUSOEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EETPUSOEXP_File
-----------

IF OBJECT_ID('U_EETPUSOEXP_File') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EETPUSOEXP_PDedHist
-----------

IF OBJECT_ID('U_EETPUSOEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EETPUSOEXP_PEarHist
-----------

IF OBJECT_ID('U_EETPUSOEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EETPUSOEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EETPUSOEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: USA Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Julie Reardon 
Create Date: 05/10/2022
Service Request Number: TekP- 2022-01-31-001

Purpose: Ethics Point Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters       06/22/2022     TekP- 2022-01-31-001   Added code for Comparatio field
Marie Waters       06/28/2022     TekP- 2022-01-31-001   FirstName and PreferredName were missing the Pipe delimiter
Marie Waters       08/18/2022      TekP- 2022-01-31-001   Changed the tenure field     -- CAST( Format((DATEDIFF(day,EecDateOfLastHire,getdate()) / 365.2425 ),'N1') as varchar)        

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EETPUSOEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EETPUSOEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EETPUSOEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EETPUSOEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EETPUSOEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EETPUSOEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EETPUSOEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EETPUSOEXP', 'OE PASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EETPUSOEXP', 'OE ACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EETPUSOEXP', 'SCH_EETPUS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EETPUSOEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EETPUSOEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EETPUSOEXP';

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
    DELETE FROM dbo.U_EETPUSOEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EETPUSOEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

  

    
    --Audit Table
    IF OBJECT_ID('U_EETPUSOEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EETPUSOEXP_AuditFields;
    CREATE TABLE dbo.U_EETPUSOEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EETPUSOEXP_AuditFields VALUES ('EmpComp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EETPUSOEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EETPUSOEXP_Audit;
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
    INTO dbo.U_EETPUSOEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EETPUSOEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EETPUSOEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -365 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EETPUSOEXP_Audit ON dbo.U_EETPUSOEXP_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EETPUSOEXP_driverTbl
    ---------------------------------
    IF OBJECT_ID('U_EETPUSOEXP_driverTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EETPUSOEXP_driverTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvFirstname = EepNameFirst
        ,drvPreferredName = EepNamePreferred
        ,drvLastname = EepNameLast
        ,drvHRIDnumber = eecEmpNo
        ,drvPhonenumber = EepPhoneHomeNumber
        ,drvEmail = EepAddressEMail
        ,drvJobTitle = JbcLongDesc 
        ,drvEmploymentStatus = eecEmplStatus
        ,drvDateofHire = EecDateOfLastHire
        ,drvTimeinJob = EecDateInJob
        ,drvTenure = CAST( Format((DATEDIFF(day,EecDateOfLastHire,getdate()) / 365.2425 ),'N1') as varchar)  -- updated per client 8/22/2022 from  CAST( Format((DATEDIFF(day,EecDateOfLastHire,getdate()) / 365 ),'N2') as varchar)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvAddress = Concat(Isnull(eepAddressLine1,''), ' ' , Isnull(eepAddressLine2,''))
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvLocation = EecLocation
        ,drvSupervisorFirstName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst')    
        ,drvSupervisorLastName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast') 
        ,drvCompensationLevelforBonus = EecUDField01
        ,drvExecutiveLevelCode = EecOrgLvl1
        ,drvExecutiveLevel = Lvl1.OrgDesc
        ,drvDivisionCode = EecOrgLvl2
        ,drvDivision = Lvl2.OrgDesc
        ,drvDepartmentCode = EecOrgLvl3
        ,drvDepartment = Lvl3.OrgDesc
        ,drvGender = EepGender
        ,drvEthnicity = eth.CodDesc
        ,drvAge = CAST( (DATEDIFF(day,eepdateofbirth,getdate()) / 365 ) as varchar)
        ,drvSalary = CAST(EecAnnSalary as varchar)
        ,drvComparatio = sl.Average
    INTO dbo.U_EETPUSOEXP_driverTbl
    FROM dbo.U_EETPUSOEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        on Eepeeid = xeeid
    JOIN dbo.EmpComp WITH (NOLOCK)
        on eeceeid =  xeeid
        and eeccoid  =  xCoID
            and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EETPUSOEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        on JbcJobCode =  eecJobCode
    LEFT JOIN dbo.Orglevel Lvl1 WITH (NOLOCK) 
        on Lvl1.OrgCode = EecOrgLvl1
        and Lvl1.OrgLvl = 1
    LEFT JOIN dbo.Orglevel Lvl2 WITH (NOLOCK) 
        on Lvl2.OrgCode = EecOrgLvl2
        and Lvl2.OrgLvl = 2
    LEFT JOIN dbo.Orglevel Lvl3 WITH (NOLOCK) 
        on Lvl3.OrgCode = EecOrgLvl3
        and Lvl3.OrgLvl = 3
    LEFT JOIN (Select CodCode,CodDesc from dbo.Codes WITH (NOLOCK)  where CodTable  = 'ETHNICCODE') eth
        on eth.CodCode = EepEthnicID
    Left Join (SELECT DISTINCT  eeceeid EEID 
                            ,Jbcjobcode Jobcode
                            ,SlgHourlyMax slgMax
                            ,SlgHourlyMin SlgMin
                            ,SlgSalgrade 
                            ,format((EecHourlyPayRate /  ( Avg(SlgHourlyMax + SlgHourlyMin)/2) * 100 ),'#0.00') AS Average 
                        FROM dbo.JobCode WITH (NOLOCK) 
                        JOIN dbo.EmpComp 
                            ON JbcJobCode =  eecJobCode
                        JOIN dbo.SalGrade WITH (NOLOCK) 
                            ON JbcSalarygrade = SlgSalgrade
                        WHERE EecSalaryOrHourly = 'H' 
                Group by  eeceeid, Jbcjobcode, SlgHourlyMax, SlgHourlyMin,     SlgSalgrade , EecHourlyPayRate

                    UNION

                SELECT DISTINCT eeceeid  
                                ,Jbcjobcode
                                ,SlgAnnualMax 
                                ,SlgAnnualMin 
                                ,SlgSalgrade 
                                , Format((EecAnnSalary /  ( Avg( SlgAnnualMax + SlgAnnualMin)/2) * 100 ),'#0.00') AS Average 
                        FROM dbo.JobCode WITH (NOLOCK) 
                        JOIN dbo.EmpComp 
                            ON JbcJobCode =  eecJobCode
                        JOIN dbo.SalGrade WITH (NOLOCK) 
                            ON JbcSalarygrade = SlgSalgrade
                        WHERE  EecSalaryOrHourly = 'S'
                    Group by  eeceeid, Jbcjobcode, SlgAnnualMax , SlgAnnualMin,     SlgSalgrade ,EecAnnSalary
        ) Sl 
        ON sl.EEID = xEEID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEETPUSOEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EETPUSOEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EETPUSOEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208171'
       ,expStartPerControl     = '202208171'
       ,expLastEndPerControl   = '202208179'
       ,expEndPerControl       = '202208179'
WHERE expFormatCode = 'EETPUSOEXP'
and  ExpExportCode ='TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEETPUSOEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EETPUSOEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EETPUSOEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EETPUSOEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EETPUSOEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EETPUSOEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EETPUSOEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EETPUSOEXP', 'UseFileName', 'V', 'Y'


-- End ripout