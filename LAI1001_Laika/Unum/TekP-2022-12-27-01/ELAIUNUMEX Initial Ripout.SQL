/**********************************************************************************

ELAIUNUMEX: Unum STD LTD FMLA Export

FormatCode:     ELAIUNUMEX
Project:        Unum STD LTD FMLA Export
Client ID:      LAI1001
Date/time:      2023-02-13 09:21:37.900
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPLAIKA
Web Filename:   LAI1001_K8KNG_EEHISTORY_ELAIUNUMEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELAIUNUMEX_SavePath') IS NOT NULL DROP TABLE dbo.U_ELAIUNUMEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELAIUNUMEX'


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
WHERE FormatCode = 'ELAIUNUMEX'
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
WHERE ExpFormatCode = 'ELAIUNUMEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELAIUNUMEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELAIUNUMEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELAIUNUMEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELAIUNUMEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELAIUNUMEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELAIUNUMEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELAIUNUMEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELAIUNUMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELAIUNUMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELAIUNUMEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELAIUNUMEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELAIUNUMEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELAIUNUMEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELAIUNUMEX];
GO
IF OBJECT_ID('U_ELAIUNUMEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_PEarHist];
GO
IF OBJECT_ID('U_ELAIUNUMEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_PDedHist];
GO
IF OBJECT_ID('U_ELAIUNUMEX_File') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_File];
GO
IF OBJECT_ID('U_ELAIUNUMEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_EEList];
GO
IF OBJECT_ID('U_ELAIUNUMEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_drvTbl];
GO
IF OBJECT_ID('U_ELAIUNUMEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_DedList];
GO
IF OBJECT_ID('U_ELAIUNUMEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_AuditFields];
GO
IF OBJECT_ID('U_ELAIUNUMEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELAIUNUMEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELAIUNUMEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELAIUNUMEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELAIUNUMEX','Unum STD LTD FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ELAIUNUMEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELAIUNUMEXZ0','10','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"PARTNERCASE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELAIUNUMEXZ0','10','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"SERVICE_INDICATOR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELAIUNUMEXZ0','11','H','01','3',NULL,'EE_SSN',NULL,NULL,'"EE_SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELAIUNUMEXZ0','20','H','01','4',NULL,'EE_ID',NULL,NULL,'"EE_ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELAIUNUMEXZ0','5','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL,'"EE_ID_TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELAIUNUMEXZ0','15','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"EE_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELAIUNUMEXZ0','1','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"EE_MIDDLE_INITIAL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELAIUNUMEXZ0','25','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL,'"EE_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELAIUNUMEXZ0','40','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"EE_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELAIUNUMEXZ0','40','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"EE_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELAIUNUMEXZ0','30','H','01','11',NULL,'EE_CITY',NULL,NULL,'"EE_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELAIUNUMEXZ0','2','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"EE_RDC_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELAIUNUMEXZ0','11','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"EE_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELAIUNUMEXZ0','2','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"EE_CNTRY_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELAIUNUMEXZ0','2','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL,'"EE_WRK_ST_PVC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELAIUNUMEXZ0','10','H','01','16',NULL,'EE_DOB',NULL,NULL,'"EE_DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELAIUNUMEXZ0','3','H','01','17',NULL,'EE_GENDER',NULL,NULL,'"EE_GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELAIUNUMEXZ0','3','H','01','18',NULL,'MARITAL_STATUS',NULL,NULL,'"MARITAL_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELAIUNUMEXZ0','40','H','01','19',NULL,'EE_JOB_TLE',NULL,NULL,'"EE_JOB_TLE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELAIUNUMEXZ0','10','H','01','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"MOST_RCNT_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELAIUNUMEXZ0','10','H','01','21',NULL,'ORG_HIRE_DATE',NULL,NULL,'"ORG_HIRE_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELAIUNUMEXZ0','10','H','01','22',NULL,'EE_TERM_DATE',NULL,NULL,'"EE_TERM_DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELAIUNUMEXZ0','3','H','01','23',NULL,'EE_STATUS',NULL,NULL,'"EE_STATUS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELAIUNUMEXZ0','5','H','01','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL,'"WKLY_SCH_WRK_HRS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELAIUNUMEXZ0','10','H','01','25',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"DATE_OF_LST_SLY_CHG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELAIUNUMEXZ0','10','H','01','26',NULL,'EE_HOME_PHONE',NULL,NULL,'"EE_HOME_PHONE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELAIUNUMEXZ0','15','H','01','27',NULL,'MGR_FIRST_NAME',NULL,NULL,'"MGR_FIRST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELAIUNUMEXZ0','25','H','01','28',NULL,'MGR_LAST_NAME',NULL,NULL,'"MGR_LAST_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELAIUNUMEXZ0','110','H','01','29',NULL,'MGR_EMAIL',NULL,NULL,'"MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELAIUNUMEXZ0','110','H','01','30',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL,'"EE_SCND_MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELAIUNUMEXZ0','110','H','01','31',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL,'"EE_THRD_MGR_EMAIL"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELAIUNUMEXZ0','6','H','01','32',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL,'"HR_WRKED_IN_PST_12_MNTHS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELAIUNUMEXZ0','1','H','01','33',NULL,'WRK_ON_SUN',NULL,NULL,'"WRK_ON_SUN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELAIUNUMEXZ0','1','H','01','34',NULL,'WRK_ON_MON',NULL,NULL,'"WRK_ON_MON"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELAIUNUMEXZ0','1','H','01','35',NULL,'WRK_ON_TUES',NULL,NULL,'"WRK_ON_TUES"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELAIUNUMEXZ0','1','H','01','36',NULL,'WRK_ON_WEDS',NULL,NULL,'"WRK_ON_WEDS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELAIUNUMEXZ0','1','H','01','37',NULL,'WRK_ON_THURS',NULL,NULL,'"WRK_ON_THURS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELAIUNUMEXZ0','1','H','01','38',NULL,'WRK_ON_FRI',NULL,NULL,'"WRK_ON_FRI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELAIUNUMEXZ0','1','H','01','39',NULL,'WRK_ON_SAT',NULL,NULL,'"WRK_ON_SAT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELAIUNUMEXZ0','30','H','01','40',NULL,'OFFCE_NAME',NULL,NULL,'"OFFCE_NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELAIUNUMEXZ0','40','H','01','41',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELAIUNUMEXZ0','40','H','01','42',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ELAIUNUMEXZ0','40','H','01','43',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL,'"EE_WRK_MAIL_ST_ADDR_3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ELAIUNUMEXZ0','30','H','01','44',NULL,'EE_WRK_CITY',NULL,NULL,'"EE_WRK_CITY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ELAIUNUMEXZ0','11','H','01','45',NULL,'EE_WRK_POSTAL_CD',NULL,NULL,'"EE_WRK_POSTAL_CD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ELAIUNUMEXZ0','6','H','01','46',NULL,'FMLA_RPTING_GRP',NULL,NULL,'"FMLA_RPTING_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ELAIUNUMEXZ0','1','H','01','47',NULL,'KEY_EE',NULL,NULL,'"KEY_EE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ELAIUNUMEXZ0','1','H','01','48',NULL,'EE_SAL_MD',NULL,NULL,'"EE_SAL_MD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ELAIUNUMEXZ0','4','H','01','49',NULL,'PRODUCT',NULL,NULL,'"PRODUCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ELAIUNUMEXZ0','6','H','01','50',NULL,'POLICY_NBR',NULL,NULL,'"POLICY_NBR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ELAIUNUMEXZ0','3','H','01','51',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ELAIUNUMEXZ0','3','H','01','52',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ELAIUNUMEXZ0','6','H','01','53',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ELAIUNUMEXZ0','3','H','01','54',NULL,'POLICY_ELG_GRP',NULL,NULL,'"POLICY_ELG_GRP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ELAIUNUMEXZ0','6','H','01','55',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"EE_POSTTAX_CNTRB_PCT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ELAIUNUMEXZ0','8','H','01','56',NULL,'EARNINGS',NULL,NULL,'"EARNINGS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ELAIUNUMEXZ0','2','H','01','57',NULL,'EARNINGS_PRD',NULL,NULL,'"EARNINGS_PRD"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ELAIUNUMEXZ0','10','H','01','58',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"EFF_DATE_OF_EE_COVG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ELAIUNUMEXZ0','10','H','01','59',NULL,'COVG_TERM_DATE',NULL,NULL,'"COVG_TERM_DATE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELAIUNUMEXZ0','10','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL,'"LAI-032987"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELAIUNUMEXZ0','10','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL,'"ELG"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELAIUNUMEXZ0','11','D','10','3',NULL,'EE_SSN',NULL,NULL,'"drvEESSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELAIUNUMEXZ0','20','D','10','4',NULL,'EE_ID',NULL,NULL,'"drvID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELAIUNUMEXZ0','5','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL,'"drvEEIDTYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELAIUNUMEXZ0','15','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL,'"drvEEFIRSTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELAIUNUMEXZ0','1','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL,'"drvEEMIDDLEINITIAL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELAIUNUMEXZ0','25','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL,'"drvEELASTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELAIUNUMEXZ0','40','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL,'"drvEESTADDR1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELAIUNUMEXZ0','40','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL,'"drvEESTADDR2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELAIUNUMEXZ0','30','D','10','11',NULL,'EE_CITY',NULL,NULL,'"drvEECITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELAIUNUMEXZ0','2','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL,'"drvEERDCSTPVC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELAIUNUMEXZ0','11','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL,'"drvEEPOSTALCD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELAIUNUMEXZ0','2','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL,'"drvEECNTRYCD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELAIUNUMEXZ0','2','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL,'"drvEEWRKSTPVC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELAIUNUMEXZ0','10','D','10','16',NULL,'EE_DOB',NULL,NULL,'"drvEEDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELAIUNUMEXZ0','3','D','10','17',NULL,'EE_GENDER',NULL,NULL,'"drvEEGENDER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELAIUNUMEXZ0','3','D','10','18',NULL,'MARITAL_STATUS',NULL,NULL,'"drvMARITALSTATUS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELAIUNUMEXZ0','40','D','10','19',NULL,'EE_JOB_TLE',NULL,NULL,'"drvEEJOBTLE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELAIUNUMEXZ0','10','D','10','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL,'"drvMOSTRCNTHIREDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELAIUNUMEXZ0','10','D','10','21',NULL,'ORG_HIRE_DATE',NULL,NULL,'"drvORGHIREDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELAIUNUMEXZ0','10','D','10','22',NULL,'EE_TERM_DATE',NULL,NULL,'"drvEETERMDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELAIUNUMEXZ0','3','D','10','23',NULL,'EE_STATUS',NULL,NULL,'"drvEESTATUS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELAIUNUMEXZ0','5','D','10','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL,'"drvWKLYSCHWRKHRS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELAIUNUMEXZ0','10','D','10','25',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL,'"drvDATEOFLSTSLYCHG"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELAIUNUMEXZ0','10','D','10','26',NULL,'EE_HOME_PHONE',NULL,NULL,'"drvEEHOMEPHONE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELAIUNUMEXZ0','15','D','10','27',NULL,'MGR_FIRST_NAME',NULL,NULL,'"drvMGRFIRSTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELAIUNUMEXZ0','25','D','10','28',NULL,'MGR_LAST_NAME',NULL,NULL,'"drvMGRLASTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELAIUNUMEXZ0','110','D','10','29',NULL,'MGR_EMAIL',NULL,NULL,'"drvMGREMAIL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELAIUNUMEXZ0','110','D','10','30',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL,'"drvEESCNDMGREMAIL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELAIUNUMEXZ0','110','D','10','31',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL,'"drvEETHRDMGREMAIL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELAIUNUMEXZ0','6','D','10','32',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL,'"drvHRWRKEDINPSTMNTHS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELAIUNUMEXZ0','1','D','10','33',NULL,'WRK_ON_SUN',NULL,NULL,'"drvWRKONSUN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELAIUNUMEXZ0','1','D','10','34',NULL,'WRK_ON_MON',NULL,NULL,'"drvWRKONMON"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELAIUNUMEXZ0','1','D','10','35',NULL,'WRK_ON_TUES',NULL,NULL,'"drvWRKONTUES"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELAIUNUMEXZ0','1','D','10','36',NULL,'WRK_ON_WEDS',NULL,NULL,'"drvWRKONWEDS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELAIUNUMEXZ0','1','D','10','37',NULL,'WRK_ON_THURS',NULL,NULL,'"drvWRKONTHURS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELAIUNUMEXZ0','1','D','10','38',NULL,'WRK_ON_FRI',NULL,NULL,'"drvWRKONFRI"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELAIUNUMEXZ0','1','D','10','39',NULL,'WRK_ON_SAT',NULL,NULL,'"drvWRKONSAT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELAIUNUMEXZ0','30','D','10','40',NULL,'OFFCE_NAME',NULL,NULL,'"drvOFFCENAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELAIUNUMEXZ0','40','D','10','41',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL,'"drvEEWRKMAILSTADDR1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELAIUNUMEXZ0','40','D','10','42',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL,'"drvEEWRKMAILSTADDR2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ELAIUNUMEXZ0','40','D','10','43',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL,'"drvEEWRKMAILSTADDR3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ELAIUNUMEXZ0','30','D','10','44',NULL,'EE_WRK_CITY',NULL,NULL,'"drvEEWRKCITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ELAIUNUMEXZ0','11','D','10','45',NULL,'EE_WRK_POSTAL_CD',NULL,NULL,'"drvEEWRKPOSTALCD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ELAIUNUMEXZ0','6','D','10','46',NULL,'FMLA_RPTING_GRP',NULL,NULL,'"drvFMLARPTINGGRP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ELAIUNUMEXZ0','1','D','10','47',NULL,'KEY_EE',NULL,NULL,'"drvKEYEE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ELAIUNUMEXZ0','1','D','10','48',NULL,'EE_SAL_MD',NULL,NULL,'"drvEESALMD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ELAIUNUMEXZ0','4','D','10','49',NULL,'PRODUCT',NULL,NULL,'"drvProduct"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ELAIUNUMEXZ0','6','D','10','50',NULL,'POLICY_NBR',NULL,NULL,'"drvPOLICYNBR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ELAIUNUMEXZ0','3','D','10','51',NULL,'DIVISION',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ELAIUNUMEXZ0','3','D','10','52',NULL,'POLICY_ELG_GRP',NULL,NULL,'"drvPOLICYELGGRP1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ELAIUNUMEXZ0','6','D','10','53',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"drvEEPOSTTAXCNTRBPCT1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ELAIUNUMEXZ0','3','D','10','54',NULL,'POLICY_ELG_GRP2',NULL,NULL,'"drvPOLICYELGGRP2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ELAIUNUMEXZ0','6','D','10','55',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL,'"drvEEPOSTTAXCNTRBPCT2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ELAIUNUMEXZ0','8','D','10','56',NULL,'EARNINGS',NULL,NULL,'"drvEarnings"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ELAIUNUMEXZ0','2','D','10','57',NULL,'EARNINGS_PRD',NULL,NULL,'"drvEARNINGSPRD"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ELAIUNUMEXZ0','10','D','10','58',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL,'"drvEFFDATEOFEECOVG"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ELAIUNUMEXZ0','10','D','10','59',NULL,'COVG_TERM_DATE',NULL,NULL,'"drvCOVGTERMDATE"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELAIUNUMEX_20230213.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202302109','EMPEXPORT','OEACTIVE',NULL,'ELAIUNUMEX',NULL,NULL,NULL,'202302109','Feb 10 2023  6:24PM','Feb 10 2023  6:24PM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202302109','EMPEXPORT','OEPASSIVE',NULL,'ELAIUNUMEX',NULL,NULL,NULL,'202302109','Feb 10 2023  6:24PM','Feb 10 2023  6:24PM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum STD LTD FMLA Export','202302109','EMPEXPORT','ONDEM_XOE',NULL,'ELAIUNUMEX',NULL,NULL,NULL,'202302109','Feb 10 2023  6:24PM','Feb 10 2023  6:24PM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum_STD_ LTD_FMLA Expo-Sched','202302109','EMPEXPORT','SCH_ELAIUN',NULL,'ELAIUNUMEX',NULL,NULL,NULL,'202302109','Feb 10 2023  6:24PM','Feb 10 2023  6:24PM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Unum_STD_ LTD_FMLA Expo-Test','202302109','EMPEXPORT','TEST_XOE',NULL,'ELAIUNUMEX',NULL,NULL,NULL,'202302109','Feb 10 2023  6:24PM','Feb 10 2023  6:24PM','202302101',NULL,'','','202302101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELAIUNUMEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELAIUNUMEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELAIUNUMEX','D10','dbo.U_ELAIUNUMEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ELAIUNUMEX
-----------

IF OBJECT_ID('U_dsi_BDM_ELAIUNUMEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELAIUNUMEX] (
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
-- Create table U_ELAIUNUMEX_Audit
-----------

IF OBJECT_ID('U_ELAIUNUMEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_Audit] (
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
-- Create table U_ELAIUNUMEX_AuditFields
-----------

IF OBJECT_ID('U_ELAIUNUMEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ELAIUNUMEX_DedList
-----------

IF OBJECT_ID('U_ELAIUNUMEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ELAIUNUMEX_drvTbl
-----------

IF OBJECT_ID('U_ELAIUNUMEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEESSN] char(11) NULL,
    [drvID] char(9) NULL,
    [drvEEIDTYPE] varchar(4) NOT NULL,
    [drvEEFIRSTNAME] varchar(100) NULL,
    [drvEEMIDDLEINITIAL] varchar(1) NULL,
    [drvEELASTNAME] varchar(100) NULL,
    [drvEESTADDR1] varchar(8000) NULL,
    [drvEESTADDR2] varchar(8000) NULL,
    [drvEECITY] varchar(255) NULL,
    [drvEERDCSTPVC] varchar(2) NULL,
    [drvEEPOSTALCD] varchar(50) NULL,
    [drvEECNTRYCD] varchar(2) NULL,
    [drvEEWRKSTPVC] varchar(255) NULL,
    [drvEEDOB] char(10) NULL,
    [drvEEGENDER] char(1) NULL,
    [drvMARITALSTATUS] varchar(7) NOT NULL,
    [drvEEJOBTLE] varchar(25) NOT NULL,
    [drvMOSTRCNTHIREDATE] varchar(10) NULL,
    [drvORGHIREDATE] varchar(10) NULL,
    [drvEETERMDATE] varchar(10) NULL,
    [drvEESTATUS] varchar(3) NOT NULL,
    [drvWKLYSCHWRKHRS] nvarchar(4000) NULL,
    [drvDATEOFLSTSLYCHG] nvarchar(4000) NULL,
    [drvEEHOMEPHONE] varchar(50) NULL,
    [drvMGRFIRSTNAME] varchar(256) NULL,
    [drvMGRLASTNAME] varchar(256) NULL,
    [drvMGREMAIL] varchar(256) NULL,
    [drvEESCNDMGREMAIL] varchar(1) NOT NULL,
    [drvEETHRDMGREMAIL] varchar(1) NOT NULL,
    [drvHRWRKEDINPSTMNTHS] nvarchar(4000) NULL,
    [drvWRKONSUN] varchar(1) NOT NULL,
    [drvWRKONMON] varchar(1) NOT NULL,
    [drvWRKONTUES] varchar(1) NOT NULL,
    [drvWRKONWEDS] varchar(1) NOT NULL,
    [drvWRKONTHURS] varchar(1) NOT NULL,
    [drvWRKONFRI] varchar(1) NOT NULL,
    [drvWRKONSAT] varchar(1) NOT NULL,
    [drvOFFCENAME] varchar(9) NOT NULL,
    [drvEEWRKMAILSTADDR1] varchar(1) NOT NULL,
    [drvEEWRKMAILSTADDR2] varchar(1) NOT NULL,
    [drvEEWRKMAILSTADDR3] varchar(1) NOT NULL,
    [drvEEWRKCITY] varchar(1) NOT NULL,
    [drvEEWRKPOSTALCD] varchar(1) NOT NULL,
    [drvFMLARPTINGGRP] varchar(1) NOT NULL,
    [drvKEYEE] varchar(1) NOT NULL,
    [drvEESALMD] char(1) NULL,
    [drvProduct] varchar(3) NULL,
    [drvPOLICYNBR] varchar(6) NULL,
    [drvDivision] varchar(3) NOT NULL,
    [drvPOLICYELGGRP1] varchar(1) NOT NULL,
    [drvEEPOSTTAXCNTRBPCT1] varchar(1) NOT NULL,
    [drvPOLICYELGGRP2] varchar(1) NOT NULL,
    [drvEEPOSTTAXCNTRBPCT2] varchar(3) NOT NULL,
    [drvEarnings] money NULL,
    [drvEARNINGSPRD] varchar(2) NULL,
    [drvEFFDATEOFEECOVG] nvarchar(4000) NULL,
    [drvCOVGTERMDATE] nvarchar(4000) NULL
);

-----------
-- Create table U_ELAIUNUMEX_EEList
-----------

IF OBJECT_ID('U_ELAIUNUMEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELAIUNUMEX_File
-----------

IF OBJECT_ID('U_ELAIUNUMEX_File') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ELAIUNUMEX_PDedHist
-----------

IF OBJECT_ID('U_ELAIUNUMEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_PDedHist] (
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
-- Create table U_ELAIUNUMEX_PEarHist
-----------

IF OBJECT_ID('U_ELAIUNUMEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELAIUNUMEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELAIUNUMEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Laika

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 02/10/2023
Service Request Number: TekP-2022-12-27-01 

Purpose: Unum STD LTD FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELAIUNUMEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELAIUNUMEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELAIUNUMEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELAIUNUMEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELAIUNUMEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAIUNUMEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAIUNUMEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAIUNUMEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAIUNUMEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELAIUNUMEX', 'SCH_ELAIUN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELAIUNUMEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELAIUNUMEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELAIUNUMEX';
    SELECT @FileMinCovDate = '1/1/2023';
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
    DELETE FROM dbo.U_ELAIUNUMEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELAIUNUMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


 --   --==========================================
 --   -- Audit Section
 --   --==========================================
 --   -- Get data from audit fields table. Add fields here if auditing
 --   IF OBJECT_ID('U_ELAIUNUMEX_AuditFields','U') IS NOT NULL
 --       DROP TABLE dbo.U_ELAIUNUMEX_AuditFields;
 --   CREATE TABLE dbo.U_ELAIUNUMEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    --INSERT INTO dbo.U_ELAIUNUMEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
 --   -- Create audit table based on fields defined above
 --   IF OBJECT_ID('U_ELAIUNUMEX_Audit','U') IS NOT NULL
 --       DROP TABLE dbo.U_ELAIUNUMEX_Audit;
 --   SELECT 
 --       audEEID  = audKey1Value
 --       ,audKey2 = audKey2Value
 --       ,audKey3 = audKey3Value
 --       ,audTableName
 --       ,audFieldName
 --       ,audAction
 --       ,audDateTime
 --       ,audOldValue
 --       ,audNewValue
 --       ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
 --   INTO dbo.U_ELAIUNUMEX_Audit
 --   FROM dbo.vw_AuditData WITH (NOLOCK) 
 --   JOIN dbo.U_ELAIUNUMEX_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
 --   WHERE audDateTime BETWEEN @StartDate AND @EndDate
 --   AND audAction <> 'DELETE';

 --   -- Create Index
 --   CREATE CLUSTERED INDEX CDX_U_ELAIUNUMEX_Audit ON dbo.U_ELAIUNUMEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ELAIUNUMEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELAIUNUMEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD,BLTD,EXLTD,LKSTD';

    IF OBJECT_ID('U_ELAIUNUMEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELAIUNUMEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELAIUNUMEX_DedList
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
    --IF OBJECT_ID('U_ELAIUNUMEX_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ELAIUNUMEX_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_ELAIUNUMEX_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ELAIUNUMEX_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ELAIUNUMEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELAIUNUMEX_PEarHist;
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
    INTO dbo.U_ELAIUNUMEX_PEarHist
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
    -- DETAIL RECORD - U_ELAIUNUMEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELAIUNUMEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELAIUNUMEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEESSN = eepSSN
        ,drvID = EecEmpno
        ,drvEEIDTYPE = 'EEID'
        ,drvEEFIRSTNAME = EepNameFirst
        ,drvEEMIDDLEINITIAL = LEFT(EepNameMiddle,1)
        ,drvEELASTNAME = EepNameLast
        ,drvEESTADDR1 = REPLACE(EepAddressLine1, ',', '')
        ,drvEESTADDR2 = REPLACE(EepAddressLine2, ',', '')
        ,drvEECITY = EepAddressCity
        ,drvEERDCSTPVC = LEFT(eepaddressstate,2)
        ,drvEEPOSTALCD = EepAddressZipCode
        ,drvEECNTRYCD = LEFT(eepAddressCountry,2)
        ,drvEEWRKSTPVC = LocAddressState
        ,drvEEDOB = convert(char(10),EepDateOfBirth, 101)
        ,drvEEGENDER = CASE WHEN EepGender IN ('M', 'F') THEN EepGender END
        ,drvMARITALSTATUS = CASE WHEN EepMaritalStatus  IN ('M') THEN 'Married'
                                 WHEN EepMaritalStatus  IN ('S') THEN ' Single' 
                                ELSE 'UNK'  
                            END
        ,drvEEJOBTLE = JbcDesc
        ,drvMOSTRCNTHIREDATE = convert(varchar(10),EecDateOfLastHire, 101)
        ,drvORGHIREDATE = convert(varchar(10),EecDateOfLastHire, 101)
        ,drvEETERMDATE = CASE WHEN EecEmplStatus = 'T' THEN convert(varchar(10),EecDateOfTermination,101) END
        ,drvEESTATUS = CASE WHEN EecEmplStatus = 'L' THEN 'LOA' ELSE 'ACT' END
        ,drvWKLYSCHWRKHRS = FORMAT(EecScheduledWorkHrs*26/52, '0.00')
        ,drvDATEOFLSTSLYCHG = FORMaT(dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GetDate(),EecDateOfLastHire), 'MM/dd/yyyy')
        ,drvEEHOMEPHONE = EepPhoneHomeNumber
        ,drvMGRFIRSTNAME = dbo.dsi_fnlib_GetSupervisorField_V2(EecCoID, EecEEID, 'NameFirst')
        ,drvMGRLASTNAME = dbo.dsi_fnlib_GetSupervisorField_V2(EecCoID, EecEEID, 'NameLast')
        ,drvMGREMAIL = dbo.dsi_fnlib_GetSupervisorField_V2(EecCoID, EecEEID, 'AddressEmail') 
        ,drvEESCNDMGREMAIL = ''
        ,drvEETHRDMGREMAIL = ''
        ,drvHRWRKEDINPSTMNTHS = FORMAT(PehCurHrsYTD, '#0.00')
        ,drvWRKONSUN = ''
        ,drvWRKONMON = ''
        ,drvWRKONTUES = ''
        ,drvWRKONWEDS = ''
        ,drvWRKONTHURS = ''
        ,drvWRKONFRI = ''
        ,drvWRKONSAT = ''
        ,drvOFFCENAME = 'Laika LLC'
        ,drvEEWRKMAILSTADDR1 = ''
        ,drvEEWRKMAILSTADDR2 = ''
        ,drvEEWRKMAILSTADDR3 = ''
        ,drvEEWRKCITY = ''
        ,drvEEWRKPOSTALCD = ''
        ,drvFMLARPTINGGRP = ''
        ,drvKEYEE = ''
        ,drvEESALMD = EecSalaryOrHourly
        ,drvProduct = CASE WHEN STD_DedCode = 'LKSTD' THEN '192' END
        ,drvPOLICYNBR = CASE WHEN STD_DedCode = 'LKSTD' THEN '617390' END
        ,drvDivision = '100'
        ,drvPOLICYELGGRP1 = CASE WHEN CbpBenGroupCode IN ( 'EXEC', 'OOAE') THEN '1' ELSE '2' END
        ,drvEEPOSTTAXCNTRBPCT1 = '0'
        ,drvPOLICYELGGRP2 = CASE WHEN BLTD_DedCode = 'BLTD' THEN '1' 
                                 WHEN EXLTD_DedCode = 'EXLTD' THEN  '2'
                               ELSE '3'
                            END
        ,drvEEPOSTTAXCNTRBPCT2 = CASE WHEN BLTD_DedCode = 'BLTD' then '100' ELSE '0' END
        ,drvEarnings = CASE WHEN STD_DedCode= 'LKSTD' THEN eecannsalary/52
                            WHEN LTD3_DedCode IN ( 'BLTD', 'EXLTD', 'LTD' ) THEN eecannsalary/12
                            END
        ,drvEARNINGSPRD = CASE WHEN STD_DedCode = 'LKSTD' THEN 'WK'
                            WHEN LTD3_DedCode IN ( 'BLTD', 'EXLTD', 'LTD' ) THEN 'MO'
                            END
        ,drvEFFDATEOFEECOVG = CASE WHEN STD_DedCode = 'LKSTD' THEN Format(dbo.dsi_fnGetMinMaxDates('MAX',STD_BenStartDate,@FileMinCovDate), 'MM/dd/yyyy')
                            WHEN LTD3_DedCode IN ( 'BLTD', 'EXLTD', 'LTD' ) THEN Format(dbo.dsi_fnGetMinMaxDates('MAX',LTD_BenStartDate,@FileMinCovDate), 'MM/dd/yyyy')
                            END
        ,drvCOVGTERMDATE = CASE WHEN STD_DedCode = 'LKSTD' THEN Format(STD_BenStopDate, 'MM/dd/yyyy')
                            WHEN LTD3_DedCode IN ( 'BLTD', 'EXLTD', 'LTD' ) THEN Format(LTD_BenStopDate, 'MM/dd/yyyy')
                            END
    INTO dbo.U_ELAIUNUMEX_drvTbl
    FROM dbo.U_ELAIUNUMEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
      LEFT JOIN (
                SELECT BdmEEID, BdmCOID
                    ,MAX(CASE WHEN BdmDedCode IN ('BLTD') THEN BdmDedCode END) AS BLTD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('EXLTD') THEN BdmDedCode END) AS EXLTD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('BLTD', 'EXLTD', 'LTD') THEN BdmDedCode END) AS LTD3_DedCode
                    
                    ,MAX(CASE WHEN BdmDedCode = 'LKSTD' THEN BdmDedCode END) AS STD_DedCode
                    ,MAX(CASE WHEN BdmDedCode = 'LKSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '1/1/2020')  END) AS STD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('BLTD', 'EXLTD', 'LTD') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '1/1/2020')  END) AS LTD_BenStartDate 
                    ,MAX(CASE WHEN BdmDedCode = 'LKSTD' THEN BdmBenStopDate END) AS STD_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('BLTD', 'EXLTD', 'LTD') THEN BdmBenStopDate END) AS LTD_BenStopDate
                FROM dbo.U_dsi_BDM_ELAIUNUMEX WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID
            ) AS Bdm_Flattened
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
      JOIN dbo.Location WITH(NOLOCK)
           ON LocCode = EecLocation
    LEFT JOIN dbo.U_ELAIUNUMEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
     LEFT JOIN dbo.BenProgTI L1 WITH (NOLOCK)
        ON (L1.CbpDedCode = LTD3_DedCode
        OR L1.CbpDedCode = STD_DedCode)
   
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
ALTER VIEW dbo.dsi_vwELAIUNUMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELAIUNUMEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELAIUNUMEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302031'
       ,expStartPerControl     = '202302031'
       ,expLastEndPerControl   = '202302109'
       ,expEndPerControl       = '202302109'
WHERE expFormatCode = 'ELAIUNUMEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELAIUNUMEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELAIUNUMEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELAIUNUMEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELAIUNUMEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELAIUNUMEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELAIUNUMEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELAIUNUMEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELAIUNUMEX', 'UseFileName', 'V', 'Y'


-- End ripout