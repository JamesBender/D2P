/**********************************************************************************

ECUSEQUDEM: Equifax Demographic

FormatCode:     ECUSEQUDEM
Project:        Equifax Demographic
Client ID:      CIS1000
Date/time:      2022-12-05 13:17:52.733
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPCISIN
Web Filename:   CIS1000_35B05_EEHISTORY_ECUSEQUDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECUSEQUDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_ECUSEQUDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECUSEQUDEM'


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
WHERE FormatCode = 'ECUSEQUDEM'
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
WHERE ExpFormatCode = 'ECUSEQUDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECUSEQUDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECUSEQUDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECUSEQUDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECUSEQUDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECUSEQUDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECUSEQUDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECUSEQUDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECUSEQUDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECUSEQUDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECUSEQUDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECUSEQUDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECUSEQUDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECUSEQUDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUSEQUDEM];
GO
IF OBJECT_ID('U_ECUSEQUDEM_File') IS NOT NULL DROP TABLE [dbo].[U_ECUSEQUDEM_File];
GO
IF OBJECT_ID('U_ECUSEQUDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECUSEQUDEM_EEList];
GO
IF OBJECT_ID('U_ECUSEQUDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECUSEQUDEM_drvTbl];
GO
IF OBJECT_ID('U_ECUSEQUDEM_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECUSEQUDEM_DedList];
GO
IF OBJECT_ID('U_ECUSEQUDEM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECUSEQUDEM_AuditFields];
GO
IF OBJECT_ID('U_ECUSEQUDEM_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECUSEQUDEM_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECUSEQUDEM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECUSEQUDEM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECUSEQUDEM','Equifax Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECUSEQUDEMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECUSEQUDEMZ0','50','H','01','1',NULL,'EmployeeUniqueIdentifier',NULL,NULL,'"EmployeeUniqueIdentifier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECUSEQUDEMZ0','50','H','01','2',NULL,'ControlledGroupCode',NULL,NULL,'"ControlledGroupCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECUSEQUDEMZ0','50','H','01','3',NULL,'EffectiveDateTime',NULL,NULL,'"EffectiveDateTime"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECUSEQUDEMZ0','50','H','01','4',NULL,'DataSource',NULL,NULL,'"DataSource"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECUSEQUDEMZ0','50','H','01','5',NULL,'IsInvalid',NULL,NULL,'"IsInvalid"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECUSEQUDEMZ0','50','H','01','6',NULL,'TransactionType',NULL,NULL,'"TransactionType"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECUSEQUDEMZ0','50','H','01','7',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECUSEQUDEMZ0','50','H','01','8',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECUSEQUDEMZ0','50','H','01','9',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECUSEQUDEMZ0','50','H','01','10',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECUSEQUDEMZ0','50','H','01','11',NULL,'MiddleName',NULL,NULL,'"MiddleName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECUSEQUDEMZ0','50','H','01','12',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECUSEQUDEMZ0','50','H','01','13',NULL,'HomeAddressLine1',NULL,NULL,'"HomeAddressLine1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECUSEQUDEMZ0','50','H','01','14',NULL,'HomeAddressLine2',NULL,NULL,'"HomeAddressLine2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECUSEQUDEMZ0','50','H','01','15',NULL,'HomeAddressCity',NULL,NULL,'"HomeAddressCity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECUSEQUDEMZ0','50','H','01','16',NULL,'HomeAddressState',NULL,NULL,'"HomeAddressState"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECUSEQUDEMZ0','50','H','01','17',NULL,'HomeAddressZIP',NULL,NULL,'"HomeAddressZIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECUSEQUDEMZ0','50','H','01','18',NULL,'HomeAddressCountry',NULL,NULL,'"HomeAddressCountry"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECUSEQUDEMZ0','50','H','01','19',NULL,'ACAEmployeeDesignationCode',NULL,NULL,'"ACAEmployeeDesignationCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECUSEQUDEMZ0','50','H','01','20',NULL,'ACAEmployeeCategoryCode',NULL,NULL,'"ACAEmployeeCategoryCode"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECUSEQUDEMZ0','50','H','01','21',NULL,'DateOfBirth',NULL,NULL,'"DateOfBirth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECUSEQUDEMZ0','50','H','01','22',NULL,'UserID',NULL,NULL,'"UserID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECUSEQUDEMZ0','50','H','01','23',NULL,'DefaultPIN',NULL,NULL,'"DefaultPIN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECUSEQUDEMZ0','50','H','01','24',NULL,'AdjustedHireDate',NULL,NULL,'"AdjustedHireDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECUSEQUDEMZ0','50','H','01','25',NULL,'WorkNumberDivision',NULL,NULL,'"WorkNumberDivision"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECUSEQUDEMZ0','50','H','01','26',NULL,'EmailAddress',NULL,NULL,'"EmailAddress"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECUSEQUDEMZ0','50','H','01','27',NULL,'PrimaryPhoneNumber',NULL,NULL,'"PrimaryPhoneNumber"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECUSEQUDEMZ0','50','D','10','1',NULL,'EmployeeUniqueIdentifier',NULL,NULL,'"drvEmployeeUniqueIdentifier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECUSEQUDEMZ0','50','D','10','2',NULL,'ControlledGroupCode',NULL,NULL,'"drvControlledGroupCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECUSEQUDEMZ0','50','D','10','3',NULL,'EffectiveDateTime',NULL,NULL,'"drvEffectiveDateTime"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECUSEQUDEMZ0','50','D','10','4',NULL,'DataSource',NULL,NULL,'"drvDataSource"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECUSEQUDEMZ0','50','D','10','5',NULL,'IsInvalid',NULL,NULL,'"drvIsInvalid"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECUSEQUDEMZ0','50','D','10','6',NULL,'TransactionType',NULL,NULL,'"drvTransactionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECUSEQUDEMZ0','50','D','10','7',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECUSEQUDEMZ0','50','D','10','8',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECUSEQUDEMZ0','50','D','10','9',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECUSEQUDEMZ0','50','D','10','10',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECUSEQUDEMZ0','50','D','10','11',NULL,'MiddleName',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECUSEQUDEMZ0','50','D','10','12',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECUSEQUDEMZ0','50','D','10','13',NULL,'HomeAddressLine1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECUSEQUDEMZ0','50','D','10','14',NULL,'HomeAddressLine2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECUSEQUDEMZ0','50','D','10','15',NULL,'HomeAddressCity',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECUSEQUDEMZ0','50','D','10','16',NULL,'HomeAddressState',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECUSEQUDEMZ0','50','D','10','17',NULL,'HomeAddressZIP',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECUSEQUDEMZ0','50','D','10','18',NULL,'HomeAddressCountry',NULL,NULL,'"drvAddressCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECUSEQUDEMZ0','50','D','10','19',NULL,'ACAEmployeeDesignationCode',NULL,NULL,'"drvACAEmployeeDesignationCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECUSEQUDEMZ0','50','D','10','20',NULL,'ACAEmployeeCategoryCode',NULL,NULL,'"drvACAEmployeeCategoryCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECUSEQUDEMZ0','50','D','10','21',NULL,'DateOfBirth',NULL,NULL,'"DateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECUSEQUDEMZ0','50','D','10','22',NULL,'UserID',NULL,NULL,'"UserID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECUSEQUDEMZ0','50','D','10','23',NULL,'DefaultPIN',NULL,NULL,'"DefaultPIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECUSEQUDEMZ0','51','D','10','24',NULL,'AdjustedHireDate',NULL,NULL,'"AdjustedHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECUSEQUDEMZ0','52','D','10','25',NULL,'WorkNumberDivision',NULL,NULL,'"WorkNumberDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECUSEQUDEMZ0','53','D','10','26',NULL,'EmailAddress',NULL,NULL,'"EmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECUSEQUDEMZ0','54','D','10','27',NULL,'PrimaryPhoneNumber',NULL,NULL,'"PrimaryPhoneNumber"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECUSEQUDEM_20221205.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208099','EMPEXPORT','OEACTIVE',NULL,'ECUSEQUDEM',NULL,NULL,NULL,'202208099','Aug  9 2022 10:56AM','Aug  9 2022 10:56AM','202208091',NULL,'','','202208091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208099','EMPEXPORT','OEPASSIVE',NULL,'ECUSEQUDEM',NULL,NULL,NULL,'202208099','Aug  9 2022 10:56AM','Aug  9 2022 10:56AM','202208091',NULL,'','','202208091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Equifax Demographic','202208099','EMPEXPORT','ONDEM_XOE',NULL,'ECUSEQUDEM',NULL,NULL,NULL,'202208099','Aug  9 2022 10:56AM','Aug  9 2022 10:56AM','202208091',NULL,'','','202208091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',UVGMB',NULL,NULL,NULL,'Equifax Demo SCH','202208099','EMPEXPORT','SCH_ECUSEQ',NULL,'ECUSEQUDEM',NULL,NULL,NULL,'202208099','Aug  9 2022 10:56AM','Aug  9 2022 10:56AM','202208091',NULL,'','','202208091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OEXEV,UVGMB,39NL5,UVGSI',NULL,NULL,NULL,'Equifax Demographic-Test','202211291','EMPEXPORT','TEST_XOE','Dec  5 2022 12:00AM','ECUSEQUDEM',NULL,NULL,NULL,'202211291','Nov 29 2022 12:00AM','Dec 30 1899 12:00AM','201910011','2903','','','201910011',dbo.fn_GetTimedKey(),NULL,'us3kEpCIS1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUSEQUDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUSEQUDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUSEQUDEM','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUSEQUDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUSEQUDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUSEQUDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUSEQUDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUSEQUDEM','D10','dbo.U_ECUSEQUDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECUSEQUDEM
-----------

IF OBJECT_ID('U_dsi_BDM_ECUSEQUDEM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECUSEQUDEM] (
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
-- Create table U_ECUSEQUDEM_Audit
-----------

IF OBJECT_ID('U_ECUSEQUDEM_Audit') IS NULL
CREATE TABLE [dbo].[U_ECUSEQUDEM_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audFullTimePartTimeChange] varchar(1) NOT NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audLOA] varchar(1) NOT NULL
);

-----------
-- Create table U_ECUSEQUDEM_AuditFields
-----------

IF OBJECT_ID('U_ECUSEQUDEM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECUSEQUDEM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECUSEQUDEM_DedList
-----------

IF OBJECT_ID('U_ECUSEQUDEM_DedList') IS NULL
CREATE TABLE [dbo].[U_ECUSEQUDEM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECUSEQUDEM_drvTbl
-----------

IF OBJECT_ID('U_ECUSEQUDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECUSEQUDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(11) NULL,
    [drvEmployeeUniqueIdentifier] char(11) NULL,
    [drvControlledGroupCode] varchar(3) NOT NULL,
    [drvEffectiveDateTime] nvarchar(4000) NULL,
    [drvDataSource] varchar(3) NOT NULL,
    [drvIsInvalid] varchar(2) NOT NULL,
    [drvTransactionType] varchar(3) NULL,
    [drvSSN] char(11) NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvNameFirst] varchar(6000) NULL,
    [drvNameLast] varchar(6000) NULL,
    [drvNameMiddle] varchar(6000) NULL,
    [drvSuffix] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(6000) NULL,
    [drvAddressState] varchar(6000) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvAddressCountry] varchar(3) NULL,
    [drvACAEmployeeDesignationCode] varchar(2) NULL,
    [drvACAEmployeeCategoryCode] varchar(3) NOT NULL,
    [DateOfBirth] datetime NULL,
    [UserID] char(9) NULL,
    [DefaultPIN] int NULL,
    [AdjustedHireDate] datetime NULL,
    [WorkNumberDivision] varchar(1) NOT NULL,
    [EmailAddress] varchar(50) NOT NULL,
    [PrimaryPhoneNumber] varchar(50) NOT NULL
);

-----------
-- Create table U_ECUSEQUDEM_EEList
-----------

IF OBJECT_ID('U_ECUSEQUDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_ECUSEQUDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECUSEQUDEM_File
-----------

IF OBJECT_ID('U_ECUSEQUDEM_File') IS NULL
CREATE TABLE [dbo].[U_ECUSEQUDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUSEQUDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cision US

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 08/09/2022
Service Request Number: TekP-2022-05-25-01

Purpose: Equifax Demographic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECUSEQUDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECUSEQUDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECUSEQUDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECUSEQUDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECUSEQUDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUSEQUDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUSEQUDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUSEQUDEM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUSEQUDEM', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUSEQUDEM', 'SCH_ECUSEQ';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECUSEQUDEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECUSEQUDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECUSEQUDEM';

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
    DELETE FROM dbo.U_ECUSEQUDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECUSEQUDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECUSEQUDEM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECUSEQUDEM_AuditFields;
    CREATE TABLE dbo.U_ECUSEQUDEM_AuditFields (aTableName varchar(30),aFieldName varchar(30));
       INSERT INTO dbo.U_ECUSEQUDEM_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_ECUSEQUDEM_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ECUSEQUDEM_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_ECUSEQUDEM_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ECUSEQUDEM_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECUSEQUDEM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECUSEQUDEM_Audit;
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
        ,audFullTimePartTimeChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecFullTimeOrPartTime' AND ISNULL(audNewValue, '') IN( 'P','F') AND ISNULL(audOldValue, '') IN ('P', 'F') THEN 'Y' ELSE 'N' END
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audLOA = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue, '') IN( 'L','A') AND ISNULL(audOldValue, '') IN ('L', 'A') THEN 'Y' ELSE 'N' END

   INTO dbo.U_ECUSEQUDEM_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECUSEQUDEM_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction = 'Update';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECUSEQUDEM_Audit ON dbo.U_ECUSEQUDEM_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECUSEQUDEM_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECUSEQUDEM_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_ECUSEQUDEM_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_ECUSEQUDEM_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_ECUSEQUDEM_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    --IF @ExportCode LIKE '%PASSIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    --END;

    --IF @ExportCode LIKE '%ACTIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    --END;


    -- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECUSEQUDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECUSEQUDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECUSEQUDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvEmployeeUniqueIdentifier = EepSSN
        ,drvControlledGroupCode = 'CGX'
          ,drvEffectiveDateTime = FORMaT((CASE WHEN (EecDateOfLastHire <> EecDateOfOriginalHire AND EecJobChangeReason = '101') OR (EecHireSource = 'REHIRE')  THEN  EecDateOfLastHire
                                      WHEN EecEmplStatus IN ( 'T', 'S','R')  THEN EecDateOfTermination 
                                      WHEN audNewValue IN ( 'T', 'S','R') THEN audDateTime
                                      WHEN audLOA  IN ( 'Y') THEN audDateTime
                                      WHEN audFullTimePartTimeChange = 'Y' THEN audDateTime
                                    Else EecDateOfOriginalHire
                                END), 'MM/dd/yyyy HH:mm:ss')
        
                                --CASE WHEN audFieldName = 'EecEmplStatus'  AND audNewValue IN ( 'T', 'S', 'L','R') THEN auddatetime  
                                --    ELSE 
                                --        GetDate() --CASE WHEN EecEmplStatus = 'A' THEN EecDateOfOriginalHire ELSE EecDateOfTermination END
                                --    END
        ,drvDataSource = 'UKG'
        ,drvIsInvalid =   'No' --- CASE WHEN EecEmplStatus IN ('A','T','S','L','R') THEN 'Yes' ELSE 'No' END
        ,drvTransactionType = CASE WHEN EecEmplStatus IN ( 'A', 'L')  THEN 'HIR'
                                   WHEN EecEmplStatus = 'T' THEN 'TER'
                                   WHEN EecEmplStatus IN ( 'R', 'S' )  THEN 'JOB'
                                END

        ,drvSSN = eepSSN
        ,drvStatus = CASE  WHEN EecEmplStatus = 'A' THEN 'A'
                           WHEn EecEmplStatus = 'T' THEN 'T' 
                           Else 'I' 
                          END
        ,drvNameFirst = dbo.dsi_fnRemoveChars('.,/-',EepNameFirst)
        ,drvNameLast = dbo.dsi_fnRemoveChars('.,/-',Replace(EepNameLast,'%é%', 'e'))
        ,drvNameMiddle = dbo.dsi_fnRemoveChars('.,/-',Case When LEFT(EepNameMiddle,1) = 'Z' THEn ''  ELSE LEFT(EepNameMiddle,1) END)
        ,drvSuffix = ''
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-@+=',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-@+=',EepAddressLine2)
        ,drvAddressCity  = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvAddressState = dbo.dsi_fnRemoveChars('.,/-',Left(eepAddressState, 2))
        ,drvZipCode = EepAddressZipCode
        ,drvAddressCountry =  CASE WHEN EepAddressCountry = 'USA' THEN 'US' else EepAddressCountry END --- 12/5/2022 added else EepAddressCountry so that those in other countries populate who are REG and in the COID
        ,drvACAEmployeeDesignationCode = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FT'
                                              WHEN EecFullTimeOrPartTime = 'P' THEN 'PT'
                                        END
        ,drvACAEmployeeCategoryCode = 'ECX'
        ,DateOfBirth = EepDateOfBirth
        ,UserID = EecEmpno
        ,DefaultPIN = Year(EepDateOfBirth)
        ,AdjustedHireDate = EecDateOfLastHire
        ,WorkNumberDivision = ''
        ,EmailAddress =  ISNULL(CASE WHEN EepAddressEMail is not null then eepAddressEMail ELSE EepAddressEmailAlternate END , 'donotreply@cision.com') 
        ,PrimaryPhoneNumber =  CASE WHEN (Ltrim(rtrim(EepPhoneHomeNumber)) Like '%+%' or LEN(EepPhoneHomeNumber) > 10 )  then '0000000000' 
                                    WHEN ((EepPhoneHomeNumber)= '' or Ltrim(rtrim(EepPhoneHomeNumber)) = '0' ) then '5555555555'
                                    WHEN Ltrim(rtrim(EepPhoneHomeNumber)) <> '0'  then isnull(eepPhoneHomeNumber,'5555555555')
                                 ELSE isnull((Select efoPhoneNumber FROM dbo.LodEMPhon WITH (NOLOCK) where efoPhoneType = 'CEL' and efoeeid = xeeid), '5555555555')
                                END
    INTO dbo.U_ECUSEQUDEM_drvTbl
    FROM dbo.U_ECUSEQUDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
       --and eepAddressCountry = 'USA' -- commented out to include the emps the company wanted to pull outside the US
  Left Join dbo.U_ECUSEQUDEM_Audit WITH (NOLOCK)
       ON AudEEID = xEEID 
       and audKey2 = xCoID
       Where  eeceetype = 'REG' and xCoID in ('OEXEV','UVGMB','39NL5','UVGS')
    --JOIN dbo.U_dsi_BDM_ECUSEQUDEM WITH (NOLOCK)
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
 
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
ALTER VIEW dbo.dsi_vwECUSEQUDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECUSEQUDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECUSEQUDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208021'
       ,expStartPerControl     = '202208021'
       ,expLastEndPerControl   = '202208099'
       ,expEndPerControl       = '202208099'
WHERE expFormatCode = 'ECUSEQUDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECUSEQUDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECUSEQUDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECUSEQUDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECUSEQUDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECUSEQUDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECUSEQUDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECUSEQUDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECUSEQUDEM', 'UseFileName', 'V', 'Y'


-- End ripout