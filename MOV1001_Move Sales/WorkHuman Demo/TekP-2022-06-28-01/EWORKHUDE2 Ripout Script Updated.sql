/**********************************************************************************

EWORKHUDE2: Work Human Demo ExportV2

FormatCode:     EWORKHUDE2
Project:        Work Human Demo ExportV2
Client ID:      MOV1001
Date/time:      2023-12-14 11:24:50.900
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N33
Server:         N3SUP3DB01
Database:       ULTIPRO_MVS
Web Filename:   MOV1001_M3D41_EEHISTORY_EWORKHUDE2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWORKHUDE2_SavePath') IS NOT NULL DROP TABLE dbo.U_EWORKHUDE2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWORKHUDE2'


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
WHERE FormatCode = 'EWORKHUDE2'
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
WHERE ExpFormatCode = 'EWORKHUDE2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWORKHUDE2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWORKHUDE2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWORKHUDE2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWORKHUDE2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWORKHUDE2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWORKHUDE2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWORKHUDE2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWORKHUDE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWORKHUDE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWORKHUDE2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWORKHUDE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWORKHUDE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWORKHUDE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKHUDE2];
GO
IF OBJECT_ID('U_EWORKHUDE2_File') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDE2_File];
GO
IF OBJECT_ID('U_EWORKHUDE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDE2_EEList];
GO
IF OBJECT_ID('U_EWORKHUDE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDE2_drvTbl];
GO
IF OBJECT_ID('U_EWORKHUDE2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDE2_AuditFields];
GO
IF OBJECT_ID('U_EWORKHUDE2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EWORKHUDE2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWORKHUDE2','Work Human Demo ExportV2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EV9QY8000020','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EV9QY8000020','50','H','01','1',NULL,'Unique ID',NULL,NULL,'"Unique ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EV9QY8000020','50','H','01','2',NULL,'Login ID',NULL,NULL,'"Login ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EV9QY8000020','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EV9QY8000020','50','H','01','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EV9QY8000020','50','H','01','5',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EV9QY8000020','50','H','01','6',NULL,'Function',NULL,NULL,'"Function"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EV9QY8000020','50','H','01','7',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EV9QY8000020','50','H','01','8',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EV9QY8000020','50','H','01','9',NULL,'Manager ID',NULL,NULL,'"Manager ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EV9QY8000020','50','H','01','10',NULL,'Admin',NULL,NULL,'"Admin"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EV9QY8000020','50','H','01','11',NULL,'Cost Center',NULL,NULL,'"Cost Center"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EV9QY8000020','50','H','01','12',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EV9QY8000020','50','H','01','13',NULL,'Job Level',NULL,NULL,'"Job Level"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EV9QY8000020','50','H','01','14',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EV9QY8000020','50','H','01','15',NULL,'Alternate Title',NULL,NULL,'"Alternate Title"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EV9QY8000020','50','H','01','16',NULL,'Approver 2',NULL,NULL,'"Approver 2"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EV9QY8000020','50','H','01','17',NULL,'Approver 3',NULL,NULL,'"Approver 3"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EV9QY8000020','50','H','01','18',NULL,'Revenue Org Participants',NULL,NULL,'"Revenue Org Participants"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EV9QY8000020','50','H','01','19',NULL,'Revenue Org Nominators',NULL,NULL,'"Revenue Org Nominators"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EV9QY8000020','50','H','01','20',NULL,'Pay Group',NULL,NULL,'"Pay Group"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EV9QY8000020','50','H','01','21',NULL,'HRBP',NULL,NULL,'"HRBP"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EV9QY8000020','50','H','01','22',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EV9QY8000020','50','H','01','23',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EV9QY8000020','50','H','01','24',NULL,'Revenue Org Approver',NULL,NULL,'"Revenue Org Approver"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EV9QY8000020','50','H','01','25',NULL,'Customer Care Approver',NULL,NULL,'"Customer Care Approver"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EV9QY8000020','50','D','10','1',NULL,'Unique ID',NULL,NULL,'"drvUniqueId"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EV9QY8000020','50','D','10','2',NULL,'Login ID',NULL,NULL,'"drvLoginId"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EV9QY8000020','50','D','10','3',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EV9QY8000020','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EV9QY8000020','50','D','10','5',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EV9QY8000020','50','D','10','6',NULL,'Function',NULL,NULL,'"drvFunc"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EV9QY8000020','50','D','10','7',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EV9QY8000020','50','D','10','8',NULL,'Hire Date',NULL,NULL,'"drvHireDt"','(''UD101''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EV9QY8000020','50','D','10','9',NULL,'Manager ID',NULL,NULL,'"drvManagerId"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EV9QY8000020','50','D','10','10',NULL,'Admin',NULL,NULL,'"drvAdmin"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EV9QY8000020','50','D','10','11',NULL,'Cost Center',NULL,NULL,'"drvCostCent"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EV9QY8000020','50','D','10','12',NULL,'Location Code',NULL,NULL,'"drvLocCode"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EV9QY8000020','50','D','10','13',NULL,'Job Level',NULL,NULL,'"drvJobLvl"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EV9QY8000020','50','D','10','14',NULL,'Employment Type',NULL,NULL,'"drvEmpType"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EV9QY8000020','50','D','10','15',NULL,'Alternate Title',NULL,NULL,'"drvAlternateTitle"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EV9QY8000020','50','D','10','16',NULL,'Approver 2',NULL,NULL,'"drvApp2"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EV9QY8000020','50','D','10','17',NULL,'Approver 3',NULL,NULL,'"drvApp3"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EV9QY8000020','50','D','10','18',NULL,'Revenue Org Participants',NULL,NULL,'"drvRevOrgPart"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EV9QY8000020','50','D','10','19',NULL,'Revenue Org Nominators',NULL,NULL,'"drvRevOrgNom"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EV9QY8000020','50','D','10','20',NULL,'Pay Group Description',NULL,NULL,'"drvPayGroupDesc"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EV9QY8000020','50','D','10','21',NULL,'HRBP',NULL,NULL,'"drvHBRP"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EV9QY8000020','50','D','10','22',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EV9QY8000020','50','D','10','23',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EV9QY8000020','50','D','10','24',NULL,'Revenue Org Approver',NULL,NULL,'"drvRevenueOrgApprov"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EV9QY8000020','50','D','10','25',NULL,'Customer Care Approver',NULL,NULL,'"drvCustomerCareApprov"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWORKHUDE2_20231214.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Work Human Demo ExportV2','202307251','EMPEXPORT','ONDEM_XOE','Jul 25 2023 12:00AM','EWORKHUDE2',NULL,NULL,NULL,'202307251','Jul 25 2023 12:00AM','Dec 30 1899 12:00AM','202307181','1875','','','202307181',dbo.fn_GetTimedKey(),NULL,'us3kEpMOV1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'Work Human Demo ExportV2-Sched','202203049','EMPEXPORT','SCH_EWORKH',NULL,'EWORKHUDE2',NULL,NULL,NULL,'202306289','Mar  4 2022  2:32PM','Mar  4 2022  2:32PM','202306211',NULL,NULL,NULL,'202203041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Work Human Demo ExportV2-Test','202312141','EMPEXPORT','TEST_XOE','Jul 28 2023 10:47AM','EWORKHUDE2',NULL,NULL,NULL,'202312141','Jul 28 2023 12:00AM','Jul 23 2023 12:00AM','202312141','1845','','','202312141',dbo.fn_GetTimedKey(),NULL,'us3kEpMOV1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDE2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDE2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDE2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKHUDE2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWORKHUDE2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWORKHUDE2','D10','dbo.U_EWORKHUDE2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EWORKHUDE2_Audit
-----------

IF OBJECT_ID('U_EWORKHUDE2_Audit') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDE2_Audit] (
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
-- Create table U_EWORKHUDE2_AuditFields
-----------

IF OBJECT_ID('U_EWORKHUDE2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDE2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EWORKHUDE2_drvTbl
-----------

IF OBJECT_ID('U_EWORKHUDE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvUniqueId] varchar(9) NULL,
    [drvLoginId] varchar(50) NULL,
    [drvFName] varchar(100) NULL,
    [drvLName] varchar(100) NULL,
    [drvEmail] varchar(50) NULL,
    [drvFunc] varchar(25) NULL,
    [drvCountry] varchar(2) NULL,
    [drvHireDt] varchar(10) NULL,
    [drvManagerId] varchar(30) NULL,
    [drvAdmin] varchar(1) NULL,
    [drvCostCent] varchar(20) NOT NULL,
    [drvLocCode] varchar(25) NULL,
    [drvJobLvl] char(10) NULL,
    [drvEmpType] varchar(45) NULL,
    [drvAlternateTitle] varchar(25) NULL,
    [drvApp2] varchar(1) NOT NULL,
    [drvApp3] varchar(9) NULL,
    [drvRevOrgPart] varchar(1) NOT NULL,
    [drvRevOrgNom] varchar(1) NOT NULL,
    [drvPayGroupDesc] varchar(25) NULL,
    [drvHBRP] varchar(6) NULL,
    [drvGender] char(1) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvRevenueOrgApprov] varchar(30) NULL,
    [drvCustomerCareApprov] varchar(30) NULL
);

-----------
-- Create table U_EWORKHUDE2_EEList
-----------

IF OBJECT_ID('U_EWORKHUDE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWORKHUDE2_File
-----------

IF OBJECT_ID('U_EWORKHUDE2_File') IS NULL
CREATE TABLE [dbo].[U_EWORKHUDE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKHUDE2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Move Sales, Inc.

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 03/04/2022
Service Request Number: TekP-2021-12-07-0003

Purpose: Work Human Demo ExportV2

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        06/28/2023     TekP-2023-05-25-05 Add 3 columns and make updates to RevOrgPart,RevOrgNom and HRBP fields
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWORKHUDE2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWORKHUDE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWORKHUDE2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWORKHUDE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWORKHUDE2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDE2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDE2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKHUDE2', 'SCH_EWORKH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWORKHUDE2';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWORKHUDE2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWORKHUDE2';

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
    DELETE FROM dbo.U_EWORKHUDE2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWORKHUDE2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --MW REMOVED---do not do this it removes emps they want on the file. Criteria hs been reloacted to WHERE clause
    --DELETE FROM dbo.U_EWORKHUDE2_EEList WHERE xEEID IN (
    --    SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE (EecEEType = 'CON' AND EecLocation = 'OFFSH') OR (EecEEType = 'CON' AND EecOrgLvl3 = 'CONEXP')
    --);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EWORKHUDE2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDE2_AuditFields;
    CREATE TABLE dbo.U_EWORKHUDE2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EWORKHUDE2_AuditFields VALUES ('EmpComp','EecTermREason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EWORKHUDE2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDE2_Audit;
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
    INTO dbo.U_EWORKHUDE2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EWORKHUDE2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
      audOldValue = '215' 
    AND audAction <> 'DELETE';

    DELETE dbo.U_EWORKHUDE2_Audit WHERE audRowNo <> 1
    DELETE dbo.U_EWORKHUDE2_Audit WHERE audOldValue <> '215' or audOldValue IS NULL
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EWORKHUDE2_Audit ON dbo.U_EWORKHUDE2_Audit (audEEID,audKey2);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWORKHUDE2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWORKHUDE2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKHUDE2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvUniqueId = SUBSTRING(Ec.EecEmpNo, PATINDEX('%[^0]%', Ec.EecEmpNo+'.'), LEN(Ec.EecEmpNo))
        --Ec.EecEmpNo
        ,drvLoginId =  pers.EepAddressEmail
        ,drvFName = CASE WHEN pers.EepNamePreferred <> '' THEN pers.EepNamePreferred
                        ELSE pers.EepNameFirst END
        ,drvLName = pers.EepNameLast
        ,drvEmail = pers.EepAddressEMail
        ,drvFunc = O3.OrgDesc    --O1.OrgDesc
        ,drvCountry = LEFT(pers.EepAddressCountry, 2) -- Cheryl follow up
        ,drvHireDt =   CONVERT(varchar(10),CASE WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire AND audOldValue = '215' THEN EC.EecDateOfLastHire                        
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EC.EecDateOfOriginalHire,EC.EecDateOfLastHire) >= 5 THEN EC.EecDateOfLastHire
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EC.EecDateOfOriginalHire,EC.EecDateOfLastHire) < 5 THEN EC.EecDateOfOriginalHire
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire THEN EC.EecDateOfLastHire
                        ELSE EC.EecDateOfOriginalHire
                        END , 101)
                        --CASE WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire AND audOldValue = '215' THEN EC.EecDateOfLastHire                        
      --                  WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EjhJobEffDate,EC.EecDateOfLastHire) >= 5 THEN EC.EecDateOfLastHire
      --                  WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EjhJobEffDate,EC.EecDateOfLastHire) < 5 THEN EC.EecDateOfOriginalHire
      --                  WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire THEN EC.EecDateOfLastHire
      --                  ELSE EC.EecDateOfOriginalHire
      --                  END
        ,drvManagerId = CAST(CAST(
                                    CASE WHEN Ec.EecEEType = 'POI' AND Ec.EecJobCode = 'UEX1010I' THEN Ec.EecEmpNo 
                                    ELSE EC2.EecEmpNo 
                                    END AS INTEGER) AS VARCHAR)
        ,drvAdmin = CASE Ec.EecEmpNo
                        WHEN '000116305' THEN 'Y'
                        WHEN '000604401' THEN 'Y'
                        WHEN '000606065' THEN 'Y'
                        WHEN '000606453' THEN 'Y'
                        WHEN '000608195' THEN 'Y'
                        WHEN '000604437' THEN 'Y'
                    END
        ,drvCostCent = CONCAT(LTRIM(RTRIM(O1.OrgCode)), LTRIM(RTRIM(O2.OrgCode)))
        ,drvLocCode = LocDesc
        ,drvJobLvl = je.JbcUDField2
        ,drvEmpType = EmpType.CodDesc -- Ec.EecEEType
        ,drvAlternateTitle = LEFT(je.JbcDesc, 50)   --Ec.EecJobTitle
        ,drvApp2 = ''
                  --CASE WHEN je2.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN '' -- SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo))
                   -- WHEN Je3.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo))
                   -- WHEN jeSupervisor4.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
                   -- WHEN jeSupervisor5.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
                    ----ECSupervisor4.EecEEID
                   -- --ELSE '??'
        --           --     ELSE SUBSTRING(Ec3.EecEmpNo, PATINDEX('%[^0]%', Ec3.EecEmpNo+'.'), LEN(Ec3.EecEmpNo))
                            
                      --   END
        ,drvApp3 = CASE WHEN je2.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN '' -- SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo))
                    WHEN Je3.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo))
                    WHEN jeSupervisor4.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
                    WHEN jeSupervisor5.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
                    --ECSupervisor4.EecEEID
                    --ELSE ECSupervisor5.EecSupervisorID -- jeSupervisor6.JbcUDField2
        --                ELSE SUBSTRING(Ec3.EecEmpNo, PATINDEX('%[^0]%', Ec3.EecEmpNo+'.'), LEN(Ec3.EecEmpNo))
                            
                         END
        --jeSupervisor4.JbcUDField2 /* CASE WHEN je2.JbcUDField2 IN ('M5', 'M6', 'M7', 'M8', 'M9') THEN  ''
                        --ELSE SUBSTRING(Ec3.EecEmpNo, PATINDEX('%[^0]%', Ec3.EecEmpNo+'.'), LEN(Ec3.EecEmpNo))
                        --END */
        -- Revenue Org Participants
       ,drvRevOrgPart = CASE WHEN Ec.EecEEType = 'REG' AND  Ec.EecOrgLvl3 IN ('CONEXP', 'OPERAT', 'SALES')  THEN 'Y' 
                              WHEN Ec.EecEEType = 'REG' AND  Ec.EecOrglvl3 = 'CUSTCR'   THEN 'X' 
                              WHEN Ec3.EecEEType = 'REG' AND Ec3.EecOrglvl3 = 'CUSTCR' AND Je3.JbcUDField2  IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X'
                              WHEN ECSupervisor4.EecEEType = 'REG' AND ECSupervisor4.EecOrglvl3 = 'CUSTCR' AND jeSupervisor4.JbcUDField2  IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X'
                              WHEN ECSupervisor5.EecEEType = 'REG' AND ECSupervisor5.EecOrglvl3 = 'CUSTCR' AND jeSupervisor5.JbcUDField2  IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X'
                             ELSE '' END
        ,drvRevOrgNom = CASE WHEN Ec.EecEEType = 'REG' AND Ec.EecOrgLvl3 IN ('CONEXP', 'OPERAT', 'SALES') AND je.JbcUDField2 IN ('M4', 'M5', 'M6', 'M7') THEN 'Y'
                             WHEN Ec.EecEEType = 'REG' AND Ec.EecOrglvl3 = 'CUSTCR' AND je.JbcUDField2 IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X' 
                             WHEN Ec3.EecEEType = 'REG' AND Ec3.EecOrglvl3 = 'CUSTCR' AND Je3.JbcUDField2  IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X'
                             WHEN ECSupervisor4.EecEEType = 'REG' AND ECSupervisor4.EecOrglvl3 = 'CUSTCR' AND jeSupervisor4.JbcUDField2  IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X'
                              WHEN ECSupervisor5.EecEEType = 'REG' AND ECSupervisor5.EecOrglvl3 = 'CUSTCR' AND jeSupervisor5.JbcUDField2  IN ('M2', 'M3','M4','M5','M6','M7') THEN 'X'
                          ELSE '' END
        ,drvPayGroupDesc = PayGroup.PgrDesc
        ,drvHBRP =     CASE WHEN EC.EecOrgLvl3 IN ('MARKT','CUSTCR','FINACT','GROWTH') THEN '608304'  --removed 'BUSOPR',
                            WHEN EC.EecOrgLvl3 IN ('PRODCT','TECH') THEN '604693'
                            WHEN EC.EecOrgLvl3 IN ('CONEXP') THEN '606000'
                            WHEN EC.EecOrgLvl3 IN ('SALES','OPERAT') THEN '606221'
                            WHEN EC.EecOrgLvl3 IN ('HRFAC','CSUITE','LEGAL') THEN '603972'
                        END
        ,drvGender =    CASE WHEN pers.EepGender IN ('M','F') THEN pers.EepGender END
        ,drvDepartment = o2.OrgDesc --CASE WHEN OrgCode = EecOrgLvl2 THEN OrgDesc

        ,drvRevenueOrgApprov = CASE --WHEN Ec2.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES') AND je2.JbcUDField2 IN ('M6','M7')  THEN NULL
                                         WHEN Ec.EecOrgLvl3  IN  ('CONEXP ','OPERAT','SALES') AND je.JbcUDField2 IN ('M6','M7')THEN  SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo))
                                         WHEN Ec2.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES') AND je2.JbcUDField2 IN ('M6','M7') THEN SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo)) 
                                         WHEN Ec3.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES') AND Je3.JbcUDField2  IN ('M6','M7')   THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo)) 
                                         WHEN ECSupervisor4.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES')AND jeSupervisor4.JbcUDField2 IN ('M6','M7') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
                                         WHEN ECSupervisor4.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES')and jeSupervisor5.JbcUDField2 IN ('M6','M7')  THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
                                         WHEN ECSupervisor5.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES')and jeSupervisor6.JbcUDField2 IN ('M6','M7')  THEN  SUBSTRING(ECSupervisor6.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor6.EecEmpNo+'.'), LEN(ECSupervisor6.EecEmpNo))
                                         ELSE CAST(CAST(
                                    CASE WHEN Ec.EecOrgLvl3  IN  ('CONEXP ','OPERAT','SALES') THEN  SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo)) 
                                    END AS INTEGER) AS VARCHAR)
                                    END
        ,drvCustomerCareApprov =    CASE --WHEN Ec2.EecOrgLvl3 IN  ('CUSTCR') AND je2.JbcUDField2 IN  ('M4','M5','M6','M7') THEN NULL
                                         WHEN Ec2.EecOrgLvl3 IN  ('CUSTCR') AND je2.JbcUDField2  IN  ('M4','M5','M6','M7') THEN SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo)) 
                                         WHEN Ec3.EecOrgLvl3 IN  ('CUSTCR') AND Je3.JbcUDField2  IN  ('M4','M5','M6','M7')  THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo)) 
                                         WHEN ECSupervisor4.EecOrgLvl3 IN  ('CUSTCR') AND jeSupervisor4.JbcUDField2 IN  ('M4','M5','M6','M7') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
                                         WHEN ECSupervisor4.EecOrgLvl3 IN  ('CUSTCR') and jeSupervisor5.JbcUDField2 IN  ('M4','M5','M6','M7') THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
                                         WHEN ECSupervisor5.EecOrgLvl3 IN  ('CUSTCR') and jeSupervisor6.JbcUDField2 IN  ('M4','M5','M6','M7') THEN  SUBSTRING(ECSupervisor6.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor6.EecEmpNo+'.'), LEN(ECSupervisor6.EecEmpNo))
                                     ELSE CAST(CAST(CASE WHEN Ec.EecOrgLvl3  IN  ('CUSTCR') THEN  SUBSTRING(EC2.EecEmpNo, PATINDEX('%[^0]%', EC2.EecEmpNo+'.'), LEN(EC2.EecEmpNo)) 
                                    END AS INTEGER) AS VARCHAR)
                                    END
        
        --,drvRevenueOrgApprov = CASE WHEN Ec2.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES') AND je2.JbcUDField2 IN ('M6','M7')  THEN NULL
        --                                 WHEN Ec3.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES') AND Je3.JbcUDField2  IN ('M6','M7')   THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo)) 
        --                                 WHEN ECSupervisor4.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES')AND jeSupervisor4.JbcUDField2 IN ('M6','M7') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
        --                                 WHEN ECSupervisor4.EecOrgLvl3 IN  ('CONEXP ','OPERAT','SALES')and jeSupervisor5.JbcUDField2 IN ('M6','M7')  THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
        --                            END
        --,drvCustomerCareApprov =    CASE WHEN Ec2.EecOrgLvl3 IN  ('CUSTCR') AND je2.JbcUDField2 IN  ('M4','M5','M6','M7') THEN NULL
        --                                 WHEN Ec3.EecOrgLvl3 IN  ('CUSTCR') AND Je3.JbcUDField2  IN  ('M4','M5','M6','M7')  THEN SUBSTRING(EC3.EecEmpNo, PATINDEX('%[^0]%', EC3.EecEmpNo+'.'), LEN(EC3.EecEmpNo)) 
        --                                 WHEN ECSupervisor4.EecOrgLvl3 IN  ('CUSTCR') AND jeSupervisor4.JbcUDField2 IN  ('M4','M5','M6','M7') THEN  SUBSTRING(ECSupervisor4.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor4.EecEmpNo+'.'), LEN(ECSupervisor4.EecEmpNo))
        --                                 WHEN ECSupervisor4.EecOrgLvl3 IN  ('CUSTCR') and jeSupervisor5.JbcUDField2 IN  ('M4','M5','M6','M7') THEN  SUBSTRING(ECSupervisor5.EecEmpNo, PATINDEX('%[^0]%', ECSupervisor5.EecEmpNo+'.'), LEN(ECSupervisor5.EecEmpNo))
        --                            END
    INTO dbo.U_EWORKHUDE2_drvTbl
    FROM dbo.U_EWORKHUDE2_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers pers WITH (NOLOCK)
        ON pers.EepEEID = xEEID
    JOIN dbo.EmpComp Ec WITH(NOLOCK)
        ON Ec.EecEEID = xEEID   
        AND Ec.EecEmplStatus <> 'T'
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.JobCode je WITH (NOLOCK)
        ON je.JbcJobCode = Ec.EecJobCode
    JOIN dbo.OrgLevel O3 WITH(NOLOCK)
        ON O3.OrgCode = Ec.EecOrgLvl3
        and o3.orglvl = '3'
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
        ON O1.OrgCode = Ec.EecOrgLvl1
        and o1.orglvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
        ON O2.OrgCode = Ec.EecOrgLvl2
        and o2.orglvl = '2'
    LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
        ON EC2.EecEEID = Ec.EecSupervisorID  
        AND EC2.EecEmplStatus <> 'T'
  --  AND Ec2.EecCOID = Ec.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers2 WITH (NOLOCK)
        ON Ec2.EecEEID = pers2.EepEEID
    LEFT JOIN dbo.JobCode je2 -- test
        ON je2.JbcJobCode = Ec2.EecJobCode
    LEFT JOIN dbo.EmpComp EC3 WITH (NOLOCK) -- supervisor  
        ON EC3.EecEEID = Ec2.EecSupervisorID  
        AND EC3.EecEmplStatus <> 'T'

    LEFT JOIN dbo.EmpComp ECSupervisor4 WITH (NOLOCK) -- supervisor  
        ON ECSupervisor4.EecEEID = Ec3.EecSupervisorID  
        AND ECSupervisor4.EecEmplStatus <> 'T'
    LEFT JOIN dbo.JobCode jeSupervisor4 -- test
        ON jeSupervisor4.JbcJobCode = ECSupervisor4.EecJobCode

    LEFT JOIN dbo.EmpComp ECSupervisor5 WITH (NOLOCK) -- supervisor  
        ON ECSupervisor5.EecEEID = ECSupervisor4.EecSupervisorID  
        AND ECSupervisor5.EecEmplStatus <> 'T'
    LEFT JOIN dbo.JobCode jeSupervisor5 -- test
        ON jeSupervisor5.JbcJobCode = ECSupervisor5.EecJobCode

    LEFT JOIN dbo.EmpComp ECSupervisor6 WITH (NOLOCK) -- supervisor  
        ON ECSupervisor6.EecEEID = ECSupervisor5.EecSupervisorID  
        AND ECSupervisor6.EecEmplStatus <> 'T'
    LEFT JOIN dbo.JobCode jeSupervisor6 -- test
        ON jeSupervisor6.JbcJobCode = ECSupervisor6.EecJobCode
        AND Ec3.EecCOID = Ec2.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers3 WITH(NOLOCK)
        ON Ec3.EecEEID = pers3.EepEEID
    LEFT JOIN dbo.JobCode je3 -- test
        ON je3.JbcJobCode = Ec3.EecJobCode
    JOIN dbo.Codes AS EmpType WITH (NOLOCK)
        ON Ec.EecEEType = EmpType.CodCode
        AND EmpType.CodTable = 'EmpType'
    JOIN dbo.PayGroup AS PayGroup WITH (NOLOCK)
        ON Ec.EecPayGroup = PayGroup.PgrPayGroup      
    LEFT JOIN dbo.EmpHJob 
        ON EjhEEID = xEEID
        --AND EjhEEID = xCOID
        AND EjhEmplStatus = 'T'
    LEFT JOIN dbo.U_EWORKHUDE2_Audit WITH (NOLOCK)
            ON audEEID = xEEID
            AND audKey2 = xCOID
    WHERE (Ec.EecEEType <> 'CON' or Ec.EecLocation <> 'OFFSH'  or  o3.OrgCode <> 'CONEXP' ) -- MW updated 12/14/2023 
    --WHERE ((Ec.EecEEType <> 'CON' and Ec.EecLocation <> 'OFFSH' ) or (Ec.EecEEType <> 'CON' and  o3.OrgCode <> 'CONEXP' )) -- mW updated 12/13/2023
    ---(Ec.EecLocation <> 'OFFSH' and  o3.OrgCode <> 'CONEXP')   --(( Ec.EecEEType <> 'CON' AND )
        --    OR (Ec.EecEEType = 'CON' AND (Ec.EecLocation <> 'OFFSH' and o3.OrgCode <> 'CONEXP')))
    and  Ec.EecEmplstatus <> 'T'
    AND  CASE WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire AND audOldValue = '215' THEN EC.EecDateOfLastHire                        
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EC.EecDateOfOriginalHire,EC.EecDateOfLastHire) >= 5 THEN EC.EecDateOfLastHire
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire /*AND EC.EecJobChangeReason = '101'*/ AND DATEDIFF(YEAR, EC.EecDateOfOriginalHire,EC.EecDateOfLastHire) < 5 THEN EC.EecDateOfOriginalHire
                        WHEN EC.EecDateOfLastHire <> EC.EecDateOfOriginalHire THEN EC.EecDateOfLastHire
                        ELSE EC.EecDateOfOriginalHire
                        END < =  @StartDate

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
ALTER VIEW dbo.dsi_vwEWORKHUDE2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWORKHUDE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EV9QY8000020%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202312141'
       ,expStartPerControl     = '202312141'
       ,expLastEndPerControl   = '202312141'
       ,expEndPerControl       = '202312141'
WHERE expFormatCode = 'EWORKHUDE2' and expexportcode = 'TEST_XOE' ;

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWORKHUDE2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWORKHUDE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWORKHUDE2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWORKHUDE2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWORKHUDE2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWORKHUDE2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWORKHUDE2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWORKHUDE2', 'UseFileName', 'V', 'Y'


-- End ripout