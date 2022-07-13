/**********************************************************************************

EJCMHUNUM: UNUM FMLA STD LTD

FormatCode:     EJCMHUNUM
Project:        UNUM FMLA STD LTD
Client ID:      JEF1005
Date/time:      2022-07-12 18:41:05.167
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB01
Database:       ULTIPRO_WPJCMH
Web Filename:   JEF1005_BA926_EEHISTORY_EJCMHUNUM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EJCMHUNUM_SavePath') IS NOT NULL DROP TABLE dbo.U_EJCMHUNUM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EJCMHUNUM'


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
WHERE FormatCode = 'EJCMHUNUM'
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
WHERE ExpFormatCode = 'EJCMHUNUM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EJCMHUNUM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EJCMHUNUM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EJCMHUNUM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EJCMHUNUM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EJCMHUNUM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EJCMHUNUM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EJCMHUNUM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EJCMHUNUM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EJCMHUNUM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EJCMHUNUM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEJCMHUNUM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEJCMHUNUM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EJCMHUNUM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJCMHUNUM];
GO
IF OBJECT_ID('U_EJCMHUNUM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EJCMHUNUM_PEarHist];
GO
IF OBJECT_ID('U_EJCMHUNUM_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EJCMHUNUM_PDedHist];
GO
IF OBJECT_ID('U_EJCMHUNUM_File') IS NOT NULL DROP TABLE [dbo].[U_EJCMHUNUM_File];
GO
IF OBJECT_ID('U_EJCMHUNUM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EJCMHUNUM_EEList];
GO
IF OBJECT_ID('U_EJCMHUNUM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EJCMHUNUM_drvTbl];
GO
IF OBJECT_ID('U_EJCMHUNUM_DedList') IS NOT NULL DROP TABLE [dbo].[U_EJCMHUNUM_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EJCMHUNUM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EJCMHUNUM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EJCMHUNUM','UNUM FMLA STD LTD','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EJCMHUNUM0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EJCMHUNUM0Z0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EJCMHUNUM0Z0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EJCMHUNUM0Z0','50','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EJCMHUNUM0Z0','50','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EJCMHUNUM0Z0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EJCMHUNUM0Z0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EJCMHUNUM0Z0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EJCMHUNUM0Z0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EJCMHUNUM0Z0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EJCMHUNUM0Z0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EJCMHUNUM0Z0','50','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EJCMHUNUM0Z0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EJCMHUNUM0Z0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EJCMHUNUM0Z0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EJCMHUNUM0Z0','50','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL,'"EE_WRK_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EJCMHUNUM0Z0','50','H','01','16',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EJCMHUNUM0Z0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EJCMHUNUM0Z0','50','H','01','18',NULL,'MARITAL_STATUS',NULL,NULL,'"MARITAL_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EJCMHUNUM0Z0','50','H','01','19',NULL,'EE_JOB_TLE',NULL,NULL,'"EE_JOB_TLE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EJCMHUNUM0Z0','50','H','01','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EJCMHUNUM0Z0','50','H','01','21',NULL,'ORG_HIRE_DATE',NULL,NULL,'"ORG_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EJCMHUNUM0Z0','50','H','01','22',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EJCMHUNUM0Z0','50','H','01','23',NULL,'EE_STATUS',NULL,NULL,'"EE_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EJCMHUNUM0Z0','50','H','01','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL,'"WKLY_SCH_WRK_HRS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EJCMHUNUM0Z0','50','H','01','25',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EJCMHUNUM0Z0','50','H','01','26',NULL,'EE_HOME_PHONE',NULL,NULL,'"EE_HOME_PHONE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EJCMHUNUM0Z0','50','H','01','27',NULL,'MGR_FIRST_NAME',NULL,NULL,'"MGR_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EJCMHUNUM0Z0','50','H','01','28',NULL,'MGR_LAST_NAME',NULL,NULL,'"MGR_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EJCMHUNUM0Z0','50','H','01','29',NULL,'MGR_EMAIL',NULL,NULL,'"MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EJCMHUNUM0Z0','50','H','01','30',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL,'"HR_WRKED_IN_PST_12_MNTHS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EJCMHUNUM0Z0','50','H','01','31',NULL,'OFFCE_NAME',NULL,NULL,'"OFFCE_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EJCMHUNUM0Z0','50','H','01','32',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EJCMHUNUM0Z0','50','H','01','33',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EJCMHUNUM0Z0','50','H','01','34',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EJCMHUNUM0Z0','50','H','01','35',NULL,'EE_WRK_CITY',NULL,NULL,'"EE_WRK_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EJCMHUNUM0Z0','50','H','01','36',NULL,'EE_WRK_POSTAL_CD',NULL,NULL,'"EE_WRK_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EJCMHUNUM0Z0','50','H','01','37',NULL,'FMLA_RPTING_GRP',NULL,NULL,'"FMLA_RPTING_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EJCMHUNUM0Z0','50','H','01','38',NULL,'EE_SAL_MD',NULL,NULL,'"EE_SAL_MD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EJCMHUNUM0Z0','50','H','01','39',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EJCMHUNUM0Z0','50','H','01','40',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EJCMHUNUM0Z0','50','H','01','41',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EJCMHUNUM0Z0','50','H','01','42',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EJCMHUNUM0Z0','50','H','01','43',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EJCMHUNUM0Z0','50','H','01','44',NULL,'EARNINGS',NULL,NULL,'"EARNINGS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EJCMHUNUM0Z0','50','H','01','45',NULL,'EARNINGS_PRD',NULL,NULL,'"EARNINGS_PRD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EJCMHUNUM0Z0','50','H','01','46',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EJCMHUNUM0Z0','50','H','01','47',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EJCMHUNUM0Z0','50','H','01','48',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EJCMHUNUM0Z0','50','H','01','49',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EJCMHUNUM0Z0','50','H','01','50',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EJCMHUNUM0Z0','50','H','01','51',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EJCMHUNUM0Z0','50','H','01','52',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EJCMHUNUM0Z0','50','H','01','53',NULL,'EARNINGS',NULL,NULL,'"EARNINGS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EJCMHUNUM0Z0','50','H','01','54',NULL,'EARNINGS_PRD',NULL,NULL,'"EARNINGS_PRD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EJCMHUNUM0Z0','50','H','01','55',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EJCMHUNUM0Z0','50','H','01','56',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EJCMHUNUM0Z0','50','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"drvPartnerCaseID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EJCMHUNUM0Z0','50','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"drvServiceIndicator"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EJCMHUNUM0Z0','50','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvEESSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EJCMHUNUM0Z0','50','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvEmpno"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EJCMHUNUM0Z0','50','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"drvEEIDType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EJCMHUNUM0Z0','50','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EJCMHUNUM0Z0','50','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EJCMHUNUM0Z0','50','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EJCMHUNUM0Z0','50','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EJCMHUNUM0Z0','50','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EJCMHUNUM0Z0','50','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EJCMHUNUM0Z0','50','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvRdcStPvc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EJCMHUNUM0Z0','50','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvPostalCd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EJCMHUNUM0Z0','50','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"drvCntryCd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EJCMHUNUM0Z0','50','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL,'"drvWrkStPvc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EJCMHUNUM0Z0','50','D','10','16',NULL,'EE_DOB',NULL,NULL,'"drvEeDob"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EJCMHUNUM0Z0','50','D','10','17',NULL,'EE_GENDER',NULL,NULL,'"drvEeGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EJCMHUNUM0Z0','50','D','10','18',NULL,'MARITAL_STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EJCMHUNUM0Z0','50','D','10','19',NULL,'EE_JOB_TLE',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EJCMHUNUM0Z0','50','D','10','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvRcntHireDate"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EJCMHUNUM0Z0','50','D','10','21',NULL,'ORG_HIRE_DATE',NULL,NULL,'"drvOriginaHireDate"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EJCMHUNUM0Z0','50','D','10','22',NULL,'EE_TERM_DATE',NULL,NULL,'"drvTermDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EJCMHUNUM0Z0','50','D','10','23',NULL,'EE_STATUS',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EJCMHUNUM0Z0','50','D','10','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL,'"drvWklySchWrkHrs"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EJCMHUNUM0Z0','50','D','10','25',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"drvDateOfLstSlyChg"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EJCMHUNUM0Z0','50','D','10','26',NULL,'EE_HOME_PHONE',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EJCMHUNUM0Z0','50','D','10','27',NULL,'MGR_FIRST_NAME',NULL,NULL,'"drvMgrFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EJCMHUNUM0Z0','50','D','10','28',NULL,'MGR_LAST_NAME',NULL,NULL,'"drvMgrLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EJCMHUNUM0Z0','50','D','10','29',NULL,'MGR_EMAIL',NULL,NULL,'"drvMgrEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EJCMHUNUM0Z0','50','D','10','30',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL,'"drvHrWrkedInPst12_Mnths"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EJCMHUNUM0Z0','50','D','10','31',NULL,'OFFCE_NAME',NULL,NULL,'"drvOffceName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EJCMHUNUM0Z0','50','D','10','32',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL,'"drvWrkMailStAddr1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EJCMHUNUM0Z0','50','D','10','33',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL,'"drvWrkMailStAddr2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EJCMHUNUM0Z0','50','D','10','34',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL,'"drvWrkMailStAddr3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EJCMHUNUM0Z0','50','D','10','35',NULL,'EE_WRK_CITY',NULL,NULL,'"drvWrkCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EJCMHUNUM0Z0','50','D','10','36',NULL,'EE_WRK_POSTAL_CD',NULL,NULL,'"drvWrkPostalCd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EJCMHUNUM0Z0','50','D','10','37',NULL,'FMLA_RPTING_GRP',NULL,NULL,'"drvFMLARptingGrp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EJCMHUNUM0Z0','50','D','10','38',NULL,'EE_SAL_MD',NULL,NULL,'"drvSalMd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EJCMHUNUM0Z0','50','D','10','39',NULL,'PRODUCT',NULL,NULL,'"drvProduct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EJCMHUNUM0Z0','50','D','10','40',NULL,'POLICY_NBR',NULL,NULL,'"drvPolicyNbr1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EJCMHUNUM0Z0','50','D','10','41',NULL,'DIVISION',NULL,NULL,'"drvDivisionDivision1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EJCMHUNUM0Z0','50','D','10','42',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPolicyElgGrp1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EJCMHUNUM0Z0','50','D','10','43',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"drvPostTaxCntrbPct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EJCMHUNUM0Z0','50','D','10','44',NULL,'EARNINGS',NULL,NULL,'"drvEarnings1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EJCMHUNUM0Z0','50','D','10','45',NULL,'EARNINGS_PRD',NULL,NULL,'"drvEarningsPrd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EJCMHUNUM0Z0','50','D','10','46',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvDateOfEeCovg1"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EJCMHUNUM0Z0','50','D','10','47',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCovgTermDate1"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EJCMHUNUM0Z0','50','D','10','48',NULL,'PRODUCT',NULL,NULL,'"drvProduct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EJCMHUNUM0Z0','50','D','10','49',NULL,'POLICY_NBR',NULL,NULL,'"drvPolicyNbr2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EJCMHUNUM0Z0','50','D','10','50',NULL,'DIVISION',NULL,NULL,'"drvDivisionDivision2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EJCMHUNUM0Z0','50','D','10','51',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvElgGrp2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EJCMHUNUM0Z0','50','D','10','52',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"drvPosttaxCntrbPct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EJCMHUNUM0Z0','50','D','10','53',NULL,'EARNINGS',NULL,NULL,'"drvEarnings2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EJCMHUNUM0Z0','50','D','10','54',NULL,'EARNINGS_PRD',NULL,NULL,'"drvEarningsPrd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EJCMHUNUM0Z0','50','D','10','55',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvDateOfEeCovg2"','(''UD110''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EJCMHUNUM0Z0','50','D','10','56',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvTermDate2"','(''UD110''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EJCMHUNUM_20220712.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202206299','EMPEXPORT','OEACTIVE',NULL,'EJCMHUNUM',NULL,NULL,NULL,'202206299','Jun 29 2022 12:52PM','Jun 29 2022 12:52PM','202206291',NULL,'','','202206291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202206299','EMPEXPORT','OEPASSIVE',NULL,'EJCMHUNUM',NULL,NULL,NULL,'202206299','Jun 29 2022 12:52PM','Jun 29 2022 12:52PM','202206291',NULL,'','','202206291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM FMLA STD LTD','202206299','EMPEXPORT','ONDEM_XOE',NULL,'EJCMHUNUM',NULL,NULL,NULL,'202206299','Jun 29 2022 12:52PM','Jun 29 2022 12:52PM','202206291',NULL,'','','202206291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM FMLA STD LTD-Sched','202206299','EMPEXPORT','SCH_EJCMHU',NULL,'EJCMHUNUM',NULL,NULL,NULL,'202206299','Jun 29 2022 12:52PM','Jun 29 2022 12:52PM','202206291',NULL,'','','202206291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'UNUM FMLA STD LTD-Test','202207119','EMPEXPORT','TEST_XOE','Jul 11 2022 12:00AM','EJCMHUNUM',NULL,NULL,NULL,'202207119','Jul 11 2022 12:00AM','Dec 30 1899 12:00AM','202207041',NULL,'','','202207041',dbo.fn_GetTimedKey(),NULL,'us3kEpJEF1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJCMHUNUM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJCMHUNUM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJCMHUNUM','InitialSort','C','drvInitalSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJCMHUNUM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJCMHUNUM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJCMHUNUM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EJCMHUNUM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EJCMHUNUM','D10','dbo.U_EJCMHUNUM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EJCMHUNUM
-----------

IF OBJECT_ID('U_dsi_BDM_EJCMHUNUM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EJCMHUNUM] (
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
-- Create table U_EJCMHUNUM_DedList
-----------

IF OBJECT_ID('U_EJCMHUNUM_DedList') IS NULL
CREATE TABLE [dbo].[U_EJCMHUNUM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EJCMHUNUM_drvTbl
-----------

IF OBJECT_ID('U_EJCMHUNUM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EJCMHUNUM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitalSort] varchar(1) NOT NULL,
    [drvPartnerCaseID] varchar(10) NOT NULL,
    [drvServiceIndicator] varchar(3) NOT NULL,
    [drvEESSN] varchar(13) NULL,
    [drvEmpno] char(9) NULL,
    [drvEEIDType] varchar(4) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(255) NULL,
    [drvRdcStPvc] varchar(2) NULL,
    [drvPostalCd] varchar(5) NULL,
    [drvCntryCd] varchar(2) NULL,
    [drvWrkStPvc] varchar(255) NULL,
    [drvEeDob] datetime NULL,
    [drvEeGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(7) NOT NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvRcntHireDate] datetime NULL,
    [drvOriginaHireDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvStatus] varchar(3) NOT NULL,
    [drvWklySchWrkHrs] nvarchar(4000) NULL,
    [drvDateOfLstSlyChg] datetime NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvMgrFirstName] varchar(1) NOT NULL,
    [drvMgrLastName] varchar(1) NOT NULL,
    [drvMgrEmail] varchar(1) NOT NULL,
    [drvHrWrkedInPst12_Mnths] varchar(4) NOT NULL,
    [drvOffceName] varchar(1) NOT NULL,
    [drvWrkMailStAddr1] varchar(1) NOT NULL,
    [drvWrkMailStAddr2] varchar(1) NOT NULL,
    [drvWrkMailStAddr3] varchar(1) NOT NULL,
    [drvWrkCity] varchar(1) NOT NULL,
    [drvWrkPostalCd] varchar(1) NOT NULL,
    [drvFMLARptingGrp] varchar(3) NULL,
    [drvSalMd] char(1) NULL,
    [drvProduct1] varchar(2) NULL,
    [drvPolicyNbr1] varchar(6) NULL,
    [drvDivisionDivision1] varchar(3) NULL,
    [drvPolicyElgGrp1] varchar(1) NULL,
    [drvPostTaxCntrbPct1] varchar(1) NULL,
    [drvEarnings1] varchar(30) NULL,
    [drvEarningsPrd1] varchar(2) NULL,
    [drvDateOfEeCovg1] datetime NULL,
    [drvCovgTermDate1] datetime NULL,
    [drvProduct2] varchar(2) NULL,
    [drvPolicyNbr2] varchar(6) NULL,
    [drvDivisionDivision2] varchar(3) NULL,
    [drvElgGrp2] varchar(1) NULL,
    [drvPosttaxCntrbPct2] varchar(1) NULL,
    [drvEarnings2] varchar(30) NULL,
    [drvEarningsPrd2] varchar(2) NULL,
    [drvDateOfEeCovg2] datetime NULL,
    [drvTermDate2] datetime NULL
);

-----------
-- Create table U_EJCMHUNUM_EEList
-----------

IF OBJECT_ID('U_EJCMHUNUM_EEList') IS NULL
CREATE TABLE [dbo].[U_EJCMHUNUM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EJCMHUNUM_File
-----------

IF OBJECT_ID('U_EJCMHUNUM_File') IS NULL
CREATE TABLE [dbo].[U_EJCMHUNUM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EJCMHUNUM_PDedHist
-----------

IF OBJECT_ID('U_EJCMHUNUM_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EJCMHUNUM_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhERCurAmt] numeric NULL
);

-----------
-- Create table U_EJCMHUNUM_PEarHist
-----------

IF OBJECT_ID('U_EJCMHUNUM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EJCMHUNUM_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJCMHUNUM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Jefferson Center for Mental Health

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 06/29/2022
Service Request Number: TekP-2022-05-05-02

Purpose: UNUM FMLA STD LTD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EJCMHUNUM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EJCMHUNUM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EJCMHUNUM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EJCMHUNUM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EJCMHUNUM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJCMHUNUM', 'SCH_EJCMHU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EJCMHUNUM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EJCMHUNUM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EJCMHUNUM';

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
    --DELETE FROM dbo.U_EJCMHUNUM_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EJCMHUNUM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ZSTD,ZLTD';

    IF OBJECT_ID('U_EJCMHUNUM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EJCMHUNUM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EJCMHUNUM_DedList
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
  --  -- Working Table - PDedHist
  --  -----------------------------
  --  IF OBJECT_ID('U_EJCMHUNUM_PDedHist','U') IS NOT NULL
  --      DROP TABLE dbo.U_EJCMHUNUM_PDedHist;
  --SELECT DISTINCT
  --       PdhEEID
  --      -- Current Payroll Amounts
  --      --,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
  --      ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
  --      -- YTD Payroll Amounts
  --      --,PdhEECurAmtYTD = SUM(PdhEECurAmt)
  --      --,PdhERCurAmtYTD = SUM(PdhERCurAmt)
  --      -- Categorize Payroll Amounts
  --      --,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('ZLTD') THEN PdhEECurAmt ELSE 0.00 END)
  --      --,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ZSTD') THEN PdhEECurAmt ELSE 0.00 END)
  --      --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
  --      --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
  --      --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
  --      --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
  --      --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
  --      --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
  --      --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
  --      --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
  --  INTO dbo.U_EJCMHUNUM_PDedHist
  --  FROM dbo.PDedHist WITH (NOLOCK)
  --  JOIN dbo.U_EJCMHUNUM_DedList WITH (NOLOCK)
  --      ON DedCode = PdhDedCode
  --  WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
  --  AND PdhPerControl <= @EndPerControl
  --  AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
  --  GROUP BY PdhEEID
  --  HAVING (SUM(PdhEECurAmt) <> 0.00
  --      OR SUM(PdhERCurAmt) <> 0.00
  --  );


  --  -----------------------------
  --  -- Working Table - PEarHist
  --  -----------------------------
  --  IF OBJECT_ID('U_EJCMHUNUM_PEarHist','U') IS NOT NULL
  --      DROP TABLE dbo.U_EJCMHUNUM_PEarHist;
  --  SELECT DISTINCT
  --       PehEEID
  --      ,PehEarnCode
  --      ,PrgPayDate             = MAX(PrgPayDate)
  --      -- Current Payroll Amount/Hours
  --      ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
  --      --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
  --      -- YTD Payroll Amount/Hours
  --      ,PehCurAmtYTD           = SUM(PehCurAmt)
  --      --,PehCurHrsYTD           = SUM(PehCurHrs)
  --      -- Current Include Deferred Comp Amount/Hours
  --      --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
  --      --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
  --      ---- YTD Include Deferred Comp Amount/Hours
  --      --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
  --      --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
  --  INTO dbo.U_EJCMHUNUM_PEarHist
  --  FROM dbo.vw_int_PayReg WITH (NOLOCK)
  --  JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
  --      ON PehGenNumber = PrgGenNumber
  --  WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
  --  AND PehPerControl <= @EndPerControl 
  --  GROUP BY PehEEID, PehEarnCode
  --  HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EJCMHUNUM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EJCMHUNUM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EJCMHUNUM_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartnerCaseID = 'JEF-030723'
        ,drvServiceIndicator = 'ELG'
        ,drvEESSN = stuff(stuff(eepSSN,6,0,'-'),4,0,'-') 
        ,drvEmpno = EecEmpNo
        ,drvEEIDType = 'EEID'
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddress1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddress2 = REPLACE(EepAddressLine2, ',', '')
        ,drvCity = EepAddressCity
        ,drvRdcStPvc = LEFT(eepaddressstate,2)
        ,drvPostalCd = SUBSTRING (eepaddresszipcode , 1,5)
        ,drvCntryCd = LEFT(eepAddressCountry,2) -- Should be US employees on the file.
        ,drvWrkStPvc = LocAddressState --LocAddressState where LocCode = EecLocation
        ,drvEeDob = EepDateOfBirth
        ,drvEeGender = CASE WHEN EepGender not in ('M','F') THEN '' ELSE EepGender END 
        ,drvMaritalStatus = Case WHEN eepmaritalstatus = 'M' THEN 'Married'
                                 WHEN eepmaritalstatus = 'S' THEN 'Single' 
                                 ELSE 'UNK' 
                                END
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')  --JbcDesc where JbcCode = EecJobCode
        ,drvRcntHireDate = EecDateOfLastHire
        ,drvOriginaHireDate = Eecdateoforiginalhire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' and  EecDateOfTermination = '1/1/1900' then '' 
                            WHEN EecEmplStatus = 'T' and  EecDateOfTermination <> '1/1/1900' THEN  EecDateOfTermination END 
        ,drvStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA' else  'ACT' END
        ,drvWklySchWrkHrs = FORMAT((EecScheduledWorkHrs)/2, '#0') 
        ,drvDateOfLstSlyChg = dbo.dsi_fnGetMinMaxDates('MAX', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), EecDateOfLastHire) ---max of most recent dsi_fnlib_GetAnnSalary_EffDate_WithStartDate or eecdateoflasthire
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvMgrFirstName = ''
        ,drvMgrLastName = ''
        ,drvMgrEmail = ''
        ,drvHrWrkedInPst12_Mnths = '1250'
        ,drvOffceName = ''
        ,drvWrkMailStAddr1 = ''
        ,drvWrkMailStAddr2 = ''
        ,drvWrkMailStAddr3 = ''
        ,drvWrkCity = ''
        ,drvWrkPostalCd = ''
        ,drvFMLARptingGrp = CASE WHEN D.STD IS NOT NULL THEN '100' END
        ,drvSalMd = EecSalaryOrHourly
        ,drvProduct1 = CASE WHEN D.STD IS NOT NULL THEN '31' END
        ,drvPolicyNbr1 = CASE WHEN D.STD IS NOT NULL THEN '715009' END
        ,drvDivisionDivision1 = CASE WHEN D.STD IS NOT NULL THEN '100' END
        ,drvPolicyElgGrp1 = CASE WHEN D.STD IS NOT NULL THEN '1' END
        ,drvPostTaxCntrbPct1 = CASE WHEN D.STD IS NOT NULL THEN '0' END
        ,drvEarnings1 = CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN  
                                CASE WHEN D.STD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), EecAnnSalary / 52) AS VARCHAR) END 
                            WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN
                                CASE WHEN D.STD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), ((EecAnnSalary) / 52)) AS VARCHAR) END
                            END
                            --eecdateoflasthire date is prior to current year then if eeddedcode= ZSTD send sum(pehcuramt) where pehearncode in (BONUS,BONSP, BONSR, COMM, HOL, BONSL, OT, PTO, REG, REGE, RETRO, SICK, COV19) for all per controls in prior calendar year divided by 52
                            --if eecdateoflasthire date is in the current year then if eeddedcode = ZSTD send eecannsalary plus EECUDFIELD09 plus EECUDFIELD10  divided by 52
        ,drvEarningsPrd1 = CASE WHEN D.STD IS NOT NULL THEN 'WK' END
        ,drvDateOfEeCovg1 = CASE WHEN D.STD IS NOT NULL THEN D.STD_BenStartDate END ----eeddedcode = ZSTD send eedbenstartdate - default to 8/1/2022 or later
        ,drvCovgTermDate1 = CASE WHEN D.STD IS NOT NULL THEN D.STD_BenStopDate END
        ,drvProduct2 = CASE WHEN D.LTD IS NOT NULL THEN '38' END
        ,drvPolicyNbr2 = CASE WHEN D.LTD IS NOT NULL THEN '715009' END
        ,drvDivisionDivision2 = CASE WHEN LTD IS NOT NULL THEN '100' END
        ,drvElgGrp2 = CASE WHEN D.LTD IS NOT NULL THEN '1' END
        ,drvPosttaxCntrbPct2 = CASE WHEN D.LTD IS NOT NULL THEN '0' END
        ,drvEarnings2 =   CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN
                                CASE WHEN D.LTD IS NOT NULL  THEN  CAST(CONVERT(DECIMAL(10,2), ((EecAnnSalary) / 12)) AS VARCHAR) END
                            WHEN YEAR(EecDateOFLastHire) = YEAR(GETDATE()) THEN 
                                CASE WHEN D.LTD IS NOT NULL  THEN CAST(CONVERT(DECIMAL(10,2), ((EecAnnSalary) / 12)) AS VARCHAR) END
                            END
        -- if eecdateoflasthire date is prior to current year then
        -- if eeddedcode = ZLTD send sum(pehcuramt) where pehearncode in (BONUS,BONSP, BONSR, COMM, HOL, BONSL, OT, PTO, REG, REGE, RETRO, SICK, COV19) for all per controls in prior calendar year divided by 12
        -- if eecdateoflasthire date is in the current year then if eeddedcode = ZLTD send eecannsalary plus EECUDFIELD09 plus EECUDFIELD10  divided by 12
        ,drvEarningsPrd2 = CASE WHEN D.LTD IS NOT NULL THEN  'MO' END
        ,drvDateOfEeCovg2 = CASE WHEN D.LTD IS NOT NULL THEN  D.LTD_BenStartDate END --eeddedcode = ZLTD send eedbenstartdate - default to 8/1/2022 or later
        ,drvTermDate2 = CASE WHEN D.LTD IS NOT NULL THEN  D.LTD_BenStopDate END
    INTO dbo.U_EJCMHUNUM_drvTbl
   FROM dbo.U_EJCMHUNUM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EJCMHUNUM WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Location as Loc
        on Loc.LocCode =  EecLocation
    JOIN (SELECT EedEEID, EedCOID, MAX(CASE WHEN EedDedCode = 'ZLTD' THEN 'LTD' END) AS LTD,
                    MAX(CASE WHEN EedDedCode = 'ZSTD' THEN 'STD' END) AS STD,
                    MAX(CASE WHEN EedDedCode = 'ZLTD' THEN EedBenStartDate END) AS LTD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'ZLTD' THEN EedBenStopDate END) AS LTD_BenStopDate,
                    MAX(CASE WHEN EedDedCode = 'ZSTD' THEN EedBenStartDate END) AS STD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'ZSTD' THEN EedBenStopDate END) AS STD_BenStopDate
            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
            WHERE EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID
            ) D ON D.EedEEID = xEEID AND D.EedCOID = xCOID
    -- LEFT JOIN (SELECT PehEEID, PehEarnCode, sum(PehCurAmt)PehCurAmt, sum(PehCurAmtYTD) PehCurAmtYTD
    --            FROM dbo.U_EJCMHUNUM_PEarHist WITH(NOLOCK)
    --            --WHERE pehearncode in ('BONUS','BONSP', 'BONSR', 'COMM', 'HOL', 'BONSL', 'OT', 'PTO', 'REG', 
    --            --                       'REGE', 'RETRO', 'SICK', 'COV19')
                -- Group BY PehEEID, PehEarnCode
                --                       ) Peh ON Peh.PehEEID = xEEID
     WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and EecDateOfTermination BETWEEN @StartDate AND @EndDate)

   
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
ALTER VIEW dbo.dsi_vwEJCMHUNUM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EJCMHUNUM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EJCMHUNUM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206221'
       ,expStartPerControl     = '202206221'
       ,expLastEndPerControl   = '202206299'
       ,expEndPerControl       = '202206299'
WHERE expFormatCode = 'EJCMHUNUM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEJCMHUNUM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EJCMHUNUM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EJCMHUNUM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EJCMHUNUM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EJCMHUNUM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EJCMHUNUM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EJCMHUNUM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EJCMHUNUM', 'UseFileName', 'V', 'Y'


-- End ripout