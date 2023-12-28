/**********************************************************************************

ETANUNUMEX: Tanger Properties UNUM Export

FormatCode:     ETANUNUMEX
Project:        Tanger Properties UNUM Export
Client ID:      USG1000
Date/time:      2023-12-28 07:48:51.210
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_LUIGI
Web Filename:   USG1000_79690_EEHISTORY_ETANUNUMEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETANUNUMEX_SavePath') IS NOT NULL DROP TABLE dbo.U_ETANUNUMEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETANUNUMEX'


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
WHERE FormatCode = 'ETANUNUMEX'
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
WHERE ExpFormatCode = 'ETANUNUMEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETANUNUMEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETANUNUMEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETANUNUMEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETANUNUMEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETANUNUMEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETANUNUMEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETANUNUMEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETANUNUMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETANUNUMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETANUNUMEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETANUNUMEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETANUNUMEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETANUNUMEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETANUNUMEX];
GO
IF OBJECT_ID('U_ETANUNUMEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_PEarHist];
GO
IF OBJECT_ID('U_ETANUNUMEX_File') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_File];
GO
IF OBJECT_ID('U_ETANUNUMEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_EEList];
GO
IF OBJECT_ID('U_ETANUNUMEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_drvTbl];
GO
IF OBJECT_ID('U_ETANUNUMEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_DedList];
GO
IF OBJECT_ID('U_ETANUNUMEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_AuditFields];
GO
IF OBJECT_ID('U_ETANUNUMEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETANUNUMEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETANUNUMEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETANUNUMEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETANUNUMEX','Tanger Properties UNUM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','18000','S','N','ETANUNUMEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETANUNUMEXZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETANUNUMEXZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETANUNUMEXZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETANUNUMEXZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETANUNUMEXZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETANUNUMEXZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETANUNUMEXZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETANUNUMEXZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETANUNUMEXZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETANUNUMEXZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETANUNUMEXZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETANUNUMEXZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETANUNUMEXZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETANUNUMEXZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETANUNUMEXZ0','50','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL,'"EE_WRK_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETANUNUMEXZ0','50','H','01','16',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETANUNUMEXZ0','50','H','01','17',NULL,'SP_DOB',NULL,NULL,'"SP_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETANUNUMEXZ0','50','H','01','18',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETANUNUMEXZ0','50','H','01','19',NULL,'EE_TOBACCO_USE',NULL,NULL,'"EE_TOBACCO_USE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETANUNUMEXZ0','50','H','01','20',NULL,'MARITAL_STATUS',NULL,NULL,'"MARITAL_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETANUNUMEXZ0','50','H','01','21',NULL,'EE_JOB_TLE',NULL,NULL,'"EE_JOB_TLE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETANUNUMEXZ0','50','H','01','22',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ETANUNUMEXZ0','50','H','01','23',NULL,'ORG_HIRE_DATE',NULL,NULL,'"ORG_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ETANUNUMEXZ0','50','H','01','24',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ETANUNUMEXZ0','50','H','01','25',NULL,'EE_STATUS',NULL,NULL,'"EE_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ETANUNUMEXZ0','50','H','01','26',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL,'"WKLY_SCH_WRK_HRS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ETANUNUMEXZ0','50','H','01','27',NULL,'ACCOM_RSTCT',NULL,NULL,'"ACCOM_RSTCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ETANUNUMEXZ0','50','H','01','28',NULL,'SICK_PAY_HRS',NULL,NULL,'"SICK_PAY_HRS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ETANUNUMEXZ0','50','H','01','29',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ETANUNUMEXZ0','50','H','01','30',NULL,'EE_HOME_PHONE',NULL,NULL,'"EE_HOME_PHONE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ETANUNUMEXZ0','50','H','01','31',NULL,'MGR_FIRST_NAME',NULL,NULL,'"MGR_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ETANUNUMEXZ0','50','H','01','32',NULL,'MGR_LAST_NAME',NULL,NULL,'"MGR_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ETANUNUMEXZ0','50','H','01','33',NULL,'MGR_EMAIL',NULL,NULL,'"MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ETANUNUMEXZ0','50','H','01','34',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL,'"EE_SCND_MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ETANUNUMEXZ0','50','H','01','35',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL,'"EE_THRD_MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ETANUNUMEXZ0','50','H','01','36',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL,'"HR_WRKED_IN_PST_12_MNTHS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ETANUNUMEXZ0','50','H','01','37',NULL,'OFFCE_NAME',NULL,NULL,'"OFFCE_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ETANUNUMEXZ0','50','H','01','38',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ETANUNUMEXZ0','50','H','01','39',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ETANUNUMEXZ0','50','H','01','40',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ETANUNUMEXZ0','50','H','01','41',NULL,'EE_WRK_CITY',NULL,NULL,'"EE_WRK_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ETANUNUMEXZ0','50','H','01','42',NULL,'EE_WRK_POSTAL_CD',NULL,NULL,'"EE_WRK_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ETANUNUMEXZ0','50','H','01','43',NULL,'FMLA_RPTING_GRP',NULL,NULL,'"FMLA_RPTING_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ETANUNUMEXZ0','50','H','01','44',NULL,'KEY_EE',NULL,NULL,'"KEY_EE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ETANUNUMEXZ0','50','H','01','45',NULL,'EE_SAL_MD',NULL,NULL,'"EE_SAL_MD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ETANUNUMEXZ0','50','H','01','46',NULL,'PRODUCT_1',NULL,NULL,'"PRODUCT_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ETANUNUMEXZ0','50','H','01','47',NULL,'POLICY_NBR_1',NULL,NULL,'"POLICY_NBR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ETANUNUMEXZ0','50','H','01','48',NULL,'DIVISION_1',NULL,NULL,'"DIVISION_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ETANUNUMEXZ0','50','H','01','49',NULL,'POLICY_ELG_GRP_1',NULL,NULL,'"POLICY_ELG_GRP_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ETANUNUMEXZ0','50','H','01','50',NULL,'CHOICE_1',NULL,NULL,'"CHOICE_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ETANUNUMEXZ0','51','H','01','51',NULL,'EE_POSTTAX_CNTRB_PCT_1',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ETANUNUMEXZ0','52','H','01','52',NULL,'EARNINGS_1',NULL,NULL,'"EARNINGS_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ETANUNUMEXZ0','53','H','01','53',NULL,'EARNINGS_PRD_1',NULL,NULL,'"EARNINGS_PRD_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ETANUNUMEXZ0','54','H','01','54',NULL,'EFF_DATE_OF_EE_COVG_1',NULL,NULL,'"EFF_DATE_OF_EE_COVG_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ETANUNUMEXZ0','55','H','01','55',NULL,'COVG_TERM_DATE_1',NULL,NULL,'"COVG_TERM_DATE_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ETANUNUMEXZ0','56','H','01','56',NULL,'EE_BEN_AMT_1',NULL,NULL,'"EE_BEN_AMT_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ETANUNUMEXZ0','57','H','01','57',NULL,'EFF_DATE_OF_SP_COVG_1',NULL,NULL,'"EFF_DATE_OF_SP_COVG_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ETANUNUMEXZ0','58','H','01','58',NULL,'SP_COVG_TERM_DATE_1',NULL,NULL,'"SP_COVG_TERM_DATE_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ETANUNUMEXZ0','59','H','01','59',NULL,'EFF_DATE_OF_CH_COVG_1',NULL,NULL,'"EFF_DATE_OF_CH_COVG_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ETANUNUMEXZ0','60','H','01','60',NULL,'CH_COVG_TERM_DATE_1',NULL,NULL,'"CH_COVG_TERM_DATE_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ETANUNUMEXZ0','61','H','01','61',NULL,'CI_SP_IND_1',NULL,NULL,'"CI_SP_IND_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ETANUNUMEXZ0','62','H','01','62',NULL,'PRODUCT_2',NULL,NULL,'"PRODUCT_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ETANUNUMEXZ0','63','H','01','63',NULL,'POLICY_NBR_2',NULL,NULL,'"POLICY_NBR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ETANUNUMEXZ0','64','H','01','64',NULL,'DIVISION_2',NULL,NULL,'"DIVISION_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ETANUNUMEXZ0','65','H','01','65',NULL,'POLICY_ELG_GRP_2',NULL,NULL,'"POLICY_ELG_GRP_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ETANUNUMEXZ0','66','H','01','66',NULL,'CHOICE_2',NULL,NULL,'"CHOICE_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ETANUNUMEXZ0','67','H','01','67',NULL,'EE_POSTTAX_CNTRB_PCT_2',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ETANUNUMEXZ0','68','H','01','68',NULL,'EARNINGS_2',NULL,NULL,'"EARNINGS_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ETANUNUMEXZ0','69','H','01','69',NULL,'EARNINGS_PRD_2',NULL,NULL,'"EARNINGS_PRD_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ETANUNUMEXZ0','70','H','01','70',NULL,'EFF_DATE_OF_EE_COVG_2',NULL,NULL,'"EFF_DATE_OF_EE_COVG_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ETANUNUMEXZ0','71','H','01','71',NULL,'COVG_TERM_DATE_2',NULL,NULL,'"COVG_TERM_DATE_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ETANUNUMEXZ0','72','H','01','72',NULL,'EE_BEN_AMT_2',NULL,NULL,'"EE_BEN_AMT_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ETANUNUMEXZ0','73','H','01','73',NULL,'EFF_DATE_OF_SP_COVG_2',NULL,NULL,'"EFF_DATE_OF_SP_COVG_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ETANUNUMEXZ0','74','H','01','74',NULL,'SP_COVG_TERM_DATE_2',NULL,NULL,'"SP_COVG_TERM_DATE_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ETANUNUMEXZ0','75','H','01','75',NULL,'EFF_DATE_OF_CH_COVG_2',NULL,NULL,'"EFF_DATE_OF_CH_COVG_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ETANUNUMEXZ0','76','H','01','76',NULL,'CH_COVG_TERM_DATE_2',NULL,NULL,'"CH_COVG_TERM_DATE_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ETANUNUMEXZ0','77','H','01','77',NULL,'CI_SP_IND_2',NULL,NULL,'"CI_SP_IND_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ETANUNUMEXZ0','78','H','01','78',NULL,'PRODUCT_3',NULL,NULL,'"PRODUCT_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ETANUNUMEXZ0','79','H','01','79',NULL,'POLICY_NBR_3',NULL,NULL,'"POLICY_NBR_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ETANUNUMEXZ0','80','H','01','80',NULL,'DIVISION_3',NULL,NULL,'"DIVISION_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ETANUNUMEXZ0','81','H','01','81',NULL,'POLICY_ELG_GRP_3',NULL,NULL,'"POLICY_ELG_GRP_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ETANUNUMEXZ0','82','H','01','82',NULL,'CHOICE_3',NULL,NULL,'"CHOICE_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ETANUNUMEXZ0','83','H','01','83',NULL,'EE_POSTTAX_CNTRB_PCT_3',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ETANUNUMEXZ0','84','H','01','84',NULL,'EARNINGS_3',NULL,NULL,'"EARNINGS_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ETANUNUMEXZ0','85','H','01','85',NULL,'EARNINGS_PRD_3',NULL,NULL,'"EARNINGS_PRD_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ETANUNUMEXZ0','86','H','01','86',NULL,'EFF_DATE_OF_EE_COVG_3',NULL,NULL,'"EFF_DATE_OF_EE_COVG_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ETANUNUMEXZ0','87','H','01','87',NULL,'COVG_TERM_DATE_3',NULL,NULL,'"COVG_TERM_DATE_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ETANUNUMEXZ0','88','H','01','88',NULL,'EE_BEN_AMT_3',NULL,NULL,'"EE_BEN_AMT_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ETANUNUMEXZ0','89','H','01','89',NULL,'EFF_DATE_OF_SP_COVG_3',NULL,NULL,'"EFF_DATE_OF_SP_COVG_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ETANUNUMEXZ0','90','H','01','90',NULL,'SP_COVG_TERM_DATE_3',NULL,NULL,'"SP_COVG_TERM_DATE_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ETANUNUMEXZ0','91','H','01','91',NULL,'EFF_DATE_OF_CH_COVG_3',NULL,NULL,'"EFF_DATE_OF_CH_COVG_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ETANUNUMEXZ0','92','H','01','92',NULL,'CH_COVG_TERM_DATE_3',NULL,NULL,'"CH_COVG_TERM_DATE_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ETANUNUMEXZ0','93','H','01','93',NULL,'CI_SP_IND_3',NULL,NULL,'"CI_SP_IND_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ETANUNUMEXZ0','94','H','01','94',NULL,'PRODUCT_4',NULL,NULL,'"PRODUCT_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ETANUNUMEXZ0','95','H','01','95',NULL,'POLICY_NBR_4',NULL,NULL,'"POLICY_NBR_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ETANUNUMEXZ0','96','H','01','96',NULL,'DIVISION_4',NULL,NULL,'"DIVISION_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ETANUNUMEXZ0','97','H','01','97',NULL,'POLICY_ELG_GRP_4',NULL,NULL,'"POLICY_ELG_GRP_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ETANUNUMEXZ0','98','H','01','98',NULL,'CHOICE_4',NULL,NULL,'"CHOICE_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ETANUNUMEXZ0','99','H','01','99',NULL,'EE_POSTTAX_CNTRB_PCT_4',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ETANUNUMEXZ0','100','H','01','100',NULL,'EARNINGS_4',NULL,NULL,'"EARNINGS_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ETANUNUMEXZ0','101','H','01','101',NULL,'EARNINGS_PRD_4',NULL,NULL,'"EARNINGS_PRD_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ETANUNUMEXZ0','102','H','01','102',NULL,'EFF_DATE_OF_EE_COVG_4',NULL,NULL,'"EFF_DATE_OF_EE_COVG_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ETANUNUMEXZ0','103','H','01','103',NULL,'COVG_TERM_DATE_4',NULL,NULL,'"COVG_TERM_DATE_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ETANUNUMEXZ0','104','H','01','104',NULL,'EE_BEN_AMT_4',NULL,NULL,'"EE_BEN_AMT_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ETANUNUMEXZ0','105','H','01','105',NULL,'EFF_DATE_OF_SP_COVG_4',NULL,NULL,'"EFF_DATE_OF_SP_COVG_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ETANUNUMEXZ0','106','H','01','106',NULL,'SP_COVG_TERM_DATE_4',NULL,NULL,'"SP_COVG_TERM_DATE_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ETANUNUMEXZ0','107','H','01','107',NULL,'EFF_DATE_OF_CH_COVG_4',NULL,NULL,'"EFF_DATE_OF_CH_COVG_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ETANUNUMEXZ0','108','H','01','108',NULL,'CH_COVG_TERM_DATE_4',NULL,NULL,'"CH_COVG_TERM_DATE_4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ETANUNUMEXZ0','109','H','01','109',NULL,'CI_SP_IND_4',NULL,NULL,'"CI_SP_IND_4"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETANUNUMEXZ0','110','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"TAN-037671"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETANUNUMEXZ0','111','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"ELG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETANUNUMEXZ0','112','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETANUNUMEXZ0','113','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETANUNUMEXZ0','114','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EEID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETANUNUMEXZ0','115','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETANUNUMEXZ0','116','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETANUNUMEXZ0','117','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETANUNUMEXZ0','118','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETANUNUMEXZ0','119','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETANUNUMEXZ0','120','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETANUNUMEXZ0','121','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETANUNUMEXZ0','122','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETANUNUMEXZ0','123','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETANUNUMEXZ0','124','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL,'"drvWorkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETANUNUMEXZ0','125','D','10','16',NULL,'EE_DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETANUNUMEXZ0','126','D','10','17',NULL,'SP_DOB',NULL,NULL,'"drvDOB_SP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETANUNUMEXZ0','127','D','10','18',NULL,'EE_GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETANUNUMEXZ0','128','D','10','19',NULL,'EE_TOBACCO_USE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETANUNUMEXZ0','129','D','10','20',NULL,'MARITAL_STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETANUNUMEXZ0','130','D','10','21',NULL,'EE_JOB_TLE',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETANUNUMEXZ0','131','D','10','22',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ETANUNUMEXZ0','132','D','10','23',NULL,'ORG_HIRE_DATE',NULL,NULL,'"drvDateOfOriginalHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ETANUNUMEXZ0','133','D','10','24',NULL,'EE_TERM_DATE',NULL,NULL,'"drvTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ETANUNUMEXZ0','134','D','10','25',NULL,'EE_STATUS',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ETANUNUMEXZ0','135','D','10','26',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL,'"drvWeeklyWorkHrs"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ETANUNUMEXZ0','136','D','10','27',NULL,'ACCOM_RSTCT',NULL,NULL,'"Y"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ETANUNUMEXZ0','137','D','10','28',NULL,'SICK_PAY_HRS',NULL,NULL,'"0"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ETANUNUMEXZ0','138','D','10','29',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"drvDateOfLastSalaryChange"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ETANUNUMEXZ0','139','D','10','30',NULL,'EE_HOME_PHONE',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ETANUNUMEXZ0','140','D','10','31',NULL,'MGR_FIRST_NAME',NULL,NULL,'"drvManagerFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ETANUNUMEXZ0','141','D','10','32',NULL,'MGR_LAST_NAME',NULL,NULL,'"drvManagerLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ETANUNUMEXZ0','142','D','10','33',NULL,'MGR_EMAIL',NULL,NULL,'"drvManagerEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ETANUNUMEXZ0','143','D','10','34',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ETANUNUMEXZ0','144','D','10','35',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ETANUNUMEXZ0','145','D','10','36',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL,'"drvHrsWorkedLast12Months"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ETANUNUMEXZ0','146','D','10','37',NULL,'OFFCE_NAME',NULL,NULL,'"drvOfficeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ETANUNUMEXZ0','147','D','10','38',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ETANUNUMEXZ0','148','D','10','39',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ETANUNUMEXZ0','149','D','10','40',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ETANUNUMEXZ0','150','D','10','41',NULL,'EE_WRK_CITY',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ETANUNUMEXZ0','151','D','10','42',NULL,'EE_WRK_POSTAL_CD',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ETANUNUMEXZ0','152','D','10','43',NULL,'FMLA_RPTING_GRP',NULL,NULL,'"1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ETANUNUMEXZ0','153','D','10','44',NULL,'KEY_EE',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ETANUNUMEXZ0','154','D','10','45',NULL,'EE_SAL_MD',NULL,NULL,'"drvEESalaryMode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ETANUNUMEXZ0','155','D','10','46',NULL,'PRODUCT_1',NULL,NULL,'"drvProduct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ETANUNUMEXZ0','156','D','10','47',NULL,'POLICY_NBR_1',NULL,NULL,'"drvPolicyNbr1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ETANUNUMEXZ0','157','D','10','48',NULL,'DIVISION_1',NULL,NULL,'"drvDivision1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ETANUNUMEXZ0','158','D','10','49',NULL,'POLICY_ELG_GRP_1',NULL,NULL,'"drvPolicyElgGrp1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ETANUNUMEXZ0','159','D','10','50',NULL,'CHOICE_1',NULL,NULL,'"drvChoice1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ETANUNUMEXZ0','160','D','10','51',NULL,'EE_POSTTAX_CNTRB_PCT_1',NULL,NULL,'"drvPostTaxContributionPct1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ETANUNUMEXZ0','161','D','10','52',NULL,'EARNINGS_1',NULL,NULL,'"drvEarnings1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ETANUNUMEXZ0','162','D','10','53',NULL,'EARNINGS_PRD_1',NULL,NULL,'"drvEarningsPrd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ETANUNUMEXZ0','163','D','10','54',NULL,'EFF_DATE_OF_EE_COVG_1',NULL,NULL,'"drvEffDateOfEECovg1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ETANUNUMEXZ0','164','D','10','55',NULL,'COVG_TERM_DATE_1',NULL,NULL,'"drvCovgTermDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ETANUNUMEXZ0','165','D','10','56',NULL,'EE_BEN_AMT_1',NULL,NULL,'"drvEEBenAmt1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ETANUNUMEXZ0','166','D','10','57',NULL,'EFF_DATE_OF_SP_COVG_1',NULL,NULL,'"drvEffDateOfSpCovg1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ETANUNUMEXZ0','167','D','10','58',NULL,'SP_COVG_TERM_DATE_1',NULL,NULL,'"drvSpCovgTermDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ETANUNUMEXZ0','168','D','10','59',NULL,'EFF_DATE_OF_CH_COVG_1',NULL,NULL,'"drvEffDateOfChCovg1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ETANUNUMEXZ0','169','D','10','60',NULL,'CH_COVG_TERM_DATE_1',NULL,NULL,'"drvChCovgTermDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ETANUNUMEXZ0','170','D','10','61',NULL,'CI_SP_IND_1',NULL,NULL,'"drvCISPIND1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ETANUNUMEXZ0','171','D','10','62',NULL,'PRODUCT_2',NULL,NULL,'"drvProduct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ETANUNUMEXZ0','172','D','10','63',NULL,'POLICY_NBR_2',NULL,NULL,'"drvPolicyNbr2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ETANUNUMEXZ0','173','D','10','64',NULL,'DIVISION_2',NULL,NULL,'"drvDivision2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ETANUNUMEXZ0','174','D','10','65',NULL,'POLICY_ELG_GRP_2',NULL,NULL,'"drvPolicyElgGrp2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ETANUNUMEXZ0','175','D','10','66',NULL,'CHOICE_2',NULL,NULL,'"drvChoice2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ETANUNUMEXZ0','176','D','10','67',NULL,'EE_POSTTAX_CNTRB_PCT_2',NULL,NULL,'"drvPostTaxContributionPct2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ETANUNUMEXZ0','177','D','10','68',NULL,'EARNINGS_2',NULL,NULL,'"drvEarnings2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ETANUNUMEXZ0','178','D','10','69',NULL,'EARNINGS_PRD_2',NULL,NULL,'"drvEarningsPrd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ETANUNUMEXZ0','179','D','10','70',NULL,'EFF_DATE_OF_EE_COVG_2',NULL,NULL,'"drvEffDateOfEECovg2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ETANUNUMEXZ0','180','D','10','71',NULL,'COVG_TERM_DATE_2',NULL,NULL,'"drvCovgTermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ETANUNUMEXZ0','181','D','10','72',NULL,'EE_BEN_AMT_2',NULL,NULL,'"drvEEBenAmt2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ETANUNUMEXZ0','182','D','10','73',NULL,'EFF_DATE_OF_SP_COVG_2',NULL,NULL,'"drvEffDateOfSpCovg2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ETANUNUMEXZ0','183','D','10','74',NULL,'SP_COVG_TERM_DATE_2',NULL,NULL,'"drvSpCovgTermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ETANUNUMEXZ0','184','D','10','75',NULL,'EFF_DATE_OF_CH_COVG_2',NULL,NULL,'"drvEffDateOfChCovg2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ETANUNUMEXZ0','185','D','10','76',NULL,'CH_COVG_TERM_DATE_2',NULL,NULL,'"drvChCovgTermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ETANUNUMEXZ0','186','D','10','77',NULL,'CI_SP_IND_2',NULL,NULL,'"drvCISPIND2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ETANUNUMEXZ0','187','D','10','78',NULL,'PRODUCT_3',NULL,NULL,'"drvProduct3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ETANUNUMEXZ0','188','D','10','79',NULL,'POLICY_NBR_3',NULL,NULL,'"drvPolicyNbr3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ETANUNUMEXZ0','189','D','10','80',NULL,'DIVISION_3',NULL,NULL,'"drvDivision3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ETANUNUMEXZ0','190','D','10','81',NULL,'POLICY_ELG_GRP_3',NULL,NULL,'"drvPolicyElgGrp3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ETANUNUMEXZ0','191','D','10','82',NULL,'CHOICE_3',NULL,NULL,'"drvChoice3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ETANUNUMEXZ0','192','D','10','83',NULL,'EE_POSTTAX_CNTRB_PCT_3',NULL,NULL,'"drvPostTaxContributionPct3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ETANUNUMEXZ0','193','D','10','84',NULL,'EARNINGS_3',NULL,NULL,'"drvEarnings3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ETANUNUMEXZ0','194','D','10','85',NULL,'EARNINGS_PRD_3',NULL,NULL,'"drvEarningsPrd3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ETANUNUMEXZ0','195','D','10','86',NULL,'EFF_DATE_OF_EE_COVG_3',NULL,NULL,'"drvEffDateOfEECovg3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ETANUNUMEXZ0','196','D','10','87',NULL,'COVG_TERM_DATE_3',NULL,NULL,'"drvCovgTermDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ETANUNUMEXZ0','197','D','10','88',NULL,'EE_BEN_AMT_3',NULL,NULL,'"drvEEBenAmt3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ETANUNUMEXZ0','198','D','10','89',NULL,'EFF_DATE_OF_SP_COVG_3',NULL,NULL,'"drvEffDateOfSpCovg3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ETANUNUMEXZ0','199','D','10','90',NULL,'SP_COVG_TERM_DATE_3',NULL,NULL,'"drvSpCovgTermDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ETANUNUMEXZ0','200','D','10','91',NULL,'EFF_DATE_OF_CH_COVG_3',NULL,NULL,'"drvEffDateOfChCovg3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ETANUNUMEXZ0','201','D','10','92',NULL,'CH_COVG_TERM_DATE_3',NULL,NULL,'"drvChCovgTermDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ETANUNUMEXZ0','202','D','10','93',NULL,'CI_SP_IND_3',NULL,NULL,'"drvCISPIND3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ETANUNUMEXZ0','203','D','10','94',NULL,'PRODUCT_4',NULL,NULL,'"drvProduct4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ETANUNUMEXZ0','204','D','10','95',NULL,'POLICY_NBR_4',NULL,NULL,'"drvPolicyNbr4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ETANUNUMEXZ0','205','D','10','96',NULL,'DIVISION_4',NULL,NULL,'"drvDivision4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ETANUNUMEXZ0','206','D','10','97',NULL,'POLICY_ELG_GRP_4',NULL,NULL,'"drvPolicyElgGrp4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ETANUNUMEXZ0','207','D','10','98',NULL,'CHOICE_4',NULL,NULL,'"drvChoice4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ETANUNUMEXZ0','208','D','10','99',NULL,'EE_POSTTAX_CNTRB_PCT_4',NULL,NULL,'"drvPostTaxContributionPct4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ETANUNUMEXZ0','209','D','10','100',NULL,'EARNINGS_4',NULL,NULL,'"drvEarnings4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ETANUNUMEXZ0','210','D','10','101',NULL,'EARNINGS_PRD_4',NULL,NULL,'"drvEarningsPrd4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ETANUNUMEXZ0','211','D','10','102',NULL,'EFF_DATE_OF_EE_COVG_4',NULL,NULL,'"drvEffDateOfEECovg4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ETANUNUMEXZ0','212','D','10','103',NULL,'COVG_TERM_DATE_4',NULL,NULL,'"drvCovgTermDate4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ETANUNUMEXZ0','213','D','10','104',NULL,'EE_BEN_AMT_4',NULL,NULL,'"drvEEBenAmt4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ETANUNUMEXZ0','214','D','10','105',NULL,'EFF_DATE_OF_SP_COVG_4',NULL,NULL,'"drvEffDateOfSpCovg4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ETANUNUMEXZ0','215','D','10','106',NULL,'SP_COVG_TERM_DATE_4',NULL,NULL,'"drvSpCovgTermDate4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ETANUNUMEXZ0','216','D','10','107',NULL,'EFF_DATE_OF_CH_COVG_4',NULL,NULL,'"drvEffDateOfChCovg4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ETANUNUMEXZ0','217','D','10','108',NULL,'CH_COVG_TERM_DATE_4',NULL,NULL,'"drvChCovgTermDate4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ETANUNUMEXZ0','218','D','10','109',NULL,'CI_SP_IND_4',NULL,NULL,'"drvCISPIND4"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETANUNUMEX_20231228.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202312189','EMPEXPORT','OEACTIVE',NULL,'ETANUNUMEX',NULL,NULL,NULL,'202312189','Dec 18 2023  5:01PM','Dec 18 2023  5:01PM','202312181',NULL,'','','202312181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202312189','EMPEXPORT','OEPASSIVE',NULL,'ETANUNUMEX',NULL,NULL,NULL,'202312189','Dec 18 2023  5:01PM','Dec 18 2023  5:01PM','202312181',NULL,'','','202312181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tanger Properties UNUM Export','202312189','EMPEXPORT','ONDEM_XOE',NULL,'ETANUNUMEX',NULL,NULL,NULL,'202312189','Dec 18 2023  5:01PM','Dec 18 2023  5:01PM','202312181',NULL,'','','202312181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tanger Properties UNUM E-Sched','202312189','EMPEXPORT','SCH_ETANUN',NULL,'ETANUNUMEX',NULL,NULL,NULL,'202312189','Dec 18 2023  5:01PM','Dec 18 2023  5:01PM','202312181',NULL,'','','202312181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Tanger Properties UNUM E-Test','202312189','EMPEXPORT','TEST_XOE',NULL,'ETANUNUMEX',NULL,NULL,NULL,'202312189','Dec 18 2023  5:01PM','Dec 18 2023  5:01PM','202312181',NULL,'','','202312181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETANUNUMEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETANUNUMEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETANUNUMEX','D10','dbo.U_ETANUNUMEX_drvTbl',NULL);

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
-- Create table U_dsi_BDM_ETANUNUMEX
-----------

IF OBJECT_ID('U_dsi_BDM_ETANUNUMEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETANUNUMEX] (
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
-- Create table U_ETANUNUMEX_Audit
-----------

IF OBJECT_ID('U_ETANUNUMEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_Audit] (
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
-- Create table U_ETANUNUMEX_AuditFields
-----------

IF OBJECT_ID('U_ETANUNUMEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ETANUNUMEX_DedList
-----------

IF OBJECT_ID('U_ETANUNUMEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ETANUNUMEX_drvTbl
-----------

IF OBJECT_ID('U_ETANUNUMEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(8000) NULL,
    [drvZipCode] varchar(8000) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvDOB] datetime NULL,
    [drvDOB_SP] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(7) NOT NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvStatus] varchar(3) NOT NULL,
    [drvWeeklyWorkHrs] varchar(30) NULL,
    [drvDateOfLastSalaryChange] datetime NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvManagerFirstName] varchar(256) NULL,
    [drvManagerLastName] varchar(256) NULL,
    [drvManagerEmail] varchar(256) NULL,
    [drvHrsWorkedLast12Months] nvarchar(4000) NULL,
    [drvOfficeName] varchar(20) NOT NULL,
    [drvEESalaryMode] char(1) NULL,
    [drvProduct1] varchar(2) NULL,
    [drvPolicyNbr1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolicyElgGrp1] varchar(1) NULL,
    [drvChoice1] varchar(1) NULL,
    [drvPostTaxContributionPct1] varchar(1) NULL,
    [drvEarnings1] money NULL,
    [drvEarningsPrd1] varchar(6) NULL,
    [drvEffDateOfEECovg1] datetime NULL,
    [drvCovgTermDate1] datetime NULL,
    [drvEEBenAmt1] varchar(1) NOT NULL,
    [drvEffDateOfSpCovg1] varchar(1) NOT NULL,
    [drvSpCovgTermDate1] varchar(1) NOT NULL,
    [drvEffDateOfChCovg1] varchar(1) NOT NULL,
    [drvChCovgTermDate1] varchar(1) NOT NULL,
    [drvCISPIND1] varchar(1) NOT NULL,
    [drvProduct2] varchar(2) NULL,
    [drvPolicyNbr2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyElgGrp2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvPostTaxContributionPct2] varchar(1) NULL,
    [drvEarnings2] money NULL,
    [drvEarningsPrd2] varchar(7) NULL,
    [drvEffDateOfEECovg2] datetime NULL,
    [drvCovgTermDate2] datetime NULL,
    [drvEEBenAmt2] varchar(1) NOT NULL,
    [drvEffDateOfSpCovg2] varchar(1) NOT NULL,
    [drvSpCovgTermDate2] varchar(1) NOT NULL,
    [drvEffDateOfChCovg2] varchar(1) NOT NULL,
    [drvChCovgTermDate2] varchar(1) NOT NULL,
    [drvCISPIND2] varchar(1) NOT NULL,
    [drvProduct3] varchar(3) NULL,
    [drvPolicyNbr3] varchar(6) NULL,
    [drvDivision3] varchar(1) NULL,
    [drvPolicyElgGrp3] varchar(1) NULL,
    [drvChoice3] varchar(1) NULL,
    [drvPostTaxContributionPct3] varchar(3) NULL,
    [drvEarnings3] varchar(1) NULL,
    [drvEarningsPrd3] varchar(1) NULL,
    [drvEffDateOfEECovg3] datetime NULL,
    [drvCovgTermDate3] datetime NULL,
    [drvEEBenAmt3] varchar(1) NOT NULL,
    [drvEffDateOfSpCovg3] datetime NULL,
    [drvSpCovgTermDate3] datetime NULL,
    [drvEffDateOfChCovg3] datetime NULL,
    [drvChCovgTermDate3] datetime NULL,
    [drvCISPIND3] varchar(1) NOT NULL,
    [drvProduct4] varchar(3) NULL,
    [drvPolicyNbr4] varchar(6) NULL,
    [drvDivision4] varchar(1) NULL,
    [drvPolicyElgGrp4] varchar(1) NULL,
    [drvChoice4] varchar(1) NULL,
    [drvPostTaxContributionPct4] varchar(3) NULL,
    [drvEarnings4] varchar(1) NULL,
    [drvEarningsPrd4] varchar(1) NULL,
    [drvEffDateOfEECovg4] datetime NULL,
    [drvCovgTermDate4] datetime NULL,
    [drvEEBenAmt4] money NULL,
    [drvEffDateOfSpCovg4] datetime NULL,
    [drvSpCovgTermDate4] datetime NULL,
    [drvEffDateOfChCovg4] datetime NULL,
    [drvChCovgTermDate4] datetime NULL,
    [drvCISPIND4] varchar(1) NOT NULL
);

-----------
-- Create table U_ETANUNUMEX_EEList
-----------

IF OBJECT_ID('U_ETANUNUMEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETANUNUMEX_File
-----------

IF OBJECT_ID('U_ETANUNUMEX_File') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_ETANUNUMEX_PEarHist
-----------

IF OBJECT_ID('U_ETANUNUMEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETANUNUMEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [Peh12MHours] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETANUNUMEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Tanger Properties

Created By: Spencer Kerch
Business Analyst: Lea King
Create Date: 12/18/2023
Service Request Number: TekP-2023-11-08-14

Purpose: Tanger Properties UNUM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETANUNUMEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETANUNUMEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETANUNUMEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETANUNUMEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETANUNUMEX' ORDER BY RunID DESC;

Execute Exporta
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETANUNUMEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETANUNUMEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETANUNUMEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETANUNUMEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETANUNUMEX', 'SCH_ETANUN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETANUNUMEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ETANUNUMEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETANUNUMEX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '01/01/2024'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ETANUNUMEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETANUNUMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ETANUNUMEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETANUNUMEX_AuditFields;
    CREATE TABLE dbo.U_ETANUNUMEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_ETANUNUMEX_AuditFields VALUES ('EmpComp','eecEmplStatus');  -- MW added 
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETANUNUMEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETANUNUMEX_Audit;
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
    INTO dbo.U_ETANUNUMEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ETANUNUMEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETANUNUMEX_Audit ON dbo.U_ETANUNUMEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only        -- MW commented out this section
    ----================
    --DELETE FROM dbo.U_ETANUNUMEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ETANUNUMEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CIL10,CIL20,CIS10,CIS20,UNACC,LTD,STD'; -- MW added dedcodes

    IF OBJECT_ID('U_ETANUNUMEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETANUNUMEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETANUNUMEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DEDLIST); -- MW updated to use dedlist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '30')-- MW Added
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays', '30')-- MW Added

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

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ETANUNUMEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETANUNUMEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,Peh12MHours             = SUM( CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurHrs ELSE 0.00 END) -- MW added
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
        --,hoursWorkedLast12 = SUM(CASE WHEN ErnIsRegularPayCode = 'Y' and PehPerControl <)
    INTO dbo.U_ETANUNUMEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
   -- WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
   -- AND PehPerControl <= @EndPerControl
    WHERE PrgPayDate BETWEEN DATEADD(YY,-1,@EndDate) AND @EndDate -- MW updated
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETANUNUMEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETANUNUMEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETANUNUMEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvAddress1 = REPLACE(EepAddressLine1, ',', '') -- MW added replace
        ,drvAddress2 = REPLACE(EepAddressLine2, ',', '') -- MW added replace
        ,drvCity = REPLACE(EepAddressCity, ',', '') -- MW added replace
        ,drvState = REPLACE(EepAddressState, ',', '') -- MW added replace
        ,drvZipCode = REPLACE(EepAddressZipCode,'-','')
        ,drvWorkState = LocAddressState -- location
        ,drvDOB = EepDateOfBirth
        ,drvDOB_SP = CASE WHEN ConRelationship IN ('SPS','DP','SP') THEN ConDateOfBirth END
        ,drvGender = CASE WHEN EepGender in ('M','F') THEN eepGender  END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'Married'
                            WHEN eepMaritalStatus = 'S' THEN 'Single'
                            ELSE 'UNK'
                            END
        ,drvJobTitle = jbcDesc
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvStatus =CASE WHEN eecEmplStatus = 'L' THEN 'LOA' ELSE 'ACT' END
        ,drvWeeklyWorkHrs = Cast((Cast(EecScheduledWorkHrs AS INT) / 2) AS VARCHAR)
        ,drvDateOfLastSalaryChange = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvManagerFirstName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst')--EepNameFirst
        ,drvManagerLastName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast')
        ,drvManagerEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEmail')
        ,drvHrsWorkedLast12Months = Format(Peh12MHours, '#,###.##')--''--peh -- MW updated
        ,drvOfficeName = 'Tanger Properties LP'
        ,drvEESalaryMode = eecSalaryOrHourly
        ----STD------
        ,drvProduct1 = CASE WHEN STD IS NOT NULL THEN '31' END
        ,drvPolicyNbr1 = CASE WHEN STD IS NOT NULL THEN '947437' END
        ,drvDivision1 = CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvPolicyElgGrp1 =  CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvChoice1 =  CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvPostTaxContributionPct1 =  CASE WHEN STD IS NOT NULL THEN '0' END
        ,drvEarnings1 = CASE WHEN STD IS NOT NULL THEN STD_BanAmtCalc END--BCA??
        ,drvEarningsPrd1 =  CASE WHEN STD IS NOT NULL THEN 'Weekly' END
        ,drvEffDateOfEECovg1 =  CASE WHEN STD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',STD_StartDate,@FileMinCovDate)  END
        ,drvCovgTermDate1 = CASE WHEN STD IS NOT NULL THEN STD_StopDate END
        ,drvEEBenAmt1 = ''
        ,drvEffDateOfSpCovg1 = ''
        ,drvSpCovgTermDate1 = ''
        ,drvEffDateOfChCovg1 = ''
        ,drvChCovgTermDate1 = ''
        ,drvCISPIND1 = ''
        ----LTD-----------
        ,drvProduct2 = CASE WHEN LTD IS NOT NULL THEN '38' END
        ,drvPolicyNbr2 = CASE WHEN LTD IS NOT NULL THEN '947437' END
        ,drvDivision2 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvPolicyElgGrp2 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvChoice2 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvPostTaxContributionPct2 = CASE WHEN LTD IS NOT NULL THEN '0' END
        ,drvEarnings2 = CASE WHEN LTD IS NOT NULL THEN LTD_BanAmtCalc END
        ,drvEarningsPrd2 = CASE WHEN LTD IS NOT NULL THEN 'Monthly' END
        ,drvEffDateOfEECovg2 = CASE WHEN LTD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',LTD_StartDate,@FileMinCovDate)  END
        ,drvCovgTermDate2 = CASE WHEN LTD IS NOT NULL THEN LTD_StopDate END
        ,drvEEBenAmt2 = ''
        ,drvEffDateOfSpCovg2 = ''
        ,drvSpCovgTermDate2 = ''
        ,drvEffDateOfChCovg2 = ''
        ,drvChCovgTermDate2 = ''
        ,drvCISPIND2 = ''
        ----UNACC----
        ,drvProduct3 = CASE WHEN UNACC IS NOT NULL THEN '824' END
        ,drvPolicyNbr3 =  CASE WHEN UNACC IS NOT NULL THEN '947439' END
        ,drvDivision3 = CASE WHEN UNACC IS NOT NULL THEN '1' END
        ,drvPolicyElgGrp3 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvChoice3 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvPostTaxContributionPct3 = CASE WHEN UNACC IS NOT NULL THEN '100' END
        ,drvEarnings3 = CASE WHEN UNACC IS NOT NULL THEN '0' END
        ,drvEarningsPrd3 = CASE WHEN UNACC IS NOT NULL THEN '' END
        ,drvEffDateOfEECovg3 = CASE WHEN UNACC IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',UNACC_StartDate,@FileMinCovDate)  END
        ,drvCovgTermDate3 = CASE WHEN UNACC IS NOT NULL THEN UNACC_StopDate END
        ,drvEEBenAmt3 = ''
        ,drvEffDateOfSpCovg3 = CASE WHEN UNACC_Spouse IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',UNACC_StartDate,@FileMinCovDate) END
        ,drvSpCovgTermDate3 = CASE WHEN UNACC_Spouse IS NOT NULL THEN UNACC_StopDate END
        ,drvEffDateOfChCovg3 = CASE WHEN UNACC_Child IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',UNACC_StartDate,@FileMinCovDate) END
        ,drvChCovgTermDate3 =  CASE WHEN UNACC_Child IS NOT NULL THEN UNACC_StopDate END
        ,drvCISPIND3 = ''
        ----CRIT----
        ,drvProduct4 =  CASE WHEN CRIT IS NOT NULL THEN '822' END
        ,drvPolicyNbr4 = CASE WHEN CRIT IS NOT NULL THEN '947440' END
        ,drvDivision4 = CASE WHEN CRIT IS NOT NULL THEN '1' END
        ,drvPolicyElgGrp4 = CASE WHEN CRIT IS NOT NULL THEN '1' END
        ,drvChoice4 = CASE WHEN CRIT IS NOT NULL THEN '2' END
        ,drvPostTaxContributionPct4 =  CASE WHEN CRIT IS NOT NULL THEN '100' END
        ,drvEarnings4 =  CASE WHEN CRIT IS NOT NULL THEN '0' END
        ,drvEarningsPrd4 = CASE WHEN CRIT IS NOT NULL THEN '' END
        ,drvEffDateOfEECovg4 =  CASE WHEN CRIT IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',CRIT_StartDate,@FileMinCovDate)  END
        ,drvCovgTermDate4 = CASE WHEN CRIT IS NOT NULL THEN CRIT_StopDate END
        ,drvEEBenAmt4 = CASE WHEN CRIT IS NOT NULL THEN CRIT_EEBenEmt END
        ,drvEffDateOfSpCovg4 = CASE WHEN CRIT_Spouse IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',CRIT_StartDate,@FileMinCovDate) END
        ,drvSpCovgTermDate4 = CASE WHEN CRIT_Spouse IS NOT NULL THEN CRIT_StopDate END
        ,drvEffDateOfChCovg4 =  CASE WHEN CRIT_Child IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',CRIT_StartDate,@FileMinCovDate) END
        ,drvChCovgTermDate4 =  CASE WHEN CRIT_Child IS NOT NULL THEN CRIT_StopDate END
        ,drvCISPIND4 = CASE WHEN CRIT_Spouse IS NOT NULL THEN 'Y' ELSE 'N' END
    INTO dbo.U_ETANUNUMEX_drvTbl
    FROM dbo.U_ETANUNUMEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
       JOIN (
            SELECT Distinct  BdmEEID, BdmCOID   
                 ---STD---
                ,MAX(CASE WHEN bdmDedCode IN ('STD') THEN bdmDedCode END) AS STD 
                ,MAX(CASE WHEN bdmDedCode IN ('STD') THEN BdmBenStartDate END ) AS  STD_StartDate
                ,MAX(CASE WHEN bdmDedCode IN ('STD') THEN BdmBenStopDate END ) AS STD_StopDate
                ,MAX(CASE WHEN bdmDedCode IN ('STD') THEN BcaBenAmtcalc END ) AS STD_BanAmtCalc
                ---LTD---
                ,MAX(CASE WHEN bdmDedCode IN ('LTD') THEN bdmDedCode END) AS LTD 
                ,MAX(CASE WHEN bdmDedCode IN ('LTD') THEN BdmBenStartDate END ) AS  LTD_StartDate
                ,MAX(CASE WHEN bdmDedCode IN ('LTD') THEN BdmBenStopDate END ) AS LTD_StopDate
                ,MAX(CASE WHEN bdmDedCode IN ('LTD') THEN BcaBenAmtcalc END ) AS LTD_BanAmtCalc
                ---UNACC---
                ,MAX(CASE WHEN bdmDedCode IN ('UNACC') THEN bdmDedCode END) AS UNACC 
                ,MAX(CASE WHEN bdmDedCode IN ('UNACC') THEN BdmBenStartDate END ) AS  UNACC_StartDate
                ,MAX(CASE WHEN bdmDedCode IN ('UNACC') THEN BdmBenStopDate END ) AS UNACC_StopDate
                ,MAX(CASE WHEN bdmDedCode IN ('UNACC') and BdmRelationship IN ('SPS','DP','SP') THEN BdmRelationship END ) AS UNACC_Spouse
                ,MAX(CASE WHEN bdmDedCode IN ('UNACC') and BdmRelationship IN  ('CHL', 'DDP', 'LDP', 'STC') THEN BdmRelationship END ) AS UNACC_Child
                ---CRIT---
                ,MAX(CASE WHEN bdmDedCode IN ('CIL10','CIL20','CIS10','CIS20') THEN bdmDedCode END) AS CRIT 
                ,MAX(CASE WHEN bdmDedCode IN ('CIL10','CIL20','CIS10','CIS20') THEN BdmBenStartDate END ) AS  CRIT_StartDate
                ,MAX(CASE WHEN bdmDedCode IN  ('CIL10','CIL20','CIS10','CIS20')  THEN BdmBenStopDate END ) AS CRIT_StopDate
                ,MAX(CASE WHEN bdmDedCode IN  ('CIL10','CIL20','CIS10','CIS20')  and BdmRelationship IN ('SPS','DP','SP') THEN BdmRelationship END ) AS CRIT_Spouse
                ,MAX(CASE WHEN bdmDedCode IN  ('CIL10','CIL20','CIS10','CIS20')  and BdmRelationship IN  ('CHL', 'DDP', 'LDP', 'STC') THEN BdmRelationship END ) AS CRIT_Child
                ,MAX(CASE WHEN bdmDedCode IN ('CIL10','CIL20','CIS10','CIS20') THEN bdmEEAmt END) AS CRIT_EEBenEmt             
            FROM dbo.U_dsi_BDM_ETANUNUMEX WITH (NOLOCK)
            LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts 
        ON bdmeeid = bcaeeid 
        AND bdmcoid = bcacoid
       AND bdmdedcode = bcadedcode  and BcaEEBenAmt <> 0.00
       AND BCAFormatCode = 'ETANUNUMEX'
     --where  BdmDedCode IN ('CRILL','CISP','STD','HOSP1','HOSP2')-- Replaced GTL
       WHERE Bdmdedcode IN ('CIL10','CIL20','CIS10','CIS20','UNACC','LTD','STD') -- MW updated 
            AND bdmBenStatus IN ('A','T') 
            group by  BdmEEID, Bdmcoid
        ) Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConIsDependent = 'Y'
		AND ConRelationship IN ('SPS','DP','SP')
    LEFT JOIN dbo.U_ETANUNUMEX_PEarHist WITH (NOLOCK) -- MW added
        ON Peheeid = xEEID
     LEFT JOIN dbo.U_ETANUNUMEX_Audit -- MW added 
        ON audeeid = xeeid
        and audKey2 = xcoid            
        WHERE EecEEType NOT IN ('CON','INT') AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime Between @Startdate and @Enddate  )) -- MW added
        
        
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
ALTER VIEW dbo.dsi_vwETANUNUMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETANUNUMEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ETANUNUMEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202312111'
       ,expStartPerControl     = '202312111'
       ,expLastEndPerControl   = '202312189'
       ,expEndPerControl       = '202312189'
WHERE expFormatCode = 'ETANUNUMEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETANUNUMEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETANUNUMEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETANUNUMEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETANUNUMEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETANUNUMEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETANUNUMEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETANUNUMEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETANUNUMEX', 'UseFileName', 'V', 'Y'


-- End ripout