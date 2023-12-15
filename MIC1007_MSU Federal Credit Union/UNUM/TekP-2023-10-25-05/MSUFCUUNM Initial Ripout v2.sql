/**********************************************************************************

EMSUFCUUNM: MSUFCU UNUM Export

FormatCode:     EMSUFCUUNM
Project:        MSUFCU UNUM Export
Client ID:      USG1000
Date/time:      2023-12-08 15:08:50.900
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_LUIGI
Web Filename:   USG1000_79690_EEHISTORY_EMSUFCUUNM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMSUFCUUNM_SavePath') IS NOT NULL DROP TABLE dbo.U_EMSUFCUUNM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMSUFCUUNM'


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
WHERE FormatCode = 'EMSUFCUUNM'
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
WHERE ExpFormatCode = 'EMSUFCUUNM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMSUFCUUNM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMSUFCUUNM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMSUFCUUNM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMSUFCUUNM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMSUFCUUNM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMSUFCUUNM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMSUFCUUNM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMSUFCUUNM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMSUFCUUNM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMSUFCUUNM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMSUFCUUNM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMSUFCUUNM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMSUFCUUNM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSUFCUUNM];
GO
IF OBJECT_ID('U_EMSUFCUUNM_File') IS NOT NULL DROP TABLE [dbo].[U_EMSUFCUUNM_File];
GO
IF OBJECT_ID('U_EMSUFCUUNM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMSUFCUUNM_EEList];
GO
IF OBJECT_ID('U_EMSUFCUUNM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMSUFCUUNM_drvTbl];
GO
IF OBJECT_ID('U_EMSUFCUUNM_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMSUFCUUNM_DedList];
GO
IF OBJECT_ID('U_EMSUFCUUNM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMSUFCUUNM_AuditFields];
GO
IF OBJECT_ID('U_EMSUFCUUNM_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMSUFCUUNM_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMSUFCUUNM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMSUFCUUNM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputmediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMSUFCUUNM','MSUFCU UNUM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6000','S','N','EMSUFCUUNMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSUFCUUNMZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSUFCUUNMZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSUFCUUNMZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMSUFCUUNMZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMSUFCUUNMZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMSUFCUUNMZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMSUFCUUNMZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMSUFCUUNMZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMSUFCUUNMZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMSUFCUUNMZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMSUFCUUNMZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMSUFCUUNMZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMSUFCUUNMZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMSUFCUUNMZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMSUFCUUNMZ0','50','H','01','15',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMSUFCUUNMZ0','50','H','01','16',NULL,'SP_DOB',NULL,NULL,'"SP_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMSUFCUUNMZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMSUFCUUNMZ0','50','H','01','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'"EE_TOBACCO_USE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMSUFCUUNMZ0','50','H','01','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMSUFCUUNMZ0','50','H','01','20',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMSUFCUUNMZ0','50','H','01','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMSUFCUUNMZ0','50','H','01','22',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMSUFCUUNMZ0','50','H','01','23',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMSUFCUUNMZ0','50','H','01','24',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMSUFCUUNMZ0','50','H','01','25',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMSUFCUUNMZ0','50','H','01','26',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMSUFCUUNMZ0','50','H','01','27',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMSUFCUUNMZ0','50','H','01','28',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMSUFCUUNMZ0','50','H','01','29',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMSUFCUUNMZ0','50','H','01','30',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMSUFCUUNMZ0','50','H','01','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMSUFCUUNMZ0','50','H','01','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMSUFCUUNMZ0','50','H','01','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMSUFCUUNMZ0','50','H','01','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMSUFCUUNMZ0','50','H','01','35',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMSUFCUUNMZ0','50','H','01','36',NULL,'PRODUCT 2',NULL,NULL,'"PRODUCT 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMSUFCUUNMZ0','50','H','01','37',NULL,'POLICY_NBR 2',NULL,NULL,'"POLICY_NBR 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMSUFCUUNMZ0','50','H','01','38',NULL,'DIVISION 2',NULL,NULL,'"DIVISION 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMSUFCUUNMZ0','50','H','01','39',NULL,'POLICY_ELG_GRP 2',NULL,NULL,'"POLICY_ELG_GRP 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMSUFCUUNMZ0','50','H','01','40',NULL,'CHOICE 2',NULL,NULL,'"CHOICE 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMSUFCUUNMZ0','50','H','01','41',NULL,'EE_POSTTAX_CNTRB_PCT 2',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMSUFCUUNMZ0','50','H','01','42',NULL,'EFF_DATE_OF_EE_COVG 2',NULL,NULL,'"EFF_DATE_OF_EE_COVG 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMSUFCUUNMZ0','50','H','01','43',NULL,'COVG_TERM_DATE 2',NULL,NULL,'"COVG_TERM_DATE 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMSUFCUUNMZ0','50','H','01','44',NULL,'EE_BEN_AMT 2',NULL,NULL,'"EE_BEN_AMT 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMSUFCUUNMZ0','50','H','01','45',NULL,'EFF_DATE_OF_SP_COVG 2',NULL,NULL,'"EFF_DATE_OF_SP_COVG 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMSUFCUUNMZ0','50','H','01','46',NULL,'SP_COVG_TERM_DATE 2',NULL,NULL,'"SP_COVG_TERM_DATE 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMSUFCUUNMZ0','50','H','01','47',NULL,'EFF_DATE_OF_CH_COVG 2',NULL,NULL,'"EFF_DATE_OF_CH_COVG 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMSUFCUUNMZ0','50','H','01','48',NULL,'CH_COVG_TERM_DATE 2',NULL,NULL,'"CH_COVG_TERM_DATE 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMSUFCUUNMZ0','50','H','01','49',NULL,'CI_SP_IND 2',NULL,NULL,'"CI_SP_IND 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMSUFCUUNMZ0','51','H','01','50',NULL,'PRODUCT 3',NULL,NULL,'"PRODUCT 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMSUFCUUNMZ0','52','H','01','51',NULL,'POLICY_NBR 3',NULL,NULL,'"POLICY_NBR 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMSUFCUUNMZ0','53','H','01','52',NULL,'DIVISION 3',NULL,NULL,'"DIVISION 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMSUFCUUNMZ0','54','H','01','53',NULL,'POLICY_ELG_GRP 3',NULL,NULL,'"POLICY_ELG_GRP 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMSUFCUUNMZ0','55','H','01','54',NULL,'CHOICE 3',NULL,NULL,'"CHOICE 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMSUFCUUNMZ0','56','H','01','55',NULL,'EE_POSTTAX_CNTRB_PCT 3',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMSUFCUUNMZ0','57','H','01','56',NULL,'EFF_DATE_OF_EE_COVG 3',NULL,NULL,'"EFF_DATE_OF_EE_COVG 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMSUFCUUNMZ0','58','H','01','57',NULL,'COVG_TERM_DATE 3',NULL,NULL,'"COVG_TERM_DATE 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMSUFCUUNMZ0','59','H','01','58',NULL,'EE_BEN_AMT 3',NULL,NULL,'"EE_BEN_AMT 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMSUFCUUNMZ0','60','H','01','59',NULL,'EFF_DATE_OF_SP_COVG 3',NULL,NULL,'"EFF_DATE_OF_SP_COVG 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMSUFCUUNMZ0','61','H','01','60',NULL,'SP_COVG_TERM_DATE 3',NULL,NULL,'"SP_COVG_TERM_DATE 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMSUFCUUNMZ0','62','H','01','61',NULL,'EFF_DATE_OF_CH_COVG 3',NULL,NULL,'"EFF_DATE_OF_CH_COVG 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMSUFCUUNMZ0','63','H','01','62',NULL,'CH_COVG_TERM_DATE 3',NULL,NULL,'"CH_COVG_TERM_DATE 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMSUFCUUNMZ0','64','H','01','63',NULL,'CI_SP_IND 3',NULL,NULL,'"CI_SP_IND 3"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSUFCUUNMZ0','65','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"MIC-038060"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSUFCUUNMZ0','66','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"ELG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSUFCUUNMZ0','67','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMSUFCUUNMZ0','68','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMSUFCUUNMZ0','69','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EEID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMSUFCUUNMZ0','70','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMSUFCUUNMZ0','71','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMSUFCUUNMZ0','72','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMSUFCUUNMZ0','73','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMSUFCUUNMZ0','74','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMSUFCUUNMZ0','75','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMSUFCUUNMZ0','76','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMSUFCUUNMZ0','77','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMSUFCUUNMZ0','78','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMSUFCUUNMZ0','79','D','10','15',NULL,'EE_DOB',NULL,NULL,'"drvDOB"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMSUFCUUNMZ0','80','D','10','16',NULL,'SP_DOB',NULL,NULL,'"drvConDOB"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMSUFCUUNMZ0','81','D','10','17',NULL,'EE_GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMSUFCUUNMZ0','82','D','10','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMSUFCUUNMZ0','83','D','10','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvDateOfLastHire"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMSUFCUUNMZ0','84','D','10','20',NULL,'EE_TERM_DATE',NULL,NULL,'"drvDateOfTemination"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMSUFCUUNMZ0','85','D','10','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMSUFCUUNMZ0','86','D','10','22',NULL,'PRODUCT',NULL,NULL,'"drvProduct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMSUFCUUNMZ0','87','D','10','23',NULL,'POLICY_NBR',NULL,NULL,'"drvPolicyNbr1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMSUFCUUNMZ0','88','D','10','24',NULL,'DIVISION',NULL,NULL,'"drvDivision1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMSUFCUUNMZ0','89','D','10','25',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolicyEligibleGrp1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMSUFCUUNMZ0','90','D','10','26',NULL,'CHOICE',NULL,NULL,'"drvChoice1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMSUFCUUNMZ0','91','D','10','27',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMSUFCUUNMZ0','92','D','10','28',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEffDateChange1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMSUFCUUNMZ0','93','D','10','29',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCovgTermDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMSUFCUUNMZ0','94','D','10','30',NULL,'EE_BEN_AMT',NULL,NULL,'"drvEEBenAmt1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMSUFCUUNMZ0','95','D','10','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvSpEffCovgDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMSUFCUUNMZ0','96','D','10','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSpCovgTermDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMSUFCUUNMZ0','97','D','10','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvDateOfChCovg1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMSUFCUUNMZ0','98','D','10','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvChCvgTermDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMSUFCUUNMZ0','99','D','10','35',NULL,'CI_SP_IND',NULL,NULL,'"drvCiSpInd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMSUFCUUNMZ0','100','D','10','36',NULL,'PRODUCT 2',NULL,NULL,'"drvProduct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMSUFCUUNMZ0','101','D','10','37',NULL,'POLICY_NBR 2',NULL,NULL,'"drvPolicyNbr2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMSUFCUUNMZ0','102','D','10','38',NULL,'DIVISION 2',NULL,NULL,'"drvDivision2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMSUFCUUNMZ0','103','D','10','39',NULL,'POLICY_ELG_GRP 2',NULL,NULL,'"drvPolicyEligibleGrp2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMSUFCUUNMZ0','104','D','10','40',NULL,'CHOICE 2',NULL,NULL,'"drvChoice2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMSUFCUUNMZ0','105','D','10','41',NULL,'EE_POSTTAX_CNTRB_PCT 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMSUFCUUNMZ0','106','D','10','42',NULL,'EFF_DATE_OF_EE_COVG 2',NULL,NULL,'"drvEffDateChange2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMSUFCUUNMZ0','107','D','10','43',NULL,'COVG_TERM_DATE 2',NULL,NULL,'"drvCovgTermDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMSUFCUUNMZ0','108','D','10','44',NULL,'EE_BEN_AMT 2',NULL,NULL,'"drvEEBenAmt2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMSUFCUUNMZ0','109','D','10','45',NULL,'EFF_DATE_OF_SP_COVG 2',NULL,NULL,'"drvSpEffCovgDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMSUFCUUNMZ0','110','D','10','46',NULL,'SP_COVG_TERM_DATE 2',NULL,NULL,'"drvSpCovgTermDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMSUFCUUNMZ0','111','D','10','47',NULL,'EFF_DATE_OF_CH_COVG 2',NULL,NULL,'"drvDateOfChCovg2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMSUFCUUNMZ0','112','D','10','48',NULL,'CH_COVG_TERM_DATE 2',NULL,NULL,'"drvChCvgTermDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMSUFCUUNMZ0','113','D','10','49',NULL,'CI_SP_IND 2',NULL,NULL,'"drvCiSpInd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMSUFCUUNMZ0','114','D','10','50',NULL,'PRODUCT 3',NULL,NULL,'"drvProduct3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMSUFCUUNMZ0','115','D','10','51',NULL,'POLICY_NBR 3',NULL,NULL,'"drvPolicyNbr3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMSUFCUUNMZ0','116','D','10','52',NULL,'DIVISION 3',NULL,NULL,'"drvDivision3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMSUFCUUNMZ0','117','D','10','53',NULL,'POLICY_ELG_GRP 3',NULL,NULL,'"drvPolicyEligibleGrp3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMSUFCUUNMZ0','118','D','10','54',NULL,'CHOICE 3',NULL,NULL,'"drvChoice3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMSUFCUUNMZ0','119','D','10','55',NULL,'EE_POSTTAX_CNTRB_PCT 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMSUFCUUNMZ0','120','D','10','56',NULL,'EFF_DATE_OF_EE_COVG 3',NULL,NULL,'"drvEffDateChange3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMSUFCUUNMZ0','121','D','10','57',NULL,'COVG_TERM_DATE 3',NULL,NULL,'"drvCovgTermDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMSUFCUUNMZ0','122','D','10','58',NULL,'EE_BEN_AMT 3',NULL,NULL,'"drvEEBenAmt3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMSUFCUUNMZ0','123','D','10','59',NULL,'EFF_DATE_OF_SP_COVG 3',NULL,NULL,'"drvSpEffCovgDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMSUFCUUNMZ0','124','D','10','60',NULL,'SP_COVG_TERM_DATE 3',NULL,NULL,'"drvSpCovgTermDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMSUFCUUNMZ0','125','D','10','61',NULL,'EFF_DATE_OF_CH_COVG 3',NULL,NULL,'"drvDateOfChCovg3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMSUFCUUNMZ0','126','D','10','62',NULL,'CH_COVG_TERM_DATE 3',NULL,NULL,'"drvChCvgTermDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMSUFCUUNMZ0','127','D','10','63',NULL,'CI_SP_IND 3',NULL,NULL,'"drvCiSpInd3"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMSUFCUUNM_20231208.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MSUFCU UNUM Active OE Export','202312069','EMPEXPORT','OEACTIVE',NULL,'EMSUFCUUNM',NULL,NULL,NULL,'202312069','Dec  6 2023  3:22PM','Dec  6 2023  3:22PM','202312061',NULL,'','','202312061',dbo.fn_getTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MSUFCU UNUM Passive OE Export','202312069','EMPEXPORT','OEPASSIVE',NULL,'EMSUFCUUNM',NULL,NULL,NULL,'202312069','Dec  6 2023  3:22PM','Dec  6 2023  3:22PM','202312061',NULL,'','','202312061',dbo.fn_getTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MSUFCU UNUM Export','202312069','EMPEXPORT','ONDEM_XOE',NULL,'EMSUFCUUNM',NULL,NULL,NULL,'202312069','Dec  6 2023  3:22PM','Dec  6 2023  3:22PM','202312061',NULL,'','','202312061',dbo.fn_getTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MSUFCU UNUM Export-Sched','202312069','EMPEXPORT','SCH_EMSUFC',NULL,'EMSUFCUUNM',NULL,NULL,NULL,'202312069','Dec  6 2023  3:22PM','Dec  6 2023  3:22PM','202312061',NULL,'','','202312061',dbo.fn_getTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MSUFCU UNUM Export-Test','202312069','EMPEXPORT','TEST_XOE',NULL,'EMSUFCUUNM',NULL,NULL,NULL,'202312069','Dec  6 2023  3:22PM','Dec  6 2023  3:22PM','202312061',NULL,'','','202312061',dbo.fn_getTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSUFCUUNM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSUFCUUNM','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSUFCUUNM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSUFCUUNM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSUFCUUNM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSUFCUUNM','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSUFCUUNM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSUFCUUNM','D10','dbo.U_EMSUFCUUNM_drvTbl',NULL);

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
-- Create table U_dsi_BDM_EMSUFCUUNM
-----------

IF OBJECT_ID('U_dsi_BDM_EMSUFCUUNM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMSUFCUUNM] (
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
-- Create table U_EMSUFCUUNM_Audit
-----------

IF OBJECT_ID('U_EMSUFCUUNM_Audit') IS NULL
CREATE TABLE [dbo].[U_EMSUFCUUNM_Audit] (
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
-- Create table U_EMSUFCUUNM_AuditFields
-----------

IF OBJECT_ID('U_EMSUFCUUNM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMSUFCUUNM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMSUFCUUNM_DedList
-----------

IF OBJECT_ID('U_EMSUFCUUNM_DedList') IS NULL
CREATE TABLE [dbo].[U_EMSUFCUUNM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMSUFCUUNM_drvTbl
-----------

IF OBJECT_ID('U_EMSUFCUUNM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMSUFCUUNM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvDOB] datetime NULL,
    [drvConDOB] datetime NULL,
    [drvGender] char(1) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateOfTemination] datetime NULL,
    [drvProduct1] varchar(3) NULL,
    [drvPolicyNbr1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolicyEligibleGrp1] varchar(1) NULL,
    [drvChoice1] varchar(1) NULL,
    [drvEffDateChange1] datetime NULL,
    [drvCovgTermDate1] datetime NULL,
    [drvEEBenAmt1] varchar(1) NOT NULL,
    [drvSpEffCovgDate1] datetime NULL,
    [drvSpCovgTermDate1] datetime NULL,
    [drvDateOfChCovg1] datetime NULL,
    [drvChCvgTermDate1] datetime NULL,
    [drvCiSpInd1] varchar(1) NOT NULL,
    [drvProduct2] varchar(3) NULL,
    [drvPolicyNbr2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyEligibleGrp2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvEffDateChange2] datetime NULL,
    [drvCovgTermDate2] datetime NULL,
    [drvEEBenAmt2] money NULL,
    [drvSpEffCovgDate2] datetime NULL,
    [drvSpCovgTermDate2] datetime NULL,
    [drvDateOfChCovg2] datetime NULL,
    [drvChCvgTermDate2] datetime NULL,
    [drvCiSpInd2] varchar(1) NULL,
    [drvProduct3] varchar(3) NULL,
    [drvPolicyNbr3] varchar(6) NULL,
    [drvDivision3] varchar(1) NULL,
    [drvPolicyEligibleGrp3] varchar(1) NULL,
    [drvChoice3] varchar(1) NULL,
    [drvEffDateChange3] datetime NULL,
    [drvCovgTermDate3] datetime NULL,
    [drvEEBenAmt3] varchar(1) NOT NULL,
    [drvSpEffCovgDate3] datetime NULL,
    [drvSpCovgTermDate3] datetime NULL,
    [drvDateOfChCovg3] datetime NULL,
    [drvChCvgTermDate3] datetime NULL,
    [drvCiSpInd3] varchar(1) NOT NULL
);

-----------
-- Create table U_EMSUFCUUNM_EEList
-----------

IF OBJECT_ID('U_EMSUFCUUNM_EEList') IS NULL
CREATE TABLE [dbo].[U_EMSUFCUUNM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMSUFCUUNM_File
-----------

IF OBJECT_ID('U_EMSUFCUUNM_File') IS NULL
CREATE TABLE [dbo].[U_EMSUFCUUNM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSUFCUUNM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MSU Federal Credit Union

Created By: Spencer Kerch
Business Analyst: Dawn Ross
Create Date: 12/06/2023
Service Request Number: TekP-2023-10-25-05

Purpose: MSUFCU UNUM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMSUFCUUNM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMSUFCUUNM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMSUFCUUNM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMSUFCUUNM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMSUFCUUNM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSUFCUUNM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSUFCUUNM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSUFCUUNM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSUFCUUNM', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSUFCUUNM', 'SCH_EMSUFC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMSUFCUUNM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMSUFCUUNM', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EMSUFCUUNM';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  ='01/01/2024'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMSUFCUUNM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMSUFCUUNM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMSUFCUUNM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMSUFCUUNM_AuditFields;
    CREATE TABLE dbo.U_EMSUFCUUNM_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMSUFCUUNM_AuditFields VALUES ('EmpDed','EedEEEligDate')

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMSUFCUUNM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMSUFCUUNM_Audit;
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
    INTO dbo.U_EMSUFCUUNM_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMSUFCUUNM_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMSUFCUUNM_Audit ON dbo.U_EMSUFCUUNM_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
   -- DELETE FROM dbo.U_EMSUFCUUNM_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMSUFCUUNM_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCID,CRILL,CISP,HOSP1,HOSP2'; 

    IF OBJECT_ID('U_EMSUFCUUNM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMSUFCUUNM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
   INTO dbo.U_EMSUFCUUNM_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMSUFCUUNM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMSUFCUUNM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMSUFCUUNM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvAddress1 = replace(EepAddressLine1,',','')
        ,drvAddress2 = replace(EepAddressLine2,',','')
        ,drvAddressCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDOB = EepDateOfBirth
        ,drvConDOB = CASE WHEN CRIT_CISPSP IS NOT NULL then ConDateOfBirth END
        ,drvGender = EepGender
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateOfTemination = eecDateOfTermination
        ,drvProduct1 = CASE WHEN ACCID IS NOT NULL THEN '824' END
        ,drvPolicyNbr1 = CASE WHEN ACCID IS NOT NULL THEN '947924' END
        ,drvDivision1 = CASE WHEN ACCID IS NOT NULL THEN '1' END
        ,drvPolicyEligibleGrp1 = CASE WHEN ACCID IS NOT NULL THEN '1' END
        ,drvChoice1 = CASE WHEN ACCID IS NOT NULL THEN '1' END
        ,drvEffDateChange1 = CASE WHEN ACCID IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',ACCID_StartDate,@FileMinCovDate) END
        ,drvCovgTermDate1 = CASE WHEN ACCID IS NOT NULL THEN ACCID_StopDate END
        ,drvEEBenAmt1 = ''
        ,drvSpEffCovgDate1 = CASE WHEN ACCID_Spouse IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',ACCID_StartDate,@FileMinCovDate) END
        ,drvSpCovgTermDate1 =  CASE WHEN ACCID_Spouse IS NOT NULL THEN ACCID_StopDate END
        ,drvDateOfChCovg1 = CASE WHEN ACCID_ChangeReason IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',ACCID_StartDate,@FileMinCovDate) END
        ,drvChCvgTermDate1 = CASE WHEN ACCID_Child IS NOT NULL THEN ACCID_StopDate END
        ,drvCiSpInd1 = ''
        ,drvProduct2 = CASE WHEN CRIT IS NOT NULL THEN '822' END
        ,drvPolicyNbr2 = CASE WHEN CRIT IS NOT NULL THEN '947925' END
        ,drvDivision2 = CASE WHEN CRIT IS NOT NULL THEN '1' END
        ,drvPolicyEligibleGrp2 = CASE WHEN CRIT IS NOT NULL THEN '1' END
        ,drvChoice2 = CASE WHEN CRIT IS NOT NULL THEN 
                        CASE WHEN CRIT_EEAmt = '10000' THEN '1'
                             WHEN CRIT_EEAmt = '20000' THEN '2'
                             WHEN CRIT_EEAmt = '30000' THEN '3'
                             END
                      END
                        
        ,drvEffDateChange2 = CASE WHEN CRIT IS NOT NULL THEN  dbo.dsi_fnGetMinMaxDates('MAX',CRIT_StartDate,@FileMinCovDate) END
        ,drvCovgTermDate2 =  CASE WHEN CRIT IS NOT NULL THEN CRIT_StopDate END
        ,drvEEBenAmt2 =  CASE WHEN CRIT IS NOT NULL THEN CRIT_EEAmt END
        ,drvSpEffCovgDate2 = CASE WHEN CRIT_CISPSP IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',CRIT_StartDate,@FileMinCovDate)  END
        ,drvSpCovgTermDate2 = CASE WHEN CRIT_CISPSP IS NOT NULL THEN CRIT_StopDate END
        ,drvDateOfChCovg2 = CASE WHEN CRIT_ChangeReason IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',CRIT_StartDate,@FileMinCovDate)  END
        ,drvChCvgTermDate2 = CASE WHEN CRIT_CRILLCH IS NOT NULL THEN CRIT_StopDate END
        ,drvCiSpInd2 = CASE WHEN CRILL IS NOT NULL THEN 'N'
                            WHEN CISP IS NOT NULL THEN 'Y'
                            END
        ,drvProduct3 = CASE WHEN HOSP IS NOT NULL THEN '825' END
        ,drvPolicyNbr3 = CASE WHEN HOSP IS NOT NULL THEN '947926' END
        ,drvDivision3 = CASE WHEN HOSP IS NOT NULL THEN '1' END
        ,drvPolicyEligibleGrp3 = CASE WHEN HOSP IS NOT NULL THEN '1' END
        ,drvChoice3 = CASE WHEN HOSP_1 IS NOT NULL THEN '1'
                           WHEN HOSP_2 IS NOT NULL THEN '2'
                           END
        ,drvEffDateChange3 = CASE WHEN HOSP IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',HOSP_StartDate,@FileMinCovDate)  END
        ,drvCovgTermDate3 = CASE WHEN HOSP IS NOT NULL THEN HOSP_StopDate END
        ,drvEEBenAmt3 = ''
        ,drvSpEffCovgDate3 = CASE WHEN HOSP_Spouse IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',HOSP_StartDate,@FileMinCovDate) END
        ,drvSpCovgTermDate3 = CASE WHEN HOSP_Spouse IS NOT NULL THEN HOSP_StopDate END
        ,drvDateOfChCovg3 = CASE WHEN HOSP_ChangeReason IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',HOSP_StartDate,@FileMinCovDate) END
        ,drvChCvgTermDate3 = CASE WHEN HOSP_Child IS NOT NULL THEN HOSP_StopDate END
        ,drvCiSpInd3 = ''
    INTO dbo.U_EMSUFCUUNM_drvTbl
    FROM dbo.U_EMSUFCUUNM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT Distinct  BdmEEID, BdmCOID               
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') THEN bdmDedCode END) AS ACCID 
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') THEN BdmBenStartDate END ) AS  ACCID_StartDate
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') THEN BdmBenStopDate END ) AS ACCID_StopDate
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') THEN BdmEEAmt END ) AS ACCID_EEAmt
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') and BdmRelationship IN ('SPS','DP') THEN BdmRelationship END ) AS ACCID_Spouse
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') and BdmChangeReason IN  ('103','105', '201', '202', '204', '300', '302', '303', '401', '402', 'LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5') THEN BdmChangeReason END ) AS ACCID_ChangeReason
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID') and BdmRelationship IN  ('CHL', 'DC', 'DPC', 'STC') THEN BdmRelationship END ) AS ACCID_Child
        
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1','HOSP2') THEN bdmDedCode END) AS HOSP
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1') THEN bdmDedCode END) AS HOSP_1
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP2') THEN bdmDedCode END) AS HOSP_2
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1','HOSP2') THEN bdmBenStartDate END) AS HOSP_StartDate
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1','HOSP2') THEN bdmBenStopDate END) AS HOSP_StopDate
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1','HOSP2') and BdmRelationship IN ('SPS','DP') THEN BdmRelationship END ) AS HOSP_Spouse
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1','HOSP2') and BdmChangeReason IN  ('103','105', '201', '202', '204', '300', '302', '303', '401', '402', 'LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5') THEN BdmChangeReason END ) AS HOSP_ChangeReason
                ,MAX(CASE WHEN bdmDedCode IN ('HOSP1','HOSP2') and BdmRelationship IN  ('CHL', 'DC', 'DPC', 'STC') THEN BdmRelationship END ) AS HOSP_Child
                
                ,MAX(CASE WHEN bdmDedCode IN ('CRILL','CISP') THEN bdmDedCode END) AS CRIT
                ,MAX(CASE WHEN bdmDedCode IN ('CRILL','CISP') THEN bdmBenStartDate END) AS CRIT_StartDate
                ,MAX(CASE WHEN bdmDedCode IN ('CRILL','CISP') THEN bdmBenStopDate END) AS CRIT_StopDate
                ,MAX(CASE WHEN bdmDedCode IN ('CRILL','CISP')  THEN BdmEEAmt END ) AS CRIT_EEAmt
                ,MAX(CASE WHEN bdmDedCode IN ('CRILL','CISP') and BdmChangeReason IN  ('103','105', '201', '202', '204', '300', '302', '303', '401', '402', 'LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5') THEN BdmChangeReason END ) AS CRIT_ChangeReason

                ,MAX(CASE WHEN bdmDedCode IN ('CRILL') and BdmRelationship IN ('CHL', 'DC', 'DPC', 'STC') THEN BdmRelationship END ) AS CRIT_CRILLCH
				,MAX(CASE WHEN bdmDedCode IN ('CRILL') THEN BdmDedCode END ) AS CRILL

				,MAX(CASE WHEN bdmDedCode IN ('CISP') THEN BdmDedCode END ) AS CISP
                ,MAX(CASE WHEN bdmDedCode IN ('CISP') and BdmRelationship IN ('SPS','DP') THEN BdmRelationship END ) AS CRIT_CISPSP
             
                ,MAX(CASE WHEN bdmDedCode IN ('ACCID','CRILL','CISP','HOSP1','HOSP2') AND bdmrelationship IN ('CHL', 'DC', 'DPC', 'STC','SPS','DP') THEN bdmDepRecID END) AS bdmDepRecID

        
            FROM dbo.U_dsi_BDM_EMSUFCUUNM WITH (NOLOCK)
     where  BdmDedCode IN ('CRILL','CISP','ACCID','HOSP1','HOSP2')-- Replaced GTL
            AND bdmBenStatus IN ('A','T') 
            group by  BdmEEID, Bdmcoid
        ) Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConSystemID = BdmDepRecID
     --LEFT JOIN dbo.U_EMSUFCUUNM_Audit WITH (NoLock)
       -- ON Audeeid = XEEID and audKey2 = XCOID
       --WHERE EecEEType <> 'TES'
        --AND (EecEmplStatus IN ('A', 'L')  OR (EecEmplStatus = 'T' and EecTermreason <> 'TRO' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN @StartDate AND @EndDate))
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
ALTER VIEW dbo.dsi_vwEMSUFCUUNM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMSUFCUUNM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMSUFCUUNM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311291'
       ,expStartPerControl     = '202311291'
       ,expLastEndPerControl   = '202312069'
       ,expEndPerControl       = '202312069'
WHERE expFormatCode = 'EMSUFCUUNM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMSUFCUUNM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMSUFCUUNM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMSUFCUUNM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMSUFCUUNM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMSUFCUUNM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMSUFCUUNM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMSUFCUUNM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMSUFCUUNM', 'UseFileName', 'V', 'Y'


-- End ripout