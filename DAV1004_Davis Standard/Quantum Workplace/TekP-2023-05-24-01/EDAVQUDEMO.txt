/**********************************************************************************

EDAVQUDEMO: Quantum Demographic

FormatCode:     EDAVQUDEMO
Project:        Quantum Demographic
Client ID:      USG1000
Date/time:      2023-06-26 15:42:20.440
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EDAVQUDEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDAVQUDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_EDAVQUDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDAVQUDEMO'


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
WHERE FormatCode = 'EDAVQUDEMO'
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
WHERE ExpFormatCode = 'EDAVQUDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDAVQUDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDAVQUDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDAVQUDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDAVQUDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDAVQUDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDAVQUDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDAVQUDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDAVQUDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDAVQUDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDAVQUDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDAVQUDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDAVQUDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDAVQUDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDAVQUDEMO];
GO
IF OBJECT_ID('U_EDAVQUDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EDAVQUDEMO_File];
GO
IF OBJECT_ID('U_EDAVQUDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDAVQUDEMO_EEList];
GO
IF OBJECT_ID('U_EDAVQUDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDAVQUDEMO_drvTbl];
GO
IF OBJECT_ID('U_EDAVQUDEMO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EDAVQUDEMO_AuditFields];
GO
IF OBJECT_ID('U_EDAVQUDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EDAVQUDEMO_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDAVQUDEMO','Quantum Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EDAVQUDEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDAVQUDEMOZ0','50','H','01','1',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDAVQUDEMOZ0','50','H','01','2',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDAVQUDEMOZ0','50','H','01','3',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDAVQUDEMOZ0','50','H','01','4',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDAVQUDEMOZ0','50','H','01','5',NULL,'Username',NULL,NULL,'"Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDAVQUDEMOZ0','50','H','01','6',NULL,'Primary Email',NULL,NULL,'"Primary Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDAVQUDEMOZ0','50','H','01','7',NULL,'ManagerEmployeeID',NULL,NULL,'"ManagerEmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDAVQUDEMOZ0','50','H','01','8',NULL,'ManagerName',NULL,NULL,'"ManagerName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDAVQUDEMOZ0','50','H','01','9',NULL,'HireDate',NULL,NULL,'"HireDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDAVQUDEMOZ0','50','H','01','10',NULL,'TermDate',NULL,NULL,'"TermDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDAVQUDEMOZ0','50','H','01','11',NULL,'TermType',NULL,NULL,'"TermType"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDAVQUDEMOZ0','50','H','01','12',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDAVQUDEMOZ0','50','H','01','13',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDAVQUDEMOZ0','50','H','01','14',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDAVQUDEMOZ0','50','H','01','15',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDAVQUDEMOZ0','50','H','01','16',NULL,'Position Level',NULL,NULL,'"Position Level"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDAVQUDEMOZ0','50','H','01','17',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDAVQUDEMOZ0','50','H','01','18',NULL,'Full Time - Part Time',NULL,NULL,'"Full Time - Part Time"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDAVQUDEMOZ0','50','H','01','19',NULL,'Home State',NULL,NULL,'"Home State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDAVQUDEMOZ0','50','H','01','20',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDAVQUDEMOZ0','50','H','01','21',NULL,'Business Unit',NULL,NULL,'"Business Unit"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDAVQUDEMOZ0','50','H','01','22',NULL,'Headcount Category',NULL,NULL,'"Headcount Category"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDAVQUDEMOZ0','50','H','01','23',NULL,'Subcategory',NULL,NULL,'"Subcategory"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDAVQUDEMOZ0','50','H','01','24',NULL,'Company',NULL,NULL,'"Company"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDAVQUDEMOZ0','50','D','10','1',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDAVQUDEMOZ0','50','D','10','2',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDAVQUDEMOZ0','50','D','10','3',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDAVQUDEMOZ0','50','D','10','4',NULL,'Title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDAVQUDEMOZ0','50','D','10','5',NULL,'Username',NULL,NULL,'"drvUsername"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDAVQUDEMOZ0','50','D','10','6',NULL,'Primary Email',NULL,NULL,'"drvPrimaryEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDAVQUDEMOZ0','50','D','10','7',NULL,'ManagerEmployeeID',NULL,NULL,'"drvManagerEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDAVQUDEMOZ0','50','D','10','8',NULL,'ManagerName',NULL,NULL,'"drvManagerName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDAVQUDEMOZ0','50','D','10','9',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDAVQUDEMOZ0','50','D','10','10',NULL,'TermDate',NULL,NULL,'"drvTermDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDAVQUDEMOZ0','50','D','10','11',NULL,'TermType',NULL,NULL,'"drvTermType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDAVQUDEMOZ0','50','D','10','12',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDAVQUDEMOZ0','50','D','10','13',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDAVQUDEMOZ0','50','D','10','14',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDAVQUDEMOZ0','50','D','10','15',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDAVQUDEMOZ0','50','D','10','16',NULL,'Position Level',NULL,NULL,'"drvPositionLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDAVQUDEMOZ0','50','D','10','17',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDAVQUDEMOZ0','50','D','10','18',NULL,'Full Time - Part Time',NULL,NULL,'"drvFullTimePartTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDAVQUDEMOZ0','50','D','10','19',NULL,'Home State',NULL,NULL,'"drvHomeState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDAVQUDEMOZ0','50','D','10','20',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDAVQUDEMOZ0','50','D','10','21',NULL,'Business Unit',NULL,NULL,'"drvBusinessUnit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDAVQUDEMOZ0','50','D','10','22',NULL,'Headcount Category',NULL,NULL,'"drvHeadcountCategory"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDAVQUDEMOZ0','50','D','10','23',NULL,'Subcategory',NULL,NULL,'"drvSubcategory"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDAVQUDEMOZ0','50','D','10','24',NULL,'Company',NULL,NULL,'"drvCompany"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDAVQUDEMO_20230626.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Quantum Demographic','202306269','EMPEXPORT','ONDEM_XOE',NULL,'EDAVQUDEMO',NULL,NULL,NULL,'202306269','Jun 26 2023  2:55PM','Jun 26 2023  2:55PM','202306261',NULL,'','','202306261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Quantum Demographic-Sched','202306269','EMPEXPORT','SCH_EDAVQU',NULL,'EDAVQUDEMO',NULL,NULL,NULL,'202306269','Jun 26 2023  2:55PM','Jun 26 2023  2:55PM','202306261',NULL,'','','202306261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Quantum Demographic-Test','202306269','EMPEXPORT','TEST_XOE',NULL,'EDAVQUDEMO',NULL,NULL,NULL,'202306269','Jun 26 2023  2:55PM','Jun 26 2023  2:55PM','202306261',NULL,'','','202306261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDAVQUDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDAVQUDEMO','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDAVQUDEMO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDAVQUDEMO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDAVQUDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDAVQUDEMO','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDAVQUDEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDAVQUDEMO','D10','dbo.U_EDAVQUDEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_EDAVQUDEMO_Audit
-----------

IF OBJECT_ID('U_EDAVQUDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_EDAVQUDEMO_Audit] (
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
-- Create table U_EDAVQUDEMO_AuditFields
-----------

IF OBJECT_ID('U_EDAVQUDEMO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EDAVQUDEMO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EDAVQUDEMO_drvTbl
-----------

IF OBJECT_ID('U_EDAVQUDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDAVQUDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeID] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvTitle] varchar(8000) NULL,
    [drvUsername] varchar(8000) NULL,
    [drvPrimaryEmail] varchar(8000) NULL,
    [drvManagerEmployeeID] varchar(256) NULL,
    [drvManagerName] varchar(8000) NULL,
    [drvHireDate] varchar(8000) NULL,
    [drvTermDate] varchar(8000) NULL,
    [drvTermType] varchar(8000) NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvDepartment] varchar(8000) NULL,
    [drvLocation] varchar(8000) NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvPositionLevel] varchar(8000) NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvFullTimePartTime] varchar(8000) NULL,
    [drvHomeState] varchar(8000) NULL,
    [drvGender] varchar(8000) NULL,
    [drvBusinessUnit] varchar(1) NOT NULL,
    [drvHeadcountCategory] varchar(1) NOT NULL,
    [drvSubcategory] varchar(1) NOT NULL,
    [drvCompany] varchar(8000) NULL
);

-----------
-- Create table U_EDAVQUDEMO_EEList
-----------

IF OBJECT_ID('U_EDAVQUDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EDAVQUDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDAVQUDEMO_File
-----------

IF OBJECT_ID('U_EDAVQUDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EDAVQUDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDAVQUDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Davis-Standard 

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 06/26/2023
Service Request Number: TekP-2023-05-24-01

Purpose: Quantum Demographic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDAVQUDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDAVQUDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDAVQUDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDAVQUDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDAVQUDEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDAVQUDEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDAVQUDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDAVQUDEMO', 'SCH_EDAVQU';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDAVQUDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDAVQUDEMO';

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
    DELETE FROM dbo.U_EDAVQUDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDAVQUDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EDAVQUDEMO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDAVQUDEMO_AuditFields;
    CREATE TABLE dbo.U_EDAVQUDEMO_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EDAVQUDEMO_AuditFields VALUES ('EmpComp','EecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EDAVQUDEMO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EDAVQUDEMO_Audit;
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
    INTO dbo.U_EDAVQUDEMO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EDAVQUDEMO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDAVQUDEMO_Audit ON dbo.U_EDAVQUDEMO_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EDAVQUDEMO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EDAVQUDEMO_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDAVQUDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDAVQUDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDAVQUDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = dbo.dsi_fnlib_AddDoubleQuotes(EecEmpNo)
        ,drvFirstName = dbo.dsi_fnlib_AddDoubleQuotes(EepNamePreferred)
        ,drvLastName = dbo.dsi_fnlib_AddDoubleQuotes(EepNameLast)
        ,drvTitle = dbo.dsi_fnlib_AddDoubleQuotes(JbcDesc)
        ,drvUsername = dbo.dsi_fnlib_AddDoubleQuotes(EepAddressEMail)
        ,drvPrimaryEmail = dbo.dsi_fnlib_AddDoubleQuotes(EepAddressEMail)
        ,drvManagerEmployeeID = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'EmpNo')
        ,drvManagerName = dbo.dsi_fnlib_AddDoubleQuotes(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst') + '' + dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast')  + '' +dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Suffix') )
        ,drvHireDate = dbo.dsi_fnlib_AddDoubleQuotes(CONVERT(VARCHAR,EecDateOfLastHire, 101))
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' and EecTermreason <> 'TRO' THEN dbo.dsi_fnlib_AddDoubleQuotes(CONVERT(VARCHAR,EecDateOfTermination, 101)) END -- AuditDate
        ,drvTermType = dbo.dsi_fnlib_AddDoubleQuotes(CASE WHEN  EecTermType = 'I' THEN 'Involuntary' ELSE 'Voluntary' END)
        ,drvStatus = ''--coddesc EecEmplStatus from EMPLOYEESTATUS
        ,drvDepartment = dbo.dsi_fnlib_AddDoubleQuotes(o2.Orgdesc)
        ,drvLocation = dbo.dsi_fnlib_AddDoubleQuotes(LocDesc)
        ,drvDivision = '' --pcf.Employment_BHeadcountCategory
        ,drvPositionLevel = dbo.dsi_fnlib_AddDoubleQuotes(CASE WHEN EecSalaryOrHourly = 'S' then 'Salaried' ELSE 'Hourly' END)
        ,drvEmployeeType = '' --coddesc where codtable = EMPTYPE EecEEType
        ,drvFullTimePartTime = dbo.dsi_fnlib_AddDoubleQuotes(CASE WHEN EecFullTimeOrPartTime = 'F' then 'Full Time' else 'Part Time' END)
        ,drvHomeState = dbo.dsi_fnlib_AddDoubleQuotes(EepAddressState)
        ,drvGender = dbo.dsi_fnlib_AddDoubleQuotes(EepGender)
        ,drvBusinessUnit = ''---pcf.Employment_BBusinessUnit
        ,drvHeadcountCategory = '' --pcf.Employment_BHeadcountCategory
        ,drvSubcategory = '' --pcf.Employment_BSubCategory
        ,drvCompany = dbo.dsi_fnlib_AddDoubleQuotes(cmpcompanyname)
    INTO dbo.U_EDAVQUDEMO_drvTbl
    FROM dbo.U_EDAVQUDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
     LEFT JOIN dbo.OrgLevel o2 with (nolock) 
        ON eecorglvl2 = o2.orgcode 
        and o2.orglvl = '2'   
     JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
      LEFT JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation

        Where (eecemplstatus <> 'T'  OR  (eecemplstatus =  'T' and eecTermReason <> 'TRO' and eecDateofTermination between (DATEADD( D,-30, @enddate)) and @enddate) )

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
ALTER VIEW dbo.dsi_vwEDAVQUDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDAVQUDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EDAVQUDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202306191'
       ,expStartPerControl     = '202306191'
       ,expLastEndPerControl   = '202306269'
       ,expEndPerControl       = '202306269'
WHERE expFormatCode = 'EDAVQUDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDAVQUDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDAVQUDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDAVQUDEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDAVQUDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDAVQUDEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDAVQUDEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDAVQUDEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDAVQUDEMO', 'UseFileName', 'V', 'Y'


-- End ripout