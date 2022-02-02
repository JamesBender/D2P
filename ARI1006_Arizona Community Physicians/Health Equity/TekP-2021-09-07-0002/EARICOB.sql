/**********************************************************************************

EARICOB: Wageworks Cobra

FormatCode:     EARICOB
Project:        Wageworks Cobra
Client ID:      ARI1006
Date/time:      2022-02-02 18:02:46.567
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP2DB03
Database:       ULTIPRO_WPARIC
Web Filename:   ARI1006_CL2YX_EEHISTORY_EARICOB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EARICOB_SavePath') IS NOT NULL DROP TABLE dbo.U_EARICOB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EARICOB'


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
WHERE FormatCode = 'EARICOB'
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
WHERE ExpFormatCode = 'EARICOB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EARICOB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EARICOB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EARICOB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EARICOB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EARICOB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EARICOB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EARICOB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EARICOB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EARICOB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EARICOB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEARICOB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEARICOB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EARICOB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARICOB];
GO
IF OBJECT_ID('U_EARICOB_PlanRate3') IS NOT NULL DROP TABLE [dbo].[U_EARICOB_PlanRate3];
GO
IF OBJECT_ID('U_EARICOB_File') IS NOT NULL DROP TABLE [dbo].[U_EARICOB_File];
GO
IF OBJECT_ID('U_EARICOB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EARICOB_EEList];
GO
IF OBJECT_ID('U_EARICOB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EARICOB_drvTbl];
GO
IF OBJECT_ID('U_EARICOB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EARICOB_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EARICOB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EARICOB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EARICOB','Wageworks Cobra','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EARICOB000Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARICOB000Z0','50','H','01','1',NULL,'EMPLOYER_EIN',NULL,NULL,'"EMPLOYER_EIN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARICOB000Z0','50','H','01','2',NULL,'ACTION_CODE',NULL,NULL,'"ACTION_CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARICOB000Z0','50','H','01','3',NULL,'LAST_NAME',NULL,NULL,'"LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARICOB000Z0','50','H','01','4',NULL,'FIRST_NAME',NULL,NULL,'"FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARICOB000Z0','50','H','01','5',NULL,'MIDDLE_INITIAL',NULL,NULL,'"MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARICOB000Z0','50','H','01','6',NULL,'EMPLOYEE_SSN',NULL,NULL,'"EMPLOYEE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARICOB000Z0','50','H','01','7',NULL,'DEPENDENT_SSN',NULL,NULL,'"DEPENDENT_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARICOB000Z0','50','H','01','8',NULL,'EMPLOYEE_NUMBER',NULL,NULL,'"EMPLOYEE_NUMBER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARICOB000Z0','50','H','01','9',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARICOB000Z0','50','H','01','10',NULL,'EMPLOYEE_CLASS',NULL,NULL,'"EMPLOYEE_CLASS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARICOB000Z0','50','H','01','11',NULL,'RELATIONSHIP',NULL,NULL,'"RELATIONSHIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARICOB000Z0','50','H','01','12',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARICOB000Z0','50','H','01','13',NULL,'HIRE_DATE',NULL,NULL,'"HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARICOB000Z0','50','H','01','14',NULL,'BIRTH_DATE',NULL,NULL,'"BIRTH_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARICOB000Z0','50','H','01','15',NULL,'ADDRESS_1',NULL,NULL,'"ADDRESS_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARICOB000Z0','50','H','01','16',NULL,'ADDRESS_2',NULL,NULL,'"ADDRESS_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARICOB000Z0','50','H','01','17',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARICOB000Z0','50','H','01','18',NULL,'STATE',NULL,NULL,'"STATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARICOB000Z0','50','H','01','19',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARICOB000Z0','50','H','01','20',NULL,'COUNTRY',NULL,NULL,'"COUNTRY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARICOB000Z0','50','H','01','21',NULL,'FILLER_1',NULL,NULL,'"FILLER_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EARICOB000Z0','50','H','01','22',NULL,'COBRA_ELIGIBLE',NULL,NULL,'"COBRA_ELIGIBLE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EARICOB000Z0','50','H','01','23',NULL,'PREFERRED_LANGUAGE',NULL,NULL,'"PREFERRED_LANGUAGE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EARICOB000Z0','50','H','01','24',NULL,'PHONE_NUMBER',NULL,NULL,'"PHONE_NUMBER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EARICOB000Z0','50','H','01','25',NULL,'E_MAIL_ADDRESS',NULL,NULL,'"E_MAIL_ADDRESS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EARICOB000Z0','50','H','01','26',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL,'"INITIAL_NOTIFICATION_COBRA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EARICOB000Z0','50','H','01','27',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL,'"INITIAL_NOTIFICATION_HIPAA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EARICOB000Z0','50','H','01','28',NULL,'WAITING_START_DATE',NULL,NULL,'"WAITING_START_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EARICOB000Z0','50','H','01','29',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL,'"COVERAGE_BEGIN_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EARICOB000Z0','50','H','01','30',NULL,'FILLER_2',NULL,NULL,'"FILLER_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EARICOB000Z0','50','H','01','31',NULL,'QUALIFYING EVENT_DATE',NULL,NULL,'"QUALIFYING EVENT_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EARICOB000Z0','50','H','01','32',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL,'"LAST_PRECOBRA_COVERED"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EARICOB000Z0','50','H','01','33',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL,'"QUALIFYING_EVENT_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EARICOB000Z0','50','H','01','34',NULL,'ELIGIBILITY_END_DATE',NULL,NULL,'"ELIGIBILITY_END_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EARICOB000Z0','50','H','01','35',NULL,'SEVERANCE_THROUGH',NULL,NULL,'"SEVERANCE_THROUGH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EARICOB000Z0','50','H','01','36',NULL,'SEVERANCE_PERCENT',NULL,NULL,'"SEVERANCE_PERCENT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EARICOB000Z0','50','H','01','37',NULL,'SEVERANCE_MONTHLY',NULL,NULL,'"SEVERANCE_MONTHLY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EARICOB000Z0','50','H','01','38',NULL,'SEVERANCE_CREDIT',NULL,NULL,'"SEVERANCE_CREDIT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EARICOB000Z0','50','H','01','39',NULL,'BILLING_START_DATE',NULL,NULL,'"BILLING_START_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EARICOB000Z0','50','H','01','40',NULL,'ELECTION_NOTE_MAILED',NULL,NULL,'"ELECTION_NOTE_MAILED"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EARICOB000Z0','50','H','01','41',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL,'"HIPAA_CERTIFICATE_MAILED"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EARICOB000Z0','50','H','01','42',NULL,'ELECTION_DATE',NULL,NULL,'"ELECTION_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EARICOB000Z0','50','H','01','43',NULL,'FILLER_3',NULL,NULL,'"FILLER_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EARICOB000Z0','50','H','01','44',NULL,'PLAN_NAME1',NULL,NULL,'"PLAN_NAME1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EARICOB000Z0','50','H','01','45',NULL,'PLAN_COV_CODE1',NULL,NULL,'"PLAN_COV_CODE1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EARICOB000Z0','50','H','01','46',NULL,'PLAN_COV_START1',NULL,NULL,'"PLAN_COV_START1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EARICOB000Z0','50','H','01','47',NULL,'PLAN_COV_END1',NULL,NULL,'"PLAN_COV_END1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EARICOB000Z0','50','H','01','48',NULL,'PLAN_RATE1',NULL,NULL,'"PLAN_RATE1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EARICOB000Z0','50','H','01','49',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EARICOB000Z0','50','H','01','50',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL,'"CARRIER_EMPLOYEE_ID1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EARICOB000Z0','50','H','01','51',NULL,'PLAN_FILLER1',NULL,NULL,'"PLAN_FILLER1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EARICOB000Z0','50','H','01','52',NULL,'PLAN_NAME2',NULL,NULL,'"PLAN_NAME2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EARICOB000Z0','50','H','01','53',NULL,'PLAN_COV_CODE2',NULL,NULL,'"PLAN_COV_CODE2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EARICOB000Z0','50','H','01','54',NULL,'PLAN_COV_START2',NULL,NULL,'"PLAN_COV_START2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EARICOB000Z0','50','H','01','55',NULL,'PLAN_COV_END2',NULL,NULL,'"PLAN_COV_END2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EARICOB000Z0','50','H','01','56',NULL,'PLAN_RATE2',NULL,NULL,'"PLAN_RATE2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EARICOB000Z0','50','H','01','57',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EARICOB000Z0','50','H','01','58',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL,'"CARRIER_EMPLOYEE_ID2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EARICOB000Z0','50','H','01','59',NULL,'PLAN_FILLER2',NULL,NULL,'"PLAN_FILLER2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EARICOB000Z0','50','H','01','60',NULL,'PLAN_NAME3',NULL,NULL,'"PLAN_NAME3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EARICOB000Z0','50','H','01','61',NULL,'PLAN_COV_CODE3',NULL,NULL,'"PLAN_COV_CODE3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EARICOB000Z0','50','H','01','62',NULL,'PLAN_COV_START3',NULL,NULL,'"PLAN_COV_START3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EARICOB000Z0','50','H','01','63',NULL,'PLAN_COV_END3',NULL,NULL,'"PLAN_COV_END3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EARICOB000Z0','50','H','01','64',NULL,'PLAN_RATE3',NULL,NULL,'"PLAN_RATE3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EARICOB000Z0','50','H','01','65',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EARICOB000Z0','50','H','01','66',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL,'"CARRIER_EMPLOYEE_ID3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EARICOB000Z0','50','H','01','67',NULL,'PLAN_FILLER3',NULL,NULL,'"PLAN_FILLER3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EARICOB000Z0','50','H','01','68',NULL,'PLAN_NAME4',NULL,NULL,'"PLAN_NAME4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EARICOB000Z0','50','H','01','69',NULL,'PLAN_COV_CODE4',NULL,NULL,'"PLAN_COV_CODE4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EARICOB000Z0','50','H','01','70',NULL,'PLAN_COV_START4',NULL,NULL,'"PLAN_COV_START4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EARICOB000Z0','50','H','01','71',NULL,'PLAN_COV_END4',NULL,NULL,'"PLAN_COV_END4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EARICOB000Z0','50','H','01','72',NULL,'PLAN_RATE4',NULL,NULL,'"PLAN_RATE4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EARICOB000Z0','50','H','01','73',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EARICOB000Z0','50','H','01','74',NULL,'CARRIER_EMPLOYEE_ID4',NULL,NULL,'"CARRIER_EMPLOYEE_ID4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EARICOB000Z0','50','H','01','75',NULL,'PLAN_FILLER4',NULL,NULL,'"PLAN_FILLER4"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARICOB000Z0','50','D','10','1',NULL,'EMPLOYER_EIN',NULL,NULL,'"86-0767800"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARICOB000Z0','50','D','10','2',NULL,'ACTION_CODE',NULL,NULL,'"drvActionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARICOB000Z0','50','D','10','3',NULL,'LAST_NAME',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARICOB000Z0','50','D','10','4',NULL,'FIRST_NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARICOB000Z0','50','D','10','5',NULL,'MIDDLE_INITIAL',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARICOB000Z0','50','D','10','6',NULL,'EMPLOYEE_SSN',NULL,NULL,'"drvEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARICOB000Z0','50','D','10','7',NULL,'DEPENDENT_SSN',NULL,NULL,'"drvDepSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARICOB000Z0','50','D','10','8',NULL,'EMPLOYEE_NUMBER',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARICOB000Z0','50','D','10','9',NULL,'DIVISION',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARICOB000Z0','50','D','10','10',NULL,'EMPLOYEE_CLASS',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARICOB000Z0','50','D','10','11',NULL,'RELATIONSHIP',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARICOB000Z0','50','D','10','12',NULL,'GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARICOB000Z0','50','D','10','13',NULL,'HIRE_DATE',NULL,NULL,'"drvHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARICOB000Z0','50','D','10','14',NULL,'BIRTH_DATE',NULL,NULL,'"drvBirthDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARICOB000Z0','50','D','10','15',NULL,'ADDRESS_1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARICOB000Z0','50','D','10','16',NULL,'ADDRESS_2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARICOB000Z0','50','D','10','17',NULL,'CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARICOB000Z0','50','D','10','18',NULL,'STATE',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARICOB000Z0','50','D','10','19',NULL,'ZIP',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARICOB000Z0','50','D','10','20',NULL,'COUNTRY',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARICOB000Z0','50','D','10','21',NULL,'FILLER_1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EARICOB000Z0','50','D','10','22',NULL,'COBRA_ELIGIBLE',NULL,NULL,'"drvCobraEligible"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EARICOB000Z0','50','D','10','23',NULL,'PREFERRED_LANGUAGE',NULL,NULL,'"EN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EARICOB000Z0','50','D','10','24',NULL,'PHONE_NUMBER',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EARICOB000Z0','50','D','10','25',NULL,'E_MAIL_ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EARICOB000Z0','50','D','10','26',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL,'"drvInitialNotificationCobra"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EARICOB000Z0','50','D','10','27',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EARICOB000Z0','50','D','10','28',NULL,'WAITING_START_DATE',NULL,NULL,'"drvWaitingStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EARICOB000Z0','50','D','10','29',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL,'"drvCoverageBeginDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EARICOB000Z0','50','D','10','30',NULL,'FILLER_2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EARICOB000Z0','50','D','10','31',NULL,'QUALIFYING EVENT_DATE',NULL,NULL,'"drvQuallifingEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EARICOB000Z0','50','D','10','32',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL,'"drvLastPreCobraCovered"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EARICOB000Z0','50','D','10','33',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL,'"drvQuallifingEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EARICOB000Z0','50','D','10','34',NULL,'ELIGIBILITY_END_DATE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EARICOB000Z0','50','D','10','35',NULL,'SEVERANCE_THROUGH',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EARICOB000Z0','50','D','10','36',NULL,'SEVERANCE_PERCENT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EARICOB000Z0','50','D','10','37',NULL,'SEVERANCE_MONTHLY',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EARICOB000Z0','50','D','10','38',NULL,'SEVERANCE_CREDIT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EARICOB000Z0','50','D','10','39',NULL,'BILLING_START_DATE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EARICOB000Z0','50','D','10','40',NULL,'ELECTION_NOTE_MAILED',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EARICOB000Z0','50','D','10','41',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EARICOB000Z0','50','D','10','42',NULL,'ELECTION_DATE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EARICOB000Z0','50','D','10','43',NULL,'FILLER_3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EARICOB000Z0','50','D','10','44',NULL,'PLAN_NAME1',NULL,NULL,'"drvPlanName1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EARICOB000Z0','50','D','10','45',NULL,'PLAN_COV_CODE1',NULL,NULL,'"drvPlanCovCode1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EARICOB000Z0','50','D','10','46',NULL,'PLAN_COV_START1',NULL,NULL,'"drvPlanCovStart1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EARICOB000Z0','50','D','10','47',NULL,'PLAN_COV_END1',NULL,NULL,'" "','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EARICOB000Z0','50','D','10','48',NULL,'PLAN_RATE1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EARICOB000Z0','50','D','10','49',NULL,'FILLER',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EARICOB000Z0','50','D','10','50',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EARICOB000Z0','50','D','10','51',NULL,'PLAN_FILLER1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EARICOB000Z0','50','D','10','52',NULL,'PLAN_NAME2',NULL,NULL,'"drvPlanName2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EARICOB000Z0','50','D','10','53',NULL,'PLAN_COV_CODE2',NULL,NULL,'"drvPlanCovCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EARICOB000Z0','50','D','10','54',NULL,'PLAN_COV_START2',NULL,NULL,'"drvPlanCovStart2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EARICOB000Z0','50','D','10','55',NULL,'PLAN_COV_END2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EARICOB000Z0','50','D','10','56',NULL,'PLAN_RATE2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EARICOB000Z0','50','D','10','57',NULL,'FILLER',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EARICOB000Z0','50','D','10','58',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EARICOB000Z0','50','D','10','59',NULL,'PLAN_FILLER2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EARICOB000Z0','50','D','10','60',NULL,'PLAN_NAME3',NULL,NULL,'"drvPlanName3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EARICOB000Z0','50','D','10','61',NULL,'PLAN_COV_CODE3',NULL,NULL,'"drvPlanCovCode3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EARICOB000Z0','50','D','10','62',NULL,'PLAN_COV_START3',NULL,NULL,'"drvPlanCovStart3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EARICOB000Z0','50','D','10','63',NULL,'PLAN_COV_END3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EARICOB000Z0','50','D','10','64',NULL,'PLAN_RATE3',NULL,NULL,'"drvPlanRate3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EARICOB000Z0','50','D','10','65',NULL,'FILLER',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EARICOB000Z0','50','D','10','66',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EARICOB000Z0','50','D','10','67',NULL,'PLAN_FILLER3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EARICOB000Z0','50','D','10','68',NULL,'PLAN_NAME4',NULL,NULL,'"drvPlanName4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EARICOB000Z0','50','D','10','69',NULL,'PLAN_COV_CODE4',NULL,NULL,'"drvPlanCovCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EARICOB000Z0','50','D','10','70',NULL,'PLAN_COV_START4',NULL,NULL,'"drvPlanCoveStart4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EARICOB000Z0','50','D','10','71',NULL,'PLAN_COV_END4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EARICOB000Z0','50','D','10','72',NULL,'PLAN_RATE4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EARICOB000Z0','50','D','10','73',NULL,'FILLER',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EARICOB000Z0','50','D','10','74',NULL,'CARRIER_EMPLOYEE_ID4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EARICOB000Z0','50','D','10','75',NULL,'PLAN_FILLER4',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EARICOB_20220202.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202212069','EMPEXPORT','OEACTIVE',NULL,'EARICOB',NULL,NULL,NULL,'202212069','Dec  6 2021  9:15AM','Dec  6 2021  9:15AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202212069','EMPEXPORT','OEPASSIVE',NULL,'EARICOB',NULL,NULL,NULL,'202212069','Dec  6 2021  9:15AM','Dec  6 2021  9:15AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wageworks Cobra','202212069','EMPEXPORT','ONDEM_XOE',NULL,'EARICOB',NULL,NULL,NULL,'202212069','Dec  6 2021  9:15AM','Dec  6 2021  9:15AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wageworks Cobra-Sched','202212069','EMPEXPORT','SCH_EARICO',NULL,'EARICOB',NULL,NULL,NULL,'202212069','Dec  6 2021  9:15AM','Dec  6 2021  9:15AM','202110011',NULL,'','','202110011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Wageworks Cobra-Test','202212069','EMPEXPORT','TEST_XOE','Jan 24 2022 12:00PM','EARICOB',NULL,NULL,NULL,'202212069','Apr 22 2021 12:00AM','Dec 30 1899 12:00AM','202110011','240','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3cPeARI1006',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARICOB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARICOB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARICOB','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARICOB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARICOB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARICOB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARICOB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARICOB','D10','dbo.U_EARICOB_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EARICOB
-----------

IF OBJECT_ID('U_dsi_BDM_EARICOB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EARICOB] (
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
-- Create table U_EARICOB_DedList
-----------

IF OBJECT_ID('U_EARICOB_DedList') IS NULL
CREATE TABLE [dbo].[U_EARICOB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EARICOB_drvTbl
-----------

IF OBJECT_ID('U_EARICOB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EARICOB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvActionCode] varchar(2) NULL,
    [drvNameLast] varchar(20) NULL,
    [drvNameFirst] varchar(20) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvEmpSSN] varchar(11) NULL,
    [drvDepSSN] varchar(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvRelationship] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvBirthDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCobraEligible] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(12) NULL,
    [drvEmailAddress] varchar(1) NOT NULL,
    [drvInitialNotificationCobra] varchar(1) NOT NULL,
    [drvWaitingStartDate] datetime NULL,
    [drvCoverageBeginDate] datetime NULL,
    [drvQuallifingEventDate] datetime NULL,
    [drvLastPreCobraCovered] datetime NULL,
    [drvQuallifingEventType] varchar(2) NULL,
    [drvPlanName1] varchar(22) NULL,
    [drvPlanCovCode1] varchar(2) NULL,
    [drvPlanCovStart1] char(5) NULL,
    [drvPlanName2] varchar(18) NULL,
    [drvPlanCovCode2] varchar(2) NULL,
    [drvPlanCovStart2] char(5) NULL,
    [drvPlanName3] varchar(19) NULL,
    [drvPlanCovCode3] varchar(2) NULL,
    [drvPlanCovStart3] datetime NULL,
    [drvPlanRate3] nvarchar(4000) NULL,
    [drvPlanName4] varchar(26) NULL,
    [drvPlanCovCode4] varchar(2) NULL,
    [drvPlanCoveStart4] datetime NULL
);

-----------
-- Create table U_EARICOB_EEList
-----------

IF OBJECT_ID('U_EARICOB_EEList') IS NULL
CREATE TABLE [dbo].[U_EARICOB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EARICOB_File
-----------

IF OBJECT_ID('U_EARICOB_File') IS NULL
CREATE TABLE [dbo].[U_EARICOB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EARICOB_PlanRate3
-----------

IF OBJECT_ID('U_EARICOB_PlanRate3') IS NULL
CREATE TABLE [dbo].[U_EARICOB_PlanRate3] (
    [PrEEID] char(12) NOT NULL,
    [PrCoID] char(5) NULL,
    [PlanRate3] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARICOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Arizona Community Physicians

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 12/06/2021
Service Request Number: TekP-2021-09-07-0002 

Purpose: Wageworks Cobra

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EARICOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EARICOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EARICOB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EARICOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EARICOB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARICOB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARICOB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARICOB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARICOB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARICOB', 'SCH_EARICO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EARICOB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EARICOB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EARICOB';

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
    DELETE FROM dbo.U_EARICOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EARICOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CDENH, DENH, DENHD, DENHS, CDENL, DENL, DENLD, DENLS, CEDS, DEDS, DEDSD, DEDSS, CVIS, VIS, VISP, CFSAL, CFSAM, FSA, FSALP, CMHD, MHDEE, MPHY2, CMPPO, MPHY, MPPOE';

    IF OBJECT_ID('U_EARICOB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EARICOB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EARICOB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section - NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','CDENH, DENH, DENHD, DENHS, CDENL, DENL, DENLD, DENLS, CEDS, DEDS, DEDSD, DEDSS, CVIS, VIS, VISP, CFSAL, CFSAM, FSA, FSALP, CMHD, MHDEE, MPHY2, CMPPO, MPHY, MPPOE');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- Include deds where DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- 2 -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeIncludeEmps','Y'); -- Include employees when dependent is eligible

    /*-- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;
    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;*/

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section - QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','CDENH, DENH, DENHD, DENHS, CDENL, DENL, DENLD, DENLS, CEDS, DEDS, DEDSD, DEDSS, CVIS, VIS, VISP, CFSAL, CFSAM, FSA, FSALP, CMHD, MHDEE, MPHY2, CMPPO, MPHY, MPPOE');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, COD, STC');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203, IDE'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.

        -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

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
     --==========================================
    -- Insert into BDM Reason code 201 and 204
    --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EARICOB]
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

    DELETE FROM dbo.U_dsi_BDM_EARICOB WHERE bdmdedcode NOT IN  (SELECT DISTINCT Dedcode FROM dbo.U_EARICOB_DedList)
    
    UPDATE dbo.U_dsi_BDM_EARICOB 
        SET bdmNumSpouses = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EARICOB A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'SPS' AND A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EARICOB A WHERE A.bdmeeid = X.bdmeeid AND bdmRelationship = 'CHL' AND A.bdmcoid = X.bdmcoid)
    FROM dbo.U_dsi_BDM_EARICOB  X
    WHERE BdmDedRowStatus IN ('Data Inserted for 302 Chg reason') --,'Data Inserted for 201 Chg reason')

