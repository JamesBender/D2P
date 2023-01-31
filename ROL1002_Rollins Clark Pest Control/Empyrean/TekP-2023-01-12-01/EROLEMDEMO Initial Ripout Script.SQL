/**********************************************************************************

EROLEMDEMO: Empyrean Demographic Export

FormatCode:     EROLEMDEMO
Project:        Empyrean Demographic Export
Client ID:      USG1000
Date/time:      2023-01-31 07:46:57.763
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EROLEMDEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EROLEMDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_EROLEMDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EROLEMDEMO'


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
WHERE FormatCode = 'EROLEMDEMO'
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
WHERE ExpFormatCode = 'EROLEMDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EROLEMDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EROLEMDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EROLEMDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EROLEMDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EROLEMDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EROLEMDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EROLEMDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EROLEMDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EROLEMDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EROLEMDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEROLEMDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEROLEMDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EROLEMDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLEMDEMO];
GO
IF OBJECT_ID('U_EROLEMDEMO_Header') IS NOT NULL DROP TABLE [dbo].[U_EROLEMDEMO_Header];
GO
IF OBJECT_ID('U_EROLEMDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EROLEMDEMO_File];
GO
IF OBJECT_ID('U_EROLEMDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EROLEMDEMO_EEList];
GO
IF OBJECT_ID('U_EROLEMDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EROLEMDEMO_drvTbl];
GO
IF OBJECT_ID('U_EROLEMDEMO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EROLEMDEMO_AuditFields];
GO
IF OBJECT_ID('U_EROLEMDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EROLEMDEMO_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EROLEMDEMO','Empyrean Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EROLEMDEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLEMDEMOZ0','2','H','01','1',NULL,'LINE ID',NULL,NULL,'"LINE ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLEMDEMOZ0','10','H','01','2',NULL,'EMPLOYER ID',NULL,NULL,'"EMPLOYER ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLEMDEMOZ0','9','H','01','3',NULL,'EMPLOYEE SSN',NULL,NULL,'"EMPLOYEE SSN"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLEMDEMOZ0','10','H','01','4',NULL,'EMPLOYEE ID',NULL,NULL,'"EMPLOYEE ID"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLEMDEMOZ0','30','H','01','5',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLEMDEMOZ0','30','H','01','6',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLEMDEMOZ0','30','H','01','7',NULL,'MIDDLE NAME / INITIAL',NULL,NULL,'"MIDDLE NAME / INITIAL"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EROLEMDEMOZ0','10','H','01','8',NULL,'SUFFIX',NULL,NULL,'"SUFFIX"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EROLEMDEMOZ0','10','H','01','9',NULL,'BIRTHDATE',NULL,NULL,'"BIRTHDATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EROLEMDEMOZ0','1','H','01','10',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EROLEMDEMOZ0','40','H','01','11',NULL,'ADDRESS1',NULL,NULL,'"ADDRESS1"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EROLEMDEMOZ0','40','H','01','12',NULL,'ADDRESS2',NULL,NULL,'"ADDRESS2"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EROLEMDEMOZ0','40','H','01','13',NULL,'ADDRESS3',NULL,NULL,'"ADDRESS3"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EROLEMDEMOZ0','50','H','01','14',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EROLEMDEMOZ0','2','H','01','15',NULL,'STATE',NULL,NULL,'"STATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EROLEMDEMOZ0','10','H','01','16',NULL,'POSTAL CODE',NULL,NULL,'"POSTAL CODE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EROLEMDEMOZ0','2','H','01','17',NULL,'COUNTRY',NULL,NULL,'"COUNTRY"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EROLEMDEMOZ0','10','H','01','18',NULL,'ADDRESS EFFECTIVE DATE',NULL,NULL,'"ADDRESS EFFECTIVE DATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EROLEMDEMOZ0','10','H','01','19',NULL,'HOME PHONE',NULL,NULL,'"HOME PHONE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EROLEMDEMOZ0','10','H','01','20',NULL,'WORK PHONE',NULL,NULL,'"WORK PHONE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EROLEMDEMOZ0','10','H','01','21',NULL,'MOBILE PHONE',NULL,NULL,'"MOBILE PHONE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EROLEMDEMOZ0','200','H','01','22',NULL,'WORK E-MAIL ADDRESS',NULL,NULL,'"WORK E-MAIL ADDRESS"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EROLEMDEMOZ0','200','H','01','23',NULL,'PERSONAL E-MAIL ADDRESS',NULL,NULL,'"PERSONAL E-MAIL ADDRESS"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EROLEMDEMOZ0','10','H','01','24',NULL,'ORIGINAL HIRE DATE',NULL,NULL,'"ORIGINAL HIRE DATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EROLEMDEMOZ0','10','H','01','25',NULL,'LATEST HIRE DATE',NULL,NULL,'"LATEST HIRE DATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EROLEMDEMOZ0','1','H','01','26',NULL,'EMPLOYMENT STATUS',NULL,NULL,'"EMPLOYMENT STATUS"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EROLEMDEMOZ0','10','H','01','27',NULL,'EMPLOYMENT STATUS EFFECTIVE DATE',NULL,NULL,'"drvEMPLOYMENTSTATUSEFFEDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EROLEMDEMOZ0','10','H','01','28',NULL,'DEATH DATE ATTRIBUTE',NULL,NULL,'"DEATH DATE ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EROLEMDEMOZ0','10','H','01','29',NULL,'TERMINATION DATE ATTRIBUTE',NULL,NULL,'"TERMINATION DATE ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EROLEMDEMOZ0','30','H','01','30',NULL,'CURRENT ANNUAL SALARY ATTRIBUTE',NULL,NULL,'"drvCURRENTANNUALSALARYATTR"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EROLEMDEMOZ0','10','H','01','31',NULL,'CURRENT SALARY ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvCURRENTSALARYATTRIBEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EROLEMDEMOZ0','4','H','01','32',NULL,'PAY FREQUENCY ATTRIBUTE',NULL,NULL,'"PAY FREQUENCY ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EROLEMDEMOZ0','10','H','01','33',NULL,'PAY FREQUENCY ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvPAYFREQUENCYATTRIBEFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EROLEMDEMOZ0','9','H','01','34',NULL,'EMPLOYER/COMPANY EIN ATTRIBUTE',NULL,NULL,'"drvEMPLOYERCOMPANYEINATTRIB"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EROLEMDEMOZ0','10','H','01','35',NULL,'EIN ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"EIN ATTRIBUTE EFFECTIVE DATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EROLEMDEMOZ0','1','H','01','36',NULL,'FULL-TIME/PART-TIME ATTRIBUTE',NULL,NULL,'"FULL-TIME/PART-TIME ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EROLEMDEMOZ0','10','H','01','37',NULL,'FULL-TIME/PART-TIME ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvFULLTIMEPARTTIMEEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EROLEMDEMOZ0','30','H','01','38',NULL,'TERM REASON CODE ATTRIBUTE',NULL,NULL,'"TERM REASON CODE ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EROLEMDEMOZ0','10','H','01','39',NULL,'TERM REASON CODE ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvTERMREASONCODEATTREFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EROLEMDEMOZ0','30','H','01','40',NULL,'LEAVE REASON CODE ATTRIBUTE',NULL,NULL,'"LEAVE REASON CODE ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EROLEMDEMOZ0','10','H','01','41',NULL,'LEAVE REASON ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvLEAVEREASONATTREFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EROLEMDEMOZ0','10','H','01','42',NULL,'RETIREMENT DATE ATTRIBUTE',NULL,NULL,'"RETIREMENT DATE ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EROLEMDEMOZ0','1','H','01','43',NULL,'FULL-TIME/PART-TIME INDICATOR (ACA) ATTRIBUTE',NULL,NULL,'"drvFULLTIMEPARTTIMEINDICATOR"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EROLEMDEMOZ0','10','H','01','44',NULL,'FULL-TIME/PART-TIME INDICATOR (ACA) ATTRIBUTE EFFE',NULL,NULL,'"drvFULLTIMEPARTTIMEINDEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EROLEMDEMOZ0','55','H','01','45',NULL,'EXTERNAL_IDENTIFIER',NULL,NULL,'"EXTERNAL_IDENTIFIER"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EROLEMDEMOZ0','9','H','01','46',NULL,'ALT_SSN',NULL,NULL,'"ALT_SSN"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EROLEMDEMOZ0','10','H','01','47',NULL,'TERMINATION TYPE ATTRIBUTE',NULL,NULL,'"TERMINATION TYPE ATTRIBUTE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EROLEMDEMOZ0','30','H','01','48',NULL,'LIFE INSURANCE WAGES',NULL,NULL,'"LIFE INSURANCE WAGES"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EROLEMDEMOZ0','10','H','01','49',NULL,'LIFE INSURANCE WAGES EFFECTIVE DATE',NULL,NULL,'"drvLIFEINSURANCEWAGESEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EROLEMDEMOZ0','4','H','01','50',NULL,'NATIONAL UNION',NULL,NULL,'"NATIONAL UNION"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EROLEMDEMOZ0','10','H','01','51',NULL,'NATIONAL UNION EFFECTIVE DATE',NULL,NULL,'"NATIONAL UNION EFFECTIVE DATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EROLEMDEMOZ0','4','H','01','52',NULL,'PAY GROUP',NULL,NULL,'"PAY GROUP"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EROLEMDEMOZ0','10','H','01','53',NULL,'PAY GROUP EFFECTIVE DATE',NULL,NULL,'"PAY GROUP EFFECTIVE DATE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EROLEMDEMOZ0','1','H','01','54',NULL,'HOMETEAM GF IND',NULL,NULL,'"HOMETEAM GF IND"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EROLEMDEMOZ0','10','H','01','55',NULL,'HOMETEAM GF IND EFFECTIVE DATE',NULL,NULL,'"drvHOMETEAMGFINDEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EROLEMDEMOZ0','200','H','01','56',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EROLEMDEMOZ0','200','H','01','57',NULL,'Division Description',NULL,NULL,'"Division Description"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EROLEMDEMOZ0','200','H','01','58',NULL,'REGION',NULL,NULL,'"REGION"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EROLEMDEMOZ0','200','H','01','59',NULL,'Region Description',NULL,NULL,'"Region Description"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EROLEMDEMOZ0','200','H','01','60',NULL,'BRANCH',NULL,NULL,'"BRANCH"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EROLEMDEMOZ0','200','H','01','61',NULL,'Branch Description',NULL,NULL,'"Branch Description"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EROLEMDEMOZ0','200','H','01','62',NULL,'Company Code',NULL,NULL,'"Company Code"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EROLEMDEMOZ0','200','H','01','63',NULL,'COMPANY CODE DESCRIPTION',NULL,NULL,'"COMPANY CODE DESCRIPTION"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EROLEMDEMOZ0','200','H','01','64',NULL,'JOB CODE',NULL,NULL,'"JOB CODE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EROLEMDEMOZ0','200','H','01','65',NULL,'JOB TITLE',NULL,NULL,'"JOB TITLE"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLEMDEMOZ0','2','D','10','1',NULL,'LINE ID',NULL,NULL,'"02"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLEMDEMOZ0','10','D','10','2',NULL,'EMPLOYER ID',NULL,NULL,'"ROLLINS"','(''DA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLEMDEMOZ0','9','D','10','3',NULL,'EMPLOYEE SSN',NULL,NULL,'"drvEMPLOYEESSN"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLEMDEMOZ0','10','D','10','4',NULL,'EMPLOYEE ID',NULL,NULL,'"drvEMPLOYEEID"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLEMDEMOZ0','30','D','10','5',NULL,'LAST NAME',NULL,NULL,'"drvLASTNAME"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLEMDEMOZ0','30','D','10','6',NULL,'FIRST NAME',NULL,NULL,'"drvFIRSTNAME"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLEMDEMOZ0','30','D','10','7',NULL,'MIDDLE NAME / INITIAL',NULL,NULL,'"drvMIDDLENAMEINITIAL"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EROLEMDEMOZ0','10','D','10','8',NULL,'SUFFIX',NULL,NULL,'"drvSUFFIX"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EROLEMDEMOZ0','10','D','10','9',NULL,'BIRTHDATE',NULL,NULL,'"drvBIRTHDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EROLEMDEMOZ0','1','D','10','10',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EROLEMDEMOZ0','40','D','10','11',NULL,'ADDRESS1',NULL,NULL,'"drvADDRESS1"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EROLEMDEMOZ0','40','D','10','12',NULL,'ADDRESS2',NULL,NULL,'"drvADDRESS2"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EROLEMDEMOZ0','40','D','10','13',NULL,'ADDRESS3',NULL,NULL,'""','(''SS''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EROLEMDEMOZ0','50','D','10','14',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EROLEMDEMOZ0','2','D','10','15',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EROLEMDEMOZ0','10','D','10','16',NULL,'POSTAL CODE',NULL,NULL,'"drvPOSTALCODE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EROLEMDEMOZ0','2','D','10','17',NULL,'COUNTRY',NULL,NULL,'"drvCOUNTRY"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EROLEMDEMOZ0','10','D','10','18',NULL,'ADDRESS EFFECTIVE DATE',NULL,NULL,'"drvADDRESSEFFECTIVEDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EROLEMDEMOZ0','10','D','10','19',NULL,'HOME PHONE',NULL,NULL,'"drvHOMEPHONE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EROLEMDEMOZ0','10','D','10','20',NULL,'WORK PHONE',NULL,NULL,'"drvWORKPHONE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EROLEMDEMOZ0','10','D','10','21',NULL,'MOBILE PHONE',NULL,NULL,'""','(''SS''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EROLEMDEMOZ0','200','D','10','22',NULL,'WORK E-MAIL ADDRESS',NULL,NULL,'"drvWORKEMAILADDRESS"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EROLEMDEMOZ0','200','D','10','23',NULL,'PERSONAL E-MAIL ADDRESS',NULL,NULL,'""','(''SS''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EROLEMDEMOZ0','10','D','10','24',NULL,'ORIGINAL HIRE DATE',NULL,NULL,'"drvORIGINALHIREDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EROLEMDEMOZ0','10','D','10','25',NULL,'LATEST HIRE DATE',NULL,NULL,'"drvLATESTHIREDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EROLEMDEMOZ0','1','D','10','26',NULL,'EMPLOYMENT STATUS',NULL,NULL,'"drvEMPLOYMENTSTATUS"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EROLEMDEMOZ0','10','D','10','27',NULL,'EMPLOYMENT STATUS EFFECTIVE DATE',NULL,NULL,'"drvEMPLOYMENTSTATUSEFFEDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EROLEMDEMOZ0','10','D','10','28',NULL,'DEATH DATE ATTRIBUTE',NULL,NULL,'"drvDEATHDATATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EROLEMDEMOZ0','10','D','10','29',NULL,'TERMINATION DATE ATTRIBUTE',NULL,NULL,'"drvTERMINATIONDATEATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EROLEMDEMOZ0','30','D','10','30',NULL,'CURRENT ANNUAL SALARY ATTRIBUTE',NULL,NULL,'"drvCURRENTANNUALSALARYATTR"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EROLEMDEMOZ0','10','D','10','31',NULL,'CURRENT SALARY ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvCURRENTSALARYATTRIBEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EROLEMDEMOZ0','4','D','10','32',NULL,'PAY FREQUENCY ATTRIBUTE',NULL,NULL,'"drvPAYFREQUENCYATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EROLEMDEMOZ0','10','D','10','33',NULL,'PAY FREQUENCY ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvPAYFREQUENCYATTRIBEFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EROLEMDEMOZ0','9','D','10','34',NULL,'EMPLOYER/COMPANY EIN ATTRIBUTE',NULL,NULL,'"drvEMPLOYERCOMPANYEINATTRIB"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EROLEMDEMOZ0','10','D','10','35',NULL,'EIN ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvEINATTRIBUTEEFFECTIVEDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EROLEMDEMOZ0','1','D','10','36',NULL,'FULL-TIME/PART-TIME ATTRIBUTE',NULL,NULL,'"drvFULLTIMEPARTTIMEATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EROLEMDEMOZ0','10','D','10','37',NULL,'FULL-TIME/PART-TIME ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvFULLTIMEPARTTIMEEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EROLEMDEMOZ0','30','D','10','38',NULL,'TERM REASON CODE ATTRIBUTE',NULL,NULL,'"drvTERMREASONCODEATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EROLEMDEMOZ0','10','D','10','39',NULL,'TERM REASON CODE ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvTERMREASONCODEATTREFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EROLEMDEMOZ0','30','D','10','40',NULL,'LEAVE REASON CODE ATTRIBUTE',NULL,NULL,'"drvLEAVEREASONCODEATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EROLEMDEMOZ0','10','D','10','41',NULL,'LEAVE REASON ATTRIBUTE EFFECTIVE DATE',NULL,NULL,'"drvLEAVEREASONATTREFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EROLEMDEMOZ0','10','D','10','42',NULL,'RETIREMENT DATE ATTRIBUTE',NULL,NULL,'"drvRETIREMENTDATEATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EROLEMDEMOZ0','1','D','10','43',NULL,'FULL-TIME/PART-TIME INDICATOR (ACA) ATTRIBUTE',NULL,NULL,'"drvFULLTIMEPARTTIMEINDICATOR"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EROLEMDEMOZ0','10','D','10','44',NULL,'FULL-TIME/PART-TIME INDICATOR (ACA) ATTRIBUTE EFFE',NULL,NULL,'"drvFULLTIMEPARTTIMEINDEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EROLEMDEMOZ0','55','D','10','45',NULL,'EXTERNAL_IDENTIFIER',NULL,NULL,'"drvEXTERNALIDENTIFIER"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EROLEMDEMOZ0','9','D','10','46',NULL,'ALT_SSN',NULL,NULL,'"drvALTSSN"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EROLEMDEMOZ0','10','D','10','47',NULL,'TERMINATION TYPE ATTRIBUTE',NULL,NULL,'"drvTERMINATIONTYPEATTRIBUTE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EROLEMDEMOZ0','30','D','10','48',NULL,'LIFE INSURANCE WAGES',NULL,NULL,'"drvLIFEINSURANCEWAGES"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EROLEMDEMOZ0','10','D','10','49',NULL,'LIFE INSURANCE WAGES EFFECTIVE DATE',NULL,NULL,'"drvLIFEINSURANCEWAGESEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EROLEMDEMOZ0','4','D','10','50',NULL,'NATIONAL UNION',NULL,NULL,'"drvNATIONALUNION"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EROLEMDEMOZ0','10','D','10','51',NULL,'NATIONAL UNION EFFECTIVE DATE',NULL,NULL,'"drvNATIONALUNIONEFFECTIVEDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EROLEMDEMOZ0','4','D','10','52',NULL,'PAY GROUP',NULL,NULL,'"drvPAYGROUP"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EROLEMDEMOZ0','10','D','10','53',NULL,'PAY GROUP EFFECTIVE DATE',NULL,NULL,'"drvPAYGROUPEFFECTIVEDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EROLEMDEMOZ0','1','D','10','54',NULL,'HOMETEAM GF IND',NULL,NULL,'"drvHOMETEAMGFIND"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EROLEMDEMOZ0','10','D','10','55',NULL,'HOMETEAM GF IND EFFECTIVE DATE',NULL,NULL,'"drvHOMETEAMGFINDEFFDATE"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EROLEMDEMOZ0','200','D','10','56',NULL,'DIVISION',NULL,NULL,'"drvDIVISION"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EROLEMDEMOZ0','200','D','10','57',NULL,'Division Description',NULL,NULL,'"drvDivisionDescription"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EROLEMDEMOZ0','200','D','10','58',NULL,'REGION',NULL,NULL,'"drvREGION"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EROLEMDEMOZ0','200','D','10','59',NULL,'Region Description',NULL,NULL,'"drvRegionDescription"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EROLEMDEMOZ0','200','D','10','60',NULL,'BRANCH',NULL,NULL,'"drvBRANCH"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EROLEMDEMOZ0','200','D','10','61',NULL,'Branch Description',NULL,NULL,'"drvBranchDescription"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EROLEMDEMOZ0','200','D','10','62',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EROLEMDEMOZ0','200','D','10','63',NULL,'COMPANY CODE DESCRIPTION',NULL,NULL,'"drvCompanyCodeDesc"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EROLEMDEMOZ0','200','D','10','64',NULL,'JOB CODE',NULL,NULL,'"drvJobCode"','(''UA''=''TT'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EROLEMDEMOZ0','200','D','10','65',NULL,'JOB TITLE',NULL,NULL,'"drvJobTitle"','(''UA''=''TT'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EROLEMDEMO_20230131.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Demographic Export','202301319','EMPEXPORT','ONDEM_XOE',NULL,'EROLEMDEMO',NULL,NULL,NULL,'202301319','Jan 31 2023  7:43AM','Jan 31 2023  7:43AM','202301311',NULL,'','','202301311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Demographic Exp-Sched','202301319','EMPEXPORT','SCH_EROLEM',NULL,'EROLEMDEMO',NULL,NULL,NULL,'202301319','Jan 31 2023  7:43AM','Jan 31 2023  7:43AM','202301311',NULL,'','','202301311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Demographic Exp-Test','202301319','EMPEXPORT','TEST_XOE',NULL,'EROLEMDEMO',NULL,NULL,NULL,'202301319','Jan 31 2023  7:43AM','Jan 31 2023  7:43AM','202301311',NULL,'','','202301311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMDEMO','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMDEMO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMDEMO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLEMDEMO','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLEMDEMO','H01','dbo.U_EROLEMDEMO_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLEMDEMO','D10','dbo.U_EROLEMDEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_EROLEMDEMO_Audit
-----------

IF OBJECT_ID('U_EROLEMDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_EROLEMDEMO_Audit] (
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
-- Create table U_EROLEMDEMO_AuditFields
-----------

IF OBJECT_ID('U_EROLEMDEMO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EROLEMDEMO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EROLEMDEMO_drvTbl
-----------

IF OBJECT_ID('U_EROLEMDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EROLEMDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEMPLOYEESSN] char(11) NULL,
    [drvEMPLOYEEID] char(9) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvMIDDLENAMEINITIAL] varchar(1) NOT NULL,
    [drvSUFFIX] varchar(1) NOT NULL,
    [drvBIRTHDATE] datetime NULL,
    [drvGENDER] char(1) NULL,
    [drvADDRESS1] varchar(255) NULL,
    [drvADDRESS2] varchar(255) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvPOSTALCODE] varchar(50) NULL,
    [drvCOUNTRY] char(3) NULL,
    [drvADDRESSEFFECTIVEDATE] varchar(1) NOT NULL,
    [drvHOMEPHONE] varchar(50) NULL,
    [drvWORKPHONE] varchar(50) NULL,
    [drvWORKEMAILADDRESS] varchar(50) NULL,
    [drvORIGINALHIREDATE] datetime NULL,
    [drvLATESTHIREDATE] datetime NULL,
    [drvEMPLOYMENTSTATUS] varchar(1) NOT NULL,
    [drvEMPLOYMENTSTATUSEFFEDATE] varchar(1) NOT NULL,
    [drvDEATHDATATTRIBUTE] varchar(1) NOT NULL,
    [drvTERMINATIONDATEATTRIBUTE] varchar(1) NOT NULL,
    [drvCURRENTANNUALSALARYATTR] varchar(1) NOT NULL,
    [drvCURRENTSALARYATTRIBEFFDATE] varchar(1) NOT NULL,
    [drvPAYFREQUENCYATTRIBUTE] varchar(1) NOT NULL,
    [drvPAYFREQUENCYATTRIBEFDATE] varchar(1) NOT NULL,
    [drvEMPLOYERCOMPANYEINATTRIB] varchar(1) NOT NULL,
    [drvEINATTRIBUTEEFFECTIVEDATE] varchar(1) NOT NULL,
    [drvFULLTIMEPARTTIMEATTRIBUTE] varchar(1) NOT NULL,
    [drvFULLTIMEPARTTIMEEFFDATE] varchar(1) NOT NULL,
    [drvTERMREASONCODEATTRIBUTE] char(6) NULL,
    [drvTERMREASONCODEATTREFFDATE] datetime NULL,
    [drvLEAVEREASONCODEATTRIBUTE] varchar(1) NOT NULL,
    [drvLEAVEREASONATTREFFDATE] varchar(1) NOT NULL,
    [drvRETIREMENTDATEATTRIBUTE] varchar(1) NOT NULL,
    [drvFULLTIMEPARTTIMEINDICATOR] varchar(1) NOT NULL,
    [drvFULLTIMEPARTTIMEINDEFFDATE] varchar(1) NOT NULL,
    [drvEXTERNALIDENTIFIER] varchar(1) NOT NULL,
    [drvALTSSN] char(11) NULL,
    [drvTERMINATIONTYPEATTRIBUTE] varchar(1) NOT NULL,
    [drvLIFEINSURANCEWAGES] varchar(1) NOT NULL,
    [drvLIFEINSURANCEWAGESEFFDATE] varchar(1) NOT NULL,
    [drvNATIONALUNION] varchar(1) NOT NULL,
    [drvNATIONALUNIONEFFECTIVEDATE] varchar(1) NOT NULL,
    [drvPAYGROUP] char(6) NULL,
    [drvPAYGROUPEFFECTIVEDATE] varchar(1) NOT NULL,
    [drvHOMETEAMGFIND] varchar(1) NOT NULL,
    [drvHOMETEAMGFINDEFFDATE] varchar(1) NOT NULL,
    [drvDIVISION] varchar(1) NOT NULL,
    [drvDivisionDescription] varchar(1) NOT NULL,
    [drvREGION] varchar(1) NOT NULL,
    [drvRegionDescription] varchar(1) NOT NULL,
    [drvBRANCH] varchar(1) NOT NULL,
    [drvBranchDescription] varchar(1) NOT NULL,
    [drvCompanyCode] char(5) NULL,
    [drvCompanyCodeDesc] varchar(1) NOT NULL,
    [drvJobCode] char(8) NULL,
    [drvJobTitle] varchar(1) NOT NULL
);

-----------
-- Create table U_EROLEMDEMO_EEList
-----------

IF OBJECT_ID('U_EROLEMDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EROLEMDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EROLEMDEMO_File
-----------

IF OBJECT_ID('U_EROLEMDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EROLEMDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EROLEMDEMO_Header
-----------

IF OBJECT_ID('U_EROLEMDEMO_Header') IS NULL
CREATE TABLE [dbo].[U_EROLEMDEMO_Header] (
    [drvEMPLOYMENTSTATUSEFFEDATE] varchar(32) NOT NULL,
    [drvCURRENTANNUALSALARYATTR] varchar(31) NOT NULL,
    [drvCURRENTSALARYATTRIBEFFDATE] varchar(39) NOT NULL,
    [drvPAYFREQUENCYATTRIBEFDATE] varchar(38) NOT NULL,
    [drvEMPLOYERCOMPANYEINATTRIB] varchar(30) NOT NULL,
    [drvFULLTIMEPARTTIMEEFFDATE] varchar(44) NOT NULL,
    [drvTERMREASONCODEATTREFFDATE] varchar(41) NOT NULL,
    [drvLEAVEREASONATTREFFDATE] varchar(37) NOT NULL,
    [drvFULLTIMEPARTTIMEINDICATOR] varchar(45) NOT NULL,
    [drvFULLTIMEPARTTIMEINDEFFDATE] varchar(60) NOT NULL,
    [drvLIFEINSURANCEWAGESEFFDATE] varchar(35) NOT NULL,
    [drvHOMETEAMGFINDEFFDATE] varchar(30) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLEMDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 01/31/2023
Service Request Number: TekP-2023-01-12-01

Purpose: Empyrean Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EROLEMDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EROLEMDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EROLEMDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EROLEMDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EROLEMDEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMDEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLEMDEMO', 'SCH_EROLEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EROLEMDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EROLEMDEMO';

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
    DELETE FROM dbo.U_EROLEMDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EROLEMDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    ----==========================================
    ---- Audit Section
    ----==========================================
    ---- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EROLEMDEMO_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EROLEMDEMO_AuditFields;
    CREATE TABLE dbo.U_EROLEMDEMO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EROLEMDEMO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMDEMO_Audit;
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
    INTO dbo.U_EROLEMDEMO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EROLEMDEMO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EROLEMDEMO_Audit ON dbo.U_EROLEMDEMO_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EROLEMDEMO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EROLEMDEMO_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EROLEMDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EROLEMDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEMPLOYEESSN = eepSSN
        ,drvEMPLOYEEID = EecEmpNo
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAME = EepNameFirst
        ,drvMIDDLENAMEINITIAL = ''
        ,drvSUFFIX = ''
        ,drvBIRTHDATE = EepDateOfBirth
        ,drvGENDER = EepGender
        ,drvADDRESS1 = EepAddressLine1
        ,drvADDRESS2 = EepAddressLine2
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvPOSTALCODE = EepAddressZipCode
        ,drvCOUNTRY = EepAddressCountry
        ,drvADDRESSEFFECTIVEDATE = ''
        ,drvHOMEPHONE = EepPhoneHomeNumber
        ,drvWORKPHONE = EecPhoneBusinessNumber
        ,drvWORKEMAILADDRESS = EepAddressEMail
        ,drvORIGINALHIREDATE = EecDateOfLastHire
        ,drvLATESTHIREDATE = EecDateOfLastHire
        ,drvEMPLOYMENTSTATUS = ''
        ,drvEMPLOYMENTSTATUSEFFEDATE = ''
        ,drvDEATHDATATTRIBUTE = ''
        ,drvTERMINATIONDATEATTRIBUTE = ''
        ,drvCURRENTANNUALSALARYATTR = ''
        ,drvCURRENTSALARYATTRIBEFFDATE = ''
        ,drvPAYFREQUENCYATTRIBUTE = ''
        ,drvPAYFREQUENCYATTRIBEFDATE = ''
        ,drvEMPLOYERCOMPANYEINATTRIB = ''
        ,drvEINATTRIBUTEEFFECTIVEDATE = ''
        ,drvFULLTIMEPARTTIMEATTRIBUTE = ''
        ,drvFULLTIMEPARTTIMEEFFDATE = ''
        ,drvTERMREASONCODEATTRIBUTE = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvTERMREASONCODEATTREFFDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvLEAVEREASONCODEATTRIBUTE = ''
        ,drvLEAVEREASONATTREFFDATE = ''
        ,drvRETIREMENTDATEATTRIBUTE = ''
        ,drvFULLTIMEPARTTIMEINDICATOR = ''
        ,drvFULLTIMEPARTTIMEINDEFFDATE = ''
        ,drvEXTERNALIDENTIFIER = ''
        ,drvALTSSN = eepSSN
        ,drvTERMINATIONTYPEATTRIBUTE = ''
        ,drvLIFEINSURANCEWAGES = ''
        ,drvLIFEINSURANCEWAGESEFFDATE = ''
        ,drvNATIONALUNION = ''
        ,drvNATIONALUNIONEFFECTIVEDATE = ''
        ,drvPAYGROUP = EecPayGroup
        ,drvPAYGROUPEFFECTIVEDATE = ''
        ,drvHOMETEAMGFIND = ''
        ,drvHOMETEAMGFINDEFFDATE = ''
        ,drvDIVISION = ''
        ,drvDivisionDescription = ''
        ,drvREGION = ''
        ,drvRegionDescription = ''
        ,drvBRANCH = ''
        ,drvBranchDescription = ''
        ,drvCompanyCode = CmpCompanyCode
        ,drvCompanyCodeDesc = ''
        ,drvJobCode = EecJobCode
        ,drvJobTitle = ''
    INTO dbo.U_EROLEMDEMO_drvTbl
    FROM dbo.U_EROLEMDEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EROLEMDEMO_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EROLEMDEMO_Header;
    SELECT DISTINCT
         drvEMPLOYMENTSTATUSEFFEDATE = 'EMPLOYMENT STATUS EFFECTIVE DATE'
        ,drvCURRENTANNUALSALARYATTR = 'CURRENT ANNUAL SALARY ATTRIBUTE'
        ,drvCURRENTSALARYATTRIBEFFDATE = 'CURRENT SALARY ATTRIBUTE EFFECTIVE DATE'
        ,drvPAYFREQUENCYATTRIBEFDATE = 'PAY FREQUENCY ATTRIBUTE EFFECTIVE DATE'
        ,drvEMPLOYERCOMPANYEINATTRIB = 'EMPLOYER/COMPANY EIN ATTRIBUTE'
        ,drvFULLTIMEPARTTIMEEFFDATE = 'FULL-TIME/PART-TIME ATTRIBUTE EFFECTIVE DATE'
        ,drvTERMREASONCODEATTREFFDATE = 'TERM REASON CODE ATTRIBUTE EFFECTIVE DATE'
        ,drvLEAVEREASONATTREFFDATE = 'LEAVE REASON ATTRIBUTE EFFECTIVE DATE'
        ,drvFULLTIMEPARTTIMEINDICATOR = 'FULL-TIME/PART-TIME INDICATOR (ACA) ATTRIBUTE'
        ,drvFULLTIMEPARTTIMEINDEFFDATE = 'FULL-TIME/PART-TIME INDICATOR (ACA) ATTRIBUTE EFFECTIVE DATE'
        ,drvLIFEINSURANCEWAGESEFFDATE = 'LIFE INSURANCE WAGES EFFECTIVE DATE'
        ,drvHOMETEAMGFINDEFFDATE = 'HOMETEAM GF IND EFFECTIVE DATE'
    INTO dbo.U_EROLEMDEMO_Header
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
ALTER VIEW dbo.dsi_vwEROLEMDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EROLEMDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EROLEMDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301241'
       ,expStartPerControl     = '202301241'
       ,expLastEndPerControl   = '202301319'
       ,expEndPerControl       = '202301319'
WHERE expFormatCode = 'EROLEMDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEROLEMDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EROLEMDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EROLEMDEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EROLEMDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EROLEMDEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLEMDEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EROLEMDEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLEMDEMO', 'UseFileName', 'V', 'Y'


-- End ripout