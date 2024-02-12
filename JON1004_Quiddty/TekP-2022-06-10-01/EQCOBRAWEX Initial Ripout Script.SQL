/**********************************************************************************

EQCOBRAWEX: COBRA SPM Export

FormatCode:     EQCOBRAWEX
Project:        COBRA SPM Export
Client ID:      USG1000
Date/time:      2022-08-25 14:34:22.563
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EQCOBRAWEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQCOBRAWEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EQCOBRAWEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQCOBRAWEX'


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
WHERE FormatCode = 'EQCOBRAWEX'
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
WHERE ExpFormatCode = 'EQCOBRAWEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQCOBRAWEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQCOBRAWEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQCOBRAWEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQCOBRAWEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQCOBRAWEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQCOBRAWEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQCOBRAWEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQCOBRAWEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQCOBRAWEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQCOBRAWEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQCOBRAWEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQCOBRAWEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQCOBRAWEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQCOBRAWEX];
GO
IF OBJECT_ID('U_EQCOBRAWEX_File') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_File];
GO
IF OBJECT_ID('U_EQCOBRAWEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_EEList];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMUPDATE') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMUPDATE];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANINSERT];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANDROP') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANDROP];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANDELETE') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANDELETE];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMINSERT') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMINSERT];
GO
IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMDELETE') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMDELETE];
GO
IF OBJECT_ID('U_EQCOBRAWEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_DedList];
GO
IF OBJECT_ID('U_EQCOBRAWEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_AuditFields];
GO
IF OBJECT_ID('U_EQCOBRAWEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EQCOBRAWEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EQCOBRAWEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQCOBRAWEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQCOBRAWEX','COBRA SPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EQCOBRAWEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','H','01','1',NULL,'Version Header',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','H','01','2',NULL,'Version Number',NULL,NULL,'"2.0"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','10','1',NULL,'SPM Insert Indicator',NULL,NULL,'"[SPMINSERT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','10','2',NULL,'Client Name ',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"Quiddity-1 Inc"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','10','4',NULL,'Salutation ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','10','5',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','10','6',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','10','7',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','10','8',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','10','9',NULL,'Individual ID ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQCOBRAWEXZ0','50','D','10','10',NULL,'Email ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQCOBRAWEXZ0','50','D','10','11',NULL,'Phone ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQCOBRAWEXZ0','50','D','10','12',NULL,'Phone 2 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQCOBRAWEXZ0','50','D','10','13',NULL,'Address 1 ',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQCOBRAWEXZ0','50','D','10','14',NULL,'Address 2 ',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQCOBRAWEXZ0','50','D','10','15',NULL,'City ',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQCOBRAWEXZ0','50','D','10','16',NULL,'State or Province ',NULL,NULL,'"drvStateorProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQCOBRAWEXZ0','50','D','10','17',NULL,'Postal Code ',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQCOBRAWEXZ0','50','D','10','18',NULL,'Country ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQCOBRAWEXZ0','50','D','10','19',NULL,'Sex ',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQCOBRAWEXZ0','50','D','10','20',NULL,'DOB ',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQCOBRAWEXZ0','50','D','10','21',NULL,'Tobacco Use ',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQCOBRAWEXZ0','50','D','10','22',NULL,'Employee Type ',NULL,NULL,'"FTE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQCOBRAWEXZ0','50','D','10','23',NULL,'Employee Payroll Type ',NULL,NULL,'"drvEmployeePayrollType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQCOBRAWEXZ0','50','D','10','24',NULL,'Years of Service ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQCOBRAWEXZ0','50','D','10','25',NULL,'Premium Coupon Type ',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQCOBRAWEXZ0','50','D','10','26',NULL,'Billing Start Date',NULL,NULL,'"drvBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQCOBRAWEXZ0','50','D','10','27',NULL,'Billing End Date',NULL,NULL,'"drvBillingEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQCOBRAWEXZ0','50','D','10','28',NULL,'Billing Frequency',NULL,NULL,'"drvBillingFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQCOBRAWEXZ0','50','D','10','29',NULL,'Billing Type',NULL,NULL,'"drvBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQCOBRAWEXZ0','50','D','10','30',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQCOBRAWEXZ0','50','D','10','31',NULL,'SPM Subsequent Grace Period Option Type',NULL,NULL,'"CLIENTDEFAULT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQCOBRAWEXZ0','50','D','10','32',NULL,'Subsequent Grace Period Nr Of Days',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQCOBRAWEXZ0','50','D','10','33',NULL,'Benefit Group',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQCOBRAWEXZ0','50','D','10','34',NULL,'Account Structure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQCOBRAWEXZ0','50','D','10','35',NULL,'Client Custom Data',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQCOBRAWEXZ0','50','D','10','36',NULL,'Queue Welcome Letter',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQCOBRAWEXZ0','50','D','10','37',NULL,'SSOIdentifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQCOBRAWEXZ0','50','D','10','38',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQCOBRAWEXZ0','50','D','10','39',NULL,'Initial Grace Period Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQCOBRAWEXZ0','50','D','10','40',NULL,'Billing Period Seed Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQCOBRAWEXZ0','50','D','10','41',NULL,'Second Billing Period Seed Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQCOBRAWEXZ0','50','D','10','42',NULL,'Plan Category',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','15','1',NULL,'SPM Update Indicator',NULL,NULL,'"[SPMUPDATE]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','15','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','15','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','15','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','15','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','15','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','15','7',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','15','8',NULL,'First Name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','15','9',NULL,'Middle Initial',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQCOBRAWEXZ0','50','D','15','10',NULL,'Last Name ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQCOBRAWEXZ0','50','D','15','11',NULL,'SSN',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQCOBRAWEXZ0','50','D','15','12',NULL,'Individual Identifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQCOBRAWEXZ0','50','D','15','13',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQCOBRAWEXZ0','50','D','15','14',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQCOBRAWEXZ0','50','D','15','15',NULL,'Phone 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQCOBRAWEXZ0','50','D','15','16',NULL,'Address 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQCOBRAWEXZ0','50','D','15','17',NULL,'Address 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQCOBRAWEXZ0','50','D','15','18',NULL,'City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQCOBRAWEXZ0','50','D','15','19',NULL,'State Or Province',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQCOBRAWEXZ0','50','D','15','20',NULL,'Postal Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQCOBRAWEXZ0','50','D','15','21',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQCOBRAWEXZ0','50','D','15','22',NULL,'Sex',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQCOBRAWEXZ0','50','D','15','23',NULL,'DOB',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQCOBRAWEXZ0','50','D','15','24',NULL,'Tobacco Use',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQCOBRAWEXZ0','50','D','15','25',NULL,'Employee Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQCOBRAWEXZ0','50','D','15','26',NULL,'Employee Payroll Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQCOBRAWEXZ0','50','D','15','27',NULL,'Years Of Service',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQCOBRAWEXZ0','50','D','15','28',NULL,'Premium Coupon Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQCOBRAWEXZ0','50','D','15','29',NULL,'Billing Start Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQCOBRAWEXZ0','50','D','15','30',NULL,'Billing End Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQCOBRAWEXZ0','50','D','15','31',NULL,'Billing Frequency',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQCOBRAWEXZ0','50','D','15','32',NULL,'Billing Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQCOBRAWEXZ0','50','D','15','33',NULL,'Enrollment Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQCOBRAWEXZ0','50','D','15','34',NULL,'SPM Grace Period Option Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQCOBRAWEXZ0','50','D','15','35',NULL,'Grace Period Nr Of Days',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQCOBRAWEXZ0','50','D','15','36',NULL,'Benefit Group',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQCOBRAWEXZ0','50','D','15','37',NULL,'Account Structure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQCOBRAWEXZ0','50','D','15','38',NULL,'Client Custom Data',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQCOBRAWEXZ0','50','D','15','39',NULL,'Queue Welcome Letter',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQCOBRAWEXZ0','50','D','15','40',NULL,'SSOIdentifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQCOBRAWEXZ0','50','D','15','41',NULL,'Event Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQCOBRAWEXZ0','50','D','15','42',NULL,'Initial Grace Period Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQCOBRAWEXZ0','50','D','15','43',NULL,'Billing Period Seed Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EQCOBRAWEXZ0','50','D','15','44',NULL,'Second Billing Period Seed Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EQCOBRAWEXZ0','50','D','15','45',NULL,'Plan Category',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','20','1',NULL,'SPM Delete Indicator',NULL,NULL,'"[SPMDELETE]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','20','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','20','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','20','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','20','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','20','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','25','1',NULL,'SPM Insert Indicator',NULL,NULL,'"[SPMPLANINSERT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','25','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','25','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','25','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','25','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','25','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','25','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','25','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','25','9',NULL,'End Date',NULL,NULL,'"drvEndDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQCOBRAWEXZ0','50','D','25','10',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQCOBRAWEXZ0','50','D','25','11',NULL,'First Day Of',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQCOBRAWEXZ0','50','D','25','12',NULL,'Last Day Of',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQCOBRAWEXZ0','50','D','25','13',NULL,'Number Of Units',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQCOBRAWEXZ0','50','D','25','14',NULL,'Plan Bundle Name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQCOBRAWEXZ0','50','D','25','15',NULL,'Queue Plan Letter Change',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','30','1',NULL,'SPM PlanUpdate Indicator',NULL,NULL,'"[SPMPLANUPDATE]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','30','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','30','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','30','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','30','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','30','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','30','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','30','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T'',)');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','30','9',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQCOBRAWEXZ0','50','D','30','10',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UD101''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','35','1',NULL,'SPM PlanDrop Indicator',NULL,NULL,'"[SPMPLANDROP]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','35','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','35','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','35','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','35','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','35','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','35','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','35','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','35','9',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UD101''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','40','1',NULL,'SPM PlanDelete Indicator',NULL,NULL,'"[SPMPLANDELETE] "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','40','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','40','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','40','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','40','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','40','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','40','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','40','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','45','1',NULL,'SPM PlanInsert Indicator',NULL,NULL,'"[SPMPLANMEMBERSPECIFICRATEINSERT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','45','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','45','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','45','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','45','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','45','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','45','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','45','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','45','9',NULL,'Rate Start Date',NULL,NULL,'"drvRateStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQCOBRAWEXZ0','50','D','45','10',NULL,'Rate End Date',NULL,NULL,'"drvRateEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQCOBRAWEXZ0','50','D','45','11',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','50','1',NULL,'SPM PlanSpecificUpdate Indicator',NULL,NULL,'"[SPMPLANMEMBERSPECIFICRATEUPDATE]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','50','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','50','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','50','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','50','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','50','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','50','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','50','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','50','9',NULL,'oRate Start Date',NULL,NULL,'"drvoRateStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQCOBRAWEXZ0','50','D','50','10',NULL,'Rate Start Date',NULL,NULL,'"drvRateStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQCOBRAWEXZ0','50','D','50','11',NULL,'Rate End Date',NULL,NULL,'"drvRateEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQCOBRAWEXZ0','50','D','50','12',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQCOBRAWEXZ0','50','D','55','1',NULL,'SPM PlanSpecificDelete Indicator',NULL,NULL,'"[SPMPLANMEMBERSPECIFICRATEDELETE]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQCOBRAWEXZ0','50','D','55','2',NULL,'Client Name',NULL,NULL,'"Quiddity-1 Inc 36196"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQCOBRAWEXZ0','50','D','55','3',NULL,'oSSN',NULL,NULL,'"drvoSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQCOBRAWEXZ0','50','D','55','4',NULL,'oBilling Start Date',NULL,NULL,'"drvoBillingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQCOBRAWEXZ0','50','D','55','5',NULL,'oBilling Type',NULL,NULL,'"drvoBillingType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQCOBRAWEXZ0','50','D','55','6',NULL,'oBilling Frequency',NULL,NULL,'"MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQCOBRAWEXZ0','50','D','55','7',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQCOBRAWEXZ0','50','D','55','8',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQCOBRAWEXZ0','50','D','55','9',NULL,'oRate Start Date',NULL,NULL,'"drvoRateStartDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQCOBRAWEX_20220825.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208259','EMPEXPORT','OEACTIVE',NULL,'EQCOBRAWEX',NULL,NULL,NULL,'202208259','Aug 25 2022  9:36AM','Aug 25 2022  9:36AM','202208251',NULL,'','','202208251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208259','EMPEXPORT','OEPASSIVE',NULL,'EQCOBRAWEX',NULL,NULL,NULL,'202208259','Aug 25 2022  9:36AM','Aug 25 2022  9:36AM','202208251',NULL,'','','202208251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'COBRA SPM Export','202208259','EMPEXPORT','ONDEM_XOE',NULL,'EQCOBRAWEX',NULL,NULL,NULL,'202208259','Aug 25 2022  9:36AM','Aug 25 2022  9:36AM','202208251',NULL,'','','202208251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'COBRA SPM Export-Sched','202208259','EMPEXPORT','SCH_EQCOBR',NULL,'EQCOBRAWEX',NULL,NULL,NULL,'202208259','Aug 25 2022  9:36AM','Aug 25 2022  9:36AM','202208251',NULL,'','','202208251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'COBRA SPM Export-Test','202208259','EMPEXPORT','TEST_XOE',NULL,'EQCOBRAWEX',NULL,NULL,NULL,'202208259','Aug 25 2022  9:36AM','Aug 25 2022  9:36AM','202208251',NULL,'','','202208251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQCOBRAWEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQCOBRAWEX','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQCOBRAWEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQCOBRAWEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQCOBRAWEX','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','H01','dbo.U_EQCOBRAWEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D10','dbo.U_EQCOBRAWEX_drvTbl_SPMINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D15','dbo.U_EQCOBRAWEX_drvTbl_SPMUPDATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D20','dbo.U_EQCOBRAWEX_drvTbl_SPMDELETE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D25','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D30','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D35','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANDROP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D40','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANDELETE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D45','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D50','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQCOBRAWEX','D55','dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQCOBRAWEX
-----------

IF OBJECT_ID('U_dsi_BDM_EQCOBRAWEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQCOBRAWEX] (
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
-- Create table U_EQCOBRAWEX_Audit
-----------

IF OBJECT_ID('U_EQCOBRAWEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_Audit] (
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
-- Create table U_EQCOBRAWEX_AuditFields
-----------

IF OBJECT_ID('U_EQCOBRAWEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EQCOBRAWEX_DedList
-----------

IF OBJECT_ID('U_EQCOBRAWEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMDELETE
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMDELETE') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMDELETE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMINSERT
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMINSERT') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvDOB] datetime NULL,
    [drvEmployeePayrollType] varchar(6) NOT NULL,
    [drvBillingStartDate] datetime NULL,
    [drvBillingEndDate] datetime NULL,
    [drvBillingFrequency] varchar(7) NOT NULL,
    [drvBillingType] varchar(14) NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEventDate] datetime NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANDELETE
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANDELETE') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANDELETE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] datetime NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANDROP
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANDROP') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANDROP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] datetime NULL,
    [drvEffectiveDate] datetime NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANINSERT
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANINSERT') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] varchar(30) NULL,
    [drvoRateStartDate] varchar(30) NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] datetime NULL,
    [drvRateStartDate] datetime NULL,
    [drvRateEndDate] varchar(1) NOT NULL,
    [drvRate] money NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] varchar(30) NULL,
    [drvoRateStartDate] varchar(30) NULL,
    [drvRateStartDate] varchar(1) NOT NULL,
    [drvRateEndDate] varchar(1) NOT NULL,
    [drvRate] varchar(1) NOT NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvStartDate] datetime NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvEffectiveDate] datetime NULL
);

-----------
-- Create table U_EQCOBRAWEX_drvTbl_SPMUPDATE
-----------

IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMUPDATE') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_drvTbl_SPMUPDATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvoSSN] char(11) NULL,
    [drvoBillingStartDate] datetime NULL,
    [drvoBillingType] varchar(14) NULL
);

-----------
-- Create table U_EQCOBRAWEX_EEList
-----------

IF OBJECT_ID('U_EQCOBRAWEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQCOBRAWEX_File
-----------

IF OBJECT_ID('U_EQCOBRAWEX_File') IS NULL
CREATE TABLE [dbo].[U_EQCOBRAWEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQCOBRAWEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Quiddity Engineering LLC

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 08/25/2022
Service Request Number: TekP-2022-06-10-01

Purpose: COBRA SPM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQCOBRAWEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQCOBRAWEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQCOBRAWEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQCOBRAWEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQCOBRAWEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQCOBRAWEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQCOBRAWEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQCOBRAWEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQCOBRAWEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQCOBRAWEX', 'SCH_EQCOBR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQCOBRAWEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQCOBRAWEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EQCOBRAWEX';

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
    DELETE FROM dbo.U_EQCOBRAWEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQCOBRAWEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EQCOBRAWEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_AuditFields;
    CREATE TABLE dbo.U_EQCOBRAWEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EQCOBRAWEX_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EQCOBRAWEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EQCOBRAWEX_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EQCOBRAWEX_AuditFields VALUES ('EmpDed','eedBenStopDate');
    INSERT INTO dbo.U_EQCOBRAWEX_AuditFields VALUES ('EmpDed','eedBenOption');
    INSERT INTO dbo.U_EQCOBRAWEX_AuditFields VALUES ('EmpDed','eedDedCode');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EQCOBRAWEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_Audit;
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
    INTO dbo.U_EQCOBRAWEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EQCOBRAWEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EQCOBRAWEX_Audit ON dbo.U_EQCOBRAWEX_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EQCOBRAWEX_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EQCOBRAWEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DAE,DEN,DNE,OAE,OAEDP,OAESH,HB1,HB1DP,HDHPB,SHB,HDHPM,HM1,HM1DP,SHM,VAE,VIS,VSE,FSA,LFP,MFP';

    IF OBJECT_ID('U_EQCOBRAWEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQCOBRAWEX_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');


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
    -- Build Working Tables
    --==========================================
    
    ---- ================================================
    ----  Insert into BDM Reason Missing Codes for Terms
    ---- ================================================

    -- INSERT INTO [dbo].[U_dsi_BDM_EQCOBRAWEX]

    --(       [BdmRecType]

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

    --       ,[BdmBenOptionDate]

    --       ,[BdmChangeReason]

    --       ,[BdmStartDate]

    --       ,[BdmStopDate]

    --       ,[BdmIsCobraCovered]

    --       ,[BdmCobraReason]

    --       ,[BdmDateOfCOBRAEvent]
            
    --       ,[BdmIsChildOldest]

    --       ,[BdmUSGField1]

    --       ,[BdmUSGField2]

    --       ,[BdmUSGDate1]

    --       ,[BdmUSGDate2]

    --       ,[BdmTVStartDate]

    --       ,[BdmSessionID]

    --       ,[BdmEEAmt]

    --       ,[BdmEECalcRateOrPct]

    --       ,[BdmEEGoalAmt]

    --       ,[BdmEEMemberOrCaseNo]

    --       ,[BdmERAmt]

    --       ,[BdmNumSpouses]

    --       ,[BdmNumChildren]
            
    --       ,[BdmNumDomPartners]

    --       ,[BdmNumDPChildren]

            
    --)

    --Select rectype = 'EMP'

    --    ,EedCoid

    --    ,EedEEID

    --    ,''

    --    ,''

    --    ,''

    --    ,'Deduction termed within/after date range'

    --    ,'Emp'

    --    , EepDateOfBirth

    --    ,EedDedCode

    --    ,EedBenOption
        
    --    ,eedBenStatus

    --    ,EedBenStartDate

    --    ,EedBenStopDate

    --    ,EedBenStatusDate

    --    ,EedBenOptionDate

        
    --    ,EedChangeReason

    --    ,EedStartDate

    --    ,EedStopDate

    --    ,''

    --    ,EedCobraReason

    --    ,EedDateOfCOBRAEvent

    --    ,''

    --    ,EedUSGField1

    --    ,EedUSGField2

    --    ,EedUSGDate1

    --    ,EedUSGDate2

    --    ,EedTVStartDate

    --    ,EedSessionID

    --    ,eedeeamt

    --    ,EedBenAmtRateOrPct
        
    --    ,EedEEGoalAmt

    --    ,EedEEMemberOrCaseNo

    --    ,EedERAmt

    --    ,EedNumSpouses

    --    ,EedNumChildren    

    --    ,EedNumDomPartners

    --    ,EedNumDPChildren
        
    --FROM dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --     ON EepEEID =EedEEID
    --  Where  EedFormatCode =  'EQCOBRAWEX'
    --    and eeddedcode in ('DAE','DEN','DNE','OAE','OAEDP','OAESH','HB1','HB1DP','HDHPB','SHB','HDHPM','HM1','HM1DP','SHM','VAE','VIS','VSE','FSA','LFP','MFP')
    --    and EedValidForExport = 'N'
    --    and eedbenstatus = 'T'
    --    and eedstopdate BETWEEN dateadd(D, -30, @StartDate)  AND @EndDate



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMINSERT
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvSSN = eepSSN
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvGender = CASE WHEn EepGender IN ( 'M','F') THEN EepGender ELSE 'U' END
        ,drvDOB = EepDateOfBirth
        ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvBillingStartDate = CASE WHEN  EecEmplStatus = 'L' THEN BdmBenStatusDate
                                    WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN  CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                  END
        ,drvBillingEndDate = CASE WHEn EecEmplStatus = 'L' THEn  BdmBenStatusDate + 365 
                                  WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN  CONVERT(VARCHAR, DATEADD(day, 365, bdmBenStopDate), 101)
                                 END
        ,drvBillingFrequency = 'MONTHLY'
        ,drvBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                               WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvEnrollmentDate = EshStatusStartDate
        ,drvEventDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate 
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN   CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMINSERT
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate, max(EshStatusStartDate) AS EshStatusStartDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMUPDATE
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMUPDATE','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMUPDATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                     WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN  CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                  END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMUPDATE
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate, max(EshStatusStartDate) AS EshStatusStartDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMDELETE
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMDELETE','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMDELETE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate =  CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                      WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                    END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMDELETE
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate, max(EshStatusStartDate) AS EshStatusStartDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANINSERT
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate =  CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                      WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                    END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvEndDate = ''
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANINSERT
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate =  CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
        ,drvEffectiveDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                 WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                               END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANUPDATE
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate, max(EshStatusStartDate) AS EshStatusStartDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANDROP
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANDROP','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANDROP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                     WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                  END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvEffectiveDate = EdhEffDate
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANDROP
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
    LEFT JOIN (   SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('DPPO','DDMO','MEPO','MHSA','MPPO','VIS','FSA') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANDELETE
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANDELETE','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANDELETE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                     WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                    END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                          END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANDELETE
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                     WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                    END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                             WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                          END
        ,drvRateStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                 WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                              END
        ,drvRateEndDate = ''
        ,drvRate = CASE WHEN bdmDedCode IN ( 'FSA', 'FSA', 'MFP' ) THEN 2*(bdmEEAMT) END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEINSERT
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                     WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                    END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate = CASE WHEN EecEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, BdmBenStatusDate), 101) 
                             WHEN EecEmplStatus = 'T'  THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvoRateStartDate = CASE WHEN EecEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, BdmBenStatusDate), 101) 
                             WHEN EecEmplStatus = 'T'  THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvRateStartDate = ''
        ,drvRateEndDate = ''
        ,drvRate = ''
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEUPDATE
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE
    ---------------------------------
    IF OBJECT_ID('U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE','U') IS NOT NULL
        DROP TABLE dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvoSSN = eepSSN
        ,drvoBillingStartDate = CASE WHEN EecEmplStatus = 'L' THEN BdmBenStatusDate
                                     WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                                    END
        ,drvoBillingType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                                WHEN EecEmplStatus = 'T' and EshEmplStatus = 'L' THEN 'LEAVEOFABSENCE'
                              END
        ,drvPlanName = CASE WHEN bdmdedcode in ( 'DAE', 'DEN', 'DNE' ) THEN 'DB Cigna Dental'
                            WHEN bdmdedcode in ('OAE', 'OAEDP', 'OAESH' ) THEN 'DB Cigna Medical High OAP Plan'
                            WHEN bdmdedcode in ('HB1', 'HB1DP', 'HDHPB', 'SHB') THEN 'DB Cigna Medical HSA Base Plan'
                            WHEN bdmdedcode in ('HDHPM', 'HM1', 'HM1DP', 'SHM') THEN 'DB Cigna Medical HSA Mid Plan'
                            WHEN bdmdedcode in ('VAE', 'VIS', 'VSE' ) THEN 'DB Cigna Vision'
                            WHEN bdmdedcode in ('FSA', 'LFP', 'MFP') THEn 'DB WEX FSA'
                        END
        ,drvStartDate = CASE WHEN EecEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, BdmBenStatusDate), 101) 
                             WHEN EecEmplStatus = 'T'  THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                            END
        ,drvoRateStartDate = CASE WHEN EecEmplStatus = 'L' THEN CONVERT(VARCHAR, DATEADD(day, 1, BdmBenStatusDate), 101) 
                                  WHEN EecEmplStatus = 'T'  THEN CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                              END
    INTO dbo.U_EQCOBRAWEX_drvTbl_SPMPLANMEMBERSPECIFICRATEDELETE
    FROM dbo.U_EQCOBRAWEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
    JOIN dbo.U_dsi_BDM_EQCOBRAWEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEQCOBRAWEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQCOBRAWEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EQCOBRAWEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208181'
       ,expStartPerControl     = '202208181'
       ,expLastEndPerControl   = '202208259'
       ,expEndPerControl       = '202208259'
WHERE expFormatCode = 'EQCOBRAWEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEQCOBRAWEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EQCOBRAWEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQCOBRAWEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQCOBRAWEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQCOBRAWEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQCOBRAWEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQCOBRAWEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQCOBRAWEX', 'UseFileName', 'V', 'Y'


-- End ripout