--==========================================
--  Insert into BDM Reason code 201 and 204
-- ==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EARICOB]
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

INSERT INTO [dbo].[U_dsi_BDM_EARICOB]
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

  INSERT INTO [dbo].[U_dsi_BDM_EARICOB]
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

 Delete from dbo.U_dsi_BDM_EARICOB where bdmdedcode not in (Select dedcode from U_EARICOB_DedList)
 Delete from U_dsi_BDM_EARICOB where bdmrelationship = 'Z'

 Update dbo.U_dsi_BDM_EARICOB set bdmNumSpouses = (select count(*) from U_dsi_BDM_EARICOB A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid),
 bdmNumChildren = (select count(*) from U_dsi_BDM_EARICOB A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
 from dbo.U_dsi_BDM_EARICOB X where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 210 Chg reason')

DELETE FROM dbo.U_dsi_BDM_EARICOB where  BdmRelationship <> 'Emp' and BdmBenStatus = 'T' AND BdmCobraReason not IN ('203','IDE') 
    -----------------------------
    -- Working Table - PlanRate3
    -----------------------------
    IF OBJECT_ID('U_EARICOB_PlanRate3','U') IS NOT NULL
        DROP TABLE dbo.U_EARICOB_PlanRate3;
    SELECT DISTINCT
            PrEEID = BdmEEID
            ,PrCoID = BdmCOID
            ,PlanRate3 = SUM(BdmEEAmt)*52
     INTO dbo.U_EARICOB_PlanRate3
     FROM dbo.U_dsi_BDM_EARICOB 
     WHERE BdmDedCode in ('CFSAL','CFSAM','FSA','FSALP')
     Group by BdmEEID, BdmCOID
    --==========================================
    -- Build Driver Tables --- CDENH, DENH, DENHD, DENHS, CDENL, DENL, DENLD, DENLS, CEDS, DEDS, DEDSD, DEDSS, CVIS, VIS, VISP, CFSAL, CFSAM, FSA, FSALP, CMHD, MHDEE, MPHY2, CMPPO, MPHY, MPPOE
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EARICOB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EARICOB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EARICOB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID  
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvActionCode =    CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus <> 'T' THEN '01'
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' THEN '02'
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' THEN '03'
                                WHEN EecEmplStatus = 'A' AND BdmBenStatus = 'T' THEN '03'
                                WHEN ConRelationship IN ('SPS') AND BdmBenStatus = 'T' AND EdhChangeReason IN ('204','LEVNT4') THEN '06'
                                WHEN ConRelationship IN ('CHL','COD','SPS','STC') AND EecEmplStatus = 'T' AND EecTermReason IN ('203','IDE') THEN '06'
                                WHEN ConRelationship IN ('CHL','COD','STC') AND BdmBenStatus = 'T' AND BdmCobraReason IN ('201','LEVNT3') THEN '06'
                            END 
        -- standard fields above and additional driver fields below
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameLast,20) ELSE LEFT(ConNameLast,20) END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameFirst,20) ELSE LEFT(ConNameFirst,20) END
        ,drvNameMiddle = CASE 
                            WHEN BdmRecType = 'EMP' AND EepNameMiddle is not null THEN LEFT(EepNameMiddle,1) 
                            WHEN BdmRecType = 'DEP' AND ConNameMiddle is not null THEN LEFT(ConNameMiddle,1) 
                            ELSE ''
                            END
        ,drvEmpSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(eepSSN, 5), 2) + '-' + RIGHT(LEFT(eepSSN, 9), 4)
        ,drvDepSSN = CASE WHEN BdmRecType = 'DEP' AND ConSSN IS NOT NULL THEN LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(ConSSN, 5), 2) + '-' + RIGHT(LEFT(ConSSN, 9), 4) ELSE '' END
        ,drvEmpNo = EecEmpNo
        ,drvRelationship = CASE WHEN BdmRecType = 'EMP' THEN 'E'
                                ELSE
                                    CASE WHEN ConRelationship IN ('CHL','COD') THEN 'C'
                                        WHEN ConRelationship IN ('STC') THEN 'Q'
                                        WHEN ConRelationship IN ('SPS') THEN 'S'
                                    END
                            END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN EepGender = 'M' THEN 'M'
                                WHEN EepGender = 'F' THEN 'F'
                                ELSE 'X'
                            END
                        WHEN BdmRecType = 'DEP' THEN
                            CASE WHEN ConGender = 'M' THEN 'M'
                                WHEN ConGender = 'F' THEN 'F'
                                ELSE 'X'
                            END
                        END
        ,drvHireDate = EecDateOfLastHire
        ,drvBirthDate = CASE WHEN BdmRecType = 'EMP'  THEN EepDateOfBirth
                                WHEN BdmRecType = 'DEP' THEN ConDateOfBirth
                                ELSE '12/31/1900'
                            END
        ,drvAddressLine1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                WHEN BdmRecType = 'DEP' THEN ConAddressLine1
                            END 
        ,drvAddressLine2 = REPLACE(ISNULL(CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                WHEN BdmRecType = 'DEP'  THEN ConAddressLine2
                            END, ''), '  ', '') 
        ,drvAddressCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                WHEN BdmRecType = 'DEP' THEN ConAddressCity
                            END
        ,drvAddressState = CASE WHEN BdmRecType = 'EMP'  THEN EepAddressState
                                WHEN BdmRecType = 'DEP' THEN ConAddressState
                            END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                    WHEN BdmRecType = 'DEP' THEN ConAddressZipCode
                                END
        ,drvCobraEligible = CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' THEN 'Y' ELSE '' END
        ,drvPhoneNumber = CASE WHEN BdmRecType = 'EMP' AND  EepPhoneHomeNumber <> '' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
                                WHEN BdmRecType = 'DEP' AND ConPhoneHomeNumber <> '' THEN LEFT(ConPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(ConPhoneHomeNumber, 6), 3) + '-' + RIGHT(ConPhoneHomeNumber, 4)
                                ELSE ''
                            END
        ,drvEmailAddress = ''
        ,drvInitialNotificationCobra = CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' THEN 'C' ELSE '' END
        ,drvWaitingStartDate = EecDateOfLastHire
        ,drvCoverageBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/2022')
        ,drvQuallifingEventDate =    CASE WHEN BdmRunId = 'QB' THEN
                                        CASE WHEN ConRelationship IN ('SPS') AND BdmBenStatus = 'T' AND BdmCobraReason IN ('204','LEVNT4') THEN ConCobraStatusDate
                                        WHEN ConRelationship IN ('CHL','COD','SPS','STC') AND EecEmplStatus = 'T' AND EecTermReason IN ('203','IDE') THEN EecDateOfTermination
                                        WHEN ConRelationship IN ('CHL','COD','STC') AND BdmBenStatus = 'T' AND BdmCobraReason IN ('201','LEVNT3') THEN ConCobraStatusDate
                                        WHEN ConRelationship IN ('CHL','COD','SPS','STC') AND BdmBenStatus = 'T' AND EecEmplStatus = 'A' THEN  ConCobraStatusDate
                                        WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN EecEmplStatus = 'A' THEN EdhEffDate
                                        ELSE EepDateOFCobraEvent
                                        END
                                    END
        ,drvLastPreCobraCovered = CASE WHEN ConRelationship IN ('SPS') AND BdmBenStatus = 'T' AND BdmCobraReason in ('204','LEVNT4')THEN BdmBenStopDate
                                        WHEN ConRelationship IN ('CHL','COD','STC','SPS') AND EecEmplStatus ='T' AND BdmCobraReason in ('203','IDE') THEN BdmBenStopDate
                                        WHEN ConRelationship IN ('CHL','COD','STC') AND BdmBenStatus = 'T' AND BdmCobraReason in ('201','LEVNT3')THEN BdmBenStopDate
                                        WHEN ConRelationship IN ('CHL','COD','SPS','STC') AND BdmBenStatus = 'T' AND EecEmplStatus = 'A' THEN BdmBenStopDate
                                        WHEN EecEmplStatus = 'T' AND BdmBenStatus = 'T' THEN BdmBenStopDate
                                        WHEN EecEmplStatus = 'A' AND BdmBenStatus = 'T' THEN BdmBenStopDate
                                    END
                                --WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' THEN '03'
                          --      WHEN EecEmplStatus = 'A' AND BdmBenStatus = 'T' THEN '03'
        ,drvQuallifingEventType = CASE WHEN ConRelationship IN ('SPS') AND BdmBenStatus = 'T' AND BdmCobraReason IN ('204', 'LEVNT4') THEN '11'
                                        WHEN ConRelationship IN ('CHL','COD','SPS','STC') AND EecEmplStatus = 'T' and EecTermReason in ( '203','IDE') THEN '14'
                                        WHEN ConRelationship IN ('CHL','COD','STC') and BdmBenStatus = 'T' and BdmCobraReason IN ('201','LEVNT3') THEN '12'
                                        WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('202','203','IDE','VRE','COVID','IEP') THEN '03'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason in ('COVID','IEP') THEN '05'
                                        WHEN (BdmChangeReason = '208') OR ( EecEmplStatus = 'T'AND EecTermReason in ('202','VRE') ) THEN '01'
                                        WHEN EecEmplStatus = 'A' and BdmCobraReason IN ('203','202') THEN '04'                                        
                                    END
        ,drvPlanName1 = CASE    WHEN DedCode_DHIGH IS NOT NULL THEN 'Delta Dental High Plan'                             
                                WHEN DedCode_DLOW IS NOT NULL THEN 'Delta Dental Low Plan'                             
                                WHEN DedCode_DEDS IS NOT NULL THEN 'EDS Dental Plan' 
                            END
        ,drvPlanCovCode1 = CASE WHEN DedCode_D1 IS NOT NULL THEN CASE BenOption_D1
                                WHEN 'EE' THEN '01'
                                WHEN 'EEF' THEN '04'
                                WHEN 'EE1' THEN '39'
                            END END
        ,drvPlanCovStart1 = DedCode_D1
                            --CASE 
       --                         WHEN DedCode_D1 IS NOT NULL AND BenStartDate_D1> '2022-01-01' THEN BenStartDate_D1
       --                         WHEN DedCode_D1 IS NOT NULL AND BenStartDate_D1 <= '2022-01-01' THEN '01/01/2022'
       --                         END
        ,drvPlanName2 = CASE WHEN DedCode_VIS1 IS NOT NULL THEN 'EyeMed Vision Plan' END
        ,drvPlanCovCode2 = CASE WHEN DedCode_VIS1  IS NOT NULL THEN CASE BenOption_VIS1
                                WHEN 'EE' THEN '01'
                                WHEN 'EEF' THEN '04'
                                WHEN 'EE1' THEN '39'
                            END END
        ,drvPlanCovStart2 = DedCode_VIS1
        ,drvPlanName3 = CASE WHEN DedCode_FSA1 IS NOT NULL THEN 'HealthCare FSA 2022' END
        ,drvPlanCovCode3 = CASE WHEN DedCode_FSA1 IS NOT NULL /*and BenOption_FSA1 IS NOT NULL*/ then '98'  END
        ,drvPlanCovStart3 = BenStartDate_FSA1
                            --CASE 
       --                         WHEN BenStartDate_FSA1 > '2022-01-01' THEN BenStartDate_FSA1
       --                         WHEN BenStartDate_FSA1 <= '2022-01-01' THEN '01/01/2022' 
       --                         END
        ,drvPlanRate3 = FORMAT(CASE WHEN PlanRate3 <> '' OR PlanRate3 <> 0 THEN  PlanRate3/12 END, '#0.00')
        ,drvPlanName4 = CASE 
                            WHEN DedCode_MED1 IS NOT NULL THEN 'UMR HDHP 2800 Medical Plan'
                            WHEN DedCode_MED2 IS NOT NULL THEN 'UMR PPO 4500 Medical Plan'
                        END
        ,drvPlanCovCode4 = CASE WHEN DedCode_MED IS NOT NULL THEN 
                            CASE BenOption_MED
                                WHEN 'EE' THEN '01'
                                WHEN 'EEF' THEN '04'
                                WHEN 'EES' THEN '06'
                                WHEN 'EEC' THEN '59'
                            END 
                            END
        ,drvPlanCoveStart4 = BenStartDate_MED
                            --CASE 
       --                         WHEN BenStartDate_MED > '2022-01-01' THEN BenStartDate_MED
       --                         WHEN BenStartDate_MED <= '2022-01-01' THEN  '01/01/2022'
       --                         END
    INTO dbo.U_EARICOB_drvTbl
    FROM dbo.U_EARICOB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
                ,MAX(BdmBenStartDate) AS BdmBenStartDate
                ,MAX(BdmBenStopDate) AS BdmBenStopDate
                ,MAX(BdmBenStatusDate) AS BdmBenStatusDate
                ,MAX(BdmCobraReason) AS BdmCobraReason
                ,MAX(BdmChangeReason) AS BdmChangeReason
                ,MAX(BdmIsPQB) AS BdmIsPQB
                ,MAX(CASE WHEN BdmDedCode in ('CDENH', 'DENH', 'DENHD', 'DENHS') THEN BdmDedCode END) AS DedCode_DHIGH    
                ,MAX(CASE WHEN BdmDedCode in ('CDENL', 'DENL', 'DENLD', 'DENLS') THEN BdmDedCode END) AS DedCode_DLOW  
                ,MAX(CASE WHEN BdmDedCode in ('CEDS', 'DEDS', 'DEDSD', 'DEDSS')  THEN BdmDedCode END) AS DedCode_DEDS  
                ,MAX(CASE WHEN BdmDedCode in ('CDENH', 'DENH', 'DENHD', 'DENHS', 'CDENL', 'DENL', 'DENLD', 'DENLS', 'CEDS', 'DEDS', 'DEDSD', 'DEDSS') THEN BdmBenOption END) AS BenOption_D1
                ,MAX(CASE WHEN BdmDedCode in ('CDENH', 'DENH', 'DENHD', 'DENHS', 'CDENL', 'DENL', 'DENLD', 'DENLS', 'CEDS', 'DEDS', 'DEDSD', 'DEDSS') THEN BdmDedCode END) AS DedCode_D1
                ,MAX(CASE WHEN BdmDedCode IN ('CDENH', 'DENH', 'DENHD', 'DENHS', 'CDENL', 'DENL', 'DENLD', 'DENLS', 'CEDS', 'DEDS', 'DEDSD', 'DEDSS') THEN BdmBenStartDate END) AS BenStartDate_D1
                ,MAX(CASE WHEN BdmDedCode in ('CVIS','VIS','VISP')  THEN BdmDedCode END) AS DedCode_VIS1
                ,MAX(CASE WHEN BdmDedCode in ('CVIS','VIS','VISP')  THEN BdmBenOption END) AS BenOption_VIS1
                ,MAX(CASE WHEN BdmDedCode IN ('CVIS','VIS','VISP')  THEN BdmBenStartDate END) AS BenStartDate_VIS1
                ,MAX(CASE WHEN BdmDedCode in ('CFSAL', 'CFSAM', 'FSA', 'FSALP')THEN BdmDedCode END) AS DedCode_FSA1
                ,MAX(CASE WHEN BdmDedCode in ('CFSAL', 'CFSAM', 'FSA', 'FSALP')THEN BdmBenOption END) AS BenOption_FSA1
                ,MAX(CASE WHEN BdmDedCode IN ('CFSAL','CFSAM','FSA','FSALP')  THEN BdmBenStartDate END) AS BenStartDate_FSA1
                ,MAX(CASE WHEN BdmDedCode in('CMHD', 'MHDEE', 'MPHY2') THEN BdmDedCode END) AS DedCode_MED1
                ,MAX(CASE WHEN BdmDedCode in('CMPPO', 'MPHY', 'MPPOE') THEN BdmDedCode END) AS DedCode_MED2
                ,MAX(CASE WHEN BdmDedCode IN ('CMHD', 'MHDEE', 'MPHY2', 'CMPPO', 'MPHY', 'MPPOE')  THEN BdmDedCode END) AS DedCode_MED
                ,MAX(CASE WHEN BdmDedCode IN ('CMHD', 'MHDEE', 'MPHY2', 'CMPPO', 'MPHY', 'MPPOE')  THEN BdmBenStartDate END) AS BenStartDate_MED
                ,MAX(CASE WHEN BdmDedCode in ('CMHD', 'MHDEE', 'MPHY2', 'CMPPO', 'MPHY', 'MPPOE') THEN BdmBenOption END) AS BenOption_MED
            FROM dbo.U_dsi_BDM_EARICOB WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EARICOB_PlanRate3 WITH (NOLOCK)
        ON PrEEID = xEEID 
        AND PrCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID        
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('CDENH','DENH','DENHD','DENHS','CDENL','DENL','DENLD','DENLS','CEDS','DEDS','DEDSD','DEDSS','CVIS','VIS','VISP','CFSAL','CFSAM','FSA','FSALP','CMHD','MHDEE','MPHY2','CMPPO','MPHY','MPPOE') 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200') AND EdhEffDate BETWEEN @StartDate AND @EndDate
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    WHERE (BdmRunID = 'QB') OR (BdmRunID = 'NPM' AND EecDateOfLastHire BETWEEN @StartDate AND @EndDate)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_PSF_60341_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_FND.UPD'
                                  ELSE 'PSF_60341_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_FND.UPD'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEARICOB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EARICOB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EARICOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102011'
       ,expStartPerControl     = '202102011'
       ,expLastEndPerControl   = '202105069'
       ,expEndPerControl       = '202105069'
WHERE expFormatCode = 'EARICOB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEARICOB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EARICOB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EARICOB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EARICOB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EARICOB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARICOB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EARICOB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARICOB', 'UseFileName', 'V', 'Y'


-- End ripout