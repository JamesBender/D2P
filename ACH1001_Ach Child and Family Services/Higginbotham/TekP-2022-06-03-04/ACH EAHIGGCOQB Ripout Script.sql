/**********************************************************************************

EAHIGGCOQB: Higginbotham Cobra QB Export

FormatCode:     EAHIGGCOQB
Project:        Higginbotham Cobra QB Export
Client ID:      ACH1001
Date/time:      2022-10-11 09:05:41.633
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB02
Database:       ULTIPRO_WPACHS
Web Filename:   ACH1001_XTE10_EEHISTORY_EAHIGGCOQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAHIGGCOQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EAHIGGCOQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAHIGGCOQB'


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
WHERE FormatCode = 'EAHIGGCOQB'
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
WHERE ExpFormatCode = 'EAHIGGCOQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAHIGGCOQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAHIGGCOQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAHIGGCOQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAHIGGCOQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAHIGGCOQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAHIGGCOQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAHIGGCOQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAHIGGCOQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAHIGGCOQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAHIGGCOQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAHIGGCOQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAHIGGCOQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAHIGGCOQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAHIGGCOQB];
GO
IF OBJECT_ID('U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl];
GO
IF OBJECT_ID('U_EAHIGGCOQB_QBEvents_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_QBEvents_drvTbl];
GO
IF OBJECT_ID('U_EAHIGGCOQB_QBDependents_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_QBDependents_drvTbl];
GO
IF OBJECT_ID('U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl];
GO
IF OBJECT_ID('U_EAHIGGCOQB_QB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_QB_drvTbl];
GO
IF OBJECT_ID('U_EAHIGGCOQB_PlanInitial_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_PlanInitial_drvTbl];
GO
IF OBJECT_ID('U_EAHIGGCOQB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_PEarHist];
GO
IF OBJECT_ID('U_EAHIGGCOQB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_PDedHist];
GO
IF OBJECT_ID('U_EAHIGGCOQB_File') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_File];
GO
IF OBJECT_ID('U_EAHIGGCOQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_EEList];
GO
IF OBJECT_ID('U_EAHIGGCOQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAHIGGCOQB_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EAHIGGCOQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAHIGGCOQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAHIGGCOQB','Higginbotham Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EAHIGGCOQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','H','01','1',NULL,'RecordType',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHIGGCOQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"1.2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','D','10','1',NULL,'RecordType',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHIGGCOQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"ACH Child & Family Services"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHIGGCOQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"ACH Child & Family Services"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHIGGCOQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHIGGCOQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHIGGCOQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHIGGCOQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHIGGCOQBZ0','50','D','10','8',NULL,'QBSSN',NULL,NULL,'"drvQBSSN "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHIGGCOQBZ0','50','D','10','9',NULL,'IndividualIdentifier',NULL,NULL,'"drvIntividualIdentifier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHIGGCOQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHIGGCOQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHIGGCOQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHIGGCOQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAHIGGCOQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAHIGGCOQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAHIGGCOQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAHIGGCOQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAHIGGCOQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAHIGGCOQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAHIGGCOQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAHIGGCOQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAHIGGCOQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAHIGGCOQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAHIGGCOQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAHIGGCOQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAHIGGCOQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAHIGGCOQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAHIGGCOQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAHIGGCOQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAHIGGCOQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAHIGGCOQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EAHIGGCOQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EAHIGGCOQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EAHIGGCOQBZ0','50','D','10','34',NULL,'ACTIVE',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EAHIGGCOQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EAHIGGCOQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EAHIGGCOQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EAHIGGCOQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EAHIGGCOQBZ0','50','D','10','39',NULL,'AllowMemberSSO',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EAHIGGCOQBZ0','50','D','10','40',NULL,'SSOIdenitifier',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EAHIGGCOQBZ0','50','D','10','41',NULL,'PlanCategory',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','D','15','1',NULL,'RecordType',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHIGGCOQBZ0','50','D','15','2',NULL,'Eventtype',NULL,NULL,'"drvEventtype"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHIGGCOQBZ0','50','D','15','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHIGGCOQBZ0','50','D','15','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHIGGCOQBZ0','50','D','15','5',NULL,'EmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHIGGCOQBZ0','50','D','15','6',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHIGGCOQBZ0','50','D','15','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','D','20','1',NULL,'RecordType',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHIGGCOQBZ0','50','D','20','3',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHIGGCOQBZ0','50','D','20','6',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHIGGCOQBZ0','50','D','20','13',NULL,'NumberOfUnits',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','D','30','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHIGGCOQBZ0','50','D','30','3',NULL,'DependentSSN',NULL,NULL,'"drvDependentSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHIGGCOQBZ0','50','D','30','5',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHIGGCOQBZ0','50','D','30','6',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHIGGCOQBZ0','50','D','30','7',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHIGGCOQBZ0','50','D','30','8',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHIGGCOQBZ0','50','D','30','9',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHIGGCOQBZ0','50','D','30','10',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHIGGCOQBZ0','50','D','30','11',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHIGGCOQBZ0','50','D','30','12',NULL,'Phone2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHIGGCOQBZ0','50','D','30','13',NULL,'AddressSameAsQB',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAHIGGCOQBZ0','50','D','30','14',NULL,'Address1',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAHIGGCOQBZ0','50','D','30','15',NULL,'Address2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAHIGGCOQBZ0','50','D','30','16',NULL,'City',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAHIGGCOQBZ0','50','D','30','17',NULL,'StateOrProvince',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAHIGGCOQBZ0','50','D','30','18',NULL,'PostalCode',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAHIGGCOQBZ0','50','D','30','19',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAHIGGCOQBZ0','50','D','30','20',NULL,'EnrollmentDate',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAHIGGCOQBZ0','50','D','30','21',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAHIGGCOQBZ0','50','D','30','22',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAHIGGCOQBZ0','50','D','30','23',NULL,'IsQMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','D','40','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHIGGCOQBZ0','50','D','40','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHIGGCOQBZ0','50','D','50','1',NULL,'RecordType',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHIGGCOQBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHIGGCOQBZ0','50','D','50','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAHIGGCOQB_20221011.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202208099','EMPEXPORT','OEACTIVE',NULL,'EAHIGGCOQB',NULL,NULL,NULL,'202208099','Jul 25 2022  3:46PM','Jul 25 2022  3:46PM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208099','EMPEXPORT','OEPASSIVE',NULL,'EAHIGGCOQB',NULL,NULL,NULL,'202208099','Jul 25 2022  3:46PM','Jul 25 2022  3:46PM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Higginbotham Cobra QB export','202208099','EMPEXPORT','ONDEM_XOE',NULL,'EAHIGGCOQB',NULL,NULL,NULL,'202208099','Jul 25 2022  3:46PM','Jul 25 2022  3:46PM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202208099','EMPEXPORT','SCH_EAHIGG',NULL,'EAHIGGCOQB',NULL,NULL,NULL,'202208099','Jul 25 2022  3:46PM','Jul 25 2022  3:46PM','202107011',NULL,'','','202107011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202208099','EMPEXPORT','TEST_XOE','Oct  3 2022 12:00AM','EAHIGGCOQB',NULL,NULL,NULL,'202208099','Aug  9 2022 12:00AM','Dec 30 1899 12:00AM','202207011',NULL,'','','202207011',dbo.fn_GetTimedKey(),NULL,'us3rByACH1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHIGGCOQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','D10','dbo.U_EAHIGGCOQB_QB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','D15','dbo.U_EAHIGGCOQB_QBEvents_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','D20','dbo.U_EAHIGGCOQB_PlanInitial_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','D30','dbo.U_EAHIGGCOQB_QBDependents_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','D40','dbo.U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHIGGCOQB','D50','dbo.U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EAHIGGCOQB
-----------

IF OBJECT_ID('U_dsi_BDM_EAHIGGCOQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAHIGGCOQB] (
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
-- Create table U_EAHIGGCOQB_DedList
-----------

IF OBJECT_ID('U_EAHIGGCOQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAHIGGCOQB_EEList
-----------

IF OBJECT_ID('U_EAHIGGCOQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAHIGGCOQB_File
-----------

IF OBJECT_ID('U_EAHIGGCOQB_File') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EAHIGGCOQB_PDedHist
-----------

IF OBJECT_ID('U_EAHIGGCOQB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_PDedHist] (
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
-- Create table U_EAHIGGCOQB_PEarHist
-----------

IF OBJECT_ID('U_EAHIGGCOQB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_PEarHist] (
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

-----------
-- Create table U_EAHIGGCOQB_PlanInitial_drvTbl
-----------

IF OBJECT_ID('U_EAHIGGCOQB_PlanInitial_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_PlanInitial_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(39) NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_EAHIGGCOQB_QB_drvTbl
-----------

IF OBJECT_ID('U_EAHIGGCOQB_QB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_QB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubsort] int NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvQBSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvIntividualIdentifier] char(9) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDOB] varchar(30) NULL,
    [drvEmployeeType] varchar(3) NOT NULL
);

-----------
-- Create table U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl
-----------

IF OBJECT_ID('U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(16) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(37) NULL
);

-----------
-- Create table U_EAHIGGCOQB_QBDependents_drvTbl
-----------

IF OBJECT_ID('U_EAHIGGCOQB_QBDependents_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_QBDependents_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(16) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvDependentNumber] varchar(2) NULL,
    [drvQBSSN] char(11) NULL,
    [drvDependentSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvSex] varchar(1) NULL,
    [drvDOB] varchar(30) NULL,
    [drvIsQMCSO] varchar(5) NOT NULL,
    [drvStartDate] varchar(30) NULL,
    [drvUsesFDOC] varchar(4) NOT NULL,
    [drvRank] int NOT NULL
);

-----------
-- Create table U_EAHIGGCOQB_QBEvents_drvTbl
-----------

IF OBJECT_ID('U_EAHIGGCOQB_QBEvents_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_QBEvents_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventdate] varchar(30) NULL,
    [drvEnrollmentDate] varchar(30) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
-----------

IF OBJECT_ID('U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(16) NULL,
    [drvSubSort] int NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(39) NOT NULL,
    [drvRate] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAHIGGCOQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ACH Child and Family Svc

Created By: Roger Bynum
Business Analyst: Cheryl Petititi
Create Date: 07/25/2022
Service Request Number: SR-2016-00012345

Purpose: Higginbotham Cobra QB export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAHIGGCOQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAHIGGCOQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAHIGGCOQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAHIGGCOQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAHIGGCOQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHIGGCOQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHIGGCOQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHIGGCOQB', 'SCH_EAHIGG';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHIGGCOQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHIGGCOQB', 'OEACTIVE';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAHIGGCOQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAHIGGCOQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAHIGGCOQB';

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
    DELETE FROM dbo.U_EAHIGGCOQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAHIGGCOQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MDPOS, MDBP, DEN, VIS, FSA';

    IF OBJECT_ID('U_EAHIGGCOQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAHIGGCOQB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
   DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups ? 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists ? 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) ? 

    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- 
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); 
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDep','201,204,210,LEVNT3,LEVNT4'); 


    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,203,204,210,302,LEVNT3,LEVNT4'); -- 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,203,204,210,302,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason ? 


    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CH,CHL,DPC,STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'N')

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


        IF OBJECT_ID('U_EAHIGGCOQB_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_PDedHist;
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
    INTO dbo.U_EAHIGGCOQB_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAHIGGCOQB_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_PEarHist;
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
    INTO dbo.U_EAHIGGCOQB_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

        -----------------------------
    -- Working Table - dbo.EAHIGGCOQB_Dependents
    -----------------------------
    IF OBJECT_ID('EAHIGGCOQB_Dependents','U') IS NOT NULL
    DROP TABLE dbo.EAHIGGCOQB_Dependents;

    CREATE TABLE dbo.EAHIGGCOQB_Dependents
    (dEEID VARCHAR (20) NOT NULL
    ,dSystemID VARCHAR(20) NOT NULL
    ,dRelationship VARCHAR(20) NOT NULL
    ,dRank INT NOT NULL
    )

   INSERT INTO dbo.EAHIGGCOQB_Dependents 
    (dEEID
    ,dSystemID
    ,dRelationship
    ,dRank)
    SELECT DISTINCT BdmEEID, BdmDepRecID, 'SPOUSE', 1
    FROM dbo.U_dsi_BDM_EAHIGGCOQB
    WHERE BdmRelationship IN ('SPS', 'DP', 'LP')



    INSERT INTO dbo.EAHIGGCOQB_Dependents 
    (dEEID
    ,dSystemID
    ,dRelationship
    ,dRank)
    SELECT DISTINCT
    bdmEEID, BdmDepRecID, 'Child' AS Relationship,
        RANK() OVER 
        (PARTITION BY b.bdmEEID ORDER BY MAX(ConDateOfBirth) DESC) AS RANK 
    FROM (SELECT DISTINCT BdmEEID, BdmDepRecID, ConDateOfBirth
    FROM dbo.U_dsi_BDM_EAHIGGCOQB
    JOIN dbo.Contacts ON ConSystemID = BdmDepRecID
    WHERE BdmRelationship IN ('CHL','COD','DCH','DPC','STC')) b
    GROUP BY b.bdmEEID, BdmDepRecID

    UPDATE dbo.EAHIGGCOQB_Dependents 
    SET dRank = dRank + 1
    WHERE dRelationship = 'CHILD'


    --==========================================
    -- Build Driver Tables
    --==========================================
        ---------------------------------
    -- HEADER RECORD - U_EAHIGGCOQB_Dependents_drvTbl
    ---------------------------------
    --  IF OBJECT_ID('U_EAHIGGCOQB_Header','U') IS NOT NULL
    --    DROP TABLE dbo.U_EAHIGGCOQB_Header;
    --SELECT DISTINCT
    --     drvVersionNumber = '[VERSION] 1.2'
    --INTO dbo.U_EAHIGGCOQB_Header

    ---------------------------------
    -- DETAIL RECORD - U_EAHIGGCOQB_QB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_QB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_QB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_1'
        ,drvSubsort = 1
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvQBSSN = CASE WHEN bdmChangeReason IN ('DEP', '201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConSSN ELSE eepssn END
        ,drvFirstName = CASE WHEN bdmChangeReason IN ('DEP', '201', 'LEVNT3', '204', '210', 'LEVNT4') THEN ConNameFirst ELSE EepNameFirst END
        ,drvMiddleInitial = CASE WHEN bdmChangeReason IN ('DEP', '201', 'LEVNT3', '204', '210', 'LEVNT4') THEN  LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle,1) END
        ,drvLastName =  CASE WHEN bdmChangeReason IN ('DEP', '201', 'LEVNT3', '204', '210', 'LEVNT4') THEN  LEFT(ConNameLast, 1) ELSE EepNameLast END
        ,drvIntividualIdentifier = EecEmpNo
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateOrProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvSex =  CASE WHEN bdmChangeReason IN ('DEP', '201', 'LEVNT3', '204', '210', 'LEVNT4') 
                            THEN CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                        ELSE CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
                   END
        ,drvDOB = CASE WHEN bdmChangeReason IN ('DEP', '201', 'LEVNT3', '204', '210', 'LEVNT4') THEN CONVERT(VARCHAR, conDateOfBirth, 101) ELSE CONVERT(VARCHAR, EepDateOfBirth, 101) END
        ,drvEmployeeType = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'PTE' ELSE 'FTE' END
    INTO dbo.U_EAHIGGCOQB_QB_drvTbl
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND conSystemID = bdmSystemID
    JOIN dbo.U_EAHIGGCOQB_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN (SELECT bdmEEID, MAX(bdmBenStartDate) AS EEStartDate
          FROM dbo.U_dsi_BDM_EAHIGGCOQB
          WHERE BdmDedCode in ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
          GROUP BY  bdmEEID) AS eb
          ON eb.BdmEEID = xEEID
    LEFT JOIN (SELECT bdmSystemID, MAX(bdmBenStartDate) AS CnStartDate
          FROM dbo.U_dsi_BDM_EAHIGGCOQB
          WHERE BdmDedCode in ('MDPOS', 'MDBP', 'DEN', 'VIS', 'FSA')
          GROUP BY  bdmSystemID) AS cb
          ON cb.bdmSystemID = ConSystemID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAHIGGCOQB_QBEvents_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_QBEvents_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_QBEvents_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_2'
        ,drvSubSort = '2'
        --,drvRecordType = '[QBEVENT]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE WHEN edhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                             WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH'
                             WHEN edhChangeReason = '205' THEN 'MEDICARE'
                             WHEN edhChangeReason IN ('DEP','201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                             WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND eectermtype = 'V' THEN 'TERMINATION'
                             WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('202','203') AND eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                             WHEN edhChangeReason = '208' OR (EecEmplStatus = 'T' AND EecTermReason = '202') THEN 'RETIREMENT'
                             WHEN edhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                             WHEN edhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                        END
        ,drvEventdate = CASE WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('202','203') THEN CONVERT(VARCHAR, EecDateOfTermination, 101)
                             WHEN EecEmplStatus = 'T' and EecTermReason IN ('202','203') AND ISNULL(eepDateOfCOBRAEvent, '') = ''  THEN CONVERT(VARCHAR, EecDateOfTermination, 101)
                             WHEN edhChangeReason IN ('DEP','LEVNT3','LEVNT4','204','210','201') THEN CONVERT(VARCHAR, edheffdate, 101)
                             ELSE CONVERT(VARCHAR, eepDateOfCOBRAEvent, 101)
                        END
        ,drvEnrollmentDate = CASE WHEN edhChangeReason IN ('DEP','LEVNT3','LEVNT4','204','210','201') THEN CONVERT(VARCHAR, ConStartDate, 101)
                                  ELSE CONVERT(VARCHAR, EEStartDate , 101)
                             END
        ,drvEmployeeSSN = EepSSN
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast
        --,drvSecondEventOriginalFDOC = ''
    INTO dbo.U_EAHIGGCOQB_QBEvents_drvTbl
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --AND BdmDedCode IN ('MDPOS','MDBP')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID
    LEFT JOIN (SELECT bdmEEID AS cEEID, MAX(BdmBenStartDate) AS ConStartDate
            FROM dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
            WHERE BdmRecType = 'DEP'
            GROUP BY bdmEEID) AS cb
        ON cEEID = xEEID
    LEFT JOIN (SELECT bdmEEID AS eEEID, MAX(BdmBenStartDate) AS EEStartDate
            FROM dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
                WHERE BdmRecType = 'EMP'
                GROUP BY bdmEEID) AS eb 
        ON eEEID = xEEID


    ---------------------------------
    -- DETAIL RECORD - U_EAHIGGCOQB_PlanInitial_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_PlanInitial_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_PlanInitial_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_3'
        ,drvSubSort = '2'
        --,drvRecordType = '[QBPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        --,drvQBSSN =  CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN conSSN
        --                  ELSE eepSSN
        --             END
        ,drvPlanName = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN
                                CASE WHEN BdmDedCode = 'MDPOS' THEN 'Aetna CPOSII Medical Plan'
                                     WHEN BdmDedCode = 'MDBP' THEN  'Aetna Texas Health EPO Medical Plan'
                                END
                            ELSE CASE WHEN BdmDedCode = 'MDPOS' THEN 'Aetna CPOSII Medical Plan'
                                      WHEN BdmDedCode = 'MDBP' THEN 'Aetna Texas Health EPO Medical Plan'
                                 END
                      END
        --,drvStartDate = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') 
        --                     THEN CONVERT(VARCHAR,DATEADD(day, 1,DbnBenStopDate) ,101)
        --                     ELSE CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
        --                END
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
    INTO dbo.U_EAHIGGCOQB_PlanInitial_drvTbl
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('MDPOS','MDBP')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION
    
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_3'
        ,drvSubSort = '3'
        --,drvRecordType = '[QBPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        --,drvQBSSN =  CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN conSSN
                     --     ELSE eepSSN
                     --END
        ,drvPlanName = 'Aetna Employee Assistance Plan'
        --,drvStartDate = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') 
                        --     THEN CONVERT(VARCHAR,DATEADD(day, 1,DbnBenStopDate) ,101)
                        --     ELSE CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
                        --END
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('MDPOS','MDBP')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

        UNION

        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_3'
        ,drvSubSort = '4'
        --,drvRecordType = '[QBPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        --,drvQBSSN =  CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN conSSN
                     --     ELSE eepSSN
                     --END
        ,drvPlanName = 'Higginbotham HRA - must elect medical'
        --,drvStartDate = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') 
        --                     THEN CONVERT(VARCHAR,DATEADD(day, 1,DbnBenStopDate) ,101)
        --                     ELSE CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
        --                END
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('MDPOS','MDBP')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION 

         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_3'
        ,drvSubSort = '5'
        --,drvRecordType = '[QBPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        --,drvQBSSN =  CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN conSSN
                     --     ELSE eepSSN
                     --END
        ,drvPlanName = 'Aetna PPO Dental Plan'
        --,drvStartDate = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') 
        --                     THEN CONVERT(VARCHAR,DATEADD(day, 1,DbnBenStopDate) ,101)
        --                     ELSE CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
        --                END
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode = 'DEN'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION

         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_3'
        ,drvSubSort = '6'
        --,drvRecordType = '[QBPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        --,drvQBSSN =  CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN conSSN
                     --     ELSE eepSSN
                     --END
        ,drvPlanName = 'Aetna Vision Plan'
        --,drvStartDate = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') 
        --                     THEN CONVERT(VARCHAR,DATEADD(day, 1,DbnBenStopDate) ,101)
        --                     ELSE CONVERT(VARCHAR, DATEADD(day, 1, bdmBenStopDate), 101)
        --                END
        ,drvCoverageLevel = CASE bdmBenOption WHEN 'EE' THEN 'EE'
                                              WHEN 'EEC' THEN 'EE+CHILDREN'
                                              WHEN 'EEF' THEN 'EE+FAMILY'
                                              WHEN 'EES' THEN 'EE+SPOUSE'
                            END
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode = 'VIS'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION

         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_3'
        ,drvSubSort = '7'
        --,drvRecordType = '[QBPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ----,drvQBSSN =  CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN conSSN
        --                  ELSE eepSSN
        --             END
        ,drvPlanName = CASE WHEN MONTH(GETDATE()) >= 11 THEN CONCAT(DATEPART(Year, GETDATE()) , '-' ,  RIGHT(DATEPART(Year, GETDATE()) + 1, 2)) 
                            ELSE  CONCAT(DATEPART(Year, GETDATE()) - 1 , '-' ,  RIGHT(DATEPART(Year, GETDATE()), 2)) 
                       END 
                       + ' Higginbotham Health FSA'
        --,drvStartDate = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') 
        --                     THEN CONVERT(VARCHAR,DATEADD(day, 1,DbnBenStopDate) ,101)
        --                     ELSE CONVERT(VARCHAR, DATEADD(day, 1, DbnBenStopDate), 101)
        --                END
        ,drvCoverageLevel = 'EE'
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    --    AND BdmDedCode = 'FSA'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        --AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND edhDedCode = 'FSA'
        --AND EdhDedCode= bdmDedCode
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnSystemID = ConSystemID
        --AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID
    WHERE EdhBenStopDate BETWEEN @StartDate AND @EndDate

;  

    ---------------------------------
    -- DETAIL RECORD - U_EAHIGGCOQB_QBDependents_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_QBDependents_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_QBDependents_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_4'
        ,drvSubSort = '2_' + ConsystemID + '_1'
        --,drvRecordType = '[QBDEPENDENT]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below

        ,drvDependentNumber = CAST(dRank AS Varchar(2))
        --,drvQBSSN = q.drvQBSSN
        ,drvDependentSSN = ConSSN
        ,drvRelationship = CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship IN ('DP','LP') THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL','COD','DCH','DPC','STC') THEN 'CHILD'
                            END
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvAddressSameAsQB = CASE WHEN ConAddressIsDifferent = 'Y' THEN 'FALSE' ELSE 'TRUE' END
        ,drvAddress1 = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine1 ELSE '' END
        ,drvAddress2 = ''
        ,drvAddressCity = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCity ELSE '' END
        ,drvStateOrProvince = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressState ELSE '' END
        ,drvPostalCode = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressZipCode ELSE '' END
        ,drvCountry = ''
        ,drvSex = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDOB = CONVERT(VARCHAR, ConDateOfBirth, 101)
        ,drvIsQMCSO = 'FALSE'
        --,drvPlanName = ''
        ,drvStartDate = CONVERT(VARCHAR, DATEADD(Day, 1, BenStartDate), 101)
        ,drvUsesFDOC = 'TRUE'
        ,drvRank = dRank
    INTO dbo.U_EAHIGGCOQB_QBDependents_drvTbl
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (SELECT bdmEEID, bdmDepRecID, MAX(bdmBenStartDate) AS BenStartDate
        FROM dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        WHERE bdmDepRecID IS NOT NULL
        GROUP BY bdmEEID, bdmDepRecID) AS BDM_Flattened
        ON bdmEEID = xEEID
    JOIN dbo.Contacts ON ConSystemID = bdmDepRecID
        AND ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EAHIGGCOQB_Dependents AS d WITH (NOLOCK)
         ON dSystemID = ConsystemID
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl AS q WITH (NOLOCK)
        ON drvEEID = xEEID

    --JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
    --    ON BdmEEID = dEEID
    --    AND BdmDepRecID = dSystemID
    --ORDER BY xEEID, dRank

    ;

    ---------------------------------
    -- DETAIL RECORD - U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl;
        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_4'
        ,drvSubSort = '2_' + ConsystemID + '_2'
        --,drvRecordType = '[QBDEPENDENTPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvPlanName = CASE WHEN edhChangeReason IN ('DEP', 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN
                                CASE WHEN BdmDedCode = 'MDPOS' THEN 'Aetna CPOSII Medical Plan'
                                     WHEN BdmDedCode = 'MDBP' THEN  'Aetna Texas Health EPO Medical Plan'
                                END
                            ELSE CASE WHEN BdmDedCode = 'MDPOS' THEN 'Aetna CPOSII Medical Plan'
                                      WHEN BdmDedCode = 'MDBP' THEN 'Aetna Texas Health EPO Medical Plan'
                                 END
                      END
    INTO dbo.U_EAHIGGCOQB_QBDependentPlanInitial_drvTbl
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('MDPOS','MDBP')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    --LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
    --    ON DbnSystemID = ConSystemID
    --    AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION
    
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_4'
        ,drvSubSort = '2_' + ConsystemID + '_3'
        --,drvRecordType = '[QBDEPENDENTPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'Aetna Employee Assistance Plan'
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('MDPOS','MDBP')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    --LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
    --    ON DbnSystemID = ConSystemID
    --    AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

        UNION

        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_4'
        ,drvSubSort = '2_' + ConsystemID + '_4'
        --,drvRecordType = '[QBDEPENDENTPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'Higginbotham HRA - must elect medical'
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('MDPOS','MDBP')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    --LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
    --    ON DbnSystemID = ConSystemID
    --    AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION 

         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_4'
        ,drvSubSort = '2_' + ConsystemID + '_5'
        --,drvRecordType = '[QBDEPENDENTPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'Aetna PPO Dental Plan'
     FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode = 'DEN'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    --LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
    --    ON DbnSystemID = ConSystemID
    --    AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID

    UNION

         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_4'
        ,drvSubSort = '2_' + ConsystemID + '_6'
        --,drvRecordType = '[QBDEPENDENTPLANINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = 'Aetna Vision Plan'
     FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode = 'VIS'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode= bdmDedCode
    --LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
    --    ON DbnSystemID = ConSystemID
    --    AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID
;
 

    ---------------------------------
    -- DETAIL RECORD - U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl;
         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSort =  '2_' + xEEID + '_5'
        ,drvSubSort = 1
        --,drvRecordType = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN MONTH(GETDATE()) >= 11 THEN CONCAT(DATEPART(Year, GETDATE()) , '-' ,  RIGHT(DATEPART(Year, GETDATE()) + 1, 2)) 
                            ELSE  CONCAT(DATEPART(Year, GETDATE()) - 1 , '-' ,  RIGHT(DATEPART(Year, GETDATE()), 2)) 
                       END 
                       + ' Higginbotham Health FSA'
        ,drvRate = EdhEEAmt * 24 / 12
    INTO dbo.U_EAHIGGCOQB_QBPLANMEMBERSPECIFICRATEINITIAL_drvTbl
    FROM dbo.U_EAHIGGCOQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EAHIGGCOQB WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    --    AND BdmDedCode = 'FSA'
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    --    ON conEEID = xEEID
        --AND ConSystemID = BdmSystemID
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND edhDedCode = 'FSA'
        --AND EdhDedCode= bdmDedCode
    --LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
    --    ON DbnSystemID = ConSystemID
        --AND DbnDedCode = BdmDedCode
    JOIN dbo.U_EAHIGGCOQB_QB_drvTbl WITH (NOLOCK)
        ON drvEEID = xEEID
    WHERE EdhBenStopDate BETWEEN @StartDate AND @EndDate

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEAHIGGCOQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAHIGGCOQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAHIGGCOQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107011'
       ,expStartPerControl     = '202107011'
       ,expLastEndPerControl   = '202208099'
       ,expEndPerControl       = '202208099'
WHERE expFormatCode = 'EAHIGGCOQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAHIGGCOQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAHIGGCOQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAHIGGCOQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAHIGGCOQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAHIGGCOQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAHIGGCOQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAHIGGCOQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAHIGGCOQB', 'UseFileName', 'V', 'Y'


-- End ripout