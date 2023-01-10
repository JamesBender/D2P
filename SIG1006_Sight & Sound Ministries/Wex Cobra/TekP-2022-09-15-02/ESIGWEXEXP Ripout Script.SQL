/**********************************************************************************

ESIGWEXEXP: WEX COBRA NPM Export

FormatCode:     ESIGWEXEXP
Project:        WEX COBRA NPM Export
Client ID:      SIG1006
Date/time:      2023-01-10 15:29:11.797
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB02
Database:       ULTIPRO_WPSSMIN
Web Filename:   SIG1006_RO71N_EEHISTORY_ESIGWEXEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESIGWEXEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ESIGWEXEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESIGWEXEXP'


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
WHERE FormatCode = 'ESIGWEXEXP'
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
WHERE ExpFormatCode = 'ESIGWEXEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESIGWEXEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESIGWEXEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESIGWEXEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESIGWEXEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESIGWEXEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESIGWEXEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESIGWEXEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESIGWEXEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESIGWEXEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESIGWEXEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESIGWEXEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESIGWEXEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESIGWEXEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESIGWEXEXP];
GO
IF OBJECT_ID('U_ESIGWEXEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_File];
GO
IF OBJECT_ID('U_ESIGWEXEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_EEList];
GO
IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_drvTbl_QB];
GO
IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_drvTbl_NPM];
GO
IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL];
GO
IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_DEP') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_drvTbl_DEP];
GO
IF OBJECT_ID('U_ESIGWEXEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_DedList];
GO
IF OBJECT_ID('U_ESIGWEXEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_AuditFields];
GO
IF OBJECT_ID('U_ESIGWEXEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESIGWEXEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESIGWEXEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESIGWEXEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESIGWEXEXP','WEX COBRA NPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESIGWEXEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','H','01','1',NULL,'RecTypeH',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','H','01','2',NULL,'Version',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','D','10','1',NULL,'RecType1',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','D','10','2',NULL,'Client Name',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESIGWEXEXPZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESIGWEXEXPZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESIGWEXEXPZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESIGWEXEXPZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESIGWEXEXPZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESIGWEXEXPZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESIGWEXEXPZ0','50','D','10','9',NULL,'Individual ID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESIGWEXEXPZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESIGWEXEXPZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESIGWEXEXPZ0','50','D','10','12',NULL,'Phone 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESIGWEXEXPZ0','50','D','10','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESIGWEXEXPZ0','50','D','10','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESIGWEXEXPZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESIGWEXEXPZ0','50','D','10','16',NULL,'State or Province',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESIGWEXEXPZ0','50','D','10','17',NULL,'Postal Code',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESIGWEXEXPZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESIGWEXEXPZ0','50','D','10','19',NULL,'Premium Address Same As Primary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESIGWEXEXPZ0','50','D','10','20',NULL,'Premium Address 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESIGWEXEXPZ0','50','D','10','21',NULL,'Premium Address 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESIGWEXEXPZ0','50','D','10','22',NULL,'Premium City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESIGWEXEXPZ0','50','D','10','23',NULL,'Premium State Or Province',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESIGWEXEXPZ0','50','D','10','24',NULL,'Premium Postal Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESIGWEXEXPZ0','50','D','10','25',NULL,'Premium Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESIGWEXEXPZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESIGWEXEXPZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESIGWEXEXPZ0','50','D','10','28',NULL,'Tobacco Use',NULL,NULL,'"drvTobaccoUse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESIGWEXEXPZ0','50','D','10','29',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESIGWEXEXPZ0','50','D','10','30',NULL,'Employee Payroll Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESIGWEXEXPZ0','50','D','10','31',NULL,'Years of Service',NULL,NULL,'"drvYears"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESIGWEXEXPZ0','50','D','10','32',NULL,'Premium Coupon Type',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESIGWEXEXPZ0','50','D','10','33',NULL,'Uses HCTC',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESIGWEXEXPZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESIGWEXEXPZ0','50','D','10','35',NULL,'Allow Member SSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESIGWEXEXPZ0','50','D','10','36',NULL,'Benefit Group',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESIGWEXEXPZ0','50','D','10','37',NULL,'Account Structure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESIGWEXEXPZ0','50','D','10','38',NULL,'Client Specific Data',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','D','20','1',NULL,'RecType2',NULL,NULL,'"{QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','D','20','2',NULL,'Event Type',NULL,NULL,'"drvEvent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESIGWEXEXPZ0','50','D','20','3',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESIGWEXEXPZ0','50','D','20','4',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESIGWEXEXPZ0','50','D','20','5',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESIGWEXEXPZ0','50','D','20','6',NULL,'Employee Name',NULL,NULL,'"drvEmpName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESIGWEXEXPZ0','50','D','20','7',NULL,'Second Event Original FDOC',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','D','30','1',NULL,'RecType3',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESIGWEXEXPZ0','50','D','30','3',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESIGWEXEXPZ0','50','D','30','4',NULL,'Number Of Units',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','D','40','1',NULL,'RecType4',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESIGWEXEXPZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESIGWEXEXPZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESIGWEXEXPZ0','50','D','40','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESIGWEXEXPZ0','50','D','40','6',NULL,'Middle Initial',NULL,NULL,'"ddvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESIGWEXEXPZ0','50','D','40','7',NULL,'Last Name',NULL,NULL,'"dsvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESIGWEXEXPZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESIGWEXEXPZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESIGWEXEXPZ0','50','D','40','10',NULL,'Phone 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESIGWEXEXPZ0','50','D','40','11',NULL,'Address Same As QB',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESIGWEXEXPZ0','50','D','40','12',NULL,'Address 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESIGWEXEXPZ0','50','D','40','13',NULL,'Address 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESIGWEXEXPZ0','50','D','40','14',NULL,'City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESIGWEXEXPZ0','50','D','40','15',NULL,'State Or Province',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESIGWEXEXPZ0','50','D','40','16',NULL,'Postal Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESIGWEXEXPZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESIGWEXEXPZ0','50','D','40','18',NULL,'Enrollment Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESIGWEXEXPZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESIGWEXEXPZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESIGWEXEXPZ0','50','D','40','21',NULL,'Is QMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','D','50','1',NULL,'RecType5',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','D','50','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESIGWEXEXPZ0','50','D','60','1',NULL,'RecType6',NULL,NULL,'"[NPM]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESIGWEXEXPZ0','50','D','60','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESIGWEXEXPZ0','50','D','60','3',NULL,'Individual ID',NULL,NULL,'"ddvIndividualID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESIGWEXEXPZ0','50','D','60','4',NULL,'Client Name',NULL,NULL,'"divClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESIGWEXEXPZ0','50','D','60','5',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESIGWEXEXPZ0','50','D','60','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESIGWEXEXPZ0','50','D','60','7',NULL,'Middle Initial',NULL,NULL,'"ddvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESIGWEXEXPZ0','50','D','60','8',NULL,'Last Name',NULL,NULL,'"dsvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESIGWEXEXPZ0','50','D','60','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESIGWEXEXPZ0','50','D','60','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESIGWEXEXPZ0','50','D','60','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESIGWEXEXPZ0','50','D','60','12',NULL,'Phone 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESIGWEXEXPZ0','50','D','60','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESIGWEXEXPZ0','50','D','60','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESIGWEXEXPZ0','50','D','60','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESIGWEXEXPZ0','50','D','60','16',NULL,'State or Province',NULL,NULL,'"davState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESIGWEXEXPZ0','50','D','60','17',NULL,'Postal Code',NULL,NULL,'"dsvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESIGWEXEXPZ0','50','D','60','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESIGWEXEXPZ0','50','D','60','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESIGWEXEXPZ0','50','D','60','20',NULL,'Uses Family In Address',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESIGWEXEXPZ0','50','D','60','21',NULL,'Has Waived All Coverage',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESIGWEXEXPZ0','50','D','60','22',NULL,'Send GR Notice',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESIGWEXEXPZ0','50','D','60','23',NULL,'Hire Date',NULL,NULL,'"drvLastHireDate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESIGWEXEXP_20230110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202301099','EMPEXPORT','OEACTIVE',NULL,'ESIGWEXEXP',NULL,NULL,NULL,'202301099','Dec  7 2022  3:38PM','Dec  7 2022  3:38PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202301099','EMPEXPORT','OEPASSIVE',NULL,'ESIGWEXEXP',NULL,NULL,NULL,'202301099','Dec  7 2022  3:38PM','Dec  7 2022  3:38PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX COBRA NPM Export','202301099','EMPEXPORT','ONDEM_XOE',NULL,'ESIGWEXEXP',NULL,NULL,NULL,'202301099','Dec  7 2022  3:38PM','Dec  7 2022  3:38PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX COBRA NPM Export-Sched','202301099','EMPEXPORT','SCH_ESIGWE',NULL,'ESIGWEXEXP',NULL,NULL,NULL,'202301099','Dec  7 2022  3:38PM','Dec  7 2022  3:38PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'WEX COBRA NPM Export-Test','202301099','EMPEXPORT','TEST_XOE','Jan  9 2023 12:00AM','ESIGWEXEXP',NULL,NULL,NULL,'202301099','Jan  9 2023 12:00AM','Dec 30 1899 12:00AM','202301011','61','','','202301011',dbo.fn_GetTimedKey(),NULL,'us3lKiSIG1006',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESIGWEXEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','D10','dbo.U_ESIGWEXEXP_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','D20','dbo.U_ESIGWEXEXP_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','D30','dbo.U_ESIGWEXEXP_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','D40','dbo.U_ESIGWEXEXP_drvTbl_DEP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','D50','dbo.U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESIGWEXEXP','D60','dbo.U_ESIGWEXEXP_drvTbl_NPM',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESIGWEXEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ESIGWEXEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESIGWEXEXP] (
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
-- Create table U_ESIGWEXEXP_Audit
-----------

IF OBJECT_ID('U_ESIGWEXEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_Audit] (
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
-- Create table U_ESIGWEXEXP_AuditFields
-----------

IF OBJECT_ID('U_ESIGWEXEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESIGWEXEXP_DedList
-----------

IF OBJECT_ID('U_ESIGWEXEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESIGWEXEXP_drvTbl_DEP
-----------

IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_DEP') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_drvTbl_DEP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(32) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvFirstName] varchar(100) NULL,
    [ddvMiddleInitial] varchar(1) NULL,
    [dsvLastName] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] varchar(10) NULL
);

-----------
-- Create table U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL
-----------

IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(32) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvPlanName] varchar(28) NULL
);

-----------
-- Create table U_ESIGWEXEXP_drvTbl_NPM
-----------

IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [ddvIndividualID] varchar(1) NOT NULL,
    [divClientName] varchar(30) NOT NULL,
    [drvClientDivisionName] varchar(24) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [ddvMiddleInitial] varchar(1) NULL,
    [dsvLastName] varchar(100) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(255) NULL,
    [davState] varchar(255) NULL,
    [dsvZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvLastHireDate] varchar(10) NULL
);

-----------
-- Create table U_ESIGWEXEXP_drvTbl_QB
-----------

IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvClientName] varchar(30) NOT NULL,
    [drvClientDivisionName] varchar(24) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvSex] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmployeeType] varchar(3) NOT NULL,
    [drvYears] varchar(1) NOT NULL
);

-----------
-- Create table U_ESIGWEXEXP_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvEvent] varchar(29) NULL,
    [drvEventDate] varchar(10) NULL,
    [drvEnrollDate] varchar(10) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpName] varchar(201) NULL
);

-----------
-- Create table U_ESIGWEXEXP_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvPlanName] varchar(28) NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_ESIGWEXEXP_EEList
-----------

IF OBJECT_ID('U_ESIGWEXEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESIGWEXEXP_File
-----------

IF OBJECT_ID('U_ESIGWEXEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESIGWEXEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESIGWEXEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Sight & Sound Ministries, Inc.

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 12/07/2022
Service Request Number: TekP-2022-09-15-02

Purpose: WEX COBRA NPM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESIGWEXEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESIGWEXEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESIGWEXEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESIGWEXEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESIGWEXEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESIGWEXEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESIGWEXEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESIGWEXEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESIGWEXEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESIGWEXEXP', 'SCH_ESIGWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESIGWEXEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESIGWEXEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ESIGWEXEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(10),GETDATE(),101)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
        ,@FileMinCovDate  = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESIGWEXEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESIGWEXEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESIGWEXEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_AuditFields;
    CREATE TABLE dbo.U_ESIGWEXEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_ESIGWEXEXP_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ESIGWEXEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESIGWEXEXP_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_ESIGWEXEXP_AuditFields VALUES ('EmpDed','eedBenStartDate');
    INSERT INTO dbo.U_ESIGWEXEXP_AuditFields VALUES ('EmpDed','eedBenOption');
    INSERT INTO dbo.U_ESIGWEXEXP_AuditFields VALUES ('EmpDed','eedDedCode');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESIGWEXEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_Audit;
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
    INTO dbo.U_ESIGWEXEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESIGWEXEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESIGWEXEXP_Audit ON dbo.U_ESIGWEXEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ESIGWEXEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESIGWEXEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,DENS,VIS,VISS,HEA,HEA1,HEA1S,HEA1W,HEAS,HEAW';

    IF OBJECT_ID('U_ESIGWEXEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESIGWEXEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

   --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
        
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y'); -- only used for NPM/QB combined files

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then BDMChangeReason. Include CHGRP for elig. ben groups – 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee WHEN Cobra Reason is a dependent PQB reason – 
    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee WHEN Cobra Reason is "Death".  

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used WHEN clients have Platform Configurable fields.  Client doesn’t use PCF fields.

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); --- update to the spouse relationship code

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH, DPC,STC');  -- update to the child relationship codes

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); --- update to the domestic partner relationship code
    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); --- same for all files
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
        
    
    


    ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 --   --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_ESIGWEXEXP]
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
    )
    Select distinct
        'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,'EE'
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'ESIGWEXEXP'
    WHERE edhChangeReason IN ('201','LEVNT3') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
            AND DbnBenStatus = 'T'

--    ========================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 --  ======================================================================
    INSERT INTO [dbo].[U_dsi_BDM_ESIGWEXEXP]
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
    )
    SELECT Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204/LEVNT4 (Divorce/Separation)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        --,EdhBenStopDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'ESIGWEXEXP'
    WHERE edhChangeReason in ('204','LEVNT4') 
       -- AND DbnRelationShip = 'SPS'
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'

--  --====================================================
 --   Insert into BDM Reason code 302 (Remove Dependent)
 --   --==================================================
    INSERT INTO [dbo].[U_dsi_BDM_ESIGWEXEXP]
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
    )
    Select Distinct rectype = 'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 302 (Remove Dependent)'
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
        ,'302'
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'ESIGWEXEXP'
    WHERE edhChangeReason IN ('302') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T'

      Delete from dbo.U_dsi_BDM_ESIGWEXEXP where bdmdedcode not in (Select dedcode from U_ESIGWEXEXP_DedList)
    
    


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESIGWEXEXP_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 1'
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvClientName = 'Sight and Sound Ministry 47271'
        ,drvClientDivisionName = 'Sight and Sound Ministry'
        ,drvNameFirst = CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN  connamefirst ELSE EepNameFirst END
        ,drvNameMiddle = CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN  Left(ConNameMiddle,1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN  connameLast ELSE EepNameLast END
        ,drvSSN = EepSSN 
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars(',',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars(',',EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvSex = CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN ConGender ELSE EepGender ENd
        ,drvDOB = CONVERT(VARCHAR(10),CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN ConDateofBirth ELSE EepDateOfBirth END, 101)
        ,drvTobaccoUse = CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN 'UNKNOWN' 
                            ELSE 
                                CASE WHEN EepIsSmoker = 'Y' THEN  'YES'
                                     WHEN EepIsSmoker = 'N' THEN 'NO' else  'UNKNOWN'  
                                    END
                                END
        ,drvEmployeeType = 'FTE'
        ,drvYears = ''
    INTO dbo.U_ESIGWEXEXP_drvTbl_QB
    FROM dbo.U_ESIGWEXEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESIGWEXEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmIsPQB = 'Y'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId 
    --LEFT JOIN dbo.U_ESIGWEXEXP_Audit WITH (NOLOCK) 
    -- ON audEEID = bdmeeid
    --    AND audKey2 = bdmCoID
    --    AND audFieldName = 'EecDateofTermination'
    --    AND audNewValue is not null
    --    and audDateTime BETWEEN @startdate AND @enddate
   -- WHERE  EecEEType <> 'TES' 
      --  AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESIGWEXEXP_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_drvTbl_QBEVENT;
     
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 2'
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
    
        ,drvEvent = CASE WHEN BdmChangeReason IN ( '204', 'RSD', 'LEVNT4' ) THEN 'DIVORCELEGALSEPARATION'
                         WHEN EecEmplStatus = 'T' and EecTermReason  = '203' THEN 'DEATH'
                         WHEN (BdmChangeReason IN ( '201' , 'LEVNT3') or EDHChangeReason IN ( '201' , 'LEVNT3')) THEN 'INELIGIBLEDEPENDENT'
                         WHEN EecEmplStatus = 'T'and EecTermReason = '202' THEN 'RETIREMENT' 
                         WHEN (EdhChangeReason IN ('203' , 'CSFTPT') or BdmCobraReason IN ('203' , 'CSFTPT') )  THEN  'REDUCTIONINHOURS-STATUSCHANGE'
                         WHEN BdmChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                         WHEN EecEmplStatus = 'T' and EecTermReason  = 'LAYOFF' THEN 'REDUCTIONINFORCE'
                         WHEN EecEmplStatus = 'T' and eectermtype = 'I' and EecTermReason NOT IN ('202', '203' , 'LAYOFF')  and eectermtype  <> 'V'THEN 'INVOLUNTARYTERMINATION'
                         WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ( '202', '203' , 'LAYOFF') and eectermtype  = 'V' THEN 'TERMINATION'
                        END
        ,drvEventDate = CONVERT(VARCHAR(10),CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN EdhEffDate ELSE EecDateofTermination END, 101)
        ,drvEnrollDate = CONVERT(VARCHAR(10),BdmbenStartDate, 101)--CASE WHEN bdmChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) THEN BdmbenStartDate ELSE BdmbenStartDate END
        ,drvSSN = eepSSN
        ,drvEmpName = eepnamefirst +' '+ eepnamelast
    INTO dbo.U_ESIGWEXEXP_drvTbl_QBEVENT
    FROM dbo.U_ESIGWEXEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (
            SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmChangeReason = Max(BdmChangeReason)
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
              FROM dbo.U_dsi_BDM_ESIGWEXEXP WITH (NOLOCK)
              WHERE BdmRunId = 'QB'
              GROUP BY BdmEEID, BdmCoID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID        
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable(@DedList)) 
                        AND edhChangeReason IN ('204', 'RSD', 'LEVNT4', '201', 'LEVNT3' ,'210' ) 
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
    --LEFT JOIN dbo.U_ESIGWEXEXP_Audit WITH (NOLOCK) 
    --    ON audEEID = bdmeeid
    --    AND audKey2 = bdmCoID
    --    AND audFieldName = 'EecDateofTermination'
    --    AND audNewValue is not null
    --    and audDateTime BETWEEN @startdate AND @enddate
  --  WHERE  EecEEType <> 'TES' 
     --   AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESIGWEXEXP_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 3'
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BDMDedcode IN ('DEN', 'DENS') THEN 'Guardian Dental'
                            WHEN BdmDedCode IN ('HEA', 'HEAS', 'HEAW') THEN 'Guardian Medical Standard'
                            WHEN BdmDedCode IN ('VIS', 'VISS') THEN 'Guardian Vision'
                            WHEN BdmDedCode IN ('HEA1', 'HEA1S', 'HEA1W') THEN 'Meritain Health Medical HDHP'
                        END
        ,drvCoverageLevel = CASE WHEN  BdmChangeReason IN ('204','LEVNT4','201','LEVNT3','210') THEN
                                    CASE WHEN (SELECT  COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_ESIGWEXEXP B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('SPS', 'DP')) = 1 AND (SELECT COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_ESIGWEXEXP B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID  AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
                                         WHEN (SELECT COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_ESIGWEXEXP B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('SPS', 'DP')) = 1 AND (SELECT  COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_ESIGWEXEXP B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                         WHEN (SELECT  COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_ESIGWEXEXP B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN' 
                                         ELSE 'EE'
                                    END
                                 ELSE
                                
                                CASE WHEN  BdmChangeReason NOT IN ('204','LEVNT4','201','LEVNT3','210') THEN
                                           CASE WHEN BdmBenOption IN ('EE') THEN 'EE'
                                                WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILDREN'
                                                WHEN BdmBenOption IN ('EES') THEN 'EE+SPOUSE'
                                                WHEN BdmBenOption IN ('EEF') THEN 'EE+FAMILY'
                                                END
                                            END
                                        END
                            
    INTO dbo.U_ESIGWEXEXP_drvTbl_QBPLANINITIAL
    FROM dbo.U_ESIGWEXEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESIGWEXEXP A WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB' and bdmIsPQB = 'Y'
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --LEFT JOIN dbo.U_ESIGWEXEXP_Audit WITH (NOLOCK) 
    -- ON audEEID = bdmeeid
    --    AND audKey2 = bdmCoID
    --    AND audFieldName = 'EecDateofTermination'
    --    AND audNewValue is not null
    --    and audDateTime BETWEEN @startdate AND @enddate
    --WHERE  EecEEType <> 'TES' 
    --    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESIGWEXEXP_drvTbl_DEP
    ---------------------------------
    IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_DEP','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_drvTbl_DEP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort  = '1 ' + xEEID + ' 4' + CASE WHEN  conrelationship in ('CHL', 'DIS', 'DPC', 'STC') THEN' 2' ELSE ' 1' END + BdmDepRecID + ' 1'  
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN
        ,drvRelationship = CASE WHEN ConRelationship IN ('CHL','CHD','DPC','STC') THEN 'CHILD'
                                WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                            END
        ,drvFirstName = ConNameFirst
        ,ddvMiddleInitial = LEFT(ConNameMiddle,1)
        ,dsvLastName = ConNameLast
        ,drvGender = ConGender
        ,drvDOB = CONVERT(VARCHAR(10),ConDateOfBirth, 101)
    INTO dbo.U_ESIGWEXEXP_drvTbl_DEP
    FROM dbo.U_ESIGWEXEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ESIGWEXEXP WITH (NOLOCK)
         ON BdmEEID = xEEID 
         AND BdmCoID = xCoID
         AND bdmRunID = 'QB'
         AND BdmRecType = 'DEP' 
         AND BdmIsPQB = 'N'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    --LEFT JOIN dbo.U_ESIGWEXEXP_Audit WITH (NOLOCK) 
    -- ON audEEID = bdmeeid
    --    AND audKey2 = bdmCoID
    --    AND audFieldName = 'EecDateofTermination'
    --    AND audNewValue is not null
    --    and audDateTime BETWEEN @startdate AND @enddate
    --WHERE  EecEEType <> 'TES' 
    --    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL
    ---------------------------------
    IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 4' + CASE WHEN  conrelationship in ('CHL', 'DIS', 'DPC', 'STC') THEN' 2' ELSE ' 1' END + BdmDepRecID + ' 2'
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BDMDedcode IN ('DEN', 'DENS') THEN 'Guardian Dental'
                            WHEN BdmDedCode IN ('HEA', 'HEAS', 'HEAW') THEN 'Guardian Medical Standard'
                            WHEN BdmDedCode IN ('VIS', 'VISS') THEN 'Guardian Vision'
                            WHEN BdmDedCode IN ('HEA1', 'HEA1S', 'HEA1W') THEN 'Meritain Health Medical HDHP'
                        END
    INTO dbo.U_ESIGWEXEXP_drvTbl_DEPPLANINTIAL
    FROM dbo.U_ESIGWEXEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESIGWEXEXP WITH (NOLOCK)
         ON BdmEEID = xEEID 
         AND BdmCoID = xCoID
         AND bdmRunID = 'QB'
         AND BdmRecType = 'DEP' 
         AND BdmIsPQB = 'N'
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    --LEFT JOIN dbo.U_ESIGWEXEXP_Audit WITH (NOLOCK) 
    -- ON audEEID = bdmeeid
    --    AND audKey2 = bdmCoID
    --    AND audFieldName = 'EecDateofTermination'
    --    AND audNewValue is not null
    --    and audDateTime BETWEEN @startdate AND @enddate
    --WHERE  EecEEType <> 'TES' 
    --    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESIGWEXEXP_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_ESIGWEXEXP_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_ESIGWEXEXP_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2 ' + xEEID 
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,ddvIndividualID = ''
        ,divClientName = 'Sight and Sound Ministry 47271'
        ,drvClientDivisionName = 'Sight and Sound Ministry'
        ,drvFirstName = EepNameFirst
        ,ddvMiddleInitial = LEFT(EepNameMiddle,1)
        ,dsvLastName = EepNameLast
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars(',',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars(',',EepAddressLine2)
        ,drvCity = EepAddressCity
        ,davState = EepAddressState
        ,dsvZipCode = EepAddressZipCode
        ,drvGender = EepGender
        ,drvLastHireDate = CONVERT(VARCHAR(10),EecDateOfLastHire,101)
    INTO dbo.U_ESIGWEXEXP_drvTbl_NPM
    FROM dbo.U_ESIGWEXEXP_EEList WITH (NOLOCK)
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESIGWEXEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'NPM'
       -- AND BdmRelationship IN ('Emp','SPS','DP')
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
ALTER VIEW dbo.dsi_vwESIGWEXEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESIGWEXEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESIGWEXEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202210011'
       ,expStartPerControl     = '202210011'
       ,expLastEndPerControl   = '202212079'
       ,expEndPerControl       = '202212079'
WHERE expFormatCode = 'ESIGWEXEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESIGWEXEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESIGWEXEXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort,RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESIGWEXEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESIGWEXEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESIGWEXEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESIGWEXEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESIGWEXEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESIGWEXEXP', 'UseFileName', 'V', 'Y'


-- End ripout