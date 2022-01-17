/**********************************************************************************

EDISCCOBRA: Discovery Cobra Export

FormatCode:     EDISCCOBRA
Project:        Discovery Cobra Export
Client ID:      FLO1005
Date/time:      2022-01-14 08:51:06.540
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP4DB02
Database:       ULTIPRO_WPFLOTE
Web Filename:   FLO1005_E1FCF_EEHISTORY_EDISCCOBRA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDISCCOBRA_SavePath') IS NOT NULL DROP TABLE dbo.U_EDISCCOBRA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDISCCOBRA'


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
WHERE FormatCode = 'EDISCCOBRA'
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
WHERE ExpFormatCode = 'EDISCCOBRA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDISCCOBRA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDISCCOBRA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDISCCOBRA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDISCCOBRA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDISCCOBRA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDISCCOBRA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDISCCOBRA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDISCCOBRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDISCCOBRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDISCCOBRA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDISCCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBRA];
GO
IF OBJECT_ID('U_EDISCCOBRA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_PEarHist];
GO
IF OBJECT_ID('U_EDISCCOBRA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_PDedHist];
GO
IF OBJECT_ID('U_EDISCCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_File];
GO
IF OBJECT_ID('U_EDISCCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_EEList];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISCCOBRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCCOBRA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCCOBRA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCCOBRA','Discovery Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EDISCCOBRAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','H','01','2',NULL,'Version',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','10','2',NULL,'Client Name',NULL,NULL,'"Flotek Industries Inc 22132"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBRAZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBRAZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBRAZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBRAZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBRAZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCCOBRAZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCCOBRAZ0','50','D','10','9',NULL,'Individual ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCCOBRAZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCCOBRAZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCCOBRAZ0','50','D','10','12',NULL,'Phone 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCCOBRAZ0','50','D','10','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCCOBRAZ0','50','D','10','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCCOBRAZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCCOBRAZ0','50','D','10','16',NULL,'State or Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCCOBRAZ0','50','D','10','17',NULL,'Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCCOBRAZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCCOBRAZ0','50','D','10','19',NULL,'Premium Address Same As Primary',NULL,NULL,'"True"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCCOBRAZ0','50','D','10','20',NULL,'Premium Address 1',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCCOBRAZ0','50','D','10','21',NULL,'Premium Address 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISCCOBRAZ0','50','D','10','22',NULL,'Premium City',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDISCCOBRAZ0','50','D','10','23',NULL,'Premium State Or Province',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDISCCOBRAZ0','50','D','10','24',NULL,'Premium Postal Code',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDISCCOBRAZ0','50','D','10','25',NULL,'Premium Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDISCCOBRAZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDISCCOBRAZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDISCCOBRAZ0','50','D','10','28',NULL,'Tobacco Use',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDISCCOBRAZ0','50','D','10','29',NULL,'Employee Type',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDISCCOBRAZ0','50','D','10','30',NULL,'Employee Payroll Type',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDISCCOBRAZ0','50','D','10','31',NULL,'Years of Service',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDISCCOBRAZ0','50','D','10','32',NULL,'Premium Coupon Type',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDISCCOBRAZ0','50','D','10','33',NULL,'Uses HCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDISCCOBRAZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDISCCOBRAZ0','50','D','10','35',NULL,'Allow Member SSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDISCCOBRAZ0','50','D','10','36',NULL,'Benefit Group',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDISCCOBRAZ0','50','D','10','37',NULL,'Account Structure',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDISCCOBRAZ0','50','D','10','38',NULL,'Client Specific Data',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','20','2',NULL,'Event Type',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBRAZ0','50','D','20','3',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBRAZ0','50','D','20','4',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBRAZ0','50','D','20','5',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBRAZ0','50','D','20','6',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBRAZ0','50','D','20','7',NULL,'Second Event Original FDOC',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','30','1',NULL,'Record Type',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL,'"drvPLanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBRAZ0','50','D','30','3',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBRAZ0','50','D','30','4',NULL,'Number Of Units',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','40','1',NULL,'Record Type',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBRAZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBRAZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBRAZ0','50','D','40','5',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBRAZ0','50','D','40','6',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBRAZ0','50','D','40','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCCOBRAZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCCOBRAZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCCOBRAZ0','50','D','40','10',NULL,'Phone 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCCOBRAZ0','50','D','40','11',NULL,'Address Same As QB',NULL,NULL,'"drvAddressSameAsQB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCCOBRAZ0','50','D','40','12',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCCOBRAZ0','50','D','40','13',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCCOBRAZ0','50','D','40','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCCOBRAZ0','50','D','40','15',NULL,'State Or Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCCOBRAZ0','50','D','40','16',NULL,'Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCCOBRAZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCCOBRAZ0','50','D','40','18',NULL,'Enrollment Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCCOBRAZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCCOBRAZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCCOBRAZ0','50','D','40','21',NULL,'Is QMCSO',NULL,NULL,'"False"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','50','1',NULL,'Record Type',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','50','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','60','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','60','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBRAZ0','50','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISCCOBRAZ0','50','D','70','1',NULL,'Record Type',NULL,NULL,'"[NPM]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISCCOBRAZ0','50','D','70','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISCCOBRAZ0','50','D','70','3',NULL,'Individual Identifier',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISCCOBRAZ0','50','D','70','4',NULL,'Client Name',NULL,NULL,'"Flotek Industries Inc 22132"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISCCOBRAZ0','50','D','70','5',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISCCOBRAZ0','50','D','70','6',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISCCOBRAZ0','50','D','70','7',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISCCOBRAZ0','50','D','70','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISCCOBRAZ0','50','D','70','9',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISCCOBRAZ0','50','D','70','10',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISCCOBRAZ0','50','D','70','11',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISCCOBRAZ0','50','D','70','12',NULL,'Phone 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISCCOBRAZ0','50','D','70','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISCCOBRAZ0','50','D','70','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISCCOBRAZ0','50','D','70','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISCCOBRAZ0','50','D','70','16',NULL,'State Or Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISCCOBRAZ0','50','D','70','17',NULL,'Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISCCOBRAZ0','50','D','70','18',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISCCOBRAZ0','50','D','70','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISCCOBRAZ0','50','D','70','20',NULL,'Uses Family In Address',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISCCOBRAZ0','50','D','70','21',NULL,'Has Waived All Coverage',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISCCOBRAZ0','50','D','70','22',NULL,'Send GR Notice',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDISCCOBRAZ0','50','D','70','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDISCCOBRA_20220114.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102019','EMPEXPORT','OEACTIVE',NULL,'EDISCCOBRA',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102019','EMPEXPORT','OEPASSIVE',NULL,'EDISCCOBRA',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery Cobra Export','202102019','EMPEXPORT','ONDEM_XOE',NULL,'EDISCCOBRA',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discover Cobra and NPM E-Sched','202102019','EMPEXPORT','SCH_EDISCC',NULL,'EDISCCOBRA',NULL,NULL,NULL,'202102019','Jan 24 2021  1:23PM','Jan 24 2021  1:23PM','202012011',NULL,'','','202012011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Discover Cobra and NPM E-Test','202112229','EMPEXPORT','TEST_XOE','Jan 13 2022 12:11PM','EDISCCOBRA',NULL,NULL,NULL,'202112229','Dec 22 2021 12:00AM','Dec 30 1899 12:00AM','202011011','612','','','202011011',dbo.fn_GetTimedKey(),NULL,'us3rVaFLO1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCCOBRA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D10','dbo.U_EDISCCOBRA_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D20','dbo.U_EDISCCOBRA_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D30','dbo.U_EDISCCOBRA_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D40','dbo.U_EDISCCOBRA_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D50','dbo.U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D60','dbo.U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCCOBRA','D70','dbo.U_EDISCCOBRA_drvTbl_NPM',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISCCOBRA
-----------

IF OBJECT_ID('U_dsi_BDM_EDISCCOBRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCCOBRA] (
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
-- Create table U_EDISCCOBRA_DedList
-----------

IF OBJECT_ID('U_EDISCCOBRA_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_NPM
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(21) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvHireDate] datetime NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvClientDivisionName] varchar(21) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSsn] char(11) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvPlanName] varchar(18) NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NOT NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanName] varchar(18) NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
-----------

IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvRecordType] varchar(33) NOT NULL,
    [drvPlanName] varchar(12) NULL,
    [drvRate] nvarchar(4000) NULL
);

-----------
-- Create table U_EDISCCOBRA_EEList
-----------

IF OBJECT_ID('U_EDISCCOBRA_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISCCOBRA_File
-----------

IF OBJECT_ID('U_EDISCCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EDISCCOBRA_PDedHist
-----------

IF OBJECT_ID('U_EDISCCOBRA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_PDedHist] (
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
-- Create table U_EDISCCOBRA_PEarHist
-----------

IF OBJECT_ID('U_EDISCCOBRA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISCCOBRA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Flotek LLC

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 05/03/2021
Service Request Number: TekP-2021-02-23-0001

Purpose: Discovery Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCCOBRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCCOBRA', 'SCH_EDISCC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCCOBRA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDISCCOBRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISCCOBRA';

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
    DELETE FROM dbo.U_EDISCCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDISCCOBRA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN, MED, MEDHD, VIS, FSA, FSALP,DFSA,M3'; 

    IF OBJECT_ID('U_EDISCCOBRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCCOBRA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

     -- Non Cobra
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode; 

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','A'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then BdmCobraReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '201,204,210,LEVNT3,LEVNT4,200') -- add regular term and--  200 and 210
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '201,204,210,LEVNT3,LEVNT4,200')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4,302'); -- 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); --,302'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DAU,DPC,SON,STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP,DOM'); -- update to the domestic partner relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); -- same for all files
    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;




    --==========================================
    -- Insert into BDM Reason code 201 and 204
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDISCCOBRA]
        ([BdmRecType]
        ,[BdmCOID]
        ,[BdmEEID]
        ,[BdmDepRecID]
        ,[BdmSystemID]
        ,[BdmRunID]
        ,[BdmDedRowStatus]
        ,[BdmRelationship]
        ,[BdmDateOfBirth]
        ,[BdmDedCode]
        ,[BdmBenStartDate]
        ,[BdmBenStopDate]
        ,[BdmBenStatusDate]        
        ,[BdmChangeReason]
        ,[BdmCobraReason]
        ,[BdmStartDate]
        ,[BdmStopDate]
        ,[BdmIsPQB]
        ,[BdmBenOption])
    SELECT /*rectype =*/ 'DEP'
        ,dbnCoid
        ,dbneeid
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 302 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedcode
        ,(SELECT TOP 1 edhBenStartDate FROM dbo.Emphded A WITH (NOLOCK) WHERE A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid ORDER BY Auditkey ASC ) AS bdmBenstartDate
        ,edhBenStopDate
        ,edhEffDate
        ,'302'
        ,'302'
        ,edhStartDate
        ,edhStopDate
        ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,edhbenoption
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON dbneeid = edheeid 
        AND dbnformatcode = @FormatCode
    WHERE edhChangeReason in ('302') 
        AND dbnBenstatusdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnDedCode = EdhDedCode
    GROUP BY dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption

    DELETE FROM dbo.U_dsi_BDM_EDISCCOBRA WHERE bdmdedcode NOT IN  (SELECT DISTINCT Dedcode FROM dbo.U_EDISCCOBRA_DedList)
    
    UPDATE dbo.U_dsi_BDM_EDISCCOBRA 
        SET bdmNumSpouses = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCCOBRA A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'SPS' AND A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EDISCCOBRA A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'CHL' AND A.bdmcoid = X.bdmcoid)
    FROM dbo.U_dsi_BDM_EDISCCOBRA  X
    WHERE BdmDedRowStatus IN ('Data Inserted for 302 Chg reason') --,'Data Inserted for 201 Chg reason')



