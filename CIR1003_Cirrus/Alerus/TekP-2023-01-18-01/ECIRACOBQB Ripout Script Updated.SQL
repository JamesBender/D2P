/**********************************************************************************

ECIRACOBQB: Alerus COBRA QB Export

FormatCode:     ECIRACOBQB
Project:        Alerus COBRA QB Export
Client ID:      CIR1003
Date/time:      2023-04-19 10:18:01.423
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP4DB03
Database:       ULTIPRO_WPCIRR
Web Filename:   CIR1003_B61C4_EEHISTORY_ECIRACOBQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECIRACOBQB_SavePath') IS NOT NULL DROP TABLE dbo.U_ECIRACOBQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECIRACOBQB'


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
WHERE FormatCode = 'ECIRACOBQB'
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
WHERE ExpFormatCode = 'ECIRACOBQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECIRACOBQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECIRACOBQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECIRACOBQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECIRACOBQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECIRACOBQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECIRACOBQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECIRACOBQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECIRACOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECIRACOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECIRACOBQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECIRACOBQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIRACOBQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIRACOBQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIRACOBQB];
GO
IF OBJECT_ID('U_ECIRACOBQB_File') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_File];
GO
IF OBJECT_ID('U_ECIRACOBQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_EEList];
GO
IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE];
GO
IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL];
GO
IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_drvTbl_QB];
GO
IF OBJECT_ID('U_ECIRACOBQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_DedList];
GO
IF OBJECT_ID('U_ECIRACOBQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_AuditFields];
GO
IF OBJECT_ID('U_ECIRACOBQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECIRACOBQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECIRACOBQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIRACOBQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIRACOBQB','Alerus COBRA QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECIRACOBQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','50','H','01','1',NULL,'RecordType',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"1.2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','50','D','10','1',NULL,'RecordType',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClentName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIRACOBQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIRACOBQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIRACOBQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIRACOBQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIRACOBQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIRACOBQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIRACOBQBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvIndividualID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIRACOBQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIRACOBQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIRACOBQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIRACOBQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIRACOBQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIRACOBQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIRACOBQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIRACOBQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIRACOBQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIRACOBQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"drvPremiumAddressAsPrimary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIRACOBQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIRACOBQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECIRACOBQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECIRACOBQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECIRACOBQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECIRACOBQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECIRACOBQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECIRACOBQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECIRACOBQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECIRACOBQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"drvEEType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECIRACOBQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECIRACOBQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECIRACOBQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECIRACOBQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECIRACOBQBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECIRACOBQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECIRACOBQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECIRACOBQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECIRACOBQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECIRACOBQBZ0','50','D','10','39',NULL,'SSOIdentifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECIRACOBQBZ0','50','D','10','40',NULL,'PlanCategory',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','50','D','20','1',NULL,'RecordType',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIRACOBQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIRACOBQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIRACOBQBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIRACOBQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIRACOBQBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','50','D','30','1',NULL,'RecordType',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','51','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIRACOBQBZ0','52','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIRACOBQBZ0','53','D','30','4',NULL,'NumberOfUnit',NULL,NULL,'"drvNumberOfUnit"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','54','D','40','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','55','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIRACOBQBZ0','56','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIRACOBQBZ0','57','D','40','4',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIRACOBQBZ0','58','D','40','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIRACOBQBZ0','59','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIRACOBQBZ0','60','D','40','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIRACOBQBZ0','61','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIRACOBQBZ0','62','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIRACOBQBZ0','63','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIRACOBQBZ0','64','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvAddressSameAsQB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIRACOBQBZ0','65','D','40','12',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIRACOBQBZ0','66','D','40','13',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIRACOBQBZ0','67','D','40','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIRACOBQBZ0','68','D','40','15',NULL,'StateOrProvince',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIRACOBQBZ0','69','D','40','16',NULL,'PostalCode',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIRACOBQBZ0','70','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIRACOBQBZ0','71','D','40','18',NULL,'EnrollmentDate ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIRACOBQBZ0','72','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIRACOBQBZ0','73','D','40','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIRACOBQBZ0','74','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','75','D','50','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','76','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIRACOBQBZ0','77','D','60','1',NULL,'RecordTypeRateInitial',NULL,NULL,'"drvRecordTypeRateInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIRACOBQBZ0','78','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIRACOBQBZ0','79','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECIRACOBQB_20230419.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202304109','EMPEXPORT','OEACTIVE',NULL,'ECIRACOBQB',NULL,NULL,NULL,'202304109','Jan 24 2023  4:40PM','Jan 24 2023  4:40PM','202303281',NULL,'','','202303281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202304109','EMPEXPORT','OEPASSIVE',NULL,'ECIRACOBQB',NULL,NULL,NULL,'202304109','Jan 24 2023  4:40PM','Jan 24 2023  4:40PM','202303281',NULL,'','','202303281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',KD708',NULL,NULL,NULL,'Alerus COBRA QB ONDEMAND','202304109','EMPEXPORT','ONDEM_XOE',NULL,'ECIRACOBQB',NULL,NULL,NULL,'202304109','Jan 24 2023  4:40PM','Jan 24 2023  4:40PM','202303281',NULL,'','','202303281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','KD708,KD723,KD74A',NULL,NULL,NULL,'Alerus COBQB SCH WK TUE 210P E','202304109','EMPEXPORT','SCH_ECIRAC',NULL,'ECIRACOBQB',NULL,NULL,NULL,'202304179','Jan 24 2023  4:40PM','Jan 24 2023  4:40PM','202304101',NULL,'','','202303281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','KD708,KD723,KD74A',NULL,NULL,NULL,'Alerus COBRA QB Test','202304179','EMPEXPORT','TEST_XOE','Apr 19 2023  9:51AM','ECIRACOBQB',NULL,NULL,NULL,'202304179','Apr 17 2023 12:00AM','Dec 30 1899 12:00AM','202304101','0','','','202304101',dbo.fn_GetTimedKey(),NULL,'us3kEpCIR1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIRACOBQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','D10','dbo.U_ECIRACOBQB_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','D20','dbo.U_ECIRACOBQB_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','D30','dbo.U_ECIRACOBQB_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','D40','dbo.U_ECIRACOBQB_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','D50','dbo.U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIRACOBQB','D60','dbo.U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECIRACOBQB
-----------

IF OBJECT_ID('U_dsi_BDM_ECIRACOBQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIRACOBQB] (
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
-- Create table U_ECIRACOBQB_Audit
-----------

IF OBJECT_ID('U_ECIRACOBQB_Audit') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_Audit] (
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
-- Create table U_ECIRACOBQB_AuditFields
-----------

IF OBJECT_ID('U_ECIRACOBQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECIRACOBQB_DedList
-----------

IF OBJECT_ID('U_ECIRACOBQB_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECIRACOBQB_drvTbl_QB
-----------

IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClentName] varchar(25) NOT NULL,
    [drvClientDivisionName] varchar(25) NOT NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualID] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvPremiumAddressAsPrimary] varchar(4) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvEEType] varchar(3) NULL
);

-----------
-- Create table U_ECIRACOBQB_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(31) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvSex] char(1) NULL,
    [drvDOB] varchar(10) NULL
);

-----------
-- Create table U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL
-----------

IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(30) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanName] varchar(34) NULL
);

-----------
-- Create table U_ECIRACOBQB_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] varchar(10) NULL,
    [drvEnrollmentDate] varchar(10) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_ECIRACOBQB_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanName] varchar(34) NULL,
    [drvCoverageLevel] varchar(12) NULL,
    [drvNumberOfUnit] varchar(4) NULL
);

-----------
-- Create table U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE
-----------

IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordTypeRateInitial] varchar(33) NULL,
    [drvPlanName] varchar(11) NULL,
    [drvRate] money NULL
);

-----------
-- Create table U_ECIRACOBQB_EEList
-----------

IF OBJECT_ID('U_ECIRACOBQB_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECIRACOBQB_File
-----------

IF OBJECT_ID('U_ECIRACOBQB_File') IS NULL
CREATE TABLE [dbo].[U_ECIRACOBQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIRACOBQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cirrus Design Corporation d/b/a Cirrus Aircraft

Created By: Marie Waters
Business Analyst: Kim Em[hraim
Create Date: 01/24/2023
Service Request Number: TekP-2023-01-18-01

Purpose: Alerus COBRA QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
Kim Ephraim (ke)   02/10/2023     TekP-2023-01-18-01  added dedcodes LIFEE,LIFES,LIFEC to logic; update FSA amt logic to not sent '0'
Marie Waters       04/19/2023     TekP-2023-01-18-01  Added Conditional Address fields for QBDependent  

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIRACOBQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIRACOBQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIRACOBQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIRACOBQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIRACOBQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIRACOBQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIRACOBQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIRACOBQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIRACOBQB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIRACOBQB', 'SCH_ECIRAC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIRACOBQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECIRACOBQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ECIRACOBQB';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECIRACOBQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_AuditFields;
    CREATE TABLE dbo.U_ECIRACOBQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpComp','EecTermReason');
    --INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpDed','eedBenStartDate');
    --INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpDed','eedBenOption');
    --INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpDed','eedDedCode');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECIRACOBQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_Audit;
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
    INTO dbo.U_ECIRACOBQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECIRACOBQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECIRACOBQB_Audit ON dbo.U_ECIRACOBQB_Audit (audEEID,audKey2);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECIRACOBQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIRACOBQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECIRACOBQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_AuditFields;
    CREATE TABLE dbo.U_ECIRACOBQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpDed','eedBenStartDate');
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpDed','eedBenOption');
    INSERT INTO dbo.U_ECIRACOBQB_AuditFields VALUES ('EmpDed','eedDedCode');



    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECIRACOBQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_Audit;
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
    INTO dbo.U_ECIRACOBQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECIRACOBQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECIRACOBQB_Audit ON dbo.U_ECIRACOBQB_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECIRACOBQB_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECIRACOBQB_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MHSA,MPPO,MHSA2,DEN,VIS,FSA,GLIFE,GLBD,GLEXC,GLMAX,WHSA,WPPO,WHSA2,LIFEE,LIFES,LIFEC';---LIFEE,LIFEC,LIFES  ---ke update 20230210

    IF OBJECT_ID('U_ECIRACOBQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIRACOBQB_DedList
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

    -- COBRA parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #3.
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB', 'LEVNT3,LEVNT4,DLS,D,NLED') -- Add valid dependent edhchangereasons
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp', 'LEVNT3,LEVNT4,DLS,D,NLED') ;-- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','D,203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP'); -- update to the spouse relationship code
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild', 'CHL,DCH,DPC,STC'); -- update to the child relationship codes
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code

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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --====================================================
 --   -- Insert into BDM Reason code 200/203/DEA (Death)
 --            SPS or 1st child is EMP
 --=====================================================
        
        INSERT INTO [dbo].[U_dsi_BDM_ECIRACOBQB]
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
           ,[BdmSessionID]
        )
       

                Select CASE WHEN ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, EdhDedCode, dbnRelationship desc) = 1 THEN 'EMP' ELSE 'DEP' END
                ,EdhCoid
                ,EdhEEID
                ,DbnDepRecID
                ,DbnDepRecID
                ,'QB'
                ,'Data Inserted for 200/203 (Death)'
                ,DbnRelationship
                ,DbnDateOfBirth
                ,EdhDedCode
                ,EdhBenOption
                ,EdhBenstatus
                ,edhBenStartDate
                ,edhBenStopDate
                ,edhBenStatusDate
                ,EecDateofTermination
                ,'D'
                ,'D'
                ,edhStartDate
                ,edhStopDate
                ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
                ,'Y'
                ,'Y'
                FROM  dbo.emphded with (nolock)
                JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = 'ECIRACOBQB'
                JOIN EmpComp WITH (NOLOCK)
                ON dbnEEID = EecEEID
                AND EecTermReason IN ('203', 'D' )
                AND edhBenStatus = 'A'
                AND EecEmplStatus = 'T'
                and edhbenoption <> 'Z'
                and edhbenoption Not in ( 'EE', 'NTU')
                and edhbenoption <> 'Z'
                and dbnBenstatusDate between @startdate and @enddate 

      ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 -- --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_ECIRACOBQB]
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
           ,[BdmSessionID]
    )
        Select distinct
        'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,DbnDedCode
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,DbnBenStopDate
        ,'Y'
        ,'Y'
         ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'ECIRACOBQB'
    WHERE edhchangereason IN ('NLED','LEVNT3') 
      and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
            AND DbnBenStatus IN ('T','C')
            ---and edheeid = 'BYF7QL0000K0'

--    ========================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 --  ======================================================================
    INSERT INTO [dbo].[U_dsi_BDM_ECIRACOBQB]
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
            ,[BdmEEAmt]
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
        ,edheeamt
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'ECIRACOBQB'
    WHERE edhChangeReason in ('DLS','LEVNT4') 
        AND DbnRelationShip = 'SPS'
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'

----  --====================================================
-- --   Insert into BDM Reason code 302 (Remove Dependent)
-- --   --==================================================
--    INSERT INTO [dbo].[U_dsi_BDM_ECIRACOBQB]
--    (    [BdmRecType]
--           ,[BdmCOID]
--           ,[BdmEEID]
--           ,[BdmDepRecID]
--           ,[BdmSystemID]
--           ,[BdmRunID]
--           ,[BdmDedRowStatus]
--           ,[BdmRelationship]
--           ,[BdmDateOfBirth]
--           ,[BdmDedCode]
--           ,[BdmBenOption]
--           ,[BdmBenStatus]
--           ,[BdmBenStartDate]
--           ,[BdmBenStopDate]
--           ,[BdmBenStatusDate]
--           ,[BdmDateOFCobraEvent]
--           ,[BdmChangeReason]
--           ,[BdmCobraReason]
--           ,[BdmStartDate]
--           ,[BdmStopDate]
--           ,[BdmIsPQB]
--            ,[BdmIsCobraCovered]
--            ,[BdmEEAmt] 
--    )
--    Select Distinct rectype = 'EMP'
--        ,EdhCoid
--        ,EdhEEID
--        ,DbnDepRecID
--        ,DbnDepRecID
--        ,'QB'
--        ,'Data Inserted for 302/LEVNT3 (Remove Dependent)'
--        ,DbnRelationship
--        ,DbnDateOfBirth
--        ,EdhDedCode
--        ,DbnBenOption
--        ,DbnBenStatus
--        ,EdhBenStartDate
--        ,DbnBenStopDate
--        ,edhEffDate
--        ,edhEffDate
--        ,edhChangeReason
--        ,'LEVNT3'
--        ,EdhStartDate
--        ,EdhStopDate
--        ,'Y'
--        ,'Y'
--        ,edheeamt
--    FROM dbo.emphded WITH (NOLOCK)
--    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
--        ON dbneeid = edheeid 
--        AND DbnCoID = EdhCoID
--        AND EdhDedCode = DbnDedCode
--        AND EdhBenOption = DbnBenOption
--        AND dbnformatcode = 'ECIRACOBQB'
--    WHERE edhChangeReason IN ('LEVNT3','D')
--        and DbnBenstopdate BETWEEN @startdate AND @enddate 
--        AND dbnValidForExport = 'N'
--        AND DbnBenStatus IN ('T','C')

 


 

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECIRACOBQB_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvClentName = 'Cirrus Design Corporation'
        ,drvClientDivisionName = CASE WHEN EepAddressState IN ('WI') THEN 'Wisconsin' ELSE 'Cirrus Design Corporation' END  --'Cirrus Design Corporation'
        ,drvSalutation = ''
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSSN = eepSSN
        ,drvIndividualID = ''
        ,drvEmail = EepAddressEMailAlternate
        ,drvPhone = efoPhoneNumber
        ,drvPhone2 = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = '' --EepAddressCountry 20230418 KAE per vendor request
        ,drvPremiumAddressAsPrimary = 'TRUE'
        ,drvGender = CASE WHEN EepGender IN ('M', 'F') THEN EepGender ELSE 'U' END
        ,drvDOB = CONVERT(VARCHAR(10), EepDateOfBirth, 101)
        ,drvEEType = CASE When EecFullTimeOrPartTime = 'F' then 'FTE'
                          When EecFullTimeOrPartTime = 'P' then 'PTE'
                        END

    INTO dbo.U_ECIRACOBQB_drvTbl_QB
    FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoeeid =Xeeid
        and efoPhoneType = 'CEL'
    WHERE BdmRunID = 'QB'
        AND BdmRecType = 'EMP' and BdmChangeReason NOT IN ('NLED','LEVNT3','DLS','LEVNT4','D')
          

        INSERT INTO dbo.U_ECIRACOBQB_drvTbl_QB
        (    drvEEID
            ,drvCoID
            ,drvDepRecID
            ,drvInitialSort
            ,drvSubSort
            ,drvClentName
            ,drvClientDivisionName 
            ,drvSalutation
            ,drvFirstName
            ,drvMiddleInitial
            ,drvLastName 
            ,drvSSN 
            ,drvIndividualID
            ,drvEmail 
            ,drvPhone 
            ,drvPhone2 
            ,drvAddress1
            ,drvAddress2
            ,drvCity
            ,drvState
            ,drvPostalCode
            ,drvCountry
            ,drvPremiumAddressAsPrimary
            ,drvGender
            ,drvDOB
            ,drvEEType )
        
          SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvClentName = 'Cirrus Design Corporation'
        ,drvClientDivisionName = CASE WHEN ConAddressState IN ('WI') THEN 'Wisconsin' ELSE 'Cirrus Design Corporation' END --'Cirrus Design Corporation'
        ,drvSalutation = ''
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvSSN = ConSSN
        ,drvIndividualID = ''
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress1 = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressLine1 ELSE '' END
        ,drvAddress2 = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressLine2 ELSE '' END
        ,drvCity = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressCity ELSE '' END
        ,drvState = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressState ELSE '' END
        ,drvPostalCode = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressZipCode ELSE '' END
        ,drvCountry = '' --ConAddressCountry 20230418 KAE per vendor request
        ,drvPremiumAddressAsPrimary = CASE WHEN ConAddressIsDifferent  = 'Y' THEN 'TRUE' ELSE 'FALSE' END --'TRUE'
        ,drvGender = CASE WHEN ConGender IN ('M', 'F') THEN ConGender ELSE 'U' END
        ,drvDOB = CONVERT(VARCHAR(10), ConDateOfBirth, 101)
        ,drvEEType = CASE When EecFullTimeOrPartTime = 'F' then 'FTE'
                          When EecFullTimeOrPartTime = 'P' then 'PTE'
                        END

   -- INTO dbo.U_ECIRACOBQB_drvTbl_QB
  FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        AND BdmIsPQB ='Y'
     LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoeeid =Xeeid
        and efoPhoneType = 'CEL'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecId
        AND ConRelationship in ('CHL','DIS', 'DPC','STC','DP','SPS')
    WHERE   BdmRecType = 'DEP' and BdmChangeReason  IN ('NLED','LEVNT3','DLS','LEVNT4','D')


    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECIRACOBQB_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 2'
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE WHEN  (BdmChangeReason IN ('200','TOE')  OR EecTermReason IN ('A','COW','JA','LD','LDNR','M','NOB','NOCA','NONCF','NOP','NOS','NOUWJD','OC' ,'PR','RM','WC' ,'WS') or BdmCobraReason IN ('200','TOE')) THEN 'TERMINATION'
                                WHEN EecTermReason IN ('DCOP','FCTC','FJA','I','IB','MA','MR', 'POAOD' ,'PV','T','UP', 'WCR') THEN 'INVOLUNTARYTERMINATION'
                                WHEN EecTermReason = 'PE' THEN 'REDUCTIONINFORCE'
                                WHEN (BdmChangeReason IN ('NLED','LEVNT3') OR BdmCobraReason IN ('NLED','LEVNT3'))THEN 'INELIGIBLEDEPENDENT'
                                WHEN (BdmChangeReason IN ('NLEE','ACALOE','LWOB','LEFTPT') or BdmCobraReason IN ('NLEE','ACALOE','LWOB','LEFTPT') )THEN 'LOSSOFELIGIBILITY'
                                WHEN EecTermReason  = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                   WHEN (BdmChangeReason IN ('DLS','LEVNT4') or BdmCobraReason IN ('DLS','LEVNT4') )THEN 'DIVORCELEGALSEPARATION'
                                WHEN BdmChangeReason = 'MEDIC' or BdmCobraReason = 'MEDIC' THEN 'MEDICARE'
                                WHEN (BdmChangeReason = 'ML' or BdmCobraReason = 'ML' )THEN 'USERRA-REDUCTIONINHOURS'
                                WHEN (BdmChangeReason = 'R' or BdmCobraReason = 'R' OR EecTermReason IN ('R','202')) THEN 'RETIREMENT'
                                WHEN (BdmChangeReason = 'D' OR EecTermReason IN ('D','203') or BdmCobraReason = 'D') THEN 'DEATH'
                            END
        ,drvEventDate = CONVERT(VARCHAR(10), CASE WHEN EecEmplStatus IN ('T','C') THEN EecDateOfTermination ELSE BdmBenStopDate END, 101)

        ,drvEnrollmentDate =  CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, BdmBenStartDate),101) 
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast
    INTO dbo.U_ECIRACOBQB_drvTbl_QBEVENT
    FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
   JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN (SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmChangeReason = MAX(BdmChangeReason)
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
                ,BdmStopDate = Max(bdmstopdate)
              FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
            WHERE BdmRunId = 'QB' 
            --and BdmIsPQB ='Y'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID

   
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECIRACOBQB_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_drvTbl_QBPLANINITIAL;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 3'
        ,drvSubSort = '3'
    
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BdmDedcode =  'DEN' THEN 'Delta Dental'
                            WHEN BdmDedcode =  'FSA' THEN 'Further FSA'
                            WHEN BdmDedcode IN  ('GLBD', 'GLEXC','GLIFE','GLMAX') AND BdmBenStatus IN ('T') THEN 'NYL Basic Life'
                            WHEN BdmDedcode =  'MHSA' THEN 'BCBS $1500 HSA Medical'
                            WHEN BdmDedcode =  'LIFEE' AND BdmBenStatus IN ('T')  THEN 'NYL Employee Voluntary Life'  ---ke update 20230210 
                            WHEN BdmDedcode =  'LIFES' AND BdmBenStatus IN ('T') and (BdmChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') or EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3')) THEN 'NYL Spouse Voluntary Life'   ---ke update 20230210 --MW added and EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') 3/14/23
                            WHEN BdmDedcode =  'LIFEC' AND BdmBenStatus IN ('T') and ( BdmChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') or EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3')) THEN 'NYL Child Vol Life'   ---ke update 20230210 --MW added and EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') 3/14/23
                            WHEN BdmDedcode =  'MHSA2' THEN 'BCBS $3000 HSA Medical'
                            WHEN BdmDedcode =  'MPPO' THEN 'BCBS Traditional Medical'
                            WHEN BdmDedcode =  'VIS' THEN 'EyeMed Vision'
                            WHEN BdmDedcode = 'WHSA' THEN 'BCBS $1500 HSA Medical Wisconsin'
                            WHEN BdmDedcode = 'WHSA2' THEN 'BCBS $3000 HSA Medical Wisconsin'
                            WHEN BdmDedcode = 'WPPO' THEN 'BCBS Traditional Medical Wisconsin'
                            --WHEN EecPayGroup <> 'No Pay Group' AND EecEEType = 'REG' THEN 'Modern Health EAP'
                            --WHEN BdmDedCode IN ('MHSA','MHSA2','MPPO', 'WHSA','WHSA2','WPPO') THEN 'Modern Health EAP'
                        END
        
        ,drvCoverageLevel = CASE WHEN BdmDedCode IN ('MHSA','MHSA2','MPPO','WHSA','WHSA2','WPPO','DEN','VIS') THEN  
                                   CASE WHEN ISNULL(BdmChangeReason,'') NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') THEN
                                   CASE WHEN BdmBenOption = 'EE' OR (BdmBenOption IS NULL AND EdhBenOption = 'EE') THEN 'EE'
                                        WHEN (BdmBenOption = 'EEC' OR (BdmBenOption IS NULL AND EdhBenOption = 'EEC')) and BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
                                        WHEN (BdmBenOption = 'EEC' OR (BdmBenOption IS NULL AND EdhBenOption = 'EEC')) and BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) >= 1 THEN 'EE+CHILDREN'
                                        WHEN (BdmBenOption = 'EEC' OR (BdmBenOption IS NULL AND EdhBenOption = 'EEC')) AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                        WHEN BdmBenOption IN ('EEF','EEDPF') OR (BdmBenOption IS NULL AND EdhBenOption IN ('EEF','EEDPF')) THEN 'EE+FAMILY'
                                        WHEN BdmBenOption IN ('EES','EEDP') OR (BdmBenOption IS NULL AND EdhBenOption IN ('EES','EEDP')) THEN 'EE+SPOUSE'
                                    END
                                ELSE
                                  
                                    CASE WHEN BdmDedCode IN ('MHSA','MHSA2','MPPO','WHSA','WHSA2','WPPO','DEN','VIS') and BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
                                        WHEN BdmDedCode IN ('MHSA','MHSA2','MPPO','WHSA','WHSA2','WPPO','DEN','VIS') and BdmRelationship = 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                        WHEN BdmDedCode IN ('MHSA','MHSA2','MPPO','WHSA','WHSA2','WPPO','DEN','VIS') and BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                        ELSE 'EE'
                                    END
                                END 
                                WHEN  BdmDedCode IN  ('FSA', 'GLBD','GLEXC','GLIFE','GLMAX','LIFEE') THEN 'EE'  ---ke update 20230210 *added LIFEE, LEFES, LIFEC
                                WHEN  BdmDedCode IN  ('LIFES') THEN 'SPOUSEONLY' --ke added logic to include life plan coverage level. 20230330
                                WHEN  BdmDedCode IN  ('LIFEC')  and BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'CHILDRENONLY' --ke added logic to include life plan coverage level. 20230330
                                WHEN BdmDedCode IN  ('LIFEC')  and BdmRelationship <> 'SPS' AND (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK) WHERE BdmRunId = 'QB' AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'CHILDONLY'--ke added logic to include life plan coverage level. 20230330
                            END

     ,drvNumberOfUnit = Convert(varchar(4),CASE WHEN   BdmDedCode IN ('LIFEE','LIFES','LIFEC') and Units <> '0' THEN Units  --MW removed'GLBD','GLEXC','GLIFE','GLMAX'--- (Replace(BcaEEBenAmt,'.00','')/1000) ---removed 'FSA' as NumberOfUnits is not required. KE 20230215 
                                                WHEN bdmdedcode IN ('GLBD','GLEXC','GLIFE','GLMAX') THEN (select top 1 (Replace(Format((PdhDedCalcBasisAmt), '00'),'.00','')/1000) from dbo.pDedHist A WITH (NOLOCK) where pdhEEID = xEEID AND PdhCOID = xCOID AND pdhDedCode IN ('GLBD','GLEXC','GLIFE','GLMAX')  order by A.PdhPerControl desc)
                                END)
                                    
                                        
   INTO dbo.U_ECIRACOBQB_drvTbl_QBPLANINITIAL
    FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        and bdmIsPQB = 'Y'
        and bdmdedcode IN  ('DEN','FSA','GLBD','GLEXC','GLIFE','GLMAX','MHSA','MHSA2','MPPO','VIS','WHSA','WHSA2','WPPO','LIFEE','LIFES','LIFEC')   ---ke update 20230210

    --LEFt JOIN u_dsi_bdm_BenCalculationAmounts
    --    ON XEEid = bcaeeid 
    --    AND Xcoid = bcacoid 
    --    and bcaformatcode = 'ECIRACOBQB'
    --    and BcaDedCode IN ('GLBD','GLEXC','GLIFE','GLMAX')
    --    and bcadedcode = bdmdedcode
        
    LEFT JOIN (
              Select Distinct eedeeid, eeddedcode, EedBenAmt, (Replace(Format(EedBenAmt, '00'),'.00','')/1000) Units
              FROM empded  WITH (NOLOCK)
              --Where EedbenOption NOT In  ('W', 'C')
              Where (Replace(Format(EedBenAmt, '00'),'.00','')/1000) > 0
              ) ED
            ON EedEEID = XEEID
            AND eeddedcode = BdmDedCode
     LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT distinct EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, EdhBenOption, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN  ('DEN','FSA','GLBD','GLEXC','GLIFE','GLMAX','MHSA','MHSA2','MPPO','VIS','WHSA','WHSA2','WPPO','LIFEE','LIFES','LIFEC')  ---ke update 20230210
                        AND edhChangeReason IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
        
    WHERE 
    CASE WHEN BdmDedcode =  'DEN' THEN 'Delta Dental'
                            WHEN BdmDedcode =  'FSA' THEN 'Further FSA'
                            WHEN BdmDedcode IN  ('GLBD', 'GLEXC','GLIFE','GLMAX') AND BdmBenStatus IN ('T') THEN 'NYL Basic Life'
                            WHEN BdmDedcode =  'MHSA' THEN 'BCBS $1500 HSA Medical'
                            WHEN BdmDedcode =  'LIFEE' AND BdmBenStatus IN ('T')  THEN 'NYL Employee Voluntary Life'  ---ke update 20230210 
                            WHEN BdmDedcode =  'LIFES' AND BdmBenStatus IN ('T') and (BdmChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') or EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3')) THEN 'NYL Spouse Voluntary Life'   ---ke update 20230210 --MW added and EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') 3/14/23
                            WHEN BdmDedcode =  'LIFEC' AND BdmBenStatus IN ('T') and ( BdmChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') or EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3')) THEN 'NYL Child Vol Life'   ---ke update 20230210 --MW added and EdhChangeReason NOT IN ('LEVNT4', 'DLS', 'D', 'NLED','LEVNT3') 3/14/23
                            WHEN BdmDedcode =  'MHSA2' THEN 'BCBS $3000 HSA Medical'
                            WHEN BdmDedcode =  'MPPO' THEN 'BCBS Traditional Medical'
                            WHEN BdmDedcode =  'VIS' THEN 'EyeMed Vision'
                            WHEN BdmDedcode = 'WHSA' THEN 'BCBS $1500 HSA Medical Wisconsin'
                            WHEN BdmDedcode = 'WHSA2' THEN 'BCBS $3000 HSA Medical Wisconsin'
                            WHEN BdmDedcode = 'WPPO' THEN 'BCBS Traditional Medical Wisconsin'
                            --WHEN EecPayGroup <> 'No Pay Group' AND EecEEType = 'REG' THEN 'Modern Health EAP'
                            --WHEN BdmDedCode IN ('MHSA','MHSA2','MPPO', 'WHSA','WHSA2','WPPO') THEN 'Modern Health EAP'
                        END IS NOT NULL
            

                UNION

                SELECT DISTINCT
                     drvEEID = xEEID
                    ,drvCoID = xCoID
                    ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                    ,drvInitialSort = '1 ' + xEEID + ' 3'
                    ,drvSubSort = '3'
    
                    -- standard fields above and additional driver fields below
                    ,drvPlanName ='Modern Health EAP'
                    ,drvCoverageLevel  = 'EE'
                    ,drvNumberOfUnit =''
                FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
                JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                    ON EecEEID = xEEID 
                    AND EecCoID = xCoID
                JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
                    ON BdmEEID = xEEID 
                    AND BdmCoID = xCoID

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECIRACOBQB_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 4 ' +  BdmDepRecID + ' 1'  
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvRelationship = CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL','CLN','DHC','STC') THEN 'CHILD'
                            END
        ,drvSalutation = ''
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvAddressSameAsQB = Case ConAddressIsDifferent WHEN 'Y' THEN 'TRUE' ELSE 'FALSE' END
        ,drvAddress1 = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressLine1 END
        ,drvAddress2 = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressLine2 END
        ,drvCity = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressCity END
        ,drvState = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressState END
        ,drvZip = CASE WHEN ConAddressIsDifferent  = 'Y' THEN ConAddressZipCode END
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDOB = CONVERT(VARCHAR(10), ConDateOfBirth,101)
    INTO dbo.U_ECIRACOBQB_drvTbl_QBDEPENDENT
    FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB'
        AND BdmRecType = 'DEP'
        AND BdmIsPQB='N'
        AND bdmdedcode IN  ('DEN','FSA','GLBD','GLEXC','GLIFE','GLMAX','MHSA','MHSA2','MPPO','VIS','WHSA','WHSA2','WPPO','LIFEE','LIFES','LIFEC')   ---ke update 20230210
     JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL;
    SELECT DISTINCT
        drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 4 ' + BdmDepRecID + '2'
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BdmDedcode = 'DEN' THEN 'Delta Dental'
                            WHEN BdmDedcode = 'FSA' THEN 'Further FSA'
                            WHEN BdmDedcode IN  ('GLBD', 'GLEXC','GLIFE','GLMAX') THEN 'NYL Basic Life'
                            WHEN BdmDedcode = 'MHSA' THEN 'BCBS $1500 HSA Medical'
                            WHEN BdmDedcode =  'LIFEE' THEN 'NYL Employee Voluntary Life'  ---ke update 20230210
                            WHEN BdmDedcode =  'LIFES' THEN 'NYL Spouse Voluntary Life'  ---ke update 20230210
                            WHEN BdmDedcode =  'LIFEC' THEN 'NYL Child Vol Life'  ---ke update 20230210
                            WHEN BdmDedcode =  'MHSA2' THEN 'BCBS $3000 HSA Medical'
                            WHEN BdmDedcode =  'MPPO' THEN 'BCBS Traditional Medical'
                            WHEN BdmDedcode =  'VIS' THEN 'EyeMed Vision'
                            WHEN BdmDedcode =  'WHSA' THEN 'BCBS $1500 HSA Medical Wisconsin'
                            WHEN BdmDedcode = 'WHSA2' THEN 'BCBS $3000 HSA Medical Wisconsin'
                            WHEN BdmDedcode =  'WPPO' THEN 'BCBS Traditional Medical Wisconsin'
                            --WHEN EecPayGroup <> 'No Pay Group' AND EecEEType = 'REG' THEN 'Modern Health EAP'
                           -- WHEN BdmDedcode  IN ('MHSA','MHSA2','MPPO', 'WHSA','WHSA2','WPPO') THEN ' Modern Health EAP'

                        END 

    INTO dbo.U_ECIRACOBQB_drvTbl_QBDEPPLANINITIAL
    FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRunID = 'QB'
        AND BdmRecType = 'DEP' 
        AND BdmIsPQB = 'N'
        AND bdmdedcode IN  ('DEN','FSA','GLBD','GLEXC','GLIFE','GLMAX','MHSA','MHSA2','MPPO','VIS','WHSA','WHSA2','WPPO','LIFEE','LIFES','LIFEC')  ---ke update 20230210
     JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE
    ---------------------------------
    IF OBJECT_ID('U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE','U') IS NOT NULL
        DROP TABLE dbo.U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1 ' + xEEID + ' 6'
        ,drvSubSort = '6'
        -- standard fields above and additional driver fields below
        ,drvRecordTypeRateInitial = CASE WHEN BdmDedCode = 'FSA' THEN '[QBPLANMEMBERSPECIFICRATEINITIAL]' END
        ,drvPlanName = CASE WHEN BdmDedCode = 'FSA' THEN 'Further FSA' END
        ,drvRate =  CASE WHEN BdmDedCode = 'FSA' AND BDMEEAMT <> 0.00 THEN (BdmEEAmt*2) END  ---ke update 20230210
    INTO dbo.U_ECIRACOBQB_drvTbl_QBPLANMEMSPCRATE
    FROM dbo.U_ECIRACOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECIRACOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        AND BdmRecType = 'EMP'
        AND BdmIsPQB = 'Y'
      WHERE BdmDedCode = 'FSA' AND BDMEEAMT <> 0.00 

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
  SELECT TOP 20000000 Data FROM dbo.U_ECIRACOBQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort
END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECIRACOBQB_Export AS
  ,RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECIRACOBQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303281'
       ,expStartPerControl     = '202303281'
       ,expLastEndPerControl   = '202304109'
       ,expEndPerControl       = '202304109'
WHERE expFormatCode = 'ECIRACOBQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIRACOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIRACOBQB_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECIRACOBQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECIRACOBQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECIRACOBQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIRACOBQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECIRACOBQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIRACOBQB', 'UseFileName', 'V', 'Y'


-- End ripout