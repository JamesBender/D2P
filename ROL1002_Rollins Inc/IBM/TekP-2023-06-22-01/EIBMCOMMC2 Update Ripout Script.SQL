/**********************************************************************************

EIBMCOMMC2: IBM Commissions ExportV2

FormatCode:     EIBMCOMMC2
Project:        IBM Commissions ExportV2
Client ID:      ROL1002
Date/time:      2023-07-21 05:57:05.423
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
ExportPath:    \\us.saas\E0\data_exchange\ROL1002\Exports\
TestPath:      \\us.saas\E4\Public\ROL1002\Exports\IBMCommissions\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIBMCOMMC2_SavePath') IS NOT NULL DROP TABLE dbo.U_EIBMCOMMC2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIBMCOMMC2'


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
WHERE FormatCode = 'EIBMCOMMC2'
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
WHERE ExpFormatCode = 'EIBMCOMMC2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIBMCOMMC2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIBMCOMMC2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIBMCOMMC2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIBMCOMMC2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIBMCOMMC2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIBMCOMMC2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIBMCOMMC2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIBMCOMMC2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIBMCOMMC2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIBMCOMMC2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIBMCOMMC2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIBMCOMMC2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIBMCOMMC2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIBMCOMMC2];
GO
IF OBJECT_ID('U_EIBMCOMMC2_File') IS NOT NULL DROP TABLE [dbo].[U_EIBMCOMMC2_File];
GO
IF OBJECT_ID('U_EIBMCOMMC2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIBMCOMMC2_EEList];
GO
IF OBJECT_ID('U_EIBMCOMMC2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIBMCOMMC2_drvTbl];
GO
IF OBJECT_ID('U_EIBMCOMMC2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIBMCOMMC2_AuditFields];
GO
IF OBJECT_ID('U_EIBMCOMMC2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIBMCOMMC2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIBMCOMMC2','IBM Commissions ExportV2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EWFGCW0000C0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWFGCW0000C0','50','H','01','1',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWFGCW0000C0','50','H','01','2',NULL,'Company Code',NULL,NULL,'"Company Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWFGCW0000C0','50','H','01','3',NULL,'Company Name',NULL,NULL,'"Company Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWFGCW0000C0','50','H','01','4',NULL,'Org Level 1',NULL,NULL,'"Org Level 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWFGCW0000C0','50','H','01','5',NULL,'Org Level 1 Description',NULL,NULL,'"Org Level 1 Description"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWFGCW0000C0','50','H','01','6',NULL,'Org Level 2',NULL,NULL,'"Org Level 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWFGCW0000C0','50','H','01','7',NULL,'Org Level 2 Description',NULL,NULL,'"Org Level 2 Description"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWFGCW0000C0','50','H','01','8',NULL,'Job Code',NULL,NULL,'"Job Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWFGCW0000C0','50','H','01','9',NULL,'EmployeeName',NULL,NULL,'"EmployeeName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWFGCW0000C0','50','H','01','10',NULL,'EmailID',NULL,NULL,'"EmailID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWFGCW0000C0','50','H','01','11',NULL,'PlanID',NULL,NULL,'"PlanID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWFGCW0000C0','50','H','01','12',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWFGCW0000C0','50','H','01','13',NULL,'Location Name',NULL,NULL,'"Location Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWFGCW0000C0','50','H','01','13',NULL,'JobRole',NULL,NULL,'"JobRole"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWFGCW0000C0','50','H','01','14',NULL,'ManagerEmployeeID',NULL,NULL,'"ManagerEmployeeID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWFGCW0000C0','50','H','01','15',NULL,'ManagerName',NULL,NULL,'"ManagerName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWFGCW0000C0','50','H','01','16',NULL,'ManagerEmail',NULL,NULL,'"ManagerEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWFGCW0000C0','50','H','01','17',NULL,'ManagerLocation',NULL,NULL,'"ManagerLocation"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWFGCW0000C0','50','H','01','18',NULL,'ManagerJobRole',NULL,NULL,'"ManagerJobRole"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWFGCW0000C0','50','H','01','19',NULL,'EmployeeStartDate',NULL,NULL,'"EmployeeStartDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWFGCW0000C0','50','H','01','20',NULL,'EmployeeEndDate',NULL,NULL,'"EmployeeEndDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWFGCW0000C0','50','H','01','21',NULL,'EmploymentStatus',NULL,NULL,'"EmploymentStatus"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWFGCW0000C0','50','H','01','22',NULL,'Weekly Draw',NULL,NULL,'"Draw"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWFGCW0000C0','50','H','01','25',NULL,'PayFrequency',NULL,NULL,'"PayFrequency"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWFGCW0000C0','50','H','01','25',NULL,'Pay Group',NULL,NULL,'"Pay Group"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWFGCW0000C0','50','H','01','26',NULL,'Pay Group Description',NULL,NULL,'"Pay Group Description"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWFGCW0000C0','50','H','01','27',NULL,'Company Car',NULL,NULL,'"Company Car"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWFGCW0000C0','50','H','01','28',NULL,'ID',NULL,NULL,'"ID"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWFGCW0000C0','50','D','10','1',NULL,'EmployeeID',NULL,NULL,'"drvEmpNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWFGCW0000C0','50','D','10','2',NULL,'Company Code',NULL,NULL,'"drvImportCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWFGCW0000C0','50','D','10','3',NULL,'Company Name',NULL,NULL,'"drvCompanyName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWFGCW0000C0','50','D','10','4',NULL,'Org Level 1',NULL,NULL,'"drvOrgLvl1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWFGCW0000C0','50','D','10','5',NULL,'Org Level 1 Description',NULL,NULL,'"drvDesc1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWFGCW0000C0','50','D','10','6',NULL,'Org Level 2',NULL,NULL,'"drvOrgLvl2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWFGCW0000C0','50','D','10','7',NULL,'Org Level 2 Description',NULL,NULL,'"drvDesc2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWFGCW0000C0','50','D','10','8',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWFGCW0000C0','50','D','10','9',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWFGCW0000C0','50','D','10','10',NULL,'EmailID',NULL,NULL,'"drvAddressEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWFGCW0000C0','50','D','10','11',NULL,'PlanID',NULL,NULL,'"drvUDField03"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWFGCW0000C0','50','D','10','12',NULL,'Location',NULL,NULL,'"drvOrgLvl3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWFGCW0000C0','50','D','10','13',NULL,'Location Name',NULL,NULL,'"drvorgDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWFGCW0000C0','50','D','10','13',NULL,'JobRole',NULL,NULL,'"drvDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWFGCW0000C0','50','D','10','14',NULL,'ManagerEmployeeID',NULL,NULL,'"drvSupID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWFGCW0000C0','50','D','10','15',NULL,'ManagerName',NULL,NULL,'"drvSupName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWFGCW0000C0','50','D','10','16',NULL,'ManagerEmail',NULL,NULL,'"drvSupEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWFGCW0000C0','50','D','10','17',NULL,'ManagerLocation',NULL,NULL,'"drvSupLoc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWFGCW0000C0','50','D','10','18',NULL,'ManagerJobRole',NULL,NULL,'"drvSupJob"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWFGCW0000C0','50','D','10','19',NULL,'EmployeeStartDate',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWFGCW0000C0','50','D','10','20',NULL,'EmployeeEndDate',NULL,NULL,'"drvDateofTermination"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWFGCW0000C0','50','D','10','21',NULL,'EmploymentStatus',NULL,NULL,'"drvEmplStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWFGCW0000C0','50','D','10','22',NULL,'Weekly Draw',NULL,NULL,'"drvUDField05"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWFGCW0000C0','50','D','10','25',NULL,'PayFrequency',NULL,NULL,'"drvPayPeriod"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWFGCW0000C0','50','D','10','25',NULL,'Pay Group',NULL,NULL,'"drvPayGroup"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWFGCW0000C0','50','D','10','26',NULL,'Pay Group Description',NULL,NULL,'"drvprgDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWFGCW0000C0','50','D','10','27',NULL,'Company Car',NULL,NULL,'"drvcUDField21"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWFGCW0000C0','50','D','10','28',NULL,'ID',NULL,NULL,'"drvID"','(''UA''=''T'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'IBM Commissions ExportV2','201812219','EMPEXPORT','CHGSONLY','Dec 21 2018  6:25PM','EIBMCOMMC2',NULL,NULL,NULL,'201812219','Dec 21 2018 12:00AM','Dec 30 1899 12:00AM','201811011','8399',NULL,NULL,'201811011',dbo.fn_GetTimedKey(),NULL,'ESWEET',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201905169','EMPEXPORT','FULLFILE','May 16 2019 12:00AM','EIBMCOMMC2',NULL,NULL,NULL,'201905169','May 16 2019 12:00AM','Dec 30 1899 12:00AM','201905061','8361',NULL,NULL,'201905061',dbo.fn_GetTimedKey(),NULL,'GAMIDAALA',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202307169','EMPEXPORT','FULLFILTST','Jul 17 2023  1:56PM','EIBMCOMMC2',NULL,NULL,NULL,'202307169','Jul 16 2023 12:00AM','Dec 30 1899 12:00AM','202307101','9885',NULL,NULL,'202307101',dbo.fn_GetTimedKey(),NULL,'ESWEET',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202307209','EMPEXPORT','SCH_EIBMCO','Jul 20 2023 11:03PM','EIBMCOMMC2',NULL,NULL,NULL,'202307209','Nov  5 2018  5:33PM','Nov  5 2018  5:33PM','202307201',NULL,NULL,NULL,'202307201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','ExportPath','V','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','InitialSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','SubSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','TestPath','V','\\us.saas\E4\Public\ROL1002\Exports\IBMCommissions\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','UDESPath','C','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIBMCOMMC2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIBMCOMMC2','D10','dbo.U_EIBMCOMMC2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EIBMCOMMC2_Audit
-----------

IF OBJECT_ID('U_EIBMCOMMC2_Audit') IS NULL
CREATE TABLE [dbo].[U_EIBMCOMMC2_Audit] (
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
-- Create table U_EIBMCOMMC2_AuditFields
-----------

IF OBJECT_ID('U_EIBMCOMMC2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIBMCOMMC2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIBMCOMMC2_drvTbl
-----------

IF OBJECT_ID('U_EIBMCOMMC2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIBMCOMMC2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvEmpNo] char(9) NULL,
    [drvImportCode] char(10) NULL,
    [drvCompanyName] varchar(40) NULL,
    [drvOrgLvl1] varchar(10) NULL,
    [drvDesc1] varchar(25) NULL,
    [drvOrgLvl2] varchar(10) NULL,
    [drvDesc2] varchar(25) NULL,
    [drvJobCode] char(8) NULL,
    [drvName] varchar(8000) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvUDField03] char(10) NULL,
    [drvOrgLvl3] varchar(10) NULL,
    [drvorgDesc] varchar(25) NULL,
    [drvDesc] varchar(25) NOT NULL,
    [drvSupID] char(9) NULL,
    [drvSupName] varchar(8000) NULL,
    [drvSupEmail] varchar(50) NULL,
    [drvSupLoc] varchar(10) NULL,
    [drvSupJob] varchar(25) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvEmplStatus] char(1) NULL,
    [drvUDField05] varchar(25) NULL,
    [drvUDField021] char(1) NULL,
    [drvUDField22] char(1) NULL,
    [drvPayPeriod] varchar(12) NULL,
    [drvPayGroup] char(6) NULL,
    [drvprgDesc] varchar(25) NULL,
    [drvcUDField21] varchar(1) NULL,
    [drvID] char(12) NOT NULL
);

-----------
-- Create table U_EIBMCOMMC2_EEList
-----------

IF OBJECT_ID('U_EIBMCOMMC2_EEList') IS NULL
CREATE TABLE [dbo].[U_EIBMCOMMC2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIBMCOMMC2_File
-----------

IF OBJECT_ID('U_EIBMCOMMC2_File') IS NULL
CREATE TABLE [dbo].[U_EIBMCOMMC2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIBMCOMMC2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins, Inc.

Created By: Cyndi Diaz
Business Analyst: Patrick Clare
Create Date: 11/05/2018
Service Request Number: SR-2018-00207742

Purpose: IBM Commissions ExportV2

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        07/21/2023       TekP-2023-06-22-01 Add ID column to end of file
XXXX                XX/XX/2018     SR-2018-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIBMCOMMC2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIBMCOMMC2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIBMCOMMC2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIBMCOMMC2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIBMCOMMC2' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIBMCOMMC2', 'FULLFILTST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIBMCOMMC2', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIBMCOMMC2', 'CHGSONLY';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIBMCOMMC2', 'SCH_EIBMCO';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIBMCOMMC2', @AllObjects = 'Y', @IsWeb = 'N'
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
    SELECT @FormatCode = 'EIBMCOMMC2';

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
    DELETE FROM dbo.U_EIBMCOMMC2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIBMCOMMC2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIBMCOMMC2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIBMCOMMC2_AuditFields;
    CREATE TABLE dbo.U_EIBMCOMMC2_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('emppers','eepNameFirst');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('emppers','eepNameMiddle');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('emppers','eepNameLast');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('emppers','eepAddressEmail');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecDateOfLastHire');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecEmplStatus');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecJobCode');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecOrgLvl3');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecSupervisorID');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecUDField03');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecUDField05');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecUDField21');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','eecUDField22');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','EecPayPeriod');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','EecEmpNo');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','EecOrgLvl1');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','EecOrgLvl2');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','EecDateOfTermination');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('empcomp','EecPayGroup');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('company','CmpImportCode');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('company','CmpCompanyName');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('orglevel','OrgDesc');
    insert into dbo.U_EIBMCOMMC2_AuditFields values ('jobcode','JbcDesc');
     

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIBMCOMMC2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIBMCOMMC2_Audit;
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
    INTO dbo.U_EIBMCOMMC2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIBMCOMMC2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIBMCOMMC2_Audit ON dbo.U_EIBMCOMMC2_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    IF @ExportCode NOT LIKE 'FULLFIL%'
    BEGIN
        DELETE FROM dbo.U_EIBMCOMMC2_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EIBMCOMMC2_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIBMCOMMC2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIBMCOMMC2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIBMCOMMC2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvNameLast = EEP.EepNameLast
        ,drvNameFirst = EEP.EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EMP.EecEmpNo
        ,drvImportCode = cmpImportCode
        ,drvCompanyName = CmpCompanyName
        ,drvOrgLvl1 = EMP.EecOrgLvl1
        ,drvDesc1 = ORG1.orgDesc
        ,drvOrgLvl2 = EMP.EecOrgLvl2
        ,drvDesc2 = ORG2.orgDesc
        ,drvJobCode = EMP.EecJobCode
        ,drvName = CASE WHEN (ISNULL(EEP.eepNameSuffix, '') = '' OR EEP.eepNameSuffix = 'Z') THEN EEP.eepNameFirst + ' ' + SUBSTRING(ISNULL(EEP.eepNameMiddle, ''),1,1) + ' ' + EEP.eepNameLast
                        WHEN (ISNULL(EEP.eepNameSuffix, '') <> '' OR EEP.eepNameSuffix <> 'Z') THEN EEP.eepNameFirst + ' ' + SUBSTRING(ISNULL(EEP.eepNameMiddle, ''),1,1) + ' ' + EEP.eepNameLast + ', ' + REPLACE(EEP.eepNameSuffix, 'Z', '')
                    END
        ,drvAddressEmail = EEP.EepAddressEMail
        ,drvUDField03 = EMP.eecUDField03
        ,drvOrgLvl3 = EMP.EecOrgLvl3
        ,drvorgDesc = ORG3.orgDesc
        ,drvDesc = EJC.jbcDesc
        ,drvSupID = SUP.eecEmpNo
        ,drvSupName = CASE WHEN (ISNULL(SUPP.eepNameSuffix, '') = '' OR SUPP.eepNameSuffix = 'Z') THEN SUPP.eepNameFirst + ' ' + SUBSTRING(ISNULL(SUPP.eepNameMiddle, ''),1,1) + ' ' + SUPP.eepNameLast
                        WHEN (ISNULL(SUPP.eepNameSuffix, '') <> '' OR SUPP.eepNameSuffix <> 'Z') THEN SUPP.eepNameFirst + ' ' + SUBSTRING(ISNULL(SUPP.eepNameMiddle, ''),1,1) + ' ' + SUPP.eepNameLast + ', ' + REPLACE(SUPP.eepNameSuffix, 'Z', '')
                    END
        ,drvSupEmail = SUPP.EepAddressEMail
        ,drvSupLoc = SUP.eecOrgLvl3
        ,drvSupJob = SJC.jbcDesc
        ,drvDateOfLastHire = EMP.EecDateOfLastHire
        ,drvDateofTermination = CASE WHEN EMP.EecEmplStatus = 'T' THEN EMP.EecDateOfTermination END
        ,drvEmplStatus = EMP.EecEmplStatus
        ,drvUDField05 = EMP.eecUDField05
        ,drvUDField021 = EMP.eecUDField21
        ,drvUDField22 = EMP.eecUDField22
        ,drvPayPeriod = CASE WHEN EMP.EecPayPeriod = 'W' then 'Weekly'
                            WHEN EMP.EecPayPeriod = 'B' then 'Biweekly'
                            WHEN EMP.EecPayPeriod = 'S' then 'Semi-Monthly'
                        END
        ,drvPayGroup = EMP.eecPayGroup
        ,drvprgDesc = pgrDesc
        ,drvcUDField21 = CASE WHEN ISNULL(EMP.EecUDField21, '') <> '' THEN EMP.EecUDField21 ELSE 'N' END
        ,drvID = EEP.eepeeid
    INTO dbo.U_EIBMCOMMC2_drvTbl                --SELECT DISTINCT drveeid FROM U_EIBMCOMMC2_drvTbl
    FROM dbo.U_EIBMCOMMC2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EMP WITH (NOLOCK)
        ON EMP.EecEEID = xEEID 
        AND EMP.EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers EEP WITH (NOLOCK)
        ON EEP.EepEEID = xEEID
    JOIN dbo.JobCode EJC WITH (NOLOCK)
        ON EJC.JbcJobCode = EMP.EecJobCode
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EMP.EecPayGroup
    LEFT JOIN dbo.vw_int_OrgLevel ORG1 WITH (NOLOCK)
        ON ORG1.OrgCode = EMP.EecOrgLvl1
        AND orgLvl = '1'
    LEFT JOIN dbo.vw_int_OrgLevel ORG2 WITH (NOLOCK)
        ON ORG2.OrgCode = EMP.EecOrgLvl2
        AND ORG2.orgLvl = '2'
    LEFT JOIN dbo.vw_int_OrgLevel ORG3 WITH (NOLOCK)
        ON ORG3.OrgCode = EMP.EecOrgLvl3
        AND ORG3.orgLvl = '3'
    LEFT JOIN dbo.vw_int_EmpComp SUP WITH(NOLOCK)
        ON SUP.EecEEID = EMP.EecSupervisorID
        AND SUP.EecEmplStatus = 'A'
    LEFT JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.EepEEID = SUP.EecEEID
    LEFT JOIN dbo.JobCode SJC WITH (NOLOCK)
        ON SJC.JbcJobCode = SUP.EecJobCode
    WHERE cmpCompanyCode IN ('HYX', 'CPD', 'ORKIN','BANKS')
    AND ((@ExportCode NOT LIKE 'FULLFIL%' AND (EMP.EecEmplStatus <> 'T' OR (EMP.EecEmplStatus = 'T' AND EMP.EecTermReason NOT IN ('TRI','TRO')
                AND EMP.EecDateOfTermination >= DATEADD(DAY, -30, GETDATE()))))
             OR (@ExportCode LIKE 'FULLFIL%' AND EMP.EecEmplStatus = 'A'))
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'Rollins_IBMCommissions.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEIBMCOMMC2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EIBMCOMMC2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIBMCOMMC2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201810291'
       ,expStartPerControl     = '201810291'
       ,expLastEndPerControl   = '201811059'
       ,expEndPerControl       = '201811059'
WHERE expFormatCode = 'EIBMCOMMC2';



    --------JOB NAME: IBM Commissions ExportV2 (EIBMCOMMC2) - Daily, 12:33AM ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - IBM Commissions ExportV2 (EIBMCOMMC2) - Daily, 12:33AM ET'
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
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (EIBMCOMMC2)', 
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
WHERE expFormatCode = ''EIBMCOMMC2''
  AND expExportCode = ''SCH_EIBMCO'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (EIBMCOMMC2)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''EIBMCOMMC2'', ''SCH_EIBMCO'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily, 12:33AM ET',
            @enabled=1, 
            @freq_type=4, 
            @freq_interval=1,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20181105,
            @active_end_date=99991231,
            @active_start_time=003300,
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
CREATE VIEW dbo.dsi_vwEIBMCOMMC2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIBMCOMMC2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIBMCOMMC2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIBMCOMMC2'
   AND rpoParmType = 'expSystemID'


-- End ripout