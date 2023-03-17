/**********************************************************************************

EBAVOY401K: Voya 401K Demographic and Payroll

FormatCode:     EBAVOY401K
Project:        Voya 401K Demographic and Payroll
Client ID:      OUT1004
Date/time:      2023-03-14 10:33:06.797
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPOUTB
Web Filename:   OUT1004_VA7H4_EEHISTORY_EBAVOY401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBAVOY401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EBAVOY401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBAVOY401K'


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
WHERE FormatCode = 'EBAVOY401K'
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
WHERE ExpFormatCode = 'EBAVOY401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBAVOY401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBAVOY401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBAVOY401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBAVOY401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBAVOY401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBAVOY401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBAVOY401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBAVOY401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBAVOY401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBAVOY401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBAVOY401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBAVOY401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBAVOY401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAVOY401K];
GO
IF OBJECT_ID('U_EBAVOY401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_PEarHist];
GO
IF OBJECT_ID('U_EBAVOY401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_PDedHist];
GO
IF OBJECT_ID('U_EBAVOY401K_Header') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_Header];
GO
IF OBJECT_ID('U_EBAVOY401K_File') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_File];
GO
IF OBJECT_ID('U_EBAVOY401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_EEList];
GO
IF OBJECT_ID('U_EBAVOY401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_drvTbl];
GO
IF OBJECT_ID('U_EBAVOY401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_DedList];
GO
IF OBJECT_ID('U_EBAVOY401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBAVOY401K_AuditFields];
GO
IF OBJECT_ID('U_dsi_BDM_EBAVOY401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBAVOY401K];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBAVOY401K','Voya 401K Demographic and Payroll','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EBAVOY401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAVOY401KZ0','13','H','01','1',NULL,'RECORD TYPE',NULL,NULL,'"RECORD TYPE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAVOY401KZ0','13','H','01','2',NULL,'EMPLOYER ID',NULL,NULL,'"EMPLOYER ID"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAVOY401KZ0','15','H','01','3',NULL,'PAYROLL CYCLE',NULL,NULL,'"PAYROLL CYCLE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAVOY401KZ0','10','H','01','4',NULL,'PAY DATE',NULL,NULL,'"PAY DATE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAVOY401KZ0','10','H','01','5',NULL,'IRS CODE',NULL,NULL,'"IRS CODE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAVOY401KZ0','5','H','01','6',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAVOY401KZ0','17','H','01','7',NULL,'EMPLOYEE NUMBER',NULL,NULL,'"EMPLOYEE NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAVOY401KZ0','17','H','01','8',NULL,'DEPARTMENT CODE',NULL,NULL,'"DEPARTMENT CODE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAVOY401KZ0','15','H','01','9',NULL,'LOCATION CODE',NULL,NULL,'"LOCATION CODE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAVOY401KZ0','11','H','01','10',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAVOY401KZ0','12','H','01','11',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAVOY401KZ0','4','H','01','12',NULL,'MI',NULL,NULL,'"MI"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAVOY401KZ0','16','H','01','13',NULL,'ADDRESS LINE 1',NULL,NULL,'"ADDRESS LINE 1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAVOY401KZ0','16','H','01','14',NULL,'ADDRESS LINE 2',NULL,NULL,'"ADDRESS LINE 2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAVOY401KZ0','6','H','01','15',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAVOY401KZ0','7','H','01','16',NULL,'STATE',NULL,NULL,'"STATE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAVOY401KZ0','10','H','01','17',NULL,'ZIP CODE',NULL,NULL,'"ZIP CODE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAVOY401KZ0','15','H','01','18',NULL,'ZIP EXTENSION',NULL,NULL,'"ZIP EXTENSION"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAVOY401KZ0','8','H','01','19',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAVOY401KZ0','10','H','01','20',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAVOY401KZ0','16','H','01','21',NULL,'MARITAL STATUS',NULL,NULL,'"MARITAL STATUS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAVOY401KZ0','22','H','01','22',NULL,'EMPLOYEE STATUS CODE',NULL,NULL,'"EMPLOYEE STATUS CODE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAVOY401KZ0','15','H','01','23',NULL,'DATE OF BIRTH',NULL,NULL,'"DATE OF BIRTH"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAVOY401KZ0','23','H','01','24',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL,'"DATE OF ORIGINAL HIRE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAVOY401KZ0','21','H','01','25',NULL,'DATE OF TERMINATION',NULL,NULL,'"DATE OF TERMINATION"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAVOY401KZ0','16','H','01','26',NULL,'DATE OF REHIRE',NULL,NULL,'"DATE OF REHIRE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBAVOY401KZ0','29','H','01','27',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL,'"LEAVE OF ABSENCE START DATE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBAVOY401KZ0','27','H','01','28',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL,'"LEAVE OF ABSENCE END DATE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBAVOY401KZ0','16','H','01','29',NULL,'PLAN YTD HOURS',NULL,NULL,'"PLAN YTD HOURS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBAVOY401KZ0','22','H','01','30',NULL,'CURRENT PERIOD HOURS',NULL,NULL,'"CURRENT PERIOD HOURS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBAVOY401KZ0','19','H','01','31',NULL,'ANNIVERSARY HOURS',NULL,NULL,'"ANNIVERSARY HOURS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBAVOY401KZ0','15','H','01','32',NULL,'SOURCE CODE 1',NULL,NULL,'"SOURCE CODE 1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBAVOY401KZ0','32','H','01','33',NULL,'CONTRIBUTION AMOUNT SOURCE # 1',NULL,NULL,'"drvCONTRIBUTIONAMOUNTSOURCE1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBAVOY401KZ0','15','H','01','34',NULL,'SOURCE CODE 2',NULL,NULL,'"SOURCE CODE 2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBAVOY401KZ0','32','H','01','35',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL,'"drvCONTRIBUTIONAMOUNTSOURCE2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBAVOY401KZ0','15','H','01','36',NULL,'SOURCE CODE 3',NULL,NULL,'"SOURCE CODE 3"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBAVOY401KZ0','32','H','01','37',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL,'"drvCONTRIBUTIONAMOUNTSOURCE3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBAVOY401KZ0','15','H','01','38',NULL,'SOURCE CODE 4',NULL,NULL,'"SOURCE CODE 4"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBAVOY401KZ0','32','H','01','39',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL,'"drvCONTRIBUTIONAMOUNTSOURCE4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBAVOY401KZ0','15','H','01','40',NULL,'SOURCE CODE 5',NULL,NULL,'"SOURCE CODE 5"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBAVOY401KZ0','32','H','01','41',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL,'"drvCONTRIBUTIONAMOUNTSOURCE5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBAVOY401KZ0','15','H','01','42',NULL,'SOURCE CODE 6',NULL,NULL,'"SOURCE CODE 6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBAVOY401KZ0','32','H','01','43',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL,'"drvCONTRIBUTIONAMOUNTSOURCE6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBAVOY401KZ0','13','H','01','44',NULL,'LOAN NUMBER',NULL,NULL,'"LOAN NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBAVOY401KZ0','23','H','01','45',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"EMPLOYEE LOAN PAYMENT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBAVOY401KZ0','13','H','01','46',NULL,'LOAN NUMBER',NULL,NULL,'"LOAN NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBAVOY401KZ0','23','H','01','47',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"EMPLOYEE LOAN PAYMENT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBAVOY401KZ0','13','H','01','48',NULL,'LOAN NUMBER',NULL,NULL,'"LOAN NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBAVOY401KZ0','23','H','01','49',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"EMPLOYEE LOAN PAYMENT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBAVOY401KZ0','13','H','01','50',NULL,'LOAN NUMBER',NULL,NULL,'"LOAN NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBAVOY401KZ0','23','H','01','51',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"EMPLOYEE LOAN PAYMENT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBAVOY401KZ0','13','H','01','52',NULL,'LOAN NUMBER',NULL,NULL,'"LOAN NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBAVOY401KZ0','23','H','01','53',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"EMPLOYEE LOAN PAYMENT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBAVOY401KZ0','13','H','01','54',NULL,'LOAN NUMBER',NULL,NULL,'"LOAN NUMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBAVOY401KZ0','23','H','01','55',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"EMPLOYEE LOAN PAYMENT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBAVOY401KZ0','14','H','01','56',NULL,'UNION MEMBER',NULL,NULL,'"UNION MEMBER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBAVOY401KZ0','27','H','01','57',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL,'"EMPLOYEE ELIGIBILITY CODE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBAVOY401KZ0','10','H','01','58',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBAVOY401KZ0','24','H','01','59',NULL,'YTD GROSS COMPENSATION',NULL,NULL,'"YTD GROSS COMPENSATION"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBAVOY401KZ0','10','H','01','60',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBAVOY401KZ0','33','H','01','61',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL,'"drvYTDTESTADPCOMPENSATION"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBAVOY401KZ0','37','H','01','62',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL,'"drvYTDALLOCATIONBENCOMP"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBAVOY401KZ0','10','H','01','63',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBAVOY401KZ0','15','H','01','64',NULL,'ANNUAL SALARY',NULL,NULL,'"ANNUAL SALARY"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBAVOY401KZ0','28','H','01','65',NULL,'MISCELLANEOUS COMPENSATION',NULL,NULL,'"MISCELLANEOUS COMPENSATION"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBAVOY401KZ0','10','H','01','66',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBAVOY401KZ0','10','H','01','67',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBAVOY401KZ0','24','H','01','68',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL,'"KEY EMPLOYEE INDICATOR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBAVOY401KZ0','10','H','01','69',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBAVOY401KZ0','10','H','01','70',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBAVOY401KZ0','29','H','01','71',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL,'"HIGHLY COMPENSATED EMPLOYEE"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBAVOY401KZ0','21','H','01','72',NULL,'NON-RESIDENT ALIEN?',NULL,NULL,'"NON-RESIDENT ALIEN?"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBAVOY401KZ0','10','H','01','73',NULL,'RESERVED',NULL,NULL,'"RESERVED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBAVOY401KZ0','15','H','01','74',NULL,'EMAIL ADDRESS',NULL,NULL,'"EMAIL ADDRESS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBAVOY401KZ0','12','H','01','75',NULL,'TIER GROUP',NULL,NULL,'"TIER GROUP"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBAVOY401KZ0','15','H','01','76',NULL,'CLIENT DATA 1',NULL,NULL,'"CLIENT DATA 1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBAVOY401KZ0','15','H','01','77',NULL,'CLIENT DATE 1',NULL,NULL,'"CLIENT DATE 1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBAVOY401KZ0','8','H','01','78',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBAVOY401KZ0','7','D','10','1',NULL,'RECORD TYPE',NULL,NULL,'"INGWIN6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBAVOY401KZ0','6','D','10','2',NULL,'EMPLOYER ID',NULL,NULL,'"551760"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBAVOY401KZ0','1','D','10','3',NULL,'PAYROLL CYCLE',NULL,NULL,'"drvPayrollCycle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBAVOY401KZ0','8','D','10','4',NULL,'PAY DATE',NULL,NULL,'"drvPayDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBAVOY401KZ0','4','D','10','5',NULL,'IRS CODE',NULL,NULL,'"drvIrsCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBAVOY401KZ0','9','D','10','6',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBAVOY401KZ0','10','D','10','7',NULL,'EMPLOYEE NUMBER',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBAVOY401KZ0','10','D','10','8',NULL,'DEPARTMENT CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBAVOY401KZ0','4','D','10','9',NULL,'LOCATION CODE',NULL,NULL,'"drvLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBAVOY401KZ0','20','D','10','10',NULL,'LAST NAME',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBAVOY401KZ0','15','D','10','11',NULL,'FIRST NAME',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBAVOY401KZ0','1','D','10','12',NULL,'MI',NULL,NULL,'"drvMI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBAVOY401KZ0','25','D','10','13',NULL,'ADDRESS LINE 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBAVOY401KZ0','25','D','10','14',NULL,'ADDRESS LINE 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBAVOY401KZ0','20','D','10','15',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBAVOY401KZ0','2','D','10','16',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBAVOY401KZ0','5','D','10','17',NULL,'ZIP CODE',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBAVOY401KZ0','4','D','10','18',NULL,'ZIP EXTENSION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBAVOY401KZ0','1','D','10','19',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBAVOY401KZ0','20','D','10','20',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBAVOY401KZ0','1','D','10','21',NULL,'MARITAL STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBAVOY401KZ0','1','D','10','22',NULL,'EMPLOYEE STATUS CODE',NULL,NULL,'"drvEmployeeStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBAVOY401KZ0','8','D','10','23',NULL,'DATE OF BIRTH',NULL,NULL,'"drvDateOfBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBAVOY401KZ0','8','D','10','24',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL,'"drvDateOfOriginalHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBAVOY401KZ0','8','D','10','25',NULL,'DATE OF TERMINATION',NULL,NULL,'"drvDateOfTermination"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBAVOY401KZ0','8','D','10','26',NULL,'DATE OF REHIRE',NULL,NULL,'"drvDateOfRehire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBAVOY401KZ0','8','D','10','27',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL,'"drvLeaveOfAbsenceStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBAVOY401KZ0','8','D','10','28',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL,'"drvLeaveOfAbsenceEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBAVOY401KZ0','4','D','10','29',NULL,'PLAN YTD HOURS',NULL,NULL,'"drvPlanYtdHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBAVOY401KZ0','4','D','10','30',NULL,'CURRENT PERIOD HOURS',NULL,NULL,'"drvCurrentPeriodHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBAVOY401KZ0','4','D','10','31',NULL,'ANNIVERSARY HOURS',NULL,NULL,'"drvAnniversaryHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBAVOY401KZ0','1','D','10','32',NULL,'SOURCE CODE 1',NULL,NULL,'"drvSourceCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBAVOY401KZ0','9','D','10','33',NULL,'CONTRIBUTION AMOUNT SOURCE # 1',NULL,NULL,'"drvContributionAmountSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBAVOY401KZ0','1','D','10','34',NULL,'SOURCE CODE 2',NULL,NULL,'"drvSourceCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBAVOY401KZ0','9','D','10','35',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL,'"drvContributionAmountSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBAVOY401KZ0','1','D','10','36',NULL,'SOURCE CODE 3',NULL,NULL,'"drvSourceCode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBAVOY401KZ0','9','D','10','37',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL,'"drvContributionAmountSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBAVOY401KZ0','1','D','10','38',NULL,'SOURCE CODE 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBAVOY401KZ0','9','D','10','39',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBAVOY401KZ0','1','D','10','40',NULL,'SOURCE CODE 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBAVOY401KZ0','9','D','10','41',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBAVOY401KZ0','1','D','10','42',NULL,'SOURCE CODE 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBAVOY401KZ0','9','D','10','43',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBAVOY401KZ0','3','D','10','44',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBAVOY401KZ0','9','D','10','45',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBAVOY401KZ0','3','D','10','46',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBAVOY401KZ0','9','D','10','47',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBAVOY401KZ0','3','D','10','48',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBAVOY401KZ0','9','D','10','49',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBAVOY401KZ0','3','D','10','50',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBAVOY401KZ0','9','D','10','51',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBAVOY401KZ0','3','D','10','52',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBAVOY401KZ0','9','D','10','53',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBAVOY401KZ0','3','D','10','54',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBAVOY401KZ0','9','D','10','55',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBAVOY401KZ0','1','D','10','56',NULL,'UNION MEMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBAVOY401KZ0','1','D','10','57',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL,'"drvEmployeeEligibilityCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBAVOY401KZ0','8','D','10','58',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBAVOY401KZ0','11','D','10','59',NULL,'YTD GROSS COMPENSATION',NULL,NULL,'"drvYtdGrossCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBAVOY401KZ0','11','D','10','60',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBAVOY401KZ0','11','D','10','61',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL,'"drvYtdTestAdpCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBAVOY401KZ0','11','D','10','62',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL,'"drvYtdAllocationBenefitComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBAVOY401KZ0','11','D','10','63',NULL,'RESERVED',NULL,NULL,'"00000000000"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBAVOY401KZ0','11','D','10','64',NULL,'ANNUAL SALARY',NULL,NULL,'"drvAnnualSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBAVOY401KZ0','11','D','10','65',NULL,'MISCELLANEOUS COMPENSATION',NULL,NULL,'"drvMiscellaneousCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBAVOY401KZ0','1','D','10','66',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBAVOY401KZ0','9','D','10','67',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBAVOY401KZ0','1','D','10','68',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBAVOY401KZ0','1','D','10','69',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBAVOY401KZ0','5','D','10','70',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBAVOY401KZ0','1','D','10','71',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL,'"drvHighlyCompensatedEmployee"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBAVOY401KZ0','1','D','10','72',NULL,'NON-RESIDENT ALIEN?',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBAVOY401KZ0','1','D','10','73',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBAVOY401KZ0','40','D','10','74',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBAVOY401KZ0','4','D','10','75',NULL,'TIER GROUP',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBAVOY401KZ0','10','D','10','76',NULL,'CLIENT DATA 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBAVOY401KZ0','8','D','10','77',NULL,'CLIENT DATE 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBAVOY401KZ0','10','D','10','78',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBAVOY401K_20230314.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Voya 401K Demographic and Payr','202303149','EMPEXPORT','ONDEM_XOE',NULL,'EBAVOY401K',NULL,NULL,NULL,'202303149','Mar 14 2023  9:02AM','Mar 14 2023  9:02AM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya 401K Demographic an-Sched','202303149','EMPEXPORT','SCH_EBAVOY',NULL,'EBAVOY401K',NULL,NULL,NULL,'202303149','Mar 14 2023  9:02AM','Mar 14 2023  9:02AM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Voya 401K Demographic an-Test','202303149','EMPEXPORT','TEST_XOE',NULL,'EBAVOY401K',NULL,NULL,NULL,'202303149','Mar 14 2023  9:02AM','Mar 14 2023  9:02AM','202302011',NULL,'','','202302011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBAVOY401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAVOY401K','H01','dbo.U_EBAVOY401K_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBAVOY401K','D10','dbo.U_EBAVOY401K_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBAVOY401K
-----------

IF OBJECT_ID('U_dsi_BDM_EBAVOY401K') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBAVOY401K] (
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
-- Create table U_EBAVOY401K_AuditFields
-----------

IF OBJECT_ID('U_EBAVOY401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBAVOY401K_DedList
-----------

IF OBJECT_ID('U_EBAVOY401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBAVOY401K_drvTbl
-----------

IF OBJECT_ID('U_EBAVOY401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPayrollCycle] varchar(1) NULL,
    [drvPayDate] varchar(8) NULL,
    [drvIrsCode] varchar(4) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLocationCode] varchar(4) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMI] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvGENDER] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvEmployeeStatusCode] varchar(1) NULL,
    [drvDateOfBirth] varchar(8) NULL,
    [drvDateOfOriginalHire] varchar(8) NULL,
    [drvDateOfTermination] varchar(8) NULL,
    [drvDateOfRehire] varchar(8) NULL,
    [drvLeaveOfAbsenceStartDate] varchar(8) NULL,
    [drvLeaveOfAbsenceEndDate] varchar(8) NULL,
    [drvPlanYtdHours] nvarchar(4000) NULL,
    [drvCurrentPeriodHours] nvarchar(4000) NULL,
    [drvAnniversaryHours] varchar(1) NOT NULL,
    [drvSourceCode1] varchar(1) NOT NULL,
    [drvContributionAmountSource1] varchar(24) NULL,
    [drvSourceCode2] varchar(1) NOT NULL,
    [drvContributionAmountSource2] varchar(24) NULL,
    [drvSourceCode3] varchar(1) NOT NULL,
    [drvContributionAmountSource3] varchar(24) NULL,
    [drvLoanNumber1] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment1] varchar(24) NULL,
    [drvLoanNumber2] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment2] varchar(24) NULL,
    [drvLoanNumber3] varchar(3) NOT NULL,
    [drvLoanNumber4] varchar(3) NOT NULL,
    [drvLoanNumber5] varchar(3) NOT NULL,
    [drvLoanNumber6] varchar(3) NOT NULL,
    [drvEmployeeEligibilityCode] varchar(1) NULL,
    [drvYtdGrossCompensation] varchar(24) NULL,
    [drvYtdTestAdpCompensation] varchar(11) NOT NULL,
    [drvYtdAllocationBenefitComp] varchar(11) NOT NULL,
    [drvAnnualSalary] varchar(24) NULL,
    [drvMiscellaneousCompensation] varchar(11) NOT NULL,
    [drvHighlyCompensatedEmployee] char(1) NULL,
    [drvEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_EBAVOY401K_EEList
-----------

IF OBJECT_ID('U_EBAVOY401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBAVOY401K_File
-----------

IF OBJECT_ID('U_EBAVOY401K_File') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EBAVOY401K_Header
-----------

IF OBJECT_ID('U_EBAVOY401K_Header') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_Header] (
    [drvCONTRIBUTIONAMOUNTSOURCE1] varchar(30) NOT NULL,
    [drvCONTRIBUTIONAMOUNTSOURCE2] varchar(30) NOT NULL,
    [drvCONTRIBUTIONAMOUNTSOURCE3] varchar(30) NOT NULL,
    [drvCONTRIBUTIONAMOUNTSOURCE4] varchar(30) NOT NULL,
    [drvCONTRIBUTIONAMOUNTSOURCE5] varchar(30) NOT NULL,
    [drvCONTRIBUTIONAMOUNTSOURCE6] varchar(30) NOT NULL,
    [drvYTDTESTADPCOMPENSATION] varchar(31) NOT NULL,
    [drvYTDALLOCATIONBENCOMP] varchar(35) NOT NULL
);

-----------
-- Create table U_EBAVOY401K_PDedHist
-----------

IF OBJECT_ID('U_EBAVOY401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401] numeric NULL,
    [PdhRoth] numeric NULL,
    [Pdh401M] numeric NULL,
    [Pdh401L] numeric NULL,
    [Pdh401L2] numeric NULL
);

-----------
-- Create table U_EBAVOY401K_PEarHist
-----------

IF OBJECT_ID('U_EBAVOY401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBAVOY401K_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBAVOY401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Blue Acorn

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 03/14/2023
Service Request Number: TekP-2022-11-21-10

Purpose: Voya 401K Demographic and Payroll

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBAVOY401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBAVOY401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBAVOY401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBAVOY401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBAVOY401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAVOY401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAVOY401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBAVOY401K', 'SCH_EBAVOY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBAVOY401K';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBAVOY401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBAVOY401K';

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
    DELETE FROM dbo.U_EBAVOY401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBAVOY401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    ----==========================================
    ---- Audit Section
    ----==========================================
    ---- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EBAVOY401K_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EBAVOY401K_AuditFields;
    --CREATE TABLE dbo.U_EBAVOY401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EBAVOY401K_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EBAVOY401K_Audit;
    --SELECT 
    --    audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --INTO dbo.U_EBAVOY401K_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    --JOIN dbo.U_EBAVOY401K_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE';

    ---- Create Index
    --CREATE CLUSTERED INDEX CDX_U_EBAVOY401K_Audit ON dbo.U_EBAVOY401K_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EBAVOY401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBAVOY401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F,401P,ROTHF,ROTHP,401M,401L,401L2,401CF,401CP';

    IF OBJECT_ID('U_EBAVOY401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBAVOY401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBAVOY401K_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EBAVOY401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBAVOY401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401     = SUM(CASE WHEN PdhDedCode IN ('401F','401P','401CF','401CP') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth     = SUM(CASE WHEN PdhDedCode IN ('ROTHF', 'ROTHP') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401M     = SUM(CASE WHEN PdhDedCode IN ('401M') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)        
        ,Pdh401L     = SUM(CASE WHEN PdhDedCode IN ('401L') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401L2     = SUM(CASE WHEN PdhDedCode IN ('401L2') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
  
    INTO dbo.U_EBAVOY401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBAVOY401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
  --  AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBAVOY401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBAVOY401K_PEarHist;
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
    INTO dbo.U_EBAVOY401K_PEarHist
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
    -- DETAIL RECORD - U_EBAVOY401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBAVOY401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBAVOY401K_drvTbl;
      
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = xEEID
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPayrollCycle = CASE  EecPayPeriod 
                                WHEN 'M' THEN '4'
                                WHEN 'S' THEN '5'
                                WHEN 'B' THEN '6'
                                WHEN 'W' THEN '7'
                            END
        ,drvPayDate =  Case when isnull(CONVERT(VARCHAR(8),PrgPayDate, 112), '' ) <> '' THEN CONVERT(VARCHAR(8),PrgPayDate, 112) ELSE CONVERT(VARCHAR(8),getdate() , 112) END
        ,drvIrsCode = '401K'
        ,drvSSN = eepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvLocationCode = '0001'
        ,drvLastName = UPPER(EepNameLast)
        ,drvFirstName = UPPER(EepNameFirst)
        ,drvMI = UPPER(LEFT(EepNameMiddle,1))
        ,drvAddressLine1 = UPPER(EepAddressLine1)
        ,drvAddressLine2 = UPPER(EepAddressLine2)
        ,drvCITY = UPPER(EepAddressCity)
        ,drvSTATE = UPPER(EepAddressState)
        ,drvZipCode = EepAddressZipCode
        ,drvGENDER = CASE EepGender
                        WHEN 'M' THEN 'M'
                        WHEN 'F' THEN 'F'
                    END
        ,drvMaritalStatus = CASE eepMaritalStatus
                                WHEN  'S' THEN 'S'
                                WHEN 'M' THEN 'M'
                            END
        ,drvEmployeeStatusCode = CASE WHEN EecEmplStatus IN ('A','L', 'T') THEN UPPER(EecEmplStatus)                
                                END
        ,drvDateOfBirth = CONVERT(VARCHAR(8),EepDateOfBirth , 112)
        ,drvDateOfOriginalHire =  CONVERT(VARCHAR(8),EecDateOfOriginalHire , 112)
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN  CONVERT(VARCHAR(8),EecDateOfTermination,112) END
        ,drvDateOfRehire = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND (EecJobChangeReason = '101' OR EecHireSource = 'REHIRE') then  CONVERT(VARCHAR(8),EecDateOfLastHire, 112)
                                    Else  CONVERT(VARCHAR(8),EecDateOfOriginalHire,112)
                                END
        ,drvLeaveOfAbsenceStartDate = CASE WHEN EecEmplStatus = 'L' THEN  CONVERT(VARCHAR(8),EecEmplStatusStartDate, 112) END
        ,drvLeaveOfAbsenceEndDate = CASE WHEN EecEmplStatus = 'A' and EshEmplStatus = 'L' THEN   CONVERT(VARCHAR(8),EshStatusStopDate, 112) END
        ,drvPlanYtdHours = FORMAT(PehCurHrsYTD, '0000')
        ,drvCurrentPeriodHours = FORMAT(PehCurHrs, '0000')
        ,drvAnniversaryHours = ''
        ,drvSourceCode1 =  'A' 
        ,drvContributionAmountSource1 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401 as decimal(18,8)),'0.######'), '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401 as decimal(18,8)),'0.######'), '.',''),9,0) END 
        ,drvSourceCode2 =  'G' 
        ,drvContributionAmountSource2 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(format(cast(PdhRoth as decimal(18,8)),'0.######'), '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(format(cast(PdhRoth as decimal(18,8)),'0.######'), '.',''),9,0) END 
        ,drvSourceCode3 =  'X' 
        ,drvContributionAmountSource3 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401M as decimal(18,8)),'0.######'), '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401M as decimal(18,8)),'0.######'), '.',''),9,0) END 
        ,drvLoanNumber1 =  '001' 
        ,drvEmployeeLoanPayment1 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401L as decimal(18,8)),'0.######'), '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401L as decimal(18,8)),'0.######'), '.',''),9,0) END 
        ,drvLoanNumber2 =  '002' 
        ,drvEmployeeLoanPayment2 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401L2 as decimal(18,8)),'0.######'), '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(format(cast(Pdh401L2 as decimal(18,8)),'0.######'), '.',''),9,0) END 
        ,drvLoanNumber3 = '000'
        ,drvLoanNumber4 = '000'
        ,drvLoanNumber5 = '000'
        ,drvLoanNumber6 = '000'
        ,drvEmployeeEligibilityCode = CASE WHEN EecEmplStatus = 'A' AND BdmBenStatus = 'A' THEN 'Y'
                                           WHEN EecEmplStatus = 'T'  OR  BdmBenStatus IN ('C','T')  THEN 'N' 
                                        END
        ,drvYtdGrossCompensation =  CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(PehCurAmtYTD, '.',''),11,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(PehCurAmtYTD, '.',''),11,0)  END
        ,drvYtdTestAdpCompensation = '00000000000'
        ,drvYtdAllocationBenefitComp = '00000000000'
        ,drvAnnualSalary = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(EecAnnSalary, '.',''),11,0), '') <> '' THEn dbo.dsi_fnPadZero(REPLACE(EecAnnSalary, '.',''),11,0)  ELSE dbo.dsi_fnPadZero('',11, 0) END
        ,drvMiscellaneousCompensation = '00000000000'
        ,drvHighlyCompensatedEmployee = EecIsHighlyComp
        ,drvEmailAddress = EepAddressEMail
    INTO dbo.U_EBAVOY401K_drvTbl
    FROM dbo.U_EBAVOY401K_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBAVOY401K WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EBAVOY401K_PEarHist WITH (NOLOCK)
        ON PehEEID= XEEID
    JOIN dbo.U_EBAVOY401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    WHERE EecEEType NOT IN ('CON','INT','SUM','TMP','VOL','TES')
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (Pdh401  > 0  OR Pdh401M > 0 OR PdhRoth > 0    OR PehCurHrsYTD > 0 OR PehCurAmt > 0)) OR (EecEmplStatus = 'T' AND ( EecDateOfTermination Between @StartDate and @EndDate)))
    ;
  
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBAVOY401K_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBAVOY401K_Header;
    SELECT DISTINCT
         drvCONTRIBUTIONAMOUNTSOURCE1 = 'CONTRIBUTION AMOUNT SOURCE # 1'         
        ,drvCONTRIBUTIONAMOUNTSOURCE2 = 'CONTRIBUTION AMOUNT SOURCE # 2'
        ,drvCONTRIBUTIONAMOUNTSOURCE3 = 'CONTRIBUTION AMOUNT SOURCE # 3'
        ,drvCONTRIBUTIONAMOUNTSOURCE4 = 'CONTRIBUTION AMOUNT SOURCE # 4'
        ,drvCONTRIBUTIONAMOUNTSOURCE5 = 'CONTRIBUTION AMOUNT SOURCE # 5'
        ,drvCONTRIBUTIONAMOUNTSOURCE6 = 'CONTRIBUTION AMOUNT SOURCE # 6'
        ,drvYTDTESTADPCOMPENSATION = 'YTD TEST (ADP/ACP) COMPENSATION'
        ,drvYTDALLOCATIONBENCOMP = 'YTD ALLOCATION/BENEFIT COMPENSATION'
    INTO dbo.U_EBAVOY401K_Header
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
ALTER VIEW dbo.dsi_vwEBAVOY401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBAVOY401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBAVOY401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302011'
       ,expStartPerControl     = '202302011'
       ,expLastEndPerControl   = '202303149'
       ,expEndPerControl       = '202303149'
WHERE expFormatCode = 'EBAVOY401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBAVOY401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBAVOY401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBAVOY401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBAVOY401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBAVOY401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAVOY401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBAVOY401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBAVOY401K', 'UseFileName', 'V', 'Y'


-- End ripout