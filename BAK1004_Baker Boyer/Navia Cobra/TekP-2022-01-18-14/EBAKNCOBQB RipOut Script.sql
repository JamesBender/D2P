/**********************************************************************************

EBAKNCOBQB: Navia Cobra QB Export

FormatCode:     EBAKNCOBQB
Project:        Navia Cobra QB Export
Client ID:      BAK1004
Date/time:      2022-07-19 11:56:40.457
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB04
Database:       ULTIPRO_WPBBNB
Web Filename:   BAK1004_2QM25_EEHISTORY_EBAKNCOBQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBAKNCOBQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EBAKNCOBQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBAKNCOBQB'


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
WHERE FormatCode = 'EBAKNCOBQB'
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
WHERE ExpFormatCode = 'EBAKNCOBQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBAKNCOBQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBAKNCOBQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBAKNCOBQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBAKNCOBQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBAKNCOBQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBAKNCOBQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBAKNCOBQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBAKNCOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBAKNCOBQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBAKNCOBQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBAKNCOBQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBAKNCOBQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBAKNCOBQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAKNCOBQB];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QBPLANINITIAL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QBPLANINITIAL_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QBEVENT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QBEVENT_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QBDEPENDENT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QBDEPENDENT_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_QB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_QB_drvTbl];
GO
IF OBJECT_ID('U_EBAKNCOBQB_File') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_File];
GO
IF OBJECT_ID('U_EBAKNCOBQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_EEList];
GO
IF OBJECT_ID('U_EBAKNCOBQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_DedList];
GO
IF OBJECT_ID('U_EBAKNCOBQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_AuditFields];
GO
IF OBJECT_ID('U_EBAKNCOBQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBAKNCOBQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBAKNCOBQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBAKNCOBQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBAKNCOBQB','Navia Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EBAKNCOBQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"1.2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"Baker Boyer National Bank"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAKNCOBQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"Baker Boyer National Bank"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAKNCOBQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAKNCOBQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAKNCOBQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAKNCOBQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAKNCOBQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAKNCOBQBZ0','50','D','10','9',NULL,'IndividualIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAKNCOBQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAKNCOBQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAKNCOBQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAKNCOBQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAKNCOBQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAKNCOBQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAKNCOBQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAKNCOBQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAKNCOBQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAKNCOBQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAKNCOBQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAKNCOBQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAKNCOBQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAKNCOBQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAKNCOBQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAKNCOBQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'"','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAKNCOBQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBAKNCOBQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBAKNCOBQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBAKNCOBQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBAKNCOBQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBAKNCOBQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBAKNCOBQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBAKNCOBQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBAKNCOBQBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBAKNCOBQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBAKNCOBQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBAKNCOBQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBAKNCOBQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBAKNCOBQBZ0','50','D','10','39',NULL,'SSOIdentifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBAKNCOBQBZ0','50','D','10','40',NULL,'PlanCategory',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAKNCOBQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAKNCOBQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAKNCOBQBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAKNCOBQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAKNCOBQBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','30','1',NULL,'Record Type',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAKNCOBQBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAKNCOBQBZ0','50','D','30','4',NULL,'NumberOfUnit',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','40','1',NULL,'Record Type',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAKNCOBQBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAKNCOBQBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAKNCOBQBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAKNCOBQBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAKNCOBQBZ0','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAKNCOBQBZ0','50','D','40','8',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAKNCOBQBZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAKNCOBQBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAKNCOBQBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAKNCOBQBZ0','50','D','40','12',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAKNCOBQBZ0','50','D','40','13',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAKNCOBQBZ0','50','D','40','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAKNCOBQBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAKNCOBQBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAKNCOBQBZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAKNCOBQBZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAKNCOBQBZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAKNCOBQBZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAKNCOBQBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','50','1',NULL,'Record Type',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','60','1',NULL,'Record Type',NULL,NULL,'"[QBSTATEINSERTS]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','60','2',NULL,'ORSRINSERT',NULL,NULL,'"drvORSRINSERT"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAKNCOBQBZ0','50','D','70','1',NULL,'Record Type',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAKNCOBQBZ0','50','D','70','2',NULL,'PlanName',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAKNCOBQBZ0','50','D','70','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBAKNCOBQB_20220719.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Navia Cobra QB Export','202207259','EMPEXPORT','ONDEM_XOE',NULL,'EBAKNCOBQB',NULL,NULL,NULL,'202207259','May 25 2022 11:48AM','May 25 2022 11:48AM','202201181',NULL,'','','202201181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Navia Cobra QB Export-Sched','202207259','EMPEXPORT','SCH_EBN401',NULL,'EBAKNCOBQB',NULL,NULL,NULL,'202207259','May 25 2022 11:48AM','May 25 2022 11:48AM','202201181',NULL,'','','202201181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','3YN7L',NULL,NULL,NULL,'Navia Cobra QB Export-Test','202207259','EMPEXPORT','TEST_XOE',NULL,'EBAKNCOBQB',NULL,NULL,NULL,'202207259','May 25 2022 11:48AM','May 25 2022 11:48AM','202201181',NULL,'','','202201181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAKNCOBQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAKNCOBQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAKNCOBQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAKNCOBQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAKNCOBQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAKNCOBQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D10','dbo.U_EBAKNCOBQB_QB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D20','dbo.U_EBAKNCOBQB_QBEVENT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D30','dbo.U_EBAKNCOBQB_QBPLANINITIAL_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D40','dbo.U_EBAKNCOBQB_QBDEPENDENT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D50','dbo.U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D60','dbo.U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAKNCOBQB','D70','dbo.U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBAKNCOBQB
-----------

IF OBJECT_ID('U_dsi_BDM_EBAKNCOBQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBAKNCOBQB] (
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
-- Create table U_EBAKNCOBQB_Audit
-----------

IF OBJECT_ID('U_EBAKNCOBQB_Audit') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_Audit] (
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
-- Create table U_EBAKNCOBQB_AuditFields
-----------

IF OBJECT_ID('U_EBAKNCOBQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBAKNCOBQB_DedList
-----------

IF OBJECT_ID('U_EBAKNCOBQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBAKNCOBQB_EEList
-----------

IF OBJECT_ID('U_EBAKNCOBQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBAKNCOBQB_File
-----------

IF OBJECT_ID('U_EBAKNCOBQB_File') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EBAKNCOBQB_QB_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvSex] char(1) NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EBAKNCOBQB_QBDEPENDENT_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QBDEPENDENT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QBDEPENDENT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSex] char(1) NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(27) NULL
);

-----------
-- Create table U_EBAKNCOBQB_QBEVENT_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QBEVENT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QBEVENT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEventType] varchar(22) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(201) NULL
);

-----------
-- Create table U_EBAKNCOBQB_QBPLANINITIAL_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QBPLANINITIAL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QBPLANINITIAL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(27) NULL,
    [drvCoverageLevel] varchar(18) NOT NULL
);

-----------
-- Create table U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(4) NOT NULL,
    [drvRate] money NULL
);

-----------
-- Create table U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl
-----------

IF OBJECT_ID('U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvORSRINSERT] varchar(11) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAKNCOBQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Baker Boyer

Created By: Marie Thomerson
Business Analyst: Curlin Beck
Create Date: 05/26/2022
Service Request Number: TekP-2022-01-18-14

Purpose: Navia Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters       07/19/2022     TekP-2022-01-18-14   remove the line for NON-FSA Plans on [QBPLANMEMBERSPECIFICRATEINITIAL]

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBAKNCOBQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBAKNCOBQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBAKNCOBQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBAKNCOBQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBAKNCOBQB' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201011'
       ,expStartPerControl     = '202201011'
       ,expLastEndPerControl   = '202210319'
       ,expEndPerControl       = '202210319'
WHERE expFormatCode = 'EBAKNCOBQB';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAKNCOBQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAKNCOBQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAKNCOBQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAKNCOBQB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAKNCOBQB', 'SCH_EBAKNC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBAKNCOBQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBAKNCOBQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBAKNCOBQB';

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
    DELETE FROM dbo.U_EBAKNCOBQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBAKNCOBQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBAKNCOBQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_AuditFields;
    CREATE TABLE dbo.U_EBAKNCOBQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EBAKNCOBQB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EBAKNCOBQB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EBAKNCOBQB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EBAKNCOBQB_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EBAKNCOBQB_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EBAKNCOBQB_AuditFields VALUES ('EmpDed','EedDedCode');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBAKNCOBQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_Audit;
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
    INTO dbo.U_EBAKNCOBQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBAKNCOBQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBAKNCOBQB_Audit ON dbo.U_EBAKNCOBQB_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,DEN2,MED,MED1,MED2,MED3,MED4,VIS,VIS2,FSA,FSALP';

    IF OBJECT_ID('U_EBAKNCOBQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBAKNCOBQB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    --QB Section
    --==========================================

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');


    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    
    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','4'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #6.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;

    --==========================================
    -- Insert into BDM Reason code 201 and 204
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EBAKNCOBQB]
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

    DELETE FROM dbo.U_dsi_BDM_EBAKNCOBQB WHERE bdmdedcode NOT IN  (SELECT DISTINCT Dedcode FROM dbo.U_EBAKNCOBQB_DedList)
    
    UPDATE dbo.U_dsi_BDM_EBAKNCOBQB 
        SET bdmNumSpouses = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EBAKNCOBQB A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'SPS' AND A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EBAKNCOBQB A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'CHL' AND A.bdmcoid = X.bdmcoid)
    FROM dbo.U_dsi_BDM_EBAKNCOBQB  X
    WHERE BdmDedRowStatus IN ('Data Inserted for 302 Chg reason') --,'Data Inserted for 201 Chg reason')

--==========================================
 -- Insert into BDM Reason code 201 and 204
 --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EBAKNCOBQB]
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

INSERT INTO [dbo].[U_dsi_BDM_EBAKNCOBQB]
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

  INSERT INTO [dbo].[U_dsi_BDM_EBAKNCOBQB]
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

 Delete from dbo.U_dsi_BDM_EBAKNCOBQB where bdmdedcode not in (Select dedcode from U_EBAKNCOBQB_DedList)
 --Delete from U_dsi_BDM_EBAKNCOBQB where bdmrelationship = 'Z'


 Update dbo.U_dsi_BDM_EBAKNCOBQB set bdmNumSpouses = (select count(*) from U_dsi_BDM_EBAKNCOBQB A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid),
 bdmNumChildren = (select count(*) from U_dsi_BDM_EBAKNCOBQB A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
 from dbo.U_dsi_BDM_EBAKNCOBQB X where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 210 Chg reason')

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBAKNCOBQB_QB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvEmail = EepAddressEmailAlternate
        ,drvPhone = EepPhoneHomeNumber
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateOrProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvSex = EepGender
        ,drvDOB = EepDateOfBirth
    INTO dbo.U_EBAKNCOBQB_QB_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
  
    ;

       -- FROM dbo.U_dsi_BDM_EDSICCBEXP WITH (NOLOCK)
    --JOIN dbo.EmpComp WITH (NOLOCK)
    --    ON EecEEID = BdmEEID
    --   AND EecCoID = BdmCoID
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = BdmEEID
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    --    ON ConEEID = BdmEEID
    --   AND ConSystemID = BdmDepRecID
    --WHERE BdmRunID = 'QB'
    --  AND BdmIsPQB = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_EBAKNCOBQB_QBEVENT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QBEVENT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QBEVENT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 2'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE    WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                                WHEN bdmChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'DEATH'
                                WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','208') THEN 'RETIREMENT'
                                --If edhChangeReason = 208 or EecEmplStatus = T and EecTermReason = 202 send RETIREMENT 
                                WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'TERMINATION'
                                WHEN bdmChangeReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                --WHEN bdmChangeReason = '205' then 'MEDICARE'
                                --WHEN bdmChangeReason IN ('203','202') then 'REDUCTIONINHOURS-STATUSCHANGE' 
                                --WHEN bdmChangeReason = '206' then 'REDUCTIONINHOURS-ENDOFLEAVE'  
                        END        
                                                                                                      
        ,drvEventDate = CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201','LEVNT3') THEN BdmBenStatusDate else BdmDateOfCOBRAEvent END
        -- effective date
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN = CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201','LEVNT3') then EepSSN END
        ,drvNameFirst = CASE WHEN BdmChangeReason in ('204', 'LEVNT4', '201','LEVNT3') then EepNameFirst + ' ' + EepNameLast END
        --,drvInitialSort    = '21'
  --      ,drvSubSort        = drvSubSort
  --      ,drvSubSort2       = '1'
  --      ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EBAKNCOBQB_QBEVENT_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
        --AND BchIsCOBRAQualifiedEvent = 'Y'
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID

        ;


    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN (SELECT
    --         BdmEEID
    --        ,BdmCoID
    --        ,BdmDepRecID
    --        ,BdmRecType
    --        ,BdmCobraReason = MAX(BdmCobraReason)
    --        ,BdmChangereason = MAX(BdmChangereason)
    --        ,BdmBenStartDate = MIN(BdmBenStartDate)
    --        ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
    --        ,BdmUSGDate1 = MAX(BdmUSGDate1)
    --        ,BdmBenStatusDate = MAX(BdmBenStatusDate)
    --      FROM dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
    --      WHERE BdmRunID = 'QB'
    --        AND BdmIsPQB = 'Y'
    --      GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
    --    ON BdmEEID = xEEID
    --   AND BdmCoID = xCoID
    --   --AND ISNULL(BdmDepRecID,'') = BdmDepRecID;

    -----------------------------------
    ---- DETAIL RECORD - U_EBAKNCOBQB_QBPLANINITIAL_drvTbl
    -----------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QBPLANINITIAL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QBPLANINITIAL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 3'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE                                                                                                                                          
                            When BdmDedCode = 'FSA' then 'Navia FSA'                                                             
                            When BdmDedCode = 'FSALP' then 'Navia Limited FSA'                                        
                            When BdmDedCode = 'VIS1' then 'Vision Plan'         
                            When BdmDedCode IN ('MED1','MED2') then 'Copay Plan' 
                            When BdmDedCode ='DEN2' then 'Dental PPO'   
                            When BdmDedCode IN ('MED3','MED4') then 'High Deductible Health Plan'
                        END
        ,drvCoverageLevel = 
        --(Over age dep, Divorce or Death) - 
                        CASE    WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3','210') and BdmDedCode NOT IN ('FSA','FSALP') AND bdmrelationship = 'SPS'  then 'EE+SPOUSE'                                                                        
                                WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3','210') and BdmDedCode NOT IN ('FSA','FSALP') AND bdmrelationship in ('DP')  then 'EE+DOMESTICPARTNER'                                                               
                                WHEN BdmChangeReason in ('204', 'LEVNT4', '201', 'LEVNT3','210') and BdmDedCode NOT IN ('FSA','FSALP') AND bdmrelationship in ('CHL','DPC','STC','DCH') THEN 'EE+CHILD'
                                --WHEN BdmChangeReason in ('204, LEVNT4, 201, LEVNT3,'210') and BdmDedCode NOT IN ('FSA',' FSALP') AND If bdmrelationship = more than 1 CHL,DPC,STC or DCH THEN 'EE+CHILDREN'
                                --If bdmrelationship = SPS OR DP AND more than 1 CHL,DPC,STC or DCH') AND BdmDedCode NOT IN ('FSA',' FSALP') AND THEN 'EE+FAMILY'
                                ELSE 'EE'
                                END
    INTO dbo.U_EBAKNCOBQB_QBPLANINITIAL_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
        --AND BdmRelationship IN ('SPS', 'DP', 'CHL')
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID

    ;

    ---------------------------------
    -- DETAIL RECORD - U_EBAKNCOBQB_QBDEPENDENT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QBDEPENDENT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QBDEPENDENT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 4'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvRelationship = CASE WHEN BdmRelationship = 'SP' THEN 'SPOUSE'
                                WHEN BdmRelationship = 'CHL' THEN 'CHILD'
                                WHEN BdmRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                END
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvEmail = EepAddressEmailAlternate
        ,drvPhone = EepPhoneHomeNumber
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateOrProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSex = EepGender
        ,drvDOB = EepDateOfBirth
    INTO dbo.U_EBAKNCOBQB_QBDEPENDENT_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
    JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID

    ;

    ---------------------------------
    -- DETAIL RECORD - U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 5'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE    When BdmDedCode = 'FSA' then 'Navia FSA'                                                             
                            When BdmDedCode = 'FSALP' then 'Navia Limited FSA'                                        
                            When BdmDedCode = 'VIS1' then 'Vision Plan'         
                            When BdmDedCode IN ('MED1','MED2') then 'Copay Plan' 
                            When BdmDedCode = 'DEN2' then 'Dental PPO'   
                            When BdmDedCode IN ('MED3','MED4') then 'High Deductible Health Plan'
                            END
    INTO dbo.U_EBAKNCOBQB_QBDEPENDENTPLANINITIAL_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
    JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;

        ---------------------------------
    -- DETAIL RECORD - U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 6'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvORSRINSERT = CASE    WHEN EepAddressState = 'CA' then 'CA-SRINSERT'
                                WHEN EepAddressState = 'CT' then 'CT-SRINSERT' 
                                WHEN EepAddressState = 'GA' then 'GA-SRINSERT' 
                                WHEN EepAddressState = 'IL' then 'IL-SRINSERT' 
                                WHEN EepAddressState = 'MN' then 'MN-SRINSERT' 
                                WHEN EepAddressState = 'NY' then 'NY-SRINSERT' 
                                WHEN EepAddressState = 'OR' then 'OR-SRINSERT' 
                                WHEN EepAddressState = 'RI' then 'RI-SRINSERT' 
                                WHEN EepAddressState = 'TX' then 'TX-SRINSERT' 
                                WHEN EepAddressState = 'VA' then 'VA-SRINSERT' 
                                END
    INTO dbo.U_EBAKNCOBQB_QBSTATEINSERTS_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID

    ;

        ---------------------------------
    -- DETAIL RECORD - U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort = '1 ' + xEEID + ' 7'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'TRUE'
        ,drvRate = CASE WHEN Bdmdedcode in ('FSA','FSALP') THEN BdmEEAmt END
    INTO dbo.U_EBAKNCOBQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
    FROM dbo.U_EBAKNCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAKNCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'Y'
    LEFT JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        Where BdmDedCode = 'FSA' --- added 7/19/22
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
ALTER VIEW dbo.dsi_vwEBAKNCOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAKNCOBQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBAKNCOBQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201181'
       ,expStartPerControl     = '202201181'
       ,expLastEndPerControl   = '202207259'
       ,expEndPerControl       = '202207259'
WHERE expFormatCode = 'EBAKNCOBQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBAKNCOBQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAKNCOBQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBAKNCOBQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBAKNCOBQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBAKNCOBQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAKNCOBQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBAKNCOBQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAKNCOBQB', 'UseFileName', 'V', 'Y'


-- End ripout