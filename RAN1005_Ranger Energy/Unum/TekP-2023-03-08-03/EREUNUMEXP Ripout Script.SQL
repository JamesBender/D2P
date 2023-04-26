/**********************************************************************************

EREUNUMEXP: Unum Accident_Critical Illness_Hospital

FormatCode:     EREUNUMEXP
Project:        Unum Accident_Critical Illness_Hospital
Client ID:      RAN1005
Date/time:      2023-04-26 10:03:12.060
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB03
Database:       ULTIPRO_WPRENS
Web Filename:   RAN1005_0E2IH_EEHISTORY_EREUNUMEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EREUNUMEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EREUNUMEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EREUNUMEXP'


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
WHERE FormatCode = 'EREUNUMEXP'
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
WHERE ExpFormatCode = 'EREUNUMEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EREUNUMEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EREUNUMEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EREUNUMEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EREUNUMEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EREUNUMEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EREUNUMEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EREUNUMEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EREUNUMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EREUNUMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EREUNUMEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEREUNUMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEREUNUMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EREUNUMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREUNUMEXP];
GO
IF OBJECT_ID('U_EREUNUMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EREUNUMEXP_File];
GO
IF OBJECT_ID('U_EREUNUMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EREUNUMEXP_EEList];
GO
IF OBJECT_ID('U_EREUNUMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EREUNUMEXP_drvTbl];
GO
IF OBJECT_ID('U_EREUNUMEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EREUNUMEXP_DedList];
GO
IF OBJECT_ID('U_EREUNUMEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EREUNUMEXP_AuditFields];
GO
IF OBJECT_ID('U_EREUNUMEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EREUNUMEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EREUNUMEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EREUNUMEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EREUNUMEXP','Unum Accident_Critical Illness_Hospital','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EREUNUMEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREUNUMEXPZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREUNUMEXPZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREUNUMEXPZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREUNUMEXPZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREUNUMEXPZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREUNUMEXPZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREUNUMEXPZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREUNUMEXPZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREUNUMEXPZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREUNUMEXPZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREUNUMEXPZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREUNUMEXPZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREUNUMEXPZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREUNUMEXPZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREUNUMEXPZ0','50','H','01','15',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREUNUMEXPZ0','50','H','01','16',NULL,'SP_DOB',NULL,NULL,'"SP_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EREUNUMEXPZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EREUNUMEXPZ0','50','H','01','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'"EE_TOBACCO_USE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EREUNUMEXPZ0','50','H','01','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EREUNUMEXPZ0','50','H','01','20',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EREUNUMEXPZ0','50','H','01','21',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EREUNUMEXPZ0','50','H','01','22',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EREUNUMEXPZ0','50','H','01','23',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EREUNUMEXPZ0','50','H','01','24',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EREUNUMEXPZ0','50','H','01','25',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EREUNUMEXPZ0','50','H','01','26',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EREUNUMEXPZ0','50','H','01','27',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EREUNUMEXPZ0','50','H','01','28',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EREUNUMEXPZ0','50','H','01','29',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EREUNUMEXPZ0','50','H','01','30',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EREUNUMEXPZ0','50','H','01','31',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EREUNUMEXPZ0','50','H','01','32',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EREUNUMEXPZ0','50','H','01','33',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EREUNUMEXPZ0','50','H','01','34',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EREUNUMEXPZ0','50','H','01','35',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EREUNUMEXPZ0','50','H','01','36',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EREUNUMEXPZ0','50','H','01','37',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EREUNUMEXPZ0','50','H','01','38',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EREUNUMEXPZ0','50','H','01','39',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EREUNUMEXPZ0','50','H','01','40',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EREUNUMEXPZ0','50','H','01','41',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EREUNUMEXPZ0','50','H','01','42',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EREUNUMEXPZ0','50','H','01','43',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EREUNUMEXPZ0','50','H','01','44',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EREUNUMEXPZ0','50','H','01','45',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EREUNUMEXPZ0','50','H','01','46',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EREUNUMEXPZ0','50','H','01','47',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EREUNUMEXPZ0','50','H','01','48',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EREUNUMEXPZ0','50','H','01','49',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EREUNUMEXPZ0','50','H','01','50',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EREUNUMEXPZ0','51','H','01','51',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EREUNUMEXPZ0','52','H','01','52',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EREUNUMEXPZ0','53','H','01','53',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EREUNUMEXPZ0','54','H','01','54',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EREUNUMEXPZ0','55','H','01','55',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EREUNUMEXPZ0','56','H','01','56',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EREUNUMEXPZ0','57','H','01','57',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EREUNUMEXPZ0','58','H','01','58',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EREUNUMEXPZ0','59','H','01','59',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EREUNUMEXPZ0','10','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"drvPARTNERCASEID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EREUNUMEXPZ0','10','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"drvSERVICEINDICATOR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EREUNUMEXPZ0','11','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvEESSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EREUNUMEXPZ0','20','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvEE_ID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EREUNUMEXPZ0','5','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"drvEEIDTYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EREUNUMEXPZ0','15','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvEEFIRSTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EREUNUMEXPZ0','1','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"drvEEMIDDLEINITIAL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EREUNUMEXPZ0','25','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvEELASTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EREUNUMEXPZ0','40','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvEESTADDR1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EREUNUMEXPZ0','40','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvEESTADDR2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EREUNUMEXPZ0','30','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvEECITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EREUNUMEXPZ0','2','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvEERDCSTPVC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EREUNUMEXPZ0','11','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvEEPOSTALCD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EREUNUMEXPZ0','2','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"drvEECNTRYCD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EREUNUMEXPZ0','10','D','10','15',NULL,'EE_DOB',NULL,NULL,'"drvEEDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EREUNUMEXPZ0','10','D','10','16',NULL,'SP_DOB',NULL,NULL,'"drvSPDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EREUNUMEXPZ0','3','D','10','17',NULL,'EE_GENDER',NULL,NULL,'"drvEEGENDER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EREUNUMEXPZ0','1','D','10','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'"drvEETOBACCOUSE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EREUNUMEXPZ0','10','D','10','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvMOSTRCNTHIREDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EREUNUMEXPZ0','10','D','10','20',NULL,'EE_TERM_DATE',NULL,NULL,'"drvEETERMDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EREUNUMEXPZ0','4','D','10','21',NULL,'PRODUCT',NULL,NULL,'"drvPRODUCT1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EREUNUMEXPZ0','6','D','10','22',NULL,'POLICY_NBR',NULL,NULL,'"drvPOLICYNBR1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EREUNUMEXPZ0','3','D','10','23',NULL,'DIVISION',NULL,NULL,'"drvDIVISION1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EREUNUMEXPZ0','3','D','10','24',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPOLICYELGGRP1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EREUNUMEXPZ0','2','D','10','25',NULL,'CHOICE',NULL,NULL,'"drvCHOICE1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EREUNUMEXPZ0','10','D','10','26',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEFFDATEOFEECOVG1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EREUNUMEXPZ0','10','D','10','27',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCOVGTERMDATE1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EREUNUMEXPZ0','10','D','10','28',NULL,'EE_BEN_AMT',NULL,NULL,'"drvEEBENAMT1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EREUNUMEXPZ0','1','D','10','29',NULL,'CI_SP_IND',NULL,NULL,'"drvCISPIND1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EREUNUMEXPZ0','10','D','10','30',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvEFFDATEOFSPCOVG1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EREUNUMEXPZ0','10','D','10','31',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSPCOVGTERMDATE1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EREUNUMEXPZ0','10','D','10','32',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvEFFDATEOFCHCOVG1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EREUNUMEXPZ0','10','D','10','33',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvCHCOVGTERMDATE1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EREUNUMEXPZ0','4','D','10','34',NULL,'PRODUCT',NULL,NULL,'"drvPRODUCT2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EREUNUMEXPZ0','6','D','10','35',NULL,'POLICY_NBR',NULL,NULL,'"drvPOLICYNBR2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EREUNUMEXPZ0','3','D','10','36',NULL,'DIVISION',NULL,NULL,'"drvDIVISION2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EREUNUMEXPZ0','3','D','10','37',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPOLICYELGGRP2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EREUNUMEXPZ0','2','D','10','38',NULL,'CHOICE',NULL,NULL,'"drvCHOICE2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EREUNUMEXPZ0','10','D','10','39',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEFFDATEOFEECOVG2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EREUNUMEXPZ0','10','D','10','40',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCOVGTERMDATE2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EREUNUMEXPZ0','10','D','10','41',NULL,'EE_BEN_AMT',NULL,NULL,'"drvEEBENAMT2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EREUNUMEXPZ0','1','D','10','42',NULL,'CI_SP_IND',NULL,NULL,'"drvCISPIND2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EREUNUMEXPZ0','10','D','10','43',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvEFFDATEOFSPCOVG2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EREUNUMEXPZ0','10','D','10','44',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSPCOVGTERMDATE2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EREUNUMEXPZ0','10','D','10','45',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvEFFDATEOFCHCOVG2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EREUNUMEXPZ0','10','D','10','46',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvCHCOVGTERMDATE2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EREUNUMEXPZ0','4','D','10','47',NULL,'PRODUCT',NULL,NULL,'"drvPRODUCT3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EREUNUMEXPZ0','6','D','10','48',NULL,'POLICY_NBR',NULL,NULL,'"drvPOLICYNBR3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EREUNUMEXPZ0','3','D','10','49',NULL,'DIVISION',NULL,NULL,'"drvDIVISION3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EREUNUMEXPZ0','3','D','10','50',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPOLICYELGGRP3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EREUNUMEXPZ0','2','D','10','51',NULL,'CHOICE',NULL,NULL,'"drvCHOICE3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EREUNUMEXPZ0','10','D','10','52',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEFFDATEOFEECOVG3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EREUNUMEXPZ0','10','D','10','53',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCOVGTERMDATE3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EREUNUMEXPZ0','10','D','10','54',NULL,'EE_BEN_AMT',NULL,NULL,'"drvEEBENAMT3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EREUNUMEXPZ0','1','D','10','55',NULL,'CI_SP_IND',NULL,NULL,'"drvCISPIND3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EREUNUMEXPZ0','10','D','10','56',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvEFFDATEOFSPCOVG3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EREUNUMEXPZ0','10','D','10','57',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSPCOVGTERMDATE3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EREUNUMEXPZ0','10','D','10','58',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvEFFDATEOFCHCOVG3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EREUNUMEXPZ0','10','D','10','59',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvCHCOVGTERMDATE3"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EREUNUMEXP_20230426.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202304269','EMPEXPORT','OEACTIVE',NULL,'EREUNUMEXP',NULL,NULL,NULL,'202304269','Apr 26 2023  6:41AM','Apr 26 2023  6:41AM','202304261',NULL,'','','202304261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202304269','EMPEXPORT','OEPASSIVE',NULL,'EREUNUMEXP',NULL,NULL,NULL,'202304269','Apr 26 2023  6:41AM','Apr 26 2023  6:41AM','202304261',NULL,'','','202304261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Accident_Critical Illness','202304269','EMPEXPORT','ONDEM_XOE',NULL,'EREUNUMEXP',NULL,NULL,NULL,'202304269','Apr 26 2023  6:41AM','Apr 26 2023  6:41AM','202304261',NULL,'','','202304261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Accident_Critical I-Sched','202304269','EMPEXPORT','SCH_EREUNU',NULL,'EREUNUMEXP',NULL,NULL,NULL,'202304269','Apr 26 2023  6:41AM','Apr 26 2023  6:41AM','202304261',NULL,'','','202304261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Unum Accident_Critical I-Test','202304269','EMPEXPORT','TEST_XOE',NULL,'EREUNUMEXP',NULL,NULL,NULL,'202304269','Apr 26 2023  6:41AM','Apr 26 2023  6:41AM','202304261',NULL,'','','202304261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EREUNUMEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREUNUMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EREUNUMEXP','D10','dbo.U_EREUNUMEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EREUNUMEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EREUNUMEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EREUNUMEXP] (
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
-- Create table U_EREUNUMEXP_Audit
-----------

IF OBJECT_ID('U_EREUNUMEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EREUNUMEXP_Audit] (
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
-- Create table U_EREUNUMEXP_AuditFields
-----------

IF OBJECT_ID('U_EREUNUMEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EREUNUMEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EREUNUMEXP_DedList
-----------

IF OBJECT_ID('U_EREUNUMEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EREUNUMEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EREUNUMEXP_drvTbl
-----------

IF OBJECT_ID('U_EREUNUMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EREUNUMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPARTNERCASEID] varchar(10) NOT NULL,
    [drvSERVICEINDICATOR] varchar(3) NOT NULL,
    [drvEESSN] char(11) NULL,
    [drvEE_ID] char(9) NULL,
    [drvEEIDTYPE] varchar(4) NOT NULL,
    [drvEEFIRSTNAME] varchar(100) NULL,
    [drvEEMIDDLEINITIAL] varchar(1) NULL,
    [drvEELASTNAME] varchar(100) NULL,
    [drvEESTADDR1] varchar(8000) NULL,
    [drvEESTADDR2] varchar(8000) NULL,
    [drvEECITY] varchar(8000) NULL,
    [drvEERDCSTPVC] varchar(2) NULL,
    [drvEEPOSTALCD] varchar(50) NULL,
    [drvEECNTRYCD] varchar(2) NULL,
    [drvEEDOB] varchar(8000) NULL,
    [drvSPDOB] varchar(8000) NULL,
    [drvEEGENDER] char(1) NULL,
    [drvEETOBACCOUSE] varchar(1) NOT NULL,
    [drvMOSTRCNTHIREDATE] varchar(8000) NULL,
    [drvEETERMDATE] varchar(8000) NULL,
    [drvPRODUCT1] varchar(3) NULL,
    [drvPOLICYNBR1] varchar(6) NULL,
    [drvDIVISION1] varchar(1) NULL,
    [drvPOLICYELGGRP1] varchar(1) NULL,
    [drvCHOICE1] varchar(1) NULL,
    [drvEFFDATEOFEECOVG1] varchar(8000) NULL,
    [drvCOVGTERMDATE1] varchar(8000) NULL,
    [drvEEBENAMT1] varchar(8000) NULL,
    [drvCISPIND1] varchar(1) NULL,
    [drvEFFDATEOFSPCOVG1] varchar(8000) NULL,
    [drvSPCOVGTERMDATE1] varchar(8000) NULL,
    [drvEFFDATEOFCHCOVG1] varchar(1) NOT NULL,
    [drvCHCOVGTERMDATE1] varchar(1) NOT NULL,
    [drvPRODUCT2] varchar(3) NULL,
    [drvPOLICYNBR2] varchar(6) NULL,
    [drvDIVISION2] varchar(1) NULL,
    [drvPOLICYELGGRP2] varchar(1) NULL,
    [drvCHOICE2] varchar(1) NULL,
    [drvEFFDATEOFEECOVG2] varchar(1) NOT NULL,
    [drvCOVGTERMDATE2] varchar(8000) NULL,
    [drvEEBENAMT2] varchar(1) NOT NULL,
    [drvCISPIND2] varchar(1) NOT NULL,
    [drvEFFDATEOFSPCOVG2] varchar(8000) NULL,
    [drvSPCOVGTERMDATE2] varchar(8000) NULL,
    [drvEFFDATEOFCHCOVG2] varchar(8000) NULL,
    [drvCHCOVGTERMDATE2] varchar(8000) NULL,
    [drvPRODUCT3] varchar(3) NULL,
    [drvPOLICYNBR3] varchar(6) NULL,
    [drvDIVISION3] varchar(1) NULL,
    [drvPOLICYELGGRP3] varchar(1) NULL,
    [drvCHOICE3] varchar(1) NULL,
    [drvEFFDATEOFEECOVG3] varchar(8000) NULL,
    [drvCOVGTERMDATE3] varchar(8000) NULL,
    [drvEEBENAMT3] varchar(1) NOT NULL,
    [drvCISPIND3] varchar(1) NOT NULL,
    [drvEFFDATEOFSPCOVG3] varchar(8000) NULL,
    [drvSPCOVGTERMDATE3] varchar(8000) NULL,
    [drvEFFDATEOFCHCOVG3] varchar(8000) NULL,
    [drvCHCOVGTERMDATE3] varchar(8000) NULL
);

-----------
-- Create table U_EREUNUMEXP_EEList
-----------

IF OBJECT_ID('U_EREUNUMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EREUNUMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EREUNUMEXP_File
-----------

IF OBJECT_ID('U_EREUNUMEXP_File') IS NULL
CREATE TABLE [dbo].[U_EREUNUMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EREUNUMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ranger Energy

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 04/26/2023
Service Request Number: TekP-2023-03-08-03

Purpose: Unum Accident_Critical Illness_Hospital

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EREUNUMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EREUNUMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EREUNUMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EREUNUMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EREUNUMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREUNUMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREUNUMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREUNUMEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREUNUMEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EREUNUMEXP', 'SCH_EREUNU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EREUNUMEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EREUNUMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EREUNUMEXP';

    -- Declare dates from Parameter file
   SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EREUNUMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EREUNUMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EREUNUMEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EREUNUMEXP_AuditFields;
    CREATE TABLE dbo.U_EREUNUMEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EREUNUMEXP_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EREUNUMEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EREUNUMEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EREUNUMEXP_Audit;
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
    INTO dbo.U_EREUNUMEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EREUNUMEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EREUNUMEXP_Audit ON dbo.U_EREUNUMEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EREUNUMEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EREUNUMEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CILL,CILLS,ACC1,ACC2,HI';

    IF OBJECT_ID('U_EREUNUMEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EREUNUMEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EREUNUMEXP_DedList
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EREUNUMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EREUNUMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EREUNUMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPARTNERCASEID = 'RAN-029397'
        ,drvSERVICEINDICATOR = 'ELG'
        ,drvEESSN = eepSSN
        ,drvEE_ID = eecempno
        ,drvEEIDTYPE = 'EEID'
        ,drvEEFIRSTNAME = EepNameFirst
        ,drvEEMIDDLEINITIAL = LEFT(EepNameMiddle,1)
        ,drvEELASTNAME = EepNameLast
        ,drvEESTADDR1 = Replace(eepaddressline1, ',','')
        ,drvEESTADDR2 = Replace(eepaddressline2, ',','')
        ,drvEECITY = Replace(EepAddressCity, ',','')
        ,drvEERDCSTPVC = LEFT(eepaddressstate,2)
        ,drvEEPOSTALCD = eepaddresszipcode
        ,drvEECNTRYCD = LEFT(eepAddressCountry,2)
        ,drvEEDOB = REPLACE(CONVERT (CHAR(10), EepDateOfBirth, 101),'/','')
        ,drvSPDOB =  CASE WHEN CIBdmDedCode  is not null  and sp.ConDateOfBirth Is not null  THEN REPLACE(CONVERT (CHAR(10), Sp.ConDateOfBirth, 101),'/','')END
        ,drvEEGENDER = CASE WHEN EepGender IN ('M', 'F') THEN EepGender END
        ,drvEETOBACCOUSE = ''
        ,drvMOSTRCNTHIREDATE = REPLACE(CONVERT (CHAR(10), EecDateOfLastHire, 101),'/','')
        ,drvEETERMDATE = CASE WHEN EecEmplStatus = 'T' THEN REPLACE(CONVERT (CHAR(10), EecDateOfTermination, 101),'/','') END
         ,drvPRODUCT1 = CASE WHEN  CIBdmDedCode   is not null THEN '822' END
        ,drvPOLICYNBR1 = CASE WHEN CIBdmDedCode  is not null THEN '704712' END
        ,drvDIVISION1 = CASE WHEN  CIBdmDedCode  is not null  THEN '1' END
        ,drvPOLICYELGGRP1 = CASE WHEN CIBdmDedCode  is not null THEN '1'END
        ,drvCHOICE1 =  CASE WHEN CIBdmDedCode  is not null and REPLACE(CIBdmBenAmt, '.00','') = 10000 THEN '1'
                            WHEN CIBdmDedCode  is not null and REPLACE(CIBdmBenAmt, '.00','') = 20000 THEN '2'
                            WHEN CIBdmDedCode  is not null and REPLACE(CIBdmBenAmt, '.00','') = 30000 THEN '3'
                        END
        ,drvEFFDATEOFEECOVG1 =  CASE WHEN CIBdmDedCode  IS NOT NULL THEN  REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',CIBdmBenStartDate, @FileMinCovDate), 101),'/','')  END
        ,drvCOVGTERMDATE1 = CASE WHEN CIBdmDedCode  IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),CIBdmBenStopDate, 101),'/','')  END
        ,drvEEBENAMT1 = CASE WHEN CIBdmDedCode  IS NOT NULL and format(CIBdmBenAmt, '0.00')  > '0.00' THEN REPLACE(CIBdmBenAmt, '.00','') END
        ,drvCISPIND1 = CASE WHEN CIBdmDedCode  IS NOT NULL  AND  sp.ConDateOfBirth is not null   THEN 'Y'  END --ELSE 'N'
        ,drvEFFDATEOFSPCOVG1 = CASE WHEN  CIBdmDedCode  IS NOT NULL  AND  sp.ConDateOfBirth is not null   THEN REPLACE(CONVERT (CHAR(10),CIBdmBenStartDate, 101),'/','')  END 
        ,drvSPCOVGTERMDATE1 = CASE WHEN  CIBdmDedCode  IS NOT NULL AND sp.ConDateOfBirth is not null THEN REPLACE(CONVERT (CHAR(10),CIBdmBenStopDate, 101),'/','')  END 
        ,drvEFFDATEOFCHCOVG1 = ''
        ,drvCHCOVGTERMDATE1 = ''
        ,drvPRODUCT2 = CASE WHEN  AccBdmDedCode  is not null THEN '824' END
        ,drvPOLICYNBR2 = CASE WHEN AccBdmDedCode  is not null THEN '704711' END
        ,drvDIVISION2 = CASE WHEN  AccBdmDedCode  is not null THEN '1' END 
        ,drvPOLICYELGGRP2 = CASE WHEN  AccBdmDedCode  is not null THEN '1' END 
        ,drvCHOICE2 = CASE WHEN  AccBdmDedCode  IN ('ACC1') THEN '1'
                           WHEN  AccBdmDedCode  IN ('ACC2') THEN '2' 
                          END
        ,drvEFFDATEOFEECOVG2 =''-- CASE WHEN  AccBdmDedCode  is not null THEN REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',AccBdmBenStartDate, @FileMinCovDate), 101),'/','')  END
        ,drvCOVGTERMDATE2 = CASE WHEN  AccBdmDedCode  is not null THEN REPLACE(CONVERT (CHAR(10),AccBdmBenStopDate, 101),'/','')  END
        ,drvEEBENAMT2 = ''
        ,drvCISPIND2 = ''
        ,drvEFFDATEOFSPCOVG2 = CASE WHEN AccBdmDedCode  is not null AND sp2.ConDateOfBirth is not null  THEN REPLACE(CONVERT (CHAR(10),AccBdmBenStartDate, 101),'/','')  END 
        ,drvSPCOVGTERMDATE2 = CASE WHEN AccBdmDedCode  is not null  AND  sp2.ConDateOfBirth is not null THEN REPLACE(CONVERT (CHAR(10),AccBdmBenStopDate, 101),'/','')  END 
        ,drvEFFDATEOFCHCOVG2 = CASE WHEN AccBdmDedCode  is not null AND Child.ConEEID IS NOT NULL THEN REPLACE(CONVERT (CHAR(10), AccBdmBenStartDate, 101),'/','')  END
        ,drvCHCOVGTERMDATE2 = CASE WHEN AccBdmDedCode  is not null  AND Child.ConEEID IS NOT NULL  THEN REPLACE(CONVERT (CHAR(10), AccBdmBenStopDate, 101),'/','')  END
        ,drvPRODUCT3 = CASE WHEN HospBdmDedCode is not null  THEN '825' END
        ,drvPOLICYNBR3 = CASE WHEN HospBdmDedCode is not null  THEN '704713' END
        ,drvDIVISION3 = CASE WHEN HospBdmDedCode is not null  THEN  '1' END
        ,drvPOLICYELGGRP3 = CASE WHEN  HospBdmDedCode is not null  THEN  '1' END
        ,drvCHOICE3 = CASE WHEN   HospBdmDedCode  IN ('HOS1') THEN '1'
                           WHEN   HospBdmDedCode IN ('HOS2') THEN '2' 
                          END
        ,drvEFFDATEOFEECOVG3 = CASE WHEN  HospBdmDedCode is not null THEN REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',HospBdmBenStartDate, @FileMinCovDate), 101),'/','')  END
        ,drvCOVGTERMDATE3 = CASE WHEN   HospBdmDedCode is not null THEN REPLACE(CONVERT (CHAR(10),HospBdmBenStopDate, 101),'/','')  END
        ,drvEEBENAMT3 = ''
        ,drvCISPIND3 = ''
        ,drvEFFDATEOFSPCOVG3 = CASE WHEN HospBdmDedCode is not null  AND  sp3.ConDateOfBirth is not null  THEN REPLACE(CONVERT (CHAR(10),HospBdmBenStartDate, 101),'/','')  END 
        ,drvSPCOVGTERMDATE3 = CASE WHEN HospBdmDedCode is not null  AND   sp3.ConDateOfBirth is not null THEN REPLACE(CONVERT (CHAR(10),HospBdmBenStopDate, 101),'/','')  END
        ,drvEFFDATEOFCHCOVG3 = CASE WHEN HospBdmDedCode is not null AND Child.ConEEID IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),HospBdmBenStartDate, 101),'/','') END
        ,drvCHCOVGTERMDATE3 = CASE WHEN HospBdmDedCode is not null AND Child.ConEEID IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),HospBdmBenStopDate, 101),'/','')  END
    INTO dbo.U_EREUNUMEXP_drvTbl
    FROM dbo.U_EREUNUMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        JOIN (
            SELECT Distinct  BdmEEID, BdmCOID               
                ,MAX(CASE WHEN bdmDedCode IN ('CILL', 'CILLS') THEN bdmDedCode END) AS CIBdmDedCode 
                ,MAX(CASE WHEN bdmDedCode IN ('CILL', 'CILLS') THEN BdmBenStartDate END ) AS  CIBdmBenStartDate
                ,MAX(CASE WHEN bdmDedCode IN ('CILL', 'CILLS') THEN BdmBenStopDate END ) AS CIBdmBenStopDate
                ,MAX(CASE WHEN bdmDedCode IN ('CILL', 'CILLS') and ISNULL(BcaEEBenAmt,0) > 0.00  THEN BcaEEBenAmt END ) AS CIBdmBenAmt
                ,MAX(CASE WHEN bdmDedCode IN ('CILL', 'CILLS') THEN bdmDepRecID END) AS CIBDepRecID
                ,MAX(CASE WHEN bdmDedCode IN ('ACC1','ACC2')THEN bdmDedCode END) AS AccBdmDedCode 
                ,MAX(CASE WHEN bdmDedCode IN ('ACC1','ACC2')THEN bdmDepRecID END) AS AccDepRecID 
                ,MAX(CASE WHEN bdmDedCode IN ('ACC1','ACC2')THEN BdmBenStartDate END) AccBdmBenStartDate
                ,MAX(CASE WHEN bdmDedCode IN ('ACC1','ACC2')THEN BdmBenStopDate END) AccBdmBenStopDate
                ,MAX(CASE WHEN bdmDedCode IN ('HI')THEN bdmDedCode END) AS HospBdmDedCode 
                ,MAX(CASE WHEN bdmDedCode IN ('HI')THEN bdmDepRecID END) AS HospDepRecID
                ,MAX(CASE WHEN bdmDedCode IN ('HI')THEN BdmBenStartDate  END) AS HospBdmBenStartDate
                ,MAX(CASE WHEN bdmDedCode IN ('HI')THEN BdmBenStopDate  END) AS HospBdmBenStopDate
            
        
        
            FROM dbo.U_dsi_BDM_EREUNUMEXP WITH (NOLOCK)
             JOIN dbo.EmpDedFull WITH (NOLOCK)
                ON BdmEEID = EedEEID
                AND EedDedCode = BdmDedCode
            LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH(NOLOCK)
            ON BcaEEID = EedEEID
            and BcaCoID = EedCoID
            and BcaDedCode = bdmdedcode
                Where eedbenstatus in ('A', 'T')   
            GROUP BY BdmEEID, BdmCOID
        ) Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.contacts SP WITH (NOLOCK)
        ON Sp.ConEEID = xEEID
        AND Sp.ConSystemID = CIBDepRecID     
       AND Sp.ConRelationship IN ('SPS','SPO','DP')
     LEFT JOIN dbo.contacts SP2 WITH (NOLOCK)
        ON Sp2.ConEEID = xEEID
        AND Sp2.ConSystemID = AccDepRecID     
        AND Sp2.ConRelationship IN ('SPS','SPO','DP')
        LEFT JOIN dbo.contacts SP3 WITH (NOLOCK)
        ON Sp3.ConEEID = xEEID
        AND Sp3.ConSystemID = HospDepRecID     
        AND Sp3.ConRelationship IN ('SPS', 'DOM')
     LEFT JOIN dbo.Contacts CHILD WITH (NOLOCK)
        ON CHILD.ConEEID = xEEID
        AND CHILD.ConRelationship IN ('CHL','STC','DCH','DPC')
        AND CHILD.ConIsDependent = 'Y'
   LEFT JOIN dbo.U_EREUNUMEXP_Audit WITH (NOLOCK) 
       ON audeeid = xEEID
    WHERE EecEEType <> 'TES' and LEFT(eepAddressCountry,2) = 'US'
        and (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecTermReason <> 'TRO' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
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
ALTER VIEW dbo.dsi_vwEREUNUMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EREUNUMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EREUNUMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304191'
       ,expStartPerControl     = '202304191'
       ,expLastEndPerControl   = '202304269'
       ,expEndPerControl       = '202304269'
WHERE expFormatCode = 'EREUNUMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEREUNUMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EREUNUMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EREUNUMEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EREUNUMEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EREUNUMEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREUNUMEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EREUNUMEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EREUNUMEXP', 'UseFileName', 'V', 'Y'


-- End ripout