/**********************************************************************************

ECYCCOBQBT: Connect Your Care Cobra QB TEST

FormatCode:     ECYCCOBQBT
Project:        Connect Your Care Cobra QB TEST
Client ID:      MGP1000
Date/time:      2022-02-04 13:49:25.010
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPMGPI
Web Filename:   MGP1000_BLF99_EEHISTORY_ECYCCOBQBT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECYCCOBQBT_SavePath') IS NOT NULL DROP TABLE dbo.U_ECYCCOBQBT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECYCCOBQBT'


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
WHERE FormatCode = 'ECYCCOBQBT'
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
WHERE ExpFormatCode = 'ECYCCOBQBT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECYCCOBQBT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECYCCOBQBT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECYCCOBQBT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECYCCOBQBT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECYCCOBQBT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECYCCOBQBT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECYCCOBQBT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECYCCOBQBT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECYCCOBQBT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECYCCOBQBT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECYCCOBQBT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECYCCOBQBT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECYCCOBQBT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCOBQBT];
GO
IF OBJECT_ID('U_ECYCCOBQBT_File') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_File];
GO
IF OBJECT_ID('U_ECYCCOBQBT_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_EEList];
GO
IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QB];
GO
IF OBJECT_ID('U_dsi_BDM_ECYCCOBQBT') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECYCCOBQBT];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECYCCOBQBT','Connect Your Care Cobra QB TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECYCCOBQBTZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','H','02','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','H','02','2',NULL,'Version Number',NULL,NULL,'"1.2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','20','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCOBQBTZ0','50','D','20','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCCOBQBTZ0','50','D','20','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECYCCOBQBTZ0','50','D','20','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECYCCOBQBTZ0','50','D','20','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECYCCOBQBTZ0','50','D','20','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECYCCOBQBTZ0','50','D','20','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECYCCOBQBTZ0','50','D','20','9',NULL,'IndividualID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECYCCOBQBTZ0','50','D','20','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECYCCOBQBTZ0','50','D','20','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECYCCOBQBTZ0','50','D','20','12',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECYCCOBQBTZ0','50','D','20','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECYCCOBQBTZ0','50','D','20','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECYCCOBQBTZ0','50','D','20','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECYCCOBQBTZ0','50','D','20','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECYCCOBQBTZ0','50','D','20','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECYCCOBQBTZ0','50','D','20','18',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECYCCOBQBTZ0','50','D','20','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECYCCOBQBTZ0','50','D','20','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECYCCOBQBTZ0','50','D','20','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECYCCOBQBTZ0','50','D','20','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECYCCOBQBTZ0','50','D','20','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECYCCOBQBTZ0','50','D','20','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECYCCOBQBTZ0','50','D','20','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECYCCOBQBTZ0','50','D','20','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECYCCOBQBTZ0','50','D','20','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECYCCOBQBTZ0','50','D','20','28',NULL,'TobaccoUse',NULL,NULL,'"drvTobaccoUse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECYCCOBQBTZ0','50','D','20','29',NULL,'EmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECYCCOBQBTZ0','50','D','20','30',NULL,'EmployeePayrollType',NULL,NULL,'"drvEmployeePayrollType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECYCCOBQBTZ0','50','D','20','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECYCCOBQBTZ0','50','D','20','32',NULL,'PremiumCouponType',NULL,NULL,'"PREMIUMNOTICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECYCCOBQBTZ0','50','D','20','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECYCCOBQBTZ0','50','D','20','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECYCCOBQBTZ0','50','D','20','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECYCCOBQBTZ0','50','D','20','36',NULL,'AllowMemberSSO',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECYCCOBQBTZ0','50','D','20','37',NULL,'AllowMemberSSO',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECYCCOBQBTZ0','50','D','20','38',NULL,'AllowMemberSSO',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECYCCOBQBTZ0','50','D','20','39',NULL,'AllowMemberSSO',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','30','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCOBQBTZ0','50','D','30','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCCOBQBTZ0','50','D','30','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECYCCOBQBTZ0','50','D','30','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECYCCOBQBTZ0','50','D','30','6',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECYCCOBQBTZ0','50','D','30','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','40','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCOBQBTZ0','50','D','40','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCCOBQBTZ0','50','D','40','4',NULL,'NumberOfUnits',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','50','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCOBQBTZ0','50','D','50','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECYCCOBQBTZ0','50','D','50','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECYCCOBQBTZ0','50','D','50','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECYCCOBQBTZ0','50','D','50','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECYCCOBQBTZ0','50','D','50','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECYCCOBQBTZ0','50','D','50','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECYCCOBQBTZ0','50','D','50','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECYCCOBQBTZ0','50','D','50','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECYCCOBQBTZ0','50','D','50','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvIsAddressSame"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECYCCOBQBTZ0','50','D','50','12',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECYCCOBQBTZ0','50','D','50','13',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECYCCOBQBTZ0','50','D','50','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECYCCOBQBTZ0','50','D','50','15',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECYCCOBQBTZ0','50','D','50','16',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECYCCOBQBTZ0','50','D','50','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECYCCOBQBTZ0','50','D','50','18',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECYCCOBQBTZ0','50','D','50','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECYCCOBQBTZ0','50','D','50','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECYCCOBQBTZ0','50','D','50','21',NULL,'IsQMCSO',NULL,NULL,'"drvISQMCO"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','70','1',NULL,'Record Identifier',NULL,NULL,'"drvRecordIdentifierQBS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','70','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECYCCOBQBTZ0','50','D','80','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECYCCOBQBTZ0','50','D','80','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECYCCOBQBTZ0','50','D','80','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECYCCOBQBT_20220204.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'CYC Cobra QB-OnDem TEST','202202031','EMPEXPORT','ONDEM_XOE','Feb  3 2022  3:20PM','ECYCCOBQBT',NULL,NULL,NULL,'202202031','Feb  3 2022 12:00AM','Jan 30 2022 12:00AM','202108011','301','','','202108011',dbo.fn_GetTimedKey(),NULL,'us3cPeMGP1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'CYC Cobra QB-Sched TEST','202004229','EMPEXPORT','SCH_ECYCCO',NULL,'ECYCCOBQBT',NULL,NULL,NULL,'202201149','Jan 13 2016  8:53AM','Jan 13 2016  8:53AM','202201071',NULL,NULL,NULL,'202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECYCCOBQBT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','H02','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D20','dbo.U_ECYCCOBQBT_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D30','dbo.U_ECYCCOBQBT_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D40','dbo.U_ECYCCOBQBT_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D50','dbo.U_ECYCCOBQBT_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D60','dbo.U_ECYCCOBQBT_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D70','dbo.U_ECYCCOBQBT_drvTbl_QBMSI WITH (NOLOCK)','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECYCCOBQBT','D80','dbo.U_ECYCCOBQBT_drvTbl_QBMSRI WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECYCCOBQBT
-----------

IF OBJECT_ID('U_dsi_BDM_ECYCCOBQBT') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECYCCOBQBT] (
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
-- Create table U_ECYCCOBQBT_drvTbl_QB
-----------

IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(20) NOT NULL,
    [drvClientDivName] varchar(33) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(50) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCountry] varchar(8000) NULL,
    [drvGender] char(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmployeeType] varchar(7) NOT NULL,
    [drvEmployeePayrollType] varchar(9) NOT NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_ECYCCOBQBT_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(15) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(13) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_ECYCCOBQBT_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(46) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(18) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_ECYCCOBQBT_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(201) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvAgedOut] varchar(1) NOT NULL
);

-----------
-- Create table U_ECYCCOBQBT_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(46) NULL,
    [drvRate] money NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_ECYCCOBQBT_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(46) NULL,
    [drvCoverageLevel] varchar(18) NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_ECYCCOBQBT_EEList
-----------

IF OBJECT_ID('U_ECYCCOBQBT_EEList') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECYCCOBQBT_File
-----------

IF OBJECT_ID('U_ECYCCOBQBT_File') IS NULL
CREATE TABLE [dbo].[U_ECYCCOBQBT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECYCCOBQBT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MGPI Processing

Created By: Carrie McDowell
Business Analyst: Van Amundson
Create Date: 10/27/2020
Service Request Number: N/A-Partner Direct   ***WEB***

Purpose: Connect Your Care Cobra QB Export

Revision History
----------------
Update By            Date           Request Num           Desc
Darren Collard       01/20/2022     TekP-2021-12-10-0006  Update Client Division Name Logic to use OrgLevel3; Add "Medical PPO"/"Medical HDHP"
Darren Collard       02/04/2022     TekP-2021-12-10-0006  Append "- age 26 only" to "Medical PPO"/"Medical HDHP" if INELIGIBLEDEPENDENT >= 26


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCCOBQBT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCCOBQBT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCCOBQBT';
SELECT expformatcode, expexportcode, expascfilename, expstartpercontrol, expendpercontrol,* FROM dbo.AscExp WHERE ExpFormatCode = 'ECYCCOBQBT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCCOBQBT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBQBT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBQBT', 'SCH_ECYCCO';

--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
UPDATE dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ECYCCOBQBT' AND cfgname = 'Testing';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCCOBQBT';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECYCCOBQBT', @AllObjects = 'Y', @IsWeb = 'Y';

**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(10)
            ,@ExportCode varchar(10)
            ,@StartDate  datetime
            ,@EndDate    datetime;

    -- Initialize @FormatCode
    SET @FormatCode = 'ECYCCOBQBT';

    -- Declare dates FROM Parameter file
    SELECT
         @ExportCode = ExportCode
        ,@StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECYCCOBQBT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_ECYCCOBQBT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Remove Test Data -- 10-14-2020
    --==========================================

    --DELETE FROM dbo.U_ECYCCOBQBT_EEList
    --WHERE EXISTS (SELECT 1 FROM dbo.EmpComp(NOLOCK) WHERE EecEEID = xEEID AND EecCOID = xCOID AND EecEEID IN ('CPT2NF000030', 'CX01F3000030'));

        --==========================================
        -- BDM Section for QB
        -- SELECT * FROM U_dsi_BDM_Configuration where formatcode = 'ECYCCOBQBT'
        --==========================================
        DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        -- Required parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSELECTionOption','AuditDate');

        -- COBRA parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); --Pull Cobra reasons FROM EepCobraReason and ConCobraReason
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); --Pull Cobra dates FROM EepDateofCobraEvent and ConDateofCobraEvent
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
       -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204');        --,210,LEVNT3,LEVNT4');
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraPQBMulti', '1')
        --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS,DPC,STC');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP,SGO');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','Contacts_DependentCOBRAReason'); 
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'InvalidCobraReasonsEmp', '210,LEVNT1,LEVNT2') 

        -- Run BDM for QB
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable_v2 @FormatCode;
        -- SELECT * FROM dbo.U_dsi_BDM_ECYCCOBQBT
        -- SELECT distinct CodCode, CodDesc FROM codes where codtable like 'relat%'
        -- SELECT distinct BDMDEDCODE, BDMDEDTYPE FROM dbo.U_dsi_bdm_ECYCCOBQBT order by 1
        -- select distinct bdmbenoption, bdmrelationship from dbo.U_dsi_bdm_ECYCCOBQBT order by 1
        ----------------------------------------------
        -- Invalidate dependent PQBs where cobra reason not valid
        ----------------------------------------------
        UPDATE dbo.U_dsi_BDM_DepDeductions
        SET  DbnValidForExport = 'N'
            ,DbnDedRowStatus   = 'EE not on file and ConCOBRAReason not valid'
        FROM dbo.EmpComp WITH (NOLOCK)
        WHERE EecEEID = DbnEEID
          AND EecCoID = DbnCoID
          AND ISNULL(EecTermReason,'') <> '203' 
          AND DbnCobraReason NOT IN ('201','204','210','LEVNT3','LEVNT4')        --SELECT * FROM [dbo].[TrmReasn] order by 2         SELECT * FROM benchrsn        SELECT deddedcode, dedlongdesc, dedIsCobraCovered FROM dedcode
          AND DbnFormatCode = @FormatCode -- SELECT distinct TchCode, TchDesc FROM [dbo].[TrmReasn] -- SELECT distinct BchCode, BchDesc FROM benchrsn WHERE BchIsCobraQualifiedEvent = 'Y'
          AND DbnValidForExport = 'Y'
          AND DbnRunID = 'QB'
          AND NOT EXISTS(SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) -- SELECT * FROM dbo.U_dsi_BDM_DepDeductions where dbneeid = 'CQ3YZD000030' and dbnformatcode = 'ECYCCOBQBT'
                         WHERE EedEEID = DbnEEID
                           AND EedCoID = DbnCoID
                           AND EedDedCode = DbnDedCode
                           AND EedFormatCode = @FormatCode
                           AND EedValidForExport = 'Y'
                           AND EedRunID = 'QB');

        -- Run BuildConsolidatedTable SP for QB run
        EXEC dbo.dsi_BDM_sp_BuildConsolidatedTable @FormatCode, 'Standard';
        -- SELECT * FROM dbo.U_dsi_BDM_EmpDeductions where eedformatcode = 'ECYCCOBQBT' and eedcobrareason is not null
        --SELECT * FROM dbo.depbplan where dbneeid = 'CQ3U2H000030'

         -- Update spouse record for Number of dependents
    UPDATE dbo.U_dsi_BDM_ECYCCOBQBT
    SET BdmNumSpouses = 0, BdmNumChildren = ISNULL(NumChs,0)
    FROM dbo.U_dsi_BDM_ECYCCOBQBT SQB
    LEFT JOIN (SELECT DISTINCT ConEEID, NumChs = COUNT(ConSystemID)
                FROM dbo.Contacts WITH (NOLOCK)
                WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK) 
                                WHERE BdmEEID = ConEEID AND BdmDepRecID = ConSystemID 
                                        AND BdmRelationship NOT IN ('SPS') AND BdmIsPQB = 'N' AND BdmRecType <> 'EMP'
                                )
            GROUP BY ConEEID
    ) tbl1
    ON tbl1.ConEEID = SQB.BdmEEID
    WHERE sqb.BdmRelationship IN ('SPS') AND ISNULL(sqb.BdmIsPQB,'N') = 'Y' AND sqb.BdmRecType <> 'EMP'

      -- Update dependent record for Number of dependents
    UPDATE dbo.U_dsi_BDM_ECYCCOBQBT
    SET BdmNumSpouses = 0
       ,BdmNumChildren = ISNULL(NumChs,0)
    FROM dbo.U_dsi_BDM_ECYCCOBQBT SQB
    LEFT JOIN (SELECT BdmDepRecID, NumChs = COUNT(BdmEEID)
            FROM dbo.U_dsi_BDM_ECYCCOBQBT
            WHERE BdmRelationship NOT IN ('SPS') AND BdmIsPQB = 'N' AND BdmRecType <> 'EMP'
            GROUP BY BdmDepRecID
    ) tbl1
    ON tbl1.BdmDepRecID = SQB.BdmDepRecID
    WHERE BdmRelationship NOT IN ('SPS') AND ISNULL(BdmIsPQB,'N') = 'Y' AND BdmRecType <> 'EMP'
    ;


    --==========================================
    -- Build driver tables
    --==========================================

        ------------------
        -- QB DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QB') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QB;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = ISNULL(BdmDepRecID,'')
            ,drvClientName     = 'MGP Ingredients, Inc'
            ,drvClientDivName  = CASE WHEN EecOrgLvl3 IN ('1000', '2000', '7000') THEN 'Atchison KS'
                                         WHEN EecOrgLvl3 IN ('20001')                THEN 'CLEVELAND'
                                         WHEN EecOrgLvl3 IN ('36001')                THEN 'WASHINGTON DC'
                                         WHEN EecOrgLvl3 IN ('4000')                 THEN 'Lawrenceburg IN'
                                         WHEN EecOrgLvl3 IN ('80001')                THEN 'LIMESTONE'
                                         WHEN EecOrgLvl3 IN ('70001')                THEN 'Lux Rowe'
                                         WHEN EecOrgLvl3 IN ('10001')                THEN 'LUXCO CORP (ST LOUIS)'
                                         ELSE CmpAddressCity + ',' + CmpAddressState
                                    END
            ,drvNameFirst      = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(eepnamefirst,',',' ')
                                      ELSE REPLACE(Connamefirst,',',' ')
                                 END
            ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                      ELSE LEFT(ConNameMiddle,1)
                                 END
            ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(eepnamelast,',',' ')
                                      ELSE REPLACE(Connamelast,',',' ')
                                 END
            ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                      ELSE ISNULL(ConSSN,'')
                                 END
            ,drvPhone           = EepPhoneHomeNumber
            ,drvPhone2           = efoPMobilePhone
            ,drvAddressLine1   = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(EepAddressLine1,',',' ')
                                      WHEN ConAddressLine1 IS NULL THEN REPLACE(EepAddressLine1,',',' ')
                                      ELSE REPLACE(ConAddressLine1,',',' ')
                                 END
            ,drvAddressLine2   = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(EepAddressLine2,',',' ')
                                      WHEN ConAddressLine1 IS NULL THEN REPLACE(EepAddressLine2,',',' ')
                                      ELSE REPLACE(ConAddressLine2,',',' ')
                                 END
            ,drvAddressCity    = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(EepAddressCity,',',' ')
                                      WHEN ConAddressLine1 IS NULL THEN REPLACE(EepAddressCity,',',' ')
                                      ELSE REPLACE(ConAddressCity,',',' ')
                                 END
            ,drvAddressState   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                      WHEN ConAddressLine1 IS NULL THEN EepAddressState
                                      ELSE ConAddressState
                                 END
            ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                      WHEN ConAddressLine1 IS NULL THEN EepAddressZipCode
                                      ELSE ConAddressZipCode
                                 END
            ,drvCountry           = CASE WHEN EepAddressCountry = 'USA' THEN NULL
                                      ELSE REPLACE(EepAddressCountry,',',' ')
                                      END
            ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepGender,'U')
                                      ELSE ISNULL(ConGender,'U')
                                 END
            ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                      ELSE ConDateOfBirth
                                 END
            ,drvTobaccoUse       = 'UNKNOWN' -- CASE WHEN BdmRecType = 'EMP' THEN
            ,drvEmployeeType = CASE WHEN EecEeType = 'REG' THEN 'FTE' ElSE 'UNKNOWN' END
            ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'EXEMPT' ELSE 'NONEXEMPT' END
            ,drvDateOfLastHire = EecDateOfLastHire
            ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                      ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                                 END
            ,drvSubSort2       = '1'
            ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                      ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                                 END
        INTO dbo.U_ECYCCOBQBT_drvTbl_QB -- SELECT * FROM dbo.U_ECYCCOBQBT_drvTbl_QB
        FROM dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
           AND EecCoID = BdmCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = BdmEEID
        JOIN dbo.JobCode WITH (NOLOCK)
            ON EecJobCode = JbcJobCode
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        JOIN dbo.Company WITH (NOLOCK)
            ON CmpCOID = BdmCOID 
        LEFT JOIN (SELECT efoeeid, MAX(efoPhoneNumber) AS efoPMobilePhone 
               FROM dbo.EmpMPHon WITH (NOLOCK) 
               WHERE efoPhoneType = 'CEL' 
               GROUP BY efoeeid) AS TmpTbl3 
        ON BdmEEID = efoeeid
        WHERE BdmIsPQB = 'Y';

        ------------------
        -- QBEVENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBEVENT') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QBEVENT;
        SELECT DISTINCT
             drvEEID           = drvEEID
            ,drvCoID           = drvCoID
            ,drvDepRecID       = drvDepRecID
            ,drvEventType      = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                      WHEN EecTermReason = '203' THEN 'DEATH'
                                      WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                      WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                      WHEN BdmCobraReason = '210' THEN 'DEATH'
                                      WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                      WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                      WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                      WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                      WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                      WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                      WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                      ELSE 'TERMINATION'
                                 END
            ,drvEventDate      = CASE WHEN BdmDateOfCOBRAEvent > BdmBenStartDate then BdmDateOfCOBRAEvent ELSE BdmBenStopDate END
            ,drvEnrollmentDate = BdmBenStartDate
            ,drvSSN            = eepSSN        -- EE must always be here per Discovery even for DEP records
            ,drvName           = RTRIM(EepNameFirst) + ' ' + EepNameLast        -- EE must always be here per Discovery even for DEP records
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '1'
            ,drvSubSort3       = drvSubSort3
            ,drvAgedOut        = iif(BdmRelationship ='CHL' AND BdmDateOfBirth <= DATEADD(Y, -26, @EndDate) AND BdmCobraReason='201', 'Y','N') 
        INTO dbo.U_ECYCCOBQBT_drvTbl_QBEVENT        -- SELECT * FROM dbo.U_ECYCCOBQBT_drvTbl_QBEVENT
        FROM dbo.U_ECYCCOBQBT_drvTbl_QB WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = drvEEID
           AND EecCoID = drvCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = drvEEID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON drvdeprecid = consystemid
        JOIN (SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmBenStopDate = MIN(BdmBenStopDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
                ,BdmRelationship = MAX(BdmRelationship)
                ,BdmDateOfBirth = MAX(BdmDateOfBirth)
              FROM dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)
              WHERE BdmIsPQB = 'Y'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
           ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
           ;

        ------------------
        -- QBPLANINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBPLAN') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QBPLAN;
        SELECT DISTINCT
             drvEEID          = drvEEID
            ,drvCoID          = drvCoID
            ,drvDepRecID      = drvDepRecID
            ,drvDedCode       = BdmDedCode
            ,drvPlanName      = CASE WHEN BdmDedCode IN ('MEDA1', 'MEDLB') THEN 'Medical HDHP' + iif(drvAgedOut='Y', ' - age 26 only', '')
                                     WHEN BdmDedCode IN ('MEDAT', 'MEDL2') THEN 'Medical PPO' + iif(drvAgedOut='Y', ' - age 26 only', '')
                                     WHEN CodDesc IS NOT NULL THEN CodDesc
                                     ELSE CONCAT(RTRIM(BdmDedCode),'-',LTRIM(DedLongDesc))
                                END
            ,drvCoverageLevel = CASE WHEN BdmNumSpouses = 0 AND BdmNumChildren = 1 THEN 'EE+CHILD'                    
                                     WHEN BdmNumSpouses = 0 AND BdmNumChildren > 1 THEN 'EE+CHILDREN'                    
                                     WHEN BdmNumSpouses = 0 AND BdmNumChildren = 0 THEN 'EE'
                                     WHEN BdmBenOption IN ('EE','EETF') THEN 'EE'
                                     WHEN BdmBenOption IN ('EES','EESTF') THEN 'EE+SPOUSE'
                                     WHEN BdmBenOption IN ('EEC','EECTF') THEN 'EE+CHILDREN'
                                     WHEN BdmBenOption IN ('EEF','EEFTF') THEN 'EE+FAMILY'
                                        ELSE BdmBenOption + '- NOT MAPPED'
                                END 
            ,drvSubSort       = drvSubSort
            ,drvSubSort2      = '1' + BdmDedCode
            ,drvSubSort3      = drvSubSort3
        INTO dbo.U_ECYCCOBQBT_drvTbl_QBPLAN    -- SELECT * FROM U_ECYCCOBQBT_drvTbl_QBPLAN
        FROM dbo.U_ECYCCOBQBT_drvTbl_QBEVENT WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
        -- SubSELECT of BDM for count of deps for non-EE PQB
        --LEFT JOIN (SELECT  NdpEEID    = BdmEEID
        --                  ,NdpDedCode = BdmDedCode
        --                  ,NdpNumDeps = COUNT(1)
        --           FROM (SELECT DISTINCT BdmEEID, BdmDepRecID, BdmDedCode
        --                 FROM dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)
        --                 WHERE BdmIsPQB = 'N') NDEP
        --           GROUP BY BdmEEID, BdmDedCode) NDP
        --    ON NdpEEID = BdmEEID
        --   AND NdpDedCode = BdmDedCode
        LEFT JOIN dbo.Codes WITH (NOLOCK)
            ON BdmDedCode = CodCode
            AND CodTable = 'CO_COBRAPLANNAMEMAPP'
        JOIN dbo.Company WITH (NOLOCK)
            ON CmpCOID = BdmCOID
        LEFT JOIN dbo.DedCode WITH (NOLOCK) 
            ON BdmDedCode = DedDedCode
        WHERE BdmIsPQB = 'Y';

        ------------------
        -- QBDEPENDENT DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBDEP') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QBDEP;
        SELECT DISTINCT
             drvEEID           = BdmEEID
            ,drvCoID           = BdmCoID
            ,drvDepRecID       = BdmDepRecID
            ,drvSSN            = ISNULL(ConSSN,'')
            ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                      WHEN BdmRelationship IN ('DP','SGO') THEN 'DOMESTICPARTNER'
                                      ELSE 'CHILD'
                                 END
            ,drvNameFirst      = ConNameFirst
            ,drvNameMiddle     = LEFT(ConNameMiddle,1)
            ,drvNameLast       = ConNameLast
            ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                      ELSE 'FALSE'
                                 END
            ,drvAddressLine1   = ConAddressLine1
            ,drvAddressLine2   = ConAddressLine2
            ,drvAddressCity    = ConAddressCity
            ,drvAddressState   = ConAddressState
            ,drvAddressZipCode = ConAddressZipCode
            ,drvGender         = ConGender
            ,drvDateOfBirth    = ConDateOfBirth
            ,drvISQMCO         = CASE WHEN BdmRelationship IN ('@QMCORelationships') THEN 'TRUE'
                                      ELSE 'FALSE'
                                 END
            ,drvSubSort        = drvSubSort
            ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP','SGO') THEN 'A'
                                            ELSE 'B' + ISNULL(ConSSN,'')
                                       END
            ,drvSubSort3       = drvSubSort3
        INTO dbo.U_ECYCCOBQBT_drvTbl_QBDEP -- SELECT * FROM dbo.U_ECYCCOBQBT_drvTbl_QBDEP where drveeid = 'CPT2NF000030'
        FROM dbo.U_ECYCCOBQBT_drvTbl_QB WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N';

        ------------------
        -- QBDEPENDENTPLANINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBDEPPLAN') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QBDEPPLAN;
        SELECT DISTINCT
             drvEEID     = BdmEEID
            ,drvCoID     = BdmCoID
            ,drvDepRecID = BdmDepRecID
            ,drvDedCode  = BdmDedCode
            ,drvPlanName = drvPlanName
            ,drvSubSort  = drvSubSort
            ,drvSubSort2 = '2' + CASE WHEN BdmRelationship IN ('SPS','DP','SGO') THEN 'A'
                                      ELSE 'B' + RTRIM(ISNULL(ConSSN,''))
                                 END + BdmDedCode
            ,drvSubSort3 = drvSubSort3
        INTO dbo.U_ECYCCOBQBT_drvTbl_QBDEPPLAN
        FROM dbo.U_ECYCCOBQBT_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK) -- SELECT * FROM dbo.U_dsi_BDM_ECYCCOBQBT where bdmeeid = 'CPT2NF000030'
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND BdmDedCode = drvDedCode
        JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
        WHERE BdmIsPQB = 'N';
        -- select distinct bdmbenoption, bdmrelationship from dbo.U_dsi_bdm_ECYCCOBQBT order by 1
        ------------------
        -- QBSTATEINSERTS DETAIL RECORD
        ------------------
        --IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBMSI') IS NOT NULL
        --    DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QBMSI;
        --SELECT DISTINCT
        --     drvEEID     = drvEEID
        --    ,drvCoID     = drvCoID
        --    ,drvDepRecID = drvDepRecID
        --    ,drvRecordIdentifierQBS = '[QBSTATEINSERTS]'
        --    ,drvPlanName = CASE WHEN EepAddressState = 'NY' THEN 'NY-SR INSERT'
        --                        WHEN EepAddressState IN ('CA','CT','MN','OR','IL','RI','GA','VA','TX') THEN RTRIM(EepAddressState)+'-SRINSERT' -- changed to add TX here per feedback 8/3/20 ACW
        --                   END
        --    ,drvSubSort  = drvSubSort
        --    ,drvSubSort2 = '2'
        --    ,drvSubSort3 = drvSubSort3
        --INTO dbo.U_ECYCCOBQBT_drvTbl_QBMSI    -- SELECT * FROM U_ECYCCOBQBT_drvTbl_QBMSI
        --FROM dbo.U_ECYCCOBQBT_drvTbl_QB WITH (NOLOCK)
        ----JOIN dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)
        ----    ON BdmEEID = drvEEID
        ----   AND BdmCoID = drvCoID
        ----   AND ISNULL(BdmDepRecID,'') = drvDepRecID
        ----   AND BdmDedCode = drvDedCode
        --JOIN dbo.EmpPers WITH (NOLOCK)
        --    ON EepEEID = drvEEID
        --WHERE EepAddressState IN ('NY','CA','CT','MN','OR','IL','RI','GA','VA','TX'); -- 

        ------------------
        -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
        ------------------
        IF OBJECT_ID('U_ECYCCOBQBT_drvTbl_QBMSRI') IS NOT NULL
            DROP TABLE dbo.U_ECYCCOBQBT_drvTbl_QBMSRI;
        SELECT DISTINCT
             drvEEID     = drvEEID
            ,drvCoID     = drvCoID
            ,drvDepRecID = drvDepRecID
            ,drvPlanName = drvPlanName
            ,drvRate     = CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
                                WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
                                WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
                                WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
                           END
            ,drvSubSort  = drvSubSort
            ,drvSubSort2 = '3'
            ,drvSubSort3 = drvSubSort3
        INTO dbo.U_ECYCCOBQBT_drvTbl_QBMSRI    -- SELECT * FROM U_ECYCCOBQBT_drvTbl_QBMSRI
        FROM dbo.U_ECYCCOBQBT_drvTbl_QBPLAN WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_ECYCCOBQBT WITH (NOLOCK)  -- SELECT * FROM dbo.U_dsi_BDM_DepDeductions where dbneeid = 'CPT2NF000030' and dbnformatcode = 'ECYCCOBQBT'
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
           AND ISNULL(BdmDepRecID,'') = drvDepRecID
           AND BdmDedCode = drvDedCode
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = BdmEEID
           AND EecCoID = BdmCoID
        WHERE BdmIsPQB = 'Y'
          AND BdmDedType = 'FSA';
    

    --==========================================
    -- Set filename
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --    SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%NPM%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
    --                          WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%QB%' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'TESTNPM' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'TESTQB' THEN '_TEST_' + CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'NPMFILE' THEN CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_NPM_@FileCustomerNumber.txt'
    --                          WHEN @ExportCode = 'QBFILE' THEN CONVERT(char(8),GETDATE(),112) + '_@FileCustomerName_QB_@FileCustomerNumber.txt'
    --                     END
    --    WHERE FormatCode = @FormatCode;
    --END;
END;
/***************************************************************************

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECYCCOBQBT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECYCCOBQBT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECYCCOBQBT';
SELECT expformatcode, expexportcode, expascfilename, expstartpercontrol, expendpercontrol,* FROM dbo.AscExp WHERE ExpFormatCode = 'ECYCCOBQBT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECYCCOBQBT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBQBT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECYCCOBQBT', 'SCH_ECYCCO';

--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
UPDATE dbo.U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'ECYCCOBQBT' AND cfgname = 'Testing';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECYCCOBQBT';


--Alter the View
ALTER VIEW dbo.dsi_vwECYCCOBQBT_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECYCCOBQBT_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECYCCOBQBT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates for After Testing
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911011'
       ,expStartPerControl     = '201911011'
       ,expLastEndPerControl   = '202004309'
       ,expEndPerControl       = '202004309'
WHERE expFormatCode = 'ECYCCOBQBT';

--Update Dates for Before Testing
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202103011'
       ,expStartPerControl     = '202103011'
       ,expLastEndPerControl   = '202103309'
       ,expEndPerControl       = '202103309'
WHERE expFormatCode = 'ECYCCOBQBT' and expExportCode = 'ONDEM_XOE';



***************************************************************************/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwECYCCOBQBT_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECYCCOBQBT_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECYCCOBQBT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECYCCOBQBT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECYCCOBQBT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCCOBQBT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECYCCOBQBT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECYCCOBQBT', 'UseFileName', 'V', 'Y'


-- End ripout