--==========================================
 -- Insert into BDM Reason code 201 and 204
 --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EDISCCOBRA]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, DbnBenStatus, edhBenStartDate,edhBenStopDate, edhBenStatusDate,'204'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @formatcode
            WHERE edhChangeReason in ('204') and dbnBenstatusDate between @startdate and @enddate and dbnValidForExport = 'N'

INSERT INTO [dbo].[U_dsi_BDM_EDISCCOBRA]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, DbnBenStatus,  edhBenStartDate,edhBenStopDate, edhBenStatusDate,'201'
            ,edhStartDate, edhStopDate, 'Y'
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @formatcode
            WHERE edhChangeReason in ('201') and dbnBenstatusDate between @startdate and @enddate and dbnValidForExport = 'N'

  INSERT INTO [dbo].[U_dsi_BDM_EDISCCOBRA]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 210 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, edhBenStartDate,edhBenStopDate, edhBenStatusDate,'210'
            ,edhStartDate, edhStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @formatcode
            WHERE edhChangeReason in ('210') and dbnBenstatusDate between @startdate and @enddate and dbnValidForExport = 'N'





 Delete from dbo.U_dsi_BDM_EDISCCOBRA where bdmdedcode not in (Select dedcode from U_EDISCCOBRA_DedList)
 --Delete from U_dsi_BDM_EDISCCOBRA where bdmrelationship = 'Z'


 Update dbo.U_dsi_BDM_EDISCCOBRA set bdmNumSpouses = (select count(*) from U_dsi_BDM_EDISCCOBRA A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid),
 bdmNumChildren = (select count(*) from U_dsi_BDM_EDISCCOBRA A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
 from dbo.U_dsi_BDM_EDISCCOBRA X where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 210 Chg reason')

    --==========================================

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvClientDivisionName =   'Flotek Industries Inc'
        ,drvNameFirst = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast =  CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConNameLast ELSE EepNameLast END 
        ,drvSsn = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConSSN ELSE EepSsn END
        ,drvAddressLine1 = REPLACE(CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressLine1 ELSE EepAddressLine1 END, ',', '')
        ,drvAddressLine2 = REPLACE(CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressLIne2 ELSE EepAddressLine2 END, ',', '')
        ,drvAddressCity = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvSex =    CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN 
                            CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                        ELSE 
                            CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END                         
                    END
        ,drvDateOfBirth = CASE WHEN BdmCobraReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConDateOfBirth ELSE EepDateOfBirth END
    INTO dbo.U_EDISCCOBRA_drvTbl_QB
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND (BdmCoID = xCoID OR BdmCobraReason = '302')
        AND BdmRunId = 'QB'
        --AND BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship IN ('SPS','DP'))
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DEN', 'MED', 'MEDHD', 'VIS') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200','302')
                        AND BchIsCobraQualifiedEvent = 'Y'
                        AND EdhEffDAte BETWEEN @StartDate AND @EndDate) AS T
            ) AS ChgReason
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    WHERE --BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship IN ('SPS','DP'))
        ((BdmCobraReason NOT IN  ('302') OR (BdmCobraReason IN ('302') AND ConRelationship IN ('SPS','DP')))
        OR (edhChangeReason NOT IN  ('204') OR (edhChangeReason IN ('204') AND ConRelationship IN ('SPS','DP'))))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvEventType =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'TERMINATION'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '210' THEN 'DEATH'
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','208') THEN 'RETIREMENT'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                            -- WHEN EecEmplStatus = 'T' AND EecTermReason IN ('200','201','205','206') THEN 'INVOLUNTARYTERMINATION'
                            WHEN EecEmplStatus = 'T' AND eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                            WHEN EdhChangeReason = '208' THEN 'RETIREMENT'
                            WHEN EdhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                            WHEN EdhChangeReason IN ('205') THEN 'MEDICARE'
                            -- WHEN EdhChangeReason IN ('201','302 ','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EdhChangeReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EdhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                            WHEN EdhChangeReason IN ('206') THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                            --ELSE 'chg reason: ' + ISNULL(EdhChangeReason, '') + ' : term reason:' + ISNULL(EecTermReason, '')
                        END
        ,drvEventDate =    CASE WHEN eecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND BdmDateOfCobraEvent IS NOT NULL THEN BdmDateOfCobraEvent
                            WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND BdmDateOfCobraEvent IS NULL THEN EecDateOfTermination
                            WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN BdmDateOfCobraEvent --ConCobraStatusDate
                            ELSE EepDateOFCobraEvent
                        END
        --CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN ConCobraStatusDate ELSE BdmDateOfCobraEvent END
        ,drvEnrollmentDate = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4','204','210','201','302') THEN /*ConBenStartDate*/ BdmBenStartDate ELSE BdmBenStartDate END
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName =  ISNULL(EepNameFirst, '') + ' ' + ISNULL(EepNameLast, '') 
    INTO dbo.U_EDISCCOBRA_drvTbl_QBEVENT
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
/*    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'*/
    JOIN (
            SELECT BdmEEID, BdmCOID, MAX(BdmBenStartDate) AS BdmBenStartDate, MAX(BdmDateOfCobraEvent) AS BdmDateOfCobraEvent
            FROM dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
            WHERE BdmRunId = 'QB'
            GROUP BY BdmEEID, BdmCOID) AS BDM
            --GROUP BY BdmEEID, BdmCOID, BdmDepRecId) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DEN', 'MED', 'MEDHD', 'VIS') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200')
                        AND BchIsCobraQualifiedEvent = 'Y') AS T
            WHERE RN = 1
            ) AS ChgReason
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    --    ON ConEEID = xEEID
    --    AND ConSystemID = BdmDepRecId
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE  WHEN BdmDedCode IN ('DEN')THEN 'Aetna Dental'
                                WHEN BdmDedCode = 'MEDHD' THEN 'Aetna Medical HDHP'
                                WHEN BdmDedCode = 'MED' THEN 'Aetna Medical PPO'
                                WHEN BdmDedCode = 'DFSA' THEN 'DBI FSA'
                                WHEN BdmDedCode = 'M3' THEN 'Magellan EAP'
                                WHEN BdmDedCode = 'VIS' THEN 'Ameritas Vision'                                                                 
                        END
        ,drvCoverageLevel =    CASE 
                                 WHEN BdmChangeReason IN ('204', 'LEVNT4','210' )
                                            or BdmCobraReason IN ('204', 'LEVNT4', '210' ) THEN
                                            CASE WHEN BdmNumChildren = 1 or BdmNumSpouses = 1 then 'EE+CHILD'
                                            WHEN BdmNumChildren > 1 or BdmNumSpouses = 1 then 'EE+CHILDREN'
                                            ELSE 'EE'
                                            END
                                WHEN BdmDedCode IN ('DEN', 'MED', 'MEDHD', 'VIS') THEN
                                       CASE WHEN BdmBenOption = 'EE' THEN 'EE'
                                            WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                            WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN 'EE+FAMILY'
                                            WHEN BdmBenOption IN ('EES', 'EEDP') THEN 'EE+SPOUSE'
                                        END
                                    --   WHEN BdmDedCode = 'FSA' THEN 'EE'
                                END
    INTO dbo.U_EDISCCOBRA_drvTbl_QBPLANINITIAL
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedDedCode = BdmDedCode
    WHERE EedBenStatus <> 'W'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 4 ' + BdmDepRecId + ' 1'
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL','DIS','DPC','STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast =  ConNameLast 
        ,drvAddressSameAsQB = 'TRUE' --CASE WHEN ConAddressIsDifferent = 'N' THEN 'TRUE' ELSE 'FALS' END
        ,drvAddressLine1 = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddressLine2 = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvAddressCity = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN EepAddressCity ELSE ConAddressCity END
        ,drvAddressState = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN EepAddressState ELSE ConAddressState END
        ,drvAddressZipCode = '' --CASE WHEN ConAddressIsDifferent = 'N' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EDISCCOBRA_drvTbl_QBDEPENDENT
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
        --AND BdmCobraReason <> '302'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DEN', 'MED', 'MEDHD', 'VIS') 
                        AND edhChangeReason IN ('201','204','210','LEVNT3','LEVNT4','200','302')
                        AND BchIsCobraQualifiedEvent = 'Y') AS T
            ) AS ChgReason
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    WHERE --BdmCobraReason <> '302' OR (BdmCobraReason = '302' AND ConRelationship NOT IN ('SPS','DP'))
        ((BdmCobraReason NOT IN  ('302') OR (BdmCobraReason IN ('302') AND ConRelationship IN ('SPS','DP')))
        OR (edhChangeReason NOT IN  ('204') OR (edhChangeReason IN ('204') AND ConRelationship IN ('SPS','DP'))))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 4 ' + BdmDepRecId + ' 2'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE  WHEN BdmDedCode IN ('DEN')THEN 'Aetna Dental'
                                WHEN BdmDedCode = 'MEDHD' THEN 'Aetna Medical HDHP'
                                WHEN BdmDedCode = 'MED' THEN 'Aetna Medical PPO'
                                WHEN BdmDedCode = 'VIS' THEN 'Ameritas Vision'  
                                WHEN BdmDedCode = 'DFSA' THEN 'DBI FSA'
                                WHEN BdmDedCode = 'M3' THEN 'Magellan EAP'                                                               
                        END
    INTO dbo.U_EDISCCOBRA_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'DEP'
        AND BdmRunId = 'QB'
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedDedCode = BdmDedCode
    WHERE EedBenStatus <> 'W'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '3 ' + xEEID + ' 5'
        -- standard fields above and additional driver fields below
        ,drvRecordType = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName =    CASE WHEN BdmDedCode = 'DFSA' THEN 'DBI FSA'
                        WHEN BdmDedCode = 'M3' THEN 'Magellan EAP'
                        END
                        --CASE WHEN BdmDedCode = 'FSA' THEN 'DBI FSA'
                        --END
        ,drvRate = CASE WHEN BdmDedCode IN ('FSA','M3') THEN FORMAT(ISNULL(BdmEEAmt, 0.00), '#0.00') END
    INTO dbo.U_EDISCCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        --AND BdmDedCode IN ('FSA','FSALP','M3')
        --AND BdmDedCode IN ('DFSA','M3')
        AND BdmDedCode IN ('M3')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCCOBRA_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_EDISCCOBRA_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCCOBRA_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvClientDivisionName = 'Flotek Industries Inc'
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast =  EepNameLast 
        ,drvAddressLine1 =  EepAddressLine1 
        ,drvAddressLine2 =  ISNULL(EepAddressLine2, '') 
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvSex = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvHireDate = EecDateOfLastHire
    INTO dbo.U_EDISCCOBRA_drvTbl_NPM
    FROM dbo.U_EDISCCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISCCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'NPM'
    JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    LEFT JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DEN', 'MED', 'MEDHD', 'VIS') 
                ) AS T 
            WHERE RN = 1) AS X
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
    WHERE EdhChangeReason <> 'OE'
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
ALTER VIEW dbo.dsi_vwEDISCCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCCOBRA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012011'
       ,expStartPerControl     = '202012011'
       ,expLastEndPerControl   = '202102019'
       ,expEndPerControl       = '202102019'
WHERE expFormatCode = 'EDISCCOBRA';


UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012011'
       ,expStartPerControl     = '202012011'
       ,expLastEndPerControl   = '202102019'
       ,expEndPerControl       = '202102019'
WHERE expFormatCode = 'EDISCCOBRA' and expExportCode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCCOBRA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDISCCOBRA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISCCOBRA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISCCOBRA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCCOBRA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDISCCOBRA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCCOBRA', 'UseFileName', 'V', 'Y'


-- End ripout