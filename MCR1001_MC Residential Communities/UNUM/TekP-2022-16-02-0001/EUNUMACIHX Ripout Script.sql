/**********************************************************************************

EUNUMACIHX: UNUM Accident, Critical Ilness, Hospital Export

FormatCode:     EUNUMACIHX
Project:        UNUM Accident, Critical Ilness, Hospital Export
Client ID:      MCR1001
Date/time:      2022-03-30 10:16:56.157
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP1DB03
Database:       ULTIPRO_WPMCRES
Web Filename:   MCR1001_Q9T5Q_EEHISTORY_EUNUMACIHX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUNUMACIHX_SavePath') IS NOT NULL DROP TABLE dbo.U_EUNUMACIHX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUNUMACIHX'


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
WHERE FormatCode = 'EUNUMACIHX'
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
WHERE ExpFormatCode = 'EUNUMACIHX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUNUMACIHX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUNUMACIHX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUNUMACIHX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUNUMACIHX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUNUMACIHX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUNUMACIHX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUNUMACIHX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUNUMACIHX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUNUMACIHX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUNUMACIHX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUNUMACIHX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMACIHX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMACIHX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMACIHX];
GO
IF OBJECT_ID('U_EUNUMACIHX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMACIHX_PEarHist];
GO
IF OBJECT_ID('U_EUNUMACIHX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMACIHX_PDedHist];
GO
IF OBJECT_ID('U_EUNUMACIHX_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMACIHX_File];
GO
IF OBJECT_ID('U_EUNUMACIHX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMACIHX_EEList];
GO
IF OBJECT_ID('U_EUNUMACIHX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMACIHX_drvTbl];
GO
IF OBJECT_ID('U_EUNUMACIHX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMACIHX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMACIHX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMACIHX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMACIHX','UNUM Accident, Critical Ilness, Hospital Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EUNUMACIHXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMACIHXZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMACIHXZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMACIHXZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMACIHXZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMACIHXZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMACIHXZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMACIHXZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMACIHXZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMACIHXZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMACIHXZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMACIHXZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMACIHXZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMACIHXZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMACIHXZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMACIHXZ0','50','H','01','15',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMACIHXZ0','50','H','01','16',NULL,'SP_DOB',NULL,NULL,'"SP_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMACIHXZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMACIHXZ0','50','H','01','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'"EE_TOBACCO_USE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMACIHXZ0','50','H','01','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMACIHXZ0','50','H','01','20',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMACIHXZ0','50','H','01','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMACIHXZ0','50','H','01','22',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMACIHXZ0','50','H','01','23',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMACIHXZ0','50','H','01','24',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMACIHXZ0','50','H','01','25',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMACIHXZ0','50','H','01','26',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMACIHXZ0','50','H','01','27',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMACIHXZ0','50','H','01','28',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMACIHXZ0','50','H','01','29',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMACIHXZ0','50','H','01','30',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMACIHXZ0','50','H','01','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMACIHXZ0','50','H','01','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMACIHXZ0','50','H','01','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMACIHXZ0','50','H','01','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMACIHXZ0','50','H','01','35',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMACIHXZ0','50','H','01','36',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMACIHXZ0','50','H','01','37',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMACIHXZ0','50','H','01','38',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMACIHXZ0','50','H','01','39',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMACIHXZ0','50','H','01','40',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMACIHXZ0','50','H','01','41',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMACIHXZ0','50','H','01','42',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMACIHXZ0','50','H','01','43',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMACIHXZ0','50','H','01','44',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMACIHXZ0','50','H','01','45',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMACIHXZ0','50','H','01','46',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMACIHXZ0','50','H','01','47',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMACIHXZ0','50','H','01','48',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMACIHXZ0','50','H','01','49',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMACIHXZ0','50','H','01','50',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMACIHXZ0','50','H','01','51',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMACIHXZ0','50','H','01','52',NULL,'CHOICE',NULL,NULL,'"CHOICE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMACIHXZ0','50','H','01','53',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMACIHXZ0','50','H','01','54',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMACIHXZ0','50','H','01','55',NULL,'EE_BEN_AMT',NULL,NULL,'"EE_BEN_AMT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMACIHXZ0','50','H','01','56',NULL,'CI_SP_IND',NULL,NULL,'"CI_SP_IND"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMACIHXZ0','50','H','01','57',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"EFF_DATE_OF_SP_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMACIHXZ0','50','H','01','58',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"SP_COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMACIHXZ0','50','H','01','59',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"EFF_DATE_OF_CH_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMACIHXZ0','50','H','01','60',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"CH_COVG_TERM_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMACIHXZ0','50','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"MCR-027426"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMACIHXZ0','50','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"ELG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMACIHXZ0','50','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMACIHXZ0','50','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvEmployeeId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMACIHXZ0','50','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EEID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMACIHXZ0','50','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMACIHXZ0','50','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMACIHXZ0','50','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMACIHXZ0','50','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMACIHXZ0','50','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMACIHXZ0','50','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMACIHXZ0','50','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMACIHXZ0','50','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMACIHXZ0','50','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMACIHXZ0','50','D','10','15',NULL,'EE_DOB',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMACIHXZ0','50','D','10','16',NULL,'SP_DOB',NULL,NULL,'"drvSpouseDateOfBirth"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMACIHXZ0','50','D','10','17',NULL,'EE_GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMACIHXZ0','50','D','10','18',NULL,'EE_TOBACCO_USE',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMACIHXZ0','50','D','10','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvMostRecentDateOfHire"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMACIHXZ0','50','D','10','20',NULL,'EE_TERM_DATE',NULL,NULL,'"drvEETerminationDate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMACIHXZ0','50','D','10','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"drvDateOfLastSalaryChange"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMACIHXZ0','50','D','10','22',NULL,'PRODUCT',NULL,NULL,'"drvProduct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMACIHXZ0','50','D','10','23',NULL,'POLICY_NBR',NULL,NULL,'"drvPolicyNumber1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMACIHXZ0','50','D','10','24',NULL,'DIVISION',NULL,NULL,'"drvDivision1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMACIHXZ0','50','D','10','25',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolicyEligbilityGroup1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMACIHXZ0','50','D','10','26',NULL,'CHOICE',NULL,NULL,'"drvChoice1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMACIHXZ0','50','D','10','27',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEffectiveDateOfEECoverage1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMACIHXZ0','50','D','10','28',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCoverageTerminationDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMACIHXZ0','50','D','10','29',NULL,'EE_BEN_AMT',NULL,NULL,'"drvEEBenefitAmount1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMACIHXZ0','50','D','10','30',NULL,'CI_SP_IND',NULL,NULL,'"drvCiSpInd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMACIHXZ0','50','D','10','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvSpouseEffectiveDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMACIHXZ0','50','D','10','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSpouseCoverageTermDate1"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMACIHXZ0','50','D','10','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMACIHXZ0','50','D','10','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMACIHXZ0','50','D','10','35',NULL,'PRODUCT',NULL,NULL,'"drvProduct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMACIHXZ0','50','D','10','36',NULL,'POLICY_NBR',NULL,NULL,'"drvPolicyNumber2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMACIHXZ0','50','D','10','37',NULL,'DIVISION',NULL,NULL,'"drvDivision2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMACIHXZ0','50','D','10','38',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolicyEligbilityGroup2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMACIHXZ0','50','D','10','39',NULL,'CHOICE',NULL,NULL,'"drvChoice2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMACIHXZ0','50','D','10','40',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEffectiveDateOfEECoverage2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMACIHXZ0','50','D','10','41',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCoverageTerminationDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMACIHXZ0','50','D','10','42',NULL,'EE_BEN_AMT',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMACIHXZ0','50','D','10','43',NULL,'CI_SP_IND',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMACIHXZ0','50','D','10','44',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvSpouseEffectiveDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMACIHXZ0','50','D','10','45',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSpouseCoverageTermDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMACIHXZ0','50','D','10','46',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvChildEffeciveDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMACIHXZ0','50','D','10','47',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvChildTerminationDate2"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMACIHXZ0','50','D','10','48',NULL,'PRODUCT',NULL,NULL,'"drvProduct3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMACIHXZ0','50','D','10','49',NULL,'POLICY_NBR',NULL,NULL,'"drvPolicyNumber3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMACIHXZ0','50','D','10','50',NULL,'DIVISION',NULL,NULL,'"drvDivision3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMACIHXZ0','50','D','10','51',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolicyEligbilityGroup3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMACIHXZ0','50','D','10','52',NULL,'CHOICE',NULL,NULL,'"drvChoice3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMACIHXZ0','50','D','10','53',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEffectiveDateOfEECoverage3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMACIHXZ0','50','D','10','54',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCoverageTerminationDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMACIHXZ0','50','D','10','55',NULL,'EE_BEN_AMT',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMACIHXZ0','50','D','10','56',NULL,'CI_SP_IND',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMACIHXZ0','50','D','10','57',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL,'"drvSpouseEffectiveDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMACIHXZ0','50','D','10','58',NULL,'SP_COVG_TERM_DATE',NULL,NULL,'"drvSpouseTerminationDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMACIHXZ0','50','D','10','59',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL,'"drvChildEffeciveDate3"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMACIHXZ0','50','D','10','60',NULL,'CH_COVG_TERM_DATE',NULL,NULL,'"drvChildTerminationDate3"','(''UDMDY''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUNUMACIHX_20220330.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202203259','EMPEXPORT','OEACTIVE',NULL,'EUNUMACIHX',NULL,NULL,NULL,'202203259','Mar 25 2022 12:38PM','Mar 25 2022 12:38PM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202203259','EMPEXPORT','OEPASSIVE',NULL,'EUNUMACIHX',NULL,NULL,NULL,'202203259','Mar 25 2022 12:38PM','Mar 25 2022 12:38PM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Acc, Crit Il, Hosp Export','202203259','EMPEXPORT','ONDEM_XOE',NULL,'EUNUMACIHX',NULL,NULL,NULL,'202203259','Mar 25 2022 12:38PM','Mar 25 2022 12:38PM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Acc, Crit Il, Hosp -Sched','202203259','EMPEXPORT','SCH_EUNUMA',NULL,'EUNUMACIHX',NULL,NULL,NULL,'202203259','Mar 25 2022 12:38PM','Mar 25 2022 12:38PM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'UNUM Acc, Crit Il, Hosp -Test','202203259','EMPEXPORT','TEST_XOE',NULL,'EUNUMACIHX',NULL,NULL,NULL,'202203259','Mar 25 2022 12:38PM','Mar 25 2022 12:38PM','202203251',NULL,'','','202203251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMACIHX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMACIHX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMACIHX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMACIHX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMACIHX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMACIHX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMACIHX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMACIHX','D10','dbo.U_EUNUMACIHX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUNUMACIHX
-----------

IF OBJECT_ID('U_dsi_BDM_EUNUMACIHX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMACIHX] (
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
-- Create table U_EUNUMACIHX_DedList
-----------

IF OBJECT_ID('U_EUNUMACIHX_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMACIHX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUNUMACIHX_drvTbl
-----------

IF OBJECT_ID('U_EUNUMACIHX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMACIHX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMostRecentDateOfHire] datetime NULL,
    [drvEETerminationDate] datetime NULL,
    [drvDateOfLastSalaryChange] datetime NULL,
    [drvProduct1] varchar(3) NULL,
    [drvPolicyNumber1] varchar(6) NULL,
    [drvDivision1] varchar(1) NOT NULL,
    [drvPolicyEligbilityGroup1] varchar(1) NULL,
    [drvChoice1] varchar(1) NULL,
    [drvEffectiveDateOfEECoverage1] datetime NULL,
    [drvCoverageTerminationDate1] datetime NULL,
    [drvEEBenefitAmount1] nvarchar(4000) NULL,
    [drvCiSpInd1] varchar(1) NULL,
    [drvSpouseEffectiveDate1] datetime NULL,
    [drvSpouseCoverageTermDate1] datetime NULL,
    [drvProduct2] varchar(3) NULL,
    [drvPolicyNumber2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyEligbilityGroup2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvEffectiveDateOfEECoverage2] datetime NULL,
    [drvCoverageTerminationDate2] datetime NULL,
    [drvSpouseEffectiveDate2] datetime NULL,
    [drvSpouseCoverageTermDate2] datetime NULL,
    [drvChildEffeciveDate2] datetime NULL,
    [drvChildTerminationDate2] datetime NULL,
    [drvProduct3] varchar(3) NULL,
    [drvPolicyNumber3] varchar(6) NULL,
    [drvDivision3] varchar(1) NULL,
    [drvPolicyEligbilityGroup3] varchar(1) NULL,
    [drvChoice3] varchar(1) NULL,
    [drvEffectiveDateOfEECoverage3] datetime NULL,
    [drvCoverageTerminationDate3] datetime NULL,
    [drvSpouseEffectiveDate3] datetime NULL,
    [drvSpouseTerminationDate3] datetime NULL,
    [drvChildEffeciveDate3] datetime NULL,
    [drvChildTerminationDate3] datetime NULL
);

-----------
-- Create table U_EUNUMACIHX_EEList
-----------

IF OBJECT_ID('U_EUNUMACIHX_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMACIHX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUNUMACIHX_File
-----------

IF OBJECT_ID('U_EUNUMACIHX_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMACIHX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EUNUMACIHX_PDedHist
-----------

IF OBJECT_ID('U_EUNUMACIHX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMACIHX_PDedHist] (
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
-- Create table U_EUNUMACIHX_PEarHist
-----------

IF OBJECT_ID('U_EUNUMACIHX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMACIHX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMACIHX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MC Residential

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/25/2022
Service Request Number: TekP20-22-16-02-0001

Purpose: UNUM Accident, Critical Ilness, Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMACIHX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMACIHX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMACIHX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMACIHX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMACIHX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMACIHX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMACIHX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMACIHX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMACIHX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMACIHX', 'SCH_EUNUMA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMACIHX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUNUMACIHX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMACIHX';

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
    DELETE FROM dbo.U_EUNUMACIHX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMACIHX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'VAI,VCC,VCIE,VCIS,VHI';

    IF OBJECT_ID('U_EUNUMACIHX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMACIHX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMACIHX_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUNUMACIHX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMACIHX_PDedHist;
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
    INTO dbo.U_EUNUMACIHX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUNUMACIHX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EUNUMACIHX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMACIHX_PEarHist;
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
    INTO dbo.U_EUNUMACIHX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMACIHX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMACIHX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMACIHX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSpouseDateOfBirth = VCISSpouse.ConDateOfBirth
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvMostRecentDateOfHire = EecDateOfLastHire
        ,drvEETerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateOfLastSalaryChange = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvProduct1 = CASE WHEN VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL THEN '822' END
        ,drvPolicyNumber1 = CASE WHEN VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL THEN '480696' END
        ,drvDivision1 = ''
        ,drvPolicyEligbilityGroup1 = CASE WHEN VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL THEN '2' END        
        ,drvChoice1 =    CASE WHEN (VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL) AND Prod1BenAmt = 10000 THEN '1'
                        WHEN (VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL) AND Prod1BenAmt = 20000 THEN '2'
                        END
        ,drvEffectiveDateOfEECoverage1 = CASE WHEN VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL THEN Prod1BenStartDate END
        ,drvCoverageTerminationDate1 = CASE WHEN VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL THEN Prod1BenStopDate END
        ,drvEEBenefitAmount1 = CASE WHEN VCCDedCode IS NOT NULL OR VCIEDedCode IS NOT NULL OR VCISDedCode IS NOT NULL THEN FORMAT(Prod1BenAmt, '#0.00') END
        ,drvCiSpInd1 = CASE WHEN VCISSpouse.ConDateOfBirth IS NOT NULL THEN 'Y' END
        ,drvSpouseEffectiveDate1 = CASE WHEN VCISSpouse.ConDateOfBirth IS NOT NULL THEN Prod1BenStartDate END
        ,drvSpouseCoverageTermDate1 = CASE WHEN VCISSpouse.ConDateOfBirth IS NOT NULL THEN Prod1BenStopDate END
        ,drvProduct2 = CASE WHEN VAIDedCode IS NOT NULL THEN '824' END
        ,drvPolicyNumber2 = CASE WHEN VAIDedCode IS NOT NULL THEN '480695' END
        ,drvDivision2 = CASE WHEN VAIDedCode IS NOT NULL THEN '1' END
        ,drvPolicyEligbilityGroup2 = CASE WHEN VAIDedCode IS NOT NULL THEN '2' END
        ,drvChoice2 = CASE WHEN VAIDedCode IS NOT NULL THEN '1' END
        ,drvEffectiveDateOfEECoverage2 =  CASE WHEN VAIDedCode IS NOT NULL THEN Prod2BenStartDate END
        ,drvCoverageTerminationDate2 = CASE WHEN VAIDedCode IS NOT NULL THEN Prod2BenStopDate END
        ,drvSpouseEffectiveDate2 = CASE WHEN VAIDedCode IS NOT NULL AND VAISpouse.ConDateOfBirth IS NOT NULL THEN Prod2BenStartDate END
        ,drvSpouseCoverageTermDate2 = CASE WHEN VAIDedCode IS NOT NULL AND VAISpouse.ConDateOfBirth IS NOT NULL THEN Prod2BenStopDate END
        ,drvChildEffeciveDate2 = CASE WHEN VAIDedCode IS NOT NULL AND Child.ConEEID IS NOT NULL THEN Prod2BenStartDate END
        ,drvChildTerminationDate2 = CASE WHEN VAIDedCode IS NOT NULL AND Child.ConEEID IS NOT NULL THEN Prod2BenStopDate END
        ,drvProduct3 = CASE WHEN VHIDedCode IS NOT NULL THEN '825' END
        ,drvPolicyNumber3 = CASE WHEN VHIDedCode IS NOT NULL THEN '480697' END
        ,drvDivision3 = CASE WHEN VHIDedCode IS NOT NULL THEN '1' END
        ,drvPolicyEligbilityGroup3 = CASE WHEN VHIDedCode IS NOT NULL THEN '2' END
        ,drvChoice3 = CASE WHEN VHIDedCode IS NOT NULL THEN '1' END
        ,drvEffectiveDateOfEECoverage3 = CASE WHEN VHIDedCode IS NOT NULL THEN Prod3BenStartDate END
        ,drvCoverageTerminationDate3 = CASE WHEN VHIDedCode IS NOT NULL THEN Prod3BenStopDate END
        ,drvSpouseEffectiveDate3 = CASE WHEN VHIDedCode IS NOT NULL AND VHISpouse.ConDateOfBirth IS NOT NULL THEN Prod3BenStartDate END
        ,drvSpouseTerminationDate3 = CASE WHEN VHIDedCode IS NOT NULL AND VHISpouse.ConDateOfBirth IS NOT NULL THEN Prod3BenStopDate END
        ,drvChildEffeciveDate3 = CASE WHEN VHIDedCode IS NOT NULL AND Child.ConEEID IS NOT NULL THEN Prod3BenStartDate END
        ,drvChildTerminationDate3 = CASE WHEN VHIDedCode IS NOT NULL AND Child.ConEEID IS NOT NULL THEN Prod3BenStopDate END
    INTO dbo.U_EUNUMACIHX_drvTbl
    FROM dbo.U_EUNUMACIHX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EUNUMACIHX WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecID
                ,MAX(CASE WHEN BdmDedCode = 'VAI' THEN BdmDedCode END) AS VAIDedCode
                ,MAX(CASE WHEN BdmDedCode = 'VAI' THEN EedDepRecID END) AS VAIConSystemId
                ,MAX(CASE WHEN BdmDedCode = 'VCC' THEN BdmDedCode END) AS VCCDedCode
                ,MAX(CASE WHEN BdmDedCode = 'VCC' THEN EedBenAmt END) AS VCCBenAmt
                ,MAX(CASE WHEN BdmDedCode = 'VCIE' THEN BdmDedCode END) AS VCIEDedCode
                ,MAX(CASE WHEN BdmDedCode = 'VCIE' THEN EedBenAmt END) AS VCIEBenAmt
                ,MAX(CASE WHEN BdmDedCode = 'VCIS' THEN BdmDedCode END) AS VCISDedCode
                ,MAX(CASE WHEN BdmDedCode = 'VCIS' THEN EedDepRecID     END) AS VCISConSystemId
                ,MAX(CASE WHEN BdmDedCode = 'VCIS' THEN EedBenAmt END) AS VCISBenAmt
                ,MAX(CASE WHEN BdmDedCode = 'VHI' THEN BdmDedCode END) AS VHIDedCode
                ,MAX(CASE WHEN BdmDedCode = 'VHI' THEN EedDepRecID     END) AS VHIConSystemId
                ,MAX(CASE WHEN BdmDedCode IN ('VCC','VCIE','VCIS') THEN EedBenAmt END) AS Prod1BenAmt
                ,MAX(CASE WHEN BdmDedCode IN ('VCC','VCIE','VCIS') THEN BdmBenStartDate END) AS Prod1BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('VAI') THEN BdmBenStartDate END) AS Prod2BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('VHI') THEN BdmBenStartDate END) AS Prod3BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('VCC','VCIE','VCIS') THEN BdmBenStopDate END) AS Prod1BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('VAI') THEN BdmBenStopDate END) AS Prod2BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('VHI') THEN BdmBenStopDate END) AS Prod3BenStopDate
            FROM dbo.U_dsi_BDM_EUNUMACIHX WITH (NOLOCK)
            LEFT JOIN dbo.EmpDed WITH (NOLOCK)
                ON BdmEEID = EedEEID
                AND EedDedCode = BdmDedCode
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts VCISSpouse WITH (NOLOCK)
        ON VCISSpouse.ConEEID = xEEID
        AND VCISSpouse.ConSystemID = VCISConSystemId
    LEFT JOIN dbo.Contacts VAISpouse WITH (NOLOCK)
        ON VAISpouse.ConEEID = xEEID
        AND VAISpouse.ConSystemID = VAIConSystemId
    LEFT JOIN dbo.Contacts VHISpouse WITH (NOLOCK)
        ON VHISpouse.ConEEID = xEEID
        AND VHISpouse.ConSystemID = VHIConSystemId
    LEFT JOIN dbo.Contacts CHILD WITH (NOLOCK)
        ON CHILD.ConEEID = xEEID
        AND CHILD.ConRelationship IN ('CHL','COG','DPC','STC')
        AND CHILD.ConIsDependent = 'Y'
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
ALTER VIEW dbo.dsi_vwEUNUMACIHX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMACIHX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMACIHX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202203181'
       ,expStartPerControl     = '202203181'
       ,expLastEndPerControl   = '202203259'
       ,expEndPerControl       = '202203259'
WHERE expFormatCode = 'EUNUMACIHX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMACIHX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMACIHX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUNUMACIHX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUNUMACIHX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUNUMACIHX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMACIHX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUNUMACIHX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMACIHX', 'UseFileName', 'V', 'Y'


-- End ripout