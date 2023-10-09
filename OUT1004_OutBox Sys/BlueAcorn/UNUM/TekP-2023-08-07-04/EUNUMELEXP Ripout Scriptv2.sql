/**********************************************************************************

EUNUMELEXP: UNUM Eligibility Critical Illness Accident

FormatCode:     EUNUMELEXP
Project:        UNUM Eligibility Critical Illness Accident
Client ID:      OUT1004
Date/time:      2023-10-06 12:57:03.817
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPOUTB
Web Filename:   OUT1004_VA7H4_EEHISTORY_EUNUMELEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUNUMELEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EUNUMELEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUNUMELEXP'


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
WHERE FormatCode = 'EUNUMELEXP'
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
WHERE ExpFormatCode = 'EUNUMELEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUNUMELEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUNUMELEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUNUMELEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUNUMELEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUNUMELEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUNUMELEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUNUMELEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUNUMELEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUNUMELEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUNUMELEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUNUMELEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMELEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMELEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMELEXP];
GO
IF OBJECT_ID('U_EUNUMELEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_PEarHist];
GO
IF OBJECT_ID('U_EUNUMELEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_PDedHist];
GO
IF OBJECT_ID('U_EUNUMELEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_Header];
GO
IF OBJECT_ID('U_EUNUMELEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_File];
GO
IF OBJECT_ID('U_EUNUMELEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_EEList];
GO
IF OBJECT_ID('U_EUNUMELEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_drvTbl];
GO
IF OBJECT_ID('U_EUNUMELEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_DedList];
GO
IF OBJECT_ID('U_EUNUMELEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_AuditFields];
GO
IF OBJECT_ID('U_EUNUMELEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNUMELEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMELEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMELEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMELEXP','UNUM Eligibility Critical Illness Accident','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EUNUMELEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMELEXPZ0','10','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMELEXPZ0','10','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMELEXPZ0','11','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMELEXPZ0','20','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMELEXPZ0','5','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMELEXPZ0','15','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMELEXPZ0','1','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMELEXPZ0','25','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMELEXPZ0','40','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMELEXPZ0','40','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMELEXPZ0','30','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMELEXPZ0','2','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMELEXPZ0','11','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMELEXPZ0','2','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMELEXPZ0','10','H','01','15',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMELEXPZ0','10','H','01','16',NULL,'SP_DOB',NULL,NULL,'"SP_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMELEXPZ0','3','H','01','17',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMELEXPZ0','1','H','01','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'"EE_TOBACCO_USE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMELEXPZ0','10','H','01','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMELEXPZ0','10','H','01','20',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMELEXPZ0','10','H','01','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMELEXPZ0','4','H','01','22',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMELEXPZ0','6','H','01','23',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMELEXPZ0','3','H','01','24',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMELEXPZ0','3','H','01','25',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMELEXPZ0','2','H','01','26',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMELEXPZ0','10','H','01','27',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMELEXPZ0','10','H','01','28',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMELEXPZ0','10','H','01','29',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMELEXPZ0','1','H','01','30',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMELEXPZ0','10','H','01','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMELEXPZ0','10','H','01','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMELEXPZ0','10','H','01','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMELEXPZ0','10','H','01','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMELEXPZ0','4','H','01','35',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMELEXPZ0','6','H','01','36',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMELEXPZ0','3','H','01','37',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMELEXPZ0','3','H','01','38',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMELEXPZ0','2','H','01','39',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMELEXPZ0','10','H','01','40',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMELEXPZ0','10','H','01','41',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMELEXPZ0','10','H','01','42',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMELEXPZ0','1','H','01','43',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMELEXPZ0','10','H','01','44',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMELEXPZ0','10','H','01','45',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMELEXPZ0','10','H','01','46',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMELEXPZ0','10','H','01','47',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMELEXPZ0','4','H','01','48',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMELEXPZ0','6','H','01','49',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMELEXPZ0','3','H','01','50',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMELEXPZ0','3','H','01','51',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMELEXPZ0','2','H','01','52',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMELEXPZ0','10','H','01','53',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMELEXPZ0','10','H','01','54',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMELEXPZ0','10','H','01','55',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMELEXPZ0','1','H','01','56',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMELEXPZ0','10','H','01','57',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMELEXPZ0','10','H','01','58',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMELEXPZ0','10','H','01','59',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMELEXPZ0','10','H','01','60',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMELEXPZ0','10','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"drvPartnerCaseID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMELEXPZ0','10','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"drvServiceIndicator"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMELEXPZ0','11','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMELEXPZ0','20','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvEE_ID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMELEXPZ0','5','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"drvEE_ID_TYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMELEXPZ0','15','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvFirstname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMELEXPZ0','1','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"drvMiddleInit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMELEXPZ0','25','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMELEXPZ0','40','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvSt_Addr1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMELEXPZ0','40','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvSt_Addr2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMELEXPZ0','30','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMELEXPZ0','2','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvRdc_StPvc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMELEXPZ0','11','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvPostalCd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMELEXPZ0','2','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"drvCntryCd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMELEXPZ0','10','D','10','15',NULL,'EE_DOB',NULL,NULL,'"drvEE_Dob"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMELEXPZ0','10','D','10','16',NULL,'SP_DOB',NULL,NULL,'"drvSP_Dob"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMELEXPZ0','3','D','10','17',NULL,'EE_GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMELEXPZ0','1','D','10','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'"drvTobaccoUse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMELEXPZ0','10','D','10','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvRcnt_HireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMELEXPZ0','10','D','10','20',NULL,'EE_TERM_DATE',NULL,NULL,'"drvTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMELEXPZ0','10','D','10','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"drvDate_Of_Lst_SlyChg"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMELEXPZ0','4','D','10','22',NULL,'PRODUCT',NULL,NULL,'"drvProd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMELEXPZ0','6','D','10','23',NULL,'POLICY_NBR',NULL,NULL,'"drvNum1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMELEXPZ0','3','D','10','24',NULL,'DIVISION',NULL,NULL,'"drvDivision1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMELEXPZ0','3','D','10','25',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolElgGrp1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMELEXPZ0','2','D','10','26',NULL,'CHOICE',NULL,NULL,'"drvchoice1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMELEXPZ0','10','D','10','27',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEEF_Date_Of_EeCovg1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMELEXPZ0','10','D','10','28',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCovgTermDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMELEXPZ0','10','D','10','29',NULL,'EE_BEN_AMT',NULL,NULL,'"drvBenAmt1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMELEXPZ0','1','D','10','30',NULL,'CI_SP_IND',NULL,NULL,'"drvCiSpInd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMELEXPZ0','10','D','10','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvEEF_Date_Of_SpCovg1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMELEXPZ0','10','D','10','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSP_Covg_TermDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMELEXPZ0','10','D','10','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvDate_Of_ChCovg1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMELEXPZ0','10','D','10','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvCH_Covg_TermDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMELEXPZ0','4','D','10','35',NULL,'PRODUCT',NULL,NULL,'"drvProd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMELEXPZ0','6','D','10','36',NULL,'POLICY_NBR',NULL,NULL,'"drvNum2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMELEXPZ0','3','D','10','37',NULL,'DIVISION',NULL,NULL,'"drvDivision2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMELEXPZ0','3','D','10','38',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolElgGrp2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMELEXPZ0','2','D','10','39',NULL,'CHOICE',NULL,NULL,'"drvchoice2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMELEXPZ0','10','D','10','40',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEEF_Date_Of_EeCovg2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMELEXPZ0','10','D','10','41',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCovgTermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMELEXPZ0','10','D','10','42',NULL,'EE_BEN_AMT',NULL,NULL,'"drvBenAmt2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMELEXPZ0','1','D','10','43',NULL,'CI_SP_IND',NULL,NULL,'"drvCiSpInd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMELEXPZ0','10','D','10','44',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvEEF_Date_Of_SpCovg2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMELEXPZ0','10','D','10','45',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSP_Covg_TermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMELEXPZ0','10','D','10','46',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvDate_Of_ChCovg2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMELEXPZ0','10','D','10','47',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvCH_Covg_TermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMELEXPZ0','4','D','10','48',NULL,'PRODUCT',NULL,NULL,'"drvProd3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMELEXPZ0','6','D','10','49',NULL,'POLICY_NBR',NULL,NULL,'"drvNum3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMELEXPZ0','3','D','10','50',NULL,'DIVISION',NULL,NULL,'"drvDivision3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMELEXPZ0','3','D','10','51',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolElgGrp3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMELEXPZ0','2','D','10','52',NULL,'CHOICE',NULL,NULL,'"drvchoice3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMELEXPZ0','10','D','10','53',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEEF_Date_Of_EeCovg3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMELEXPZ0','10','D','10','54',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCovgTermDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMELEXPZ0','10','D','10','55',NULL,'EE_BEN_AMT',NULL,NULL,'"drvBenAmt3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMELEXPZ0','1','D','10','56',NULL,'CI_SP_IND',NULL,NULL,'"drvCiSpInd3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMELEXPZ0','10','D','10','57',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvEEF_Date_Of_SpCovg3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMELEXPZ0','10','D','10','58',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSP_Covg_TermDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMELEXPZ0','10','D','10','59',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvDate_Of_ChCovg3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMELEXPZ0','10','D','10','60',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvCH_Covg_TermDate3"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUNUMELEXP_20231006.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202310049','EMPEXPORT','OEACTIVE',NULL,'EUNUMELEXP',NULL,NULL,NULL,'202310049','Oct  4 2023  4:58PM','Oct  4 2023  4:58PM','202310041',NULL,'','','202310041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202310049','EMPEXPORT','OEPASSIVE',NULL,'EUNUMELEXP',NULL,NULL,NULL,'202310049','Oct  4 2023  4:58PM','Oct  4 2023  4:58PM','202310041',NULL,'','','202310041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Eligibility Crit Illness','202310049','EMPEXPORT','ONDEM_XOE',NULL,'EUNUMELEXP',NULL,NULL,NULL,'202310049','Oct  4 2023  4:58PM','Oct  4 2023  4:58PM','202310041',NULL,'','','202310041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Eligibility Crit Il-Sched','202310049','EMPEXPORT','SCH_EUNUME',NULL,'EUNUMELEXP',NULL,NULL,NULL,'202310049','Oct  4 2023  4:58PM','Oct  4 2023  4:58PM','202310041',NULL,'','','202310041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'UNUM Eligibility Crit Il-Test','202310049','EMPEXPORT','TEST_XOE',NULL,'EUNUMELEXP',NULL,NULL,NULL,'202310049','Oct  4 2023  4:58PM','Oct  4 2023  4:58PM','202308011',NULL,'','','202308011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','InitialSort','C','drvInitSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMELEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMELEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMELEXP','D10','dbo.U_EUNUMELEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUNUMELEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EUNUMELEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMELEXP] (
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
-- Create table U_EUNUMELEXP_Audit
-----------

IF OBJECT_ID('U_EUNUMELEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [AudCoid] varchar(255) NOT NULL,
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
-- Create table U_EUNUMELEXP_AuditFields
-----------

IF OBJECT_ID('U_EUNUMELEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EUNUMELEXP_DedList
-----------

IF OBJECT_ID('U_EUNUMELEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUNUMELEXP_drvTbl
-----------

IF OBJECT_ID('U_EUNUMELEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPartnerCaseID] varchar(10) NOT NULL,
    [drvServiceIndicator] varchar(3) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEE_ID] char(9) NULL,
    [drvEE_ID_TYPE] varchar(4) NOT NULL,
    [drvFirstname] varchar(100) NULL,
    [drvMiddleInit] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSt_Addr1] varchar(8000) NULL,
    [drvSt_Addr2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvRdc_StPvc] varchar(2) NULL,
    [drvPostalCd] varchar(50) NULL,
    [drvCntryCd] varchar(2) NULL,
    [drvEE_Dob] varchar(10) NULL,
    [drvSP_Dob] varchar(10) NULL,
    [drvGender] char(1) NULL,
    [drvTobaccoUse] varchar(1) NOT NULL,
    [drvRcnt_HireDate] varchar(10) NULL,
    [drvTermDate] varchar(10) NULL,
    [drvDate_Of_Lst_SlyChg] varchar(10) NULL,
    [drvProd1] varchar(3) NULL,
    [drvNum1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolElgGrp1] varchar(1) NULL,
    [drvchoice1] varchar(1) NULL,
    [drvEEF_Date_Of_EeCovg1] varchar(10) NULL,
    [drvCovgTermDate1] varchar(10) NULL,
    [drvBenAmt1] varchar(1) NOT NULL,
    [drvCiSpInd1] varchar(1) NOT NULL,
    [drvEEF_Date_Of_SpCovg1] varchar(10) NULL,
    [drvSP_Covg_TermDate1] varchar(10) NULL,
    [drvDate_Of_ChCovg1] varchar(1) NOT NULL,
    [drvCH_Covg_TermDate1] varchar(1) NOT NULL,
    [drvProd2] varchar(3) NULL,
    [drvNum2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolElgGrp2] varchar(1) NULL,
    [drvchoice2] varchar(1) NULL,
    [drvEEF_Date_Of_EeCovg2] varchar(10) NULL,
    [drvCovgTermDate2] varchar(10) NULL,
    [drvBenAmt2] varchar(5) NULL,
    [drvCiSpInd2] varchar(1) NOT NULL,
    [drvEEF_Date_Of_SpCovg2] varchar(10) NULL,
    [drvSP_Covg_TermDate2] varchar(10) NULL,
    [drvDate_Of_ChCovg2] varchar(1) NOT NULL,
    [drvCH_Covg_TermDate2] varchar(1) NOT NULL,
    [drvProd3] varchar(3) NULL,
    [drvNum3] varchar(6) NULL,
    [drvDivision3] varchar(1) NULL,
    [drvPolElgGrp3] varchar(1) NULL,
    [drvchoice3] varchar(1) NULL,
    [drvEEF_Date_Of_EeCovg3] varchar(10) NULL,
    [drvCovgTermDate3] varchar(10) NULL,
    [drvBenAmt3] varchar(1) NOT NULL,
    [drvCiSpInd3] varchar(1) NOT NULL,
    [drvEEF_Date_Of_SpCovg3] varchar(10) NULL,
    [drvSP_Covg_TermDate3] varchar(10) NULL,
    [drvDate_Of_ChCovg3] varchar(1) NOT NULL,
    [drvCH_Covg_TermDate3] varchar(1) NOT NULL
);

-----------
-- Create table U_EUNUMELEXP_EEList
-----------

IF OBJECT_ID('U_EUNUMELEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUNUMELEXP_File
-----------

IF OBJECT_ID('U_EUNUMELEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EUNUMELEXP_Header
-----------

IF OBJECT_ID('U_EUNUMELEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_Header] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPartnerCaseID] varchar(10) NOT NULL,
    [drvServiceIndicator] varchar(3) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEE_ID] char(9) NULL,
    [drvEE_ID_TYPE] varchar(4) NOT NULL,
    [drvFirstname] varchar(100) NULL,
    [drvMiddleInit] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSt_Addr1] varchar(8000) NULL,
    [drvSt_Addr2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvRdc_StPvc] varchar(2) NULL,
    [drvPostalCd] varchar(50) NULL,
    [drvCntryCd] varchar(2) NULL,
    [drvEE_Dob] varchar(10) NULL,
    [drvSP_Dob] varchar(10) NULL,
    [drvGender] char(1) NULL,
    [drvTobaccoUse] varchar(1) NOT NULL,
    [drvRcnt_HireDate] varchar(10) NULL,
    [drvTermDate] varchar(10) NULL,
    [drvDate_Of_Lst_SlyChg] varchar(10) NULL,
    [drvProd1] varchar(3) NULL,
    [drvNum1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolElgGrp1] varchar(1) NULL,
    [drvchoice1] varchar(1) NULL,
    [drvEEF_Date_Of_EeCovg1] varchar(10) NULL,
    [drvCovgTermDate1] varchar(10) NULL,
    [drvBenAmt1] varchar(1) NOT NULL,
    [drvCiSpInd1] varchar(1) NOT NULL,
    [drvEEF_Date_Of_SpCovg1] varchar(10) NULL,
    [drvSP_Covg_TermDate1] varchar(10) NULL,
    [drvDate_Of_ChCovg1] varchar(1) NOT NULL,
    [drvCH_Covg_TermDate1] varchar(1) NOT NULL,
    [drvProd2] varchar(3) NULL,
    [drvNum2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolElgGrp2] varchar(1) NULL,
    [drvchoice2] varchar(1) NULL,
    [drvEEF_Date_Of_EeCovg2] varchar(10) NULL,
    [drvCovgTermDate2] varchar(10) NULL,
    [drvBenAmt2] varchar(5) NULL,
    [drvCiSpInd2] varchar(1) NOT NULL,
    [drvEEF_Date_Of_SpCovg2] varchar(10) NULL,
    [drvSP_Covg_TermDate2] varchar(10) NULL,
    [drvDate_Of_ChCovg2] varchar(1) NOT NULL,
    [drvCH_Covg_TermDate2] varchar(1) NOT NULL,
    [drvProd3] varchar(3) NULL,
    [drvNum3] varchar(6) NULL,
    [drvDivision3] varchar(1) NULL,
    [drvPolElgGrp3] varchar(1) NULL,
    [drvchoice3] varchar(1) NULL,
    [drvEEF_Date_Of_EeCovg3] varchar(10) NULL,
    [drvCovgTermDate3] varchar(10) NULL,
    [drvBenAmt3] varchar(1) NOT NULL,
    [drvCiSpInd3] varchar(1) NOT NULL,
    [drvEEF_Date_Of_SpCovg3] varchar(10) NULL,
    [drvSP_Covg_TermDate3] varchar(10) NULL,
    [drvDate_Of_ChCovg3] varchar(1) NOT NULL,
    [drvCH_Covg_TermDate3] varchar(1) NOT NULL
);

-----------
-- Create table U_EUNUMELEXP_PDedHist
-----------

IF OBJECT_ID('U_EUNUMELEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_PDedHist] (
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
-- Create table U_EUNUMELEXP_PEarHist
-----------

IF OBJECT_ID('U_EUNUMELEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMELEXP_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMELEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Blue Acorn Inc.

Created By: Spencer Kerch
Business Analyst: Kim Ephraim
Create Date: 10/04/2023
Service Request Number: SR-2016-00012345

Purpose: UNUM Eligibility Critical Illness Accident

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMELEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMELEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMELEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMELEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMELEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMELEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMELEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMELEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMELEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMELEXP', 'SCH_EUNUME';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMELEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUNUMELEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMELEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
         ,@FileMinCovDate  = '09/01/2023'--?
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMELEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMELEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


--==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUNUMELEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMELEXP_AuditFields;
    CREATE TABLE dbo.U_EUNUMELEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_EUNUMELEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNUMELEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMELEXP_Audit;
    
    SELECT 
        audEEID  = audKey1Value
        ,AudCoid = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EUNUMELEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EUNUMELEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EUNUMELEXP_Audit ON dbo.U_EUNUMELEXP_Audit (audEEID,AudCoid);

 
 --   --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EUNUMELEXP_EEList
   --- WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUNUMELEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CR10E,CR10S,CR20E,CR20S,CR30E,CR30S,BAACC,BAHOS';

    IF OBJECT_ID('U_EUNUMELEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMELEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMELEXP_DedList
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
    -- DETAIL RECORD - U_EUNUMELEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMELEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMELEXP_drvTbl;
         SELECT DISTINCT
        drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartnerCaseID = 'BLU-036474'
        ,drvServiceIndicator = 'ELG'
        ,drvSSN = eepSSN
        ,drvEE_ID = eecEmpNo
        ,drvEE_ID_TYPE = 'EEID'
        ,drvFirstname = EepNameFirst
        ,drvMiddleInit = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSt_Addr1 = replace(eepAddressLine1,',',' ')
        ,drvSt_Addr2 = replace(eepAddressLine2,',',' ')
        ,drvCity = replace(EepAddressCity,',',' ')
        ,drvRdc_StPvc = left(EepAddressState,2)
        ,drvPostalCd = eepAddressZipCode
        ,drvCntryCd = Left(eepAddressCountry,2)
        ,drvEE_Dob = CONVERT(VARCHAR(10),EepDateOfBirth,101)
        ,drvSP_Dob = (Select  CONVERT(VARCHAR(10),ConDateOfBirth,101) from dbo.Contacts with (NOLOCK)where coneeid = xeeid and ConRelationship in ('SPS','DP') and conisdependent = 'Y')
        ,drvGender = eepGender
        ,drvTobaccoUse = ''
        ,drvRcnt_HireDate = Case when eecDateOfLastHire <> eecdateoforiginalhire and (eecjobchangereason = '101' or eechiresource = 'REHIRE') then CONVERT(VARCHAR(10),eecdateoflasthire,101)
                            else CONVERT(VARCHAR(10),eecdateoforiginalhire,101)
                            end
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(10),EecDateOfTermination,101) END
        ,drvDate_Of_Lst_SlyChg = CONVERT(VARCHAR(10),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire),101)
        ,drvProd1 = Case When BAACC in ('BAACC')  THen '824' END
        ,drvNum1 = Case When BAACC in ('BAACC')  THen '937649' END
        ,drvDivision1 =  Case When BAACC in ('BAACC')  THen '1' END
        ,drvPolElgGrp1 = Case When BAACC in ('BAACC')  THen '1' END
        ,drvchoice1 = Case When BAACC in ('BAACC')  THen '1' END
        ,drvEEF_Date_Of_EeCovg1 = Case When BAACC in ('BAACC') THen CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',BAACCStartDate, @FileMinCovDate),101) END
        ,drvCovgTermDate1 = Case when BAACC IN ('BAACC') AND BAACC_BenStatus IN ('T') THEN CONVERT(VARCHAR(10),BAACCStopDate,101) END
        ,drvBenAmt1 = ''
        ,drvCiSpInd1 = ''
        ,drvEEF_Date_Of_SpCovg1 =  Case when  BAACC IN ('BAACC')   then CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',BAACCStartDate, @FileMinCovDate),101) end
        ,drvSP_Covg_TermDate1 = Case when  BAACC IN ('BAACC') AND BAACC_BenStatus IN ('T') THEN CONVERT(VARCHAR(10),BAACCStopDate,101) end
        ,drvDate_Of_ChCovg1 = ''
        ,drvCH_Covg_TermDate1 = ''
        ,drvProd2 = Case when Crit is not null then '822' end
        ,drvNum2 = Case When Crit is not null THEN '937650' END
        ,drvDivision2 = Case when Crit is not null  THEN '1' END
        ,drvPolElgGrp2 = Case when Crit is not null  THEN '1' END
        ,drvchoice2 = Case when  Crit1 is not null THEN '1'
                       when Crit2 is not null  THEN '2'
                       when Crit3 is not null   THEN '3'
                       END
        ,drvEEF_Date_Of_EeCovg2 = Case when Crit is not null  then CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',Crit_StartDate, @FileMinCovDate),101) END
        ,drvCovgTermDate2 = Case when  Crit is not null AND Crit_Status IN ('T') THEN CONVERT(VARCHAR(10),Crit_StopDate,101) END
        ,drvBenAmt2 = Case when Crit1 is not null THEN '10000'
                                 when Crit2 is not null THEN '20000'
                                 when Crit3 is not null THEN '30000' 
                                END 
        ,drvCiSpInd2 = Case when  Crit_Spouse is not null AND Crit_Spouse_Status IN ('A') THEN 'Y'
                        ELSE 'N'
                        END
        ,drvEEF_Date_Of_SpCovg2 =  Case when    Crit_Spouse is not null then CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',Crit_Spouse_StartDate, @FileMinCovDate),101) END
        ,drvSP_Covg_TermDate2 =  Case when     Crit_Spouse is not null AND Crit_Spouse_Status IN ('T') THEN CONVERT(VARCHAR(10),Crit_Spouse_StopDate,101) END
        ,drvDate_Of_ChCovg2 = ''
        ,drvCH_Covg_TermDate2 = ''
        ,drvProd3 = Case when BAHOS IN ('BAHOS')  THEN '825' END
        ,drvNum3 = Case when BAHOS IN ('BAHOS')  THEN '937651' END
        ,drvDivision3 = Case when BAHOS IN ('BAHOS')  THEN '1' END
        ,drvPolElgGrp3 = Case when BAHOS IN ('BAHOS')  THEN '1' END
        ,drvchoice3 = Case when BAHOS IN ('BAHOS')  THEN '1' END
        ,drvEEF_Date_Of_EeCovg3 = Case when BAHOS IN ('BAHOS') then CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',BAHOS_StartDate, @FileMinCovDate),101) end
        ,drvCovgTermDate3 = Case when BAHOS IN ('BAHOS')  THEN CONVERT(VARCHAR(10),BAHOS_StopDate,101) END
        ,drvBenAmt3 = ''
        ,drvCiSpInd3 = ''
        ,drvEEF_Date_Of_SpCovg3 = Case when  BAHOS IN ('BAHOS')  then CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',BAHOS_StartDate, @FileMinCovDate),101) END
        ,drvSP_Covg_TermDate3 = Case when  BAHOS IN ('BAHOS')  THEN CONVERT(VARCHAR(10),BAHOS_StopDate,101) END
        ,drvDate_Of_ChCovg3 = ''
        ,drvCH_Covg_TermDate3 = ''
     INTO dbo.U_EUNUMELEXP_drvTbl
    FROM dbo.U_EUNUMELEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecDedGroupCode = 'BAICI'
        and EecEEType <> 'TES'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT DISTINCT
             BdmEEID
            ,Bdmcoid
            ,Crit = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S') then BdmDedCode  END))
            ,Crit_BenefitDate = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S') then  BdmBenStartDate END))
            ,Crit_StartDate = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S') then  BdmBenStartDate END))
            ,Crit_StopDate = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S') then  BdmBenStopDate END))
            ,Crit_Status = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S') then  BdmBenStatus  END))
            ,Crit_ChangeReason = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S') then  BdmChangeReason END))
            ,Crit1 = MAX((CASE WHEN BdmDedCode  IN ('CR10E','CR10S') then BdmDedCode  END))
            ,Crit2 = MAX((CASE WHEN BdmDedCode  IN ('CR20E','CR20S') then BdmDedCode  END))
            ,Crit3 = MAX((CASE WHEN BdmDedCode  IN ('CR30E','CR30S') then BdmDedCode  END))        
            ,Crit_Spouse = MAX((CASE WHEN BdmDedCode  IN ('CR10S','CR20S','CR30S') then BdmDedCode  END))
            ,Crit_Spouse_BenefitDate = MAX((CASE WHEN BdmDedCode  IN('CR10S','CR20S','CR30S')then  BdmBenStartDate END))
            ,Crit_Spouse_StartDate = MAX((CASE WHEN BdmDedCode  IN ('CR10S','CR20S','CR30S') then  BdmBenStartDate END))
            ,Crit_Spouse_StopDate = MAX((CASE WHEN BdmDedCode  IN ('CR10S','CR20S','CR30S') then  BdmBenStopDate END))
            ,Crit_Spouse_Status = MAX((CASE WHEN BdmDedCode  IN ('CR10S','CR20S','CR30S') then   BdmBenStatus  END))
            ,Crit_Spouse_ChangeReason = MAX((CASE WHEN BdmDedCode  IN ('CR10S','CR20S','CR30S') then  BdmChangeReason END))
            ,BAACC = MAX((CASE WHEN BdmDedCode  IN ('BAACC') then BdmDedCode  END))
            ,BAACC_BenefitDate = MAX((CASE WHEN BdmDedCode  IN ('BAACC') then  BdmBenStartDate END))
            ,BAACCStartDate = MAX((CASE WHEN BdmDedCode  IN ('BAACC') then  BdmBenStartDate END))
            ,BAACCStopDate = MAX((CASE WHEN BdmDedCode  IN ('BAACC') then  BdmBenStopDate END))
            ,BAACC_EEAmt = MAX((CASE WHEN BdmDedCode  IN ('BAACC') then  BdmEEAmt  END))
            ,BAACC_BenStatus =  MAX((CASE WHEN BdmDedCode  IN ('BAACC') then   BdmBenStatus  END))
            ,BAACC_ChangeReason = MAX((CASE WHEN BdmDedCode  IN ('BAACC') then  BdmChangeReason END))
            ,BAHOS = MAX((CASE WHEN BdmDedCode  IN ('BAHOS') then BdmDedCode  END))
            ,BAHOS_BenefitDate = MAX((CASE WHEN BdmDedCode  IN ('BAHOS') then  BdmBenStartDate END))
            ,BAHOS_StartDate = MAX((CASE WHEN BdmDedCode  IN ('BAHOS') then  BdmBenStartDate END))
            ,BAHOS_StopDate = MAX((CASE WHEN BdmDedCode  IN ('BAHOS') then  BdmBenStopDate END))
            ,BAHOS_Status = MAX((CASE WHEN BdmDedCode  IN ('BAHOS') then   BdmBenStatus  END))
            ,BAHOS_ChangeReason = MAX((CASE WHEN BdmDedCode  IN ('BAHOS') then  BdmChangeReason END))
            FROM  dbo.U_dsi_BDM_EUNUMELEXP  WITH (NOLOCK)
            where  BdmDedCode IN ('CR10E','CR10S','CR20E','CR20S','CR30E','CR30S','BAACC','BAHOS')-- Replaced GTL
            AND bdmBenStatus IN ('A','T') 
            group by  BdmEEID, Bdmcoid
             ) as BdmConsolidated 
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID   
    LEFT JOIN dbo.U_EUNUMELEXP_Audit WITH (NoLock)
        ON Audeeid = XEEID    and AudCoid = XCOID
    WHERE EecEEType <> 'TES'
        AND (EecEmplStatus IN ('A', 'L')  OR (EecEmplStatus = 'T' and EecTermreason <> 'TRO' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN @StartDate AND @EndDate))
       

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
ALTER VIEW dbo.dsi_vwEUNUMELEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMELEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMELEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202308011'
       ,expStartPerControl     = '202308011'
       ,expLastEndPerControl   = '202310049'
       ,expEndPerControl       = '202310049'
WHERE expFormatCode = 'EUNUMELEXP' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMELEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMELEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUNUMELEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUNUMELEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUNUMELEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMELEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUNUMELEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMELEXP', 'UseFileName', 'V', 'Y'


-- End ripout