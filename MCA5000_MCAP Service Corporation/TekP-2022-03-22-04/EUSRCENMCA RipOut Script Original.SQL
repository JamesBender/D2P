/**********************************************************************************

EUSRCENMCA: MCAP User Data Feed

FormatCode:     EUSRCENMCA
Project:        MCAP User Data Feed
Client ID:      MCA5000
Date/time:      2022-06-09 11:47:51.163
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    TWP
Server:         TW1WUP1DB03
Database:       ULTIPRO_WPMCAP
Web Filename:   MCA5000_AGD8Q_EEHISTORY_EUSRCENMCA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUSRCENMCA_SavePath') IS NOT NULL DROP TABLE dbo.U_EUSRCENMCA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUSRCENMCA'


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
WHERE FormatCode = 'EUSRCENMCA'
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
WHERE ExpFormatCode = 'EUSRCENMCA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUSRCENMCA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUSRCENMCA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUSRCENMCA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUSRCENMCA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUSRCENMCA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUSRCENMCA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUSRCENMCA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUSRCENMCA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUSRCENMCA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUSRCENMCA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUSRCENMCA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUSRCENMCA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUSRCENMCA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUSRCENMCA];
GO
IF OBJECT_ID('U_EUSRCENMCA_File') IS NOT NULL DROP TABLE [dbo].[U_EUSRCENMCA_File];
GO
IF OBJECT_ID('U_EUSRCENMCA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUSRCENMCA_EEList];
GO
IF OBJECT_ID('U_EUSRCENMCA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUSRCENMCA_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUSRCENMCA','MCAP User Data Feed','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EUSRCENMCAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUSRCENMCAZ0','50','H','01','1',NULL,NULL,NULL,NULL,'"EmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUSRCENMCAZ0','50','H','01','2',NULL,NULL,NULL,NULL,'"ManagerName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUSRCENMCAZ0','50','H','01','3',NULL,NULL,NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUSRCENMCAZ0','50','H','01','4',NULL,NULL,NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUSRCENMCAZ0','50','H','01','5',NULL,NULL,NULL,NULL,'"JobTitle"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUSRCENMCAZ0','50','H','01','6',NULL,NULL,NULL,NULL,'"CostCentre"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUSRCENMCAZ0','50','H','01','7',NULL,NULL,NULL,NULL,'"Company"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUSRCENMCAZ0','50','H','01','8',NULL,NULL,NULL,NULL,'"LocationID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUSRCENMCAZ0','50','H','01','9',NULL,NULL,NULL,NULL,'"PersonalEmailAddress"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUSRCENMCAZ0','50','H','01','10',NULL,NULL,NULL,NULL,'"HomePhone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUSRCENMCAZ0','50','H','01','11',NULL,NULL,NULL,NULL,'"CellPersonal"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUSRCENMCAZ0','50','H','01','12',NULL,NULL,NULL,NULL,'"CellPhoneWork"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUSRCENMCAZ0','50','H','01','13',NULL,NULL,NULL,NULL,'"EmploymentStatus"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUSRCENMCAZ0','50','H','01','14',NULL,NULL,NULL,NULL,'"EmploymentCategory"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUSRCENMCAZ0','50','H','01','15',NULL,NULL,NULL,NULL,'"EmployeeType"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUSRCENMCAZ0','50','H','01','16',NULL,NULL,NULL,NULL,'"EmployeeNumber"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUSRCENMCAZ0','50','H','01','17',NULL,NULL,NULL,NULL,'"LOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUSRCENMCAZ0','50','H','01','18',NULL,NULL,NULL,NULL,'"MLOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUSRCENMCAZ0','50','H','01','19',NULL,NULL,NULL,NULL,'"SupervisorID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUSRCENMCAZ0','50','H','01','20',NULL,NULL,NULL,NULL,'"SupervisorFirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUSRCENMCAZ0','50','H','01','21',NULL,NULL,NULL,NULL,'"SupervisorLastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUSRCENMCAZ0','50','H','01','22',NULL,NULL,NULL,NULL,'"Location 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUSRCENMCAZ0','50','H','01','23',NULL,NULL,NULL,NULL,'"Street Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUSRCENMCAZ0','50','H','01','24',NULL,NULL,NULL,NULL,'"Apt/Suite/Unit"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUSRCENMCAZ0','50','H','01','25',NULL,NULL,NULL,NULL,'"City 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUSRCENMCAZ0','50','H','01','26',NULL,NULL,NULL,NULL,'"State/Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUSRCENMCAZ0','50','H','01','27',NULL,NULL,NULL,NULL,'"Postal Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUSRCENMCAZ0','50','H','01','28',NULL,NULL,NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUSRCENMCAZ0','50','H','01','29',NULL,NULL,NULL,NULL,'"Seniority Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUSRCENMCAZ0','50','D','10','1',NULL,'EmployeeID',NULL,NULL,'"drvEmpID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUSRCENMCAZ0','50','D','10','2',NULL,'ManagerName',NULL,NULL,'"drvManagerName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUSRCENMCAZ0','50','D','10','3',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUSRCENMCAZ0','50','D','10','4',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUSRCENMCAZ0','100','D','10','5',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUSRCENMCAZ0','50','D','10','6',NULL,'CostCentre',NULL,NULL,'"drvCostCentre"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUSRCENMCAZ0','50','D','10','7',NULL,'Company',NULL,NULL,'"drvCompany"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUSRCENMCAZ0','50','D','10','8',NULL,'LocationID',NULL,NULL,'"drvLocationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUSRCENMCAZ0','50','D','10','9',NULL,'PersonalEmailAddress',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUSRCENMCAZ0','50','D','10','10',NULL,'HomePhone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUSRCENMCAZ0','50','D','10','11',NULL,'CellPersonal',NULL,NULL,'"drvCellPersonal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUSRCENMCAZ0','50','D','10','12',NULL,'CellPhoneWork',NULL,NULL,'"drvCellPhoneWork"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUSRCENMCAZ0','50','D','10','13',NULL,'EmploymentStatus',NULL,NULL,'"drvEmplStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUSRCENMCAZ0','50','D','10','14',NULL,'EmploymentCategory',NULL,NULL,'"drvEmplCategory"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUSRCENMCAZ0','50','D','10','15',NULL,'EmployeeType',NULL,NULL,'"drvEEType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUSRCENMCAZ0','50','D','10','16',NULL,'EmployeeNumber',NULL,NULL,'"drvEENumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUSRCENMCAZ0','50','D','10','17',NULL,'LOB',NULL,NULL,'"drvLOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUSRCENMCAZ0','50','D','10','18',NULL,'MLOB',NULL,NULL,'"drvMLOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUSRCENMCAZ0','50','D','10','19',NULL,'SupervisorID',NULL,NULL,'"drvSupervisorID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUSRCENMCAZ0','50','D','10','20',NULL,'SupervisorFirstName',NULL,NULL,'"drvSupervisorFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUSRCENMCAZ0','50','D','10','21',NULL,'SupervisorLastName',NULL,NULL,'"drvSupervisorLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUSRCENMCAZ0','50','D','10','22',NULL,'SupervisorLastName',NULL,NULL,'"drvLocation2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUSRCENMCAZ0','50','D','10','23',NULL,'SupervisorLastName',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUSRCENMCAZ0','50','D','10','24',NULL,'SupervisorLastName',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUSRCENMCAZ0','50','D','10','25',NULL,'SupervisorLastName',NULL,NULL,'"drvCity2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUSRCENMCAZ0','50','D','10','26',NULL,'SupervisorLastName',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUSRCENMCAZ0','50','D','10','27',NULL,'SupervisorLastName',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUSRCENMCAZ0','50','D','10','28',NULL,'SupervisorLastName',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUSRCENMCAZ0','50','D','10','29',NULL,'SupervisorLastName',NULL,NULL,'"drvSeniority"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUSRCENMCA_20220609.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',RC4XC,RC6RM,RC6UP,1IT3K,RC5QD,1ITJ1,RJFGO,01KVU,01L83',NULL,NULL,NULL,'MCAP User File Friday','201912129','EMPEXPORT','MCAPUSRFR',NULL,'EUSRCENMCA',NULL,NULL,NULL,'202206039',NULL,NULL,'202206021',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',RC4XC,RC6RM,RC6UP,1IT3K,RC5QD,1ITJ1,RJFGO,01KVU,01L83',NULL,NULL,NULL,'MCAP USER FILE Thursday','201912129','EMPEXPORT','MCAPUSRTH',NULL,'EUSRCENMCA',NULL,NULL,NULL,'202206029',NULL,NULL,'202206011',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',RC4XC,RC6RM,RC6UP,1IT3K,RC5QD,1ITJ1,RJFGO,01KVU,01L83',NULL,NULL,NULL,'MCAP USER FILE Wednesday','201912129','EMPEXPORT','MCAPUSRW',NULL,'EUSRCENMCA',NULL,NULL,NULL,'202206089',NULL,NULL,'202206071',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',RC4XC,RC6RM,RC6UP,1IT3K,RC5QD,1ITJ1,RJFGO,01KVU,01L83',NULL,NULL,NULL,'MCAP USER FILE Tuesday','201912129','EMPEXPORT','MCPUSRT',NULL,'EUSRCENMCA',NULL,NULL,NULL,'202206079',NULL,NULL,'202206061',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MCAP User Data Feed','201910089','EMPEXPORT','ONDEMAND','Nov 15 2019 12:00AM','EUSRCENMCA',NULL,NULL,NULL,'201910089','Oct  8 2019 12:00AM','Dec 30 1899 12:00AM','201910081',NULL,'','','201910081',dbo.fn_GetTimedKey(),NULL,'ULTI_WPMCAP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',RC4XC,RC6RM,RC6UP,1IT3K,RC5QD,1ITJ1,RJFGO,01KVU,01L83',NULL,NULL,NULL,'Scheduled Session - MON','201910089','EMPEXPORT','SCHEDULED','Jul 27 2021 10:01AM','EUSRCENMCA',NULL,NULL,NULL,'202206069','Oct  8 2019 12:00AM','Dec 30 1899 12:00AM','202206051','1588','','','201910081',dbo.fn_GetTimedKey(),NULL,'ULTI_WPMCAP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','RC4XC,RC6RM,RC6UP,1IT3K,RC5QD,1ITJ1,RJFGO',NULL,NULL,NULL,'Test Purposes Only','202106301','EMPEXPORT','TEST','Aug  2 2021  9:49AM','EUSRCENMCA',NULL,NULL,NULL,'202106301','Jun 30 2021 12:00AM','Jun 30 2021 12:00AM','202106301','1588','','','202106301',dbo.fn_GetTimedKey(),NULL,'ULTI_WPMCAP',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSRCENMCA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSRCENMCA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSRCENMCA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSRCENMCA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUSRCENMCA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUSRCENMCA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUSRCENMCA','D10','dbo.U_EUSRCENMCA_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EUSRCENMCA_drvTbl
-----------

IF OBJECT_ID('U_EUSRCENMCA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUSRCENMCA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmpID] char(10) NULL,
    [drvManagerName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvCostCentre] varchar(10) NULL,
    [drvCompany] char(5) NULL,
    [drvLocationID] char(6) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvCellPersonal] varchar(50) NULL,
    [drvCellPhoneWork] varchar(50) NULL,
    [drvEmplStatus] char(1) NULL,
    [drvEmplCategory] char(1) NULL,
    [drvEEType] char(3) NULL,
    [drvEENumber] char(9) NULL,
    [drvLOB] varchar(8000) NULL,
    [drvMLOB] varchar(8000) NULL,
    [drvSupervisorID] char(10) NULL,
    [drvSupervisorFName] varchar(100) NULL,
    [drvSupervisorLName] varchar(100) NULL,
    [drvLocation2] varchar(4) NOT NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity2] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] varchar(3) NULL,
    [drvSeniority] varchar(30) NULL
);

-----------
-- Create table U_EUSRCENMCA_EEList
-----------

IF OBJECT_ID('U_EUSRCENMCA_EEList') IS NULL
CREATE TABLE [dbo].[U_EUSRCENMCA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUSRCENMCA_File
-----------

IF OBJECT_ID('U_EUSRCENMCA_File') IS NULL
CREATE TABLE [dbo].[U_EUSRCENMCA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUSRCENMCA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MCAP Service Corporation

Created By: Guido Pozo
Business Analyst: Michael Christopher
Create Date: 10/08/2019
Service Request Number: MCA5000-2019-00240541

Purpose: MCAP User Data Feed  

Revision History
----------------
Update By           Date           Request Num        Desc
David Miller       06/30/2021     SR-2021-00322562   Added columns for Location 2, Street Address, Apt, City 2, State, Country, Seniority Date

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUSRCENMCA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUSRCENMCA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUSRCENMCA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUSRCENMCA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUSRCENMCA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUSRCENMCA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUSRCENMCA', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUSRCENMCA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUSRCENMCA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUSRCENMCA';

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
    DELETE FROM dbo.U_EUSRCENMCA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUSRCENMCA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
/*
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EUSRCENMCA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUSRCENMCA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUSRCENMCA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUSRCENMCA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUSRCENMCA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EUSRCENMCA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUSRCENMCA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_EUSRCENMCA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUSRCENMCA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EUSRCENMCA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

*/
    DELETE dbo.U_EUSRCENMCA_EEList 
    FROM dbo.U_EUSRCENMCA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    WHERE eecPayGroup='TEST'

        DELETE dbo.U_EUSRCENMCA_EEList 
    FROM dbo.U_EUSRCENMCA_EEList WITH (NOLOCK)
    JOIN dbo.Emppers WITH (NOLOCK)
        ON EepEEID = xEEID 
    WHERE eepnamelast='TEST'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUSRCENMCA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUSRCENMCA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUSRCENMCA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpID = EecUDField11
        ,drvManagerName = --Case when EecUDField04 is not null then dbo.fn_AddDoubleQuotes(EecUDField04)    
                                --else 
                                dbo.fn_AddDoubleQuotes( super.lname + ', ' + super.fname + Case when super.mname is not null then '' + super.mname else '' end )
                            --End
        ,drvFirstName =dbo.fn_AddDoubleQuotes( EepNameFirst )
        ,drvLastName = dbo.fn_AddDoubleQuotes( EepNameLast )
        ,drvJobTitle = dbo.fn_AddDoubleQuotes( jbcLongdesc)    --eecJobTitle )
        ,drvCostCentre = eecOrgLvl3        --dbo.fn_AddDoubleQuotes( O3.orgdesc )
        ,drvCompany = cmpcompanycode
        ,drvLocationID = EecLocation
        ,drvEmailAddress = EepAddressEmailAlternate
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvCellPersonal = cell.phone
        ,drvCellPhoneWork = EecPhoneBusinessNumber
        ,drvEmplStatus = EecEmplStatus
        ,drvEmplCategory = EecFullTimeOrPartTime
        ,drvEEType = EecEEType
        ,drvEENumber = EecEmpno
        ,drvLOB = dbo.fn_AddDoubleQuotes( O2.orgdesc )
        ,drvMLOB = dbo.fn_AddDoubleQuotes( O1.orgdesc )
        ,drvSupervisorID = super.IT_Num    --  super.EmpNo    --''--MgrID.mID    --super.EmpNo        -- EecUDField11    for Supervisor         --'M-' + ltrim(empno)
        ,drvSupervisorFName = super.Fname    --Case when isnull(EecUDField04,'')<>'' then left(rtrim(vw_int_EmpComp.EecUDField04),charindex(',',rtrim(vw_int_EmpComp.EecUDField04))-1) End --MgrID.fname    --super.Fname
        ,drvSupervisorLName = super.lname    --Case when isnull(EecUDField04,'')<>'' then substring(rtrim(vw_int_EmpComp.EecUDField04),charindex(',',rtrim(vw_int_EmpComp.EecUDField04))+1,len(rtrim(vw_int_EmpComp.EecUDField04))) end    --MgrID.lname    --super.LName
        ,drvLocation2 = 'Home' --DM 6/30/21
        ,drvAddress1 = REPLACE(EepAddressLine1,',','') --DM 6/30/21
        ,drvAddress2 = REPLACE(EepAddressLine2,',','') --DM 6/30/21
        ,drvCity2 = EepAddressCity --DM 6/30/21
        ,drvState = EepAddressState --DM 6/30/21
        ,drvZipCode = EepAddressZipCode --DM 6/30/21
        ,drvCountry = CASE WHEN EepAddressCountry = 'CAN' THEN 'CA' ELSE EepAddressCountry END --DM 6/30/21
        ,drvSeniority = convert(varchar, EecDateOfSeniority, 23) --DM 6/30/21
    INTO dbo.U_EUSRCENMCA_drvTbl
    FROM dbo.U_EUSRCENMCA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --supervisor info -same Coid
    left join (select eepEEID seeid, b.eeccoid scoid,eepSSN ssn,LEFT(ISNULL(eepnameMiddle,''),1) mname,eepnamefirst fname, eepnamelast lname, eepAddressEMail email,vw_int_EmpComp.eecsupervisorid, b.eeceeid, b.eecempno empno, b.EecPhoneBusinessNumber workphone 
                ,b.EecUDField11 IT_Num    
                from vw_int_EmpComp 
                    join vw_int_EmpComp b on b.eeceeid = vw_int_EmpComp.eecsupervisorid
    join emppers on emppers.eepeeid = b.eeceeid) super on super.sEEID = vw_int_EmpComp.eecSupervisorID --and super.scoid=vw_int_EmpComp.eeccoid

    LEFT JOIN (select efoeeid eeid, auditkey audkey, efophonetype ptype, efophonenumber phone
                from empmphon) cell on cell.eeid = xeeid and cell.ptype = 'CEL'
                and cell.audkey = (select max(auditkey) from empmphon where efophonetype = 'CEL' and efoeeid = xeeid)
     left join vw_int_OrgLevel o1 with (nolock) on eecorglvl1 = o1.orgcode and o1.orglvl = '1'
     left join vw_int_OrgLevel o2 with (nolock) on eecorglvl2 = o2.orgcode and o2.orglvl = '2'
     left join vw_int_OrgLevel o3 with (nolock) on eecorglvl3 = o3.orgcode and o3.orglvl = '3'
     left join vw_int_OrgLevel o4 with (nolock) on eecorglvl4 = o4.orgcode and o4.orglvl = '4'
     Join company on cmpCoid = eeccoid

--     LEFT JOIN( Select eecempno mID,eepNameLast lname,eepNameFirst fname from  emppers 
--     join vw_int_EmpComp on eepeeid = eeceeid and eecemplstatus='A') MgrID on MgrID.lname=substring(rtrim(vw_int_EmpComp.EecUDField04),charindex(',',rtrim(vw_int_EmpComp.EecUDField04))+1,len(rtrim(vw_int_EmpComp.EecUDField04))) and MgrID.fname = left(rtrim(vw_int_EmpComp.EecUDField04),charindex(',',rtrim(vw_int_EmpComp.EecUDField04))-1) 


    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EUSRCENMCA_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EUSRCENMCA_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EUSRCENMCA_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUSRCENMCA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUSRCENMCA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUSRCENMCA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001071'
       ,expStartPerControl     = '202001071'
       ,expLastEndPerControl   = '202001089'
       ,expEndPerControl       = '202001089'
WHERE expFormatCode = 'EUSRCENMCA' and ExpExportCode='TEST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUSRCENMCA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUSRCENMCA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUSRCENMCA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUSRCENMCA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUSRCENMCA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUSRCENMCA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUSRCENMCA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUSRCENMCA', 'UseFileName', 'V', 'Y'


-- End ripout