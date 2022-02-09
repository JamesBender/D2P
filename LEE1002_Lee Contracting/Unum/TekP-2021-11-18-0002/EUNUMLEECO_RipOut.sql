/**********************************************************************************

EUNUMLEECO: Unum FMLA Export

FormatCode:     EUNUMLEECO
Project:        Unum FMLA Export
Client ID:      USG1000
Date/time:      2022-02-08 20:42:28.573
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_EUNUMLEECO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUNUMLEECO_SavePath') IS NOT NULL DROP TABLE dbo.U_EUNUMLEECO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUNUMLEECO'


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
WHERE FormatCode = 'EUNUMLEECO'
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
WHERE ExpFormatCode = 'EUNUMLEECO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUNUMLEECO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUNUMLEECO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUNUMLEECO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUNUMLEECO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUNUMLEECO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUNUMLEECO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUNUMLEECO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUNUMLEECO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUNUMLEECO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUNUMLEECO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUNUMLEECO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMLEECO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMLEECO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMLEECO];
GO
IF OBJECT_ID('U_EUNUMLEECO_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLEECO_PEarHist];
GO
IF OBJECT_ID('U_EUNUMLEECO_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLEECO_File];
GO
IF OBJECT_ID('U_EUNUMLEECO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLEECO_EEList];
GO
IF OBJECT_ID('U_EUNUMLEECO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLEECO_drvTbl];
GO
IF OBJECT_ID('U_EUNUMLEECO_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLEECO_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMLEECO') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMLEECO];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMLEECO','Unum FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EUNUMLEECOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMLEECOZ0','50','H','01','1',NULL,'Partner Case ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMLEECOZ0','50','H','01','2',NULL,'Service Indicator',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMLEECOZ0','50','H','01','3',NULL,'EE Social Security Number',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMLEECOZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMLEECOZ0','50','H','01','5',NULL,'Employee ID Type',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMLEECOZ0','50','H','01','6',NULL,'Employee First Name',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMLEECOZ0','50','H','01','7',NULL,'Employee Middle Initial',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMLEECOZ0','50','H','01','8',NULL,'Employee Last Name',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMLEECOZ0','50','H','01','9',NULL,'EE Street Address 1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMLEECOZ0','50','H','01','10',NULL,'EE Street Address 2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMLEECOZ0','50','H','01','11',NULL,'EE City',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMLEECOZ0','50','H','01','12',NULL,'EE Residence State/Province',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMLEECOZ0','50','H','01','13',NULL,'EE Postal Code',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMLEECOZ0','50','H','01','14',NULL,'EE Country Code',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMLEECOZ0','50','H','01','15',NULL,'EE Work State/Province',NULL,NULL,'"EE_WRK_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMLEECOZ0','50','H','01','16',NULL,'EE Date of Birth',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMLEECOZ0','50','H','01','17',NULL,'EE Gender',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMLEECOZ0','50','H','01','18',NULL,'Marital Status',NULL,NULL,'"MARITAL_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMLEECOZ0','50','H','01','19',NULL,'Employee Job Title',NULL,NULL,'"EE_JOB_TLE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMLEECOZ0','50','H','01','20',NULL,'Most Recent Hire Date',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMLEECOZ0','50','H','01','21',NULL,'Original Hire Date',NULL,NULL,'"ORG_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMLEECOZ0','50','H','01','22',NULL,'Employment Termination Date',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMLEECOZ0','50','H','01','23',NULL,'Employment Status',NULL,NULL,'"EE_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMLEECOZ0','50','H','01','24',NULL,'Weekly Scheduled Work Hours',NULL,NULL,'"WKLY_SCH_WRK_HRS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMLEECOZ0','50','H','01','25',NULL,'Accommodates Restrictions',NULL,NULL,'"ACCOM_RSTCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMLEECOZ0','50','H','01','26',NULL,'Sick Pay Hours  ',NULL,NULL,'"SICK_PAY_HRS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMLEECOZ0','50','H','01','27',NULL,'Date of Last Salary Change',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMLEECOZ0','50','H','01','28',NULL,'Employee Home Phone Number',NULL,NULL,'"EE_HOME_PHONE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMLEECOZ0','50','H','01','29',NULL,'Manager First Name',NULL,NULL,'"MGR_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMLEECOZ0','50','H','01','30',NULL,'Manager Last Name',NULL,NULL,'"MGR_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMLEECOZ0','50','H','01','31',NULL,'Manager Email',NULL,NULL,'"MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMLEECOZ0','50','H','01','32',NULL,'Employee Second Manager Email',NULL,NULL,'"EE_SCND_MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMLEECOZ0','50','H','01','33',NULL,'Employee Third Manager Email',NULL,NULL,'"EE_THRD_MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMLEECOZ0','50','H','01','34',NULL,'Hours Worked In the Past 12 Months',NULL,NULL,'"HR_WRKED_IN_PST_12_MNTHS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMLEECOZ0','50','H','01','35',NULL,'Work On Sunday?',NULL,NULL,'"WRK_ON_SUN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMLEECOZ0','50','H','01','36',NULL,'Work On Monday?',NULL,NULL,'"WRK_ON_MON"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMLEECOZ0','50','H','01','37',NULL,'Work On Tuesday?',NULL,NULL,'"WRK_ON_TUES"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMLEECOZ0','50','H','01','38',NULL,'Work On Wednesday?',NULL,NULL,'"WRK_ON_WEDS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMLEECOZ0','50','H','01','39',NULL,'Work On Thursday?',NULL,NULL,'"WRK_ON_THURS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMLEECOZ0','50','H','01','40',NULL,'Work On Friday?',NULL,NULL,'"WRK_ON_FRI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMLEECOZ0','50','H','01','41',NULL,'Work On Saturday?',NULL,NULL,'"WRK_ON_SAT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMLEECOZ0','50','H','01','42',NULL,'Office Name',NULL,NULL,'"OFFCE_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMLEECOZ0','50','H','01','43',NULL,'Employee Work Mail Street Address 1',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMLEECOZ0','50','H','01','44',NULL,'Employee Work Mail Street Address 2',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMLEECOZ0','50','H','01','45',NULL,'Employee Work Mail Street Address 3',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMLEECOZ0','50','H','01','46',NULL,'Employee Work City',NULL,NULL,'"EE_WRK_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMLEECOZ0','50','H','01','47',NULL,'Employee Work Postal Code',NULL,NULL,'"EE_WRK_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMLEECOZ0','50','H','01','48',NULL,'FMLA Reporting Group',NULL,NULL,'"FMLA_RPTING_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMLEECOZ0','50','H','01','49',NULL,'Key Employee',NULL,NULL,'"KEY_EE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMLEECOZ0','50','H','01','50',NULL,'EE Salary Mode',NULL,NULL,'"EE_SAL_MD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMLEECOZ0','51','H','01','51',NULL,'Product',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMLEECOZ0','52','H','01','52',NULL,'Policy Number',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMLEECOZ0','53','H','01','53',NULL,'Division',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMLEECOZ0','54','H','01','54',NULL,'Policy Eligibility Group (Class)',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMLEECOZ0','54','H','01','55',NULL,'Choice',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMLEECOZ0','54','H','01','56',NULL,'Employee Post-Tax Contribution %',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMLEECOZ0','54','H','01','57',NULL,'Earnings',NULL,NULL,'"EARNINGS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMLEECOZ0','54','H','01','58',NULL,'Earnings Period',NULL,NULL,'"EARNINGS_PRD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMLEECOZ0','54','H','01','59',NULL,'Effective Date of Employee Coverage',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMLEECOZ0','54','H','01','60',NULL,'Employee Coverage Termination Date',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EUNUMLEECOZ0','54','H','01','61',NULL,'Product',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EUNUMLEECOZ0','54','H','01','62',NULL,'Policy Number',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EUNUMLEECOZ0','54','H','01','63',NULL,'Division',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EUNUMLEECOZ0','54','H','01','64',NULL,'Policy Eligibility Group (Class)',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EUNUMLEECOZ0','54','H','01','65',NULL,'Choice',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EUNUMLEECOZ0','54','H','01','66',NULL,'Employee Post-Tax Contribution %',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EUNUMLEECOZ0','54','H','01','67',NULL,'Earnings',NULL,NULL,'"EARNINGS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EUNUMLEECOZ0','54','H','01','68',NULL,'Earnings Period',NULL,NULL,'"EARNINGS_PRD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EUNUMLEECOZ0','54','H','01','69',NULL,'Effective Date of Employee Coverage',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EUNUMLEECOZ0','54','H','01','70',NULL,'Employee Coverage Termination Date',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMLEECOZ0','54','D','10','1',NULL,'Partner Case ID',NULL,NULL,'"drvPartCaseId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMLEECOZ0','54','D','10','2',NULL,'Service Indicator',NULL,NULL,'"drvServIndic"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMLEECOZ0','54','D','10','3',NULL,'EE Social Security Number',NULL,NULL,'"drvEESSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMLEECOZ0','54','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMLEECOZ0','54','D','10','5',NULL,'Employee ID Type',NULL,NULL,'"drvEmpIdType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMLEECOZ0','54','D','10','6',NULL,'Employee First Name',NULL,NULL,'"drvEmpFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMLEECOZ0','54','D','10','7',NULL,'Employee Middle Initial',NULL,NULL,'"drvEmpMI"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMLEECOZ0','54','D','10','8',NULL,'Employee Last Name',NULL,NULL,'"drvEmpLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMLEECOZ0','54','D','10','9',NULL,'EE Street Address 1',NULL,NULL,'"drvEEAdd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMLEECOZ0','54','D','10','10',NULL,'EE Street Address 2',NULL,NULL,'"drvEEAdd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMLEECOZ0','54','D','10','11',NULL,'EE City',NULL,NULL,'"drvEECity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMLEECOZ0','54','D','10','12',NULL,'EE Residence State/Province',NULL,NULL,'"drvEEState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMLEECOZ0','54','D','10','13',NULL,'EE Postal Code',NULL,NULL,'"drvEEPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMLEECOZ0','54','D','10','14',NULL,'EE Country Code',NULL,NULL,'"drvEECountryCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMLEECOZ0','54','D','10','15',NULL,'EE Work State/Province',NULL,NULL,'"drvEEWorkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMLEECOZ0','54','D','10','16',NULL,'EE Date of Birth',NULL,NULL,'"drvEEDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMLEECOZ0','54','D','10','17',NULL,'EE Gender',NULL,NULL,'"drvEEGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMLEECOZ0','54','D','10','18',NULL,'Marital Status',NULL,NULL,'"drvMaritalStat"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMLEECOZ0','54','D','10','19',NULL,'Employee Job Title',NULL,NULL,'"drvEmpJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMLEECOZ0','54','D','10','20',NULL,'Most Recent Hire Date',NULL,NULL,'"drvMostRecentHireDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMLEECOZ0','54','D','10','21',NULL,'Original Hire Date',NULL,NULL,'"drvOrigHireDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMLEECOZ0','54','D','10','22',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentTermDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMLEECOZ0','54','D','10','23',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStat"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMLEECOZ0','54','D','10','24',NULL,'Weekly Scheduled Work Hours',NULL,NULL,'"drvWeekSchWorkHrs"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMLEECOZ0','54','D','10','25',NULL,'Accommodates Restrictions',NULL,NULL,'"drvAccoRestrict"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMLEECOZ0','54','D','10','26',NULL,'Sick Pay Hours  ',NULL,NULL,'"drvSickPayHrs"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMLEECOZ0','54','D','10','27',NULL,'Date of Last Salary Change',NULL,NULL,'"drvDtLastSalChng"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMLEECOZ0','54','D','10','28',NULL,'Employee Home Phone Number',NULL,NULL,'"drvEmpHomePh"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMLEECOZ0','54','D','10','29',NULL,'Manager First Name',NULL,NULL,'"drvManFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMLEECOZ0','54','D','10','30',NULL,'Manager Last Name',NULL,NULL,'"drvManLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMLEECOZ0','54','D','10','31',NULL,'Manager Email',NULL,NULL,'"drvManEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMLEECOZ0','54','D','10','32',NULL,'Employee Second Manager Email',NULL,NULL,'"drvEmpSecManEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMLEECOZ0','54','D','10','33',NULL,'Employee Third Manager Email',NULL,NULL,'"drvEmpThirdManEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMLEECOZ0','54','D','10','34',NULL,'Hours Worked In the Past 12 Months',NULL,NULL,'"drvHrsWrkedPast12Mo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMLEECOZ0','54','D','10','35',NULL,'Work On Sunday?',NULL,NULL,'"drvWorkSunday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMLEECOZ0','54','D','10','36',NULL,'Work On Monday?',NULL,NULL,'"drvWorkMonday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMLEECOZ0','54','D','10','37',NULL,'Work On Tuesday?',NULL,NULL,'"drvWorkTuesday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMLEECOZ0','54','D','10','38',NULL,'Work On Wednesday?',NULL,NULL,'"drvWorkWednesday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMLEECOZ0','54','D','10','39',NULL,'Work On Thursday?',NULL,NULL,'"drvWorkThursday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMLEECOZ0','54','D','10','40',NULL,'Work On Friday?',NULL,NULL,'"drvWorkFriday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMLEECOZ0','54','D','10','41',NULL,'Work On Saturday?',NULL,NULL,'"drvWorkSaturday"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMLEECOZ0','54','D','10','42',NULL,'Office Name',NULL,NULL,'"drvOfficeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMLEECOZ0','54','D','10','43',NULL,'Employee Work Mail Street Address 1',NULL,NULL,'"drvEmpWorkMailStreet1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMLEECOZ0','54','D','10','44',NULL,'Employee Work Mail Street Address 2',NULL,NULL,'"drvEmpWorkMailStreet2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMLEECOZ0','54','D','10','45',NULL,'Employee Work Mail Street Address 3',NULL,NULL,'"drvEmpWorkMailStreet3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMLEECOZ0','54','D','10','46',NULL,'Employee Work City',NULL,NULL,'"drvEmpWorkCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMLEECOZ0','54','D','10','47',NULL,'Employee Work Postal Code',NULL,NULL,'"drvEmpWorkPostCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMLEECOZ0','54','D','10','48',NULL,'FMLA Reporting Group',NULL,NULL,'"drvFMLARepGrp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMLEECOZ0','54','D','10','49',NULL,'Key Employee',NULL,NULL,'"drvKeyEmp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMLEECOZ0','54','D','10','50',NULL,'EE Salary Mode',NULL,NULL,'"drvEESalMode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMLEECOZ0','54','D','10','51',NULL,'Product',NULL,NULL,'"drvProduct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMLEECOZ0','54','D','10','52',NULL,'Policy Number',NULL,NULL,'"drvPolNum1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMLEECOZ0','54','D','10','53',NULL,'Division',NULL,NULL,'"drvDiv1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMLEECOZ0','54','D','10','54',NULL,'Policy Eligibility Group (Class)',NULL,NULL,'"drvPolEligGrp1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMLEECOZ0','54','D','10','55',NULL,'Choice',NULL,NULL,'"drvChoice1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMLEECOZ0','54','D','10','56',NULL,'Employee Post-Tax Contribution %',NULL,NULL,'"drvEmpPostTax1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMLEECOZ0','54','D','10','57',NULL,'Earnings',NULL,NULL,'"drvEarnings1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMLEECOZ0','54','D','10','58',NULL,'Earnings Period',NULL,NULL,'"drvEarningsPrd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMLEECOZ0','54','D','10','59',NULL,'Effective Date of Employee Coverage',NULL,NULL,'"drvEffDtEmpCov1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMLEECOZ0','54','D','10','60',NULL,'Employee Coverage Termination Date',NULL,NULL,'"drvEmpCovTermDt1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EUNUMLEECOZ0','54','D','10','61',NULL,'Product',NULL,NULL,'"drvProduct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EUNUMLEECOZ0','54','D','10','62',NULL,'Policy Number',NULL,NULL,'"drvPolNum2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EUNUMLEECOZ0','54','D','10','63',NULL,'Division',NULL,NULL,'"drvDiv2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EUNUMLEECOZ0','54','D','10','64',NULL,'Policy Eligibility Group (Class)',NULL,NULL,'"drvPolEligGrp2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EUNUMLEECOZ0','54','D','10','65',NULL,'Choice',NULL,NULL,'"drvChoice2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EUNUMLEECOZ0','54','D','10','66',NULL,'Employee Post-Tax Contribution %',NULL,NULL,'"drvEmpPostTax2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EUNUMLEECOZ0','54','D','10','67',NULL,'Earnings',NULL,NULL,'"drvEarnings2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EUNUMLEECOZ0','54','D','10','68',NULL,'Earnings Period',NULL,NULL,'"drvEarningsPrd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EUNUMLEECOZ0','54','D','10','69',NULL,'Effective Date of Employee Coverage',NULL,NULL,'"drvEffDtEmpCov2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EUNUMLEECOZ0','54','D','10','70',NULL,'Employee Coverage Termination Date',NULL,NULL,'"drvEmpCovTermDt2"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUNUMLEECO_20220208.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum FMLA Export','202202089','EMPEXPORT','ONDEM_XOE',NULL,'EUNUMLEECO',NULL,NULL,NULL,'202202089','Feb  8 2022  7:01PM','Feb  8 2022  7:01PM','202202081',NULL,'','','202202081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum FMLA Export-Sched','202202089','EMPEXPORT','SCH_EUNUML',NULL,'EUNUMLEECO',NULL,NULL,NULL,'202202089','Feb  8 2022  7:01PM','Feb  8 2022  7:01PM','202202081',NULL,'','','202202081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum FMLA Export-Test','202202089','EMPEXPORT','TEST_XOE',NULL,'EUNUMLEECO',NULL,NULL,NULL,'202202089','Feb  8 2022  7:01PM','Feb  8 2022  7:01PM','202202081',NULL,'','','202202081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLEECO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLEECO','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLEECO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLEECO','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMLEECO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMLEECO','D10','dbo.U_EUNUMLEECO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUNUMLEECO
-----------

IF OBJECT_ID('U_dsi_BDM_EUNUMLEECO') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMLEECO] (
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
-- Create table U_EUNUMLEECO_DedList
-----------

IF OBJECT_ID('U_EUNUMLEECO_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMLEECO_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUNUMLEECO_drvTbl
-----------

IF OBJECT_ID('U_EUNUMLEECO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMLEECO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPartCaseId] varchar(10) NOT NULL,
    [drvServIndic] varchar(3) NOT NULL,
    [drvEESSN] varchar(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvEmpIdType] varchar(4) NOT NULL,
    [drvEmpFName] varchar(100) NULL,
    [drvEmpMI] varchar(1) NOT NULL,
    [drvEmpLName] varchar(100) NULL,
    [drvEEAdd1] varchar(255) NULL,
    [drvEEAdd2] varchar(1) NOT NULL,
    [drvEECity] varchar(255) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEPostalCode] varchar(50) NULL,
    [drvEECountryCode] char(3) NULL,
    [drvEEWorkState] varchar(255) NULL,
    [drvEEDOB] datetime NULL,
    [drvEEGender] char(1) NULL,
    [drvMaritalStat] char(1) NULL,
    [drvEmpJobTitle] varchar(25) NOT NULL,
    [drvMostRecentHireDt] datetime NULL,
    [drvOrigHireDt] datetime NULL,
    [drvEmploymentTermDt] varchar(30) NOT NULL,
    [drvEmploymentStat] varchar(3) NULL,
    [drvWeekSchWorkHrs] varchar(30) NULL,
    [drvAccoRestrict] varchar(1) NOT NULL,
    [drvSickPayHrs] varchar(1) NOT NULL,
    [drvDtLastSalChng] datetime NULL,
    [drvEmpHomePh] varchar(50) NULL,
    [drvManFName] varchar(1) NOT NULL,
    [drvManLName] varchar(1) NOT NULL,
    [drvManEmail] varchar(1) NOT NULL,
    [drvEmpSecManEmail] varchar(1) NOT NULL,
    [drvEmpThirdManEmail] varchar(1) NOT NULL,
    [drvHrsWrkedPast12Mo] varchar(30) NULL,
    [drvWorkSunday] varchar(1) NOT NULL,
    [drvWorkMonday] varchar(1) NOT NULL,
    [drvWorkTuesday] varchar(1) NOT NULL,
    [drvWorkWednesday] varchar(1) NOT NULL,
    [drvWorkThursday] varchar(1) NOT NULL,
    [drvWorkFriday] varchar(1) NOT NULL,
    [drvWorkSaturday] varchar(1) NOT NULL,
    [drvOfficeName] varchar(1) NOT NULL,
    [drvEmpWorkMailStreet1] varchar(1) NOT NULL,
    [drvEmpWorkMailStreet2] varchar(1) NOT NULL,
    [drvEmpWorkMailStreet3] varchar(1) NOT NULL,
    [drvEmpWorkCity] varchar(255) NULL,
    [drvEmpWorkPostCode] varchar(1) NOT NULL,
    [drvFMLARepGrp] varchar(1) NOT NULL,
    [drvKeyEmp] varchar(1) NOT NULL,
    [drvEESalMode] char(1) NULL,
    [drvProduct1] varchar(3) NULL,
    [drvPolNum1] varchar(6) NULL,
    [drvDiv1] varchar(1) NOT NULL,
    [drvPolEligGrp1] varchar(1) NULL,
    [drvChoice1] varchar(1) NOT NULL,
    [drvEmpPostTax1] varchar(1) NULL,
    [drvEarnings1] varchar(1) NULL,
    [drvEarningsPrd1] varchar(2) NULL,
    [drvEffDtEmpCov1] datetime NULL,
    [drvEmpCovTermDt1] datetime NULL,
    [drvProduct2] varchar(3) NULL,
    [drvPolNum2] varchar(6) NULL,
    [drvDiv2] varchar(1) NOT NULL,
    [drvPolEligGrp2] varchar(1) NULL,
    [drvChoice2] varchar(1) NOT NULL,
    [drvEmpPostTax2] varchar(3) NULL,
    [drvEarnings2] varchar(30) NULL,
    [drvEarningsPrd2] varchar(2) NULL,
    [drvEffDtEmpCov2] datetime NULL,
    [drvEmpCovTermDt2] datetime NULL
);

-----------
-- Create table U_EUNUMLEECO_EEList
-----------

IF OBJECT_ID('U_EUNUMLEECO_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMLEECO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUNUMLEECO_File
-----------

IF OBJECT_ID('U_EUNUMLEECO_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMLEECO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EUNUMLEECO_PEarHist
-----------

IF OBJECT_ID('U_EUNUMLEECO_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMLEECO_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PayEarnCode] char(5) NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMLEECO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Lee Contracting, Inc.

Created By: Andy Pineda
Business Analyst: Julie Reardon
Create Date: 02/08/2022
Service Request Number: TekP-2021-11-18-0002

Purpose: Unum FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMLEECO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMLEECO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMLEECO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMLEECO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMLEECO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLEECO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLEECO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLEECO', 'SCH_EUNUML';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMLEECO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUNUMLEECO', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EUNUMLEECO';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('01/01/2021' as DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMLEECO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMLEECO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,STD2,STD3,LTD';

    IF OBJECT_ID('U_EUNUMLEECO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLEECO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMLEECO_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    -- IF OBJECT_ID('U_EUNUMLEECO_PDedHist','U') IS NOT NULL
    --     DROP TABLE dbo.U_EUNUMLEECO_PDedHist;
    -- SELECT DISTINCT
    --      PdhEEID
    --     -- Current Payroll Amounts
    --     ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --     -- YTD Payroll Amounts
    --     ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --     ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --     -- Categorize Payroll Amounts
    --     ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --     ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --     ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --     ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    -- INTO dbo.U_EUNUMLEECO_PDedHist
    -- FROM dbo.PDedHist WITH (NOLOCK)
    -- JOIN dbo.U_EUNUMLEECO_DedList WITH (NOLOCK)
    --     ON DedCode = PdhDedCode
    -- WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    -- AND PdhPerControl <= @EndPerControl
    -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    -- GROUP BY PdhEEID
    -- HAVING (SUM(PdhEECurAmt) <> 0.00
    --     OR SUM(PdhERCurAmt) <> 0.00
    -- );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
   IF OBJECT_ID('U_EUNUMLEECO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLEECO_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehEarnCode
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PayEarnCode            = MAX(PehEarnCode)
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
    INTO dbo.U_EUNUMLEECO_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl, 4) = YEAR(GETDATE()) - 1
    --LEFT(PehPerControl,4) - 1 = LEFT(@EndPerControl,4) - 1
    --PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMLEECO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMLEECO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLEECO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPartCaseId = 'LEE-023835'
        ,drvServIndic = 'ELG'
        ,drvEESSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                    SUBSTRING(EepSSN, 4, 2)+'-'+
                    SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpId = EecEmpNo
        ,drvEmpIdType = 'EEID'
        ,drvEmpFName = EepNameFirst
        ,drvEmpMI = ''
        ,drvEmpLName = EepNameLast
        ,drvEEAdd1 = EepAddressLine1
        ,drvEEAdd2 = ''
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEPostalCode = EepAddressZipCode
        ,drvEECountryCode = EepAddressCountry
        ,drvEEWorkState = LocAddressState
        ,drvEEDOB = EepDateOfBirth
        ,drvEEGender = EepGender
        ,drvMaritalStat = EepMaritalStatus
        ,drvEmpJobTitle = JbcDesc
        ,drvMostRecentHireDt = EecDateOfLastHire
        ,drvOrigHireDt = EecDateOfOriginalHire
        ,drvEmploymentTermDt = ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 101), '')
        ,drvEmploymentStat = CASE WHEN EecEmplStatus IN ('A', 'O', 'S', 'T') THEN 'A'
                                    WHEN EecEmplStatus = 'R' THEN 'LAY'
                                    WHEN EecEmplStatus = 'L' THEN 'LOA' END
        ,drvWeekSchWorkHrs = CAST(EecScheduledWorkHrs AS VARCHAR)
        ,drvAccoRestrict = 'Y'
        ,drvSickPayHrs = ''
        ,drvDtLastSalChng = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvEmpHomePh = EepPhoneHomeNumber
        ,drvManFName = ''
        ,drvManLName = ''
        ,drvManEmail = ''
        ,drvEmpSecManEmail = ''
        ,drvEmpThirdManEmail = ''
        ,drvHrsWrkedPast12Mo = CAST(Peh.PehCurHrs AS VARCHAR)
        ,drvWorkSunday = ''
        ,drvWorkMonday = ''
        ,drvWorkTuesday = ''
        ,drvWorkWednesday = ''
        ,drvWorkThursday = ''
        ,drvWorkFriday = ''
        ,drvWorkSaturday = ''
        ,drvOfficeName = ''
        ,drvEmpWorkMailStreet1 = ''
        ,drvEmpWorkMailStreet2 = ''
        ,drvEmpWorkMailStreet3 = ''
        ,drvEmpWorkCity = EepAddressCity
        ,drvEmpWorkPostCode = ''
        ,drvFMLARepGrp = ''
        ,drvKeyEmp = ''
        ,drvEESalMode = EecSalaryOrHourly
        ,drvProduct1 = CASE WHEN STD IS NOT NULL THEN '469' END
        ,drvPolNum1 = CASE WHEN STD IS NOT NULL THEN '709744' END
        ,drvDiv1 = '1'
        ,drvPolEligGrp1 = CASE WHEN STD IS NOT NULL AND EecOrgLvl3 IN ('TRD', 'ADS') THEN '1'
                                WHEN STD IS NOT NULL AND EecOrgLvl3 IN ('MGT', 'PFS', 'EXE') AND DATEDIFF(YEAR, GETDATE(), EecDateOfLastHire) < 3 THEN '2'
                                WHEN STD IS NOT NULL AND EecOrgLvl3 IN ('MGT', 'PFS', 'EXE') AND DATEDIFF(YEAR, GETDATE(), EecDateOfLastHire) >= 3 THEN '3'
                                    END
        ,drvChoice1 = '1'
        ,drvEmpPostTax1 = CASE WHEN STD IS NOT NULL THEN '0' END
        ,drvEarnings1 = CASE WHEN STD IS NOT NULL THEN '0' END
        ,drvEarningsPrd1 = CASE WHEN STD IS NOT NULL THEN 'WK' END
        ,drvEffDtEmpCov1 = CASE WHEN STD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt1 = CASE WHEN STD IS NOT NULL THEN STD_BenStopDate END
        ,drvProduct2 = CASE WHEN LTD IS NOT NULL THEN '195' END
        ,drvPolNum2 = CASE WHEN LTD IS NOT NULL THEN '497388' END
        ,drvDiv2 = '1'
        ,drvPolEligGrp2 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvChoice2 = '1'
        ,drvEmpPostTax2 = CASE WHEN LTD IS NOT NULL THEN '100' END
        ,drvEarnings2 = CASE WHEN LTD IS NOT NULL THEN CAST(EecAnnSalary / 12 AS VARCHAR) END
        ,drvEarningsPrd2 = CASE WHEN LTD IS NOT NULL THEN 'MO' END
        ,drvEffDtEmpCov2 = CASE WHEN LTD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LTD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt2 = CASE WHEN LTD IS NOT NULL THEN LTD_BenStopDate END
    INTO dbo.U_EUNUMLEECO_drvTbl
    FROM dbo.U_EUNUMLEECO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    -- JOIN dbo.U_dsi_BDM_EUNUMLEECO WITH (NOLOCK)
    --     ON BdmEEID = xEEID 
    --     AND BdmCoID = xCoID
    JOIN (SELECT EedEEID, EedCOID, MAX(CASE WHEN EedDedCode = 'LTD' THEN 'LTD' END) AS LTD,
                    MAX(CASE WHEN EedDedCode IN ('STD', 'STD2', 'STD3') THEN 'STD' END) AS STD,
                    MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStartDate END) AS LTD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStopDate END) AS LTD_BenStopDate,
                    MAX(CASE WHEN EedDedCode IN ('STD', 'STD2', 'STD3')  THEN EedBenStartDate END) AS STD_BenStartDate,
                    MAX(CASE WHEN EedDedCode IN ('STD', 'STD2', 'STD3')  THEN EedBenStopDate END) AS STD_BenStopDate
            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
            WHERE EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID
            ) D ON D.EedEEID = xEEID AND D.EedCOID = xCOID
    LEFT JOIN (SELECT PehEEID, SUM(PehCurHrs) AS PehCurHrs
                FROM dbo.U_EUNUMLEECO_PEarHist WITH(NOLOCK)
                WHERE PehEarnCode IN ('DT', 'MBDT', 'MBOT', 'MBRG', 'OT', 'REG')
                                        GROUP BY PehEEID) Peh ON Peh.PehEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEUNUMLEECO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMLEECO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMLEECO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202011'
       ,expStartPerControl     = '202202011'
       ,expLastEndPerControl   = '202202089'
       ,expEndPerControl       = '202202089'
WHERE expFormatCode = 'EUNUMLEECO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMLEECO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMLEECO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUNUMLEECO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUNUMLEECO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUNUMLEECO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMLEECO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUNUMLEECO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMLEECO', 'UseFileName', 'V', 'Y'


-- End ripout