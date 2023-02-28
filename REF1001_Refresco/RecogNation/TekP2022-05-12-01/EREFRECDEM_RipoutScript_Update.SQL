/**********************************************************************************

EREFRECDEM: RecogNation Demographic

FormatCode:     EREFRECDEM
Project:        RecogNation Demographic
Client ID:      REF1001
Date/time:      2023-02-28 15:16:46.027
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
Web Filename:   REF1001_XAC7C_EEHISTORY_EREFRECDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EREFRECDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_EREFRECDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EREFRECDEM'


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
WHERE FormatCode = 'EREFRECDEM'
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
WHERE ExpFormatCode = 'EREFRECDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EREFRECDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EREFRECDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EREFRECDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EREFRECDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EREFRECDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EREFRECDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EREFRECDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EREFRECDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EREFRECDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EREFRECDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEREFRECDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREFRECDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREFRECDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFRECDEM];
GO
IF OBJECT_ID('U_EREFRECDEM_File') IS NOT NULL DROP TABLE [dbo].[U_EREFRECDEM_File];
GO
IF OBJECT_ID('U_EREFRECDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREFRECDEM_EEList];
GO
IF OBJECT_ID('U_EREFRECDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREFRECDEM_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREFRECDEM','RecogNation Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EREFRECDEMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFRECDEMZ0','50','H','01','1',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFRECDEMZ0','50','H','01','2',NULL,'CostCenter',NULL,NULL,'"CostCenter"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFRECDEMZ0','50','H','01','3',NULL,'ProfitCenter',NULL,NULL,'"ProfitCenter"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFRECDEMZ0','50','H','01','4',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFRECDEMZ0','50','H','01','5',NULL,'JobTitle',NULL,NULL,'"JobTitle"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFRECDEMZ0','50','H','01','6',NULL,'Profile',NULL,NULL,'"Profile"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFRECDEMZ0','50','H','01','7',NULL,'EmployeeStatus',NULL,NULL,'"EmployeeStatus"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFRECDEMZ0','50','H','01','8',NULL,'Employee_ID',NULL,NULL,'"Employee_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREFRECDEMZ0','50','H','01','9',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREFRECDEMZ0','50','H','01','10',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREFRECDEMZ0','50','H','01','11',NULL,'MiddleInitial',NULL,NULL,'"MiddleInitial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREFRECDEMZ0','50','H','01','12',NULL,'Addr1',NULL,NULL,'"Addr1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREFRECDEMZ0','50','H','01','13',NULL,'Addr2',NULL,NULL,'"Addr2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREFRECDEMZ0','50','H','01','14',NULL,'Addr3',NULL,NULL,'"Addr3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREFRECDEMZ0','50','H','01','15',NULL,'Addr4',NULL,NULL,'"Addr4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREFRECDEMZ0','50','H','01','16',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EREFRECDEMZ0','50','H','01','17',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EREFRECDEMZ0','50','H','01','18',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EREFRECDEMZ0','50','H','01','19',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EREFRECDEMZ0','50','H','01','20',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EREFRECDEMZ0','50','H','01','21',NULL,'YrsOfServ',NULL,NULL,'"YrsOfServ"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EREFRECDEMZ0','50','H','01','22',NULL,'DateHired',NULL,NULL,'"DateHired"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EREFRECDEMZ0','50','H','01','23',NULL,'BirthDate',NULL,NULL,'"BirthDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EREFRECDEMZ0','50','H','01','24',NULL,'SupervisorJobTitle',NULL,NULL,'"SupervisorJobTitle"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EREFRECDEMZ0','50','H','01','25',NULL,'Supervisor_ID',NULL,NULL,'"Supervisor_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EREFRECDEMZ0','50','H','01','26',NULL,'SupervisorFirstName',NULL,NULL,'"SupervisorFirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EREFRECDEMZ0','50','H','01','27',NULL,'SupervisorLastName',NULL,NULL,'"SupervisorLastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EREFRECDEMZ0','50','H','01','28',NULL,'SupervisorEmail',NULL,NULL,'"SupervisorEmail"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EREFRECDEMZ0','50','H','01','29',NULL,'HRID',NULL,NULL,'"HRID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EREFRECDEMZ0','50','H','01','30',NULL,'HRName',NULL,NULL,'"HRName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EREFRECDEMZ0','50','H','01','31',NULL,'HREmail',NULL,NULL,'"HREmail"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EREFRECDEMZ0','50','H','01','32',NULL,'Union',NULL,NULL,'"Union"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EREFRECDEMZ0','50','H','01','33',NULL,'PreferredLanguage',NULL,NULL,'"PreferredLanguage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EREFRECDEMZ0','50','H','01','34',NULL,'RetirementDate',NULL,NULL,'"RetirementDate"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREFRECDEMZ0','50','D','10','1',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREFRECDEMZ0','50','D','10','2',NULL,'CostCenter',NULL,NULL,'"drvCostCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREFRECDEMZ0','50','D','10','3',NULL,'ProfitCenter',NULL,NULL,'"drvProfitCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREFRECDEMZ0','50','D','10','4',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREFRECDEMZ0','50','D','10','5',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREFRECDEMZ0','50','D','10','6',NULL,'Profile',NULL,NULL,'"E"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREFRECDEMZ0','50','D','10','7',NULL,'EmployeeStatus',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREFRECDEMZ0','50','D','10','8',NULL,'Employee_ID',NULL,NULL,'"drvEmployee_ID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREFRECDEMZ0','50','D','10','9',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREFRECDEMZ0','50','D','10','10',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREFRECDEMZ0','50','D','10','11',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREFRECDEMZ0','50','D','10','12',NULL,'Addr1',NULL,NULL,'"drvAddrress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREFRECDEMZ0','50','D','10','13',NULL,'Addr2',NULL,NULL,'"drvAddrress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREFRECDEMZ0','50','D','10','14',NULL,'Addr3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREFRECDEMZ0','50','D','10','15',NULL,'Addr4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREFRECDEMZ0','50','D','10','16',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EREFRECDEMZ0','50','D','10','17',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EREFRECDEMZ0','50','D','10','18',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EREFRECDEMZ0','51','D','10','19',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EREFRECDEMZ0','52','D','10','20',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EREFRECDEMZ0','53','D','10','21',NULL,'YrsOfServ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EREFRECDEMZ0','54','D','10','22',NULL,'DateHired',NULL,NULL,'"drvDateofHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EREFRECDEMZ0','55','D','10','23',NULL,'BirthDate',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EREFRECDEMZ0','56','D','10','24',NULL,'SupervisorJobTitle',NULL,NULL,'"drvSupervisorJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EREFRECDEMZ0','57','D','10','25',NULL,'Supervisor_ID',NULL,NULL,'"drvSupervisor_ID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EREFRECDEMZ0','58','D','10','26',NULL,'SupervisorFirstName',NULL,NULL,'"drvSupervisorFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EREFRECDEMZ0','59','D','10','27',NULL,'SupervisorLastName',NULL,NULL,'"drvSupervisorLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EREFRECDEMZ0','60','D','10','28',NULL,'SupervisorEmail',NULL,NULL,'"drvSupervisorEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EREFRECDEMZ0','61','D','10','29',NULL,'HRID',NULL,NULL,'"drvHRID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EREFRECDEMZ0','62','D','10','30',NULL,'HRName',NULL,NULL,'"drvHRName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EREFRECDEMZ0','63','D','10','31',NULL,'HREmail',NULL,NULL,'"drvHREmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EREFRECDEMZ0','64','D','10','32',NULL,'Union',NULL,NULL,'"drvUnion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EREFRECDEMZ0','64','D','10','33',NULL,'PreferredLanguage',NULL,NULL,'"drvPreferredLanguage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EREFRECDEMZ0','64','D','10','34',NULL,'RetirementDate',NULL,NULL,'"drvRetireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EREFRECDEM_20230228.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RecogNation Demographic','202205189','EMPEXPORT','ONDEMAND',NULL,'EREFRECDEM',NULL,NULL,NULL,'202205189','May 18 2022  1:40PM','May 18 2022  1:40PM','202205181',NULL,'','','202205181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'DAJ4C,DCQJ1,DAJ8D,CIUJE,CMCOX,CITIX',NULL,NULL,NULL,'RecogNation - Weekly Monday AM','202205189','EMPEXPORT','SCHEDULED',NULL,'EREFRECDEM',NULL,NULL,NULL,'202302279','May 18 2022  1:40PM','May 18 2022  1:40PM','202302201',NULL,'','','202205181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202206139','EMPEXPORT','TEST','Jun 13 2022 10:02AM','EREFRECDEM',NULL,NULL,NULL,'202206139','Jun 13 2022 12:00AM','Dec 30 1899 12:00AM','202205301','5204','','','202205301',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFRECDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFRECDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFRECDEM','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFRECDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFRECDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREFRECDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFRECDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREFRECDEM','D10','dbo.U_EREFRECDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EREFRECDEM_drvTbl
-----------

IF OBJECT_ID('U_EREFRECDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREFRECDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvLocation] char(6) NULL,
    [drvCostCenter] varchar(10) NULL,
    [drvProfitCenter] varchar(10) NULL,
    [drvDepartment] varchar(10) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvEmployeeStatus] varchar(10) NOT NULL,
    [drvEmployee_ID] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddleInitial] varchar(1) NULL,
    [drvAddrress1] varchar(8000) NULL,
    [drvAddrress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(8000) NULL,
    [drvZip] varchar(8000) NULL,
    [drvCountry] varchar(8000) NULL,
    [drvEmail] varchar(50) NULL,
    [drvYrsOfServ] nvarchar(4000) NULL,
    [drvDateofHire] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSupervisorJobTitle] varchar(256) NULL,
    [drvSupervisor_ID] varchar(256) NULL,
    [drvSupervisorFirstName] varchar(256) NULL,
    [drvSupervisorLastName] varchar(256) NULL,
    [drvSupervisorEmail] varchar(256) NULL,
    [drvHRID] char(9) NULL,
    [drvHRName] varchar(201) NULL,
    [drvHREmail] varchar(50) NULL,
    [drvUnion] char(12) NULL,
    [drvPreferredLanguage] varchar(45) NULL,
    [drvRetireDate] datetime NULL
);

-----------
-- Create table U_EREFRECDEM_EEList
-----------

IF OBJECT_ID('U_EREFRECDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_EREFRECDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EREFRECDEM_File
-----------

IF OBJECT_ID('U_EREFRECDEM_File') IS NULL
CREATE TABLE [dbo].[U_EREFRECDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREFRECDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco Beverages US Inc

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 05/18/2022
Service Request Number: TekP2022-05-12-01

Purpose: RecogNation Demographic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREFRECDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREFRECDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREFRECDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREFRECDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREFRECDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFRECDEM', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFRECDEM', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREFRECDEM', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREFRECDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREFRECDEM';

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
    DELETE FROM dbo.U_EREFRECDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREFRECDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREFRECDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREFRECDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREFRECDEM_drvTbl;
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eecempno
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvLocation = EecLocation
        ,drvCostCenter = eecorglvl3
        ,drvProfitCenter = eecorglvl2
        ,drvDepartment = eecorglvl1
        ,drvJobTitle = replace(JbcDesc,',','' )  
        ,drvEmployeeStatus = CASE WHEN eecemplstatus = 'T' and eectermreason = '202' THEN 'Terminated' ELSE 'Active' END
                    --CASE WHEN eecemplstatus IN ('A',  'S') THEN 'Active' END
        ,drvEmployee_ID = eecempno
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddrress1 = replace(eepaddressline1,',','' )
        ,drvAddrress2 = replace(eepaddressline2,',','' )
        ,drvCity = replace(EepAddressCity,',','' )
        ,drvState = replace(EepAddressState,',','' )
        ,drvZip = replace(eepaddresszipcode,',','' )
        ,drvCountry = replace(EepAddressCountry,',','' )
        ,drvEmail = CASE WHEN eecemplstatus = 'T' and eectermreason = '202' THEN EepAddressEMailAlternate ELSE EepAddressEMail END
                --EepAddressEMail
        ,drvYrsOfServ = CASE WHEN eecemplstatus = 'T' and eectermreason = '202' and eecdateoftermination is not null THEN FORMAT(DATEDIFF(Year,Employee_ServiceRewardDate,eecdateoftermination), '0')
                        ELSE ''
                        END
                        --CAST(dbo.dsi_fnlib_GetYearsMonthsDays(Employee_ServiceRewardDate,eecdateoftermination) AS VARCHAR)
        ,drvDateofHire = Employee_ServiceRewardDate  --Employee_ServiceRewardDate 
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSupervisorJobTitle = dbo.dsi_fnlib_GetSupervisorField(EecCoID,EecEEID, 'JobDesc') -- JbcDesc where JbcCode = EecJobCode from EecSupervisorID
        ,drvSupervisor_ID = dbo.dsi_fnlib_GetSupervisorField(EecCoID,EecEEID, 'EmpNo') --from EecSupervisorID
        ,drvSupervisorFirstName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst')
        ,drvSupervisorLastName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast')
        ,drvSupervisorEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail')
        ,drvHRID =  NciEmpNo  --HR manager by location - eecempno from codCode FROM dbo.Codes ON ON EecLocation = CodCodewhere codTable = 'CO_HRMANAGERBYLOCATI' - see coding used in export EBENEXDEMO
        ,drvHRName =  NciNameFirst + ' ' + NciNameLast --HR manager by location - eepnamefirst space eepnamelast from codCode FROM dbo.Codes ON ON EecLocation = CodCode where codTable = 'CO_HRMANAGERBYLOCATI' - see coding used in export EBENEXDEMO
        ,drvHREmail =  NciEmailAddress --HR manager by location - eepaddressemail from codCode FROM dbo.Codes ON ON EecLocation = CodCode where codTable = 'CO_HRMANAGERBYLOCATI' - see coding used in export EBENEXDEMO
        ,drvUnion = CASE WHEN EecUnionLocal <> 'N' THEN EecUnionLocal END-- EecUnionNational
        ,drvPreferredLanguage =  Codes.CodDesc
        ,drvRetireDate = eecdateoftermination
   INTO dbo.U_EREFRECDEM_drvTbl
    FROM dbo.U_EREFRECDEM_EEList WITH (NOLOCK)
   JOIN dbo.vw_int_EmpComp  WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID --and EecEEtype <> 'TES'
    JOIN dbo.EmpPers EMP WITH (NOLOCK)
        ON EMP.EepEEID = xEEID
    JOIN dbo.JobCode  WITH (NOLOCK)
        ON JbcJobCode = EecJobCode --JbcCode = EecJobCode 
    LEFT JOIN (
                SELECT EepNameLast AS NciNameLast, EepNameFirst AS NciNameFirst, EecEmpNo AS NciEmpNo, EepAddressEmail AS NciEmailAddress, CodCode AS NciLocationCode 
                FROM dbo.EmpComp WITH (NOLOCK)    
                    JOIN dbo.EmpPers WITH (NOLOCK)
                        ON EecEEID = EepEEID        
                    JOIN dbo.Codes WITH (NOLOCK)
                        ON CodDesc = EecEmpNo
                WHERE CodTable = 'CO_HRMANAGERBYLOCATI') AS HRI
        ON NciLocationCode = EecLocation
    Left Join dbo.LabUnion 
        ON unicode = EecUnionLocal
    LEFT JOIN [dbo].[fn_MP_CustomFields_EmpPers_Export](null, null, null, null)
        ON EEID = xEEID 
    LEFT JOIN (select CodCode, CodDesc from Codes WITH (NOLOCK)
        where codtable = 'PAYSTMTLANG') Codes on Codes.CodCode = EecLanguageCode
        WHERE (eecemplstatus IN ('A',  'S') or (eecemplstatus = 'T' and eectermreason = '202' and eecdateoftermination > CAST(DATEADD(DAY, -120, @StartDate) AS VARCHAR)))  
        AND EecEEtype IN ('REG', 'HS', 'EXE')
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
ALTER VIEW dbo.dsi_vwEREFRECDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREFRECDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREFRECDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202205111'
       ,expStartPerControl     = '202205111'
       ,expLastEndPerControl   = '202205189'
       ,expEndPerControl       = '202205189'
WHERE expFormatCode = 'EREFRECDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEREFRECDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EREFRECDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EREFRECDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EREFRECDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EREFRECDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFRECDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EREFRECDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREFRECDEM', 'UseFileName', 'V', 'Y'


-- End ripout